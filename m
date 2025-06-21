Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E67C7EE2A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z1-00053n-44; Sat, 21 Jun 2025 19:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yy-00052n-Nx
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yx-0004Rv-1R
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73972a54919so2371899b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549846; x=1751154646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JesRsBxTW9P6euxGCiWnEca1MfgSBXk2WdQ/r2EWxHc=;
 b=iPyOdAGPXIv755Rt2XQwuyOvFzC/aWU/U9kupKYON6AIZ7XQnVDOr+GY9ccBfhIjZ2
 HpD6wa9fBnGrWN8C6JscA7UophRKmTAKFZSeha5uqh5XPwGcwC7zYEolDp+AWOnZdZpV
 ALyhF15JtTtY5oswX5PIgKAK3c51sMEdXcrKNzuPDZvX4Ctp5NqbzpCHshGk2gf9oZS3
 tW+zhxrLsH6SMKEL6U2PDi8eFipxYY9mlAGm6K1GzkAnddJ78LaKiRUrDPBkLzC0wYeL
 V3cePjw2ZXl49vHWyAKQJ5wqhx8VnMu++QYuz7vCRlBmFHRzSRR2BcQUegGOoK5VQfIh
 7Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549846; x=1751154646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JesRsBxTW9P6euxGCiWnEca1MfgSBXk2WdQ/r2EWxHc=;
 b=XAt3t3HZuhc3v/RY3y6ZGaKKgx1S2gp/UVU5ZvnWgRI0fMLBo62c5Ich+sY5ge+Le+
 2c3n5hIJ3BoblCm+pT/nu2intkQP0DxE+qoTx5BAgTKveI/Kb+3rh7a0BujyuCjIG3K6
 cs5z5drsqehRasfBZa3kRTklcHhDfcDDw+YATriK2LcXMgQNzi3U/blXbeNc+V1ybhhu
 W9R/lC066YnqZVkVdAHVfrqCrOUjrwALfsIRncx4/kbPzH5yOmcqCscIo+EYddfvx9X7
 hzZ+/elVCnAdkhAYuTH7+EGBpPX5DAOfYpl1pcOpgtH9Cg9BzPorUauVbyRfmeWdc/nW
 hrUQ==
X-Gm-Message-State: AOJu0YzauDDSBQLXL4qi1RMbYHcPWHnWOZ5CHmWLcAnpGxZyLWBG5vgB
 G26VwQ9Zhy7Wz05Ffo/2aAChhiQtOgNLwEaQYRl0mBi/TsZfjcYtQSb7YzsG0alN5WnzWfgmje0
 /4s/k
X-Gm-Gg: ASbGncuZ1n5HTzf9UVTM43JKmeu+yZCZDz3x4KOFSAd/K2RX0kEndYwuPDw8JrpRnSa
 tEnTT+8epl4MM5JV4g/fGnzRhzljGeaflO83GlcavqBxC8wS2ysIHaZRhCnJnjtFIDg9ueG+AUQ
 A0uL/DQmSmKjDGBECfjNCqC3+gyts+rDKz8U2SRc6mSEf8VAHz+08ykzBAf+JfY+Nb1XVUL+Uu/
 yonqZZn8TRKR5e1iqeTcxBhIrcb1nA3YYFZIzOuSYyOoL7EUDAnQaEs3UR2M/ZsBheGnXsOfeKB
 QtBJGyT9BiSHu8TfJIRLMe6I7FUZyIEC487qGNeG51KHHxqus0+INKcf2CA8n7xmuDpjI71lQ7g
 +w4pdBP9/6iB8qJvFvrv1
X-Google-Smtp-Source: AGHT+IFzx+2q0Zr8+hyHaFAGqQCJIY8QAXOoakh/i9EWo23rQ6m15H0mHNKxI9ER8M7REBuob7otww==
X-Received: by 2002:a05:6a20:244a:b0:21a:b9d4:ad73 with SMTP id
 adf61e73a8af0-22026ffb540mr14761532637.40.1750549845671; 
 Sat, 21 Jun 2025 16:50:45 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 010/101] linux-user/aarch64: Update hwcap bits from 6.14
Date: Sat, 21 Jun 2025 16:49:06 -0700
Message-ID: <20250621235037.74091-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 linux-user/elfload.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 82ebf6a212..2add1665c7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -751,7 +751,23 @@ enum {
     ARM_HWCAP_A64_SSBS          = 1 << 28,
     ARM_HWCAP_A64_SB            = 1 << 29,
     ARM_HWCAP_A64_PACA          = 1 << 30,
-    ARM_HWCAP_A64_PACG          = 1UL << 31,
+    ARM_HWCAP_A64_PACG          = 1ULL << 31,
+    ARM_HWCAP_A64_GCS           = 1ULL << 32,
+    ARM_HWCAP_A64_CMPBR         = 1ULL << 33,
+    ARM_HWCAP_A64_FPRCVT        = 1ULL << 34,
+    ARM_HWCAP_A64_F8MM8         = 1ULL << 35,
+    ARM_HWCAP_A64_F8MM4         = 1ULL << 36,
+    ARM_HWCAP_A64_SVE_F16MM     = 1ULL << 37,
+    ARM_HWCAP_A64_SVE_ELTPERM   = 1ULL << 38,
+    ARM_HWCAP_A64_SVE_AES2      = 1ULL << 39,
+    ARM_HWCAP_A64_SVE_BFSCALE   = 1ULL << 40,
+    ARM_HWCAP_A64_SVE2P2        = 1ULL << 41,
+    ARM_HWCAP_A64_SME2P2        = 1ULL << 42,
+    ARM_HWCAP_A64_SME_SBITPERM  = 1ULL << 43,
+    ARM_HWCAP_A64_SME_AES       = 1ULL << 44,
+    ARM_HWCAP_A64_SME_SFEXPA    = 1ULL << 45,
+    ARM_HWCAP_A64_SME_STMOP     = 1ULL << 46,
+    ARM_HWCAP_A64_SME_SMOP4     = 1ULL << 47,
 
     ARM_HWCAP2_A64_DCPODP       = 1 << 0,
     ARM_HWCAP2_A64_SVE2         = 1 << 1,
@@ -798,6 +814,25 @@ enum {
     ARM_HWCAP2_A64_SME_F16F16   = 1ULL << 42,
     ARM_HWCAP2_A64_MOPS         = 1ULL << 43,
     ARM_HWCAP2_A64_HBC          = 1ULL << 44,
+    ARM_HWCAP2_A64_SVE_B16B16   = 1ULL << 45,
+    ARM_HWCAP2_A64_LRCPC3       = 1ULL << 46,
+    ARM_HWCAP2_A64_LSE128       = 1ULL << 47,
+    ARM_HWCAP2_A64_FPMR         = 1ULL << 48,
+    ARM_HWCAP2_A64_LUT          = 1ULL << 49,
+    ARM_HWCAP2_A64_FAMINMAX     = 1ULL << 50,
+    ARM_HWCAP2_A64_F8CVT        = 1ULL << 51,
+    ARM_HWCAP2_A64_F8FMA        = 1ULL << 52,
+    ARM_HWCAP2_A64_F8DP4        = 1ULL << 53,
+    ARM_HWCAP2_A64_F8DP2        = 1ULL << 54,
+    ARM_HWCAP2_A64_F8E4M3       = 1ULL << 55,
+    ARM_HWCAP2_A64_F8E5M2       = 1ULL << 56,
+    ARM_HWCAP2_A64_SME_LUTV2    = 1ULL << 57,
+    ARM_HWCAP2_A64_SME_F8F16    = 1ULL << 58,
+    ARM_HWCAP2_A64_SME_F8F32    = 1ULL << 59,
+    ARM_HWCAP2_A64_SME_SF8FMA   = 1ULL << 60,
+    ARM_HWCAP2_A64_SME_SF8DP4   = 1ULL << 61,
+    ARM_HWCAP2_A64_SME_SF8DP2   = 1ULL << 62,
+    ARM_HWCAP2_A64_POE          = 1ULL << 63,
 };
 
 #define ELF_HWCAP   get_elf_hwcap()
@@ -886,7 +921,7 @@ uint64_t get_elf_hwcap2(void)
 
 const char *elf_hwcap_str(uint32_t bit)
 {
-    static const char *hwcap_str[] = {
+    static const char * const hwcap_str[] = {
     [__builtin_ctz(ARM_HWCAP_A64_FP      )] = "fp",
     [__builtin_ctz(ARM_HWCAP_A64_ASIMD   )] = "asimd",
     [__builtin_ctz(ARM_HWCAP_A64_EVTSTRM )] = "evtstrm",
@@ -919,6 +954,22 @@ const char *elf_hwcap_str(uint32_t bit)
     [__builtin_ctz(ARM_HWCAP_A64_SB      )] = "sb",
     [__builtin_ctz(ARM_HWCAP_A64_PACA    )] = "paca",
     [__builtin_ctz(ARM_HWCAP_A64_PACG    )] = "pacg",
+    [__builtin_ctzll(ARM_HWCAP_A64_GCS   )] = "gcs",
+    [__builtin_ctzll(ARM_HWCAP_A64_CMPBR )] = "cmpbr",
+    [__builtin_ctzll(ARM_HWCAP_A64_FPRCVT)] = "fprcvt",
+    [__builtin_ctzll(ARM_HWCAP_A64_F8MM8 )] = "f8mm8",
+    [__builtin_ctzll(ARM_HWCAP_A64_F8MM4 )] = "f8mm4",
+    [__builtin_ctzll(ARM_HWCAP_A64_SVE_F16MM)] = "svef16mm",
+    [__builtin_ctzll(ARM_HWCAP_A64_SVE_ELTPERM)] = "sveeltperm",
+    [__builtin_ctzll(ARM_HWCAP_A64_SVE_AES2)] = "sveaes2",
+    [__builtin_ctzll(ARM_HWCAP_A64_SVE_BFSCALE)] = "svebfscale",
+    [__builtin_ctzll(ARM_HWCAP_A64_SVE2P2)] = "sve2p2",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME2P2)] = "sme2p2",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME_SBITPERM)] = "smesbitperm",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME_AES)] = "smeaes",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME_SFEXPA)] = "smesfexpa",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME_STMOP)] = "smestmop",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME_SMOP4)] = "smesmop4",
     };
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
@@ -926,7 +977,7 @@ const char *elf_hwcap_str(uint32_t bit)
 
 const char *elf_hwcap2_str(uint32_t bit)
 {
-    static const char *hwcap_str[] = {
+    static const char * const hwcap_str[] = {
     [__builtin_ctz(ARM_HWCAP2_A64_DCPODP       )] = "dcpodp",
     [__builtin_ctz(ARM_HWCAP2_A64_SVE2         )] = "sve2",
     [__builtin_ctz(ARM_HWCAP2_A64_SVEAES       )] = "sveaes",
@@ -972,6 +1023,24 @@ const char *elf_hwcap2_str(uint32_t bit)
     [__builtin_ctzll(ARM_HWCAP2_A64_SME_F16F16 )] = "smef16f16",
     [__builtin_ctzll(ARM_HWCAP2_A64_MOPS       )] = "mops",
     [__builtin_ctzll(ARM_HWCAP2_A64_HBC        )] = "hbc",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SVE_B16B16 )] = "sveb16b16",
+    [__builtin_ctzll(ARM_HWCAP2_A64_LRCPC3     )] = "lrcpc3",
+    [__builtin_ctzll(ARM_HWCAP2_A64_LSE128     )] = "lse128",
+    [__builtin_ctzll(ARM_HWCAP2_A64_FPMR       )] = "fpmr",
+    [__builtin_ctzll(ARM_HWCAP2_A64_LUT        )] = "lut",
+    [__builtin_ctzll(ARM_HWCAP2_A64_FAMINMAX   )] = "faminmax",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8CVT      )] = "f8cvt",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8FMA      )] = "f8fma",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8DP4      )] = "f8dp4",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8DP2      )] = "f8dp2",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8E4M3     )] = "f8e4m3",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8E5M2     )] = "f8e5m2",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_LUTV2  )] = "smelutv2",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_F8F16  )] = "smef8f16",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_F8F32  )] = "smef8f32",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_SF8DP4 )] = "smesf8dp4",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_SF8DP2 )] = "smesf8dp2",
+    [__builtin_ctzll(ARM_HWCAP2_A64_POE        )] = "poe",
     };
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
-- 
2.43.0


