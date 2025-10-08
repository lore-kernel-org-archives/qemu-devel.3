Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC84CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 11:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6SIt-0000Zq-PS; Wed, 08 Oct 2025 07:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v6SIs-0000Zd-4N
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:25:54 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v6SIq-0005AP-DU
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:25:53 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 07C79406CD;
 Wed,  8 Oct 2025 11:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678EEC4CEF4;
 Wed,  8 Oct 2025 11:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759922750;
 bh=aFEhoYDAhCVC6PyY8ZrlUZht3yUsY0wyaIhThtFLA4w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Av2DtcjJQmsP+YtQHGNjSsL2X+ntVZ/zYB68yCy6zRaNnwSBw7/LsFpAh30eUwfYP
 DLjjKVoaAUs7SvEAYnvu9AnAI4BTWJmZ+pzaLw9VQVGIan0Pmd9LnT3Na4mpJ5H097
 14Aq2c2t1BQAIOZzP830CW84W1Qe1aw2BM6eM1Dd8iREnxI60HyrIj54WN2yrmazc8
 CcajtzX+jVUFqIuJE0bq+QHRZVMZejtVjDWHex8mdE0HSSVBXdm8/2EIcgZA3hV/eW
 2cM4BRdjLu6apGvFSQ5j/MMfdSvkMxfdNrJp1I7UXjuNX732+huzTboXLdSg961bYL
 RtnCQV1I6Nbrw==
Date: Wed, 8 Oct 2025 15:22:52 +0530
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
Message-ID: <uzfmnzzhz7a7lghdpazb2sphtctphmsj2nyfqnu6erjt44h577@bjj57um7n2ze>
References: <cover.1758794556.git.naveen@kernel.org>
 <65400881e426aa0e412eb431099626dceb145ddd.1758794556.git.naveen@kernel.org>
 <6a9ce7bb-5c69-ad8b-8bfd-638122619c71@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a9ce7bb-5c69-ad8b-8bfd-638122619c71@amd.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=naveen@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 07, 2025 at 08:31:47AM -0500, Tom Lendacky wrote:
> On 9/25/25 05:17, Naveen N Rao (AMD) wrote:

...

> > +
> > +static void
> > +sev_snp_guest_set_tsc_frequency(Object *obj, Visitor *v, const char *name,
> > +                                void *opaque, Error **errp)
> > +{
> > +    uint32_t value;
> > +
> > +    if (!visit_type_uint32(v, name, &value, errp)) {
> > +        return;
> > +    }
> > +
> > +    SEV_SNP_GUEST(obj)->tsc_khz = value / 1000;
> 
> This will cause a value that isn't evenly divisible by 1000 to be
> rounded down, e.g.: tsc-frequency=2500000999. Should this name instead
> just be tsc-khz or secure-tsc-khz (to show it is truly associated with
> Secure TSC)?

I modeled this after the existing tsc-frequency parameter on the cpu 
object to keep it simple (parameter is the same, just where it is 
specified differs). This also aligns with TDX which re-uses the 
tsc-frequency parameter on the cpu object.

> 
> Also, I think there is already a "tsc-freq" parameter for the -cpu
> parameter (?), should there be some kind of error message if both of
> these are set? Or a warning saying it is being ignored? Or ...?

This is validated when the TSC frequency is being set on the vcpu, so I didn't
add an explicit check.

As an example, with:
  -cpu EPYC-v4,tsc-frequency=2500000000 \
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,secure-tsc=on

qemu-system-x86_64: warning: TSC frequency mismatch between VM (2500000 kHz) and host (2596099 kHz), and TSC scaling unavailable
qemu-system-x86_64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument


Thanks,
Naveen


