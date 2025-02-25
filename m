Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE424C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxOk-0000TY-Oo; Tue, 25 Feb 2025 11:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tmxN2-0007HB-D8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:01:20 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tmxMt-0001wo-VY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:01:19 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43989226283so39924775e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740499257; x=1741104057;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1upG3QxbU0TZ9a6nDq0D3oxnkr9zAA+ZcBirmsMASI=;
 b=qVwGRwBqeO4MztVFXbgJF/8zxBDThIkdqU47Fmyf2Cdnj6HZDeFThERTIAQmZP17Kj
 0YthyhB7KKcHgpn/cru8yxLP+51Vsokxq5hF7DyxXDDIHxSKRehwqgpLe8ED0cKkgIah
 bBlcn/AnOQ14uklhvIOKQ3+pB2eCuu9uw52JKmV/2s39l6mW63zTwD9uIsf2HgbeQfa5
 sc2vYA0BTIKgdbyweR0pTMciWxCMQvxYiHCP+O0yov8rCPQ660Z8woHVkejAipPbfYtG
 rXmAhZlK2o1lHOiAvu1Nj3z05ep6mzEMjZzE2BlEvO/BfPQT/haconha77JWruJyHhjJ
 OLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740499257; x=1741104057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1upG3QxbU0TZ9a6nDq0D3oxnkr9zAA+ZcBirmsMASI=;
 b=g2ZrMGTo47A00s3M+WJ0b2ROHIahLGPtqMRsy3JJoY3NMIIkog8M0o/8UcKzTct+cw
 mUbIScRLdwLGmBUY++0mBolE+oPPw3JVYJQNjSswAA689Qjf7pZNOr/v3B8343GtcSBj
 cj62bv/mgEluhTZmyqIzffriKkbKymEY3ahTMlFVeOQcEC5ShS/RZk/YqeLlCS24JpEw
 usXG/B77Da2oE38fBZ+JgvblaLN4ZOaaNc/MQCIBbDlnVC+dwCM3cIrnm5EO1ghJ8azr
 Ig6F76FcUEK+uEM7vrovTAnSgwgyd+zZAwcx/GHBSEqXiy85b8EYFlyjtPxyXJX3IiIh
 P9uA==
X-Gm-Message-State: AOJu0YxDqL/OwoUAQIzcMGdqYlQ1tGVs9fOGSWwttfIoymDcnTEmto3M
 DSc8y/xiKo9GG0Yt6h0O/ssfL/jLjxFRqHMU5lvN+piGjhzO/n2YhpJ04xHE1bsJWHOQKty+Tve
 ODe67TCBC
X-Gm-Gg: ASbGncsbChScumn3LxvqhfjQETgc9MxO/42J4Bi0cCH6vkMaDxASiIumMaGNkcedPyJ
 z0pGNlAv/j920tDGdMfvuTgJw5bELAqsNX0ypsxyxaJMCFkWFggtDC0AUAkjNae5sbjcIQZ2l9y
 oHyprul5uA+4c4RFshecuY3uQnOfpb4HK9mY3ci/AmC/Tslhr2Vghl2CH7luu2tRxiNPcbXZMxV
 vr8rI0roYiYdXMJ4v0dqgz2YqaGuLAbd7rZH2b4ryTCfnylDkkaqalHAlaeELd2mNMuDu0vnwF3
 84NC+6zuPF6qMVvTRNXQuCH6alk6kw66fJPMAXyNX0f3e2QdM6arFnFnorMPhRdqs4hYrwhhow=
 =
X-Google-Smtp-Source: AGHT+IF8IT2SVbKmiK7fu/uyxWlVtw67ma6/xAsxErSdZ9xHZoKERocGG4ZsYy0TuTmJHJ+D/+3QDA==
X-Received: by 2002:a05:600c:5253:b0:439:a093:fffe with SMTP id
 5b1f17b1804b1-439ae1e9601mr159030085e9.7.1740499255764; 
 Tue, 25 Feb 2025 08:00:55 -0800 (PST)
Received: from llx1.cad.pilog.net (lfbn-mar-1-50-94.w86-229.abo.wanadoo.fr.
 [86.229.28.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab1546df4sm30530755e9.17.2025.02.25.08.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:00:55 -0800 (PST)
From: =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
Subject: [PATCH 1/5] target/riscv: pmp: don't allow RLB to bypass rule
 privileges
Date: Tue, 25 Feb 2025 17:00:48 +0100
Message-ID: <20250225160052.39564-2-loic@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225160052.39564-1-loic@rivosinc.com>
References: <20250225160052.39564-1-loic@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=loic@rivosinc.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When Smepmp is supported, RLB allows bypassing locks when writing CSRs but
should not affect interpretation of actual PMP rules.

pmp_is_locked is changed to only check LOCK bit and a new pmp_is_readonly
function is added that checks both LOCK bit and mseccfg.RLB. pmp_write_cfg and
pmpaddr_csr_write are changed to use pmp_is_readonly while pmp_hart_has_privs
keeps using pmp_is_locked.

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
---
 target/riscv/pmp.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 85ab270dad..ddb7e0d23c 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -45,11 +45,6 @@ static inline uint8_t pmp_get_a_field(uint8_t cfg)
  */
 static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
 {
-    /* mseccfg.RLB is set */
-    if (MSECCFG_RLB_ISSET(env)) {
-        return 0;
-    }
-
     if (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_LOCK) {
         return 1;
     }
@@ -62,6 +57,15 @@ static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
     return 0;
 }
 
+/*
+ * Check whether a PMP is locked for writing or not.
+ * (i.e. has LOCK flag and mseccfg.RLB is unset)
+ */
+static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
+{
+    return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
+}
+
 /*
  * Count the number of active rules.
  */
@@ -90,39 +94,40 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
     if (pmp_index < MAX_RISCV_PMPS) {
-        bool locked = true;
+        bool readonly = true;
 
         if (riscv_cpu_cfg(env)->ext_smepmp) {
             /* mseccfg.RLB is set */
             if (MSECCFG_RLB_ISSET(env)) {
-                locked = false;
+                readonly = false;
             }
 
             /* mseccfg.MML is not set */
-            if (!MSECCFG_MML_ISSET(env) && !pmp_is_locked(env, pmp_index)) {
-                locked = false;
+            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env, pmp_index)) {
+                readonly = false;
             }
 
             /* mseccfg.MML is set */
             if (MSECCFG_MML_ISSET(env)) {
                 /* not adding execute bit */
                 if ((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) {
-                    locked = false;
+                    readonly = false;
                 }
                 /* shared region and not adding X bit */
                 if ((val & PMP_LOCK) != PMP_LOCK &&
                     (val & 0x7) != (PMP_WRITE | PMP_EXEC)) {
-                    locked = false;
+                    readonly = false;
                 }
             }
         } else {
-            if (!pmp_is_locked(env, pmp_index)) {
-                locked = false;
+            if (!pmp_is_readonly(env, pmp_index)) {
+                readonly = false;
             }
         }
 
-        if (locked) {
-            qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked\n");
+        if (readonly) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "ignoring pmpcfg write - read only\n");
         } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
             /* If !mseccfg.MML then ignore writes with encoding RW=01 */
             if ((val & PMP_WRITE) && !(val & PMP_READ) &&
@@ -524,14 +529,14 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
             uint8_t pmp_cfg = env->pmp_state.pmp[addr_index + 1].cfg_reg;
             is_next_cfg_tor = PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg);
 
-            if (pmp_is_locked(env, addr_index + 1) && is_next_cfg_tor) {
+            if (pmp_is_readonly(env, addr_index + 1) && is_next_cfg_tor) {
                 qemu_log_mask(LOG_GUEST_ERROR,
-                              "ignoring pmpaddr write - pmpcfg + 1 locked\n");
+                              "ignoring pmpaddr write - pmpcfg+1 read only\n");
                 return;
             }
         }
 
-        if (!pmp_is_locked(env, addr_index)) {
+        if (!pmp_is_readonly(env, addr_index)) {
             if (env->pmp_state.pmp[addr_index].addr_reg != val) {
                 env->pmp_state.pmp[addr_index].addr_reg = val;
                 pmp_update_rule_addr(env, addr_index);
@@ -542,7 +547,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
             }
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
-                          "ignoring pmpaddr write - locked\n");
+                          "ignoring pmpaddr write - read only\n");
         }
     } else {
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.47.2


