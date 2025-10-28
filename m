Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6975BCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtQy-0001uK-Rx; Tue, 28 Oct 2025 19:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQw-0001rf-MN
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:58 -0400
Received: from p-east1-cluster5-host9-snip4-10.eps.apple.com ([57.103.89.221]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQi-0004mI-BY
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:58 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 3E9FE18034DC; Tue, 28 Oct 2025 23:48:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=xJAo1UBdZ8OCZhRCAjdQFGpLMCFJEpy5JZqSAAb7aX8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ln1tMnPrK5/NRgrNkfm0bYHSY/i6GTow3+WuSIl9gAzqRMaOYpE3Dcny6WoEAnMbKnTdgb00GKgppLPBgZ6uaiD8+XaFdC85dYJe/RrrHgT4cx0rcQtF2r/42mqV0bep3GhL5Fowt9IA7C9hY36iPt1DoY5fEWE/VIRyWrhMgglV1Xgb8HfPmr63vYhvFrn7TXs/XActncYTPMxbUFo/WTrSKzM9qlx64B3eRQqYJXmygzsAu+I+oAZtbIS2QwOqWP6kS+ESVYK9ijZtaZ1CospcOyZSroMacDLERbeQPRt3lDs5mE6SvEP5Mv9wf7A3KfIvZab/nhOOYprDRd4nKQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 594C418034D3; Tue, 28 Oct 2025 23:48:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v9 13/27] whpx: change memory management logic
Date: Wed, 29 Oct 2025 00:47:43 +0100
Message-ID: <20251028234757.39609-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: x4QXeZW7MyEX0WcF2SNhyG3QQkhstZri
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfXwjbk6n7cMpLB
 PfQal5MTFAPXKLCtkFpwmoJeLHist+zctmqbHm9nNJDiG5kV+QFrh/WKnAZ9JmUbi+9Q51hRzGq
 jgNT2XatqqRNTh//azxd0RqRXRY6gHfoAASKqYe4g2L0RRCsr9aXOoLajZ+pAQbzJ56okA0flqt
 KOclNBVL6a1gCACW3q24K2Un39Csu3j9RjQ5Q4JlJRLZ8WtaJVvce+YBHrEL0Z6Wz8K7s1D69fM
 uro3aFNamdLdamrkQ9kjWIzhKnDlMtCEWDq5mq1781jgvtngVjFliJ3Mk77Dwy++WMVdtzZrY=
X-Proofpoint-GUID: x4QXeZW7MyEX0WcF2SNhyG3QQkhstZri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 clxscore=1030 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABrYUH3zYGMERuXStUSEs+TzZYPWzcDD0AGGib0p0DtZswi93nY5eAd4tJbxtPVbULIQabD11+FadwJlttA19EuzfWBONN+vV2X0xS/iN5wavst9KiyOKJmJCeFkT9Coc/3SDZQNQk9oQYA8RcXELMnOX1cUbBf4wGaL9BIDM7uZ9gC407cOnePmO5ylqfpzR3n75NcDRPCOzFCpvoAJbxWHR/zLrw5/u7hqag1VQ1jus+HjVuyyEXK9mHgqdIMq3ReopZXmsWbknLuknn9rvNKAinToqMmPYUZVWz+xdEa2YUARnANl34Pl4BWWlmdExWhW1qWQWxdgW4AOjJ02wP12Z9UcKsP1DKdBflR+fwuTef1mwOGM1B6Ko4SlrXeVkbLbNYsMLtFdB1CQXYvqWVwhVbE48QpFe+DmQD7zZNvp4B54gIpYJGbz79TQXaYWj+QsDKwMvDDpakaYiATT4bbVoVYV1nuD2HPF6Q4tgNS7s0bj1gp7zKgtZtoteTwkrKW4MO2qMtlNNVPz6aDtEkpgGgRDUrUPL8q/GjYbHM8skQPmvryiC6KsWHF7GpLPRTbCAWmUw3Ni6KfFYUzeBFx9ILex2CWmXR5wNy6S0qHo7z/FR9P4gs9pyMjvnhTD1lwTnSHxnMOizDckP1bQ6ozQmdKtaMhH52VYVqCDAejVzgkcQ/HSWYR8LYUkNjH2SAkiaEkNoBIVth67ZQNPpgj8P05jot5Ot8gfC9bGhLo5HSNocQGt9AxHvYqg==
Received-SPF: pass client-ip=57.103.89.221;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


