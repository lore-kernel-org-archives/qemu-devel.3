Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68200C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzpKA-0006o8-LS; Wed, 24 Apr 2024 22:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpK9-0006nd-7e; Wed, 24 Apr 2024 22:59:01 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpK7-00056p-1C; Wed, 24 Apr 2024 22:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714013939; x=1745549939;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e3Q+Y5fMB14WcsrZBnrBXX5kf/gMjWQSeAZQ0eh6Sn4=;
 b=VJN/clOxgI4C1mwZoPKb48ib1TuIfe6sHr+0g+6Q3Qt5IP9no5YoQW5L
 Ga5flecChpQP+KJxzSUmXMZs+WBIy9lYWCsuHowvTK/NLhIb2DmtkIF0j
 N4y6/Ga1HIdBIWvvBbyI+RZb+pS7wXVkZKPctpruUjMMbUCwg/ko/lSza
 HJdH2hpCOkxN3qnLvwdSAUbXdQA7Kbp/327o0Ii4mhUNpQLkh2nGbph7I
 fVjuHAHU5qnXQuWMhMNiyjAVNuAGSozvQX3QTFJQjkzXTsdHRQPG7J0bL
 R1nTGd2jfGC/AztF+KjTff4P48dk05AAzXDCujvG9+m8dlYhpMx9Os2UJ A==;
X-CSE-ConnectionGUID: 0dxDiO87THSr5mheqpFILg==
X-CSE-MsgGUID: bUNlFC/hT+CQdmBXtQi7Xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9605676"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9605676"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 19:58:58 -0700
X-CSE-ConnectionGUID: lwxtQvbXRH+zMZxhfd7zuw==
X-CSE-MsgGUID: adUQ7ZllTseej1kEUkDZXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="62395708"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 24 Apr 2024 19:58:56 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 6/7] target/s390x/cpu_models: Make
 kvm_s390_apply_cpu_model() return boolean
Date: Thu, 25 Apr 2024 11:12:31 +0800
Message-Id: <20240425031232.1586401-7-zhao1.liu@intel.com>
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

So make kvm_s390_apply_cpu_model() return boolean and check the
returned boolean in apply_cpu_model() instead of accessing @err.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.h        |  2 +-
 target/s390x/cpu_models_sysemu.c |  3 +--
 target/s390x/kvm/kvm.c           | 15 ++++++++-------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index c14aff6c10eb..71d4bc2dd4a2 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -116,6 +116,6 @@ S390CPUDef const *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
 
 bool kvm_s390_cpu_models_supported(void);
 bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
-void kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp);
+bool kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp);
 
 #endif /* TARGET_S390X_CPU_MODELS_H */
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 2d99218069cb..bf855c659d5e 100644
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
index 2c3e05cae3ad..1b494ecc2076 100644
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
2.34.1


