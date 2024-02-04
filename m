Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DF2C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFm-0004LW-1L; Sun, 04 Feb 2024 16:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFi-00046t-Tk
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:15 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFh-0003ct-0m
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:14 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso31083175ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082931; x=1707687731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLlFVC2Bn8RFXAnYZ0tdiIE38xNTKymQB0njuipjHgI=;
 b=eV9jXOpEQrZql2VM6I+hfYndgmk7AgsS4uHBufCVIdw/rVKaz5vovulI1Bwwws/aWF
 76CKr99vFkvFFuHx6MHbevFbk6Rl/zU61MolzB75NW0XhAgCc2L5ejvskNzSPMNT/i1K
 TLTECZp5fwPddQbinpgpIy5QeIajv4I4+cSMRKq8K+nc9dwu3PXlWxnIea+Ucr5EH3qc
 a8tTk3jtta1GSA++6x1AHveKag462pyfMTaTEb9jNFdTs8ywyQHU1a2BT/twz84igAHD
 OkvSG/KgUuy7uyiyGkFZwGftOIbSwlw4NoB53UnhTvjQO53AxKZM5EXKIXIhqpiNCcfp
 TXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082931; x=1707687731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLlFVC2Bn8RFXAnYZ0tdiIE38xNTKymQB0njuipjHgI=;
 b=XweZGWaFcINMWHHM8gtXItzQyxdQw1lvRkXqnBDsSGCwfmFfsdEOzgr+uhA+8e3Pi7
 Nza5ROWVUrdbyEU64knSPINyAduxSVYQiZX8N0OIkU7f0PHeBBq3DmSXQqIGH7nrs92e
 hY3HD5O7sWkeLd0Vc65GezBoTOvWrDerWm3IpuE4xJQxKKzUDBUnqfWW9IwUbFhAoczS
 P7GbuNMMO6K8dFpKVj9E8XHNFOGwQCox8FfhcPSnqIUQK8kvR5sEnh9bswfhTuZoqmsi
 szHqkyqPqw9230V+0Pef3xcUOFheGFu21LMlzmp+rmGovRVydbYtPu86vTKkE1oCAkxq
 UkxQ==
X-Gm-Message-State: AOJu0YzAre/gnBoIFtudKHmtUJXOisFr8eQxwKB31M5eXlHDZ24uhOQu
 Iu5H6T/9yialeeby5FrLwLxRTuSziZAOOKvbU5P+2CUseZerDWtrU4CgGFiKMRS6eC8ZBUpgYy1
 bqnQ=
X-Google-Smtp-Source: AGHT+IH/O4ZMMGo6GEv/gXqYjj2CQRRC/8IMWUW4zB+S345l9MBFvGM7MiBxzP/3JDq95oET3wKjLA==
X-Received: by 2002:a17:902:d2c2:b0:1d9:b407:dd87 with SMTP id
 n2-20020a170902d2c200b001d9b407dd87mr1911951plc.21.1707082931599; 
 Sun, 04 Feb 2024 13:42:11 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:42:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/39] tcg/s390x: Split constraint A into J+U
Date: Mon,  5 Feb 2024 07:40:49 +1000
Message-Id: <20240204214052.5639-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed 33-bit == signed 32-bit + unsigned 32-bit.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h |  8 ++++----
 tcg/s390x/tcg-target-con-str.h |  2 +-
 tcg/s390x/tcg-target.c.inc     | 36 +++++++++++++++++-----------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 9a42037499..665851d84a 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -15,7 +15,7 @@
 C_O0_I1(r)
 C_O0_I2(r, r)
 C_O0_I2(r, ri)
-C_O0_I2(r, rA)
+C_O0_I2(r, rJU)
 C_O0_I2(v, r)
 C_O0_I3(o, m, r)
 C_O1_I1(r, r)
@@ -27,7 +27,7 @@ C_O1_I2(r, 0, rI)
 C_O1_I2(r, 0, rJ)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
-C_O1_I2(r, r, rA)
+C_O1_I2(r, r, rJU)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rK)
@@ -39,10 +39,10 @@ C_O1_I2(v, v, r)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
 C_O1_I4(r, r, ri, rI, r)
-C_O1_I4(r, r, rA, rI, r)
+C_O1_I4(r, r, rJU, rI, r)
 C_O2_I1(o, m, r)
 C_O2_I2(o, m, 0, r)
 C_O2_I2(o, m, r, r)
 C_O2_I3(o, m, 0, 1, r)
 C_N1_O1_I4(r, r, 0, 1, ri, r)
-C_N1_O1_I4(r, r, 0, 1, rA, r)
+C_N1_O1_I4(r, r, 0, 1, rJU, r)
diff --git a/tcg/s390x/tcg-target-con-str.h b/tcg/s390x/tcg-target-con-str.h
index 25675b449e..9d2cb775dc 100644
--- a/tcg/s390x/tcg-target-con-str.h
+++ b/tcg/s390x/tcg-target-con-str.h
@@ -16,10 +16,10 @@ REGS('o', 0xaaaa) /* odd numbered general regs */
  * Define constraint letters for constants:
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
-CONST('A', TCG_CT_CONST_S33)
 CONST('I', TCG_CT_CONST_S16)
 CONST('J', TCG_CT_CONST_S32)
 CONST('K', TCG_CT_CONST_P32)
 CONST('N', TCG_CT_CONST_INV)
 CONST('R', TCG_CT_CONST_INVRISBG)
+CONST('U', TCG_CT_CONST_U32)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 54645d1f55..b2815ec648 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -30,7 +30,7 @@
 
 #define TCG_CT_CONST_S16        (1 << 8)
 #define TCG_CT_CONST_S32        (1 << 9)
-#define TCG_CT_CONST_S33        (1 << 10)
+#define TCG_CT_CONST_U32        (1 << 10)
 #define TCG_CT_CONST_ZERO       (1 << 11)
 #define TCG_CT_CONST_P32        (1 << 12)
 #define TCG_CT_CONST_INV        (1 << 13)
@@ -542,22 +542,23 @@ static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece)
 {
     if (ct & TCG_CT_CONST) {
-        return 1;
+        return true;
     }
-
     if (type == TCG_TYPE_I32) {
         val = (int32_t)val;
     }
 
-    /* The following are mutually exclusive.  */
-    if (ct & TCG_CT_CONST_S16) {
-        return val == (int16_t)val;
-    } else if (ct & TCG_CT_CONST_S32) {
-        return val == (int32_t)val;
-    } else if (ct & TCG_CT_CONST_S33) {
-        return val >= -0xffffffffll && val <= 0xffffffffll;
-    } else if (ct & TCG_CT_CONST_ZERO) {
-        return val == 0;
+    if ((ct & TCG_CT_CONST_S32) && val == (int32_t)val) {
+        return true;
+    }
+    if ((ct & TCG_CT_CONST_U32) && val == (uint32_t)val) {
+        return true;
+    }
+    if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
+        return true;
+    }
+    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
+        return true;
     }
 
     if (ct & TCG_CT_CONST_INV) {
@@ -573,8 +574,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_INVRISBG) && risbg_mask(~val)) {
         return true;
     }
-
-    return 0;
+    return false;
 }
 
 /* Emit instructions according to the given instruction format.  */
@@ -3137,7 +3137,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rA);
+        return C_O1_I2(r, r, rJU);
 
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rI);
@@ -3187,7 +3187,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_brcond_i32:
         return C_O0_I2(r, ri);
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, rA);
+        return C_O0_I2(r, rJU);
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -3240,7 +3240,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_movcond_i32:
         return C_O1_I4(r, r, ri, rI, r);
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rA, rI, r);
+        return C_O1_I4(r, r, rJU, rI, r);
 
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
@@ -3259,7 +3259,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i64:
-        return C_N1_O1_I4(r, r, 0, 1, rA, r);
+        return C_N1_O1_I4(r, r, 0, 1, rJU, r);
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
-- 
2.34.1


