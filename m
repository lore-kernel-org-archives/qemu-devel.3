Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C26CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 13:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs0no-00057a-5u; Wed, 03 Apr 2024 09:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill.shutemov@linux.intel.com>)
 id 1rs0nj-00057I-No
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 09:37:16 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill.shutemov@linux.intel.com>)
 id 1rs0nh-0006AM-Ik
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 09:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712151432; x=1743687432;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=XEHj3c3nj2E1N1WGsIp8LhGRbiN0XyxURglFs1/jb1U=;
 b=RJjM25F7WvVslKTcoTRpzMj1RI0pOaxPoMyo9vQWtpCsi3XbKkPLhRnG
 xfOshP9lHL9vFhDIzwILqm5aIe8AlwebD5ZIPWRXF52MtI5QGOgtJq3Sf
 8KwarYwidfesIxGD+0GxgneSQ7FALb9THdFuubpW1Jo2U2hEfoAboezcu
 doscx5pdr2e4gjE4imXTuokqKaTdhfxqr7r/Sde0/u/G+gGSDoC3LX10t
 t/f9oF07zt3xB3ayZq/MIG2I9n08zPQ5zcqkusCEPfSHpxInLURMNYMjl
 6FL+Jy/m56gLGvT+YSvEqrIG3jgoHl9Zx++rUHb/olNq06SOM4eZ8lFuo A==;
X-CSE-ConnectionGUID: 78pAdP8kSYWDdDdQFZtU5g==
X-CSE-MsgGUID: LbeRPiA+RwGLeEAKVPDo8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="17954840"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; d="scan'208";a="17954840"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 06:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085050"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; d="scan'208";a="937085050"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 06:37:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
 id E716657D; Wed,  3 Apr 2024 16:37:04 +0300 (EEST)
Date: Wed, 3 Apr 2024 16:37:04 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 isaku.yamahata@intel.com
Subject: Re: [PATCH] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is not
 disabled
Message-ID: <pludfku3el7l5qgilmxio56m5ld6nq2mn2icgic6i7kfn3p2je@bes2h4y7k2xz>
References: <20240402082516.2921143-1-xiaoyao.li@intel.com>
 <20240402060109-mutt-send-email-mst@kernel.org>
 <d3a3c9bc-a783-4293-bd1b-b00135ec2685@intel.com>
 <20240402103123-mutt-send-email-mst@kernel.org>
 <f887c77a-bb8c-46cf-aedc-1637bd7ad08e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f887c77a-bb8c-46cf-aedc-1637bd7ad08e@intel.com>
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=kirill.shutemov@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 03, 2024 at 10:03:15AM +0800, Xiaoyao Li wrote:
> On 4/2/2024 10:31 PM, Michael S. Tsirkin wrote:
> > On Tue, Apr 02, 2024 at 09:18:44PM +0800, Xiaoyao Li wrote:
> > > On 4/2/2024 6:02 PM, Michael S. Tsirkin wrote:
> > > > On Tue, Apr 02, 2024 at 04:25:16AM -0400, Xiaoyao Li wrote:
> > > > > Set MADT.FLAGS[bit 0].PCAT_COMPAT based on x86ms->pic.
> > > > > 
> > > > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > 
> > > > Please include more info in the commit log:
> > > > what is the behaviour you observe, why it is wrong,
> > > > how does the patch fix it, what is guest behaviour
> > > > before and after.
> > > 
> > > Sorry, I thought it was straightforward.
> > > 
> > > A value 1 of PCAT_COMPAT (bit 0) of MADT.Flags indicates that the system
> > > also has a PC-AT-compatible dual-8259 setup, i.e., the PIC.
> > > 
> > > When PIC is not enabled for x86 machine, the PCAT_COMPAT bit needs to be
> > > cleared. Otherwise, the guest thinks there is a present PIC even it is
> > > booted with pic=off on QEMU.
> > > 
> > > (I haven't seen real issue from Linux guest. The user of PIC inside guest
> > > seems only the pit calibration. Whether pit calibration is triggered depends
> > > on other things. But logically, current code is wrong, we need to fix it
> > > anyway.
> > > 
> > > @Isaku, please share more info if you have)
> > > 
> 
> + Kirill,
> 
> It seems to have issue with legacy irqs with PCAT_COMPAT set 1 while no PIC
> on QEMU side. Kirill, could you elaborate it?

TDX guest cannot support PIC because the platform doesn't allow direct
interrupt injection, only posted interrupts.

For TDX guest kernel we had a patch[1] that forces no-PIC, but it is not
upstreamable as it is a hack.

I looked around to find The Right Way™ to archive the same effect and
discovered that we only have PIC ops hooked up because kernel bypasses[2]
PIC enumeration because PCAT_COMPAT is set. Which is wrong for TDX guest
or other platforms without PIC.

I am not aware about any user-visible issues due to it, but maybe they are
just not discovered yet.

[1] https://lore.kernel.org/linux-kernel/b29f00c1eb5cff585ec2b999b69923c13418ecc4.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/i8259.c#n322

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

