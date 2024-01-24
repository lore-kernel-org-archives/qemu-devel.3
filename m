Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99D5C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 12:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rScnY-000334-3R; Wed, 24 Jan 2024 07:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rScnV-00032J-UF; Wed, 24 Jan 2024 07:56:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rScnT-00018J-O8; Wed, 24 Jan 2024 07:56:05 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5E56ACE30FF;
 Wed, 24 Jan 2024 12:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E90C43390;
 Wed, 24 Jan 2024 12:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706100957;
 bh=ry0lR4qMXsSwWVpsn6ghkeTk9xoq40DbZT3PJKglEhE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H9M2V3BYLs1uIEBoVC6fwCFW2ipVCtRwNyfgIM18atHcjq2kJqbpQhqjy8eUX3V3v
 yEVjYMDidMnXjd5NYFN5g2nkgxxstDNZAn8vQre3tryNUOSQsZKboH8fmN9sCg7qZp
 CwdA3YVIm/4KVXK4aeWG2uvS9bcENIRD6Y53/ka7lPkHIZAfFAWpuPSHh3NUtjPpSk
 SnVZS4/ba25kMyToCbeB65epZtUsKTgzDaC3Yhqnoz05i1zvwq41YgQjzMN6U/AE0b
 80eHqpIZ2RpeQaT3Xq+bBpGOpYDC6RzCM/asuI5GldWNcyKR3EBkXoeB4A9soWwWdI
 xx71aPIOr394Q==
From: Conor Dooley <conor@kernel.org>
To: qemu-riscv@nongnu.org
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] target/riscv: use misa_mxl_max to populate isa string
 rather than TARGET_LONG_BITS
Date: Wed, 24 Jan 2024 12:55:49 +0000
Message-ID: <20240124-swear-monthly-56c281f809a6@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124-squatting-getup-a16a8499ad73@spud>
References: <20240124-squatting-getup-a16a8499ad73@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734;
 i=conor.dooley@microchip.com; h=from:subject:message-id;
 bh=QS/0f+ukaw2mCU94HDKZEschftslg3jvKGDRD/+PYLQ=;
 b=owGbwMvMwCFWscWwfUFT0iXG02pJDKkbOa4kfX97aX2j4dx+47enbhgq7G+cmL1E/KqxoRnPh
 1Sus5wbOkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRe28YGaYqvXbfYn5i5e7M
 c4LCSqnmG8rW/D2Umdj9Ys+0uc8Vp0Qx/PcvnRO5QPTKXKaY5j7l1vkiZzbN6nuisaRGr33qnEy
 PGF4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp;
 fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=conor@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Conor Dooley <conor.dooley@microchip.com>

A cpu may not have the same xlen as the compile time target, and
misa_mxl_max is the source of truth for what the hart supports.

The conversion from misa_mxl_max to xlen already has one user, so
introduce a helper and use that to populate the isa string.

Link: https://lore.kernel.org/qemu-riscv/20240108-efa3f83dcd3997dc0af458d7@orel/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I dropped the tags since I added the helper
---
 target/riscv/cpu.c     | 9 ++++++++-
 target/riscv/cpu.h     | 1 +
 target/riscv/gdbstub.c | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ad1df2318b..4aa4b2e988 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -307,6 +307,11 @@ void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext)
     env->misa_ext_mask = env->misa_ext = ext;
 }
 
+int riscv_cpu_max_xlen(CPURISCVState env)
+{
+    return 16 << env.misa_mxl_max;
+}
+
 #ifndef CONFIG_USER_ONLY
 static uint8_t satp_mode_from_str(const char *satp_mode_str)
 {
@@ -2332,7 +2337,9 @@ char *riscv_isa_string(RISCVCPU *cpu)
     int i;
     const size_t maxlen = sizeof("rv128") + sizeof(riscv_single_letter_exts);
     char *isa_str = g_new(char, maxlen);
-    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
+    int xlen = riscv_cpu_max_xlen(cpu->env);
+    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", xlen);
+
     for (i = 0; i < sizeof(riscv_single_letter_exts) - 1; i++) {
         if (cpu->env.misa_ext & RV(riscv_single_letter_exts[i])) {
             *p++ = qemu_tolower(riscv_single_letter_exts[i]);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 05e83c4ac9..aacc031397 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -511,6 +511,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
+int riscv_cpu_max_xlen(CPURISCVState env);
 bool riscv_cpu_option_set(const char *optname);
 
 #define cpu_mmu_index riscv_cpu_mmu_index
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 58b3ace0fe..f15980fdcf 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -218,7 +218,7 @@ static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
     CPURISCVState *env = &cpu->env;
     GString *s = g_string_new(NULL);
     riscv_csr_predicate_fn predicate;
-    int bitsize = 16 << env->misa_mxl_max;
+    int bitsize = riscv_cpu_max_xlen(*env);
     int i;
 
 #if !defined(CONFIG_USER_ONLY)
-- 
2.43.0


