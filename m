Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0A2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPOI-0002BM-Df; Mon, 29 Jul 2024 08:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYPOG-00027F-3r; Mon, 29 Jul 2024 08:22:12 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYPO7-0008Pa-22; Mon, 29 Jul 2024 08:22:05 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AFC8D61695;
 Mon, 29 Jul 2024 12:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76609C32786;
 Mon, 29 Jul 2024 12:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722255720;
 bh=OHF10ytzKDJKK8yB0tCLTAdFrlhZAGLKi90cSr3k3kk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jpr5f4c8+eLVa6HVIpPRqw53PW26Fs+uOZ5f0V8Zp4mO6aZtiwvTjSFsvnnHGdCRD
 g617SKwFCI1j5Fno2Zz7F591CM3xqagE0KeDqsiyXQwD8bW0y9PDC6OBVOs4quGnuZ
 Nv8b/cop5l25OyMo9L2IBPkjWNy82aMHFHCL4NE2W1CvugwC/0V9u0/T2pVZ/SsveC
 SUiTTswQxuMwLIPasKT+uc9/rH5b2ooM5Hh0+vVBug2zeMC3+lbKxQ6ZUhWex4miqA
 B4fIu4tsttdNL2Tn/e4nz+ZvSA4B9/bmzjFfl1b80Bb4OPG+fN9U1Xz/bd0DpK9w2P
 uVKmDGRBgwkVw==
Date: Mon, 29 Jul 2024 14:21:54 +0200
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
Message-ID: <20240729142154.44d484c4@foz.lan>
In-Reply-To: <87bk2lreeb.fsf@pond.sub.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
 <87bk2lreeb.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

Em Thu, 25 Jul 2024 11:48:12 +0200
Markus Armbruster <armbru@redhat.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > 1. Some GHES functions require handling addresses. Add a helper function
> >    to support it.
> >
> > 2. Add support for ACPI CPER (firmware-first) ARM processor error injection.
> >
> > Compliance with N.2.4.4 ARM Processor Error Section in UEFI 2.6 and
> > upper specs, using error type bit encoding as detailed at UEFI 2.9A
> > errata.
> >
> > Error injection examples:
> >
> > { "execute": "qmp_capabilities" }
> >
> > { "execute": "arm-inject-error",
> >       "arguments": {
> >         "errortypes": ['cache-error']
> >       }
> > }
> >
> > { "execute": "arm-inject-error",
> >       "arguments": {
> >         "errortypes": ['tlb-error']
> >       }
> > }
> >
> > { "execute": "arm-inject-error",
> >       "arguments": {
> >         "errortypes": ['bus-error']
> >       }
> > }
> >
> > { "execute": "arm-inject-error",
> >       "arguments": {
> >         "errortypes": ['cache-error', 'tlb-error']
> >       }
> > }
> >
> > { "execute": "arm-inject-error",
> >       "arguments": {
> >         "errortypes": ['cache-error', 'tlb-error', 'bus-error', 'micro-arch-error']
> >       }
> > }
> > ...
> >
> > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> > For Add a logic to handle block addresses,
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > For FW first ARM processor error injection,
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > ---
> >  configs/targets/aarch64-softmmu.mak |   1 +
> >  hw/acpi/ghes.c                      | 258 ++++++++++++++++++++++++++--
> >  hw/arm/Kconfig                      |   4 +
> >  hw/arm/arm_error_inject.c           |  35 ++++
> >  hw/arm/arm_error_inject_stubs.c     |  18 ++
> >  hw/arm/meson.build                  |   3 +
> >  include/hw/acpi/ghes.h              |   2 +
> >  qapi/arm-error-inject.json          |  49 ++++++
> >  qapi/meson.build                    |   1 +
> >  qapi/qapi-schema.json               |   1 +
> >  10 files changed, 361 insertions(+), 11 deletions(-)
> >  create mode 100644 hw/arm/arm_error_inject.c
> >  create mode 100644 hw/arm/arm_error_inject_stubs.c
> >  create mode 100644 qapi/arm-error-inject.json  
> 
> Since the new file not covered in MAINTAINERS, get_maintainer.pl will
> blame it on the QAPI maintainers alone.  No good.

Added myself there:

diff --git a/MAINTAINERS b/MAINTAINERS
index 98eddf7ae155..713a104ef901 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
 F: include/hw/acpi/ghes.h
 F: docs/specs/acpi_hest_ghes.rst
 
+ACPI/HEST/GHES/ARM processor CPER
+R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+S: Maintained
+F: hw/arm/arm_error_inject.c
+F: hw/arm/arm_error_inject_stubs.c
+F: qapi/arm-error-inject.json
+
 ppc4xx
 L: qemu-ppc@nongnu.org
 S: Orphan

> 
> [...]
> 
> > diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
> > new file mode 100644
> > index 000000000000..430e6cea6b60
> > --- /dev/null
> > +++ b/qapi/arm-error-inject.json
> > @@ -0,0 +1,49 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=python
> > +
> > +##
> > +# = ARM Processor Errors
> > +##
> > +
> > +##
> > +# @ArmProcessorErrorType:
> > +#
> > +# Type of ARM processor error to inject
> > +#
> > +# @unknown-error: Unknown error  
> 
> Removed in PATCH 7, and unused until then.  Why add it in the first
> place?

I folded this with patch 7, so this was gone now.

> 
> > +#
> > +# @cache-error: Cache error
> > +#
> > +# @tlb-error: TLB error
> > +#
> > +# @bus-error: Bus error.
> > +#
> > +# @micro-arch-error: Micro architectural error.
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'enum': 'ArmProcessorErrorType',
> > +  'data': ['unknown-error',
> > +	   'cache-error',  
> 
> Tab in this line.  Please convert to spaces.

Ok.

> 
> > +           'tlb-error',
> > +           'bus-error',
> > +           'micro-arch-error']
> > +}
> > +
> > +##
> > +# @arm-inject-error:
> > +#
> > +# Inject ARM Processor error.
> > +#
> > +# @errortypes: ARM processor error types to inject
> > +#
> > +# Features:
> > +#
> > +# @unstable: This command is experimental.
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'command': 'arm-inject-error',
> > +  'data': { 'errortypes': ['ArmProcessorErrorType'] },  
> 
> Please separate words with dashes: 'error-types'.

Done.

Folding with patch 7 broke it on two separate fields: error and
type.

> 
> > +  'features': [ 'unstable' ]
> > +}  
> 
> Is this used only with TARGET_ARM?

Yes, as this CPER record is defined only for arm. There are three other
processor error info:
	- for x86;
	- for ia32;
	- for "generic cpu".

They have different structures, with different fields.

> Why is being able to inject multiple error types at once useful?

The CPER ARM Processor record is defined at UEFI spec as having from 1 to
255 errors, that can be using the same type or not. The idea behind UEFI
spec is that a single root error may be reflected on multiple errors.

It may also help to reduce BIOS interrupts to OS, by merging errors
altogether, as memory errors usually happen in bursts.

Due to that, a single Processor Error Information inside a CPER record
for ARM processor can, according with UEFI spec, contain more than one
of the following bits set:

            +-----|---------------------------+
            | Bit | Meaning                   |
            +=====+===========================+
            |  1  | Cache Error               |
            |  2  | TLB Error                 |
            |  3  | Bus Error                 |
            |  4  | Micro-architectural Error |
            +-----|---------------------------+

So, the spec allows, for instance, to have a single Processor Error
Information (PEI) with micro-arch and tlb-error flags raised at the
same time.

We need the capability of testing multiple error types in order to check
if OS implementation is decoding it the right way. In particular, Linux
was not doing it right, as the CPER ARM Processor record handler was 
written at the time UEFI 2.6 spec was written, while the actual encoding
for the error type was only defined at UEFI 2.9A errata and newer.

> I'd expect at least some of these errors to come with additional
> information.  For instance, I imagine a bus error is associated with
> some address.

It actually depends on the ARM and PEI valid fields: the address may or 
may not be present, depending if the phy/logical address valid field bit
is set or not.

> 
> If we encode the the error to inject as an enum value, adding more will
> be hard.
> 
> If we wrap the enum in a struct
> 
>     { 'struct': 'ArmProcessorError',
>       'data': { 'type': 'ArmProcessorErrorType' } }
> 
> we can later extend it like
> 
>     { 'union': 'ArmProcessorError',
>       'base: { 'type': 'ArmProcessorErrorType' }
>       'data': {
>           'bus-error': 'ArmProcessorBusErrorData' } }
> 
>     { 'struct': 'ArmProcessorBusErrorData',
>       'data': ... }

I don't see this working as one might expect. See, the ARM error
information data can be repeated from 1 to 255 times. It is given 
by this struct (see patch 7):

	{ 'struct': 'ArmProcessorErrorInformation',
	  'data': { '*validation': ['ArmPeiValidationBits'],
	            'type': ['ArmProcessorErrorType'],
	            '*multiple-error': 'uint16',
	            '*flags': ['ArmProcessorFlags'],
	            '*error-info': 'uint64',
	            '*virt-addr':  'uint64',
	            '*phy-addr': 'uint64'}
	}

According with the UEFI spec, the type is always be present.
The other fields are marked as valid or not via the field
"validation". So, there's one bit indicating what is valid between
the fields at the PEI structure, e. g.:

	- multiple-error: multiple occurrences of the error;
	- flags;
	- error-info: error information;
	- virt-addr: virtual address;
	- phy-addr: physical address.

There are also other fields that are global for the entire record,
also marked as valid or not via another bitmask.

The contents of almost all those fields are independent of the error
type. The only field which content is affected by the error type is
"error-info", and the definition of such field is not fully specified.

So, currently, UEFI spec only defines it when:

1. the error type has just one bit set;
2. the error type is either cache, TLB or bus error[1].
   If type is micro-arch-specific error, the spec doesn't tell how this 
   field if filled.

To make the API simple (yet powerful), I opted to not enforce any encoding
for error-info: let userspace fill it as required and use some default
that would make sense, if this is not passed via QMP.

[1] See https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information

> > diff --git a/qapi/meson.build b/qapi/meson.build
> > index e7bc54e5d047..5927932c4be3 100644
> > --- a/qapi/meson.build
> > +++ b/qapi/meson.build
> > @@ -22,6 +22,7 @@ if have_system or have_tools or have_ga
> >  endif
> >  
> >  qapi_all_modules = [
> > +  'arm-error-inject',
> >    'authz',
> >    'block',
> >    'block-core',
> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> > index b1581988e4eb..479a22de7e43 100644
> > --- a/qapi/qapi-schema.json
> > +++ b/qapi/qapi-schema.json
> > @@ -81,3 +81,4 @@
> >  { 'include': 'vfio.json' }
> >  { 'include': 'cryptodev.json' }
> >  { 'include': 'cxl.json' }
> > +{ 'include': 'arm-error-inject.json' }  
> 

Thanks,
Mauro

