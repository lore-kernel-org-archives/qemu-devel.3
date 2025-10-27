Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD28CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQWb-0003uS-F9; Mon, 27 Oct 2025 12:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQWH-0003df-LI
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:56:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQW6-0001ON-Pl
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:56:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475dab5a5acso15593825e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761584180; x=1762188980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRbyNgBG2QYbRLBjJ+dLxGFpEggesGRlG37R+YEXlUY=;
 b=KS1LNAc8q8CYO8apch6tuk0VHvUuPez1V8SqFRUp7Ja5uJHIqNfIx+22vwSWPPY5pF
 SEQo8r/ccC2TJ8OvXoLFBF5+m0O5ffw8zHGwy6iEDRMLKEpRMvKMNUOGJfVpyM1VZYTc
 IoMAKN5mqeZfN+IUd29OrUyMZV95rUOZugrtgYWr42SQWovQqwaLoGAxYAXvL1W5Jz/D
 qrwtpoXN2y+3woejy3N4zDoCYFYj++tiC62BBRSCWAjj1MXwyPPKpduaucyLYbzAdXXg
 O0KpoR0Fp7ivF9ldgIupyAxYeLVSItwqmi2cpFAB8mW0NXknTMjy4wV/jNuOEhEv0Ux5
 aL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584180; x=1762188980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRbyNgBG2QYbRLBjJ+dLxGFpEggesGRlG37R+YEXlUY=;
 b=np8/Tesq38pzM0klFsaYdsgrIZE/fmZndnL/BSGa+fnVJ7H8Pw6y1LI7LA9FBEtD6Y
 8V61nbvTyy6/GVOesklKaSV/TVOfm7tdpvjJXr9Y4LOBRbuxsZtNPTYRV7FdY79JInYG
 Z22pPVEpJg3og4QNkQAkjDi9WB55GkgTHXThV3EPd/FW7N10TMZ3t6SJhmZjdTM4ZfS/
 P1qjy1SL+RGN6d4v18VodgfHjHFEpiMJRUu4ZI53qEC3wa8iSemqg1QzPgqspZpraTRM
 kIHRHyktKzSNLt2rguRi6LGB+5awKfYtVDOTcAtsJElbugSYZPWcJT/i6v6yl4IQloEk
 82cQ==
X-Gm-Message-State: AOJu0Yw3oP0GXhc54jWR4e+mVgxRwLfliitI+kGcfcer+3oQftLck/XC
 qCkhLJtwmxXezMpzNh4Fobo8+nAocj0cn2p/pu8r7gMJyR/F8Vt7ebxV1ZU3bYgi+FV59lgVxds
 Dz0fZiP8=
X-Gm-Gg: ASbGncu107RcTQ4aU8ClDRRXHSrBQnaGVNMOzrBwbD0/Qr/AVZdE70bOV4Aibjqdl3y
 wfFmEE6yOfdQZja0C2au+ySMVsBVQqkF7PZMZGUfcC2DsJohiLjt95PZuVC5pPX7ePra6S+xdUk
 prRIQ/odKeKEE0WGwFAwF2vMQaALUSrZoGU++K0G4q7ycZju3WDafudo5rhlBoAUzUb5zaV2mh2
 Kb/SmDtbG0G0jAy7TYGF73biTlgGxZ/7hAXiSWg0JZx3/LFVQCfP76go1leFyAzgq/i48o+WOLI
 tCvQWJ+zERgvCpaDOVBDVq3dYovBl0X6eAtgbs1mDH5zQNkPXT/gwZjaf+GJ/O2SgyzdSr2oBus
 yKieQX2BdcOQj6qT3obSbmr+ONdCckreqMVhzjV2Zp7JutQeEyzj6NRHCuUr4k7erQ1kTvAaoWg
 Y1ekYE4QPTJmaoooIrqRbOqAcNABwRXzrqtY7QxCmJVEEYuGsvxQ==
X-Google-Smtp-Source: AGHT+IHB6Jayx13wSSGJnxfl7G3sjpsz07BEBFYyiomF06bFmu07tIKBf/4iI63Ifm7s+Y+LnHZUng==
X-Received: by 2002:a05:600c:6215:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-47717e416admr3367265e9.32.1761584179936; 
 Mon, 27 Oct 2025 09:56:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd02cd5dsm145426295e9.4.2025.10.27.09.56.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 09:56:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/7] hw/pci-host/sabre: Re-use generic pci_host_data_le_ops
 MemoryRegionOps
Date: Mon, 27 Oct 2025 17:53:02 +0100
Message-ID: <20251027165304.98296-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027165304.98296-1-philmd@linaro.org>
References: <20251027165304.98296-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Avoid duplicating code, re-use the generic generic
pci_host_data_le_ops MemoryRegionOps.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/sabre.c      | 34 +++-------------------------------
 hw/pci-host/trace-events |  2 --
 2 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 669191b6c7e..eb3dbe3361f 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -246,28 +246,6 @@ static const MemoryRegionOps sabre_host_config_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void sabre_pci_config_write(void *opaque, hwaddr addr,
-                                   uint64_t val, unsigned size)
-{
-    SabreState *s = opaque;
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-
-    trace_sabre_pci_config_write(addr, val);
-    pci_data_write(phb->bus, addr, val, size);
-}
-
-static uint64_t sabre_pci_config_read(void *opaque, hwaddr addr,
-                                      unsigned size)
-{
-    uint32_t ret;
-    SabreState *s = opaque;
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-
-    ret = pci_data_read(phb->bus, addr, size);
-    trace_sabre_pci_config_read(addr, ret);
-    return ret;
-}
-
 /* The sabre host has an IRQ line for each IRQ line of each slot.  */
 static int pci_sabre_map_irq(PCIDevice *pci_dev, int irq_num)
 {
@@ -361,12 +339,6 @@ static void sabre_host_reset(DeviceState *d)
     pci_bridge_update_mappings(PCI_BRIDGE(pci_dev));
 }
 
-static const MemoryRegionOps pci_config_ops = {
-    .read = sabre_pci_config_read,
-    .write = sabre_pci_config_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static void sabre_host_realize(DeviceState *dev, Error **errp)
 {
     SabreState *s = SABRE(dev);
@@ -430,12 +402,12 @@ static void sabre_host_instance_init(Object *obj)
 
     /* sabre_config */
     memory_region_init_io(&s->sabre_config, obj, &sabre_host_config_ops, s,
-                          "sabre-config", 0x10000);
+                          "pci-conf-idx", 0x10000);
     /* at region 0 */
     sysbus_init_mmio(sbd, &s->sabre_config);
 
-    memory_region_init_io(&s->pci_config, obj, &pci_config_ops, s,
-                          "sabre-pci-config", 0x1000000);
+    memory_region_init_io(&s->pci_config, obj, &pci_host_data_le_ops, s,
+                          "pci-data-idx", 0x1000000);
     /* at region 1 */
     sysbus_init_mmio(sbd, &s->pci_config);
 
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 792ab25729b..20c3cae47a2 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -35,8 +35,6 @@ sabre_set_request(int irq_num) "request irq %d"
 sabre_clear_request(int irq_num) "clear request irq %d"
 sabre_config_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
 sabre_config_read(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
-sabre_pci_config_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
-sabre_pci_config_read(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
 sabre_pci_set_irq(int irq_num, int level) "set irq_in %d level %d"
 sabre_pci_set_obio_irq(int irq_num, int level) "set irq %d level %d"
 
-- 
2.51.0


