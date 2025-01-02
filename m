Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CC2E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbm-0007Py-GF; Thu, 02 Jan 2025 13:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbT-00072m-NS
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:29 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbR-0005Cc-7F
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:27 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-215770613dbso117115835ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841244; x=1736446044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yTp4xXbVrPMCOjkMCkleN5D7ZHLekGUxbwpbvZU9AAQ=;
 b=Th0Y1p4XarCFQrq2bO19md2B85TBBMM608DmwmtJcYEvpNfc13Q9DCPkYrkZqSYWZx
 rdNCLT/6D5+RyDTX3UOHLp6JnvrFgaTuYbv/4tG+pEw/9fEdYnmbmtpGGE21mkAUbh/L
 zNWAUynM7lY8XvN5RvQYkOpsh4FuMouVw0lb0AYosYlnT/y6QLc2H+b+W8hWQh0IfrWr
 e0bWXWZZicvnUaodJd0UXpcyeGFpFQmxjSF9jim1/zCoLOF9ptuxxKtw2/Mb90SnpTFZ
 kd5Yji5mr9QUhuJc4dPgNDRIjCt3f4pXlkBcp2LZWZeALz4UHsUgHlue8OMOjrqXctr9
 020Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841244; x=1736446044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTp4xXbVrPMCOjkMCkleN5D7ZHLekGUxbwpbvZU9AAQ=;
 b=iu8VfNa/1/kSLqcZOiNEFi0EyK7GStPqjp/3Lv2PsPmN26GntXehrHMRmoEPX+cXR4
 6tbPZXwtY1bdKE8yBHPrc1GuaRCnaFVuC2fwOaL0ykZGMWMrKogipUio6/OU/w+SfJ2B
 GYvMIgqP+24+OItUx3lv0r9oFYmfQRIPrSn3vUscHP0HgBdduwuvb6vpu8Nb/wmYDIzN
 II3wRgWwvhdisnKVc+pOrhCyTmw/YJAuJVjSvIRvtqvW1G3/bRphPYGV0XpJ7mcCNI7g
 FnkukjAoZZepBNyw2+1ImXlDRYAFKN6T0zt1Rvt8zUtk33Mnwh/6RL0IFUH+9k8QuTzO
 KhRA==
X-Gm-Message-State: AOJu0Ywwu7cOFEh5oFjB4tpiY7CbcwqTolZoyuTLGr/exZ7EQbJbFG84
 SpxJdn1AjbNfI4s1LHJKSSntMG3zaCFJJassacHGMAItkzR2UQ1JmG9kVOn3i099ufGuYVBpOWx
 9
X-Gm-Gg: ASbGnct4tZTMJ24q+oztTJifzayCrty8UYrDe+3zi860cDV1/Ka5U6T2z01d491tsJD
 yf1rzDvcIZqlJuaw/qxaMpoIAuC2GxEnBTmBdEOheExZKIg9EPDKHfcjtSSiukSkckaZS5OLI7S
 BJKALJXpPIZ+hLwQ3zZbBWV5uQPTILtL0HmU4d+SuyaWxmAzTKXgxwRtS4LUP9XVniucyMa1w+0
 Pbo5KRrVLMQeuv42jHsX8eaOiTl2737YGR9qH+g37hZafJvqTGBmQ6Gapg+HA==
X-Google-Smtp-Source: AGHT+IH2gfattPxM/GU0kuZ152rKmDVTjihXxd2+R+8UAafkLVCnPnsgyuOplhqV2E06xls4SXGgBg==
X-Received: by 2002:a05:6a20:8412:b0:1e1:b727:1801 with SMTP id
 adf61e73a8af0-1e5e07a55e8mr70058167637.27.1735841243952; 
 Thu, 02 Jan 2025 10:07:23 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/73] tcg/ppc: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Thu,  2 Jan 2025 10:06:17 -0800
Message-ID: <20250102180654.1420056-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Accept byte and word extensions with the extract opcodes.
This is preparatory to removing the specialized extracts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-has.h | 16 ++++++++++++++--
 tcg/ppc/tcg-target.c.inc | 30 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index fba392613b..b3a9526ee3 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -48,7 +48,7 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -62,7 +62,7 @@
 #define TCG_TARGET_HAS_ext32u_i64       0
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #endif
 
@@ -95,4 +95,16 @@
 #define TCG_TARGET_HAS_cmpsel_vec       1
 #define TCG_TARGET_HAS_tst_vec          0
 
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+
+static inline bool
+tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (type == TCG_TYPE_I64 && ofs + len == 32) {
+        return true;
+    }
+    return ofs == 0 && (len == 8 || len == 16);
+}
+#define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
+
 #endif
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 94997b126f..69de135ee7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3430,13 +3430,41 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_extract_i32:
+        if (args[2] == 0 && args[3] <= 16) {
+            tcg_out32(s, ANDI | SAI(args[1], args[0], (1 << args[3]) - 1));
+            break;
+        }
         tcg_out_rlw(s, RLWINM, args[0], args[1],
                     32 - args[2], 32 - args[3], 31);
         break;
     case INDEX_op_extract_i64:
+        if (args[2] == 0 && args[3] <= 16) {
+            tcg_out32(s, ANDI | SAI(args[1], args[0], (1 << args[3]) - 1));
+            break;
+        }
         tcg_out_rld(s, RLDICL, args[0], args[1], 64 - args[2], 64 - args[3]);
         break;
 
+    case INDEX_op_sextract_i64:
+        if (args[2] + args[3] == 32) {
+            if (args[2] == 0) {
+                tcg_out_ext32s(s, args[0], args[1]);
+            } else {
+                tcg_out_sari32(s, args[0], args[1], args[2]);
+            }
+            break;
+        }
+        /* FALLTHRU */
+    case INDEX_op_sextract_i32:
+        if (args[2] == 0 && args[3] == 8) {
+            tcg_out_ext8s(s, TCG_TYPE_I32, args[0], args[1]);
+        } else if (args[2] == 0 && args[3] == 16) {
+            tcg_out_ext16s(s, TCG_TYPE_I32, args[0], args[1]);
+        } else {
+            g_assert_not_reached();
+        }
+        break;
+
     case INDEX_op_movcond_i32:
         tcg_out_movcond(s, TCG_TYPE_I32, args[5], args[0], args[1], args[2],
                         args[3], args[4], const_args[2]);
@@ -4159,6 +4187,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
+    case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -4178,6 +4207,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
-- 
2.43.0


