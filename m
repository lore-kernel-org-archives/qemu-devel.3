Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73789C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrsc-0002cP-7l; Mon, 19 May 2025 00:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmZ-0004j9-G0; Mon, 19 May 2025 00:07:21 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmX-00044s-ER; Mon, 19 May 2025 00:07:18 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b26ee6be1ecso1638717a12.0; 
 Sun, 18 May 2025 21:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627634; x=1748232434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTIvHcAFACQpxbEMKQQmOLfJuML6Aq0ZlBGdT+L1BSU=;
 b=KZZHIFoqqoNl0nGzs4UxyHdmp/NSm1RiWsz+/cWhWip6LPH+uEvdGjTi6+tYPyFDyu
 Mh7ChvJvvj2cVt7E/sM7S8Vweq5EW6jVl64Y3mxMJ7/oVjY5uRpXSFTYsyzL48l24QUN
 ZZVE7bxwTFqs49fAqtVtnqrmOFhkUg2Z+irTTELrrXQzIVyQw09KcQisK4laq9nrOk96
 6WNkF5LiEWzj/gMWgWN8Hrfwbp+2OxXXEBqQg7vEVUdt3mHBolAe9XV5TjdTo1IFL2hp
 pjyK0AItqMAD2NdoDybEOJjuPY8QE4md2mP5CwxOvAsYtfO+vN8giwUJKc7p7k+Mou8E
 4ZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627634; x=1748232434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTIvHcAFACQpxbEMKQQmOLfJuML6Aq0ZlBGdT+L1BSU=;
 b=Uz1UC75NlDvFcbkxXZDQxCmh+hAYVQwdp9QiPmPP9F4YsWN09b0B/ABNpfe00L2d7v
 6eMGy/V3VUqVk9+AMQ/Ys4uR8AS2Ah2/Ve0021hIcCRn9m1pkiUwF3zdo0tswkHQWxhP
 KHDuPbrtU1NvyIoG/rdnj+NABYbbsTarYNzu7L/GyezC5o8UppAULEdEyow1aiJYUOak
 O19HAI1HVt0m5MQzYFsCNAxaM27c2iqJZTQpP7tkliEoDDSUg5j4G8uEf/nZ+A8juZKc
 0zqgkXBvvgRFjAtCxiFeq2OGfFMtEdTqcEyK/SsRH6uL5SiRdRe138muVwpNQdiaWrFu
 SxUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCBnbah34NB+RwvjhA08aCWRxm75EjFfdOVBNlnJnVWY689IsZfraQIe21e1t+TSkg3uP2QK/AbZfi+w==@nongnu.org
X-Gm-Message-State: AOJu0Yy+QhrnU+ibJ8K2FIEYppCc4R1Iz0b3BTVu3ZeIBXxrw9KcPlvi
 6dLBhI5WcbCDvIltapcUfB5OC/Nli0CBEVl2soe0OeLnV1QZSCpcWROlLJoAEw==
X-Gm-Gg: ASbGncu1z1B9+UdG9lORSl6fr4oawZdrqiLSX2wQ9IWIAtEu8K8CEP3EIwm0K4j5l2r
 ReOJP6XvttUopH7K+fGfhmfv3qBrFvbVG1//egayktO58on7wxLmvFTXqYjt4qPSlnm5JFPeE7R
 ecN0H7ExL2Vecu1G4vKNnAbBjblbO9H9c03BXUkcQHhy3Z/yxGUWVXTYF/W3UhGJ0eJ2bVKXXfV
 Zu8MHIy8I6vtwflT1XTJa8VPvBD24vvSC1yRRvwgMcM1EviuEdpVjQuLCk6EiyRcXXtsJAzjTgd
 xCQ+HhA5kM3Zi18T+J97NoWfOsEvDnX9Ntad7fAHOcUD9tchA5U+EYsJkD5mCzJyeQMMTw/0lhM
 tjiD+V1/gVIt8HfdYasGemB6braylQPKeUjpo3yg0KsfPDXQCG7+8heVrXO90llhMB6M=
X-Google-Smtp-Source: AGHT+IHVZyQRDYIxJyiL91I/9mVazjNn5i+tqrvUZoeyS1x9XaXQgc1SdC06ZmFkm4oEak8DIcL3PQ==
X-Received: by 2002:a17:903:228b:b0:224:1157:6d26 with SMTP id
 d9443c01a7336-231de352994mr150114505ad.4.1747627634355; 
 Sun, 18 May 2025 21:07:14 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:13 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?LIU=20Zhiwei=C2=A0?= <zhiwei_liu@linux.alibaba.com>,
 qemu-stable@nongnu.org
Subject: [PULL 03/56] target/riscv: pmp: don't allow RLB to bypass rule
 privileges
Date: Mon, 19 May 2025 14:05:00 +1000
Message-ID: <20250519040555.3797167-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Loïc Lefort <loic@rivosinc.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei  <zhiwei_liu@linux.alibaba.com>
Message-ID: <20250313193011.720075-2-loic@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/pmp.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index c13a117e3f..d8e2949aaf 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -46,11 +46,6 @@ static inline uint8_t pmp_get_a_field(uint8_t cfg)
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
@@ -63,6 +58,15 @@ static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
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
@@ -91,39 +95,38 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
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
@@ -525,14 +528,14 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
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
@@ -543,7 +546,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
             }
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
-                          "ignoring pmpaddr write - locked\n");
+                          "ignoring pmpaddr write - read only\n");
         }
     } else {
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.49.0


