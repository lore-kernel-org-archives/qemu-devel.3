Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7999CC27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Xr-0007NF-D2; Mon, 17 Jun 2024 03:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Xp-00079J-6d
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:49 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Xn-0002Ng-80
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:48 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so605265266b.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608365; x=1719213165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1PAfSOioCsPYSEzokEcxN3G7yqqrG+D69U3fBdQq5A=;
 b=aqxgnRjV8cFeeJQh3d1dVkScl2fD6TzqOqJc3AD4IN2gky7Gr6mIz+cICUO2ytqf5U
 GFFCqBts3XwpqybdDbiPjbeuwukZMUiSMJFPdHnIiBkAxWGgRSuhGeg5PxdmCKV8NgjL
 S+vjOGKm7xWaPPxn7FU28fSi/TJgo2VmrNbuJKk6KtvbuKd6AtyoeopnkGnGMYzar84+
 p1Srn2t9AUpI0P0eG5GGbkFYJOkMgKVIw8ULLOYMIheSHhSuuh9MgJMVbYaOSp6qkDS5
 BV28GrmEHWdRCCQZsUJHOWyFSVCiJUc17KfFGBOYzwK38IkXF2YyXyCsaEOhMVeoWg4Y
 n4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608365; x=1719213165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1PAfSOioCsPYSEzokEcxN3G7yqqrG+D69U3fBdQq5A=;
 b=LIXT48NdDYvzDIjf3SPo0AjS7X1mrHFICwbOuM6FSMXnVqz2M2Zz2VYnNJOacckzCI
 jYFiEivpbCsV0B76Z15dejig98DRa9Oi1JFQN6/7fXW8G4TJrjeM2islC52U+xrPELZt
 YlrNEW6pzupTPeW474Nxv+ag4Hs5m9hv0xsc/cF82Kfm29U+Ff5PAu1eCFpqGoOOPtDL
 5bF3aWdJn7uAQcoSHZs2mxrR46pbUt+VsufqOwG1uQE/S+mjuNRL8iYjX0qee3i/E/CU
 ZVloXaJTNFitcMaOkfPPMf7mF+GYIHkZS2dQzCEI5KauGchSQzdkParvk+4C5iwzTXfo
 Ojcg==
X-Gm-Message-State: AOJu0YwolmK1f+tXDl4HgxLbNgq+AWdFGziiT6dtqvsUoxl/xXDoB+nQ
 mzz1xeBhfjVdKarEIq5iK8L0uY5o18cZxB23D0rCJxUVML+e+H/DDr+DUfe/5mzxggAWVqkBEI5
 RcYU=
X-Google-Smtp-Source: AGHT+IEhVYqxPoFQ1i+QrUwdgK3bQbJ992jzWOtqYIYlhfOC6Rk3cRWZQjMyERRIJ8MuiMv8qIY4uQ==
X-Received: by 2002:a17:906:457:b0:a68:c744:725b with SMTP id
 a640c23a62f3a-a6f60d2cd0cmr518531566b.32.1718608365496; 
 Mon, 17 Jun 2024 00:12:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da3f50sm493279766b.14.2024.06.17.00.12.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:12:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 15/23] hw/mem/memory-device: Remove legacy_align from
 memory_device_pre_plug()
Date: Mon, 17 Jun 2024 09:11:10 +0200
Message-ID: <20240617071118.60464-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

'legacy_align' is always NULL, remove it, simplifying
memory_device_pre_plug().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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
index 2d0a517c4c..8a9c025754 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1395,8 +1395,7 @@ static void pc_hv_balloon_pre_plug(HotplugHandler *hotplug_dev,
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


