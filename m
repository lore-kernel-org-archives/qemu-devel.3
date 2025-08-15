Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC9BCA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 12:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umtWz-00019B-1I; Fri, 15 Aug 2025 08:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWj-00015n-Jp
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:24 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWg-0007ZA-Dy
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:21 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76e39ec6f52so1499738b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755260836; x=1755865636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QLYyuHVparpPkh2Y2hgv/6oup4ZQ3R6Uz4weGDqzuYA=;
 b=j4KX+tOpCEbxnUV/GvBOugpATStri6916V5lxezX6uCv2xfgAl5uO/+0fpxpr5SXw1
 ewVkRlOl7vWyerECa253sVKABohHyECRGVnUcbKgTiAXM9UDEWRGaTxJfzn6bbMlM++Y
 HeTjHU2iWO5ynjt3BpkAZkVmjMnCr5p19+Nk6pd+dYoemgKIZVY2HeWMUR83aRBlRKmk
 NbbJdeQBJxsEIFXHxegNYKH9APvfxIWIWomL2xWb5sm1oXjWsE77OjTX083JXpSSg17k
 PZYA+MtVUuu3Lt54PE6Nk5cspFRHFHxKouFCkRaOYiV+HDT8QMnB+W2kBXsLtQcjpkZE
 1kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755260836; x=1755865636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLYyuHVparpPkh2Y2hgv/6oup4ZQ3R6Uz4weGDqzuYA=;
 b=E+xkEXhvDXGo0YYDoTXJmU0WvfAu0RQ3a7/jxWJwFUu6mgXJDVaeK8fcrXX4TpvMyw
 f7WcXaRJdl3wTkfaAy7CajDdP4bemP0QAWShCfGNhtD5ESittSREuD4T0rojLt7xMJr3
 6SSm8ieM3F+Iy5EzxJ93mTX3E+h4Z8UlfWO9Fqtxg1cxG8xlXr0i3rSjXUMaDk9PJ8bm
 5GYDFmLIZ9IqGYUKHi4aakDCMvm+qAEEba/pQdFiyohc/qMVPndBSYTa1Sqx6FmdAN5f
 LptcRtCX/SBIIhJ7hjLxwU5nq6q20UwJTfuHc8gyr7xylHdE5ywBtWxoVOWgquKSOXV1
 zqJA==
X-Gm-Message-State: AOJu0YxXn7WDy4UwkWAyeT9UGyEI4OhsHDTSWjRoWiKNZsHWy82B0GAk
 7xcHHm5LgIWzGnN/jJUwOl/NkBPGvwEk8WlhMoLx6Lp8juFobjmniaeQkfyQ3fVaZMrLOa0ZV2A
 Qa9rMEPg=
X-Gm-Gg: ASbGncvgb/OgzX1Rr/DJElevIn/nwe7MDn6HtkpNwYrSIzyrZKvSS8qZ2E7VMwL9KJT
 W9LD8JLeWZctOV4fEKCP1f0HsMyQ9rX/+OQVvJuS8iFjYXU53kKamS7+tlf9dz8nXDBGIxKrPfP
 esgILMMQfy5IVboV/EFMufFtnXySw2Q6IOffpZ0qBNpfgV5mVrZg96QK0jFwid1ozU6V232EgxQ
 ovdYU93QOSUt11v8aKQRRWe6jHpJnsVo5Yjm1THDVsg6vEb+RW/x6TrnW3W/EiBsJy4NfgltoJi
 T/JmGdpXO0i2XZNF5aMMeAy+/NYI+5mp5pEJDHCK69/BlRwbaG0v8b6nuNYJFj87EdsGiTe1Ci5
 4zgX6mmgsfZ+ltow7bCaMsoqww/2PtqNZmWmlQjEzyMWppzzJgvJgNXp2dQ==
X-Google-Smtp-Source: AGHT+IFk68NYNRFwYUGNDYOpMW9V9B9xkw97YN0Ur76Ui2lQbghLcnkIro4yhruNStmIa0bLurwswA==
X-Received: by 2002:a05:6a20:3949:b0:23d:8af5:13b9 with SMTP id
 adf61e73a8af0-240d2debc97mr3076399637.2.1755260836513; 
 Fri, 15 Aug 2025 05:27:16 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e45292c86sm1053475b3a.48.2025.08.15.05.27.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 05:27:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] target/arm: Enable FEAT_LSE128 for -cpu max
Date: Fri, 15 Aug 2025 22:26:53 +1000
Message-ID: <20250815122653.701782-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815122653.701782-1-richard.henderson@linaro.org>
References: <20250815122653.701782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 linux-user/elfload.c          | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9f36ec06a4..85f67d3d44 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -923,6 +923,7 @@ uint64_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sme_b16b16, ARM_HWCAP2_A64_SME_B16B16);
     GET_FEATURE_ID(aa64_sme_f16f16, ARM_HWCAP2_A64_SME_F16F16);
     GET_FEATURE_ID(aa64_sve_b16b16, ARM_HWCAP2_A64_SVE_B16B16);
+    GET_FEATURE_ID(aa64_lse128, ARM_HWCAP2_A64_LSE128);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 35cddbafa4..370818d11b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1145,7 +1145,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* FEAT_SHA512 */
     t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* FEAT_CRC32 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 2);   /* FEAT_LSE */
+    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 3);   /* FEAT_LSE, FEAT_LSE128 */
     t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* FEAT_RDM */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* FEAT_SHA3 */
     t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);      /* FEAT_SM3 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 890dc6fee2..a5c0e61393 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -88,6 +88,7 @@ the following architecture extensions:
 - FEAT_LRCPC2 (Load-acquire RCpc instructions v2)
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
+- FEAT_LSE128 (128-bit Atomics)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MixedEnd (Mixed-endian support)
 - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
-- 
2.43.0


