Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC1DCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8laW-00088Q-En; Tue, 14 Oct 2025 16:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8laT-00088I-VH
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8laJ-00083N-VZ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760473521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RLgJGzo8oRKrykPBF3FgcA0mpKSzNArLm1J9klVTdDY=;
 b=Zodi5CqyQfaWZ5vwKHhw6/KMeMJdLJ/NwRiLFgEusrFFs2gJGmmgvN9LNwf7KxP8bN3NRw
 KvRkgTdCagKRU2WfF2+4wk/iHexE7RK5PVgOnXvBD38uKGE/vyX8mqmAFNI3QmrFeI/ei2
 Xt9pSoKgD6pTOUfpoptAZy22h84gd2s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-oSErFAfXPfi7GSw3fP_A0A-1; Tue, 14 Oct 2025 16:25:19 -0400
X-MC-Unique: oSErFAfXPfi7GSw3fP_A0A-1
X-Mimecast-MFC-AGG-ID: oSErFAfXPfi7GSw3fP_A0A_1760473519
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-876ee102b44so9216146d6.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760473519; x=1761078319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLgJGzo8oRKrykPBF3FgcA0mpKSzNArLm1J9klVTdDY=;
 b=SdLxE+AkLRCu8ZlEZp3+ISmrSGsDSNXkyOYbSQ1Qu04OCqmCpet1WXFxHoxVL2GZ+e
 /MXmIBajuuT4FNY9QRXqYlqo3RFeO+ltfhwwF0SK8XY612+/VtXf8w/185jRcAxPQe73
 sO6zDvVZH8GEknnWyLPFpg1rOR6hYTTqxpLQxqZWMRBz8KSx6Ad9mjskTz8wFYIT/VD6
 rFWwu2wBXSiEo6lbTew62YpmHD0tWMZ7xsFyS0yfDd47kZCpi6wDTMM9hIAoGi1JkqDp
 laMPXLRfnxlKyHtw/I4PKEmMQI+cIC8NbOMXZo1LdMPIP0oXHeKYUIjK6r/+OADqecTS
 rBLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt8Gy2W8+V19tQSgwOHOFrsMmKf93gDzrPq8FOjukqpPKT0isPIIh2ih5Wlh/q/+a9flyvk/GCTWrB@nongnu.org
X-Gm-Message-State: AOJu0YwIPl9lxPJ7qvwqSTQnDAY0oqWWFSyuWrtl6IiErT0TLoet7DKZ
 F4SNFLYnlE0scvV0vQN83JRDGakJVogcV8gBWUCvEvpK9sNkR12l9t8N1w8Fcu+ApOavfhzTCbE
 LBBHB+Cif3fvegDbtgwXLCc5m1B/s0SRsCnfPbkDnctVxGgX2oUbupzGx
X-Gm-Gg: ASbGnctZSdCcvwA8IPXSYMg/Nw0+srSc6OeTjpANkvs0Pegn1M1quvm0NnABeZLiIH/
 Aba40Fzr7W4D8G8UdsvfLo+ugv1jtL4KC0qXSK0xdEGdLAqxTubPqLe4v1RBF6wbv2V5cjIy6xU
 2MkS+du2CW4T32Rc1S9Y8Bvu4tfEF/TetJJeOz4WO01hgTpnTmzlQWhYJfjwTX0sJkfi+Vry2ys
 57cyAp1kQ23Hthty/aOSz5AGIhSj54IyhAel6m7WmyzykYKfvv8wxmYPdG4yknZLBIoe1yeIZL2
 qgJ/8rZ2fi8QmIPwayW3Y1vfGm/BGZIS
X-Received: by 2002:a05:622a:590a:b0:4b3:4fa9:4cd2 with SMTP id
 d75a77b69052e-4e6eb04f536mr448967041cf.33.1760473518624; 
 Tue, 14 Oct 2025 13:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvL8nMo+yMQL9jDt2bTIFDJJ4LSClUVIVWClLmjGbS38/A/PIMKCga5BfwCH44U3dnC2JqZg==
X-Received: by 2002:a05:622a:590a:b0:4b3:4fa9:4cd2 with SMTP id
 d75a77b69052e-4e6eb04f536mr448966571cf.33.1760473518052; 
 Tue, 14 Oct 2025 13:25:18 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881d04210sm4935981cf.23.2025.10.14.13.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:25:16 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:25:14 -0400
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
Message-ID: <aO6xqt5_1PDBwOwu@x1.local>
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
 <20251010173957.166759-17-vsementsov@yandex-team.ru>
 <aO57SKp86zX2R8mV@x1.local>
 <6da192b9-7609-4cc8-82a9-1a445ecb10c9@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6da192b9-7609-4cc8-82a9-1a445ecb10c9@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Oct 14, 2025 at 10:31:30PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 14.10.25 19:33, Peter Xu wrote:
> > On Fri, Oct 10, 2025 at 08:39:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > To migrate virtio-net TAP device backend (including open fds) locally,
> > > user should simply set migration parameter
> > > 
> > >     backend-transfer = ["virtio-net-tap"]
> > > 
> > > Why not simple boolean? To simplify migration to further versions,
> > > when more devices will support backend-transfer migration.
> > > 
> > > Alternatively, we may add per-device option to disable backend-transfer
> > > migration, but still:
> > > 
> > > 1. It's more comfortable to set same capabilities/parameters on both
> > > source and target QEMU, than care about each device.
> > 
> > But it loses per-device control, right?  Say, we can have two devices, and
> > the admin can decide if only one of the devices will enable this feature.
> > 
> 
> Right. But, in short:
> 
> 1. I'm not sure, that such granularity is necessary.
> 
> 2. It may implemented later, on top of the feature.

I confess that's not a good example, but my point was that it was
straightforward idea to have two layers of settings, meanwhile it provides
full flexiblity.

> 
> > > 
> > > 2. To not break the design, that machine-type + device options +
> > > migration capabilities and parameters are fully define the resulting
> > > migration stream. We'll break this if add in future more
> > > backend-transfer support in devices under same backend-transfer=true
> > > parameter.
> > 
> > Could you elaborate?
> > 
> > I thought last time we discussed, we planned to have both the global knob
> > and a per-device flag, then the feature is enabled only if both flags are
> > set.
> 
> Right, here in v3: https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01644.html
> 
> Still at this point, I also needed local-incoming=true target option, so I
> considered all the parameters like "I can't make feature without extra
> per-device options, so here they are".
> 
> A day later, after motivating comment from Markus (accidentally in v2),
> I found and suggested the way:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01960.html
> 
> And further versions v4-v7 were the realization of the idea. Still, main
> benefit is possibility to get rid of per-device local-incoming=true
> options for target, not about a kind of per-device "capability" flag we
> discuss now.
> 
> A, and here I said [1]:
> 
> > 1. global fds-passing migration capability, to enable/disable the whole feature
> > 
> > 2. per-device fds-passing option, on by default for all supporting
> > devices, to be
> > able to disable backing migration for some devices. (we discussed it
> > here: https://lore.kernel.org/all/aL8kuXQ2JF1TV3M7@x1.local/ ).
> > Still, normally these options are always on by default.
> > And more over, I can postpone their implementation to separate series,
> > to reduce discussion field, and to check that everything may work
> > without additional user input.
> 
> And then, went this way, postponing realization of per-device options..

Postponing the per-device flag might still break different backends if you
specify the list with virtio-net-pci.

But only until now, I noticed you were using "virtio-net-tap" instead of
"virtio-net-pci".

Ouch.. I think that's even more complicated. :(

Here I think the problem is, introducing some arbitrary strings into
migration QAPI to represent some combinations of "virtio frontend F1" and
"virtio backend B1" doesn't sound the right thing to do.  Migration ideally
should have zero knowledge of the device topology, types of devices,
frontends or backends.  "virtio-*" as a string should not appear in
migration/ or qapi/migration.json at all..

> 
> And then, developing similar migration for vhost-user-blk, found
> that I can't use on boolean capability for such features, the reason
> in commit message, which we discuss now.

Why a bool isn't enough?  Could you share a link to that discussion?

> 
> Than, current design came in v5 (v4 was skipped).. And I even got an
> approval from Fabiano :)
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg03999.html
> 
> > 
> > If these parameters are all set the same on src/dst, would it also not
> > break the design when new devices start to support it (and the new device
> > will need to introduce its own per-device flags)?
> 
> Yes, right.
> 
> I missed, that, "postponing (probably forever)" per-device options
> realization, I started to implement another way to solve the same
> problem (switching from one boolean capability to a backend-transfer
> list).
> 
> In other words, if at some point implement per-device options, that will
> partly intersect by functionality with current complex migration
> parameter..
> 
> -
> 
> But still, I think, that parameter backend-transfer = [list of targets]
> is better than per-device option. With per-device options we'll have to
> care about them forever. I can't imagine a way to make them TRUE by
> default.
> 
> Using machine type, to set option to TRUE by default in new MT, and to
> false in all previous ones doesn't make real sense: we never migrate on
> another MT, but we do can migrate from QEMU without support for
> virtio-net backend transfer to the QEMU with such support. And on target
> QEMU we'll want to enable virtio-net backend-transfer for further
> migrations..

So this is likely why you changed your mind.  I think machine properties
definitely make sense.

We set it OFF on old machines because when on old machines the src QEMU
_may_ not support this feature.  We set it ON on new machines because when
the QEMU has the new machine declared anyway, it is guaranteed to support
the feature.

We can still manually set the per-device properties iff the admin is sure
that both sides of "old" QEMUs support this feature.  However machine
properties worked like that for many years and I believe that's how it
works, by being always on the safe side.

> 
> So, I think, modifying machine types is wrong idea here. So, we have to
> keep new options FALSE by default, and management tool have to care to
> set them appropriately.
> 
> -
> 
> Let's look from the POV of management tool.
> 
> With complex parameter (list of backend-transfer targets, suggested with
> this series), what should we do?
> 
> 1. With introspection, get backend-transfer targets supported by source
>    and target QEMUs
> 2. Get and intersection, assume X
> 3. Set same backend-transfer=X on source and target
> 4. Start a migration
> 
> But with per-device parameters it becomes a lot more complicated and
> error prone
> 
> 1. Somehow understand (how?), which devices support backend-transfer on
>    source and target
> 2. Get an intersection
> 3. Set all the backend-transfer options on both vms correspondingly,
>    doing personal qom-set for each device
> 4. Start a migration
> 
> -
> 
> In short:
> 
> 1. per device - is too high granularity, making management more complex

If we follow the machine property way of doing this (which I believe we
used for years), then mgmt doesn't need any change except properly enable
fd-passing in migration cap/params when it's a local migration.  That's
all.  It doesn't need to know anything about "which device(s) supports
fd-passing", because they'll all be auto-set by the machine types.

> 
> 2. per feature - is what we need. And it's a normal use for migration
> capabilities: we implement a new migration feature, and add new
> capability. The only new bit with this series is that "we are going to"
> implement similar capabilities later, and seems good to organize them
> all into a list, rather than make separate booleans.
> 
> 
> > 
> > > 
> > > The commit only brings the interface, the realization will come in later
> > > commit. That's why we add a temporary not-implemented error in
> > > migrate_params_check().
> > > 
> 
> [..]
> 
> > > +bool migrate_virtio_net_tap(void)
> > > +{
> > > +    MigrationState *s = migrate_get_current();
> > > +    BackendTransferList *el = s->parameters.backend_transfer;
> > > +
> > > +    for ( ; el; el = el->next) {
> > > +        if (el->value == BACKEND_TRANSFER_VIRTIO_NET_TAP) {
> > 
> > So this is also something I want to avoid.  The hope is we don't
> > necessarily need to invent new device names into qapi/migration.json.
> > OTOH, we can export a helper in migration/misc.h so that devices can query
> > wehther the global feature is enabled or not, using that to AND the
> > per-device flag.
> > 
> 
> Understand. But I can't imagine how to keep management simple with per-device
> options..
> 
> -
> 
> What do you think?

I feel like you wanted to enable this feature _while_ using an old machine
type.  Is that what you're looking for?  Can you simply urge the users to
move to new machine types when looking for new features?  I believe that's
what we do..

MT properties were working like that for a long time.  What you were asking
is fair, but if so I'd still like to double check with you on that's your
real purpose (enabling this feature on NEW qemus but OLD machine types, all
automatically).

Thanks,

-- 
Peter Xu


