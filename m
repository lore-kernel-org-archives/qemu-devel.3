Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DC7CDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srHJL-0002sI-Ij; Thu, 19 Sep 2024 09:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.gao@intel.com>)
 id 1sr9RN-0001bj-9w
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 01:10:53 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.gao@intel.com>)
 id 1sr9RK-00023X-Mk
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 01:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726722651; x=1758258651;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TK45IQc09A6cua+tN+o4oqoEEfoNXkZlIHxFO6UzYiQ=;
 b=FQH2R5LLBYxTdHw313j121evTrHCxnVhDsZPxijWKsthK7DIw4M/3/rc
 T78kI232aKmMA+MmeVciSQHKC9T6sO+l2Gud23okaGvSQ8mzigyptPYSg
 Wmq4eCpvidd4aamA1yHAz6G2yXSRtcI6bMcpR0DlVgXwSigT72Lv0LsMF
 ozY/TW6vFjwUbN3adUBQaPtJdIY4WWWfsz7WjudEZ5Jjzcqk0PUaL37Fn
 e8SGUHUmZRcGbtNg7e+q0Y7alIl8v8mLB8eeK2A8E6xRYIprCGJ52o5no
 4R6zYNyZiqYeu9tTEWPGRF225uLVKuaNYaAgwmqCu/PTqis5w2HVBD1Gy g==;
X-CSE-ConnectionGUID: waoQu/buRnKjCpkQjhR9DQ==
X-CSE-MsgGUID: EZ+N5OUUQxCEXorREhJ/VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25817914"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25817914"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 22:10:47 -0700
X-CSE-ConnectionGUID: VrGo1ugBS46s1jR5GFIyJA==
X-CSE-MsgGUID: 9vdgGrpLQWm9QqQ+7/HrFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="100629752"
Received: from spr.sh.intel.com ([10.239.53.31])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 22:10:45 -0700
From: Chao Gao <chao.gao@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, jmattson@google.com,
 pawan.kumar.gupta@linux.intel.com, jon@nutanix.com,
 Chao Gao <chao.gao@intel.com>
Subject: [PATCH] target/i386: Add more features enumerated by CPUID.7.2.EDX
Date: Thu, 19 Sep 2024 13:10:11 +0800
Message-ID: <20240919051011.118309-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=chao.gao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Sep 2024 09:34:48 -0400
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

Following 5 bits in CPUID.7.2.EDX are supported by KVM. Add their
supports in QEMU. Each of them indicates certain bits of IA32_SPEC_CTRL
are supported. Those bits can control CPU speculation behavior which can
be used to defend against side-channel attacks.

bit0: intel-psfd
  if 1, indicates bit 7 of the IA32_SPEC_CTRL MSR is supported. Bit 7 of
  this MSR disables Fast Store Forwarding Predictor without disabling
  Speculative Store Bypass

bit1: ipred-ctrl
  If 1, indicates bits 3 and 4 of the IA32_SPEC_CTRL MSR are supported.
  Bit 3 of this MSR enables IPRED_DIS control for CPL3. Bit 4 of this
  MSR enables IPRED_DIS control for CPL0/1/2

bit2: rrsba-ctrl
  If 1, indicates bits 5 and 6 of the IA32_SPEC_CTRL MSR are supported.
  Bit 5 of this MSR disables RRSBA behavior for CPL3. Bit 6 of this MSR
  disables RRSBA behavior for CPL0/1/2

bit3: ddpd-u
  If 1, indicates bit 8 of the IA32_SPEC_CTRL MSR is supported. Bit 8 of
  this MSR disables Data Dependent Prefetcher.

bit4: bhi-ctrl
  if 1, indicates bit 10 of the IA32_SPEC_CTRL MSR is supported. Bit 10
  of this MSR enables BHI_DIS_S behavior.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c0..18ba958f46 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1148,8 +1148,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_7_2_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL, NULL, NULL, NULL,
-            NULL, "mcdt-no", NULL, NULL,
+            "intel-psfd", "ipred-ctrl", "rrsba-ctrl", "ddpd-u",
+            "bhi-ctrl", "mcdt-no", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.46.1


