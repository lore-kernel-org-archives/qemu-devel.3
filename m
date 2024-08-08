Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29702C52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbyr9-0004Zb-OY; Thu, 08 Aug 2024 04:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbyr7-0004Q6-Th
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbyr3-0007lk-Oj
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723107040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+P945oXoh8Dg1hOM4d9au0nq9mZ8s5CjyWl9HOYb1UU=;
 b=GxK+RebtgMsLzJAoJNlnKRo/iSjMzF26AVS6pmROurXDkmrR/mPx4ynzRLRYIU7HzbsYuo
 SaAp6M5CaeI2wT+Bhe/dMpNlYn4FAcoUUeGm1lM8K2T6dgPLpMdGMiZmI6a4THgm2B++ZL
 lWverxQHL71Tc4HRw9VMXqKi9a7pc1M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-dA68Y6d5O2CCl_orbzP6HQ-1; Thu,
 08 Aug 2024 04:50:38 -0400
X-MC-Unique: dA68Y6d5O2CCl_orbzP6HQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99DAF1944B2F; Thu,  8 Aug 2024 08:50:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EFF11956056; Thu,  8 Aug 2024 08:50:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 12BAF21E6692; Thu,  8 Aug 2024 10:50:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Shiju Jose
 <shiju.jose@huawei.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Ani
 Sinha <anisinha@redhat.com>,  Dongjiu Geng <gengdongjiu1@gmail.com>,  Eric
 Blake <eblake@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
In-Reply-To: <51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
 (Mauro Carvalho Chehab's message of "Fri, 2 Aug 2024 23:44:00 +0200")
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
Date: Thu, 08 Aug 2024 10:50:33 +0200
Message-ID: <87v80b1jqe.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Creates a QMP command to be used for generic ACPI APEI hardware error
> injection (HEST) via GHESv2.
>
> The actual GHES code will be added at the followup patch.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS              |  7 +++++
>  hw/acpi/Kconfig          |  5 ++++
>  hw/acpi/ghes_cper.c      | 45 ++++++++++++++++++++++++++++++++
>  hw/acpi/ghes_cper_stub.c | 18 +++++++++++++
>  hw/acpi/meson.build      |  2 ++
>  hw/arm/Kconfig           |  5 ++++
>  include/hw/acpi/ghes.h   |  7 +++++
>  qapi/ghes-cper.json      | 55 ++++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build         |  1 +
>  qapi/qapi-schema.json    |  1 +
>  10 files changed, 146 insertions(+)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/ghes-cper.json
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 98eddf7ae155..655edcb6688c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
>  F: include/hw/acpi/ghes.h
>  F: docs/specs/acpi_hest_ghes.rst
>  
> +ACPI/HEST/GHES/ARM processor CPER
> +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +S: Maintained
> +F: hw/arm/ghes_cper.c
> +F: hw/acpi/ghes_cper_stub.c
> +F: qapi/ghes-cper.json
> +

Here's the reason for creating a new QAPI module instead of adding to
existing module acpi.json: different maintainers.

Hypothetical question: if we didn't care for that, would this go into
qapi/acpi.json?

If yes, then should we call it acpi-ghes-cper.json or acpi-ghes.json
instead?

>  ppc4xx
>  L: qemu-ppc@nongnu.org
>  S: Orphan

[...]

> diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
> new file mode 100644
> index 000000000000..3cc4f9f2aaa9
> --- /dev/null
> +++ b/qapi/ghes-cper.json
> @@ -0,0 +1,55 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +
> +##
> +# = GHESv2 CPER Error Injection
> +#
> +# These are defined at
> +# ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> +# (GHESv2 - Type 10)
> +##

Feels a bit terse.  These what?

The reference could be clearer: "defined in the ACPI Specification 6.2,
section 18.3.2.8 Generic Hardware Error Source version 2".  A link would
be nice, if it's stable.

> +
> +##
> +# @CommonPlatformErrorRecord:
> +#
> +# Common Platform Error Record - CPER - as defined at the UEFI
> +# specification.  See
> +# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
> +# for more details.
> +#
> +# @notification-type: pre-assigned GUID string indicating the record
> +#   association with an error event notification type, as defined
> +#   at https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header

Please indent four spaces for consistency, like this:

   # @notification-type: pre-assigned GUID string indicating the record
   #     association with an error event notification type, as defined at
   #     https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header

> +#
> +# @raw-data: Contains a base64 encoded string with the payload of
> +#   the CPER.

Suggest

  # @raw-data: payload of the CPER encoded in base64

Have you considered naming this @payload instead?

> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'CommonPlatformErrorRecord',
> +  'data': {
> +      'notification-type': 'str',
> +      'raw-data': 'str'
> +  }
> +}
> +
> +##
> +# @ghes-cper:
> +#
> +# Inject ARM Processor error with data to be filled according with
> +# ACPI 6.2 GHESv2 spec.

according to

(Beware, I'm not a native speaker)

> +#
> +# @cper: a single CPER record to be sent to the guest OS.
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since: 9.2
> +##
> +{ 'command': 'ghes-cper',
> +  'data': {
> +    'cper': 'CommonPlatformErrorRecord'
> +  },
> +  'features': [ 'unstable' ]
> +}
> diff --git a/qapi/meson.build b/qapi/meson.build
> index e7bc54e5d047..bd13cd7d40c9 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -35,6 +35,7 @@ qapi_all_modules = [
>    'dump',
>    'ebpf',
>    'error',
> +  'ghes-cper',
>    'introspect',
>    'job',
>    'machine-common',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b1581988e4eb..c1a267399fe5 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -75,6 +75,7 @@
>  { 'include': 'misc-target.json' }
>  { 'include': 'audio.json' }
>  { 'include': 'acpi.json' }
> +{ 'include': 'ghes-cper.json' }
>  { 'include': 'pci.json' }
>  { 'include': 'stats.json' }
>  { 'include': 'virtio.json' }


