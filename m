Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B243FC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvbH-0008FE-L8; Fri, 02 May 2025 14:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvaz-0007ur-Iw
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:49 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvax-0005jD-D0
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:49 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ace94273f0dso513912066b.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212325; x=1746817125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAEnpROpQK6DxM6uJJQ1bpWzbrmSzQalAkAVB3r0tgU=;
 b=c9bTdyiSQzZQabGbuFIuF1vr42BCnDGuAJsaSKWYXOXUsUHiEiXArh/oDZT6hBViWH
 qJecubv/rCmnIKoMmixoTQaUNMJ8/gi4MIGXH+pbjQH5qbIJl2vdtGLuKXaeun6sKg1t
 KpbTU4Eel4VUPkds+8ML22LG6tZzw812gaGF5giA720p6BSHj3PzZi9BJNQBLUeMFUf2
 Gr3sZLhmycuaB4kauT4dC0lDguUe4br06keY27cOygtiygIj9te0ps4/QfcPE/8m33kH
 KhdUQVR+pqkvRqI4ssDaLjQIzIkGkxfib7oj2mjgRE+6VDrB5ZV6kfZM2elIlx+fCUUa
 KhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212325; x=1746817125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAEnpROpQK6DxM6uJJQ1bpWzbrmSzQalAkAVB3r0tgU=;
 b=rGTW6RtLlZbcBCLpwgMuBHjC/EqhPpew8PKde6gxjrjWADNf7aP67HWywQpY9g8IcC
 ITTd82cFiNK6qo0PM60ZO7Ewvj2bhogufraW1POXEW22TMd7naCOYioukwzYDgFP/L9H
 UEvVUwHbHfwCnFpbLlY7qksSB54oYuKch/hvFYVY/4hoLDtE+sIwmAUHH/r1crX7RSvx
 TutNEDThU9k6AhxWmikd413M5s+6bOExZ6COjqbPCwfNdvSF/33UOoDHOvmBn0AwHAhD
 eHoV2NQBHXhbASHi2ScHedEM27B+zFAuND3pAyVW/hBVUD7fbGBPbRL1hx49XTbVDWRl
 v+vw==
X-Gm-Message-State: AOJu0Yy15Eqq1s9qO0WZ+767Ag9YpoZ+OG/UAw39IhSlWCGBhdSRNiuC
 9ru7kZyC43HxxOCozgbBEN7TWfkyF07JfOmvl1yosgWtthSSVOa4ng76/2LReW0b2bpSNqUatUH
 M
X-Gm-Gg: ASbGncuj0WAruUgZys1twcYGLu3ISJMlzjBpVegx3iXtqD6yTnE7dieRsqG/p6jQfan
 rYExPpbuT+0XPMmNr2199v03DVttSvv0q9x67fVgbOsc19kR48RYI6E3aiRq0/eEXxgJdXQIaCX
 HYOJhDc9h7Mg0iSuPs3LVK60NGoZab21S4uTHSonhP6yLYnhUAVIJZBwBO8iAGlVqdfKFXLGvp4
 zO4pxPuWKwl77+NmgIdkR/Ab1/LpppjwmJUAsKvLk2KH/pvng4TWyQ2NfP7a3YqtkNrpiiHGKNm
 DDeVxBiWEY8R039volpmJ/y/+hNY2/8MOdtQ0HjeDwYPD9Aoc1p9/AS6ogOSf4wqy6IGzTc40jv
 h4SV6Vlfy/lR0CUSxipgD
X-Google-Smtp-Source: AGHT+IHEzN1oHza48LBvLfGU1yv7hc31xMFZ9Vo3WiynuGtpxIfE+KT5BVKQVxHfrApZPrIR6Re4cA==
X-Received: by 2002:a17:907:3e87:b0:acb:b966:3a7c with SMTP id
 a640c23a62f3a-ad17af4d344mr389294366b.47.1746212325279; 
 Fri, 02 May 2025 11:58:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891490afsm86709466b.23.2025.05.02.11.58.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:58:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 19/19] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_PAGE_PER_VQ definition
Date: Fri,  2 May 2025 20:56:51 +0200
Message-ID: <20250502185652.67370-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

VIRTIO_PCI_FLAG_PAGE_PER_VQ was only used by the hw_compat_2_7[]
array, via the 'page-per-vq=on' property. We removed all
machines using that array, lets remove all the code around
VIRTIO_PCI_FLAG_PAGE_PER_VQ (see commit 9a4c0e220d8 for similar
VIRTIO_PCI_FLAG_* enum removal).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/virtio/virtio-pci.h |  1 -
 hw/display/virtio-vga.c        | 10 ----------
 hw/virtio/virtio-pci.c         |  7 +------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 9838e8650a6..8abc5f8f20d 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -33,7 +33,6 @@ enum {
     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
-    VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 40e60f70fcd..83d01f089b5 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -141,16 +141,6 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
                                VIRTIO_GPU_SHM_ID_HOST_VISIBLE);
     }
 
-    if (!(vpci_dev->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)) {
-        /*
-         * with page-per-vq=off there is no padding space we can use
-         * for the stdvga registers.  Make the common and isr regions
-         * smaller then.
-         */
-        vpci_dev->common.size /= 2;
-        vpci_dev->isr.size /= 2;
-    }
-
     offset = memory_region_size(&vpci_dev->modern_bar);
     offset -= vpci_dev->notify.size;
     vpci_dev->notify.offset = offset;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7c965771907..4e0d4bda6ed 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -314,12 +314,9 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState *d)
     return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) != 0;
 }
 
-#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
-
 static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
 {
-    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
-        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
+    return 4;
 }
 
 static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
@@ -2348,8 +2345,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
     DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
-    DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
     DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
-- 
2.47.1


