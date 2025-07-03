Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9422BC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFMD-0008Rh-AS; Thu, 03 Jul 2025 04:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXFM0-0008OS-Hn
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXFLy-0006Z0-1M
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751531490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDFNFjUDbkVduXGlmsYCznbew7zFkai1qcWy1WXNVjE=;
 b=L6ioj2zsypugegO5wnxU+rJz2zuWnc4+wPI03ABofmHN881EYsPkS5RnhqFLyiDzqOFarP
 kvUnj4JvdSJsa+e6ljEMZwAoixRB0m49YGNaTA4JHvtIM5AVr6q6yFEUA2Lhg+9lprhTHs
 pIqWLnI8uPb+5qyZI214uAUfrGNmcDE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-g5ambDpYMv62B6PMg9ykJg-1; Thu,
 03 Jul 2025 04:31:26 -0400
X-MC-Unique: g5ambDpYMv62B6PMg9ykJg-1
X-Mimecast-MFC-AGG-ID: g5ambDpYMv62B6PMg9ykJg_1751531484
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51D3F19373D8; Thu,  3 Jul 2025 08:31:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A9D119560A7; Thu,  3 Jul 2025 08:31:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9921B21E6A27; Thu, 03 Jul 2025 10:31:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,  Eric Blake
 <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 22/65] qapi: Move definitions related to accelerators
 in their own file
In-Reply-To: <20250702185332.43650-23-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 2 Jul 2025 20:52:44
 +0200")
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-23-philmd@linaro.org>
Date: Thu, 03 Jul 2025 10:31:20 +0200
Message-ID: <87cyah65gn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Extract TCG and KVM definitions from machine.json to accelerator.json.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS                |  1 +
>  qapi/accelerator.json      | 75 ++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json          | 65 ---------------------------------
>  qapi/qapi-schema.json      |  1 +
>  accel/tcg/monitor.c        |  2 +-
>  hw/core/machine-hmp-cmds.c |  1 +
>  hw/core/machine-qmp-cmds.c |  1 +
>  qapi/meson.build           |  1 +
>  8 files changed, 81 insertions(+), 66 deletions(-)
>  create mode 100644 qapi/accelerator.json
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7128e0bc98e..5d6b337cef6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -507,6 +507,7 @@ F: accel/Makefile.objs
>  F: accel/stubs/Makefile.objs
>  F: cpu-common.c
>  F: cpu-target.c
> +F: qapi/accelerator.json
>  F: system/cpus.c
>=20=20
>  Apple Silicon HVF CPUs
> diff --git a/qapi/accelerator.json b/qapi/accelerator.json
> new file mode 100644
> index 00000000000..1d2a83f1b22
> --- /dev/null
> +++ b/qapi/accelerator.json
> @@ -0,0 +1,75 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=3Dpython
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +##
> +# =3D Accelerators
> +##

Going to conflict with John Snow's "[PATCH v3 4/5] docs/sphinx: remove
special parsing for freeform sections".  Don't worry about it.

> +
> +{ 'include': 'common.json' }
> +
> +##
> +# @KvmInfo:
> +#
> +# Information about support for KVM acceleration
> +#
> +# @enabled: true if KVM acceleration is active
> +#
> +# @present: true if KVM acceleration is built into this executable
> +#
> +# Since: 0.14
> +##
> +{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
> +
> +##
> +# @query-kvm:
> +#
> +# Return information about KVM acceleration
> +#
> +# Returns: @KvmInfo
> +#
> +# Since: 0.14
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "query-kvm" }
> +#     <- { "return": { "enabled": true, "present": true } }
> +##
> +{ 'command': 'query-kvm', 'returns': 'KvmInfo' }
> +
> +##
> +# @x-query-jit:
> +#
> +# Query TCG compiler statistics
> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: TCG compiler statistics
> +#
> +# Since: 6.2
> +##
> +{ 'command': 'x-query-jit',
> +  'returns': 'HumanReadableText',
> +  'if': 'CONFIG_TCG',
> +  'features': [ 'unstable' ] }
> +
> +##
> +# @x-query-opcount:
> +#
> +# Query TCG opcode counters
> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: TCG opcode counters
> +#
> +# Since: 6.2
> +##
> +{ 'command': 'x-query-opcount',
> +  'returns': 'HumanReadableText',
> +  'if': 'CONFIG_TCG',
> +  'features': [ 'unstable' ] }
> diff --git a/qapi/machine.json b/qapi/machine.json
> index d5bbb5e367e..e4713c405e8 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -454,35 +454,6 @@
>  ##
>  { 'command': 'inject-nmi' }
>=20=20
> -##
> -# @KvmInfo:
> -#
> -# Information about support for KVM acceleration
> -#
> -# @enabled: true if KVM acceleration is active
> -#
> -# @present: true if KVM acceleration is built into this executable
> -#
> -# Since: 0.14
> -##
> -{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
> -
> -##
> -# @query-kvm:
> -#
> -# Return information about KVM acceleration
> -#
> -# Returns: @KvmInfo
> -#
> -# Since: 0.14
> -#
> -# .. qmp-example::
> -#
> -#     -> { "execute": "query-kvm" }
> -#     <- { "return": { "enabled": true, "present": true } }
> -##
> -{ 'command': 'query-kvm', 'returns': 'KvmInfo' }
> -
>  ##
>  # @NumaOptionsType:
>  #
> @@ -1729,24 +1700,6 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
>=20=20
> -##
> -# @x-query-jit:
> -#
> -# Query TCG compiler statistics
> -#
> -# Features:
> -#
> -# @unstable: This command is meant for debugging.
> -#
> -# Returns: TCG compiler statistics
> -#
> -# Since: 6.2
> -##
> -{ 'command': 'x-query-jit',
> -  'returns': 'HumanReadableText',
> -  'if': 'CONFIG_TCG',
> -  'features': [ 'unstable' ] }
> -
>  ##
>  # @x-query-numa:
>  #
> @@ -1764,24 +1717,6 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
>=20=20
> -##
> -# @x-query-opcount:
> -#
> -# Query TCG opcode counters
> -#
> -# Features:
> -#
> -# @unstable: This command is meant for debugging.
> -#
> -# Returns: TCG opcode counters
> -#
> -# Since: 6.2
> -##
> -{ 'command': 'x-query-opcount',
> -  'returns': 'HumanReadableText',
> -  'if': 'CONFIG_TCG',
> -  'features': [ 'unstable' ] }
> -
>  ##
>  # @x-query-ramblock:
>  #
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index a8f66163cb7..0477696ff02 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -37,6 +37,7 @@
>  { 'include': 'run-state.json' }
>  { 'include': 'crypto.json' }
>  { 'include': 'job.json' }
> +{ 'include': 'accelerator.json' }
>  { 'include': 'block.json' }
>  { 'include': 'block-export.json' }
>  { 'include': 'char.json' }

This puts the new section "Accelerators" between "Background jobs" and
"Block devices".  Feels arbitrary.  Much of the existing order does.
Would it fit better next to "Machines"?

> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index 1c182b6bfb5..5bdd837006c 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -11,7 +11,7 @@
>  #include "qemu/qht.h"
>  #include "qapi/error.h"
>  #include "qapi/type-helpers.h"
> -#include "qapi/qapi-commands-machine.h"
> +#include "qapi/qapi-commands-accelerator.h"
>  #include "monitor/monitor.h"
>  #include "system/cpu-timers.h"
>  #include "exec/icount.h"
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index 65eeb5e9cc2..15ae5864d16 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -18,6 +18,7 @@
>  #include "monitor/monitor.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-builtin-visit.h"
> +#include "qapi/qapi-commands-accelerator.h"
>  #include "qapi/qapi-commands-machine.h"
>  #include "qobject/qdict.h"
>  #include "qapi/string-output-visitor.h"
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index ab4fd1ec08a..f37fd220c2d 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -14,6 +14,7 @@
>  #include "hw/mem/memory-device.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-builtin-visit.h"
> +#include "qapi/qapi-commands-accelerator.h"
>  #include "qapi/qapi-commands-machine.h"
>  #include "qobject/qobject.h"
>  #include "qapi/qobject-input-visitor.h"

Have you considered extracting the accelerator command code to
accel/accel-qmp-cmds.c and accel/accel-hmp-cmds.c?

> diff --git a/qapi/meson.build b/qapi/meson.build
> index 3b035aea339..ca6b61a608d 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -57,6 +57,7 @@ qapi_all_modules =3D [
>  ]
>  if have_system
>    qapi_all_modules +=3D [
> +    'accelerator',
>      'acpi',
>      'audio',
>      'cryptodev',


