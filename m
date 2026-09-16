Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0E2C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6qxO-00021A-JJ; Wed, 16 Sep 2026 10:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qxH-0001Gv-89
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qxE-0006pK-OP
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789570183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dBJ5GLKEsBXPj8B/DijWFLtxBgu3dGuSeoZoL9j1+VQ=;
 b=buXII69J27WMdS9lAnArVN7qf+as66Jhp1Zy+h/BA/kHqqaVAxejQH96jc7FZ//El0dXyi
 2hZB50pQjegkOLxYUhyOGIXogOz/GoKsXQwjepimzbpNbA2BUwh3IPtIkXQw0d+k85uFP3
 7vjZFG2+n1+a/pI62vnP6zkn4PKGf40=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-V_-kREX8MniLi9F5W18BYw-1; Wed,
 16 Sep 2026 10:49:40 -0400
X-MC-Unique: V_-kREX8MniLi9F5W18BYw-1
X-Mimecast-MFC-AGG-ID: V_-kREX8MniLi9F5W18BYw_1789570178
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FA1D18005BA; Wed, 16 Sep 2026 14:49:38 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39E2E19560AB; Wed, 16 Sep 2026 14:49:33 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v9 24/26] target/arm/kvm: Introduce
 kvm_arm_create_init_scratch_vcpu()
Date: Wed, 16 Sep 2026 16:45:47 +0200
Message-ID: <20260916144721.751810-25-eric.auger@redhat.com>
In-Reply-To: <20260916144721.751810-1-eric.auger@redhat.com>
References: <20260916144721.751810-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 target/arm/kvm_arm.h  | 11 +++++++++++
 target/arm/kvm-stub.c | 10 ++++++++++
 target/arm/kvm.c      | 14 ++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 185018e00c..4ce58d6b0e 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -118,6 +118,17 @@ struct kvm_vcpu_init;
 bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
                                       struct kvm_vcpu_init *init, Error **errp);
 
+/**
+ * kvm_arm_create_init_scratch_vcpu:
+ * Create and initialize a scratch vcpu inheriting the features set
+ * on the vcpu
+ *
+ * Return the vcpu fd on success or -1 on failure with a corresponding
+ * Error handle
+ */
+int kvm_arm_create_init_scratch_vcpu(ARMCPU *cpu, Error **errp);
+
+
 /**
  * kvm_arm_destroy_scratch_host_vcpu:
  * @fdarray: array of fds as set up by kvm_arm_create_scratch_host_vcpu
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 8e6fae0a4d..dd2e94e45f 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -126,3 +126,13 @@ bool kvm_idreg_write_scratch_vcpu(ARMCPU *cpu, int cpufd,
 {
     g_assert_not_reached();
 }
+
+int kvm_arm_create_init_scratch_vcpu(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_destroy_scratch_host_vcpu(int *fdarray)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a459942a73..800e5f3020 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2485,6 +2485,20 @@ static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
     }
 }
 
+int kvm_arm_create_init_scratch_vcpu(ARMCPU *cpu, Error **errp)
+{
+    struct kvm_vcpu_init init = {.target = cpu->kvm_target, };
+    int fdarray[3];
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


