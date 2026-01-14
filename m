Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661DBD37E3C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg19P-00012o-51; Wed, 14 Jan 2026 08:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19N-0000rG-G8
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:05 -0500
Received: from p-east2-cluster5-host9-snip4-2.eps.apple.com ([57.103.79.105]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19L-00085K-78
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:04 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 510861800499; Wed, 14 Jan 2026 13:42:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=F9oLyg/qgYRJ/JZV5dNJO6abkXMsGF/lMhk1P5D4R60=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=O4+uEOaSqJ54hV8Z8Jed76yZLjrm1E5BZzNphkD0dli8kh8wHm2E6y8/7SXKRLeQK/9XqtPx+IpXXzx4tq6KeYTmL+9og3w7whoKfjDYqoUwArwGx5626LIY6KWzB+sIZRYK2HQ3KlKxHV1PrUnEmw54iDYOUJtYVn9UEqXgs+ahh8k0vwTViAbyJGhN2qhNIU4W7leBOQcBmkN2KX3JXjJ4fFTvbgtMDWlgx9R0gNbUKb4JBSrZD2Dg8S4RT/3VBjgewe3nNSUrY4R2R5HKxe9y6EoWOm1ngnLVocHXVeSgF2gpU6smfs9OoUKiaQBwMWUN2f4rrCvK9ufnnB9Fgw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 DA92D1800498; Wed, 14 Jan 2026 13:42:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 16/26] whpx: change memory management logic
Date: Wed, 14 Jan 2026 14:41:33 +0100
Message-ID: <20260114134143.26198-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX9DkWNfA3NUBL
 dpTwxZZTZih5xOEPtB0PJTNF4D4wpf1lKx8VFpk29NOkOBefvfz+VQKyv6renEofs+0AihsRj2x
 W7Oj6SojaY1k09I9tXQ+sAyxqKXG+YIdpzbIwA+/PiMIFe6yY7PaIbq1Epbm9rW2ZgTLqUQ8WiQ
 HlnI7sLvuvHqhLcXS9ARpZdCKZq/n/ymnDl0dnJl8Qwe1AgsIz5STakUu74owVyIHRww3ebRgr3
 rt0/i083RLYiKahOlMQGsMxESvurKtRZxiCt0zuUoYgZ0LxFuRXLdql1hwEXjNOGjxjuCSxiyeo
 r9vSJuuigJvF+dE9tKW
X-Authority-Info: v=2.4 cv=XZeEDY55 c=1 sm=1 tr=0 ts=69679d63
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Warxv3Xc6ASOjn9-k1MA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -vxp6_LJlwuT514UZo8GHiD0jc_Dxy-k
X-Proofpoint-ORIG-GUID: -vxp6_LJlwuT514UZo8GHiD0jc_Dxy-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 clxscore=1030 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601140114
X-JNJ: AAAAAAABua+KEvI1IsVWvgm6kN8ski8KYXpcne0GIpGaUHgvHrnLKPbnl85iIuo5sO1V5fDYoQuAAGRX+Abv7uS2rdg86VQ+0uf0nRGjbQs8PDzmTpPPkMrWcBaE4NZvZI9j+KwFWbKA7iKaHBlgWgjt9oxwPvTVQSpblW4rQYVDRQrIPtbzshrkMyTGcahL4zENV3vxj6dRJnmij1DU8oxr4a+02EzgY+tmpoxPXvomemlQGStZzTIPlK+KVeU7VHQf6Tsz1hA6Mt65/fGDbXAPmmyRcEf0zKgwlT5HJvxX/Na3KwmUwoGuiNTiF7kuPWlA3RtBiGrxgQXfLfP5sLssrZybcW2rBU6h6um2cu0f+RUrcVcTP8odNy3EkGV3loGqvj1tj3CVkKAy4mcn1w2g4qIYzlczXXNzFRN6keXVJtCNddVoImvoM/5yULZZ5OgVO4gwyfiqOUFMGDWJEIqT8bQ9G2QUNmhogyyse11hn9/8g+J4rCQykfqFKyxaJzVsKsDPvr2hymnmjyi3EgsETzYDmF+RRyWoixUVPGosdjAzm9kvUbh9igCilEv5T5JAIhdluqHpHawvIlrN5Eo5RRMvFb+VNn83/hDg0Gbm7sL06CeNQj0XhSAsmQjjEKpRZQPJXyUwqUcQ/L3Vslw3tNTx0C1BhCl89bW7hUz3EIwdFDE3kqPu04QJkui6CzCaQkg6QYC+JTusPfce/FN0cZg1HqV5bpaAa7Opvry6/WdNNhdodDk/Vb2C0P6xlNFxnUKxL2DymzNC+pOrpj95hCBQYo0EQUW4PDG+yITOzj8KMSC8G2Te/H+Z7+hPmp4V2YKJsbJBxCPbfVF1TEVfWcE7dwIMRHPCyCxi7yiQr2+3gCS5g/kONzW+aQe1O+InjDufoWIlpd0cCn3wFUiIsYe67dnPiG026JkczWj6pNcd+w==
Received-SPF: pass client-ip=57.103.79.105;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


