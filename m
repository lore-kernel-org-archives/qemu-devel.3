Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AEFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ubJ-0005nR-1I; Fri, 03 May 2024 11:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubG-0005kb-72
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:26 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubE-00076G-Jz
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:25 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ec69e3dbcfso34037485ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749202; x=1715354002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oO6lVL+LVK6xULV3eqZmGPXjUDThyU0i78qX8xOIR9w=;
 b=Hwj/a+k2/t2qsCutDjeU8sVsgHzlmzSNdDJTFESksbdthyTduPeEu571hUjxcqAuFw
 fFoBy1v5DWJvrvWX8Fu8tpa0h/TOfugqdI7CQxHhviRLn4ZSSPsi79zvx90FQKRicrJm
 fdAaG/+MPFrN68BIy0UmEmRR23EMlglTUpnpci05rrAeMgNt2e7+gx/339MVcqciJbHf
 LvGFh6gK8d8trMCWYSfxn42Z740sLSH0WSwCZzxMP4Z7N7vmD+EsuIVERUammMaOALvG
 dmrOKosXP1D6o2sMNFWm4KNwZSqAiiF5A0UBe936aUTfx1kSZYUPLWZuDqFKXO8CTZdm
 hfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749202; x=1715354002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oO6lVL+LVK6xULV3eqZmGPXjUDThyU0i78qX8xOIR9w=;
 b=VPK3Mkgd1FuU4keuHpngLV21NUEBA9PM0EEbQD6i4ltiJQj5pmiwSyleQCRIEotA/D
 NmfKmBV6WGuAxYKGYsdPRK2TspZwsP6nUEFq61IvnE8Bt9OK5bqN/T9qYHe6LjHaY9JJ
 eD4PEGcAWD65iUMG+5UwPL2rtKOGjWq9JTAeWUyt/BkJVIWUPFI4+IW/aPXdLo+S7sLe
 S3cnPQu8GldkddsWdUZ/mP2udLnIwWNu1oqI6AE2jGPgQTGnHAEhc6uB6NesdMOlfxFi
 GVG7Cht3HRAp6lTCoysTq00aqQcdwLGsh632gALw1dygx0khf4mmkqx43qX0c0PKk+NN
 XHRg==
X-Gm-Message-State: AOJu0YwssLnMLUElOdsjvx8AXh4fjrPo94dlY6FwvotBWxm0Cmt5teep
 uQ73zBQj+qrvm3Qlit9pDUtmfFmp6dIQ9d1RBqxUEsxETLK9si5L39L+jqmzccA/nIK0OIdzP6E
 w
X-Google-Smtp-Source: AGHT+IHKqf/ltv9tkTOiLAkwEhVgxREj49Vln9ghlrnKNmF570d+MTlsgu8rUZ2pxCMu68wPM1MnRQ==
X-Received: by 2002:a17:902:da8d:b0:1e5:2883:6ff6 with SMTP id
 j13-20020a170902da8d00b001e528836ff6mr3582685plx.11.1714749202614; 
 Fri, 03 May 2024 08:13:22 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902c70a00b001e81c778784sm3366611plp.67.2024.05.03.08.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:13:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/10] util/bufferiszero: Introduce biz_accel_fn typedef
Date: Fri,  3 May 2024 08:13:11 -0700
Message-Id: <20240503151314.336357-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503151314.336357-1-richard.henderson@linaro.org>
References: <20240503151314.336357-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index c9a7ded016..f9af7841ba 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -26,7 +26,8 @@
 #include "qemu/bswap.h"
 #include "host/cpuinfo.h"
 
-static bool (*buffer_is_zero_accel)(const void *, size_t);
+typedef bool (*biz_accel_fn)(const void *, size_t);
+static biz_accel_fn buffer_is_zero_accel;
 
 static bool buffer_is_zero_int_lt256(const void *buf, size_t len)
 {
@@ -184,7 +185,7 @@ select_accel_cpuinfo(unsigned info)
     /* Array is sorted in order of algorithm preference. */
     static const struct {
         unsigned bit;
-        bool (*fn)(const void *, size_t);
+        biz_accel_fn fn;
     } all[] = {
 #ifdef CONFIG_AVX2_OPT
         { CPUINFO_AVX2,    buffer_zero_avx2 },
@@ -231,7 +232,7 @@ bool test_buffer_is_zero_next_accel(void)
 #define INIT_ACCEL buffer_is_zero_int_ge256
 #endif
 
-static bool (*buffer_is_zero_accel)(const void *, size_t) = INIT_ACCEL;
+static biz_accel_fn buffer_is_zero_accel = INIT_ACCEL;
 
 bool buffer_is_zero_ool(const void *buf, size_t len)
 {
-- 
2.34.1


