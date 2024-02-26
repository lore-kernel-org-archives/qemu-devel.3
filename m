Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7CFC54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebSp-0006JC-97; Mon, 26 Feb 2024 08:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rebSi-0006IH-Nk
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:56:08 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rebSf-0007yN-Sg
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708955766; x=1740491766;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RjE2hXjKIY2J3+psJTzlcUkkch1XdbF0A6fZS1slcAY=;
 b=UvLn6kQOenv1qxH9Y4gSPwk1/jyaungQAHk03oPHH1I2MiZ6tJOo1NWS
 PbK7z9NBXwxiGtlD8jq9xvXfs2yIIaMzIsd4n0JS1/bj81Lz4iv3FRD+i
 8OrjjKTtVs8Nu5Ph61lmhxOWxMCE93F3vHzWk+A2cbiirCYCQ8CnSIN1b
 NGAqM4jYxlhxW6vSxUvxkxOevKS0BNIvNn9c4gE7PoPOvbhCPRYq45xbj
 AX09gQ2MTR/DuCbVw+xpN35WQkl827AX6LO2Cc9hbgcaYwUs1IkPGnGrD
 pKyXhOLLTnxb5WCqYxe5Nrb4T+FsDiq0Cy+VesFMY0rLVYNBsagrxtetn g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13934107"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="13934107"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 05:56:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6662934"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2024 05:56:00 -0800
Date: Mon, 26 Feb 2024 22:09:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH 02/10] hw/i386/pc: Do pc_cmos_init_late() from
 pc_machine_done()
Message-ID: <ZdybpokP2q+ayi2Z@intel.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160622.114437-3-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Tue, Feb 20, 2024 at 04:06:14PM +0000, Peter Maydell wrote:
> Date: Tue, 20 Feb 2024 16:06:14 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 02/10] hw/i386/pc: Do pc_cmos_init_late() from
>  pc_machine_done()
> X-Mailer: git-send-email 2.34.1
> 
> In the i386 PC machine, we want to run the pc_cmos_init_late()
> function only once the IDE and floppy drive devices have been set up.
> We currently do this using qemu_register_reset(), and then have the
> function call qemu_unregister_reset() on itself, so it runs exactly
> once.
> 
> This was an expedient way to do it back in 2010 when we first added
> this (in commit c0897e0cb94e8), but now we have a more obvious point
> to do "machine initialization that has to happen after generic device
> init": the machine-init-done hook.
> 
> Do the pc_cmos_init_late() work from our existing PC machine init
> done hook function, so we can drop the use of qemu_register_reset()
> and qemu_unregister_reset().
> 
> Because the pointers to the devices we need (the IDE buses and the
> RTC) are now all in the machine state, we don't need the
> pc_cmos_init_late_arg struct and can just pass the PCMachineState
> pointer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/i386/pc.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


