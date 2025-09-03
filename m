Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90B7CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 04:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utf43-0005ej-OW; Wed, 03 Sep 2025 00:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utf41-0005dg-6N; Wed, 03 Sep 2025 00:25:41 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utf3z-0004L0-Bv; Wed, 03 Sep 2025 00:25:40 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-248cb0b37dfso58375985ad.3; 
 Tue, 02 Sep 2025 21:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756873537; x=1757478337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gx3mwO6QtzIQd/HmRNtRCUdA0C+5KW1rVn8GO01PC6w=;
 b=EbNybXQ1q/fCN1ZLPXHqr8L9gHeKQGEc12tpEESjbe+18/95Za1HqPOMSgR5Wcdpin
 /kH3eApObr+GYRUNrzawEbfmflhEs7A10/i1v3fP/Eoy1NNy1BynTG4X9oNCBnw+E9SV
 hfOVuwKoUCoo+aahpT7ggl0b3pd5ZzuWLWLATZ1Mo2AYInhMJ8d/kx7zty53diqjEnhr
 2oAMaJMNPzDDfgaWzOzV6JFySM1F2AbGnQyBhlypJmtAssE5ALZqCsUcfrhRusvkUMAR
 AWAyPREsZmkNL2ORYf5tXKDYywLTnkux2w//wgh8hVZddEzeENq7JhMmSQ0Qwvjoe6B7
 yvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756873537; x=1757478337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gx3mwO6QtzIQd/HmRNtRCUdA0C+5KW1rVn8GO01PC6w=;
 b=v/Hkol3P+mOw+QP6wJ2h0QcGanUYo9k1ickai6cj6r1/FNwFJ69+RvdAEedjLPucRA
 +Y4I3cEYF9g2DG1BoottlQAy6ep9ljAmTeIaJTomx1aPRmHrbp8O11eakZeXaaZIEiv/
 nBFgHj8WBNyzjGSzeUc+fntpVqY9vErK4x6FnB6busEqfIhyVqYylR5pXaN6rgeUr2cX
 vzZKtiQJo+lFKB9eUoADQTHjlX4Lah7yZdVrQ31FKXFZpdbVACnXCvGBB7LtUSmTzgNl
 QxJmqZMwL+Nz104TgJFimmiYqZ4MjvSSm41DaYMzbZULNxwKgRg6+j5HpVauIN2O7xiS
 M6EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBES3mJRCNC7BBPZoN2pZRiFiFukrFGoTG4y39Wr91GScvfjN+WqSsb/3EDAjZGUExGHKW0H0eizhR@nongnu.org
X-Gm-Message-State: AOJu0Yx9xG8qmJ638jAsA5BXZHVMk91lO/5HqoF5kN0qtLVGrWC1dBl9
 gThkv7C6r61YT34WoAzyPqIQ/X3eH00JyAAvuFpySmJYhNhWsx/Kg2Vg+qTG6g==
X-Gm-Gg: ASbGncvaywdo4xWn5sOO50LW4thuYBgpcZtV5V596tvj/FBWOPKSrDocvwPr71/P073
 kegegCzqlcj5NiNeYJH3cjiP2bBN8pGSRtfkFGzLx1VDHjhM2FWfKySDli1UuqiKIcXJZe/NYOI
 goKZ42ANlZtnUSwC1nUJohPpT+RGlwCrZzgrWdbdAS1yTUXAwYocpnftBbLrikXZbWjMQJQjK/d
 nxhcWl1oDiwzzsoWIk+TBm2lgqTbRiHEYppDRvcT2//ZMbZSPHR6tudw33EtRD101RZrXNDhhkW
 QTLiJbSpLq8mOqr2i7smVSfATQCzafEN/ihK7yeSjLihh5+arcJ5gsRA96WyDw3pDPUV1z3IQl4
 qNncC89S1f+6+XwxnnCfB5yQgbss4TNJwsno1EOHsLPBxgQjvQqH8IGelSS6+VFMSf1GRnWjH7k
 l2y+yFNU1p
X-Google-Smtp-Source: AGHT+IE9R+Ck+0uqEq/dwkedktxmUwzWXPTBE0ly2RebVCgNorWgmp3xm7IRWUY1VEkwTSLEp471Vw==
X-Received: by 2002:a17:902:e943:b0:24c:9309:587d with SMTP id
 d9443c01a7336-24c930959ddmr7802755ad.29.1756873536884; 
 Tue, 02 Sep 2025 21:25:36 -0700 (PDT)
Received: from lima-default (123.253.189.97.qld.leaptel.network.
 [123.253.189.97]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490370298dsm149002635ad.4.2025.09.02.21.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 21:25:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/4] linux-user/riscv: Add extended state to sigcontext
Date: Wed,  3 Sep 2025 14:25:08 +1000
Message-ID: <20250903042510.279954-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903042510.279954-1-npiggin@gmail.com>
References: <20250903042510.279954-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

Linux/riscv has extended the sigcontext with padding and an
extended state structure that can save various optional
features like vector in a flexible format. Update the
linux-user signal handling to this new structure.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 linux-user/riscv/signal.c         | 71 ++++++++++++++++++++++++++-----
 linux-user/riscv/vdso-asmoffset.h |  2 +-
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 358fa1d82d..4ef55d0848 100644
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
@@ -79,19 +108,25 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
 
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
+    hdr = &sc->sc_extdesc.hdr;
+    __put_user(END_MAGIC, &hdr->magic);
+    __put_user(END_HDR_SIZE, &hdr->size);
 }
 
 static void setup_ucontext(struct target_ucontext *uc,
@@ -146,20 +181,36 @@ badframe:
 
 static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
 {
+    struct target_ctx_hdr *hdr;
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
+
+    hdr = &sc->sc_extdesc.hdr;
+    uint32_t rsv;
+    __get_user(rsv, &sc->sc_extdesc.reserved);
+    if (rsv != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext reserved field is "
+                                       "non-zero. Attempting restore anyway.");
+    }
+
+    uint32_t magic;
+    __get_user(magic, &hdr->magic);
+    if (magic != END_MAGIC) {
+        qemu_log_mask(LOG_UNIMP, "signal: unknown extended context header: "
+                                 "0x%08x, ignoring", magic);
+    }
 }
 
 static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
diff --git a/linux-user/riscv/vdso-asmoffset.h b/linux-user/riscv/vdso-asmoffset.h
index 123902ef61..7d14228fb3 100644
--- a/linux-user/riscv/vdso-asmoffset.h
+++ b/linux-user/riscv/vdso-asmoffset.h
@@ -3,7 +3,7 @@
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


