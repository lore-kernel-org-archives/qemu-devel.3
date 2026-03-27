Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7D310ED65E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65DS-0000NR-PZ; Fri, 27 Mar 2026 07:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CT-0007Rf-SU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:03 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CO-00006q-PL
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:59 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso1507057f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610275; x=1775215075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zg0JdMYpNPucplnhgObUVKgc6cBxcpxKCbSlMlmDTlo=;
 b=j8D3pVma0SwUF2JB7puMBVFO4rnfV3/MHoBIKmRxA9YRvvMIjkKNAebiQ5mB2e9CCz
 FhOcMTUzURNtOmik5aZa/4opeWlB1htRHTszYds4XYJLaIvYiO/CHqkV5uA90hWDnusw
 Wq6z3tWAj+etEiFgxMGKYI4ZhgKSzEdef4NlH+hgb/SjfTMfXydJCyvPZWaeltbss28O
 wl55mvKW/og1Yi58/1vJWv3/7L7nOyp9jZO/mVuINd3UY8fUL4aHyW57/nrjmglKqAIA
 i79/5mykcFqcBfXWiS93nqRdhaC0MaQ9aA4+nQUHcZnMwPEEt/KuFIZDR19xKqKGpD8Q
 Toqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610275; x=1775215075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zg0JdMYpNPucplnhgObUVKgc6cBxcpxKCbSlMlmDTlo=;
 b=fhp0mRFxQs3wCRXGBzAgQV2j/It6/Fs8ppF+BUOnbG7AoH5Rw1toQvqYDc5xcplz/9
 yCM50O5rjxW3ObHAzIWC+EoqJh6xKG+1kVrXGQzzhz7pj7mBKNrpEOlxNMqO8X3llmbK
 rtgf5wqYmDHeaIVAmBcZld8gKq19AVLeXck9aXFKnYKD7O2SpBes9+1F83yhJv41wwpn
 wcvS3wHZJpdL5a5y33aafUj/a3cAc6wvj+tLd7s+UOTbYhz+AuHPdYztr29N8glXJqmb
 AH3j2bWPSjD33lcZwrydNjINJV1J2ioQFB8uR94WanDi2g6oMpPwFsHDcSufmJQiBZmW
 02XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX0D8Z/ALpQO3RZVN/FLpX/SwkpyF97POfH+TZdXQD3xmqyUPijX7yPYmOFTbM6Qfm76DF5BZf36z0@nongnu.org
X-Gm-Message-State: AOJu0YzHoSEjsTaNyE7QedW5QsV9cICOahKTliAjqT73H5EJOTz1Hr/b
 LiVnLfFcLYIC8rSRbiojIndq+PN7VD6pMpO8i3QZJCsvHgLFssn9OqKs9m8vLkfULpM=
X-Gm-Gg: ATEYQzzywLwMpBexc8FWlCAIBHMXS1CxYvBCOO0vTpQ77gkBXVp3wNGZ8ICGvG3C46v
 3+GPbmeG72fUhJlQDyio0UZ9XRoGJOBcYoMBBAt2L4mZDP7E9rN+B5IdQ6aVm4EJ8LObT3tboMh
 dkBjd9j8d62VWF5YaNXZPf7o3zyTJnw5G9X1796uqQ19WcyQqA4quXG7MZfS4hFniLTPYQvlCZH
 4ZC9dPrN5r3h1SSEyrcGOZCSOyAMnyrVwNHlbrgyHYkTTfy1m8y0YQpht/dwBzbdsJjOTvHFbJ2
 QS9AlmBj2kDKi675QNnhHWbHrkatj3EIF/UbhMIdYiP8ogQTsrtPROiYTRhmmvwmC7ZQam5CMJ/
 wkMIMRKhct8JTxpVuSQmLlm7yyLLg6FDf/yPjtSTWC0+BU5tUh56FjUPSQQTAb6w3qKWxfuolax
 d/C+9xmGmS27qP5dg1y1aNCgzuSIZ/l303HEQXvnq6Soc5X7wIfItBPZdt9pL7b449equpPH9sE
 yrywbi0OwyDNUvIQmsOmk7rEt43Uk0=
X-Received: by 2002:a5d:64e6:0:b0:43b:5037:7ef3 with SMTP id
 ffacd0b85a97d-43b9e9e8bdamr3113357f8f.20.1774610275201; 
 Fri, 27 Mar 2026 04:17:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 56/65] hw/arm/virt: Remember CPU phandles rather than
 looking them up by name
Date: Fri, 27 Mar 2026 11:16:51 +0000
Message-ID: <20260327111700.795099-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

In fdt_add_cpu_nodes(), we currently add phandles for each CPU node
if we are going to add a topology description, and when we do, we
re-look-up the phandle by node name when creating the topology
description.

For GICv5 we will also want to refer to the CPU phandles; so always
add a phandle, and keep track of those phandles in the
VirtMachineState so we don't have to look them up by name in the dtb
every time.

The phandle property is extra data in the final DTB, but only a tiny
amount, so it's not worth trying to carefully track the conditions
when we're going to need them so we only emit them when required.

(We need to change the smp_cpus variable to unsigned because
otherwise gcc thinks that we might be passing a negative number to
g_new0() and produces an error:

/usr/include/glib-2.0/glib/gmem.h:270:19: error: argument 1 range [18446744071562067968, 18446744073709551615] exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
  270 |             __p = g_##func##_n (__n, __s);                      \
      |                   ^~~~~~~~~~~~~~~~~~~~~~~
/usr/include/glib-2.0/glib/gmem.h:332:57: note: in expansion of macro ‘_G_NEW’
  332 | #define g_new0(struct_type, n_structs)                  _G_NEW (struct_type, n_structs, malloc0)
      |                                                         ^~~~~~
../../hw/arm/virt.c:469:25: note: in expansion of macro ‘g_new0’
  469 |     vms->cpu_phandles = g_new0(uint32_t, smp_cpus);
      |                         ^~~~~~

)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/arm/virt.c         | 19 ++++++++++---------
 include/hw/arm/virt.h |  1 +
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ec0d8475ca..91097e25ec 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -431,13 +431,13 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
     }
 }
 
-static void fdt_add_cpu_nodes(const VirtMachineState *vms)
+static void fdt_add_cpu_nodes(VirtMachineState *vms)
 {
     int cpu;
     int addr_cells = 1;
     const MachineState *ms = MACHINE(vms);
     const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
-    int smp_cpus = ms->smp.cpus;
+    unsigned int smp_cpus = ms->smp.cpus;
 
     /*
      * See Linux Documentation/devicetree/bindings/arm/cpus.yaml
@@ -465,10 +465,13 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", addr_cells);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
 
+    vms->cpu_phandles = g_new0(uint32_t, smp_cpus);
+
     for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
         char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
         CPUState *cs = CPU(armcpu);
+        uint32_t phandle;
 
         qemu_fdt_add_subnode(ms->fdt, nodename);
         qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
@@ -493,10 +496,9 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
                 ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
         }
 
-        if (!vmc->no_cpu_topology) {
-            qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
-                                  qemu_fdt_alloc_phandle(ms->fdt));
-        }
+        phandle = qemu_fdt_alloc_phandle(ms->fdt);
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", phandle);
+        vms->cpu_phandles[cpu] = phandle;
 
         g_free(nodename);
     }
@@ -521,7 +523,6 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
         qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
 
         for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
-            char *cpu_path = g_strdup_printf("/cpus/cpu@%d", cpu);
             char *map_path;
 
             if (ms->smp.threads > 1) {
@@ -539,10 +540,10 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
                     cpu % ms->smp.cores);
             }
             qemu_fdt_add_path(ms->fdt, map_path);
-            qemu_fdt_setprop_phandle(ms->fdt, map_path, "cpu", cpu_path);
+            qemu_fdt_setprop_cell(ms->fdt, map_path, "cpu",
+                                  vms->cpu_phandles[cpu]);
 
             g_free(map_path);
-            g_free(cpu_path);
         }
     }
 }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5fcbd1c76f..22bbc34ca8 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -171,6 +171,7 @@ struct VirtMachineState {
     uint32_t gic_phandle;
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
+    uint32_t *cpu_phandles;
     int psci_conduit;
     uint8_t virtio_transports;
     hwaddr highest_gpa;
-- 
2.43.0


