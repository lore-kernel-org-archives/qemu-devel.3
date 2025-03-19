Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E95C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutl4-0004cU-Gr; Wed, 19 Mar 2025 09:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutk7-0003ZO-Fb
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:46:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutk3-00044x-Bj
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso24294485e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391953; x=1742996753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0iduta05yw16WNoxlZ2Qk6hI45690lcV/AnGwn0ABIE=;
 b=BVsuNliAPBphT3Dl8o7GtdtkP4UfN3kV3qStr/lg/so4InV3/mp5M8gM3/MHYWdCO2
 9RAIHsOWkVHpRiMZChzrdI58hAbmMtd222Shh74uaCcbmlXuNkkYytVs4nz6yjdgok9K
 ozn+bIXSzIady2ULbhCT1FAvP+TgqoqK9zDIFnbSDEDlvPWMrLXR3lOI+obmGCkzUR+b
 vDj1sDwnEgEoWDfC0WWwi5u9aX4Fibv4cwyMkKsb7Ja5eZhkVfstIAOF67rRsuGyfvkd
 FU0OC5WWnX9QtGnETaFbUBoFGJRo/NoYRTLyMFNQK3i695JjIBVNDFfWcE3TuQiM+G1Z
 FOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391953; x=1742996753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0iduta05yw16WNoxlZ2Qk6hI45690lcV/AnGwn0ABIE=;
 b=UR96pmzKsDv1Amw5QOBxbzVoOZbpNMm1FMGRzol00GVqbdijjuVKkiUSj39SWzGIqs
 9Ht3pPU76peCEh0d4qKziVZhITcpiodmguCdkorOVA7CdxeA4cwuds6Yd1qa81HU1sRo
 aq4u8+B5hPhsI2Gv9rtMNG16NEzh29W9wtCrD9ziSQ19MKLlKiYUrFUMpISxLjeLdaBG
 /Wf6s27lG3kXpnhOU4WVc5lNfoHqI0ePaNVVq5sNKHloqEHKt7rVxhjgWvcZZrGstWhx
 pNXgEtTbmHKXSaIqFZdTMfbJAExmKJX3ajnXlXRnYg+2jTwvkcNSQNIMJr6F2kogHgHy
 3jwQ==
X-Gm-Message-State: AOJu0YxJtvqaWnTi8fC13ZQDRXoNDgoFvbmRDfohQB7rEVXtxrRAye6I
 /iR3ijqeWEdTmouwnQjJ4g7G0ATyKq0LtFTm0vK69fTrqCwSPU3EjyQnjUJT3vqMfKu4oJFVk5U
 i
X-Gm-Gg: ASbGnctIu0nWCmcnuAf+2H6tFcN7V5e5CKTMhcYsNRqCDu0O0MQSczPMBmzlwH7rTDe
 1CLW1xCPFgxWx3S/r5vsphVjoacCP8AS1UM756vYzMUT/69Lwx//Oy5UXR2gJhsypqeYxO4863w
 +oXbcUbLAEWWBZheIk4jebMlhyxM14JpOiknysCTlsRiLgUf/2FqYYMP8EdzNgbi1RGs1d7IF2o
 hOcF9P+KIoNzBvgMriUUdyMJDSv8dAOF6OuZBCQ9znqEaSRFIhHbr/Q98IuEM6LKGFPQcTTOpWR
 GXLMkK7SxDsppYWmbAWAey1fZVwdWPxbvGItqL8RteKVe/HMz+3X0oGb3YkvN2S8KfBPAluSHDG
 g71dF2ZP+7O8NxGLv7Pw=
X-Google-Smtp-Source: AGHT+IEIVkvNjZTSUIhxld65N34wtP4O1yV6EMcKBSQsg6hWbOD77YnM3I07e40v7q9onP2gPDDs1g==
X-Received: by 2002:a05:600c:1da9:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-43d43793160mr29149685e9.16.1742391953364; 
 Wed, 19 Mar 2025 06:45:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f864d4sm19661645e9.37.2025.03.19.06.45.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:45:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 09/12] tcg: Restrict TARGET_INSN_START_WORDS
 definition to translate-all.c
Date: Wed, 19 Mar 2025 14:45:03 +0100
Message-ID: <20250319134507.45045-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

TARGET_INSN_START_WORDS is now only used within translate-all.c,
move its declaration there.
"tcg/insn-start-words.h" header being now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/insn-start-words.h | 13 -------------
 accel/tcg/translate-all.c      |  3 ++-
 target/i386/helper.c           |  1 -
 target/openrisc/sys_helper.c   |  1 -
 4 files changed, 2 insertions(+), 16 deletions(-)
 delete mode 100644 include/tcg/insn-start-words.h

diff --git a/include/tcg/insn-start-words.h b/include/tcg/insn-start-words.h
deleted file mode 100644
index 394c191da8d..00000000000
--- a/include/tcg/insn-start-words.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define TARGET_INSN_START_WORDS
- * Copyright (c) 2008 Fabrice Bellard
- */
-
-#ifndef TARGET_INSN_START_WORDS
-
-#include "cpu.h"
-
-# define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)
-
-#endif /* TARGET_INSN_START_WORDS */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2f8cf6db144..fc55a75a3cf 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -65,11 +65,12 @@
 #include "internal-common.h"
 #include "internal-target.h"
 #include "tcg/perf.h"
-#include "tcg/insn-start-words.h"
 #include "tcg/tcg-op.h"
 
 TBContext tb_ctx;
 
+#define TARGET_INSN_START_WORDS     (1 + TARGET_INSN_START_EXTRA_WORDS)
+
 /*
  * Encode VAL as a signed leb128 sequence at P.
  * Return P incremented past the encoded value.
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 90e113c8b5a..1f819fbff65 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -30,7 +30,6 @@
 #endif
 #include "qemu/log.h"
 #ifdef CONFIG_TCG
-#include "tcg/insn-start-words.h"
 #include "tcg/tcg.h"
 #endif
 
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index cf521461954..9da2bebbd5b 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -27,7 +27,6 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #endif
-#include "tcg/insn-start-words.h"
 #include "tcg/tcg.h"
 
 #define TO_SPR(group, number) (((group) << 11) + (number))
-- 
2.47.1


