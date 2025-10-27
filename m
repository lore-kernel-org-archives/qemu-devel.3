Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B140CCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQWL-0003dT-MG; Mon, 27 Oct 2025 12:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQVz-0003Qd-F7
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:56:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQVd-0001MM-Oa
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:56:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4298b49f103so1623189f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761584147; x=1762188947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJWsP8lU8vlleE35z63JKOE98MNb43nWOSZHGlrXrmY=;
 b=rNEOEWFXx5RJOCMP73VWDqK6xAm6nAiu6pUpthVRA3bdYtljdPDDzkiYisXQQdgCoI
 ssRyeEOonry9R9DBGM5E9y4pPhr7aHBTBt9MhwtTZOAu3cJ/Ad4DS8aPc35Pd4/vKUx+
 XABMH+tG/61aL22uwSSnpkISCl/rgcFCwNJgem05KD4TWdZQ3dKSl61p5gjAm3m3TA6Q
 Wml5M0nMVPPX938iWLSu5hVgNcBiO+1vgIuLd+7Z3I8LhBxLJ1kARbu9TiiJpd0IHjB+
 AQKRnthVumD238921YaxZILnDB8G8tN++fGnmw5ZxUgl8gNcD58k46LIkdFfIwoHujp5
 hmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584147; x=1762188947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJWsP8lU8vlleE35z63JKOE98MNb43nWOSZHGlrXrmY=;
 b=BpvCWYSvOBgd+CScTM9LD7ML7mGNIoeABCqsz6TQHN7+Io/gOJ2bSjQa9zjJNiavQC
 62coLNzqY9vb1wYo5Ed4dYjk28QVXdyYKONA1MlSTSTLoa7in/4jhMgHGRKC2wP24KBN
 uiwOHdm8aSALOcvaVY15D9E28ncDdUPkJ8tbtiBrVLg8Dmx5ffPb617e9bcaX4KVymAF
 zG8OpDrfFqIJJY4+Oq8QZN3dFcT0nT5FTyEm7OW9e2gMKJM9b17R3G24M40dGVB+Ly8F
 jfPSm/0zF59iGkbSAwZlYM7bfd+TXIBGkCRWazy1hB8j+hy7aVRwgYRXuE6fEZC0HSoN
 4A+g==
X-Gm-Message-State: AOJu0YwuhgSj+Fxd0gowmPkoKySbxwX/ORptNf2Zsb/GiwN08oA4ij56
 e0bJ6YO3dquxYOivuCYlJqGLKFF6pFdjtjPctrpfW5Woel4ja6jNHwU7nROQrxxXlTK5qf+C//P
 aKYGigcw=
X-Gm-Gg: ASbGncujbeym9efsryOMY70yGsfshCOs7j+08cAxNqAuhRmZu3SYEkxBFy4tBfSsco7
 N2tbpV4h9GcGxTW+Yty19m/ExT9auXARfTBhqH6D3VubQmlB6+LUNQZ8UETY7J1mBhKbF2mkQ5m
 937Y/GcQz5MNCDZ5xB+ytvfFr4jgN+ZjNLuZbznKjwSbtNltnfnDWho/7DPUt5/jk2QH7svuqYj
 DagbFVBTDoTjM4fT82YOrZXsL1Yn7j0aDLXlGadjXVB0iXtgSEc4LrUqJsxH4EL3yMmicvxJ5PI
 EG78/bj7EhsW9tSxuGAVnMxdzOZcMdPDGj6sMNUKkxjr7AbXYbZQsT29jQsMXkZz7ffWRl6KR1R
 xcueo1SxLCJZXltaBg1hFlMN03Iu1YSBwRCnNxEfYOy84uh+go/NJCY4yniNbDOvkEmwHkbODM2
 xWPyPjG1bP9C4eVUfwhwKpWS461bElKag4FWxBmy+fOu9Qoqh132cfgaZa32lTX/zfwk1yzm4=
X-Google-Smtp-Source: AGHT+IFtcG54nuSaLEEr+2seJ9InEAuITtTAVmn1aKWi2EhdCvQwCqtnRdnSJkLE8ehoeHUHBCZ3Vg==
X-Received: by 2002:a5d:64c4:0:b0:3df:c5e3:55fe with SMTP id
 ffacd0b85a97d-429a7e7c755mr335757f8f.29.1761584147273; 
 Mon, 27 Oct 2025 09:55:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de971sm15162492f8f.39.2025.10.27.09.55.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 09:55:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/7] hw/pci-host/sabre: Include 'host' in host bridge
 method names
Date: Mon, 27 Oct 2025 17:53:01 +0100
Message-ID: <20251027165304.98296-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027165304.98296-1-philmd@linaro.org>
References: <20251027165304.98296-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Rename various methods to help distinguish between
sabre_host* (for host bridge block) and sabre_pci*
(for the PCI function).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/sabre.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index f63d832efc0..669191b6c7e 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -116,8 +116,8 @@ static const PCIIOMMUOps sabre_iommu_ops = {
     .get_address_space = sabre_pci_dma_iommu,
 };
 
-static void sabre_config_write(void *opaque, hwaddr addr,
-                               uint64_t val, unsigned size)
+static void sabre_host_config_write(void *opaque, hwaddr addr,
+                                    uint64_t val, unsigned size)
 {
     SabreState *s = opaque;
 
@@ -194,8 +194,8 @@ static void sabre_config_write(void *opaque, hwaddr addr,
     }
 }
 
-static uint64_t sabre_config_read(void *opaque,
-                                  hwaddr addr, unsigned size)
+static uint64_t sabre_host_config_read(void *opaque,
+                                       hwaddr addr, unsigned size)
 {
     SabreState *s = opaque;
     uint32_t val = 0;
@@ -240,9 +240,9 @@ static uint64_t sabre_config_read(void *opaque,
     return val;
 }
 
-static const MemoryRegionOps sabre_config_ops = {
-    .read = sabre_config_read,
-    .write = sabre_config_write,
+static const MemoryRegionOps sabre_host_config_ops = {
+    .read = sabre_host_config_read,
+    .write = sabre_host_config_write,
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
@@ -329,7 +329,7 @@ static void pci_sabre_set_irq(void *opaque, int irq_num, int level)
     }
 }
 
-static void sabre_reset(DeviceState *d)
+static void sabre_host_reset(DeviceState *d)
 {
     SabreState *s = SABRE(d);
     PCIDevice *pci_dev;
@@ -367,7 +367,7 @@ static const MemoryRegionOps pci_config_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void sabre_realize(DeviceState *dev, Error **errp)
+static void sabre_host_realize(DeviceState *dev, Error **errp)
 {
     SabreState *s = SABRE(dev);
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
@@ -402,7 +402,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
     pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
 }
 
-static void sabre_init(Object *obj)
+static void sabre_host_instance_init(Object *obj)
 {
     SabreState *s = SABRE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
@@ -429,7 +429,7 @@ static void sabre_init(Object *obj)
                              0);
 
     /* sabre_config */
-    memory_region_init_io(&s->sabre_config, obj, &sabre_config_ops, s,
+    memory_region_init_io(&s->sabre_config, obj, &sabre_host_config_ops, s,
                           "sabre-config", 0x10000);
     /* at region 0 */
     sysbus_init_mmio(sbd, &s->sabre_config);
@@ -483,7 +483,7 @@ static const TypeInfo sabre_pci_info = {
     },
 };
 
-static char *sabre_ofw_unit_address(const SysBusDevice *dev)
+static char *sabre_host_ofw_unit_address(const SysBusDevice *dev)
 {
     SabreState *s = SABRE(dev);
 
@@ -492,34 +492,34 @@ static char *sabre_ofw_unit_address(const SysBusDevice *dev)
                (uint32_t)(s->special_base & 0xffffffff));
 }
 
-static const Property sabre_properties[] = {
+static const Property sabre_host_properties[] = {
     DEFINE_PROP_UINT64("special-base", SabreState, special_base, 0),
     DEFINE_PROP_UINT64("mem-base", SabreState, mem_base, 0),
 };
 
-static void sabre_class_init(ObjectClass *klass, const void *data)
+static void sabre_host_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
 
-    dc->realize = sabre_realize;
-    device_class_set_legacy_reset(dc, sabre_reset);
-    device_class_set_props(dc, sabre_properties);
+    dc->realize = sabre_host_realize;
+    device_class_set_legacy_reset(dc, sabre_host_reset);
+    device_class_set_props(dc, sabre_host_properties);
     dc->fw_name = "pci";
-    sbc->explicit_ofw_unit_address = sabre_ofw_unit_address;
+    sbc->explicit_ofw_unit_address = sabre_host_ofw_unit_address;
 }
 
-static const TypeInfo sabre_info = {
+static const TypeInfo sabre_host_info = {
     .name          = TYPE_SABRE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(SabreState),
-    .instance_init = sabre_init,
-    .class_init    = sabre_class_init,
+    .instance_init = sabre_host_instance_init,
+    .class_init    = sabre_host_class_init,
 };
 
 static void sabre_register_types(void)
 {
-    type_register_static(&sabre_info);
+    type_register_static(&sabre_host_info);
     type_register_static(&sabre_pci_info);
 }
 
-- 
2.51.0


