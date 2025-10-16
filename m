Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A8BCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 13:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9OTu-0006ku-ON; Thu, 16 Oct 2025 09:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9OTs-0006jt-TR
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9OTe-00068v-F7
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760623027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSSOQjHlELjPhsxKkeZNq3eX3cMQavKRRCjGfxib9Ig=;
 b=Mtgeo0pZC1JTO+/0OUeQVf8IovJ43bLGuQo0ritlqNQMnU+mFybQ24MTh+xU5v2unv7Kd6
 I7+f8PD/Ik1Kuelf9gRLCfoksIAOSS/QGxoltXTzKCzzYSKSQfpmrNgUGxXKJFoCEKg/Gh
 XdL8QyL8AKPKh0UpZmIyEUqVB7sD+FE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-9QVi66RJPReG-nvZL9HFsQ-1; Thu,
 16 Oct 2025 09:57:05 -0400
X-MC-Unique: 9QVi66RJPReG-nvZL9HFsQ-1
X-Mimecast-MFC-AGG-ID: 9QVi66RJPReG-nvZL9HFsQ_1760623024
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71623195398B; Thu, 16 Oct 2025 13:57:04 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.238])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4756119560B5; Thu, 16 Oct 2025 13:56:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH 6/7] target/arm/kvm: Expose kvm-hidden-regs and kvm-fake-regs
 properties
Date: Thu, 16 Oct 2025 15:55:18 +0200
Message-ID: <20251016135625.249551-7-eric.auger@redhat.com>
In-Reply-To: <20251016135625.249551-1-eric.auger@redhat.com>
References: <20251016135625.249551-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Allows to set the kvm-hidden-regs and kvm-fake-regs array properties.
This will allow to define such compat machine props like:

    static GlobalProperty arm_virt_kernel_compat_10_1[] = {
        /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
        { TYPE_ARM_CPU, "kvm-hidden-regs", "0x6030000000160003" },
        { TYPE_ARM_CPU, "kvm-enforced-regs",
          /* TCR_EL1, PIRE0_EL1, PIR_EL1 */
          "0x603000000013c103, 0x603000000013c512, 0x603000000013c513" },
    }

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1a95e2c667..d103d4293d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,8 @@
 #include "qemu/log.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "target/arm/gtimer.h"
 #include "migration/blocker.h"
 
@@ -484,6 +486,15 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
     ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+static const Property arm_cpu_kvm_compat_hidden_regs_property =
+    DEFINE_PROP_ARRAY("kvm-hidden-regs", ARMCPU,
+                      nr_kvm_hidden_regs, kvm_hidden_regs, qdev_prop_uint64, uint64_t);
+
+static const Property arm_cpu_kvm_compat_enforced_regs_property =
+    DEFINE_PROP_ARRAY("kvm-enforced-regs", ARMCPU,
+                      nr_kvm_enforced_regs, kvm_enforced_regs,
+                      qdev_prop_uint64, uint64_t);
+
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
@@ -505,6 +516,9 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
                              kvm_steal_time_set);
     object_property_set_description(obj, "kvm-steal-time",
                                     "Set off to disable KVM steal time.");
+
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_kvm_compat_hidden_regs_property);
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_kvm_compat_enforced_regs_property);
 }
 
 bool kvm_arm_pmu_supported(void)
-- 
2.49.0


