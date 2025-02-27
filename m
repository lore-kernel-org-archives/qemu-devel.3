Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465E2C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnX1n-000369-Aq; Thu, 27 Feb 2025 01:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnX1k-00035C-9I
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:05:44 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnX1h-0001rg-Ru
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740636342; x=1772172342;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=t1nipi6U9eSk+/EIGKV9BJ1I5KWA2cBTKLGsu7WWMvo=;
 b=WCOq6ZAb1QhYZlQNSQu4lavfIXoi2tnaN6FupSK/g4sxAggZ/ZhJ3Xo1
 zQU78zxMqFCKB6cCj/1tFWY8nqkblq9fyANeMk4NotGPVBdpNkPUil8Mr
 bdgztlpanDTYLyvPi2EhJFgRwG7coPApqRJqZhO/uYTimyB+zA+Qn/YoY
 dKUtRpwKEO65q7Rt8+WfTYJKcJcKc12N9nfnH+UszcTMJxyHcbrGmOtyh
 eqDPNpYlNksPYtfVEGFzInZRvOeDMgZwo9fThCYB0+JrSQNAZnK0ujZcm
 sN5rk3e+/Ll/TKeQEtXPrplzfIIoAvWb5kG/WhEzwodn00r4o6J0cn/lf A==;
X-CSE-ConnectionGUID: 1+7WGjTHSym/N4pGiaugUw==
X-CSE-MsgGUID: ocrH4TtzSVOqdcUqzwrR/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52148164"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="52148164"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 22:05:35 -0800
X-CSE-ConnectionGUID: TiRftZbgQoWMjzEfgjPpKw==
X-CSE-MsgGUID: NaipIpCNRbidFxWXrJsQCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="121938232"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 26 Feb 2025 22:05:32 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chuang Xu <xuchuangxclwt@bytedance.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/4] i386/cpu: Fix topological field encoding & overflow
Date: Thu, 27 Feb 2025 14:25:19 +0800
Message-Id: <20250227062523.124601-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

This series collects and organizes several topology-related cleanups and
fixes, based on b69801dd6b1e ("Merge tag 'for_upstream' of
https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging").

Patch 1 is picked from Chuang's v6 [1].

Patch 2-3 are picked from Qian's v4 [2], though it had previously gone
through sufficient review (got R/b tags), I dropped its R/b tags because
of my code change.

Patch 4 is newly added, inspired by patch 3, to also perform a check on
AMD's cache CPUID. This is to consider the current maximum number of
supported CPUs, which is approaching the overflow boundary.

In addition to the 0x1, 0x4, and 0x8000001d leaves involved in the patch
series, there is also the 0x1f leaf related to topology. However, the
upper limit for CPUID.1FH.EBX[bits 15:0] is 65,535 threads, which
provides enough room. Therefore, this field does not currently require
overflow checks.

This series correct the CPUIDs, but it doesn't affect the Guest's live
migration. Therefore, I did not add the compat property for this.

[1]: https://lore.kernel.org/qemu-devel/20241009035638.59330-1-xuchuangxclwt@bytedance.com/
[2]: https://lore.kernel.org/qemu-devel/20230829042405.932523-2-qian.wen@intel.com/

Thanks and Best Regards,
Zhao
---
Chuang Xu (1):
  i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX[23:16]

Qian Wen (2):
  i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]
  i386/cpu: Fix overflow of cache topology fields in CPUID.04H

Zhao Liu (1):
  i386/cpu: Honor maximum value for CPUID.8000001DH.EAX[25:14]

 target/i386/cpu.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

-- 
2.34.1


