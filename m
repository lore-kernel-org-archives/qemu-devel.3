Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D905FC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 03:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz4QN-0004lg-7z; Tue, 25 Aug 2026 23:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kishen.maloor@intel.com>)
 id 1wz4QM-0004lY-38
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 23:35:38 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kishen.maloor@intel.com>)
 id 1wz4QJ-0006wq-RY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 23:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787715336; x=1819251336;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ULqvLgcf5aolbxdLszytXH1oq+3IAUaBe+G/qeS8EdM=;
 b=nANm9exjAVkZYHV37+i1zdFUooVowciAwLNTPyn/WwFbWouOJJcQOYq+
 Gpq/ESy6IpD0uIusiPBIikq/X1oE5LMuxcao3Njrr/cnKtctnrXkV6UDh
 GJDwLM+pY5mFEyjI0VDkbmjfnz92SlenXyLwGc7sWtKrJSg8SKNEF0US2
 RrYXzX+cvbNndOBVxHAE6WBS3iaKUWh9/a7/JOJApR1Lkod2umstBppQL
 SkoCcw1t/BHVewqgjGB8fGbXV9Wg8Y93CXIlRo9dC1CusfO6eP8qZLzYO
 fbM/ya33XWUWCftTXqjA9wyj52aXXS4ZyFvZ7JKOVyTeSwFc2MyJ7SYjR A==;
X-CSE-ConnectionGUID: +HKDxPRfQuCyCHHkg0zMKA==
X-CSE-MsgGUID: elkiuHziT7mxwwu+jKcKMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="75728371"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="75728371"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 20:35:31 -0700
X-CSE-ConnectionGUID: nB/r3phlSgKxFBIsXLmKcw==
X-CSE-MsgGUID: /1JyepAAS26vrUjWpwqhxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="297364009"
Received: from d404e69c8b80.jf.intel.com ([10.54.34.91])
 by orviesa002.jf.intel.com with ESMTP; 25 Aug 2026 20:35:31 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, kvm@vger.kernel.org,
 sohil.mehta@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com,
 farrah.chen@intel.com, kishen.maloor@intel.com
Subject: [PATCH 0/5] target/i386: Add support for LASS
Date: Tue, 25 Aug 2026 20:57:29 -0700
Message-ID: <20260826035734.114685-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=kishen.maloor@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds QEMU support for Linear Address Space Separation (LASS) [1],
an Intel security feature that prevents a class of side-channel attacks
relying on speculative accesses across the user/kernel boundary. Paging,
along with SMEP and SMAP, already provides mode-based access protection,
but enforcing it requires a page walk whose timing can leak the layout of
kernel memory. LASS applies the equivalent protections during
linear-address pre-processing: given the usual partitioning of the linear
address space into a user half (bit 63 clear) and a supervisor half
(bit 63 set), an access targeting the opposite half is rejected on the
basis of bit 63 alone, before any page walk.

This series enumerates the LASS CPUID bit, recognizes CR4.LASS,
and exposes LASS on the relevant Intel CPU models via new versioned models.
LASS is not emulated by TCG.

Exposing LASS to a guest also requires KVM support: KVM must validate
the CPUID bit and CR4.LASS, and enforce LASS violations in its
instruction emulator. That enabling is currently under review [2].

Tested with a Linux guest on LASS-capable hardware: LASS is enumerated and
CR4.LASS is set under KVM, and not enumerated under TCG.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual, Volume 3A,
    Section 4.3, "Linear-Address-Space Separation (LASS)".
[2] https://lore.kernel.org/kvm/20260806011536.4172258-1-sohil.mehta@intel.com/

Isaku Yamahata (2):
  target/i386: Add support for LASS in CPUID enumeration
  target/i386: Add LASS support in CR4

Kishen Maloor (3):
  target/i386: Introduce DiamondRapids-v3 to enable LASS
  target/i386: Introduce SierraForest-v7 to enable LASS
  target/i386: Introduce ClearwaterForest-v5 to enable LASS

 target/i386/cpu.c    | 26 +++++++++++++++++++++++++-
 target/i386/cpu.h    |  7 ++++++-
 target/i386/helper.c |  4 ++++
 3 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.47.1


