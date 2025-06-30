Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4BBC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 08:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW9e9-0003vE-Fm; Mon, 30 Jun 2025 04:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uW9e6-0003v2-Sx
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:13:46 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uW9e1-0008FC-DZ
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751271221; x=1782807221;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kNtZV9/4wlO7pqV3WzMD6Mjh7KpcJBsVr0n4r4zy9PY=;
 b=P4oMrrGKMvRd7fw2CHj4uCHN/ovCUcOgmekS77dzdAWjFGAEvaKgAUL/
 B8RDd1SW6P9Vw3cPGwvORB08s75mGXUfZq8hzbZb1nVcGiDMJYf+BJLu+
 H1OiHtw5UErUsEc4gp1vwnSFcv9U2Z93ttM2hKeR9nj9a4of63MtDyS+v
 Lp1Rpynj/h+C7NpWpP4zlZ0yqwsTEnDXGNVh7gcF2GuJ+mCLX2+Rb77Ck
 EuX8dTi0LnJoXKVEsf0Tt7iSdM5CCYvTF8OH33PhWJSkS7o6zRctHlXCU
 n8sXGIq8g9gKcNkFql3Z6xQHjo0lkb/TBJepGpkgtzj4qLdpdMonKnNWj g==;
X-CSE-ConnectionGUID: lvheu0rXRIq4F+LwqZjv+A==
X-CSE-MsgGUID: xUgEzGeTTN+P42l8/nPTGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53637391"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="53637391"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 01:13:36 -0700
X-CSE-ConnectionGUID: 0OplDfk6RQW8QVB8mJbI7Q==
X-CSE-MsgGUID: DIw/qoHeTg63ZwxRSpxmgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="152777280"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 30 Jun 2025 01:13:34 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 0/4] i386: Misc cleanup and fix  
Date: Mon, 30 Jun 2025 16:06:06 +0800
Message-ID: <20250630080610.3151956-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is a misc sereis.

The first 3 patches are cleanup and they are simple.

The last one is cleanup as well as a fix.

Xiaoyao Li (4):
  i386/cpu: Use CPUID_MODEL_ID_SZ instead of hardcoded 48
  i386: Cleanup the usage of CPUID_VENDOR_INTEL_1
  i386/kvm-cpu: Fix the indentation inside kvm_cpu_realizefn()
  i386/cpu: Unify family, model and stepping calculation for x86 CPU

 target/i386/cpu.c                | 22 +++++++++------------
 target/i386/cpu.h                | 33 +++++++++++++++++++++++++++++++-
 target/i386/host-cpu.c           |  7 +++----
 target/i386/kvm/kvm-cpu.c        |  2 +-
 target/i386/kvm/kvm.c            |  2 +-
 target/i386/tcg/decode-new.c.inc |  4 ++--
 6 files changed, 48 insertions(+), 22 deletions(-)

-- 
2.43.0


