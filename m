Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6579FC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxb-0007BA-Is; Sun, 16 Feb 2025 18:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwa-00049A-8j
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:00 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwX-0006Rt-5A
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:59 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22104c4de96so20685315ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748055; x=1740352855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6YmG+5NsJNkoxHFMkE90ODbmuf/mHUrlMw3/lVh+glE=;
 b=YgsuvllmiAID/Ei3qbNUJHTMnzo5mMBQNNa1xVW/47oNAP7EnWM3df8OUDMwDlHeWI
 uUVlxbncVRXc/TOZW8k5kaiyA0uzxSDR6LD9b/JVQ8snWA9IcBb8oL5RB84UeZClUXRA
 xoK9BPhDEY/uwCYMep03+sPlYK1EvfR+Mxlzv4sX4UM7tSql938HcD6pCcE1tHTB4Uer
 H76o30DK0H6bWHdOUPdhWRbfdzu6B0INlWVxdWdp6yqs5gFE9SnW8nR0pDFUt6sjCcF1
 7rgBLDAj8iK7AktX5fs3fb80G+x1DNKfU5MwA66I+gRo2XZV/48iATG6DA39Lj3Lkbct
 93kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748055; x=1740352855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6YmG+5NsJNkoxHFMkE90ODbmuf/mHUrlMw3/lVh+glE=;
 b=r+VXvaXhOluKhbdGwrDKHQD35MzErHjnzGgDrA+8wYYlWLVPuaIjIKWTntWxdwrcuG
 RGUEEd510vqe75G46I0iIs3amvcji0zG4mgi4rXlAVcMwvm+kYJu25O1O6SYcNUV2DMJ
 Ib7SNfpfDCXvGVGJMR6UQtoAqwkexgnnkxoCO+kBCJ3sdelhykAgcXUR8+5U6wU3WIM3
 X1sWyeKjwjvWWw/He+QwPhd1InpRktxW+Uq3AYA+speiip9vhig6pDIsAdt3DNNE85LU
 uirlZ/XFQntVtQYIJBxUYcfAfVVhpbaLA1+UbPRSRLvuIVv5In9wdVoVrFzELahZzuuK
 dunw==
X-Gm-Message-State: AOJu0YxbtfiuzXXPLQGR3qrlEaFwZB3q7SJwt6KUrPFrvK0yGZUzON0+
 81sSwlGFmzjnP3b/QvMYbf86xGswo4++5/aM9N33qVck/4f5L1UfpdSRMGUnUn0j48OQqk/EskP
 w
X-Gm-Gg: ASbGnct/MTP1BZ32JkwADt9UO2rfp714UWkLU81RlN4t70g14g60qiAMPj0wp4b3rZF
 efCN3pOgPr8WbwsN+riek9eNsjpHBMwtzM/AYGiRSGugwJJn+nyu2jxi++XoE6bNvdEnF+/G//7
 ut0e5ljBRDuMECVniFnMs2LatsiJ0OxF0hPXMCsM8BNJwxQTf03I14gwCdwPFhsqjR1mvPospNM
 59v54h15vsfKxwJQXiZwKxPB/SGymQQOhRrSeLsKgsQQQRn66D+k2kPD0/3/MrZmO4HIKuU/ZZc
 9rcKoWUI4xPQZ1HJAdbK/TAPhtTkm+QSfTah6HR9rwBjZfU=
X-Google-Smtp-Source: AGHT+IEVlm7D+OapNRSJ8u5K6xB+PvqlYD2CnKXFm7jGrQjUFCUrjiLIzcOmpASOpox6yBoP/9uO3A==
X-Received: by 2002:a17:90b:3b92:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-2fc40f10763mr14060065a91.12.1739748055515; 
 Sun, 16 Feb 2025 15:20:55 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 133/162] tcg/aarch64: Remove support for add2/sub2
Date: Sun, 16 Feb 2025 15:09:42 -0800
Message-ID: <20250216231012.2808572-134-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |  1 -
 tcg/aarch64/tcg-target-has.h     |  8 ++--
 tcg/aarch64/tcg-target.c.inc     | 75 --------------------------------
 3 files changed, 4 insertions(+), 80 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index 02a0be66fd..d0622e65fb 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -36,4 +36,3 @@ C_O1_I2(w, w, wZ)
 C_O1_I3(w, w, w, w)
 C_O1_I4(r, r, rC, rz, rz)
 C_O2_I1(r, r, r)
-C_O2_I4(r, r, rz, rz, rA, rMZ)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 011a91c263..695effd77c 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -13,13 +13,13 @@
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 9dc6bf3e3d..75cf490fd2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1575,56 +1575,6 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rn)
     tcg_out_mov(s, TCG_TYPE_I32, rd, rn);
 }
 
-static void tcg_out_addsub2(TCGContext *s, TCGType ext, TCGReg rl,
-                            TCGReg rh, TCGReg al, TCGReg ah,
-                            tcg_target_long bl, tcg_target_long bh,
-                            bool const_bl, bool const_bh, bool sub)
-{
-    TCGReg orig_rl = rl;
-    AArch64Insn insn;
-
-    if (rl == ah || (!const_bh && rl == bh)) {
-        rl = TCG_REG_TMP0;
-    }
-
-    if (const_bl) {
-        if (bl < 0) {
-            bl = -bl;
-            insn = sub ? I3401_ADDSI : I3401_SUBSI;
-        } else {
-            insn = sub ? I3401_SUBSI : I3401_ADDSI;
-        }
-
-        if (unlikely(al == TCG_REG_XZR)) {
-            /* ??? We want to allow al to be zero for the benefit of
-               negation via subtraction.  However, that leaves open the
-               possibility of adding 0+const in the low part, and the
-               immediate add instructions encode XSP not XZR.  Don't try
-               anything more elaborate here than loading another zero.  */
-            al = TCG_REG_TMP0;
-            tcg_out_movi(s, ext, al, 0);
-        }
-        tcg_out_insn_3401(s, insn, ext, rl, al, bl);
-    } else {
-        tcg_out_insn_3502(s, sub ? I3502_SUBS : I3502_ADDS, ext, rl, al, bl);
-    }
-
-    insn = I3503_ADC;
-    if (const_bh) {
-        /* Note that the only two constants we support are 0 and -1, and
-           that SBC = rn + ~rm + c, so adc -1 is sbc 0, and vice-versa.  */
-        if ((bh != 0) ^ sub) {
-            insn = I3503_SBC;
-        }
-        bh = TCG_REG_XZR;
-    } else if (sub) {
-        insn = I3503_SBC;
-    }
-    tcg_out_insn_3503(s, insn, ext, rh, ah, bh);
-
-    tcg_out_mov(s, ext, orig_rl, rl);
-}
-
 static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
 {
     static const uint32_t sync[] = {
@@ -2895,25 +2845,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
         break;
 
-    case INDEX_op_add2_i32:
-        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, a2, args[3],
-                        (int32_t)args[4], args[5], const_args[4],
-                        const_args[5], false);
-        break;
-    case INDEX_op_add2_i64:
-        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, a2, args[3], args[4],
-                        args[5], const_args[4], const_args[5], false);
-        break;
-    case INDEX_op_sub2_i32:
-        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, a2, args[3],
-                        (int32_t)args[4], args[5], const_args[4],
-                        const_args[5], true);
-        break;
-    case INDEX_op_sub2_i64:
-        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, a2, args[3], args[4],
-                        args[5], const_args[4], const_args[5], true);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -3407,12 +3338,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(rz, rz, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, rz, rz, rA, rMZ);
-
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_mul_vec:
-- 
2.43.0


