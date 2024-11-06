Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E247D35E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 02:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8W7o-0007Bp-F6; Tue, 05 Nov 2024 21:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7m-0007BQ-O6
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:50:26 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7l-0003d6-0v
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730861425; x=1762397425;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9AuyQrZYSzpVA3FJlyTq2ttbB88VVZZG/V9oVSStOkA=;
 b=VXlBmCNelqYELmuQJP+qwIjlpWReC5gEPjHxjdTLtqoHvzgsEZC2dkEV
 44ypGqEdMY9Fsp+VCo1WFirVunrthLJEX3rZ1mBkIqB8ckWiNndgDX0uv
 q0CdqCSpsMXeqVRzrd0BfsSQnMcjPHbMlha7CFnmS1NWaAztC/Zq6AuEc
 Q8EXzI+w0DRI2iYxEd6GIwq5sw/7kJMAQ3o1alifIFTva9sIJ5ArreOQH
 R64vLRTjj8tjplW2gt6aq42KQDo1UiNCcgkMy6G42vJEm1RYnE3j/psKZ
 XvL+bbUYtnni0fX0x7WWVWQ0jMvDRGPiLvSTln9DgeKltxW0pnuNAonNW g==;
X-CSE-ConnectionGUID: zGzZ8vs4RbW5wvWSAzDBjA==
X-CSE-MsgGUID: 8NoJAtJ1Q+21EpaeEhwxGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30492330"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30492330"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 18:50:24 -0800
X-CSE-ConnectionGUID: Xc1MDl7tSfCEEqJ32ZjcVg==
X-CSE-MsgGUID: k7B4qdF5SEW5pn0ojYmSlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="115078037"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2024 18:50:20 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 11/11] target/i386/kvm: Replace ARRAY_SIZE(msr_handlers)
 with KVM_MSR_FILTER_MAX_RANGES
Date: Wed,  6 Nov 2024 11:07:28 +0800
Message-Id: <20241106030728.553238-12-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106030728.553238-1-zhao1.liu@intel.com>
References: <20241106030728.553238-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Zide Chen <zide.chen@intel.com>
---
v4: new commit.
---
 target/i386/kvm/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 013c0359acbe..501873475255 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5885,7 +5885,7 @@ static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
 {
     int i, ret;
 
-    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
+    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
         if (!msr_handlers[i].msr) {
             msr_handlers[i] = (KVMMSRHandlers) {
                 .msr = msr,
@@ -5911,7 +5911,7 @@ static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
     int i;
     bool r;
 
-    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
+    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
         KVMMSRHandlers *handler = &msr_handlers[i];
         if (run->msr.index == handler->msr) {
             if (handler->rdmsr) {
@@ -5931,7 +5931,7 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
     int i;
     bool r;
 
-    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
+    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
         KVMMSRHandlers *handler = &msr_handlers[i];
         if (run->msr.index == handler->msr) {
             if (handler->wrmsr) {
-- 
2.34.1


