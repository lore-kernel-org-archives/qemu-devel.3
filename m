Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D263FCCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lK2-0002go-Oj; Tue, 14 Oct 2025 16:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lK1-0002fs-4U
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:37 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJ9-0005Ob-VT
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:36 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b6093f8f71dso3595661a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472459; x=1761077259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yz/BsnnxH/AGtjqnFOXBYx31cM+7NtxzeRTWBiS0WY4=;
 b=SVwJSC5fPsDSivo0qDED/Cezk9LRXjxdYy+PG8kH+lMGUk72k5z/k5/2nXwwfjd0Am
 ORmUeadGUsOhujGMRPg2eoR4hM+mbHtNBX6RF89QQybZwUv8dlO9zNJBeg5Hg+Ni4U8V
 +HWia/108ZJgmqKOL1/UvzMC5sXqxCEGRqGCuJHAsVmMVOEu3DL8gZMAfL3MiYvDoFHY
 KaEAgzfbdHPBkVn9S2+TFUKIgB4oADw/TSJlal90VThTCn/Iuj8f3Q5xjA5aZzJpg2b9
 +ImeATLXWuuh9cI5j8zW0IcCYLadJqlYCGrjKL/rdvL3bzLdQYeh3hTJWn1CznM7RDvn
 +KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472459; x=1761077259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yz/BsnnxH/AGtjqnFOXBYx31cM+7NtxzeRTWBiS0WY4=;
 b=CMdes4qSAP9agAkT27hq48jMZtxEC2p3iQYO2fZPQWkg3Z/WMWmT6Qbms7/H+TanOa
 HBhuOmuQY6G91W1fVb6415gxOSuWdq2hUFVmqWXaQ6uSuERiHqhAe8hS0J4Nz6WkA8cA
 JkrmI3rNSFz5s4mtuLFVI3ry8lAIv3Rej1Dd3LPsJOMM/9AOFxB1M13WFxi0lb0r1S1B
 /Mq7GifIdlLOshxEvX+fRQkCDwh84nU41xUl2CqH7iqvrwutECPp2038xXbDQCWdafw6
 0OiQbHO9xDo+utTWM3hchYiFwtWXh/UCwXUGoVcjv6o8/uAQycg1WE9V7WrCbI/WqKIq
 epCw==
X-Gm-Message-State: AOJu0Yx5zShhEH3UjBeVdBlgr3t3uuIvaY8TFopjGQeXaFx+lwEn4V0/
 LkdsUCxD3irj1ConusKD3I+qWFeVCLik7maoNVRXACilHONNmJTuBbjoTRT0yd1qs661TlSqgYD
 3wxNkU+s=
X-Gm-Gg: ASbGncsg/y3ZveYhoaEjyWSd0TzseWnuoVSHQEOX1mNzd7AVPsJBzlfBlfgNFqyWeKS
 +1GiEopqTKAEl0gJiJBf4xDZWJj/XCyihmBy4ufE60hyHPPy9LNdbmQjyYP2xieNNShry/bNRqY
 Q2gFEHm63c2BjXhLfceY5wUSoEmNaGGRBbS0Cfs1JZvcZ2YbJTON9SsUgqtltEExLf1XbC8vHuO
 7HfTB4OXZyS2ko41qtW7mS/aQX7Fq7o/5kAQs0g+Psn1XQiOHc4awMhcsHRtsbJr68HHf/ZQXzl
 09FTrBCqQTMEV0fNxhE5tlYOX4OXeRVSB1zd58o2H78C7uoHp1CuJ+8uvpIx/M0M4BCq9VKYQXz
 nCw7zcn+QjByR6z9vJZsGZHxy8aJ1XSjhk0ecImpitL3QRbKAcqc=
X-Google-Smtp-Source: AGHT+IGUnQe8IVLSARPXZ9y1ekfmbJ0bvi51uOVKcweeC0HmBBkl6XvwlT1+icnoRWNCj1iBu7ElrA==
X-Received: by 2002:a17:903:948:b0:249:37ad:ad03 with SMTP id
 d9443c01a7336-290273ee21fmr347600935ad.34.1760472458725; 
 Tue, 14 Oct 2025 13:07:38 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 27/37] target/arm: Implement TLBIP IPAS2E1IS, IPAS2LE1IS
Date: Tue, 14 Oct 2025 13:07:08 -0700
Message-ID: <20251014200718.422022-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 target/arm/tcg/tlb-insns.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index bf8f007869..f7510a1208 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -536,6 +536,17 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
 }
 
+static void tlbi_aa64_ipas2e1is_write128(CPUARMState *env,
+                                         const ARMCPRegInfo *ri,
+                                         uint64_t vallo, uint64_t valhi)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = ipas2e1_tlbmask(env, vallo);
+    uint64_t pageaddr = sextract64(valhi << 12, 0, 56);
+
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
+}
+
 static const ARMCPRegInfo tlbi_not_v7_cp_reginfo[] = {
     /*
      * MMU TLB control. Note that the wildcarding means we cover not just
@@ -719,12 +730,16 @@ static const ARMCPRegInfo tlbi_v8_cp_reginfo[] = {
       .writefn = tlbi_aa64_vae1_write },
     { .name = "TLBI_IPAS2E1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_ipas2e1is_write },
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_ipas2e1is_write,
+      .write128fn = tlbi_aa64_ipas2e1is_write128 },
     { .name = "TLBI_IPAS2LE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_ipas2e1is_write },
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_ipas2e1is_write,
+      .write128fn = tlbi_aa64_ipas2e1is_write128 },
     { .name = "TLBI_ALLE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-- 
2.43.0


