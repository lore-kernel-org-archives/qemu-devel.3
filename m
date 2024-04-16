Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79123C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo3W-0001uD-HW; Tue, 16 Apr 2024 15:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3U-0001nr-82
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:20 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3R-0005mi-Vf
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:19 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-518d98b9620so3460459e87.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294076; x=1713898876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tX6emDsZqVY2muZJRjyArm9SgC2+2SHZUCWPsCYUO0=;
 b=XXkoo01wgJLcqx5MY3t7zg2on2TS+GzJ4CNGIwNhj6FTy44qflnA8ViNLoi0aI9xPJ
 i/UplER4f38P4niTFDIk1jFf8O+pgS00KIKxl/QhPLTcXEo1zOf53GzSjOJcMUvMsY3B
 0PsG18DhOjGWi2W3OX6l6ErPTZa6Dy5fhAgJjZ6BuG4qpPh9NyKh73t9Pbza7tOS80e8
 kG2JzOHKySJ+fHEn+2CuCHNN6g35p1K4DinwzU6BQoHW/ksL7uoY++0QCCu/qJdW9yBB
 a5f24vFk1NkPQZVbW/Iy3Hr73xVlkEft+fSgoNZOZh+q4h+isQG+sHR9FcV8ExkHQJKd
 fmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294076; x=1713898876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tX6emDsZqVY2muZJRjyArm9SgC2+2SHZUCWPsCYUO0=;
 b=JuhMUiPD+DhdiwnZEp90yhnIVRboC3TVtOJWxK+thmaxoSXsAwQM8frxd4LRyq/zlV
 OirYLa3J3Stly7xRf1/+KsfSZ0f8d5OP4KHEualaE92SQw29g3blgtUO0EcMI+kA9FO/
 yIGYKqvmiHVwC7TDe5ZXmbLC8WMF65TJWYt44EoXHm4di6gHk2YACdM82kje6dnFrR50
 2JOk41LJVXH/zDgptkYcox/8Ok2gBEyY1MRSLE9MutN3bny3nAeF5f9Zl8QGbZFppoGb
 ZOUVpWVFpEA5I1TOw2OQL8qn/2c8NswfeRlP931abDfJzR4SlxuLUmhJjc/u90981MuH
 Fx3A==
X-Gm-Message-State: AOJu0Yzu0pGkk5VRn63ukvd40z0zG8CjyHsQnwDUMiu2NM31RbZH04Mi
 V56fIBOvzuYEDcKwbEhvVEf3nZwdO0t8RXKg3lV84gVEmrYa850RlYW4ipTREag2bR6g3C7H85e
 g
X-Google-Smtp-Source: AGHT+IGAeJUk9j1vWHyak+lS5xvi7WZDRHJdtrfadkYcSMrcnN5S5wA21dkShPt8sipozRTysqPPHA==
X-Received: by 2002:ac2:4c25:0:b0:515:c102:c825 with SMTP id
 u5-20020ac24c25000000b00515c102c825mr7947381lfq.19.1713294075893; 
 Tue, 16 Apr 2024 12:01:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 gs39-20020a1709072d2700b00a46f95f5849sm7167635ejc.106.2024.04.16.12.01.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:01:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 14/22] hw/mem/pc-dimm: Remove legacy_align argument from
 pc_dimm_pre_plug()
Date: Tue, 16 Apr 2024 20:59:30 +0200
Message-ID: <20240416185939.37984-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index a55ef916cb..7af05a6a2d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2736,7 +2736,7 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
 static void virt_memory_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c7bfdfc1e1..9ba21b9967 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1309,7 +1309,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 00d3005e54..af71bd2a99 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1025,7 +1025,7 @@ static bool memhp_type_supported(DeviceState *dev)
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
index e9bc97fee0..f147876dc9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3668,7 +3668,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(dimm, MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(dimm, MACHINE(hotplug_dev), errp);
 }
 
 struct SpaprDimmState {
-- 
2.41.0


