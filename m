Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9665D59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFF-00058a-Rt; Mon, 25 Nov 2024 14:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFD-00056J-9E
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:39 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF5-0004mk-QY
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so44610845e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564770; x=1733169570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oo1EgfoyArPx0QyjZUVlmbBpOKVgCXNN/Sfqm4FiXXo=;
 b=mieKa2DMzTeXllctCe6oPxhkEn80nnS3hJD8WSMTy29YMtHD8JJ9dwAZdmymZssaM+
 qkD5e/r24gdy4F/pZEeQToorGM1tXXKeQBtoPIOuFkAk6vo3Oigz2V5OyPqMJI/zhS7C
 1ytrUYN9R6rzTcpG8oYBCr51/siNIfwAE9rp4jz+bkv7wbVnz2wuGApOeI5NCFYDdHp8
 XNFdBybGT++Xld6qiwuqXpvADCsNRzWoDK+c2tKqBUlBToSSM65oAvQiOKpe90wbGG3Q
 UuIblbqYoYrAO1K+k/b7SusKUpP+HmOFRxjIM9NaRuiCWklGP+1g2IU+FBZAeX+59ibd
 bKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564770; x=1733169570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oo1EgfoyArPx0QyjZUVlmbBpOKVgCXNN/Sfqm4FiXXo=;
 b=MVT2DtS3qhxYrWpMcGzFRjJyUX8DxLkdDj+++XubxC0yzWN5/yIuSQ/w9GiWz/Ngb9
 1B7y/L1h9lSyUcyflVK1eBG5DKaUlL0HyuiAPnW31lKsY9ICCWBSSl3QHA+YHi0QCI6R
 QtqCLWFZf+eSeG6ao+frTLVxWaTrwJOtQIK6qdKk3i7cPgfJrPgZOBo+dfJj000x9qEa
 uAnHFp8SJnC7q/98JvqNkchehvB37w6ONeoTaadpoXGpJJI2l/FMiWwAJR8REgWBWfDZ
 KGSgm2DMn21bQgVkcIIvryaBXr+xyAZXFpWEeG/y4kiT934gaC5b7mE2cpsVpBMb1YmO
 lOsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3SWlpb1eHC+sKQF+2Ef3ZDJ7FDELZLdHYWWhIsjP2sNo4kbxlmsqUmvnxvyauHsy7qDbxERLoVhge@nongnu.org
X-Gm-Message-State: AOJu0YzrnqiA1iZj2/ZFaJ56tmgxnIRjfu6GhpNLarnhCWVXiUW6uk2a
 P6PSL/QW/45fk9KQpbUf7/v3q5u1lOhgtv5xE9x90SHfAqtFkPq70ahxPCxH1S8THNuFUhH84ly
 I
X-Gm-Gg: ASbGncswGzWPRTBE3cgHo6u+sa8N4OUDRZptP6186r6b5V3lT8oc1zZsdCqaG7AWz6p
 NlMdyIdglcsffVdLpMAX4PFq0D/Cz0+W/iOcy9mQkSiJDJ0orog2XwEXeObY5peq41VyNYaOYS3
 S/wChpakyfl50FwyxnKOjDhwlSXo1giLv2E3EC8Bsu6XdSNHlO5sv+OvgLWbtKfA9UQNCXoFzQm
 +ipag/llkab38nDAkNxQ1ELYwldaudL1VhMMqHg2pP5PDzZ0oGOlOV/ekcwDts3Mh66
X-Google-Smtp-Source: AGHT+IGEuG55nfDajrGEaz7M/kGNc1ktpiuJCiuV/narivEo/mrkiiTEuTAGFHtr+tUvMIFwJ0tt4A==
X-Received: by 2002:a05:600c:1f85:b0:431:5ce4:bcf0 with SMTP id
 5b1f17b1804b1-433ce428100mr134775805e9.15.1732564769711; 
 Mon, 25 Nov 2024 11:59:29 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:29 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 09/26] target/arm/kvm-rme: Initialize Realm memory
Date: Mon, 25 Nov 2024 19:56:08 +0000
Message-ID: <20241125195626.856992-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Initialize the IPA state of RAM. Collect the images copied into guest
RAM into a sorted list, and issue POPULATE_REALM KVM ioctls once we've
created the Realm Descriptor. The images are part of the Realm Initial
Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2->v3: RIPAS is now initialized separately
---
 target/arm/kvm_arm.h |  14 +++++
 target/arm/kvm-rme.c | 128 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 8b52a881b0..67db09a424 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -255,6 +255,16 @@ int kvm_arm_rme_vm_type(MachineState *ms);
  */
 int kvm_arm_rme_vcpu_init(CPUState *cs);
 
+/*
+ * kvm_arm_rme_init_guest_ram
+ * @base: base address of RAM
+ * @size: size of RAM
+ *
+ * If the user requested a Realm, set the base and size of guest RAM, in order
+ * to initialize the Realm IPA space.
+ */
+void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
+
 #else
 
 /*
@@ -281,6 +291,10 @@ static inline bool kvm_arm_mte_supported(void)
     return false;
 }
 
+static inline void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
+{
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index e3cc37538a..83a29421df 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -9,6 +9,7 @@
 #include "exec/confidential-guest-support.h"
 #include "hw/boards.h"
 #include "hw/core/cpu.h"
+#include "hw/loader.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
@@ -20,16 +21,85 @@
 #define TYPE_RME_GUEST "rme-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
+#define RME_PAGE_SIZE qemu_real_host_page_size()
+
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
+    Notifier rom_load_notifier;
+    GSList *ram_regions;
+
+    hwaddr ram_base;
+    size_t ram_size;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
                                           CONFIDENTIAL_GUEST_SUPPORT,
                                           { TYPE_USER_CREATABLE }, { })
 
+typedef struct {
+    hwaddr base;
+    hwaddr size;
+} RmeRamRegion;
+
 static RmeGuest *rme_guest;
 
+static int rme_init_ram(hwaddr base, size_t size, Error **errp)
+{
+    int ret;
+    uint64_t start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
+    uint64_t end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
+    struct kvm_cap_arm_rme_init_ipa_args init_args = {
+        .init_ipa_base = start,
+        .init_ipa_size = end - start,
+    };
+
+    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
+                            KVM_CAP_ARM_RME_INIT_IPA_REALM,
+                            (intptr_t)&init_args);
+    if (ret) {
+        error_setg_errno(errp, -ret,
+                         "failed to init RAM [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
+                         start, end);
+    }
+
+    return ret;
+}
+
+static int rme_populate_range(hwaddr base, size_t size, bool measure,
+                              Error **errp)
+{
+    int ret;
+    uint64_t start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
+    uint64_t end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
+    struct kvm_cap_arm_rme_populate_realm_args populate_args = {
+        .populate_ipa_base = start,
+        .populate_ipa_size = end - start,
+        .flags = measure ? KVM_ARM_RME_POPULATE_FLAGS_MEASURE : 0,
+    };
+
+    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
+                            KVM_CAP_ARM_RME_POPULATE_REALM,
+                            (intptr_t)&populate_args);
+    if (ret) {
+        error_setg_errno(errp, -ret,
+                   "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
+                   start, end);
+    }
+    return ret;
+}
+
+static void rme_populate_ram_region(gpointer data, gpointer err)
+{
+    Error **errp = err;
+    const RmeRamRegion *region = data;
+
+    if (*errp) {
+        return;
+    }
+
+    rme_populate_range(region->base, region->size, /* measure */ true, errp);
+}
+
 static int rme_init_cpus(Error **errp)
 {
     int ret;
@@ -60,6 +130,16 @@ static int rme_create_realm(Error **errp)
         return -1;
     }
 
+    if (rme_init_ram(rme_guest->ram_base, rme_guest->ram_size, errp)) {
+        return -1;
+    }
+
+    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, errp);
+    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
+    if (*errp) {
+        return -1;
+    }
+
     if (rme_init_cpus(errp)) {
         return -1;
     }
@@ -105,6 +185,43 @@ static void rme_guest_finalize(Object *obj)
 {
 }
 
+static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
+{
+        const RmeRamRegion *ra = a;
+        const RmeRamRegion *rb = b;
+
+        g_assert(ra->base != rb->base);
+        return ra->base < rb->base ? -1 : 1;
+}
+
+static void rme_rom_load_notify(Notifier *notifier, void *data)
+{
+    RmeRamRegion *region;
+    RomLoaderNotify *rom = data;
+
+    if (rom->addr == -1) {
+        /*
+         * These blobs (ACPI tables) are not loaded into guest RAM at reset.
+         * Instead the firmware will load them via fw_cfg and measure them
+         * itself.
+         */
+        return;
+    }
+
+    region = g_new0(RmeRamRegion, 1);
+    region->base = rom->addr;
+    region->size = rom->len;
+
+    /*
+     * The Realm Initial Measurement (RIM) depends on the order in which we
+     * initialize and populate the RAM regions. To help a verifier
+     * independently calculate the RIM, sort regions by GPA.
+     */
+    rme_guest->ram_regions = g_slist_insert_sorted(rme_guest->ram_regions,
+                                                   region,
+                                                   rme_compare_ram_regions);
+}
+
 int kvm_arm_rme_init(MachineState *ms)
 {
     static Error *rme_mig_blocker;
@@ -132,11 +249,22 @@ int kvm_arm_rme_init(MachineState *ms)
      */
     qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
 
+    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
+    rom_add_load_notifier(&rme_guest->rom_load_notifier);
+
     cgs->require_guest_memfd = true;
     cgs->ready = true;
     return 0;
 }
 
+void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
+{
+    if (rme_guest) {
+        rme_guest->ram_base = base;
+        rme_guest->ram_size = size;
+    }
+}
+
 int kvm_arm_rme_vcpu_init(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.47.0


