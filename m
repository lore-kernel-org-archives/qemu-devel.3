Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E41CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmi-0000qa-A4; Tue, 26 May 2026 10:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmX-000068-VB
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmW-0001Kh-6Z
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so112878315e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805758; x=1780410558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nw9+ZkGYvqLC/PP3ScE0XL1JrYtjlJc9Fw+E/KuN0R8=;
 b=kmNtd7W0yXHkmsrn8fSLp+2fi3XDC1W1QBhaFj95qvUymhINC10Vz4D4Nvh/14jw9C
 Uz0GAixGHUL0dAV/p41htZjQn81BgoqOEJbeKlOqX0M7lGkLZpnJC687NTVoTtejMaSs
 I90eep6fQIuU/HqdZsXrWMuCKrd3fXm3DPI5ZPMEN1KGy5uPAlvWkxeQrhL0FuGkhgm0
 dYwtpD2VQ7KMlMnpUmDZqPyHWuuyxqlA9863UcVe6g51geA1g0mP9EtGoyDBiylI571O
 AOlf013kJ+kc/FDFWGH0Eac9PJU1jNzwHlE36s6CBOsV4a5k1Cp4b96T6BlyRSWZU3uD
 hTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805758; x=1780410558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nw9+ZkGYvqLC/PP3ScE0XL1JrYtjlJc9Fw+E/KuN0R8=;
 b=aAL2pzcYkLauByG3LRc8gNYHdQwDLyJpb5Khg3yHrMxP430XiUqIu/0CYJc9pDwMRK
 Mcp6EAKo3jK0o3hLSnPdpdOyq2fshNy0mvvnL3mmtOtLI1lHt1fyNMxOj7a5vB1dxE4/
 PqXftXfKc5LWac2V0fvW2+BtZfuQSdcUGm0va2U+gcWjhVEu0XM0b3bwsmfHKNbWrEJA
 wzvdLjFW2nQW0WNe+Y1MHdNGcg1Em07oOdzEAJTGpcZVRE8b8mBUBiSY4Htr17/qz9x3
 6GFDKiTbi2nipGVegMJQXWjp8O0DELkpKkxx04BVF84o/R8noqA6Cl4heJeRd5VDtR+x
 qoUA==
X-Gm-Message-State: AOJu0Yz0P8BoTsL+tu+VrK3xyiv2AoTHOlf9XW32uufzTFcW9z+5uVeK
 PCYA7zJsis0p4Zh4+eyGarJsSygstM/pDd+orM1AgQQj/9ziuXeqeKbsvV3cQrwHweX9x+DJOlI
 AMzDN
X-Gm-Gg: Acq92OHTBa9xKRcwmwdrdwL5byAxI4enB6mEJCl0ur1y6VuS9avJ+EMG+bpoVFUIYN8
 aY77UlE4N+XqoKcb6aaNC4QakBZ1ml41uvjGa20TXKxPBr0U43uWoldf43ERy9vAxbf2yHILreF
 MgLWXn3w9VXlbSKZhhmZBheEyyxiYsVC+pxouxdL83Xdp7MUcWWwTGRQkuk36qNPjgTO0LK5Bdx
 g/VaamAGiuL+ih5JsreyzwCME0chVDur5e6v2yQKF9M3+M7IVPY1DsygmRkIUu3KbW+VWsqILgk
 opbw8wZqPeR+gSOLUWcuXG/MFZLohwkDHwTU0uYYZTcW+A/lLe5bNY3bgzbkii6OFtPeCcjx9wT
 OtSA5XQvf8ia7puyy2PgH8WNOyYit2/z+V0uERkFShtou/9YKSKcuL7G3ZfWGVNQrfQJJ/XT2wM
 3M5lzi4JibdlDaKG8t8AKq0FkZPuaJtAbKFGFqPme8Y7VeriwbiBOpmOJXEaVzMVj+lmbsKBdXl
 gAzRlyaQjg1GriYoy7ccHtRaVq9/8bxNk2c0XQNQg==
X-Received: by 2002:a05:600c:46c6:b0:490:46df:a87a with SMTP id
 5b1f17b1804b1-49046dfa9c1mr330826665e9.1.1779805757705; 
 Tue, 26 May 2026 07:29:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/54] target/arm/ptw: Flip sense of get_phys_addr return value
Date: Tue, 26 May 2026 15:28:23 +0100
Message-ID: <20260526142850.2326589-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This completes the conversion of this family of functions to
returning true on success and false on failure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-15-peter.maydell@linaro.org
---
 target/arm/internals.h      | 2 +-
 target/arm/ptw.c            | 2 +-
 target/arm/tcg/m_helper.c   | 8 ++++----
 target/arm/tcg/tlb_helper.c | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 139c8d1769..fcc08ece90 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1500,7 +1500,7 @@ typedef struct GetPhysAddrResult {
  * by doing a translation table walk on MMU based systems or using the
  * MPU state on MPU based systems.
  *
- * Returns false if the translation was successful. Otherwise, phys_ptr, attrs,
+ * Returns true if the translation was successful. Otherwise, phys_ptr, attrs,
  * prot and page_size may not be filled in, and the populated fsr value provides
  * information on why the translation aborted, in the format of a
  * DFSR/IFSR fault register, with the following caveats:
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d1f23340aa..0a5201763a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3939,7 +3939,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
         .in_prot_check = 1 << access_type,
     };
 
-    return !get_phys_addr_gpc(env, &ptw, address, access_type,
+    return get_phys_addr_gpc(env, &ptw, address, access_type,
                              memop, result, fi);
 }
 
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f2059ed8b0..c5a553a5d4 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -222,7 +222,7 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
     int exc;
     bool exc_secure;
 
-    if (get_phys_addr(env, addr, MMU_DATA_STORE, 0, mmu_idx, &res, &fi)) {
+    if (!get_phys_addr(env, addr, MMU_DATA_STORE, 0, mmu_idx, &res, &fi)) {
         /* MPU/SAU lookup failed */
         if (fi.type == ARMFault_QEMU_SFault) {
             if (mode == STACK_LAZYFP) {
@@ -311,7 +311,7 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *dest, uint32_t addr,
     bool exc_secure;
     uint32_t value;
 
-    if (get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
+    if (!get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
         /* MPU/SAU lookup failed */
         if (fi.type == ARMFault_QEMU_SFault) {
             qemu_log_mask(CPU_LOG_INT,
@@ -2023,7 +2023,7 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx, bool secure,
                       "...really SecureFault with SFSR.INVEP\n");
         return false;
     }
-    if (get_phys_addr(env, addr, MMU_INST_FETCH, 0, mmu_idx, &res, &fi)) {
+    if (!get_phys_addr(env, addr, MMU_INST_FETCH, 0, mmu_idx, &res, &fi)) {
         /* the MPU lookup failed */
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_IACCVIOL_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM, env->v7m.secure);
@@ -2059,7 +2059,7 @@ static bool v7m_read_sg_stack_word(ARMCPU *cpu, ARMMMUIdx mmu_idx,
     ARMMMUFaultInfo fi = {};
     uint32_t value;
 
-    if (get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
+    if (!get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
         /* MPU/SAU lookup failed */
         if (fi.type == ARMFault_QEMU_SFault) {
             qemu_log_mask(CPU_LOG_INT,
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index bbe1e70bc4..f90765cb59 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -361,9 +361,9 @@ bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
         fi->type = ARMFault_Alignment;
     } else if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
         fi->type = ARMFault_Alignment;
-    } else if (!get_phys_addr(&cpu->env, address, access_type, memop,
-                              core_to_arm_mmu_idx(&cpu->env, mmu_idx),
-                              &res, fi)) {
+    } else if (get_phys_addr(&cpu->env, address, access_type, memop,
+                             core_to_arm_mmu_idx(&cpu->env, mmu_idx),
+                             &res, fi)) {
         res.f.extra.arm.pte_attrs = res.cacheattrs.attrs;
         res.f.extra.arm.shareability = res.cacheattrs.shareability;
         *out = res.f;
-- 
2.43.0


