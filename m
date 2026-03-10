Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26BCFD88C7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d1-0001HZ-7k; Tue, 10 Mar 2026 18:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cu-0001Fu-L9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:33 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cr-00073f-9l
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:32 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 cd6030fe8978e4c5bbc4cfd6ce63a47f45722afe3c28f40d0a22bf31fa78212a with SMTP id
 69b09bf59628775d0f6699fc; Tue, 10 Mar 2026 22:32:21 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181941;
 bh=wicgdC1xXrakkxUMlnFZPhjPUCkdX9Esz0JpQwmMlBU=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=cU9P8xCKyf/HpGvTVRM1VKp1FhrCcr5AMegUxwb1+dwLU72VbK++prfYw0yWj71P1
 C3CFyqV9HmZ82LubnYqtimc6z6cyyaSMEK69WQvfqtQDXWHTeTi1EK4Ih2jgAPi8k9
 thBS1lYM1+0ObgchWGJQyXJH/Pd44udJvDz+ln5eZ+0B7xWInL/0hM6IgRgYwHRJ5I
 z+IRf7mbcGxOW3PBnMMA5p1UjOmQlbpyTyHNQLhiaxfKxhCUlXmKF08xpCs44WxVwE
 qEbSzsJ/j7d/JcMduQmJ1acJV2vJgVJImCTFEDDdaejIMGmDCvn4eokeAeL3LRb0Vh
 +cnjr6Z2hO7LQ==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:48 -0500
Subject: [PATCH 08/15] hw/alpha: Set CPU link properties and use them
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-8-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2994; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=4+yl9aBE7yIAIoXFLFvfcGF9rFQ6EgOSgSsswW68crI=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP4olcWgvPru2kMlRR6ZE6cscrNWCc6502v13+vH6
 0PR99bmdZSyMIhxMciKKbJcPitx1iF3d1fayh/3YeawMoEMYeDiFICJ2Akz/I+aXD2N4Z7gv2wX
 oS6dmmzHO5fivDet84t1XCjOGtVxaD4jw9bY6Mqbq84d0FwmJZ21m29O4JrHGrsU/70QtuDu3q5
 +kgcA
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

Set the "cpu[*]" links upon instantiation. Eliminate the cpus
array parameter of typhoon_init(), as it is no longer needed.

Note: This commit helps with the eventual splitting of
typhoon_init() into instance_init and realize hooks, by
eliminating one of its parameters.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/alpha_sys.h | 2 +-
 hw/alpha/dp264.c     | 3 ++-
 hw/alpha/typhoon.c   | 5 ++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index 247a52b776..f6779520d9 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -11,7 +11,7 @@
 #define TYPE_TYPHOON_PCI_HOST_BRIDGE "typhoon-pcihost"
 OBJECT_DECLARE_SIMPLE_TYPE(TyphoonState, TYPHOON_PCI_HOST_BRIDGE)
 
-PCIBus *typhoon_init(MemoryRegion *, qemu_irq *, qemu_irq *, AlphaCPU *[4],
+PCIBus *typhoon_init(MemoryRegion *, qemu_irq *, qemu_irq *,
                      pci_map_irq_fn, uint8_t devfn_min, TyphoonState *);
 
 /* alpha_pci.c.  */
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index c9d639eb7b..c0996efffe 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -85,6 +85,7 @@ static void clipper_init(MachineState *machine)
         g_autofree char *name = g_strdup_printf("cpu[%ld]", i);
         Object *cpu = object_new(machine->cpu_type);
         object_property_add_child(OBJECT(machine), name, cpu);
+        object_property_set_link(typhoon_obj, name, cpu, &error_fatal);
         qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
         cpus[i] = ALPHA_CPU(cpu);
     }
@@ -107,7 +108,7 @@ static void clipper_init(MachineState *machine)
      * Init the chipset.  Because we're using CLIPPER IRQ mappings,
      * the minimum PCI device IdSel is 1.
      */
-    pci_bus = typhoon_init(machine->ram, &isa_irq, &rtc_irq, cpus,
+    pci_bus = typhoon_init(machine->ram, &isa_irq, &rtc_irq,
                            clipper_pci_map_irq, PCI_DEVFN(1, 0), typhoon);
 
     /*
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index b0eb4e415c..5fac5eba1c 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -832,7 +832,7 @@ static void typhoon_alarm_timer(void *opaque)
 }
 
 PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
-                     qemu_irq *p_rtc_irq, AlphaCPU *cpus[4],
+                     qemu_irq *p_rtc_irq,
                      pci_map_irq_fn sys_map_irq, uint8_t devfn_min,
                      TyphoonState *s)
 {
@@ -849,8 +849,7 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
 
     /* Remember the CPUs so that we can deliver interrupts to them.  */
     for (i = 0; i < 4; i++) {
-        AlphaCPU *cpu = cpus[i];
-        s->cchip.cpu[i] = cpu;
+        AlphaCPU *cpu = s->cchip.cpu[i];
         if (cpu != NULL) {
             cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                                  typhoon_alarm_timer,

-- 
2.53.0


