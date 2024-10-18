Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D10D2127B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 07:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1hsQ-0007ry-15; Fri, 18 Oct 2024 03:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1hsO-0007r0-Hn
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1hsM-0006he-LM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729238302;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DTTMNicW4OjRcXbKL4oqTcLX63sd7nExpwbEaCF2IcE=;
 b=QAHj+T4p5dP6m0mDAZVMYrlqvGXm2BuBeIn5o9q6w26Mw+FOMitbWnnDeavn+WflBuIt48
 NHSWMt7AQ2mS+8uawEQXDmC/5tWZhLxUFjnjO7eeMKRaRX7J/eviRL8lNSvAsg2l9Qb/K6
 xozmLET0MjXIzNoe6GffuhKyWrZkCIY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-7mvuoKwiMHmr0nwGMQ75mg-1; Fri,
 18 Oct 2024 03:58:18 -0400
X-MC-Unique: 7mvuoKwiMHmr0nwGMQ75mg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 253291954227; Fri, 18 Oct 2024 07:58:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EABD19560A3; Fri, 18 Oct 2024 07:58:06 +0000 (UTC)
Date: Fri, 18 Oct 2024 08:58:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
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
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v3 6/7] i386/pc: Support cache topology in -machine for
 PC machine
Message-ID: <ZxIVC-XQaMqOy6Fw@redhat.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
 <20241012104429.1048908-7-zhao1.liu@intel.com>
 <ZxEs3DGGgCqGT5yK@redhat.com> <ZxHcsPyqT6MLJ9hG@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxHcsPyqT6MLJ9hG@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 18, 2024 at 11:57:36AM +0800, Zhao Liu wrote:
> Hi Daniel,
> 
> > > +    ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
> > > +        Define cache properties for SMP system.
> > > +
> > > +        ``cache=cachename`` specifies the cache that the properties will be
> > > +        applied on. This field is the combination of cache level and cache
> > > +        type. It supports ``l1d`` (L1 data cache), ``l1i`` (L1 instruction
> > > +        cache), ``l2`` (L2 unified cache) and ``l3`` (L3 unified cache).
> > > +
> > > +        ``topology=topologylevel`` sets the cache topology level. It accepts
> > > +        CPU topology levels including ``thread``, ``core``, ``module``,
> > > +        ``cluster``, ``die``, ``socket``, ``book``, ``drawer`` and a special
> > > +        value ``default``. If ``default`` is set, then the cache topology will
> > > +        follow the architecture's default cache topology model. If another
> > > +        topology level is set, the cache will be shared at corresponding CPU
> > > +        topology level. For example, ``topology=core`` makes the cache shared
> > > +        by all threads within a core.
> > > +
> > > +        Example:
> > > +
> > > +        ::
> > > +
> > > +            -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
> > 
> > There are 4 cache types, l1d, l1i, l2, l3.
> > 
> > In this example you've only set properties for l1d, l1i caches.
> > 
> > What does this mean for l2 / l3 caches ?
> 
> Omitting "cache" will default to using the "default" level.
> 
> I think I should add the above description to the documentation.
> 
> > Are they reported as not existing, or are they to be reported at
> > some built-in default topology level.
> 
> It's the latter.
> 
> If a machine doesn't support l2/l3, then QEMU will also report the error
> like:
> 
> qemu-system-*: l2 cache topology not supported by this machine

Ok, that's good.

> > If the latter, how does the user know what that built-in default is, 
> 
> Currently, the default cache model for x86 is L1 per core, L2 per core,
> and L3 per die. Similar to the topology levels, there is still no way to
> expose this to users. I can descript default cache model in doc.
> 
> But I feel like we're back to the situation we discussed earlier:
> "default" CPU topology support should be related to the CPU model, but
> in practice, QEMU supports it at the machine level. The cache topology
> depends on CPU topology support and can only continue to be added on top
> of the machine.
> 
> So do you think we can add topology and cache information in CpuModelInfo
> so that query-cpu-model-expansion can expose default CPU/cache topology
> information to users?
> 
> This way, users can customize CPU/cache topology in -smp and
> -machine smp-cache. Although the QMP command is targeted at the CPU model
> while our CLI is at the machine level, at least we can expose the
> information to users.
> 
> If you agree to expose the default topology/cache info in
> query-cpu-model-expansion, can I work on this in a separate series? :)

Yeah, lets worry about that another day.

It it sufficient to just encourage users to always specify
the full set of caches.

> > Can we explicitly disable a l2/l3 cache, or must it always exists ?
> 
> Now we can't disable it through -machine smp-cache (while x86 CPU support
> l3-cache=off), but as you mentioned, I can try using "invalid" to support
> this scenario, which would be more general. Similarly, if you agree, I
> can also add this support in a separate series.

If we decide to offer a way to disable caches, probably better to have
a name like 'disabled' for such a setting, and yes, we don't need todo
that now.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


