Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AA1C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 08:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXGpJ-00051o-NX; Tue, 06 Feb 2024 03:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rXGpH-00051J-Md; Tue, 06 Feb 2024 03:29:07 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rXGpE-000235-ET; Tue, 06 Feb 2024 03:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707208145; x=1738744145;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4WR9izcgYukFF3F7vycbVdYquEAc1jz79lr3UwTHfTM=;
 b=aFw0+T5BdqQ1bNwC+iAcSKxVboruWIuUnwTHoc1emfs1hXZxyWa9l150
 YTk4qvoPK4BkBRrEIsE2e8i6VM0gg7RHH+NLaf07LdPZwPWUwNX/XViyL
 QITTV+NCZhirS2izM8+RU/CpSfKMNn8aWNGIAis3xIoujG1cU4crxaNzm
 etF6jplUBJ67q33HWFoeMCJ1OvXfOU4uc6559rPrz6z09/HjJDGTTYato
 WuTuba6AN/2lCMDY9GOmr7XbuW1lpzZhnoRI/D2y5G86rIdL27qpVkMVA
 WR7zicBXx6HySN/0ine+hyIfkIYpC158mIKlSXVDNCQ4yukALiIP6FPCb A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4578222"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="4578222"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2024 00:29:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824112652"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; d="scan'208";a="824112652"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga001.jf.intel.com with ESMTP; 06 Feb 2024 00:28:55 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [RFC PATCH 0/4] Confidential Guest Support: Introduce kvm_init() and
 kvm_reset() virtual functions 
Date: Tue,  6 Feb 2024 03:28:48 -0500
Message-Id: <20240206082852.3333299-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This series is inspired and suggested by Daniel:
https://lore.kernel.org/qemu-devel/ZbfoQsEuv6_zwl3b@redhat.com/

Currently, different confidential VMs in different architectures have
their own specific *_kvm_init() (and some have *_kvm_reset()) exposed
for KVM stuff when it's a confidential VM. e.g., sev_kmv_init() for x86
SEV, pef_kvm_init() and pef_kvm_reset() for PPC PEF, and s390_pv_init()
for s390 PV VMs.

Introduce a generic .kvm_init() and .kvm_reset() functions in
ConfidentialGuestSupportClass, so that different cgs technologies in
different architectures can implement their own, while common interface
of cgs can be used.

This RFC implements two helper functions confidential_guest_kvm_init()
and confidential_guest_kvm_reset() in Patch 1. In the following patches,
they are called in arch specific implementation. X86 will benefit more
for the generic implementation when TDX support is added.

There is one step forward possible, that calling
confidential_guest_kvm_init() before kvm_arch_init() in kvm_int() in
accel/kvm/kvm-all.c. This way, each arch doesn't need to call in their
arch specific code.
	
X86 fits it, however I'm not sure if ppc and s390 fit it as well.
Because currently, ppc calls it in machine->init()
and s390 calls in MachineClass->init(). I'm not sure if there is any
order dependency. 

Xiaoyao Li (4):
  confidential guest support: Add kvm_init() and kvm_reset() in class
  i386/sev: Switch to use confidential_guest_kvm_init()
  ppc/pef: switch to use confidential_guest_kvm_init/reset()
  s390: Switch to use confidential_guest_kvm_init()

 hw/ppc/pef.c                              |   9 +-
 hw/ppc/spapr.c                            |   6 +-
 hw/s390x/s390-virtio-ccw.c                |   3 +-
 include/exec/confidential-guest-support.h |  42 +++++++-
 include/hw/ppc/pef.h                      |  17 ---
 target/i386/kvm/kvm.c                     |   2 +-
 target/i386/kvm/meson.build               |   2 -
 target/i386/kvm/sev-stub.c                |   5 -
 target/i386/sev.c                         | 120 +++++++++++-----------
 target/i386/sev.h                         |   2 -
 target/s390x/kvm/pv.c                     |   8 ++
 target/s390x/kvm/pv.h                     |  14 ---
 12 files changed, 123 insertions(+), 107 deletions(-)
 delete mode 100644 include/hw/ppc/pef.h

-- 
2.34.1


