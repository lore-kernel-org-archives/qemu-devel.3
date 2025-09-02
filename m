Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC280CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 09:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNJ8-0006BJ-It; Tue, 02 Sep 2025 05:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1utNIw-00069I-MU
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1utNIu-00077X-8F
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756805268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s/vicsLIV8ie3pxPzrJpUlfFeHWyHL18Rm5hc2iBIzc=;
 b=SLvLABEJSp+mvztWpV8Elq/lY7LONPkQgWvv5tZPYSJZLsIcneCekzq0zthOIKFfZ1etTB
 MCe5j4hzCoT5As9nJF95sIxiW93muDUXK0031eAO5b/L8CJ/6M5IHJ5nKwprP8PVkd4xcP
 C+nhpO8DQ3sc2wjumoF8/jOYa5epAmg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-fm6crridM-u1VYhOcsbsFg-1; Tue,
 02 Sep 2025 05:27:45 -0400
X-MC-Unique: fm6crridM-u1VYhOcsbsFg-1
X-Mimecast-MFC-AGG-ID: fm6crridM-u1VYhOcsbsFg_1756805264
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 558E41956089; Tue,  2 Sep 2025 09:27:44 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-200.str.redhat.com
 [10.33.192.200])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4533C19560B4; Tue,  2 Sep 2025 09:27:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2] arm/kvm: report registers we failed to set
Date: Tue,  2 Sep 2025 11:27:32 +0200
Message-ID: <20250902092732.706338-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If we fail migration because of a mismatch of some registers between
source and destination, the error message is not very informative:

qemu-system-aarch64: error while loading state for instance 0x0 ofdevice 'cpu'
qemu-system-aarch64: Failed to put registers after init: Invalid argument

At least try to give the user a hint which registers had a problem,
even if they cannot really do anything about it right now.

Sample output:

Could not set register op0:3 op1:0 crn:0 crm:0 op2:0 to c00fac31 (is 413fd0c1)

We could be even more helpful once we support writable ID registers,
at which point the user might actually be able to configure something
that is migratable.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
Changes RFC->v2:
* cover different register types
* less macro magic
* less memory leaks
---
 target/arm/kvm.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 667234485547..0423d4df7c06 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -900,6 +900,58 @@ bool write_kvmstate_to_list(ARMCPU *cpu)
     return ok;
 }
 
+/* pretty-print a KVM register */
+#define CP_REG_ARM64_SYSREG_OP(_reg, _op)                       \
+    ((uint8_t)((_reg & CP_REG_ARM64_SYSREG_ ## _op ## _MASK) >> \
+               CP_REG_ARM64_SYSREG_ ## _op ## _SHIFT))
+
+static gchar *kvm_print_sve_register_name(uint64_t regidx)
+{
+    uint16_t sve_reg = regidx & 0x000000000000ffff;
+
+    if (regidx == KVM_REG_ARM64_SVE_VLS) {
+        return g_strdup_printf("SVE VLS");
+    }
+    /* zreg, preg, ffr */
+    switch (sve_reg & 0xfc00) {
+    case 0:
+        return g_strdup_printf("SVE zreg n:%d slice:%d",
+                               (sve_reg & 0x03e0) >> 5, sve_reg & 0x001f);
+    case 0x04:
+        return g_strdup_printf("SVE preg n:%d slice:%d",
+                               (sve_reg & 0x01e0) >> 5, sve_reg & 0x001f);
+    case 0x06:
+        return g_strdup_printf("SVE ffr slice:%d", sve_reg & 0x001f);
+    default:
+        return g_strdup_printf("SVE ???");
+    }
+}
+
+static gchar *kvm_print_register_name(uint64_t regidx)
+{
+        switch ((regidx & KVM_REG_ARM_COPROC_MASK)) {
+        case KVM_REG_ARM_CORE:
+            return g_strdup_printf("core reg %lx", regidx);
+        case KVM_REG_ARM_DEMUX:
+            return g_strdup_printf("demuxed reg %lx", regidx);
+        case KVM_REG_ARM64_SYSREG:
+            return g_strdup_printf("op0:%d op1:%d crn:%d crm:%d op2:%d",
+                                   CP_REG_ARM64_SYSREG_OP(regidx, OP0),
+                                   CP_REG_ARM64_SYSREG_OP(regidx, OP1),
+                                   CP_REG_ARM64_SYSREG_OP(regidx, CRN),
+                                   CP_REG_ARM64_SYSREG_OP(regidx, CRM),
+                                   CP_REG_ARM64_SYSREG_OP(regidx, OP2));
+        case KVM_REG_ARM_FW:
+            return g_strdup_printf("fw reg %d", (int)(regidx & 0xffff));
+        case KVM_REG_ARM64_SVE:
+            return kvm_print_sve_register_name(regidx);
+        case KVM_REG_ARM_FW_FEAT_BMAP:
+            return g_strdup_printf("fw feat reg %d", (int)(regidx & 0xffff));
+        default:
+            return g_strdup_printf("%lx", regidx);
+        }
+}
+
 bool write_list_to_kvmstate(ARMCPU *cpu, int level)
 {
     CPUState *cs = CPU(cpu);
@@ -927,11 +979,45 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
             g_assert_not_reached();
         }
         if (ret) {
+            gchar *reg_str = kvm_print_register_name(regidx);
+
             /* We might fail for "unknown register" and also for
              * "you tried to set a register which is constant with
              * a different value from what it actually contains".
              */
             ok = false;
+            switch (ret) {
+            case -ENOENT:
+                error_report("Could not set register %s: unknown to KVM",
+                             reg_str);
+                break;
+            case -EINVAL:
+                if ((regidx & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U32) {
+                    if (!kvm_get_one_reg(cs, regidx, &v32)) {
+                        error_report("Could not set register %s to %x (is %x)",
+                                     reg_str, (uint32_t)cpu->cpreg_values[i],
+                                     v32);
+                    } else {
+                        error_report("Could not set register %s to %x",
+                                     reg_str, (uint32_t)cpu->cpreg_values[i]);
+                    }
+                } else /* U64 */ {
+                    uint64_t v64;
+
+                    if (!kvm_get_one_reg(cs, regidx, &v64)) {
+                        error_report("Could not set register %s to %lx (is %lx)",
+                                     reg_str, cpu->cpreg_values[i], v64);
+                    } else {
+                        error_report("Could not set register %s to %lx",
+                                     reg_str, cpu->cpreg_values[i]);
+                    }
+                }
+                break;
+            default:
+                error_report("Could not set register %s: %s",
+                             reg_str, strerror(-ret));
+            }
+            g_free(reg_str);
         }
     }
     return ok;
-- 
2.50.1


