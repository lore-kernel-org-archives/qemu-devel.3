Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8166DC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 12:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7vXQ-0004I2-Ie; Thu, 24 Apr 2025 08:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u7vXM-0004DW-PB
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 08:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u7vXJ-00033I-PA
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 08:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745497115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eqa/wyHkA5Rds0zkDQ8ijbjXqasl+g3gbnyFVrmdGMA=;
 b=IgK3x/svPhzTZYzL30xNja9+2m/0crNOtyKEcJ94xE97vNl10mosZ0t1dHzR1id1dvQOrO
 LrUmdjmZeQMQ0GzAB894qVsdUzGbJBcXLg+FnXN47tW7fLY6gdLRHlcl4jHB0b7wZNOmKb
 JIFFSEhrytmXXOJpzlp1A98O+2m+M+o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-eDini4p0PFG706XdvBSijg-1; Thu,
 24 Apr 2025 08:18:30 -0400
X-MC-Unique: eDini4p0PFG706XdvBSijg-1
X-Mimecast-MFC-AGG-ID: eDini4p0PFG706XdvBSijg_1745497109
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EA4F1800368; Thu, 24 Apr 2025 12:18:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77833180047F; Thu, 24 Apr 2025 12:18:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 08CA921E66C3; Thu, 24 Apr 2025 14:18:23 +0200 (CEST)
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
Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
In-Reply-To: <20250409082649.14733-2-zhao1.liu@intel.com> (Zhao Liu's message
 of "Wed, 9 Apr 2025 16:26:45 +0800")
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-2-zhao1.liu@intel.com>
Date: Thu, 24 Apr 2025 14:18:22 +0200
Message-ID: <87tt6d4usx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> Introduce the kvm-pmu-filter object and support the PMU event with raw
> format.
>
> The raw format, as a native PMU event code representation, can be used
> for several architectures.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>

[...]

> diff --git a/qapi/accelerator.json b/qapi/accelerator.json
> new file mode 100644
> index 000000000000..1fe0d64be113
> --- /dev/null
> +++ b/qapi/accelerator.json
> @@ -0,0 +1,14 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +# Copyright (C) 2025 Intel Corporation.
> +#
> +# Author: Zhao Liu <zhao1.liu@intel.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +##
> +# = Accelerators
> +##
> +
> +{ 'include': 'kvm.json' }
> diff --git a/qapi/kvm.json b/qapi/kvm.json
> new file mode 100644
> index 000000000000..1861d86a9726
> --- /dev/null
> +++ b/qapi/kvm.json
> @@ -0,0 +1,84 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +# Copyright (C) 2025 Intel Corporation.
> +#
> +# Author: Zhao Liu <zhao1.liu@intel.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +##
> +# == KVM
> +##

There's KVM-specific stuff elsewhere in the schema.  Some if of it
should probably be moved here.  Can you have a look?  This is not a
demand; it's fine if you can't.  If you can: separate patch preceding
this one to create kvm.json and move stuff there.

> +
> +##
> +# === PMU stuff (KVM related)

The KVM subsection contains just this subsubsection.  Awkward.  Can we
do without this subsubsection now?  We can always add it later, when we
have enough KVM stuff to warrant structuring it into subsubsections.

If we decide we want it:

   # === KVM performance monitor unit (PMU)

> +##
> +
> +##
> +# @KvmPmuFilterAction:
> +#
> +# Actions that KVM PMU filter supports.
> +#
> +# @deny: disable the PMU event/counter in KVM PMU filter.
> +#
> +# @allow: enable the PMU event/counter in KVM PMU filter.
> +#
> +# Since 10.1
> +##
> +{ 'enum': 'KvmPmuFilterAction',
> +  'data': ['allow', 'deny'] }
> +
> +##
> +# @KvmPmuEventFormat:

Maybe KvmPmuFilterEventFormat?  Or is that too long?

> +#
> +# Encoding formats of PMU event that QEMU/KVM supports.
> +#
> +# @raw: the encoded event code that KVM can directly consume.

Suggest

   # @raw: raw KVM PMU event code.

> +#
> +# Since 10.1
> +##
> +{ 'enum': 'KvmPmuEventFormat',
> +  'data': ['raw'] }
> +
> +##
> +# @KvmPmuRawEvent:

Maybe KvmPmuFilterEventRaw?  Or is that too long?

> +#
> +# Raw PMU event code.
> +#
> +# @code: the raw value that has been encoded, and QEMU could deliver
> +#     to KVM directly.

Suggest

   ##
   # @KvmPmuRawEvent
   #
   # @code: raw KVM PMU event code, to be passed verbatim to KVM.

> +#
> +# Since 10.1
> +##
> +{ 'struct': 'KvmPmuRawEvent',
> +  'data': { 'code': 'uint64' } }
> +
> +##
> +# @KvmPmuFilterEvent:
> +#
> +# PMU event filtered by KVM.

Suggest

   # A KVM PMU event specification.

> +#
> +# @format: PMU event format.
> +#
> +# Since 10.1
> +##
> +{ 'union': 'KvmPmuFilterEvent',
> +  'base': { 'format': 'KvmPmuEventFormat' },
> +  'discriminator': 'format',
> +  'data': { 'raw': 'KvmPmuRawEvent' } }
> +
> +##
> +# @KvmPmuFilterProperties:
> +#
> +# Properties of KVM PMU Filter.
> +#
> +# @action: action that KVM PMU filter will take for selected PMU events.
> +#
> +# @events: list of selected PMU events.

Here's my try:

   # Properties of kvm-pmu-filter objects.  A kvm-pmu-filter object
   # restricts the guest's access to the PMU with either an allowlist or
   # a denylist.
   #
   # @action: whether @events is an allowlist or a denylist.
   #
   # @events: list of KVM PMU event specifications.

> +#
> +# Since 10.1
> +##
> +{ 'struct': 'KvmPmuFilterProperties',
> +  'data': { 'action': 'KvmPmuFilterAction',
> +            '*events': ['KvmPmuFilterEvent'] } }
> diff --git a/qapi/meson.build b/qapi/meson.build
> index eadde4db307f..dba27ebc7489 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -37,6 +37,7 @@ qapi_all_modules = [
>    'error',
>    'introspect',
>    'job',
> +  'kvm',
>    'machine-common',
>    'machine',
>    'machine-target',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index c41c01eb2ab9..c7fed7940af7 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -66,6 +66,7 @@
>  { 'include': 'compat.json' }
>  { 'include': 'control.json' }
>  { 'include': 'introspect.json' }
> +{ 'include': 'accelerator.json' }
>  { 'include': 'qom.json' }
>  { 'include': 'qdev.json' }
>  { 'include': 'machine-common.json' }
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 28ce24cd8d08..517f4c06c260 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -8,6 +8,7 @@
>  { 'include': 'block-core.json' }
>  { 'include': 'common.json' }
>  { 'include': 'crypto.json' }
> +{ 'include': 'kvm.json' }
>  
>  ##
>  # = QEMU Object Model (QOM)
> @@ -1108,6 +1109,7 @@
>        'if': 'CONFIG_LINUX' },
>      'iommufd',
>      'iothread',
> +    'kvm-pmu-filter',
>      'main-loop',
>      { 'name': 'memory-backend-epc',
>        'if': 'CONFIG_LINUX' },
> @@ -1183,6 +1185,7 @@
>                                        'if': 'CONFIG_LINUX' },
>        'iommufd':                    'IOMMUFDProperties',
>        'iothread':                   'IothreadProperties',
> +      'kvm-pmu-filter':             'KvmPmuFilterProperties',
>        'main-loop':                  'MainLoopProperties',
>        'memory-backend-epc':         { 'type': 'MemoryBackendEpcProperties',
>                                        'if': 'CONFIG_LINUX' },


