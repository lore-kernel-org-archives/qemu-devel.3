Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964ABC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3trp-0003YQ-VX; Mon, 06 May 2024 04:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3tr3-0002h7-UQ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:37:51 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3tr2-0000gt-4l
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714984668; x=1746520668;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=t16zbWmXufIghAtbC59BZnfuKimAEZlNbjdKAMlDDag=;
 b=bpu1l8MhXRYc53Wc6BkfX6WG5YY82EcGTSSFwq5iHCeLqGZpQISbH7DI
 jN/aB2vJ+rZLC8w9kMBcyij4AsHIwN1mfwp+nGZxpvVX3uZ0aU2JykWzw
 LSYQk/zjVnPuDuDm2V9YAQtp8A0NqVQX9Pl6Q1oNyPUXWFLjEAugBYACM
 dcvejX7DYhfQEq/QsMDrfbF5SuTFZ1LsoY/OEIT27Et2B9MTtPGGm638o
 kGRtGAnMYpNvvZAApGrCiKJDDv/yt/IP/nlqhExSJcgNy8yqrSzolErLB
 VoOIyts8RdooMphlrZlKOLB8ct8GpivSwjQBCNPZyqqRk5xp3FK5xvk+N A==;
X-CSE-ConnectionGUID: JPceVyfkSF6YESzK8s8aPg==
X-CSE-MsgGUID: 1jRO9RkNSM6xMjRT4zaH3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14533314"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="14533314"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:37:46 -0700
X-CSE-ConnectionGUID: yv9lfA5xRjetFiZhiWpslw==
X-CSE-MsgGUID: mcQArTPlQFCiDrXfvOBQiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="28186713"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 06 May 2024 01:37:43 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 0/6] target/i386: Misc cleanup on KVM PV defs and outdated
 comments
Date: Mon,  6 May 2024 16:51:47 +0800
Message-Id: <20240506085153.2834841-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

This is my v2 cleanup series. Compared with v1 [1], only tags (R/b, S/b)
updates, and a typo fix, no code change.

This series picks cleanup from my previous kvmclock [2] (as other
renaming attempts were temporarily put on hold).

In addition, this series also include the cleanup on a historically
workaround and recent comment of coco interface [3].

Avoiding the fragmentation of these misc cleanups, I consolidated them
all in one series and was able to tackle them in one go!

[1]: https://lore.kernel.org/qemu-devel/20240426100716.2111688-1-zhao1.liu@intel.com/
[2]: https://lore.kernel.org/qemu-devel/20240329101954.3954987-1-zhao1.liu@linux.intel.com/
[3]: https://lore.kernel.org/qemu-devel/2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (6):
  target/i386/kvm: Add feature bit definitions for KVM CPUID
  target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
    MSR_KVM_SYSTEM_TIME definitions
  target/i386/kvm: Only save/load kvmclock MSRs when kvmclock enabled
  target/i386/kvm: Save/load MSRs of kvmclock2
    (KVM_FEATURE_CLOCKSOURCE2)
  target/i386/kvm: Drop workaround for KVM_X86_DISABLE_EXITS_HTL typo
  target/i386/confidential-guest: Fix comment of
    x86_confidential_guest_kvm_type()

 hw/i386/kvm/clock.c              |  5 +--
 target/i386/confidential-guest.h |  2 +-
 target/i386/cpu.h                | 25 +++++++++++++
 target/i386/kvm/kvm.c            | 63 +++++++++++++++++++-------------
 4 files changed, 66 insertions(+), 29 deletions(-)

-- 
2.34.1


