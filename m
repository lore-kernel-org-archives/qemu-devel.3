Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42D2C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 02:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta3nJ-00023j-P1; Mon, 20 Jan 2025 21:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1ta3nI-00023D-0Z
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 21:15:08 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1ta3nG-0002n1-DL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 21:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737425707; x=1768961707;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XTfta7ONUOxsfA5PdRCrhWIh3f0K363C/r73/SFk49A=;
 b=Voq3Qp4FGenBjmFQm/quQ2ST4GC+VBet6oK2jfjoqTwehUvv2utibdS8
 ciTzPWAphMfzg3LlfSTrfv7g/8mvJH2sEx41GfkUoKxUrT3JRETiM9KGL
 cA8gN134hGe5qHvzQKVD7I7bAqTWEClqSP8vPTNiEp3EWTg6q+jBHIrqK
 5sFqXbER5Bk8u0AfajL4QycitYEiT2G6VBsyw4+D1S0ijPhjBrEZ+LzYU
 RwdmrdrnvYJzhZMxKCroyfhdpt04iukvHPjwo/TQTzGszqxWQZG4zE1tp
 wKyx2a2mFDMID1ggGTDsyYk2T8J5Am9ltXMjlVozrdpbQxsHoKRI0gKX/ Q==;
X-CSE-ConnectionGUID: AqsktypUSoyFS7ev089tQw==
X-CSE-MsgGUID: 1ZdVNK0KRK6DCRdisklguA==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="48320155"
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="48320155"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 18:15:03 -0800
X-CSE-ConnectionGUID: ngaJ5KzcSkW99zZJBV/I2Q==
X-CSE-MsgGUID: hoJDec7PRtCepx769v9Vjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="106599359"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmviesa007.fm.intel.com with ESMTP; 20 Jan 2025 18:15:00 -0800
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@linux.intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH 1/4] target/i386: Introduce SierraForest-v2 model
Date: Tue, 21 Jan 2025 10:06:47 +0800
Message-Id: <20250121020650.1899618-2-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121020650.1899618-1-tao1.su@linux.intel.com>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Update SierraForest CPU model to add LAM, 4 bits indicating certain bits
of IA32_SPEC_CTR are supported(intel-psfd, ipred-ctrl, rrsba-ctrl,
bhi-ctrl) and the missing features(ss, tsc-adjust, cldemote, movdiri,
movdir64b)

Also add GDS-NO and RFDS-NO to indicate the related vulnerabilities are
mitigated in stepping 3.

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b9c11022c..6db8d6c9ba 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4549,6 +4549,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (SierraForest)",
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
+                    { "gds-no", "on" },
+                    { "rfds-no", "on" },
+                    { "lam", "on" },
+                    { "intel-psfd", "on"},
+                    { "ipred-ctrl", "on"},
+                    { "rrsba-ctrl", "on"},
+                    { "bhi-ctrl", "on"},
+                    { "stepping", "3" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.34.1


