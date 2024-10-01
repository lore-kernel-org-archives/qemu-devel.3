Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1C2CEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuX-0005Xz-0U; Tue, 01 Oct 2024 12:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuT-0005ON-53
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuF-00060N-N7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:36 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37cc4e718ecso3888779f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800762; x=1728405562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PsXUFBU3QruO38o0fdEqv/OvE0qQmtWUQI6Lq8K9+EY=;
 b=Lbbzut/dkR9HRajDIE/k5JpbYPSzxa6DD4em0WZhBGvQw4O2KloH0y02Eko7Yn4LTy
 B0y8G82aL/5Qg+LZUudq1C92Hef54cUdZSWpipsds8EsZKeCc1QnhPhbawB+Q+A8vmFX
 67Ww1WItDc7mSmda/ZsrzflQP/ca07fDDZhppoDkNDy7O3H1zGe/nMpTkVqeWs6bJCfo
 lxPd2R2V0gNH9QIcpXpKoayeZWQBkWxoLVnfSj/3RyTo43cf2NGoOvWk4ewiQb60kGOi
 XqmL0x21HAt4MRHbvTlpR8tl28KEjeZJWIXyC0fr2Skp0gs/kHTPofKtjRNm7nrlCyl/
 Kq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800762; x=1728405562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PsXUFBU3QruO38o0fdEqv/OvE0qQmtWUQI6Lq8K9+EY=;
 b=euW8KLpdq1q90kW78suUG0yBWm6ct3tmTV4M37ec+ffaJ8Fkj9C8B/GHKfpj2MNDT3
 qNJ8m7A1CQkqauqzk/7EV18WzTG3N1iOczJXFYNjjRtyDEoNyA8n8aCcIbZGEGYAqWbt
 YVp9+IjAUDTsvVrjDVjZj8g8t2GXg0/Pw9qYYqpDs2bjEt4jkn34rYwy3izUkxoMTnbS
 DjZOkVZcOpiHL4Jm7keTaDXTep0G4BPYpQonBWemX1mX6VeSRbRVy6GcpugNRqlZnQAX
 LkM9zsJQTIMONGxkdnLcqchc19/8/z/ZI0kmJrtUXdw8HpDCbTe6oxCEp2mGtuT41jXJ
 SpEQ==
X-Gm-Message-State: AOJu0YwrHJYziZKAjlBCX1GUWUrwM6eJbdgt44vdNbaFGBuODi3TUMIs
 mVlGCEyk4pxQO+UCB+rkctTz2X273P17K1BH1PrWgobIfuXD2qlDeCXQpSVvY5dnnnGGto5gM5P
 T
X-Google-Smtp-Source: AGHT+IGOVQClQdtVi+pOYONJpTwmymFdx30Ix4WMXBl9OoBV0sSUIlDUkWmomRLtBNajAM4vVOCowA==
X-Received: by 2002:a5d:4a0f:0:b0:37c:c802:888 with SMTP id
 ffacd0b85a97d-37cfb8aa860mr170927f8f.4.1727800762171; 
 Tue, 01 Oct 2024 09:39:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/54] target/arm: Avoid target_ulong for physical address
 lookups
Date: Tue,  1 Oct 2024 17:38:28 +0100
Message-Id: <20241001163918.1275441-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Ard Biesheuvel <ardb@kernel.org>

target_ulong is typedef'ed as a 32-bit integer when building the
qemu-system-arm target, and this is smaller than the size of an
intermediate physical address when LPAE is being used.

Given that Linux may place leaf level user page tables in high memory
when built for LPAE, the kernel will crash with an external abort as
soon as it enters user space when running with more than ~3 GiB of
system RAM.

So replace target_ulong with vaddr in places where it may carry an
address value that is not representable in 32 bits.

Fixes: f3639a64f602ea ("target/arm: Use softmmu tlbs for page table walking")
Cc: qemu-stable@nongnu.org
Reported-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Message-id: 20240927071051.1444768-1-ardb+git@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  4 ++--
 target/arm/ptw.c       | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c5d7b0b4929..1e5da81ce92 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1449,7 +1449,7 @@ typedef struct GetPhysAddrResult {
  *  * for PSMAv5 based systems we don't bother to return a full FSR format
  *    value.
  */
-bool get_phys_addr(CPUARMState *env, target_ulong address,
+bool get_phys_addr(CPUARMState *env, vaddr address,
                    MMUAccessType access_type, ARMMMUIdx mmu_idx,
                    GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
     __attribute__((nonnull));
@@ -1468,7 +1468,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
  * Similar to get_phys_addr, but use the given security space and don't perform
  * a Granule Protection Check on the resulting address.
  */
-bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
+bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
                                     MMUAccessType access_type,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index defd6b84de6..659855133c9 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -74,13 +74,13 @@ typedef struct S1Translate {
 } S1Translate;
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
-                                target_ulong address,
+                                vaddr address,
                                 MMUAccessType access_type,
                                 GetPhysAddrResult *result,
                                 ARMMMUFaultInfo *fi);
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
-                              target_ulong address,
+                              vaddr address,
                               MMUAccessType access_type,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi);
@@ -3217,7 +3217,7 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
  */
 static bool get_phys_addr_disabled(CPUARMState *env,
                                    S1Translate *ptw,
-                                   target_ulong address,
+                                   vaddr address,
                                    MMUAccessType access_type,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
@@ -3300,7 +3300,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
 }
 
 static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
-                                   target_ulong address,
+                                   vaddr address,
                                    MMUAccessType access_type,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
@@ -3405,7 +3405,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 }
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
-                                      target_ulong address,
+                                      vaddr address,
                                       MMUAccessType access_type,
                                       GetPhysAddrResult *result,
                                       ARMMMUFaultInfo *fi)
@@ -3542,7 +3542,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 }
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
-                              target_ulong address,
+                              vaddr address,
                               MMUAccessType access_type,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
@@ -3558,7 +3558,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
     return false;
 }
 
-bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
+bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
                                     MMUAccessType access_type,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
@@ -3571,7 +3571,7 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
     return get_phys_addr_nogpc(env, &ptw, address, access_type, result, fi);
 }
 
-bool get_phys_addr(CPUARMState *env, target_ulong address,
+bool get_phys_addr(CPUARMState *env, vaddr address,
                    MMUAccessType access_type, ARMMMUIdx mmu_idx,
                    GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
-- 
2.34.1


