Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F37AC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73l6-0003wx-Hi; Thu, 17 Sep 2026 00:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k7-0003Cq-RD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:05 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006na-Iw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:03 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so323812a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619325; x=1790224125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mRS7vobS39woljInot0zu4ep78CVsfZV7P7veSlVxro=;
 b=q7ZKzXMEmii7LtMppzOtXAXqJKC+rHpQmtS3CxQ3EkoWiJcWkwI9l280kyLuEAodAV
 yeBwIFRME0vC9ldkr96ANJtQLQkwlmsXC+CLLba3390KHME9hLJbmHbX4i6REB1mYA3K
 ufgPTFukMev66LAnKfLvrmkfDrbny0ET8Qx+vUNfVsiiESTUS2mFDEjT52dpFNCPfpKC
 rA2UDRr25D0n/2SMGRKB1w+NC0smECYdm0xdG0FLIiW7RNR5+2FGaaOc2I/6qT4g4YIU
 zkqrPLBsaxMFm6IJ+v8La/7y24Y/mnOz7Fj5pe+MGnNLXR21FRc6cvp/4uwkvy6Z7+ck
 MpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619325; x=1790224125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mRS7vobS39woljInot0zu4ep78CVsfZV7P7veSlVxro=;
 b=onD+ycBgljg+gSXWlqZ/mdDDn8pvTS5PKS4T9DwVBFWCp7doRnNr34pUH7VWLBstma
 4ZGNWLqxFOj7FMdSWAKqmIr+PLWYqDQydloJhmRL7L8VoTRe96HFVFPaQ2xDnGjrqSpv
 0/F84eXZyEZQZhbakZET7iFAULLn3ay3D0O2thS5a6PkD3wqTX8+J+ym/3/XVHZg389/
 0Moe6gOMrBOckJPMONMvU2tIsXDZgVQ+U1ugPs3ROAap6L2jiQ7Y4yyBRl7UfjR623NK
 eMRjFtyZGLUcmbVI5FWdQWafa25ZdT4yF6g89DwsuOj9RHbAlsrGsKDltwkvnFqRHEWK
 wj7A==
X-Gm-Message-State: AFuF++kA5Xo+3mMaQO4WC4Aupmfc2OSket7R4PEQjscVLz2R8qHbluih
 A9UX3Daye2XGtHiCoBbzYBHrnJfz0CbFnMbSd7sHvfWC17pgiwpxB2OKrrciZRizfiqTQrW8TAi
 lbxNfhes=
X-Gm-Gg: AYBFou0OeHKlyeDeuR29eXIdRDzBW+SV6DB7TgvppFf3lzQ75OUQsv6Ionc/fasOOaW
 xeeiz0YdxRZeNfbfk8QwgOQPqftUpEJhaLczPMS85ddxtX7Xi//ZPHCskfe6ivrJGlc/vbOmso1
 P7V5EZNAQb3eNRGlYbtQj7W7Hk93b800lPli9m5S0wAm7ENYZkwiD8m6xLzS4FM8Xi1HCyt+DTX
 4/28NTnViYjt+jAU0CFDvvPepRhZ59vWyptu+LPG/dpfVO+Ov47Z0lc8e08TV40edAN8KLpN4rd
 HWhbGWceQ41IyK392/rzQ8CoO67dObWvtuEEe4hOEm3qTedbwY2s7bU1yC/vq5ybRx50P4nK70O
 bXgz0YMO2i+vtgZpbk6tCgPou3HXf3HSFfMcbmtntD+R6R7Y5u1F660iQagv3gSGeefb6WAkLyr
 XiRhwfZoZpGVDPW3kDRuMLPhIqlo68gQhBruF3c4pyBJguczwpfDtBtDr1MuaFHujcEMkXv8Q0G
 +cDeZw=
X-Received: by 2002:a17:90b:4987:b0:39d:f064:3a68 with SMTP id
 98e67ed59e1d1-39e1e4d371bmr12287455a91.21.1789619324716; 
 Wed, 16 Sep 2026 21:28:44 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 017/101] tcg: Generic expansion of tcg_gen_subfi_*
Date: Wed, 16 Sep 2026 18:26:59 -1000
Message-ID: <20260917042823.542588-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 21 ++++++---------------
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7d4765460b2..390df36f1c2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -222,7 +221,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 77b1260a292..9084171d6fc 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,3 +8,4 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
+DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6aee0190e0d..bc902d04d53 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -443,17 +443,17 @@ static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_addi(type, dst, src1, -src2);
 }
 
-/* 32 bit ops */
-
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
+static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
-    if (arg1 == 0) {
-        tcg_gen_neg_i32(ret, arg2);
+    if (src1 == 0) {
+        gen_neg(type, dst, src2);
     } else {
-        tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
+        gen_sub(type, dst, tcg_constant_internal(type, src1), src2);
     }
 }
 
+/* 32 bit ops */
+
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1562,15 +1562,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
-{
-    if (arg1 == 0) {
-        tcg_gen_neg_i64(ret, arg2);
-    } else {
-        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
-    }
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


