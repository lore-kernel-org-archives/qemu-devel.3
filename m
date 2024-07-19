Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D59FC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc6k-0005kV-2i; Thu, 18 Jul 2024 21:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc5y-0003Hv-UV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:41 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc5u-0000mD-7N
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:36 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fc566ac769so11728665ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721351249; x=1721956049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/SUfCnTpRQkNLbtLFhLzUNUB0u06MHsZx7MB+lBLUc=;
 b=YjsquKBmU2OKdeWRj5y1IYkFT2Zoirmb0L1jzJ2KhT05hfp0dQxPUXj3ncMB+rttK3
 tGRQNXKhXH99C0UfDurBpmCPPUXkqb3y5BVnABvrtcfG4DX+rHE2W475Rn2lt8xBKEYy
 /K4Vy1QQurMEkFF43HQpn147EnpJWfTlK5CR3DKfwBxsEi9EMTNLRjv3vsbRMfRQhrlW
 Fu6WU2IPCHwSMnADfCo+wN2y/fV1+SWiCmgvU0k0CRkcJOT1GRtlzf2wwXP01rO7Rzc4
 e0i5090qUXSx3Cu/81TVh0upS0zVQLPAUvczuHwQotk1MEqoAUyOLrHHOtCFxkSKEOfF
 Fsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721351249; x=1721956049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/SUfCnTpRQkNLbtLFhLzUNUB0u06MHsZx7MB+lBLUc=;
 b=Il+mivfuIxzCr1upA12ojQrrSKnqFcp/10dGkIrPhXvZ9kHEJ8kKcBENpQjQRrqqzj
 XZB8eHr80x/xMA47jQMLmKQlN7V9+T3QyOBtqsODppDaXRvYKw0vwvj82MWVmxkKt9u4
 GSdmir01cDiDs2RywNKjW9LsFti0XmLgCG6XsYtqAu1zo1ALoDrDN62SFofbLwbLNvdE
 9mLdw/LEyKrAIOvKLu4P6cnqI+xZDoqqRDRGYe5LYRQYlmJCOxtiy/kP0APfMMZQ/iyg
 Wd3F93KYY7qHRRqTALD9X+5llilvwsEDtwWXIFsP6pi4V9fQ4ho5ksURRTd1pwoF0Sm8
 fgLQ==
X-Gm-Message-State: AOJu0YwMmrshZt9qw79HQHgiCGAc9GOpNPzd5DjLWC7GQ9ftOIv50m0E
 0BjAox4dYrk0fFPp1Amu+1XNDH3SMf0cQOuDUWzR3ALQ7KNrWC+RTLb0rtk6B7IRiTk82d2bIyn
 kU+YYdQ==
X-Google-Smtp-Source: AGHT+IHQAnSGOWBHimOCTiszD0Dzf/Awm3haLVGX0zJgVaqeM7yCqPcJrzDh730KnsTFHjg8rW5A/A==
X-Received: by 2002:a17:902:db0d:b0:1fb:1b16:eb80 with SMTP id
 d9443c01a7336-1fc4e15c311mr52103855ad.26.1721351248839; 
 Thu, 18 Jul 2024 18:07:28 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d07ad9sm2067415ad.177.2024.07.18.18.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 18:07:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v3 04/12] target/ppc/mem_helper.c: Remove a conditional from
 dcbz_common()
Date: Fri, 19 Jul 2024 11:06:59 +1000
Message-ID: <20240719010707.1319675-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719010707.1319675-1-richard.henderson@linaro.org>
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Instead of passing a bool and select a value within dcbz_common() let
the callers pass in the right value to avoid this conditional
statement. On PPC dcbz is often used to zero memory and some code uses
it a lot. This change improves the run time of a test case that copies
memory with a dcbz call in every iteration from 6.23 to 5.83 seconds.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20240622204833.5F7C74E6000@zero.eik.bme.hu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mem_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index f88155ad45..361fd72226 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -271,12 +271,11 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
 }
 
 static void dcbz_common(CPUPPCState *env, target_ulong addr,
-                        uint32_t opcode, bool epid, uintptr_t retaddr)
+                        uint32_t opcode, int mmu_idx, uintptr_t retaddr)
 {
     target_ulong mask, dcbz_size = env->dcache_line_size;
     uint32_t i;
     void *haddr;
-    int mmu_idx = epid ? PPC_TLB_EPID_STORE : ppc_env_mmu_index(env, false);
 
 #if defined(TARGET_PPC64)
     /* Check for dcbz vs dcbzl on 970 */
@@ -309,12 +308,12 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
 
 void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
 {
-    dcbz_common(env, addr, opcode, false, GETPC());
+    dcbz_common(env, addr, opcode, ppc_env_mmu_index(env, false), GETPC());
 }
 
 void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
 {
-    dcbz_common(env, addr, opcode, true, GETPC());
+    dcbz_common(env, addr, opcode, PPC_TLB_EPID_STORE, GETPC());
 }
 
 void helper_icbi(CPUPPCState *env, target_ulong addr)
-- 
2.43.0


