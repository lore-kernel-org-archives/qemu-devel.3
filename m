Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637EBC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQWv-0004Mb-3o; Tue, 04 Jun 2024 05:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEQWt-0004M8-OV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEQWq-00088h-Tf
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717493547;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Kj3Af50YVLKSXNM5eVa3oxycaL5wmFR39UMS4qGQoVk=;
 b=GFsW/UnrCfXeEgWUHsftcFziRAJkZIjppC3D6n5V/4CVUhmyLEb+TV1Lyylb+KzmLbSWaj
 MYiRaw31T9sr39tU79X808rraiwlhnXr66tI2KX/qERPoc2b8118Gr2vzVyfwzaMCRydpv
 UK+f/hYeaNR23dFlU8NzN4eyPOrdedc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-CB9fc94iPDG0jTlRbq3LXQ-1; Tue,
 04 Jun 2024 05:32:20 -0400
X-MC-Unique: CB9fc94iPDG0jTlRbq3LXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9057B29AB3E0;
 Tue,  4 Jun 2024 09:32:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C559320230B7;
 Tue,  4 Jun 2024 09:32:16 +0000 (UTC)
Date: Tue, 4 Jun 2024 10:32:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [RFC v2 3/7] hw/core: Add cache topology options in -smp
Message-ID: <Zl7fHop_GaiJt6AE@redhat.com>
References: <20240530101539.768484-1-zhao1.liu@intel.com>
 <20240530101539.768484-4-zhao1.liu@intel.com>
 <87sext9jfo.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sext9jfo.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 04, 2024 at 10:54:51AM +0200, Markus Armbruster wrote:
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Add "l1d-cache", "l1i-cache". "l2-cache", and "l3-cache" options in
> > -smp to define the cache topology for SMP system.
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> [...]
> 
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 7ac5a05bb9c9..8fa5af69b1bf 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1746,6 +1746,23 @@
> >  #
> >  # @threads: number of threads per core
> >  #
> > +# @l1d-cache: topology hierarchy of L1 data cache. It accepts the CPU
> > +#     topology enumeration as the parameter, i.e., CPUs in the same
> > +#     topology container share the same L1 data cache. (since 9.1)
> > +#
> > +# @l1i-cache: topology hierarchy of L1 instruction cache. It accepts
> > +#     the CPU topology enumeration as the parameter, i.e., CPUs in the
> > +#     same topology container share the same L1 instruction cache.
> > +#     (since 9.1)
> > +#
> > +# @l2-cache: topology hierarchy of L2 unified cache. It accepts the CPU
> > +#     topology enumeration as the parameter, i.e., CPUs in the same
> > +#     topology container share the same L2 unified cache. (since 9.1)
> > +#
> > +# @l3-cache: topology hierarchy of L3 unified cache. It accepts the CPU
> > +#     topology enumeration as the parameter, i.e., CPUs in the same
> > +#     topology container share the same L3 unified cache. (since 9.1)
> > +#
> >  # Since: 6.1
> >  ##
> 
> The new members are all optional.  What does "absent" mean?  No such
> cache?  Some default topology?
> 
> Is this sufficiently general?  Do all machines of interest have a split
> level 1 cache, a level 2 cache, and a level 3 cache?

Level 4 cache is apparently a thing

https://www.guru3d.com/story/intel-confirms-l4-cache-in-upcoming-meteor-lake-cpus/

but given that any new cache levels will require new code in QEMU to
wire up, its not a big deal to add new properties at the same time.

That said see my reply just now to the cover letter, where I suggest
we should have a "caches" property that takes an array of cache
info objects.

> 
> Is the CPU topology level the only cache property we'll want to
> configure here?  If the answer isn't "yes", then we should perhaps wrap
> it in an object, so we can easily add more members later.

Cache size is a piece of info I could see us wanting to express

> Two spaces between sentences for consistency, please.
> 
> >  { 'struct': 'SMPConfiguration', 'data': {
> > @@ -1758,7 +1775,11 @@
> >       '*modules': 'int',
> >       '*cores': 'int',
> >       '*threads': 'int',
> > -     '*maxcpus': 'int' } }
> > +     '*maxcpus': 'int',
> > +     '*l1d-cache': 'CPUTopoLevel',
> > +     '*l1i-cache': 'CPUTopoLevel',
> > +     '*l2-cache': 'CPUTopoLevel',
> > +     '*l3-cache': 'CPUTopoLevel' } }
> >  
> >  ##
> >  # @x-query-irq:
> > diff --git a/system/vl.c b/system/vl.c
> 
> [...]
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


