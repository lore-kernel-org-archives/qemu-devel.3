Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C03C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 05:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reqL3-0007l2-EC; Tue, 27 Feb 2024 00:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reqL1-0007ko-UN
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 00:49:12 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reqKz-0006Ne-Q4
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 00:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709012950; x=1740548950;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0kh4n/mkpK1mEtMVLcyDsY255vwDm8cWoPqf+70c4Rk=;
 b=iOnTEjqskwjfm6/Au/1FVwUHStvd6D85Hb+0St7PkUJmuRLaPWeCkYIa
 7WFcxBfawbbGGR4QI0kqFBMBIM46JnIKvNkYV7deyd2SySQtTrWsRBhdM
 FO9BbCzQeZrYNBG4o0nXln4hpkHte1DdEl4Pdl7/33vahGms8s7tNfieS
 YGcEQm29dZLlqn01FXDXs9nXOpmsB0XTlN/msNubpQBWWr24UywoDS/i0
 NfemxuFgvEVfgbDXgLQ+TWQxGu9I9L2pTkv/kyk0+feDkLXmr5MtHg3fF
 oICqv0aB6ZMIoX/+2sI7qS9+aBaR82E3loDnAAHKX/IvhnjjAKsHQZ+XF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20782631"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="20782631"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 21:49:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="30091513"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 26 Feb 2024 21:49:03 -0800
Date: Tue, 27 Feb 2024 14:02:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH 07/10] hw/core/reset: Add qemu_{register,
 unregister}_resettable()
Message-ID: <Zd17Biy6ZpZhHTBL@intel.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-8-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160622.114437-8-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Tue, Feb 20, 2024 at 04:06:19PM +0000, Peter Maydell wrote:
> Date: Tue, 20 Feb 2024 16:06:19 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 07/10] hw/core/reset: Add qemu_{register,
>  unregister}_resettable()
> X-Mailer: git-send-email 2.34.1
> 
> Implement new functions qemu_register_resettable() and
> qemu_unregister_resettable().  These are intended to be
> three-phase-reset aware equivalents of the old qemu_register_reset()
> and qemu_unregister_reset().  Instead of passing in a function
> pointer and opaque, you register any QOM object that implements the
> Resettable interface.
> 
> The implementation is simple: we have a single global instance of a
> ResettableContainer, which we reset in qemu_devices_reset(), and
> the Resettable objects passed to qemu_register_resettable() are
> added to it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/sysemu/reset.h | 37 ++++++++++++++++++++++++++++++++++---
>  hw/core/reset.c        | 31 +++++++++++++++++++++++++++++--
>  2 files changed, 63 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com> 

