Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C96109447F
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3x5z-0006To-2v; Sat, 21 Mar 2026 10:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x5y-0006TN-7C
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x5w-0003nT-4G
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:29 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82c20f1e890so937809b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774102467; x=1774707267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FY1vY5A9lfdd8TffAjYpcK3liJc1Z//+Qu5oJPrNd9c=;
 b=MbFNVPIvlLn7JehSfEQCxEgtZFBA5p9imHsa24vgux6ai6+Ksq6uLVo4nQcypOCxe1
 hQuNWPUE3UYP9EGr2IhwhjkGdVoOGHv6G/JB7IpjOE9+aXLCDRU3qXLW0IcJnKV5doVw
 gbqVF/ixJsgv/YsA8swKJU6gq74rCwxOJZPcsA60K2LquFhuvLUHlMvlzoV3gaBwpDiq
 Lh4PayPxBJLRwhGu/jxeZBeJNFMuA5aBqOSIpnqCdANu1Mwj4bkRoJQgYfbubb6XzBEo
 CLNHB7kgxRVyqcIkMeIRNXLJaENRf2F3dn9odPdHSQRp4eehUBH3MBrnzrEQsz5p2yyG
 +h4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774102467; x=1774707267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FY1vY5A9lfdd8TffAjYpcK3liJc1Z//+Qu5oJPrNd9c=;
 b=GSqP5wlXAp4UXKQjC1VKYAq0a6vsFBfmCCYan8BPaZaBFqGDilJvH61FJ7u2TOv9YL
 Hf+tvBaNC4cnMo24l4z8TmivXcrgbeYKt01PxiaLC08M+d05nqTt2XE139is5nMsINuP
 yR/X3TNgNBv/YDkb1LhTfGdr9yCAKakNO8wcvUd4aVWLMTlDmeq3iMG3LtKAozSDtpNm
 86E9VP101wRY/Sj9l1y/pFLhld0Y2TSK/VroSUUlaN9VB/hrX2371h4Z5D3p4M70WS5r
 kQ1+DsgsMJjbfeG3KjGCnEUiN9+lYRWaXcntG/JQFq3Hlr3uXI3mx1hc85g5skMJztzb
 HPuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKta9ETPN5wYQBvVDH7O6pchwFXHcnmLr9Ho1qU31or2WaQiKyRq2axelNvFswB8RdZV9MR73Fye5Y@nongnu.org
X-Gm-Message-State: AOJu0Yznrhs66Y8ziuyAioo8mxOc+MzTooAbrH7Cd5xT6eZhkq0g5re8
 nGO/o7oRGNx6Rz16FRECsHGXSG6kMC2eA/nNJ7CL9tYIcQ2tAe3i2/JnJRdCMg==
X-Gm-Gg: ATEYQzyrY7hqKjrU2ov60s4exZ6yNAJkkYsX9ZQbMLC0Js5Lm37s7tsC06lbCLQpW3a
 ot6CgRPDRohxLA3n0xs/OXU4BGuVHbTBelYiXFGNZAzviskxkUxQBOT1UiKwMpa0QPVXzfaH6K9
 QYSh+kFjr8Ab2j6+xADEtZiURJPEqHt286zbvCNLMgkL6lzmwFbJQ+Q+cX/GHE4JMncMQ1wPCYB
 VWMfxaBgX1rsofhYXfnxxN7pVNI9z2RRUTc/s/ptKIRFEsnCPOf9bsmaTe7hiCT0PO+sNiScXPZ
 tBp77kfz2hp07gPJ4YzVP57JmBRcb6nDkDwwAco464lTid3nUNrzT9+mNf1Vls37VzYgrROeqKk
 aq3FMzj6saSLOfQJx7T6Um71WjMMtAdwatTf2h6rh06VCCBrV/YxVE+J5Qo8acpwckgUpVQAc90
 ruLURv1Z3Cf1DdT5omv4qeofTVq1EzXHAIRmJ4lPrUQJGFkG4Gy/ZSpl9wUhm2wwmIwmBF
X-Received: by 2002:a05:6a00:23c5:b0:81a:7be3:9e6a with SMTP id
 d2e1a72fcca58-82a8c238375mr5422360b3a.7.1774102466721; 
 Sat, 21 Mar 2026 07:14:26 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b040debf9sm4764875b3a.47.2026.03.21.07.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 07:14:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 4/5] linux-user/riscv: Add vector state to signal context
Date: Sun, 22 Mar 2026 00:13:42 +1000
Message-ID: <20260321141345.599105-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321141345.599105-1-npiggin@gmail.com>
References: <20260321141345.599105-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This enables vector state to be saved and restored across signals.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 linux-user/riscv/signal.c    | 175 +++++++++++++++++++++++++++++++++--
 target/riscv/cpu.h           |   4 +
 target/riscv/csr.c           |   7 +-
 target/riscv/vector_helper.c |  19 +++-
 4 files changed, 191 insertions(+), 14 deletions(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index e20b9ac177..2e1a1a5027 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -41,7 +41,17 @@ struct target_fp_state {
     uint32_t fcsr;
 };
 
+struct target_v_ext_state {
+    abi_ulong vstart;
+    abi_ulong vl;
+    abi_ulong vtype;
+    abi_ulong vcsr;
+    abi_ulong vlenb;
+    abi_ptr   datap;
+};
+
 /* The Magic number for signal context frame header. */
+#define RISCV_V_MAGIC   0x53465457
 #define END_MAGIC       0x0
 
 /* The size of END signal context header. */
@@ -106,6 +116,130 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
     return sp;
 }
 
+static unsigned int get_v_state_hdr_size(CPURISCVState *env)
+{
+    return sizeof(struct target_ctx_hdr) +
+           sizeof(struct target_v_ext_state);
+}
+
+static unsigned int get_v_state_data_size(CPURISCVState *env)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    return cpu->cfg.vlenb * 32;
+}
+
+static struct target_ctx_hdr *save_v_state(CPURISCVState *env,
+                                           struct target_ctx_hdr *hdr)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    target_ulong vlenb = cpu->cfg.vlenb;
+    uint32_t riscv_v_sc_size = get_v_state_hdr_size(env) +
+                               get_v_state_data_size(env);
+    struct target_v_ext_state *vs;
+    abi_ulong vcsr;
+    abi_ptr datap;
+    void *host_datap;
+
+#ifdef CONFIG_DEBUG_REMAP
+    /*
+     * The host pointers are derived from lock_user, not g2h, so
+     * h2g can not be used when CONFIG_DEBUG_REMAP=y.
+     */
+    qemu_log_mask(LOG_UNIMP, "signal: sigcontext can not save V state "
+                             "when CONFIG_DEBUG_REMAP=y\n");
+    return hdr;
+#endif
+
+    vs = (struct target_v_ext_state *)(hdr + 1);
+    vcsr = riscv_csr_read(env, CSR_VCSR);
+    host_datap = (vs + 1);
+    datap = h2g(host_datap);
+
+    __put_user(RISCV_V_MAGIC, &hdr->magic);
+    __put_user(riscv_v_sc_size, &hdr->size);
+
+    __put_user(env->vstart, &vs->vstart);
+    __put_user(env->vl, &vs->vl);
+    __put_user(env->vtype, &vs->vtype);
+    __put_user(vcsr, &vs->vcsr);
+    __put_user(vlenb, &vs->vlenb);
+    __put_user(datap, &vs->datap);
+
+    for (int i = 0; i < 32; i++) {
+        for (int j = 0; j < vlenb; j += 8) {
+            size_t idx = (i * vlenb + j);
+            __put_user(env->vreg[idx / 8],
+                       (uint64_t *)(host_datap + idx));
+        }
+    }
+
+    return (void *)hdr + riscv_v_sc_size;
+}
+
+static bool restore_v_state(CPURISCVState *env,
+                            struct target_ctx_hdr *hdr)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    target_ulong vlenb;
+    target_ulong vcsr, vl, vtype, vstart;
+    struct target_v_ext_state *vs;
+    uint32_t size;
+    abi_ptr datap;
+    void *host_datap;
+
+    if (!riscv_has_ext(env, RVV)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext has V state but "
+                                       "CPU does not support V extension\n");
+        return false;
+    }
+
+    __get_user(size, &hdr->size);
+    if (size < get_v_state_hdr_size(env)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext V state header "
+                                       "size is too small (%u)\n", size);
+        return false;
+    }
+
+    vs = (struct target_v_ext_state *)(hdr + 1);
+
+    __get_user(vstart, &vs->vstart);
+    __get_user(vl, &vs->vl);
+    __get_user(vtype, &vs->vtype);
+    __get_user(vcsr, &vs->vcsr);
+
+    riscv_cpu_set_vstart(env, vstart);
+    riscv_cpu_vsetvl(env, vl, vtype, 0);
+    riscv_csr_write(env, CSR_VCSR, vcsr);
+
+    __get_user(vlenb, &vs->vlenb);
+
+    if (vlenb != cpu->cfg.vlenb) {
+        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext has invalid "
+                                       "vlenb\n");
+        return false;
+    }
+
+    __get_user(datap, &vs->datap);
+
+    host_datap = lock_user(VERIFY_READ, datap, vlenb * 32, true);
+    if (!host_datap) {
+        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext has V state but "
+                                       "datap pointer is invalid\n");
+        return false;
+    }
+
+    for (int i = 0; i < 32; i++) {
+        for (int j = 0; j < vlenb; j += 8) {
+            size_t idx = (i * vlenb + j);
+            __get_user(env->vreg[idx / 8],
+                       (uint64_t *)(host_datap + idx));
+        }
+    }
+    unlock_user(host_datap, datap, 0);
+
+    return true;
+}
+
 static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
 {
     struct target_ctx_hdr *hdr;
@@ -126,6 +260,9 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
     __put_user(0, &sc->sc_extdesc.reserved);
 
     hdr = &sc->sc_extdesc.hdr;
+    if (riscv_has_ext(env, RVV)) {
+        hdr = save_v_state(env, hdr);
+    }
     __put_user(END_MAGIC, &hdr->magic);
     __put_user(END_HDR_SIZE, &hdr->size);
 }
@@ -152,17 +289,24 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 {
     abi_ulong frame_addr;
     struct target_rt_sigframe *frame;
+    size_t frame_size = sizeof(*frame);
 
-    frame_addr = get_sigframe(ka, env, sizeof(*frame));
+    if (riscv_has_ext(env, RVV)) {
+        frame_size += get_v_state_hdr_size(env) +
+                      get_v_state_data_size(env);
+    }
+
+    frame_addr = get_sigframe(ka, env, frame_size);
     trace_user_setup_rt_frame(env, frame_addr);
 
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+    frame = lock_user(VERIFY_WRITE, frame_addr, frame_size, 0);
+    if (!frame) {
         goto badframe;
     }
 
     setup_ucontext(&frame->uc, env, set);
     frame->info = *info;
-    unlock_user_struct(frame, frame_addr, 1);
+    unlock_user(frame, frame_addr, frame_size);
 
     env->pc = ka->_sa_handler;
     env->gpr[xSP] = frame_addr;
@@ -174,7 +318,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     return;
 
 badframe:
-    unlock_user_struct(frame, frame_addr, 1);
+    unlock_user(frame, frame_addr, frame_size);
     if (sig == TARGET_SIGSEGV) {
         ka->_sa_handler = TARGET_SIG_DFL;
     }
@@ -211,6 +355,11 @@ static bool restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
     __get_user(magic, &hdr->magic);
     while (magic != END_MAGIC) {
         switch (magic) {
+        case RISCV_V_MAGIC:
+            if (!restore_v_state(env, hdr)) {
+                return false;
+            }
+            break;
         default:
             qemu_log_mask(LOG_GUEST_ERROR, "signal: unknown extended state in "
                                            "sigcontext, magic=0x%08x\n", magic);
@@ -258,11 +407,23 @@ static bool restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
 long do_rt_sigreturn(CPURISCVState *env)
 {
     struct target_rt_sigframe *frame;
+    size_t frame_size = sizeof(*frame);
     abi_ulong frame_addr;
 
+    if (riscv_has_ext(env, RVV)) {
+        /*
+         * userspace may have set up a discontiguous V state data area,
+         * so need to map that region separately once the address is
+         * known, from datap.
+         */
+        frame_size += get_v_state_hdr_size(env);
+    }
+
     frame_addr = env->gpr[xSP];
     trace_user_do_sigreturn(env, frame_addr);
-    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+
+    frame = lock_user(VERIFY_READ, frame_addr, frame_size, 1);
+    if (!frame) {
         goto badframe;
     }
 
@@ -272,11 +433,11 @@ long do_rt_sigreturn(CPURISCVState *env)
 
     target_restore_altstack(&frame->uc.uc_stack, env);
 
-    unlock_user_struct(frame, frame_addr, 0);
+    unlock_user(frame, frame_addr, 0);
     return -QEMU_ESIGRETURN;
 
 badframe:
-    unlock_user_struct(frame, frame_addr, 0);
+    unlock_user(frame, frame_addr, 0);
     force_sig(TARGET_SIGSEGV);
     return 0;
 }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 35d1f6362c..e1eca79197 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -668,6 +668,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
 
+void riscv_cpu_set_vstart(CPURISCVState *env, target_ulong val);
+target_ulong riscv_cpu_vsetvl(CPURISCVState *env, target_ulong s1,
+                              target_ulong s2, target_ulong x0);
+
 #ifndef CONFIG_USER_ONLY
 void cpu_set_exception_base(int vp_index, target_ulong address);
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5064483917..8a6fd11fb5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -991,11 +991,8 @@ static RISCVException write_vstart(CPURISCVState *env, int csrno,
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
 #endif
-    /*
-     * The vstart CSR is defined to have only enough writable bits
-     * to hold the largest element index, i.e. lg2(VLEN) bits.
-     */
-    env->vstart = val & ~(~0ULL << ctzl(riscv_cpu_cfg(env)->vlenb << 3));
+    riscv_cpu_set_vstart(env, val);
+
     return RISCV_EXCP_NONE;
 }
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index caa8dd9c12..bceefe019b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -33,8 +33,17 @@
 #include "vector_internals.h"
 #include <math.h>
 
-target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
-                            target_ulong s2, target_ulong x0)
+void riscv_cpu_set_vstart(CPURISCVState *env, target_ulong val)
+{
+    /*
+     * The vstart CSR is defined to have only enough writable bits
+     * to hold the largest element index, i.e. lg2(VLEN) bits.
+     */
+    env->vstart = val & ~(~0ULL << ctzl(riscv_cpu_cfg(env)->vlenb << 3));
+}
+
+target_ulong riscv_cpu_vsetvl(CPURISCVState *env, target_ulong s1,
+                              target_ulong s2, target_ulong x0)
 {
     int vlmax, vl;
     RISCVCPU *cpu = env_archcpu(env);
@@ -99,6 +108,12 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     return vl;
 }
 
+target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
+                            target_ulong s2, target_ulong x0)
+{
+    return riscv_cpu_vsetvl(env, s1, s2, x0);
+}
+
 /*
  * Get the maximum number of elements can be operated.
  *
-- 
2.51.0


