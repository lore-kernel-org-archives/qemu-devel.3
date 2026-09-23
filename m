Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FA4C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9PiZ-0000IB-RT; Wed, 23 Sep 2026 12:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x9PiT-0000HR-5W
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x9PiR-0004Hk-8L
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790180461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3I9anFPmeXYs/o8y2MrpmiObvFljkGA/1STuIm8SMko=;
 b=VU8QefMZMVNZzJOtt7ckLC1DLodhg8nRYRCfTkuFuLsdUtUoXGYTtQFgThejwXVdL8R3YV
 aeiOA7X5UdELvXAuRndu5VoYrfvqgzXQRLqayTqntvieNwJrIyMcOfjJVOE3ESnGfi/t2P
 LOxfW3ycIJefVDO84khowyp8Ft5Tcto=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-R824mAV5M327HTLlw_o_aw-1; Wed, 23 Sep 2026 12:21:00 -0400
X-MC-Unique: R824mAV5M327HTLlw_o_aw-1
X-Mimecast-MFC-AGG-ID: R824mAV5M327HTLlw_o_aw_1790180459
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso10938085e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790180459; x=1790785259; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3I9anFPmeXYs/o8y2MrpmiObvFljkGA/1STuIm8SMko=;
 b=dLOk7cXlWmKcsrcjNiI1ccnriYPI0pEGhkb+bCF7SMbqBv0WiCj5dKuuWc+rqIJEc9
 SA+KdGHFHMRM9vWZn95dKXSTnGPpdkeIxV3dzfjvbitRKRXDEpsttuU83nZHB9nYRHdV
 5hEbyyxW0953e5nXFCLaqJ96H/oYWTFe6lgLF7oAkRpBciKRBaVNYIP09ol2qOvOae2B
 r26pBTMRGlqVnCXH41a+wah8LfgeIOj/VycL1aOECBqiil3+Hf0fCyQz0J1WTffX8NC6
 eqHKNwxoC32p8BNFIpvJjt1DXfy07yv1B46+U6j8mFgWLxqhHOLcQOtmPgFvDWjbL//Q
 x82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790180459; x=1790785259;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3I9anFPmeXYs/o8y2MrpmiObvFljkGA/1STuIm8SMko=;
 b=VdqjsQNHcE5gXcqLqz/4ssu3FkzMg4XksmHiPCY8NGeMz9tP2unOZMMNJQFFZ4e5j2
 s4bXsO1eSRsjfhoddq7rIe/0mcAfMtgYP+RVrzzAcBL1h58OoizoKIjPSQz8XG8oe1ZQ
 D5/6q94FXmt4YaOIbqutgj43E33hKQeXhph7E6JXAH8d9ZZZXfw3P9jrhHfxmrViPm1F
 AmfsZn0gF+arTQer+UIwg39O90X7qpfDZUhH7O58/123lcPvSKMQlADT6Z1sLR8gd6pA
 iMlIraMqQDo9FRL7z7kL+6H81URhpHnXTgiHy3IcESC1ou2EB6josZAbrJPnKTOT1FDp
 urzQ==
X-Gm-Message-State: AFuF++mM0WC84z7/xWsMCdsSxf9YisAbMNGRgmnJ+Hn0bB92sNtGBprh
 dbqOHorJuRfy7NrkpJtlFCwK0sD/+0NAUJEiug4CRzrP5ta2rIbrvZ77FDuNsi1T3E2tzTvM8Ny
 KYVAUvkNuVuJbYKCPp6QOhmfsRqvigO+DKVtMTadhvXNxGdD+6gxhrSSI
X-Gm-Gg: AYBFou0/kwZwO5tgvJZQUvdsRUB4iwD1P0cX5toxo0sE6K1GQY1gOBr/G3CyGwi+NT9
 piL7Gwqpbgl7zMWch15EZW5q5yvqQwwnU0ljG+qtxTehnlnlFrIF6bxDkZOV+XeD3mGD5ry8m+P
 mo+d6NuB3mFZjLabyUmURzeSOpC9WYZ42d0r+T8+c6/J7nC752p9KZ0lQ00chM5EjGouHTYEASF
 Mrd5unmoLeWqVmh5qLrDY2t3hVn9t2xChfQau0/fXgTXOKtufu9b6AY4fcU0YS3z9zrjstRRuug
 J/QaNamIKqoe7VSVEkyrXFAtnK6r+XCtbOccKmiB9On9Dr43WjvnVhTvuW4CgLwEqC0U4P2NBfT
 Wiadsy5fA4IHqkSOP5T7hlNwyAtSDtonKBw4rJuxBdR0LF4zLbcW8UKLRGZTHAPMUTcNx
X-Received: by 2002:a05:600c:4e0b:b0:49e:84bf:6136 with SMTP id
 5b1f17b1804b1-49fdeffdfc0mr60119115e9.11.1790180458983; 
 Wed, 23 Sep 2026 09:20:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0b:b0:49e:84bf:6136 with SMTP id
 5b1f17b1804b1-49fdeffdfc0mr60118665e9.11.1790180458530; 
 Wed, 23 Sep 2026 09:20:58 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe1432362sm39560075e9.1.2026.09.23.09.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 09:20:57 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 23 Sep 2026 18:20:55 +0200
Subject: [PATCH] backends/igvm: supply an empty device tree when the
 machine has none
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-relax_dt-v1-1-ff40f2a06acd@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyNj3aLUnMSK+JQS3SRDs9SUZKPkVMM0QyWg8oKi1LTMCrBR0bG1tQA
 KAZ9jWgAAAA==
X-Change-ID: 20260923-relax_dt-b16edc2ce1f1
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commit 1c4bd8f13c ("igvm: add device tree parameter support") added
handling for the IGVM device tree parameter directive. The handler
fails when the machine has not built a device tree of its own, so an
IGVM file carrying that directive cannot be booted on such a machine,
for example q35.

An empty tree satisfies the IGVM file's request, so build and supply
one instead of rejecting the whole file.

While at it, rename fdt_packed to fdt, which better reflects the
content of the variable, as it does not always hold a packed fdt.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index ec7bee428b..e982bab06a 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -29,6 +29,9 @@
 
 #ifdef CONFIG_FDT
 #include <libfdt.h>
+
+/* Enough for the header, the memory reservation block and an empty root node */
+#define EMPTY_FDT_SIZE 256
 #endif
 
 #ifndef IGVM_VHT_OPTIONAL_BIT
@@ -856,7 +859,7 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
                                        Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    g_autofree void *fdt_packed = NULL;
+    g_autofree void *fdt = NULL;
     uint8_t *param_data;
     uint32_t param_size;
     uint32_t fdt_size;
@@ -866,20 +869,27 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
-    if (ctx->machine_state->fdt == NULL) {
-        error_setg(errp, "IGVM: device tree not available");
-        return -1;
+    if (ctx->machine_state->fdt) {
+        fdt = g_memdup2(ctx->machine_state->fdt,
+                        fdt_totalsize(ctx->machine_state->fdt));
+    } else {
+        /*
+         * The machine doesn't build a device tree of its own.
+         * Supply an empty tree rather than rejecting the IGVM file.
+         */
+        fdt = g_malloc0(EMPTY_FDT_SIZE);
+        if (fdt_create_empty_tree(fdt, EMPTY_FDT_SIZE)) {
+            error_setg(errp, "IGVM: failed to create an empty device tree");
+            return -1;
+        }
     }
 
-    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
-    fdt_packed = g_memdup2(ctx->machine_state->fdt, fdt_size);
-
-    if (fdt_pack(fdt_packed)) {
+    if (fdt_pack(fdt)) {
         error_setg(errp, "IGVM: failed to pack device tree");
         return -1;
     }
 
-    fdt_size = fdt_totalsize(fdt_packed);
+    fdt_size = fdt_totalsize(fdt);
     if (fdt_size > param_size) {
         error_setg(errp,
                    "IGVM: device tree size exceeds parameter area"
@@ -887,7 +897,7 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
-    memcpy(param_data, fdt_packed, fdt_size);
+    memcpy(param_data, fdt, fdt_size);
 
     return 0;
 }

---
base-commit: 67166d97a3269285aa68c489f85c9ccdf78495e1
change-id: 20260923-relax_dt-b16edc2ce1f1

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


