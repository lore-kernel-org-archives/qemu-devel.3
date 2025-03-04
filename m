Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D15C282C6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 06:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpLMn-00061O-Ud; Tue, 04 Mar 2025 01:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpLMX-00060h-Kc
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 01:02:43 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpLMU-0001L0-Ik
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 01:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741068159; x=1772604159;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8k+gCmWzyPAX3ACsdCDd/8IJ2f0jiR58l1KDEiQjScA=;
 b=fJrG1w8O4oBELkuT3ty1uDxrjMiPvD/gQVXVEG4WDIh0Ejt6AO3+SY4M
 WUNr0x2telS4R+y8dFN19wwOBOxK7bP0QQZJsR3CVKzK6LyD2y17xqGfe
 wDOJr3wHCx4cXxDoTLUqO5FNJOBThp1Uf+MgcD/xbkH/v3DRqrcGXTBuH
 yopj+QVgNzQh3oxy/p46I60GgayjWcvdU4XVkN4bSjD32z6sEKtAniGmv
 HhuLGy93WGYHpIKGunyIzfac5knNsaxH+uWsXOKzZKEpr3gkAiLAzdo6R
 V3OBvdnS25/Ld7WgL1QP09Gq0FsiEKWPAgGWVV27oTEkyssKrPTjhwjkT A==;
X-CSE-ConnectionGUID: f12wO2zSSPaCd/PFx2DvMw==
X-CSE-MsgGUID: PMSUNWfcRoG0ESruSGmIrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59519162"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="59519162"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 22:02:29 -0800
X-CSE-ConnectionGUID: A4joGlkCQcuDAq4v+lkWpw==
X-CSE-MsgGUID: 3/+5H1xiSByWglAs4JXM1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118132363"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 03 Mar 2025 22:02:27 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH 0/2] i386: Adjust CPUID_EXT_PDCM based on enable_pmu at
 realization
Date: Tue,  4 Mar 2025 00:24:48 -0500
Message-Id: <20250304052450.465445-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

First, it's not a good practice that values in env->features[] cannot be
directly used for guest CPUID in void cpu_x86_cpuid(), but require further
adjustment there. env->features[] are supposed to be finalized at cpu
realization, so that after it env->features[] is reliable.

Second, there is one dependency entry relates to CPUID_EXT_PDCM in
feature_dependencies[]. QEMU needs to get correct value of
CPUID_EXT_PDCM in env->features[] to ensure applying the dependencies
correctly.

Patch 1 resolves above two points.

Patch 2 is a enhancement to give users a warning when they request pdcm
explicitly while PMU disabled.

Xiaoyao Li (2):
  i386/cpu: Move adjustment of CPUID_EXT_PDCM before
    feature_dependencies[] check
  i386/cpu: Warn about why CPUID_EXT_PDCM is not available

 target/i386/cpu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.34.1


