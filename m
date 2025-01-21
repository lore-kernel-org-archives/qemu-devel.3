Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E16C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 02:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta3nM-00025H-9Y; Mon, 20 Jan 2025 21:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1ta3nJ-00023k-JW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 21:15:09 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1ta3nI-0002bj-25
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 21:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737425708; x=1768961708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/ExwcxXLZOoaeYnlfshScg6n9yUqomMAZ7vYGCbgh+o=;
 b=VdnY5FFib5qFAPXab67/lUgJdQyXzHoCWe4+UhH/jxjNs7SkYfivk5fm
 QdXzCG2z/u50vpaVl6eNE5buC11q6LAMNjg4RmIkFmt9WAsk/jZViajSZ
 pZdp96oEluWE/C/IMK4LDLsgBwEBYi7WWOLaUGgeMhgk7oHl4f4xKT5bo
 arXV8AybbTYyUU7nEUWBF87GGgDUTSWyXL+IhkOV7s1gWIQtTRYu87wvg
 qXHIYkMrewHWXyzzol76kp3Z6mHtEjLct8NKF92xC7IZsV2z0fzVbqHB+
 sI6xBC8EQ1CcxM5P2b24rFwMPO+ds+kj/zQmzKF876nfR0ZfQz47inEtL w==;
X-CSE-ConnectionGUID: Xayk4CuDTbK+ILqcCtqAyA==
X-CSE-MsgGUID: PUcOO3G+TWaGMEqO5Rr89Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="48320163"
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="48320163"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 18:15:05 -0800
X-CSE-ConnectionGUID: zqm4rBt7TZeQerLchLT24w==
X-CSE-MsgGUID: RS2vdoviRQmGB3G11ZgE1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="106599370"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmviesa007.fm.intel.com with ESMTP; 20 Jan 2025 18:15:03 -0800
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@linux.intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH 2/4] target/i386: Export BHI_NO bit to guests
Date: Tue, 21 Jan 2025 10:06:48 +0800
Message-Id: <20250121020650.1899618-3-tao1.su@linux.intel.com>
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

Branch History Injection (BHI) is a CPU side-channel vulnerability, where
an attacker may manipulate branch history before transitioning from user
to supervisor mode or from VMX non-root/guest to root mode. CPUs that set
BHI_NO bit in MSR IA32_ARCH_CAPABILITIES to indicate no additional
mitigation is required to prevent BHI.

Make BHI_NO bit available to guests.

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6db8d6c9ba..33fb27a611 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1364,7 +1364,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "taa-no", NULL, NULL, NULL,
             NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
             NULL, "fb-clear", NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "bhi-no", NULL, NULL, NULL,
             "pbrsb-no", NULL, "gds-no", "rfds-no",
             "rfds-clear", NULL, NULL, NULL,
         },
-- 
2.34.1


