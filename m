Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FA4D13592
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 02:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5FqO-0006Ar-IS; Sun, 27 Oct 2024 22:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5FqM-0006AS-T1
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:50:58 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5FqK-0003WL-TY
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730083857; x=1761619857;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=M3mBgBU7e5LuZmz19r+dIQ6WHcL16DaSTm+8esgRVuE=;
 b=Wt+CWgper1Syf+21VvznCAUjEYhzriZjXFtJGdmS7OuTUt9O2ci+VtVx
 hZAbhUH93yBn/rfWBLCsXucWMgKg4w3KzbPFUc8P0OIy36gDbcldJOUef
 rFi5x6QBs5xgo8BNSirKdYSCPlepvSCLSbo9qHlaX06bye/gYmBaUM3ql
 jjj5rSSwNfovou1s9+Q9R4271/Ps+UdSSb2/T76VmrBtlpqubACiLFvOQ
 iTvMFfwkO3bBYllFQgi7yJ6F++cTHX5TZVZKtkF9L1Mx0Zz8+rbfGDRaU
 1o1z907RXF3Ep+V66kA/2YvT/otCHM+jm0LAHPLKL0d3kJ2GWdKa3EgUn w==;
X-CSE-ConnectionGUID: 3PU5qkO1SaWmoag57mp/xg==
X-CSE-MsgGUID: WqcPHV06Spman6zs2DFDRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40249462"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="40249462"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2024 19:50:53 -0700
X-CSE-ConnectionGUID: 9UDsFjTjRB+15cz8lOwn2w==
X-CSE-MsgGUID: eWxjF0DhSaiHRiS6XWaq2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="81420928"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa009.jf.intel.com with ESMTP; 27 Oct 2024 19:50:51 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH 0/6] Add AVX10.1 CPUID support and GraniteRapids-v2 model
Date: Mon, 28 Oct 2024 10:45:06 +0800
Message-Id: <20241028024512.156724-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add AVX10.1 CPUID support, i.e. add AVX10 support bit via
CPUID.(EAX=07H, ECX=01H):EDX[bit 19] and new CPUID leaf 0x24H so that
guest OS and applications can query the AVX10 CPUIDs directly. The AVX10.1
spec can be found in [*], it is worth mentioning that
VL128 (CPUID.(EAX=24H, ECX=00H):EBX[bit 16]) was dropped in rev3.0, but it
will be added back and reserved as 1.

Since GraniteRapids (stepping 1) is the first platform to support AVX10,
introduce GraniteRapids-v2 CPU model to add AVX10 in this patch set, and
add some missing features as well.

[*] https://cdrdv2.intel.com/v1/dl/getContent/784267

---
Tao Su (6):
  target/i386: Add AVX512 state when AVX10 is supported
  target/i386: add avx10-version property
  target/i386: Add CPUID.24 leaf for AVX10
  target/i386: Add feature dependencies for AVX10
  target/i386: Add support for AVX10 in CPUID enumeration
  target/i386: Introduce GraniteRapids-v2 model

 target/i386/cpu.c     | 90 ++++++++++++++++++++++++++++++++++++++++++-
 target/i386/cpu.h     | 16 ++++++++
 target/i386/kvm/kvm.c |  3 +-
 3 files changed, 107 insertions(+), 2 deletions(-)


base-commit: cea8ac78545a83e1f01c94d89d6f5a3f6b5c05d2
-- 
2.34.1


