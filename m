Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE65EC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPwc-0000bJ-9r; Tue, 04 Jun 2024 04:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEPwb-0000ad-1n
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEPwZ-00032F-HN
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717491299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Kh6eB6FJO7y29jcT+D89kAQxKrmCwTX41ilLKqtUEQ=;
 b=bWJ0Wq10+KYgyx54DE+yvvqSUlbMn8PJlYYOQUfiF87Rj6vkw5Co0kP41dV1EI25fZyWLc
 G5mNczydJqzMNzgQtGz4DISNnNoTTOaWHWl9Xo23ZhAFH8KUxTfuFdtZ5Y3VGJVjjantQG
 gjaBGvaKB/SF1cF+1whagMxIbHSyTJk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-m6nBrRR1Plq-R6WoAWdtFA-1; Tue, 04 Jun 2024 04:54:54 -0400
X-MC-Unique: m6nBrRR1Plq-R6WoAWdtFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5831D8025EF;
 Tue,  4 Jun 2024 08:54:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5656E3C23;
 Tue,  4 Jun 2024 08:54:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6349221E6757; Tue,  4 Jun 2024 10:54:51 +0200 (CEST)
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
Subject: Re: [RFC v2 3/7] hw/core: Add cache topology options in -smp
In-Reply-To: <20240530101539.768484-4-zhao1.liu@intel.com> (Zhao Liu's message
 of "Thu, 30 May 2024 18:15:35 +0800")
References: <20240530101539.768484-1-zhao1.liu@intel.com>
 <20240530101539.768484-4-zhao1.liu@intel.com>
Date: Tue, 04 Jun 2024 10:54:51 +0200
Message-ID: <87sext9jfo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Add "l1d-cache", "l1i-cache". "l2-cache", and "l3-cache" options in
> -smp to define the cache topology for SMP system.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index 7ac5a05bb9c9..8fa5af69b1bf 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1746,6 +1746,23 @@
>  #
>  # @threads: number of threads per core
>  #
> +# @l1d-cache: topology hierarchy of L1 data cache. It accepts the CPU
> +#     topology enumeration as the parameter, i.e., CPUs in the same
> +#     topology container share the same L1 data cache. (since 9.1)
> +#
> +# @l1i-cache: topology hierarchy of L1 instruction cache. It accepts
> +#     the CPU topology enumeration as the parameter, i.e., CPUs in the
> +#     same topology container share the same L1 instruction cache.
> +#     (since 9.1)
> +#
> +# @l2-cache: topology hierarchy of L2 unified cache. It accepts the CPU
> +#     topology enumeration as the parameter, i.e., CPUs in the same
> +#     topology container share the same L2 unified cache. (since 9.1)
> +#
> +# @l3-cache: topology hierarchy of L3 unified cache. It accepts the CPU
> +#     topology enumeration as the parameter, i.e., CPUs in the same
> +#     topology container share the same L3 unified cache. (since 9.1)
> +#
>  # Since: 6.1
>  ##

The new members are all optional.  What does "absent" mean?  No such
cache?  Some default topology?

Is this sufficiently general?  Do all machines of interest have a split
level 1 cache, a level 2 cache, and a level 3 cache?

Is the CPU topology level the only cache property we'll want to
configure here?  If the answer isn't "yes", then we should perhaps wrap
it in an object, so we can easily add more members later.

Two spaces between sentences for consistency, please.

>  { 'struct': 'SMPConfiguration', 'data': {
> @@ -1758,7 +1775,11 @@
>       '*modules': 'int',
>       '*cores': 'int',
>       '*threads': 'int',
> -     '*maxcpus': 'int' } }
> +     '*maxcpus': 'int',
> +     '*l1d-cache': 'CPUTopoLevel',
> +     '*l1i-cache': 'CPUTopoLevel',
> +     '*l2-cache': 'CPUTopoLevel',
> +     '*l3-cache': 'CPUTopoLevel' } }
>  
>  ##
>  # @x-query-irq:
> diff --git a/system/vl.c b/system/vl.c

[...]


