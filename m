Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E26CC021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6qT-0003ub-Ay; Mon, 17 Feb 2025 14:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p6-0001yR-EV
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:34 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p2-0008Q6-7N
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:31 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fc20e0f0ceso5810867a91.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820627; x=1740425427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPHXMTVD2Fm2wK5XqhrhS+/8+R7tQQXD2orYSrUxi/8=;
 b=iAJZkT0wefHgJ6kuXfPS1oHFbbRgiaTlmaVG+um0D3Sj0vfBMYU034ox+84kGdGAWb
 Smjn3pCOpFbDvVdwnz9v6dSNaZRSFtgwZqTjFnRLXB6R/fOlxvurDph7Q1kJhdhUqtAv
 NZH50ItEU4RbYjNnBT3zp1AErQ6szrBBH3N3ajqSBjIRqc6Jk7E1qRHWMJBWR2fTHXD0
 lX4caTs5sHzRFjQ+/Et2tnXYrW6EBpW0gcsaO5jt3P4UzK9fgu77PHpB7kQqu8cODmHC
 0G/neglO+RbzawlIaGKsHTQJI2o9fscNIMAf8SsR/bnyDptWsaNO/09nklYULZrfTx3y
 EWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820627; x=1740425427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPHXMTVD2Fm2wK5XqhrhS+/8+R7tQQXD2orYSrUxi/8=;
 b=ozLs7Y+rBxsktm9FnKuPjfQ4ONer8VRg/C3j/DJle/iW5XN6xWeAc58LnEtpHJtKAv
 nUrco/KdCbDRZAM/m8S82UU/KV8H9jFs1XJOwTTxTefyq4775sxBr7XTbpA3G9vAqKwJ
 VCMuMiUSdTRXOUE6ztMhbsSf3KPk+yrTiAYH/CXSGjyEnuxfNVmbdFKefOudrNQZcnwL
 7BObj9/CB8Udy5Up+0Fgq3kPDvyjUFepGIfYmVJK5MLQWzJo05KT4fe/IiKAMjRyCdpF
 Zg3JhEW1ZcDfamBPASmqSCwPpFWo1hQnziWwHzrFIAZjH1/Cz+yRlCE77AYejp0mK+UA
 hhDw==
X-Gm-Message-State: AOJu0YyTuNnaMijJjNRuMYZB+RGRdgcAH8fMq0A8UgnnSb+lNJAzVS9Q
 d17gf9n7xgCYfO7RNzbbA2bgo897Me4o/R4q2xtFhSPee/Ijz/pyIGH5kOjZy2gzOVrXMoT+/OQ
 R
X-Gm-Gg: ASbGncuoVbv/LN19RstmcXDF3Rx3XkZDPYR2YiwDWC2FoJfzLHjOUD3umUYHsjxlbMd
 VUqf685Zwc5Vvun34XHsdyCCRQrZbGjX3DtKfBGWGkIVAzIDgGVV4jmbFOGJ1hBoF4dDCWY2DEK
 7H6uttX+y7aSl1DfkhVKiv3vZwZxAKUOr9pIQAmD1PVgBlpc3QHNgHA0I55GK4Io3see9dmmunN
 iFzB23qDhRbdbslhCNdJF2q+RWEP15YDv9PWBSuQhivKdspySD8O2gKLf/byUAQxp6GKsrcn9IO
 Cgi/jBDg0WIyEUOPS0KHmGfq3c2p3pxo7tANrIpp21Tcjbs=
X-Google-Smtp-Source: AGHT+IH/x5ysFJXsmYl7iTk7oztURtsk2HCgTN8u+9pa6BW2Ws7C3xaV4+VolnXh2bP/2X/OAM+kGw==
X-Received: by 2002:a05:6a00:1903:b0:725:df1a:285 with SMTP id
 d2e1a72fcca58-732617c63d2mr16018665b3a.12.1739820626728; 
 Mon, 17 Feb 2025 11:30:26 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 19/27] tcg/riscv: Use 'z' constraint
Date: Mon, 17 Feb 2025 11:30:00 -0800
Message-ID: <20250217193009.2873875-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Replace target-specific 'Z' with generic 'z'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h | 10 +++++-----
 tcg/riscv/tcg-target-con-str.h |  1 -
 tcg/riscv/tcg-target.c.inc     | 28 ++++++++++++----------------
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 3c4ef44eb0..e92e815491 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -10,17 +10,17 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(rZ, r)
-C_O0_I2(rZ, rZ)
+C_O0_I2(rz, r)
+C_O0_I2(rz, rz)
 C_O1_I1(r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
-C_O1_I2(r, rZ, rN)
-C_O1_I2(r, rZ, rZ)
+C_O1_I2(r, rz, rN)
+C_O1_I2(r, rz, rz)
 C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
-C_O2_I4(r, r, rZ, rZ, rM, rM)
+C_O2_I4(r, r, rz, rz, rM, rM)
 C_O0_I2(v, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index 089efe96ca..2f9700638c 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -21,4 +21,3 @@ CONST('K', TCG_CT_CONST_S5)
 CONST('L', TCG_CT_CONST_CMP_VI)
 CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
-CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 689fbea0df..f7e1ca5a56 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -112,13 +112,12 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     return TCG_REG_A0 + slot;
 }
 
-#define TCG_CT_CONST_ZERO    0x100
-#define TCG_CT_CONST_S12     0x200
-#define TCG_CT_CONST_N12     0x400
-#define TCG_CT_CONST_M12     0x800
-#define TCG_CT_CONST_J12    0x1000
-#define TCG_CT_CONST_S5     0x2000
-#define TCG_CT_CONST_CMP_VI 0x4000
+#define TCG_CT_CONST_S12     0x100
+#define TCG_CT_CONST_N12     0x200
+#define TCG_CT_CONST_M12     0x400
+#define TCG_CT_CONST_J12     0x800
+#define TCG_CT_CONST_S5     0x1000
+#define TCG_CT_CONST_CMP_VI 0x2000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -391,9 +390,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if (ct & TCG_CT_CONST) {
         return 1;
     }
-    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return 1;
-    }
     if (type >= TCG_TYPE_V64) {
         /* Val is replicated by VECE; extract the highest element. */
         val >>= (-8 << vece) & 63;
@@ -2681,7 +2677,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_and_i32:
@@ -2707,7 +2703,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-        return C_O1_I2(r, rZ, rN);
+        return C_O1_I2(r, rz, rN);
 
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
@@ -2723,7 +2719,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
-        return C_O1_I2(r, rZ, rZ);
+        return C_O1_I2(r, rz, rz);
 
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -2745,7 +2741,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(rZ, rZ);
+        return C_O0_I2(rz, rz);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
@@ -2755,14 +2751,14 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, rZ, rZ, rM, rM);
+        return C_O2_I4(r, r, rz, rz, rM, rM);
 
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
-- 
2.43.0


