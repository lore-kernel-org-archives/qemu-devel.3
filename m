Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D948C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7I65-0007LX-Db; Wed, 15 May 2024 13:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7I63-0007L0-Ds
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7I60-0000Oh-W0
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715792836;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vPdORdygyTpTWXX7cp1qjSAHF7j2hu4q9NSVKpuJ2QY=;
 b=Lb5uph4fl4ITi3rplss3nq0/kANj6D+Z3vCBv+7Z5g9vP+i26OOaeR5hqOb7Dd69P0fIQX
 50e9r2uD4LqPtqFN09jaU11zwoLxFkZ4I5LmKgHRKS2sl3bfTpysbhEwOCFugARIAZSjt/
 7+D71NT9N+5NzTQpvFXtiAa/VrsyDK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-9elnMeoXN86jsJ_6_lzfGg-1; Wed, 15 May 2024 13:07:12 -0400
X-MC-Unique: 9elnMeoXN86jsJ_6_lzfGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C555D800074;
 Wed, 15 May 2024 17:07:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E25D11C00A8F;
 Wed, 15 May 2024 17:07:09 +0000 (UTC)
Date: Wed, 15 May 2024 18:06:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Krempa <pkrempa@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] hw/core: allow parameter=1 for SMP topology on any
 machine
Message-ID: <ZkTrsDdyGRFzVULG@redhat.com>
References: <20240513123358.612355-1-berrange@redhat.com>
 <20240513123358.612355-2-berrange@redhat.com>
 <ZkIiHgw9rQActD2i@intel.com> <ZkImOkl-HtsFMaAz@redhat.com>
 <ZkLfVB/1arSlAptC@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkLfVB/1arSlAptC@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 14, 2024 at 11:49:40AM +0800, Zhao Liu wrote:
> > I'm failing to see what real world technical problems QEMU faces
> > with a parameter being set to '1' by a mgmt app, when QEMU itself
> > treats all omitted values as being '1' anyway.
> > 
> > If we're trying to faithfully model the real world, then restricting
> > the topology against machine types though still looks inherantly wrong.
> > The valid topology ought to be constrained based on the named CPU model.
> > eg it doesn't make sense to allow 'dies=4' with a Skylake CPU model,
> > only an EPYC CPU model, especially if we want to model cache info in
> > a way that matches the real world silicon better.
> 
> Thanks for figuring out this. This issue is related with Intel CPU
> cache model: currently Intel code defaults L3 shared at die level.
> This could be resolved by defining the accurate default cache topology
> level for CPU model and make Intel CPU models share L3 at package level
> except only Cascadelake.
> 
> Then user could define any other topology levels (die/module) for
> Icelake and this won't change the cache topology, unless the user adds
> more sockets or further customizes the cache topology in another way [1].
> Do you agree with this solution?

Broadly speaking yes. Historically we have created trouble for
ourselves (and or our users) by allowing creation of "wierd"
guest CPU models, which don't resemble those which can be found
in real world silicon. Problems specifically have been around
unsual combinations of CPUID features eg user enabled X, but not Y,
where real silicon always has X + Y enabled, and guest OS assumed
this is always the case.

So if our named CPU models can more faithfully match what you might
see in terms of cache topology in the real world, that's likely to
be a good thing.

> > As above, I think that restrictions based on machine type, while nice and
> > simple, are incorrect long term. If we did impose restrictions based on
> > CPU model, then we could trivially expose this info to mgmt apps via the
> > existing mechanism for querying supported CPU models. Limiting based on
> > CPU model, however, has potentially greater back compat issues, though
> > it would be strictly more faithful to hardware.
> 
> I think as long as the default cache topology model is clearly defined,
> users can further customize the CPU topology and adjust the cache
> topology based on it. After all, topology is architectural, not CPU
> model-specific (linux support for topology does not take into account
> specific CPU models).
> 
> For example, x86, for simplicity, can we assume that all x86 CPU models
> support all x86 topology levels (thread/core/module/die/package) without
> making distinctions based on specific CPU models?

Hmm, true, if we have direct control over cache topology, the
CPU topology is less critical. I'd still be wary of suggesting
it is a good idea to use CPU topology configs that don't reflect
something the CPU vendor has concievably used in real silicon.

> That way as long as the user doesn't change the default topology, then
> Guest's cache and other topology information won't be "corrupted".

> And there's one more question, does this rollback mean that smp's
> parameters must have compatible default values for all architectures?

Historically we preferred "sockets", when filling missing topology,
then more recently we switched to prefer "cores", since high core
counts are generally more common in real world than high socket
counts.

In theory at some point, one might want to fill in 'dies > 0' for
EPYC, or 'modules > 0' for appropriate Intel CPU models, but doing
the reverse while theoretically valid, would be wierd as no such
topology would exist in real silicon.

Ultimately if you're allowing QEMU guest vCPUs threads to float
freely across host CPUs, there is little point in setting dies/
modules/threads to a value other than 1, because the guest OS
won't benefit from understanding cache differences for dies/
modules/threads/etc, if the vCPU can be moved between host CPUs
at any time by the host OS scheduler.

Fine grained control over dies/modules/threads only makes more
sense if you have strictly pinning vCPU threads 1:1 to host CPUs

IOW, simply preferring "cores" for everything is a reasonable
default long term plan for everything, unless the specific
architecture target has no concept of "cores".

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


