Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8561DC54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 14:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkPz5-00067w-CB; Wed, 13 Mar 2024 10:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1rkPz1-00067j-JO
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:53:32 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1rkPyz-000281-LJ
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710341609; x=1741877609;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=XOemtsi8vdmeDqBW+6o4uTJO0rOcvSG7dIYrpbWw3oQ=;
 b=ersHc6qC8QxdQpKZ6F/QcZMno28XYCoBuZpRMN5Ppz5YX5MMslZXHrSL
 9yNokhVF5AocY61tggjospt4tkEZ9RpTWemrU7s+rMvwavyEvajiuLATT
 P9et2NqhOh3tPIRXdIHHvuJUhAgSd9EVNotvJ0SLdqmNxtnxuQbTofnqS
 pc3+4AUVFC14mGJD3Ysg6WgUOkMX/152u0sXUlTJiss58I55PrDxdmSOh
 5CnGb0WAIaIDaM8EMjaFSK/sUPWw8h9lXe8A2n+c3+ODbPJUfBoIBKjlx
 YjzSFoI/RMHBRxx1QRmMVy51OjgqGhjSmDVf4n69gWElEYTVlGQICMc6u A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15834796"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; d="scan'208";a="15834796"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2024 07:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; d="scan'208";a="11981940"
Received: from tnbowmax-mobl.amr.corp.intel.com (HELO desk) ([10.212.137.40])
 by orviesa009-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:53:25 -0700
Date: Wed, 13 Mar 2024 07:53:23 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Chao Gao <chao.gao@intel.com>,
 antonio.gomez.iglesias@linux.intel.com,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: [PATCH] target/i386: Export RFDS bit to guests
Message-ID: <9a38877857392b5c2deae7e7db1b170d15510314.1710341348.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: none client-ip=192.198.163.9;
 envelope-from=pawan.kumar.gupta@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) AC_FROM_MANY_DOTS=2.497, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.971, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Register File Data Sampling (RFDS) is a CPU side-channel vulnerability
that may expose stale register value. CPUs that set RFDS_NO bit in MSR
IA32_ARCH_CAPABILITIES indicate that they are not vulnerable to RFDS.
Similarly, RFDS_CLEAR indicates that CPU is affected by RFDS, and has
the microcode to help mitigate RFDS.

Make RFDS_CLEAR and RFDS_NO bits available to guests.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9a210d8d9290..693a5e0fb2ce 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1158,8 +1158,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
             NULL, "fb-clear", NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "pbrsb-no", NULL, "gds-no", NULL,
-            NULL, NULL, NULL, NULL,
+            "pbrsb-no", NULL, "gds-no", "rfds-no",
+            "rfds-clear", NULL, NULL, NULL,
         },
         .msr = {
             .index = MSR_IA32_ARCH_CAPABILITIES,

base-commit: a1932d7cd6507d4d9db2044a54731fff3e749bac
-- 
2.34.1


