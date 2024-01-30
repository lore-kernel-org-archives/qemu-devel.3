Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1779C47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUw1Y-0002S3-6Q; Tue, 30 Jan 2024 16:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw1J-0002DT-Rg
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw1I-0005nx-5K
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706651511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6clwgklteqQmzqVd62Vwxjq6DrL4/PqmNUAfSDryvWo=;
 b=EoMljisJWCNJp8NYYBVEj1XaK6LO6bPo4zBiosmkr7CKdcfuKmir10xZhPUFBqJvMXiAWM
 iUlyub3piNFtp/5JdhEdTaL36xluuMkPE2QtCFLTytbU8iwYAyYh9HBPuwPDnc0i2sZidl
 TJKfDDGWSwVcqwk2gTI6Vv/dLob3f0A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-XNq4h4i6Nvq86hTJOgHE8w-1; Tue,
 30 Jan 2024 16:51:49 -0500
X-MC-Unique: XNq4h4i6Nvq86hTJOgHE8w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4515D29AC036;
 Tue, 30 Jan 2024 21:51:49 +0000 (UTC)
Received: from localhost (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3A3C492BE2;
 Tue, 30 Jan 2024 21:51:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 5/5] hw/block/block.c: improve confusing
 blk_check_size_and_read_all() error
Date: Tue, 30 Jan 2024 16:51:34 -0500
Message-ID: <20240130215134.346557-6-stefanha@redhat.com>
In-Reply-To: <20240130215134.346557-1-stefanha@redhat.com>
References: <20240130215134.346557-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

In cases where a device tries to read more bytes than the block device
contains, the error is vague: "device requires X bytes, block backend
provides Y bytes".

This patch changes the errors of this function to include the block
backend name, the device id and device type name where appropriate.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 7260eadff22c08457740117c1bb7bd2b4353acb9.1706598705.git.manos.pitsidianakis@linaro.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/block/block.h |  4 ++--
 hw/block/block.c         | 25 +++++++++++++++----------
 hw/block/m25p80.c        |  3 ++-
 hw/block/pflash_cfi01.c  |  4 ++--
 hw/block/pflash_cfi02.c  |  2 +-
 5 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 15fff66435..de3946a5f1 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -88,8 +88,8 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
 
 /* Backend access helpers */
 
-bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
-                                 Error **errp);
+bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
+                                 void *buf, hwaddr size, Error **errp);
 
 /* Configuration helpers */
 
diff --git a/hw/block/block.c b/hw/block/block.c
index ff503002aa..3ceca7dce6 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -54,29 +54,30 @@ static int blk_pread_nonzeroes(BlockBackend *blk, hwaddr size, void *buf)
  * BDRV_REQUEST_MAX_BYTES.
  * On success, return true.
  * On failure, store an error through @errp and return false.
- * Note that the error messages do not identify the block backend.
- * TODO Since callers don't either, this can result in confusing
- * errors.
+ *
  * This function not intended for actual block devices, which read on
  * demand.  It's for things like memory devices that (ab)use a block
  * backend to provide persistence.
  */
-bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
-                                 Error **errp)
+bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
+                                 void *buf, hwaddr size, Error **errp)
 {
     int64_t blk_len;
     int ret;
+    g_autofree char *dev_id = NULL;
 
     blk_len = blk_getlength(blk);
     if (blk_len < 0) {
         error_setg_errno(errp, -blk_len,
-                         "can't get size of block backend");
+                         "can't get size of %s block backend", blk_name(blk));
         return false;
     }
     if (blk_len != size) {
-        error_setg(errp, "device requires %" HWADDR_PRIu " bytes, "
-                   "block backend provides %" PRIu64 " bytes",
-                   size, blk_len);
+        dev_id = qdev_get_human_name(dev);
+        error_setg(errp, "%s device '%s' requires %" HWADDR_PRIu
+                   " bytes, %s block backend provides %" PRIu64 " bytes",
+                   object_get_typename(OBJECT(dev)), dev_id, size,
+                   blk_name(blk), blk_len);
         return false;
     }
 
@@ -89,7 +90,11 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
     assert(size <= BDRV_REQUEST_MAX_BYTES);
     ret = blk_pread_nonzeroes(blk, size, buf);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "can't read block backend");
+        dev_id = qdev_get_human_name(dev);
+        error_setg_errno(errp, -ret, "can't read %s block backend"
+                         " for %s device '%s'",
+                         blk_name(blk), object_get_typename(OBJECT(dev)),
+                         dev_id);
         return false;
     }
     return true;
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 26ce895628..0a12030a3a 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1617,7 +1617,8 @@ static void m25p80_realize(SSIPeripheral *ss, Error **errp)
         trace_m25p80_binding(s);
         s->storage = blk_blockalign(s->blk, s->size);
 
-        if (!blk_check_size_and_read_all(s->blk, s->storage, s->size, errp)) {
+        if (!blk_check_size_and_read_all(s->blk, DEVICE(s),
+                                         s->storage, s->size, errp)) {
             return;
         }
     } else {
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index f956f8bcf7..1bda8424b9 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -848,8 +848,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     }
 
     if (pfl->blk) {
-        if (!blk_check_size_and_read_all(pfl->blk, pfl->storage, total_len,
-                                         errp)) {
+        if (!blk_check_size_and_read_all(pfl->blk, dev, pfl->storage,
+                                         total_len, errp)) {
             vmstate_unregister_ram(&pfl->mem, DEVICE(pfl));
             return;
         }
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 6fa56f14c0..2314142373 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -902,7 +902,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     }
 
     if (pfl->blk) {
-        if (!blk_check_size_and_read_all(pfl->blk, pfl->storage,
+        if (!blk_check_size_and_read_all(pfl->blk, dev, pfl->storage,
                                          pfl->chip_len, errp)) {
             vmstate_unregister_ram(&pfl->orig_mem, DEVICE(pfl));
             return;
-- 
2.43.0


