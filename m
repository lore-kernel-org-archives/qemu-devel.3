Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546A0C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQTz-0002aG-A7; Tue, 04 Jun 2024 05:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEQTy-0002Zm-6N
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEQTv-0007Pe-VR
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717493367;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZ6BR7ZP0R1ebLkNmGoehN6rlFVKuR/AxIITl0TNwfA=;
 b=HOIfiExZZRumP83NUmsOGp0r7NY64p08I6RLs9FUHJxn38mLjEcQAcno5b+4iQtaTfxicY
 sQqECf6QOTJ4EPmhN3JJpU1X/JJfpKYBT1U/k+M25xqiNfo5LCruDPtsOJ/sW+Psifn3Q2
 8Quyv7VclqYqiD58k/juM5VubaHEYxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-ryezyYoeOaegVds3xkxEaw-1; Tue, 04 Jun 2024 05:29:21 -0400
X-MC-Unique: ryezyYoeOaegVds3xkxEaw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCF16803C81;
 Tue,  4 Jun 2024 09:29:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25571492BCD;
 Tue,  4 Jun 2024 09:29:17 +0000 (UTC)
Date: Tue, 4 Jun 2024 10:29:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [RFC v2 0/7] Introduce SMP Cache Topology
Message-ID: <Zl7ea2o2aaxXMj9X@redhat.com>
References: <20240530101539.768484-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240530101539.768484-1-zhao1.liu@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

On Thu, May 30, 2024 at 06:15:32PM +0800, Zhao Liu wrote:
> Hi,
> 
> Now that the i386 cache model has been able to define the topology
> clearly, it's time to move on to discussing/advancing this feature about
> configuring the cache topology with -smp as the following example:
> 
> -smp 32,sockets=2,dies=2,modules=2,cores=2,threads=2,maxcpus=32,\
>      l1d-cache=core,l1i-cache=core,l2-cache=core,l3-cache=die
> 
> With the new cache topology options ("l1d-cache", "l1i-cache",
> "l2-cache" and "l3-cache"), we could adjust the cache topology via -smp.

Switching to QAPI for a second, your proposal is effectively

    { 'enum': 'SMPCacheTopo',
      'data': [ 'default','socket','die','cluster','module','core','thread'] }

   { 'struct': 'SMPConfiguration',
     'data': {
       '*cpus': 'int',
       '*drawers': 'int',
       '*books': 'int',
       '*sockets': 'int',
       '*dies': 'int',
       '*clusters': 'int',
       '*modules': 'int',
       '*cores': 'int',
       '*threads': 'int',
       '*maxcpus': 'int',
       '*l1d-cache': 'SMPCacheTopo',
       '*l1i-cache': 'SMPCacheTopo',
       '*l2-cache': 'SMPCacheTopo',
       '*l3-cache': 'SMPCacheTopo',
     } }

I think that would be more natural to express as an array of structs
thus:

    { 'enum': 'SMPCacheTopo',
      'data': [ 'default','socket','die','cluster','module','core','thread'] }

    { 'enum': 'SMPCacheType',
      'data': [ 'l1d', 'l1i', 'l2', 'l3' ] }
     
    { 'struct': 'SMPCache',
      'data': {
        'type': 'SMPCacheType',
        'topo': 'SMPCacheTopo',
      } }

   { 'struct': 'SMPConfiguration',
     'data': {
       '*cpus': 'int',
       '*drawers': 'int',
       '*books': 'int',
       '*sockets': 'int',
       '*dies': 'int',
       '*clusters': 'int',
       '*modules': 'int',
       '*cores': 'int',
       '*threads': 'int',
       '*maxcpus': 'int',
       'caches': [ 'SMPCache' ]
     } }

Giving an example in (hypothetical) JSON cli syntax of:

  -smp  "{'cpus':32,'sockets':2,'dies':2,'modules':2,
          'cores':2,'threads':2,'maxcpus':32,'caches': [
	    {'type':'l1d','topo':'core' },
	    {'type':'l1i','topo':'core' },
	    {'type':'l2','topo':'core' },
	    {'type':'l3','topo':'die' },
	  ]}"


> Open about How to Handle the Default Options
> ============================================
> 
> (For the detailed description of this series, pls skip this "long"
> section and review the subsequent content.)
> 
> 
> Background of OPEN
> ------------------
> 
> Daniel and I discussed initial thoughts on cache topology, and there was
> an idea that the default *cache_topo is on the CORE level [3]:
> 
> > simply preferring "cores" for everything is a reasonable
> > default long term plan for everything, unless the specific
> > architecture target has no concept of "cores".

FYI, when I wrote that I wasn't specifically thinking about cache
mappings. I just meant that when exposing SMP topology to guests,
'cores' is a good default, compared to 'sockets', or 'threads',etc.

Defaults for cache <-> topology  mappings should be whatever makes
most sense to the architecture target/cpu.

> Problem with this OPEN
> ----------------------
> 
> Some arches have their own arch-specific cache topology, such as l1 per
> core/l2 per core/l3 per die for i386. And as Jeehang proposed for
> RISC-V, the cache topologies are like: l1/l2 per core and l3 per
> cluster. 
> 
> Taking L3 as an example, logically there is a difference between the two
> starting points of user-specified core level and with the default core
> level.
> 
> For example,
> 
> "(user-specified) l3-cache-topo=core" should override i386's default l3
> per core, but i386's default l3 per core should also override
> "(default) l3-cache-topo=core" because this default value is like a
> placeholder that specifies nothing.
> 
> However, from a command line parsing perspective, it's impossible to
> tell what the “l3-cache-topo=core” setting is for...

Yes, we need to explicitly distinguish built-in defaults from
user specified data, otherwise we risk too many mistakes.

> Options to solve OPEN
> ---------------------
> 
> So, I think we have the following options:
> 
> 
> 1. Can we avoid such default parameters?
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This would reduce the pain in QEMU, but I'm not sure if it's possible to
> make libvirt happy?

I think having an explicit "defualt" value is inevitable, not simply
because of libvirt. Long experiance with QEMU shows that we need to
be able to reliably distinguish direct user input from  built-in
defaults in cases like this.

> 
> It is also possible to expose Cache topology information as the CPU
> properties in “query-cpu-model-expansion type=full”, but that adds
> arch-specific work.
> 
> If omitted, I think it's just like omitting “cores”/“sockets”,
> leaving it up to the machine to decide based on the specific CPU model
> (and now the cache topology is indeed determined by the CPU model as
> well).
> 
> 
> 2. If default is required, can we use a specific abstract word?
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> That is, is it possible to use a specific word like “auto”/“invalid”
> /“default” and avoid a specific topology level?

"invalid" feels a bit wierd, but 'auto' or 'default' are fine,
and possibly "unspecified"

> Like setting “l3-cache-topo=invalid” (since I've only added the invalid
> hierarchy so far ;-) ).
> 
> I found the cache topology of arches varies so much that I'm sorry to
> say it's hard to have a uniform default cache topology.
> 
> 
> I apologize for the very lengthy note and appreciate you reviewing it
> here as well as your time!

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


