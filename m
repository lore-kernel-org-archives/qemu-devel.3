Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34FCD2AB1B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 10:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5jh0-0007zO-Jr; Tue, 29 Oct 2024 06:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5jgy-0007yw-NS
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 06:43:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5jgu-0005iR-Db
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 06:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730198590;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ortyQ82awpGNF/5ch39Tufg7eZbIlHNqQW0/rQ4NCE0=;
 b=PlaCzLG7IleW9XcPv80WtlqkZCou7mplBMMWl0i43VTdk5eQbNBa7KEYKf+0MEufGg6wam
 VZNg+0BvBgrODuiQbrzlIbRJQP0asIUsCy3MBvpnhm31SppErleKaPtkc33WPFgSO3WT0H
 pDpFHPwK8bgslN5ZOU4KOxH8RaEnnEs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-6PzBKahBPqOIE8zu6lV92w-1; Tue,
 29 Oct 2024 06:43:09 -0400
X-MC-Unique: 6PzBKahBPqOIE8zu6lV92w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDD341956088; Tue, 29 Oct 2024 10:43:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DD75300018D; Tue, 29 Oct 2024 10:43:01 +0000 (UTC)
Date: Tue, 29 Oct 2024 10:42:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/4] QOM: Singleton interface
Message-ID: <ZyC8MmM7k6df2Awi@redhat.com>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <87h690my2w.fsf@pond.sub.org> <Zxuy5CjKNlK49TUL@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zxuy5CjKNlK49TUL@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 25, 2024 at 11:01:56AM -0400, Peter Xu wrote:
> On Fri, Oct 25, 2024 at 09:38:31AM +0200, Markus Armbruster wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > This patchset introduces the singleton interface for QOM.
> > >
> > > The singleton interface is as simple as "this class can only create one
> > > instance".
> > >
> > > We used to have similar demand when working on all kinds of vIOMMUs,
> > > because in most cases that I am aware of, vIOMMU must be a singleton as
> > > it's closely bound to the machine and also the root PCIe systems.  We used
> > > to have a bunch of special code guarding those, for example, X86 has
> > > pc_machine_device_pre_plug_cb() just to detect when vIOMMU is created more
> > > than once.
> > >
> > > There is a similar demand raising recently (even if the problem existed
> > > over years) when we were looking at a migration bug, that part of it was
> > > involved with the current_migration global pointer being referenced
> > > anywhere, even after the migration object was finalize()ed.  So far without
> > > singleton support, there's no way to reset the variable properly.
> > > Declaring migration object to be a singleton also just makes sense, e.g.,
> > > dynamically creating migration objects on the fly with QMP commands doesn't
> > > sound right..
> > >
> > > The idea behind is pretty simple: any object that can only be created once
> > > can now declare the TYPE_SINGLETON interface, then QOM facilities will make
> > > sure it won't be created more than once.  For example, qom-list-properties,
> > > device-list-properties, etc., will be smart enough to not try to create
> > > temporary singleton objects now.
> > 
> > QOM design assumption: object_new() followed by object_unref() is always
> > possible and has no side effect.
> 
> I see.
> 
> > 
> > QOM introspection relies on this.  Your PATCH 1 makes non-class
> > properties of singletons invisible in introspection.  Making something
> > with such properties a singleton would be a regression.
> > 
> > Anything that violates the design assumption must be delayed to a
> > suitable state transition.  For devices (subtypes of TYPE_DEVICE), this
> > is ->realize().  For user-creatable objects (provide interface
> > TYPE_USER_CREATABLE), this is ->complete().  For anything else, it's
> > something else that probably doesn't even exist, yet.  See "Problem 5:
> > QOM lacks a clear life cycle" in
> > 
> >     Subject: Dynamic & heterogeneous machines, initial configuration: problems
> >     Date: Wed, 31 Jan 2024 21:14:21 +0100
> >     Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
> >     https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
> 
> The major challenge here might be that, in migration's use case we want to
> do something after the last refcount is released.

This is rather a strange idea, and feels back to front. An object's last
refcount must never be released until code has entirely finished using
the object.

> IOW, I don't yet see an easy way to explicit do qdev_unrealize() (even if
> migration object will use realize(), while it doesn't yet..), because there
> can be more than one thread holding refcount of the object, and we don't
> know where to invoke it, and we don't want to do the cleanup if the other
> one still holds a refcount.

This sounds like the code is missing some synchronization mechanism
beween the threads, which need to communicate with each other when
they are "done", so that the "primary" thread can then finally
release any resources.

> Maybe I can also try do that with a "magic property" with its set/get, as
> that's indeed the other hook (basically, object_property_del_all()) that is
> only invoked after the final refcount is released.  However I think we
> still need the singleton idea somehow..

Based on the description above it feels like the problem is outside
of QOM, around the lack of synchronization across threads.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


