Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DFCE7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 15:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJx1P-0006GA-BD; Sat, 07 Dec 2024 10:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJx1L-0006Fo-4S; Sat, 07 Dec 2024 10:47:03 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJx1I-0002P3-OY; Sat, 07 Dec 2024 10:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733586421; x=1765122421;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5HO3QTnaC5iFkhFEywlwSIMggWHgJGN/BGF5+fujBAE=;
 b=DBbnzmmUA1uDNIa5qyygg+LmYel7qyy07vMv/NaiSbqTD+VA5T/KLWAg
 auYYVymFGysSmLRIsUn98QTi9Z6oOHzEMYLcLR0nHRCPrkWOR7EY6R7iQ
 b3PkNWnUD6ecUtZLLzOAXACcn2RWLalkubHej13TOBWBLqbkdLJfqVbkE
 2F+Jf5gCXPlg6E92fF4z7L+15TIAVRKCHvCDhLYRZZLilGzKLOtloiglo
 SuemKGkBaaJC7dxC2Xg2jLsvG6UmYN799m6QbBOYug+0jwiALClMBjLIS
 0r/AEV4FYbUJPl8QMy7+f05CVMdvCjEbisLwHI3sXlcfjCHUVavk13XjF A==;
X-CSE-ConnectionGUID: 5Ebo5k97TN6mte4KgvNFTw==
X-CSE-MsgGUID: nl1eT23/TO2vPKLsff8Q4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="34046641"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="34046641"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2024 07:46:58 -0800
X-CSE-ConnectionGUID: twZOGX3MRuyMCgrZ/qaq0g==
X-CSE-MsgGUID: btwqK0U2Rk6xIINZcUAX1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="95037660"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 07 Dec 2024 07:46:55 -0800
Date: Sun, 8 Dec 2024 00:05:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 12/13] rust/timer/hpet: add qdev APIs support
Message-ID: <Z1RyNGHFz0y7fA3C@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-13-zhao1.liu@intel.com>
 <2345dbef-039c-4390-9671-75c8b529e13f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2345dbef-039c-4390-9671-75c8b529e13f@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 05, 2024 at 07:58:07PM +0100, Paolo Bonzini wrote:
> Date: Thu, 5 Dec 2024 19:58:07 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 12/13] rust/timer/hpet: add qdev APIs support
> 
> On 12/5/24 07:07, Zhao Liu wrote:
> > Implement QAPI support for HPET device in qdev.rs.
> > 
> > Additionally, wrap the handling of HPET internal details as traits to be
> > specifically implemented in hpet.rs.
> 
> Why not just put everything in a simple file to avoid the traits?

Ah, I considered that qdev has many unsafe C-style wrappers, to avoid
confusion with HPET state/timer methods... However, looking back now,
qdev and qom are already quite clean. I will merge this into hpet.rs in
the next version.

> > +pub(crate) trait RamOps {
> > +    fn read(&mut self, addr: hwaddr, _size: c_uint) -> u64;
> > +    fn write(&mut self, addr: hwaddr, value: u64, size: u64);
> > +}
> 
> Please try as much as possible to make these "&self", same for the GPIO
> handler.  That's the point of BqlCell/BqlRefCell. :)

Sure! Will do as you suggested.

Regards,
Zhao


