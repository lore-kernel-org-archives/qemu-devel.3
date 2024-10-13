Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73437CF2591
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06ps-0007Dr-3g; Sun, 13 Oct 2024 18:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pd-0007BO-Hn
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:58 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pb-0000wb-Sp
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:57 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e2eb9dde40so2029066a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857574; x=1729462374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUID/VOY3Ga2ZN/DeZx4JrZs9/xknXUyzF7dZ/9YQNo=;
 b=z2qlj6jVEtZytH6iGhGAM7nZJuSIBO4eJNb1VYC5ymPUUbepmgdMM3GQGaUI080Lhv
 jE7jZU7S0szKf/RuOAN9HRYo0aP6n50f10znxK8rCdj+4WQYIlO6C0GYEqtj6q8zX+hG
 1o3d38pqSfVW+pXq1mLOddeOUq2JXQ1Hfw8U+/1xLCf2XJsezZF6jvn6gRZcVtJRPbnj
 fFp0EYEMctz+mvz/Isb9ih9DkEbQOc6+uwjaDw2/pbxD6hAPcA2G+DdNGW3/JBc/aTVH
 dEIvgWYhOmXfs9R+9xc52tUK8DfuJ+ZkZqQJYbq56DUW6iFqwadR11wd98f1syTjZ8mU
 B9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857574; x=1729462374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUID/VOY3Ga2ZN/DeZx4JrZs9/xknXUyzF7dZ/9YQNo=;
 b=pKkXeREz1mwi3n0W5L52uLvdZpMx97ttWPQ4BaiGnQAVIMGtcPrUUDRL3n7bpoRNFB
 ldN0Oge4gBiNB9wp2GIg+9RaBWNWTwo6ICDIlsj99+go6OSL2JldwyjhvVcrnlsyRhW0
 wf22/RwA7UOVLSEoXOSx04lgeHubO7hGO7BCSuMUR3Ivw7lLFrDCewJNX5kPAqkgBvsX
 msgkVrqB4114epfcdULV6w3jRct4nF7yjAu7dgn/qmTYi1V7nOF1zN89Fy2VWeFLvF40
 z+ZFMycfAvhptwFKrU8aAAT0NaTzNJIWheuuhhapwXyp++zbz+rrnCoXeQzUqJaO8Skv
 j2aA==
X-Gm-Message-State: AOJu0Yw0QRzPP743Hw/j5Ldcx653KtFUGsSa0EYja/d1yD8SSkToYQcD
 vFRRz1woinGva/RzXX52zcOdoMYevJE85InbaNlVAGfZ70rCsb4MEn7ny8Cx3yUBcSORKItaeox
 O
X-Google-Smtp-Source: AGHT+IHIeiU5NWTWsngP6F8QfuBcm9ufih7hM2/3rCztS4GNSuZBGeCdiazmtHRCzjUJ91VRtGDnTw==
X-Received: by 2002:a17:90a:bf09:b0:2e0:d1fa:fdd7 with SMTP id
 98e67ed59e1d1-2e2f0d8dd21mr11930248a91.27.1728857574639; 
 Sun, 13 Oct 2024 15:12:54 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/27] target/arm: Pass MemOp to get_phys_addr
Date: Sun, 13 Oct 2024 15:12:27 -0700
Message-ID: <20241013221235.1585193-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Zero is the safe do-nothing value for callers to use.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      | 3 ++-
 target/arm/ptw.c            | 2 +-
 target/arm/tcg/m_helper.c   | 8 ++++----
 target/arm/tcg/tlb_helper.c | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1e5da81ce9..2b16579fa5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1432,6 +1432,7 @@ typedef struct GetPhysAddrResult {
  * @env: CPUARMState
  * @address: virtual address to get physical address for
  * @access_type: 0 for read, 1 for write, 2 for execute
+ * @memop: memory operation feeding this access, or 0 for none
  * @mmu_idx: MMU index indicating required translation regime
  * @result: set on translation success.
  * @fi: set to fault info if the translation fails
@@ -1450,7 +1451,7 @@ typedef struct GetPhysAddrResult {
  *    value.
  */
 bool get_phys_addr(CPUARMState *env, vaddr address,
-                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                   MMUAccessType access_type, MemOp memop, ARMMMUIdx mmu_idx,
                    GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
     __attribute__((nonnull));
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 659855133c..373095a339 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3572,7 +3572,7 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
 }
 
 bool get_phys_addr(CPUARMState *env, vaddr address,
-                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                   MMUAccessType access_type, MemOp memop, ARMMMUIdx mmu_idx,
                    GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
     S1Translate ptw = {
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 23d7f73035..f7354f3c6e 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -222,7 +222,7 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
     int exc;
     bool exc_secure;
 
-    if (get_phys_addr(env, addr, MMU_DATA_STORE, mmu_idx, &res, &fi)) {
+    if (get_phys_addr(env, addr, MMU_DATA_STORE, 0, mmu_idx, &res, &fi)) {
         /* MPU/SAU lookup failed */
         if (fi.type == ARMFault_QEMU_SFault) {
             if (mode == STACK_LAZYFP) {
@@ -311,7 +311,7 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *dest, uint32_t addr,
     bool exc_secure;
     uint32_t value;
 
-    if (get_phys_addr(env, addr, MMU_DATA_LOAD, mmu_idx, &res, &fi)) {
+    if (get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
         /* MPU/SAU lookup failed */
         if (fi.type == ARMFault_QEMU_SFault) {
             qemu_log_mask(CPU_LOG_INT,
@@ -2009,7 +2009,7 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx, bool secure,
                       "...really SecureFault with SFSR.INVEP\n");
         return false;
     }
-    if (get_phys_addr(env, addr, MMU_INST_FETCH, mmu_idx, &res, &fi)) {
+    if (get_phys_addr(env, addr, MMU_INST_FETCH, 0, mmu_idx, &res, &fi)) {
         /* the MPU lookup failed */
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_IACCVIOL_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM, env->v7m.secure);
@@ -2045,7 +2045,7 @@ static bool v7m_read_sg_stack_word(ARMCPU *cpu, ARMMMUIdx mmu_idx,
     ARMMMUFaultInfo fi = {};
     uint32_t value;
 
-    if (get_phys_addr(env, addr, MMU_DATA_LOAD, mmu_idx, &res, &fi)) {
+    if (get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
         /* MPU/SAU lookup failed */
         if (fi.type == ARMFault_QEMU_SFault) {
             qemu_log_mask(CPU_LOG_INT,
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 885bf4ec14..1d8b7bcaa2 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -344,7 +344,7 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
      * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
      * register format, and signal the fault.
      */
-    ret = get_phys_addr(&cpu->env, address, access_type,
+    ret = get_phys_addr(&cpu->env, address, access_type, 0,
                         core_to_arm_mmu_idx(&cpu->env, mmu_idx),
                         &res, fi);
     if (likely(!ret)) {
-- 
2.43.0


