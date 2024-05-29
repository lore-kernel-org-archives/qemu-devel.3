Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA8CC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBgM-0000nL-Pk; Wed, 29 May 2024 01:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBgL-0000md-Mc
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:01 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBgI-0005TG-Ud
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:01 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42120fc8d1dso11457425e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959817; x=1717564617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kn2QkW6roygyEjQL8EjLWez7qhV3aYVFxACDYZ5R7ks=;
 b=cV/i7/flYRvlPUZ2cA4AT1IU8AR2gBRcYn01OUxvzl1YShs1NNLTD7eSvzB0sixdic
 m0CG5CmrtbvqV6WrHa6gT7/P4U2/uDZ0Rbxur9fhOPNoA/fwMChO89ACW2pwE8hueyb0
 CadmvH1Wu+nh5lX1dOYhitf58/KVuFrOPAfy2b8YdcRBEf0BuvEMGaQrKScC7Tn5oErs
 Onp09VXwOAiZ98Fpu1QbAb81lNmHfgiT42Qy/Ag98bAt8z3lNA+53BJcY/be8QZR8D1w
 1gKeLB9PlcjWVV1LSN10JwW3FYSQhQelTjqwbzux5XEuYeP2/rdaboMzPEuU/dD1jFKt
 tkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959817; x=1717564617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kn2QkW6roygyEjQL8EjLWez7qhV3aYVFxACDYZ5R7ks=;
 b=JSfOVdtxuLbSOEVrQ2bTRobdXnZpYy46tDoU2pvKZZiAgBgkYXGEZSf7wyBq7YRwGC
 uPbD9TAaBEGgozVqvcXObVWZLVrSQtJa77niQP0L02bmWp9zqkzRzPxcG1jO9gutxCCP
 fv+zFvBYjHQalgVLC462TCbsobCqVd0hYmCVrM0u3AiiuV3Ky13kQpmfQIVzixSExruK
 VwwkkKjbRZX9ZO7nSBLv649d0oi139sQcn1rTLpEhvD/Um9eWlPkROQb3mjS7wq5UFrs
 GjHRU3e0jm5D18tygTeROn7/cxWnVB68zFzGToJxb25M+aF4Q8NG70FbOFqtL3gPpfho
 NIxw==
X-Gm-Message-State: AOJu0Ywb0w0V0eHpY3Wva9sxDHTKrfCTouU2pbdabuXlNRURl6j3PZwr
 HpYCUzENeVzSs0iuyCmN3Kgno6jtVib8j0S/7CQ/GApa/Dg9It0YQp55LLz3ofxTbrexdMLhWI9
 J
X-Google-Smtp-Source: AGHT+IG+LCqe4eRzjAw0ply5oF1T7owpp+j7u6Jf1ySFg2WotIaG/dn55pG5QehH4dCcDG3ssJHGgw==
X-Received: by 2002:a05:600c:5788:b0:420:e4b:d9df with SMTP id
 5b1f17b1804b1-42108a59336mr112221525e9.13.1716959817188; 
 Tue, 28 May 2024 22:16:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089b0410sm165022025e9.29.2024.05.28.22.16.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:16:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 14/23] hw/mem/pc-dimm: Remove legacy_align argument from
 pc_dimm_pre_plug()
Date: Wed, 29 May 2024 07:15:30 +0200
Message-ID: <20240529051539.71210-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
index 9cb5083f8f..08d38a1dcc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1321,7 +1321,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 6a12659583..c8f16d9d6c 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1133,7 +1133,7 @@ static bool memhp_type_supported(DeviceState *dev)
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
index 4345764bce..e7a5b7ce8c 100644
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


