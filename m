Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD8CC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 13:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXKu4-0007go-T4; Fri, 26 Jul 2024 09:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXKu3-0007dl-0B; Fri, 26 Jul 2024 09:22:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXKtz-0008CO-7r; Fri, 26 Jul 2024 09:22:34 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVpKR2Tprz6K5nk;
 Fri, 26 Jul 2024 21:20:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 699F5140A46;
 Fri, 26 Jul 2024 21:22:27 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 14:22:26 +0100
Date: Fri, 26 Jul 2024 14:22:25 +0100
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Beraldo Leal <bleal@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 7/7] acpi/ghes: extend arm error injection logic
Message-ID: <20240726142225.00000bdd@Huawei.com>
In-Reply-To: <89e8a63b5e54409dd9bc4e7f4f4c12290838371b.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <89e8a63b5e54409dd9bc4e7f4f4c12290838371b.1721630625.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 22 Jul 2024 08:45:59 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Enrich CPER error injection logic for ARM processor to allow
> setting values to  from UEFI 2.10 tables N.16 and N.17.
>=20
> It should be noticed that, with such change, all arguments are
> now optional, so, once QMP is negotiated with:
>=20
> 	{ "execute": "qmp_capabilities" }
>=20
> the simplest way to generate a cache error is to use:
>=20
> 	{ "execute": "arm-inject-error" }
>=20
> Also, as now PEI is mapped into an array, it is possible to
> inject multiple errors at the same CPER record with:
>=20
> 	{ "execute": "arm-inject-error", "arguments": {
> 	   "error": [ {"type": [ "cache-error" ]},
> 		      {"type": [ "tlb-error" ]} ] } }
>=20
> This would generate both cache and TLB errors, using default
> values for other fields.
>=20
> As all fields from ARM Processor CPER are now mapped, all
> types of CPER records can be generated with the new QAPI.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
If you are happy to smash this into patch 4 then also take ownership
of the result and change the author as I wrote almost none of the code
that ended up in the result as only the GHESv2 stuff was mind
even before you joined this effort - the rest was Shiju's

If you want, I'm fine with a co-developed on the result

Jonathan



> ---
>  hw/acpi/ghes.c                  | 168 +++++++-------
>  hw/arm/arm_error_inject.c       | 399 +++++++++++++++++++++++++++++++-
>  hw/arm/arm_error_inject_stubs.c |  20 +-
>  include/hw/acpi/ghes.h          |  40 +++-
>  qapi/arm-error-inject.json      | 250 +++++++++++++++++++-
>  tests/lcitool/libvirt-ci        |   2 +-
>  6 files changed, 778 insertions(+), 101 deletions(-)
>=20
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index ebf1b812aaaa..afd1d098a7e3 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c

> +    build_append_int_noprefix(table, err.running_state, 4);
> +
> +    /* PSCI state: only valid when running state is zero  */
> +    build_append_int_noprefix(table, err.psci_state, 4);
> +
> +    for (i =3D 0; i < err.err_info_num; i++) {
> +        /* ARM Propcessor error information */
> +        /* Version */
> +        build_append_int_noprefix(table, 0, 1);
> +
> +        /*  Length */
> +        build_append_int_noprefix(table, ACPI_GHES_ARM_CPER_PEI_LENGTH, =
1);
> +
> +        /* Validation Bits */
> +        build_append_int_noprefix(table, err.pei[i].validation, 2);

Maybe drop some comments when the data being written makes it obvious?

> +
> +        /* Type */
> +        build_append_int_noprefix(table, err.pei[i].type, 1);
> +
> +        /* Multiple error count */
> +        build_append_int_noprefix(table, err.pei[i].multiple_error, 2);
> +
> +        /* Flags  */
> +        build_append_int_noprefix(table, err.pei[i].flags, 1);
> +
> +        /* Error information  */
> +        build_append_int_noprefix(table, err.pei[i].error_info, 8);
> +
> +        /* Virtual fault address  */
> +        build_append_int_noprefix(table, err.pei[i].virt_addr, 8);
> +
> +        /* Physical fault address  */
> +        build_append_int_noprefix(table, err.pei[i].phy_addr, 8);
> +    }
> +
> +    for (i =3D 0; i < err.context_info_num; i++) {
> +        /* ARM Propcessor error context information */
> +        /* Version */
> +        build_append_int_noprefix(table, 0, 2);
> +
> +        /* Validation type */
> +        build_append_int_noprefix(table, err.context[i].type, 2);
> +
> +        /* Register array size */
> +        build_append_int_noprefix(table, err.context[i].size * 8, 4);
> +
> +        /* Register array (byte 8 of Context info) */
> +        for (j =3D 0; j < err.context[i].size; j++) {
> +            build_append_int_noprefix(table, err.context[i].array[j], 8);
> +        }
>      }

> diff --git a/hw/arm/arm_error_inject.c b/hw/arm/arm_error_inject.c
> index 1da97d5d4fdc..67f1c77546b9 100644
> --- a/hw/arm/arm_error_inject.c
> +++ b/hw/arm/arm_error_inject.c
> @@ -10,23 +10,408 @@

> +
> +/* Handle ARM Context */
> +static ArmContext *qmp_arm_context(uint16_t *context_info_num,
> +                                   uint32_t *context_length,
> +                                   bool has_context,
> +                                   ArmProcessorContextList const *contex=
t_list)
> +{
> +    ArmProcessorContextList const *next;
> +    ArmContext *context =3D NULL;
> +    uint16_t i, j, num, default_type;
> +
> +    default_type =3D get_default_context_type();
> +
> +    if (!has_context) {
> +        *context_info_num =3D 0;
> +        *context_length =3D 0;
> +
> +        return NULL;
> +    }
> +
> +    /* Calculate sizes */
> +    num =3D 0;
> +    for (next =3D context_list; next; next =3D next->next) {
> +        uint32_t n_regs =3D 0;
> +
> +        if (next->value->has_q_register) {
> +            uint64List *reg =3D next->value->q_register;
> +
> +            while (reg) {
> +                n_regs++;
> +                reg =3D reg->next;
> +            }
> +
> +            if (next->value->has_minimal_size &&
> +                                        next->value->minimal_size < n_re=
gs) {
I'd align just after (

> +
> +static uint8_t *qmp_arm_vendor(uint32_t *vendor_num, bool has_vendor_spe=
cific,
> +                               uint8List const *vendor_specific_list)
> +{
> +    uint8List const *next =3D vendor_specific_list;
> +    uint8_t *vendor =3D NULL, *p;

vendor always set before use.

> +
> +    if (!has_vendor_specific) {
> +        return NULL;
> +    }
> +
> +    *vendor_num =3D 0;
> +
> +    while (next) {
> +        next =3D next->next;
> +        (*vendor_num)++;
> +    }
> +
> +    vendor =3D g_malloc(*vendor_num);
> +
> +    p =3D vendor;
> +    next =3D vendor_specific_list;
> +    while (next) {
> +        *p =3D next->value;
> +        next =3D next->next;
> +        p++;
> +    }
> +
> +    return vendor;
> +}
> diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
> index 430e6cea6b60..2a314830fe60 100644
> --- a/qapi/arm-error-inject.json
> +++ b/qapi/arm-error-inject.json

> +
> +##
> +# @ArmProcessorErrorInformation:
> +#
> +# Contains ARM processor error information (PEI) data according with UEFI
> +# CPER table N.17.
> +#
> +# @validation:
> +#       Valid validation bits for error-info section.
> +#       Argument is optional. If not specified, those flags will be enab=
led:
> +#       first-error-cap and propagated.
> +#
> +# @type:
> +#       ARM processor error types to inject. Argument is mandatory.
> +#
> +# @multiple-error:
> +#       Indicates whether multiple errors have occurred.
> +#       Argument is optional. If not specified and @validation not enfor=
ced,

forced probably rather than enforced.

> +#       this field will be marked as invalid at CPER record..
. only

Good to mention the odd encoding of 0 =3D single error, 1 =3D multiple (los=
t count)
2+ =3D actual count of errors

> +#
> +# @flags:
> +#       Indicates flags that describe the error attributes.
> +#       Argument is optional. If not specified and defaults to
> +#       first-error and propagated.
> +#
> +# @error-info:
> +#       Error information structure is specific to each error type.
> +#       Argument is optional, and its value depends on the PEI type(s).
> +#       If not defined, the default depends on the type:
> +#       - for cache-error: 0x0091000F;
> +#       - for tlb-error: 0x0054007F;
> +#       - for bus-error: 0x80D6460FFF;
> +#       - for micro-arch-error: 0x78DA03FF;
> +#       - if multiple types used, this bit is disabled from @validation =
bits.
> +#
> +# @virt-addr:
> +#       Virtual fault address associated with the error.
> +#       Argument is optional. If not specified and @validation not enfor=
ced,
> +#       this field will be marked as invalid at CPER record..
> +#
> +# @phy-addr:
> +#       Physical fault address associated with the error.
> +#       Argument is optional. If not specified and @validation not enfor=
ced,
> +#       this field will be marked as invalid at CPER record..
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'ArmProcessorErrorInformation',
> +  'data': { '*validation': ['ArmPeiValidationBits'],
> +            'type': ['ArmProcessorErrorType'],
> +            '*multiple-error': 'uint16',
> +            '*flags': ['ArmProcessorFlags'],
> +            '*error-info': 'uint64',
> +            '*virt-addr':  'uint64',
> +            '*phy-addr': 'uint64'}
> +}
> +
> +##
> +# @ArmProcessorContext:
> +#
> +# Provide processor context state specific to the ARM processor architec=
ture,
> +# According with UEFI 2.10 CPER table N.21.
> +# Argument is optional.If not specified, no context will be used.
                          ^ space
> +#
> +# @type:
> +#       Contains an integer value indicating the type of context state b=
eing
> +#       reported.
> +#       Argument is optional. If not defined, it will be set to be EL1 r=
egister
> +#       for the emulation, e. g.:
> +#       - on arm32: AArch32 EL1 context registers;
> +#       - on arm64: AArch64 EL1 context registers.
> +#
> +# @register:
> +#       Provides the contents of the actual registers or raw data, depen=
ding
> +#       on the context type.
> +#       Argument is optional. If not defined, it will fill the first reg=
ister
> +#       with 0xDEADBEEF, and the other ones with zero.
We could fill this in with a valid snap shot I think?  It' just a set of CP=
U registers.
Obviously content would be pretty random and meaningless given the
error isn't correlated with particular activity (as we triggered it) but ma=
ybe would
useful for testing the parsing?

Perhaps that's a job for the future as we will want to be able to override =
it
anyway.

> +#
> +# @minimal-size:
> +#       Argument is optional. If provided, define the minimal size of the
> +#       context register array. The actual size is defined by checking t=
he
> +#       number of register values plus the content of this field (if use=
d),
> +#       ensuring that each processor context information structure array=
 is
> +#       padded with zeros if the size is not a multiple of 16 bytes.
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'ArmProcessorContext',
> +  'data': { '*type': 'uint16',
> +            '*minimal-size': 'uint32',
> +            '*register': ['uint64']}
>  }
> =20
>  ##
>  # @arm-inject-error:
>  #
> -# Inject ARM Processor error.
> +# Inject ARM Processor error with data to be filled accordign with UEFI =
2.10
> +# CPER table N.16.
>  #
> -# @errortypes: ARM processor error types to inject
> +# @validation:
> +#       Valid validation bits for ARM processor CPER.
> +#       Argument is optional. If not specified, the default is
> +#       calculated based on having the corresponding arguments filled.
> +#
> +# @affinity-level:
> +#       Error affinity level for errors that can be attributed to a spec=
ific
> +#       affinity level.
> +#       Argument is optional. If not specified and @validation not enfor=
ced,
> +#       this field will be marked as invalid at CPER record.
As below.

> +#
> +# @mpidr-el1:
> +#       Processor=E2=80=99s unique ID in the system.
> +#       Argument is optional. If not specified, it will use the cpu mpidr
> +#       field from the emulation data. If zero and @validation is not
> +#       enforced, this field will be marked as invalid at CPER record.
The zero case is obscure enough I'd be tempted to say that if we want
to test that then we will override the validation field.

The logic will end up simpler and still allow the same level of corner
case testing for no valid mpidr (which is really odd if it occurs!)

> +#
> +# @midr-el1:  Identification info of the chip
> +#       Argument is optional. If not specified, it will use the cpu mpidr
> +#       field from the emulation data. If zero and @validation is not
> +#       enforced, this field will be marked as invalid at CPER record.

Same as above.

> +#
> +# @running-state:
> +#       Indicates the running state of the processor.
> +#       Argument is optional. If not specified and @validation not enfor=
ced,
> +#       this field will be marked as invalid at CPER record.

Fun corners of the spec.  Can't allow bit0 of this and psci-state.
We should perhaps enforce that? I don't think we need to inject completely
invalid states (just corners of what is valid).

> +#
> +# @psci-state:
> +#       Provides PSCI state of the processor, as defined in ARM PSCI doc=
ument.
> +#       Argument is optional. If not specified, it will use the cpu power
> +#       state field from the emulation data.
Hmm. Do you think validation is meant to cover this? Is it under running-st=
ate?

> +#
> +# @context:
> +#       Contains an array of processor context registers.
> +#       Argument is optional. If not specified, no context will be added.
> +#
> +# @vendor-specific:
> +#       Contains a byte array of vendor-specific data.
> +#       Argument is optional. If not specified, no vendor-specific data
> +#       will be added.
> +#
> +# @error:
> +#       Contains an array of ARM processor error information (PEI) secti=
ons.
> +#       Argument is optional. If not specified, defaults to a single
> +#       Program Error Information record defaulting to type=3Dcache-erro=
r.
>  #
>  # Features:
>  #
> @@ -44,6 +262,16 @@
>  # Since: 9.1
>  ##
>  { 'command': 'arm-inject-error',
> -  'data': { 'errortypes': ['ArmProcessorErrorType'] },
> +  'data': {
> +    '*validation': ['ArmProcessorValidationBits'],
> +    '*affinity-level': 'uint8',
> +    '*mpidr-el1': 'uint64',
> +    '*midr-el1': 'uint64',
> +    '*running-state':  ['ArmProcessorRunningState'],
> +    '*psci-state': 'uint32',
> +    '*context': ['ArmProcessorContext'],
> +    '*vendor-specific': ['uint8'],
> +    '*error': ['ArmProcessorErrorInformation']
> +  },
>    'features': [ 'unstable' ]
>  }

