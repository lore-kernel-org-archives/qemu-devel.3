Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1E1CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTpt-0000KH-KP; Tue, 16 Jun 2026 09:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZTps-0000JW-Lf
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZTpr-00064n-3E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781616490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAUvyW8XM/MoP2Fagjs5c0VuePcOU0ts+uJ4JlRpEoU=;
 b=cQmZXEpz57khhu74KRs1zldEKmlZoxBwRYAApJHe/oq/5SqgYrnRu6MVfymjJjroQC03zY
 7YM9+ybArCoWx4oXwD2yCvrj+jVwwtdet/SphOd+Dz5pgngNQhV+xE5nXJ01JzdrngsKU3
 mlQhBaYltGKl0jzeND2GHXxg/8oIIsQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-sBaWpOSdOHGsoELbp3UDpw-1; Tue,
 16 Jun 2026 09:28:07 -0400
X-MC-Unique: sBaWpOSdOHGsoELbp3UDpw-1
X-Mimecast-MFC-AGG-ID: sBaWpOSdOHGsoELbp3UDpw_1781616485
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10221195411F; Tue, 16 Jun 2026 13:28:05 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.30])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 174073000203; Tue, 16 Jun 2026 13:27:58 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [RFC PATCH v6 13/17] target/arm/cpu: Expose writable ID reg field
 properties on the kvm host vcpu model
Date: Tue, 16 Jun 2026 15:17:00 +0200
Message-ID: <20260616132625.1732031-14-eric.auger@redhat.com>
In-Reply-To: <20260616132625.1732031-1-eric.auger@redhat.com>
References: <20260616132625.1732031-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If the host supports KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES and
KVM_ARM_GET_REG_WRITABLE_MASKS ioctl successfully retrieved the mask
of writable fields for all ID regs, expose uint64 SYSREG properties
for all the writable ID reg fields exposed by the host kernel which
can be matched in target/arm/cpu-idregs.h.inc.

Properties are named  SYSREG_<REG>_<FIELD> with REG and FIELD
being those used ARCHMRS Registers.json.

When such properties are set, they override the default field value
retrieved from the host and reinjected into KVM. Then the actual value
being applied at KVM depends on the register, ie. it can be sanitized.
In case the field value is rejected by KVM, the vpcu init fails.

Anyway there is a first attempt to write back this value into KVM.

Then legacy CPU options (virtualization, secure, ...) can still
override the previous value. So low level IDREG field properties
apply before the legacy ones.

An example of invocation is:
-cpu host,SYSREG_ID_AA64MMFR0_EL1_ECV=0x0
which sets ECV field of ID_AA64MMFR0_EL1 to 0 (enhanced counter
virtualization).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>

---
v5 -> v6:
- do not check writable_map anymore

v4 -> v5:
- get rid of ret local variable, dynamically allocate and free writable_map
  here
---
 target/arm/cpu64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 2816735577..d5d02515df 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -37,6 +37,7 @@
 #include "hw/core/qdev-properties.h"
 #include "internals.h"
 #include "cpu-features.h"
+#include "cpu-idregs.h"
 
 /* convert between <register>_IDX and SYS_<register> */
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
@@ -806,6 +807,10 @@ void aarch64_host_initfn(Object *obj)
     kvm_arm_set_cpreg_mig_tolerances(cpu);
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
+
+    /* generate SYSREG properties according to writable masks */
+    kvm_arm_expose_idreg_properties(cpu, arm64_id_regs);
+
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
 #elif defined(CONFIG_WHPX)
-- 
2.53.0


