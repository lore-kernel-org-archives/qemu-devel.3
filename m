Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FBBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 11:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYOHN-0003Bp-EB; Mon, 29 Jul 2024 07:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYOHL-00039u-QV; Mon, 29 Jul 2024 07:10:59 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYOHI-0002hu-IY; Mon, 29 Jul 2024 07:10:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id DA073CE01C6;
 Mon, 29 Jul 2024 11:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA060C32786;
 Mon, 29 Jul 2024 11:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722251444;
 bh=vQ8t/JYMBWYxqOxwzc/oQrWk6W2MtN5PZd/gMviaVwM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=e3VqvZBx4FzOzArpk7I0ypfEV5FDtT/ARs1H255JFdO/PdQEpqaV07R8MllKz5sIF
 DvOMr6V3tMIL5c2qvH562YcUfngLcWvbkHj2jzDEuF+hgRa7kRIIdwcaa4TbqiCzYb
 NTURnvOQEmtGG5HyL1cVxNsfAkYL8jIeTfRf7IstbS7+n0OCdiJOz9U1cPPQOZxrLr
 iFngPae+0ukcezXKbAwsOi5Q9KjCz+CY3DPlhqzR84pqplpjAELbtTBmibTjV1R5Na
 VldQWjzwgNVbD01Tqcu2SgBSZzJ+f78B1MGhi3QT3bjTpbQWGjj4qlcKZeB3OiVp7P
 IR/xFjDTtisyw==
Date: Mon, 29 Jul 2024 13:10:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Beraldo Leal <bleal@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 7/7] acpi/ghes: extend arm error injection logic
Message-ID: <20240729131037.2506686a@foz.lan>
In-Reply-To: <20240726142225.00000bdd@Huawei.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <89e8a63b5e54409dd9bc4e7f4f4c12290838371b.1721630625.git.mchehab+huawei@kernel.org>
 <20240726142225.00000bdd@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
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

Em Fri, 26 Jul 2024 14:22:25 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Mon, 22 Jul 2024 08:45:59 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>=20
> > Enrich CPER error injection logic for ARM processor to allow
> > setting values to  from UEFI 2.10 tables N.16 and N.17.
> >=20
> > It should be noticed that, with such change, all arguments are
> > now optional, so, once QMP is negotiated with:
> >=20
> > 	{ "execute": "qmp_capabilities" }
> >=20
> > the simplest way to generate a cache error is to use:
> >=20
> > 	{ "execute": "arm-inject-error" }
> >=20
> > Also, as now PEI is mapped into an array, it is possible to
> > inject multiple errors at the same CPER record with:
> >=20
> > 	{ "execute": "arm-inject-error", "arguments": {
> > 	   "error": [ {"type": [ "cache-error" ]},
> > 		      {"type": [ "tlb-error" ]} ] } }
> >=20
> > This would generate both cache and TLB errors, using default
> > values for other fields.
> >=20
> > As all fields from ARM Processor CPER are now mapped, all
> > types of CPER records can be generated with the new QAPI.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> =20
> If you are happy to smash this into patch 4 then also take ownership
> of the result and change the author as I wrote almost none of the code
> that ended up in the result as only the GHESv2 stuff was mind
> even before you joined this effort - the rest was Shiju's
>=20
> If you want, I'm fine with a co-developed on the result

Ok, I'll fold both patches.

> > ---
> >  hw/acpi/ghes.c                  | 168 +++++++-------
> >  hw/arm/arm_error_inject.c       | 399 +++++++++++++++++++++++++++++++-
> >  hw/arm/arm_error_inject_stubs.c |  20 +-
> >  include/hw/acpi/ghes.h          |  40 +++-
> >  qapi/arm-error-inject.json      | 250 +++++++++++++++++++-
> >  tests/lcitool/libvirt-ci        |   2 +-
> >  6 files changed, 778 insertions(+), 101 deletions(-)
> >=20
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index ebf1b812aaaa..afd1d098a7e3 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c =20
>=20
> > +    build_append_int_noprefix(table, err.running_state, 4);
> > +
> > +    /* PSCI state: only valid when running state is zero  */
> > +    build_append_int_noprefix(table, err.psci_state, 4);
> > +
> > +    for (i =3D 0; i < err.err_info_num; i++) {
> > +        /* ARM Propcessor error information */
> > +        /* Version */
> > +        build_append_int_noprefix(table, 0, 1);
> > +
> > +        /*  Length */
> > +        build_append_int_noprefix(table, ACPI_GHES_ARM_CPER_PEI_LENGTH=
, 1);
> > +
> > +        /* Validation Bits */
> > +        build_append_int_noprefix(table, err.pei[i].validation, 2); =20
>=20
> Maybe drop some comments when the data being written makes it obvious?

The current change preserves the already existing coding style of ghes.c.=20
See, for instance acpi_ghes_generic_error_data(). There, except for=20
revision, all other comments are obvious. From my side, I prefer to have=20
this patch preserving the same style.

Yet, if agreed, we can later send a cleanup patch dropping all obvious
comments at once.

> > +
> > +        /* Type */
> > +        build_append_int_noprefix(table, err.pei[i].type, 1);
> > +
> > +        /* Multiple error count */
> > +        build_append_int_noprefix(table, err.pei[i].multiple_error, 2);
> > +
> > +        /* Flags  */
> > +        build_append_int_noprefix(table, err.pei[i].flags, 1);
> > +
> > +        /* Error information  */
> > +        build_append_int_noprefix(table, err.pei[i].error_info, 8);
> > +
> > +        /* Virtual fault address  */
> > +        build_append_int_noprefix(table, err.pei[i].virt_addr, 8);
> > +
> > +        /* Physical fault address  */
> > +        build_append_int_noprefix(table, err.pei[i].phy_addr, 8);
> > +    }
> > +
> > +    for (i =3D 0; i < err.context_info_num; i++) {
> > +        /* ARM Propcessor error context information */
> > +        /* Version */
> > +        build_append_int_noprefix(table, 0, 2);
> > +
> > +        /* Validation type */
> > +        build_append_int_noprefix(table, err.context[i].type, 2);
> > +
> > +        /* Register array size */
> > +        build_append_int_noprefix(table, err.context[i].size * 8, 4);
> > +
> > +        /* Register array (byte 8 of Context info) */
> > +        for (j =3D 0; j < err.context[i].size; j++) {
> > +            build_append_int_noprefix(table, err.context[i].array[j], =
8);
> > +        }
> >      } =20
>=20
> > diff --git a/hw/arm/arm_error_inject.c b/hw/arm/arm_error_inject.c
> > index 1da97d5d4fdc..67f1c77546b9 100644
> > --- a/hw/arm/arm_error_inject.c
> > +++ b/hw/arm/arm_error_inject.c
> > @@ -10,23 +10,408 @@ =20
>=20
> > +
> > +/* Handle ARM Context */
> > +static ArmContext *qmp_arm_context(uint16_t *context_info_num,
> > +                                   uint32_t *context_length,
> > +                                   bool has_context,
> > +                                   ArmProcessorContextList const *cont=
ext_list)
> > +{
> > +    ArmProcessorContextList const *next;
> > +    ArmContext *context =3D NULL;
> > +    uint16_t i, j, num, default_type;
> > +
> > +    default_type =3D get_default_context_type();
> > +
> > +    if (!has_context) {
> > +        *context_info_num =3D 0;
> > +        *context_length =3D 0;
> > +
> > +        return NULL;
> > +    }
> > +
> > +    /* Calculate sizes */
> > +    num =3D 0;
> > +    for (next =3D context_list; next; next =3D next->next) {
> > +        uint32_t n_regs =3D 0;
> > +
> > +        if (next->value->has_q_register) {
> > +            uint64List *reg =3D next->value->q_register;
> > +
> > +            while (reg) {
> > +                n_regs++;
> > +                reg =3D reg->next;
> > +            }
> > +
> > +            if (next->value->has_minimal_size &&
> > +                                        next->value->minimal_size < n_=
regs) { =20
> I'd align just after (
> > +
> > +static uint8_t *qmp_arm_vendor(uint32_t *vendor_num, bool has_vendor_s=
pecific,
> > +                               uint8List const *vendor_specific_list)
> > +{
> > +    uint8List const *next =3D vendor_specific_list;
> > +    uint8_t *vendor =3D NULL, *p; =20
>=20
> vendor always set before use.

True. Will remove the assignment to NULL.

> > +
> > +    if (!has_vendor_specific) {
> > +        return NULL;
> > +    }
> > +
> > +    *vendor_num =3D 0;
> > +
> > +    while (next) {
> > +        next =3D next->next;
> > +        (*vendor_num)++;
> > +    }
> > +
> > +    vendor =3D g_malloc(*vendor_num);
> > +
> > +    p =3D vendor;
> > +    next =3D vendor_specific_list;
> > +    while (next) {
> > +        *p =3D next->value;
> > +        next =3D next->next;
> > +        p++;
> > +    }
> > +
> > +    return vendor;
> > +}
> > diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
> > index 430e6cea6b60..2a314830fe60 100644
> > --- a/qapi/arm-error-inject.json
> > +++ b/qapi/arm-error-inject.json =20
>=20
> > +
> > +##
> > +# @ArmProcessorErrorInformation:
> > +#
> > +# Contains ARM processor error information (PEI) data according with U=
EFI
> > +# CPER table N.17.
> > +#
> > +# @validation:
> > +#       Valid validation bits for error-info section.
> > +#       Argument is optional. If not specified, those flags will be en=
abled:
> > +#       first-error-cap and propagated.
> > +#
> > +# @type:
> > +#       ARM processor error types to inject. Argument is mandatory.
> > +#
> > +# @multiple-error:
> > +#       Indicates whether multiple errors have occurred.
> > +#       Argument is optional. If not specified and @validation not enf=
orced, =20
>=20
> forced probably rather than enforced.

Changed everywhere at this patch.

>=20
> > +#       this field will be marked as invalid at CPER record.. =20
> . only
>=20
> Good to mention the odd encoding of 0 =3D single error, 1 =3D multiple (l=
ost count)
> 2+ =3D actual count of errors

Added.

>=20
> > +#
> > +# @flags:
> > +#       Indicates flags that describe the error attributes.
> > +#       Argument is optional. If not specified and defaults to
> > +#       first-error and propagated.
> > +#
> > +# @error-info:
> > +#       Error information structure is specific to each error type.
> > +#       Argument is optional, and its value depends on the PEI type(s).
> > +#       If not defined, the default depends on the type:
> > +#       - for cache-error: 0x0091000F;
> > +#       - for tlb-error: 0x0054007F;
> > +#       - for bus-error: 0x80D6460FFF;
> > +#       - for micro-arch-error: 0x78DA03FF;
> > +#       - if multiple types used, this bit is disabled from @validatio=
n bits.
> > +#
> > +# @virt-addr:
> > +#       Virtual fault address associated with the error.
> > +#       Argument is optional. If not specified and @validation not enf=
orced,
> > +#       this field will be marked as invalid at CPER record..
> > +#
> > +# @phy-addr:
> > +#       Physical fault address associated with the error.
> > +#       Argument is optional. If not specified and @validation not enf=
orced,
> > +#       this field will be marked as invalid at CPER record..
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'struct': 'ArmProcessorErrorInformation',
> > +  'data': { '*validation': ['ArmPeiValidationBits'],
> > +            'type': ['ArmProcessorErrorType'],
> > +            '*multiple-error': 'uint16',
> > +            '*flags': ['ArmProcessorFlags'],
> > +            '*error-info': 'uint64',
> > +            '*virt-addr':  'uint64',
> > +            '*phy-addr': 'uint64'}
> > +}
> > +
> > +##
> > +# @ArmProcessorContext:
> > +#
> > +# Provide processor context state specific to the ARM processor archit=
ecture,
> > +# According with UEFI 2.10 CPER table N.21.
> > +# Argument is optional.If not specified, no context will be used. =20
>                           ^ space
> > +#
> > +# @type:
> > +#       Contains an integer value indicating the type of context state=
 being
> > +#       reported.
> > +#       Argument is optional. If not defined, it will be set to be EL1=
 register
> > +#       for the emulation, e. g.:
> > +#       - on arm32: AArch32 EL1 context registers;
> > +#       - on arm64: AArch64 EL1 context registers.
> > +#
> > +# @register:
> > +#       Provides the contents of the actual registers or raw data, dep=
ending
> > +#       on the context type.
> > +#       Argument is optional. If not defined, it will fill the first r=
egister
> > +#       with 0xDEADBEEF, and the other ones with zero. =20
> We could fill this in with a valid snap shot I think?  It' just a set of =
CPU registers.
> Obviously content would be pretty random and meaningless given the
> error isn't correlated with particular activity (as we triggered it) but =
maybe would
> useful for testing the parsing?

I considered this as well, but the goal of having a default context set
is just to check if OS is properly receiving/handling such data.

If we use an EL1 context register dump, instead of a fixed default:

1. the values will be pretty much random, and, as you said, not related
   with a real issue - so probably the values will be bogus anyway;
2. there won't be an easy way to identify if the OS is handling it
   the right way, as there won't be any way to associate the value sent
   to BIOS/Kernel with an expected behavior. With a fixed value, one can=20
   check if 0xDEADBEEF is the first thing that happens at the context
   dump;
3. If one wants to simulate a real hardware error, he can instead send a
   proper set of register values;
4. the default to report EL1 context register may not be what it is
   wanted for tests.

> Perhaps that's a job for the future as we will want to be able to overrid=
e it
> anyway.

This can already be overridden:

	$ qemu_einj.py arm --ctx-array 0xffee,0xdeadbeef,0xabbabaa,0x0,0xbeafdeed
		 {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 9}, "pac=
kage": "v9.0.0-2620-g8e5b224ee328-dirty"}, "capabilities": ["oob"]}}
	{ "execute": "qmp_capabilities" }=20
		 {"return": {}}
	{ "execute": "arm-inject-error", "arguments": {"error": [{"type": ["cache-=
error"]}], "context": [{"register": [65518, 3735928559, 180071338, 0, 31991=
96909]}]} }

[   52.044695] {3}[Hardware Error]:     PC is imprecise
[   52.044909] {3}[Hardware Error]:   Context info structure 0:
[   52.045147] {3}[Hardware Error]:    register context type: AArch64 EL1 c=
ontext registers
[   52.045500] {3}[Hardware Error]:    00000000: 0000ffee 00000000 deadbeef=
 00000000
[   52.045866] {3}[Hardware Error]:    00000010: 0abbabaa 00000000 00000000=
 00000000
[   52.046184] {3}[Hardware Error]:    00000020: beafdeed 00000000 00000000=
 00000000

And other types of register dump can also be set, like:

	$ qemu_einj.py arm --ctx-array 0xffee,0xdeadbeef,0xabbabaa,0x0,0xbeafdeed =
--ctx-type 7
		 {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 9}, "pac=
kage": "v9.0.0-2620-g8e5b224ee328-dirty"}, "capabilities": ["oob"]}}
	{ "execute": "qmp_capabilities" }=20
		 {"return": {}}
	{ "execute": "arm-inject-error", "arguments": {"error": [{"type": ["cache-=
error"]}], "context": [{"type": 7, "register": [65518, 3735928559, 18007133=
8, 0, 3199196909]}]} }
		 {"return": {}}

[  172.693339] {4}[Hardware Error]:   Context info structure 0:
[  172.693643] {4}[Hardware Error]:    register context type: AArch64 EL3 c=
ontext registers
[  172.694050] {4}[Hardware Error]:    00000000: 0000ffee 00000000 deadbeef=
 00000000
[  172.694445] {4}[Hardware Error]:    00000010: 0abbabaa 00000000 00000000=
 00000000
[  172.694859] {4}[Hardware Error]:    00000020: beafdeed 00000000 00000000=
 00000000

So, one can replicate any context needed - preferably reproducing a real
real error condition that happened on some hardware.

>=20
> > +#
> > +# @minimal-size:
> > +#       Argument is optional. If provided, define the minimal size of =
the
> > +#       context register array. The actual size is defined by checking=
 the
> > +#       number of register values plus the content of this field (if u=
sed),
> > +#       ensuring that each processor context information structure arr=
ay is
> > +#       padded with zeros if the size is not a multiple of 16 bytes.
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'struct': 'ArmProcessorContext',
> > +  'data': { '*type': 'uint16',
> > +            '*minimal-size': 'uint32',
> > +            '*register': ['uint64']}
> >  }
> > =20
> >  ##
> >  # @arm-inject-error:
> >  #
> > -# Inject ARM Processor error.
> > +# Inject ARM Processor error with data to be filled accordign with UEF=
I 2.10
> > +# CPER table N.16.
> >  #
> > -# @errortypes: ARM processor error types to inject
> > +# @validation:
> > +#       Valid validation bits for ARM processor CPER.
> > +#       Argument is optional. If not specified, the default is
> > +#       calculated based on having the corresponding arguments filled.
> > +#
> > +# @affinity-level:
> > +#       Error affinity level for errors that can be attributed to a sp=
ecific
> > +#       affinity level.
> > +#       Argument is optional. If not specified and @validation not enf=
orced,
> > +#       this field will be marked as invalid at CPER record. =20
> As below.
>=20
> > +#
> > +# @mpidr-el1:
> > +#       Processor=E2=80=99s unique ID in the system.
> > +#       Argument is optional. If not specified, it will use the cpu mp=
idr
> > +#       field from the emulation data. If zero and @validation is not
> > +#       enforced, this field will be marked as invalid at CPER record.=
 =20
> The zero case is obscure enough I'd be tempted to say that if we want
> to test that then we will override the validation field.
>
> The logic will end up simpler and still allow the same level of corner
> case testing for no valid mpidr (which is really odd if it occurs!)

The zero case may happen if the MPIDR CPU field inside the emulation is
not properly by QEMU arm32/64 specific machine.=20

I opted to make it explicit, as this happened to me on some of my
tests. So I ended adding the check and this comment.

> > +#
> > +# @midr-el1:  Identification info of the chip
> > +#       Argument is optional. If not specified, it will use the cpu mp=
idr
> > +#       field from the emulation data. If zero and @validation is not
> > +#       enforced, this field will be marked as invalid at CPER record.=
 =20
>=20
> Same as above.
>=20
> > +#
> > +# @running-state:
> > +#       Indicates the running state of the processor.
> > +#       Argument is optional. If not specified and @validation not enf=
orced,
> > +#       this field will be marked as invalid at CPER record. =20
>=20
> Fun corners of the spec.  Can't allow bit0 of this and psci-state.
> We should perhaps enforce that? I don't think we need to inject completely
> invalid states (just corners of what is valid).

The logic there is already checking it, filling psci-state only if
the bit is not set.

>=20
> > +#
> > +# @psci-state:
> > +#       Provides PSCI state of the processor, as defined in ARM PSCI d=
ocument.
> > +#       Argument is optional. If not specified, it will use the cpu po=
wer
> > +#       state field from the emulation data. =20
> Hmm. Do you think validation is meant to cover this? Is it under running-=
state?

IMO, the right filling of it according with the spec should be enforced,
with this logic:

    if (!has_psci_state) {
        psci_state =3D armcpu->power_state;
    }

    if (has_running_state) {
        while (running_state_list) {
            running_state |=3D BIT(running_state_list->value);
            running_state_list =3D running_state_list;
        }

        if (running_state) {
            psci_state =3D 0;
        }
    }

    error.psci_state =3D psci_state;

    if (has_validation) {
...
    } else {
...
        if (running_state) {
            validation |=3D BIT(ARM_PROCESSOR_VALIDATION_BITS_RUNNING_STATE=
_VALID);
        }
    }

E.g.:

- if running_state is enforced, psci_state will be zero;
- if not enforced:
	- if not defined: use CPU-defined power_state;
	- otherwise, use the value passed via QMP.

I'm changing the code to do the above, as there were some errors at the
check logic.

>=20
> > +#
> > +# @context:
> > +#       Contains an array of processor context registers.
> > +#       Argument is optional. If not specified, no context will be add=
ed.
> > +#
> > +# @vendor-specific:
> > +#       Contains a byte array of vendor-specific data.
> > +#       Argument is optional. If not specified, no vendor-specific data
> > +#       will be added.
> > +#
> > +# @error:
> > +#       Contains an array of ARM processor error information (PEI) sec=
tions.
> > +#       Argument is optional. If not specified, defaults to a single
> > +#       Program Error Information record defaulting to type=3Dcache-er=
ror.
> >  #
> >  # Features:
> >  #
> > @@ -44,6 +262,16 @@
> >  # Since: 9.1
> >  ##
> >  { 'command': 'arm-inject-error',
> > -  'data': { 'errortypes': ['ArmProcessorErrorType'] },
> > +  'data': {
> > +    '*validation': ['ArmProcessorValidationBits'],
> > +    '*affinity-level': 'uint8',
> > +    '*mpidr-el1': 'uint64',
> > +    '*midr-el1': 'uint64',
> > +    '*running-state':  ['ArmProcessorRunningState'],
> > +    '*psci-state': 'uint32',
> > +    '*context': ['ArmProcessorContext'],
> > +    '*vendor-specific': ['uint8'],
> > +    '*error': ['ArmProcessorErrorInformation']
> > +  },
> >    'features': [ 'unstable' ]
> >  } =20

Thanks,
Mauro

