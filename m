Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF54FD88DF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09IZ-0000fh-Ce; Tue, 10 Mar 2026 22:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09IX-0000cI-Gk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:27:45 -0400
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09IV-0003t0-MF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:27:45 -0400
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-128e3125372so517312c88.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773196060; x=1773800860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXwwiABDq8rPzJnL1JUdTxpV62wLUq0WTiy3Tyw5lEg=;
 b=cMckmbEYxoTOwQXzPfancI+xVFDnkB6C0h04ougu2aYf0A/yvr8jPMR5uvkAd0tbAn
 wBpuDNQHXZ/6XeijgnrPH7hqFwRlOHbgNJgn+ML9MC0LnNhneTUxJ+KH4PY/U1SAlzPd
 T5cnOIfGb2S5+EtH2Q5O7GwoiMe853Mtd/c9GL9FT6PRkbmXYKEtbpsqECHFBe+TrCOH
 9/VcoCFgIOG5eoYJCi4J8zBXL47zfX08J8d9ZqbIbXYTjy30HT7USHKWphWYdJYINwhG
 tOP8eKPPSnM4QNW7RW2HanV85F7NTkW2BnvSIQL9RPrad6jqiI5M7ZnZ9QO6z3iVp1Wc
 OzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773196060; x=1773800860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EXwwiABDq8rPzJnL1JUdTxpV62wLUq0WTiy3Tyw5lEg=;
 b=GLcAKM6/z35iw/Yaz633Mi8WIscPxmq68HbdUJQ+lBTY4keMdUtJqBzQt5PJG2Sg+3
 /Uh9GwnGtGc33AR75vHVdyNvF2SxaunnG2GRhplLgIqQieAamb6GlRmzdyK5397niJsl
 pGhjjMoDk9mGFt+t40XnifXC0NSIY5Rya5B9JETlwxSNNqPZX+GeatQ94xKLzPxYKOaK
 ix+4rZ4FI+v7QWpSJNtL+Etjer3OoI0rb4OtyuWZScTP7lXDmWz+dFI0ka9jmsdb6q1g
 ZR7n3HOvw+VqAkkdCXMrUsFKudl7sJMBVch9XskTVIeLKVELCnocI+9COJdvJGTooE7v
 bgkw==
X-Gm-Message-State: AOJu0Yxb/3gtr1RacmzrXTMGD++C1wdIAY1yG7x1C/SzxAdjuRG34WCC
 mF4AsP2YbqgtmFupAruRqC8cRz22Hl97mvzFn3XYAwYSNz9xgmLXkjwtWSR2wQ==
X-Gm-Gg: ATEYQzw0latx9kVonzYh2uBS8/msG12oJC5yskgZHpPoUx4lUCirPIM3XPa80rhF5EV
 IPN2Wc+EUX7WUq+AZI1FO5zzeTNzbv1ReJSzEEoNk6I2nBIkahAKpgBzfU5yIggRrJibZBSZKyI
 syr/out1YaTS2hVurKYGkcAbXoSTJzEcOfYSJTfUI/hz37oDuwAU2S2J3RzkHZ2tJYPRHK2WwpC
 24U2LFIRhYy6k+kA9A4xNByeQ7Lp5ng/0iNF10bvigfzRvxoGeftK8as4SUW6xrrXmq63mtNGrg
 eF+Mgiw1ulkzRedNaqIXCrQyHWo0n0YtWS2BbFJ6dkwsuvOVLM0lF0yxlBFVJ6zI8/LZ70fWYxS
 SyXVPNSl3Scu/dta76qr/5DvF9vBcBkgdcSZrA8gRZYnhjalj2KL/KZE+Mbrdd+p9fGmtPoi/Qi
 myxYjbTc4/dtkiWbZC4lWrOUw3UyLsnpFtjStXjaFj8TGbhyC6msw=
X-Received: by 2002:a05:7022:e28:b0:128:cdb7:76e1 with SMTP id
 a92af1059eb24-128e7a2f765mr320314c88.13.1773196060236; 
 Tue, 10 Mar 2026 19:27:40 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:80a9:8ba1:b664:ae3d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128e7bf1e1asm937039c88.3.2026.03.10.19.27.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 19:27:39 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v2 1/2] accel/hvf: introduce map granule abstraction and IPA
 property
Date: Tue, 10 Mar 2026 23:27:31 -0300
Message-ID: <20260311022732.64141-2-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311022732.64141-1-lucaaamaral@gmail.com>
References: <20260309214906.92578-1-lucaaamaral@gmail.com>
 <20260311022732.64141-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x122f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace hardcoded qemu_real_host_page_size() in HVF memory mapping
with a configurable map granule.  Non-aligned regions now return
early instead of proceeding with add=false.

Add an 'ipa-granule' property (auto, 4k, 16k) on the HVF accelerator
object for aarch64, allowing the user to select the IPA page granule
for HVF stage-2 address translation:

  -accel hvf,ipa-granule=4k

'auto' (the default) resolves to the host page size (16KB on macOS
ARM64).  The actual HVF configuration is handled by the arch-specific
hvf_arch_vm_create() in a subsequent patch.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 accel/hvf/hvf-all.c      | 67 ++++++++++++++++++++++++++++++++++++++--
 include/system/hvf.h     | 15 +++++++++
 include/system/hvf_int.h |  1 +
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 033c677..d94926b 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -10,6 +10,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
 #include "accel/accel-ops.h"
 #include "exec/cpu-common.h"
 #include "system/address-spaces.h"
@@ -23,6 +25,21 @@
 
 bool hvf_allowed;
 
+static uint64_t hvf_map_granule;
+
+void hvf_set_map_granule(uint64_t size)
+{
+    hvf_map_granule = size;
+}
+
+uint64_t hvf_get_map_granule(void)
+{
+    if (!hvf_map_granule) {
+        return qemu_real_host_page_size();
+    }
+    return hvf_map_granule;
+}
+
 const char *hvf_return_string(hv_return_t ret)
 {
     switch (ret) {
@@ -54,7 +71,7 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 static void do_hv_vm_protect(hwaddr start, size_t size,
                              hv_memory_flags_t flags)
 {
-    intptr_t page_mask = qemu_real_host_page_mask();
+    intptr_t page_mask = -(intptr_t)hvf_get_map_granule();
     hv_return_t ret;
 
     trace_hvf_vm_protect(start, size, flags,
@@ -84,7 +101,7 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     MemoryRegion *area = section->mr;
     bool writable = !area->readonly && !area->rom_device;
     hv_memory_flags_t flags;
-    uint64_t page_size = qemu_real_host_page_size();
+    uint64_t page_size = hvf_get_map_granule();
     uint64_t gpa = section->offset_within_address_space;
     uint64_t size = int128_get64(section->size);
     hv_return_t ret;
@@ -105,7 +122,7 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     if (!QEMU_IS_ALIGNED(size, page_size) ||
         !QEMU_IS_ALIGNED(gpa, page_size)) {
         /* Not page aligned, so we can not map as RAM */
-        add = false;
+        return;
     }
 
     if (!add) {
@@ -187,6 +204,11 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     int pa_range = 36;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
+    /* Resolve ipa-granule=auto → host page size */
+    if (!s->ipa_granule) {
+        s->ipa_granule = qemu_real_host_page_size();
+    }
+    hvf_set_map_granule(s->ipa_granule);
 
     if (mc->get_physical_address_range) {
         pa_range = mc->get_physical_address_range(ms,
@@ -217,6 +239,37 @@ static int hvf_gdbstub_sstep_flags(AccelState *as)
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
 
+#ifdef __aarch64__
+static char *hvf_get_ipa_granule(Object *obj, Error **errp)
+{
+    HVFState *s = HVF_STATE(obj);
+
+    if (s->ipa_granule == 4 * KiB) {
+        return g_strdup("4k");
+    }
+    if (s->ipa_granule == 16 * KiB) {
+        return g_strdup("16k");
+    }
+    return g_strdup("auto");
+}
+
+static void hvf_set_ipa_granule(Object *obj, const char *value, Error **errp)
+{
+    HVFState *s = HVF_STATE(obj);
+
+    if (!strcmp(value, "auto")) {
+        s->ipa_granule = 0;
+    } else if (!strcmp(value, "4k")) {
+        s->ipa_granule = 4 * KiB;
+    } else if (!strcmp(value, "16k")) {
+        s->ipa_granule = 16 * KiB;
+    } else {
+        error_setg(errp, "invalid ipa-granule: '%s' (use auto, 4k, 16k)",
+                   value);
+    }
+}
+#endif /* __aarch64__ */
+
 static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -224,6 +277,14 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
+
+#ifdef __aarch64__
+    object_class_property_add_str(oc, "ipa-granule",
+                                  hvf_get_ipa_granule,
+                                  hvf_set_ipa_granule);
+    object_class_property_set_description(oc, "ipa-granule",
+        "IPA granule for HVF stage-2 translation (auto, 4k, 16k)");
+#endif
 }
 
 static const TypeInfo hvf_accel_type = {
diff --git a/include/system/hvf.h b/include/system/hvf.h
index d3dcf08..d1b702b 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -36,4 +36,19 @@ typedef struct HVFState HVFState;
 DECLARE_INSTANCE_CHECKER(HVFState, HVF_STATE,
                          TYPE_HVF_ACCEL)
 
+#ifdef CONFIG_HVF_IS_POSSIBLE
+/*
+ * Minimum alignment for hv_vm_map(). Returns host page size (16KB on
+ * macOS ARM64), or 4KB when HVF 4KB IPA granule is configured (macOS 26+).
+ */
+void hvf_set_map_granule(uint64_t size);
+uint64_t hvf_get_map_granule(void);
+#else
+static inline void hvf_set_map_granule(uint64_t size) {}
+static inline uint64_t hvf_get_map_granule(void)
+{
+    return qemu_real_host_page_size();
+}
+#endif
+
 #endif
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 2621164..4c1caba 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -38,6 +38,7 @@ struct HVFState {
 
     hvf_vcpu_caps *hvf_caps;
     uint64_t vtimer_offset;
+    uint32_t ipa_granule;
     QTAILQ_HEAD(, hvf_sw_breakpoint) hvf_sw_breakpoints;
 };
 extern HVFState *hvf_state;
-- 
2.52.0


