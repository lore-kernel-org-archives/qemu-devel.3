Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E568AC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 02:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX9zX-0002Wx-UU; Wed, 02 Jul 2025 22:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX9zT-0002QV-FW
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:47:59 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX9zR-0007sP-DN
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751510876; x=1783046876;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IljfHVdbYHA5TemE31vaPJWRdxNzFkXx8ftoYmvK7Pg=;
 b=DOeFyB+qD0dXcBEob9LkH6coPNQAlAIFpCprotwn0ETNBHMsPardwOnC
 o5Gc0O4DapARpPMf6iQar0KFzbMw+HN90HXCIW0cvs+BTIyZxkve6SW9Z
 1MnvJ9TkQ+Y3L51Ztux1zsGlqG8hVbd0iKKuG+CsUmpBU9oC1GCmEAmf7
 nfgagu7754lMy10WwtGvAxpXoKwEDwLBjVAl9wJMRnkf5pmL9Pc+mHafH
 9tQGWbSLxwWtD47ZQXuwMz8tI44+WzAePCjQ6bbWk608WeNAkuDA1RpY1
 AnckmeUCG7JkNxfQrGNzcTontC6/pWDqD+eKkaezr4KI0utufhHObATd3 w==;
X-CSE-ConnectionGUID: RP1h2G1FS1Knudl/01Bx7Q==
X-CSE-MsgGUID: UdQ/m2AaRt+ULuMwvLswUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57499448"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="57499448"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 19:47:53 -0700
X-CSE-ConnectionGUID: pD8UBRgaT/S34ZL/qqJjFA==
X-CSE-MsgGUID: kPhuyByjQrmOFKUypSi0Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="153880355"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa007.fm.intel.com with ESMTP; 02 Jul 2025 19:47:52 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 0/4] TDX: Update the handling of <GetTdVmCallInfo> and
 implement <SetupEventNotifyInterrupt>
Date: Thu,  3 Jul 2025 10:40:16 +0800
Message-ID: <20250703024021.3559286-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

It ends up as <GetQuote> is one of the base TDG.VP.VMCALL leaf, and it's
not enumerated via bit 0 of out R11 (the bit 0 becomes reserved).[1]

So patch 1 updates the handling of tdx_handle_get_tdvmcall_info().

[1] https://cdrdv2.intel.com/v1/dl/getContent/858626

Paolo,

Patch 2-4, enables <SetupEventNotifyInterrupt> in QEMU. They based on
the KVM patches you put in KVM tree master.

Xiaoyao Li (4):
  i386/tdx: Remove enumeration of GetQuote in
    tdx_handle_get_tdvmcall_info()
  update Linux headers to KVM tree master
  i386/tdx: Set value of <GetTdVmCallInfo> based on capabilities of both
    KVM and QEMU
  i386/tdx: handle TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT

 linux-headers/asm-x86/kvm.h |  8 ++++-
 linux-headers/linux/kvm.h   |  4 +++
 target/i386/kvm/kvm.c       |  3 ++
 target/i386/kvm/tdx-stub.c  |  4 +++
 target/i386/kvm/tdx.c       | 61 +++++++++++++++++++++++++++++++++++--
 target/i386/kvm/tdx.h       |  7 ++++-
 6 files changed, 82 insertions(+), 5 deletions(-)

-- 
2.43.0


