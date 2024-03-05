Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC8BC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV6S-00055L-PS; Tue, 05 Mar 2024 08:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV54-0003PM-9k
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:43:44 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV50-00042O-30
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:43:40 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d33986dbc0so9266371fa.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646216; x=1710251016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+MCTA1UltNqL+EA8gVKWQmk1jjDdIIyMkrSTBOV/KA=;
 b=H2e2t35iS2U0o52j3CarRN7e+pXelRwYzjuESiNvoR32fgvhv0EcMWgJodtDHBGFV2
 fLRpJvU1XPv8QIeObmmUHTGab2WxyF3LRCjmePWIblxEfuJM1Tq+OZiEBJDHgZLTIvvI
 NrxnbGADNCfOUFK0XHr+MqLF1oH09ZHtpYnfzjVigm14czd8nk/nl0j4gWdTm+H9Esli
 Aq45gz2KZakhVmwfOJl7TM7iFUM05RWWwIuzv+dT+weY91HqoZVRoqryQbnqfTLX4Xkw
 9oPPZmmH+AOqLTtwvlrMRvUkveWZQaWYVNrziVibHnN6jbnMUwuicy2lptrcG++qtxDx
 TNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646216; x=1710251016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+MCTA1UltNqL+EA8gVKWQmk1jjDdIIyMkrSTBOV/KA=;
 b=ehxiQ5SswKD6Poo0EdkdNW5We9RsG39Vl18RSj5Ge4pv/9Mj+MgU7EZJhJUPNmBFZo
 CC4SfxlcV8IkFejK9em9n4XPX4kFFRKNlcaKe/Tf9LHQgkmoBNfwsfgsUeZuhSCDFvOs
 oidzhyq/Smklv3XhYfLlfEoB++SOLukYXlWPrYfvMyDSr/bndxIiOHrdWYg2L5hgQk55
 WiMVK78BXSznKw4NyG3eWPeidVCX0US8FZSRokFsxJecoz8jeWwGKl4zq1hxrmHqz9Lm
 4YQNEggmCajz12YkHzk6BHlQDdDexkN9EPDfMOcXalnGhpocDdV41iD5tad0yolQA4Si
 LwiQ==
X-Gm-Message-State: AOJu0YzMv5Jde7IR7xUljGyZizzCyD/RrywXo+BMcSB/fypJXImAzTee
 LXb74SXRvuyImSP4HaLllFPR4AW0F3QRo+a8nvuxOezvmm2jmUzv5snwesPbzLUcC8dsbrmYB1p
 s
X-Google-Smtp-Source: AGHT+IHpNwIWn9dU253fZ8k5m2DWd3SEtuggzOllzPMD9VtxMkKcCh3wswwtA70e6fwn1H/OqFetiA==
X-Received: by 2002:a05:6512:2028:b0:513:177e:4254 with SMTP id
 s8-20020a056512202800b00513177e4254mr1162168lfs.14.1709646216124; 
 Tue, 05 Mar 2024 05:43:36 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 qw28-20020a1709066a1c00b00a381ca0e589sm6032584ejc.22.2024.03.05.05.43.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 05:43:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-9.1 10/18] hw/mem/pc-dimm: Remove legacy_align argument
 from pc_dimm_pre_plug()
Date: Tue,  5 Mar 2024 14:42:12 +0100
Message-ID: <20240305134221.30924-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305134221.30924-1-philmd@linaro.org>
References: <20240305134221.30924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

'legacy_align' is always NULL, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mem/pc-dimm.h | 3 +--
 hw/arm/virt.c            | 2 +-
 hw/i386/pc.c             | 2 +-
 hw/loongarch/virt.c      | 2 +-
 hw/mem/pc-dimm.c         | 6 ++----
 hw/ppc/spapr.c           | 2 +-
 6 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 322bebe555..fe0f3ea963 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -66,8 +66,7 @@ struct PCDIMMDeviceClass {
     void (*unrealize)(PCDIMMDevice *dimm);
 };
 
-void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
-                      const uint64_t *legacy_align, Error **errp);
+void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp);
 void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine);
 void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0af1943697..9a6df69642 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2720,7 +2720,7 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
 static void virt_memory_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0950abcc2a..b4736822e4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1325,7 +1325,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1e98d8bda5..2e8234affd 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1024,7 +1024,7 @@ static bool memhp_type_supported(DeviceState *dev)
 static void virt_mem_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
 static void virt_machine_device_pre_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 37f1f4ccfd..836384a90f 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -44,8 +44,7 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
     return host_memory_backend_get_memory(dimm->hostmem);
 }
 
-void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
-                      const uint64_t *legacy_align, Error **errp)
+void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
 {
     Error *local_err = NULL;
     int slot;
@@ -70,8 +69,7 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                             &error_abort);
     trace_mhp_pc_dimm_assigned_slot(slot);
 
-    memory_device_pre_plug(MEMORY_DEVICE(dimm), machine, legacy_align,
-                           errp);
+    memory_device_pre_plug(MEMORY_DEVICE(dimm), machine, NULL, errp);
 }
 
 void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 55263f0815..32fdca2bd4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3639,7 +3639,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(dimm, MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(dimm, MACHINE(hotplug_dev), errp);
 }
 
 struct SpaprDimmState {
-- 
2.41.0


