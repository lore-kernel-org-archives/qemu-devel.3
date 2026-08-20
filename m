Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67409C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlU-0006rZ-UT; Wed, 19 Aug 2026 23:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlT-0006qW-GJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:27 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlR-0004PA-TQ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:27 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2756909a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197704; x=1787802504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6cxpb598ZC5YQS9pQsz8M+jshSqMrf/FVzGuyNPyanY=;
 b=eGOTKMBCRprhvggsvMnCOfsJYFNQyK9Ftz5RuINJr+IavvsuwKS5YHHiIrcky0mNGY
 avXt7WUYvRolo58U1t3jtFCPSeftYiogyWWvsi9IkCQM/0G9mEVr16b46hbtEEM84ubD
 quprMWat8FCEhp3LwddS+sveMm2dmVuX/Ak3EO7jKlqj2Rlq0GkAiTnrU5TSECmYxN2D
 raha8qqknQ5I5Hv7cdE/vINGfLISpr6Ltm3/uCg+PYjx8nFOE5YvJ3TEXxafQqA51W7H
 zkozE5vsBg5Sb4Yi2eIe3FVoxd4F0OSO7cl8HkgSHO+6haoWyKB76FbHzhhp1N56oLGJ
 /9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197704; x=1787802504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6cxpb598ZC5YQS9pQsz8M+jshSqMrf/FVzGuyNPyanY=;
 b=TZNkQpkNFE8rmSLVac6ZbC1R8K+g7HFAqWO8tr8H0iNQKYUbtFMYa0YhE9cMYT7bPm
 5FqX/9Hgqx3ulWGjOwo7Bw7IwsP0n7HNspfkWnC00VjHt4NbOrOnMSkr0pZ23I2zJHl/
 YMb3GDMvB9hqSBB+RaOUv4yb82YQhipumLe+xRbWxOPuIAABc8TerlDU5OxqUsa4k60q
 S05E6PyaDRTdT3nSRVH7hXAFchSYn9stEK+PEUAAuslPqqXuddkCO168Yxho9D+pGW+v
 +qPB5LuFJZMRRBdLFx2AP2F7kOVz3kv3/YxhMSBaPDl3Dn43KwCa7Dmx14m0eQOk4TfX
 N/FQ==
X-Gm-Message-State: AFuF++kz/787q1KbE7R55DTSAiXVnU7Mktr3MEdsn+KwAWZhBS+B0LNl
 UGuscNqtlqO/tLUlf9k8O9Mp6f9bu7K7D+l/nHUcxP6/2bx3tk3qrj+0HP+nDg==
X-Gm-Gg: AR+sD12jbqIZU8fBofY66gY6QoUOc1tCugcnXWmIYBw4uJyrU/k8YYSHLz0mwXnCd9y
 wODyueJ5HCLSFaILFVLRvknqWG2dwfrOtl/GZ+TMttUsibC3OE4DCff2x17IG38RHX1qa7b7zk+
 YGeyShnWHqdLZHbyilsLjOP5qMRhvQS8i0aThPULCcH0sccssGiO2WPNWApV3kb/1CgcJZr6oPP
 UPZiBNxF8Kr8WPqNkZ6lGc5YZ6lGNWkqfP0/uxDatNowfvsiFOeS8IVkLhtUDrPwR2WViDR0Q0x
 YutZ48xZ2nKFWCuCVvS3/5ld1/dSL3bXMP5rTDgjk+CzWEuLBV7FRjWojn1YMLAR7WxFqXR80XI
 mC8JbOFT/XsN0H/4uZZvkVxC0OfZcLNpC16M53x/2o8W/LfY7R16DWsbYTyaAuSbr+79elqBmMp
 sB1ZH5f/8tc7Ic7SQGtogoMwHVeXdVnnI4e81hcHkTwTdNPnMM1ZgyyxAc4V3JIU10idNtU9fAJ
 kwhgw==
X-Received: by 2002:a17:90b:4fd0:b0:390:b41a:b92b with SMTP id
 98e67ed59e1d1-39580a53469mr18392116a91.4.1787197704400; 
 Wed, 19 Aug 2026 20:48:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 77/93] disas/riscv: Split ventana_opcode_data
Date: Thu, 20 Aug 2026 13:44:14 +1000
Message-ID: <20260820034430.1186695-78-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Move the table to riscv-xventana-op.c.inc and massage
the lines into OP() form.  Drop vt.illegal as unused.
Return pointers to objects directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-42-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv-xventana.c        | 21 ++++++---------------
 disas/riscv-xventana-op.c.inc |  2 ++
 2 files changed, 8 insertions(+), 15 deletions(-)
 create mode 100644 disas/riscv-xventana-op.c.inc

diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
index a4e59312d0..5d2e07865f 100644
--- a/disas/riscv-xventana.c
+++ b/disas/riscv-xventana.c
@@ -8,35 +8,26 @@
 #include "disas/riscv.h"
 #include "disas/riscv-xventana.h"
 
-typedef enum {
-    /* 0 is reserved for rv_op_illegal. */
-    ventana_op_vt_maskc = 1,
-    ventana_op_vt_maskcn = 2,
-} rv_ventana_op;
-
-static const rv_opcode_data ventana_opcode_data[] = {
-    { "vt.illegal", rv_codec_illegal, rv_fmt_none },
-    { "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-};
+#define OP(N, ...) static const rv_opcode_data op_##N = { __VA_ARGS__ };
+#include "riscv-xventana-op.c.inc"
+#undef OP
 
 const rv_opcode_data *decode_xventanacondops(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
         switch (((inst >> 2) & 0b11111)) {
         case 30:
             switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
-            case 6: op = ventana_op_vt_maskc; break;
-            case 7: op = ventana_op_vt_maskcn; break;
+            case 6: return &op_vt_maskc;
+            case 7: return &op_vt_maskcn;
             }
             break;
         }
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &ventana_opcode_data[op];
+    return NULL;
 }
diff --git a/disas/riscv-xventana-op.c.inc b/disas/riscv-xventana-op.c.inc
new file mode 100644
index 0000000000..0fe4666aee
--- /dev/null
+++ b/disas/riscv-xventana-op.c.inc
@@ -0,0 +1,2 @@
+OP(vt_maskc, "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(vt_maskcn, "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2)
-- 
2.54.0


