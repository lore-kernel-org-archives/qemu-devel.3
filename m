Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119F7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzX4N-0003ZZ-7V; Wed, 24 Apr 2024 03:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rzX4I-0003ZL-Uy
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:29:27 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rzX4G-000688-Rm
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713943765; x=1745479765;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QGuX1De+ZVyPLDbv0VL8aMFNXcUg6PToPq/JFscTSE0=;
 b=Xp1gVQe63kki8i5iKB7W1KX7Rgzg4VaxCUrDMPCyD2GHPSW2sET51yJ6
 4KGyependDgOiqRSh0mL7G+Cws2hEvQLGnRR2FrKViA+7oxFUf6oNA6BI
 SYPI8IY0fvg7e6DB0Tvr6aiLR2HIKwQ+rZBQPBHfXRLcQg8yQi00Hj4tc
 omJHdo2+MSZX7mWaXmEQgdK+Emjtf+3FhoBHcPXm4/OxIcAxKKUJ7prdV
 l3a9dX63eI7wqr78RZARcjKmmqPsZbG0tftwO8T19WOswTEg8Wt47Z2fD
 AfFKLCBGqkaa967iFKZtdPglyUCclpkHh9GArFGCmkvI1zhZJUy1YdLZH w==;
X-CSE-ConnectionGUID: S3BDsqF2TwqQSSYu+zdNPg==
X-CSE-MsgGUID: peI16BpSQoij1KWXYERv/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="32049627"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; d="scan'208";a="32049627"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 00:29:18 -0700
X-CSE-ConnectionGUID: 6LUCR4jVSd2OWqgFzM7j5g==
X-CSE-MsgGUID: eREagEaNQo6Q1kYYwqFCzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; d="scan'208";a="55829706"
Received: from sqa-gate.sh.intel.com (HELO emr-bkc.tsp.org) ([10.239.48.212])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 00:29:15 -0700
From: Lei Wang <lei4.wang@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, manish.mishra@nutanix.com, xiaoyao.li@intel.com,
 chenyi.qiang@intel.com, tao1.su@linux.intel.com
Subject: [PATCH] target/i386: Introduce SapphireRapids-v3 to add missing
 features
Date: Wed, 24 Apr 2024 03:29:12 -0400
Message-Id: <20240424072912.43188-1-lei4.wang@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

Add the missing features(ss, tsc-adjust, cldemote, movdiri, movdir64b) in
the SapphireRapids-v3 CPU model.

Signed-off-by: Lei Wang <lei4.wang@intel.com>
---
 target/i386/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fd6af0d763..77e7945152 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3970,6 +3970,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 }
             },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "ss", "on" },
+                    { "tsc-adjust", "on" },
+                    { "cldemote", "on" },
+                    { "movdiri", "on" },
+                    { "movdir64b", "on" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ }
         }
     },
-- 
2.39.3


