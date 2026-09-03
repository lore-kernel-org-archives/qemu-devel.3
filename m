Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BA0C624DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEj-0001RV-If; Thu, 03 Sep 2026 15:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEh-0001Oy-62
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:35 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEf-0004Bp-Dh
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:34 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-39b24d114d4so217047a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464191; x=1789068991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6yAZYi7h64i0sOWTrsMVth4dHq383ltCyuAo47L2qv8=;
 b=rh6nwpAhUZvMQRRojCOpzAUZQ0QypeJLtPMuN9k3EhIUroQtxKVSbrRDN+pRar640w
 OdpGBHm2XiOAxwadSWxWhQhR4lnXe9aRLHus3bZAzIvWoWbSGUZ90WHzh8N7wlKDvUcI
 lomPKdO21KkgNsJBcESpwGyx0pN6EC5nWb2r8JLdQhVkPCh+YgsvuDITsI7wYDZsMO/m
 aDqpQZylVZeC6fmSvOJEJcGX2dfaC7AdUnnAnnDnRtz1qzmva0dVbihO144oeDc7yA0s
 ZZgadDAX+UaN+NQCF6MciNWNiUj9dqrl05ZqQBftznM3d59bkpBv3oZbs9Gjp7ynntBa
 37fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464191; x=1789068991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6yAZYi7h64i0sOWTrsMVth4dHq383ltCyuAo47L2qv8=;
 b=SlKipRj2sFISZYhsuD5lEURroUKXWtT+e3UHdalN12YcmabtHM2Z1Nuw1ihPxdQcTX
 /BD9SaNVLCeZ5QfdhVEfhUweqYVQLBxf7wBvIWQBCGm9ZZts1YkCSeFadwh1UcCikrrt
 DquuTLZ47FFyx+Wc4Xcj3PsUMFxpF4E2PHITNJ2Nsj/FcdMxBTCXFUSwUR5NQYcAOm6l
 Zu9DfaWePdDarHnsy3UYo3hoyCCxqh8u2tXn1HudxitFlWfV7jNZEwFDklUnYos4FgDz
 F/DRqwUoKWzd6XJpqfQbpAQQbq32H17s4QhqoaN4/aWxcr+Ls0B+sJOfOblHWNLuCzs1
 KJjg==
X-Gm-Message-State: AFuF++nnpY+7re0RGdYIboskwkCyiksWK2w5CH6WRF0Eck2PypVz8Rtp
 VFyywsdUAz54oYlll3Qpf9GADWFCtjZ/L4kP9aGZcs+4qqtU7VQvrO46aJYmGwFOnTw=
X-Gm-Gg: AYBFou37f2pW4vEVtxK6eyoKbft08M5Rz4+8cd7KGTuTfslaljm+BuCE/Kt76XsnvcS
 iqMtoOTugkTn9hCyANN+/GFXXxL9v8KuutfzhnEJxUSKjoZNmcDX3a4iNoKLMrZiEhAfrLdLyrJ
 ZtBZY5ep3hsG/D07/EEnqtUbHkjW8gKqp0FSk7zXL5yEDN/2AI/gJuViLxEQ9Js5AJX/GE0SVs1
 XfA90lQYiQxWj3ael4BGtgrFCnei7N9vr6Luc/6eVnIoYjFxw76cVYOk9fTUUEH2sN68DN1qFLX
 2H6wWpsn6JbIO913ZEsHFe1nEtnuUSJgoz9/FQJTfyZlj9e92LFSFwubIfpzVsdtjECcMiqiJ1n
 HB+WTKvtTx/0+vpVJWd3Bxb6Xab/tV+50ZjEq5sDXO0c6uNm6NrjHe0KOqqsUNWojtozqEB9uNz
 4u6el9RUQj6RMYEOteZ4ehi95drAUuI7WXiDP5kBkgAnkpW8D/67YhwQ78nODCFM3mlts8HWadz
 H8vX22N2mI9D4w=
X-Received: by 2002:a17:90b:17c2:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-39b25f1c5bdmr1024392a91.0.1788464191280; 
 Thu, 03 Sep 2026 12:36:31 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:30 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 10/24] target/arm/kvm-rme: Keep track of images loaded in
 Realm memory
Date: Thu,  3 Sep 2026 13:35:57 -0600
Message-ID: <20260903193611.1058589-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
That way we can deterministically calculate the Realm Initial Measurement (RIM).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index f7c2cc786e2c..9985f5daba89 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -10,6 +10,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
@@ -22,8 +23,18 @@
 #define TYPE_RME_GUEST "rme-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
+#define RME_PAGE_SIZE qemu_real_host_page_size()
+
+typedef struct {
+    hwaddr base;
+    hwaddr size;
+    uint8_t *data;
+} RmeRamRegion;
+
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
+    Notifier rom_load_notifier;
+    GSList *ram_regions;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -41,6 +52,44 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
     kvm_mark_guest_state_protected();
 }
 
+static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
+{
+    const RmeRamRegion *ra = a;
+    const RmeRamRegion *rb = b;
+
+    g_assert(ra->base != rb->base);
+    return ra->base < rb->base ? -1 : 1;
+}
+
+static void rme_rom_load_notify(Notifier *notifier, void *data)
+{
+    RmeRamRegion *region;
+    RomLoaderNotifyData *rom = data;
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
+    region->data = rom->data;
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
 static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     KVMState *s = KVM_STATE(current_accel());
@@ -58,6 +107,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
     error_setg(&rme_mig_blocker, "RME: migration is not implemented");
     migrate_add_blocker(&rme_mig_blocker, &error_fatal);
 
+    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
+    rom_add_load_notifier(&rme_guest->rom_load_notifier);
+
     /*
      * The realm activation is done last, when the VM starts, after all images
      * have been loaded and all vcpus finalized.
-- 
2.43.0


