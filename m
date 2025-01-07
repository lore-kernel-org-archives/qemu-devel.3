Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92B6E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4dy-00060m-Sc; Tue, 07 Jan 2025 03:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4dp-0005qc-WF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:08:46 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4dl-0004ST-IR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:08:45 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21675fd60feso25312245ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237320; x=1736842120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3YSimvCItU+e7wKG8kzJ/WuszNFuOlkH9wW6NaFtjo=;
 b=EgdcTFhFx68QJbg1SXH9JAOa7LkQ+VkA9iJARExlN14xa00M8ExsF0Y1LayH5yvmla
 ccuRgxio6J6VUtQomkF9nmaoH1XgknldPtZ2XL+EB0WxXiJjQvPDJnvTnlnMJUrJzRPh
 teJXsR/yxLKPcd/VhzVBd1Us/SIZjAoim0FOxU7dNu4/1QKbEuZucWrXNLi/MrtCqyyx
 B7qQNufA4xDwxGLoK09F5o7MFtBblRynndBeEIZYIWH1cbkUnSYmlsfm6WBpfjd8r6JX
 52LQ9gRBtUx8CiFZeX3eId7Qm+/9LRiaYMwLBayra/dqJHrVXXsqBPqOIq17fXiOT5KJ
 g3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237320; x=1736842120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3YSimvCItU+e7wKG8kzJ/WuszNFuOlkH9wW6NaFtjo=;
 b=OKqNSQN7kZE5X+QjhhQikk54OFFi2fiMo+baiYpazVvqCsBiToKol+KgnREQRdBs8z
 9wIjc9Ix141Xl9hClMA999DZI7OoTplECJLAfBZ+nNtc8sWnFXTms3ChNr4wxbW8y/CN
 Ol8+TqzKbspQu2DHH4CBXS2gkL3CQMhXwuspdtI8NCgr0niRWl4qlRgfCtwEUJfVVEgD
 VUhXHraYCBDnPGzWJT9zVENLiGMxEM9q5VsNtUo2WraZMTjXNon8X9ADsThLuBUlQl0p
 8C0vFvno6nhSNme4uMrl7fMTn89YRiB0RT7y/hn/sigfj6yXzJFA0wD0NU9Y0kaLs/tI
 k/9g==
X-Gm-Message-State: AOJu0YwLMDDolW/xQtgaRxTW5/qx0DUqFGHf5liazSkiwCKbWbZwocOE
 NMINNoYR1c2pS0qKJ4uMi8MURsVd1m8u05Iy7Pdp30U/qGseomHWgK0Foc0CRL+srSfywCViied
 T
X-Gm-Gg: ASbGncuHmuYJUB18QHOUtaJuAST9UGqf3xOjaJ4GaXXYhwhVPSXakGdZsYXJ9x4Lud8
 6H3h7/pRXeY9h7Q/Ac02u8lw7YUX5Aq6/CxDYsMTbCk99eigbiXJmECLbDUlmjoVterXRbzM5gs
 cGpEO9MQKa5RDoHyOdzivzZcNhDZqpjNYC/Q9ROVeTdGRluIN1yzMsFQQXkKjmBQe/1qjiYUwH9
 GCyDJkMECIXqdVas0Uy2FCBeEL1HhNNjyhckEfXr0QRgkcGQqr6TK3Fb2/Cp9240177YAejPPL3
 IzN3RktuFp1gB7sEMQ==
X-Google-Smtp-Source: AGHT+IHpSegfs3ArjLV7xZEamwTLbqZeBbdHJisOFCEDuSrc+wEX52D+p+dXIjSkltbfT664FUQgJQ==
X-Received: by 2002:a05:6a21:3115:b0:1e1:aef4:9cd0 with SMTP id
 adf61e73a8af0-1e5e044e423mr93170437637.3.1736237320032; 
 Tue, 07 Jan 2025 00:08:40 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad816305sm32624205b3a.31.2025.01.07.00.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:08:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 80/81] tcg: Convert not to TCGOutOpUnary
Date: Tue,  7 Jan 2025 00:01:11 -0800
Message-ID: <20250107080112.1175095-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 tcg/aarch64/tcg-target-has.h     |  2 --
 tcg/arm/tcg-target-has.h         |  1 -
 tcg/i386/tcg-target-has.h        |  2 --
 tcg/loongarch64/tcg-target-has.h |  2 --
 tcg/mips/tcg-target-has.h        |  2 --
 tcg/ppc/tcg-target-has.h         |  2 --
 tcg/riscv/tcg-target-has.h       |  2 --
 tcg/s390x/tcg-target-has.h       |  2 --
 tcg/sparc64/tcg-target-has.h     |  2 --
 tcg/tcg-has.h                    |  1 -
 tcg/tci/tcg-target-has.h         |  2 --
 tcg/optimize.c                   |  4 ++--
 tcg/tcg-op.c                     | 10 ++++++----
 tcg/tcg.c                        |  8 ++++----
 tcg/tci.c                        |  2 --
 tcg/aarch64/tcg-target.c.inc     | 17 ++++++++++-------
 tcg/arm/tcg-target.c.inc         | 15 ++++++++++-----
 tcg/i386/tcg-target.c.inc        | 17 +++++++++++------
 tcg/loongarch64/tcg-target.c.inc | 17 ++++++++++-------
 tcg/mips/tcg-target.c.inc        | 20 ++++++++++----------
 tcg/ppc/tcg-target.c.inc         | 17 ++++++++++-------
 tcg/riscv/tcg-target.c.inc       | 17 ++++++++++-------
 tcg/s390x/tcg-target.c.inc       | 25 ++++++++++++++++---------
 tcg/sparc64/tcg-target.c.inc     | 20 ++++++++++----------
 tcg/tci/tcg-target.c.inc         | 13 ++++++++++---
 25 files changed, 119 insertions(+), 103 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 240fcac2cc..7f18727686 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -17,7 +17,6 @@
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
@@ -38,7 +37,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index e80711ee40..e766c6d628 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -26,7 +26,6 @@ extern bool use_neon_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index b27f853dcd..3d36fe58f2 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -30,7 +30,6 @@
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        have_popcnt
@@ -51,7 +50,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        have_popcnt
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 70bccdaa2e..529ff49b84 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -24,7 +24,6 @@
 #define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -43,7 +42,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 987f83f761..9d8e0fb8df 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -41,7 +41,6 @@ extern bool use_mips32r2_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muluh_i32        1
@@ -56,7 +55,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 6be6d7f994..7ebcb49a19 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -22,7 +22,6 @@
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i32        have_isa_2_06
@@ -44,7 +43,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          have_isa_3_00
 #define TCG_TARGET_HAS_ctpop_i64        have_isa_2_06
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 0c375e40bb..35030babbf 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -24,7 +24,6 @@
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
@@ -42,7 +41,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 374db3cf9d..e5c132cf12 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -33,7 +33,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_rot_i32        1
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
-#define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i32        0
 #define TCG_TARGET_HAS_ctz_i32        0
 #define TCG_TARGET_HAS_ctpop_i32      1
@@ -53,7 +52,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i64    1
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
-#define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_clz_i64        1
 #define TCG_TARGET_HAS_ctz_i64        0
 #define TCG_TARGET_HAS_ctpop_i64      1
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 35ae536879..df87249df2 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -19,7 +19,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_rot_i32          0
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_clz_i32          0
 #define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_ctpop_i32        0
@@ -40,7 +39,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 7de13ef383..a84ed1313a 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -19,7 +19,6 @@
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_not_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
 #define TCG_TARGET_HAS_ctz_i64          0
 #define TCG_TARGET_HAS_ctpop_i64        0
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 13c9dc3dfa..f147da5c0e 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -15,7 +15,6 @@
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        1
-#define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
@@ -34,7 +33,6 @@
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
-#define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_muls2_i64        1
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 63d36afe69..9af8f15235 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1089,11 +1089,11 @@ static bool fold_to_not(OptContext *ctx, TCGOp *op, int idx)
     switch (ctx->type) {
     case TCG_TYPE_I32:
         not_op = INDEX_op_not_i32;
-        have_not = TCG_TARGET_HAS_not_i32;
+        have_not = tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0);
         break;
     case TCG_TYPE_I64:
         not_op = INDEX_op_not_i64;
-        have_not = TCG_TARGET_HAS_not_i64;
+        have_not = tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0);
         break;
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cb2eb9ae52..e0f8ab28b8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -461,7 +461,8 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     /* Some cases can be optimized here.  */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
-    } else if (arg2 == -1 && TCG_TARGET_HAS_not_i32) {
+    } else if (arg2 == -1 &&
+               tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0)) {
         /* Don't recurse with tcg_gen_not_i32.  */
         tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg1);
     } else {
@@ -471,7 +472,7 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_not_i32) {
+    if (tcg_op_supported(INDEX_op_not_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg);
     } else {
         tcg_gen_xori_i32(ret, arg, -1);
@@ -1762,7 +1763,8 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* Some cases can be optimized here.  */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
-    } else if (arg2 == -1 && TCG_TARGET_HAS_not_i64) {
+    } else if (arg2 == -1 &&
+               tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0)) {
         /* Don't recurse with tcg_gen_not_i64.  */
         tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg1);
     } else {
@@ -2252,7 +2254,7 @@ void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_not_i32(TCGV_LOW(ret), TCGV_LOW(arg));
         tcg_gen_not_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
-    } else if (TCG_TARGET_HAS_not_i64) {
+    } else if (tcg_op_supported(INDEX_op_not_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg);
     } else {
         tcg_gen_xori_i64(ret, arg, -1);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e7e8232219..c1c91b3373 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1011,6 +1011,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
+    OUTOP(INDEX_op_not_i32, TCGOutOpUnary, outop_not),
+    OUTOP(INDEX_op_not_i64, TCGOutOpUnary, outop_not),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -2287,8 +2289,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap16_i32;
     case INDEX_op_bswap32_i32:
         return TCG_TARGET_HAS_bswap32_i32;
-    case INDEX_op_not_i32:
-        return TCG_TARGET_HAS_not_i32;
     case INDEX_op_clz_i32:
         return TCG_TARGET_HAS_clz_i32;
     case INDEX_op_ctz_i32:
@@ -2350,8 +2350,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_bswap32_i64;
     case INDEX_op_bswap64_i64:
         return TCG_TARGET_HAS_bswap64_i64;
-    case INDEX_op_not_i64:
-        return TCG_TARGET_HAS_not_i64;
     case INDEX_op_clz_i64:
         return TCG_TARGET_HAS_clz_i64;
     case INDEX_op_ctz_i64:
@@ -5456,6 +5454,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_neg:
+    case INDEX_op_not_i32:
+    case INDEX_op_not_i64:
         {
             const TCGOutOpUnary *out =
                 container_of(all_outop[op->opc], TCGOutOpUnary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index b091dde7c8..706932eef7 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -705,12 +705,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = bswap32(regs[r1]);
             break;
 #endif
-#if TCG_TARGET_HAS_not_i32 || TCG_TARGET_HAS_not_i64
         CASE_32_64(not)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ~regs[r1];
             break;
-#endif
 #if TCG_TARGET_REG_BITS == 64
             /* Load/store operations (64 bit). */
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 042773a6fc..dfdb0e3de7 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2245,6 +2245,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_orc(s, type, a0, TCG_REG_XZR, a1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2316,11 +2326,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, REG0(0), a1, a2, 3);
         break;
 
-    case INDEX_op_not_i64:
-    case INDEX_op_not_i32:
-        tcg_out_insn(s, 3510, ORN, ext, a0, TCG_REG_XZR, a1);
-        break;
-
     case INDEX_op_mul_i64:
     case INDEX_op_mul_i32:
         tcg_out_insn(s, 3509, MADD, ext, a0, a1, a2, TCG_REG_XZR);
@@ -3008,8 +3013,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap16_i64:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 6b6dc29ec9..6ec5dfcf80 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1987,6 +1987,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_MVN, a0, 0, a1, SHIFT_IMM_LSL(0));
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2076,10 +2086,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
-    case INDEX_op_not_i32:
-        tcg_out_dat_reg(s, COND_AL,
-                        ARITH_MVN, args[0], 0, args[1], SHIFT_IMM_LSL(0));
-        break;
     case INDEX_op_mul_i32:
         tcg_out_mul32(s, COND_AL, args[0], args[1], args[2]);
         break;
@@ -2277,7 +2283,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index af8463bfa0..e1e302c021 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2777,6 +2777,17 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, a0);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, 0),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2977,10 +2988,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(not):
-        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, a0);
-        break;
-
     case INDEX_op_qemu_ld_a64_i32:
         if (TCG_TARGET_REG_BITS == 32) {
             tcg_out_qemu_ld(s, a0, -1, a1, a2, args[3], TCG_TYPE_I32);
@@ -3822,8 +3829,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 257a5b122b..0eb7f44924 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1414,6 +1414,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_nor(s, type, a0, a1, TCG_REG_ZERO);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1449,11 +1459,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_srai_d(s, a0, a1, 32);
         break;
 
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
-        tcg_out_opc_nor(s, a0, a1, TCG_REG_ZERO);
-        break;
-
     case INDEX_op_extract_i32:
         if (a2 == 0 && args[3] <= 12) {
             tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
@@ -2286,8 +2291,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 9a72d3dbba..986c71a934 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1816,6 +1816,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_nor(s, type, a0, TCG_REG_ZERO, a1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2013,14 +2023,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_reg(s, OPC_MFHI, a1, 0, 0);
         break;
 
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
-        i1 = OPC_NOR;
-        goto do_unary;
-    do_unary:
-        tcg_out_opc_reg(s, i1, a0, TCG_REG_ZERO, a1);
-        break;
-
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
         tcg_out_bswap16(s, a0, a1, a2);
@@ -2253,7 +2255,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
@@ -2265,7 +2266,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i64:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index eecdbe96ff..bafaa69208 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3100,6 +3100,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_nor(s, type, a0, a1, a1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3272,11 +3282,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond2(s, args, const_args);
         break;
 
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
-        tcg_out32(s, NOR | SAB(args[1], args[0], args[1]));
-        break;
-
     case INDEX_op_shl_i64:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
@@ -4198,7 +4203,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_ctpop_i32:
-    case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
@@ -4211,7 +4215,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_ctpop_i64:
-    case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 2498d9169f..5c772e55d4 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2090,6 +2090,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_xori(s, type, a0, a1, -1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2153,11 +2163,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
-        tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
-        break;
-
     case INDEX_op_mul_i32:
         tcg_out_opc_reg(s, OPC_MULW, a0, a1, a2);
         break;
@@ -2663,7 +2668,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_not_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -2671,7 +2675,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 2e9306a65c..f811241ec9 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2387,6 +2387,22 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_nor(s, type, a0, a1, a1);
+}
+
+static TCGConstraintSetIndex cset_not(TCGType type, unsigned flags)
+{
+    return HAVE_FACILITY(MISC_INSN_EXT3) ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_not,
+    .out_rr = tgen_not,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2444,10 +2460,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_not_i32:
-        tcg_out_insn(s, RRFa, NORK, args[0], args[1], args[1]);
-        break;
-
     case INDEX_op_mul_i32:
         a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
         if (const_args[2]) {
@@ -2641,9 +2653,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_not_i64:
-        tcg_out_insn(s, RRFa, NOGRK, args[0], args[1], args[1]);
-        break;
     case INDEX_op_bswap64_i64:
         tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
         break;
@@ -3337,8 +3346,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 1724d31230..2897737054 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1416,6 +1416,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+     tgen_orc(s, type, a0, TCG_REG_G0, a1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1486,10 +1496,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         c = ARITH_UMUL;
         goto gen_arith;
 
-    OP_32_64(not):
-	c = ARITH_ORN;
-	goto gen_arith1;
-
     case INDEX_op_div_i32:
         tcg_out_div32(s, a0, a1, a2, c2, 0);
         break;
@@ -1607,10 +1613,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_arithc(s, a0, a1, a2, c2, c);
         break;
 
-    gen_arith1:
-	tcg_out_arithc(s, a0, TCG_REG_G0, a1, const_args[1], c);
-	break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -1653,8 +1655,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index bb9dcbb75d..b781a2c5dd 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -55,8 +55,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
@@ -761,6 +759,16 @@ static const TCGOutOpUnary outop_neg = {
     .out_rr = tgen_neg,
 };
 
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, glue(INDEX_op_not_i,TCG_TARGET_REG_BITS), a0, a1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -834,7 +842,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rl(s, opc, TCG_REG_TMP, arg_label(args[3]));
         break;
 
-    CASE_32_64(not)      /* Optional (TCG_TARGET_HAS_not_*). */
     CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
     case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap32_i32). */
     case INDEX_op_bswap64_i64: /* Optional (TCG_TARGET_HAS_bswap64_i64). */
-- 
2.43.0


