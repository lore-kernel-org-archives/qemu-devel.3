Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0F4CCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsKd-00005w-N8; Mon, 03 Nov 2025 06:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vFsJH-0007d6-Gp
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:01:24 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vFsJ9-000566-7Y
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:01:15 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E1F8F404A5;
 Mon,  3 Nov 2025 11:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F806C4CEE7;
 Mon,  3 Nov 2025 11:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762167646;
 bh=7KlQ6SyNHBa4lk3dkpiYR4iscB2B68Q7KOAeVXNjiSw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AhLcoQGIUn+XILCnMIYp24uIaR3p69oXI/V6fr2s4n4Ec3dMk6596cJc8JewLsa4h
 KH5DwHU+y64yKfd8NNeimWaZw1szCfwTuusS6gzNKNATMviBmyE+MoOdp3QnN28hIR
 3E0UeStC9All56Gp2pdVeTWwenSKVRqubFlPtJ2+pS1KuzMH3B2FH0RmZ/TnN2nNyk
 EMt7J7LPi9rFPVn+cmbUk3Bv/t5UvugJbWayoVuYrfsVT6o76K8yFJd0epMFsa1XJX
 1sQkHZGC+JKDimTmCwtmVY/gilo49irmmg9oPAnPj9OcsFleJisA43gCgRZCIYaAar
 1djVvz8IQq03g==
Date: Mon, 3 Nov 2025 16:25:02 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org,
 Nikunj A Dadhania <nikunj@amd.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Zhao Liu <zhao1.liu@intel.com>, Michael Roth <michael.roth@amd.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [PATCH v2 8/9] target/i386: SEV: Add support for setting TSC
 frequency for Secure TSC
Message-ID: <hbfmcwhus6oyggzfrjz3rdkdrzfmeeuab45bnipta2bo5wj6z3@os4yj4ywoahn>
References: <cover.1758794556.git.naveen@kernel.org>
 <65400881e426aa0e412eb431099626dceb145ddd.1758794556.git.naveen@kernel.org>
 <6a9ce7bb-5c69-ad8b-8bfd-638122619c71@amd.com>
 <uzfmnzzhz7a7lghdpazb2sphtctphmsj2nyfqnu6erjt44h577@bjj57um7n2ze>
 <a8a324ba-e474-4733-b998-7d36be06b7f7@amd.com>
 <boyf3kr7uo7jnlratgmgaklm2a4leg37hsgfno5ywsl6qvbcvo@5dwlbncvaogv>
 <acb88951-b46f-4a08-8cd7-4e2d20e153f4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb88951-b46f-4a08-8cd7-4e2d20e153f4@amd.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=naveen@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Oct 28, 2025 at 10:11:13AM -0500, Tom Lendacky wrote:
> On 10/24/25 12:16, Naveen N Rao wrote:
> > On Fri, Oct 24, 2025 at 10:00:08AM -0500, Tom Lendacky wrote:
> >> On 10/8/25 04:52, Naveen N Rao wrote:
> >>> On Tue, Oct 07, 2025 at 08:31:47AM -0500, Tom Lendacky wrote:
> >>>> On 9/25/25 05:17, Naveen N Rao (AMD) wrote:
> >>>
> >>> ...
> >>>
> >>>>> +
> >>>>> +static void
> >>>>> +sev_snp_guest_set_tsc_frequency(Object *obj, Visitor *v, const char *name,
> >>>>> +                                void *opaque, Error **errp)
> >>>>> +{
> >>>>> +    uint32_t value;
> >>>>> +
> >>>>> +    if (!visit_type_uint32(v, name, &value, errp)) {
> >>>>> +        return;
> >>>>> +    }
> >>>>> +
> >>>>> +    SEV_SNP_GUEST(obj)->tsc_khz = value / 1000;
> >>>>
> >>>> This will cause a value that isn't evenly divisible by 1000 to be
> >>>> rounded down, e.g.: tsc-frequency=2500000999. Should this name instead
> >>>> just be tsc-khz or secure-tsc-khz (to show it is truly associated with
> >>>> Secure TSC)?
> >>>
> >>> I modeled this after the existing tsc-frequency parameter on the cpu 
> >>> object to keep it simple (parameter is the same, just where it is 
> >>> specified differs). This also aligns with TDX which re-uses the 
> >>> tsc-frequency parameter on the cpu object.
> >>
> >> So why aren't we using the one on the cpu object instead of creating a
> >> duplicate parameter? There should be some way to get that value, no?
> > 
> > I had spent some time on this, but I couldn't figure out a simple way to 
> > make that work.
> > 
> > TDX uses a vcpu pre-create hook (similar to KVM) to get access to and 
> > set the TSC value from the cpu object. For SEV-SNP, we need the TSC 
> > frequency during SNP_LAUNCH_START which is quite early and we don't have 
> > access to the cpu object there.
> > 
> > Admittedly, my qemu understanding is limited. If there is a way to 
> > re-use the cpu tsc-frequency field, then that would be ideal.
> > 
> > Any ideas/suggestions?
> 
> Any Qemu experts know how the SEV support would be able to access the
> TSC value from the -cpu command line option at LAUNCH time?

Bump. Any feedback on this, please?

Otherwise, kindly review v3 posted here:
http://lore.kernel.org/r/cover.1761648149.git.naveen@kernel.org


Thanks,
Naveen


