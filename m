Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B780C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 03:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzpK6-0006m3-H4; Wed, 24 Apr 2024 22:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpK3-0006kb-PK; Wed, 24 Apr 2024 22:58:55 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpK2-00056p-1Z; Wed, 24 Apr 2024 22:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714013934; x=1745549934;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jxtgf1M3qa4QDchG9UoRAqtFphtYY47nm2E2h9u0rZg=;
 b=IZ4dBFyXwbXkwH/Ko/9w3nHSVWPi0y7YHOGZq8IhYkbEGAvMb9qxiM3p
 ZYnuCJ4OJcdv0/reMrtRc2F/DLoy1dqsNYTdvpVg1CeRfQVmoLkBnEkOF
 ZTfw2B7QvOqkHXy+BmDmRgI/qDuBm4ZySEYry0HxhfG3J5AQLLSGo7xwO
 gZqKmgWfTeT6Wy1FsKTIka0Yn2gZVNnSHS7LmB7DLZmT+pwYalaRPzerk
 iQIx3986KZS7dg9YZBTHzni4OZiWFtAKZgarIEzwwIlDfxFn9TPMyP+17
 6Pu2mv5yZYBxqpAM23e7PbXy0rFHsCWIgSTrFJnlGXX2Be7H93LBtNEqA Q==;
X-CSE-ConnectionGUID: EHuS73anQkaDNCjop7BU0Q==
X-CSE-MsgGUID: 5dUv/oiDTQm48S+r/73etw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9605659"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9605659"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 19:58:53 -0700
X-CSE-ConnectionGUID: 2D4+rdj2Rk2Ul8hZ6el77Q==
X-CSE-MsgGUID: 3bn1xvccS+es8iX86Lrvzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="62395695"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 24 Apr 2024 19:58:50 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 4/7] target/s390x/cpu_models: Make
 kvm_s390_get_host_cpu_model() return boolean
Date: Thu, 25 Apr 2024 11:12:29 +0800
Message-Id: <20240425031232.1586401-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425031232.1586401-1-zhao1.liu@intel.com>
References: <20240425031232.1586401-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As error.h suggested, the best practice for callee is to return
something to indicate success / failure.

So make kvm_s390_get_host_cpu_model() return boolean and check the
returned boolean in get_max_cpu_model() instead of accessing @err.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/s390x/cpu_models.c |  9 ++++-----
 target/s390x/cpu_models.h |  2 +-
 target/s390x/kvm/kvm.c    | 13 +++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 052540a866ac..a0e4acb707d7 100644
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
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index a89c2a15ab54..c14aff6c10eb 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -115,7 +115,7 @@ S390CPUDef const *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
                                     S390FeatBitmap features);
 
 bool kvm_s390_cpu_models_supported(void);
-void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
+bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
 void kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp);
 
 #endif /* TARGET_S390X_CPU_MODELS_H */
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 4dcd757cdcc3..2c3e05cae3ad 100644
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
2.34.1


