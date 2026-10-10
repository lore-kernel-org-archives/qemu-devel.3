Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FDACA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXI2-0002l7-R5; Sat, 10 Oct 2026 09:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXHv-0002VL-RI
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXHs-0004dQ-S9
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJJ9866SG6H+ss4j/yi5NJRaRLchsKWeX66gkZZoSAY=;
 b=SPKubFUoL9IGmXtEzCEtIKYxqDzAb1GmgOPmiiAIN6W2A3ybadjr2rGoigeJFV7wD/kJDh
 u5LsJFA85gj+ioqLn1R9ADr+vQGAxO6cA9pS0aJns0YDATeNYRgXeAAS6ap6zPFNqpBk+j
 zXdvDjK3ZNzHz9nIuYsl/N+aGxc1HxM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-IlDwscnDO6S4RsQQdcxOeA-1; Sat,
 10 Oct 2026 13:38:52 +0000
X-MC-Unique: IlDwscnDO6S4RsQQdcxOeA-1
X-Mimecast-MFC-AGG-ID: IlDwscnDO6S4RsQQdcxOeA_1791639530
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA44A1809C9F; Sat, 10 Oct 2026 13:38:50 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00FCD30000E5; Sat, 10 Oct 2026 13:38:45 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 15/26] target/arm/kvm: Let kvm_arm_init_cpreg_list
 propagate an error handle
Date: Sat, 10 Oct 2026 15:36:19 +0200
Message-ID: <20261010133725.642498-16-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-1-eric.auger@redhat.com>
References: <20261010133725.642498-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Subsequent patch will add an error handle to kvm_arch_init_vcpu(). So all
errors must come with an error handle.

kvm_arm_init_cpreg_list does not propogate any, add this capability.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ac4f307276..f2b79c0a34 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -962,6 +962,7 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
 /**
  * kvm_arm_init_cpreg_list:
  * @cpu: ARMCPU
+ * @errp: pointer to Error* for error reporting
  *
  * Initialize the ARMCPU cpreg list according to the kernel's
  * definition of what CPU registers it knows about (and throw away
@@ -969,22 +970,27 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
  *
  * Returns: 0 if success, else < 0 error code
  */
-static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
+static int kvm_arm_init_cpreg_list(ARMCPU *cpu, Error **errp)
 {
     struct kvm_reg_list rl;
-    struct kvm_reg_list *rlp;
+    struct kvm_reg_list *rlp = NULL;
     int i, ret, arraylen;
     CPUState *cs = CPU(cpu);
 
     rl.n = 0;
     ret = kvm_vcpu_ioctl(cs, KVM_GET_REG_LIST, &rl);
     if (ret != -E2BIG) {
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "failed to get KVM register list size");
+        }
         return ret;
     }
     rlp = g_malloc(sizeof(struct kvm_reg_list) + rl.n * sizeof(uint64_t));
     rlp->n = rl.n;
     ret = kvm_vcpu_ioctl(cs, KVM_GET_REG_LIST, rlp);
     if (ret) {
+        error_setg_errno(errp, -ret, "failed to get KVM register list");
         goto out;
     }
     /* Sort the list we get back from the kernel, since cpreg_tuples
@@ -1001,7 +1007,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         case KVM_REG_SIZE_U64:
             break;
         default:
-            fprintf(stderr, "Can't handle size of register in kernel list\n");
+            error_setg(errp, "Can't handle size of register in kernel list");
             ret = -EINVAL;
             goto out;
         }
@@ -1027,7 +1033,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         /* Shouldn't happen unless kernel is inconsistent about
          * what registers exist.
          */
-        fprintf(stderr, "Initial read of kernel register state failed\n");
+        error_setg(errp, "Initial read of kernel register state failed");
         ret = -EINVAL;
         goto out;
     }
@@ -2196,7 +2202,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     SET_IDREG(&cpu->isar, MPIDR, mpidr);
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
-    return kvm_arm_init_cpreg_list(cpu);
+    return kvm_arm_init_cpreg_list(cpu, errp);
 }
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
-- 
2.53.0


