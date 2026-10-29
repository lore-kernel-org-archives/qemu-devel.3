Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C42606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R2xrZvFR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRI5-0007Cc-Jp; Thu, 29 Oct 2026 10:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMRGy-0006QZ-Rl
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMRGw-0007RI-ML
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793284709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxRP/DaUp9vcon55zc5851rZsjlUW7sUIs1U3116HmY=;
 b=R2xrZvFRn9W2x9RFP9P2Lfd2swzi/XPJEW0L9G7EnKMiD2ZswseeKQuxjxA8NLcpYqZcUU
 Gg4dZdFP6D+yJ+6GnB+KsdGDAEpfavhQ8v9R6E/yyIsoyg13B79d4DO7HWaYz8Sgm6sSLh
 Y6iiRR3+KS+tHzcwTaq0/kj5AmzySXY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-7Px_9zf1Mca2_0i62nbsiw-1; Thu,
 29 Oct 2026 10:38:25 -0400
X-MC-Unique: 7Px_9zf1Mca2_0i62nbsiw-1
X-Mimecast-MFC-AGG-ID: 7Px_9zf1Mca2_0i62nbsiw_1793284703
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F2EE180034E; Thu, 29 Oct 2026 14:38:23 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 488551955F01; Thu, 29 Oct 2026 14:38:18 +0000 (UTC)
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
Subject: [PATCH v2 for-11.2 6/9] target/arm/kvm: Pass an error handle to
 kvm_arm_init_cpreg_list
Date: Thu, 29 Oct 2026 15:36:53 +0100
Message-ID: <20261029143742.294275-7-eric.auger@redhat.com>
In-Reply-To: <20261029143742.294275-1-eric.auger@redhat.com>
References: <20261029143742.294275-1-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass an error handle to kvm_arm_init_cpreg_list(). A Subsequent patch
will do the same with kvm_arch_init_vcpu().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/kvm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 28f199c03f..d454346037 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -872,6 +872,7 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
 /**
  * kvm_arm_init_cpreg_list:
  * @cpu: ARMCPU
+ * @errp: Error handle
  *
  * Initialize the ARMCPU cpreg list according to the kernel's
  * definition of what CPU registers it knows about (and throw away
@@ -879,7 +880,7 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
  *
  * Returns: 0 if success, else < 0 error code
  */
-static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
+static int kvm_arm_init_cpreg_list(ARMCPU *cpu, Error **errp)
 {
     struct kvm_reg_list rl;
     struct kvm_reg_list *rlp;
@@ -889,12 +890,17 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
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
@@ -911,7 +917,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         case KVM_REG_SIZE_U64:
             break;
         default:
-            fprintf(stderr, "Can't handle size of register in kernel list\n");
+            error_setg(errp, "Can't handle size of register in kernel list");
             ret = -EINVAL;
             goto out;
         }
@@ -937,7 +943,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         /* Shouldn't happen unless kernel is inconsistent about
          * what registers exist.
          */
-        fprintf(stderr, "Initial read of kernel register state failed\n");
+        error_setg(errp, "Initial read of kernel register state failed");
         ret = -EINVAL;
         goto out;
     }
@@ -2015,6 +2021,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     uint64_t mpidr;
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
+    Error *local_err = NULL;
     uint64_t psciver;
 
     if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
@@ -2113,7 +2120,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
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


