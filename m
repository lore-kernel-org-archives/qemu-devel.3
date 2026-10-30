Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176D606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FEQ8yL6/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmRZ-0000Gy-7m; Fri, 30 Oct 2026 09:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMmRV-00008j-As
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMmRT-0005AU-M9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793366087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sWPcDbNjWSK4m62un68W2aSa9nPYNDYfPEb/+sW6n0=;
 b=FEQ8yL6/6W54x//MoGrrO3Mj0zG2AJ+UQT1mnSw4sbhux3i8/tRnsU/FzuLyYG1wazRe68
 7tRuk6n17lEkPJ0y/ieQbnctCer8Rso7KvRxo75VNDjr78TMrSYRUfyR/2xEAwTAYLxJEN
 pv73h/hSTW8DTzMegl6yBuNtZ4jB0hg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-zsJObxb-PlGvhvY3AVUlvg-1; Fri,
 30 Oct 2026 09:14:44 -0400
X-MC-Unique: zsJObxb-PlGvhvY3AVUlvg-1
X-Mimecast-MFC-AGG-ID: zsJObxb-PlGvhvY3AVUlvg_1793366082
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 586421956079; Fri, 30 Oct 2026 13:14:42 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9AAE91956088; Fri, 30 Oct 2026 13:14:37 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com,
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com,
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alireza.sanaee@huawei.com
Cc: armbru@redhat.com,
	mbawa@redhat.com
Subject: [PATCH v4 for-11.2 05/10] target/arm/kvm: Pass an error handle to
 kvm_arm_init_cpreg_list
Date: Fri, 30 Oct 2026 14:13:13 +0100
Message-ID: <20261030131406.461599-6-eric.auger@redhat.com>
In-Reply-To: <20261030131406.461599-1-eric.auger@redhat.com>
References: <20261030131406.461599-1-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass an error handle to kvm_arm_init_cpreg_list(). A Subsequent patch
will do the same with kvm_arch_init_vcpu().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 724bc08edf..76b3996d3b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -865,6 +865,7 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
 /**
  * kvm_arm_init_cpreg_list:
  * @cpu: ARMCPU
+ * @errp: Error handle
  *
  * Initialize the ARMCPU cpreg list according to the kernel's
  * definition of what CPU registers it knows about (and throw away
@@ -872,7 +873,7 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
  *
  * Returns: 0 if success, else < 0 error code
  */
-static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
+static int kvm_arm_init_cpreg_list(ARMCPU *cpu, Error **errp)
 {
     struct kvm_reg_list rl;
     struct kvm_reg_list *rlp;
@@ -882,12 +883,17 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
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
@@ -904,7 +910,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         case KVM_REG_SIZE_U64:
             break;
         default:
-            fprintf(stderr, "Can't handle size of register in kernel list\n");
+            error_setg(errp, "Can't handle size of register in kernel list");
             ret = -EINVAL;
             goto out;
         }
@@ -930,7 +936,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         /* Shouldn't happen unless kernel is inconsistent about
          * what registers exist.
          */
-        fprintf(stderr, "Initial read of kernel register state failed\n");
+        error_setg(errp, "Initial read of kernel register state failed");
         ret = -EINVAL;
         goto out;
     }
@@ -2008,6 +2014,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     uint64_t mpidr;
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
+    Error *local_err = NULL;
     uint64_t psciver;
 
     if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
@@ -2106,7 +2113,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     SET_IDREG(&cpu->isar, MPIDR, mpidr);
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
-    return kvm_arm_init_cpreg_list(cpu);
+    ret = kvm_arm_init_cpreg_list(cpu, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+    return ret;
 }
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
-- 
2.53.0


