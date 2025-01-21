Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5429C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGc1-0004LV-GF; Tue, 21 Jan 2025 10:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGbS-0003xH-O9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:55:47 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGbR-0001xS-2I
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:55:46 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3863703258fso4610458f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737474942; x=1738079742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS948Gr2VsnNjnco9hXr7RbHaTk3SiCQ0lKFo2k/clM=;
 b=rZkiBxPK4YiLMLf29HxL4ArNK+xMTNMQrvRJOgHxGFjX5snjN0uuwbGGgWe6pBfRT+
 8+jtBX8OOFBSJzceMA+zz7d71XmQnw3H52gYPb+hC0o/ZZB30PmaOExGDdJWp2QXOZ2I
 TK/ZZfO65i/UyZyA5cTqi9LUrINp60R7psMsHfT8fybJDcGf//eVZZ+taAInbR4aB4F1
 KoWpYPYYQEB1kmm5K+OrzmFGuUbQFok1fZiiyhcKU82UsgjWAoQBPli/3Z0tRUKmAkwa
 esucQfdY2QNv3gnjmsI53jvD80U41NpxDHR0wyJLKP8nb3aV9ngYZKz2nVbvYkyQrek+
 zVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737474942; x=1738079742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eS948Gr2VsnNjnco9hXr7RbHaTk3SiCQ0lKFo2k/clM=;
 b=PUyaq77s6IH+UBkNg5wnTuXWIpOMChszwdqeEbcR28dRPtPOIirhrDy1dE3sgFVf2z
 HcovcGg8qhrrs1QpbEPbwM8sd/P4FMBn6v73PitAuLyhhUSOk7XREvqWzfwRbONa1cOA
 CF9AASOU6zuRPHaZy54rBEOtKNATcVyEXc0RtoznXIIVS9vhHNQiwWhlWM2Ygj+bECBU
 HYqIDkyv4LJ6sZXEdAsspJpwR4uRGwJOKR5PAXozRuHLUioqbQvSlOY88ASrwOr/52OY
 90dcK51pQgJokeg0VxJ2PN5oB4R3QRaHIJqkvxzypm9GsdR7glmBUvmKuNt9uYPnXXeY
 W4Bw==
X-Gm-Message-State: AOJu0YwYpiPgHN6x6sBi2gYod5QYTO7GEpW5e0NZ/1Lb2HG4jXwTrEx0
 qTOTtoJrG3GR3l8eh1fUNizGYZcnKN/NBqdMlyavW5mEBd7NApmAMsy/sLofNKb8WZh6+cXVG3m
 vUK0=
X-Gm-Gg: ASbGncvt7313qwEvMmhN3Sks+4VKoM6uUlpsBzOEb7SWeDca2psaP7YocylfvTCAgUE
 OWXbxCT0DMOhRlDITbat5QjBJ65QezOxIwreL9hAxz/AkGOeawg39le/LyuOiNrBaMZEJ+LvUar
 AyvqUBnO3YulzqOUK9PIgWGP1ve5mTpqNiJlmob/JaOObdV9YZqfD6OTLJ6uyf/ycKw+FnIXH73
 KcvQA+1+3PL2Ytt3d0X3caIc+TyC7BnqJ6Iq00vRUeDcjm/OaKTlNnTTJxFKgGAumE+jb1Zqc9d
 txCeaKRmgcoxs635c8w3bDTlMQBzp5peVjqMFPkCRiP/
X-Google-Smtp-Source: AGHT+IEVLwrii0Krz7P2g1JxxGLFGT8NEF1Fs9YKg0MVpTh57Bb9UqEg6FM5CZEsJ/SXOa8r+q1g+g==
X-Received: by 2002:a5d:598d:0:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38bf5b02ac3mr14856940f8f.18.1737474941719; 
 Tue, 21 Jan 2025 07:55:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3214fc9sm13471098f8f.6.2025.01.21.07.55.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 07:55:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/3] hw/ipack: Remove legacy qemu_allocate_irqs() use
Date: Tue, 21 Jan 2025 16:55:26 +0100
Message-ID: <20250121155526.29982-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121155526.29982-1-philmd@linaro.org>
References: <20250121155526.29982-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

No need to dynamically allocate IRQ when we know before hands
how many we'll use. Declare the 2 of them in IPackDevice state
and initialize them in the DeviceRealize handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ipack/ipack.h | 7 ++-----
 hw/char/ipoctal232.c     | 4 ++--
 hw/ipack/ipack.c         | 5 +----
 hw/ipack/tpci200.c       | 6 +++---
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/hw/ipack/ipack.h b/include/hw/ipack/ipack.h
index cbcdda509d3..00f397fd020 100644
--- a/include/hw/ipack/ipack.h
+++ b/include/hw/ipack/ipack.h
@@ -12,6 +12,7 @@
 #define QEMU_IPACK_H
 
 #include "hw/qdev-core.h"
+#include "hw/irq.h"
 #include "qom/object.h"
 
 
@@ -19,10 +20,8 @@
 OBJECT_DECLARE_SIMPLE_TYPE(IPackBus, IPACK_BUS)
 
 struct IPackBus {
-    /*< private >*/
     BusState parent_obj;
 
-    /* All fields are private */
     uint8_t n_slots;
     uint8_t free_slot;
     qemu_irq_handler set_irq;
@@ -58,13 +57,11 @@ struct IPackDeviceClass {
 };
 
 struct IPackDevice {
-    /*< private >*/
     DeviceState parent_obj;
-    /*< public >*/
 
     int32_t slot;
     /* IRQ objects for the IndustryPack INT0# and INT1# */
-    qemu_irq *irq;
+    IRQState irq[2];
 };
 
 extern const VMStateDescription vmstate_ipack_device;
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index d1e5f6dad2e..a2879977fb3 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -184,9 +184,9 @@ static void update_irq(IPOctalState *dev, unsigned block)
     unsigned intno = block / 2;
 
     if ((blk0->isr & blk0->imr) || (blk1->isr & blk1->imr)) {
-        qemu_irq_raise(idev->irq[intno]);
+        qemu_irq_raise(&idev->irq[intno]);
     } else {
-        qemu_irq_lower(idev->irq[intno]);
+        qemu_irq_lower(&idev->irq[intno]);
     }
 }
 
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index ed75f791832..b6defae6025 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -55,22 +55,19 @@ static void ipack_device_realize(DeviceState *dev, Error **errp)
     }
     bus->free_slot = idev->slot + 1;
 
-    idev->irq = qemu_allocate_irqs(bus->set_irq, idev, 2);
+    qemu_init_irqs(idev->irq, ARRAY_SIZE(idev->irq), bus->set_irq, idev);
 
     k->realize(dev, errp);
 }
 
 static void ipack_device_unrealize(DeviceState *dev)
 {
-    IPackDevice *idev = IPACK_DEVICE(dev);
     IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(dev);
 
     if (k->unrealize) {
         k->unrealize(dev);
         return;
     }
-
-    qemu_free_irqs(idev->irq, 2);
 }
 
 static const Property ipack_device_props[] = {
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index 88eef4b8308..470a4203ae4 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -275,11 +275,11 @@ static void tpci200_write_las0(void *opaque, hwaddr addr, uint64_t val,
                 if (ip != NULL) {
                     if (val & STATUS_INT(i, 0)) {
                         DPRINTF("Clear IP %c INT0# status\n", 'A' + i);
-                        qemu_irq_lower(ip->irq[0]);
+                        qemu_irq_lower(&ip->irq[0]);
                     }
                     if (val & STATUS_INT(i, 1)) {
                         DPRINTF("Clear IP %c INT1# status\n", 'A' + i);
-                        qemu_irq_lower(ip->irq[1]);
+                        qemu_irq_lower(&ip->irq[1]);
                     }
                 }
 
@@ -344,7 +344,7 @@ static uint64_t tpci200_read_las1(void *opaque, hwaddr addr, unsigned size)
                 bool int_set = s->status & STATUS_INT(ip_n, intno);
                 bool int_edge_sensitive = s->ctrl[ip_n] & CTRL_INT_EDGE(intno);
                 if (int_set && !int_edge_sensitive) {
-                    qemu_irq_lower(ip->irq[intno]);
+                    qemu_irq_lower(&ip->irq[intno]);
                 }
             }
 
-- 
2.47.1


