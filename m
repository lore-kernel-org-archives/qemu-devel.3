Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B82DC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Wqd-0002Q7-1g; Mon, 13 May 2024 10:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6Wqb-0002Oo-Lg
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6WqR-0003fQ-7m
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715611202;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aof9HgaDlh9DOKll1Uc6cIXal37EWtrXuZX+nXDQTS4=;
 b=a7bWLfyqDWGnjEkkZaV/hOWeazxGEUK56VTPlcijfyDDYDVeqwqOQsTnpvT2cNN2g6RzZJ
 DNmj/ikpUzvxzx3k7Vj6+TX+f6JZSerz2oY4DPrDtyvG4wp0L5T3quMejRaySu8OyJKWv3
 k3l7JKyBlHVZASAKH41Na4RCI56RwlE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-IP3AFeumNfSXdqN_2WlMjA-1; Mon,
 13 May 2024 10:39:58 -0400
X-MC-Unique: IP3AFeumNfSXdqN_2WlMjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F20838135F6;
 Mon, 13 May 2024 14:39:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 432C92026D6E;
 Mon, 13 May 2024 14:39:56 +0000 (UTC)
Date: Mon, 13 May 2024 15:39:54 +0100
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
Message-ID: <ZkImOkl-HtsFMaAz@redhat.com>
References: <20240513123358.612355-1-berrange@redhat.com>
 <20240513123358.612355-2-berrange@redhat.com>
 <ZkIiHgw9rQActD2i@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkIiHgw9rQActD2i@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, May 13, 2024 at 10:22:22PM +0800, Zhao Liu wrote:
> Cc Paolo for x86 topology part
> 
> Hi Daniel,
> 
> On Mon, May 13, 2024 at 01:33:57PM +0100, Daniel P. Berrangé wrote:
> > Date: Mon, 13 May 2024 13:33:57 +0100
> > From: "Daniel P. Berrangé" <berrange@redhat.com>
> > Subject: [PATCH 1/2] hw/core: allow parameter=1 for SMP topology on any
> >  machine
> > 
> > This effectively reverts
> > 
> >   commit 54c4ea8f3ae614054079395842128a856a73dbf9
> >   Author: Zhao Liu <zhao1.liu@intel.com>
> >   Date:   Sat Mar 9 00:01:37 2024 +0800
> > 
> >     hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP configurations
> > 
> > but is not done as a 'git revert' since the part of the changes to the
> > file hw/core/machine-smp.c which add 'has_XXX' checks remain desirable.
> > Furthermore, we have to tweak the subsequently added unit test to
> > account for differing warning message.
> > 
> > The rationale for the original deprecation was:
> > 
> >   "Currently, it was allowed for users to specify the unsupported
> >    topology parameter as "1". For example, x86 PC machine doesn't
> >    support drawer/book/cluster topology levels, but user could specify
> >    "-smp drawers=1,books=1,clusters=1".
> > 
> >    This is meaningless and confusing, so that the support for this kind
> >    of configurations is marked deprecated since 9.0."
> > 
> > There are varying POVs on the topic of 'unsupported' topology levels.
> > 
> > It is common to say that on a system without hyperthreading, that there
> > is always 1 thread. Likewise when new CPUs introduced a concept of
> > multiple "dies', it was reasonable to say that all historical CPUs
> > before that implicitly had 1 'die'. Likewise for the more recently
> > introduced 'modules' and 'clusters' parameter'. From this POV, it is
> > valid to set 'parameter=1' on the -smp command line for any machine,
> > only a value > 1 is strictly an error condition.
> 
> Currently QEMU has become more and more difficult to maintain a general
> topology hierarchy, there are two recent examples:
> 
> 1. as you mentioned "module" v.s. "cluster", one reason for introducing
> "module" is because it is difficult to define what "cluster" is for x86,
> the cluster in the device tree can be nested, then it can correspond to
> an x86 die, or it can correspond to an x86 module. Therefore, specifying
> "clusters=1" for x86 is ambiguous.
> 
> 2. s390 introduces book and drawer, which are above socket/package
> level, but for x86, the level above the package names "cluster" (yeah,
> "cluster" again :-(). So if user sets "books=1" or "drawers=1" for x86,
> then it's meaningless. Similarly, "clusters=1" is also very confusing for
> x86 machine.
> 
> I think that only thread/core/socket are architecturally general, the
> other topology levels are hard to define across architectures, then
> allowing unsupported topology=1 is always confusing...
> 
> Moreover, QEMU currently requires a clear topology containment
> relationship when defining a topology, after which it will become
> increasingly difficult to define a generic topology containment
> relationship when new topology levels are introduced in the future...

I'm failing to see what real world technical problems QEMU faces
with a parameter being set to '1' by a mgmt app, when QEMU itself
treats all omitted values as being '1' anyway.

If we're trying to faithfully model the real world, then restricting
the topology against machine types though still looks inherantly wrong.
The valid topology ought to be constrained based on the named CPU model.
eg it doesn't make sense to allow 'dies=4' with a Skylake CPU model,
only an EPYC CPU model, especially if we want to model cache info in
a way that matches the real world silicon better.

> > It doesn't cause any functional difficulty for QEMU, because internally
> > the QEMU code is itself assuming that all "unsupported" parameters
> > implicitly have a value of '1'.
> > 
> > At the libvirt level, we've allowed applications to set 'parameter=1'
> > when configuring a guest, and pass that through to QEMU.
> > 
> > Deprecating this creates extra difficulty for because there's no info
> > exposed from QEMU about which machine types "support" which parameters.
> > Thus, libvirt can't know whether it is valid to pass 'parameter=1' for
> > a given machine type, or whether it will trigger deprecation messages.
> 
> I understand that libvirt is having trouble because there is no interface
> to expose which topology levels the current machine supports. As a
> workaround to eliminate the difficulties at the libvirt level, it's
> ok for me.
> 
> But I believe deprecating the unsupported topology is necessary, so do
> you think it's acceptable to include an interface to expose the supported
> topology if it's going to be deprecated again later?

As above, I think that restrictions based on machine type, while nice and
simple, are incorrect long term. If we did impose restrictions based on
CPU model, then we could trivially expose this info to mgmt apps via the
existing mechanism for querying supported CPU models. Limiting based on
CPU model, however, has potentially greater back compat issues, though
it would be strictly more faithful to hardware.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


