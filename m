Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E866CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrO-0006yD-6j; Tue, 11 Nov 2025 06:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqf-0004y2-S5
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:46 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqZ-0004PU-FZ
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:45 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b996c8db896so3412553a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861648; x=1763466448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDZqy9Ycf62vW9VzFoH94rD5vUs2gHUCx1e+AQMwd78=;
 b=fCp9yXDIpmuQM7H5s/zlpPQPOxWjOk+1jWn/O3wXWHAS4MXWtuH/C4pCgJBZsO7O8d
 skZXLQfKKU7luMsZJb/lLWCS2T3I3WSGCWvPgrQghxEGjKTtnON2PHyhMTAudxxybTAC
 5K2b5BKHLKBzfS+f0mzPpgsvA89/ObhA9t2tdgo/DLYVCjZP89ji3Gh6za/EwXVmnoJE
 xBpTz9fWdljhbpZwby06cj6y++VtYCxat9dN7phwl283FQi3bEmFxz/4GikWXETYbbpX
 mRKZe5lRKjgqa5r3SqtTsd9obmXPhe10jl0w1UufzQG/lpxnZAedPeRPJmLKZHMiX/mf
 Xxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861648; x=1763466448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RDZqy9Ycf62vW9VzFoH94rD5vUs2gHUCx1e+AQMwd78=;
 b=t7QSgCDNDopzDm1j0X3WfJHrU4mCyJRcGOoD0i1j0ps6txXtfnslq1r7ebfoRtaUU6
 Ky9/Y9BBjo7Z/1qlwstmk7qNyakB6GqWp60XbtfildJyXO8IeWyU2TUY2IQHVrnIIsV7
 vPbA9ZF6tTJN9tVSVDGdhfSA3rYHa/RH/C1pSfeEYlP414WnsfM7ivRMCGXWIsG9j2Sl
 QXb5IBEHsJ8+sg1dcyRTHxaicDCdS/FNt0FFmoh0xcwP3FgV8I9617r3YktesAltOo6D
 wcTd3A8r9QaTBcPmAcmpBbE8u6yLqGa2RdHNag4+pOpVWjlsyDc9tyI0+6jYMp1CjTIz
 dqtg==
X-Gm-Message-State: AOJu0YxW96gsTsTa3eyuWVKIsrJF3D6+p8GeNZWBQTwylCHOtZdAOplM
 7QH7ZeNmWVtQML2tnEiZlhHpNiICHsDM6cvLQBIVMDXaYosz2/NGDQTRP99VyXZA+Iwjp/2guXm
 +3ijaPnE=
X-Gm-Gg: ASbGnctojq0hYCCpSblJP9MzXgQm7RWXS7nhBRY7FeOSYGmblggvkQZqm7F1Qin2Vxw
 qpOHnLTF+cv+I7FsQoSkRDLPPuSPaniO/25RWgHiWMCltaKQdZOfhFBG2L5WoHE78TK42elQA2T
 WYnrbf9pbfbGVPGRiBkK9Ya2n2AZf0lGQm3xMVzm9JiJkPmE4wHTiiaqBRlcrNDsPPaXx6csM9H
 SjqylgVt+0vGvvpvGiChr0N/0aeGhzrnHWFmc4eySS13pT2+czCuykKmUIgmRz4zVjHKcY/iEK6
 of0lLkgyoyXzuqvMHbwu/i9NuPCtBkuBnaA0NhSpOhh3/8qjdhdfdCgw7On+ypr25ElEJ1uG//c
 ei3DZzpHjm9uLavIPtz8dNmItgIW4w0KOKYzSMJwArf7Jjk+oWxsmt29Y9CV6Vt3NNQUqdkYYl8
 0n+uhdcfivDGz1A54lySJ0ZPICo8E=
X-Google-Smtp-Source: AGHT+IFygTL/Ro2/76nj3R+cdpt5yfcIgJlHk/sc3lXC2Rc0388+Dj65gZb4pvibzEmPoCHZ5Q+TnA==
X-Received: by 2002:a17:903:350d:b0:298:8ec:9991 with SMTP id
 d9443c01a7336-29808ec9a10mr112272315ad.37.1762861647568; 
 Tue, 11 Nov 2025 03:47:27 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:47:27 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 03/17] hw/riscv/trace-encoder: add trace start/stop logic
Date: Tue, 11 Nov 2025 08:46:42 -0300
Message-ID: <20251111114656.2285048-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Starting/stopping a trace session will rely on two flags:

- trace_next_insn: this flag will be used to signal the translation that
  the encoder wants to know the PC of the current insn. The translation
  helper (to be added) will clear this flag after sending the current
  insn to the encoder;

- trace_running: shows that we're running a trace session and certain
  insns classes (traps, certain jumps and branches) need to report to
  the trace encoder.

These flags are controlled by the trTeInstTracing bit. This bit requires
other two bits to be set beforehand (ACTIVE and ENABLE). We'll revisit
these bits in the future as more features are implemented.

While we're at it, add hardwire bits to indicate which features we're
(not) implementing at this time.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/trace-encoder.c | 107 +++++++++++++++++++++++++++++++++++++++
 hw/riscv/trace-encoder.h |   4 ++
 2 files changed, 111 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 21bf650a6a..d45e45d17e 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -30,7 +30,11 @@ REG32(TR_TE_CONTROL, 0x0)
     FIELD(TR_TE_CONTROL, INST_TRACING, 2, 1)
     FIELD(TR_TE_CONTROL, EMPTY, 3, 1)
     FIELD(TR_TE_CONTROL, INST_MODE, 4, 3)
+    FIELD(TR_TE_CONTROL, CONTEXT, 9, 1)
+    FIELD(TR_TE_CONTROL, INST_STALL_ENA, 13, 1)
+    FIELD(TR_TE_CONTROL, INHIBIT_SRC, 15, 1)
     FIELD(TR_TE_CONTROL, INST_SYNC_MODE, 16, 2)
+    FIELD(TR_TE_CONTROL, INST_SYNC_MAX, 20, 4)
     FIELD(TR_TE_CONTROL, FORMAT, 24, 3)
     /* reserved bits */
     FIELD(TR_TE_CONTROL, RSVP1, 7, 2)
@@ -75,17 +79,116 @@ REG32(TR_TE_IMPL, 0x4)
 
 #define R_TR_TE_IMPL_RESET (BIT(0) | BIT(8))
 
+REG32(TR_TE_INST_FEATURES, 0x8)
+    FIELD(TR_TE_INST_FEATURES, NO_ADDR_DIFF, 0, 1)
+
+static uint64_t trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
+{
+    input = FIELD_DP32(input, TR_TE_CONTROL, INST_MODE, 0x6);
+    input = FIELD_DP32(input, TR_TE_CONTROL, CONTEXT, 0);
+    input = FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_ENA, 0);
+    input = FIELD_DP32(input, TR_TE_CONTROL, INHIBIT_SRC, 1);
+    input = FIELD_DP32(input, TR_TE_CONTROL, FORMAT, 0);
+
+    /* SYNC_MODE and SYNC_MAX will be revisited */
+    input = FIELD_DP32(input, TR_TE_CONTROL, INST_SYNC_MODE, 0);
+    input = FIELD_DP32(input, TR_TE_CONTROL, INST_SYNC_MAX, 0);
+
+    return input;
+}
+
+static uint64_t trencoder_te_ctrl_prew(RegisterInfo *reg, uint64_t val)
+{
+    TraceEncoder *te = TRACE_ENCODER(reg->opaque);
+    uint32_t trTeActive = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL, ACTIVE);
+    uint32_t trTeInstTracing = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
+                                                INST_TRACING);
+    uint32_t temp;
+
+    val = trencoder_te_ctrl_set_hardwire_vals(val);
+
+    if (!trTeActive) {
+        /*
+         * 11.2 Reset and discovery, table 58, trTeControl = 0x1
+         * means "Release from reset and set all defaults." Do
+         * that only if trTeActive is 0.
+         */
+        if (val == 0x1) {
+            val = FIELD_DP32(val, TR_TE_CONTROL, EMPTY, 1);
+
+            return val;
+        }
+
+        /*
+         * 11.3 Enabling and Disabling hints that the device must
+         * be activated first (trTeActive = 1), then enabled.
+         * Do not enable the device if it's not active
+         * beforehand.
+         */
+        temp = FIELD_EX32(val, TR_TE_CONTROL, ENABLE);
+        if (temp) {
+            val = FIELD_DP32(val, TR_TE_CONTROL, ENABLE, 0);
+        }
+    }
+
+    /*
+     * Do not allow inst tracing to start if the device isn't
+     * already enabled. Do not allow enabling the devince and
+     * and enable tracing at the same time.
+     */
+    if (!te->enabled && trTeInstTracing) {
+        val = FIELD_DP32(val, TR_TE_CONTROL, INST_TRACING, 0);
+    }
+
+    return val;
+}
+
+static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
+{
+    TraceEncoder *te = TRACE_ENCODER(reg->opaque);
+    uint32_t trTeActive = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL, ACTIVE);
+    uint32_t trTeEnable = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL, ENABLE);
+    uint32_t trTeInstTracing = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
+                                                INST_TRACING);
+
+    if (!trTeActive) {
+        te->enabled = false;
+        te->trace_running = false;
+        te->trace_next_insn = false;
+        return;
+    }
+
+    if (te->enabled && !trTeEnable) {
+        /* TODO: this should cause a pending trace data flush. */
+    }
+
+    te->enabled = trTeEnable ? true : false;
+
+    if (!te->trace_running && trTeInstTracing) {
+        /* Starting trace. Ask the CPU for the first trace insn */
+        te->trace_next_insn = true;
+    }
+
+    te->trace_running = trTeInstTracing ? true : false;
+}
+
 static RegisterAccessInfo trencoder_regs_info[] = {
     {   .name = "TR_TE_CONTROL", .addr = A_TR_TE_CONTROL,
         .rsvd = R_TR_TE_CONTROL_RSVP_BITS,
         .reset = R_TR_TE_CONTROL_RESET,
         .ro = R_TR_TE_CONTROL_RO_BITS,
+        .pre_write = &trencoder_te_ctrl_prew,
+        .post_write = &trencoder_te_ctrl_postw,
     },
     {   .name = "TR_TE_IMPL", .addr = A_TR_TE_IMPL,
         .rsvd = R_TR_TE_IMPL_RSVP_BITS,
         .reset = R_TR_TE_IMPL_RESET,
         .ro = R_TR_TE_IMPL_RO_BITS,
     },
+    {   .name = "TR_TE_INST_FEATURES", .addr = A_TR_TE_INST_FEATURES,
+        .reset = R_TR_TE_INST_FEATURES_NO_ADDR_DIFF_MASK,
+        .ro = ~0,
+    },
 };
 
 static uint64_t trencoder_read(void *opaque, hwaddr addr, unsigned size)
@@ -132,6 +235,10 @@ static void trencoder_reset(DeviceState *dev)
     for (int i = 0; i < ARRAY_SIZE(te->regs_info); i++) {
         register_reset(&te->regs_info[i]);
     }
+
+    te->enabled = false;
+    te->trace_running = false;
+    te->trace_next_insn = false;
 }
 
 static void trencoder_realize(DeviceState *dev, Error **errp)
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 71002f58a4..001d872514 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -33,6 +33,10 @@ struct TraceEncoder {
     hwaddr ramsink_ramlimit;
     uint32_t regs[TRACE_R_MAX];
     RegisterInfo regs_info[TRACE_R_MAX];
+
+    bool enabled;
+    bool trace_running;
+    bool trace_next_insn;
 };
 
 #define TYPE_TRACE_ENCODER "trace-encoder"
-- 
2.51.1


