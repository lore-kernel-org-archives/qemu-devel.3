Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9E5CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXIf-0004fi-0N; Sat, 10 Oct 2026 09:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXId-0004Zi-8t
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXIb-0004mV-O1
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWAeOoa1Aggv8+wq6e4woSeOMPDynBiaXDMHTvXpmn8=;
 b=hJlbLCm7to9kEs9EkhN9ThIYuJijsdCBOPPi7Hmt09IqTYSRHiurIbx9F3Kj4C2BstGp6Q
 OFn4y1rPYNtYg9enBp+EFaN5vr7DKeyT4uxmN0ebRGljSDguUJEd4ETuxqPWamR/mHaCx4
 we6w0rvElCth1YWYUNlq1ZXg97IhfD0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446--t0Vb-m-NQunNUWAFWP68Q-1; Sat,
 10 Oct 2026 13:39:36 +0000
X-MC-Unique: -t0Vb-m-NQunNUWAFWP68Q-1
X-Mimecast-MFC-AGG-ID: -t0Vb-m-NQunNUWAFWP68Q_1791639575
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E72AC180A20A; Sat, 10 Oct 2026 13:39:34 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D77230000E5; Sat, 10 Oct 2026 13:39:30 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 24/26] target/arm/kvm: Introduce
 kvm_arm_create_init_scratch_vcpu()
Date: Sat, 10 Oct 2026 15:36:28 +0200
Message-ID: <20261010133725.642498-25-eric.auger@redhat.com>
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

Introduce kvm_arm_create_init_scratch_vcpu() that allows to create
and initialize a scratch vcpu from cpu settings. We want to use
this in arm-qmp-cmds code as well as kvm_arm_destroy_scratch_host_vcpu
so export them.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v9 -> v10:
- pass the fdarray as a param
---
 target/arm/kvm_arm.h  | 19 ++++++++++++++++++-
 target/arm/kvm-stub.c | 10 ++++++++++
 target/arm/kvm.c      | 13 +++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index ccab33e571..2e7e02e4a4 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -118,11 +118,28 @@ struct kvm_vcpu_init;
 bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
                                       struct kvm_vcpu_init *init, Error **errp);
 
+/**
+ * kvm_arm_create_init_scratch_vcpu:
+ * @cpu: ARMCPU whose kvm init features to inherit
+ * @fdarray: array of fds filled as by kvm_arm_create_scratch_host_vcpu
+ *
+ * Create and initialize a scratch vcpu inheriting the features set
+ * on @cpu.
+ *
+ * Return the vcpu fd on success or -1 on failure with a corresponding
+ * Error handle. On success, @fdarray is populated and must be torn down
+ * with kvm_arm_destroy_scratch_host_vcpu().
+ */
+int kvm_arm_create_init_scratch_vcpu(ARMCPU *cpu, int *fdarray, Error **errp);
+
+
 /**
  * kvm_arm_destroy_scratch_host_vcpu:
  * @fdarray: array of fds as set up by kvm_arm_create_scratch_host_vcpu
+ *           or kvm_arm_create_init_scratch_vcpu
  *
- * Tear down the scratch vcpu created by kvm_arm_create_scratch_host_vcpu.
+ * Tear down the scratch vcpu created by kvm_arm_create_scratch_host_vcpu
+ * or kvm_arm_create_init_scratch_vcpu.
  */
 void kvm_arm_destroy_scratch_host_vcpu(int *fdarray);
 
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 8e6fae0a4d..c9387f5c8c 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -126,3 +126,13 @@ bool kvm_idreg_write_scratch_vcpu(ARMCPU *cpu, int cpufd,
 {
     g_assert_not_reached();
 }
+
+int kvm_arm_create_init_scratch_vcpu(ARMCPU *cpu, int *fdarray, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_destroy_scratch_host_vcpu(int *fdarray)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 840501f9bf..ebe4f408e2 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2228,6 +2228,19 @@ static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
     }
 }
 
+int kvm_arm_create_init_scratch_vcpu(ARMCPU *cpu, int *fdarray, Error **errp)
+{
+    struct kvm_vcpu_init init = {.target = cpu->kvm_target, };
+
+    kvm_arm_vcpu_prepare_init_features(cpu);
+    memcpy(init.features, cpu->kvm_init_features, sizeof(init.features));
+
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init, errp)) {
+        return -1;
+    }
+    return fdarray[2];
+}
+
 int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
 {
     int ret;
-- 
2.53.0


