Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CC0E68960
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 08:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6R1F-0000rP-FU; Thu, 31 Oct 2024 04:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R1A-0000mJ-DI
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:59:00 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R18-0003Gu-Mo
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730365139; x=1761901139;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X/D2vNdScCHmz0+RWJ9LwHGG/iCwnHpfrXS7AkXMf9I=;
 b=C93mkFydpJXkWEMn6CryTrCFX8H8r+XGezBEqEc2nZbpgdqFZAx/4Vf2
 OXjq+XDulsUgeH+MgJ60bWrpVF+22nt0HpA3P2axvWXus+cgkWaFZvc3+
 tNvrfF2/BAHLze1aBSz7pb+j2HgnKfhI57P18/RI9xY626J4H1ZSReefA
 A0ZP2UOakwC4or4WPSkbjvzzQVV0kJ9VLoY95YBFQoQsq8oXBbWW8VMcw
 AxQ4Di0INfIBQn5iry9CTU/uyNONsxxyWUXWmBySBiIuRbL299zNhGUt7
 vVAb72wswHdgoEo7IgQThJRaX+FvfdAc/JiQJ5AtCV+kG8cIP9v6i4rsM w==;
X-CSE-ConnectionGUID: UbiHwaeLRIeAP4zcK0ozAw==
X-CSE-MsgGUID: LPbobEWCTLmdlCOFFadN0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55492766"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="55492766"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 01:58:38 -0700
X-CSE-ConnectionGUID: BJQPn5EbQYiRKqRP8vXgLw==
X-CSE-MsgGUID: Un6EcnpVQAqn66k/DCBiXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82489581"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa010.jf.intel.com with ESMTP; 31 Oct 2024 01:58:36 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v3 8/8] target/i386: Introduce GraniteRapids-v2 model
Date: Thu, 31 Oct 2024 16:52:33 +0800
Message-Id: <20241031085233.425388-9-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031085233.425388-1-tao1.su@linux.intel.com>
References: <20241031085233.425388-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Update GraniteRapids CPU model to add AVX10 and the missing features(ss,
tsc-adjust, cldemote, movdiri, movdir64b).

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241028024512.156724-7-tao1.su@linux.intel.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cc7e4ce665..8846314775 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4381,6 +4381,23 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (GraniteRapids)",
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "ss", "on" },
+                    { "tsc-adjust", "on" },
+                    { "cldemote", "on" },
+                    { "movdiri", "on" },
+                    { "movdir64b", "on" },
+                    { "avx10", "on" },
+                    { "avx10-128", "on" },
+                    { "avx10-256", "on" },
+                    { "avx10-512", "on" },
+                    { "avx10-version", "1" },
+                    { "stepping", "1" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.34.1


