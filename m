Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4355DC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprmO-0006rF-Da; Wed, 05 Mar 2025 11:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tprmI-0006kD-V2
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tprmG-0003iJ-Vt
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741192763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKrKWVfaY7mTGlaz0J6916fxeJzslrBJ/6kjw8FTtDA=;
 b=QTIHbMP3MZ9XxBnup2O7wmWayo0Q6cVy6IVSSxeMNzIkFbOZ1Oo21MRxyM6e01354wFEJQ
 KvXeYi+rb4uG2+dlv0crR/Sdrxn+qYF02cvkQ82y7Eh6LYHm3Tjw15aYKqTxqxZPkDJ52k
 PdqlzRpclZmmhR38vBEA4ACb3xGcyX4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-t-Y3nSZwNTSOUF1lVM-p6Q-1; Wed,
 05 Mar 2025 11:39:19 -0500
X-MC-Unique: t-Y3nSZwNTSOUF1lVM-p6Q-1
X-Mimecast-MFC-AGG-ID: t-Y3nSZwNTSOUF1lVM-p6Q_1741192757
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A00A61956059; Wed,  5 Mar 2025 16:39:16 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.67.24.9])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 146F81956095; Wed,  5 Mar 2025 16:38:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 02/14] arm/kvm: add accessors for storing host features
 into idregs
Date: Wed,  5 Mar 2025 17:38:07 +0100
Message-ID: <20250305163819.2477553-3-cohuck@redhat.com>
In-Reply-To: <20250305163819.2477553-1-cohuck@redhat.com>
References: <20250305163819.2477553-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/cpu-sysregs.h |  3 +++
 target/arm/cpu64.c       | 25 +++++++++++++++++++++++++
 target/arm/kvm.c         | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
index de09ebae91a5..54a4fadbf0c1 100644
--- a/target/arm/cpu-sysregs.h
+++ b/target/arm/cpu-sysregs.h
@@ -128,4 +128,7 @@ static const uint32_t id_register_sysreg[NUM_ID_IDX] = {
     [CTR_EL0_IDX] = SYS_CTR_EL0,
 };
 
+int get_sysreg_idx(ARMSysRegs sysreg);
+uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg);
+
 #endif /* ARM_CPU_SYSREGS_H */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8188ede5cc8a..9ae78253cb34 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -736,6 +736,31 @@ static void aarch64_a53_initfn(Object *obj)
     define_cortex_a72_a57_a53_cp_reginfo(cpu);
 }
 
+#ifdef CONFIG_KVM
+
+int get_sysreg_idx(ARMSysRegs sysreg)
+{
+    int i;
+
+    for (i = 0; i < NUM_ID_IDX; i++) {
+        if (id_register_sysreg[i] == sysreg) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg)
+{
+    return ARM64_SYS_REG((sysreg & CP_REG_ARM64_SYSREG_OP0_MASK) >> CP_REG_ARM64_SYSREG_OP0_SHIFT,
+                         (sysreg & CP_REG_ARM64_SYSREG_OP1_MASK) >> CP_REG_ARM64_SYSREG_OP1_SHIFT,
+                         (sysreg & CP_REG_ARM64_SYSREG_CRN_MASK) >> CP_REG_ARM64_SYSREG_CRN_SHIFT,
+                         (sysreg & CP_REG_ARM64_SYSREG_CRM_MASK) >> CP_REG_ARM64_SYSREG_CRM_SHIFT,
+                         (sysreg & CP_REG_ARM64_SYSREG_OP2_MASK) >> CP_REG_ARM64_SYSREG_OP2_SHIFT);
+}
+
+#endif
+
 static void aarch64_host_initfn(Object *obj)
 {
 #if defined(CONFIG_KVM)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index da30bdbb2349..2381c87e4ba1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -246,6 +246,18 @@ static bool kvm_arm_pauth_supported(void)
             kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_GENERIC));
 }
 
+/* read a sysreg value and store it in the idregs */
+static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf, ARMIDRegisterIdx index)
+{
+    uint64_t *reg;
+    int ret;
+
+    reg = &ahcf->isar.idregs[index];
+    ret = read_sys_reg64(fd, reg,
+                         idregs_sysreg_to_kvm_reg(id_register_sysreg[index]));
+    return ret;
+}
+
 static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
-- 
2.48.1


