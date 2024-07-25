Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDBDC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvKj-00054Y-C6; Thu, 25 Jul 2024 06:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWvKh-0004yZ-3c
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWvKd-0004qg-4C
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721901836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKggOuMzjkGZbvdSJoNF8Z4O9COB+FBjLMBo6UrDOV8=;
 b=FW3BmuzHrpB6tfF05kM4+TSKsdXeEYfp+a3JBPqiB5JIR+dIv/aUou1XeLBesmLov7ruKB
 wVzoNfG90984X/8AKIY6kn0S/hmojfqtWLDX3MSJiLvhaadHoQwGN/1tcI6n/RwU9PUyNz
 W5NmBUvMH+1jnVtBfNgcmyL5XkACebo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-mbOY8YfjN92hA4HC5AzWaQ-1; Thu,
 25 Jul 2024 06:03:52 -0400
X-MC-Unique: mbOY8YfjN92hA4HC5AzWaQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ADA41955D47; Thu, 25 Jul 2024 10:03:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 244811955E7D; Thu, 25 Jul 2024 10:03:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D272D21E668A; Thu, 25 Jul 2024 12:03:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Shiju Jose
 <shiju.jose@huawei.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,  Beraldo Leal <bleal@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>,  Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3 7/7] acpi/ghes: extend arm error injection logic
In-Reply-To: <89e8a63b5e54409dd9bc4e7f4f4c12290838371b.1721630625.git.mchehab+huawei@kernel.org>
 (Mauro Carvalho Chehab's message of "Mon, 22 Jul 2024 08:45:59 +0200")
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <89e8a63b5e54409dd9bc4e7f4f4c12290838371b.1721630625.git.mchehab+huawei@kernel.org>
Date: Thu, 25 Jul 2024 12:03:46 +0200
Message-ID: <87y15ppz3x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Enrich CPER error injection logic for ARM processor to allow
> setting values to  from UEFI 2.10 tables N.16 and N.17.
>
> It should be noticed that, with such change, all arguments are
> now optional, so, once QMP is negotiated with:
>
> 	{ "execute": "qmp_capabilities" }
>
> the simplest way to generate a cache error is to use:
>
> 	{ "execute": "arm-inject-error" }
>
> Also, as now PEI is mapped into an array, it is possible to
> inject multiple errors at the same CPER record with:
>
> 	{ "execute": "arm-inject-error", "arguments": {
> 	   "error": [ {"type": [ "cache-error" ]},
> 		      {"type": [ "tlb-error" ]} ] } }
>
> This would generate both cache and TLB errors, using default
> values for other fields.
>
> As all fields from ARM Processor CPER are now mapped, all
> types of CPER records can be generated with the new QAPI.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[...]

> diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
> index 430e6cea6b60..2a314830fe60 100644
> --- a/qapi/arm-error-inject.json
> +++ b/qapi/arm-error-inject.json
> @@ -2,40 +2,258 @@
>  # vim: filetype=3Dpython
>=20=20
>  ##
> -# =3D ARM Processor Errors
> +# =3D ARM Processor Errors as defined at:
> +# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.ht=
ml
> +# See tables N.16, N.17 and N.21.
>  ##

This comes out badly in HTML.

Try something like

   # =3D ARM Processor Errors
   #
   # These are defined at
   # https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.ht=
ml
   # See tables N.16, N.17 and N.21.

If any part of this is relevant in PATCH 4 already, squash the relevant
parts into that patch please.

>=20=20
> +##
> +# @ArmProcessorValidationBits:
> +#
> +# Indcates whether or not fields of ARM processor CPER record are valid.

docs/devel/qapi-code-gen.rst section "Documentation markup":

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

> +#
> +# @mpidr-valid:  MPIDR Valid
> +#
> +# @affinity-valid: Error affinity level Valid
> +#
> +# @running-state-valid: Running State
> +#
> +# @vendor-specific-valid: Vendor Specific Info Valid
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'ArmProcessorValidationBits',
> +  'data': ['mpidr-valid',
> +           'affinity-valid',
> +           'running-state-valid',
> +           'vendor-specific-valid']
> +}
> +
> +##
> +# @ArmProcessorFlags:
> +#
> +# Indicates error attributes at the Error info section.
> +#
> +# @first-error-cap: First error captured
> +#
> +# @last-error-cap:  Last error captured
> +#
> +# @propagated: Propagated
> +#
> +# @overflow: Overflow
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'ArmProcessorFlags',
> +  'data': ['first-error-cap',
> +           'last-error-cap',
> +           'propagated',
> +           'overflow']
> +}
> +
> +##
> +# @ArmProcessorRunningState:
> +#
> +# Indicates if the processor is running.
> +#
> +# @processor-running: indicates that the processor is running
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'ArmProcessorRunningState',
> +  'data': ['processor-running']
> +}
> +
>  ##
>  # @ArmProcessorErrorType:
>  #
> -# Type of ARM processor error to inject
> -#
> -# @unknown-error: Unknown error
> +# Type of ARM processor error information to inject.
>  #
>  # @cache-error: Cache error
>  #
>  # @tlb-error: TLB error
>  #
> -# @bus-error: Bus error.
> +# @bus-error: Bus error
>  #
> -# @micro-arch-error: Micro architectural error.
> +# @micro-arch-error: Micro architectural error
>  #
>  # Since: 9.1
>  ##
>  { 'enum': 'ArmProcessorErrorType',
> -  'data': ['unknown-error',
> -	   'cache-error',
> +  'data': ['cache-error',
>             'tlb-error',
>             'bus-error',
>             'micro-arch-error']
> + }

Squash the changes to this type into PATCH 4, please.

> +
> +##
> +# @ArmPeiValidationBits:
> +#
> +# Indcates whether or not fields of Processor Error Info section are val=
id.
> +#
> +# @multiple-error-valid: Information at multiple-error field is valid
> +#
> +# @flags-valid: Information at flags field is valid
> +#
> +# @error-info-valid: Information at error-info field is valid
> +#
> +# @virt-addr-valid: Information at virt-addr field is valid
> +#
> +# @phy-addr-valid: Information at phy-addr field is valid
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'ArmPeiValidationBits',
> +  'data': ['multiple-error-valid',
> +           'flags-valid',
> +           'error-info-valid',
> +           'virt-addr-valid',
> +           'phy-addr-valid']
> +}
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

Please format like this for consistency:

   # @validation: Valid validation bits for error-info section.
   #     Argument is optional.  If not specified, those flags will be
   #     enabled: first-error-cap and propagated.

> +#
> +# @type:
> +#       ARM processor error types to inject. Argument is mandatory.
> +#
> +# @multiple-error:
> +#       Indicates whether multiple errors have occurred.
> +#       Argument is optional. If not specified and @validation not enfor=
ced,
> +#       this field will be marked as invalid at CPER record..
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
>=20=20
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
> +#
> +# @mpidr-el1:
> +#       Processor=E2=80=99s unique ID in the system.
> +#       Argument is optional. If not specified, it will use the cpu mpidr
> +#       field from the emulation data. If zero and @validation is not
> +#       enforced, this field will be marked as invalid at CPER record.
> +#
> +# @midr-el1:  Identification info of the chip
> +#       Argument is optional. If not specified, it will use the cpu mpidr
> +#       field from the emulation data. If zero and @validation is not
> +#       enforced, this field will be marked as invalid at CPER record.
> +#
> +# @running-state:
> +#       Indicates the running state of the processor.
> +#       Argument is optional. If not specified and @validation not enfor=
ced,
> +#       this field will be marked as invalid at CPER record.
> +#
> +# @psci-state:
> +#       Provides PSCI state of the processor, as defined in ARM PSCI doc=
ument.
> +#       Argument is optional. If not specified, it will use the cpu power
> +#       state field from the emulation data.
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

This changes the command pretty much completely.  Why is the previous
state worth capturing in git?

> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> index 0e9490cebc72..77c800186f34 160000
> --- a/tests/lcitool/libvirt-ci
> +++ b/tests/lcitool/libvirt-ci
> @@ -1 +1 @@
> -Subproject commit 0e9490cebc726ef772b6c9e27dac32e7ae99f9b2
> +Subproject commit 77c800186f34b21be7660750577cc5582a914deb

Accident?


