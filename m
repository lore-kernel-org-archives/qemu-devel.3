Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E77D5AE71
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 08:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8y9t-0000st-LR; Thu, 07 Nov 2024 03:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8y9q-0000sT-V0
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 03:46:27 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8y9o-0000vc-Hb
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 03:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730969184; x=1762505184;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YaTy+hycUaCD85D1uurv6OIwHla6GTmo65tqEZCb/6k=;
 b=nA3AcwCuaiGCvcyqpUYBb5lJFtgR1pZ3/tlIfe8HHmL0rRxT1XgdtsmF
 jaVs6nBchDdw7yy7bb+lptd7E1VqO+lvWsFaRkAscHeD83OmqgUyIOHjN
 p8c9rHsWknL0/OiZM82F/Bd/XOwngQgN/+Ip+YqzOX3gacjNTz6sA34+9
 74Rux+EnOWQOrPBLh2nbDgtPbs4fxxjnKq7JaPZMV0zgaQqCMtLIRF/ac
 mfOchoYB/O3UpFeiJqP9hHQQKGRtJzd9eFt+eeJv5aXPwZS4ZwDz0Xkkp
 l9u96aYlptcZNdYrvmr7ZgcsctH6Ih0eD3YOfD8mVFA2NWTYEdqVK1M6a Q==;
X-CSE-ConnectionGUID: IqI9LxafQlC9zCULojKkQQ==
X-CSE-MsgGUID: 5zZZUPMrT/6caAyr3UAn8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="33641553"
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; d="scan'208";a="33641553"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2024 00:46:21 -0800
X-CSE-ConnectionGUID: l/SYtaaGQHWpYxQrWDbRoQ==
X-CSE-MsgGUID: WmTJDXL1RQSBMIlL1wsEMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; d="scan'208";a="85407459"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 07 Nov 2024 00:46:19 -0800
Date: Thu, 7 Nov 2024 17:04:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: pbonzini@redhat.com, sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/i386: fix NULL-dereference
Message-ID: <ZyyCkFQX548AgEye@intel.com>
References: <20241107070415.694662-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107070415.694662-2-frolov@swemel.ru>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

+Philippe for ISAPC

On Thu, Nov 07, 2024 at 10:04:10AM +0300, Dmitry Frolov wrote:
> Date: Thu,  7 Nov 2024 10:04:10 +0300
> From: Dmitry Frolov <frolov@swemel.ru>
> Subject: [PATCH] hw/i386: fix NULL-dereference
> 
> If pcmc->pci_enabled is false, pcms->pcibus is NULL and is passed
> to pc_nic_init() where it is being dereferenced.
> 
> Found making check with enabled sanitizers.
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  hw/i386/pc_piix.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 2bf6865d40..2a92d2dbb7 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -313,9 +313,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>      /* init basic PC hardware */
>      pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>                           !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
> -
> -    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
> -
> +    if (pcmc->pci_enabled) {
> +        pc_nic_init(pcmc, isa_bus, pcms->pcibus);
> +    }
>  #ifdef CONFIG_IDE_ISA
>      if (!pcmc->pci_enabled) {
>          DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];

In principle, I think the fix is right. Currently only ISAPC's
pci_enabled is false.

I think ISAPC shouldn't need nic, so it's safe. Is this right, Phil? :)

The potential issue lies in pci_init_nic_devices() with "&bus->qbus".
Although "bus" (which is pcibus here) is NULL, the compiler seems to
optimize this, making &bus->qbus also NULL. Therefore, I did not
encounter any errors when attempting to start ISAPC.

Thanks,
Zhao



