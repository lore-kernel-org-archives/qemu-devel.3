Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3237CC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbHf-000544-5n; Tue, 18 Jun 2024 12:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHd-00051T-DW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:09 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHa-0006vI-8O
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:07 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57c778b5742so6557774a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726524; x=1719331324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCZJ5ylQLswy1jx1rgaB0EFpBR4bZntZL6FEGbk+Shg=;
 b=ZD+1RD3tXGxL7oX1v1m5AVUK5mvd2fIml5ifuB1e3IrvCcTEE1/7AXu1RaJtKBKndG
 jGtDYm0y00gXsgSe96D7q/GLcShWgI+E50H401f6RHZ9Ozsd7mxc7AM4MX0UehzbMtKa
 1W8PhqDOKQQCoy6q4dQE+MbqFuVG0+nE0rMHeVfyPufRqhWNaBVdVFAk1eaaNWeZOM7E
 7iukrlEcMSC7MAZQRMLq6Tx5r3n3ttPT/5sXofCFSeooyu/g0gOvNcfxmGIvodY+G65b
 TdWlT+FfS2Wjm3oxUElQKzt2AqBwrwAL1O8vw0NI0VvW4PMztThCRXrBET6L4uMJpglo
 m58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726524; x=1719331324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wCZJ5ylQLswy1jx1rgaB0EFpBR4bZntZL6FEGbk+Shg=;
 b=XSHakAlJT9x7LYwm3Yf8qq/XjxOfW4RusX6FwjNeiKdPgKLstOOZPJBw2IaA9YGMQq
 6eJ1cH1S2JnGIkwtxJGIwosf9xBHN2uM3pow7HkMiyey9bl4Gs4kfh3w/3roWC2qCdYe
 R4YVsfrU0ZDlttvvseB5R4s0JipNvbOTq2cBTyDkjD9JXnHccjxqGukbLA6YWb8xPiZ1
 ru/0HcLiobCW/zSc0X3+XfieO+PXxd8GAwSFwLqygBGYZFqbAuSLk8MBTniMWdCRTq8Y
 D6IzxOUhfGmbAfsVJtJDH9r6zQyMrVOTuTdvKzcsf4rVtNtkKLVfp601CGMnZat7Dahk
 3Nww==
X-Gm-Message-State: AOJu0YyklizNtxmU9c5n4pIqawTUo6jxuuRGA+qXPl8ODanmVQ8nbj0n
 rWN07Ke3iPOhG22SPpK3qfPZSka43kVMJ8U+6D9kZDmwJC0QXt55TgS7WzsKyZ7s2N+zyvc6FQ+
 +
X-Google-Smtp-Source: AGHT+IG/EwMS3L52HYg7V3HbHG1fBnp+zEDkDY1lyLMOiuqK9Dh3NaGF6x44XmPkKhBFsh8CBBz/yw==
X-Received: by 2002:a17:906:4109:b0:a6f:5a48:7b90 with SMTP id
 a640c23a62f3a-a6f60d413f1mr734751466b.38.1718726524169; 
 Tue, 18 Jun 2024 09:02:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f5b5ce0c2sm600947866b.78.2024.06.18.09.02.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:02:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 14/76] hw/mem/pc-dimm: Remove legacy_align argument from
 pc_dimm_pre_plug()
Date: Tue, 18 Jun 2024 17:59:36 +0200
Message-ID: <20240618160039.36108-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

'legacy_align' is always NULL, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-15-philmd@linaro.org>
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
index 268b25e332..c7a1f754e7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2763,7 +2763,7 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
 static void virt_memory_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ff5683a8ee..2d0a517c4c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1327,7 +1327,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index b7ea17d5f3..8be2d2ff6a 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1245,7 +1245,7 @@ static bool memhp_type_supported(DeviceState *dev)
 static void virt_mem_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
 static void virt_device_pre_plug(HotplugHandler *hotplug_dev,
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
index 81a187f126..d7d4b188ee 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3700,7 +3700,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(dimm, MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(dimm, MACHINE(hotplug_dev), errp);
 }
 
 struct SpaprDimmState {
-- 
2.41.0


