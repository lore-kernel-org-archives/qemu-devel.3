Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D04CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2g-0006Oy-3i; Sat, 05 Oct 2024 16:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2e-0006Nk-Mz
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:16 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2d-0001mb-15
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20b9b35c7c7so22719685ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158774; x=1728763574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1uh5v8Er5HwrssIP/tcmhd1DyyVCAW+cpRhBaU0frQ=;
 b=mIDgLo1YeoAjIlsCWmFQGzKzAAiQ/7g1smqZIr3qEPDWucOIJ/htjXDDOV4XBToFj5
 HO0qFZUhtxtCwlKYBxvj/4LiiB6MoNkALnJGNR5JIxX8XdjIQ9JFOyrAdDr3vGzuSDSJ
 mKYaQn/2bZgiK19UAR8X1kQOnlLnv+/0TmNCpaJcsn6P+zbpqECPrVcVslYGfqBlkKxg
 zenry6k7bMejARRn9knX0bc2Mqb0QgxvtK6y9UpyY2qZnf1W2ZnAIJ+MJsF+hCUqWtSk
 Unl6Lj+Q/SSu7awBGOmO6GpKy8+eS4Jk6wpZ1xkaXqj42B2VWaL+JzDX7uvTWA1rm2BG
 ucyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158774; x=1728763574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1uh5v8Er5HwrssIP/tcmhd1DyyVCAW+cpRhBaU0frQ=;
 b=IRzV94U4wsFVwJNQxavvAlDoSGNcbDC+HTKdxynbofuhnRnQZUCeZ66mB94mrkQGtv
 TUj5qVBTtGxjpH11FeEnQLrXS9VxjUMGboZXtt9s8FNYJXh6qvS7Aa6WK/2v7sAJRqzh
 rGO5NPSZ9wkvHTXouNwDIHUsMtImgckXyIlpwXmEdw2LKHEa7EBmJVrf7+dNgv16BIal
 iEOdrCds3kekinvWvPkXgjCGkiU6ibSg8kOPa3Jl6XTJBj7zAoR1rKWyNxZWSMerrZaa
 rO30RInCj2siWo8smzSrxzxl6mS0z1ZLcETaueVe6cjXA37UhWtYPZcB7mP/6fMJtm4H
 Cm0g==
X-Gm-Message-State: AOJu0YzGBF6JTmgocOfbgNbeadOOslk9MdtFZ7EwQeqRnAZACkHDGAK7
 0ttg3rixvTr+S6L4wT0ZGa55I5C239rn/f0AcZ73Xc0ByEOb2u7DO6FAGw2bPaEtVS6DsLU/Oa/
 W
X-Google-Smtp-Source: AGHT+IFuIEZa4i6J0XzDsWHUBnGbrBzjQrdOCbbZFKtwtRYvhgzw6qHzcnt8mJfy/cgTXRoh5crEPg==
X-Received: by 2002:a17:902:d4c6:b0:20b:b48d:68e with SMTP id
 d9443c01a7336-20bfde57cf8mr99495885ad.7.1728158773783; 
 Sat, 05 Oct 2024 13:06:13 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 13/21] target/arm: Pass MemOp to get_phys_addr
Date: Sat,  5 Oct 2024 13:05:52 -0700
Message-ID: <20241005200600.493604-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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


