Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9437D3A670
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 17:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5pem-0001pp-SI; Tue, 29 Oct 2024 13:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5pef-0001nQ-AQ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5peb-0004ic-1m
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730221511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldKlKT6hVSodbspQyiCFNWAOi6js2vOE0FGVH3lvyS4=;
 b=ISYYinZMpBoVeRfvMJQgETdatiAEXavmqLTy1XD9+G3cjOrqkLMMkpmqs+k91511Dp5dGU
 e1FTQkPSrzB6lxn+SihvI9Tdu4SH0am04Dq14y27KCGoZR6jCoGSON6HFILzQXe/moUDI3
 kWsCSbKBcdEQu9NpDCXlExt2nj/35cw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-SX2sxZ-pPNS4WdaxFcL4QA-1; Tue, 29 Oct 2024 13:05:09 -0400
X-MC-Unique: SX2sxZ-pPNS4WdaxFcL4QA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b1581d41dcso965946985a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 10:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730221509; x=1730826309;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ldKlKT6hVSodbspQyiCFNWAOi6js2vOE0FGVH3lvyS4=;
 b=qOhlZe4O7CzWPVysNcAeY53Hbjmc8DeiMJakgyjB5YB3veLJ4y4ZnHENBB+SQOfrkw
 eWpX7UaQeeZPuwOhp/DewvxsZy2AYcmo0ekoz94Vgntz+GpsWlwgYTIAQLUtTy9gbE9l
 R9g05iNb+22ObJTmmNAYzQLr3VJChu9d/zP1/1JZmbQVTRyTLmAqD/4QyZmykXV4zyBq
 80v9uqmk6Egf6fut7tX5GgJ5PdTZqv2pap0lu2LR05Ktjc7SwW14qh0BQeLgjE9xW9hO
 FNzgm6XA9P7Xld7Tx3bXrt5dPLFSLvD4pIn0KF8NdKijRQfNgWzgvspJIeMXVellZQ9D
 LpMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGSQ+WIDh1fzpqi8F8Cd/VwlEv6YXdUGPMmIG/1MIsdBvmXVn1TPdRZqH9HNUpgPM18z5Nr2lSPhoJ@nongnu.org
X-Gm-Message-State: AOJu0Yz/zXZB3UpxT4KxdD4M8YPjwyjnTT+rb5wRc+3rnQuA7eRWxXl8
 WeOOpPo/7ZehcFJOkZoSHjw7SOnDBlDF/dWe7B46gFp2H2BT5QhZcOn9XP/xMGb3LuJZj9HovYk
 rutB12d2IZ1eJ9X6TJyCQuwWoXHvaCOBP/d4vejrCbBSYa6VX2zjR
X-Received: by 2002:a05:622a:1490:b0:45e:f2df:2ed3 with SMTP id
 d75a77b69052e-4613c047c88mr151298891cf.32.1730221507391; 
 Tue, 29 Oct 2024 10:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0be638M+h/soBygwL94yEZeQd0wFJ/KeKrLWgNq50bELfflDLfdPuZwnucFfMw5cFb6IVSA==
X-Received: by 2002:a05:622a:1490:b0:45e:f2df:2ed3 with SMTP id
 d75a77b69052e-4613c047c88mr151298161cf.32.1730221506726; 
 Tue, 29 Oct 2024 10:05:06 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132119fd6sm46363941cf.4.2024.10.29.10.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 10:05:06 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:05:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
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
Message-ID: <ZyEVwFaTbqtw2Vx6@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <87h690my2w.fsf@pond.sub.org> <Zxuy5CjKNlK49TUL@x1n>
 <ZyC8MmM7k6df2Awi@redhat.com> <ZyD1BarDJUSA7Nen@x1n>
 <ZyEHoj3Mrm3OGtnX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyEHoj3Mrm3OGtnX@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 29, 2024 at 04:04:50PM +0000, Daniel P. Berrangé wrote:
> On Tue, Oct 29, 2024 at 10:45:25AM -0400, Peter Xu wrote:
> > On Tue, Oct 29, 2024 at 10:42:58AM +0000, Daniel P. Berrangé wrote:
> > > On Fri, Oct 25, 2024 at 11:01:56AM -0400, Peter Xu wrote:
> > > > On Fri, Oct 25, 2024 at 09:38:31AM +0200, Markus Armbruster wrote:
> > > > > Peter Xu <peterx@redhat.com> writes:
> > > > > 
> > > > > > This patchset introduces the singleton interface for QOM.
> > > > > >
> > > > > > The singleton interface is as simple as "this class can only create one
> > > > > > instance".
> > > > > >
> > > > > > We used to have similar demand when working on all kinds of vIOMMUs,
> > > > > > because in most cases that I am aware of, vIOMMU must be a singleton as
> > > > > > it's closely bound to the machine and also the root PCIe systems.  We used
> > > > > > to have a bunch of special code guarding those, for example, X86 has
> > > > > > pc_machine_device_pre_plug_cb() just to detect when vIOMMU is created more
> > > > > > than once.
> > > > > >
> > > > > > There is a similar demand raising recently (even if the problem existed
> > > > > > over years) when we were looking at a migration bug, that part of it was
> > > > > > involved with the current_migration global pointer being referenced
> > > > > > anywhere, even after the migration object was finalize()ed.  So far without
> > > > > > singleton support, there's no way to reset the variable properly.
> > > > > > Declaring migration object to be a singleton also just makes sense, e.g.,
> > > > > > dynamically creating migration objects on the fly with QMP commands doesn't
> > > > > > sound right..
> > > > > >
> > > > > > The idea behind is pretty simple: any object that can only be created once
> > > > > > can now declare the TYPE_SINGLETON interface, then QOM facilities will make
> > > > > > sure it won't be created more than once.  For example, qom-list-properties,
> > > > > > device-list-properties, etc., will be smart enough to not try to create
> > > > > > temporary singleton objects now.
> > > > > 
> > > > > QOM design assumption: object_new() followed by object_unref() is always
> > > > > possible and has no side effect.
> > > > 
> > > > I see.
> > > > 
> > > > > 
> > > > > QOM introspection relies on this.  Your PATCH 1 makes non-class
> > > > > properties of singletons invisible in introspection.  Making something
> > > > > with such properties a singleton would be a regression.
> > > > > 
> > > > > Anything that violates the design assumption must be delayed to a
> > > > > suitable state transition.  For devices (subtypes of TYPE_DEVICE), this
> > > > > is ->realize().  For user-creatable objects (provide interface
> > > > > TYPE_USER_CREATABLE), this is ->complete().  For anything else, it's
> > > > > something else that probably doesn't even exist, yet.  See "Problem 5:
> > > > > QOM lacks a clear life cycle" in
> > > > > 
> > > > >     Subject: Dynamic & heterogeneous machines, initial configuration: problems
> > > > >     Date: Wed, 31 Jan 2024 21:14:21 +0100
> > > > >     Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
> > > > >     https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
> > > > 
> > > > The major challenge here might be that, in migration's use case we want to
> > > > do something after the last refcount is released.
> > > 
> > > This is rather a strange idea, and feels back to front. An object's last
> > > refcount must never be released until code has entirely finished using
> > > the object.
> > > 
> > > > IOW, I don't yet see an easy way to explicit do qdev_unrealize() (even if
> > > > migration object will use realize(), while it doesn't yet..), because there
> > > > can be more than one thread holding refcount of the object, and we don't
> > > > know where to invoke it, and we don't want to do the cleanup if the other
> > > > one still holds a refcount.
> > > 
> > > This sounds like the code is missing some synchronization mechanism
> > > beween the threads, which need to communicate with each other when
> > > they are "done", so that the "primary" thread can then finally
> > > release any resources.
> > > 
> > > > Maybe I can also try do that with a "magic property" with its set/get, as
> > > > that's indeed the other hook (basically, object_property_del_all()) that is
> > > > only invoked after the final refcount is released.  However I think we
> > > > still need the singleton idea somehow..
> > > 
> > > Based on the description above it feels like the problem is outside
> > > of QOM, around the lack of synchronization across threads.
> > 
> > Right, this used to be discussed here and you were also in the loop:
> > 
> > https://lore.kernel.org/qemu-devel/20190228122822.GD4970@work-vm/
> > 
> > I kind of agree join() would be perfect, disregard the question on whether
> > QEMU would still benefit from a singleton interface, no matter migration
> > would rely on that for refcounting, or simply it'll also make sense to just
> > avoid people creating random migration objects.
> > 
> > So yes, I think migration can benefit from singleton idea for more than one
> > reason, while the refcount issue here might be even better resolved by
> > join() in main.
> > 
> > It's just that in the thread Dave raised a few points on possible
> > challenges on join() in the main thread.  I'm not sure whether we should go
> > that route instead.  Obviously I am digging one of our legacy rabbit holes
> > from when I started to look at this "access current_migration anywhere"
> > issue reported from VFIO.  But if some of us think we should give it a
> > shot, I can try.  After all, I started digging.
> > 
> > Another simpler but direct solution to "access current_migration" is, we
> > simply don't free it at all, leaving process exit() to do the job.  Then I
> > can drop all object_[un]ref() for the migration object.  I think that could
> > work too, but ugly, for the refcount issue.
> 
> I tend to feel that having MigrationState exist for the whole lifetime
> of QEMU is a bug, forced on us by the unfortunate need to call
> migrate-set-parameters/capabilities separately from the migrate
> command, and by the need to query migrate info an arbitrary amount of
> time after it finishes.
> 
> This puts libvirt in the awkward position of having to manually reset
> all migration parameters, just to ensure earlier settings don't
> accidentally affect a future migration operation :-( This is a design
> that encourages mistakes.

I think it would still be easy to add "cap" & "params" arguments support
for the "migrate" QMP command without breaking the current API, iff that
helps in whatever form.  When present, it simply applies the caps and/or
param list first before invoking the migrate command, fail the command if
cap / param check fails.

But I'm not sure whether that's a concern at all for Libvirt, if what
Libvirt currently does is having separate "migrate-set-*" commands prior to
the "migrate".  I may have overlooked the real issue behind on how that
could complicate Libvirt.

> 
> Rather than MigrationState become a singleton, I'd really encourage
> trying to see if we can fix the lifecycle design problems, so that
> we have a clear beginning & end of the migration operation, with the
> state discarded at the end, such that every future migrate starts
> from a clean base.

I assume it implies the join() path as a start.  As long as we're ok we
risk slow quits of QEMU, as I would expect bug reports coming afterwards,
we could try.  I believe there's no way we can resolve all such issues in
one shot.  I doubt whether some of those can be too tricky so we may wish
to go back at some point, spending too much effort but without a direct
benefit yet so far.

Meanwhile we still have the immediate concern that current_migration can
points to freed memory right now with QEMU master branch.  That's simply
wrong.

I thought it was still an improvement to have the singleton idea, so that
even afterwards we can join() properly the idea may still make sense on its
own.  It is also not against the ultimate willingness that we want to
create an obj at start of migration, and clearly destroys it after
migration completes.  When that comes we keep migration object singleton,
but then the tricky operations on current_migration can be gone.

That still guarantees from QOM level that e.g. nobody tries to initiate
migration twice, for example, or accidentally create it somewhere, like in
qom-list-properties.

There's yet another short term plan that I can fix UAF for
current_migration, which is to have a refcount for migration alone on top
of Object, then it only object_unref() on the migration object after we
know the last real refcount is released.  That won't need any QOM change,
so keep the complexity internally.  But I prefer the current proposal,
assuming it could be still helpful in general for QEMU, even though I'm not
sure.

So.. I'm not sure whether we should ignore the current UAF until a whole
refactor of any kind to land, or we should do something to fix it, which is
what I'm trying with the series.

Thanks,

-- 
Peter Xu


