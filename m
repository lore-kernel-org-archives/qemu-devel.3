Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D6EC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 06:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfwMz-0005DW-Q4; Fri, 01 Mar 2024 01:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfwMw-0005CL-Fn; Fri, 01 Mar 2024 01:27:42 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfwMu-0005Zl-5i; Fri, 01 Mar 2024 01:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709274460; x=1740810460;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XCtpnWdSB/ppu1KW/ef5a+BODFHs3LeeZAZC2Iuvn1w=;
 b=XJfmQqG8rtyZqACccIG1c1JNh0vfj0xxvBbvW0ruMZ4p8I9kzxmTmPsH
 Pmny2GKqy5891pSYQGqHGHwNlJYlYLrSMzRLsEXeMee8v4r+gDQTKzprB
 /Mnd49Z1tRX1zmkOr7EvKElQifqa5ld+L3sg9faKRa78BAHQ2epdUZQQk
 p07Jjga04yBpNVahu9u+GcC6jSj1+XKn2UvAqx1KOozoE/8GHsp/wEwDc
 +ThNwCBeNZ7s+o3aax2JW9/qG3gn2afw4eIKPN/SxJd5Y8FK3c1jgqTa4
 tXR2VqYp9wo1h0WfSin1di2iLLLXlvZf6rwimFJH6dqv+wQcEU7NfAPs2 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3722835"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3722835"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 22:27:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; d="scan'208";a="39114543"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 29 Feb 2024 22:27:33 -0800
Date: Fri, 1 Mar 2024 14:41:17 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Juan Quintela <quintela@trasno.org>,
 Steve Sistare <steven.sistare@oracle.com>,
 Michael Galaxy <mgalaxy@akamai.com>
Subject: Re: [PATCH 01/17] hw/misc/ivshmem: Fix missing ERRP_GUARD() for
 error_prepend()
Message-ID: <ZeF4jZ3NEqGYXkVG@intel.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-2-zhao1.liu@linux.intel.com>
 <dec70521-cacc-419c-8405-44780b39f84a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dec70521-cacc-419c-8405-44780b39f84a@redhat.com>
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

> > @@ -832,6 +832,7 @@ static void ivshmem_write_config(PCIDevice *pdev, uint32_t address,
> >   static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       IVShmemState *s = IVSHMEM_COMMON(dev);
> >       Error *err = NULL;
> 
> Please remove "err" and the error_propagate in here now.

OK, I hadn't thought of that. Thanks.

Regards,
Zhao

