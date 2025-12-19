Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A35E66891
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 22:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWiub-0001lM-IK; Fri, 19 Dec 2025 17:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuX-0001ic-7B
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:21 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuV-00052n-NM
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:20 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-64d02c01865so465647a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 14:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766183118; x=1766787918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8BqEgdpUXBLEHZZxgBu/z9VKa0uS4p2LU6CFeU+CZA=;
 b=AzP3BS40qYoXbRpfNbGJBhNoEab6YDjW/PqbF7Y/68jMinpiIacgOR63dw+kZyjHB9
 yHzbB1XGu+in0uEh/bLS4h66Fl7GkcdSStCVYFZNFToz3y3qT8QzqKJUIgxCSog+Fzi7
 164vUSCVR2lm0ueVYNwPWyM6eAHzScgQ/eq59tISXp6YXGRwqVfChqSet4X+vbFDp72L
 ZwiDy6DDWjpzW124FwidbbbUIPGcRqYn6K475gjeNZxJHK3FSo09H//S4M9GprhbbNUt
 opqsCG0aJVRiyIAF5BMc1g+tuwKySQ4XuRvgtVfYrcgRip6mdgzHQLpKie0l37xRSM4+
 dZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766183118; x=1766787918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l8BqEgdpUXBLEHZZxgBu/z9VKa0uS4p2LU6CFeU+CZA=;
 b=ZMsqW8CQg1wRki4kQmFKDR8pi1HVidbrghtJMxiWgdStjAs9dHnFUEjzgHF54Z7kn4
 s/bgyqICcx7ZcRjAhshIeJb6WXes4NKbm/hOzV85wu67Xo848mB4B8jq9zZ4Tb5yrRLA
 TXUwVC1em4QzgirJEZAurzncBuVKRdeXdxBW2FBxjLRO3EhuC4cVMirN6KyS3SOysySH
 5k/EkDqyqizsBzni2DP8tdVg9JTptx23A6pLuUFNlO2nKsJWqujfb3RPrXSfzGTJYsnf
 lCpuCh9+hm7HzsCJ9ae3kwQ4fTyCMI4bd8KNSEc36cNwvbPr6LJAcy5XnN9juzJIfxlg
 fdow==
X-Gm-Message-State: AOJu0YyIjBw7AWVQSqCT9HbToOr9IYeirxvtwAKOrM/+3tVExsE/rzKs
 OQKykz3l5rIjGeIp9MjuJCR1MEbu5x/U0PFlxxVbfOk+xxcje88E+bGGJZAo6NQi
X-Gm-Gg: AY/fxX7CglM64dxTejX54FK39FDXBZlhdUDL51Ti+9SvSjs8HGQA/oRHGxeE0RJ/ION
 37EnEqG/Is6f2pD2PeTNTk6K6BnP1uac1wWqSbSqMTAnzvRFoHxA0JmrbPjYOqGOPSs8MNgqOQG
 L/62WyPv/OnZTqlJAqlHd3njPjeVxKiaKyFKHGldNND7tA/YM4w57b99g1QSrKnYM8G7uB+OHyX
 ncGZH8oYcperKSrsRWHaBZajquTvhwl0/V2+MSkHyR0Re47Q4DizJE6isdFxZdiVL+GdlYM66fi
 obczMzRddNO8pOh0d44r9eJpcQxJdJHN1gm57LrouxEAArYmlJTbfdUOAfaVAt8hxqLNpdmlxzs
 M+hr1euwTOA6ZfhpRrkLA0WUILFd/MYM1kKoaO40YJQVqWc+r9sl7hH6NYaQeRihlAIvE711bA4
 zFpZ8GaclEYJyEyez+xU6pRvxVgTtSgWCRro1Hd0RLvlgXqlIKaWRCJhDSCThh4Q==
X-Google-Smtp-Source: AGHT+IE6mGo9TDFSmLkAjCttdTmHyybW/qflhIxVLPOrjtlDjIuIlquDO0tHervTsfHmVBG9LuNd+w==
X-Received: by 2002:aa7:d283:0:b0:64b:5abb:9be7 with SMTP id
 4fb4d7f45d1cf-64b8ecb2036mr2955548a12.23.1766183117790; 
 Fri, 19 Dec 2025 14:25:17 -0800 (PST)
Received: from thinkpad-t470s.. (93-138-210-222.adsl.net.t-com.hr.
 [93.138.210.222]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91599605sm3237440a12.23.2025.12.19.14.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 14:25:16 -0800 (PST)
From: ruslichenko.r@gmail.com
X-Google-Original-From: ruslan_ruslichenko@epam.com
To: qemu-devel@nongnu.org
Cc: ruslan_ruslichenko@epam.com, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, Dmytro Terletskyi <dmytro_terletskyi@epam.com>,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
Subject: [RFC PATCH 5/6] hw/arm/virt: add 'iommus' property for virtio_mmio
Date: Fri, 19 Dec 2025 23:24:38 +0100
Message-ID: <20251219222439.2497195-6-ruslan_ruslichenko@epam.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
References: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Dmytro Terletskyi <dmytro_terletskyi@epam.com>

Added support for the "iommus" property for virtio_mmio
in device tree nodes.
The property specifies the SMMU phandle and stream ID.

Signed-off-by: Dmytro Terletskyi <dmytro_terletskyi@epam.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/arm/virt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ad609bc651..ff3eb95036 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -89,6 +89,7 @@
 #include "hw/uefi/var-service-api.h"
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/virtio/virtio-mmio.h"
 #include "hw/char/pl011.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
@@ -1178,9 +1179,11 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
 static void create_virtio_devices(const VirtMachineState *vms)
 {
     int i;
+    uint32_t stream_ids[NUM_VIRTIO_TRANSPORTS];
     hwaddr size = vms->memmap[VIRT_MMIO].size;
     MachineState *ms = MACHINE(vms);
 
+
     /* We create the transports in forwards order. Since qbus_realize()
      * prepends (not appends) new child buses, the incrementing loop below will
      * create a list of virtio-mmio buses with decreasing base addresses.
@@ -1212,8 +1215,11 @@ static void create_virtio_devices(const VirtMachineState *vms)
         int irq = vms->irqmap[VIRT_MMIO] + i;
         hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
 
-        sysbus_create_simple("virtio-mmio", base,
+        DeviceState* dev = sysbus_create_simple("virtio-mmio", base,
                              qdev_get_gpio_in(vms->gic, irq));
+        
+        VirtIOMMIOProxy *proxy = VIRTIO_MMIO(dev);
+        stream_ids[i] = proxy->stream_id;
     }
 
     /* We add dtb nodes in reverse order so that they appear in the finished
@@ -1238,6 +1244,9 @@ static void create_virtio_devices(const VirtMachineState *vms)
                                GIC_FDT_IRQ_TYPE_SPI, irq,
                                GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
         qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "iommus",
+                                    1, vms->sysbus_iommu_phandle,
+                                    1, stream_ids[i]);
         g_free(nodename);
     }
 }
-- 
2.43.0


