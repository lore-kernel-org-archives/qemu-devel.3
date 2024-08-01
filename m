Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42798C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWsu-0003ir-5Y; Thu, 01 Aug 2024 10:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZWss-0003bE-AW; Thu, 01 Aug 2024 10:34:26 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZWso-0006SV-Me; Thu, 01 Aug 2024 10:34:25 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 06E58CE1A13;
 Thu,  1 Aug 2024 14:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F49C32786;
 Thu,  1 Aug 2024 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722522858;
 bh=pCLks0KKkjWtBuTbXUEEAzmun/Ei05ls4gs/i/vnJkA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=n2AIQLJJf5bEF80+we21wlGogYviVoZsrJTtML8CzYbHiFT+ORLqStGsFzUVHepmr
 bYejuNe5A81NwCH+QMWgFRKAVBHVZQjEMHxsVJTNb/zTnk0dmQrs1RWuGvNtKbzGBW
 BIPYND2tmJ2hnwU6vNQHUuYDIimSt8Q+eSq+5TPjfVlnfUOCM7287ln85SmfFDIV4C
 NvY2k4sBq/YgT3Sdmk0vNKggUFOo1iQIt+HxPw59mZ8bl2byN47cXVz1wl7yxlooeF
 LJennGKlTygqwvoHoaFkrbvK87Q7R1oem1ibFwkLF2nUAR0UkAHotbx32GMT845yeD
 YX8szBWN6mcHQ==
Date: Thu, 1 Aug 2024 16:34:12 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240801163412.48740ddb@foz.lan>
In-Reply-To: <87zfq0b75i.fsf@pond.sub.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
 <87bk2lreeb.fsf@pond.sub.org> <20240729142154.44d484c4@foz.lan>
 <87zfq0b75i.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Mon, 29 Jul 2024 16:32:41 +0200
Markus Armbruster <armbru@redhat.com> escreveu:

>  Yes, as this CPER record is defined only for arm. There are three other
> > processor error info:
> > 	- for x86;
> > 	- for ia32;
> > 	- for "generic cpu".
> >
> > They have different structures, with different fields.  
> 
> A generic inject-error command feels nicer, but coding its arguments in
> the schema could be more trouble than it's worth.  I'm not asking you to
> try.
> 
> A target-specific command like this one should be conditional.  Try
> this:
> 
>     { 'command': 'arm-inject-error',
>       'data': { 'errortypes': ['ArmProcessorErrorType'] },
>       'features': [ 'unstable' ],
>       'if': 'TARGET_ARM' }
> 
> No need to provide a qmp_arm_inject_error() stub then.

I tried it, but it generates lots of poison errors. Basically, QAPI
generation includes poison.h, making it to complain about on
non-ARM builds.

Anyway, the new version I'm about to submit is not dependent on
ARM anymore (as it is a generic GHES error injection that can be used
by any arch).

Still, as I added a Kconfig symbol for it, I still needed a stub.

It would be cool not needing it, but on the other hand it doesn't
hurt much.

> >> If we encode the the error to inject as an enum value, adding more will
> >> be hard.
> >> 
> >> If we wrap the enum in a struct
> >> 
> >>     { 'struct': 'ArmProcessorError',
> >>       'data': { 'type': 'ArmProcessorErrorType' } }
> >> 
> >> we can later extend it like
> >> 
> >>     { 'union': 'ArmProcessorError',
> >>       'base: { 'type': 'ArmProcessorErrorType' }
> >>       'data': {
> >>           'bus-error': 'ArmProcessorBusErrorData' } }
> >> 
> >>     { 'struct': 'ArmProcessorBusErrorData',
> >>       'data': ... }  
> >
> > I don't see this working as one might expect. See, the ARM error
> > information data can be repeated from 1 to 255 times. It is given 
> > by this struct (see patch 7):
> >
> > 	{ 'struct': 'ArmProcessorErrorInformation',
> > 	  'data': { '*validation': ['ArmPeiValidationBits'],
> > 	            'type': ['ArmProcessorErrorType'],
> > 	            '*multiple-error': 'uint16',
> > 	            '*flags': ['ArmProcessorFlags'],
> > 	            '*error-info': 'uint64',
> > 	            '*virt-addr':  'uint64',
> > 	            '*phy-addr': 'uint64'}
> > 	}
> >
> > According with the UEFI spec, the type is always be present.
> > The other fields are marked as valid or not via the field
> > "validation". So, there's one bit indicating what is valid between
> > the fields at the PEI structure, e. g.:
> >
> > 	- multiple-error: multiple occurrences of the error;
> > 	- flags;
> > 	- error-info: error information;
> > 	- virt-addr: virtual address;
> > 	- phy-addr: physical address.
> >
> > There are also other fields that are global for the entire record,
> > also marked as valid or not via another bitmask.
> >
> > The contents of almost all those fields are independent of the error
> > type. The only field which content is affected by the error type is
> > "error-info", and the definition of such field is not fully specified.
> >
> > So, currently, UEFI spec only defines it when:
> >
> > 1. the error type has just one bit set;
> > 2. the error type is either cache, TLB or bus error[1].
> >    If type is micro-arch-specific error, the spec doesn't tell how this 
> >    field if filled.
> >
> > To make the API simple (yet powerful), I opted to not enforce any encoding
> > for error-info: let userspace fill it as required and use some default
> > that would make sense, if this is not passed via QMP.
> >
> > [1] See https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information  
> 
> I asked because designing for extensibility is good practice.
> 
> It's not a hard requirement here, because feature 'unstable' gives us
> lincense to change the interface incompatibly.

IMO keeping it as unstable makes sense, as this QAPI is specific for
error injection, which is hardly a feature widely used. Also, with the
script approach, the actual CPER record generation happens on a script.

If we provide it together with QEMU, if the QAPI ever changes, the
changes inside the script will happen altogether. So, IMO, no need to
make it stable.

Thanks,
Mauro

