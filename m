Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DADAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjGz-0005Ru-N1; Tue, 16 Apr 2024 09:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjGf-0004oS-6I
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:54:39 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjGb-0001wJ-RD
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:54:35 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-516d756eb74so5371732e87.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275672; x=1713880472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrloeWXgUOLOMISBfKf4pjkEgrJ1tsN5/Rvv0yaa8aA=;
 b=Fzafj7hMbLKlpjRfypiJcKv5gPj1AxjV/xBEtxUo/DSOldjWNKzm0DXgU1qPo/qnYW
 cG7PzFS7HbXWL1Qv1AZd/t1EYliBFJhEQz+rgP6Yo/q9VApondwWqFwmZZl6d2k/3t/T
 PwHgItfX0plm6Nib4/elGmBtFFI97uEK84/3aK9ge4oZDPQCA9I9jExXMVqkVbxshs5c
 07Um0uwG1HIW9LCYChxs4osoB3jl1wEL3OAgtLVWkd3CwWYH8aHGac4/1hFSV2o+zVY+
 3hwQr37tl1dw5r2BPlwUJ4naBWpkjAYT/J/SucLwi2KiKTFL+gcFDQ2Q4ZEoi0x6hS3I
 RqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275672; x=1713880472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zrloeWXgUOLOMISBfKf4pjkEgrJ1tsN5/Rvv0yaa8aA=;
 b=aAYPaG6pJ8Y+bffY2ViDsa7q0W3QEvFoWv2s+Qi2GU1wYOEYFjQPlsGqS9vRSjZuyq
 JTh9wi8DYev0crFNh0Glh/xnepgri3xWVaabRWlCby3SYOzriyazMW4PAPOX/yBl0YSZ
 EN328GQVekyq91rr4qYutj9TmPupp5z5t4Fopk4vm5E19G/gB4qtbtCUm7eMLgYTB+Ik
 7KbsqYmXArm6k8TUcqOrNY9XJ3c6PD1XGF/tP5MF9cSLVONti6WRvLtxCOYBhLKOdsbH
 UzAAqOkz25M2l/t7yht0fbCkGhetlaVrcJnMxJSk3kiem81kjriwq9F3gfROMa9loVrY
 m7qw==
X-Gm-Message-State: AOJu0Yz2SfAnwlKISyT/RaCPU3xmMoMAuIOaITOz6s53M817UhgtpNN4
 4c9QkM+t7zIA3nEJnhWTPvj+FmhwRG7Z1dgl3+BHbzPielmGwY7oIuzEP/r8Y5Wqg7FcxbRujME
 p
X-Google-Smtp-Source: AGHT+IFFgNM/rfr1tPQGfN5FidWriTyRIgbnJMzi8aUjvLsajQTyItDQd7VnyTO30mSBQpKohLuNJg==
X-Received: by 2002:a05:6512:694:b0:519:3243:3083 with SMTP id
 t20-20020a056512069400b0051932433083mr816018lfe.14.1713275671881; 
 Tue, 16 Apr 2024 06:54:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a1709067c9100b00a4a396ba54asm6866832ejo.93.2024.04.16.06.54.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 06:54:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: [PATCH v3 15/22] hw/mem/memory-device: Remove legacy_align from
 memory_device_pre_plug()
Date: Tue, 16 Apr 2024 15:52:44 +0200
Message-ID: <20240416135252.8384-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416135252.8384-1-philmd@linaro.org>
References: <20240416135252.8384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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
Message-Id: <20240305134221.30924-12-philmd@linaro.org>
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


