Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DB0CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utidl-0002nC-HV; Wed, 03 Sep 2025 04:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utidi-0002lp-MZ; Wed, 03 Sep 2025 04:14:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utidg-0001j9-PS; Wed, 03 Sep 2025 04:14:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-24a9ccbf10dso34895295ad.3; 
 Wed, 03 Sep 2025 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756887282; x=1757492082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C417OsYO0i831zsFFAbegUg0Ax4p35RqpiQra3XZSak=;
 b=lF8h/lTXbwtPJM4e0PZkl6kBA4j7WzKv5GJIQoxhWeD8IjuSNSevLEAVO/WErNWgAy
 ChA64LUAWwa7IpjU+FXoT8aZE6pSgKleIOq9hKQzVN84XuMOxD52cly4qIjkS7jxnQe5
 pyF/07db+GeAlnoI7AHntjBOp3iHaYkEjl+1jIr+p5Xp+3LLJnUlF+kBzVGI6HOES5qj
 l7j33kAWO3tW5QkYYbLVc73sYKRori+jWcHognaiArnsDAasdsErYy0/GFSbykbMhWdn
 EDQQRHUUxzbJF3TMojuLdTM8PIrvGnP822qFU5c4wQeaNxqrvTh0mWeg1g5et1u8bOSW
 LrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756887282; x=1757492082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C417OsYO0i831zsFFAbegUg0Ax4p35RqpiQra3XZSak=;
 b=EVWpk4UzLm3XKOrH8hZVHCp8hKIS5ypiBV8crXaWAzvDeFDZ0aklcJbJ8hPk0oJzkk
 on6oQ8b6PW8BAiuO5zOHj2Vig9kCOzgXtBHw9qdiCIqeqa0x8SL6V0MfdMysMvw/IGN1
 wta4kiP7SKqKfcY86dY/3mMSiZFMKPxOnINGdXzrXKybx5D76IzXBXNUs577ZvlURslz
 qHTXm+QxIr1SfXhehzSLs1oxY7S1FKkucdZXXB/m2S0BOdyHw2/WpXui7xhG5dcLjtcw
 EeKE2yLa7at2DY7xGfh8mqFUyzLaTjUnAe9iOWoVi41GafHTZiFdPE/0xeS6sDrSvP88
 xooA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh21UA+pdpASMGsFTtOpjeoQDmrj7BqQWKn5v/MTQFmm8n2eQZ+Jc8RSw6Nq1zUKfqGEzi5ooDrCnw@nongnu.org
X-Gm-Message-State: AOJu0Yxyavk+x8wzhqBr+yIXJx2MQ6gnpIPKL9YoOg/k7nhcR7NknuLT
 7S3081jPjQawHT0MwjxcehDEKkENtlvlPZuF0AG4BC5pWM0gmADW6i77A5v/7Q==
X-Gm-Gg: ASbGncvW2kclcfQuOmhOmOsRTg3WaILIn9lddL75abEc86ouvtpAs3G5+LqBS9JCewT
 /SBvJSKNZ0XulPD40icHtW98l4DQobH42p4byUE25I9XAGUN2IJ8qEOAwHDIZUS8f8XWmkh+G9f
 RfDgKFkGVN0GEAzYugOrK8aFguNQZ6jVjrJbzAC0El7tV3TbjpDcVyCNoc4IoZLGSLqScU+7XYc
 zxD2btOty7ok51xKr2IHivekyXtsdgFMeJ/EzOkiUcVFwYTBqB1hpy6T3ZGoVOJvbVDeT12LEYz
 vwE/canx+u/oFotx6wsQNgMVvopFmOjrC6prl5iCyod5E8mt+uX7ElTd2gnoNgIXz9cGKQWhL9p
 5ANuoaYL+pFlVgJ9uDaLdfMCV7YspMI+SRUc313SwUolWzeT9JniN2l1tftI3vzWcBop+YRypX1
 s21CI=
X-Google-Smtp-Source: AGHT+IHbUrsbNIvdSnK/A2EmhCVdvU4vKnLsOywoKrYfS8w8aPPtCvwJq9411siQucImAiDDCudzOA==
X-Received: by 2002:a17:902:ec85:b0:248:d84a:91df with SMTP id
 d9443c01a7336-24944a5c73cmr201795565ad.26.1756887282077; 
 Wed, 03 Sep 2025 01:14:42 -0700 (PDT)
Received: from lima-default (123.253.189.97.qld.leaptel.network.
 [123.253.189.97]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24c9a46bcf1sm8806555ad.3.2025.09.03.01.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 01:14:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] linux-user/riscv: Add extended state to sigcontext
Date: Wed,  3 Sep 2025 18:14:15 +1000
Message-ID: <20250903081417.338515-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903081417.338515-1-npiggin@gmail.com>
References: <20250903081417.338515-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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
 linux-user/riscv/vdso-asmoffset.h |  4 +-
 2 files changed, 63 insertions(+), 12 deletions(-)

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


