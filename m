Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70704D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfMw-0002YL-WB; Fri, 19 Dec 2025 13:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.k1so4a3w5m3rck1=p87iyfidqkxo=yqm6opo5m62z1l@em483429.getutm.app>)
 id 1vWfMp-0002Xo-8A
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:38:20 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.k1so4a3w5m3rck1=p87iyfidqkxo=yqm6opo5m62z1l@em483429.getutm.app>)
 id 1vWfMm-0007f9-Dz
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766170385; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=kvTUUaMn+jLgW1Zko42A5PWt3BGWZ2R66E4H4FDBLzc=; b=jTEJoNVnf6N/zo3ax4jUpxt+TM
 rUJGim5vvyOlG9meFDV3ixZJdW43/cWawr0GUd1k71h7p1lVo4RN4Eou7aJSmx4lBs/MQQ9O6RmxS
 oErm+odnknT8LzNQ8+SqQIZNbIEYkYSsvaVdQQDA2RkLUjrZHEuq32Z/6QG9Ab1PnI+p5oxtAPQ/t
 clzsQUBsv1gKuGBUYtDn0myFL0l8tvdJLerqh6nLrcvq6Pdo1cbn1jHhCPBEBqXF/F/Q0tEPSPHS8
 r19FFK5mCrx0fjuDpR+mqExfUUQH2YmDX8uKPn7VmM9yCCpxaSccbKH8Yi9lwdTROX1nUosJ0u3fZ
 5GthZebw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766169485; h=from : subject :
 to : message-id : date;
 bh=kvTUUaMn+jLgW1Zko42A5PWt3BGWZ2R66E4H4FDBLzc=;
 b=FZ3dC9BtFbQgx8DfzpVw4RxgqYvZh0aoK2Ih8UravJKBu//t13GqFeJqMWUxoQ2QtFbfk
 W0fI0akWnzIkuDzrCkYtKCTZiVDW9a75FSlvviHlrFbc0xGuA3yU67OlLFB8E3v2lxN7sLQ
 s1jq6Rb8FZS+H27wTmfDaD+kcS2FmWtSlK1fhojguzCrbEo2W3RLOf7vi+n1fTE/YboK7+3
 z6Efh0eX8fTMWUEUxfu1L0YqyRCmtEA+mfq0Xo1S05b3YONL+aUkgHfiOJtsVnQ4n7bbqDs
 2wmnFl/y2qOlcApJ1CwUIz8VuBLsEFYZM5bQ1+42Os2SNRee9Xmu+kJZ3TXg==
Received: from [10.172.234.246] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>)
 id 1vWfMX-pH9Upe-B9; Fri, 19 Dec 2025 18:38:01 +0000
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vWfMV-AIkwcC8uj9p-5OS2; Fri, 19 Dec 2025 18:37:59 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH] hvf: support changing IPA granule size
Date: Fri, 19 Dec 2025 10:37:15 -0800
Message-ID: <20251219183716.4379-1-j@getutm.app>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: AuI25QJCS2cQ.MbuHYUEL1UXI.mnnaVQEFPy8
Feedback-ID: 483429m:483429abrvJvs:483429sngI8vWHXA
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.k1so4a3w5m3rck1=p87iyfidqkxo=yqm6opo5m62z1l@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The IPA granule is the smallest page size hv_vm_map() support. For Venus, we
need to support 4KiB pages. macOS 26 introduces a public API for setting
the granule size. We can only use this when compiled with macOS 26 SDK and
run on macOS 26+. Otherwise, we fall back to an older, private, API which
achieves the same purpose.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/system/hvf_int.h |  4 +++-
 accel/hvf/hvf-all.c      | 42 ++++++++++++++++++++++++++++++++-
 target/arm/hvf/hvf.c     | 50 +++++++++++++++++++++++++++++++++++++++-
 target/i386/hvf/hvf.c    | 10 +++++++-
 4 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 1d2616595cd..881e16e31b6 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -63,6 +63,7 @@ struct HVFState {
 
     hvf_vcpu_caps *hvf_caps;
     uint64_t vtimer_offset;
+    uint32_t ipa_granule_size;
     QTAILQ_HEAD(, hvf_sw_breakpoint) hvf_sw_breakpoints;
 };
 extern HVFState *hvf_state;
@@ -82,7 +83,8 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 #define assert_hvf_ok(EX) assert_hvf_ok_impl((EX), __FILE__, __LINE__, #EX)
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
-hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
+hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range,
+                               uint32_t ipa_granule_size);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index a898359777c..7ebfc9bbe58 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -17,6 +17,8 @@
 #include "system/hvf_int.h"
 #include "hw/core/cpu.h"
 #include "hw/boards.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "trace.h"
 
 bool hvf_allowed;
@@ -152,6 +154,10 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
         }
     }
 
+    if (hvf_state->ipa_granule_size) {
+        page_size = hvf_state->ipa_granule_size;
+    }
+
     if (!QEMU_IS_ALIGNED(int128_get64(section->size), page_size) ||
         !QEMU_IS_ALIGNED(section->offset_within_address_space, page_size)) {
         if (add) {
@@ -316,7 +322,7 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
         }
     }
 
-    ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
+    ret = hvf_arch_vm_create(ms, (uint32_t)pa_range, s->ipa_granule_size);
     if (ret == HV_DENIED) {
         error_report("Could not access HVF. Is the executable signed"
                      " with com.apple.security.hypervisor entitlement?");
@@ -340,6 +346,34 @@ static int hvf_gdbstub_sstep_flags(AccelState *as)
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
 
+static void hvf_get_ipa_granule_size(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    HVFState *s = HVF_STATE(obj);
+    uint32_t value = s->ipa_granule_size;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void hvf_set_ipa_granule_size(Object *obj, Visitor *v,
+                                     const char *name, void *opaque,
+                                     Error **errp)
+{
+    HVFState *s = HVF_STATE(obj);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+    if (value & (value - 1)) {
+        error_setg(errp, "ipa-granule-size must be a power of two.");
+        return;
+    }
+
+    s->ipa_granule_size = value;
+}
+
 static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -347,6 +381,12 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
+
+    object_class_property_add(oc, "ipa-granule-size", "uint32",
+        hvf_get_ipa_granule_size, hvf_set_ipa_granule_size,
+        NULL, NULL);
+    object_class_property_set_description(oc, "ipa-granule-size",
+        "Size of a single guest page");
 }
 
 static const TypeInfo hvf_accel_type = {
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index de1e8fb8a05..7c44325ca64 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -12,6 +12,9 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include <dlfcn.h>
+#include <AvailabilityMacros.h>
+#include <TargetConditionals.h>
 
 #include "system/runstate.h"
 #include "system/hvf.h"
@@ -880,7 +883,45 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
     assert_hvf_ok(ret);
 }
 
-hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
+static hv_return_t hvf_set_ipa_granule(hv_vm_config_t config,
+                                uint32_t ipa_granule_size)
+{
+    static hv_return_t (*set_ipa_granule)(hv_vm_config_t, uint32_t);
+    uint64_t page_size = qemu_real_host_page_size();
+
+    /* macOS 26 introduces a public API for setting granule size */
+#if defined(MAC_OS_X_VERSION_MAX_ALLOWED) && defined(MAC_OS_VERSION_26_0) && \
+    MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_26_0
+    if (__builtin_available(macOS 26, *)) {
+        hv_ipa_granule_t granule = HV_IPA_GRANULE_16KB;
+
+        if (ipa_granule_size == 4096) {
+            granule = HV_IPA_GRANULE_4KB;
+        } else if (ipa_granule_size != 16384) {
+            error_report("Unsupported granule size: 0x%x", ipa_granule_size);
+            return HV_UNSUPPORTED;
+        }
+
+        return hv_vm_config_set_ipa_granule(config, granule);
+    }
+#endif
+
+    /* older macOS need to use a private API */
+    if (!set_ipa_granule) {
+        set_ipa_granule = dlsym(RTLD_NEXT, "_hv_vm_config_set_ipa_granule");
+    }
+    if (set_ipa_granule) {
+        return set_ipa_granule(config, ipa_granule_size);
+    } else if (ipa_granule_size != page_size) {
+        error_report("Failed to find _hv_vm_config_set_ipa_granule");
+        return HV_UNSUPPORTED;
+    }
+
+    return HV_SUCCESS;
+}
+
+hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range,
+                               uint32_t ipa_granule_size)
 {
     hv_return_t ret;
     hv_vm_config_t config = hv_vm_config_create();
@@ -891,6 +932,13 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
     chosen_ipa_bit_size = pa_range;
 
+    if (ipa_granule_size) {
+        ret = hvf_set_ipa_granule(config, ipa_granule_size);
+        if (ret != HV_SUCCESS) {
+            goto cleanup;
+        }
+    }
+
     ret = hv_vm_create(config);
 
 cleanup:
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 16febbac48f..395e13f467e 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -225,8 +225,16 @@ int hvf_arch_init(void)
     return 0;
 }
 
-hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
+hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range,
+                               uint32_t ipa_granule_size)
 {
+    uint64_t page_size = qemu_real_host_page_size();
+
+    if (ipa_granule_size != 0 && ipa_granule_size != page_size) {
+        error_report("Only supported IPA granule size: 0x%llx", page_size);
+        return HV_UNSUPPORTED;
+    }
+
     return hv_vm_create(HV_VM_DEFAULT);
 }
 
-- 
2.50.1 (Apple Git-155)


