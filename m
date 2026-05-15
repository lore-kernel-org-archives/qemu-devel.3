Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F9CCD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUl-0006ek-AS; Fri, 15 May 2026 10:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUN-00060I-8G
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:26:07 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUH-00011k-0D
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:26:05 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso5201533f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855157; x=1779459957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vA+cQBnC8tVbvSe9RbhVXRcVemldMP+qSodEma1dh88=;
 b=nCxZ1gWxX2NO8rdAx8x7oRSuhPmCuQ6jWXalV+VwFZPUzja7ZzsyInfHBueqqmOJP9
 anfZzuSVE+M8rcdSDnu5MVoJWcFV0KO6znUEF2cHMYhBldTqwNcOfNCdCyr0IjO4Fbul
 V8MdYFQKfPLOaKbBshFjpQ80jca93pGkAI/vPIRvuuURZsixoH43k6b8jOM1epxnZ9I/
 0bTdmFWVr6PIdNe1SIYgq+qOsAaGoi3XPdX9BmB8+0ZktcNxk+8OCxOagNL1IYaJIWha
 +NEpwEsgoT+/+Jytl7pjZXC4hF34egQu65kfOeioyDKDHP2yi6aVdiC3ejv4AQrFTCzK
 s5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855157; x=1779459957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vA+cQBnC8tVbvSe9RbhVXRcVemldMP+qSodEma1dh88=;
 b=BqYL8WY98hOOsL64Q2zIFNmJgKoO8RIXDQaC0pIJHPcBJhvQrNF0CEMKHWhO/LUJ16
 AcfE9g9kIdIplrrdaMZdsZKIhmbTLrp4MEgfgiH7thN7Dzm+UYMSVCZ84bzhutVvwaFR
 rc9ATp2CHjbv4716EoNaaH/nIRWSlSrWJhurwUYx4oYYjpejFoP7Xqz/zlQGNf1QrUPg
 KrlGpm+/Dxs0IU1n0pDYVlcrMf1VIArmdI5yIB86szQAO4MHgZUZBbUMeLXgbS5IZq28
 g1GUU1BqeKjXklXgQlFBPKIvsG1W9iOaou/J2/a7a5Ydm0wD5naxsMnmwk9bljy4WlyU
 lICw==
X-Forwarded-Encrypted: i=1;
 AFNElJ961FTbKNpvthwx8Q7TZjhRGrpWeb63AXCNH/b3nPweyy4I/KCquGs7rvwdxhQtyhKMT0/4vFEN+UNH@nongnu.org
X-Gm-Message-State: AOJu0YzUlhq+Ra327kETp+Og3NrnJpOoVwmRPdGNQLjb8gdBKmHylSGA
 ISDKNACQs7NWraSlxVaTa17H1CHlDe0NyG0cZJ4umUA5gEI0kgQw5Uy5wXrrxYo44xg=
X-Gm-Gg: Acq92OFUdvV7qlVcxtyWHgebGXH7ZmSHuvY7yP8i/Ji/gxsFBi4RMLXbRSyx8lkLG/x
 vv0FO9TxJOeG7Y7S8Xosl1tAjUQGFxDrBRyVnMH0Y1cdgtYV4Fw8v8w92k1mHT0UwPDEvqnTeyR
 LJUUXnlVTopoBZSZS8dymYpQ0NQmWX0EUIzAdhsIlLnP+zNcbHWXm1IiK4jExep3vuFjvBguEtH
 eig0sknlheJ6sOChBft4zcv9VFNfaf88LCsyuTUNn2V/nFQ+9gTzzgSI7oEVi6mLqNsX131UmUW
 vWSKy6H4UhNt6KRI4Qk6GdfZt//FhiZPq74k2fwhF8+zgqULbumsVUa4HEYFyJmSzvwYG3m6Ks+
 hpEoVy1yt+EVSiKOmiQYGvgsr24optdGYaqikbJ3sagn0jAoK/yGYbxeYySzI232Z/LWQn1bZD1
 uDWWOK6WOJS6DnkISH+ZFzLakU45L7SYyZrlCtSvhpadGQqXGuiOWL+OXZCZaR4+asUhn2jG/+8
 nBvWRoZ6fiVDcyCf5gzR90TcrqrDVkivY3h88qU4w==
X-Received: by 2002:a05:6000:2601:b0:456:e27d:d6aa with SMTP id
 ffacd0b85a97d-45e5c5b3975mr5677124f8f.2.1778855156777; 
 Fri, 15 May 2026 07:25:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 14/14] target/arm/ptw: Flip sense of get_phys_addr return
 value
Date: Fri, 15 May 2026 15:25:41 +0100
Message-ID: <20260515142541.571911-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
---
 target/arm/internals.h      | 2 +-
 target/arm/ptw.c            | 2 +-
 target/arm/tcg/m_helper.c   | 8 ++++----
 target/arm/tcg/tlb_helper.c | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 7fd8312477..d47ffb67c0 100644
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
index 6a002c25e1..8dc9c67712 100644
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


