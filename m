Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D8BCA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 04:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utf46-0005f5-Ro; Wed, 03 Sep 2025 00:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utf45-0005en-Br; Wed, 03 Sep 2025 00:25:45 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utf43-0004M0-HT; Wed, 03 Sep 2025 00:25:45 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b4c3d8bd21eso3886155a12.2; 
 Tue, 02 Sep 2025 21:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756873541; x=1757478341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQUkmVWzELLsrd5LFWN5qjCWWbc7bLPOMntiNkwPBtU=;
 b=Fe/JgL4XQmT2D277yEJvgn0168B/cxbTHneyyHZmd7j5Gb5C3cvyn27iLK9HE4YCsg
 8CRJQWFj9tr82+Q6zA4Cc3xoUIFg+z+Bb9NLkze4pu202+Tpe5sB8jInjWHQ/3rsdylt
 SVTu7ECyH/fUYy5fBKH6Bb4uSj+i6OjM/PL6YWSncdWfEMwfcn0a/CmQAIW7An99JnOZ
 mKn+mX7tnLyC+DGK+lvQsScd3WF7Mo52kPVKEa7LhIOSh4Nne09U1YzSKKMxZdzoavua
 q/sgFL3kKa3rVieGjQiRqqN/usZYsUlHWxMQgiTaqcB9iIn5wKL7JaBOEPpS461wUrDL
 v3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756873541; x=1757478341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQUkmVWzELLsrd5LFWN5qjCWWbc7bLPOMntiNkwPBtU=;
 b=VcksQmrzKnm9X9acexhANE5FFCXF19XMXdO88+k9ZXyZsTgDXTRHhnHWoeOgmmDWJp
 udMutvwgqDKGHK0EYrAeE9h7beY9OQ0jLeHX56Ek6nxGUwTmxdZlVRGhWlFmfE/rkZm2
 UdT3VKBt0/1BYmQhTvFjbcEiFgtJFlHdCQxUY+oi1rxT+8epVsb+6wsG/f8tZzgppn7r
 Dw9KRk+EvTAks1Z8F/wy3NEP7nPQ3YBeE2H3yvshvePcc6yCZBVOvF2iFKHcAsYUmuCP
 B429jXSCT33HN5VTKH/DUPJJmWq307KVYqgbpFjSHLouAmH4iww8NcYA6qy8Ecc3ELPi
 J0jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWGD0r/HxwDGe9I0OgZ31pXu3vCdyLO0CkJZYc0L4XZ5ZCUho67Uql+FIZzmHHsFAyMhHDpdgMv0lh@nongnu.org
X-Gm-Message-State: AOJu0Yxq6J6Qb471+GaNN4o+MnsBeWHwqDT49lP/WBqz3/+KZA2kKztu
 oSVldYkj0S0Eu95mvGeUbQdEkZBPDUnG1F+YThklv8o5qNQITkkW2xdXqRKEWg==
X-Gm-Gg: ASbGncuElV6uHWWajYX3rOyWr9H3MyZV14oTDmMss740uimSTulp263auT4MgniItsc
 jEpz+I2uTbeqo4XgWJSH9vdHSmq4GFTt7iZg6xUnIfjqQaJ+YBjFo7ZelFPwaHj1rcC/H4LZbdJ
 FzJc5gbUGm+qUf3zpWfSajZA6+VTQS0xlZWVzbhMT0TD/ukw396ElWDFKYvhxsjp3l+HFJiw2x5
 ULwzoTcUf7m7OuRx7dvZd5Qw41lbXYDNhzo3H/fC+w70k+Io4rQR332wA8+5iplUZ+bBRL6dZrp
 6Y52pdYteYiZUJSEPitq8zNwOZ2ZKkVlsXCM3kR/EXRNaag43KclVfEpL65xgS0fjU4eBwmrfDn
 Vf872zmfMW8hIPwktazvj6dK1ZIcMqaw8sD+URN2L9mZGI9i+9xBN2+YyC+1aplPBiYiyDxmczw
 ==
X-Google-Smtp-Source: AGHT+IHfrGvuwKAXsvJTngvXS5eTHKyFXxs9yF9Unu7oeQEklVsrz++56QrwuiBGxRXeQVb73zNGSw==
X-Received: by 2002:a17:902:e888:b0:248:79d4:93ae with SMTP id
 d9443c01a7336-24944a98674mr174291695ad.33.1756873540994; 
 Tue, 02 Sep 2025 21:25:40 -0700 (PDT)
Received: from lima-default (123.253.189.97.qld.leaptel.network.
 [123.253.189.97]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490370298dsm149002635ad.4.2025.09.02.21.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 21:25:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH 3/4] linux-user/riscv: Add vector state to signal context
Date: Wed,  3 Sep 2025 14:25:09 +1000
Message-ID: <20250903042510.279954-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903042510.279954-1-npiggin@gmail.com>
References: <20250903042510.279954-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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
 linux-user/riscv/signal.c | 130 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 4 deletions(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 4ef55d0848..4acbabcbc9 100644
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
@@ -106,6 +116,88 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
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
+    uint64_t *vdatap;
+    int i;
+
+    __put_user(RISCV_V_MAGIC, &hdr->magic);
+    __put_user(riscv_v_sc_size, &hdr->size);
+
+    vs = (struct target_v_ext_state *)(hdr + 1);
+    vdatap = (uint64_t *)(vs + 1);
+
+    __put_user(env->vstart, &vs->vstart);
+    __put_user(env->vl, &vs->vl);
+    __put_user(env->vtype, &vs->vtype);
+    target_ulong vcsr = riscv_csr_read(env, CSR_VCSR);
+    __put_user(vcsr, &vs->vcsr);
+    __put_user(vlenb, &vs->vlenb);
+    __put_user((target_ulong)vdatap, &vs->datap);
+
+    for (i = 0; i < 32; i++) {
+        int j;
+        for (j = 0; j < vlenb; j += 8) {
+            size_t idx = (i * vlenb + j) / 8;
+            __put_user(env->vreg[idx], vdatap + idx);
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
+    uint64_t *vdatap;
+    int i;
+
+    uint32_t size;
+    __get_user(size, &hdr->size);
+    if (size != get_v_state_size(env)) {
+        g_assert_not_reached();
+        /* XXX: warn, bail */
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
+    target_ulong __vdatap;
+    __get_user(__vdatap, &vs->datap);
+    vdatap = (uint64_t *)__vdatap;
+
+    for (i = 0; i < 32; i++) {
+        int j;
+        for (j = 0; j < vlenb; j += 8) {
+            size_t idx = (i * vlenb + j) / 8;
+            __get_user(env->vreg[idx], vdatap + idx);
+        }
+    }
+}
+
 static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
 {
     struct target_ctx_hdr *hdr;
@@ -124,7 +216,11 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
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
@@ -151,8 +247,13 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
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
@@ -207,9 +308,30 @@ static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
 
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
+            qemu_log_mask(LOG_GUEST_ERROR, "signal: extended state in sigcontext "
+                                           "has size 0");
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


