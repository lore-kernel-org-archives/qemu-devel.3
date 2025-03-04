Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DACC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaPB-0001uh-Ud; Tue, 04 Mar 2025 17:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaP0-0001hA-Cf
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:06:16 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOy-00019g-JV
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:06:14 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOq-00000000LYp-0s51; Tue, 04 Mar 2025 23:06:04 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 15/36] migration/multifd: Make MultiFDSendData a struct
Date: Tue,  4 Mar 2025 23:03:42 +0100
Message-ID: <7b02baba8e6ddb23ef7c349d312b9b631db09d7e.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
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

From: Peter Xu <peterx@redhat.com>

The newly introduced device state buffer can be used for either storing
VFIO's read() raw data, but already also possible to store generic device
states.  After noticing that device states may not easily provide a max
buffer size (also the fact that RAM MultiFDPages_t after all also want to
have flexibility on managing offset[] array), it may not be a good idea to
stick with union on MultiFDSendData.. as it won't play well with such
flexibility.

Switch MultiFDSendData to a struct.

It won't consume a lot more space in reality, after all the real buffers
were already dynamically allocated, so it's so far only about the two
structs (pages, device_state) that will be duplicated, but they're small.

With this, we can remove the pretty hard to understand alloc size logic.
Because now we can allocate offset[] together with the SendData, and
properly free it when the SendData is freed.

Signed-off-by: Peter Xu <peterx@redhat.com>
[MSS: Make sure to clear possible device state payload before freeing
MultiFDSendData, remove placeholders for other patches not included]
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd-device-state.c |  5 -----
 migration/multifd-nocomp.c       | 13 ++++++-------
 migration/multifd.c              | 25 +++++++------------------
 migration/multifd.h              | 15 +++++++++------
 4 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index e383e75b1a02..64d8ca180167 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -20,11 +20,6 @@ static struct {
     MultiFDSendData *send_data;
 } *multifd_send_device_state;
 
-size_t multifd_device_state_payload_size(void)
-{
-    return sizeof(MultiFDDeviceState_t);
-}
-
 void multifd_device_state_send_setup(void)
 {
     assert(!multifd_send_device_state);
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index c00804652383..ffe75256c9fb 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -25,15 +25,14 @@
 
 static MultiFDSendData *multifd_ram_send;
 
-size_t multifd_ram_payload_size(void)
+void multifd_ram_payload_alloc(MultiFDPages_t *pages)
 {
-    uint32_t n = multifd_ram_page_count();
+    pages->offset = g_new0(ram_addr_t, multifd_ram_page_count());
+}
 
-    /*
-     * We keep an array of page offsets at the end of MultiFDPages_t,
-     * add space for it in the allocation.
-     */
-    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
+void multifd_ram_payload_free(MultiFDPages_t *pages)
+{
+    g_clear_pointer(&pages->offset, g_free);
 }
 
 void multifd_ram_save_setup(void)
diff --git a/migration/multifd.c b/migration/multifd.c
index 3625c9a37c0e..dfb5189f0ea3 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -105,26 +105,12 @@ struct {
 
 MultiFDSendData *multifd_send_data_alloc(void)
 {
-    size_t max_payload_size, size_minus_payload;
+    MultiFDSendData *new = g_new0(MultiFDSendData, 1);
 
-    /*
-     * MultiFDPages_t has a flexible array at the end, account for it
-     * when allocating MultiFDSendData. Use max() in case other types
-     * added to the union in the future are larger than
-     * (MultiFDPages_t + flex array).
-     */
-    max_payload_size = MAX(multifd_ram_payload_size(),
-                           multifd_device_state_payload_size());
-    max_payload_size = MAX(max_payload_size, sizeof(MultiFDPayload));
+    multifd_ram_payload_alloc(&new->u.ram);
+    /* Device state allocates its payload on-demand */
 
-    /*
-     * Account for any holes the compiler might insert. We can't pack
-     * the structure because that misaligns the members and triggers
-     * Waddress-of-packed-member.
-     */
-    size_minus_payload = sizeof(MultiFDSendData) - sizeof(MultiFDPayload);
-
-    return g_malloc0(size_minus_payload + max_payload_size);
+    return new;
 }
 
 void multifd_send_data_clear(MultiFDSendData *data)
@@ -151,8 +137,11 @@ void multifd_send_data_free(MultiFDSendData *data)
         return;
     }
 
+    /* This also free's device state payload */
     multifd_send_data_clear(data);
 
+    multifd_ram_payload_free(&data->u.ram);
+
     g_free(data);
 }
 
diff --git a/migration/multifd.h b/migration/multifd.h
index aa679d8bbe83..2d337e7b3b52 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -115,9 +115,13 @@ typedef struct {
     uint32_t num;
     /* number of normal pages */
     uint32_t normal_num;
+    /*
+     * Pointer to the ramblock.  NOTE: it's caller's responsibility to make
+     * sure the pointer is always valid!
+     */
     RAMBlock *block;
-    /* offset of each page */
-    ram_addr_t offset[];
+    /* offset array of each page, managed by multifd */
+    ram_addr_t *offset;
 } MultiFDPages_t;
 
 struct MultiFDRecvData {
@@ -140,7 +144,7 @@ typedef enum {
     MULTIFD_PAYLOAD_DEVICE_STATE,
 } MultiFDPayloadType;
 
-typedef union MultiFDPayload {
+typedef struct MultiFDPayload {
     MultiFDPages_t ram;
     MultiFDDeviceState_t device_state;
 } MultiFDPayload;
@@ -394,12 +398,11 @@ void multifd_ram_save_cleanup(void);
 int multifd_ram_flush_and_sync(QEMUFile *f);
 bool multifd_ram_sync_per_round(void);
 bool multifd_ram_sync_per_section(void);
-size_t multifd_ram_payload_size(void);
+void multifd_ram_payload_alloc(MultiFDPages_t *pages);
+void multifd_ram_payload_free(MultiFDPages_t *pages);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
 
-size_t multifd_device_state_payload_size(void);
-
 void multifd_send_data_clear_device_state(MultiFDDeviceState_t *device_state);
 
 void multifd_device_state_send_setup(void);

