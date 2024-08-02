Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0392C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 09:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZoq5-0002fp-7B; Fri, 02 Aug 2024 05:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZoq3-0002eA-By
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 05:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZoq1-0001gQ-Es
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 05:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722591877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B9EaUStHADUXdsk6O1sblIXDnZ14YmoOn7I4PIz0ei0=;
 b=Wu8pFb3Z4/DVu6y/UwsvBPGzeTQ+azBkIMTN3YmXx7mEI6YQOcvnKCN7+EcCVK2dlUxHXq
 u/BZwLqkdTVXKkXmNoK9xG9q0UGXvC/gkl1qYM0isu2baRt4t3gzqSXZQ0CWijubtPubQx
 ThC0ozjixUryxoEWxI+jE+ZmG+hafmg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-Ed9lTl1vOnuX4x6-AEFjrg-1; Fri,
 02 Aug 2024 05:44:33 -0400
X-MC-Unique: Ed9lTl1vOnuX4x6-AEFjrg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4547A1955F40; Fri,  2 Aug 2024 09:44:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59D781955F6B; Fri,  2 Aug 2024 09:44:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4FA0621E668F; Fri,  2 Aug 2024 11:44:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Shiju Jose
 <shiju.jose@huawei.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Ani
 Sinha <anisinha@redhat.com>,  Dongjiu Geng <gengdongjiu1@gmail.com>,  Eric
 Blake <eblake@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
In-Reply-To: <5a4da771f04beea4e7488eee8080c0ace372e9a0.1722523312.git.mchehab+huawei@kernel.org>
 (Mauro Carvalho Chehab's message of "Thu, 1 Aug 2024 16:47:08 +0200")
References: <cover.1722523312.git.mchehab+huawei@kernel.org>
 <5a4da771f04beea4e7488eee8080c0ace372e9a0.1722523312.git.mchehab+huawei@kernel.org>
Date: Fri, 02 Aug 2024 11:44:26 +0200
Message-ID: <87plqr45tx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Creates a QAPI to be used for generic ACPI APEI hardware error
> injection (HEST) via GHESv2.

Creates a QMP command

> The actual GHES code will be added at the followup patch.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS            |  7 ++++++
>  hw/acpi/Kconfig        |  5 ++++
>  hw/acpi/ghes_cper.c    | 53 +++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/meson.build    |  2 ++
>  hw/arm/Kconfig         |  5 ++++
>  include/hw/acpi/ghes.h |  6 +++++
>  qapi/ghes-cper.json    | 54 ++++++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build       |  1 +
>  qapi/qapi-schema.json  |  1 +
>  9 files changed, 134 insertions(+)
>  create mode 100644 hw/acpi/ghes_cper.c
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
>  ppc4xx
>  L: qemu-ppc@nongnu.org
>  S: Orphan

[...]

> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index fa5c07db9068..6cbf430eb66d 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -34,4 +34,6 @@ endif
>  system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
>  system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))

../hw/acpi/meson.build:38:50: ERROR: File ghes_cper_stub.c does not exist.

>  system_ss.add(files('acpi-qmp-cmds.c'))

[...]

> diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
> new file mode 100644
> index 000000000000..2b0438431054
> --- /dev/null
> +++ b/qapi/ghes-cper.json

Would this fit into acpi.json?

If yes: would the maintainers of acpi.json be happy to take it?
Michael, Igor?

> @@ -0,0 +1,54 @@
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
> +
> +##
> +# @CommonPlatformErrorRecord:
> +#
> +# Common Platform Error Record - CPER - as defined at the UEFI
> +# specification. See

Separate sentences with two spaces for consistency, please.

> +# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
> +# for more details.
> +#
> +# @notification-type: pre-assigned GUID value indicating the record
> +#   association with an error event notification type, as defined
> +#   at https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
> +#
> +# @raw-data: Contains the payload of the CPER.
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'CommonPlatformErrorRecord',
> +  'data': {
> +      'notification-type': ['uint8'],
> +      'raw-data': ['uint8']
> +  }
> +}

You use ['uint8'] for binary.  We commonly represent binary as
base64-encoded strings in QAPI.

If @notification-type is a UUID, we should use the usual text
representation.  qemu/uuid.h has functions to convert between binary and
text.

> +
> +##
> +# @ghes-cper:
> +#
> +# Inject ARM Processor error with data to be filled according with
> +# ACPI 6.2 GHESv2 spec.
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
> index b1581988e4eb..54165c8d6655 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -81,3 +81,4 @@
>  { 'include': 'vfio.json' }
>  { 'include': 'cryptodev.json' }
>  { 'include': 'cxl.json' }
> +{ 'include': 'ghes-cper.json' }

Put it next to acpi.json, perhaps?


