Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D658ECD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 12:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSZnI-0006pb-8w; Thu, 28 May 2026 08:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wSZnE-0006oL-RV; Thu, 28 May 2026 08:24:57 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wSZnB-000209-GI; Thu, 28 May 2026 08:24:56 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64SCON9C072008
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 May 2026 21:24:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=RxZUOf8ni6a8SIg/8EgGkqqYQg3EENoeddI1Vb1aoQQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779971079; v=1;
 b=WjmggZB2RupmxwbrduemVN60aRmub8CdXLmQ7yTD/9SsDUdP6OrH69HMR0ZWFdVR
 PMAd2jY41XcFzJwHWxOscuNCZShNUtQkvThOSvWsKu+jucUw7eNF9YOucScwg+iG
 jRKILhxx0dLE6YYAxY5GtD5qntDUwbGZxwx8YkDqUG/z/BBGtZ+RTfdYyjR+4PHK
 Gu3tfDDCF4f8gaLwQdu4ayonHEVSnbeCrjw3tvk4a2EKK/3kuc3RaCVBr2DzTEYW
 B0Xm/4qKRxNndKU8Tw9Qgwl5UndZM2HyCaNsM7euY1up+fVJrJWwv10KBSghmHUs
 P67SM7XtOv94H//iLT+zFg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 28 May 2026 21:24:05 +0900
Subject: [PATCH] hw/cxl: Fix cxl_fmws_set_memmap() range check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-cxl-v1-1-a470c8255264@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyML3eSKHN0U46Q0S8OkxGSDZDMloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0AcnVUiWcAAAA=
X-Change-ID: 20260528-cxl-d3bf91bac0c6
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=5805;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=AJDH0QO4O1OhWeasipmp1MRUM1hKVFxHeg8QcUDXHsY=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5aE8U8z3p1PYguNVl2Jnrz33gnXb7dKVr3O/BYeoPhbf
 3VhqrBIRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwESOcjD803LYvXh+dVt5jKbL
 Rem+kH1s8bdzRQuldmQZvI9uKVjziuGvyK5qFnWbl5ob1E/tkmcvaH5y9TfjrUqDA9tPNke5bn7
 ODQA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

cxl_fmws_set_memmap() leaves the zero-initialized base address of a CXL
fixed window unchanged when it does not fit in the memory map, which
results in incorrect mapping. Change the function to report an error
instead.

The Arm virt machine passes the exclusive end of the memory map while
the i386 pc machine passes the inclusive end to cxl_fmws_set_memmap().
Change the i386 pc machine to pass the exclusive end and perform the
range check accordingly in cxl_fmws_set_memmap().

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/cxl/cxl_host.h |  2 +-
 hw/arm/virt.c             |  6 +++---
 hw/cxl/cxl-host-stubs.c   |  4 ++--
 hw/cxl/cxl-host.c         | 12 +++++++-----
 hw/i386/pc.c              | 12 ++++++------
 5 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index 21619bb748ab..ed34c3159f59 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -16,7 +16,7 @@
 void cxl_machine_init(Object *obj, CXLState *state);
 void cxl_fmws_link_targets(Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
-hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
+bool cxl_fmws_set_memmap(hwaddr *cursor, hwaddr end, Error **errp);
 void cxl_fmws_update_mmio(void);
 GSList *cxl_fmws_get_all_sorted(void);
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b090233893c5..a22778575cfb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2536,9 +2536,9 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     if (device_memory_size > 0) {
         machine_memory_devices_init(ms, device_memory_base, device_memory_size);
     }
-    vms->highest_gpa = cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1,
-                                                    256 * MiB),
-                                           BIT_ULL(pa_bits)) - 1;
+    vms->highest_gpa = ROUND_UP(vms->highest_gpa + 1, 256 * MiB);
+    cxl_fmws_set_memmap(&vms->highest_gpa, BIT_ULL(pa_bits), &error_fatal);
+    vms->highest_gpa--;
 }
 
 static VirtGICType finalize_gic_version_do(const char *accel_name,
diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index 9b515913ea4d..fa87cea0e8b9 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -11,9 +11,9 @@
 void cxl_fmws_link_targets(Error **errp) {};
 void cxl_machine_init(Object *obj, CXLState *state) {};
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
-hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
+bool cxl_fmws_set_memmap(hwaddr *base, hwaddr max_addr, Error **errp)
 {
-    return base;
+    return true;
 };
 void cxl_fmws_update_mmio(void) {};
 
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index a94b893e9991..33421b3ca174 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -429,7 +429,7 @@ void cxl_fmws_update_mmio(void)
     object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map, NULL);
 }
 
-hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
+bool cxl_fmws_set_memmap(hwaddr *cursor, hwaddr end, Error **errp)
 {
     GSList *cfmws_list, *iter;
     CXLFixedWindow *fw;
@@ -437,14 +437,16 @@ hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
     cfmws_list = cxl_fmws_get_all_sorted();
     for (iter = cfmws_list; iter; iter = iter->next) {
         fw = CXL_FMW(iter->data);
-        if (base + fw->size <= max_addr) {
-            fw->base = base;
-            base += fw->size;
+        if (end - *cursor < fw->size) {
+            error_setg(errp, "A CXL fixed memory window does not fit in the memory map");
+            return false;
         }
+        fw->base = *cursor;
+        *cursor += fw->size;
     }
     g_slist_free(cfmws_list);
 
-    return base;
+    return true;
 }
 
 static void cxl_fmw_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ecad3c503fb..eadf37096533 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -747,7 +747,7 @@ void pc_memory_init(PCMachineState *pcms,
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(pcms);
     hwaddr maxphysaddr, maxusedaddr;
-    hwaddr cxl_base, cxl_resv_end = 0;
+    hwaddr cxl_cursor = 0;
     X86CPU *cpu = X86_CPU(first_cpu);
     uint64_t res_mem_end;
 
@@ -857,11 +857,11 @@ void pc_memory_init(PCMachineState *pcms,
         MemoryRegion *mr = &pcms->cxl_devices_state.host_mr;
         hwaddr cxl_size = MiB;
 
-        cxl_base = pc_get_cxl_range_start(pcms);
+        cxl_cursor = pc_get_cxl_range_start(pcms);
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
-        memory_region_add_subregion(system_memory, cxl_base, mr);
-        cxl_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
-        cxl_resv_end = cxl_fmws_set_memmap(cxl_base, maxphysaddr);
+        memory_region_add_subregion(system_memory, cxl_cursor, mr);
+        cxl_cursor = ROUND_UP(cxl_cursor + cxl_size, 256 * MiB);
+        cxl_fmws_set_memmap(&cxl_cursor, maxphysaddr + 1, &error_fatal);
         cxl_fmws_update_mmio();
     }
 
@@ -892,7 +892,7 @@ void pc_memory_init(PCMachineState *pcms,
     rom_set_fw(fw_cfg);
 
     if (pcms->cxl_devices_state.is_enabled) {
-        res_mem_end = cxl_resv_end;
+        res_mem_end = cxl_cursor;
     } else if (machine->device_memory) {
         res_mem_end = machine->device_memory->base
                       + memory_region_size(&machine->device_memory->mr);

---
base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
change-id: 20260528-cxl-d3bf91bac0c6

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


