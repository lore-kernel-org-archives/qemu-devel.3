Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92516C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 08:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWVzY-0006xk-BJ; Tue, 01 Jul 2025 04:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWVzS-0006xD-7P
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:05:18 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWVzK-00076f-Mw
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751357111; x=1782893111;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=umHWAtsKsfzLVPZKOjmq4/JFkJtRRsk2mp5Q+dzUJBo=;
 b=OQ8YfbYssnstIj+jwXotj6emCCMJjD+jaRiGxOqCMI9sjpJrdM17yEjY
 vIN5KlHbXPLczb7OII9KcdaUzejI0D119VcXaPDwNqoI4QiO8kuETfiDl
 3j5gCj9m81j9qZDtzfWxNj/mg3P7HSQs2V93lbF/+U0+LHhyJD0iw3dpV
 xRMTJI5ZMi+kis7i5IPFJUj4PuEBrcBTWl6WD9rC2Awzd0dlGwmxy+bQG
 S5YvcHmgzmBCyNn/yu/G3QkXW5wwQKCJKqMwz9nYpr9JJTQkU2tO9gsyH
 O8oqbBoBTpsQe8cDgLaaJdUthD/EWG2lX/4LzoCdqEuz3NkKXne4VG9H1 Q==;
X-CSE-ConnectionGUID: ZagZ/YBaQ+uTRTBSGD7+BQ==
X-CSE-MsgGUID: d5vUW1/GSq2/k6GLFVeAuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64207657"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="64207657"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 01:05:07 -0700
X-CSE-ConnectionGUID: nqA1eYzWSYK4liQVr2/XoQ==
X-CSE-MsgGUID: 89LWOQARRkuYZw8esHwsvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="157726504"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 01 Jul 2025 01:05:04 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 0/2] Clean up of target/i386/host-cpu.c
Date: Tue,  1 Jul 2025 15:57:36 +0800
Message-ID: <20250701075738.3451873-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
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

Everytime I look at the flow of how x86 cpu is initialized, I get
confused by the name of host_cpu_instance_init() and
host_cpu_max_instance_init(). They look like related to "-cpu host" and
the .instance_init() callback of "-cpu host".

However, host_cpu_instance_init() even has noting to do with "-cpu
host". So patch 1, to rename host_cpu_instance_init(). I also want to
rename host_cpu_max_instance_init(), but I cannot think of a new better
name so I just leave it as-is.

Patch 2 is the cleanup found when I look at host-cpu.c

Note, this series is based on my another cleanup [1]. It might be able
to apply cleanly on master with [1].

[1] https://lore.kernel.org/qemu-devel/20250630080610.3151956-1-xiaoyao.li@intel.com/

Xiaoyao Li (2):
  i386/cpu: Rename host_cpu_instance_init() to apply_host_vendor()
  i386/cpu: Move the implementation of is_host_cpu_intel() host-cpu.c

 target/i386/host-cpu.c        | 21 +++++++++++++--------
 target/i386/host-cpu.h        |  3 ++-
 target/i386/hvf/hvf-cpu.c     |  5 ++++-
 target/i386/kvm/kvm-cpu.c     |  4 ++--
 target/i386/kvm/vmsr_energy.c |  9 ---------
 target/i386/kvm/vmsr_energy.h |  1 -
 6 files changed, 21 insertions(+), 22 deletions(-)

-- 
2.43.0


