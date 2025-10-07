Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5C5CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68QW-0005on-BD; Tue, 07 Oct 2025 10:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QI-0005lD-9z
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q5-0002D3-IJ
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e48d6b95fso54858365e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846314; x=1760451114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AKhc0637ABhd7afL/DYnjwfyvFJ+HExy4fMVR1xkGgI=;
 b=aDepZ3/94l3I1sBFZ4I67Hd+eJM5xGEpyD8Cqb+fnm1qLDbv6hsP0zEgBSt4ewmBoB
 QmVbiq2tt4prmDCmHemnQFMChFLMCXgPspbos1zC7ye1NTNjta6ooCFXlvm1y9JJUd1F
 BhuMBJDOPNaRw1eZEbvaMeYayw0YripI7ae7zg6if6tIzKDGEvIT/FAnifqx65aTN2Oq
 eFjqQ0jZiKQFJA5H2qRc2fayYKqn99vLMaGfx3WvRDYYjEyNmj2fmHMJu3kVAhErnQOc
 kkikb0QUwhJoX5wFQ/UZRB83CXyO0Iuw0kv/7NzFYqcsUIsFXevULGOGhNEriXczKX/t
 JUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846314; x=1760451114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKhc0637ABhd7afL/DYnjwfyvFJ+HExy4fMVR1xkGgI=;
 b=IZ6s64qUM0fr9829rM9FIN+f/UNYjee0UZAg7LdTXWZ69iufbpvQYMUU4j93ZLSVtQ
 4yVrd+AseH9Y4xNVTocEPDTpf/aOgDPEUE/amUBPqxjFk3f+lYoGhyv4NzVka+ca7WO/
 XdZGS9ykW1Ot9HdBp4C4gg3KKckS9zNOmjbZuzITYVBnTnq0ZNowtcUR40voMDcfFt5v
 hXg1QyaoUI02apD+2mZzzMIclwHc4zN3VVauXmMFAv/TO1g+blzK8o2jDdr8sgG4JrCg
 5Wd/sgUdpT8BYXIBaeYgULyOGGo4z3bD/ziTM6cOVM1d5f45XOtP4AHOKcdxzc1Y8uyA
 zx/Q==
X-Gm-Message-State: AOJu0Yz3wVZzGKLgh7CXYV/fB55hh9HBgO+05kQ8A5xDKQIDoGvlOSsR
 tve6YlMRK8KSf+760Ny1ct6lOo6PH1ismslZsbFII89DSa5Exz7I3ojk13wEGrNjMpx2yxoZMnj
 8NACx
X-Gm-Gg: ASbGncvIgl2VKcOMhs57sR6H/nh+6m5BtozmDyNWDuuj7EeB65g2+1JVT0uN2nnFJV1
 R90Q9hMJcwcaQQHwXkYXkKLKZQp7LZOun0KUZFD2Qtpw9z1vzwGNNvf3wNbsyn93Axnfd19+Jbt
 P+UgmnxHVk8g8kNlY1Ww5a/8eJkGHsAPw9AUpmcVwjQ/7kV3VkXd37ocQ7AeiQdOI8dzvBxNTzJ
 C59k6OLDxOTg//AEgAY6uBe3wwtTfbvfq+cg8wUh2R7LGahJYQ43NF4zifVkGpY5G31xComgViz
 X7H4fZgy+BhuWKvqouX//+M3r8lzEDIIHuWjvDJnOTbF9RWlb9KjkSDk6BLHJ0m1TWx6CMO/k6Z
 2Rb0zfFYPtr9uMBijh4eKvUpUrfd9YcwTqHd0v/5RzF5MbCH/oDVuwCM1
X-Google-Smtp-Source: AGHT+IELORINHy659gfv9Okbe5bCqgmFNSZP24+HVs4/GofU9wdCROCiE+0HciuA7wygjNMMjezVvw==
X-Received: by 2002:a05:600c:3151:b0:46e:4c7c:5140 with SMTP id
 5b1f17b1804b1-46e71142eeamr120917975e9.18.1759846314408; 
 Tue, 07 Oct 2025 07:11:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/62] hw/arm/xlnx-versal: rpu: refactor creation
Date: Tue,  7 Oct 2025 15:10:47 +0100
Message-ID: <20251007141123.3239867-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Luc Michel <luc.michel@amd.com>

Refactor the RPU cluster creation using the VersalMap structure. This
effectively instantiate the RPU GICv2 which was not instantiated before.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-27-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h | 11 -------
 hw/arm/xlnx-versal-virt.c    |  1 +
 hw/arm/xlnx-versal.c         | 60 +++++++++++++++---------------------
 3 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 984f9f2ccdd..0a91ec7ae36 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -14,10 +14,8 @@
 #define XLNX_VERSAL_H
 
 #include "hw/sysbus.h"
-#include "hw/cpu/cluster.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
-#include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
 
 #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
@@ -52,15 +50,6 @@ struct Versal {
 
     struct {
         MemoryRegion mr_ocm;
-
-        /* Real-time Processing Unit.  */
-        struct {
-            MemoryRegion mr;
-            MemoryRegion mr_ps_alias;
-
-            CPUClusterState cluster;
-            ARMCPU cpu[XLNX_VERSAL_NR_RCPUS];
-        } rpu;
     } lpd;
 
     struct {
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 27594f78c8f..5958e712519 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -24,6 +24,7 @@
 #include "hw/arm/boot.h"
 #include "target/arm/multiprocessing.h"
 #include "qom/object.h"
+#include "target/arm/cpu.h"
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
 OBJECT_DECLARE_SIMPLE_TYPE(VersalVirt, XLNX_VERSAL_VIRT_MACHINE)
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 45ea47a8b97..e89c66313c1 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -47,6 +47,8 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/core/split-irq.h"
+#include "target/arm/cpu.h"
+#include "hw/cpu/cluster.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -107,6 +109,7 @@ typedef struct VersalCpuClusterMap {
 
 typedef struct VersalMap {
     VersalCpuClusterMap apu;
+    VersalCpuClusterMap rpu;
 
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
@@ -226,6 +229,27 @@ static const VersalMap VERSAL_MAP = {
         },
     },
 
+    .rpu = {
+        .name = "rpu",
+        .cpu_model = ARM_CPU_TYPE_NAME("cortex-r5f"),
+        .num_cluster = 1,
+        .num_core = 2,
+        .qemu_cluster_id = 1,
+        .mp_affinity = {
+            .base = 0x100,
+            .core_shift = ARM_AFF0_SHIFT,
+            .cluster_shift = ARM_AFF1_SHIFT,
+        },
+        .start_powered_off = SPO_ALL,
+        .dtb_expose = false,
+        .gic = {
+            .version = 2,
+            .dist = 0xf9000000,
+            .cpu_iface = 0xf9001000,
+            .num_irq = 192,
+        },
+    },
+
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
     .num_uart = 2,
@@ -806,35 +830,6 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
     }
 }
 
-static void versal_create_rpu_cpus(Versal *s)
-{
-    int i;
-
-    object_initialize_child(OBJECT(s), "rpu-cluster", &s->lpd.rpu.cluster,
-                            TYPE_CPU_CLUSTER);
-    qdev_prop_set_uint32(DEVICE(&s->lpd.rpu.cluster), "cluster-id", 1);
-
-    for (i = 0; i < ARRAY_SIZE(s->lpd.rpu.cpu); i++) {
-        Object *obj;
-
-        object_initialize_child(OBJECT(&s->lpd.rpu.cluster),
-                                "rpu-cpu[*]", &s->lpd.rpu.cpu[i],
-                                XLNX_VERSAL_RCPU_TYPE);
-        obj = OBJECT(&s->lpd.rpu.cpu[i]);
-        object_property_set_bool(obj, "start-powered-off", true,
-                                 &error_abort);
-
-        object_property_set_int(obj, "mp-affinity", 0x100 | i, &error_abort);
-        object_property_set_int(obj, "core-count", ARRAY_SIZE(s->lpd.rpu.cpu),
-                                &error_abort);
-        object_property_set_link(obj, "memory", OBJECT(&s->lpd.rpu.mr),
-                                 &error_abort);
-        qdev_realize(DEVICE(obj), NULL, &error_fatal);
-    }
-
-    qdev_realize(DEVICE(&s->lpd.rpu.cluster), NULL, &error_fatal);
-}
-
 static void versal_create_uart(Versal *s,
                                const VersalSimplePeriphMap *map,
                                int chardev_idx)
@@ -1636,7 +1631,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#address-cells", 0x2);
 
     versal_create_cpu_cluster(s, &map->apu);
-    versal_create_rpu_cpus(s);
+    versal_create_cpu_cluster(s, &map->rpu);
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
@@ -1692,8 +1687,6 @@ static void versal_realize(DeviceState *dev, Error **errp)
                            MM_OCM_SIZE, &error_fatal);
 
     memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
-    memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
-                                        &s->lpd.rpu.mr_ps_alias, 0);
 }
 
 DeviceState *versal_get_boot_cpu(Versal *s)
@@ -1804,10 +1797,7 @@ static void versal_base_init(Object *obj)
     Versal *s = XLNX_VERSAL_BASE(obj);
     size_t i, num_can;
 
-    memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
     memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
-    memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
-                             "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
     s->intc = g_array_new(false, false, sizeof(DeviceState *));
 
     num_can = versal_get_map(s)->num_canfd;
-- 
2.43.0


