Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0B7C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 09:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWv5I-0001FO-Td; Thu, 25 Jul 2024 05:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWv5H-0001C4-VR
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 05:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWv5F-0007SB-5P
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 05:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721900904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a1bce9JEpfXvcwePXavoFZ3558ZqzOQZ/t6vPIqba6Y=;
 b=B7kAFTZ8TSY3qHwvX5ot81FGv04GoIMwbP37145RNJLht66GsZenXP/6RXkaCme4EBuEmI
 uEUFowBo3rPo6V9XSkeDKObrqzX6PjM7dlXKRs1auyD8+UEEythKcKMQtdNnNTENyAsRpK
 cO8yySFMkt8yOChtEHb6oN71isA7SgM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-NUWNpbPPMmOT3hMEjMP8eg-1; Thu,
 25 Jul 2024 05:48:20 -0400
X-MC-Unique: NUWNpbPPMmOT3hMEjMP8eg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8EA91955D4A; Thu, 25 Jul 2024 09:48:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1577019560AE; Thu, 25 Jul 2024 09:48:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E0EB521E6682; Thu, 25 Jul 2024 11:48:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Shiju Jose
 <shiju.jose@huawei.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Ani
 Sinha <anisinha@redhat.com>,  Dongjiu Geng <gengdongjiu1@gmail.com>,  Eric
 Blake <eblake@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
In-Reply-To: <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
 (Mauro Carvalho Chehab's message of "Mon, 22 Jul 2024 08:45:56 +0200")
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
Date: Thu, 25 Jul 2024 11:48:12 +0200
Message-ID: <87bk2lreeb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> 1. Some GHES functions require handling addresses. Add a helper function
>    to support it.
>
> 2. Add support for ACPI CPER (firmware-first) ARM processor error injection.
>
> Compliance with N.2.4.4 ARM Processor Error Section in UEFI 2.6 and
> upper specs, using error type bit encoding as detailed at UEFI 2.9A
> errata.
>
> Error injection examples:
>
> { "execute": "qmp_capabilities" }
>
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error']
>       }
> }
>
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['tlb-error']
>       }
> }
>
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['bus-error']
>       }
> }
>
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error', 'tlb-error']
>       }
> }
>
> { "execute": "arm-inject-error",
>       "arguments": {
>         "errortypes": ['cache-error', 'tlb-error', 'bus-error', 'micro-arch-error']
>       }
> }
> ...
>
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> For Add a logic to handle block addresses,
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> For FW first ARM processor error injection,
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  configs/targets/aarch64-softmmu.mak |   1 +
>  hw/acpi/ghes.c                      | 258 ++++++++++++++++++++++++++--
>  hw/arm/Kconfig                      |   4 +
>  hw/arm/arm_error_inject.c           |  35 ++++
>  hw/arm/arm_error_inject_stubs.c     |  18 ++
>  hw/arm/meson.build                  |   3 +
>  include/hw/acpi/ghes.h              |   2 +
>  qapi/arm-error-inject.json          |  49 ++++++
>  qapi/meson.build                    |   1 +
>  qapi/qapi-schema.json               |   1 +
>  10 files changed, 361 insertions(+), 11 deletions(-)
>  create mode 100644 hw/arm/arm_error_inject.c
>  create mode 100644 hw/arm/arm_error_inject_stubs.c
>  create mode 100644 qapi/arm-error-inject.json

Since the new file not covered in MAINTAINERS, get_maintainer.pl will
blame it on the QAPI maintainers alone.  No good.

[...]

> diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
> new file mode 100644
> index 000000000000..430e6cea6b60
> --- /dev/null
> +++ b/qapi/arm-error-inject.json
> @@ -0,0 +1,49 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +
> +##
> +# = ARM Processor Errors
> +##
> +
> +##
> +# @ArmProcessorErrorType:
> +#
> +# Type of ARM processor error to inject
> +#
> +# @unknown-error: Unknown error

Removed in PATCH 7, and unused until then.  Why add it in the first
place?

> +#
> +# @cache-error: Cache error
> +#
> +# @tlb-error: TLB error
> +#
> +# @bus-error: Bus error.
> +#
> +# @micro-arch-error: Micro architectural error.
> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'ArmProcessorErrorType',
> +  'data': ['unknown-error',
> +	   'cache-error',

Tab in this line.  Please convert to spaces.

> +           'tlb-error',
> +           'bus-error',
> +           'micro-arch-error']
> +}
> +
> +##
> +# @arm-inject-error:
> +#
> +# Inject ARM Processor error.
> +#
> +# @errortypes: ARM processor error types to inject
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since: 9.1
> +##
> +{ 'command': 'arm-inject-error',
> +  'data': { 'errortypes': ['ArmProcessorErrorType'] },

Please separate words with dashes: 'error-types'.

> +  'features': [ 'unstable' ]
> +}

Is this used only with TARGET_ARM?

Why is being able to inject multiple error types at once useful?

I'd expect at least some of these errors to come with additional
information.  For instance, I imagine a bus error is associated with
some address.

If we encode the the error to inject as an enum value, adding more will
be hard.

If we wrap the enum in a struct

    { 'struct': 'ArmProcessorError',
      'data': { 'type': 'ArmProcessorErrorType' } }

we can later extend it like

    { 'union': 'ArmProcessorError',
      'base: { 'type': 'ArmProcessorErrorType' }
      'data': {
          'bus-error': 'ArmProcessorBusErrorData' } }

    { 'struct': 'ArmProcessorBusErrorData',
      'data': ... }

> diff --git a/qapi/meson.build b/qapi/meson.build
> index e7bc54e5d047..5927932c4be3 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -22,6 +22,7 @@ if have_system or have_tools or have_ga
>  endif
>  
>  qapi_all_modules = [
> +  'arm-error-inject',
>    'authz',
>    'block',
>    'block-core',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b1581988e4eb..479a22de7e43 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -81,3 +81,4 @@
>  { 'include': 'vfio.json' }
>  { 'include': 'cryptodev.json' }
>  { 'include': 'cxl.json' }
> +{ 'include': 'arm-error-inject.json' }


