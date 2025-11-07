Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A11CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 09:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHIKU-0000ej-3N; Fri, 07 Nov 2025 04:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vHIKR-0000eP-Ki
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 04:00:19 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vHIKM-0007GZ-UH
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 04:00:19 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F26CA403CB;
 Fri,  7 Nov 2025 09:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18860C4CEF8;
 Fri,  7 Nov 2025 09:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762506009;
 bh=3e8g68W/EBHINx1+9ERUwS9Z4JKlywnF/1EVtlhfhvs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AMB9o4TlKKdbWEws1cUYXReyg9cEGb4WrnFC6M9LYksPfzlB078kJyZr7bX+BEIOa
 jHWiskxF7GSiLfrHWzoCv8eJLdY8WPsYfIZvIg2a1bM5I2EyV2p5NSQlmeLKJseHsX
 1paI0sYlrAqQptmrsuVnS7UIDRzv69Kpgk/q8n7uFzCVtvDLq6dZqAh2slYTolY7v2
 OxNnx6GH2F1qyOgz0OEt6HYULfdXZIZ2t40comHsrwyJkhQmUUC8VshpCCM6ntL4YK
 jfm/rXedQ4tGEwATaBI/K3z2V2BFh9q+Q99lByxtday8R84mUln3YjTvXsoWGDVtKC
 JM71rJCjfPCSA==
Date: Fri, 7 Nov 2025 14:21:24 +0530
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
Message-ID: <ot37mpc4y2oferchx6yroyriqickajnkiouok7quaaijq25c7n@cpqitwnuwyz2>
References: <cover.1761648149.git.naveen@kernel.org>
 <cc40fed64f62649891bb8234daaba8a5cc926695.1761648149.git.naveen@kernel.org>
 <87cy5vgy66.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cy5vgy66.fsf@pond.sub.org>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
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

On Thu, Nov 06, 2025 at 01:09:37PM +0100, Markus Armbruster wrote:
> Pardon my ignorance...
> 
> "Naveen N Rao (AMD)" <naveen@kernel.org> writes:
> 
> > Add support for configuring the TSC frequency when Secure TSC is enabled
> > in SEV-SNP guests through a new "tsc-frequency" property on SEV-SNP
> > guest objects, similar to the vCPU-specific property used by regular
> > guests and TDX.
> 
> Which property exactly?

Same name: tsc-frequency specified with '-cpu'

> 
> >                 A new property is needed since SEV-SNP guests require
> > the TSC frequency to be specified during early SNP_LAUNCH_START command
> > before any vCPUs are created.
> 
> Sounds awkward.
> 
> Do the two properties set the same thing at different times?

Yes. For regular guests, TSC frequency is set using a vCPU ioctl.  
However, TDX and SEV-SNP (with Secure TSC) require the TSC frequency to 
be set as a VM property (there is a VM ioctl for this purpose).

This was Tom's question too (see v2): is there any way to re-use 
'tsc-frequency' specified with '-cpu' for Secure TSC.

> 
> > The user-provided TSC frequency is set through KVM_SET_TSC_KHZ before
> > issuing KVM_SEV_SNP_LAUNCH_START.
> >
> > Attempts to set TSC frequency on both the SEV_SNP object and the cpu
> > object result in an error from KVM (on the vCPU ioctl), so do not add
> > separate checks for the same.
> >
> > Sample command-line:
> >   -machine q35,confidential-guest-support=sev0 \
> >   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,secure-tsc=on,tsc-frequency=2500000000
> >
> > Co-developed-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
> > Signed-off-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
> > Co-developed-by: Nikunj A Dadhania <nikunj@amd.com>
> > Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> > Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> 
> [...]
> 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index c7dd2dd1b095..5daaf065b6b7 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1104,6 +1104,9 @@
> >  # @secure-tsc: enable Secure TSC
> >  #     (default: false) (since 10.2)
> >  #
> > +# @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
> > +#     is enabled (default: zero) (since 10.2)
> 
> Is this likely to remain the only property that's only valied when
> @secure-tsc is true?

At this stage, yes. I am not aware of anything else that is specific to 
Secure TSC.


- Naveen


