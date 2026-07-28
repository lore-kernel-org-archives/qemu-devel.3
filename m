Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469D2C54F55
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonS2-00037E-0y; Tue, 28 Jul 2026 15:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonRs-0002ux-RT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:46 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonRr-0001NR-48
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:44 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cf452def93so12059815ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266802; x=1785871602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FPcLPI8Xklacd9X4zG4SydQQX6Mfa0kQr3DHTZ+XxOQ=;
 b=ATCR/w6qAgfOP3bOnVXUxoJI1JWqLlmA2KqnA30FpDqWDmjH8NFasvvCbwipTOUuYc
 PLFAjtx01VSLdLfyz3PHJawc8IYju7pAinfRQvUFKaD6zDEYWcRqepZjKlUpysqZ9Ob1
 8jlsawp4CtNjUgO4lEjai7N/Kw558cVP/VhJvkNjhWQRq1fo1vhkQ7YvCIjFECZSJeY/
 Gf0vOLOWE3Ui9NGt8huMAY0Utt+HAIazJvLl9Zu0NxY9UKQDVXc15WA3wwiIBE3jog9j
 8K7Vd02vfJMDmm3ICPK8BG/D7aRXNYu0NtWCbEIiceUaRrGHexnl6h6isyluwy7c0GgG
 Rq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266802; x=1785871602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FPcLPI8Xklacd9X4zG4SydQQX6Mfa0kQr3DHTZ+XxOQ=;
 b=kpODSb7Mv/tl3y76AdDu3JxPm+GSzW0U7dByCpEtbJH9KCprj1yj52hllrF3Bc3+/+
 mhGyQ2Tz+1PqI8TjWGtrsQIZbTH6oN20plYYXIMtKFl8Ng5nnvx83Uh+Usq8/En9jSOZ
 l+s485VKlVtfV4UJselqDkUWHl44d5q4Zomio4cPISt8x2ZxaZ9svMVWLayySdIWj1A+
 acYpunOUKOQTWjiifCPHaE6iG5bsQm+epQV7+Fg2PfN1yrtfqChnjcBIYsfLEhAh7+lz
 b2vBUOpi8TIPy8JtQlLQgo6V+EN+mQ709SdkyAZMa7qJWq+T0GepqOSYPLlFgZkSXfqF
 O1Mg==
X-Gm-Message-State: AOJu0YwHn4u94SKQhKXZCcnwjJU/2VpzcvegVkWG3mogzTY/kWguBgKH
 KKJ8/x0odxMuatM3olUypyYL7mqvgzwZdvh3rva9TSs/rDZJ8wUlRRy0amkg38hg3cF4JXTCyjB
 xhdgrEMM=
X-Gm-Gg: AR+sD11xHKqfMs+d8jP6jXuJdYQr6HdDtmjUNlHc+f3aTgkRajzh8tpidiRWFoNTnXI
 xOVT/f8jBUjeQTY6P7rtpcJIFeO/J0Movo/clbgn/s21XCtcgOTRIXEssEVzHihKc2I5doeoDhI
 AiSjjlH2cFqNj8JBCrhOkkLAb55LJBARBLko4Zv4gqT66qZVPRfs4Fg0NJAmvO/VLCE800Vu7kQ
 KhdZ7idBXpdnnhrfMrHAqh3PMOz9o6noZIU5tBsS/toW9SUbAjfUGgt+Pmusid8MFCqkA37YeIF
 2RH8DAhJRw6rmOGWHsJvmcEDW2tOEdu/nxrCZYMbpQ2Yzx20PxwjpSsD6efQTV8QNCoE8dLFXKZ
 nkrIvy/C6H1mY97ZbW4p5YHZbq/MexJor5EHSBNBt64lQKemd5UxFyeJOUiE406Ql8Oi496wlLd
 bDUTyGPGinCDntb4Hb/EfP0K9k8hQn3/p/rLhrny/dMXOn0T3ocobC8D1wbIJJLv/Qi6K+zych0
 kBj7Ai5GVmqw5s=
X-Received: by 2002:a17:90b:3908:b0:385:3ab:fecb with SMTP id
 98e67ed59e1d1-38f6a205db2mr3283785a91.4.1785266801692; 
 Tue, 28 Jul 2026 12:26:41 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:26:41 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 04/24] target/arm/kvm-rme: Add mechanic to initialize realms
Date: Tue, 28 Jul 2026 13:26:10 -0600
Message-ID: <20260728192630.240375-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x629.google.com
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

Initialise an @rme_guest object and install a handler to get notified
when the Realm is ready to start.  That way we can finish reading the
Realm once we know everything is in place.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c     | 15 ++++++++++++--
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 42e1d1e7b859..eb8e65ba438f 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -13,6 +13,7 @@
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
 #include "system/confidential-guest-support.h"
 #include "system/kvm.h"
@@ -29,12 +30,59 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
                                           CONFIDENTIAL_GUEST_SUPPORT,
                                           { TYPE_USER_CREATABLE }, { })
 
+static RmeGuest *rme_guest;
+
+static void rme_vm_state_change(void *opaque, bool running, RunState state)
+{
+    if (!running) {
+        return;
+    }
+
+    kvm_mark_guest_state_protected();
+}
+
+static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
+{
+    KVMState *s = KVM_STATE(current_accel());
+    static Error *rme_mig_blocker;
+
+    if (!rme_guest) {
+        return 0;
+    }
+
+    if (!kvm_vm_check_extension(s, KVM_CAP_ARM_RMI)) {
+        error_setg(errp, "VM doesn't support Realms");
+        return -ENODEV;
+    }
+
+    error_setg(&rme_mig_blocker, "RME: migration is not implemented");
+    migrate_add_blocker(&rme_mig_blocker, &error_fatal);
+
+    /*
+     * The realm activation is done last, when the VM starts, after all images
+     * have been loaded and all vcpus finalized.
+     */
+    qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
+
+    cgs->require_guest_memfd = true;
+    cgs->ready = true;
+    return 0;
+}
+
 static void rme_guest_class_init(ObjectClass *oc, const void *data)
 {
+    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+
+    klass->kvm_init = kvm_arm_rme_init;
 }
 
 static void rme_guest_init(Object *obj)
 {
+    if (rme_guest) {
+        error_report("a single instance of RmeGuest is supported");
+        exit(1);
+    }
+    rme_guest = RME_GUEST(obj);
 }
 
 static void rme_guest_finalize(Object *obj)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed99be7fd80c..401a6f669cbb 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -33,6 +33,7 @@
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
+#include "system/confidential-guest-support.h"
 #include "gdbstub/enums.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
@@ -596,7 +597,8 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    int ret;
+    Error *local_err = NULL;
+    int ret = 0;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -610,6 +612,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
+    /* Initialize confidential guest (Realm) if needed */
+    if (ms->cgs) {
+        ret = confidential_guest_kvm_init(ms->cgs, &local_err);
+            if (ret < 0) {
+                error_report_err(local_err);
+                return ret;
+        }
+    }
+
     /* Check whether user space can specify guest syndrome value */
     cap_has_inject_serror_esr =
         kvm_check_extension(s, KVM_CAP_ARM_INJECT_SERROR_ESR);
@@ -660,7 +671,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return 0;
+    return ret;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.43.0


