Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460A6C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mSK-0008Tc-Ro; Wed, 16 Sep 2026 06:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRh-000885-PA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:56 -0400
Received: from qs-2003a-snip6-11.eps.apple.com ([2a01:b747:3006:204::d]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRg-0005FU-1z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:53 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id
 712E81800BC1; Wed, 16 Sep 2026 10:00:47 +0000 (UTC)
X-ICL-RepId: 01a0a9a9-69e1-7621-888e-338619f70f67
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0IShMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLSAFbB1IDRghIA10FWhxHCkABWBpSHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789552851; x=1792144851;
 bh=FIznWV24oNw8Sya1w+azG+7Xp+DpfmhjLIwDAtI19ts=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=pj9bJkg6J1lp8yLVfHq705W2AGZwOOBh/ImLnfBc6g6/qtJn3gbr7JZwM33LUt34DQdSfXwiFQn/GAkW4rtZzojbLFenM+ywFABe+m0+ZOBJSnQEdu1a7qfU0ZJmEcB46Y/05EMOxWQtykdKEY19ZvoIEieejtnnzfUmBR5N5M8OOv97VbposJ9HImm/68O/LS1RARk2Or2YjgNscU6DU6LEBMpCSf+4KqkzLDlUkG/y1bJBL0YQs9wNHGfHUqdiw/VU95Tde/dsquXzLO2mowV/1qSULeFNWHFM7cGEkpz/Jz/eHSCurnztL/zdUomLSkLCPanCrB2BkC3NzdG6QQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id
 0752A1800172; Wed, 16 Sep 2026 10:00:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v8 08/10] vmapple: add gicv2m
Date: Wed, 16 Sep 2026 12:00:16 +0200
Message-ID: <20260916100021.73825-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916100021.73825-1-mohamed@unpredictable.fr>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfX6WetL08h+XOI
 Lc6xaFKPDqgOI8xlU+Mhk4DIh0dVzpoBU7/C7taAti4r03LyNA9QJ/ByjfLzzS2BNBqE5N7Lgky
 +YmC2hII2FDehtc4vdLosWEQWPmanxdGWD0SCKL66/YESTG+AgfdFg95tThKGfbFhuh9gwL9CyO
 SJL4RRgD/P0WKaY2AhLfVOmBnlhWvUIkuNywhapQuuUYwV9VVQE5zSGoHFpYaXemqwZ1lyOUvp/
 y7A+uLDY39uX1CxLhtGhq60TmlYsCXFTfbGHa+qHBQS2uLZhRXm8Qn3fbL2/FhiuVtnlu5o1Vhf
 tOqfOjD+jqAhkLRIJyM5A32mPtSawTCKBbpDs9vbWdljGSY5xxeeK2yK76QQRo=
X-Proofpoint-GUID: MLoCm096RJtGOciEHYXboPMpur-tdVoT
X-Proofpoint-ORIG-GUID: MLoCm096RJtGOciEHYXboPMpur-tdVoT
X-Authority-Info-Out: v=2.4 cv=V8hwEOni c=1 sm=1 tr=0 ts=6aaa68d1
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sAlVIecbGMDsLuTEZI0A:9
X-JNJ: AAAAAAABueZG2hXuli0Tgtvg5E1kwblq65C2QVvbHsuZlud2IEP9jxqmBAwkzMQ2KEbC9UcSz0LepJaZj7tfF0YQFdVK/jbYcHlqOBuSZ7Fv7fePlS0Vv0urGdrSerC+fM6yNoUYMfXZcsRnaL9PqcMjqh3qrRzf8V4ygK0gnq/RQfvlAtxZenhgeMHmER+2hQCoENWH6c2AqCk+gC1yGcID0STUAKTsrb3Nhm12PoGbUcZYKOCMktDwjVjKQTgYrx7Q/BcsrPsVi1o11o2PNrZnRTUyhaTfcMnfQJ/UadB8VkDD9Rs0grTOnFiH0Z0gqbzl0M2zrVPSNr+fJr1ovb96gq2W7SFNJwguJDo8ae404S+spFp3hb9SOjXc7FajMO4W6MegbT+AzzWm1RujK4wqcDs6IXBs2INNCOmwyixdKGUd/ZvI0B0+Xhi7qU/LF/WGQw/m/FLZ4ZgfJGwQ13+leJfCDpi00lvVdsM93zc414U8bXvoWgCz4N/tJrdQmOGtuRJ+CBkkpxU0PFxK045m99TPBJl9Vm5X/Bgl7gximZeREahTJ0HaookEFFrirfv6CloHRGr6tbgYnw84bv9GGnHLesPlKYfKCFLJUUELd46gRMsyNCKTdpUT2rnlM9p1R+CDVEuRd6QuJbZuuQoxk5qYHKLKS/3cfCU777eQvI6br9KhjLeCg0AhzNqdh42kmbaF1Qc7hggW+FDv1kxZ6sF/27hmBqx9OJXGrUxfG0DGgoXaxMDxkIk6LPuf+kcitC6xHD05wiBQsfrU9dvuTKRxGmFdK4PdGP39oH2UR+O3HdCZlsQGfhJdDdlRoJhpe3W18ZPAKQqLX+hGJD9weYPrJzDGjA==
Received-SPF: pass client-ip=2a01:b747:3006:204::d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/vmapple/vmapple.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 607181f517..2467c79ab3 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -82,6 +82,7 @@ enum {
     VMAPPLE_MEM,
     VMAPPLE_GIC_DIST,
     VMAPPLE_GIC_REDIST,
+    VMAPPLE_GICV2M,
     VMAPPLE_UART,
     VMAPPLE_RTC,
     VMAPPLE_PCIE,
@@ -103,6 +104,7 @@ static const MemMapEntry memmap[] = {
 
     [VMAPPLE_GIC_DIST] =           { 0x10000000, 0x00010000 },
     [VMAPPLE_GIC_REDIST] =         { 0x10010000, 0x00400000 },
+    [VMAPPLE_GICV2M] =             { 0x1FFF0000, 0x00010000 },
 
     [VMAPPLE_UART] =               { 0x20010000, 0x00010000 },
     [VMAPPLE_RTC] =                { 0x20050000, 0x00001000 },
@@ -128,6 +130,7 @@ static const int irqmap[] = {
     [VMAPPLE_APV_GFX] = 0x11,
     [VMAPPLE_AES_1] = 0x12,
     [VMAPPLE_PCIE] = 0x20,
+    [VMAPPLE_GICV2M] = 0x80
 };
 
 #define GPEX_NUM_IRQS 16
@@ -285,6 +288,26 @@ static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
     }
 }
 
+#define NUM_GICV2M_SPIS       128
+
+static void create_gicv2m(VMAppleMachineState *vms)
+{
+    int i;
+    int irq = vms->irqmap[VMAPPLE_GICV2M];
+    DeviceState *dev;
+
+    dev = qdev_new("arm-gicv2m");
+    qdev_prop_set_uint32(dev, "base-spi", irq);
+    qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VMAPPLE_GICV2M].base);
+
+    for (i = 0; i < NUM_GICV2M_SPIS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(vms->gic, irq + i));
+    }
+}
+
 static void create_uart(const VMAppleMachineState *vms, int uart,
                         MemoryRegion *mem, Chardev *chr)
 {
@@ -495,6 +518,7 @@ static void mach_vmapple_init(MachineState *machine)
                                 machine->ram);
 
     create_gic(vms, sysmem);
+    create_gicv2m(vms);
     create_bdif(vms, sysmem);
     create_pvpanic(vms, sysmem);
     create_aes(vms, sysmem);
-- 
2.54.0 (Apple Git-157)


