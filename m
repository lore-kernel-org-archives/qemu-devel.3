Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB8BC9EC67
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFDK-0001lk-Ed; Mon, 12 Jan 2026 05:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFD3-0001Rd-3i
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:44 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFCy-0001k3-UB
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:39 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso26458665e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213891; x=1768818691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=229mJ0exSkSuzo3goGw27TABw6OtzO3/NT2tuTjL7Tg=;
 b=uKQ3bjznQPkEARxjyG52CAA8kWMZ9qaSxEw1PenJWyzbBID7yy6ax9AlxnaD0ke0t/
 GcfISKqERRJt5EFl53EGrZiDE9yKKqXG8VT/VVrBxNxhXCUWlckDRJKPRUbeKDNRyjQ3
 3cEil4ME4SCn/iAjPEdG+wfi09P/JuTeiYJr1C0mwJe0KJsldvGDbJMEA3A4T0WaEYr3
 q3PJOMz4Y06DS5ohygfiEs19s7oMQUnFzB8k7oLIZDbLXTcGtMCwOPLGLG8RuzWrphEh
 Fjyb2zR989rp1Ghq8xOnS+dUzdYHLBMAPb32ozMOIF+519ARguBx6TrKYPvwF0pX6hGH
 fN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213891; x=1768818691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=229mJ0exSkSuzo3goGw27TABw6OtzO3/NT2tuTjL7Tg=;
 b=b96J/b4hcFqaBavJHmb8l+tG8gfAts63MvORzv/2Antx5tSCCO42QKAnkwN+aRDmrB
 UWCeEstPioznoEkU89XC70lgAzjDIliHppsC6ffDhUEc4FC1VxGa02yCTS5ZOpBTVr+A
 a7J6aP0qLL+yxf+r2E2fa1SF/81Ppg0ZgVHrBMl9MX6uHMAAn7BTcDI4yQBVPpIQq3Ol
 hes3R+2NrtXTVCl6QZIQdnc4iYsyEo/O88NcSQnenEnRUJr/23sKQrM4dL/7+oRh6MF6
 26WSC8cLwI8ygV7ph25eLFsQy22ogXnIc8wQsE3zy2DDJHJUH1istt0m+mmAImQjMvHf
 P1Dw==
X-Gm-Message-State: AOJu0YzOFt1ruxHEgG1v9A6pgJPJjItLft4btT0LcYNLvUNKosDkI3eV
 E4xMVPgyNkyBtxRi8q8kHFouiDFiJN7/BA6hB7cL0SCA0ArasLPf5MXkt0d+73zMpahI/kWvqeN
 iA+Z7L5Q=
X-Gm-Gg: AY/fxX4SYX6gbigzyFt9S1sTFvLKB/zBIqQ+tisX2F3pX0cQfXbfic894LmGhJPzSp6
 c+FwK7RUlIuiy3Oa1i2YkRxTJzAmnjgfjOYVvUw/GK+iWfK0/vX0nba4OBB/t0GWrEquQMcGzRO
 +5AZYeuzv11A4iFbZ11K57fKx7ws8KLQWB1nHwifd7JV17De2dHvhP7AgGzVDfs8QO2JKvRD8Cu
 Y+J/f4WSRfgGR2fij8n1is1Jv34ICiqvdF6WihHUYp131OTuULaiDBg3x71FvNL5sliyR6aLbH2
 wqbuQcPDwReMe2SSPu5es3bu8Re5m+ZnzO9QgxowVX+xCcGRMJyYEuZmFSv5+ozHNNjHGVm3JCC
 32thuejJ9X/Q2iMukIXOkzNBiZe3oEIw2wPbTwmcBfPBKjUbmha0DE+pl00QpnGX0+7aQ7SbPWR
 DNqShk9xe+tLp8pWaiH2jMM9g6hKOaprL7tE+aDrjj+LTMoFeliElRWsU+uOvy
X-Google-Smtp-Source: AGHT+IGxNNabdE2dqECqAaNqVZs7YYzDTVBzYnA8oPlXa4JXy9OfHmt+PAXTKsrsivExvfvJCZVVMQ==
X-Received: by 2002:a05:600c:a46:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-47ec98112bcmr52055345e9.4.1768213891498; 
 Mon, 12 Jan 2026 02:31:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41eb3bsm360742385e9.7.2026.01.12.02.31.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:31:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 08/19] accel/hvf: Simplify hvf_set_phys_mem
Date: Mon, 12 Jan 2026 11:30:22 +0100
Message-ID: <20260112103034.65310-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

All of the complicated parts of updating the address space
are handled by address_space_update_topology_pass.
Do not create or use hvf_slot structures.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 accel/hvf/hvf-all.c | 111 +++++++-------------------------------------
 1 file changed, 17 insertions(+), 94 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 3b6b9d6ea6a..dd9ea641ea5 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -87,45 +87,16 @@ void hvf_unprotect_dirty_range(hwaddr addr, size_t size)
                      HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
 }
 
-static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
-{
-    struct mac_slot *macslot;
-    hv_return_t ret;
-
-    macslot = &mac_slots[slot->slot_id];
-
-    if (macslot->present) {
-        if (macslot->size != slot->size) {
-            macslot->present = 0;
-            trace_hvf_vm_unmap(macslot->gpa_start, macslot->size);
-            ret = hv_vm_unmap(macslot->gpa_start, macslot->size);
-            assert_hvf_ok(ret);
-        }
-    }
-
-    if (!slot->size) {
-        return 0;
-    }
-
-    macslot->present = 1;
-    macslot->gpa_start = slot->start;
-    macslot->size = slot->size;
-    trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
-                     flags & HV_MEMORY_READ ?  'R' : '-',
-                     flags & HV_MEMORY_WRITE ? 'W' : '-',
-                     flags & HV_MEMORY_EXEC ?  'X' : '-');
-    ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
-    assert_hvf_ok(ret);
-    return 0;
-}
-
 static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
 {
-    hvf_slot *mem;
     MemoryRegion *area = section->mr;
     bool writable = !area->readonly && !area->rom_device;
     hv_memory_flags_t flags;
     uint64_t page_size = qemu_real_host_page_size();
+    uint64_t gpa = section->offset_within_address_space;
+    uint64_t size = int128_get64(section->size);
+    hv_return_t ret;
+    void *mem;
 
     if (!memory_region_is_ram(area)) {
         if (writable) {
@@ -139,69 +110,28 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
         }
     }
 
-    if (!QEMU_IS_ALIGNED(int128_get64(section->size), page_size) ||
-        !QEMU_IS_ALIGNED(section->offset_within_address_space, page_size)) {
+    if (!QEMU_IS_ALIGNED(size, page_size) ||
+        !QEMU_IS_ALIGNED(gpa, page_size)) {
         /* Not page aligned, so we can not map as RAM */
         add = false;
     }
 
-    mem = hvf_find_overlap_slot(
-            section->offset_within_address_space,
-            int128_get64(section->size));
-
-    if (mem && add) {
-        if (mem->size == int128_get64(section->size) &&
-            mem->start == section->offset_within_address_space &&
-            mem->mem == (memory_region_get_ram_ptr(area) +
-            section->offset_within_region)) {
-            return; /* Same region was attempted to register, go away. */
-        }
-    }
-
-    /* Region needs to be reset. set the size to 0 and remap it. */
-    if (mem) {
-        mem->size = 0;
-        if (do_hvf_set_memory(mem, 0)) {
-            error_report("Failed to reset overlapping slot");
-            abort();
-        }
-    }
-
     if (!add) {
+        trace_hvf_vm_unmap(gpa, size);
+        ret = hv_vm_unmap(gpa, size);
+        assert_hvf_ok(ret);
         return;
     }
 
-    if (area->readonly ||
-        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
-        flags = HV_MEMORY_READ | HV_MEMORY_EXEC;
-    } else {
-        flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
-    }
+    flags = HV_MEMORY_READ | HV_MEMORY_EXEC | (writable ? HV_MEMORY_WRITE : 0);
+    mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
 
-    /* Now make a new slot. */
-    int x;
-
-    for (x = 0; x < hvf_state->num_slots; ++x) {
-        mem = &hvf_state->slots[x];
-        if (!mem->size) {
-            break;
-        }
-    }
-
-    if (x == hvf_state->num_slots) {
-        error_report("No free slots");
-        abort();
-    }
-
-    mem->size = int128_get64(section->size);
-    mem->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
-    mem->start = section->offset_within_address_space;
-    mem->region = area;
-
-    if (do_hvf_set_memory(mem, flags)) {
-        error_report("Error registering new memory slot");
-        abort();
-    }
+    trace_hvf_vm_map(gpa, size, mem, flags,
+                     flags & HV_MEMORY_READ ?  'R' : '-',
+                     flags & HV_MEMORY_WRITE ? 'W' : '-',
+                     flags & HV_MEMORY_EXEC ?  'X' : '-');
+    ret = hv_vm_map(mem, gpa, size, flags);
+    assert_hvf_ok(ret);
 }
 
 static void hvf_log_start(MemoryListener *listener,
@@ -260,7 +190,6 @@ static MemoryListener hvf_memory_listener = {
 
 static int hvf_accel_init(AccelState *as, MachineState *ms)
 {
-    int x;
     hv_return_t ret;
     HVFState *s = HVF_STATE(as);
     int pa_range = 36;
@@ -281,12 +210,6 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     }
     assert_hvf_ok(ret);
 
-    s->num_slots = ARRAY_SIZE(s->slots);
-    for (x = 0; x < s->num_slots; ++x) {
-        s->slots[x].size = 0;
-        s->slots[x].slot_id = x;
-    }
-
     QTAILQ_INIT(&s->hvf_sw_breakpoints);
 
     hvf_state = s;
-- 
2.52.0


