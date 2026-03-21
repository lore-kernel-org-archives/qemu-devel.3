Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EBA1094474
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3x5w-0006Ri-2Z; Sat, 21 Mar 2026 10:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x5r-0006PK-Vd
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:24 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x5q-0003n7-AE
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82735a41920so1184361b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774102461; x=1774707261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqaGAnnpccfVW8ZFyBB14Gt89PnbcdQ0eaqs3g8GXfw=;
 b=eDYx/UZDHgZJsuCwgfsVwh9LvggZkqWgFgZpmmNygbDMndeQOSNwyp/BFPsQGpz8UI
 OvWWZvZ59Mi+conomlLE8uF00vDXO++TAxm6n13q5ZNqBEXLtDJs/pRE71iRJDvINXJ9
 WWxaHnXQsm7fyGfS51t3sAz6MdNwkogoBkWuIOL7nQvak2m0Jq28GOM6AqEaj0T207TM
 zCp8daIlo7cBmOPfdkFsQTxdyMJR/7eCykKgaeQ/hbD+OBZAPtDl0Su7ng2oxa3iqiwX
 i1yeDsmD4yK7p5sIhtaD1vZQxtBv00WTZvg/gj8S52/pTDyn0LYxc2ZV+hcq0ozENiep
 besg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774102461; x=1774707261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zqaGAnnpccfVW8ZFyBB14Gt89PnbcdQ0eaqs3g8GXfw=;
 b=N8xWfnxXOkXpesDhkodJ3yv2jYE6fF0VnR503k5yHFiuAxmKa5FgXj6mKxj/APud+J
 JdLx1+E5didfLzDQac7RMNSlF1li4B/9eoL3Ndna9inUhaus5Dm+Gxo/u8H/SamrexVv
 VqRCVMAqKmPXNjSQD3DhyM1AaShRuzqRMRx/Rw+Jsq9iy5dxFp0kIzsNlI5xszl/lrnY
 u3hE7I5wT6gT1mfNfYrMS2ePnZrKkt6SyWFoJiaHL0Ntlw2f3i/jNE1bdouY30t7Ndxz
 XZ1bAq8gsUzJjSdrmnVHm2vFMNQgFKpJPSNz2crUe87XRdokLjo07crXwHPzHo2T8k+m
 qa2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4B28SbnVh4hGfZx5z2xjKAafAnvCk8lICL81vbaA7pJ3KFqAbe/Pej8VNIfUE73DN5eXoJBIU95ud@nongnu.org
X-Gm-Message-State: AOJu0Ywnn6/J4INbqzUXha9vtK75idxj1VnmQpipNS6hxO/dcr51357k
 +P9szNzNRLJh2wvLG67DTYDEYUL9Ut+bN5uTQRKgLUsqEJFzR4CMmjao
X-Gm-Gg: ATEYQzzvX5JVxIrFRHQQAqEUsyygqQHfPtyzMDroSCu3bFEj5D/0QMTCKJ06K6pxe1t
 /nithgmc/jqfpyOGPBW8fB7GP1ePdRB9GdHwUNRJzkEqT6msnOikYkp80FasljbJZGNKjcN/vDL
 xiSg2EUzyJAOzIuiVid69XS8ijYK7XQt04ORdSdl7QbhiidTP3NTi1Spe8x07yzvCwmvTDgEUBw
 qOkBt35H2pNSwWfZ6fED+Ye/LZiyZ3LO201xQqf1mAyGoG0eLfBSZXTeC/MAJHrQZtZcWnVHu5c
 q+rfbEDwP9gzUFAQ8YHfzi4Q6kFz0iuia2R7v0GsiAg2tvp7uiU4HCU39DcPxoarUuzx6hx33Na
 6ySmvwDeSb7kqOto+bHRyWOA8M7tzfTJalt3ZY4wrm5xfilVYwxGqs5F+IlBTUDXEnXZW3bqMh7
 xAXWgQVREKJm1K+XRaj/KBeQpDmLBbRaKQmydP41Zt4xB2zoUF6mshjfZq2TVy9kv836nx
X-Received: by 2002:a05:6a00:b41:b0:82a:5d55:5807 with SMTP id
 d2e1a72fcca58-82a8c24817emr5402824b3a.6.1774102460889; 
 Sat, 21 Mar 2026 07:14:20 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b040debf9sm4764875b3a.47.2026.03.21.07.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 07:14:20 -0700 (PDT)
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
Subject: [PATCH v3 3/5] linux-user/riscv: Add extended state to sigcontext
Date: Sun, 22 Mar 2026 00:13:41 +1000
Message-ID: <20260321141345.599105-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321141345.599105-1-npiggin@gmail.com>
References: <20260321141345.599105-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Linux/riscv has extended the sigcontext with padding and an
extended state structure that can save various optional
features like vector in a flexible format. Update the
linux-user signal handling to this new structure.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 linux-user/riscv/signal.c         | 93 +++++++++++++++++++++++++++----
 linux-user/riscv/vdso-asmoffset.h |  4 +-
 2 files changed, 85 insertions(+), 12 deletions(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index ece276f85f..e20b9ac177 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -31,14 +31,43 @@
 
    The code below is qemu re-implementation of arch/riscv/kernel/signal.c */
 
-struct target_sigcontext {
+struct target_gp_state {
     abi_long pc;
     abi_long gpr[31]; /* x0 is not present, so all offsets must be -1 */
+};
+
+struct target_fp_state {
     uint64_t fpr[32];
     uint32_t fcsr;
+};
+
+/* The Magic number for signal context frame header. */
+#define END_MAGIC       0x0
+
+/* The size of END signal context header. */
+#define END_HDR_SIZE    0x0
+
+struct target_ctx_hdr {
+    uint32_t magic;
+    uint32_t size;
+};
+
+struct target_extra_ext_header {
+    uint32_t __padding[129] __attribute__((aligned(16)));
+    uint32_t reserved;
+    struct target_ctx_hdr hdr;
+};
+
+struct target_sigcontext {
+    struct target_gp_state sc_regs;
+    union {
+        struct target_fp_state sc_fpregs;
+        struct target_extra_ext_header sc_extdesc;
+    };
 }; /* cf. riscv-linux:arch/riscv/include/uapi/asm/ptrace.h */
 
-QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, fpr) != offsetof_freg0);
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_fpregs.fpr) !=
+                  offsetof_freg0);
 
 struct target_ucontext {
     abi_ulong uc_flags;
@@ -79,19 +108,26 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
 
 static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
 {
+    struct target_ctx_hdr *hdr;
     int i;
 
-    __put_user(env->pc, &sc->pc);
+    __put_user(env->pc, &sc->sc_regs.pc);
 
     for (i = 1; i < 32; i++) {
-        __put_user(env->gpr[i], &sc->gpr[i - 1]);
+        __put_user(env->gpr[i], &sc->sc_regs.gpr[i - 1]);
     }
     for (i = 0; i < 32; i++) {
-        __put_user(env->fpr[i], &sc->fpr[i]);
+        __put_user(env->fpr[i], &sc->sc_fpregs.fpr[i]);
     }
 
     uint32_t fcsr = riscv_csr_read(env, CSR_FCSR);
-    __put_user(fcsr, &sc->fcsr);
+    __put_user(fcsr, &sc->sc_fpregs.fcsr);
+
+    __put_user(0, &sc->sc_extdesc.reserved);
+
+    hdr = &sc->sc_extdesc.hdr;
+    __put_user(END_MAGIC, &hdr->magic);
+    __put_user(END_HDR_SIZE, &hdr->size);
 }
 
 static void setup_ucontext(struct target_ucontext *uc,
@@ -147,21 +183,58 @@ badframe:
 
 static bool restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
 {
+    struct target_ctx_hdr *hdr;
+    uint32_t rsv, magic, size;
     int i;
 
-    __get_user(env->pc, &sc->pc);
+    __get_user(env->pc, &sc->sc_regs.pc);
 
     for (i = 1; i < 32; ++i) {
-        __get_user(env->gpr[i], &sc->gpr[i - 1]);
+        __get_user(env->gpr[i], &sc->sc_regs.gpr[i - 1]);
     }
     for (i = 0; i < 32; ++i) {
-        __get_user(env->fpr[i], &sc->fpr[i]);
+        __get_user(env->fpr[i], &sc->sc_fpregs.fpr[i]);
     }
 
     uint32_t fcsr;
-    __get_user(fcsr, &sc->fcsr);
+    __get_user(fcsr, &sc->sc_fpregs.fcsr);
     riscv_csr_write(env, CSR_FCSR, fcsr);
 
+    hdr = &sc->sc_extdesc.hdr;
+    __get_user(rsv, &sc->sc_extdesc.reserved);
+    if (rsv != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext reserved field is "
+                                       "non-zero\n");
+        return false;
+    }
+
+    __get_user(magic, &hdr->magic);
+    while (magic != END_MAGIC) {
+        switch (magic) {
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR, "signal: unknown extended state in "
+                                           "sigcontext, magic=0x%08x\n", magic);
+            return false;
+        }
+
+        __get_user(size, &hdr->size);
+        if (size == 0) {
+            qemu_log_mask(LOG_GUEST_ERROR, "signal: extended state in "
+                                           "sigcontext has size 0\n");
+            return false;
+        }
+
+        hdr = (void *)hdr + size;
+        __get_user(magic, &hdr->magic);
+    }
+
+    __get_user(size, &hdr->size);
+    if (size != END_HDR_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR, "signal: extended state end header has "
+                                       "size=%u (should be 0)\n", size);
+        return false;
+    }
+
     return true;
 }
 
diff --git a/linux-user/riscv/vdso-asmoffset.h b/linux-user/riscv/vdso-asmoffset.h
index 123902ef61..92e8ac10ab 100644
--- a/linux-user/riscv/vdso-asmoffset.h
+++ b/linux-user/riscv/vdso-asmoffset.h
@@ -1,9 +1,9 @@
 #ifdef TARGET_ABI32
-# define sizeof_rt_sigframe     0x2b0
+# define sizeof_rt_sigframe     0x3b0
 # define offsetof_uc_mcontext   0x120
 # define offsetof_freg0         0x80
 #else
-# define sizeof_rt_sigframe     0x340
+# define sizeof_rt_sigframe     0x440
 # define offsetof_uc_mcontext   0x130
 # define offsetof_freg0         0x100
 #endif
-- 
2.51.0


