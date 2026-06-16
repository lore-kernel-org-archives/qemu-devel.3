Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA01CD98E8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQkQ-0003hA-Db; Tue, 16 Jun 2026 06:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkN-0003OW-EH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:19 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkL-0004RQ-9g
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:19 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36b8d414666so2696411a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604616; x=1782209416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecx+vduJBeK0LpzbCfn4pNXqX2YQoNqsLsnMHFPsvdk=;
 b=HIqB272RupUquke4qvborYjEcJnnMHJ1Gw9n1Jgr5z/EtfHsYT0FkCfaPEwEqxip7J
 qZmyx1CqkndpWK8C0UFeInW7kZikMintd/755/7/XBtNHdjdSIWASrOeaCge1isLpP+4
 ngsXNF5FeyEBIwfTWK8RDJUsvKmaMoJkffZZXvBEEgBbbR1wD0Lfb+cUpgcMVPLcYjyH
 Som8c8WQRzrwU1lHQ7Sri3xZsSidIi7MlsYkWU1vFxiJieV56d7GbLVy9Fu4rM349jPC
 +nPb9rA3hbGbG8+3vLXztiXYl1oL+71K1yE0dJfQOqCmV5FMc1bkH2Cg3TuqSzvATngF
 GNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604616; x=1782209416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ecx+vduJBeK0LpzbCfn4pNXqX2YQoNqsLsnMHFPsvdk=;
 b=SqCFNr06iN1aRzv64VsYGmsovo8E5J0FMOBuVCC8cFDm6U02AbtocREenxqeThcGLD
 wzLQy9pKZuy22PjH1/HYd/D41IpeNlWErOFGbo7sOaULwGXk4xSzsFf6FvzGek1SZO0o
 lGxfzUVeZP8Bgc1Npgktsateq6dvr463sGbXalSBxD/jTv0C9ygGSb6D0+UOmz/gw06U
 ml3YPKVqsEtGutJrnktODu+E1SNc7RBcZHfYuQuNE9r7eZDIq+LzTXnSqqy82io4Jluz
 HIouL/xa6N1R59P/WPwVXeZmLL/PHpF0QfjuCA/rfiNzf+USvSh36R4D88YDbm2GWmFn
 FL5w==
X-Gm-Message-State: AOJu0YwJDYF5xkV2eR42PTpy7ypdGgV6RpFZHQzGQsb7ta+79IWRETpT
 RQLXSEAAsW520Sd0M77HR+acX9pp8O/iXe8JmIAUolonWRYSdBFW39uIa8a5ZeXN
X-Gm-Gg: Acq92OHPPrX1UaktZlQszdGolQGzhDBqYRoeXAcbY4IJyZeFtprOYPfjAKG1IYOcyFy
 IQcPYW4hrYo/2uc3QlS3WEwhB3CFOCE34eyFieZNg5kP282EWlKrQvE6SVYgTAMnAi9v9A4QYsG
 OcLqcCYpFLwiTN50H/7Sg0nJ2zuWztadi1fkMyOjN7chk837r8zbZusau3smKkvv38rq3M7dhhA
 3Lbcd1vJlOmfM+7X7X95If1viEdkZf69ewHZqKGi4Lnrim6sNSl3V1mqJxkToZtn/XKm8CEkXSP
 UHOjQ2DeWMu3brt70iSpTdE7ZjobMWU4jI1Py2SZ4ASE/ShQCfpjEdicKSs+jeBfe21ixqEb6hA
 4jBHHYaZuLyclkMkNgJF+Sj8GEj4DAZnE2eMAypadsxFubxv7c0MuEtcCZT5P4/6+1nRU+8xlU8
 8VM5zw/NZErQx1JfdotmTuQz+YfNxBNYKqCKlBXgm3
X-Received: by 2002:a17:90b:224a:b0:369:b9db:b885 with SMTP id
 98e67ed59e1d1-37c523bd69cmr3344940a91.15.1781604615865; 
 Tue, 16 Jun 2026 03:10:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:10:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 81/83] hw/riscv/spike.c: use create_fdt_socket_cpus()
Date: Tue, 16 Jun 2026 20:05:24 +1000
Message-ID: <20260616100527.1939565-82-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Use the new FDT helper to create FDTs for the CPU sockets.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-12-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/spike.c | 54 +++++++-----------------------------------------
 1 file changed, 7 insertions(+), 47 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index ee8232f734..4e60724c14 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -56,11 +56,9 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     void *fdt;
     int fdt_size;
     unsigned long clint_addr;
-    int cpu, socket;
+    int socket;
     MachineState *ms = MACHINE(s);
-    uint32_t cpu_phandle, phandle = 1;
-    char *clust_name;
-    char *core_name, *cpu_name, *intc_name;
+    uint32_t phandle = 1;
     bool numa_enabled = riscv_numa_enabled(ms);
 
     fdt = ms->fdt = create_board_device_tree("ucbbar,spike-bare,qemu",
@@ -82,48 +80,11 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
                          riscv_socket_mem_offset(ms, socket);
         uint64_t memsize =  riscv_socket_mem_size(ms, socket);
 
-        clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
-        qemu_fdt_add_subnode(fdt, clust_name);
-
-        for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
-            cpu_phandle = phandle++;
-
-            cpu_name = g_strdup_printf("/cpus/cpu@%d",
-                s->soc[socket].hartid_base + cpu);
-            qemu_fdt_add_subnode(fdt, cpu_name);
-            if (is_32_bit) {
-                qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv32");
-            } else {
-                qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
-            }
-            riscv_isa_write_fdt(&s->soc[socket].harts[cpu], fdt, cpu_name);
-            qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
-            qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
-            qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
-                s->soc[socket].hartid_base + cpu);
-            qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
-            riscv_socket_fdt_write_id(ms, cpu_name, socket);
-            qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
-
-            intc_phandles[cpu] = phandle++;
-
-            intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
-            qemu_fdt_add_subnode(fdt, intc_name);
-            qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
-                                  intc_phandles[cpu]);
-            qemu_fdt_setprop_string(fdt, intc_name, "compatible",
-                "riscv,cpu-intc");
-            qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
-            qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
-
-            core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
-            qemu_fdt_add_subnode(fdt, core_name);
-            qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
-
-            g_free(core_name);
-            g_free(intc_name);
-            g_free(cpu_name);
-        }
+        create_fdt_socket_cpus(fdt, (&s->soc[socket])->harts, socket,
+                               s->soc[socket].num_harts,
+                               s->soc[socket].hartid_base,
+                               &phandle, intc_phandles, numa_enabled,
+                               is_32_bit);
 
         create_fdt_socket_memory(fdt, memaddr, memsize, socket,
                                  riscv_numa_enabled(ms));
@@ -133,7 +94,6 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
         create_fdt_socket_clint(fdt, clint_addr, memmap[SPIKE_CLINT].size,
                                 socket, intc_phandles,
                                 s->soc[socket].num_harts, numa_enabled);
-        g_free(clust_name);
     }
 
     riscv_socket_fdt_write_distance_matrix(ms);
-- 
2.54.0


