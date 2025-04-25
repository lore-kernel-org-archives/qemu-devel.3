Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD54C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FDY-0007W4-RJ; Fri, 25 Apr 2025 05:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8FDT-0007R5-Pe
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8FDR-0006xY-PF
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745572763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ZutwbOjXGr5bGwYW46iHYOEUi2TGqqNhr0ZW2OCt4A=;
 b=aZ0s53+Wp7K3EkSfb3DIlxWLrUq5SyepnOnLsVP5JBrsUFw7TphRyJLuPULpGr+fZpl+jP
 JYcY+JQgmsj1ANJhGZ0BVgc4FjAOnONIofZq9WMPnFmGVXKViy/R92eFWqDzxWvMmkgEJt
 iKagTXRuAwVJwHmosbknOpTYVM6uBU0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-LdiWRZCINieW0mfEquIkpQ-1; Fri,
 25 Apr 2025 05:19:17 -0400
X-MC-Unique: LdiWRZCINieW0mfEquIkpQ-1
X-Mimecast-MFC-AGG-ID: LdiWRZCINieW0mfEquIkpQ_1745572755
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65F7E19560AE; Fri, 25 Apr 2025 09:19:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 886F030001AB; Fri, 25 Apr 2025 09:19:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB81421E6766; Fri, 25 Apr 2025 11:19:10 +0200 (CEST)
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
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
In-Reply-To: <20250409082649.14733-2-zhao1.liu@intel.com> (Zhao Liu's message
 of "Wed, 9 Apr 2025 16:26:45 +0800")
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-2-zhao1.liu@intel.com>
Date: Fri, 25 Apr 2025 11:19:10 +0200
Message-ID: <87a584ha41.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Philippe, there's a question for you on target-specific QAPI schema.

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

> diff --git a/accel/kvm/kvm-pmu.c b/accel/kvm/kvm-pmu.c
> new file mode 100644
> index 000000000000..22f749bf9183
> --- /dev/null
> +++ b/accel/kvm/kvm-pmu.c

[...]

> +static const TypeInfo kvm_pmu_filter_info = {
> +    .parent = TYPE_OBJECT,
> +    .name = TYPE_KVM_PMU_FILTER,
> +    .class_init = kvm_pmu_filter_class_init,
> +    .instance_size = sizeof(KVMPMUFilter),
> +    .instance_init = kvm_pmu_filter_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void kvm_pmu_event_register_type(void)
> +{
> +    type_register_static(&kvm_pmu_filter_info);
> +}
> +
> +type_init(kvm_pmu_event_register_type);
> diff --git a/accel/kvm/meson.build b/accel/kvm/meson.build
> index 397a1fe1fd1e..dfab2854f3a8 100644
> --- a/accel/kvm/meson.build
> +++ b/accel/kvm/meson.build
> @@ -2,6 +2,7 @@ kvm_ss = ss.source_set()
>  kvm_ss.add(files(
>    'kvm-all.c',
>    'kvm-accel-ops.c',
> +  'kvm-pmu.c',
>  ))
>  
>  specific_ss.add_all(when: 'CONFIG_KVM', if_true: kvm_ss)

The new file is compiled into the binary when CONFIG_KVM.  Therefore,
object kvm-pmu-filter is available exactly then.  Makes sense.
However, ...

[...]

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
> +
> +##
> +# === PMU stuff (KVM related)
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
> +#
> +# Encoding formats of PMU event that QEMU/KVM supports.
> +#
> +# @raw: the encoded event code that KVM can directly consume.
> +#
> +# Since 10.1
> +##
> +{ 'enum': 'KvmPmuEventFormat',
> +  'data': ['raw'] }
> +
> +##
> +# @KvmPmuRawEvent:
> +#
> +# Raw PMU event code.
> +#
> +# @code: the raw value that has been encoded, and QEMU could deliver
> +#     to KVM directly.
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
> +#
> +# Since 10.1
> +##
> +{ 'struct': 'KvmPmuFilterProperties',
> +  'data': { 'action': 'KvmPmuFilterAction',
> +            '*events': ['KvmPmuFilterEvent'] } }

... the QAPI schema doesn't reflect that.

To make it reflect, we'd have to add 'if': 'CONFIG_KVM'.  Since
CONFIG_KVM can only be used in target-specific code, we'd have to put
the definitions in a target-specific schema module kvm-target.json.

This makes the headers generated for the module target-specific, which
can be inconvenient.  Whether it's inconvenient here, I can't say.

I understand target-specific QAPI modules are problematic for the single
binary / heterogeneous machine work.  Philippe, thoughts on this one?

[...]


