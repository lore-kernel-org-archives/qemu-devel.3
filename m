Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7C2C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq98A-000296-3h; Fri, 29 Mar 2024 06:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rq97z-00026W-2A
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:06:28 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rq97x-00017E-82
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711706785; x=1743242785;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5YnpqPAXnQgSLnwyieSH2PQh+ZNUxgYyQ1OBV3sT/yg=;
 b=Ka4xH/kX4X2LeMFlVTPn+SbJM/A4y8rjnNtiknOGmvk69t+r7JBpVF4u
 PLAlxl3wM47rlQwsA+FA7ClsNTMCIe1vVGxr4Akv8+cqBSLPM2oGwfZNQ
 BKElJtTg0HH4DsqiscZdlBM82f//7/gcnilfomIsPDUtpGM9YbwXDMU3j
 xMC+NJF0REL+dq9Gqk/EhZXdIgAdEgoToejqXjvVkvIlvBy8O6/x1fKxx
 WSwnnl0RfRZDBiMWzj3fSj3hHwn57smk8umTcpwq45QwlEnROf+aETYYB
 tm6HAfew4s7ap0cQvSCdQKdQO1mGgtK5Tznlla55rL9B0iK6+gmHfDm6a Q==;
X-CSE-ConnectionGUID: vbpDncvrSDy7HeD5LYWovA==
X-CSE-MsgGUID: p5+2ZrGCQICvTxR76/Cpcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17519239"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="17519239"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 03:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="21441985"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Mar 2024 03:06:21 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH for-9.1 6/7] target/i386: Fix duplicated kvmclock name in
 FEAT_KVM
Date: Fri, 29 Mar 2024 18:19:53 +0800
Message-Id: <20240329101954.3954987-7-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Tim Wiederhake <twiederh@redhat.com>

The commit 642258c6c7 ("kvm: add kvmclock to its second bit") gave the
old and new kvmclocks with the same name "kvmclock", to facilitate user
to set/unset the feature bits for both 2 kvmclock features together.

This could work because:
* QEMU side:
  - x86_cpu_register_bit_prop() supports "the same property name can be
    registered multiple times to make it affect multiple bits in the
    same FeatureWord".
* KVM side:
  - The only difference between 2 version kvmclocks is their MSRs have
    different addresses.
  - When 2 kvmclocks are both enabled, KVM will prioritize the use of
    new kvmclock's MSRs.

However, there're reasons we need give the second kvmclock a new name:
* Based on the KVM mechanism, it doesn't make sense to bind two
  kvmclocks together. Since kvmclock is enabled by default in most cases
  as a KVM PV feature, the benefit of the same naming is reflected in
  the fact that -kvmclock can disable both. But, following the KVM
  interface style (i.e., separating the two kvmclocks) is clearly
  clearer to the user.
* For developers, identical names have been creating confusion along
  with persistent doubts about the naming.
* FeatureWordInfo should define names based on hardware/Host CPUID bit,
  and the name is used to distinguish the bit.
* User actions based on +/- feature names should only work on
  independent feature bits. The common effect of multiple features
  should be controlled by an additional CPU property or additional code
  logic to show the association between different feature bits.
* The old kvmclock will eventually be removed. Different naming can ease
  the burden of future cleanups.

Therefore, rename the new kvmclock feature as "kvmclock2".

Additionally, add "kvmclock2" entry in kvm_default_props[] since the
oldest kernel supported by QEMU (v4.5) has supported the new kvm clock.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Based on Tim's original patch, rewrote the commit message and added the
tiny fix for compatibility.
---
 target/i386/cpu.c         | 2 +-
 target/i386/kvm/kvm-cpu.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b6caf071a6d..0a1dac60f5de 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -855,7 +855,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_KVM] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
+            "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock2",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
             NULL, "kvm-pv-tlb-flush", "kvm-asyncpf-vmexit", "kvm-pv-ipi",
             "kvm-poll-control", "kvm-pv-sched-yield", "kvm-asyncpf-int", "kvm-msi-ext-dest-id",
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index ae3cb27c8aa8..753f90c18bd6 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -77,7 +77,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
 
     if (cpu->legacy_kvmclock) {
         /*
-         * The old and new kvmclock are both set by default from the
+         * The kvmclock and kvmclock2 are both set by default from the
          * oldest KVM supported (v4.5, see "OS requirements" section at
          * docs/system/target-i386.rst). So when one of them is missing,
          * it is only possible that the user is actively masking it.
@@ -179,6 +179,7 @@ static void kvm_cpu_xsave_init(void)
  */
 static PropValue kvm_default_props[] = {
     { "kvmclock", "on" },
+    { "kvmclock2", "on" },
     { "kvm-nopiodelay", "on" },
     { "kvm-asyncpf", "on" },
     { "kvm-steal-time", "on" },
-- 
2.34.1


