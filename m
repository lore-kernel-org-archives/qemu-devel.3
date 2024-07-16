Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA0FC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkWj-0000Ys-2K; Tue, 16 Jul 2024 11:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkWc-0000BN-Bx
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:55:36 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkWY-0007Rv-QX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721145331; x=1752681331;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tdtgldsaF/+mVcySq07MM+0QKRZwCNCIky3jLeqq+yU=;
 b=SeTwgmpYcoodVYpWXmOAxIruboZfcLU5//XaJgJgD2yEc9nwOglL/nOy
 13KufpFd1w8F2Nrk7xXW09rpQ6UW/5Kb/slLgJJtI4i1vQhOLtH6Cse1x
 nMtEgzC2PkINZTk13b+EifHVn3UVEmN62e9xdEn33rapScC8s1jjuaI/j
 ZZN//3fNYGruDW6AFWeRZVkiXdkWK+N8OjB9d3MyOTytBf2U2t1APrcWx
 8HH8D9rXX4pbGJTTY4f+YUEm1Vm5OZXxMO6sagKlROzOv8h3qsUt9R2Md
 hm9bRqZtGonxFoN/okMPETusy3x25RewRsuXV0DvogIAfN+vD/RucwTYr g==;
X-CSE-ConnectionGUID: 7VyvnZhyQ8ai5W6V9P3n1w==
X-CSE-MsgGUID: X4SPtY1DRvam0eZ2WYhleA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18743847"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="18743847"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 08:55:22 -0700
X-CSE-ConnectionGUID: VMJ6NDNcQHG83f2ZFWlZ7Q==
X-CSE-MsgGUID: 6r8tifxbTPWlPASAB/PxKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="50788551"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 16 Jul 2024 08:55:10 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 9/9] target/i386/kvm: Replace ARRAY_SIZE(msr_handlers) with
 KVM_MSR_FILTER_MAX_RANGES
Date: Wed, 17 Jul 2024 00:10:15 +0800
Message-Id: <20240716161015.263031-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716161015.263031-1-zhao1.liu@intel.com>
References: <20240716161015.263031-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

kvm_install_msr_filters() uses KVM_MSR_FILTER_MAX_RANGES as the bound
when traversing msr_handlers[], while other places still compute the
size by ARRAY_SIZE(msr_handlers).

In fact, msr_handlers[] is an array with the fixed size
KVM_MSR_FILTER_MAX_RANGES, so there is no difference between the two
ways.

For the code consistency and to avoid additional computational overhead,
use KVM_MSR_FILTER_MAX_RANGES instead of ARRAY_SIZE(msr_handlers).

Suggested-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v4: new commit.
---
 target/i386/kvm/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index d47476e96813..43b2ea63d584 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5314,7 +5314,7 @@ int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
 {
     int i, ret;
 
-    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
+    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
         if (!msr_handlers[i].msr) {
             msr_handlers[i] = (KVMMSRHandlers) {
                 .msr = msr,
@@ -5340,7 +5340,7 @@ static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
     int i;
     bool r;
 
-    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
+    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
         KVMMSRHandlers *handler = &msr_handlers[i];
         if (run->msr.index == handler->msr) {
             if (handler->rdmsr) {
@@ -5360,7 +5360,7 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
     int i;
     bool r;
 
-    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
+    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
         KVMMSRHandlers *handler = &msr_handlers[i];
         if (run->msr.index == handler->msr) {
             if (handler->wrmsr) {
-- 
2.34.1


