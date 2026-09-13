Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80D8C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a8I-0001oy-Ti; Sat, 12 Sep 2026 22:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7p-0008Vb-Dr
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:25 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7l-000163-MG
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:24 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so735228a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267160; x=1789871960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xjzB9PJkcDa7CTx8nFMeDFXL2nGn5ZwABCBQku8dSik=;
 b=ZKARLIFnSknbDTI6cYi7zdJceXk9KJNnpk1M7LirZX6w5fDqdNjsmH5Zx2MFSksaM3
 AqLl9B/GRdCwcXXoUjgqRhGcdSKG4Ht0Swy4dcOokj6g5bhuulrfyYY6PK1PSYp6lodQ
 ob3Mq9qZKwCHEezCTsBYfUhpAYF0pMMGfdGZ+5Io0+fcpJBZqxq/aRcsf54PtbwwfjtC
 F0UTfikncfC9F37PCW42d0jJUfIGa6rSAOfnwZTm9C0ybrZuCP8LKuDe1/IJLdOuKAkP
 p+BqQOaVA0Xm+aV1Ezu4/gkMYL+OLMGHFfQn4RMjt0ws09M2AdCKLp1u97j4kfnRosrN
 ifZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267160; x=1789871960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xjzB9PJkcDa7CTx8nFMeDFXL2nGn5ZwABCBQku8dSik=;
 b=FOklm/kib+XiblIo3MnH5uckMcW1R5KysK44A4Gs6dtZB2havZlsbBe9V4sgf0zNz+
 2iSnsmUaDT6+3e/9AhNDrjdMTffoUJlzyBOTPq0attNVqq7Qpq8I7Mif/XcpJId592xB
 OWovcHBr37KmcRRtoGVEiU223DgFvq56t4ido3/i/BZ54t05W3u7fu+6OHy4tHq0/0tu
 vghrTKc+zNQrWGnT4nBQIDetrL/OC3iheY/i06LEB/LTVPm82klf7KuOj8n5Iy+ZVj2y
 XueZWRu8ffB3Nv2PiuFFMBbKFw3KKYMfgvnYNj5Bv9dgdwsKj4MFrWgY7O3jo5J1nGc6
 rElA==
X-Gm-Message-State: AFuF++m1LQM6nRHAbSJM6d4woTOPqUSfOjaE5iWfZzZNHH/4sOX+ducw
 aHJtJAj2XZBbkyQxw9APYr9odetahYKkoPFj/34J6NlRQ6aX/348VULJOswVPDMj15C2gUOqyop
 8Q6Qp
X-Gm-Gg: AYBFou2kQACaThVEknvDSdzPgKhCvHmS2/v0jocF8yMQw59BnCCDDLNGhOHl8JuuxFD
 /pQaq7L8jKspV+f7z9+D13tAzRBFNVx9rTglFSOGUWzrCZGQu/BXTjUp+xFQUKld0yV8E37M3pJ
 N0mQ4D7lLu0g/UORo93XEbwh5ImE6hW8FOhNvEyUc9IY2ziQyPT4WnwoKVjo3+CXHzIfMPzoJxU
 CqZTe5BEPtamaLuG72DBfCL9MsnAiJaGzzFyz34eYUIUEeBz+V2p1wBVZi+KkXkvDE7m5p7x7mT
 8vmTVr4/QHg6CYhP8Z0hVNN0aLYUZdA/z6yzj0iPljHj6p7rB63gzop4qTcBpCeBIMtkKOqHF11
 a6GwPcWvtgqwzAe+H+TrOrRhn9GXtAfM8AT3YJwWxRFAYWQJ63NEAS3zNYmhZ97rgum3NLE1XC8
 s8obyz9aSNdVTe18AQfQqhk1mHeBnYOkCMg/t/2RTSFRNI0fLDHSr+OkfSvb2o3iepYi5R/SGKR
 TVifmg=
X-Received: by 2002:a17:90b:2c90:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-39dbc1d2546mr9550520a91.10.1789267160229; 
 Sat, 12 Sep 2026 19:39:20 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 35/86] tcg: Generic expansion of tcg_gen_nor_*
Date: Sat, 12 Sep 2026 16:37:46 -1000
Message-ID: <20260913023837.741866-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 621839a3b82..471fce20998 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -198,7 +197,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 80d174a6cb1..62dc85ff6a6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -15,6 +15,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
+DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 89362b597f4..928ae524d49 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -542,6 +542,16 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nor, type, 0)) {
+        gen_op_ttt(INDEX_op_nor, type, dst, src1, src2);
+    } else {
+        gen_or(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_not, type, 0)) {
@@ -750,16 +760,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
@@ -1777,16 +1777,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


