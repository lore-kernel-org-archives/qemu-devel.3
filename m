Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED712CEBF93
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 06:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLFKA-0005lt-87; Tue, 18 Nov 2025 01:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLFJz-0005ij-PE
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 01:36:13 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLFJu-0007C4-My
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 01:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763447767; x=1794983767;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=A65mMd5lWNs6XXTjhO21knFYXJM3Yt8rXvU/WLqh2Ko=;
 b=F0NLzyjEEt0KIOmaSwEwjen2EE+SdGmpG9KNoprzbM8KQ902bEjadvwH
 FyNXNcftNgCifL2yGMLEQPlTpTrOylYFBWklqFjStVweMlhY/QPFkZMlP
 bvg4qWbD4TrzVxJ7UrvQlmuXljdpyRxVTf21AUHb05wx19M42BBBXp2+w
 Qm4MrMYepfrJYNwi1SFnmT6NpGGJTujeXZPaOOjm8hl5fASYi+9wjcQ2x
 xj5wXQJ7zF4v+4wSiA9d2IyID49q/T9DEdxAPNNhfQ770PEZeFcoGl7eO
 ykOsHYCfiHxkOKUyTRRT8i5zV9DJD3ZSItFwcAdarIkwQqDUTxMeg9C+q Q==;
X-CSE-ConnectionGUID: /KT5NToySvadmrsPHsft/w==
X-CSE-MsgGUID: GhWGiopHQF6Qfay8d2kIRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="82850935"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="82850935"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 22:36:01 -0800
X-CSE-ConnectionGUID: NHinHyBvTS+9fcI76gGa9g==
X-CSE-MsgGUID: 9zQlB8GdQYK4i39ikxw46g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="189962628"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 17 Nov 2025 22:35:59 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/5] i386/cpu: Support APX for KVM
Date: Tue, 18 Nov 2025 14:58:12 +0800
Message-Id: <20251118065817.835017-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

Hi,

This series adds APX (Advanced Performance Extensions) support in QEMU
to enable APX in Guest based on KVM.

This series is based on CET v4:

https://lore.kernel.org/qemu-devel/20251118034231.704240-1-zhao1.liu@intel.com/

And you can also find the code here:

https://gitlab.com/zhao.liu/qemu/-/commits/i386-all-for-dmr-v1.1-11-17-2025

The patches for KVM side can be found at:

https://lore.kernel.org/kvm/20251110180131.28264-1-chang.seok.bae@intel.com/


Thanks for your review!


Overview
========

Intel Advanced Performance Extensions (Intel APX) expands the Intel 64
instruction set architecture with access to more registers (16
additional general-purpose registers (GPRs) R16–R31) and adds various
new features that improve general-purpose performance. The extensions
are designed to provide efficient performance gains across a variety of
workloads without significantly increasing silicon area or power
consumption of the core. 

APX spec link (rev.07) is:
https://cdrdv2.intel.com/v1/dl/getContent/861610

At QEMU side, the enabling work mainly includes two parts:

1. save/restore/migrate the xstate of APX.
   * APX xstate is a user xstate, but it reuses MPX xstate area in
     un-compacted XSAVE buffer.
   * To address this, QEMU will reject both APX and MPX if their CPUID
     feature bits are set at the same (in Patch 1).

2. add related CPUIDs support in feature words.

Thanks and Best Regards,
Zhao
---
Zhao Liu (2):
  i386/cpu: Support APX CPUIDs
  i386/cpu: Mark apx xstate as migratable

Zide Chen (3):
  i386/cpu: Add APX EGPRs into xsave area
  i386/cpu: Cache EGPRs in CPUX86State
  i386/cpu: Add APX migration support

 target/i386/cpu.c          | 68 ++++++++++++++++++++++++++++++++++++--
 target/i386/cpu.h          | 26 +++++++++++++--
 target/i386/machine.c      | 24 ++++++++++++++
 target/i386/xsave_helper.c | 14 ++++++++
 4 files changed, 128 insertions(+), 4 deletions(-)

-- 
2.34.1


