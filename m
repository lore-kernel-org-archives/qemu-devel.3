Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0B5CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 10:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Lds-0005ja-5Y; Thu, 16 Oct 2025 06:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9Ldq-0005hS-Un
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 06:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9Ldm-0004aU-Vd
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 06:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760612118;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGMl0mUxo1GR509mzKBX81Z4Ze2hDI31UhMtysAkGD8=;
 b=O2/TO608E8alviDgQ5sbijKqgqazva6yFi3qwCa1OzQUTdust/Lt44fIORsNfN3EjxhQ0k
 ZviCmn/M7l2mVxzingcnghpz67wzrmZeNoHIblZjPaOmdepC80dNgbusVKEW77JriPPCPh
 s76q5JWjlP1B6io8j9q5WDnLM1XvvRg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-pfO4JHbIO8WWjFvcTb3DHQ-1; Thu,
 16 Oct 2025 06:55:12 -0400
X-MC-Unique: pfO4JHbIO8WWjFvcTb3DHQ-1
X-Mimecast-MFC-AGG-ID: pfO4JHbIO8WWjFvcTb3DHQ_1760612111
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AB811800654; Thu, 16 Oct 2025 10:55:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7ED5019560AD; Thu, 16 Oct 2025 10:55:04 +0000 (UTC)
Date: Thu, 16 Oct 2025 11:55:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>, mst@redhat.com, jasowang@redhat.com,
 farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aPDPBSBHtgyZMlvN@redhat.com>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
 <20251015132136.1083972-17-vsementsov@yandex-team.ru>
 <aO_ll4Lf0bq6vgdm@x1.local>
 <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <c7de7ea6-954c-4a1f-972b-b2166bcafb85@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7de7ea6-954c-4a1f-972b-b2166bcafb85@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 16, 2025 at 01:38:25PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 16.10.25 12:23, Vladimir Sementsov-Ogievskiy wrote:
> > On 16.10.25 11:32, Daniel P. Berrangé wrote:
> > > On Thu, Oct 16, 2025 at 12:02:45AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > On 15.10.25 23:07, Peter Xu wrote:
> > > > > On Wed, Oct 15, 2025 at 10:02:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > On 15.10.25 21:19, Peter Xu wrote:
> > > > > > > On Wed, Oct 15, 2025 at 04:21:32PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > > > This parameter enables backend-transfer feature: all devices
> > > > > > > > which support it will migrate their backends (for example a TAP
> > > > > > > > device, by passing open file descriptor to migration channel).
> > > > > > > > 
> > > > > > > > Currently no such devices, so the new parameter is a noop.
> > > > > > > > 
> > > > > > > > Next commit will add support for virtio-net, to migrate its
> > > > > > > > TAP backend.
> > > > > > > > 
> > > > > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > > > > > ---
> > > > > > 
> > > > > > [..]
> > > > > > 
> > > > > > > > --- a/qapi/migration.json
> > > > > > > > +++ b/qapi/migration.json
> > > > > > > > @@ -951,9 +951,16 @@
> > > > > > > >     #     is @cpr-exec.  The first list element is the program's filename,
> > > > > > > >     #     the remainder its arguments.  (Since 10.2)
> > > > > > > >     #
> > > > > > > > +# @backend-transfer: Enable backend-transfer feature for devices that
> > > > > > > > +#     supports it. In general that means that backend state and its
> > > > > > > > +#     file descriptors are passed to the destination in the migraton
> > > > > > > > +#     channel (which must be a UNIX socket). Individual devices
> > > > > > > > +#     declare the support for backend-transfer by per-device
> > > > > > > > +#     backend-transfer option. (Since 10.2)
> > > > > > > 
> > > > > > > Thanks.
> > > > > > > 
> > > > > > > I still prefer the name "fd-passing" or anything more explicit than
> > > > > > > "backend-transfer". Maybe the current name is fine for TAP, only because
> > > > > > > TAP doesn't have its own VMSD to transfer?
> > > > > > > 
> > > > > > > Consider a device that would be a backend that supports VMSDs already to be
> > > > > > > migrated, then if it starts to allow fd-passing, this name will stop being
> > > > > > > suitable there, because it used to "transfer backend" already, now it's
> > > > > > > just started to "fd-passing".
> > > > > > > 
> > > > > > > Meanwhile, consider another example - what if a device is not a backend at
> > > > > > > all (e.g. vfio?), has its own VMSD, then want to do fd-passing?
> > > > > > 
> > > > > > Reasonable.
> > > > > > 
> > > > > > But consider also the discussion with Fabiano in v5, where he argues against fds
> > > > > > (reasonable too):
> > > > > > 
> > > > > > https://lore.kernel.org/qemu-devel/87y0qatqoa.fsf@suse.de/
> > > > > > 
> > > > > > (still, they were against my "fds" name for the parameter, which is
> > > > > > really too generic, fd-passing is not)
> > > > > > 
> > > > > > and the arguments for backend-transfer (to read similar with cpr-transfer)
> > > > > > 
> > > > > > https://lore.kernel.org/qemu-devel/87ms6qtlgf.fsf@suse.de/
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > In general, I think "fd" is really a core concept of this whole thing.
> > > > > > 
> > > > > > I think, we can call "backend" any external object, linked by the fd.
> > > > > > 
> > > > > > Still, backend/frontend terminology is so misleading, when applied to
> > > > > > complex systems (for me, at least), that I don't really like "-backend"
> > > > > > word here.
> > > > > > 
> > > > > > fd-passing is OK for me, I can resend with it, if arguments by Fabiano
> > > > > > not change your mind.
> > > > > 
> > > > > Ah, I didn't notice the name has been discussed.
> > > > > 
> > > > > I think it means you can vote for your own preference now because we have
> > > > > one vote for each. :) Let's also see whether Fabiano will come up with
> > > > > something better than both.
> > > > > 
> > > > > You mentioned explicitly the file descriptors in the qapi doc, that's what
> > > > > I would strongly request for.  The other thing is the unix socket check, it
> > > > > looks all good below now with it, thanks.  No strong feelings on the names.
> > > > > 
> > > > 
> > > > After a bit more thinking, I leaning towards keeping backend-transfer. I think
> > > > it's more meaningful for the user:
> > > > 
> > > > If we call it "fd-passing", user may ask:
> > > > 
> > > > Ok, what is it? Allow QEMU to pass some fds through migration stream, if it
> > > > supports fds? Which fds? Why to pass them? Finally, why QEMU can't just check
> > > > is it unix socket or not, and pass any fds it wants if it is?
> > > > 
> > > > Logical question is, why not just drop the global capability, and check only
> > > > is it unix socket or not? (OK, relying only on socket type is wrong anyway,
> > > > as it may be some complex tunneling, which includes unix sockets, but still
> > > > can't pass fds, but I think now about feature naming)
> > > > 
> > > > But we really want an explicit switch for the feature. As qemu-update is
> > > > not the only case of local migration. The another case is changing the
> > > > backend. So for the user's choice is:
> > > > 
> > > > 1. Remote migration: we can't reuse backends (files, sockets, host devices), as
> > > > we are moving to another host. So, we don't enable "backend-transfer". We don't
> > > > transfer the backend, we have to initialize new backend on another host.
> > > > 
> > > > 2. Local migration to update QEMU, with minimal freeze-time and minimal
> > > > extra actions: use "backend-transfer", exactly to keep the backends
> > > > (vhost-user-server, TAP device in kernel, in-kernel vfio device state, etc)
> > > > as is.
> > > > 
> > > > 3. Local migration, but we want to reconfigure some backend, or switch
> > > > to another backend. We disable "backend-transfer" for one device.
> > > 
> > > This implies that you're changing 'backend-transfer' against the
> > > device at time of each migration.
> > > 
> > > This takes us back to the situation we've had historically where the
> > > behaviour of migration depends on global properties the mgmt app has
> > > set prior to the 'migrate' command being run. We've just tried to get
> > > away from that model by passing everything as parameters to the
> > > migrate command, so I'm loathe to see us invent a new way to have
> > > global state properties changing migration behaviour.
> > > 
> > > This 'backend-transfer' device property is not really a device property,
> > > it is an indirect parameter to the 'migrate' command.
> > > 
> > > Ergo, if we need the ability to selectively migrate the backend state
> > > of individal devices, then instead of a property on the device, we
> > > should pass a list of device IDs as a parameter to the migrate
> > > command in QMP.
> > 
> > Understand.
> > 
> > So, it will look like
> > 
> > # @backend-transfer: List of devices IDs or QOM paths, to enable
> > #     backend-transfer for. In general that means that backend
> > #     states and their file descriptors are passed to the destination
> > #     in the migration channel (which must be a UNIX socket), and
> > #     management tool doesn't have to configure new backends for
> > #     target QEMU (like vhost-user server, or TAP device in the kernel).
> > #     Default is no backend-transfer migration (Since 10.2)
> > 
> > 
> > Peter, is it OK for you?
> 
> Or, may be, we just can continue with two simple experimental boolean parameters:
> 
> @backend-transfer-vhost-user-blk
> 
> and
> 
> @backend-transfer-virtio-net-tap
> 
> 
> and not care to implement good-final-complex-API, while it's unstable anyway?

Even if declared unstable, that still has a negative impact on the internal
code structure because its putting special cases for certain device types
into the migration framework and the device code, with no time limit on how
long this technical debt will last.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


