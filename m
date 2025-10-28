Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A65CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcu5-00009Z-8A; Tue, 28 Oct 2025 02:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcu0-0008Pw-FU
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:09:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcty-0006E3-Gl
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:09:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-427015003eeso4909036f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631788; x=1762236588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZU5Y5jdxtTfJM7VLLaWii+65USNcK5SXMjuuGQStsM=;
 b=IlaJxUPmNC2FM2eKxEibD0ABaP10wOTCKEwiNfB+bux2htfafRt6UsX/Yg3+zgaiZB
 8hpHapfbyMp3ZxUvvwlaHvvEtGwMIDZ1H0e0fZRQYADCH/PIsV3C22ZU6/a/N/IyiTXy
 Km572LS0D0dZvdpr9ySMsnX9BeI3DiERgpUeQvL+x4c8MrvASaOK4p5WhGXut7esHH+m
 w5FaGRNzaVFTN2+Cl9xpreweiZdNvnrxjYrMM7YNRPfL/1hINi/SQYnVA6Ia24kJYDkk
 h8Y0YZAE0s1kgafFmJM4qgu9fMzjU9oIb4sx9V3B4fz4h9Z5B56T/RyvJa0qp9FrW0Ob
 nkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631788; x=1762236588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ZU5Y5jdxtTfJM7VLLaWii+65USNcK5SXMjuuGQStsM=;
 b=D8Pk6ec8eA9FvGSFVc8fcFYO+1EnwtNaOwAFowKT9fg0auetFiEHIURYtL1+GchU8G
 9MPikZy21Kx4IsXMWmKGA/hekxxUSKeaAgLrHwhs3yiG9C/GIMKTeX2gZzcHe/3egOsz
 TRY1cgzTXRJvhBIZKBI5hRh6jeM+DvXPanxJ90jXPUN4Za9KbasArumGjoJqv/tgO8vi
 jOOOY5cVYJkipchHr9AkuKjFcwum4SPLiOpTlapGfl8EdSGQMyHKVXWGfkUBJfnvVWmZ
 A+2yKrKxHne+3Vp+NLUnTtY3S0WXN2vjiBtTYoX+/2gJDNqPBSLfo5VM7rFo6p2PHh3n
 pLEw==
X-Gm-Message-State: AOJu0Yxn02pcIkA+aiFFRIgh8dQz+Jtk3aBqtfgkOza8GYNNuHmkvpyw
 x4cPH77nCF7NpdrSD+Pv4xT8H+MoLUH3k08YWudJ6InrI4qYq52seinnU7ylwwyIWBs/sAQ/ALn
 UbaSXTsM=
X-Gm-Gg: ASbGncs+hgTai+5HqPZw9buqWEZwLfTsEUyWV2kDGEAXS0OqKx2WDtbZFedQ5+7ceB1
 Y5z9ayp4OnzuHIkhnEsWZw3R8uzn73UBAJRWEfiqzwz7sA1g7VSR1JAUV1Da0Y2apnxyudrIsJj
 ukpa9TnVCf8+oOzwU2Gx7emvwS7LqlvgPZi7fl/dZfo9pprAqQrxmLvkKBA5v5NHgedAx8c7TVv
 bvfC1f7oEsO9JJqmYv7FpRWmK1ec/B6gU9jwfZixj9IxNiNDsdeeNxHdG/od/WpEOKyMqVDw+FQ
 K+RTePjV9hlGDddQ+YCpizPr3yz5Lh9OKKJyJWSaj2nWR83SlEj/urNnytndrg7LzapjSyA7Mgx
 3g9DdmzZ4yJbSxndbuQmY6rUZAzceav4sTjorNHCgtzwLrr93i3KuY9L7KS9iVDKyA2O5tRUN7V
 skJlKrndk83OXSZBzE2341PvyNl12qu3cyKSvZL+FqfA6ibF3qHGL/Wqc=
X-Google-Smtp-Source: AGHT+IGcQBpziHy8WQwIlSWWs40B2V1U8bpaNmxq9myLSa8B4GckMQu2wCzE7MMtqkWKFjY7Z7YDbw==
X-Received: by 2002:a5d:5d87:0:b0:3e9:ee54:af71 with SMTP id
 ffacd0b85a97d-429a7e52c4cmr1653753f8f.12.1761631788394; 
 Mon, 27 Oct 2025 23:09:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb7e8sm18669147f8f.19.2025.10.27.23.09.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:09:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 38/59] accel/hvf: Simplify hvf_set_phys_mem
Date: Tue, 28 Oct 2025 06:42:14 +0100
Message-ID: <20251028054238.14949-39-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

All of the complicated parts of updating the address space
are handled by address_space_update_topology_pass.
Do not create or use hvf_slot structures.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 111 +++++++-------------------------------------
 1 file changed, 17 insertions(+), 94 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 4b0a1af9fdc..97b367bd788 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -86,45 +86,16 @@ void hvf_unprotect_dirty_range(hwaddr addr, size_t size)
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
+    uint64_t gva = section->offset_within_address_space;
+    uint64_t size = int128_get64(section->size);
+    hv_return_t ret;
+    void *mem;
 
     if (!memory_region_is_ram(area)) {
         if (writable) {
@@ -138,69 +109,28 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
         }
     }
 
-    if (!QEMU_IS_ALIGNED(int128_get64(section->size), page_size) ||
-        !QEMU_IS_ALIGNED(section->offset_within_address_space, page_size)) {
+    if (!QEMU_IS_ALIGNED(size, page_size) ||
+        !QEMU_IS_ALIGNED(gva, page_size)) {
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
+        trace_hvf_vm_unmap(gva, size);
+        ret = hv_vm_unmap(gva, size);
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
+    trace_hvf_vm_map(gva, size, mem, flags,
+                     flags & HV_MEMORY_READ ?  'R' : '-',
+                     flags & HV_MEMORY_WRITE ? 'W' : '-',
+                     flags & HV_MEMORY_EXEC ?  'X' : '-');
+    ret = hv_vm_map(mem, gva, size, flags);
+    assert_hvf_ok(ret);
 }
 
 static void hvf_log_start(MemoryListener *listener,
@@ -259,7 +189,6 @@ static MemoryListener hvf_memory_listener = {
 
 static int hvf_accel_init(AccelState *as, MachineState *ms)
 {
-    int x;
     hv_return_t ret;
     HVFState *s = HVF_STATE(as);
     int pa_range = 36;
@@ -280,12 +209,6 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
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
2.51.0


