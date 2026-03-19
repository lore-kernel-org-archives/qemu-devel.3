Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9ADB1088E60
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3CXz-0007mG-MY; Thu, 19 Mar 2026 08:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CXs-0007lP-Ps
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CXo-0001cq-0E
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773923526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TYQ2FQAM6tPwzmdYBYO5OvpxbkldqcSyN78Fvt4tmec=;
 b=X6z83UW5f9rq9ySK7W7xDpCAIgPHABdgf7O8LxjDopHi3ZgY7qk7CaOqagx/q0/yH1yts4
 H2L0Si9C6wJKPp0yCzlV1wQQhBsxjNeBmHMLMvK2Uhnuqum9ANfhfM+Cs0X/mFvzQF0fM9
 rEBeCmJEVx+SHOgh+Uijoo0iNUabG4c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-APVG3Or-MRGpIhLpgHqDtA-1; Thu,
 19 Mar 2026 08:32:05 -0400
X-MC-Unique: APVG3Or-MRGpIhLpgHqDtA-1
X-Mimecast-MFC-AGG-ID: APVG3Or-MRGpIhLpgHqDtA_1773923523
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39A44195609D; Thu, 19 Mar 2026 12:32:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A4791800361; Thu, 19 Mar 2026 12:32:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE99721E6937; Thu, 19 Mar 2026 13:31:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tommaso Califano <califano.tommaso@gmail.com>
Cc: qemu-devel@nongnu.org,  kvm@vger.kernel.org,  Eduardo Habkost
 <eduardo@habkost.net>,  Zhao Liu <zhao1.liu@intel.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,  Giuseppe Lettieri
 <giuseppe.lettieri@unipi.it>,  Paolo Bonzini <pbonzini@redhat.com>,  Luigi
 Leonardi <leonardi@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
In-Reply-To: <20260317113840.33017-2-califano.tommaso@gmail.com> (Tommaso
 Califano's message of "Tue, 17 Mar 2026 12:38:36 +0100")
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
Date: Thu, 19 Mar 2026 13:31:59 +0100
Message-ID: <87tsucvw3k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tommaso Califano <califano.tommaso@gmail.com> writes:

> QEMU's AMD SEV support requires KVM on costly AMD EPYC processors,
> limiting development and testing to users with specialized server
> hardware. This makes it hard to validate SEV guest behavior, like
> OVMF boots or SEV-aware software, on common dev machines.
> A solution to this is the emulation of SEV from the guest's
> perspective using TCG.
>
> This change begins this process with the exposure of the SEV CPUID leaf.
> In target/i386/cpu.c:cpu_x86_cpuid() case 0x8000001F:
>
> case 0x8000001F:
>     *eax = *ebx = *ecx = *edx = 0;
>     if (sev_enabled()) {
>         *eax = 0x2;
>         *eax |= sev_es_enabled() ? 0x8 : 0;
>         *eax |= sev_snp_enabled() ? 0x10 : 0;
>         *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
>         *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
>     }
>     break;
>
> sev_enabled() verifies if the QOM object is TYPE_SEV_GUEST;
> TYPE_SEV_EMULATED is derived from TYPE_SEV_GUEST with SevEmulatedState
> to satisfy this check with minimal changes. In particular this allows
> to bypass all the sev_enabled() checks for future features.
>
> Since KVM hardware isn't available, override the QOM's kvm_init() and add
> a conditional confidential_guest_kvm_init() call during machine_init() to
> set up emulated confidential support using the ConfidentialGuestSupport
> structure.
>
> With this change it is possible to run a VM with the SEV CPUID active
> adding:
>
>     -accel tcg \
>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>     -machine memory-encryption=sev0
>
> To the QEMU start arguments.
>
> Signed-off-by: Tommaso Califano <califano.tommaso@gmail.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index c653248f85..35cda819ec 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1057,6 +1057,19 @@
>              '*handle': 'uint32',
>              '*legacy-vm-type': 'OnOffAuto' } }
>  
> +##
> +# @SevEmulatedProperties:
> +#
> +# Properties for sev-emulated objects.
> +# This object functionally emulates AMD SEV hardware via TCG, so
> +# it does not require real hardware to run.

Wrap the paragraph, please:

   # Properties for sev-emulated objects.  This object functionally
   # emulates AMD SEV hardware via TCG, so it does not require real
   # hardware to run.

> +#
> +# Since: 10.1.0

11.0 right now, but realistically 11.1.

> +##
> +{ 'struct': 'SevEmulatedProperties',
> +  'base': 'SevGuestProperties',
> +  'data': {}}
> +
>  ##
>  # @SevSnpGuestProperties:
>  #
> @@ -1241,6 +1254,7 @@
>      { 'name': 'secret_keyring',
>        'if': 'CONFIG_SECRET_KEYRING' },
>      'sev-guest',
> +    'sev-emulated',
>      'sev-snp-guest',
>      'thread-context',
>      's390-pv-guest',

Please insert before sev-guest to keep things more or less sorted.

> @@ -1318,6 +1332,7 @@
>        'secret_keyring':             { 'type': 'SecretKeyringProperties',
>                                        'if': 'CONFIG_SECRET_KEYRING' },
>        'sev-guest':                  'SevGuestProperties',
> +      'sev-emulated':               'SevEmulatedProperties',

Likewise.

>        'sev-snp-guest':              'SevSnpGuestProperties',
>        'tdx-guest':                  'TdxGuestProperties',
>        'thread-context':             'ThreadContextProperties',


