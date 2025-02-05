Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C255C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 10:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfcJX-00042S-HR; Wed, 05 Feb 2025 05:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfcJW-00041u-3U
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:07:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfcJU-0007BX-Jx
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738750039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1zDoZmkitSBKZ8WS2tPZOpQfMN+YQSBeT3+5PJja8Yo=;
 b=aoGUj8suwHoVBf57s0rodpHRZgNTkt5PGHw3t17ChJSl8h9bWbLUPyzyk9CKiJ5z6FLSKN
 V+/Q+2TQ0WkY3EA0szyrjPYNaQ2MorSU8Wii1K1JGj8g2LECiw7phOAToXarl7mL0tKhO7
 38487yCEGK2KeYxmxh2uK6cqGxc2xSk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-_xxC_nefP8Gptcel8UouCw-1; Wed,
 05 Feb 2025 05:07:15 -0500
X-MC-Unique: _xxC_nefP8Gptcel8UouCw-1
X-Mimecast-MFC-AGG-ID: _xxC_nefP8Gptcel8UouCw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BE0819560B6; Wed,  5 Feb 2025 10:07:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABD7019560A3; Wed,  5 Feb 2025 10:07:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 64CC221E6A28; Wed, 05 Feb 2025 11:07:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Shaoqin Huang <shahuang@redhat.com>,  Eric
 Auger <eauger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>,  Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
In-Reply-To: <20250122090517.294083-4-zhao1.liu@intel.com> (Zhao Liu's message
 of "Wed, 22 Jan 2025 17:05:15 +0800")
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-4-zhao1.liu@intel.com>
Date: Wed, 05 Feb 2025 11:07:10 +0100
Message-ID: <87zfj01z8x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Zhao Liu <zhao1.liu@intel.com> writes:

> The select&umask is the common way for x86 to identify the PMU event,
> so support this way as the "x86-default" format in kvm-pmu-filter
> object.

So, format 'raw' lets you specify the PMU event code as a number, wheras
'x86-default' lets you specify it as select and umask, correct?

Why do we want both?

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

[...]

> diff --git a/qapi/kvm.json b/qapi/kvm.json
> index d51aeeba7cd8..93b869e3f90c 100644
> --- a/qapi/kvm.json
> +++ b/qapi/kvm.json
> @@ -27,11 +27,13 @@
>  #
>  # @raw: the encoded event code that KVM can directly consume.
>  #
> +# @x86-default: standard x86 encoding format with select and umask.

Why is this named -default?

> +#
>  # Since 10.0
>  ##
>  { 'enum': 'KVMPMUEventEncodeFmt',
>    'prefix': 'KVM_PMU_EVENT_FMT',
> -  'data': ['raw'] }
> +  'data': ['raw', 'x86-default'] }
>  
>  ##
>  # @KVMPMURawEvent:
> @@ -46,6 +48,25 @@
>  { 'struct': 'KVMPMURawEvent',
>    'data': { 'code': 'uint64' } }
>  
> +##
> +# @KVMPMUX86DefalutEvent:

Default, I suppose.

> +#
> +# x86 PMU event encoding with select and umask.
> +# raw_event = ((select & 0xf00UL) << 24) | \
> +#              (select) & 0xff) | \
> +#              ((umask) & 0xff) << 8)

Sphinx rejects this with "Unexpected indentation."

Is the formula needed here?

> +#
> +# @select: x86 PMU event select field, which is a 12-bit unsigned
> +#     number.
> +#
> +# @umask: x86 PMU event umask field.
> +#
> +# Since 10.0
> +##
> +{ 'struct': 'KVMPMUX86DefalutEvent',
> +  'data': { 'select': 'uint16',
> +            'umask': 'uint8' } }
> +
>  ##
>  # @KVMPMUFilterEvent:
>  #
> @@ -58,7 +79,8 @@
>  { 'union': 'KVMPMUFilterEvent',
>    'base': { 'format': 'KVMPMUEventEncodeFmt' },
>    'discriminator': 'format',
> -  'data': { 'raw': 'KVMPMURawEvent' } }
> +  'data': { 'raw': 'KVMPMURawEvent',
> +            'x86-default': 'KVMPMUX86DefalutEvent' } }
>  
>  ##
>  # @KVMPMUFilterProperty:
> @@ -86,6 +108,23 @@
>  { 'struct': 'KVMPMURawEventVariant',
>    'data': { 'code': 'str' } }
>  
> +##
> +# @KVMPMUX86DefalutEventVariant:
> +#
> +# The variant of KVMPMUX86DefalutEvent with the string, rather than
> +# the numeric value.
> +#
> +# @select: x86 PMU event select field.  This field is a 12-bit
> +#     unsigned number string.
> +#
> +# @umask: x86 PMU event umask field. This field is a uint8 string.

Why are these strings?  How are they parsed into numbers?

> +#
> +# Since 10.0
> +##
> +{ 'struct': 'KVMPMUX86DefalutEventVariant',
> +  'data': { 'select': 'str',
> +            'umask': 'str' } }
> +
>  ##
>  # @KVMPMUFilterEventVariant:
>  #
> @@ -98,7 +137,8 @@
>  { 'union': 'KVMPMUFilterEventVariant',
>    'base': { 'format': 'KVMPMUEventEncodeFmt' },
>    'discriminator': 'format',
> -  'data': { 'raw': 'KVMPMURawEventVariant' } }
> +  'data': { 'raw': 'KVMPMURawEventVariant',
> +            'x86-default': 'KVMPMUX86DefalutEventVariant' } }
>  
>  ##
>  # @KVMPMUFilterPropertyVariant:

[...]


