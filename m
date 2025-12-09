Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69942D3B985
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0w2-0008VR-Q2; Tue, 09 Dec 2025 11:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0vg-0008OM-5d
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:51:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0vc-0000AH-Iw
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765299066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VCQWajjHh1een5vE+8vsAKhYgNdQSKY1bd8kYotKcvo=;
 b=BgiG44v6RAYVr20k4Mq+T1TnFtCNG5Etehd/Lx5J57aHlb31vLdZt35YcR8L2l3vhhWjj3
 EiWsyZKGNKR7QwcxkD6rg34GCkVxKm/v8XgkCKt3ntDIj4alJlo+AckyHRXO3VeQxF4Pqe
 6RKE09i/oCaaCibqu6cvDnbevYsYvIw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-DLzxzFZzORWmEyxclP1enw-1; Tue, 09 Dec 2025 11:51:05 -0500
X-MC-Unique: DLzxzFZzORWmEyxclP1enw-1
X-Mimecast-MFC-AGG-ID: DLzxzFZzORWmEyxclP1enw_1765299065
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b1d8f56e24so1264238585a.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765299065; x=1765903865; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VCQWajjHh1een5vE+8vsAKhYgNdQSKY1bd8kYotKcvo=;
 b=YjBp96I0QKSHdDVaPE3lcI7Rx0RbRil1yKVEpcrhJNOatNnNZuYL+DJJCr3QOHMBof
 GPOMtXnf1elAZnlCe7ydoxE19aZvSTH0RK19yv6FYGbqGTlcQFHWxRQLedeSN4bIx1FF
 /NCcOHfXTcE/xbnwwLLdGLUHVb/Xkl5Tca6EmYLRLGEig0V4dlui88PFYOd7BjE2JMuU
 ZIXKant8zjrp2RI3AKnXNG2yTIjjiMNZXPxkRKWtPOMn2uXcCl5IsMaEi/fplKQcYReO
 RF16NZQjU7esNKQdXp7QuyKstpZs2vWA55HI/O1JduFNdoBw7P3dumSTTmdkMeRtT97m
 2k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765299065; x=1765903865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCQWajjHh1een5vE+8vsAKhYgNdQSKY1bd8kYotKcvo=;
 b=FJ+qJ/QdVbBfD46qqEdGgnK9NsYJD628plhbJ2uwgN+h1ETsCUIcHyINVDpz0nidEu
 X9AkPTFh3krn9lyuHHwvQU0F6/8c9v6huQ1UApyYlJNDEBgqdHYSAvSoTZ3Y1dKQ7On+
 d109+Sq7wbbRGKWM67B3wBaBO0LE74P5OHNGpk6MK2X4PTZ8l+Tpe8HWWOsE+LExXQa5
 NEYygpae1ZO6B9xGt9vHq/WJSVSt4JJsVDzBfI1qSV/A8n35dfjtdmyb1rCm+TYma9W6
 wfPjjReZvmPdR0qSWRGhFYJ8eUfFi5HmSlfEYJSlH6PZaJ4H09oUyTSnggJagOfZK2xx
 qy/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPrBPB3KrPMB6O5d2ZKtsaq+Bm2gc914/9LFISEgmuAQWkt281EDCw+ZzXLKJB3su7C3mfJGcvFFpE@nongnu.org
X-Gm-Message-State: AOJu0Yx+xFyLiuFPXo0KJvgLKwM3tG1ddMb42q0+lX/3BH5txn67Pnrk
 klD2Etk/lNsNYFrTYPE3h2twuF+Ix9PKEunBtwHzeehqMTFQYEcCId9mHwe0fEmvWcOduKXJ6ij
 ldT9zMGGCKnukPZvKw2PZBNBj8EJqsSk9ZG7gPchNJxQgChY+7NHdhnW+
X-Gm-Gg: ASbGncvx2p/TwImWnqojLNYRhFlTMNr7kshX2P4VYpdsqbS3Q7PZU+x20CNHiCheqS2
 Hl28uBRxC0qAekKnHXgyBNSS2UrUjoCc4s5tqxAw8ShGV1qK3f08THXzI8LxLPPHUXVJ83uwQFe
 CfTao2zTyiRBSuVkB8jurB8FNerkM8nKRvMHU2xcm8u3JXgX7MPwEu1CQwn303l70A0Sc3xrRh0
 9wTWtydMPLqSUgQrMk+K3xBPbbx7NFZtqtTDF4yP7lhah1SoZ0PNo/cB1t9iJRVVrNxCrA/w+xl
 mPAkmFjlfoeOOKxBewTowEqwF0A6icVufgWXq5HKUY4ovg3MDnjppforIXic4FmUQFT9RNyEKsL
 I52o=
X-Received: by 2002:a05:620a:1a96:b0:84f:110c:b6e8 with SMTP id
 af79cd13be357-8b6a23e30c4mr1761639985a.68.1765299064452; 
 Tue, 09 Dec 2025 08:51:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1T9Qw8YK7Vw9OJhXvnMGsu1CKAVZfqSxcIGIfq0XD69NTfZ/7uV8lkmR3TaCCKZW5x71cKQ==
X-Received: by 2002:a05:620a:1a96:b0:84f:110c:b6e8 with SMTP id
 af79cd13be357-8b6a23e30c4mr1761632985a.68.1765299063871; 
 Tue, 09 Dec 2025 08:51:03 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b627a9fd23sm1331967185a.46.2025.12.09.08.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:51:03 -0800 (PST)
Date: Tue, 9 Dec 2025 11:51:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/3] vhost-user-blk: support inflight migration
Message-ID: <aThTdgwsNexV9KAp@x1.local>
References: <20251110103937.1944486-1-dtalexundeer@yandex-team.ru>
 <cf0f69b9-4b2b-4c09-a32b-ad86bbe04f6d@yandex-team.ru>
 <aRztnfZFl-OcbVYI@x1.local>
 <d986f0ac-a0ae-44f6-b7a5-e002b7d3226e@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d986f0ac-a0ae-44f6-b7a5-e002b7d3226e@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Dec 04, 2025 at 10:55:33PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 19.11.25 01:05, Peter Xu wrote:
> > On Tue, Nov 18, 2025 at 11:24:12PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Add Daniel
> > > 
> > > On 10.11.25 13:39, Alexandr Moshkov wrote:
> > > > v3:
> > > > - use pre_load_errp instead of pre_load in vhost.c
> > > > - change vhost-user-blk property to
> > > >     "skip-get-vring-base-inflight-migration"
> > > > - refactor vhost-user-blk.c, by moving vhost_user_blk_inflight_needed() higher
> > > > 
> > > > v2:
> > > > - rewrite migration using VMSD instead of qemufile API
> > > > - add vhost-user-blk parameter instead of migration capability
> > > > 
> > > > I don't know if VMSD was used cleanly in migration implementation, so
> > > > feel free for comments.
> > > > 
> > > > Based on Vladimir's work:
> > > > [PATCH v2 00/25] vhost-user-blk: live-backend local migration
> > > >     which was based on:
> > > >       - [PATCH v4 0/7] chardev: postpone connect
> > > >         (which in turn is based on [PATCH 0/2] remove deprecated 'reconnect' options)
> > > >       - [PATCH v3 00/23] vhost refactoring and fixes
> > > >       - [PATCH v8 14/19] migration: introduce .pre_incoming() vmsd handler
> > > > 
> > > 
> > > Hi!
> > > 
> > > On my series about backend-transfer migration, the final consensus (or at least,
> > > I hope that it's a consensus:) is that using device properties to control migration
> > > channel content is wrong. And we should instead use migration parameters.
> > > 
> > > (discussion here: https://lore.kernel.org/qemu-devel/29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru/ )
> > > 
> > > So the API for backend-transfer features is a migration parameter
> > > 
> > >      backend-transfer = [ list of QOM paths of devices, for which we want to enable backend-transfer ]
> > > 
> > > and user don't have to change device properties in runtime to setup the following migration.
> > > 
> > > So I assume, similar practice should be applied here: don't use device
> > > properties to control migration.
> > > 
> > > So, should it be a parameter like
> > > 
> > >      migrate-inflight-region = [ list of QOM paths of vhost-user devices ]
> > > 
> > > ?
> > 
> > I have concern that if we start doing this more, migration qapi/ will be
> > completely messed up.
> > 
> > Imagine a world where there'll be tons of lists like:
> > 
> >    migrate-dev1-some-feature-1 = [list of devices (almost only dev1 typed)]
> >    migrate-dev2-some-feature-2 = [list of devices (almost only dev2 typed)]
> >    migrate-dev3-some-feature-3 = [list of devices (almost only dev3 typed)]
> >    ...
> 
> 
> Yes, hard to argue against it.
> 
> I still hope, Daniel will share his opinion..
> 
> From our side, we are OK with any interface, which is accepted)
> 
> 
> Let me summarize in short the variants I see:
> 
> ===
> 
> 1. lists
> 
> Add migrations parameters for such features:
> 
> migrate-inflight-region = [ list of QOM paths of vhost-user devices ]
> backend-transfer = [ list of QOM paths of devices, which backend should be migrated ]
> 
> This way, we just need to set the same sets for source and target QEMU before migration,
> and it have no relation to machine types.
> 
> PROS: Like any other migration-capability, setup what (and how) should migrate, no
> relation to device properties and MT.
> 
> CONS: Logically, that's the same as add a device property, but instead we implement
> lists of devices, and create extra QOM_PATH-links.
> 
> ===
> 
> 2. device parameters
> 
> Before migration we should loop through devices and call corresponding
> qom-set commands, like
> 
> qom-set {path: QOM_PATH, property: "backend-transfer", "value": true}
> qom-set {path: QOM_PATH, property: "migrate-inflight-region", "value": true}
> 
> And of course, we should care to set same values for corresponding devices on source
> and target.
> 
> In this case, we also _can_ rely on machine types for defaults.
> 
> Note, that "migrate-inflight-region" may become the default in the 11.0 MT.
> But backend-transfer can't be a default, as this way we'll break remote migration.
> 
> PROS: No lists, native properties
> 
> CONS: These properties does not define any portion of device state, internal or
> visible to guest. It's not a property of device, but it's and option for migration
> of that device.
> 
> ===
> 
> 2.1 = [2] assisted by one boolean migration-parameter
> 
> Still, if we want make backend-transfer "a kind of" default, we'll need one boolean
> migration parameter "it-is-local-migration", and modify logic to
> 
> really_do_backend_transfer = it-is-local-migration and device.backend-transfer
> really_do_migrate_inflight_region = not it-is-local-migration and device.migrate-inflight-region
> 
> PROS: starting from some MT, we'll have good defaults, so that user don't have
> to enable/disable the option per device for every migration.
> 
> CONS: a precedent of the behavior driven by combination of device property and
> corresponding migration parameter (or we have something similar?)
> 
> ===
> 
> 4. mixed
> 
> Keep [2] for this series, and [1] for backend-transfer.
> 
> PROS: list for backend-transfer remains "the only exclusion" instead of "the practice",
> so we will not have tons of such lists :)
> 
> CONS: inconstant solutions for similar things
> 
> ===
> 
> 5. implement "per device" migration parameters
> 
> They may be set by additional QMP command qmp-migrate-set-device-parameters, which
> will take additional qom-path parameter.
> 
> Or, we may add one list of structures like
> 
> [{
>    qom_path: ...
>    parameters: ..
> }, ...]
> 
> into common migration parameters.
> 
> PROS: keep new features as a property of migration, but avoid several lists of QOM paths
> CONS: ?
> 
> Hmm, we also may select devices not only by qom_path, but by type, for example, to enable
> feature for all virtio-net devices. Hmm, and this type may be also used as discriminator
> for parameters, which may be a QAPI union type..
> 
> ===
> 
> 
> Thoughts?

Sorry to respond late, I kept getting other things interrupting me when I
wanted to look at this..

I just sent a series here, allowing TYPE_OBJECT of any kind to be able to
work with machine compat properties:

https://lore.kernel.org/r/20251209162857.857593-1-peterx@redhat.com

I still want to see if we can stick with compat properties in general
whenever it's about defining guest ABI.

What you proposed should work, but that'll involve a 2nd way of probing
"what is the guest ABI" by providing a new QMP query command and then set
them after mgmt queries both QEMUs then set the subset of both.  It will be
finer granule but as I discussed previously, I think it's re-inventing the
wheels, and it may cause mgmt over-bloated on caring too many trivial
details of per-device specific details.

Please have a look to see the feasibility.  As mentioned in the cover
letter, that will need further work to e.g. QOMify TAP first at least for
your series.  But I don't yet see it as a blocker?  After QOMified, it can
inherit directly the OBJECT_COMPAT then TAP can add compat properties.

I wonder if vhost-usr-blk can already use compat properties.

Thanks,

> 
> > 
> > That doesn't look reasonable at all.  If some feature is likely only
> > supported in one device, that should not appear in migration.json but only
> > in the specific device.
> > 
> > I don't think I'm fully convinced we can't enable some form of machine type
> > properties (with QDEV or not) on backends we should stick with something
> > like that.  I can have some closer look this week, but.. even if not, I
> > still think migration shouldn't care about some specific behavior of a
> > specific device.
> > 
> > If we really want to have some way to probe device features, maybe we
> > should also think about a generic interface (rather than "one new list
> > every time").  We also have some recent discussions on a proper interface
> > to query TAP backend features like USO*.  Maybe they share some of the
> > goals here.
> > 
> What do you mean by probing device features? Isn't it qom-get command?
> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Peter Xu


