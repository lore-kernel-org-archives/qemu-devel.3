Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5F7CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5c-0003dI-Gd; Wed, 29 Oct 2025 13:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5W-0003ax-LT
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:58 -0400
Received: from p-east2-cluster1-host9-snip4-10.eps.apple.com ([57.103.76.113]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5G-0003Lo-78
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:58 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 B6A9C1824491; Wed, 29 Oct 2025 17:35:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=xJAo1UBdZ8OCZhRCAjdQFGpLMCFJEpy5JZqSAAb7aX8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=X4pJiibYhti+2D/uvrYZPeN82ScQbo0ZH2GNgDOt2N6fOrTUJCi1yqgZzZcjZvBAH1nofp/jlJXl1suSjXtSaSe8cMep19j/qpJbBoS14HVXypwkfKUatQ8e4DSgwa7yTlz7/OsaavquYygzmUb580Mh4KwQ3nacOFXnxvNKgbh1VDrlNDetOY39dIWo5DSdsi9q9NGBth7iDvoggTa0Nb09YwNS+JX0SZSJ/pydMIJheNsPeirurLdEnqY4JBxfURwAIYBO0MzQtnoYLKRHYYQcvj4WdJMQzHh6GjUsmEOce+wE+NQDjNsVMroLJyfFKR4IXWSS3WghrSf7vHpQiA==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 5A47518076DB; Wed, 29 Oct 2025 16:55:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 13/28] whpx: change memory management logic
Date: Wed, 29 Oct 2025 17:54:55 +0100
Message-ID: <20251029165510.45824-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KLsQIPo04_gTGx1Y4AoWkeQG4ohI7u6D
X-Proofpoint-GUID: KLsQIPo04_gTGx1Y4AoWkeQG4ohI7u6D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfXzqlEouIAHAy4
 qqyV7KRZdRCljmjeEk6aa4qkq5tWyyK6KMG3T35iMvwRTBJeQaQpn3L+LkNgdAR8Do0+0U1Fv3r
 ccxOEpZSph9Djz8CzabufvYqM3UCg15AjXLc0Cmb7g4cMU/Zb9Y1CffpL/WuuBgx0gh+ybA0om+
 che6FMPEveyfqH9NL2UBUlam66XLZn5AWkcyQIxCDpHPSvkcxjmyeWNdDCBWd1z26wLzJS2cSe0
 eE9Eg9ikxay3ruePdqQ2P6TOZzikI5RPi0UBBUQVzMmVBnt1aNk4J1Xrh7Fv8N4d3igmZI7Sg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=963 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABmYl7oBGtiQGRAMK1r6hwErmrBUsLvDEt5FXthu1IeVXZd3Oz+cAkj3dtdtXjmDkk+3pYfxQIfTiQMwAqUcmT2B4tFTgyl1f1TstOuXfh2q+KJRV0llpFT/5WcG86pjQbRL6/kMaa7EyV0E0E+zakaw3sfPgzp559fkcsS/FiE0tjSRFYwoBfJTt7CrKb2X0ztDMCRgzHLCUlFgXMZJoA54k9R1/V/bZv6SifxMVdGt4ATo1LluTS9MM4blvDIxVb6AnqbwAzxSlVcZjIRGJzzK2SYZd1TahTUgH2pL8xqlrTYYNOZs6UmfKHYYwwMPg/icEMtnmv/SiKQjRNil15oKEa8YiYKXaExzVkUU1UrbiGMsds2B3vLWQfvfCtfoKe/2qHlPGYvU++hVKFEPH/CtOBHFD8MW/1CF03fFTu+W7XEGC7eEFXGl852ZT2tCzYnXNWpGLSMPjtOQua6StihFTQIJ4O1oC5koNB/+QEt3a1Clj1zrAW/DDQ4H4wo60Lco4Vuh2vXnujsMPuAtkyyTCrvIWT84ASgReX7WQgBvPwZrHJ0XgzBNU4ciXk/bmtfNC+9z/Nxtyj6UgtK1fDWWs4AHCb6uaIEz1u5oeHcIOdYNyXdCbIj07P+WM8x2drp0X/jEekRoi0U49NpfCUe08fhoW5dHpeAb+ujzRJYRj5uk7pqU7x/LaOry+XIGvwT1f/00KFFSL35oBK0ZzpPtcqDj2EmKoCiV/ee4DXT+Ah1GzbDxTtDMkHxJwtWw==
Received-SPF: pass client-ip=57.103.76.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index c69792e638..aefec4bc8f 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -258,89 +258,64 @@ void whpx_vcpu_kick(CPUState *cpu)
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


