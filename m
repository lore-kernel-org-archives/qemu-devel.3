Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F609C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo44-0002VH-7C; Tue, 16 Apr 2024 15:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3b-0001z7-A4
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:27 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3Y-0005oU-Ae
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:27 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so538603666b.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294082; x=1713898882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xewXMqFZRdg+aIzvHesVxZBjNGsZ5q/Yk0k6GByalI=;
 b=E3PmjKOvt0FTl7di5qriohG73+MrjR/p8VJUl2SoI5EWKT5dlh6YThKgMWc2ym4GCq
 u/XPEswhBqsNt+ZmkhIKxRjpEBTA6OvAT7S5CbYpEXu92oNIsVuRi+LVNavFUjBBNx33
 U0Hh51M6ziXL4upFrhZ5Yy0jVtL9kRC+Q01ZXro9XqAo/KV3LayIgemw0ys3Hl+SXPgp
 4qPFFGzgVkkxfHFLsM0v14ss6Qdlfs0hSy5xbOqhCmVmNuhGsOMjB48va6QWsE5XEVL7
 fCZqkoc/CFfqEFKjogWjCagGg1apc4WldPQYKQXrLnjQVIiAsn2+WL5+4rL+l9Q3PIGZ
 1Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294082; x=1713898882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xewXMqFZRdg+aIzvHesVxZBjNGsZ5q/Yk0k6GByalI=;
 b=DuBpMVSg1rgAJY8+aE8nfoWBJ82IGUsb0iLp0ZjNxPD+K1ZxhoU5mWJiC1hMvaczbR
 qoyMCJS5Pw+JOCq94umnOLWRqT4YfVkZ34s8WFhYodAuxA9qaLSoIOpS5H/jr8/42aiX
 cBHA5gktDREf7WQH2NST20mdO7DjnYKOL00NzkCHDoRZPFICo3DAZgAMOz7iassp+B7/
 q9nINQ41oXJ48j9t0TAar73pqMbmJnRbSZIVm6kuP8cM0nU5K8ylyouMnQW8V8rSMhov
 iAEbpvTuNWG6n8EPSCHyeMuGttUb65jtmrIV02nNxkEAXRsiLIf258IuAVx354mR3WmH
 082A==
X-Gm-Message-State: AOJu0Yxy1oiXz9qUZ0OxPewBglaC1t54NmPtqwpZZxqqTuA6pyQaxHrz
 qxw6wA7RAzEEklAsgU+EQYW9y2cg1o1EWSZH45F69JojZEq8A0Wr3rTA0+hS+AERC6R0EzZU+zB
 o
X-Google-Smtp-Source: AGHT+IGrcfAnmJXonN8JuJEvsDmgkpMY/h2vEBpzGAwJB5s5ZBgbSWZCpPAV7Xr/p9z7spQOvcg7Dg==
X-Received: by 2002:a17:907:724b:b0:a52:5795:226a with SMTP id
 ds11-20020a170907724b00b00a525795226amr7057705ejc.5.1713294082413; 
 Tue, 16 Apr 2024 12:01:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a170906360500b00a51da296f66sm7135044ejb.41.2024.04.16.12.01.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:01:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: [PATCH v4 15/22] hw/mem/memory-device: Remove legacy_align from
 memory_device_pre_plug()
Date: Tue, 16 Apr 2024 20:59:31 +0200
Message-ID: <20240416185939.37984-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

'legacy_align' is always NULL, remove it, simplifying
memory_device_pre_plug().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/mem/memory-device.h |  2 +-
 hw/i386/pc.c                   |  3 +--
 hw/mem/memory-device.c         | 12 ++++--------
 hw/mem/pc-dimm.c               |  2 +-
 hw/virtio/virtio-md-pci.c      |  2 +-
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index e0571c8a31..c0a58087cc 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -169,7 +169,7 @@ uint64_t get_plugged_memory_size(void);
 unsigned int memory_devices_get_reserved_memslots(void);
 bool memory_devices_memslot_auto_decision_active(void);
 void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
-                            const uint64_t *legacy_align, Error **errp);
+                            Error **errp);
 void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
 void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
 uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9ba21b9967..633724f177 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1377,8 +1377,7 @@ static void pc_hv_balloon_pre_plug(HotplugHandler *hotplug_dev,
 {
     /* The vmbus handler has no hotplug handler; we should never end up here. */
     g_assert(!dev->hotplugged);
-    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
-                           errp);
+    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), errp);
 }
 
 static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index e098585cda..a5f279adcc 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -345,7 +345,7 @@ uint64_t get_plugged_memory_size(void)
 }
 
 void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
-                            const uint64_t *legacy_align, Error **errp)
+                            Error **errp)
 {
     const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
     Error *local_err = NULL;
@@ -388,14 +388,10 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
         return;
     }
 
-    if (legacy_align) {
-        align = *legacy_align;
-    } else {
-        if (mdc->get_min_alignment) {
-            align = mdc->get_min_alignment(md);
-        }
-        align = MAX(align, memory_region_get_alignment(mr));
+    if (mdc->get_min_alignment) {
+        align = mdc->get_min_alignment(md);
     }
+    align = MAX(align, memory_region_get_alignment(mr));
     addr = mdc->get_addr(md);
     addr = memory_device_get_free_addr(ms, !addr ? NULL : &addr, align,
                                        memory_region_size(mr), &local_err);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 836384a90f..27919ca45d 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -69,7 +69,7 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
                             &error_abort);
     trace_mhp_pc_dimm_assigned_slot(slot);
 
-    memory_device_pre_plug(MEMORY_DEVICE(dimm), machine, NULL, errp);
+    memory_device_pre_plug(MEMORY_DEVICE(dimm), machine, errp);
 }
 
 void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine)
diff --git a/hw/virtio/virtio-md-pci.c b/hw/virtio/virtio-md-pci.c
index 62bfb7920b..9ec5067662 100644
--- a/hw/virtio/virtio-md-pci.c
+++ b/hw/virtio/virtio-md-pci.c
@@ -37,7 +37,7 @@ void virtio_md_pci_pre_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
      * First, see if we can plug this memory device at all. If that
      * succeeds, branch of to the actual hotplug handler.
      */
-    memory_device_pre_plug(md, ms, NULL, &local_err);
+    memory_device_pre_plug(md, ms, &local_err);
     if (!local_err && bus_handler) {
         hotplug_handler_pre_plug(bus_handler, dev, &local_err);
     }
-- 
2.41.0


