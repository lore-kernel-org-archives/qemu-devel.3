Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A971CEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZMR-0004sM-KG; Mon, 23 Feb 2026 12:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLE-0002vf-6b
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:32 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL9-0000Qt-Bx
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483abed83b6so14153015e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866196; x=1772470996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mcNmYKDo1AyTBqKWkeuzf3y95VGP3Xb6elYJJZdrymY=;
 b=Lqw9RkMTnO/iJLUNOj5EV/tON4t6DPvUzAd58+uuM+W0AQhO0YMGw+qpe1GKi5NxuG
 0XwsqlMzTJeNd1m0Xt37vCVM6gELFCHU+Y1EJOysaSB6ZtW2pfWMtSDAtglYGSrG7nQ3
 ZvSb6LfzJM+Fa/zMiQo46nbQSETeq1KdUGBrL3o+XIGo+WHHSAt2UOkdRH18Dq+EHOW7
 Frvd4DFqFRRZuzW+Hem3JS7JvyNDSe1UyE7cXWfvMSjKnl7NLJ8pjZ8gCSh5e9V6UMdT
 7lLWhgG3E0uALPKfjZVKiC0Va93Uyy2V82lDX9RKGpYbsC+Z/Ohn7IU43e97lcBgiFe4
 +33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866196; x=1772470996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mcNmYKDo1AyTBqKWkeuzf3y95VGP3Xb6elYJJZdrymY=;
 b=UXPr3cbd+ogQxXRb7tLPC7K+75DmW9mg9pUeB5XIXB62LThac21I/PszypxZutvRyT
 n8WpJkGqzo2RlxByfdfHXj2rWdO6aycaoJ/oQT8xhbvBumamENrUQm7dy/eklBaArXs4
 +JA4Qw2zBxd+wVhMP9Zb2g5EZRDe/rZ2sAMYVwA3ARght+5BjHoBjVKnTdE6GlKerEBz
 HFBjTtQdqx6fCjpEnkmhdpe9SWodrjDQNJ1Xc0GYlTg0yYCd2vbBGS/+Mwz44lDPbc4l
 FnqMM3NtAcKxlMMURbkc3pEkM1MUUQTGTwE8JNfKrgWnNbZm/UpcIyyFPXTrUa3lYMql
 lqFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRWZOiacMFr7tANXUEyZK4nDzMb8LuM5QnkVmUMTL/6lgBfyMO3EUoNSQS2HOyyCCj1OUZIvvNgHU0@nongnu.org
X-Gm-Message-State: AOJu0YydvJ4pWh2/Q+auJmj60SOqDnOtc8PeDoh1ByJKKWJ5vtzSteSm
 giHjvfyUphBql0P4UZUz9HiJRxhsQIQmDjDwlMMq+8kzVDbVR/HNPYaDjzSzs+k2fFg=
X-Gm-Gg: AZuq6aKHvGliKdFT0hSx8mM6geUNAhZAsKyF6IBqNjQ55Z884FA+HE1U/1XK6Ns0d7v
 X/ukVlYC3m9sWRZjD2GDutOV1QKtg40Mdz/CU2BpJ6dftXCgpTxrZfTfbKJHMyFCkuB2LgU27NT
 PZzev/AUOSNR6siI11ZwQRoBs10x+a/L9Q999+hruyewOSiVTBp+gvasjQ5wbZW5ldkwmH68tGr
 eKKmaeNaVhYwLeUfiDbPrCNncNytv+ayjAuY+4mW4AVVhmDMo6HcL81Qqrs4bmujqtH9rInqREn
 syEraQo0j7Q+75FumytbJpqj0TiBFvjqDGhCzgB6Dv2j+MmaGR5gKJuv4tlbi4k+xCmiDlJ3YJX
 xKQ+WT6ISkwrzQ0aFoxjSk0gTSIrbpOltmXDt0FuWCezV/PeHwXJmDHLKhfhSfojQRjXWvNCZ8B
 2n7qRvHbsyEz45XsRtCF/nLUZult1fiwrNFHk1vkForZdnpTrlXfdY3eqvjPFdfPJBbPRzJNKsu
 4a5GOYdXVGzc7OuG0CeYsJmIL7yvwE=
X-Received: by 2002:a05:600c:314a:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-483a95b3e62mr166806815e9.5.1771866196245; 
 Mon, 23 Feb 2026 09:03:16 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 56/65] hw/arm/virt: Remember CPU phandles rather than looking
 them up by name
Date: Mon, 23 Feb 2026 17:02:03 +0000
Message-ID: <20260223170212.441276-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
---
 hw/arm/virt.c         | 19 ++++++++++---------
 include/hw/arm/virt.h |  1 +
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8dc999712c..0d1032967c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -432,13 +432,13 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
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
@@ -466,10 +466,13 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
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
@@ -494,10 +497,9 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
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
@@ -522,7 +524,6 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
         qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
 
         for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
-            char *cpu_path = g_strdup_printf("/cpus/cpu@%d", cpu);
             char *map_path;
 
             if (ms->smp.threads > 1) {
@@ -540,10 +541,10 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
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
index 8069422769..6b4691761e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -171,6 +171,7 @@ struct VirtMachineState {
     uint32_t gic_phandle;
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
+    uint32_t *cpu_phandles;
     int psci_conduit;
     hwaddr highest_gpa;
     DeviceState *gic;
-- 
2.43.0


