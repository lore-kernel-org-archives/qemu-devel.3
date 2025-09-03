Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC6CCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 08:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utidp-0002oZ-Is; Wed, 03 Sep 2025 04:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utidn-0002np-4h; Wed, 03 Sep 2025 04:14:51 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utidl-0001jk-5D; Wed, 03 Sep 2025 04:14:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-248df8d82e2so52931235ad.3; 
 Wed, 03 Sep 2025 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756887286; x=1757492086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvRVwijnneGWg1Edja7q4SQVpGJeMep01w/gAcM43ZQ=;
 b=Fs4nHkHpZkJPISI0OlZSYBi6nLoKf/v+FvR0dPrU/756fCFHkJz+SnFLe0KDJ2xHtW
 MyZow/aFnrGK42jlQSUrwq0n/ZV9R1qy8l/rUvsVIUzkW3gd5EJInCX3uorEosPP0y7w
 B2Em3fdB01IrWNJ3Y8X5LOWrTIYEyKiVZQhY4ueCPgak9J30WnzBBH46PnREJ5U5ccet
 AjYE0MM8MqfveAhQsRaoNsOJ8Ae1Dc4veIfReufA/rjtWNDTsZdSNn3jmcbdwNx3RM9m
 Bdw0y/G/WgKuWWureKJo0Zm3phzRJFWTJESg+O/S//Dw/MKr9o+O2OB+F60B7CJcie1C
 eRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756887286; x=1757492086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvRVwijnneGWg1Edja7q4SQVpGJeMep01w/gAcM43ZQ=;
 b=WF532K4yGrlnQHEPenCLLDokjc853xjFOj0rBLRhU/9hFFuftkJz9uDODRBn0NiC2K
 JQKMu/ha6WSLbyiTCp1md2ddySLB2R84qtw1ftfTzUoGg9I4HxAyq5aEpYTpLA4Qsaql
 secNiNSxQ8dnhnRn9R4p/V170WI5q0rKRSgIJi5aYD5ompm45tcHZ+AFO/MHJjy+VC8c
 VdxE27yp6y82h1GWD/aXzsVzKizRFw89VDOjuzHNAeT9id1bFq9J61gnG4tI7LDxpA8c
 pbL87oFVW6lsDPx9uzzbesUULPxpT8sntYkLuGwouL5TkGE0c4dH4jt0RJIhxzlzezVn
 uKIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF7E9XD7AbwSVz8lxNBNIHKLJelKKISlHGpx2T4CbH2YWRd6xT1taNfN6sHV/AYI3IRdjr4PP9Ckr4@nongnu.org
X-Gm-Message-State: AOJu0YxgN5gzrrbM/rH3kgbM38VhwQnRIAfR4HlWiIZZ8A6eI/N67EAY
 kLSz8maTPpHctVXSkFwbyHHwmQkhOOewrdOSLD0nido/zakzn7K/EPwrWJ06RA==
X-Gm-Gg: ASbGncsEpS9MuwmAbKMukBKwtRy2gEo3gCK99sb8cYrwU4djXUOYADkRLbD0iSIek1w
 /pRfLmVgeKkvZoVJ4xA9F1X4kKyuSQSYcmrLhTYqLJuho26dIQfxMMNq5HE0jgyheGq3Sgpasx7
 8fTJS/1cPMbGAq94ffiiQdXVby2gq3pGdZ4L2oSpkbNxYHPeD9M5k25I5fS/hoFiJysEpa7uhin
 IIkxZYdJR7dLVxF0VfmhpsSwawfokp9M/o46g1LDfy8BYPGY78xjZYL8Pd8HJSNAX43l00qlFCr
 z8DeEZ72ZKFQ/FLOXdXsFMMXT0yiK9NeC3NYqFeDs9zY5G4/CWGO03fD2rqc/WzrMDpy+Sk1qc8
 L4q4E5vcrs+FfSZ7zmBaYFAtNt7qP+zaNptk8F8cVZgeC7J8OBB465E2bnrp1NU7PW55z
X-Google-Smtp-Source: AGHT+IHDKngE7z+ISk9X7AAVoYQatEhKUjexYINGxIGIStv4iu8Z5qCxZ9UMqzrd2WYMFM5W/7Gv3Q==
X-Received: by 2002:a17:902:f652:b0:249:3eec:15b8 with SMTP id
 d9443c01a7336-24944908a47mr194442395ad.24.1756887286150; 
 Wed, 03 Sep 2025 01:14:46 -0700 (PDT)
Received: from lima-default (123.253.189.97.qld.leaptel.network.
 [123.253.189.97]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24c9a46bcf1sm8806555ad.3.2025.09.03.01.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 01:14:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] linux-user/riscv: Add vector state to signal context
Date: Wed,  3 Sep 2025 18:14:16 +1000
Message-ID: <20250903081417.338515-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903081417.338515-1-npiggin@gmail.com>
References: <20250903081417.338515-1-npiggin@gmail.com>
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

This enables vector state to be saved and restored across signals.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 linux-user/riscv/signal.c | 132 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 128 insertions(+), 4 deletions(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 4ef55d0848..6af7f6b0f3 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -41,7 +41,17 @@ struct target_fp_state {
     uint32_t fcsr;
 };
 
+struct target_v_ext_state {
+    target_ulong vstart;
+    target_ulong vl;
+    target_ulong vtype;
+    target_ulong vcsr;
+    target_ulong vlenb;
+    target_ulong datap;
+} __attribute__((aligned(16)));
+
 /* The Magic number for signal context frame header. */
+#define RISCV_V_MAGIC   0x53465457
 #define END_MAGIC       0x0
 
 /* The size of END signal context header. */
@@ -106,6 +116,90 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
     return sp;
 }
 
+static unsigned int get_v_state_size(CPURISCVState *env)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    return sizeof(struct target_ctx_hdr) +
+           sizeof(struct target_v_ext_state) +
+           cpu->cfg.vlenb * 32;
+}
+
+static struct target_ctx_hdr *save_v_state(CPURISCVState *env,
+                                           struct target_ctx_hdr *hdr)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    target_ulong vlenb = cpu->cfg.vlenb;
+    uint32_t riscv_v_sc_size = get_v_state_size(env);
+    struct target_v_ext_state *vs;
+    target_ulong datap;
+    int i;
+
+    __put_user(RISCV_V_MAGIC, &hdr->magic);
+    __put_user(riscv_v_sc_size, &hdr->size);
+
+    vs = (struct target_v_ext_state *)(hdr + 1);
+    datap = (unsigned long)(vs + 1);
+
+    __put_user(env->vstart, &vs->vstart);
+    __put_user(env->vl, &vs->vl);
+    __put_user(env->vtype, &vs->vtype);
+    target_ulong vcsr = riscv_csr_read(env, CSR_VCSR);
+    __put_user(vcsr, &vs->vcsr);
+    __put_user(vlenb, &vs->vlenb);
+    __put_user(datap, &vs->datap);
+
+    for (i = 0; i < 32; i++) {
+        int j;
+        for (j = 0; j < vlenb; j += 8) {
+            size_t idx = (i * vlenb + j);
+            __put_user(env->vreg[idx / 8],
+                       (uint64_t *)(unsigned long)(datap + idx));
+        }
+    }
+
+    return (void *)hdr + riscv_v_sc_size;
+}
+
+static void restore_v_state(CPURISCVState *env,
+                            struct target_ctx_hdr *hdr)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    target_ulong vlenb = cpu->cfg.vlenb;
+    struct target_v_ext_state *vs;
+    target_ulong datap;
+    int i;
+
+    uint32_t size;
+    __get_user(size, &hdr->size);
+    if (size != get_v_state_size(env)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "signal: restoring sigcontext vector "
+                                       "state with wrong size header (%u)\n",
+                                       size);
+        return;
+    }
+
+    vs = (struct target_v_ext_state *)(hdr + 1);
+
+    __get_user(env->vstart, &vs->vstart);
+    __get_user(env->vl, &vs->vl);
+    __get_user(env->vtype, &vs->vtype);
+    target_ulong vcsr;
+    __get_user(vcsr, &vs->vcsr);
+    riscv_csr_write(env, CSR_VCSR, vcsr);
+    __get_user(vlenb, &vs->vlenb);
+    __get_user(datap, &vs->datap);
+
+    for (i = 0; i < 32; i++) {
+        int j;
+        for (j = 0; j < vlenb; j += 8) {
+            size_t idx = (i * vlenb + j);
+            __get_user(env->vreg[idx / 8],
+                       (uint64_t *)(unsigned long)(datap + idx));
+        }
+    }
+}
+
 static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
 {
     struct target_ctx_hdr *hdr;
@@ -124,7 +218,11 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
     __put_user(fcsr, &sc->sc_fpregs.fcsr);
 
     __put_user(0, &sc->sc_extdesc.reserved);
+
     hdr = &sc->sc_extdesc.hdr;
+    if (riscv_has_ext(env, RVV)) {
+        hdr = save_v_state(env, hdr);
+    }
     __put_user(END_MAGIC, &hdr->magic);
     __put_user(END_HDR_SIZE, &hdr->size);
 }
@@ -151,8 +249,13 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 {
     abi_ulong frame_addr;
     struct target_rt_sigframe *frame;
+    size_t frame_size = sizeof(*frame);
 
-    frame_addr = get_sigframe(ka, env, sizeof(*frame));
+    if (riscv_has_ext(env, RVV)) {
+        frame_size += get_v_state_size(env);
+    }
+
+    frame_addr = get_sigframe(ka, env, frame_size);
     trace_user_setup_rt_frame(env, frame_addr);
 
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
@@ -207,9 +310,30 @@ static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
 
     uint32_t magic;
     __get_user(magic, &hdr->magic);
-    if (magic != END_MAGIC) {
-        qemu_log_mask(LOG_UNIMP, "signal: unknown extended context header: "
-                                 "0x%08x, ignoring", magic);
+    while (magic != END_MAGIC) {
+        if (magic == RISCV_V_MAGIC) {
+            if (riscv_has_ext(env, RVV)) {
+                restore_v_state(env, hdr);
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext has V state "
+                                               "but CPU does not.");
+            }
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "signal: unknown extended state in "
+                                           "sigcontext magic=0x%08x", magic);
+        }
+
+        if (hdr->size == 0) {
+            qemu_log_mask(LOG_GUEST_ERROR, "signal: extended state in "
+                                           "sigcontext has size 0");
+        }
+        hdr = (void *)hdr + hdr->size;
+        __get_user(magic, &hdr->magic);
+    }
+
+    if (hdr->size != END_HDR_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR, "signal: extended state end header has "
+                                       "size=%u (should be 0)", hdr->size);
     }
 }
 
-- 
2.51.0


