Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486D6E7719C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4aj-0000fG-Cj; Tue, 07 Jan 2025 03:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aH-0000KD-Ra
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:15 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aB-0003LS-QM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:03 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee86a1a92dso17822317a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237098; x=1736841898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeV0RY/Ixk2kohRHUTMjuL8C2EOKE2Pnl+QdqdbFa20=;
 b=CadiWOPrLPP+h207j0sJSEzt7douh1nQrZaQ/shefNcRfE07pGpZH9zeCnB05YZ4Yz
 msQYCslFWxCnu/wshO2WLlwbNR538OrrCjG8f8crxA2ysNcSXLWzIIaBmV9blBpftOIF
 TGA9dMmaEw8U6wd2raahirOGD7TkAwNMno2y3cZV9Ww8Ay/X6viB/eexIVQwBoY1U9vi
 pJ1psF6hDnBrO7a4vLsqrmA+6JUu3ox2tFSnPruPihujFywZvbjQQ5Heegh9p3RCTYU9
 bGSRY7A0sYrUO00lJUuCMCVBTgq8Ed5HwZZQjUkdzvTFkOYd+RC1svAGQOtlaZubLiL6
 cmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237098; x=1736841898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QeV0RY/Ixk2kohRHUTMjuL8C2EOKE2Pnl+QdqdbFa20=;
 b=qmb3tjLmSEN1F8ng0NLwTIGXCZLIMDv49m6bQWZYv3vMGu1rkjFmCy4ToPwAmAgc2t
 tCcVUeJsmiulEr5Sv3dFfyu78ufzUNmibbvKF7A5X2OFMGgRqIdL1k7iBIjCVRvWMKou
 BZhO4QO7UBFZABRtqvWLmQQ+Upf/ryHD+xKm790gAVy4QTlsOv/n0vvYqdGfuaQ8fjv8
 GKP9KUjPguO12v3Gu7K0xDgtHXSYDJ9ZmXxPa3vwYmOsMvtgM0nKFEONrN7R9hxxzjCU
 InQCATobhOT+KlZ/J56DJANaf1Zwm3xncf6FPgA7YJFIV5GZhgnsNuGOv4yXT+g3HniY
 0VFA==
X-Gm-Message-State: AOJu0YwpVmEwxdehRcNZrT6dW+UAVlnCvFlfI1X+Zr5dhQZD7996vTHK
 KI8DATjmG1aPpOye/UdBBbDnXzs7/caJ4jvYEZIDknW/vvtOVOxNVy7zjvTJTAQBPd0MkGU5l46
 a
X-Gm-Gg: ASbGncskBB7HfwyBIyv0jQ69eY8sHwj2F0tMcawYLBLTpPVKs+zl2aaTzMvH1vmi94d
 k+fqQB57uLl8vC5LhpMHKBi5th92MKqvUQeKoKZBUuRBBOYUWNFaBgJYFRZMOYPiuiTFTpLSzsb
 XjHnmHcxOg89CEFbZ3D48q4XYtGrjvCAyA0UinwfFdjMsaS0r5kZzSUdH4yhXB2cWRoWfXE1g/b
 wOxTtpSfmdLWt0nx1CgHK8dg/DJAPCePSIbT3jpnSNz3x6id2M2BP7h9oPRJmZwiq83Dyj+l8aj
 sDTE4+lljhPq9B4NrA==
X-Google-Smtp-Source: AGHT+IHArgPO1pRVCAKAxg7c9Mqz+zbVl8F16IPDTjQEJp7M4t/VbXddiR+q5XsHIurDSCbDDClKMw==
X-Received: by 2002:a05:6a00:398f:b0:725:e499:5b8a with SMTP id
 d2e1a72fcca58-72abde3335fmr81776742b3a.15.1736237098308; 
 Tue, 07 Jan 2025 00:04:58 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:04:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 40/81] tcg/ppc: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Tue,  7 Jan 2025 00:00:31 -0800
Message-ID: <20250107080112.1175095-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
index a6c7cdba5d..d087189a77 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -39,7 +39,7 @@
 #define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        0
@@ -75,7 +75,7 @@
 #define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
@@ -121,4 +121,16 @@
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
index 9205ac99e9..6e711cd53f 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3430,13 +3430,41 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -4160,6 +4188,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
+    case INDEX_op_sextract_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -4179,6 +4208,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
-- 
2.43.0


