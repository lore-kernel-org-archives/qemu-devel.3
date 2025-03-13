Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9071C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 19:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsoGb-00020A-HH; Thu, 13 Mar 2025 15:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tsoGA-0001qa-Kp
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:30:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tsoG1-0001fW-0M
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:30:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so1194536f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741894214; x=1742499014;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJ2zQvGxiUYLcbhnAMz/lOTZv04zTOkZOKcwj4LSpp8=;
 b=SyNvEofDK4KfJCLeGTO7URRqFbBSE6RN/zAML7wDWm2vBkq1UkvMwDTGCMGSuEHK3l
 27IGjJ3MsGbahaCjAs4Y0hd39z/LMNJPw8u670Z2UX56aYg+bn+XZY/5D04cMG8INI8Y
 hv7WYu6a1Ts5VwyYgIdV9iiybQMKLoynTbO98y0Wu6gh5bY5eAUMMJSAO0MNRnu38z2g
 iq2KHCY6gc9bVK7fWLTLyEPE/zzYksguwmmdij3thwOvJlBE9rR9p26aIAQLoOwEaoGp
 JVdFucr8Y3VBfj1JYIQ5vRDjU39BZzG1o32I3iC9jYzUljggPK7QXB4uWIoD9SKF9cr0
 mlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741894214; x=1742499014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJ2zQvGxiUYLcbhnAMz/lOTZv04zTOkZOKcwj4LSpp8=;
 b=fGxkkju8XXmdEi0HrZQcAWbU65NSjdDriTQ6aHPfH1gt3GEi2Yna68dYl31qxz9HHP
 ps5iUbWvOhNVngJLsyuKi6kaK0PKQLHLerw9Ys1lJIP/TqjbAsCmGyAnWWG0jscAMS4w
 kgUY1RRiNfWaC5dUD6v0WoQ1y0HNOST2rklNSsmBh/1eeq+Q/5ypK/UQHgNNeBk5X2gm
 o4fMefY11TV7/W8D0HMaUtmDXjY3rQz0XegokbfAN0bFPH5sBrf0sesIHU6/Tkash+2W
 TjOtBb8nDbau+u3Cc2py+rLt2Dju/GtfhDneTBC5D9V9sT9CXMQlqNqqUTkGBzkp5VKF
 7R7Q==
X-Gm-Message-State: AOJu0Yy1CKjkIFPSEwR7jurLILEPeOoVkPnophGOHDuazxTQpUymiDhK
 RD/zyvWb7MhXCx6HDDh4/x1R1huDYCCZz2QDjWLGUeqFGsPnmzH1sXKBqxVOlTSV4Q3FLEZXd+r
 EWpq9gmaY
X-Gm-Gg: ASbGnctjvIWPxNIzD13sUPI80Ec8AzgroKpQ74k60aOOP97Jo+GlxIEf+h1mWGSG3iV
 6SQJYmYqqJFJ+SbDWOBMKKFVqrliSC51lA84SmdEsETwSwfZjtzXry98LngStX/33J/2TI/88Yn
 ml/LSttDNPiQbwVYaggejW0tA0ztWNyhYwXRE4P5vhJJr4xXWKObsCMsRRXtEix9Em0Trx7c/VC
 wZxkBA0QmyZMDv5QPwY8MnGMG2Tz57CqixOwyBrUDN2wVfENHsqGP1SBMoFHhWQf7Mg7riDhdDf
 C/8HK9B9m2YaDRe9qr4S450J8/RLghNXlR7I4t78BnCso+KJlrRH3b3R1LD0C12W8zJIQneLb5L
 /FsObwWJRPXCsexcYKdC/vGOd5mWRzw==
X-Google-Smtp-Source: AGHT+IEZFrxt4Idjbjow2fyvnjTXhxcf+2Ikvrzaj2PCqhYzjIfUcaexPnBNftzUv63Zhtucr1hRSQ==
X-Received: by 2002:a05:6000:1f88:b0:390:dfa1:3448 with SMTP id
 ffacd0b85a97d-396c3838e83mr1008128f8f.43.1741894213834; 
 Thu, 13 Mar 2025 12:30:13 -0700 (PDT)
Received: from llx1.ba.rivosinc.com (lfbn-mar-1-50-94.w86-229.abo.wanadoo.fr.
 [86.229.28.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888152dsm3016421f8f.48.2025.03.13.12.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 12:30:13 -0700 (PDT)
From: =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
Subject: [PATCH v2 1/5] target/riscv: pmp: don't allow RLB to bypass rule
 privileges
Date: Thu, 13 Mar 2025 20:30:07 +0100
Message-ID: <20250313193011.720075-2-loic@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313193011.720075-1-loic@rivosinc.com>
References: <20250313193011.720075-1-loic@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=loic@rivosinc.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When Smepmp is supported, mseccfg.RLB allows bypassing locks when writing CSRs
but should not affect interpretation of actual PMP rules.

This is not the case with the current implementation where pmp_hart_has_privs
calls pmp_is_locked which implements mseccfg.RLB bypass.

This commit implements the correct behavior by removing mseccfg.RLB bypass from
pmp_is_locked.

RLB bypass when writing CSRs is implemented by adding a new pmp_is_readonly
function that calls pmp_is_locked and check mseccfg.RLB. pmp_write_cfg and
pmpaddr_csr_write are changed to use this new function.

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
---
 target/riscv/pmp.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index b0841d44f4..e1e5ca589e 100644
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
@@ -90,39 +94,38 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
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
-            }
+            readonly = pmp_is_readonly(env, pmp_index);
         }
 
-        if (locked) {
-            qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked\n");
+        if (readonly) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "ignoring pmpcfg write - read only\n");
         } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
             /* If !mseccfg.MML then ignore writes with encoding RW=01 */
             if ((val & PMP_WRITE) && !(val & PMP_READ) &&
@@ -524,14 +527,14 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
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
@@ -542,7 +545,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
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


