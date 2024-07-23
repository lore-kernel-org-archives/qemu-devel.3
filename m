Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DE1C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCXg-0008Uq-LR; Tue, 23 Jul 2024 06:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWCXc-0008M1-G6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWCXa-0000dY-Oy
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721729682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u1Ky8nShwUmqI5mAf40wP6UVa7xKKOXsCs1JoLQsga0=;
 b=TydK2x7y7eMOTj6e2GrDv3W+9KH6Hizp02tUm0q9+eBcq3rPt9r9zHssnGkqrebtOWY9jM
 ncZvQNlXdnRfaUSPJWCyjt2uh4Hhhoag1C6O5PkqFtzx7uDy8XRNHyd7pk7cOaA7IdCm5I
 eOkN0rUKeKRL4P67Ivxetcur3RJ7dVk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-oacb-EhlMuG1IpFQzC6EFg-1; Tue,
 23 Jul 2024 06:14:37 -0400
X-MC-Unique: oacb-EhlMuG1IpFQzC6EFg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BD0D1955F43; Tue, 23 Jul 2024 10:14:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B272D3000192; Tue, 23 Jul 2024 10:14:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9E80221E6682; Tue, 23 Jul 2024 12:14:30 +0200 (CEST)
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
Subject: Re: [PATCH 1/8] hw/core: Make CPU topology enumeration arch-agnostic
In-Reply-To: <Zp5mRrjuZWnE+9gz@intel.com> (Zhao Liu's message of "Mon, 22 Jul
 2024 22:01:42 +0800")
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-2-zhao1.liu@intel.com>
 <875xsx4l13.fsf@pond.sub.org> <Zp5mRrjuZWnE+9gz@intel.com>
Date: Tue, 23 Jul 2024 12:14:30 +0200
Message-ID: <87ed7kwh2x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Hi Markus,
>
> On Mon, Jul 22, 2024 at 03:24:24PM +0200, Markus Armbruster wrote:
>> Date: Mon, 22 Jul 2024 15:24:24 +0200
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [PATCH 1/8] hw/core: Make CPU topology enumeration
>>  arch-agnostic
>> 
>> One little thing...
>> 
>> Zhao Liu <zhao1.liu@intel.com> writes:
>> 
>> > Cache topology needs to be defined based on CPU topology levels. Thus,
>> > define CPU topology enumeration in qapi/machine.json to make it generic
>> > for all architectures.
>> >
>> > To match the general topology naming style, rename CPU_TOPO_LEVEL_SMT
>> > and CPU_TOPO_LEVEL_PACKAGE to CPU_TOPO_LEVEL_THREAD and
>> > CPU_TOPO_LEVEL_SOCKET.
>> >
>> > Also, enumerate additional topology levels for non-i386 arches, and add
>> > a CPU_TOPO_LEVEL_DEFAULT to help future smp-cache object de-compatibilize
>> > arch-specific cache topology settings.
>> >
>> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> 
>> [...]
>> 
>> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
>> > index fa6bd71d1280..82413c668bdb 100644
>> > --- a/qapi/machine-common.json
>> > +++ b/qapi/machine-common.json
>> > @@ -5,7 +5,7 @@
>> >  # See the COPYING file in the top-level directory.
>> >  
>> >  ##
>> > -# = Machines S390 data types
>> > +# = Common machine types
>> >  ##
>> >  
>> >  ##
>> > @@ -19,3 +19,48 @@
>> >  { 'enum': 'CpuS390Entitlement',
>> >    'prefix': 'S390_CPU_ENTITLEMENT',
>> >    'data': [ 'auto', 'low', 'medium', 'high' ] }
>> > +
>> > +##
>> > +# @CpuTopologyLevel:
>> > +#
>> > +# An enumeration of CPU topology levels.
>> > +#
>> > +# @invalid: Invalid topology level.
>> > +#
>> > +# @thread: thread level, which would also be called SMT level or
>> > +#     logical processor level.  The @threads option in
>> > +#     SMPConfiguration is used to configure the topology of this
>> > +#     level.
>> > +#
>> > +# @core: core level.  The @cores option in SMPConfiguration is used
>> > +#     to configure the topology of this level.
>> > +#
>> > +# @module: module level.  The @modules option in SMPConfiguration is
>> > +#     used to configure the topology of this level.
>> > +#
>> > +# @cluster: cluster level.  The @clusters option in SMPConfiguration
>> > +#     is used to configure the topology of this level.
>> > +#
>> > +# @die: die level.  The @dies option in SMPConfiguration is used to
>> > +#     configure the topology of this level.
>> > +#
>> > +# @socket: socket level, which would also be called package level.
>> > +#     The @sockets option in SMPConfiguration is used to configure
>> > +#     the topology of this level.
>> > +#
>> > +# @book: book level.  The @books option in SMPConfiguration is used
>> > +#     to configure the topology of this level.
>> > +#
>> > +# @drawer: drawer level.  The @drawers option in SMPConfiguration is
>> > +#     used to configure the topology of this level.
>> > +#
>> > +# @default: default level.  Some architectures will have default
>> > +#     topology settings (e.g., cache topology), and this special
>> > +#     level means following the architecture-specific settings.
>> > +#
>> > +# Since: 9.1
>> > +##
>> > +{ 'enum': 'CpuTopologyLevel',
>> > +  'prefix': 'CPU_TOPO_LEVEL',
>> 
>> Why set a 'prefix'?
>> 
>
> Because my previous i386 commit 6ddeb0ec8c29 ("i386/cpu: Introduce bitmap
> to cache available CPU topology levels") introduced the level
> enumeration with such prefix. For naming consistency, and to shorten the
> length of the name, I've used the same prefix here as well.
>
> I've sensed that you don't like the TOPO abbreviation and I'll remove the
> prefix :-).

Consistency is good, but I'd rather achieve it by consistently using
"topology".

I never liked the 'prefix' feature much.  We have it because the mapping
from camel case to upper case with underscores is heuristical, and can
result in something undesirable.  See commit 351d36e454c (qapi: allow
override of default enum prefix naming).  Using it just to shorten
generated identifiers is a bad idea.


