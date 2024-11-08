Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFA3D5E143
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 07:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9JGd-0006NL-AQ; Fri, 08 Nov 2024 02:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t9JGT-0006Kd-LT
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:18:42 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t9JGQ-0007P1-5O
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731050318; x=1762586318;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EjMkmMq28G1fu7H7c97qD2aJHg4qvw2ZYKp2HV0OHXE=;
 b=F9PfGp+helRPcQM4yHQyCLZZRnnzRhFeajh0GKpsIKbc+QT5aj0f7zPZ
 Lo7vX4z4em9tz7YdagvB1D5fUcbF3avoMhHguD7dkjCwcjMuvh7jMjksj
 KDYkX/el8Fz5Ou+B7O4qpUCj5u+gVpNheff0lUVRhyZlalECjxvgB6fTb
 lMkaBzq3uShhKqy536FjYVor2IFpvDYixc/rZIA35/TQOLoNOm/qGjtzK
 wI4ARDtqUNQU95kpr+WGuWl6z2E5wP3nzGVyCFOtnZHmSi8sJxf2OzTSO
 1Y/uKZkui8AsOU03SW0MSRB/FaWEEzlWDPAEIfL4FWOicG3/wzLqHo2Px A==;
X-CSE-ConnectionGUID: H6OIb6V3QkKkFVq2qjTT3g==
X-CSE-MsgGUID: +v/1V0L8TRiHsvgZwHDbJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31082898"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="31082898"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2024 23:18:33 -0800
X-CSE-ConnectionGUID: ZG5oLrExRPKmKeYI6O8VNA==
X-CSE-MsgGUID: zrNHz+E2TP6SonziVUEO0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; d="scan'208";a="86240911"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa008.jf.intel.com with ESMTP; 07 Nov 2024 23:18:29 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH v1 0/4] Initialize nr_cores and nr_threads early and related
 clearup
Date: Fri,  8 Nov 2024 02:06:05 -0500
Message-Id: <20241108070609.3653085-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

This series is extracted from TDX QEMU v6[1] series per Paolo's request.

It is originally motivated by x86 TDX to track CPUID_HT in env->features[]
which requires nr_cores and nr_cores being initialized earlier than in
qemu_init_vcpu().

Initialize of nr_cores and nr_threads earlier in x86's cpu_realizefn()
can make it work for x86 but it's duplicated with the initialization in
qemu_init_vcpu() which are used by all the ARCHes. Since initialize them
earlier also work for other ARCHes, introduce qemu_init_early_vcpu() to
hold the initialization of nr_cores and nr_threads and call it at the
beginning in realizefn() for each ARCH.

Note, I only tested it for x86 ARCH. Please help test on other ARCHes.

The following patch 2 - 4 are x86 specific.

[1] https://lore.kernel.org/qemu-devel/CABgObfZVxaQL4FSJX396kAJ67Qp=XhEWwcmv+NQZCbdpfbV9xg@mail.gmail.com/

Xiaoyao Li (4):
  cpu: Introduce qemu_early_init_vcpu() to initialize nr_cores and
    nr_threads inside it
  i386/cpu: Set up CPUID_HT in x86_cpu_expand_features() instead of
    cpu_x86_cpuid()
  i386/cpu: Set and track CPUID_EXT3_CMP_LEG in
    env->features[FEAT_8000_0001_ECX]
  i386/cpu: Rectify the comment on order dependency on qemu_init_vcpu()

 accel/tcg/user-exec-stub.c |  4 +++
 hw/core/cpu-common.c       |  2 +-
 include/hw/core/cpu.h      |  8 +++++
 system/cpus.c              |  6 +++-
 target/alpha/cpu.c         |  2 ++
 target/arm/cpu.c           |  2 ++
 target/avr/cpu.c           |  2 ++
 target/hexagon/cpu.c       |  2 ++
 target/hppa/cpu.c          |  2 ++
 target/i386/cpu.c          | 61 +++++++++++++++++++-------------------
 target/loongarch/cpu.c     |  2 ++
 target/m68k/cpu.c          |  2 ++
 target/microblaze/cpu.c    |  2 ++
 target/mips/cpu.c          |  2 ++
 target/openrisc/cpu.c      |  2 ++
 target/ppc/cpu_init.c      |  2 ++
 target/riscv/cpu.c         |  2 ++
 target/rx/cpu.c            |  2 ++
 target/s390x/cpu.c         |  2 ++
 target/sh4/cpu.c           |  2 ++
 target/sparc/cpu.c         |  2 ++
 target/tricore/cpu.c       |  2 ++
 target/xtensa/cpu.c        |  2 ++
 23 files changed, 85 insertions(+), 32 deletions(-)

-- 
2.34.1


