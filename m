Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A9AD148A3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 06:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdjpI-0006ue-8y; Thu, 08 Jan 2026 01:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdjpE-0006tv-Tx; Thu, 08 Jan 2026 01:48:52 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdjpD-0003tg-57; Thu, 08 Jan 2026 01:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767854931; x=1799390931;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=JRPOPhmweRQ3H6XT2e/WjxxJl9QFkoppv+reiNng4GI=;
 b=fpjitBMKAhAaqa6PD7PUm17iHwZI4KVs/5k1CDL+qnVC5gj6IGiAiRd2
 QBRfXzrvPm08JuaO48gvVvVMDzCz3p81TojBAaJAf2RR94d8SQEh1ydPU
 naav7GTnX723bnl8wlpRe+q/SYfKJ1vXJm1pQihOE0ksHAVSyzZCPWdCz
 a4tHp0TPR1ZkohWvi20Acun5sVPUQq+6CRlUii0LMLfT04VxvEsN1WPzj
 z5q4X2IRnaE60kP4JMzgB/soB9Tg3T1bf4seUg7QTV6pEo5xiEhfYgG0q
 MXdoUzWma9Zpq7IvhHEqLyPlg1QbHbX7vlI8p+v70MFbmjxLFREdofVqv w==;
X-CSE-ConnectionGUID: blgA4MMTRcu9j0JyyWOz1w==
X-CSE-MsgGUID: owEZ/DhCRQSzxdQyiAAM3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69388700"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="69388700"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2026 22:48:47 -0800
X-CSE-ConnectionGUID: JLUq/h99QVOLg+Kpqa5ffw==
X-CSE-MsgGUID: HUlh0KyCQGaALaH392hZGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="207658794"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 07 Jan 2026 22:48:42 -0800
Date: Thu, 8 Jan 2026 15:14:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 5/5] accel/tcg: Unify watchpoint API
Message-ID: <aV9ZQJhvaNcKOfJ7@intel.com>
References: <20260106231908.16756-1-philmd@linaro.org>
 <20260106231908.16756-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260106231908.16756-6-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Jan 07, 2026 at 12:19:07AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed,  7 Jan 2026 00:19:07 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 5/5] accel/tcg: Unify watchpoint API
> X-Mailer: git-send-email 2.52.0
> 
> Currently "exec/breakpoint.h" contains both BreakPoint *and*
> WatchPoint APIs, however very few files requires the former,
> and more the latter:
> 
>   $ git grep -l CPUBreakpoint | wc -l
>         12
>   $ git grep -l CPUWatchpoint | wc -l
>         25
> 
> So extracting the WatchPoint API to its own header will reduce
> compilation pressure.
> 
> But more importantly, the API is scattered in two distinct headers.
> Unify them ("accel/tcg/cpu-ops.h" and "exec/watchpoint.h") to the
> new "accel/tcg/watchpoint.h" header, making the emphasis the API is
> specific to TCG.
> 
> Have accel/tcg/watchpoint.c absorb system/watchpoint.c code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  MAINTAINERS                         |   1 -
>  include/accel/tcg/cpu-ops.h         |  28 +-------
>  include/accel/tcg/watchpoint.h      |  57 ++++++++++++++++
>  include/exec/breakpoint.h           |  10 ---
>  include/exec/watchpoint.h           |  18 -----
>  include/hw/core/cpu.h               |   3 +-
>  target/arm/internals.h              |   2 +-
>  target/ppc/internal.h               |   2 +-
>  target/riscv/debug.h                |   2 +-
>  accel/tcg/cputlb.c                  |   1 +
>  accel/tcg/tcg-accel-ops.c           |   2 +-
>  accel/tcg/user-exec-stub.c          |   3 +-
>  accel/tcg/watchpoint.c              |  83 +++++++++++++++++++++-
>  system/watchpoint.c                 | 102 ----------------------------
>  target/arm/debug_helper.c           |   2 +-
>  target/arm/tcg/mte_helper.c         |   2 +-
>  target/arm/tcg/sve_helper.c         |   2 +-
>  target/i386/cpu.c                   |   2 +-
>  target/i386/machine.c               |   2 +-
>  target/i386/tcg/system/bpt_helper.c |   2 +-
>  target/ppc/cpu.c                    |   2 +-
>  target/ppc/cpu_init.c               |   2 +-
>  target/riscv/cpu_helper.c           |   2 +-
>  target/riscv/debug.c                |   2 +-
>  target/s390x/helper.c               |   2 +-
>  target/s390x/tcg/debug.c            |   2 +-
>  target/s390x/tcg/excp_helper.c      |   2 +-
>  target/s390x/tcg/mem_helper.c       |   1 +
>  target/xtensa/dbg_helper.c          |   2 +-
>  system/meson.build                  |   1 -
>  30 files changed, 162 insertions(+), 182 deletions(-)
>  create mode 100644 include/accel/tcg/watchpoint.h
>  delete mode 100644 include/exec/watchpoint.h
>  delete mode 100644 system/watchpoint.c

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


