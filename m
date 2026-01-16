Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE92C79FBF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkHa-0005UH-Vz; Fri, 16 Jan 2026 08:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGV-0003Me-Ax
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:33 -0500
Received: from ci-2004c-snip4-7.eps.apple.com ([57.103.89.30]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGQ-0002Ds-Sf
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:25 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 806BD180F91B; Fri, 16 Jan 2026 13:53:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=F9oLyg/qgYRJ/JZV5dNJO6abkXMsGF/lMhk1P5D4R60=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=V/DCRBnOY7EPplMJMkORJcmUIebBkZKTVbTe1d7b/gzm3wOzE6hkLtUWVggiPJkI7xWkmcaBZ3f3T9+bhNJrGYmbGZXjR/QwoHDJJdPleFM6Tr2R5UsqrAcdWGIFH3VmGFJk2rdlj45RG3dePH6+BCd2f/xSEuipg3nwSkQMkrfdmnANl5HDEF3gN0q9IGrG11k5/m2eN37dxips8TLpofJ8oCejXdS1SgA20eT/I+KgCk+D3Ar0m6mSaO8UQXRbIFaaPXusEfcAotJwGWpTubwrWwXOvk3gaMqXE6pGNewTZAkDLZjy//ZqEA7v3C3OFzU0wqtBthRHnKQ4SJPgvQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 A9441180F919; Fri, 16 Jan 2026 13:53:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 16/26] whpx: change memory management logic
Date: Fri, 16 Jan 2026 14:52:25 +0100
Message-ID: <20260116135235.38092-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX4wm1OqAK1Jii
 JeQyVTRCe7Fvl9LA4e+W4z73rLWUr90bzj6ytC+U8X8uaThSqfIeJCJAVtUQGZhFBT6S4lk+LNm
 pJOvVRyrVDXAREsawXXiDzgkBaCZx7lOUVdC3qoxc0WsDVFKuDOChaqil1uLAzMGvgKQgpjOK2Q
 fo3EzQe6Cuf80eiQyjab05VqFvLu3hjqU+2O5OAg8KFbqXyZGfi31lyabOtyFcHzYa4sLIPf5Fz
 HorSeWySRPE4gHvbBO5A1jxIz4UXBWOlih1b23aN6L7/5klRchPKEfxLSzYJUF/mo3AVHcIf1+G
 iUbhonXzifkB7chK1O3
X-Proofpoint-ORIG-GUID: 06k2PckgwW2R64H6X8ZfrvqX0SiQ_tG6
X-Proofpoint-GUID: 06k2PckgwW2R64H6X8ZfrvqX0SiQ_tG6
X-Authority-Info: v=2.4 cv=QrRTHFyd c=1 sm=1 tr=0 ts=696a42d0
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Warxv3Xc6ASOjn9-k1MA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1030
 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABpNRb62xx8c3AKNySiCggtM/GRv121TvndpMY6aWioPbu41RpU5T9UChEOIgqB87vAp5I0TXSZuhxU6S1OSiw0BtKq7VfPEektgMYSMO6MCFcYFHT+wneK1gLLj8PAsKJr5h6rIJfI6c5Xk9p6HStWeDbbefyHb6IbT7Ocxt0A7QhGk3DnPZfaoSi9Fr5h6zIznyin5BvWSpywnKmNvEvs/DsWZeg/yo+mdXWEWAFH2myfTk0L3mvf3E2Pa0tvEw5VR+ctG4ppd4UnBSt5YV7IUtEcGGGkG7ZzgOn+kF7wtEsayBCAs+l6vgMzNwj4IkC4Tyk/XS5g4BnJfieTROec74MxhOKmG97xCwwadwZ8m4knz5Jrbw9Id+2jrqxuNzWdXwmyH/yvZUgw9pZ3vRtqdV0gAPIX6/4/SaBrWY539s8k3hEIm5f0SMtLoMiDB0osAZ+3HJqM4RLpPmSihrZVpFzqyoen04SSY/p5cZxtx6c6l12ntYU3alnQsXVN3pVnWf6A0JdAs90lZrxXwUZI3oHHOU6zcF6qufRX3CAJTJfJ9O+9WR05QrPQ5xegDfTZxoJsJqCwhtunNdXPU5nx9+PK9+bmnbI7aYauci96U6eCPQHD1vY/VBGKi6P+IpGRR5fwgL9Tfl8rLXzyG1e2+u2DahleeMvli6gdOjKxWI0w/OcUTnlZzgwz8hoZN9rLtX1MgSeknDdVLX1jAyJjencwzUEDTuSOsldVJsKhV2AURsEKvbQuYp6M+dDvL7poVSm8K0KUH+yj4hlh7+8xaPadMRiCRhNtIugBe5qwtyIFWlqFDvAV/nRYnw1FA==
Received-SPF: pass client-ip=57.103.89.30;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

This allows edk2 to work on Arm, although u-boot is still not functional.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c | 97 +++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 61 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 827f50f3e0..f018a8f5c7 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -255,89 +255,64 @@ void whpx_vcpu_kick(CPUState *cpu)
  * Memory support.
  */
 
-static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
-                                void *host_va, int add, int rom,
-                                const char *name)
+static void whpx_set_phys_mem(MemoryRegionSection *section, bool add)
 {
     struct whpx_state *whpx = &whpx_global;
+    MemoryRegion *area = section->mr;
+    bool writable = !area->readonly && !area->rom_device;
+    WHV_MAP_GPA_RANGE_FLAGS flags;
+    uint64_t page_size = qemu_real_host_page_size();
+    uint64_t gva = section->offset_within_address_space;
+    uint64_t size = int128_get64(section->size);
     HRESULT hr;
+    void *mem;
 
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
+    if (!memory_region_is_ram(area)) {
+        if (writable) {
+            return;
+        } else if (!memory_region_is_romd(area)) {
+            add = false;
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
+        hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
+                gva, size);
+        if (FAILED(hr)) {
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
+    hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
+         mem, gva, size, flags);
+    if (FAILED(hr)) {
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


