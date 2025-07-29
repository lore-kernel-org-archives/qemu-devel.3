Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FF5C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 05:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdDZ-0001Dq-Ef; Tue, 29 Jul 2025 01:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdDG-00018m-5F
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 01:49:22 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdDD-0003Nh-T7
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 01:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753768161; x=1785304161;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MAL8ZcN3vDcsLqzYpNRIAjAE5rDaqrpRSOBZFPKgg/4=;
 b=FJgw5bZIDbKrBNDEItryM9PNk5mzj6PPlkKdyEChlLDO/MgBk075UPgr
 iUc9CHbK96HOa1p3kMz+4QyF+iov8XBnWUg1QonwTTyvjjYnWBvmEyzG0
 UWm03WKENBJ3T5wpHhs4unNAueCvs6ZOtnsdF7s1tyirN5h7Zcl+fmdhA
 MmbNfrJFfh6BbnHWR4MtgJ7hK0QIuKBU/H+mWxmgkuABpfy3CauuinlkQ
 JE2/ltlFE6YwErkw3lnbSVB4aX/IpiHXjMUT39LYxVWx/ej+Ea5akKEMB
 X3SrGv0wD4oBmrv7mqNLblgViL9lqwp0mLLH3YDhizbfQ/irqszgfWl5e w==;
X-CSE-ConnectionGUID: L2CUt4USTxGkUoigd+2wIA==
X-CSE-MsgGUID: sM3kj/P0TRGQEj8/xrr42A==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55907947"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55907947"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 22:49:16 -0700
X-CSE-ConnectionGUID: 6F0vDnGeQ16OChnklSNkMA==
X-CSE-MsgGUID: b2YQT1QxREGV6BSxGROFxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="199750954"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa001.jf.intel.com with ESMTP; 28 Jul 2025 22:49:13 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 0/2] i386/kvm: Enable SMM addrss space for i386 cpu
Date: Tue, 29 Jul 2025 13:40:21 +0800
Message-ID: <20250729054023.1668443-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.299, RCVD_IN_DNSWL_MED=-2.3,
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

Patch 1 enables the SMM address space i386 cpu under KVM.

Patch 2 gives name for each address space index.

Xiaoyao Li (2):
  i386/cpu: Enable SMM cpu addressspace
  target/i386: Define enum X86ASIdx for x86's address spaces

 accel/kvm/kvm-all.c              |  2 +-
 system/physmem.c                 |  5 -----
 target/i386/cpu.h                |  5 +++++
 target/i386/kvm/kvm-cpu.c        | 10 ++++++++++
 target/i386/kvm/kvm.c            |  7 ++++++-
 target/i386/tcg/system/tcg-cpu.c |  4 ++--
 6 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.43.0


