Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F84C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uKO-0005Xo-BW; Wed, 22 May 2024 18:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKL-0005VC-GQ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKJ-0003mM-RH
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:53 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEA5121C23;
 Wed, 22 May 2024 22:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNNt8j2mHsytQe9ZOOd8CIPHY6lGnlx8mCYp+SHpjU0=;
 b=XpNf9Yya2Q6rk5AcO3+bJV05CRSirArGTZFKhNHbkBxn/RLneIw8uA4OQPU3f1S13nZJHB
 PdXr4NLNw5dX3dMNnFnYGM1/U/oJhWS5MATAmFuZrWY/YSyhyFUJbU55/E+9VryBLPNgU0
 IGoFDzelP7vL61lwC/SUA8TJ3dX0QuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNNt8j2mHsytQe9ZOOd8CIPHY6lGnlx8mCYp+SHpjU0=;
 b=edEbtV0fRor/QlNnN7UiA/moctS9sHa5E9bfXGGI51bPXGeAcOtDM0VeUYKfYJsK/xjxlC
 fGTT+vkihTPuZuDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNNt8j2mHsytQe9ZOOd8CIPHY6lGnlx8mCYp+SHpjU0=;
 b=XpNf9Yya2Q6rk5AcO3+bJV05CRSirArGTZFKhNHbkBxn/RLneIw8uA4OQPU3f1S13nZJHB
 PdXr4NLNw5dX3dMNnFnYGM1/U/oJhWS5MATAmFuZrWY/YSyhyFUJbU55/E+9VryBLPNgU0
 IGoFDzelP7vL61lwC/SUA8TJ3dX0QuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNNt8j2mHsytQe9ZOOd8CIPHY6lGnlx8mCYp+SHpjU0=;
 b=edEbtV0fRor/QlNnN7UiA/moctS9sHa5E9bfXGGI51bPXGeAcOtDM0VeUYKfYJsK/xjxlC
 fGTT+vkihTPuZuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 165FE13A6B;
 Wed, 22 May 2024 22:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KDW/M8BvTmaABAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 22:20:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 6/9] virtio-gpu: fix v2 migration
Date: Wed, 22 May 2024 19:20:31 -0300
Message-Id: <20240522222034.4001-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240522222034.4001-1-farosas@suse.de>
References: <20240522222034.4001-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Commit dfcf74fa ("virtio-gpu: fix scanout migration post-load") broke
forward/backward version migration. Versioning of nested VMSD structures
is not straightforward, as the wire format doesn't have nested
structures versions. Introduce x-scanout-vmstate-version and a field
test to save/load appropriately according to the machine version.

Fixes: dfcf74fa ("virtio-gpu: fix scanout migration post-load")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
[fixed long lines]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/core/machine.c              |  1 +
 hw/display/virtio-gpu.c        | 30 ++++++++++++++++++++++--------
 include/hw/virtio/virtio-gpu.h |  1 +
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c7ceb11501..8d6dc69f0e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -42,6 +42,7 @@ GlobalProperty hw_compat_8_2[] = {
     { "migration", "zero-page-detection", "legacy"},
     { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
+    { "virtio-gpu-device", "x-scanout-vmstate-version", "1" },
 };
 const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ae831b6b3e..d60b1b2973 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1166,10 +1166,17 @@ static void virtio_gpu_cursor_bh(void *opaque)
     virtio_gpu_handle_cursor(&g->parent_obj.parent_obj, g->cursor_vq);
 }
 
+static bool scanout_vmstate_after_v2(void *opaque, int version)
+{
+    struct VirtIOGPUBase *base = container_of(opaque, VirtIOGPUBase, scanout);
+    struct VirtIOGPU *gpu = container_of(base, VirtIOGPU, parent_obj);
+
+    return gpu->scanout_vmstate_version >= 2;
+}
+
 static const VMStateDescription vmstate_virtio_gpu_scanout = {
     .name = "virtio-gpu-one-scanout",
-    .version_id = 2,
-    .minimum_version_id = 1,
+    .version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(resource_id, struct virtio_gpu_scanout),
         VMSTATE_UINT32(width, struct virtio_gpu_scanout),
@@ -1181,12 +1188,18 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
         VMSTATE_UINT32(cursor.hot_y, struct virtio_gpu_scanout),
         VMSTATE_UINT32(cursor.pos.x, struct virtio_gpu_scanout),
         VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
-        VMSTATE_UINT32_V(fb.format, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.bytes_pp, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.width, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.height, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.stride, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.offset, struct virtio_gpu_scanout, 2),
+        VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout,
+                            scanout_vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout,
+                            scanout_vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout,
+                            scanout_vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout,
+                            scanout_vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.stride, struct virtio_gpu_scanout,
+                            scanout_vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.offset, struct virtio_gpu_scanout,
+                            scanout_vmstate_after_v2),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -1659,6 +1672,7 @@ static Property virtio_gpu_properties[] = {
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
     DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
+    DEFINE_PROP_UINT8("x-scanout-vmstate-version", VirtIOGPU, scanout_vmstate_version, 2),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 56d6e821bf..7a59379f5a 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -177,6 +177,7 @@ typedef struct VGPUDMABuf {
 struct VirtIOGPU {
     VirtIOGPUBase parent_obj;
 
+    uint8_t scanout_vmstate_version;
     uint64_t conf_max_hostmem;
 
     VirtQueue *ctrl_vq;
-- 
2.35.3


