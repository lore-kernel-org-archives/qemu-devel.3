Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EDFC021B2
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 20:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkqoD-0007El-I7; Wed, 19 Feb 2025 15:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqoB-00076W-4o
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:36:39 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqo8-0004oI-KL
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:36:38 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqnu-00000007VV7-40D4; Wed, 19 Feb 2025 21:36:22 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 23/36] vfio/migration: Multifd device state transfer
 support - VFIOStateBuffer(s)
Date: Wed, 19 Feb 2025 21:34:05 +0100
Message-ID: <96303daed289e9c7a3261590027d18e425ea07c2.1739994627.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739994627.git.maciej.szmigiero@oracle.com>
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Add VFIOStateBuffer(s) types and the associated methods.

These store received device state buffers and config state waiting to get
loaded into the device.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration-multifd.c | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 0c3185a26242..760b110a39b9 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -29,3 +29,57 @@ typedef struct VFIODeviceStatePacket {
     uint32_t flags;
     uint8_t data[0];
 } QEMU_PACKED VFIODeviceStatePacket;
+
+/* type safety */
+typedef struct VFIOStateBuffers {
+    GArray *array;
+} VFIOStateBuffers;
+
+typedef struct VFIOStateBuffer {
+    bool is_present;
+    char *data;
+    size_t len;
+} VFIOStateBuffer;
+
+static void vfio_state_buffer_clear(gpointer data)
+{
+    VFIOStateBuffer *lb = data;
+
+    if (!lb->is_present) {
+        return;
+    }
+
+    g_clear_pointer(&lb->data, g_free);
+    lb->is_present = false;
+}
+
+static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
+{
+    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
+    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
+}
+
+static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
+{
+    g_clear_pointer(&bufs->array, g_array_unref);
+}
+
+static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
+{
+    assert(bufs->array);
+}
+
+static guint vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
+{
+    return bufs->array->len;
+}
+
+static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs, guint size)
+{
+    g_array_set_size(bufs->array, size);
+}
+
+static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
+{
+    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
+}

