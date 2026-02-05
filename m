Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCFBEA795A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1F2-0004kP-Gw; Thu, 05 Feb 2026 10:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1Ey-0004V0-RZ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:56 -0500
Received: from p-west2-cluster3-host4-snip4-3.eps.apple.com ([57.103.69.16]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1Ew-00023E-Md
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:56 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 EB1E518003D4; Thu,  5 Feb 2026 15:25:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305153; x=1772897153;
 bh=KaQ368BT2+kXLDF2JjCqdQWANc+K5Nc/lcLx70881Os=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Vh4drsK+FsUMc8xKhLf3DJij01tcdjxQ2a8SNTQ+yPDqikItpJCDp5QXt4YLOvxFAJ/jA8UWdoE3XkFD7pRwh5/A+5d0cc5F3D7OFSFGBKJgpVjA/sHKzl+YUM6o9DqzWvFGRPr07uQBHv9gYJ7TSY/2Dti66th/foT6jpHUkOVd06NIfB5iwVSRvx3QF4iRBBANY2V2Y/sWAgZO0MdJ6pq4OgU+qx/OoBz9d6jrwktv6oVt7Bw67XKiTSpYY47E+MyAFBYSNNN/bkqSKS8Ci6WNVcBpI4I3iYkJo2NSCbVq7YmKLNXyU+cublMQwo+Xg0EBg5wlmYoK0A2YKmBJNg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 2348F1800748; Thu,  5 Feb 2026 15:25:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH v22 15/22] whpx: change memory management logic
Date: Thu,  5 Feb 2026 16:24:18 +0100
Message-ID: <20260205152432.78208-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=S+nUAYsP c=1 sm=1 tr=0 ts=6984b681
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=Wq2Hhhcarr-WV7vA_m4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfX3e+u17hg6Mim
 CH/kOJcxQyFkv5MaP6EneOw+ZzIOBi6nTTmeY/UlCZVQiCqFcwo9japgbXDlyTaSyzUpb7TerBP
 /a1RVU/M8qGHLTh3e7gQFLHOKv9Spgmt+uGqs7ukwm9LRxm5iP0FBFxeSPFsLVgX5oONSEGczAK
 768Khs2iJ/VnBdYyvxRjr9ESj7kGfRcG303n3EfOOwfb0Jm0HjSjVpMRYIJ9ZmQTSpjKYUzu3cu
 iZKait5jrxUs+O5ZhwgmVeiORF1poyxUbJi1eSb8SYGihSzRE+/bUEmGBqWj3XCrVyhiafHSaHk
 W7pTBjeGjr2F1iBmO8XMZBU3Mb0WsLIZpIf8scHVQiqt6+pRXMYOeNPjdbp9YY=
X-Proofpoint-ORIG-GUID: VElVE9w0Fzdwh68Y9fSuhpLzRsM19z6s
X-Proofpoint-GUID: VElVE9w0Fzdwh68Y9fSuhpLzRsM19z6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1030 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050116
X-JNJ: AAAAAAABW5eGGfCzO5Hanj+MLpoW6FrAj0zPwjA/KLB5CjTk9ocUX6fK94enOBh1EYvPUvXsauI5p/AknO3NaJPJvmkGZbrtj5mvKTfcssm6MyndJXvq5JMTLsWAv/rVOnVMkiBjBagQlulRA4e1aQcIE9nx60PQlfZkiAbQuVU0w+eJPhrN0loe21uZn2AxKCr8iIZTUxxqpxaEWquHGBW7dzSGBmU6v1DO/SNV1PpAuLOAENwudUyIQGW16Sk+2Kt3AwiacHHqy8QnxDmAOY0JXIdPdsDRjWtL+YGpe1lLjU3nc4uydTXuwkS/HydWg1HLYDfiQb4uV99FtgbmEvw/zD8dnNdTAgBQEkTDKEMx9Hbed/+N9/+nqScHr2qB3O5vU9Inu0/vfW/tZDJwbqeQN/49iz3mLb4FZ4b6P0VML7lpiaX9FGhKX5o2waMkObGk0cnEYudtGWH8oorEj3uBO22LBdl/zyH70Diw0VOQHZAbuCRIm1MtNi4VV5f5C2N18no2CrFsUnTLe8n2E27VtOyy929MVI/szmdo1aikivZdf221LIdszdHwilJuMq+QvrOxD+hks+tsxH8vbsUv6/9ft54YQFktNWwhTVLaqYkN42ebhzVB5HTsYluJ7Q3IrilVRgxzBwt2Xez5nHMQ+xmT1EcJqYpqPgNFhgB7VDDuzz/r1Dm/gTdGgch3vQXDy3BUTvyCxrZYw8Pz8fOIKSpaOyhpw3QEtShWeDGMEyWIb4+MS6vPFrZelXIggGroYoHYkDSswUrkcr7j7xAIahHGZEJt1ivxTy2VMh6PSGyxSnORf8lE9iG2qB/GCly3OGKTAYqKf6FjlNynlCJCMFlLkPOtl/+lKZwUyOveh1ocZqOcydYI5obtOZSfMC8misoMDR9O/31V6I6BuObQWWWw7oykdgob7GWeXqqY1KdWtZTLKcT+QPMLsmu/audM/LM=
Received-SPF: pass client-ip=57.103.69.16;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


