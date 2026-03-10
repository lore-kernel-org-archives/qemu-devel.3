Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D568FD88C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d3-0001JU-FL; Tue, 10 Mar 2026 18:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cx-0001GT-8M
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:36 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cv-00073x-OG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:34 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 e3eae5278e78a74b29245b337ebde5402886ef0f423f2da3f3b2bfa1c3b59332 with SMTP id
 69b09bf6bbf64f6899e0662b; Tue, 10 Mar 2026 22:32:22 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181942;
 bh=ZnxAJzgYH9ZG2omqVFaAj6k38B27lb9zSPEJjo/0sxc=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=Eyn1Il2yBkk2zYhkj4SOoya+HnSxIDZhJxh5D8RIAYPoeEUPN6VhiVMfE0dox0QfV
 lpmiuGs34/bSEWuitKl7OKOGWSgnJf44kBZC+Qla9YOrVDfRh180VBLSPZe1oKJ7hE
 zKA6CNzi6w50sHBeUMLXV8YLjLcIPe5v0lzWVZFRkYiuX82zHaaBiZz3CGgZBoXiN4
 PiG5YhqKIj+kYb2Xzw/PRa8cZ170PSi0wiqWBY4lAW2gMqGlocwinqvqEbN60blgBP
 u/HqUV3vIzk0JCKuc2j3HYwVpdUf+YdgKNX8qQrQQPfvxtC9pMLEA785n+XMYs4HRH
 b1ue0VgIW5hGw==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:50 -0500
Subject: [PATCH 10/15] hw/alpha: Expose RAM to typhoon via QOM property
 link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-10-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4218; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=XI6uGBEJ2/O7iYlIzV2EFhEmPsdhy30vn8asQ0sinDg=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP708dc5BmemwJqnnz7kcyjzcvJqb9Xx4OupVtjXG
 x3QLa/eUcrCIMbFICumyHL5rMRZh9zdXWkrf9yHmcPKBDKEgYtTACYinMjI0DBhZYRTeZmkrw9D
 cNBbE++JfqdnaKbcnGdxUld9UUxXFyPDFWP3vst+T7PSnNwNpverT/u/uPt76+3i9tz7ykaW1W0
 8AA==
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HELO_STATIC_HOST=-0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently, the board (Clipper/DP264) passes machine->ram to the
chipset (Typhoon) as an arg to typhoon_init(), where it is
added as a subregion of system memory. This commit, instead adds
a ram pointer in TyphoonState, defines it as a Property, and sets
a link to it from the machine, thus removing the ram parameter.

Note: Moving the ram subregion mapping into machine code was
considered but decided against so as to preserve the Typhoon's
historical role in mapping the address space.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/alpha_sys.h |  5 +++--
 hw/alpha/dp264.c     |  8 +++++---
 hw/alpha/typhoon.c   | 14 +++++++++++---
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index 39a96760d7..8611881b55 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -11,8 +11,9 @@
 #define TYPE_TYPHOON_PCI_HOST_BRIDGE "typhoon-pcihost"
 OBJECT_DECLARE_SIMPLE_TYPE(TyphoonState, TYPHOON_PCI_HOST_BRIDGE)
 
-PCIBus *typhoon_init(MemoryRegion *,
-                     pci_map_irq_fn, uint8_t devfn_min, TyphoonState *);
+PCIBus *typhoon_init(pci_map_irq_fn, uint8_t devfn_min, TyphoonState *);
+
+#define TYPHOON_PROP_RAM "ram"
 
 #define TYPHOON_GPIO_ISA_IRQ "isa-irq"
 #define TYPHOON_GPIO_RTC_IRQ "rtc-irq"
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 61eeaef6db..a7fc137e70 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -102,12 +102,14 @@ static void clipper_init(MachineState *machine)
     cpus[0]->env.trap_arg1 = 0;
     cpus[0]->env.trap_arg2 = smp_cpus | (!machine->enable_graphics << 6);
 
+    object_property_set_link(typhoon_obj, TYPHOON_PROP_RAM,
+                             OBJECT(machine->ram), &error_fatal);
+
     /*
      * Init the chipset.  Because we're using CLIPPER IRQ mappings,
      * the minimum PCI device IdSel is 1.
      */
-    pci_bus = typhoon_init(machine->ram,
-                           clipper_pci_map_irq, PCI_DEVFN(1, 0), typhoon);
+    pci_bus = typhoon_init(clipper_pci_map_irq, PCI_DEVFN(1, 0), typhoon);
 
     /*
      * Init the PCI -> ISA bridge.
@@ -245,7 +247,7 @@ static void clipper_machine_init(ObjectClass *oc, const void *data)
     mc->max_cpus = 4;
     mc->is_default = true;
     mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
-    mc->default_ram_id = "ram";
+    mc->default_ram_id = TYPHOON_PROP_RAM;
     mc->default_nic = "e1000";
 }
 
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 03bb4c8055..792ace5ce7 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -55,6 +55,8 @@ struct TyphoonState {
     TyphoonCchip cchip;
     TyphoonPchip pchip;
     MemoryRegion dchip_region;
+
+    MemoryRegion *ram;
 };
 
 /* Called when one of DRIR or DIM changes.  */
@@ -831,8 +833,7 @@ static void typhoon_alarm_timer(void *opaque)
     cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
 }
 
-PCIBus *typhoon_init(MemoryRegion *ram,
-                     pci_map_irq_fn sys_map_irq, uint8_t devfn_min,
+PCIBus *typhoon_init(pci_map_irq_fn sys_map_irq, uint8_t devfn_min,
                      TyphoonState *s)
 {
     MemoryRegion *addr_space = get_system_memory();
@@ -860,7 +861,7 @@ PCIBus *typhoon_init(MemoryRegion *ram,
      * Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
      * but the address space hole reserved at this point is 8TB.
      */
-    memory_region_add_subregion(addr_space, 0, ram);
+    memory_region_add_subregion(addr_space, 0, s->ram);
 
     /* TIGbus, 0x801.0000.0000, 1GB.  */
     /*
@@ -956,11 +957,18 @@ static void typhoon_pcihost_init(Object *obj)
                             1);
 }
 
+static const Property typhoon_properties[] = {
+    DEFINE_PROP_LINK(TYPHOON_PROP_RAM, TyphoonState, ram,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+};
+
 static void typhoon_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->user_creatable = false;
+
+    device_class_set_props(dc, typhoon_properties);
 }
 
 static const TypeInfo typhoon_pcihost_info = {

-- 
2.53.0


