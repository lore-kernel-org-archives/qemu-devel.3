Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C52BE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 07:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ62h-0007d3-1x; Thu, 05 Dec 2024 02:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ62a-0007bM-K6
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 02:12:48 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ62S-0003B4-Od
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 02:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733382761; x=1764918761;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OKps0rkYDKds2eZ+OJFSR2nfHJFXxhEaVKXYOefaW/4=;
 b=RSobCeYQ05KPKy9vaSPhwEjhfu0wukoJvNyBLNODtszkr6vWsnQNw5wC
 dvv4kV1+/qLT1oXFtrnbvsK0rt+G8V3WB4hQIghjltXYLVnuM2QpjN3ny
 m1wvTnK+uGtN2JLvuviiL8NHQYQJZhHHTICHlN6o3tr35CU38BdldzrpS
 08DC4dd7fJGE3wMDHi3WzcT89m6BANowdLVdV0rPWjIhWU6ifFzw/Qct4
 oO+UE3asPzD4+wn7aZcNMdeRn6zJeEhYmEgQL/MY0G5CizNdu/Aa6+aJy
 d1AGR+SjEsueaVGdyi8OoLmOFcdpIaj50ahrjVo4bughhQF4uAiqLF7qu Q==;
X-CSE-ConnectionGUID: GAYKxHJhRyeviWgCb4dNtw==
X-CSE-MsgGUID: w2Ug4APtRwSIFIKmGpKzMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="45055504"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="45055504"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 23:12:37 -0800
X-CSE-ConnectionGUID: Ph3wGTn5Q86pFoj1cXUEMA==
X-CSE-MsgGUID: Zqo6MrRSTDW4YJSobgfGEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="93691874"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 04 Dec 2024 23:12:33 -0800
Date: Thu, 5 Dec 2024 15:30:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 0/4] Initialize nr_cores and nr_threads early and
 related clearup
Message-ID: <Z1FWpU36ZleXn7c4@intel.com>
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108070609.3653085-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

I'm also very sorry, but I have a slightly different opinion...

>  accel/tcg/user-exec-stub.c |  4 +++
>  hw/core/cpu-common.c       |  2 +-
>  include/hw/core/cpu.h      |  8 +++++
>  system/cpus.c              |  6 +++-
>  target/alpha/cpu.c         |  2 ++
>  target/arm/cpu.c           |  2 ++
>  target/avr/cpu.c           |  2 ++
>  target/hexagon/cpu.c       |  2 ++
>  target/hppa/cpu.c          |  2 ++
>  target/i386/cpu.c          | 61 +++++++++++++++++++-------------------
>  target/loongarch/cpu.c     |  2 ++
>  target/m68k/cpu.c          |  2 ++
>  target/microblaze/cpu.c    |  2 ++
>  target/mips/cpu.c          |  2 ++
>  target/openrisc/cpu.c      |  2 ++
>  target/ppc/cpu_init.c      |  2 ++
>  target/riscv/cpu.c         |  2 ++
>  target/rx/cpu.c            |  2 ++
>  target/s390x/cpu.c         |  2 ++
>  target/sh4/cpu.c           |  2 ++
>  target/sparc/cpu.c         |  2 ++
>  target/tricore/cpu.c       |  2 ++
>  target/xtensa/cpu.c        |  2 ++
>  23 files changed, 85 insertions(+), 32 deletions(-)
> 

I have some doubts about the necessity of changing the initialization of
nr_cores/nr_threads, because you can access the machine's topology info
via machine_topo_get_threads_per_socket(), which gives the same result as
`nr_cores * nr_threads`.

Especially, the TDX feature check hook is also within the context of
`current_machine`, so why not check if TDX's HT is consistent with QEMU's
emulation in the TDX hook?

For this reason, and based on my comment on patch 2, I think checking HT
in the TDX hook or even ignoring HT, would be a more straightforward and
less impactful solution.

-Zhao


