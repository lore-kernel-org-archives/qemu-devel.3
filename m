Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BC6C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 08:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui7Se-0000Uc-Gy; Sat, 02 Aug 2025 04:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Rl-0007SZ-Ir
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:29 -0400
Received: from p-east3-cluster3-host2-snip4-1.eps.apple.com ([57.103.86.14]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Rj-00055V-K8
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:29 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id
 369951800166; Sat,  2 Aug 2025 08:18:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=w42pZqZp2s0L3kj+q4OiaEo81d2J65/Cbb1vtjBtnlo=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=bwj5tS2xLTFh19ugQfFNM0rdaEymfXcZWNNCKTbZdQj5m457BiUXwGiJhXUQd2KfblFpEnKXPPQxIRuA/AqlxXySO+32PApHdVvvIzZTbV+1BXPXCtRZL3XjKcdhzZB0fgbP28Cma76HImNWQ7fFESuCeaAqjyTP+J+3tHQG5lPf0K5hK9vRiERVfaFJ5lhe3jMRwFmFyAL+85dV2KSlS2XAWoWdtJJFaYqK+dTXZ1geL10L/Vuu1NSv/Uyi+dRf7mxXf3dnIDhGidQGuUbnACItr0Aik2gIi+YUqbWXISKMEhZ1O34kajhHIFQIQlBvMx1pu3PKI1+LfJs9YyWtIw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id
 4AA30180016B; Sat,  2 Aug 2025 08:18:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-arm@nongnu.org, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 08/14] whpx: copy over memory management logic from hvf
Date: Sat,  2 Aug 2025 10:17:54 +0200
Message-Id: <20250802081800.76030-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250802081800.76030-1-mohamed@unpredictable.fr>
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA3MCBTYWx0ZWRfX6rXeSnJw4MzT
 cH56jHFrNAP6LKPtg/yjn32HrcdPf5Y7fScEUoaA9EWYrBfaeGca46KIEy2WvmCwHglLcXYRHFp
 Um1KugEczMMKBcoKGFApesqHuR+3oGAHxXiusdua6OpCh4P+4T+Eyhb15YbIxpUwMRQwkI7Xf8m
 cAdLy0Hh1wWStQ9K76FSLtEn6r9qi6uQwethhTruyUYHKnBa6HfLDvZxgQuSutHY7X/dcp8NSKF
 pdmH4ednNNdDM5DaI3hCESF+AVcwojy+O8a8jqHS47BVu71Pww6Ysy2NrkHy+YS9A0kNtpMew=
X-Proofpoint-ORIG-GUID: ZxIeUrL7YCeT-59QU7olSGpjUAxSkfHZ
X-Proofpoint-GUID: ZxIeUrL7YCeT-59QU7olSGpjUAxSkfHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 clxscore=1030 adultscore=0
 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508020070
Received-SPF: pass client-ip=57.103.86.14;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This allows edk2 to work, although u-boot is still not functional.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c | 201 ++++++++++++++++++++++++++++-----------
 1 file changed, 147 insertions(+), 54 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index b974b73082..e2a7961679 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -266,89 +266,174 @@ void whpx_vcpu_kick(CPUState *cpu)
  * Memory support.
  */
 
-static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
-                                void *host_va, int add, int rom,
-                                const char *name)
+ /* whpx_slot flags */
+#define WHPX_SLOT_LOG (1 << 0)
+typedef struct whpx_slot {
+    uint64_t start;
+    uint64_t size;
+    uint8_t *mem;
+    int slot_id;
+    uint32_t flags;
+    MemoryRegion *region;
+} whpx_slot;
+
+typedef struct WHPXState {
+    whpx_slot slots[32];
+    int num_slots;
+} WHPXState;
+
+ WHPXState *whpx_state;
+
+ struct mac_slot {
+    int present;
+    uint64_t size;
+    uint64_t gpa_start;
+    uint64_t gva;
+};
+
+struct mac_slot mac_slots[32];
+
+static int do_whpx_set_memory(whpx_slot *slot, WHV_MAP_GPA_RANGE_FLAGS flags)
 {
     struct whpx_state *whpx = &whpx_global;
+    struct mac_slot *macslot;
     HRESULT hr;
 
-    /*
-    if (add) {
-        printf("WHPX: ADD PA:%p Size:%p, Host:%p, %s, '%s'\n",
-               (void*)start_pa, (void*)size, host_va,
-               (rom ? "ROM" : "RAM"), name);
-    } else {
-        printf("WHPX: DEL PA:%p Size:%p, Host:%p,      '%s'\n",
-               (void*)start_pa, (void*)size, host_va, name);
+    macslot = &mac_slots[slot->slot_id];
+
+    if (macslot->present) {
+        if (macslot->size != slot->size) {
+            macslot->present = 0;
+            hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
+                 macslot->gpa_start, macslot->size);
+            if (FAILED(hr)) {
+                abort();
+            }
+        }
     }
-    */
-
-    if (add) {
-        hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
-                                         host_va,
-                                         start_pa,
-                                         size,
-                                         (WHvMapGpaRangeFlagRead |
-                                          WHvMapGpaRangeFlagExecute |
-                                          (rom ? 0 : WHvMapGpaRangeFlagWrite)));
-    } else {
-        hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
-                                           start_pa,
-                                           size);
+
+    if (!slot->size) {
+        return 0;
     }
 
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to %s GPA range '%s' PA:%p, Size:%p bytes,"
-                     " Host:%p, hr=%08lx",
-                     (add ? "MAP" : "UNMAP"), name,
-                     (void *)(uintptr_t)start_pa, (void *)size, host_va, hr);
+    macslot->present = 1;
+    macslot->gpa_start = slot->start;
+    macslot->size = slot->size;
+    hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
+         slot->mem, slot->start, slot->size, flags);
+    return 0;
+}
+
+static whpx_slot *whpx_find_overlap_slot(uint64_t start, uint64_t size)
+{
+    whpx_slot *slot;
+    int x;
+    for (x = 0; x < whpx_state->num_slots; ++x) {
+        slot = &whpx_state->slots[x];
+        if (slot->size && start < (slot->start + slot->size) &&
+            (start + size) > slot->start) {
+            return slot;
+        }
     }
+    return NULL;
 }
 
-static void whpx_process_section(MemoryRegionSection *section, int add)
+static void whpx_set_phys_mem(MemoryRegionSection *section, bool add)
 {
-    MemoryRegion *mr = section->mr;
-    hwaddr start_pa = section->offset_within_address_space;
-    ram_addr_t size = int128_get64(section->size);
-    unsigned int delta;
-    uint64_t host_va;
+    whpx_slot *mem;
+    MemoryRegion *area = section->mr;
+    bool writable = !area->readonly && !area->rom_device;
+    WHV_MAP_GPA_RANGE_FLAGS flags;
+    uint64_t page_size = qemu_real_host_page_size();
+
+    if (!memory_region_is_ram(area)) {
+        if (writable) {
+            return;
+        } else if (!memory_region_is_romd(area)) {
+            /*
+             * If the memory device is not in romd_mode, then we actually want
+             * to remove the whpx memory slot so all accesses will trap.
+             */
+             add = false;
+        }
+    }
 
-    if (!memory_region_is_ram(mr)) {
-        return;
+    if (!QEMU_IS_ALIGNED(int128_get64(section->size), page_size) ||
+        !QEMU_IS_ALIGNED(section->offset_within_address_space, page_size)) {
+        /* Not page aligned, so we can not map as RAM */
+        add = false;
     }
 
-    delta = qemu_real_host_page_size() - (start_pa & ~qemu_real_host_page_mask());
-    delta &= ~qemu_real_host_page_mask();
-    if (delta > size) {
-        return;
+    mem = whpx_find_overlap_slot(
+            section->offset_within_address_space,
+            int128_get64(section->size));
+
+    if (mem && add) {
+        if (mem->size == int128_get64(section->size) &&
+            mem->start == section->offset_within_address_space &&
+            mem->mem == (memory_region_get_ram_ptr(area) +
+            section->offset_within_region)) {
+            return; /* Same region was attempted to register, go away. */
+        }
+    }
+
+    /* Region needs to be reset. set the size to 0 and remap it. */
+    if (mem) {
+        mem->size = 0;
+        if (do_whpx_set_memory(mem, 0)) {
+            error_report("Failed to reset overlapping slot");
+            abort();
+        }
     }
-    start_pa += delta;
-    size -= delta;
-    size &= qemu_real_host_page_mask();
-    if (!size || (start_pa & ~qemu_real_host_page_mask())) {
+
+    if (!add) {
         return;
     }
 
-    host_va = (uintptr_t)memory_region_get_ram_ptr(mr)
-            + section->offset_within_region + delta;
+    if (area->readonly ||
+        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
+        flags = WHvMapGpaRangeFlagRead | WHvMapGpaRangeFlagExecute;
+    } else {
+        flags = WHvMapGpaRangeFlagRead | WHvMapGpaRangeFlagWrite
+         | WHvMapGpaRangeFlagExecute;
+    }
+
+    /* Now make a new slot. */
+    int x;
+
+    for (x = 0; x < whpx_state->num_slots; ++x) {
+        mem = &whpx_state->slots[x];
+        if (!mem->size) {
+            break;
+        }
+    }
+
+    if (x == whpx_state->num_slots) {
+        error_report("No free slots");
+        abort();
+    }
 
-    whpx_update_mapping(start_pa, size, (void *)(uintptr_t)host_va, add,
-                        memory_region_is_rom(mr), mr->name);
+    mem->size = int128_get64(section->size);
+    mem->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
+    mem->start = section->offset_within_address_space;
+    mem->region = area;
+
+    if (do_whpx_set_memory(mem, flags)) {
+        error_report("Error registering new memory slot");
+        abort();
+    }
 }
 
 static void whpx_region_add(MemoryListener *listener,
                            MemoryRegionSection *section)
 {
-    memory_region_ref(section->mr);
-    whpx_process_section(section, 1);
+    whpx_set_phys_mem(section, true);
 }
 
 static void whpx_region_del(MemoryListener *listener,
                            MemoryRegionSection *section)
 {
-    whpx_process_section(section, 0);
-    memory_region_unref(section->mr);
+    whpx_set_phys_mem(section, false);
 }
 
 static void whpx_transaction_begin(MemoryListener *listener)
@@ -532,6 +617,14 @@ static void whpx_accel_instance_init(Object *obj)
     memset(whpx, 0, sizeof(struct whpx_state));
     /* Turn on kernel-irqchip, by default */
     whpx->kernel_irqchip_allowed = true;
+
+    int x;
+    whpx_state = malloc(sizeof(WHPXState));
+    whpx_state->num_slots = ARRAY_SIZE(whpx_state->slots);
+    for (x = 0; x < whpx_state->num_slots; ++x) {
+        whpx_state->slots[x].size = 0;
+        whpx_state->slots[x].slot_id = x;
+    }
 }
 
 static const TypeInfo whpx_accel_type = {
-- 
2.39.5 (Apple Git-154)


