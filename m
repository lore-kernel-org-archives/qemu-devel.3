Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CE5CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrP-00071d-HM; Tue, 11 Nov 2025 06:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqh-000502-7Q
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:47 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqe-0004Q9-4u
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:46 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b553412a19bso2381501a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861660; x=1763466460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVYI3uDYuiUnuBphImalv/xBwCe/21ga86oRo136tDE=;
 b=ohkrdcSuj+flJaShRGoY9z471IdMV++XszvH9PL6/9UeQ2Nw87zejgSekGA2MNZ1B0
 yEnHtoDTF2FplZDQQIsdIdU03SHI3aHKu+HowIoX83sFQlDvDz1VYoIGFkDWq8w8sBGU
 4vxUCClADGB3sSOPL0i0X4+LHmf7O5WU+vDqmcpgI30WqmO5/SA1wahXG3L1MDoZou5z
 bGhGriXMDl9xhUW9cMgf4IiMTJDdiOdVg7D9W2S3H5fTwuHASfhQanNQRDCa5W0QU708
 gOMrdJbxDkZrBNeYR2yjepqlWNCUq78hehZh05rNpqNUKel94F4iAwb3rP+pofbNZaqW
 6TFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861660; x=1763466460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FVYI3uDYuiUnuBphImalv/xBwCe/21ga86oRo136tDE=;
 b=CPCPNwKSiVDQxQ0jo7ddMsPrOTZbbIiDA4ffztRQY6fHihZeEc3jFyq07vVivLqF/G
 utCoM1FB1YBy707XsQkQfmV4zuwMXZmYN1n+2fF2RF55dWMqTdRbNcls0iBSFI/xZenK
 5G17G5Fa/u6xbrZsavSBlqpKVZ0R6iFjHMByle0qP3WnCEvsSwUbEIcf6Au+SIE2ToPe
 chei+1qFCW4p7eWA/pBDqWQFTeRCWUa7yvqiGptMFGsFhfJzYEPOIsjKfSKqkBM4kRkC
 b7ZVmyI+zeAPLE93++vEW+kaZ31CtxInRMfIpZZhSfN8LeFRR8eBPNmEPIAmx3PumUwM
 EzEg==
X-Gm-Message-State: AOJu0Yyp86nAeF0WQbBiW3Fzt6T74xNeHmeUPPnfsuVo9aqrBPNbFQ/1
 6W+Q5Ff3YLCVAAlFCsN91LOTT3ryIjyZWbB+VbyMLF7xG0NJVi7026odEPTutkMWfeJ0mPi7VLo
 wAbc0L1Y=
X-Gm-Gg: ASbGncsIpkMrMoeztncEPvaf2tEDjw1nbDrW0NiO8hbxKMsk0aBhZv5mj4eucOvFYie
 olM5eyW3bNzRWRV5oDP54ZBOAJynuzY9dKNNpGnwTdIfyaZFf3mifQHsBRFJeCjGtPFYe5E8IH+
 MjZZXpYZ9aecniXP2c1z5boUwi5dc9Rqn6NIZHbEBKlMJSKZPu7BbgIT6Khr4gVzBqDf/lh0HbY
 2EQgfQ6OlPnWtxgDN9p9+lDylvrDQpKxR1bWNM6piT33r27XDYs/q8qfMV9x1iLefZvmpzbCShH
 rSPc5aHkaeK/kuuOSgWPwqKL1Pk+/m23dXJFb5Om8T20rR6Ss+oMUlt4cvfWF67SMEck2Dl0dQs
 81GmIEKlEtzKT2fot7RBNbNoUE/eOXOPntKC+iIX4cQWuMD0EiCPa53yPjiLqZxjpV8KCuDDAez
 OkK/hD/xk0S+4kkqbQnE0pdWPQ8xw=
X-Google-Smtp-Source: AGHT+IG/JmIzL6MQOcq4afromovbKQ+ojOkf+fQTkALXHkrzQWcq5fyv9wHkfQQIeXKgw8ke2ICTWA==
X-Received: by 2002:a17:903:3848:b0:294:def6:5961 with SMTP id
 d9443c01a7336-297e56d0868mr156485935ad.45.1762861660161; 
 Tue, 11 Nov 2025 03:47:40 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:47:39 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 05/17] hw/riscv/virt.c add trace encoder and ramsink fdt
 nodes
Date: Tue, 11 Nov 2025 08:46:44 -0300
Message-ID: <20251111114656.2285048-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Mayuresh Chitale <mchitale@ventanamicro.com>

The trace encoder and trace ramsink nodes should confirm to the bindings
described in "riscv,trace-component.yaml" in the Linux kernel. That way,
encoder and ramsink devices get populated on the rvtrace bus and perf
record is able to capture the trace data in the auxtrace section as
expected.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b1a4d63efd..30e89a6c5a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1142,6 +1142,62 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     s->pci_iommu_bdf = bdf;
 }
 
+static void create_fdt_rvtrace(RISCVVirtState *s)
+{
+    static const char * const tr_compat[2] = { "qemu,trace-component",
+                                               "riscv,trace-component" };
+    g_autofree char *cpu_name = NULL, *ram_sink_name = NULL,
+                    *trencoder_name = NULL, *ep = NULL;
+    MachineState *ms = MACHINE(s);
+    int socket_count = riscv_socket_count(ms), i;
+    uint64_t addr, size = 0x100;
+    uint32_t rs_phandle;
+    RISCVCPU *cpu_ptr;
+
+
+    for (i = 0; i < socket_count; i++) {
+        for (int cpu = 0; cpu < s->soc[i].num_harts; cpu++) {
+            cpu_ptr = &s->soc[i].harts[cpu];
+            if (!cpu_ptr->trencoder) {
+                continue;
+            }
+            cpu_name = g_strdup_printf("/cpus/cpu@%d",
+                                       s->soc[i].hartid_base + cpu);
+            ram_sink_name = g_strdup_printf("/soc/ramsink@%d",
+                                            s->soc[i].hartid_base + cpu);
+            qemu_fdt_add_subnode(ms->fdt, ram_sink_name);
+            addr = object_property_get_uint(cpu_ptr->trencoder, "dest-baseaddr",
+                                            &error_abort);
+            qemu_fdt_setprop_sized_cells(ms->fdt, ram_sink_name, "reg", 2, addr,
+                                         2, size);
+            qemu_fdt_setprop_string_array(ms->fdt, ram_sink_name, "compatible",
+                                          (char **)&tr_compat,
+                                          ARRAY_SIZE(tr_compat));
+            qemu_fdt_setprop_phandle(ms->fdt, ram_sink_name, "cpu", cpu_name);
+            ep = g_strdup_printf("%s/in-ports/port/endpoint", ram_sink_name);
+            qemu_fdt_add_path(ms->fdt, ep);
+            rs_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+            qemu_fdt_setprop_cell(ms->fdt, ep, "phandle", rs_phandle);
+
+
+            trencoder_name = g_strdup_printf("/soc/encoder@%d",
+                                             s->soc[i].hartid_base + cpu);
+            qemu_fdt_add_subnode(ms->fdt, trencoder_name);
+            addr = object_property_get_uint(cpu_ptr->trencoder, "baseaddr",
+                                            &error_abort);
+            qemu_fdt_setprop_sized_cells(ms->fdt, trencoder_name, "reg", 2,
+                                         addr, 2, size);
+            qemu_fdt_setprop_string_array(ms->fdt, trencoder_name, "compatible",
+                                          (char **)&tr_compat,
+                                          ARRAY_SIZE(tr_compat));
+            qemu_fdt_setprop_phandle(ms->fdt, trencoder_name, "cpus", cpu_name);
+            ep = g_strdup_printf("%s/out-ports/port/endpoint", trencoder_name);
+            qemu_fdt_add_path(ms->fdt, ep);
+            qemu_fdt_setprop_cell(ms->fdt, ep, "remote-endpoint", rs_phandle);
+        }
+    }
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1166,6 +1222,8 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_uart(s, irq_mmio_phandle);
 
     create_fdt_rtc(s, irq_mmio_phandle);
+
+    create_fdt_rvtrace(s);
 }
 
 static void create_fdt(RISCVVirtState *s)
-- 
2.51.1


