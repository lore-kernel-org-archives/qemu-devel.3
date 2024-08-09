Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612E6C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 12:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scOg5-0008Ro-NS; Fri, 09 Aug 2024 08:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1scOg4-0008QO-Rz
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1scOg1-00013J-Qn
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723206299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UOwA4QbVkDmvqf7etn9t7Ds166wZBQN7pf+VdSr6FkM=;
 b=RpkMOJiqvMmyWYgbk9jyTh2NbVlJAmJ0GAXNLv+I4sPJ9qNJ1Golgndxj8+4sktE9xLllV
 9K1/RNFXpI7gLTeG+xA3P50HZQOfFWO0nqk+DkqfrzYul4xZ6MU1gNJ/MrMwsiljuxxR1Q
 Dqo7YZZmeLiUaD15mxf6M216ib1AKkk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33--7dfJdlSNg-Vn4YmIjJ4nw-1; Fri,
 09 Aug 2024 08:24:56 -0400
X-MC-Unique: -7dfJdlSNg-Vn4YmIjJ4nw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AEC91956058; Fri,  9 Aug 2024 12:24:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAA9019560AE; Fri,  9 Aug 2024 12:24:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFCA821E668B; Fri,  9 Aug 2024 14:24:48 +0200 (CEST)
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
Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache object
In-Reply-To: <ZqyRik4UHHz3xaKl@intel.com> (Zhao Liu's message of "Fri, 2 Aug
 2024 15:58:02 +0800")
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-9-zhao1.liu@intel.com>
 <87r0bl35ug.fsf@pond.sub.org> <Zp5vxtXWDeHAdPok@intel.com>
 <87bk2nnev2.fsf@pond.sub.org> <ZqEN1kZaQcuY4UPG@intel.com>
 <87le1psuv3.fsf@pond.sub.org> <ZqtXP9MViOlyhEsu@intel.com>
 <87mslweb38.fsf@pond.sub.org> <ZqyRik4UHHz3xaKl@intel.com>
Date: Fri, 09 Aug 2024 14:24:48 +0200
Message-ID: <8734ndj33j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I apologize for the delay.

Zhao Liu <zhao1.liu@intel.com> writes:

> On Thu, Aug 01, 2024 at 01:28:27PM +0200, Markus Armbruster wrote:

[...]

>> Can you provide a brief summary of the design alternatives that have
>> been proposed so far?  Because I've lost track.
>
> No problem!
>
> Currently, we have the following options:
>
> * 1st: The first one is just to configure cache topology with several
>   options in -smp:
>
>   -smp l1i-cache-topo=core,l1d-cache-topo-core
>
>   This one lacks scalability to support the cache size that ARM will
>   need in the future.

-smp sets machine property "smp" of QAPI type SMPConfiguration.

So this one adds members l1i-cache-topo, l1d-cache-topo, ... to
SMPConfiguration.

> * 2nd: The cache list object in -smp.
>
>   The idea was to use JSON to configure the cache list. However, the
>   underlying implementation of -smp at the moment is keyval parsing,
>   which is not compatible with JSON.

Keyval is a variation of the QEMU's traditional KEY=VALUE,... syntax
that can serve as an alternative to JSON, with certain restrictions.
Ideally, we provide both JSON and keyval syntax on the command line.

Example: -blockdev supports both JSON and keyval.
    JSON:   -blockdev '{"driver": "null-co", "node-name": "node0"}'
    keyval: -blockdev null-co,node-name=node0

Unfortunately, we have many old interfaces that still lack JSON support.

>   If we can not insist on JSON format, then cache lists can also be
>   implemented in the following way:
>   
>   -smp caches.0.name=l1i,caches.0.topo=core,\
>        caches.1.name=l1d,caches.1.topo=core

This one adds a single member caches to SMPConfiguration.  It is an
array of objects.

> * 3rd: The cache list object linked in -machine.
>
>   Considering that -object is JSON-compatible so that defining lists via
>   JSON is more friendly, I implemented the caches list via -object and
>   linked it to MachineState:
>
>   -object '{"qom-type":"smp-cache","id":"obj","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"}]}'
>   -machine smp-caches=obj

This one wraps the same array of objects in a new user-creatable object,
then sets machine property "smp-caches" to that object.

We can set machine properties directly with -machine.  But -machine
doesn't support JSON, yet.

Wrapping in an object moves the configuration to -object, which does
support JSON.

Half way between 2nd and 3rd:

  * Cache list object in machine

    -machine caches.0.name=l1i,caches.0.topo=core,\
             caches.1.name=l1d,caches.1.topo=core

> * 4th: The per cache object without any list:
>
>   -object smp-cache,id=cache0,name=l1i,topo=core \
>   -object smp-cache,id=cache1,name=l1d,topo=core
>
>   This proposal is clearer, but there are a few opens:
>   - I plan to push qom-topo forward, which would abstract CPU related
>     topology levels and cache to "device" instead of object. Is there a
>     conflict here?

Can't say, since I don't understand where you want to go.

Looks like your trying to design an interface for what you want to do
now, and are wondering whether it could evolve to accomodate what you
want to do later.

It's often better to design the interface for everything you already
know you want to do, then take out the parts you want to do later.

>   - Multiple cache objects can't be linked to the machine on the command
>     line, so I maintain a static cache list in smp_cache.c and expose
>     the cache information to the machine through some interface. is this
>     way acceptable?
>
>
> In summary, the 4th proposal was the most up in the air, as it looked to
> be conflict with the hybrid topology I wanted to do (and while hybrid
> topology may not be accepted by the community either, I thought it would
> be best for the two work to be in the same direction).
>
> The difference between 2nd and 3rd is about the JSON requirement, if JSON
> is mandatory for now then it's 3rd, if it's not mandatory (or accept to
> make -machine/-smp support JSON in the future), 2nd looks cleaner, which
> puts the caches list in -smp.

I'd rather not let syntactic limitations of our CLI dictate the
structure of our configuration data.  Design the structure *first*.
Only then start to think about CLI.  Our CLI is an unholy mess, and
thinking about it too early risks getting lost in the weeds.  I fear
this is what happened to you.

If I forcibly ignore all the considerations related to concrete syntax
in your message, a structure seems to emerge: there's a set of caches
identified by name (l1i, l1d, ...), and for each cache, we have a number
of configurable properties (topology level, ...).  Makes sense?

What else will you need to configure in the future?

By the way, extending -machine to support JSON looks feasible to me at a
glance.


