Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01CEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgc-0000hU-MJ; Tue, 30 Apr 2024 03:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hga-0000gr-3y
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgY-0008Kw-Al
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyE/YM70aKyc4a3mwxYwnc9EiX20cEcKWdcCnAsoeb4=;
 b=egCY+1UCm5B6qwYzjZS1Uy1hRD/sT0Juw1Mu110UgqhwBZxKgc5G0NjIjv6xCCikYXqCRM
 M7L8O/RMXZOCNtvihAl4ROyNE6AayOgAPRt3KyPeXblqBmOdCgJh7Z5GE8AyREvc0yAYmc
 2GHCqB7ARViUjYe0T2FbhBpYbqAId6E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-Fae5nGc8NU22Oue763R8JA-1; Tue,
 30 Apr 2024 03:13:51 -0400
X-MC-Unique: Fae5nGc8NU22Oue763R8JA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 480053C0F18A;
 Tue, 30 Apr 2024 07:13:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8DA340C6DAE;
 Tue, 30 Apr 2024 07:13:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/19] target/s390x/cpu_models: Make kvm_s390_apply_cpu_model()
 return boolean
Date: Tue, 30 Apr 2024 09:13:26 +0200
Message-ID: <20240430071340.413305-6-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

As error.h suggested, the best practice for callee is to return
something to indicate success / failure.

So make kvm_s390_apply_cpu_model() return boolean and check the
returned boolean in apply_cpu_model() instead of accessing @err.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240425031232.1586401-7-zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.h        |  2 +-
 target/s390x/cpu_models_sysemu.c |  3 +--
 target/s390x/kvm/kvm.c           | 15 ++++++++-------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index c14aff6c10..71d4bc2dd4 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -116,6 +116,6 @@ S390CPUDef const *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
 
 bool kvm_s390_cpu_models_supported(void);
 bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
-void kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp);
+bool kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp);
 
 #endif /* TARGET_S390X_CPU_MODELS_H */
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 2d99218069..bf855c659d 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -405,8 +405,7 @@ void apply_cpu_model(const S390CPUModel *model, Error **errp)
     }
 
     if (kvm_enabled()) {
-        kvm_s390_apply_cpu_model(model, &err);
-        if (err) {
+        if (!kvm_s390_apply_cpu_model(model, &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 2c3e05cae3..1b494ecc20 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2543,7 +2543,7 @@ static void kvm_s390_configure_apie(bool interpret)
     }
 }
 
-void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
+bool kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
 {
     struct kvm_s390_vm_cpu_processor prop  = {
         .fac_list = { 0 },
@@ -2560,11 +2560,11 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
         if (kvm_s390_cmma_available()) {
             kvm_s390_enable_cmma();
         }
-        return;
+        return true;
     }
     if (!kvm_s390_cpu_models_supported()) {
         error_setg(errp, "KVM doesn't support CPU models");
-        return;
+        return false;
     }
     prop.cpuid = s390_cpuid_from_cpu_model(model);
     prop.ibc = s390_ibc_from_cpu_model(model);
@@ -2574,19 +2574,19 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
     rc = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
     if (rc) {
         error_setg(errp, "KVM: Error configuring the CPU model: %d", rc);
-        return;
+        return false;
     }
     /* configure cpu features indicated e.g. via SCLP */
     rc = configure_cpu_feat(model->features);
     if (rc) {
         error_setg(errp, "KVM: Error configuring CPU features: %d", rc);
-        return;
+        return false;
     }
     /* configure cpu subfunctions indicated via query / test bit */
     rc = configure_cpu_subfunc(model->features);
     if (rc) {
         error_setg(errp, "KVM: Error configuring CPU subfunctions: %d", rc);
-        return;
+        return false;
     }
     /* enable CMM via CMMA */
     if (test_bit(S390_FEAT_CMM, model->features)) {
@@ -2601,8 +2601,9 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
     rc = configure_uv_feat_guest(model->features);
     if (rc) {
         error_setg(errp, "KVM: Error configuring CPU UV features %d", rc);
-        return;
+        return false;
     }
+    return true;
 }
 
 void kvm_s390_restart_interrupt(S390CPU *cpu)
-- 
2.44.0


