Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5953C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDPB-0003cP-Bn; Sun, 11 May 2025 16:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP8-0003c7-MJ
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:10 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP6-0006NT-15
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:09 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22c33677183so32567905ad.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995767; x=1747600567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qH2OoJWwqiQyZOMZJFsx9bUBclHaoHUtvvMOgxzsEc=;
 b=TzxyGBgPbVB0nvRkoZKM3djSIDntboG4g4NjAAnuTp4IZYw8ZRmOAmvnBavIv0B6Q6
 NFLr1nf82Sq8+GtYvir5pMrA7RYv2gIfPEs2ZxeRnOvEw/BJyS73EPByfA2unqo/MmbT
 zf/H3kAp2Dna6uXDatiG9JGt9NYs9QcQG68dGessKThvkWYr+4WTF2UBtGpEkRzItMaE
 CpII15WrEfPbxhq2fdejRfYC3VmV1fz1LXn3K7pR8eOqhIcHDz10MZ88WJIXQQ5JjraO
 uQH9GO91UEr3oG7yTtlgrkirnkh369ItQvy5q4HQnPBHGGJ+THjJPwxCnVCWTKj0Y3ub
 McWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995767; x=1747600567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qH2OoJWwqiQyZOMZJFsx9bUBclHaoHUtvvMOgxzsEc=;
 b=MGN2M/X4Z9YaO5j0kRPrq5z1DJjR3gRGaw8hVxtkMMSmBSN7BMYUHCL37LZqXnU94K
 g4G5VTuGIU6FvXP8fxUweCDAW1c760N2prjEchF+/JaHDil7fBFXrLOMSJoGQTaLwOhe
 vVGy2cQopyReM6bpHXUyQTbznx6ShANQzeuW4x2sPTfCQ5GD8d+e8w3x2yaV5xD/7BXM
 jRQty/3zyJipJkud+iDMXPUr4L9d/0IW1/fNNwTSt3f8v4ZKnx9dGJdmt5tZbvy8EFwz
 S7W/47NZS4zG0MOgVvd5uyV9KiKmSyHAmQJyjd/dbAmuKI/YVeZEsLSopcaEwbw361WE
 8pqA==
X-Gm-Message-State: AOJu0Yz8PaKEbF02m1tc6vMlngoulMJUcyg/6vzJOHu2/HnhSTXVHfnE
 B4mKbxLJqxOveymHMQ6aKRdaHZelfDfajGKO7XW3S/1lO1n+EwDUR6Li+Q15doEGPM0U9vohMcM
 +
X-Gm-Gg: ASbGncumEpwji+zWgx2LIs8aj/DLzHxEnC7wOcIwO3NvRvGJIHRx1WF1M2SGqJRH5yj
 enM88eNBU+5U92R+Spxf3MuCHVaSSFglWXa9KScITXBHM/sEh6oXSHir+35nnI/Pg7zOq78XM+y
 9XCIMjGOovt3SNBoQJhlqiv79ybB24Xmgs/yj4fEqnKoDF18gIPWJmkE47gcicl7v8QMPSm+fOx
 ZFa6y7Db5LkRF5yhYN6NXIQ0E1s9S51h+srXhLoiT6MZyt/zujLMWPipsAPHHtdaeMBpGysT7fu
 ny3A6lpfp7rggfURTBVrwHvrnrJzUNkoM8x1JkeR8x1y9vtdgOsHYVXqKrPRb2EJEdjQPPBvsEI
 7wvhlUjvFRQ==
X-Google-Smtp-Source: AGHT+IECPuE5eYX2hfJf8fQjzyYxRdg69Nk5+XovYszCzsXBf8o2lzUDrZwiAhsFGnl5x/azLfEZbw==
X-Received: by 2002:a17:902:c950:b0:22f:c83d:d726 with SMTP id
 d9443c01a7336-22fc8e99ec8mr146813815ad.33.1746995766749; 
 Sun, 11 May 2025 13:36:06 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:36:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 23/24] target/m68k: Make vmstate variables static
Date: Sun, 11 May 2025 13:35:45 -0700
Message-ID: <20250511203546.139788-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

These need not be exported beyond cpu.c.
Fix a typo in vmstate_fpu.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 866d32fc9f..fe53572542 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -478,7 +478,7 @@ static int fpu_post_load(void *opaque, int version)
     return 0;
 }
 
-const VMStateDescription vmmstate_fpu = {
+static const VMStateDescription vmstate_fpu = {
     .name = "cpu/fpu",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -500,7 +500,7 @@ static bool cf_spregs_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_CF_ISA_A);
 }
 
-const VMStateDescription vmstate_cf_spregs = {
+static const VMStateDescription vmstate_cf_spregs = {
     .name = "cpu/cf_spregs",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -522,7 +522,7 @@ static bool cpu_68040_mmu_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_M68040);
 }
 
-const VMStateDescription vmstate_68040_mmu = {
+static const VMStateDescription vmstate_68040_mmu = {
     .name = "cpu/68040_mmu",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -547,7 +547,7 @@ static bool cpu_68040_spregs_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_M68040);
 }
 
-const VMStateDescription vmstate_68040_spregs = {
+static const VMStateDescription vmstate_68040_spregs = {
     .name = "cpu/68040_spregs",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -583,7 +583,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
-        &vmmstate_fpu,
+        &vmstate_fpu,
         &vmstate_cf_spregs,
         &vmstate_68040_mmu,
         &vmstate_68040_spregs,
-- 
2.43.0


