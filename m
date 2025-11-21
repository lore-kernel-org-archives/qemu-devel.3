Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D57CFA76B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO0R-0005HA-Cf; Fri, 21 Nov 2025 05:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNza-0004kd-Th
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:51 -0500
Received: from p-east3-cluster3-host5-snip4-6.eps.apple.com ([57.103.86.49]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzK-0007up-2i
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:48 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 515C718010E1; Fri, 21 Nov 2025 10:03:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=m3T10dAXHppumsAJBbE2xnya72Vhx976XE5zWYABtwg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CR78gFJK4TnKiIdKciuxzbNrpeG9V2axKzhhStpVoF7wUJcFehYullUYpR3CvMzSKqIVsFX2SQdnMDKMc92fYfFqe3urhhQVXwfwDWuMVeXGLPruFWfB1qV5sDzL+xNIYeMXrOXQZJjsSw+cmfaw2lpf56aNV4M9Yut72ofAjV8V+Saf5fdXNvEd0BbFRRLxRgpHzA7SceRHFv/9OYkcHy0WE+flM6GvnwNfVUodiQ24wGg0vXV/HbBWGjChKQo7cXwrdgE12tmou4bKA1Fj1X+C1hNl5yUYeVq8OSvjphciedDeLehUc+lshFO7v0lNaNhxJaw8ygptdXmVrxneKQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 3FA9518010F4; Fri, 21 Nov 2025 10:03:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v11 14/28] whpx: change memory management logic
Date: Fri, 21 Nov 2025 11:02:26 +0100
Message-ID: <20251121100240.89117-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=d/b4CBjE c=1 sm=1 tr=0 ts=692038de cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=-lUDFlMDQ8UY_jOkuTYA:9
X-Proofpoint-GUID: tfEXPYz5CA2P3YJO6WYc-oA2pAX50TCn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX7PoLvJQYE7Mp
 mR3CFwjEiuo65+RjKQF4pKNsPyFNVEmkm+ifXL9ternv6cEIiUQHCO9ek8peDZK2qtYbro6VAb2
 ImQ/gBPYdyvVjAW1xSX9VYlhUvDcuTd8QauK5gfk+zCQskse2eMMg/fPG3nn4phQi13c6BHAg4g
 yidFp13I1UBjXVxmTqWOCby8xM4+hIfBtya1lCRK+gl2CUwKN7aqFge6HoZJsmUfjSKeEJ2lM+p
 tPhWjKemQSWoGz0ijYKwejXYCdvKWXmptLTrkM0FxBSFdkLE3LSbLrFdHASvDgLpu2cdDatAaXP
 qKwL9q2SYX2HbmViPIc
X-Proofpoint-ORIG-GUID: tfEXPYz5CA2P3YJO6WYc-oA2pAX50TCn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABtIZLPGWnxHf/aZxCfPOcGa46QIjA+DUU5B6vOhdPv85E2/Vj5POQOOA9i+TL9IfMlTWn4Box4Rn4mpRHWYziGYp3+Xi/xzskgP+ROoCrvD/52taOlwU2udeF1ZbrO9Ga2A9j1pnUeceXGVKeYcnQKfyEDdAtV0fCBca3oGBdBH8jl0YvUaw2f5Q0x6yjTVk4RB1BJmGlBqk6tnQkSXiXodQ0P4ha1+I+OtGL0zrKWodykWcW+wvBloRyrXmQy4aIw3fiCTtEcxe1CDHQd4mfdYyI35jlu5ewePCMAaVgn7pFf89Goam5PQSK3Dl9xD4VZFPuC96//WMvqywjwZl3qTs+IzcBbH+xIXRfG/219IyssSkMgJASk4FSIj7rKpkFnVHCX3bR79s3O/8QMHvfRN2NkdgKaXEhWGwX1gkMHwTWCrnCGQF+2RDFp/LmaTV13iWronTyGMtXfXbtkArvVTjLe3VrjjWLaCR3zVHzF7w6oEaz6ReXhMnHXpIqHVOK5FwrdRMj1ERCZd+SAs55Vi93/9RmiY36zvnPe5bv1vTthbG7uYsFcZX/4SX3nLHaFjXTrLmDtgadJR7kEjad2lhBLuIqTNs288At5+6l7NRmXUboAE1B47jjcyE24kpVTpYgSDGBot/dW1ml7vt73dHK94rWdB7ukVEeB1l2bgxtwdZFngu+GMvuhT0QoOgupis4PnqBkKWWDxk+iBv/odpJXEhdZU09PxQsK7j8VSMbNIIroBvMPlgD
Received-SPF: pass client-ip=57.103.86.49;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This allows edk2 to work on Arm, although u-boot is still not functional.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c | 101 +++++++++++++++------------------------
 1 file changed, 38 insertions(+), 63 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 399cf1914c..53b8cb06cc 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -259,89 +259,64 @@ void whpx_vcpu_kick(CPUState *cpu)
  * Memory support.
  */
 
-static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
-                                void *host_va, int add, int rom,
-                                const char *name)
+static void whpx_set_phys_mem(MemoryRegionSection *section, bool add)
 {
     struct whpx_state *whpx = &whpx_global;
-    HRESULT hr;
-
-    /*
-    if (add) {
-        printf("WHPX: ADD PA:%p Size:%p, Host:%p, %s, '%s'\n",
-               (void*)start_pa, (void*)size, host_va,
-               (rom ? "ROM" : "RAM"), name);
-    } else {
-        printf("WHPX: DEL PA:%p Size:%p, Host:%p,      '%s'\n",
-               (void*)start_pa, (void*)size, host_va, name);
-    }
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
-    }
-
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to %s GPA range '%s' PA:%p, Size:%p bytes,"
-                     " Host:%p, hr=%08lx",
-                     (add ? "MAP" : "UNMAP"), name,
-                     (void *)(uintptr_t)start_pa, (void *)size, host_va, hr);
+    MemoryRegion *area = section->mr;
+    bool writable = !area->readonly && !area->rom_device;
+    WHV_MAP_GPA_RANGE_FLAGS flags;
+    uint64_t page_size = qemu_real_host_page_size();
+    uint64_t gva = section->offset_within_address_space;
+    uint64_t size = int128_get64(section->size);
+    HRESULT res;
+    void *mem;
+
+    if (!memory_region_is_ram(area)) {
+        if (writable) {
+            return;
+        } else if (!memory_region_is_romd(area)) {
+             add = false;
+        }
     }
-}
-
-static void whpx_process_section(MemoryRegionSection *section, int add)
-{
-    MemoryRegion *mr = section->mr;
-    hwaddr start_pa = section->offset_within_address_space;
-    ram_addr_t size = int128_get64(section->size);
-    unsigned int delta;
-    uint64_t host_va;
 
-    if (!memory_region_is_ram(mr)) {
-        return;
+    if (!QEMU_IS_ALIGNED(size, page_size) ||
+        !QEMU_IS_ALIGNED(gva, page_size)) {
+        /* Not page aligned, so we can not map as RAM */
+        add = false;
     }
 
-    delta = qemu_real_host_page_size() - (start_pa & ~qemu_real_host_page_mask());
-    delta &= ~qemu_real_host_page_mask();
-    if (delta > size) {
-        return;
-    }
-    start_pa += delta;
-    size -= delta;
-    size &= qemu_real_host_page_mask();
-    if (!size || (start_pa & ~qemu_real_host_page_mask())) {
+    if (!add) {
+        res = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
+                gva, size);
+        if (!SUCCEEDED(res)) {
+            error_report("WHPX: failed to unmap GPA range");
+            abort();
+        }
         return;
     }
 
-    host_va = (uintptr_t)memory_region_get_ram_ptr(mr)
-            + section->offset_within_region + delta;
+    flags = WHvMapGpaRangeFlagRead | WHvMapGpaRangeFlagExecute
+     | (writable ? WHvMapGpaRangeFlagWrite : 0);
+    mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
 
-    whpx_update_mapping(start_pa, size, (void *)(uintptr_t)host_va, add,
-                        memory_region_is_rom(mr), mr->name);
+    res = whp_dispatch.WHvMapGpaRange(whpx->partition,
+         mem, gva, size, flags);
+    if (!SUCCEEDED(res)) {
+        error_report("WHPX: failed to map GPA range");
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
-- 
2.50.1 (Apple Git-155)


