Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279D0C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Iri-0005sY-Tq; Tue, 07 May 2024 07:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s4IrS-0005hR-Ko
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s4IrL-0004ch-Tg
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715080785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LIlWCJCZh3pg9/1WhT8507pU6bAXAp/D69jIPRYyOkk=;
 b=OpCOGOlNMaWWpdVFXxnRhSw9EDQK0vru9Qg5cXrv8LfCOTVyizrMfJ4ljPgGvzuby49GDw
 GQAeGBiZXAuwl+14tiSqV0EJwa1CV9wuwL5P8Who+IENshrE8DTWv2VtFr+IaPBl7Hq4I7
 +G58ZX2bzC3dC9xj3mDLyRAdLtCKtIM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-UrdI2B1MNYa0x1w0u7Pp0A-1; Tue, 07 May 2024 07:19:41 -0400
X-MC-Unique: UrdI2B1MNYa0x1w0u7Pp0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BA7C101A52C;
 Tue,  7 May 2024 11:19:41 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A97472141800;
 Tue,  7 May 2024 11:19:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sebastian Ott <sebott@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>, Fiona Ebner <f.ebner@proxmox.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, peter.maydell@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/4] virtio-gpu: use a VMState variant for the scanout field
Date: Tue,  7 May 2024 15:19:19 +0400
Message-ID: <20240507111920.1594897-4-marcandre.lureau@redhat.com>
In-Reply-To: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Depending on the version, use v1 or v2 of the scanout VM state.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ae831b6b3e..4fd72caf3f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1191,17 +1191,29 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
     },
 };
 
+static bool vmstate_before_v2(void *opaque, int version)
+{
+    return version <= 1;
+}
+
 static const VMStateDescription vmstate_virtio_gpu_scanouts = {
     .name = "virtio-gpu-scanouts",
-    .version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32(parent_obj.enable, struct VirtIOGPU),
         VMSTATE_UINT32_EQUAL(parent_obj.conf.max_outputs,
                              struct VirtIOGPU, NULL),
-        VMSTATE_STRUCT_VARRAY_UINT32(parent_obj.scanout, struct VirtIOGPU,
-                                     parent_obj.conf.max_outputs, 1,
-                                     vmstate_virtio_gpu_scanout,
-                                     struct virtio_gpu_scanout),
+        VMSTATE_VSTRUCT_TEST_VARRAY_UINT32(parent_obj.scanout, struct VirtIOGPU,
+                                           vmstate_before_v2,
+                                           parent_obj.conf.max_outputs, 1,
+                                           vmstate_virtio_gpu_scanout,
+                                           struct virtio_gpu_scanout, 1),
+        VMSTATE_VSTRUCT_TEST_VARRAY_UINT32(parent_obj.scanout, struct VirtIOGPU,
+                                           NULL,
+                                           parent_obj.conf.max_outputs, 2,
+                                           vmstate_virtio_gpu_scanout,
+                                           struct virtio_gpu_scanout, 2),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.41.0.28.gd7d8841f67


