Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82C0C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 06:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reqii-0005bd-6Z; Tue, 27 Feb 2024 01:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reqig-0005av-6c
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 01:13:38 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reqie-0002Oe-I0
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 01:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709014417; x=1740550417;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3+AHTeSmUq7BWcI2WPZYIAsIzA9izycNA5aVHzWyie4=;
 b=VVFWNEsxQkYRt8DTZ+iJ2SVSdgsvVqXXwA1QcnX2lIHCBXTr1025bvJh
 A5JezjeCQwHn1pf9c7YQyyStVq3LjUbvY3Wf8wfy0YZMiaCtV5D83fCmh
 UViFnav1yST3xok1hMmEj0Q2uLBL5XyqozORQBjlaskrCHMKtcKJ4N0nz
 kMY9kun/GrM2E2Kyfm7XDKGuaOP6b2I7/uqswkFyiVWal0fuoWrx5Z0Pm
 ENAbFVfexRrLkClrilG0ji1VKBTB0cXi4oXZav0a+Rj8r38RMmiFPovQ/
 sn5B5+IjMcnP5ksqIAYVo7Mm6zn2kHV9A1yHkqx/2K+SnmiFteowF8TBG w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14487028"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="14487028"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 22:13:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="11514772"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 26 Feb 2024 22:13:31 -0800
Date: Tue, 27 Feb 2024 14:27:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH 09/10] hw/core/machine: Use qemu_register_resettable for
 sysbus reset
Message-ID: <Zd2AwRAq57R/rZlB@intel.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-10-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160622.114437-10-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 04:06:21PM +0000, Peter Maydell wrote:
> Date: Tue, 20 Feb 2024 16:06:21 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 09/10] hw/core/machine: Use qemu_register_resettable for
>  sysbus reset
> X-Mailer: git-send-email 2.34.1
> 
> Move the reset of the sysbus (and thus all devices and buses anywhere
> on the qbus tree) from qemu_register_reset() to qemu_register_resettable().
> 
> This is a behaviour change: because qemu_register_resettable() is
> aware of three-phase reset, this now means that:
>  * 'enter' phase reset methods of devices and buses are called
>    before any legacy reset callbacks registered with qemu_register_reset()
>  * 'exit' phase reset methods of devices and buses are called
>    after any legacy qemu_register_reset() callbacks
> 
> Put another way, a qemu_register_reset() callback is now correctly
> ordered in the 'hold' phase along with any other 'hold' phase methods.
> 
> The motivation for doing this is that we will now be able to resolve
> some reset-ordering issues using the three-phase mechanism, because
> the 'exit' phase is always after the 'hold' phase, even when the
> 'hold' phase function was registered with qemu_register_reset().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I believe that given we don't make much use of enter/exit phases
> currently that this is unlikely to cause unexpected regressions due
> to an accidental reset-order dependency that is no longer satisfied,
> but it's always possible...
> ---
>  hw/core/machine.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


