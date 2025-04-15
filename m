Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AD0C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mIn-00060b-O2; Tue, 15 Apr 2025 15:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m6s-0001IE-8D
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:38:36 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5g-0004VY-JR
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:54 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so4845322b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745769; x=1745350569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6YmG+5NsJNkoxHFMkE90ODbmuf/mHUrlMw3/lVh+glE=;
 b=st4nM4YIYmcF8VWsoAp1q+9ydFnatgz3ad7z0eZulf8OiXthDV38eWeQSCq4M0+bY0
 SGCmTVdScxgk1SrxWh26f46fU2y3iYEg/QiTYke43UekCYgcANXtJuJEi/Cadxzok6MD
 Ugm//IFBWsozih5cfv3SVQuHmKS6uIoU/56HVBBZ8pvJvWlC8nHbDmPD4In+52NU/I1O
 4R1+yF0JLHqT1et1yemRAYCNQWBZBHoj87QNG1zsYapDZZ3G9WeZP5lbiXHH7oEbixmg
 2U65QWSlAlZxYg0k2/D4lxTKBjJzsRoZFA22ZyhkoFAWCWw6pShTkwy1DenPhDqzLnNK
 w1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745769; x=1745350569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6YmG+5NsJNkoxHFMkE90ODbmuf/mHUrlMw3/lVh+glE=;
 b=rmvIifdVSdgLA83oI5RYwKq/jmFBLLqfmnmyzL+Of6MIGUV2e3AH3YL5+aKDChq4gY
 J+iygz9IGPEDCA6OrwCOjAkuT0t4dH+R7qRyclKB3V/9lW82c8JQ5L/x3BqC6cu5OgYL
 5KugXVbtbbn5x6PJb1DlnCRIyvjiGsBHRgMDxX0aZ0IleAJ6iTIY/ad45qUTu7fpVR2r
 dQlJzhqdZuJVcQirtbCpME12gceq7w3aKtCi4rD6/vxD9NUsFdZRw3V5XIU7mgx4e5da
 VBBbW+NtqqUo1wa/8pVAUe3/mcklr2ZuDdj364VMWARDyCu6mCZFqoDHxfDeEZUIAB7S
 NgnQ==
X-Gm-Message-State: AOJu0Yy0/MLJxVGZ6R9NbBi6c+pLD1pTyqG/3p7TgtHBvX8nD4ICUKCh
 4Xc6pKtR7i0WEaxP1sTYax8gvNL+3kccnyrDA+lKc5ACtHR5ZiRPSHpyVZAszgTTfWJm4GKqDCO
 3
X-Gm-Gg: ASbGncsX6pe7Hbvufcsx2SIG63CBMnKfdJgiCskVPZKyVUzHK1GsGrnhhfrfn/hc2lZ
 qBvLL6qSx4Yt8uK9KbabKBZLCR7xNVhPMOmD3tbhnHoEmc7eCJz7FOjlfMxX/yEw7dJPsceI4k1
 wTvSkhgA5T1cYBBPO8YiU+/IBsvZsRMB+HLWjIYuDGJaUt4K3LesFwtwhZJa8Hz3Mci2/T+12sD
 QrTE4cLEDkcvvfqgFtRFMoIeQpJvvkgvO9asB5pXmW67aITgz5HSVp8VnmdwjcylGO0RBwJeet8
 0wFnzqKwg/azbKwhUdzYzC9GV2j1w0q5sCrWxISe3gSbpMcBJalphR9XVRCihBaDwbhEQymUZ/0
 =
X-Google-Smtp-Source: AGHT+IH2XOelFOnvE49tDhryRjIHUymjt3rzixFguihx57G5rd8FClkJCk5f8U+MkN5kiJk+eXSmHg==
X-Received: by 2002:a05:6a00:400d:b0:739:50c0:b3fe with SMTP id
 d2e1a72fcca58-73c1f8f5b43mr1105707b3a.8.1744745768440; 
 Tue, 15 Apr 2025 12:36:08 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 134/163] tcg/aarch64: Remove support for add2/sub2
Date: Tue, 15 Apr 2025 12:24:45 -0700
Message-ID: <20250415192515.232910-135-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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


