Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C707CF4181F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeAI-0005CA-SA; Mon, 09 Mar 2026 13:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzeAC-0005A9-3p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:13:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzeA9-0005Bg-H4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:13:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so28325355e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773076380; x=1773681180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qJCeYSLqU11VrpnsVU8yrksEs9M698NPtVZpG/bPxMA=;
 b=k/eOojqLr5lCsZjWw81MmsM6CJN3TC6dwMZknMrZUvcaUFJve7hlLH9HlogGCgjvdf
 OvJDhm7k7gI05em9iIh+YGLbd5QT6WghG/VC9pfmZfyDvJMAd5sTRcwjdLKGDmeK3dTi
 zZ7f82Nks/9k0QlOx9GppJ+gFqoeDIIcDl2bfdx9Q01TJEajABPgT4edAD/HZ8ucqKtY
 Pe5PLbFlKnl6geTnRRPRflbNHhy+oNSYS5C9jhStwnzIXXh0RAFnEl0JhqxPk08CXJV7
 qRiLLBJO4aBQHxZgAgPv2xByq4Vp9y+OJKqZrEf3gD0JobQ/B8EzKoan2U0GO5KHAov7
 PUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773076380; x=1773681180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJCeYSLqU11VrpnsVU8yrksEs9M698NPtVZpG/bPxMA=;
 b=pBeH1hXLJ5lhpETbghRYRWKOSUGGBcsPbWrDK2dRUZ7fjo6ENWANSae9SF2coCN1wp
 tYX1hNY3wQosOIYsfyWZUAXdJsH/WiGWDeLqnmF62hJrc9qz/vBVS5ZKjXzNWPvXXto4
 UCs1RqlRhBeHbNpOs7CyJp9ol7Lcq4WRElmKW2IOYQ0Z7oOGi40ASOYKzJYvdB9oa+nL
 pQGyJ7JJIGdZVaQ7CpKQ9SZl7ebhi9gbVBt/vt2G8ch5HNropIk5DekSM88lOr67OocA
 +Nwa2Cvx6s+Sd3vQ6JaMICQci2arzoyaS8/rGJlOX7/L7rPGLndjnor8gJGQHwHb6wBY
 mFFA==
X-Gm-Message-State: AOJu0YxF3C/kmdgHMbW5ZZjk8E9kI/gOympAd8IvMM3QS4AKMc9qaR+t
 /OhroK+tXhEKDoRZcqvowom1HziTyT+9Ld4cvA/nHdeq5nn2Eim+xqMQbBrydtaEgUky8+o9a/S
 HJYDw
X-Gm-Gg: ATEYQzzwjTtBESHVn0V0BOK9h3/9PZI6DoAXMLXtc5kvf4TQUeVlGVKAWsYfdWeBira
 SVnEyY9Sbn9x6vlkCFehvms7gJDSJUtWFHuTboGK//5xnAOC/LJV0R8mZ2L4bG3s4efi59qfDmB
 fwbr1FUPAXgl/n5ZZxT8oCPNQ0WqksVuJzlY2r9Er90M/ZLsbGrGkANhDnhLP8fukIvI22h+vJZ
 +RAjAu1g59/laPKNANDToDgVIC8jD/BNd0It+GO4QU6URV2THcp4ZbpLkdR0vxaokOi2ZfyNo11
 iFvFFfVJpnZOHRhc3yDUbdVCHIlaY2WkmGw6P+SloRjl/0NhzdeAEM/AyiCE/ukt6yHliUVSCi2
 pRZmUPKLEUlkJAMmwG7h/qXiB09es7R7bGE2TPKiJfDioPuU/DgUyke96bc3wC3zrav4ji47IzB
 oPJWstTq29n9s2iTb38W42SiupsHdJsE8FSmB9EGrBReAe2OFzHT8krpcHKAEZ6uVRCqzK2Rs8T
 HMhfNgc8hfnkrddKISGB5dqHcIkf7Q=
X-Received: by 2002:a05:600c:4e4e:b0:485:363b:fafd with SMTP id
 5b1f17b1804b1-485363bfc84mr92763845e9.6.1773076379588; 
 Mon, 09 Mar 2026 10:12:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b7f406sm3955395e9.13.2026.03.09.10.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:12:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH] hw/isa/piix: Embed i8259 irq in device state instead of
 allocating
Date: Mon,  9 Mar 2026 17:12:58 +0000
Message-ID: <20260309171258.1905205-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The pci_piix_realize() function's use of qemu_allocate_irqs()
results in a memory leak:

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x61045c7a1a43 in malloc (/home/pm215/qemu/build/san/qemu-system-mips+0x16f8a43) (BuildId: aa43d3865e0f1991b1fc04422b5570fe522b6fa7)
    #1 0x724cc3095ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x61045db72134 in qemu_extend_irqs /home/pm215/qemu/build/san/../../hw/core/irq.c:77:51
    #3 0x61045cd7bf49 in pci_piix_realize /home/pm215/qemu/build/san/../../hw/isa/piix.c:318:35
    #4 0x61045cf4533e in pci_qdev_realize /home/pm215/qemu/build/san/../../hw/pci/pci.c:2308:9
    #5 0x61045db6cbca in device_set_realized /home/pm215/qemu/build/san/../../hw/core/qdev.c:523:13
    #6 0x61045db86bd9 in property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:2376:5
    #7 0x61045db81c5e in object_property_set /home/pm215/qemu/build/san/../../qom/object.c:1450:5
    #8 0x61045db8e2fc in object_property_set_qobject /home/pm215/qemu/build/san/../../qom/qom-qobject.c:28:10
    #9 0x61045db8258f in object_property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:1520:15
    #10 0x61045db687aa in qdev_realize_and_unref /home/pm215/qemu/build/san/../../hw/core/qdev.c:283:11
    #11 0x61045d892e21 in mips_malta_init /home/pm215/qemu/build/san/../../hw/mips/malta.c:1239:5

(The i386 PC sets the has-pic property to 'false', so this only
affects the MIPS Malta board.)

Fix this by embedding the i8259 irq in the device state instead of
allocating it.  This is a similar fix to the one we used for vt82c686
in commit 2225dc562a93dc, except that we use qemu_init_irq_child()
instead of qemu_init_irq().  The behaviour is identical except that
the _child() version avoids what would be a leak if we ever
unrealized the device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The handling of IRQs in i8259_init() is rather convoluted and forces
its callers into having an IRQ that just forwards the set operation
outwards. It could in theory be cleaned up, but it's used in too
many places for that to seem worthwhile just now.
---
 hw/isa/piix.c                 | 11 ++++++-----
 include/hw/southbridge/piix.h |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 04b2be2cc3..31fa53e6a4 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -315,12 +315,13 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
 
     /* PIC */
     if (d->has_pic) {
-        qemu_irq *i8259_out_irq = qemu_allocate_irqs(piix_request_i8259_irq, d,
-                                                     1);
-        qemu_irq *i8259 = i8259_init(isa_bus, *i8259_out_irq);
-        size_t i;
+        qemu_irq *i8259;
 
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
+        qemu_init_irq_child(OBJECT(dev), "i8259-irq", &d->i8259_irq,
+                            piix_request_i8259_irq, d, 0);
+        i8259 = i8259_init(isa_bus, &d->i8259_irq);
+
+        for (size_t i = 0; i < ISA_NUM_IRQS; i++) {
             d->isa_irqs_in[i] = i8259[i];
         }
 
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 86709ba2e4..a296b1205a 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -17,6 +17,7 @@
 #include "hw/ide/pci.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/usb/hcd-uhci.h"
+#include "hw/core/irq.h"
 
 /* PIRQRC[A:D]: PIRQx Route Control Registers */
 #define PIIX_PIRQCA 0x60
@@ -52,6 +53,8 @@ struct PIIXState {
     qemu_irq cpu_intr;
     qemu_irq isa_irqs_in[ISA_NUM_IRQS];
 
+    IRQState i8259_irq;
+
     /* This member isn't used. Just for save/load compatibility */
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
 
-- 
2.43.0


