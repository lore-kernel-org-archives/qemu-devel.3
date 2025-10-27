Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB377CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQUw-0001i7-6M; Mon, 27 Oct 2025 12:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQUg-0001WE-Rk
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:54:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQUc-00013g-5A
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:54:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so37143415e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761584083; x=1762188883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SiMoSAYwrcgr/wOnpUxb2QFIfjJ7jstvWBwRnIsAVY=;
 b=DmzWuQCcO3wnNiBDooO3+b0LaYKrC33rfTCqAeQE+heyT5PSS6guuJQVcITiLxBf5E
 HAcsAixMy+vMuwM4S2eWHUj2UYcgpvS+UgidGvfnd9TwveKevOmWxJq83LzJm234zEvi
 VxXBGD2Q0e2PjnhpgSe0P1IadMrnMXXwmPUv/DXenkzR9OTqEQAPpAY59nwwg/jYlAUj
 G2kHr5bX2zKgMc09RWofWCJd3DGI4MCqT0/YOYniW4MW2YSEWp0oA406T2BGDSinQmle
 OQJ41N+rQ9zrxGuq4MzKBehVji5qOjBWc12XEvZmqq3Q5yB3DL/ja/y0Y9Tmc+D3rwqy
 aCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584083; x=1762188883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3SiMoSAYwrcgr/wOnpUxb2QFIfjJ7jstvWBwRnIsAVY=;
 b=Sc0QhUXS91ZsjFWYVyt2OxF/pS+PXvShRzzOzV0/In+E47tXpoSB7AvMmcKR+WMLR9
 fQ7o/Z6lY8tyodQ/ngrlYMbcfLqM0a59mAQNz8wgZ36DBfeCaam6sLGhhPwXKuKhpo++
 vbLFQD1hz1NA5iyGIY+CtxJatwLK84ayYxDrwrvnWhhiUlC7skLbmiAF4IOTauoWlS6Y
 /By6425OOeQ+XE15GlOO6+VAHRDqfT2HKP0u57YpJM4k1WnMtKjaLz9He4D7KrcHtK88
 O31wRJ/9ttLvPHMvTDBh3hezTrTEpm+hl0HTB8InrdNh0llNnmOrOGTe/nK8WCrPVmoU
 RDWg==
X-Gm-Message-State: AOJu0YwWE/Bmbwl9uR7BtoJ6tqfKJXo4VI74HGDyEV1MuV+DvJLncihY
 IWq2QuTCb10HQE6PP3yYQFnSY2qKb5qze4wEHg5f4CF1+o3Snnz5lfZgU5HUIPctsmKYwPcFl2y
 zKBlfgiE=
X-Gm-Gg: ASbGncsAt1AcLIds+Qnrnsgzt/ahPb+NpTLtLhR2ga+OjssOBHYerRzJcerXh7WJhTf
 Unotkh7z8gXDZ4s3RNmSESSurWK96wj3Qe+Rh0GyUmjgTdKs0GGfJfsHHGREqWij9CpEGOIWmuk
 22R7x7qgkuRTP9ryy3PRR1lf6EteLsmzVYcUqU98qSMGxC47hh+FSQZM35EQthjPTv6JxsBpGtN
 w5IJiG6eMeGlThfdop5FI7RvdZM3kPMecbpVVOmPHDdRV1dLJ51wercZjDQzC2ZFBlQSx8K4ZAo
 xZWXjFH9JOlS5oirkEBUtQ4N5b1wvUXgTRsZ4nSXqtL8IPCERJuT7iRoGn6xOKb7+uXeyDifjKQ
 8gzl+nBwzJiGCG652JebFVIpMC8q1p/UYuIBjjEsXWtAj/YbNrt+//eOrMkbEM/fX+p6/lk5GN2
 m3Ppyx/f3UmPt+oYve/B6DzQlywGpZsm8NSVOaAg5o7zv7VEKisg==
X-Google-Smtp-Source: AGHT+IHyPBcLN4+lbQOVvjA2sd71nf3NW3dTc0vB+uTnASTjKFioc6xLVTCX3ogTemVLvJqCnhjg8g==
X-Received: by 2002:a05:600c:848e:b0:476:84e9:b55d with SMTP id
 5b1f17b1804b1-47717deef5dmr3534275e9.3.1761584082689; 
 Mon, 27 Oct 2025 09:54:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb7dcsm15810909f8f.11.2025.10.27.09.54.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 09:54:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/7] hw/pci-host/dino: Re-use generic pci_host_data_le_ops
 MemoryRegionOps
Date: Mon, 27 Oct 2025 17:52:59 +0100
Message-ID: <20251027165304.98296-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027165304.98296-1-philmd@linaro.org>
References: <20251027165304.98296-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Avoid duplicating code, clear the "config-reg-check-high-bit"
property in .instance_init() in order to re-use the generic
pci_host_data_le_ops MemoryRegionOps.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/dino.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 924053499c1..31ffe8fa60d 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -302,27 +302,6 @@ static const VMStateDescription vmstate_dino = {
     }
 };
 
-/* Unlike pci_config_data_le_ops, no check of high bit set in config_reg.  */
-
-static uint64_t dino_config_data_read(void *opaque, hwaddr addr, unsigned len)
-{
-    PCIHostState *s = opaque;
-    return pci_data_read(s->bus, s->config_reg | (addr & 3), len);
-}
-
-static void dino_config_data_write(void *opaque, hwaddr addr,
-                                   uint64_t val, unsigned len)
-{
-    PCIHostState *s = opaque;
-    pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
-}
-
-static const MemoryRegionOps dino_config_data_ops = {
-    .read = dino_config_data_read,
-    .write = dino_config_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static uint64_t dino_config_addr_read(void *opaque, hwaddr addr, unsigned len)
 {
     DinoState *s = opaque;
@@ -410,6 +389,12 @@ static void dino_pcihost_reset(DeviceState *dev)
     s->toc_addr = 0xFFFA0030; /* IO_COMMAND of CPU */
 }
 
+static void dino_pcihost_instance_init(Object *obj)
+{
+    object_property_set_bool(obj, "config-reg-check-high-bit", false,
+                             &error_fatal);
+}
+
 static void dino_pcihost_realize(DeviceState *dev, Error **errp)
 {
     DinoState *s = DINO_PCI_HOST_BRIDGE(dev);
@@ -424,7 +409,7 @@ static void dino_pcihost_realize(DeviceState *dev, Error **errp)
                           &dino_config_addr_ops, DEVICE(s),
                           "pci-conf-idx", 4);
     memory_region_init_io(&phb->data_mem, OBJECT(phb),
-                          &dino_config_data_ops, DEVICE(s),
+                          &pci_host_data_le_ops, phb,
                           "pci-conf-data", 4);
     memory_region_add_subregion(&s->this_mem, DINO_PCI_CONFIG_ADDR,
                                 &phb->conf_mem);
@@ -505,6 +490,7 @@ static const TypeInfo dino_pcihost_info = {
     .name          = TYPE_DINO_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(DinoState),
+    .instance_init = dino_pcihost_instance_init,
     .class_init    = dino_pcihost_class_init,
 };
 
-- 
2.51.0


