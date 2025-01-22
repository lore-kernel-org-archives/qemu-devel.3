Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283B9C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadnP-00089v-01; Wed, 22 Jan 2025 11:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tadnN-00089j-W8; Wed, 22 Jan 2025 11:41:38 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tadnL-0003w0-IC; Wed, 22 Jan 2025 11:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737564095; x=1769100095;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HA7E5MBHVOQ8GO8gmVyMe6RSuRY1j98khQpGMbsP4so=;
 b=kTylyvhOQyc6fqFn4/TY6LXFgCs6/o7scnB0k1gP593Ep2d127F6V2YZ
 l+G0Lq6nD2ocfk1zzFVFzOjIQ4Snxt8w2Cy8MtvkTnOimbIfwuJ0ZTjLw
 vyCDX/bL2NKcCt0ArewKz/5O2Bc12JS2BK6gxrwQPjL4bhNP4dcll5+Hr
 zq02Ol7+K/OrrZ3lTaQHUeM1dAGCJp9VA4Wk1Z2chFCLzTrONC7d48mZa
 b4TwD4KktLPmxGZtgi3XVcte4uDIO1DD+fyzOTLb1u4Iwcwcl1yuR10jg
 x2lE8SpD3gTXlQCI9SA+/f3ZViFZXrlAalke/dswBvFRzCCtJFDCv3Adl g==;
X-CSE-ConnectionGUID: IdeP5XIeTxqvExn3BMyuiQ==
X-CSE-MsgGUID: 5PNv4vCYSiG/Cdo4ksUa7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="40852203"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="40852203"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 08:41:32 -0800
X-CSE-ConnectionGUID: AnscbEFIRoebmfnRqx9XZw==
X-CSE-MsgGUID: okt9cAGgT6+fB/6lF8yDRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111833339"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 22 Jan 2025 08:41:31 -0800
Date: Thu, 23 Jan 2025 01:00:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/10] rust: pl011: extract conversion to RegisterOffset
Message-ID: <Z5EkRg8IUrlmHeVA@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-4-pbonzini@redhat.com>
 <Z5EB3b0VqvqxUaWm@intel.com>
 <6d7ad183-6685-4ba6-a8ef-d899162879ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d7ad183-6685-4ba6-a8ef-d899162879ea@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

> > > -    pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u64, u64> {
> > > +    fn regs_read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
> > >           use RegisterOffset::*;
> > 
> > Can we move this "use" to the start of the file?
> 
> I don't think it's a good idea to make the register names visible
> globally...  "use Enum::*" before a match statement is relatively common.
> For example: https://doc.rust-lang.org/src/std/io/error.rs.html#436

Thanks!

> > > +    pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
> > 
> > Maybe pub(crate)? But both are fine for me :-)
> 
> The struct is not public outside the crate, so it doesn't make a difference,
> does it?

You're right.

> > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Thanks, I'll post a quick v2 anyway once you've finished reviewing.
> 

The remaining critical ones, I'll go through them all tomorrow.

Regerds,
Zhao


