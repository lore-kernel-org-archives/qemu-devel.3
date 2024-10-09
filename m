Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F4FCED639
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfo6-000704-1r; Wed, 09 Oct 2024 19:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfny-0006qj-0v
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:18 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnv-0000la-Qq
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:17 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7db637d1e4eso212617a12.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728515354; x=1729120154;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L8GR17FkA/J/rE0TeH3ijOLU5RFbHn5ig8szCuUWCXw=;
 b=0/bWMC6PhJIZAFlBBG3S+/gnIqEAK8JfPRqz8gO1WF1IaZ736Uw1aFcJIsem9QFXo9
 T0T9RiqOrD1IojgG94EkaFAYeVuAITvfuIuqXujwEP5QlOBpjV6g1GN38AT8h45e8+rG
 XQvQoERT08752l3sdRynHg6wbSXKLCLS2bJNSucMnPO3uQKApcABHv9HVZA+gbJwZzT/
 v47En+XxSi7pp5sXWpwzQdspv5jw5rik0ncerEkWvHd9C3ErD8TTOD1j+5zzz2fSZwFZ
 bwoWw7MDxwr1J3u5Bb5txvU1giFOq2vIbJCCg8809sdHMg2uAtzQ4GRyHwYBllw9Zx1Q
 J7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728515354; x=1729120154;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8GR17FkA/J/rE0TeH3ijOLU5RFbHn5ig8szCuUWCXw=;
 b=aMLeKrrtLfaGOEqPdN28i55RfTfSFUqJofawBXIDeZO+7GnBO6uAlPIkAKMC2fsAfV
 ug08mGsthB04ZwQfNvAtMkGW0VVRsaSl52gvBW2VZIOTlyesuj2Q6ZXODj/lWx6vTJd3
 EZGwzA62MUxn0J5BKgAFkB4wVL1WJVvRclDpZpQ81lXWZnZ+KHiTAIMpNRRp0/BmiASu
 usI3x9K2IrpUqT2YR1VdEJOchK822L2/Hd48pQ/Ae7naxsPfIdwdngnQIwyPHQ+pD57X
 vJu4/El9uznNfNN6OKlienEwkHhyQcwYu70neOT2pm7yuJ9AWpB0X6HLP6cxDwpcrHr1
 sY9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkaySYqaC1vJhnc3OhOJ1GAhe1tMdQsSwwQUM521elWwsDS7qNaQKgFwwdpZFrb5u/lmO3Nws1CDj3@nongnu.org
X-Gm-Message-State: AOJu0YycNiOn4Cuc1UVTfHGrZeICKpg3LE7InI8oC26i2G9wmrwV0wnp
 VtFLwOPdYk9HcFBPJ+GvPV7O8UPCp0Jd3ROtVXy5oTP8rfKl11G17yZ0Q3VVv3M=
X-Google-Smtp-Source: AGHT+IHFAMKMTnnh/U4UHESQK6oc/WZEZOVnpf1VVRMpXWVSlJD3Um1gLpxj94jXPehRT9G6t6bU7w==
X-Received: by 2002:a17:90a:c481:b0:2d8:82a2:b093 with SMTP id
 98e67ed59e1d1-2e2a23303bdmr5244579a91.13.1728515354513; 
 Wed, 09 Oct 2024 16:09:14 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a55f9855sm2271902a91.2.2024.10.09.16.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 16:09:14 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 09 Oct 2024 16:09:08 -0700
Subject: [PATCH RFC 10/10] hw/riscv/virt.c: Generate the PMU node from the
 machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pmu_event_machine-v1-10-dcbd7a60e3ba@rivosinc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
In-Reply-To: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alexei.filippov@syntacore.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=atishp@rivosinc.com; helo=mail-pg1-x52f.google.com
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

The virt machine implementation relies on the SBI PMU extension.
The OpenSBI implementation requires a PMU specific DT node that
is currently encodes the counter and PMU events mapping.
As the PMU DT node encodes the platform specific event encodings,
it should be implement in platform specific code instead of generic
PMU code.

Move the PMU DT node generation code from virt.c from common pmu
code.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 hw/riscv/virt.c    | 21 +++++++++++++++++++--
 target/riscv/pmu.c | 36 ------------------------------------
 target/riscv/pmu.h |  1 -
 3 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ffda6d65d673..056afe6a6ceb 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -792,11 +792,28 @@ static void create_fdt_pmu(RISCVVirtState *s)
 {
     g_autofree char *pmu_name = g_strdup_printf("/pmu");
     MachineState *ms = MACHINE(s);
-    RISCVCPU hart = s->soc[0].harts[0];
+    uint32_t fdt_event_ctr_map[15] = {};
+    int i;
 
     qemu_fdt_add_subnode(ms->fdt, pmu_name);
     qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
-    riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
+
+    /*
+     * To keep it simple, any event can be mapped to any programmable counters
+     * in QEMU. The generic cycle & instruction count events can also be
+     * monitored using programmable counters. In that case, mcycle & minstret
+     * must continue to provide the correct value as well. Heterogeneous PMU per
+     * hart is not supported yet. Thus, number of counters are same across all
+     * harts.
+     */
+    for (i = 0; i < ARRAY_SIZE(pmu_events_arr); i++) {
+        fdt_event_ctr_map[0 + i * 3] = cpu_to_be32(pmu_events_arr[i].event_id);
+        fdt_event_ctr_map[1 + i * 3] = cpu_to_be32(pmu_events_arr[i].event_id);
+        fdt_event_ctr_map[2 + i * 3] = cpu_to_be32(pmu_events_arr[i].counter_mask);
+    }
+    /* This a OpenSBI specific DT property documented in OpenSBI docs */
+    qemu_fdt_setprop(ms->fdt, pmu_name, "riscv,event-to-mhpmcounters",
+                     fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
 }
 
 static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index e80f0f911fa3..dd0a18ae3dc1 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -27,42 +27,6 @@
 
 #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
 
-/*
- * To keep it simple, any event can be mapped to any programmable counters in
- * QEMU. The generic cycle & instruction count events can also be monitored
- * using programmable counters. In that case, mcycle & minstret must continue
- * to provide the correct value as well. Heterogeneous PMU per hart is not
- * supported yet. Thus, number of counters are same across all harts.
- */
-void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
-{
-    uint32_t fdt_event_ctr_map[15] = {};
-
-   fdt_event_ctr_map[0] = cpu_to_be32(VIRT_PMU_EVENT_HW_CPU_CYCLES);
-   fdt_event_ctr_map[1] = cpu_to_be32(VIRT_PMU_EVENT_HW_CPU_CYCLES);
-   fdt_event_ctr_map[2] = cpu_to_be32(cmask | 1 << 0);
-
-   fdt_event_ctr_map[3] = cpu_to_be32(VIRT_PMU_EVENT_HW_INSTRUCTIONS);
-   fdt_event_ctr_map[4] = cpu_to_be32(VIRT_PMU_EVENT_HW_INSTRUCTIONS);
-   fdt_event_ctr_map[5] = cpu_to_be32(cmask | 1 << 2);
-
-   fdt_event_ctr_map[6] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS);
-   fdt_event_ctr_map[7] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS);
-   fdt_event_ctr_map[8] = cpu_to_be32(cmask);
-
-   fdt_event_ctr_map[9] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS);
-   fdt_event_ctr_map[10] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS);
-   fdt_event_ctr_map[11] = cpu_to_be32(cmask);
-
-   fdt_event_ctr_map[12] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS);
-   fdt_event_ctr_map[13] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS);
-   fdt_event_ctr_map[14] = cpu_to_be32(cmask);
-
-   /* This a OpenSBI specific DT property documented in OpenSBI docs */
-   qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
-                    fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
-}
-
 static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
 {
     if (ctr_idx < 3 || ctr_idx >= RV_MAX_MHPMCOUNTERS ||
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 810ac2fae797..10505040d9e5 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -31,7 +31,6 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
                                uint32_t ctr_idx);
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, uint64_t event_idx);
-void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,

-- 
2.34.1


