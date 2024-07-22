Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A9CC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtAQ-00014a-19; Mon, 22 Jul 2024 09:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sVtAO-0000zz-Md
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sVtAM-0002VO-5G
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721655205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5ATSMX9v/PfSEyb9CI3miOcPTYwn6/p6roca0fS5hg=;
 b=fiRFnme0Grl5mNQurWKlKWVsRnmqmlj/QTbagVRoC4rKLqaPJFAqNrBF7kn5oLFv+gt0Zo
 /4p+inmLB36x9I9QX6QuOmfs9OG2HVaejB+4/GEg3m7seIDYjiEYlSzNuwkbe3UIYE3EZC
 6rwv1ga+GMAcoanipkxFbJi12P+QPvs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-WlUGx3PNMQO8Hopa8Eayvw-1; Mon,
 22 Jul 2024 09:33:20 -0400
X-MC-Unique: WlUGx3PNMQO8Hopa8Eayvw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B11C1955D4E; Mon, 22 Jul 2024 13:33:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4080C3000188; Mon, 22 Jul 2024 13:33:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC23E21E669B; Mon, 22 Jul 2024 15:33:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo
 Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Sia Jee Heng
 <jeeheng.sia@starfivetech.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,  Dapeng Mi
 <dapeng1.mi@linux.intel.com>,  Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 2/8] qapi/qom: Introduce smp-cache object
In-Reply-To: <20240704031603.1744546-3-zhao1.liu@intel.com> (Zhao Liu's
 message of "Thu, 4 Jul 2024 11:15:57 +0800")
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-3-zhao1.liu@intel.com>
Date: Mon, 22 Jul 2024 15:33:13 +0200
Message-ID: <87wmld361y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Introduce smp-cache object so that user could define cache properties.
>
> In smp-cache object, define cache topology based on CPU topology level
> with two reasons:
>
> 1. In practice, a cache will always be bound to the CPU container
>    (either private in the CPU container or shared among multiple
>    containers), and CPU container is often expressed in terms of CPU
>    topology level.
> 2. The x86's cache-related CPUIDs encode cache topology based on APIC
>    ID's CPU topology layout. And the ACPI PPTT table that ARM/RISCV
>    relies on also requires CPU containers to help indicate the private
>    shared hierarchy of the cache. Therefore, for SMP systems, it is
>    natural to use the CPU topology hierarchy directly in QEMU to define
>    the cache topology.
>
> Currently, separated L1 cache (L1 data cache and L1 instruction cache)
> with unified higher-level cache (e.g., unified L2 and L3 caches), is the
> most common cache architectures.
>
> Therefore, enumerate the L1 D-cache, L1 I-cache, L2 cache and L3 cache
> with smp-cache object to add the basic cache topology support.
>
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

[...]

> diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> index 82413c668bdb..8b8c0e9eeb86 100644
> --- a/qapi/machine-common.json
> +++ b/qapi/machine-common.json
> @@ -64,3 +64,53 @@
>    'prefix': 'CPU_TOPO_LEVEL',
>    'data': [ 'invalid', 'thread', 'core', 'module', 'cluster',
>              'die', 'socket', 'book', 'drawer', 'default' ] }
> +
> +##
> +# @SMPCacheName:

Why the SMP in this name?  Because it's currently only used by SMP
stuff?  Or is there another reason I'm missing?

The more idiomatic QAPI name would be SmpCacheName.  Likewise for the
other type names below.

> +#
> +# An enumeration of cache for SMP systems.  The cache name here is
> +# a combination of cache level and cache type.

The first sentence feels awkward.  Maybe

   # Caches an SMP system may have.

> +#
> +# @l1d: L1 data cache.
> +#
> +# @l1i: L1 instruction cache.
> +#
> +# @l2: L2 (unified) cache.
> +#
> +# @l3: L3 (unified) cache
> +#
> +# Since: 9.1
> +##

This assumes the L1 cache is split, and L2 and L3 are unified.

If we model a system with say a unified L1 cache, we'd simply extend
this enum.  No real difference to extending it for additional levels.
Correct?

> +{ 'enum': 'SMPCacheName',
> +  'prefix': 'SMP_CACHE',

Why not call it SmpCache, and ditch 'prefix'?

> +  'data': [ 'l1d', 'l1i', 'l2', 'l3' ] }

> +
> +##
> +# @SMPCacheProperty:

Sure we want to call this "property" (singular) and not "properties"?
What if we add members to this type?

> +#
> +# Cache information for SMP systems.
> +#
> +# @name: Cache name.
> +#
> +# @topo: Cache topology level.  It accepts the CPU topology
> +#     enumeration as the parameter, i.e., CPUs in the same
> +#     topology container share the same cache.
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'SMPCacheProperty',
> +  'data': {
> +  'name': 'SMPCacheName',
> +  'topo': 'CpuTopologyLevel' } }

We tend to avoid abbreviations in the QAPI schema.  Please consider
naming this 'topology'.

> +
> +##
> +# @SMPCacheProperties:
> +#
> +# List wrapper of SMPCacheProperty.
> +#
> +# @caches: the SMPCacheProperty list.
> +#
> +# Since 9.1
> +##
> +{ 'struct': 'SMPCacheProperties',
> +  'data': { 'caches': ['SMPCacheProperty'] } }

Ah, now I see why you used the singular above!

However, this type holds the properties of call caches.  It is a list
where each element holds the properties of a single cache.  Calling the
former "cache property" and the latter "cache properties" is confusing.

SmpCachesProperties and SmpCacheProperties would put the singular
vs. plural where it belongs.  Sounds a bit awkward to me, though.
Naming is hard.

Other ideas, anybody?

> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b1581988e4eb..25394f2cda50 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -64,11 +64,11 @@
>  { 'include': 'compat.json' }
>  { 'include': 'control.json' }
>  { 'include': 'introspect.json' }
> -{ 'include': 'qom.json' }
> -{ 'include': 'qdev.json' }
>  { 'include': 'machine-common.json' }
>  { 'include': 'machine.json' }
>  { 'include': 'machine-target.json' }
> +{ 'include': 'qom.json' }
> +{ 'include': 'qdev.json' }
>  { 'include': 'replay.json' }
>  { 'include': 'yank.json' }
>  { 'include': 'misc.json' }

Worth explaining in the commit message, I think.

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e39..797dd58a61f5 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -8,6 +8,7 @@
>  { 'include': 'block-core.json' }
>  { 'include': 'common.json' }
>  { 'include': 'crypto.json' }
> +{ 'include': 'machine-common.json' }
>  
>  ##
>  # = QEMU Object Model (QOM)
> @@ -1064,6 +1065,7 @@
>        'if': 'CONFIG_SECRET_KEYRING' },
>      'sev-guest',
>      'sev-snp-guest',
> +    'smp-cache',
>      'thread-context',
>      's390-pv-guest',
>      'throttle-group',
> @@ -1135,6 +1137,7 @@
>                                        'if': 'CONFIG_SECRET_KEYRING' },
>        'sev-guest':                  'SevGuestProperties',
>        'sev-snp-guest':              'SevSnpGuestProperties',
> +      'smp-cache':                  'SMPCacheProperties',
>        'thread-context':             'ThreadContextProperties',
>        'throttle-group':             'ThrottleGroupProperties',
>        'tls-creds-anon':             'TlsCredsAnonProperties',


