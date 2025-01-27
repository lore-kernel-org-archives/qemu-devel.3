Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0634DC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMKS-0001iL-Qa; Mon, 27 Jan 2025 05:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKG-0001f4-T2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:41 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKF-0001wr-Ep
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:40 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso45022585e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973596; x=1738578396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axO9L9zvQNnbH3QdpMtYTEFgm/4DySr8I7ccuAMR/ZA=;
 b=qGJBkcUrlaPFjvwPgJAbUSqzGlITX2qlveacuwUu8rx1V2lZ/VVJa/In5SocpLPGfS
 JmnXUOQbGpuR9oafUdfpZXZ2uYGoTjMDojGnUK8A5oBh663uFsx+rz+NVSPvaowJBQjV
 pqlQ/Fuv2pKbfN2w5C/UA0qDy/72BxV17gYOf04q5gKYiXOkaijHWol+hxfQeKnGzM6l
 blvFwaAcs4F/ATJvdsxXtvt0T7rMv1puRnpI4KHGcDNfDDH4pB3ZDv2GSslzS7voL2Dr
 i3V9ruAERaIQBN1WeIatYNvmZl/WaGONvydFtrSfxMyCsgLhcVm4vT/zWnc4G4DOUSxM
 LniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973596; x=1738578396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axO9L9zvQNnbH3QdpMtYTEFgm/4DySr8I7ccuAMR/ZA=;
 b=JbrH4kupK3+mPUgtLBffqoOr9UUm96COo7cce0+Up1bQw1uV7EqPI7v1I+q6Z+McNS
 Swo65so8V/gTk83u/7Jsy0Ep2cI6WySRtilFiD/wPaqUmKEZBnJmzuVf/HPNK50TICrp
 UcxvOfPLhpZf/A/cZu6i4OJ0lf0XkOfrqoDAB65FExNspP+I/VCL9iWBptHkzPRBslor
 bWKDViqhhgYVhS5pZkMngQbXjAGcMuNtYue3CITtsOdquK46KgVC+jaomHih45KkuZoh
 vHazNtbgwUcWfD/GBIMJru1WQH+GOqprjY5k5XuE5JdSJ54fWWTYdw3ekFxTzw6bkufE
 QT4w==
X-Gm-Message-State: AOJu0YyfoZNo/C+FajSogJRp6DJe5MrUdXPM+f4j1ukF6bES9UrOo20G
 gEap6M0hYKAiIvTp6Jj4k84eguu1W2Wm8z13eWnCsJyEZSyZrhtqLMacdNyjiOuHNwRjcObg1fw
 uL6M=
X-Gm-Gg: ASbGncs/SkKU1vvs29qCJ9LytBaVqcwWpmn6033XNc2Q/8NyP2OzSOrraJPkSUm76RK
 kmDPb5RGXuSeqzkTtFvzYvBsFZNtI+To6lsvHWwuWaFJoyM0ptdAYPNcw6lzAAg86ETZnwMrMnS
 bTJDD+x3gbM+DOkVmY7L123gTwnarENnv25ZBtKqoS6EWB79BEE6cyAo4EdVTHz9GwEWWcCLvza
 gZz1Y9roGoZcXwHnQlcv5ffZPqUgGhuBrScF8VM5OPSlQtJhlU3XbNYFpB9jKwK8pisaFvmg+iQ
 rlLgyuKDmTIQCEcTdNCZut4Q28OhCJoydFWvpGnpDVQChV7F1IBpanQ=
X-Google-Smtp-Source: AGHT+IFx2WysadEeLACX1fps3M+PUmSSbq31EyhKWnwldBLJ25Msv7tSqHtMyfJdT0kBZuraeKRRBQ==
X-Received: by 2002:a05:600c:468e:b0:436:5165:f1ec with SMTP id
 5b1f17b1804b1-4389143145bmr387744865e9.30.1737973596046; 
 Mon, 27 Jan 2025 02:26:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d29cesm128530235e9.35.2025.01.27.02.26.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:26:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/15] target/ppc: Make ppc_ldl_code() declaration public
Date: Mon, 27 Jan 2025 11:26:07 +0100
Message-ID: <20250127102620.39159-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We are going to move code calling ppc_ldl_code() out of
excp_helper.c where it is defined. Expose its declaration
for few commits, until eventually making it static again
once everything is moved.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/internal.h    | 2 ++
 target/ppc/excp_helper.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 20fb2ec593c..46db6adfcf6 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -268,6 +268,8 @@ static inline void pte_invalidate(target_ulong *pte0)
 #define PTE_PTEM_MASK 0x7FFFFFBF
 #define PTE_CHECK_MASK (TARGET_PAGE_MASK | 0x7B)
 
+uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr);
+
 #ifdef CONFIG_USER_ONLY
 void ppc_cpu_record_sigsegv(CPUState *cs, vaddr addr,
                             MMUAccessType access_type,
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index fde9912230e..7ed4bbec035 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -144,7 +144,7 @@ static inline bool insn_need_byteswap(CPUArchState *env)
     return !!(env->msr & ((target_ulong)1 << MSR_LE));
 }
 
-static uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
+uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 {
     uint32_t insn = cpu_ldl_code(env, addr);
 
-- 
2.47.1


