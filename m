Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9028DE77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfC-0001mi-5X; Thu, 02 Jan 2025 13:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeU-0007Hz-Dl
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:39 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeR-0006DA-TK
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:34 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2165448243fso190618415ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841430; x=1736446230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HDLZXsAdmo9m0KKacKu7Kr7VxFtJzXPj6PSwC+Mq3mU=;
 b=djkPbAiwcHMDnfSwerrrMIGVARixsibJASB+wfjD++6vWduPo8bz2iN3OqbrjL3S0B
 uslER25x9NG6a6474QI4kM1+zPMfnpuo810YzsR9FM4vMJoO+8TRLtVhP3dx1mS0lNUC
 E2bkZxjzVIR+hPC3gosOyr2JFY+fB8sB+vcDmRUT9+OZGuplnKDhVRaRaz+pjcJ05nLX
 XeYiSdTrnRLmnlgx4+d0jr4WJBcRw2VpKP35mj8kKYLLH27sUb7A14zYLZQ2vWSGY36O
 iwegKSnKIO/TSGW3G4GoV+SearencSLggIV5VC7TyW9+Nv+78j0xnqZXBkYya8spBt3n
 PHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841430; x=1736446230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HDLZXsAdmo9m0KKacKu7Kr7VxFtJzXPj6PSwC+Mq3mU=;
 b=JqlNW6CvbXFXoT5GN52WKU4MRIC7ArGVFz+4ndC4dGwzxskIxnMTOujTFDdmHJmfMU
 ujjXHT8GmPkv80HSh1FZyYessZieCPlBZTIRv/TX4pgz7aGAw3DcYB8d6Cno2cHjrypX
 x9JNRHO5VkpuO9OVtft4ty++Yu09Y7XV4tck4UXIsMLdonxt2tdY8syTBofBznwZq68a
 xnSIy4vBVK6SorhFEpf/mZlSCMg342TmyeSsd1QGV58K5dAfF52MkR6zijEkRZbvOiKq
 SY9O4ad8GSKk6aTCROk/Mid1nQnxDZOhT9FcVTeXoTg5JVdsBK6q9/YQ7hzCpL8la8nR
 de7A==
X-Gm-Message-State: AOJu0YyLAxQRxXXRih1Bnvj6tpaMeTuDjv9hLfLzrnX6liRwDAOx39Xw
 uk4Myx7q0bD509ABLLyWzQ6ov9fIT13NVgEdUdXgT+LIqPBM/t+37D5Ftw2DcRKfvbt9+w0uDRA
 f
X-Gm-Gg: ASbGncvOsf83bL3nmLnKEx38Cf6ynHfp+E1MVWIfZKs+6udgQgtq3J+aA5U0t0AmJ7b
 hgpMJ4FN3Omb9NSX+MEzXrTrvXfXfGjQODZKS5L9BCHbYM6EK5OxdLks9zhD23ujDBUi/QSV6HM
 eIDm5t71M3MJybk2lfOX4CWucRE93619h09ZMzgCfpKv4/P/TPzjiJN2+ZpzZILiBLenCh9PXHB
 Asx1rlhcjibqhcB/IaeUtqHCDcYJNwFWWQSsHPmsma7SFjctf7eyu6VI8lecw==
X-Google-Smtp-Source: AGHT+IHjRie296y0wRVxjKtd7ektfDnDEdiJJMqvmfh4SpElRDe6RlwMfBSkdfd2lFR4Jzt4I+ZMeQ==
X-Received: by 2002:a05:6a20:2d1f:b0:1e1:b1e4:e750 with SMTP id
 adf61e73a8af0-1e5e04717a2mr68842327637.18.1735841430233; 
 Thu, 02 Jan 2025 10:10:30 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 45/73] tcg: Remove TCG_TARGET_HAS_deposit_{i32,i64}
Date: Thu,  2 Jan 2025 10:06:25 -0800
Message-ID: <20250102180654.1420056-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Make extract and sextract "unconditional" in the sense
that the opcodes are always present.  Rely instead on
TCG_TARGET_deposit_valid, now always defined.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  4 ++--
 tcg/aarch64/tcg-target-has.h     |  3 +--
 tcg/arm/tcg-target-has.h         |  2 +-
 tcg/i386/tcg-target-has.h        |  5 +----
 tcg/loongarch64/tcg-target-has.h |  3 +--
 tcg/mips/tcg-target-has.h        |  3 +--
 tcg/ppc/tcg-target-has.h         |  3 +--
 tcg/riscv/tcg-target-has.h       |  4 ++--
 tcg/s390x/tcg-target-has.h       |  3 +--
 tcg/sparc64/tcg-target-has.h     |  4 ++--
 tcg/tcg-has.h                    |  8 --------
 tcg/tci/tcg-target-has.h         |  3 +--
 tcg/tcg-op.c                     | 22 +++++++++++-----------
 tcg/tcg.c                        | 30 ++++++++++--------------------
 tcg/tci.c                        |  4 ----
 15 files changed, 35 insertions(+), 66 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 29ded40bb6..d685b6915e 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -76,7 +76,7 @@ DEF(shr_i32, 1, 2, 0, 0)
 DEF(sar_i32, 1, 2, 0, 0)
 DEF(rotl_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I32)))
 DEF(rotr_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I32)))
-DEF(deposit_i32, 1, 2, 2, IMPL(TCG_TARGET_HAS_deposit_i32))
+DEF(deposit_i32, 1, 2, 2, 0)
 DEF(extract_i32, 1, 1, 2, 0)
 DEF(sextract_i32, 1, 1, 2, 0)
 DEF(extract2_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_extract2_i32))
@@ -145,7 +145,7 @@ DEF(shr_i64, 1, 2, 0, IMPL64)
 DEF(sar_i64, 1, 2, 0, IMPL64)
 DEF(rotl_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I64)))
 DEF(rotr_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_rot(TCG_TYPE_I64)))
-DEF(deposit_i64, 1, 2, 2, IMPL64 | IMPL(TCG_TARGET_HAS_deposit_i64))
+DEF(deposit_i64, 1, 2, 2, IMPL64)
 DEF(extract_i64, 1, 1, 2, IMPL64)
 DEF(sextract_i64, 1, 1, 2, IMPL64)
 DEF(extract2_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_extract2_i64))
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 8d3424e4d8..e71a0ff060 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -40,7 +40,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -51,7 +50,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
 
 /*
@@ -88,5 +86,6 @@
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
 #endif
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index f06ba539d6..761ec1bf08 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -51,7 +51,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        0 /* and r0, r1, #0xff */
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -94,5 +93,6 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 
 #define TCG_TARGET_extract_valid   tcg_target_extract_valid
 #define TCG_TARGET_sextract_valid  tcg_target_extract_valid
+#define TCG_TARGET_deposit_valid(type, ofs, len)  use_armv7_instructions
 
 #endif
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 5f90527e4b..cad82fa162 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -52,7 +52,6 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract2_i32     1
 
 #if TCG_TARGET_REG_BITS == 64
@@ -64,7 +63,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
@@ -96,10 +94,9 @@
 #define TCG_TARGET_HAS_cmpsel_vec       1
 #define TCG_TARGET_HAS_tst_vec          have_avx512bw
 
-#define TCG_TARGET_deposit_i32_valid(ofs, len) \
+#define TCG_TARGET_deposit_valid(type, ofs, len) \
     (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
      (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
-#define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
 
 /*
  * Check for the possibility of low byte/word extraction, high-byte extraction
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 45382ecf94..5f2084b6d1 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -33,7 +33,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
@@ -44,7 +43,6 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
-#define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
@@ -78,6 +76,7 @@
 #define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
 static inline bool
 tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 718d71a972..915c8719d2 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -70,14 +70,12 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
@@ -96,6 +94,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_tst              0
 
 #define TCG_TARGET_extract_valid(type, ofs, len)  use_mips32r2_instructions
+#define TCG_TARGET_deposit_valid(type, ofs, len)  use_mips32r2_instructions
 
 static inline bool
 tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index bee5b6b588..5543386980 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -46,7 +46,6 @@
 
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -58,7 +57,6 @@
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #endif
 
@@ -92,6 +90,7 @@
 #define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
 static inline bool
 tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index d27f6ee8e0..2ecf2bd971 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -33,7 +33,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
 
-#define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        1
 #define TCG_TARGET_HAS_ext16s_i32       1
@@ -43,7 +42,6 @@
 #define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
@@ -98,4 +96,6 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
+#define TCG_TARGET_deposit_valid(type, ofs, len)  0
+
 #endif
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 20d2b90fdd..6f6dc28fc7 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -55,7 +55,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext16s_i32     1
 #define TCG_TARGET_HAS_ext8u_i32      1
 #define TCG_TARGET_HAS_ext16u_i32     1
-#define TCG_TARGET_HAS_deposit_i32    1
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
@@ -66,7 +65,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext8u_i64      1
 #define TCG_TARGET_HAS_ext16u_i64     1
 #define TCG_TARGET_HAS_ext32u_i64     1
-#define TCG_TARGET_HAS_deposit_i64    1
 #define TCG_TARGET_HAS_extract2_i64   0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
@@ -93,6 +91,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_tst_vec        0
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
 static inline bool
 tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 616744d57a..2edbd5802f 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -41,7 +41,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext16s_i32       0
 #define TCG_TARGET_HAS_ext8u_i32        0
 #define TCG_TARGET_HAS_ext16u_i32       0
-#define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
@@ -52,7 +51,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
@@ -64,4 +62,6 @@ extern bool use_vis3_instructions;
 
 #define TCG_TARGET_sextract_valid  TCG_TARGET_extract_valid
 
+#define TCG_TARGET_deposit_valid(type, ofs, len) 0
+
 #endif
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index b4e5c98041..55852ef309 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -18,17 +18,9 @@
 #define TCG_TARGET_HAS_ext8u_i64        0
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract2_i64     0
 #endif
 
-#ifndef TCG_TARGET_deposit_i32_valid
-#define TCG_TARGET_deposit_i32_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_deposit_i64_valid
-#define TCG_TARGET_deposit_i64_valid(ofs, len) 1
-#endif
-
 /* Only one of DIV or DIV2 should be defined.  */
 #if defined(TCG_TARGET_HAS_div)
 #define TCG_TARGET_HAS_div2(T)          0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index f093547726..5d85e0d96e 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -35,13 +35,11 @@
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
@@ -57,5 +55,6 @@
 
 #define TCG_TARGET_extract_valid(type, ofs, len)   1
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
 #endif
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fab3e67e77..6536afb9e5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -904,7 +904,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
         tcg_gen_mov_i32(ret, arg2);
         return;
     }
-    if (TCG_TARGET_HAS_deposit_i32 && TCG_TARGET_deposit_i32_valid(ofs, len)) {
+    if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
         tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, arg1, arg2, ofs, len);
         return;
     }
@@ -949,8 +949,7 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_shli_i32(ret, arg, ofs);
     } else if (ofs == 0) {
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-    } else if (TCG_TARGET_HAS_deposit_i32
-               && TCG_TARGET_deposit_i32_valid(ofs, len)) {
+    } else if (TCG_TARGET_deposit_valid(TCG_TYPE_I32, ofs, len)) {
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
     } else {
@@ -2679,12 +2678,13 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
         tcg_gen_mov_i64(ret, arg2);
         return;
     }
-    if (TCG_TARGET_HAS_deposit_i64 && TCG_TARGET_deposit_i64_valid(ofs, len)) {
-        tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, arg1, arg2, ofs, len);
-        return;
-    }
 
-    if (TCG_TARGET_REG_BITS == 32) {
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
+            tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, arg1, arg2, ofs, len);
+            return;
+        }
+    } else {
         if (ofs >= 32) {
             tcg_gen_deposit_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1),
                                 TCGV_LOW(arg2), ofs - 32, len);
@@ -2739,8 +2739,8 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_shli_i64(ret, arg, ofs);
     } else if (ofs == 0) {
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else if (TCG_TARGET_HAS_deposit_i64
-               && TCG_TARGET_deposit_i64_valid(ofs, len)) {
+    } else if (TCG_TARGET_REG_BITS == 64 &&
+               TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
         TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, zero, arg, ofs, len);
     } else {
@@ -3280,7 +3280,7 @@ void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high)
     tcg_gen_extu_i32_i64(dest, low);
     /* If deposit is available, use it.  Otherwise use the extra
        knowledge that we have of the zero-extensions above.  */
-    if (TCG_TARGET_HAS_deposit_i64 && TCG_TARGET_deposit_i64_valid(32, 32)) {
+    if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, 32, 32)) {
         tcg_gen_deposit_i64(dest, dest, tmp, 32, 32);
     } else {
         tcg_gen_shli_i64(tmp, tmp, 32);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4e5dbedd3d..3c1a253889 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2208,6 +2208,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sar_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
+    case INDEX_op_deposit_i32:
         return true;
 
     case INDEX_op_negsetcond_i32:
@@ -2224,8 +2225,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
         return TCG_TARGET_HAS_rot(TCG_TYPE_I32);
-    case INDEX_op_deposit_i32:
-        return TCG_TARGET_HAS_deposit_i32;
     case INDEX_op_extract2_i32:
         return TCG_TARGET_HAS_extract2_i32;
     case INDEX_op_add2_i32:
@@ -2303,6 +2302,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i64:
+    case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
     case INDEX_op_negsetcond_i64:
@@ -2319,8 +2319,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_rot(TCG_TYPE_I64);
-    case INDEX_op_deposit_i64:
-        return TCG_TARGET_HAS_deposit_i64;
     case INDEX_op_extract2_i64:
         return TCG_TARGET_HAS_extract2_i64;
     case INDEX_op_extrl_i64_i32:
@@ -2447,24 +2445,16 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
 
 bool tcg_op_deposit_valid(TCGType type, unsigned ofs, unsigned len)
 {
-    switch (type) {
-    case TCG_TYPE_I32:
-        tcg_debug_assert(ofs < 32);
-        tcg_debug_assert(len > 0);
-        tcg_debug_assert(len <= 32);
-        tcg_debug_assert(ofs + len <= 32);
-        return TCG_TARGET_HAS_deposit_i32 && TCG_TARGET_deposit_i32_valid(ofs, len);
+    unsigned width;
 
-    case TCG_TYPE_I64:
-        tcg_debug_assert(ofs < 64);
-        tcg_debug_assert(len > 0);
-        tcg_debug_assert(len <= 64);
-        tcg_debug_assert(ofs + len <= 64);
-        return TCG_TARGET_HAS_deposit_i64 && TCG_TARGET_deposit_i64_valid(ofs, len);
+    tcg_debug_assert(type == TCG_TYPE_I32 || type == TCG_TYPE_I64);
+    width = (type == TCG_TYPE_I32 ? 32 : 64);
 
-    default:
-        g_assert_not_reached();
-    }
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width - ofs);
+
+    return TCG_TARGET_deposit_valid(type, ofs, len);
 }
 
 static TCGOp *tcg_op_alloc(TCGOpcode opc, TCGType type, unsigned nargs);
diff --git a/tcg/tci.c b/tcg/tci.c
index 8a02a7fff7..9898551026 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -633,12 +633,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ror32(regs[r1], regs[r2] & 31);
             break;
-#if TCG_TARGET_HAS_deposit_i32
         case INDEX_op_deposit_i32:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit32(regs[r1], pos, len, regs[r2]);
             break;
-#endif
         case INDEX_op_extract_i32:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = extract32(regs[r1], pos, len);
@@ -807,12 +805,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ror64(regs[r1], regs[r2] & 63);
             break;
-#if TCG_TARGET_HAS_deposit_i64
         case INDEX_op_deposit_i64:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
             break;
-#endif
         case INDEX_op_extract_i64:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = extract64(regs[r1], pos, len);
-- 
2.43.0


