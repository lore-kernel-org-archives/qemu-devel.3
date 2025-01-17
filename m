Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F63C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5h-0005Cp-Ep; Fri, 17 Jan 2025 13:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5a-0004th-MP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:03 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5Z-0000Do-3u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:02 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso3302762a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138539; x=1737743339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeoxNnJvMgFI3q4piiiduYU8RMXHoVGq3FrMzVqgkyQ=;
 b=xegajlZ4Y7RdAIVY7r3vpR1gj167f/fztGcHm+eiqQZKPqvmC30NB8p92eq05+auCH
 qkVjSUOlUNFvebuehNp/wlQKXZ6KAykBMWW1H68dD0SBvHWupBME6J2mAhclJ8PBk8WO
 Y6sstZNzugb5q45qiNLh79TmCibKjz/OZEPNogg61fMwFAP1P0TFLYGluFasz3JlpDMf
 RSw9E2feIxJT1eovjyeUUlR3hsZ4CTqFqBpmPyfvx4gjWQjudslXDZtUPjNGF8ViPdKU
 +j8b+3mYW+tH6zrz0vRBewGCdm7n3ceBIKpPsDp3OW6sLuyWBKWSz2aJmcaGP1O0XVe4
 KUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138539; x=1737743339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeoxNnJvMgFI3q4piiiduYU8RMXHoVGq3FrMzVqgkyQ=;
 b=bkgtnsCVNqFKrzgoQCyHDyLJhMI9mcSQsVBV647hvGeGdUavJGuc2KkbxFvNR9gX1q
 4oukd7P6evI6ZLriZB7oRfu8mXmy0OK9yuuIgpUdXNSDiV7L/P31qKNWKCZHOSWHVQmS
 c6RVJFY6kUEmoDeN4JvfH9bWJ623+NlcSJ5hLJLCY2eLATQLJfg8zKmT6SRq7+KF7fCZ
 V1qlV1DCFOQd8klH6pFUXzcTPi5cWKX2Ud7jvPU+oAr/h0VCMsxzwcO7OPrZHVmHztnz
 ljwenxiF5nX8dTSIue78vn/ZehPXRDcYMw6OkWfGKj87f7c90VSJ2Ru/B7cuxzd/t/T0
 L4oA==
X-Gm-Message-State: AOJu0YxGCtZqLh7Rzn5Ki5p15xwNIutWA/G6x8b0yZPMzgwW5kGJZTsl
 EQs2Hdxhvo7IFaeHsyG/hP5lOTQ9ZhP0seVPsyLdxqOFkWKjup8AB56n4e7y8aHphKY0rO++S/0
 y
X-Gm-Gg: ASbGncvNcvloO5hCo7yhJquJyD/F5r0XvP/BcRuM47pIrY8RC0Zi9V6FehoooROwNn8
 NnV5UYm5HTv6GDqJfRRHUBgetaDsKgGwj0FOMDVM4lmpbKrcGgiZRLpwO/OoZx9h0xFYPSZTlKA
 ceHrIcig3+YD0isEu6yiTBPBiIunZgk2I49gHjvkzsh1PKW8GEIHoP4YZDbZgJtvYG1/AWMGcTn
 vtjQF1QC4tm7rFzjc2QPLp98/gB8YGJP7Bj799kux8eAcojq+EisJRlZk1qW+45W+X/REP2IbWQ
 IQ0ttDov3yxS4ys=
X-Google-Smtp-Source: AGHT+IETpzgYZ7t2x1r8uYJ1KJkCWCVSz7Of5KNyF25cp4/BFKoWdbYupKw5bV6jmnNWSsIDvXxoeg==
X-Received: by 2002:a17:90b:1f8e:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2f782c4ff33mr4792978a91.6.1737138539086; 
 Fri, 17 Jan 2025 10:28:59 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:28:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 46/68] tcg/mips: Expand bswap unconditionally
Date: Fri, 17 Jan 2025 10:24:34 -0800
Message-ID: <20250117182456.2077110-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

We always provide bswap subroutines, whether they are optimized
using mips32r2 when available or not.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-has.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 5dbc63cef6..d3d874ffd1 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -51,6 +51,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
+#define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 
@@ -78,7 +79,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -92,9 +92,9 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_bswap16_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_bswap32_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_bswap64_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_bswap16_i64      1
+#define TCG_TARGET_HAS_bswap32_i64      1
+#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_sextract_i64     0
-- 
2.43.0


