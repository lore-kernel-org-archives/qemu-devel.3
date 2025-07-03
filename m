Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE57C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 18:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXObP-0003o4-84; Thu, 03 Jul 2025 14:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <charmitro@posteo.net>)
 id 1uXObJ-0003mw-04
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 14:24:01 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <charmitro@posteo.net>)
 id 1uXObD-0007mP-2p
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 14:23:59 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id A3769240029
 for <qemu-devel@nongnu.org>; Thu,  3 Jul 2025 20:23:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
 s=1984.ea087b; t=1751567029;
 bh=tZpaJVHAkliJPZ3G0I0UHMSBeXFjO7qarSjaVZhq4fs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=VlJFzHVRMbAZUva4VHzioGYauO2NeUJTG4e4DmwfseY+2dMbt3iaLGbPD/7nX8D95
 F2K8kSG5urudKkI6JGBCjxe5x8Z5asaL2rZ9jjd6t0UZ/ksrfyZeJSu0Kj/8HGT8tf
 f8yYS8dAvsn/t9kI4jW54AzMhHqoHnO8RzOsY9Ex8ms/obxuCBxhok6AL0NImK2NcQ
 hUAZm90KwYk21Q/Buj52/6OjURrWJ1F1Rb/FhU5UaCp3ehe6ZSGOs6ZQjeCBdqwu5x
 +YMqc8X9O7lAlymvzusFAXvY85XLQA0xTlvYaLJNj05ti4lYSeW2SOHTOmLXAeAcxx
 Tp6inOxNdkDva34rugAdJvEZw6FuEMDbo7fUv8hhrh/7J9NNvpqBNi00opUHAMIudX
 h57R7QDkEJwmYgaxWoRP3QcICa8ItxSSR02TdC8oKzoSHiAlC5hlOBOFKprNYrR4D7
 3ckhcnsRi/tZ1nVpg2ZCTWDMoQJ6elL8k8l4YSefGcy4xXRr6em
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4bY4sJ3LjFz6v0p;
 Thu,  3 Jul 2025 20:23:48 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 1/2] target/riscv: Fix MEPC/SEPC bit masking for IALIGN
Date: Thu,  3 Jul 2025 18:21:43 +0000
Message-ID: <20250703182157.281320-2-charmitro@posteo.net>
In-Reply-To: <20250703182157.281320-1-charmitro@posteo.net>
References: <20250703182157.281320-1-charmitro@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=charmitro@posteo.net;
 helo=mout01.posteo.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

According to the RISC-V Privileged Architecture specification, the low
bit of MEPC/SEPC must always be zero. When IALIGN=32, the two low bits
must be zero.

This commit fixes the behavior of MEPC/SEPC CSR reads and writes, and
the implicit reads by MRET/SRET instructions to properly mask the
lowest bit(s) based on whether the C extension is enabled:
- When C extension is enabled (IALIGN=16): mask bit 0
- When C extension is disabled (IALIGN=32): mask bits [1:0]

Previously, when vectored mode bits from STVEC (which sets bit 0 for
vectored mode) were written to MEPC, the bits would not be cleared
correctly, causing incorrect behavior on MRET.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2855
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 target/riscv/csr.c       |  8 ++++----
 target/riscv/internals.h | 11 +++++++++++
 target/riscv/op_helper.c |  4 ++--
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index fb14972169..c33a6e86d2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3126,14 +3126,14 @@ static RISCVException write_mscratch(CPURISCVState *env, int csrno,
 static RISCVException read_mepc(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
-    *val = env->mepc;
+    *val = env->mepc & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mepc(CPURISCVState *env, int csrno,
                                  target_ulong val, uintptr_t ra)
 {
-    env->mepc = val;
+    env->mepc = val & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
@@ -4113,14 +4113,14 @@ static RISCVException write_sscratch(CPURISCVState *env, int csrno,
 static RISCVException read_sepc(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
-    *val = env->sepc;
+    *val = env->sepc & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_sepc(CPURISCVState *env, int csrno,
                                  target_ulong val, uintptr_t ra)
 {
-    env->sepc = val;
+    env->sepc = val & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 4570bd50be..89ac6a160f 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -142,6 +142,17 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
     }
 }
 
+static inline target_ulong get_xepc_mask(CPURISCVState *env)
+{
+    /* When IALIGN=32, both low bits must be zero.
+     * When IALIGN=16 (has C extension), only bit 0 must be zero. */
+    if (riscv_has_ext(env, RVC)) {
+        return ~(target_ulong)1;
+    } else {
+        return ~(target_ulong)3;
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 /* Our implementation of SysemuCPUOps::has_work */
 bool riscv_cpu_has_work(CPUState *cs);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 557807ba4b..15460bf84b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -280,7 +280,7 @@ target_ulong helper_sret(CPURISCVState *env)
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    target_ulong retpc = env->sepc;
+    target_ulong retpc = env->sepc & get_xepc_mask(env);
     if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
                                     env->priv_ver,
                                     env->misa_ext) && (retpc & 0x3)) {
@@ -391,7 +391,7 @@ static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
 
 target_ulong helper_mret(CPURISCVState *env)
 {
-    target_ulong retpc = env->mepc;
+    target_ulong retpc = env->mepc & get_xepc_mask(env);
     uint64_t mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
 
-- 
2.47.2


