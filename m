Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022B8CF2591
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06q2-0007Hb-8c; Sun, 13 Oct 2024 18:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06ph-0007Ce-Pq
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:13:02 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pg-0000xO-5A
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:13:01 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e2ad9825a7so2480641a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857579; x=1729462379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDNpltdoK5BIHBCpA0bLYhC/fVRvo8Z+4KE41wqkR3g=;
 b=A5xhuLMD5Tood3W5PdqLDsO5jGUdvunXfyte6dXi7/OMMEe2RDmbvVVa4GUjDgWy0p
 9XrrUubZf++zN8lCnJYaktIx2mri71oNPUgRwqqMcYP4fgn+EYcyhKnBc0AGlgP+K+7H
 hw0buD0V2B7o1zCJpk8SwzNjl1gWU7Rdzis11S2IkX2vHgU8HLUmrE7z8wrBc66qF+0Z
 vmXxDfvq4L5LJfxXnpQ+RphquBtYduJXlN1HYqpOrvHL17+nF5FV3Wd9qktmYj0fez6f
 j+ydzszzlfsTPclsjiw1c/XW/5tT37HMwBj8g5h5bxQcOSrwZSwYTRsQWhaOkWTAbLzT
 6Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857579; x=1729462379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDNpltdoK5BIHBCpA0bLYhC/fVRvo8Z+4KE41wqkR3g=;
 b=NhV+d/n8HhcR6SCA+Zx8yLtai+i9AwUjz6NzpGzemsXwbMgcujYPwmb8RMtr07OzA9
 LRVoTg7NKRuYYvEbNtWJXxzphbcLyBHARO290jx0FANoll6Y5jbpTaRaAEnOOWUycZFE
 55Dwg1Gho6AXeUBB3wYguJS6dV9p7UF2pjw7czEaJ+WlxLeIG8zBrOCsG1Fc+MuOOT44
 PbmENYzuCFq1yXqBfKFQB4fVahbujFbUf8sn/A8AsNnLVAfSuDOYV1V4S1aetWN0Ne5R
 u/NBxOtpNh2I7M73UgMVDLH0G/1eN1ujxqfVilWPTWzceO80Wudt+2QjPaVZ9PI9tLS/
 o2hQ==
X-Gm-Message-State: AOJu0Yz4qttA0/tywgbFIQcrCDHbmEoxeUpdOiEhpzM0HD5tzLeuiztD
 QmMoe/Dednga6N4+BvYgOgbmLosCC5XMY2RUaD+wTk+sBb8UzAd7oSAIJdAbZSvbbW849Zswuz3
 i
X-Google-Smtp-Source: AGHT+IHQhpFnqbb7myorjPUSvjw1PQblrlzAOqaM2r9BRe6AvBH4FsPVJaWYqALyTW8PkJ1X3QoywA==
X-Received: by 2002:a17:90a:e00e:b0:2e2:ede0:91c with SMTP id
 98e67ed59e1d1-2e2f0dc2e8cmr13128374a91.36.1728857578911; 
 Sun, 13 Oct 2024 15:12:58 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 24/27] target/arm: Pass MemOp to get_phys_addr_lpae
Date: Sun, 13 Oct 2024 15:12:32 -0700
Message-ID: <20241013221235.1585193-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Pass the value through from get_phys_addr_nogpc.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index f1fca086a4..238b2c92a9 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1684,12 +1684,13 @@ static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
  * @ptw: Current and next stage parameters for the walk.
  * @address: virtual address to get physical address for
  * @access_type: MMU_DATA_LOAD, MMU_DATA_STORE or MMU_INST_FETCH
+ * @memop: memory operation feeding this access, or 0 for none
  * @result: set on translation success,
  * @fi: set to fault info if the translation fails
  */
 static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                uint64_t address,
-                               MMUAccessType access_type,
+                               MMUAccessType access_type, MemOp memop,
                                GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -3534,7 +3535,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        return get_phys_addr_lpae(env, ptw, address, access_type, result, fi);
+        return get_phys_addr_lpae(env, ptw, address, access_type,
+                                  memop, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
         return get_phys_addr_v6(env, ptw, address, access_type, result, fi);
-- 
2.43.0


