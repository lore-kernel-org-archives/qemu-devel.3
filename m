Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63C6C87FD1
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwRP-00023b-3b; Sun, 27 Jul 2025 04:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPv-0004hD-Ov
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPs-0004w3-H8
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:34 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-23602481460so35115925ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603650; x=1754208450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9biC4m5Z/jWTlu3yNFuyIx6JyDKTGnmYvdUOQcfLcyY=;
 b=UE691dt/eomuwxuLQ1b8lIyKMSH/7w1CZJVZR+0ypovHeqReSlkra5elUzhwi+lTMX
 X94c8LzY4TwiBtjLLUBINQzZjuYRxBQE4+iNZJd48aK+CeWvjfm7IdHj3M0o3owY16V3
 svj2lOzQwE8BWEtke7YJJjkOZhexi/ew5DkxhY62hZ3XKPiNNB+80HwB/A/0wR/I55B/
 7U9jGmUrhrCqaVZY+ie2/wNZ/K6rmg4WBOy8WcelRehE1hUMPUxTsbQd01AtMESyrXhY
 KuNIV7OO8yLwxl2P9bfEss61obBjXNdoxBvtEJ1QJudzg36cO056LbADwZY4YTLUBrSD
 OzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603650; x=1754208450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9biC4m5Z/jWTlu3yNFuyIx6JyDKTGnmYvdUOQcfLcyY=;
 b=C2+/2IgJgKt9VHxFx9mLMUPyPK35CfQEpZbkixnE+8cBUpxNa2ZE1snNZBKQnHU0M0
 x9y17mg1VkIcvpPg4vYAKk3FB/hiUHoyoFpnq3Q2wU8LdjRFrgjPKjncSrxGrVo/8mkt
 CAe2r8Rqxm85Ki9/NUoJRTlHmvKt7togqXAtqOxvPm2Au7S0yJrgkkI946P4jTT8boB7
 viHzNbMrQbvBxZM8mO30Y7L7KSbdb03bwNou2gqHefXo8L1gnRO4vHYrtE0u6Kmz5SNl
 yUA7reCLRDmk40sUHJ1ped+6aaXWKLLLwQuUcW47hPcTNZxGqV+2bXrmazUr1U2qHmyv
 +a/A==
X-Gm-Message-State: AOJu0YwM+p79A/owgErDGo1ELlZxfZWfsaklij9ngAAI/xqSvkK9YlCk
 MYXA9jLD6ugQZ9Lx3idLT8O7gj6AL+4feZmM+38E8iqTZEzvhRz2wNx54HdfHl6g/xSCOW82keH
 vvf8C
X-Gm-Gg: ASbGncuFCB9F2P4zR7L+MnrhO+3/bzOT6TubUIXV+TM+C8Gf081UkTuK5ii5hnG04vz
 WTIT/2DTTEqP5oFpxHSMJjjdS0O5bfYU017MMfNhwYIgSlpYrmbS2vCIls8pjeXhnYbMPHSretb
 wMEWZAk/t194sQAnf3Uq8c6YYlTGgEWsWQwJs2F4jKlhp33dIQOfasOm5FPqBQzp9QfZF3JkNeg
 XW/1nISIMY3+O3IcgepQsjKG4ka+8dKAp/fZBbSOei1RM2angv4xS8nt7BsHrrdltR/GoEc5fxz
 ddb8tPBLxvaiqIlNUZJwIgGj+OF7fIgXY1VqN7JnaDdWZQtPLYCmb7DZW506C2zynBGQwqZ2i0P
 CyT8pWypPih22tq+MnrMkuXOUE5Ubm/EnMG6/PUlm+S+yQADQPF1naZXoniZ9BASKAtYSlDrmsr
 RNdgKZSnWay9xlReYAFwPK
X-Google-Smtp-Source: AGHT+IEg9NX2MMOvAdB+/kV0mFV+vFeeiO2FB68ptY+7GX9OsqPm8d7rxf23vuBeIp+S+FdsVOF+hQ==
X-Received: by 2002:a17:903:2f87:b0:234:8ef1:aa7b with SMTP id
 d9443c01a7336-23fb3085301mr105934895ad.20.1753603650251; 
 Sun, 27 Jul 2025 01:07:30 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 78/82] linux-user: Change exported get_elf_hwcap to abi_ulong
Date: Sat, 26 Jul 2025 22:02:50 -1000
Message-ID: <20250727080254.83840-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

AArch64 is about to add the first 64-bit hwcap bit, so we
have to expand the return type.  Since the only user
assigns this to a abi_ulong, match that type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h  |  2 +-
 linux-user/elfload.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index e102e6f410..e1badd4393 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -99,7 +99,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 extern unsigned long guest_stack_size;
 
 #if defined(TARGET_S390X) || defined(TARGET_AARCH64) || defined(TARGET_ARM)
-uint32_t get_elf_hwcap(void);
+abi_ulong get_elf_hwcap(void);
 const char *elf_hwcap_str(uint32_t bit);
 #endif
 #if defined(TARGET_AARCH64) || defined(TARGET_ARM)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ea214105ff..d87d1a16e0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -511,10 +511,10 @@ static bool init_guest_commpage(void)
 #define ELF_HWCAP get_elf_hwcap()
 #define ELF_HWCAP2 get_elf_hwcap2()
 
-uint32_t get_elf_hwcap(void)
+abi_ulong get_elf_hwcap(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
-    uint32_t hwcaps = 0;
+    abi_ulong hwcaps = 0;
 
     hwcaps |= ARM_HWCAP_ARM_SWP;
     hwcaps |= ARM_HWCAP_ARM_HALF;
@@ -841,10 +841,10 @@ enum {
 #define GET_FEATURE_ID(feat, hwcap) \
     do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
 
-uint32_t get_elf_hwcap(void)
+abi_ulong get_elf_hwcap(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
-    uint32_t hwcaps = 0;
+    abi_ulong hwcaps = 0;
 
     hwcaps |= ARM_HWCAP_A64_FP;
     hwcaps |= ARM_HWCAP_A64_ASIMD;
@@ -1824,7 +1824,7 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define GET_FEATURE(_feat, _hwcap) \
     do { if (s390_has_feat(_feat)) { hwcap |= _hwcap; } } while (0)
 
-uint32_t get_elf_hwcap(void)
+abi_ulong get_elf_hwcap(void)
 {
     /*
      * Let's assume we always have esan3 and zarch.
-- 
2.43.0


