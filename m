Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67534606A32E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGG4-000087-07; Sat, 14 Nov 2026 11:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGFt-000077-6X; Sat, 14 Nov 2026 11:05:30 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGFn-00078s-9i; Sat, 14 Nov 2026 11:05:28 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAX5KS8hvhqHC0qBg--.44419S2; 
 Sun, 15 Nov 2026 00:05:16 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwFXWuhvhqkdv6AA--.30494S3;
 Sun, 15 Nov 2026 00:05:02 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 27/35] hw/arm/smmuv3: Route IRQ and GERROR handling by
 SEC_SID
Date: Sun, 15 Nov 2026 00:05:01 +0800
Message-Id: <20261114160501.3626474-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwFXWuhvhqkdv6AA--.30494S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBUwABs3
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKrWUGrykuw45ur1kuFy5CFg_yoWDJr4kpr
 4qywnYgr4rKF15Xr9aga1xu3W3G34kKF1YkrWUKFWfCa4jkryYqr4DG3Wjk3yDurWkZa13
 ZayfWFW8Zr1xAr7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Interrupt and global error handling currently always selects the
Non-secure register bank, even when the event or command originates
from the Secure programming interface. This splits CMDQ_CONS.ERR from
GERROR.CMDQ_ERR and prevents Secure software from acknowledging the
error through S_GERRORN.

Pass SEC_SID through the IRQ and GERROR helpers and all queue call
sites so interrupt enable checks, global error reporting, and
acknowledgement use the originating programming-interface bank.

Add separate wired interrupt outputs for Secure EventQ, CMD_SYNC
and GERROR. Select the output by SEC_SID, register the new outputs
and wire them to the GIC on virt and sbsa-ref. Adjust the CMDQV ACPI
interrupt index to account for the additional SMMU outputs.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/arm/smmuv3.h  | 11 ++++++++++-
 include/hw/arm/virt.h    |  1 +
 hw/arm/sbsa-ref.c        |  8 ++++++++
 hw/arm/smmuv3.c          | 41 ++++++++++++++++++++++++++++------------
 hw/arm/virt-acpi-build.c |  3 ++-
 hw/arm/virt.c            |  7 +++++++
 6 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 8cd2edc3412..cb05cb19e32 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -57,6 +57,14 @@ typedef struct SMMUv3RegBank {
     SMMUQueue eventq, cmdq;
 } SMMUv3RegBank;
 
+enum {
+    SMMU_IRQ_NUM_NS = 4,
+    SMMU_IRQ_S_EVTQ = SMMU_IRQ_NUM_NS,
+    SMMU_IRQ_S_CMD_SYNC,
+    SMMU_IRQ_S_GERROR,
+    SMMU_IRQ_NUM,
+};
+
 struct SMMUv3State {
     SMMUState     smmu_state;
 
@@ -67,7 +75,7 @@ struct SMMUv3State {
 
     SMMUv3RegBank bank[SMMU_SEC_SID_NUM];
 
-    qemu_irq     irq[4];
+    qemu_irq     irq[SMMU_IRQ_NUM];
     QemuMutex mutex;
     char *stage;
     uint8_t identifier;
@@ -104,6 +112,7 @@ struct SMMUv3Class {
 };
 
 bool smmuv3_ats_enabled(struct SMMUv3State *s);
+int smmuv3_get_num_irqs(struct SMMUv3State *s);
 
 #define TYPE_ARM_SMMUV3   "arm-smmuv3"
 OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1a113..e1ec8fe53d4 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -79,6 +79,7 @@ enum {
     VIRT_GICV5_ITS_TR_EL3,
     VIRT_GICV5_ITS_TR_REALM,
     VIRT_SMMU,
+    VIRT_SMMU_SECURE,
     VIRT_UART0,
     VIRT_MMIO,
     VIRT_RTC,
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 158b461eb48..ad6d0171723 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -82,6 +82,7 @@ enum {
     SBSA_GWDT_REFRESH,
     SBSA_GWDT_CONTROL,
     SBSA_SMMU,
+    SBSA_SMMU_SECURE,
     SBSA_UART,
     SBSA_RTC,
     SBSA_PCIE,
@@ -155,6 +156,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_XHCI] = 11,
     [SBSA_SMMU] = 12, /* ... to 15 */
     [SBSA_GWDT_WS0] = 16,
+    [SBSA_SMMU_SECURE] = 17,
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
@@ -618,6 +620,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
 {
     hwaddr base = sbsa_ref_memmap[SBSA_SMMU].base;
     int irq =  sbsa_ref_irqmap[SBSA_SMMU];
+    int secure_irq = sbsa_ref_irqmap[SBSA_SMMU_SECURE];
     DeviceState *dev;
     int i;
 
@@ -636,6 +639,11 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
                            qdev_get_gpio_in(sms->gic, irq + i));
     }
+    for (i = SMMU_IRQ_NUM_NS; i < smmuv3_get_num_irqs(ARM_SMMUV3(dev)); i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(sms->gic,
+                                            secure_irq + i - SMMU_IRQ_NUM_NS));
+    }
 }
 
 static void create_pcie(SBSAMachineState *sms,
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 54647964c21..97a8663349e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -49,23 +49,30 @@
  *
  * @irq: irq type
  * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
+ * @sec_sid: security state of the programming interface
  */
 static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
-                               uint32_t gerror_mask)
+                               uint32_t gerror_mask, SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
+    int irq_index = irq;
 
     bool pulse = false;
 
     switch (irq) {
     case SMMU_IRQ_EVTQ:
+        if (sec_sid == SMMU_SEC_SID_S) {
+            irq_index = SMMU_IRQ_S_EVTQ;
+        }
         pulse = smmuv3_eventq_irq_enabled(s, sec_sid);
         break;
     case SMMU_IRQ_PRIQ:
         qemu_log_mask(LOG_UNIMP, "PRI not yet supported\n");
         break;
     case SMMU_IRQ_CMD_SYNC:
+        if (sec_sid == SMMU_SEC_SID_S) {
+            irq_index = SMMU_IRQ_S_CMD_SYNC;
+        }
         pulse = true;
         break;
     case SMMU_IRQ_GERROR:
@@ -73,6 +80,9 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
         uint32_t pending = bank->gerror ^ bank->gerrorn;
         uint32_t new_gerrors = ~pending & gerror_mask;
 
+        if (sec_sid == SMMU_SEC_SID_S) {
+            irq_index = SMMU_IRQ_S_GERROR;
+        }
         if (!new_gerrors) {
             /* only toggle non pending errors */
             return;
@@ -85,14 +95,14 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
     }
     }
     if (pulse) {
-            trace_smmuv3_trigger_irq(irq);
-            qemu_irq_pulse(s->irq[irq]);
+            trace_smmuv3_trigger_irq(irq_index);
+            qemu_irq_pulse(s->irq[irq_index]);
     }
 }
 
-static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
+static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn,
+                                 SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     uint32_t pending = bank->gerror ^ bank->gerrorn;
     uint32_t toggled = bank->gerrorn ^ new_gerrorn;
@@ -173,7 +183,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
     }
 
     if (!smmuv3_q_empty(q)) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
+        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0, sec_sid);
     }
     return MEMTX_OK;
 }
@@ -187,7 +197,8 @@ void smmuv3_propagate_event(SMMUv3State *s, Evt *evt, SMMUSecSID sec_sid)
     QEMU_LOCK_GUARD(&s->mutex);
     r = smmuv3_write_eventq(s, sec_sid, evt);
     if (r != MEMTX_OK) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
+                           R_GERROR_EVENTQ_ABT_ERR_MASK, sec_sid);
     }
 }
 
@@ -1483,7 +1494,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
         switch (type) {
         case SMMU_CMD_SYNC:
             if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
-                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
+                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0, sec_sid);
             }
             break;
         case SMMU_CMD_PREFETCH_CONFIG:
@@ -1733,7 +1744,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
     if (cmd_error) {
         trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
         smmu_write_cmdq_err(s, cmd_error, sec_sid);
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
+                           R_GERROR_CMDQ_ERR_MASK, sec_sid);
     }
 
     trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
@@ -1849,7 +1861,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         bank->irq_ctrl = data;
         break;
     case A_GERRORN:
-        smmuv3_write_gerrorn(s, data);
+        smmuv3_write_gerrorn(s, data, reg_sec_sid);
         /*
          * By acknowledging the CMDQ_ERR, SW may notify cmds can
          * be processed again
@@ -2239,11 +2251,16 @@ static const MemoryRegionOps smmu_mem_ops = {
     },
 };
 
+int smmuv3_get_num_irqs(SMMUv3State *s)
+{
+    return SMMU_IRQ_NUM;
+}
+
 static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
 {
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
+    for (i = 0; i < smmuv3_get_num_irqs(s); i++) {
         sysbus_init_irq(dev, &s->irq[i]);
     }
 }
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index d368913e766..43529b73e4a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1169,7 +1169,8 @@ static void acpi_dsdt_add_tegra241_cmdqv(Aml *scope, VirtMachineState *vms)
         sbdev = SYS_BUS_DEVICE(obj);
         base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
         base += vms->memmap[VIRT_PLATFORM_BUS].base;
-        irq = platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
+        irq = platform_bus_get_irqn(pbus, sbdev,
+                                    smmuv3_get_num_irqs(ARM_SMMUV3(obj)));
         irq += vms->irqmap[VIRT_PLATFORM_BUS];
         irq += ARM_SPI_BASE;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b11f7e328c..d1e12ae1b54 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -267,6 +267,7 @@ static const int a15irqmap[] = {
     [VIRT_UART1] = 8,
     [VIRT_ACPI_GED] = 9,
     [VIRT_GWDT_WS0] = 10,
+    [VIRT_SMMU_SECURE] = 11,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
@@ -2069,6 +2070,7 @@ static void create_smmu(const VirtMachineState *vms, PCIBus *bus)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int irq =  vms->irqmap[VIRT_SMMU];
+    int secure_irq = vms->irqmap[VIRT_SMMU_SECURE];
     int i;
     hwaddr base = vms->memmap[VIRT_SMMU].base;
     hwaddr size = vms->memmap[VIRT_SMMU].size;
@@ -2095,6 +2097,11 @@ static void create_smmu(const VirtMachineState *vms, PCIBus *bus)
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
                            qdev_get_gpio_in(vms->gic, irq + i));
     }
+    for (i = SMMU_IRQ_NUM_NS; i < smmuv3_get_num_irqs(ARM_SMMUV3(dev)); i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(vms->gic,
+                                            secure_irq + i - SMMU_IRQ_NUM_NS));
+    }
     create_smmuv3_dt_bindings(vms, base, size, irq);
 }
 
-- 
2.34.1


