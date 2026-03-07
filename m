Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EE6FC9EF5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 11:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vypqn-0004J3-6A; Sat, 07 Mar 2026 06:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypql-0004I0-I8
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:29:39 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypqj-0006Af-P3
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:29:39 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso4414155f8f.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 03:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772882974; x=1773487774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uMhouh8lU7AhEzD5xKxFtylYc2aC2/dOO3bXKq0ZJng=;
 b=IujCuo3EWmdhwRTjV67A5sqJGhUoAvLCP4luB3XICghIxuidGCZhKFK49MU91fKgbr
 EfObkU618z5Wsftr8g/00hhOt6X1SySScgWbfUQX5XdmkpiRPDLvOl+DZTWdcTmEgtPv
 ZG6kzhDPCQwFhDv8sV3klgmKWtyphgCQtgdsISzR3hjtox1Kfzho6JsWU2LOqElH6dWr
 9d82xpZatxL96k+af8W/btN/OswZSYsoJ35m3lYEVmXc8yRnw2DjUFb35bLFIbpKX1rK
 XrptkG1B+kNrQ1YQT/i+m3shfq1O+wDD0yiDELy2KA3hk/NGuID3m4qF+E5B6gqleRxx
 p3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772882974; x=1773487774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uMhouh8lU7AhEzD5xKxFtylYc2aC2/dOO3bXKq0ZJng=;
 b=vBT/fDpU8ch7I60NfMcXG1mGfdRbs/h60eEZAL9beIjGUvSDL14R24GGtNuTUCsWgE
 /7bof9wE/J7NsTVI8IGWomP0bglal2O55Cd7CpfdxGud9VXwesQLI1W1JlvNmRYXs2F3
 QWMHuLJifDrA4YOMSo5DeOoYejO0KW3juVyBDPQxmmICFYkyw7+tF849mX26C+nisCtE
 2oM6m7g1VKdB2WG1GJc2d9P52q7ITXqV55oDj8oi90fusWEjLu6nEmWCnnSaRjAvASyq
 ZJXQfgo4zAnJMhLJxeAp97imaXKHLMp3dsyGPQkmqWSOMi53cfiooyrnLL0GOErFMsF2
 OZ+w==
X-Gm-Message-State: AOJu0YxBjkhG0O952xnMPFHsXHyeCW2QST48GUwUr7AAUgHDtDbPErEv
 SkdP8DvzRYUHDWWqY7RgKgHHIX9Zb1wPJR4Uraveih07iKLKX35ZTEcC2y4SzMYkR0BHtHxd3GY
 1cuex
X-Gm-Gg: ATEYQzzUgA6ZRaIoqanSmnorWJyAo61CAGQrP+nPHHafFB4mWc41umVVTSdMHobBaIk
 SwTwyPQKnMVklsvzaQ7wYeZCdm80g15z94M5AHv/BaJa6fduWrX+8JVcIupS3P1HO81CQ4i4UlE
 +u39ZZHXIUzHkkAqwtZ6OMlNm/Ybx+3BVp4MyrTLkIunFtWG9NPpNMV610Og08WXkBODdFDQzWK
 qJ3UZTBrwmcLSPrVWtAS2PGy0BQhvEnUrLu0Xu3jcByrLxmxNtERqGNF2RvvVwZHJlPAjB7/2Gj
 okw/mwfL1oFU7Kbs2qhyfI12LkEMXHZPn8mnLw7ucs1smZVtwgCm6p0dVjaNeQi5RUHiRvDxUeY
 IFMIyL8WBY9M6445bte+lgTNV7KFDBl9wU4alGm0m99zEGsprnIaB7N1JTYnijpdjS2g8nxI263
 VTxtACeW2FxPJQZ39YGVtE9OyHUs0PauUEPdt2E15d68mkgRu+NbH0fO18UMYrBGubOSSoxPawE
 he4s37cZnjB9l5LFhhoCmUfeRlQk7U=
X-Received: by 2002:a05:600c:1e88:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-48526916beamr101336255e9.7.1772882974219; 
 Sat, 07 Mar 2026 03:29:34 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853252cae1sm13462255e9.3.2026.03.07.03.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 03:29:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 1/3] hw/sparc/sun4m: Don't set up dummy cpu interrupts
Date: Sat,  7 Mar 2026 11:29:29 +0000
Message-ID: <20260307112931.3322532-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307112931.3322532-1-peter.maydell@linaro.org>
References: <20260307112931.3322532-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

In the sun4m machine init, we set up the cpu_irqs[] array
with the real inbound IRQs for each CPU, followed by some
dummy IRQs for the remaining slots from smp_cpus up to
MAX_CPUS. These dummy IRQs do nothing when set/cleared
because the dummy_cpu_set_irq() function does nothing.

Instead of creating these "do nothing" qemu_irqs, instead
pass the number of CPUs to slavio_intctl_init() so that it
can only wire up the interrupt controller's interrupts
for the CPUs that actually exist. Calling qemu_set_irq()
on an irq that isn't connected does nothing, so this is
a simpler way to achieve the same result.

This cleanup fixes an unimportant memory leak reported by
the address sanitizer that happens because we allocate these
dummy IRQs with qemu_allocate_irqs():

Direct leak of 1920 byte(s) in 15 object(s) allocated from:
    #0 0x5cb7b120cf63 in malloc (/home/pm215/qemu/build/san/qemu-system-sparc+0xe0bf63) (BuildId: d27f9230a7cc82ebfaf0cf9e439dc215ddd7ac68)
    #1 0x743cd6dc5ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x5cb7b1a42fb4 in qemu_extend_irqs /home/pm215/qemu/build/san/../../hw/core/irq.c:77:51
    #3 0x5cb7b19e7e72 in sun4m_hw_init /home/pm215/qemu/build/san/../../hw/sparc/sun4m.c:845:23
    #4 0x5cb7b141d3dd in machine_run_board_init /home/pm215/qemu/build/san/../../hw/core/machine.c:1709:5
    #5 0x5cb7b1542895 in qemu_init_board /home/pm215/qemu/build/san/../../system/vl.c:2717:5
    #6 0x5cb7b1542895 in qmp_x_exit_preconfig /home/pm215/qemu/build/san/../../system/vl.c:2811:5
    #7 0x5cb7b15493ac in qemu_init /home/pm215/qemu/build/san/../../system/vl.c:3849:9
    #8 0x5cb7b1f3f201 in main /home/pm215/qemu/build/san/../../system/main.c:71:5
    #9 0x743cd4a2a1c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #10 0x743cd4a2a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #11 0x5cb7b1172114 in _start (/home/pm215/qemu/build/san/qemu-system-sparc+0xd71114) (BuildId: d27f9230a7cc82ebfaf0cf9e439dc215ddd7ac68)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sparc/sun4m.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a17bdb3692..29bc26ebcb 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -196,10 +196,6 @@ static void cpu_set_irq(void *opaque, int irq, int level)
     }
 }
 
-static void dummy_cpu_set_irq(void *opaque, int irq, int level)
-{
-}
-
 static void sun4m_cpu_reset(void *opaque)
 {
     SPARCCPU *cpu = opaque;
@@ -344,6 +340,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
 
 static DeviceState *slavio_intctl_init(hwaddr addr,
                                        hwaddr addrg,
+                                       unsigned int smp_cpus,
                                        qemu_irq **parent_irq)
 {
     DeviceState *dev;
@@ -355,7 +352,7 @@ static DeviceState *slavio_intctl_init(hwaddr addr,
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
 
-    for (i = 0; i < MAX_CPUS; i++) {
+    for (i = 0; i < smp_cpus; i++) {
         for (j = 0; j < MAX_PILS; j++) {
             sysbus_connect_irq(s, i * MAX_PILS + j, parent_irq[i][j]);
         }
@@ -841,9 +838,6 @@ static void sun4m_hw_init(MachineState *machine)
         cpu_devinit(machine->cpu_type, i, hwdef->slavio_base, &cpu_irqs[i]);
     }
 
-    for (i = smp_cpus; i < MAX_CPUS; i++)
-        cpu_irqs[i] = qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_PILS);
-
     /* Create and map RAM frontend */
     dev = qdev_new("memory");
     object_property_set_link(OBJECT(dev), "memdev", OBJECT(ram_memdev), &error_fatal);
@@ -860,6 +854,7 @@ static void sun4m_hw_init(MachineState *machine)
 
     slavio_intctl = slavio_intctl_init(hwdef->intctl_base,
                                        hwdef->intctl_base + 0x10000ULL,
+                                       smp_cpus,
                                        cpu_irqs);
 
     for (i = 0; i < 32; i++) {
-- 
2.43.0


