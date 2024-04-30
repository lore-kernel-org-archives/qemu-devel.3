Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5FCC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgm-0000xb-EN; Tue, 30 Apr 2024 03:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgi-0000rz-5O
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgW-0008Kf-Nu
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05oqEDz5KwUeioEyNmyoXbha30Hu1Itn6Cf0RilAPW8=;
 b=iwjhWW3sK2zQoliEyksh3MQbkAf8eNVDA6LYy5WQQqs45AeiP3VxxPVlBrfUKZA0SdRIS8
 o0bypnJ3pvB923ht4qqdJclyViKBoBFRayqX2HL5r21Yd4JybmLOlpFwg+50lfQzYLYeO4
 hsVRckdkgyJAI/eAL2a+BAxCQH24/8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-pn13grocMFaEqqLOPENGbQ-1; Tue, 30 Apr 2024 03:13:48 -0400
X-MC-Unique: pn13grocMFaEqqLOPENGbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EECDC80021A;
 Tue, 30 Apr 2024 07:13:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3E9540C6DAE;
 Tue, 30 Apr 2024 07:13:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 03/19] target/s390x/cpu_models: Make
 kvm_s390_get_host_cpu_model() return boolean
Date: Tue, 30 Apr 2024 09:13:24 +0200
Message-ID: <20240430071340.413305-4-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

So make kvm_s390_get_host_cpu_model() return boolean and check the
returned boolean in get_max_cpu_model() instead of accessing @err.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240425031232.1586401-5-zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.h |  2 +-
 target/s390x/cpu_models.c |  9 ++++-----
 target/s390x/kvm/kvm.c    | 13 +++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index a89c2a15ab..c14aff6c10 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -115,7 +115,7 @@ S390CPUDef const *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
                                     S390FeatBitmap features);
 
 bool kvm_s390_cpu_models_supported(void);
-void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
+bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
 void kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp);
 
 #endif /* TARGET_S390X_CPU_MODELS_H */
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 052540a866..a0e4acb707 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -560,16 +560,15 @@ S390CPUModel *get_max_cpu_model(Error **errp)
     }
 
     if (kvm_enabled()) {
-        kvm_s390_get_host_cpu_model(&max_model, &err);
+        if (!kvm_s390_get_host_cpu_model(&max_model, &err)) {
+            error_propagate(errp, err);
+            return NULL;
+        }
     } else {
         max_model.def = s390_find_cpu_def(QEMU_MAX_CPU_TYPE, QEMU_MAX_CPU_GEN,
                                           QEMU_MAX_CPU_EC_GA, NULL);
         bitmap_copy(max_model.features, qemu_max_cpu_feat, S390_FEAT_MAX);
     }
-    if (err) {
-        error_propagate(errp, err);
-        return NULL;
-    }
     cached = true;
     return &max_model;
 }
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 4dcd757cdc..2c3e05cae3 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2375,7 +2375,7 @@ bool kvm_s390_cpu_models_supported(void)
                              KVM_S390_VM_CPU_MACHINE_SUBFUNC);
 }
 
-void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
+bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
 {
     struct kvm_s390_vm_cpu_machine prop = {};
     struct kvm_device_attr attr = {
@@ -2390,14 +2390,14 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
 
     if (!kvm_s390_cpu_models_supported()) {
         error_setg(errp, "KVM doesn't support CPU models");
-        return;
+        return false;
     }
 
     /* query the basic cpu model properties */
     rc = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
     if (rc) {
         error_setg(errp, "KVM: Error querying host CPU model: %d", rc);
-        return;
+        return false;
     }
 
     cpu_type = cpuid_type(prop.cpuid);
@@ -2420,13 +2420,13 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
     rc = query_cpu_feat(model->features);
     if (rc) {
         error_setg(errp, "KVM: Error querying CPU features: %d", rc);
-        return;
+        return false;
     }
     /* get supported cpu subfunctions indicated via query / test bit */
     rc = query_cpu_subfunc(model->features);
     if (rc) {
         error_setg(errp, "KVM: Error querying CPU subfunctions: %d", rc);
-        return;
+        return false;
     }
 
     /* PTFF subfunctions might be indicated although kernel support missing */
@@ -2482,7 +2482,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
     }
     if (!model->def) {
         error_setg(errp, "KVM: host CPU model could not be identified");
-        return;
+        return false;
     }
     /* for now, we can only provide the AP feature with HW support */
     if (ap_available()) {
@@ -2506,6 +2506,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
     /* strip of features that are not part of the maximum model */
     bitmap_and(model->features, model->features, model->def->full_feat,
                S390_FEAT_MAX);
+    return true;
 }
 
 static int configure_uv_feat_guest(const S390FeatBitmap features)
-- 
2.44.0


