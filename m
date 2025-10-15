Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523E3CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96Do-0001kn-BW; Wed, 15 Oct 2025 14:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v96Dj-0001kS-4W
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v96Db-0001z2-Cn
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760552836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nS1AVhVCqxFPeTEOfp87M0gyBs3zqrcuQrLJqmduW0=;
 b=VNyk+KU+WRAqFB9nIlZQfRYWX8K1DQ0Yf4QfXGTClozbdAc/alm8jMu3KMK1Apm48/6Lni
 DZa40KRljNOSVNuGJIypQqb+XyJOzfg/ocGlXLG8P5qfRZ1gds0wlvAYoDmyTaJU1iO6si
 VAbdIoCwZYJMGd38fvut9wTY5X+6Tm4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-vZxaPiCFMFm-DR38E1wQ1Q-1; Wed, 15 Oct 2025 14:27:14 -0400
X-MC-Unique: vZxaPiCFMFm-DR38E1wQ1Q-1
X-Mimecast-MFC-AGG-ID: vZxaPiCFMFm-DR38E1wQ1Q_1760552834
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-87c08308d26so32195026d6.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552834; x=1761157634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nS1AVhVCqxFPeTEOfp87M0gyBs3zqrcuQrLJqmduW0=;
 b=VXkaOS3bSNqQM461ClqAuyEnkZ3NvESXOp4zXS5aIDoPAqysTeOONWOOChFKvPEhNu
 MAG8CBI5jvmExO4bv5r4sfCFBUTiA3Su9cOVqFHfpvst1U/b3ipsEGw9vZBNotU3aR4r
 /jeIU02u7xxopcn412cCvocnLWWkT3e3cmzs3cxuLFp8GD4JLNhZ6z+gyImVTUJb0g7E
 qBKPpqLE2oW4Z9/siPKpj2dkWvX3FFpfA4QdNbhRfxtOw8xUV9OujPT41bmdGQbbe8AF
 RdFmAKd4uZtwcPdyZ9YlCGKFb8tTXRafHnGS1vhLWhlH+DMWhEdxGKdhRIl3gFUA5wFh
 oczQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7suep+sJIjBqn+Yo6IAukqwJ6/inbfUt8j0Tpjhx+GmCnlXwB8n8DghanzYinRdwlEVsCPj6ahPue@nongnu.org
X-Gm-Message-State: AOJu0YwS6/B4u2pLa1UUeKihotagdwn3oEdYeSBz/NQBFqh9Cv5bdiO4
 P+CEa8hC3qHeQyZlccC9QF+KwLcSsFEr/btLWzQYoKOTDIIh6vYgBloc9jODiemMgVewBk1nuIb
 5L6JeiPoKgJkeEKnqraVAjDNk2YeuzwQYlpL5FvxeWq2aSuWwh3sj8POb
X-Gm-Gg: ASbGncvIQWXVF4OxcZwwf6G/lZgNOx65utfzskIzpc/K0HoZn5BheRrUPNkuEixXS5E
 Mcc2A0v/r1VnPmVEa7hN9hca5c6nl1FSLbYasm78j1K8LXGBtCYp+sexfjsGWtRVNO4ObG4qRlo
 RRP1O6owOmmqEm19nIV3lgdhejalM3N4MLT7oa+TBVmQsJr85Nr4UxEDzOAzYubPrO31CgKgbcu
 Nb7wLHTJJB9FXxfUCNjTFlz3DFTsvrUv62Bv3jnEB5Lu/kR8q1DTGQtwAlEOt6WWsr8horzdBGT
 rCwi0KHaOnyu7ikPVRt8I6eg9xry13RT
X-Received: by 2002:a05:6214:2a84:b0:78e:1439:5ace with SMTP id
 6a1803df08f44-87b2efe71a4mr414051176d6.49.1760552833614; 
 Wed, 15 Oct 2025 11:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxqPkASLcKLzGx5EQU1eS7diw9haE3aVpe4rt2jDIMEftUiC7Vv5fBKPG13dzv67SpBWxRpA==
X-Received: by 2002:a05:6214:2a84:b0:78e:1439:5ace with SMTP id
 6a1803df08f44-87b2efe71a4mr414050606d6.49.1760552832808; 
 Wed, 15 Oct 2025 11:27:12 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c012917aasm22999936d6.31.2025.10.15.11.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 11:27:12 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:27:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, jasowang@redhat.com, farosas@suse.de, sw@weilnetz.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v7 16/19] qapi: add interface for backend-transfer
 virtio-net/tap migration
Message-ID: <aO_nfsgM2CWEjyeQ@x1.local>
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
 <20251010173957.166759-17-vsementsov@yandex-team.ru>
 <aO57SKp86zX2R8mV@x1.local>
 <6da192b9-7609-4cc8-82a9-1a445ecb10c9@yandex-team.ru>
 <aO6xqt5_1PDBwOwu@x1.local>
 <9a9ced95-583e-4c1e-84f0-af12a5800193@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a9ced95-583e-4c1e-84f0-af12a5800193@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 15, 2025 at 12:46:26AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 14.10.25 23:25, Peter Xu wrote:
> > On Tue, Oct 14, 2025 at 10:31:30PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 14.10.25 19:33, Peter Xu wrote:
> > > > On Fri, Oct 10, 2025 at 08:39:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > To migrate virtio-net TAP device backend (including open fds) locally,
> > > > > user should simply set migration parameter
> > > > > 
> > > > >      backend-transfer = ["virtio-net-tap"]
> > > > > 
> > > > > Why not simple boolean? To simplify migration to further versions,
> > > > > when more devices will support backend-transfer migration.
> > > > > 
> > > > > Alternatively, we may add per-device option to disable backend-transfer
> > > > > migration, but still:
> > > > > 
> > > > > 1. It's more comfortable to set same capabilities/parameters on both
> > > > > source and target QEMU, than care about each device.
> > > > 
> > > > But it loses per-device control, right?  Say, we can have two devices, and
> > > > the admin can decide if only one of the devices will enable this feature.
> > > > 
> > > 
> > > Right. But, in short:
> > > 
> > > 1. I'm not sure, that such granularity is necessary.
> > > 
> > > 2. It may implemented later, on top of the feature.
> > 
> > I confess that's not a good example, but my point was that it was
> > straightforward idea to have two layers of settings, meanwhile it provides
> > full flexiblity.
> > 
> > > 
> > > > > 
> > > > > 2. To not break the design, that machine-type + device options +
> > > > > migration capabilities and parameters are fully define the resulting
> > > > > migration stream. We'll break this if add in future more
> > > > > backend-transfer support in devices under same backend-transfer=true
> > > > > parameter.
> > > > 
> > > > Could you elaborate?
> > > > 
> > > > I thought last time we discussed, we planned to have both the global knob
> > > > and a per-device flag, then the feature is enabled only if both flags are
> > > > set.
> > > 
> > > Right, here in v3: https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01644.html
> > > 
> > > Still at this point, I also needed local-incoming=true target option, so I
> > > considered all the parameters like "I can't make feature without extra
> > > per-device options, so here they are".
> > > 
> > > A day later, after motivating comment from Markus (accidentally in v2),
> > > I found and suggested the way:
> > > 
> > > https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01960.html
> > > 
> > > And further versions v4-v7 were the realization of the idea. Still, main
> > > benefit is possibility to get rid of per-device local-incoming=true
> > > options for target, not about a kind of per-device "capability" flag we
> > > discuss now.
> > > 
> > > A, and here I said [1]:
> > > 
> > > > 1. global fds-passing migration capability, to enable/disable the whole feature
> > > > 
> > > > 2. per-device fds-passing option, on by default for all supporting
> > > > devices, to be
> > > > able to disable backing migration for some devices. (we discussed it
> > > > here: https://lore.kernel.org/all/aL8kuXQ2JF1TV3M7@x1.local/ ).
> > > > Still, normally these options are always on by default.
> > > > And more over, I can postpone their implementation to separate series,
> > > > to reduce discussion field, and to check that everything may work
> > > > without additional user input.
> > > 
> > > And then, went this way, postponing realization of per-device options..
> > 
> > Postponing the per-device flag might still break different backends if you
> > specify the list with virtio-net-pci.
> > 
> > But only until now, I noticed you were using "virtio-net-tap" instead of
> > "virtio-net-pci".
> > 
> > Ouch.. I think that's even more complicated. :(
> > 
> > Here I think the problem is, introducing some arbitrary strings into
> > migration QAPI to represent some combinations of "virtio frontend F1" and
> > "virtio backend B1" doesn't sound the right thing to do.  Migration ideally
> > should have zero knowledge of the device topology, types of devices,
> > frontends or backends.  "virtio-*" as a string should not appear in
> > migration/ or qapi/migration.json at all..
> > 
> > > 
> > > And then, developing similar migration for vhost-user-blk, found
> > > that I can't use on boolean capability for such features, the reason
> > > in commit message, which we discuss now.
> > 
> > Why a bool isn't enough?  Could you share a link to that discussion?
> > 
> > > 
> > > Than, current design came in v5 (v4 was skipped).. And I even got an
> > > approval from Fabiano :)
> > > 
> > > https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg03999.html
> > > 
> > > > 
> > > > If these parameters are all set the same on src/dst, would it also not
> > > > break the design when new devices start to support it (and the new device
> > > > will need to introduce its own per-device flags)?
> > > 
> > > Yes, right.
> > > 
> > > I missed, that, "postponing (probably forever)" per-device options
> > > realization, I started to implement another way to solve the same
> > > problem (switching from one boolean capability to a backend-transfer
> > > list).
> > > 
> > > In other words, if at some point implement per-device options, that will
> > > partly intersect by functionality with current complex migration
> > > parameter..
> > > 
> > > -
> > > 
> > > But still, I think, that parameter backend-transfer = [list of targets]
> > > is better than per-device option. With per-device options we'll have to
> > > care about them forever. I can't imagine a way to make them TRUE by
> > > default.
> > > 
> > > Using machine type, to set option to TRUE by default in new MT, and to
> > > false in all previous ones doesn't make real sense: we never migrate on
> > > another MT, but we do can migrate from QEMU without support for
> > > virtio-net backend transfer to the QEMU with such support. And on target
> > > QEMU we'll want to enable virtio-net backend-transfer for further
> > > migrations..
> > 
> > So this is likely why you changed your mind.  I think machine properties
> > definitely make sense.
> > 
> > We set it OFF on old machines because when on old machines the src QEMU
> > _may_ not support this feature.  We set it ON on new machines because when
> > the QEMU has the new machine declared anyway, it is guaranteed to support
> > the feature.
> > 
> > We can still manually set the per-device properties iff the admin is sure
> > that both sides of "old" QEMUs support this feature.  However machine
> > properties worked like that for many years and I believe that's how it
> > works, by being always on the safe side.
> > 
> > > 
> > > So, I think, modifying machine types is wrong idea here. So, we have to
> > > keep new options FALSE by default, and management tool have to care to
> > > set them appropriately.
> > > 
> > > -
> > > 
> > > Let's look from the POV of management tool.
> > > 
> > > With complex parameter (list of backend-transfer targets, suggested with
> > > this series), what should we do?
> > > 
> > > 1. With introspection, get backend-transfer targets supported by source
> > >     and target QEMUs
> > > 2. Get and intersection, assume X
> > > 3. Set same backend-transfer=X on source and target
> > > 4. Start a migration
> > > 
> > > But with per-device parameters it becomes a lot more complicated and
> > > error prone
> > > 
> > > 1. Somehow understand (how?), which devices support backend-transfer on
> > >     source and target
> > > 2. Get an intersection
> > > 3. Set all the backend-transfer options on both vms correspondingly,
> > >     doing personal qom-set for each device
> > > 4. Start a migration
> > > 
> > > -
> > > 
> > > In short:
> > > 
> > > 1. per device - is too high granularity, making management more complex
> > 
> > If we follow the machine property way of doing this (which I believe we
> > used for years), then mgmt doesn't need any change except properly enable
> > fd-passing in migration cap/params when it's a local migration.  That's
> > all.  It doesn't need to know anything about "which device(s) supports
> > fd-passing", because they'll all be auto-set by the machine types.
> > 
> > > 
> > > 2. per feature - is what we need. And it's a normal use for migration
> > > capabilities: we implement a new migration feature, and add new
> > > capability. The only new bit with this series is that "we are going to"
> > > implement similar capabilities later, and seems good to organize them
> > > all into a list, rather than make separate booleans.
> > > 
> > > 
> > > > 
> > > > > 
> > > > > The commit only brings the interface, the realization will come in later
> > > > > commit. That's why we add a temporary not-implemented error in
> > > > > migrate_params_check().
> > > > > 
> > > 
> > > [..]
> > > 
> > > > > +bool migrate_virtio_net_tap(void)
> > > > > +{
> > > > > +    MigrationState *s = migrate_get_current();
> > > > > +    BackendTransferList *el = s->parameters.backend_transfer;
> > > > > +
> > > > > +    for ( ; el; el = el->next) {
> > > > > +        if (el->value == BACKEND_TRANSFER_VIRTIO_NET_TAP) {
> > > > 
> > > > So this is also something I want to avoid.  The hope is we don't
> > > > necessarily need to invent new device names into qapi/migration.json.
> > > > OTOH, we can export a helper in migration/misc.h so that devices can query
> > > > wehther the global feature is enabled or not, using that to AND the
> > > > per-device flag.
> > > > 
> > > 
> > > Understand. But I can't imagine how to keep management simple with per-device
> > > options..
> > > 
> > > -
> > > 
> > > What do you think?
> > 
> > I feel like you wanted to enable this feature _while_ using an old machine
> > type.
> 
> Exactly
> 
> > Is that what you're looking for?  Can you simply urge the users to
> > move to new machine types when looking for new features?  I believe that's
> > what we do..
> > 
> > MT properties were working like that for a long time.  What you were asking
> > is fair, but if so I'd still like to double check with you on that's your
> > real purpose (enabling this feature on NEW qemus but OLD machine types, all
> > automatically).
> > 
> 
> You made me think.
> 
> On the one hand, you are right, I agree with all arguments about migration
> being separate from virtio device types, their backends and frontends.
> 
> And yes, if refuse the idea of enabling the feature in old machine types
> automatically, everything fits into existing paradigm.
> 
> On the other hand is our downstream practice in the cloud. We introduce
> new machine types _very_ seldom. Almost always, new features developed
> or backported to our downstream doesn't require new machine type. In such
> situation, creating feature, which theoretically (and more simple in API!)
> may be done without introducing new MT, but creating it by introducing new
> MT, postponing the moment when we start to widely use it up to the moment when
> most of existing vms will die or restart naturally (as for sure, we'll not
> ask users to restart them, it would be too expensive (not saying about,
> is restart a safe way to change MT, or we'd better recreate a vm), seems
> very strange for me. (too long sentence detector blinking).

Yes, I agree once more it's still a fair ask, it's just not the major way
we do it in QEMU upstream otherwise there's no point introducing versioned
machine types (while we still need things like pc/q35 to identify the
boards even if no versioning on each of them).

> 
> So, finally, it's OK for me to switch to per-device properties. Then, in
> downstream I may implement corresponding capabilities to simplify management.
> That's rather simple.

With per-device properties, maybe.. it's still feasible to qom-list the
devices on both src/dst to know whether both of them would support this,
then turning it on if qom-list can report the property on both sides.  I
didn't think deeper than that, though..

> 
> -
> 
> Interesting, could migration "return path" be somehow used to get information
> from target, does it support backend transfer for concrete device?
> 
> So that, we simply enable backend-transfer=true parameter both on
> source and target. Than, source somehow find out through return path,
> for the device, does target support backend-transfer for it, and decide,
> what to do? Or that's too complicated?

Fabiano is looking at something like that, we called it migration
handshake.

https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake

Fundamentally one of its goal is that we can have bi-directional "talks"
between src/dst, before migration ever started, to synchronize on things
like this.  It's still likely not gonna happen this release.. though..  but
it's on the radar.  With that, dst also doesn't need to set migration
caps/params the same as src, because they'll talk things over.

> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Peter Xu


