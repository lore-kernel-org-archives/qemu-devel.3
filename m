Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C7CC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 06:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdpt-0002R4-8l; Tue, 29 Jul 2025 02:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdpn-0002DK-Om
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:29:13 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdpk-0007gR-OU
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753770548; x=1785306548;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rIZ6R+np2Bx5RWEDWTEJekiSgfWu6A1OMoG6qCpCXzc=;
 b=kKCSlQsf5WqSrz3brEKj7asOW/OwXssDVTK4Zvf47Od2cY0BaRgykX9r
 RRymZWaszpT+Ss5CLOVL+bZwNyP+y8jJehhT6JzL1YlGIB+8vkkfIcjdr
 IMfyEc7aUW8qVilqwKJMSUjsmTwnmaFV/EWXVa42KEzfH/PosRaek79U7
 O0mjoVX/Iy5FmbnbDC8gEE+EdxoWVbhlrol9RPmO/92jLWZlFZE0BkwdS
 eq7huvJep0nbd2GhyU5cPnntcF3YfyoalJy31Hd2K5iF1XCOuio1ghsql
 4bEKLx68t/yV9KbGP7n89ht/JgcLs3f1FQIKlu22M8alBcmEDMHFPmU8q w==;
X-CSE-ConnectionGUID: 3u4Jz5QlSKmFYF6MAKvLzg==
X-CSE-MsgGUID: euEw78I5QmicjhqJBBJMCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="59854970"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="59854970"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 23:29:06 -0700
X-CSE-ConnectionGUID: 3NIuE4MZQKiB0HPOaspChA==
X-CSE-MsgGUID: n8RP+FGKQISxJUeJg2S4yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162492667"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 28 Jul 2025 23:29:05 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] i386/kvm: Cleanups in kvm_arch_init()
Date: Tue, 29 Jul 2025 14:20:12 +0800
Message-ID: <20250729062014.1669578-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
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

Patch 1 removes the object_dynamic_cast() check in kvm_arch_init();

Patch 2 removes the unncessary kvm_check_extension(s, KVM_CAP_X86_SMM);

Xiaoyao Li (2):
  i386/kvm: Get X86MachineState in kvm_arch_init() without the cast
    check
  i386/kvm: Drop KVM_CAP_X86_SMM check in kvm_arch_init()

 target/i386/kvm/kvm.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

-- 
2.43.0


