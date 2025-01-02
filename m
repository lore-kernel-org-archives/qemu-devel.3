Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A614DE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPf0-0000Me-Fj; Thu, 02 Jan 2025 13:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeU-0007I0-RD
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:39 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeS-0006DG-Co
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:34 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21683192bf9so158344035ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841431; x=1736446231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XsQjJKm9t5XMW6dnmtqonvJ2OOBJnNfmcPb8rE/qOV4=;
 b=yCmZzw7dMvN5ipIOYcAwm17XZf3VshIqfX2DZW3ZkAqa6MYwpy/gisYQx8MGFldC6e
 SKF+v2QdFi6VLT9Wa9ek/7hcXqPfjyZenZfakAPOxCZt2Zm2TrKwxBjnyOq2udSyVF17
 gZFLdGVY5c6CmC63H2cdh95ALT5UaHHdmCG9SsiyKVoTK1ccWtglHxaj8kSJtISbv+Hj
 F6NfwIS9htAVT4Sin9KlEsr8ZxrlL4EODDXG+U3M06RxCFViBlD9Ydoc1P0oZRW6XRVs
 oUL5t7+v350TnL5yOx7LEoGZx11GJxbNRyfL5FMSjpkoXxR7rRs2TG3CWKWrDiHQZ3gx
 /+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841431; x=1736446231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsQjJKm9t5XMW6dnmtqonvJ2OOBJnNfmcPb8rE/qOV4=;
 b=SUkFFd0s4WBZ2AaNOgbuD1eZpOV7xX79+94FsPmqEtPOZZgBeIqzrqI2ZxlgjjdC5U
 /Ogq2NVd4QdnRuPkQqNkbcC/rLce8/MUOTAv1evyNNB820/FfPlrgphN7PBdLQTyoFiH
 PA++dRsBq6Lsvfi3GwNGGC/Sf5MJpGSBrHUuPHadKJxam6pwRCtpXPpinGVOxR6cV9Z/
 BeLL/H3wkikPvi61NGb/51a9RUV9hYXTHhE55zLkdH96ss3+AhRzhUjoopFvYtRG3adf
 XLaigJq4mhfh+Y7WiFr5z/cDm/5KraTYEfhct7hvxD+sjQc3judWlmr7uVSwQTbV1ITE
 n0cA==
X-Gm-Message-State: AOJu0YzXQcMiSNqRWT6kFeqj/3BaBTimfRxqJ1yLE5x1BMh7ypQ0IKyC
 Z3imq1ASzMLedBmNB+No6+BwDCyeSgTDpLPJOh5EFo1rMwrfltiL+no9vPq/86F2Jdm/Yqn50nY
 B
X-Gm-Gg: ASbGnctKrfS0MhGtwTuz5xp6GGtprRGkumWJrFjgkz5GtYVHM2a9PbSdLpATQi/yYKA
 +8ckpCanTcaK1SMew/goR/WF9GyHwOtW9attPWO/FBl+jsDwQEA1D6K0iZ8nP3c4DLeO5uHbqS9
 VZppLTOKkyZCKVoIk9Lc4y5bXzG/xnzGBwbkd4wUq1woSoe3n5tO9UwoWKGuGVud1NHK9S6ujje
 BobF3t0/z6kdQuO+0SGmJfpkQWGh6rtlxEVXtOh5gEIdUIanxzwXxcc3wsGqg==
X-Google-Smtp-Source: AGHT+IHLl6APn9Xwb2ncDh4s5gXa4WSesCRPAh7YNyFD5ZIYAguBY2dnUt/MGckBItrgIb0nRKm+vg==
X-Received: by 2002:a05:6a00:130e:b0:729:643:744f with SMTP id
 d2e1a72fcca58-72abe18bcf4mr68112614b3a.25.1735841430944; 
 Thu, 02 Jan 2025 10:10:30 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 46/73] tcg: Merge TCG_TARGET_HAS_extract2_{i32,i64}
Date: Thu,  2 Jan 2025 10:06:26 -0800
Message-ID: <20250102180654.1420056-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-opc.h            |  4 ++--
 tcg/aarch64/tcg-target-has.h     |  3 +--
 tcg/arm/tcg-target-has.h         |  2 +-
 tcg/i386/tcg-target-has.h        |  3 +--
 tcg/loongarch64/tcg-target-has.h |  3 +--
 tcg/mips/tcg-target-has.h        |  2 --
 tcg/ppc/tcg-target-has.h         |  3 +--
 tcg/riscv/tcg-target-has.h       |  3 +--
 tcg/s390x/tcg-target-has.h       |  3 +--
 tcg/sparc64/tcg-target-has.h     |  3 +--
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  3 +--
 tcg/tcg-op.c                     | 38 ++++++++++++++++----------------
 tcg/tcg.c                        |  4 ++--
 14 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index d685b6915e..6082549322 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -79,7 +79,7 @@ DEF(rotr_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I32)))
 DEF(deposit_i32, 1, 2, 2, 0)
 DEF(extract_i32, 1, 1, 2, 0)
 DEF(sextract_i32, 1, 1, 2, 0)
-DEF(extract2_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_extract2_i32))
+DEF(extract2_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_extract2(TCG_TYPE_I32)))
 
 DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 
@@ -148,7 +148,7 @@ DEF(rotr_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I64)))
 DEF(deposit_i64, 1, 2, 2, IMPL64)
 DEF(extract_i64, 1, 1, 2, IMPL64)
 DEF(sextract_i64, 1, 1, 2, IMPL64)
-DEF(extract2_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_extract2_i64))
+DEF(extract2_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_extract2(TCG_TYPE_I64)))
 
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, IMPL64)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index e71a0ff060..2bcfed2761 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -27,6 +27,7 @@
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          1
+#define TCG_TARGET_HAS_extract2(T)      1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -40,7 +41,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -50,7 +50,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_extract2_i64     1
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 761ec1bf08..6489a20662 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -38,6 +38,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_rem(T)           0
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          1
+#define TCG_TARGET_HAS_extract2(T)      1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -51,7 +52,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index cad82fa162..e2a3513102 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -39,6 +39,7 @@
 #define TCG_TARGET_HAS_negsetcond(T)    1
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          1
+#define TCG_TARGET_HAS_extract2(T)      1
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          (T >= TCG_TYPE_V64 || have_bmi1)
@@ -52,7 +53,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_extract2_i32     1
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
@@ -63,7 +63,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 5f2084b6d1..c1a37cb524 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -24,6 +24,7 @@
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          0
+#define TCG_TARGET_HAS_extract2(T)      0
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -33,7 +34,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
@@ -43,7 +43,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
-#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 915c8719d2..658748110d 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -70,13 +70,11 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
 #endif
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 5543386980..42fcccbb0c 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -31,6 +31,7 @@
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          (T == TCG_TYPE_REG)
+#define TCG_TARGET_HAS_extract2(T)      0
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -46,7 +47,6 @@
 
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -57,7 +57,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_extract2_i64     0
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 2ecf2bd971..d5530dc0d6 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -24,6 +24,7 @@
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_sub2(T)          1
+#define TCG_TARGET_HAS_extract2(T)      0
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
@@ -33,7 +34,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
 
-#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
@@ -42,7 +42,6 @@
 #define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 6f6dc28fc7..c01a782f80 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -42,6 +42,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_negsetcond(T)  1
 #define TCG_TARGET_HAS_rot(T)         1
 #define TCG_TARGET_HAS_sub2(T)        1
+#define TCG_TARGET_HAS_extract2(T)    0
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)        (T >= TCG_TYPE_V64 || HAVE_FACILITY(MISC_INSN_EXT3))
@@ -55,7 +56,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext16s_i32     1
 #define TCG_TARGET_HAS_ext8u_i32      1
 #define TCG_TARGET_HAS_ext16u_i32     1
-#define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
@@ -65,7 +65,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext8u_i64      1
 #define TCG_TARGET_HAS_ext16u_i64     1
 #define TCG_TARGET_HAS_ext32u_i64     1
-#define TCG_TARGET_HAS_extract2_i64   0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 2edbd5802f..747ed1ab8f 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -28,6 +28,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_rem(T)           0
 #define TCG_TARGET_HAS_rot(T)           0
 #define TCG_TARGET_HAS_sub2(T)          1
+#define TCG_TARGET_HAS_extract2(T)      0
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -41,7 +42,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext16s_i32       0
 #define TCG_TARGET_HAS_ext8u_i32        0
 #define TCG_TARGET_HAS_ext16u_i32       0
-#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
@@ -51,7 +51,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_extract2_i64     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 55852ef309..5649d36961 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -18,7 +18,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_extract2_i64     0
 #endif
 
 /* Only one of DIV or DIV2 should be defined.  */
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 5d85e0d96e..ffe2b0ef27 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -22,6 +22,7 @@
 #define TCG_TARGET_HAS_rem(T)           1
 #define TCG_TARGET_HAS_rot(T)           1
 #define TCG_TARGET_HAS_sub2(T)          1
+#define TCG_TARGET_HAS_extract2(T)      0
 
 /* optional integer and vector instructions */
 #define TCG_TARGET_HAS_andc(T)          1
@@ -35,12 +36,10 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6536afb9e5..9af6f326b6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -911,7 +911,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
 
     t1 = tcg_temp_ebb_new_i32();
 
-    if (TCG_TARGET_HAS_extract2_i32) {
+    if (TCG_TARGET_HAS_extract2(TCG_TYPE_I32)) {
         if (ofs + len == 32) {
             tcg_gen_shli_i32(t1, arg1, len);
             tcg_gen_extract2_i32(ret, t1, arg2, len);
@@ -1130,7 +1130,7 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
         tcg_gen_mov_i32(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i32(ret, al, ofs);
-    } else if (TCG_TARGET_HAS_extract2_i32) {
+    } else if (TCG_TARGET_HAS_extract2(TCG_TYPE_I32)) {
         tcg_gen_op4i_i32(INDEX_op_extract2_i32, ret, al, ah, ofs);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -1873,7 +1873,7 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_movi_i32(TCGV_LOW(ret), 0);
         }
     } else if (right) {
-        if (TCG_TARGET_HAS_extract2_i32) {
+        if (TCG_TARGET_HAS_extract2(TCG_TYPE_I32)) {
             tcg_gen_extract2_i32(TCGV_LOW(ret),
                                  TCGV_LOW(arg1), TCGV_HIGH(arg1), c);
         } else {
@@ -1887,7 +1887,7 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         }
     } else {
-        if (TCG_TARGET_HAS_extract2_i32) {
+        if (TCG_TARGET_HAS_extract2(TCG_TYPE_I32)) {
             tcg_gen_extract2_i32(TCGV_HIGH(ret),
                                  TCGV_LOW(arg1), TCGV_HIGH(arg1), 32 - c);
         } else {
@@ -2684,6 +2684,20 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
             tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, arg1, arg2, ofs, len);
             return;
         }
+        if (TCG_TARGET_HAS_extract2(TCG_TYPE_I64)) {
+            if (ofs == 0 && TCG_TARGET_HAS_rot(TCG_TYPE_I64)) {
+                tcg_gen_extract2_i64(ret, arg1, arg2, len);
+                tcg_gen_rotli_i64(ret, ret, len);
+                return;
+            }
+            if (ofs + len == 64) {
+                t1 = tcg_temp_ebb_new_i64();
+                tcg_gen_shli_i64(t1, arg1, len);
+                tcg_gen_extract2_i64(ret, t1, arg2, len);
+                tcg_temp_free_i64(t1);
+                return;
+            }
+        }
     } else {
         if (ofs >= 32) {
             tcg_gen_deposit_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1),
@@ -2701,19 +2715,6 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 
     t1 = tcg_temp_ebb_new_i64();
 
-    if (TCG_TARGET_HAS_extract2_i64) {
-        if (ofs + len == 64) {
-            tcg_gen_shli_i64(t1, arg1, len);
-            tcg_gen_extract2_i64(ret, t1, arg2, len);
-            goto done;
-        }
-        if (ofs == 0) {
-            tcg_gen_extract2_i64(ret, arg1, arg2, len);
-            tcg_gen_rotli_i64(ret, ret, len);
-            goto done;
-        }
-    }
-
     mask = (1ull << len) - 1;
     if (ofs + len < 64) {
         tcg_gen_andi_i64(t1, arg2, mask);
@@ -2723,7 +2724,6 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
     }
     tcg_gen_andi_i64(ret, arg1, ~(mask << ofs));
     tcg_gen_or_i64(ret, ret, t1);
- done:
     tcg_temp_free_i64(t1);
 }
 
@@ -3021,7 +3021,7 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
         tcg_gen_mov_i64(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i64(ret, al, ofs);
-    } else if (TCG_TARGET_HAS_extract2_i64) {
+    } else if (TCG_TARGET_HAS_extract2(TCG_TYPE_I64)) {
         tcg_gen_op4i_i64(INDEX_op_extract2_i64, ret, al, ah, ofs);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3c1a253889..5b2ea74f12 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2226,7 +2226,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_rotr_i32:
         return TCG_TARGET_HAS_rot(TCG_TYPE_I32);
     case INDEX_op_extract2_i32:
-        return TCG_TARGET_HAS_extract2_i32;
+        return TCG_TARGET_HAS_extract2(TCG_TYPE_I32);
     case INDEX_op_add2_i32:
         return TCG_TARGET_HAS_add2(TCG_TYPE_I32);
     case INDEX_op_sub2_i32:
@@ -2320,7 +2320,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_rotr_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_rot(TCG_TYPE_I64);
     case INDEX_op_extract2_i64:
-        return TCG_TARGET_HAS_extract2_i64;
+        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_extract2(TCG_TYPE_I64);
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return TCG_TARGET_HAS_extr_i64_i32;
-- 
2.43.0


