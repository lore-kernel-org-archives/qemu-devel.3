Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032D1C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ric19-0006RJ-Qb; Fri, 08 Mar 2024 10:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ric18-0006NV-3l
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:20:14 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ric15-0004xR-QK
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709911212; x=1741447212;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=37x1enO9CuT262PPueVsjTold9mUMUYf4OwlO+MhuoY=;
 b=V4dw2kkCcgEm7TMnnTSgL23komvNmuF1K3a+eWNZjDYV1982L5Jei//k
 wMCAwCXHI3AFdK6y3O1E4gplVNXyHAv8L+OB85sMy+oHGCDHwNIUSOpPX
 RXWhllgrC5z9VsV1ntHTIf7TXoWhEu+qiJG3Em/SoA4yRQikT5kzQIURt
 iVRC2XgPbozcqwu66lmTyjeb82jMkYy394wQgMII53LQLEC0qVqnp0gX9
 L8Mt6JGTQbx0BsnEgIIshdCZwXxoIf7TdwrLooiMPXRxWQlVbwBk3cb6o
 u+9UPjxuI4HSNbt3zaSONbl5CjG1vCU19zqfS/T4xJ0gmKPBqFWs5Xfbw g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="22086167"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; d="scan'208";a="22086167"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 07:20:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; d="scan'208";a="15164654"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 08 Mar 2024 07:20:06 -0800
Date: Fri, 8 Mar 2024 23:33:53 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 03/14] hw/core/machine-smp: Simplify variables'
 initialization in machine_parse_smp_config()
Message-ID: <Zesv4W8DKteGeE/a@intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-4-zhao1.liu@linux.intel.com>
 <c2bd5503-7ab1-41b7-af81-2f5bf5992ad3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2bd5503-7ab1-41b7-af81-2f5bf5992ad3@redhat.com>
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi Thomas,

On Fri, Mar 08, 2024 at 02:20:45PM +0100, Thomas Huth wrote:
> Date: Fri, 8 Mar 2024 14:20:45 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: Re: [PATCH 03/14] hw/core/machine-smp: Simplify variables'
>  initialization in machine_parse_smp_config()
> 
> On 06/03/2024 10.53, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > SMPConfiguration initializes its int64_t members as 0 by default.
> 
> Can we always rely on that? ... or is this just by luck due to the current
> implementation? In the latter case, I'd maybe rather drop this patch again.
>

Thanks for the correction, I revisited and referenced more similar use
cases, and indeed, only if the flag "has_*" is true, its corresponding
field should be considered reliable.

Keeping explicit checking on has_* and explicit initialization of these
topology variables makes the code more readable.

This patch is over-optimized and I would drop it.

Regards,
Zhao



