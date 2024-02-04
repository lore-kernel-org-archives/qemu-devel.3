Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF36C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEc-000216-1i; Sun, 04 Feb 2024 16:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEa-00020p-8e
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:04 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEY-0003Ug-K1
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:04 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d9bd8fa49eso664925ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082861; x=1707687661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vr5ZAc/RjPXfmKZRK62DlWwG7Va6xrXif7VnM9K+hHM=;
 b=Bsy/aPQEcr4pBLQG/x0WxXKTHkwRI1/q0jnghxEJnHDdlOYcsPJ6wHtYO/ZMRf0Jwl
 c8l14jz7bmKs/FoDn3Xj3ekBD6Uhl9z/Mnz6hreCiegKOXhojZkdnO6mA0G5eIuzu9GI
 +OIHhD80ikWXLk72Fq4Jq+b05+WqpgFLLo37daZFMlwxmebUpkTEvDW3n2dmYV4+F3S3
 Udvd7k8H/lYyxanUx4fXGR3yBYLoZw+Dsckh6Psc1aWlTN/T/qCuN1ZuWqVqKc7BYQth
 pxELiIO+WaBlmTcHtHbmmL0OEz7A7zmk488A00Q/L8kv8MbtWH6CHi1BdWxOdLFttcAs
 aYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082861; x=1707687661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vr5ZAc/RjPXfmKZRK62DlWwG7Va6xrXif7VnM9K+hHM=;
 b=DfHo3IRkcvWgFfoVjUsfMoPnb475c1LH4Ydr1+rmm7u/2WI+Z0d1i/hGWYzhMEjCXY
 su3cxaTO1UxID09e0HKuBgT/54+3FIYV3gG8vIkc7qCmGnJ1fO6FAQzn3NWX72qP2PgR
 jkoZskIEnzIquuQg0oAkCkxAXfQByaJrkZoO8df6reOHXw+h5XmNqibuw3I41DulxDuO
 aBk+J72nYBWLF/el7mw2p6TwiJ2zCDbkeWWyCcyuZFNvUllh7J3LV/XSq1gNlEjm5GBm
 E/gqTsGblIb6BJ1GG5pb1dkCVtqTiB8WyLU79QQVyQLoxTetvc6kY8WYTzzmx5xP0Dnf
 g0hw==
X-Gm-Message-State: AOJu0YwYu532eeIFHsjMqPSMcbj9nAcJZ6H1REKcc6cp5RSFFPlSf3mA
 +Q5KGzYMfbskcVH548PwzuPTWGtydjDSV/716mp1x9kY6JzFCtoVJHaSW0Gb+aXaM9KWVXeH/0B
 ppfg=
X-Google-Smtp-Source: AGHT+IEGiZYWKuTZhpW2ri0TdffIZYuVtwHFX8Axhnsm9C89hQVHN6sVdArdKkGDNieb/5vvibvd/g==
X-Received: by 2002:a17:903:120c:b0:1d7:35ba:6a39 with SMTP id
 l12-20020a170903120c00b001d735ba6a39mr7574018plh.69.1707082861092; 
 Sun, 04 Feb 2024 13:41:01 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/39] tcg: Introduce TCG_TARGET_HAS_tst
Date: Mon,  5 Feb 2024 07:40:15 +1000
Message-Id: <20240204214052.5639-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Define as 0 for all tcg backends.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     | 2 ++
 tcg/arm/tcg-target.h         | 2 ++
 tcg/i386/tcg-target.h        | 2 ++
 tcg/loongarch64/tcg-target.h | 2 ++
 tcg/mips/tcg-target.h        | 2 ++
 tcg/ppc/tcg-target.h         | 2 ++
 tcg/riscv/tcg-target.h       | 2 ++
 tcg/s390x/tcg-target.h       | 2 ++
 tcg/sparc64/tcg-target.h     | 2 ++
 tcg/tci/tcg-target.h         | 2 ++
 10 files changed, 20 insertions(+)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 33f15a564a..b4ac13be7b 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -138,6 +138,8 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_ldst_i128   1
 #endif
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_TARGET_HAS_v64              1
 #define TCG_TARGET_HAS_v128             1
 #define TCG_TARGET_HAS_v256             0
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index a712cc80ad..7bf42045a7 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -125,6 +125,8 @@ extern bool use_neon_instructions;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_TARGET_HAS_v64              use_neon_instructions
 #define TCG_TARGET_HAS_v128             use_neon_instructions
 #define TCG_TARGET_HAS_v256             0
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index fa34deec47..1dd917a680 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -198,6 +198,8 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_ldst_i128 \
     (TCG_TARGET_REG_BITS == 64 && (cpuinfo & CPUINFO_ATOMIC_VMOVDQA))
 
+#define TCG_TARGET_HAS_tst              0
+
 /* We do not support older SSE systems, only beginning with AVX1.  */
 #define TCG_TARGET_HAS_v64              have_avx1
 #define TCG_TARGET_HAS_v128             have_avx1
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 9c70ebfefc..fede627bf7 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -169,6 +169,8 @@ typedef enum {
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_TARGET_HAS_v64              0
 #define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
 #define TCG_TARGET_HAS_v256             0
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index b98ffae1d0..a996aa171d 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -194,6 +194,8 @@ extern bool use_mips32r2_instructions;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_TARGET_DEFAULT_MO           0
 #define TCG_TARGET_NEED_LDST_LABELS
 #define TCG_TARGET_NEED_POOL_LABELS
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 5295e4f9ab..60ce49e672 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -143,6 +143,8 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
     (TCG_TARGET_REG_BITS == 64 && have_isa_2_07)
 
+#define TCG_TARGET_HAS_tst              0
+
 /*
  * While technically Altivec could support V64, it has no 64-bit store
  * instruction and substituting two 32-bit stores makes the generated
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index a4edc3dc74..2c1b680b93 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -158,6 +158,8 @@ extern bool have_zbb;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index e69b0d2ddd..53bed8c8d2 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -138,6 +138,8 @@ extern uint64_t s390_facilities[3];
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
+#define TCG_TARGET_HAS_tst            0
+
 #define TCG_TARGET_HAS_v64            HAVE_FACILITY(VECTOR)
 #define TCG_TARGET_HAS_v128           HAVE_FACILITY(VECTOR)
 #define TCG_TARGET_HAS_v256           0
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index f8cf145266..ae2910c4ee 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -149,6 +149,8 @@ extern bool use_vis3_instructions;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
+#define TCG_TARGET_HAS_tst              0
+
 #define TCG_AREG0 TCG_REG_I0
 
 #define TCG_TARGET_DEFAULT_MO (0)
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 2a13816c8e..609b2f4e4a 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -117,6 +117,8 @@
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
+#define TCG_TARGET_HAS_tst              0
+
 /* Number of registers available. */
 #define TCG_TARGET_NB_REGS 16
 
-- 
2.34.1


