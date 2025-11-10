Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29D8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 10:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPJd-0007im-NO; Mon, 10 Nov 2025 05:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vIP5m-0000Fi-DM
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:25:46 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vIP5k-0001Cr-D5
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:25:45 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 03DB9601A4;
 Mon, 10 Nov 2025 10:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5546C16AAE;
 Mon, 10 Nov 2025 10:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762770342;
 bh=FJx4GZo4EhcFFfhPu+lR1RRTb2CLulGDdWVz8Vd3SsI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BwUZEIQNPnjyilhX5ioIKGzsgMXAtqTBPITu+z0AHAqfgUXH0TpIhMQ9NYrh3l7RM
 Vf6NUh5+1ugjwHah0FbpYj8INjPiPSLgLzEA9SgsQFLlThE29l7mQL0IHStkI0HTPC
 +q6SoLZuMifWd+I8A7rJPVeuRb96fhVX4FIYPe6ohsnFcYFSHV1A0LxCkoQhmed2tG
 YK+57sRvK5Kyw85hOPBXkLuv7JdsmSWl3lWr++O9t0+/UVEAKphyhw140WeuTuKYql
 6mzkTkvmqIwF+X/C9+/vxZpqMKz3WKa9yZPl90p0Vf+8uqzwloiuk/V+nqYJW4omAS
 8FO9Db0lM+7og==
Date: Mon, 10 Nov 2025 15:48:25 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>
Subject: Re: [PATCH v3 8/9] target/i386: SEV: Add support for setting TSC
 frequency for Secure TSC
Message-ID: <4owmig2dsml7a42latp3r4tvg6ci35zbfw6qnrj2qhtcpoultu@wqa4365pgey4>
References: <cover.1761648149.git.naveen@kernel.org>
 <cc40fed64f62649891bb8234daaba8a5cc926695.1761648149.git.naveen@kernel.org>
 <87cy5vgy66.fsf@pond.sub.org>
 <ot37mpc4y2oferchx6yroyriqickajnkiouok7quaaijq25c7n@cpqitwnuwyz2>
 <87ecqacgut.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecqacgut.fsf@pond.sub.org>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Nov 07, 2025 at 10:49:30AM +0100, Markus Armbruster wrote:
> Naveen N Rao <naveen@kernel.org> writes:
> 
> > On Thu, Nov 06, 2025 at 01:09:37PM +0100, Markus Armbruster wrote:
> >> Pardon my ignorance...
> >> 
> >> "Naveen N Rao (AMD)" <naveen@kernel.org> writes:
> >> 
> >> > Add support for configuring the TSC frequency when Secure TSC is enabled
> >> > in SEV-SNP guests through a new "tsc-frequency" property on SEV-SNP
> >> > guest objects, similar to the vCPU-specific property used by regular
> >> > guests and TDX.
> >> 
> >> Which property exactly?
> >
> > Same name: tsc-frequency specified with '-cpu'
> 
> Thanks.  It's x86_64-cpu property tsc-frequency.

Ok.

> 
> >> 
> >> >                 A new property is needed since SEV-SNP guests require
> >> > the TSC frequency to be specified during early SNP_LAUNCH_START command
> >> > before any vCPUs are created.
> >> 
> >> Sounds awkward.
> >> 
> >> Do the two properties set the same thing at different times?
> >
> > Yes. For regular guests, TSC frequency is set using a vCPU ioctl.  
> > However, TDX and SEV-SNP (with Secure TSC) require the TSC frequency to 
> > be set as a VM property (there is a VM ioctl for this purpose).
> >
> > This was Tom's question too (see v2): is there any way to re-use 
> > 'tsc-frequency' specified with '-cpu' for Secure TSC.
> 
> Hmm, let's see whether I can guess how this stuff works.  Please correct
> my misunderstandings.
> 
> When machine property confidential-guest-support is null, it's a regular
> guest.
> 
> If it points to a sev-guest object, it's SEV.

Yes, or a SEV-ES guest.

> 
> If it points to a sev-snp-guest object, it's SEV-SNP.
> 
> If it points to a tdx-guest object, it's TDX.
> 
> Normally, the TSC frequency is specified with x86_64-cpu property
> tsc-frequency.
> 
> Can different CPUs have different frequencies?

I believe Daniel has answered this in his reply.

> 
> In certain cases (SEV-SNP or TDX guest with Secure TSC), tsc-frequency

nit: TDX guest, or SEV-SNP with Secure TSC.

> needs to be configured before any CPUs are created.  You're implementing
> this for SEV-SNP, and you chose to create a sev-snp property
> tsc-frequency for this.
> 
> What happens when I enable Secure TSC with sev-snp property
> "secure-tsc": true, but don't set property tsc-frequency?

KVM uses the host default if tsc-frequency is not explicitly specified.

> 
> What happens when I do set it, and then also set the CPU property?  To
> the same frequency?  To a different frequency?

From the commit log:
  Attempts to set TSC frequency on both the SEV_SNP object and the cpu
  object result in an error from KVM (on the vCPU ioctl), so do not add
  separate checks for the same.

If the same frequency is specified in both places, then no error is 
thrown.


Thanks,
Naveen


