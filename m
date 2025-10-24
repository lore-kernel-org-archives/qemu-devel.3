Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0459CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 17:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCLXy-0004vz-FT; Fri, 24 Oct 2025 13:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vCLXv-0004ve-Jy
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:25:47 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vCLXt-0001M4-IS
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:25:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B6B626023A;
 Fri, 24 Oct 2025 17:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3475C4CEF1;
 Fri, 24 Oct 2025 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761326743;
 bh=whe1EgFnKNzU49GGbQWXa7d8Iw0DdHK2jOM6pT46VoM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Zntnr1aCVUG/d5vY3i7gDibOEN38IWE+AYb//5q4eSLKSwwDp9uAnww0yT2Wsr/qk
 QEq6u3AfTJB88X/uLA2zjE3Q4pwOEG32e/Q0jE3X58VZz1MnMV2RnxAcYyqR95xMAt
 BMmw2hOV2n+O/s/BBp7CSrqiLrPc1bvni8JNi+Q7EC/UXQ9gsPefZ2YS/YsarQ67WB
 91fZL64VVmdDFOCQeAv+AcnJZOOkEp51/PedDU6aCIxQvJr0NBfN76IHie7TiI3YA5
 fW8LwloSrckfdUiVqEgd7iy0mV2rFOxCxGn/gB4r43RGcueLjjU7B+2KFQJTI23NmI
 +Xd9hPTGUZFIw==
Date: Fri, 24 Oct 2025 22:46:48 +0530
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
Message-ID: <boyf3kr7uo7jnlratgmgaklm2a4leg37hsgfno5ywsl6qvbcvo@5dwlbncvaogv>
References: <cover.1758794556.git.naveen@kernel.org>
 <65400881e426aa0e412eb431099626dceb145ddd.1758794556.git.naveen@kernel.org>
 <6a9ce7bb-5c69-ad8b-8bfd-638122619c71@amd.com>
 <uzfmnzzhz7a7lghdpazb2sphtctphmsj2nyfqnu6erjt44h577@bjj57um7n2ze>
 <a8a324ba-e474-4733-b998-7d36be06b7f7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8a324ba-e474-4733-b998-7d36be06b7f7@amd.com>
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

On Fri, Oct 24, 2025 at 10:00:08AM -0500, Tom Lendacky wrote:
> On 10/8/25 04:52, Naveen N Rao wrote:
> > On Tue, Oct 07, 2025 at 08:31:47AM -0500, Tom Lendacky wrote:
> >> On 9/25/25 05:17, Naveen N Rao (AMD) wrote:
> > 
> > ...
> > 
> >>> +
> >>> +static void
> >>> +sev_snp_guest_set_tsc_frequency(Object *obj, Visitor *v, const char *name,
> >>> +                                void *opaque, Error **errp)
> >>> +{
> >>> +    uint32_t value;
> >>> +
> >>> +    if (!visit_type_uint32(v, name, &value, errp)) {
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    SEV_SNP_GUEST(obj)->tsc_khz = value / 1000;
> >>
> >> This will cause a value that isn't evenly divisible by 1000 to be
> >> rounded down, e.g.: tsc-frequency=2500000999. Should this name instead
> >> just be tsc-khz or secure-tsc-khz (to show it is truly associated with
> >> Secure TSC)?
> > 
> > I modeled this after the existing tsc-frequency parameter on the cpu 
> > object to keep it simple (parameter is the same, just where it is 
> > specified differs). This also aligns with TDX which re-uses the 
> > tsc-frequency parameter on the cpu object.
> 
> So why aren't we using the one on the cpu object instead of creating a
> duplicate parameter? There should be some way to get that value, no?

I had spent some time on this, but I couldn't figure out a simple way to 
make that work.

TDX uses a vcpu pre-create hook (similar to KVM) to get access to and 
set the TSC value from the cpu object. For SEV-SNP, we need the TSC 
frequency during SNP_LAUNCH_START which is quite early and we don't have 
access to the cpu object there.

Admittedly, my qemu understanding is limited. If there is a way to 
re-use the cpu tsc-frequency field, then that would be ideal.

Any ideas/suggestions?


Thanks,
Naveen


