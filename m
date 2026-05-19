Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D0DCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKXU-0003iG-Rn; Tue, 19 May 2026 09:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPKXS-0003b7-6r
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPKXL-00008x-W6
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779197467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AqN7LyQkpVzsmK2HDdemrDuDRczsABmmtqsqw6bIJnM=;
 b=gQ88RU8ZtOQKR+Ifj5Xtcqq6DC+CJCpsVmJjW8EnXRJK5Y6CWO9vTAa3JMTFRMDmVWkAPh
 9lPTBJVDZOSfybYUCgZdf2T+T3wyirBXGjgRpaVzPmISj2VNnciOeTWona/zn1lW75R6RW
 pTvBct27V/XCxddqkZGgJQBxToT412o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-1otgUIMGMAW_t3_jJjq3pQ-1; Tue,
 19 May 2026 09:31:03 -0400
X-MC-Unique: 1otgUIMGMAW_t3_jJjq3pQ-1
X-Mimecast-MFC-AGG-ID: 1otgUIMGMAW_t3_jJjq3pQ_1779197460
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDA3919560B3; Tue, 19 May 2026 13:31:00 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.49.207])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12A02180034E; Tue, 19 May 2026 13:30:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v5 16/18] target/arm/cpu: Expose writable ID reg field
 properties on the kvm host vcpu model
Date: Tue, 19 May 2026 15:27:30 +0200
Message-ID: <20260519132905.145643-17-eric.auger@redhat.com>
In-Reply-To: <20260519132905.145643-1-eric.auger@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

---
v4 -> v5:
- get rid of ret local variable, dynamically allocate and free writable_map
  here
---
 target/arm/cpu64.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f2edbfc437..e0e1ff6cfb 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -37,6 +37,7 @@
 #include "hw/core/qdev-properties.h"
 #include "internals.h"
 #include "cpu-features.h"
+#include "cpu-idregs.h"
 
 /* convert between <register>_IDX and SYS_<register> */
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
@@ -851,7 +852,6 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
 static void aarch64_host_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    int ret;
 
 #if defined(CONFIG_NITRO)
     if (nitro_enabled()) {
@@ -865,13 +865,18 @@ static void aarch64_host_initfn(Object *obj)
 
     cpu->writable_map = g_new(uint64_t, KVM_ARM_FEATURE_ID_RANGE_SIZE);
 
-    ret = kvm_arm_get_writable_id_regs(cpu->writable_map);
-    if (ret) {
+    if (kvm_arm_get_writable_id_regs(cpu->writable_map)) {
         g_free(cpu->writable_map);
         cpu->writable_map = NULL;
     }
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
+
+    if (cpu->writable_map) {
+        /* generate SYSREG properties according to writable masks */
+        kvm_arm_expose_idreg_properties(cpu, arm64_id_regs);
+    }
+
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
 #elif defined(CONFIG_WHPX)
-- 
2.53.0


