Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34256C54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebZY-0000MB-LA; Mon, 26 Feb 2024 09:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rebZW-0000Lj-KP
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:03:10 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rebZU-0000q6-LY
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708956189; x=1740492189;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5wEYYpmZkxs1H4X8Y1yE9Mox0E5gGGJ5UqnSqzdv0p4=;
 b=FEF6zaMRdbTw1oaq2gLlbXwdu/u6OBn71PbcBTsvZe9OiVet+PSVoEMj
 eb95K1rASr233CB4W+HOtkS56D54tSDCKskJGNlxLx1V35BqCH9JkyR09
 ihaIlf8Hokgd1Wew8a2ByvHTiI6WUfYkFBd4eJ+GfPmiLlAo8dIUXLpQs
 VklL85ZJ/TS0l82zvVs/ntdQkgeNvolfEBkBcTYUWL5H+EUPlP3hMgC+K
 QQ1NttrjNgNNGqrnv5yGM+aTysnXS+zw16Y/HaSyfc+mE7uuky9xkjhaP
 aLnCn9fk4d5mZvB9BEdqeVD6mmEXMJFjSlGrJnqV8LkN+7HYKFs+qi7sB Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3357881"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3357881"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 06:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="29853497"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 26 Feb 2024 06:03:02 -0800
Date: Mon, 26 Feb 2024 22:16:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH 03/10] system/bootdevice: Don't unregister reset handler
 in restore_boot_order()
Message-ID: <ZdydTCIEicNCL7Ns@intel.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160622.114437-4-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

On Tue, Feb 20, 2024 at 04:06:15PM +0000, Peter Maydell wrote:
> Date: Tue, 20 Feb 2024 16:06:15 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 03/10] system/bootdevice: Don't unregister reset handler in
>  restore_boot_order()
> X-Mailer: git-send-email 2.34.1
> 
> Currently the qemu_register_reset() API permits the reset handler functions
> registered with it to remove themselves from within the callback function.
> This is fine with our current implementation, but is a bit odd, because
> generally reset is supposed to be idempotent, and doesn't fit well in a
> three-phase-reset world where a resettable object will get multiple
> callbacks as the system is reset.
> 
> We now have only one user of qemu_register_reset() which makes use of
> the ability to unregister itself within the callback:
> restore_boot_order().  We want to change our implementation of
> qemu_register_reset() to something where it would be awkward to
> maintain the "can self-unregister" feature.  Rather than making that
> reimplementation complicated, change restore_boot_order() so that it
> doesn't unregister itself but instead returns doing nothing for any
> calls after it has done the "restore the boot order" work.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> It would be nicer not to use reset at all, especially since I'm not
> a fan of conflating "system is reset" with "system boots", but I
> didn't have a good idea for how to do that.
> ---
>  system/bootdevice.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


