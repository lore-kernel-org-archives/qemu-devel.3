Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633D6E94104
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNGE-0008TJ-Pg; Mon, 29 Dec 2025 19:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFC-0006xR-Od
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:46 -0500
Received: from p-east2-cluster1-host8-snip4-10.eps.apple.com ([57.103.76.83]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNF8-000421-Fo
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:46 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 9EE5E180044C; Tue, 30 Dec 2025 00:05:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=F9oLyg/qgYRJ/JZV5dNJO6abkXMsGF/lMhk1P5D4R60=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DIIKvwXG5ZNR/DEyn2lV3hWwp19tiecfIQY7oCgQx48UbL9l9e78/r8Nz3kskpyex0dNU4oDWpUKgUGLavw6hgx5HDBO36OWU+pEb/u7SJ2MSd+5Uv7GGzV9NOoE1Svk929Bo3znJ5Hb+06JqAZhL6tqPyNa67Yw2B7dLXzHfiqtzinFSn6cSvWOYi4BJFhP0YEbwx8MhEcn6MuHT8FG+2I/St07WIDgorDSuU5yQRCG9oVoQBeUoZcTLjG0gQf0Soif/zD/5OfJrU4fnq90grr1RyKw9k3O4XVw5d0iMaUJXEX5PNJY5+XJ0FFNbPPx/9sm3jCxr0oQH00RSkJLUA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 DE0551800444; Tue, 30 Dec 2025 00:05:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 17/28] whpx: change memory management logic
Date: Tue, 30 Dec 2025 01:03:49 +0100
Message-ID: <20251230000401.72124-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=Wqsm8Nfv c=1 sm=1 tr=0 ts=69531753 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=Warxv3Xc6ASOjn9-k1MA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX7DnE46JFnNa4
 n2EI9XVD66Sg41ps/H8Updo0j6KhOfVMKPcdmabLYybPBH9DyufWE0dIzMy5gTNJuoalfBR2WLF
 5FCpF9VbhHZpbEOoK04lhKG6W72ygrQ7BZFKHUY0cRUdBx36ymKBu2+w6qk4ZX9gbwvYCOg5rWF
 qqxQN5mVNaIxDiAt8vpGkjaLfaZ8N1e/zaWaqQlsTQbMhnV/vPEEsOkIfoIahd7Ei1jluvbIZNQ
 r6pfXLmN6XmpQmfxHA2iIxVrK9GOD4oiTdpvoZNrQ1I8ErBj1vEyoNoPpu/sKgCX+NGsmH/OzcE
 ZsuFFoJmw2U6/oRHlQ3
X-Proofpoint-GUID: zhUu8P3i9JInvn7ln0RqTTo9F0mlNQlH
X-Proofpoint-ORIG-GUID: zhUu8P3i9JInvn7ln0RqTTo9F0mlNQlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 clxscore=1030 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAABrS2aNxATCOekBfjdaFRZP5xhfk+c5PkoVsy82gYqGuawpPXvkTMtgXLz4tACSBg6PB6m7HDfu6KFlgBPeQM//QlhjJplnyY0UqR5toYtv3vTEYEwx3tBDeFpGVaWDm2Gpt14SncCt051MnzyOZYVaMvh+fTsRaZfNKdHbgLdvP2GDWk3dHnsazQgm18B5x70JTUhhy//RxcNIkTWcO4DUa1GjZs9f6IMJujqZ6UxIrHBQtNbaunMPSiB8TjKVyoPw37B7w/hV5ohzrHKjuqUIcR55B+nogq1md9RwaAf7XBEC+hx+DPX9Y9i2qyh0QTKI6eoNxM6cYobXWHzUpY4sTAQ8W3Af4m84t3vfavLPZbgKl62O/0LSBSkZ1RcGtaE5+xz/cQv6ywoef6GVLrH+8MjIYQRN6v6huPiI2+73f6DV9mAzemCr3MVOWYi4kOhcvdkX7gmkEP/7YOyjOetUjOiX7KWHNf3SDbunRHMxbdalaWUNly0ItI7upShC7DHsoIg4NhDB36Xb3aZDcroRSfwXjt/BZGQJgSv5Akfcc5l31BDpEoeApE+t47EF28S39TScNPOuBITQY6BFryR1OulfQ+Xqd09qEcJVbZ/PxSscUEWdgihyKJkIqRHdj4rjwet0KL+vSi67a1t1q92a4wDprI+y1yewlhWOcH2iWQ0TqbVhlfs9SllR2jM0x5OBrN2F942vQzLSWiSOSTo51a3saEOIdY0T+ddVrjuU5JTAhSVoTD51q5VetMv+LNU+GnL2CMBt1YxQGB1wC0/1n1MJ/LxWl7cO34VmtJ+i0bqB01WPLIClkqSw3A2NBjUR6z/JL8LDzHjvkteZELfoWX3ye1mJD4axDnCz3XG6RoeJRWb72H9/MrVwxfJJvsd5rZENR85cv8FBu10tR69w3EMWOixGMqAkdh6D1liJM/GF/T0dJU7S/MwDBq0/vc0K/YDsFPG1Q==
Received-SPF: pass client-ip=57.103.76.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


