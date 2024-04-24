Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4979C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXk2-0005yC-K2; Wed, 24 Apr 2024 04:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzXk0-0005xj-3X; Wed, 24 Apr 2024 04:12:32 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzXju-0005RB-Jt; Wed, 24 Apr 2024 04:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713946347; x=1745482347;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5/bYwr8c534YsqY0qHZ1MsLawXaHscEg3ybis5UV7v4=;
 b=HItpuG55CQyp4uPBqHQbnDS8v3mqpfslEmfK8fN+ghi0IoR1j/WUyGdt
 iqBlzoPoOuFc0PVRvLc8o3hc2L3nxqlfK5bhzT5C5LAXC1jcO8R6MT7tz
 YMp1bZHrAxg9lV1lpvrH0+3110KQL8/nT+XHekxAuYD2oZh4KSJjgBNHk
 8uqOIItgTdQHZ9zBFxz+DpFNZYrLurjtpf6Wa8UuL+dHfK7mLbjLoF5M4
 rdxC+JJzpTGXUsCadCu3ZmIf0xqck1fv4MKXBpS7sHbFejavZVmXAa96K
 yvxkQiinbF3OuLl5vPCNx2SQQdH3hNfmE4COE0Cp6Eqx9ZqvaoW4SN08+ g==;
X-CSE-ConnectionGUID: kBr7euP9SgG/EZLjzlN0nA==
X-CSE-MsgGUID: dcjKWMHJSgiLf89Cak4VfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9727693"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9727693"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 01:12:21 -0700
X-CSE-ConnectionGUID: GiEEsVZJR7aimfrbwmBvwQ==
X-CSE-MsgGUID: h/pwvNubTCWuF0bpE7TkPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; d="scan'208";a="29098464"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 24 Apr 2024 01:12:17 -0700
Date: Wed, 24 Apr 2024 16:26:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH-for-9.1 03/21] target/i386: Move APIC related code to
 cpu-apic.c
Message-ID: <ZijCLxqNPFqXSycf@intel.com>
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240321154838.95771-4-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

On Thu, Mar 21, 2024 at 04:48:19PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Thu, 21 Mar 2024 16:48:19 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 03/21] target/i386: Move APIC related code to
>  cpu-apic.c
> X-Mailer: git-send-email 2.41.0
> 
> Move APIC related code split in cpu-sysemu.c and
> monitor.c to cpu-apic.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/cpu-apic.c   | 112 +++++++++++++++++++++++++++++++++++++++
>  target/i386/cpu-sysemu.c |  77 ---------------------------
>  target/i386/monitor.c    |  25 ---------
>  target/i386/meson.build  |   1 +
>  4 files changed, 113 insertions(+), 102 deletions(-)
>  create mode 100644 target/i386/cpu-apic.c
> 
> diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
> new file mode 100644
> index 0000000000..d397ec94dc
> --- /dev/null
> +++ b/target/i386/cpu-apic.c

Nit: New file needs a MAINTAINER entry ;-).

Others LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


