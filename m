Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF950C624DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEZ-0001KP-SD; Thu, 03 Sep 2026 15:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEX-0001Ho-Ew
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:25 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEV-00047J-5T
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:24 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc149372c14so215651a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464180; x=1789068980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i3s4/uL2nCcl6R6HIOwHPfPYar75XVk8sVrkSd1EszE=;
 b=ReQrJMgA/ZwJqzhB0n2C5aYza0rt0SqnGJtkc/KW2dgcgayQebJCjEh9pRjIlptihj
 c2qiWFTC4fgqryxAum82fzXlLv0hR5BwdtEC9CvK0SR/0RjYmB6gjfwK0byWWRY6KJ6n
 ya3RtAag7p62L4mS0NCBRiWOu0yXxcxQvA1hQH+wl3/AdRyUFEfFwWjrlFYQhhLfhm1f
 ftkdX1g+VJlVfdYJGiucQBJs+XZMR27xhp4JoHhS3OnoH/vzFP7i3p+OWjzOJoCGIESt
 uYbiHm4C35DrrgLRiK4y0rbc8G/lYWU7DaCxDPxuBMGTKSvZIenPpDBuKZtWUrBu5rir
 fSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464180; x=1789068980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i3s4/uL2nCcl6R6HIOwHPfPYar75XVk8sVrkSd1EszE=;
 b=A9DkO5Tx+fGgm3d3iFya+768yEqen93PTz4OXt/Xv58YrHm2hpCTTGi5hP7/+e39IQ
 LKu073qtQrneDgUq2bTMvGJWOvyYcpHYPuSLzIFZJlQ2nSh4NO7pqTpErEzGFEnnrXar
 CZf+CQWXwn9PEaIjc2xock9utfZwwCUkSjgzUavBvLYe+fkV/YhjR+m0cJuiWopB+EwH
 GN2nEgzwb20fONqy3zo3mepK2WGvJr/qcLPMAcLc+l/0oEdFePu+SoxxLhZi3NGJpdcR
 QcQDpRJ0Z04j787KAp3rSmR8w6cDbxdznAfK7GpuHbDX6wkNanY72XVz/Ypq+YTpwzKl
 Ct+Q==
X-Gm-Message-State: AFuF++nbVCDfsxyluZxa93ffp+JpMR29wN1zq9MJNAJKKnmrqRlEHzVl
 hyChrSnKH72O/F+mUE8PTzXLCTUhy93MUBtnTBTeqqJP4Wdoq6hQcsVTO2nJc4rJllI=
X-Gm-Gg: AYBFou2n4opDw/3m7g+aNP3orXroEpbvbhgvXfhgNAub6taF1vgEtqMESFd33kpNOrU
 DsiOh9SrPpvEhlxu4nuStNwAGWiR8P35be1q97CBIOTNTJzcWUeqhzfh9KfxJe00H3IrCf9aERG
 7UY6IlqE2h5W8uzSodW7q0sfm5tLxoHzn0nznUYmTNM8ht/fuezan+YCEaBTC6T/tk749uBJSp7
 IOkHJIrSKOnCjHo8ldIR6en+UvH4mJiJZatfBRDIXB4dLuKhSc8vmJO3jSl/AIHUG+6Lw+Hp3CC
 FE5bMf8NAeFXjxXRAcPRZG7SAJvQM8wqfwzGGZRItazk73TXGe7Uxl/PFNgFf4Kl5yYIXxa5l2j
 mkcZmbkWZbZiIL0tOeozQp8Rq/nCG1igZ6uJnZ/lhfYX6I9H16ABfxtqNnYlo/4v5dekkA077BD
 2S04OyE4GZ9XIv32yj5q58wCssa/z7RSQK5UV/Yolz0HD/Tr69GMnGSV+2avCDVtX2sqou4z7rH
 aKaf4yuhjtulpY=
X-Received: by 2002:a17:90b:264e:b0:398:9bd1:3215 with SMTP id
 98e67ed59e1d1-39b262e28cdmr1126889a91.22.1788464180505; 
 Thu, 03 Sep 2026 12:36:20 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:20 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 04/24] target/arm/kvm-rme: Add mechanic to initialize realms
Date: Thu,  3 Sep 2026 13:35:51 -0600
Message-ID: <20260903193611.1058589-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pg1-x535.google.com
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
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c     | 15 +++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 42e1d1e7b859..a4a5e195c196 100644
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
@@ -29,12 +30,62 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
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
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
+
+    if (rme_guest) {
+        error_report("a single instance of RmeGuest is supported");
+        exit(1);
+    }
+    rme_guest = RME_GUEST(obj);
+    cgs->allow_convert_in_place = true;
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


