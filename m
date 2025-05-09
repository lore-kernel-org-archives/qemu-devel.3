Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1101FC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 09:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDJqr-00062O-IC; Fri, 09 May 2025 05:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDJqo-00061o-L3; Fri, 09 May 2025 05:17:02 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDJqm-0001rv-99; Fri, 09 May 2025 05:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746782220; x=1778318220;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=fWuJszRoYNIae1SRNi4ekLG9TgewBETWDbuBAJi2yAI=;
 b=QRIwLGQhuyqQZUlLqLc3YCt8tWM0E4S2+1RqCe6aFxSPVna6ZJK7SECt
 2mR7ghNC8ek1gTy5DQpHpDY+iXFpiR8fr4lxviillhJkQgT7Ha0hZzz6V
 1j+LbEVt1qq4vwy7iKK7o/zaruyRru+DvY00foHf55ZkmEQP7MRc39Aa3
 cPUsiUiW2XPS1de1/sQReIgH2DFN4HGnHSgMTfiZ2n2L+3wS0xWHPoKZz
 nK+PNtH6QvXH66EkYU6opk8EiLiVj7YwLrkkdPwXcsdMNZTcRh079na/2
 Rnm08A0prWOMTaZMfzpxWqmlLSDKOhN7SAQo1BMjb0kEnOMel9L07ySAX Q==;
X-CSE-ConnectionGUID: 0OnRid9DRN6i9wSEdnJ6Gg==
X-CSE-MsgGUID: hWQZd9NPR1+ZGExLqDqAhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59600001"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="59600001"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 02:16:56 -0700
X-CSE-ConnectionGUID: WP0RCFLKT46ejuRYK87bag==
X-CSE-MsgGUID: zI96hvJRQfaATwVfgYUpog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="167641269"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 May 2025 02:16:49 -0700
Date: Fri, 9 May 2025 17:37:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 19/27] target/i386/cpu: Remove
 CPUX86State::full_cpuid_auto_level field
Message-ID: <aB3M7/RlxxDFg5al@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-20-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508133550.81391-20-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On Thu, May 08, 2025 at 03:35:42PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  8 May 2025 15:35:42 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 19/27] target/i386/cpu: Remove
>  CPUX86State::full_cpuid_auto_level field
> X-Mailer: git-send-email 2.47.1
> 
> The CPUX86State::full_cpuid_auto_level boolean was only
> disabled for the pc-q35-2.7 and pc-i440fx-2.7 machines,
> which got removed. Being now always %true, we can remove
> it and simplify x86_cpu_expand_features().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/cpu.h |   3 --
>  target/i386/cpu.c | 106 ++++++++++++++++++++++------------------------
>  2 files changed, 51 insertions(+), 58 deletions(-)

This property is a fix, so,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


