Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2379BC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg874-0007sB-AF; Fri, 01 Mar 2024 14:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg872-0007ot-ON
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:00:04 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg870-0004Mo-Va
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:00:04 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d33986dbc0so11814461fa.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 11:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709319599; x=1709924399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHk7WDIhUQBXUG2yd5CNMJ5GMZ9MlTxW37cN4pEmRS8=;
 b=nyX6ydOpWAsKrfwS+YiBv3bFfKkXmQC0BK6m0O6GyabF5oYjxdrTh1ZWVWP3ycftV4
 s4J1I1ieXouO2IPe2jhtN3WR5TAczgyqzJs2DueAG+YLXIJHaUUtnJXD2HhuBvs4vQRZ
 qUz0dTpP156szK2bPKwBj/KkCXDyJp1AcgZxfchA7c/jx1jBMjJO7NboyRmzDNVPRNkp
 SD2Lpsg98bnyafzD3g8SdZsIkA0yQTim0Em6wRXFGRZ6vmzGQpAEu/G6NMqgSlFQkipY
 aIUm45kBEchkRAi2jR98SVq+IQOtWEdZsQcC+2Ri1BXysxkgkNM93KiY1LchjRMJyqgY
 H7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319599; x=1709924399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHk7WDIhUQBXUG2yd5CNMJ5GMZ9MlTxW37cN4pEmRS8=;
 b=IIArCNGaYvisS2syknSKrFFo1fqR4u1U6sDj6/CiYXX0dMwkLzNm8VnuP3QSFT8EfV
 VQMN5abeWKBmjTLqXRXeBQbOIApGAXDa3JBj2GYglRyQGUoKABLqqdSFowjby0lMmkGL
 BSaLgCam22htpcwR3mtU0rg+FMNQhyT2YYyswkmCFXPSa3GsdmrrhMSm0f4A0isWLEm5
 b0Y0xndgV505SyxlAe6iavAveWTXLvD9UVzBY2SZT+2DIlGrbJ6UVN2ebciMDg9ajZxL
 oa0aFpmRhe0GVJwdFL38Qv9I8KEqeMPxQFp2Ek9CYF5G1Gs1oMWq51nfmXMN2DDneIOv
 WVsA==
X-Gm-Message-State: AOJu0YxWPxG8kPBZGwDX3XEv8NsbUIZTm1gyH5U0aU9l7f2VOvRR9Okj
 SUafUiNMZtEccksj2ycOoCrYd0bQNKh2XDgOHWVypF93wo7I3gGzykWP7SWcHiU6yGsaLZz8DB/
 zHs0big==
X-Google-Smtp-Source: AGHT+IE9oYaPfr6MP0MtVWVX1oDf7/jSmCNyUbc7UFarKxQlcbKamZ0d/PnPxtljZvcLfs53HF5FqA==
X-Received: by 2002:a05:651c:1043:b0:2d2:a440:d704 with SMTP id
 x3-20020a05651c104300b002d2a440d704mr1824172ljm.24.1709319599194; 
 Fri, 01 Mar 2024 10:59:59 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.84])
 by smtp.gmail.com with ESMTPSA id
 p39-20020a05600c1da700b00412d149ec79sm51068wms.5.2024.03.01.10.59.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 01 Mar 2024 10:59:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/i386/pc: Remove 'host_type' argument from pc_init1()
Date: Fri,  1 Mar 2024 19:59:35 +0100
Message-ID: <20240301185936.95175-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240301185936.95175-1-philmd@linaro.org>
References: <20240301185936.95175-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All callers use host_type=TYPE_I440FX_PCI_HOST_BRIDGE.
Directly use this definition within pc_init1().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0e688ed655..400b1c1e15 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -100,8 +100,7 @@ static void piix_intx_routing_notifier_xen(PCIDevice *dev)
 }
 
 /* PC hardware initialisation */
-static void pc_init1(MachineState *machine,
-                     const char *host_type, const char *pci_type)
+static void pc_init1(MachineState *machine, const char *pci_type)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
@@ -193,7 +192,7 @@ static void pc_init1(MachineState *machine,
         memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
         rom_memory = pci_memory;
 
-        phb = OBJECT(qdev_new(host_type));
+        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
         object_property_add_child(OBJECT(machine), "i440fx", phb);
         object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
                                  OBJECT(ram_memory), &error_fatal);
@@ -450,7 +449,7 @@ static void pc_compat_2_0_fn(MachineState *machine)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, TYPE_I440FX_PCI_DEVICE);
+    pc_init1(machine, TYPE_I440FX_PCI_DEVICE);
 }
 #endif
 
@@ -460,9 +459,7 @@ static void pc_xen_hvm_init_pci(MachineState *machine)
     const char *pci_type = xen_igd_gfx_pt_enabled() ?
                 TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
 
-    pc_init1(machine,
-             TYPE_I440FX_PCI_HOST_BRIDGE,
-             pci_type);
+    pc_init1(machine, pci_type);
 }
 
 static void pc_xen_hvm_init(MachineState *machine)
@@ -487,8 +484,7 @@ static void pc_xen_hvm_init(MachineState *machine)
         if (compat) { \
             compat(machine); \
         } \
-        pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, \
-                 TYPE_I440FX_PCI_DEVICE); \
+        pc_init1(machine, TYPE_I440FX_PCI_DEVICE); \
     } \
     DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
 
-- 
2.41.0


