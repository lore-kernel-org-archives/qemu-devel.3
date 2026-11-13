Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2DC606A896
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=pGtlcxbA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrk1-0002lP-7y; Fri, 13 Nov 2026 08:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRntw-0004Sb-14; Fri, 13 Nov 2026 04:48:56 -0500
Received: from smtp47.tsinghua.edu.cn ([101.6.4.71] helo=tsinghua.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRntt-00076Q-N7; Fri, 13 Nov 2026 04:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=5CRnXK48rR3rkDlg5BdeQ3/9sHAFSz9US1
 Ny/AUoQ94=; b=pGtlcxbAf0ds7TZ9rjxB14eQ7HUJIO+uuKlR+3+Su1/qVXzzIV
 oRFBrbhKK4SLFU3v4N0HxWMDYojLh5YB0z7LS80z8LYAfx4YpsqwcCC0j/yYNDRh
 +F1b+dI8gkbQ4q6O70jnOxH2tqmnQlRlGtrXvO23KRRIOyxm3KErMfAJ0=
Received: from ubuntu (unknown [101.5.154.165])
 by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S11;
 Fri, 13 Nov 2026 17:48:49 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 bin.meng@processmission.com, tangtao1634@phytium.com.cn,
 Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH 09/20] hw/arm/rk3588: add the GICv3 interrupt controller
Date: Fri, 13 Nov 2026 17:47:43 +0800
Message-ID: <7df52c4e9a08741bbde7b4943cb83d0c7955eece.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yAQGZQA3qzvR3PZqgA5CAg--.9318S11
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4DJr1xtr48KryrAr1fWFg_yoWxGFy5pr
 4kCFZ8GrWkGa1fCrWfZrnIgFnxJ3Z2g34j93yfuFy7Aasrt3s0yrWv9w47KFyxXrZ7Ww1U
 WrZYqF4Ygr13JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUHa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
 AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
 Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
 IFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_
 GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeVbkUU
 UUU
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/
Received-SPF: pass client-ip=101.6.4.71;
 envelope-from=w-yf22@mails.tsinghua.edu.cn; helo=tsinghua.edu.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:53 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Liu <chao.liu@processmission.com>

Add a GICv3 interrupt controller with 512 interrupts and wire the
architectural timer and maintenance interrupts to the CPUs.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/arm/Kconfig          |  1 +
 hw/arm/rk3588.c         | 86 +++++++++++++++++++++++++++++++++++++++--
 include/hw/arm/rk3588.h |  2 +
 3 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 55fdc78364..73e1154040 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -777,5 +777,6 @@ config AXIADO_EVK
 
 config RK3588
     bool
+    select ARM_GIC
     select CPU_CLUSTER
     select UNIMP
diff --git a/hw/arm/rk3588.c b/hw/arm/rk3588.c
index ecaaa09721..3682cf275b 100644
--- a/hw/arm/rk3588.c
+++ b/hw/arm/rk3588.c
@@ -15,18 +15,34 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/arm/rk3588.h"
+#include "hw/arm/bsa.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/misc/unimp.h"
 #include "hw/timer/rockchip-hptimer.h"
 #include "migration/vmstate.h"
+#include "qobject/qlist.h"
+#include "target/arm/gtimer.h"
 
 /* MPIDR Aff0 values per Aff1: 1 (one CPU per RK3588 cluster). */
 #define RK3588_MPIDR_AFF0_PER_AFF1   (1)
 
 #define RK3588_CNTFRQ                24000000
 
+#define RK3588_GIC_NUM_IRQS          512
+
+enum {
+    RK3588_DEV_GIC_DIST,
+    RK3588_DEV_GIC_REDIST,
+};
+
+/* Memory map of the modeled peripherals. */
+static const MemMapEntry rk3588_memmap[] = {
+    [RK3588_DEV_GIC_DIST]   = { 0xfe600000, 0x00010000 },
+    [RK3588_DEV_GIC_REDIST] = { 0xfe680000, 0x00100000 },
+};
+
 #define RK3588_UNIMPLEMENTED(name, base, size) \
     { "unimpl-" name, "rk3588." name, base, size, -1000 }
 
@@ -63,7 +79,6 @@ static const UnimplementedDeviceConfig rk3588_unimpl_devices[] = {
     RK3588_UNIMPLEMENTED("sdio", 0xfe2d0000, 64 * KiB),
     RK3588_UNIMPLEMENTED("emmc", 0xfe2e0000, 64 * KiB),
     RK3588_UNIMPLEMENTED("trng-ns", 0xfe378000, 32 * KiB),
-    RK3588_UNIMPLEMENTED("gic600", 0xfe600000, 4 * MiB),
     RK3588_UNIMPLEMENTED("dmac0", 0xfea10000, 64 * KiB),
     RK3588_UNIMPLEMENTED("dmac1", 0xfea30000, 64 * KiB),
     RK3588_UNIMPLEMENTED("i2c4", 0xfeac0000, 64 * KiB),
@@ -113,6 +128,69 @@ static const struct {
 
 G_STATIC_ASSERT(ARRAY_SIZE(rk3588_cpu_clusters) == RK3588_CLUSTER_COUNT);
 
+static bool rk3588_soc_create_gic(RK3588SoCState *s, Error **errp)
+{
+    DeviceState *gicdev = DEVICE(&s->gic);
+    SysBusDevice *gicsbd = SYS_BUS_DEVICE(gicdev);
+    QList *redist_region_count = qlist_new();
+
+    qdev_prop_set_uint32(gicdev, "num-cpu", RK3588_NUM_CPUS);
+    qdev_prop_set_uint32(gicdev, "num-irq", RK3588_GIC_NUM_IRQS);
+    qlist_append_int(redist_region_count, RK3588_NUM_CPUS);
+    qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
+    object_property_set_link(OBJECT(gicdev), "sysmem",
+                             OBJECT(s->memory), &error_abort);
+
+    if (!sysbus_realize(gicsbd, errp)) {
+        return false;
+    }
+
+    memory_region_add_subregion(s->memory,
+        rk3588_memmap[RK3588_DEV_GIC_DIST].base,
+        sysbus_mmio_get_region(gicsbd, 0));
+    memory_region_add_subregion(s->memory,
+        rk3588_memmap[RK3588_DEV_GIC_REDIST].base,
+        sysbus_mmio_get_region(gicsbd, 1));
+
+    for (unsigned int i = 0; i < RK3588_NUM_CPUS; i++) {
+        DeviceState *cpudev = DEVICE(&s->cpu[i]);
+        int intidbase = RK3588_GIC_NUM_IRQS - GIC_INTERNAL + (i * GIC_INTERNAL);
+        static const int timer_irqs[] = {
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP] = ARCH_TIMER_NS_EL2_IRQ,
+            [GTIMER_SEC] = ARCH_TIMER_S_EL1_IRQ,
+            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+        };
+
+        for (unsigned int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
+            qdev_connect_gpio_out(cpudev, j,
+                                  qdev_get_gpio_in(gicdev,
+                                                   intidbase + timer_irqs[j]));
+        }
+
+        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
+                                    qdev_get_gpio_in(gicdev,
+                                                     intidbase +
+                                                     ARCH_GIC_MAINT_IRQ));
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                                    qdev_get_gpio_in(gicdev,
+                                                     intidbase +
+                                                     VIRTUAL_PMU_IRQ));
+
+        sysbus_connect_irq(gicsbd, i,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gicsbd, i + RK3588_NUM_CPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicsbd, i + 2 * RK3588_NUM_CPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicsbd, i + 3 * RK3588_NUM_CPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    }
+
+    return true;
+}
+
 static bool rk3588_soc_create_hptimer(RK3588SoCState *s, Error **errp)
 {
     SysBusDevice *hptimer = SYS_BUS_DEVICE(s->hptimer);
@@ -163,10 +241,10 @@ static void rk3588_soc_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    if (!rk3588_soc_create_hptimer(s, errp)) {
+    if (!rk3588_soc_create_gic(s, errp) ||
+        !rk3588_soc_create_hptimer(s, errp)) {
         return;
     }
-
     create_unimplemented_devices(OBJECT(s), s->memory, rk3588_unimpl_devices);
 
     if (!memory_region_init_ram(&s->sram, OBJECT(s), "rk3588.sram",
@@ -198,6 +276,8 @@ static void rk3588_soc_instance_init(Object *obj)
         }
     }
 
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
+
     s->hptimer = qdev_new(TYPE_ROCKCHIP_HPTIMER);
     object_property_add_child(obj, "hptimer", OBJECT(s->hptimer));
     object_unref(OBJECT(s->hptimer));
diff --git a/include/hw/arm/rk3588.h b/include/hw/arm/rk3588.h
index 8539d2e64d..fcb9ef5964 100644
--- a/include/hw/arm/rk3588.h
+++ b/include/hw/arm/rk3588.h
@@ -17,6 +17,7 @@
 #include "target/arm/cpu.h"
 #include "hw/core/qdev.h"
 #include "hw/cpu/cluster.h"
+#include "hw/intc/arm_gicv3.h"
 #include "system/memory.h"
 
 #define TYPE_RK3588_SOC "rockchip.rk3588.soc"
@@ -45,6 +46,7 @@ struct RK3588SoCState {
     /*< public >*/
     ARMCPU cpu[RK3588_NUM_CPUS];
     CPUClusterState cluster[RK3588_CLUSTER_COUNT];
+    GICv3State gic;
     MemoryRegion *memory;
     MemoryRegion sram;
     DeviceState *hptimer;
-- 
2.53.0


