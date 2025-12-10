Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2798D3E77A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 20:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTQbO-0005hm-7u; Wed, 10 Dec 2025 15:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTQbM-0005he-8u
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 15:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTQbJ-0000FT-Mg
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 15:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765397751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yE35k1q8Hh0iyaiWLe8kI1okKHoZIPAlOxh8MmL2BN0=;
 b=IItcqZsay1F6McdDQzqXvylhu7MriY/R/0dU9vNp03brCIgmVAV2BGpLv8qBTNbmwc0HXW
 Bhooqf92vxqV8cWS079Dho7AxfzOAPnQoYfv3ErOHRtyMlXlzD7424gqOPF/NAqf0gGrtY
 0eI2oY3t6WpOZiiIubIp3aOTLSpc1kE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-3tmj4OBdMBmu3VF9QADJ9Q-1; Wed, 10 Dec 2025 15:15:50 -0500
X-MC-Unique: 3tmj4OBdMBmu3VF9QADJ9Q-1
X-Mimecast-MFC-AGG-ID: 3tmj4OBdMBmu3VF9QADJ9Q_1765397750
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b55a033a2aso63176485a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 12:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765397749; x=1766002549; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yE35k1q8Hh0iyaiWLe8kI1okKHoZIPAlOxh8MmL2BN0=;
 b=C/lEJE22StkijzGKNbVWQcx/W/kbGh26NIYHGaPfuKD1dcknINyY2YeKpyI+jK81jr
 G5bXdlqwKNePVKfDO4uGGmL5zrJ1hkjwGS6gUfndCh+oX+uEUKnsi/KTXf/qOd+zj9xJ
 Q5QbfR1NOkPay7y0pjesOIrWJvLnUn6bKSeZSpCKbtPnpkGH4aeVIIrgjAhlf1QHpJNo
 wIQHl9P32XTJsbLcZhF/LQ1zXjwg8aLm4dQsoQoMcT02bSX0Omi1FjSTCcfqkc8WrmA1
 hT6ToE1kn3K5Ob+TqcErl/Ltc+7mzJH5cL52C17gIUgQV5DKisTbMZnay0DKhDAqA1JL
 Jwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765397749; x=1766002549;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yE35k1q8Hh0iyaiWLe8kI1okKHoZIPAlOxh8MmL2BN0=;
 b=VZb5INum0GdEl+F6WgKvnKxxWwXZ4i+FUQwR9/kWGzWHSt7VNp5UcqV5nPMVWiXiGC
 ePFyrCQE3W68VGPIm7806iURRJ2VAPYGkhA29RVwrKhc9810PYEbcHI9Xz6KXEq7F1Np
 FV+bJkNKTTxTjCc+J6bD3r9TiYRyuvzvaIJpn6Tno/IZJwO/aGWL8j4H1NlSpzKqBQUG
 4CiNp4TTHkXBCHAZ4CvjS0eEyUWCCsD74/Tzflu0/ZHSf+OsXTpQ55uxdH/Rls7lK1NG
 zUsw1sp90eEV+P0WWbO8ARqXaOqakBdR8RrE5cjBr1AevD02XH+ZaXyiLtV2HU8PdDUz
 WGCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi+XiUTLx9G4eDe0dJsB2s83ewWN89ub2UqsqhOIRnQR4nevYBO0cgwoDyr/cMCS1PD9jABNy2Y7nY@nongnu.org
X-Gm-Message-State: AOJu0YyQRNxlOIo9DbOkBqf+yO1DH5wMZJeSp0beKSEbj3cQw2zjwFMq
 UbKWybUNq+T7pewiZGVsG90HhlLSC1vD5GUv2Y4yrtz9QJuB/w4tkTvrKKw8k2zi8zpuBRAjj1C
 aTbC75YSSOq9+VaO5rH/YSg33+KZEvvgHTvTlNgPI2tgxcEqY3johpzIl
X-Gm-Gg: ASbGncuHyYbC3ndtPs702ZATvw2eNGLy/dYFhGz1Rx886tbVoATSxTErN9cSYITy0l6
 gbDh+iS4lHAIDnaEjE9KCIRpbjwxW8IT7PHVpmN30RGapESwVrmc224iihFkni3kpLpxSTDUfyR
 ONZwnF3VYJ3j0UcemvakLkG+C7qEN82Beq0ohkAvSd0Cwoy5uEePtwgp9uFLBaz3mLX4P/Sl+Ta
 vOc5HzhTrBbryVi/kTmIrV+Fxmz5yUN85Lfnjdl2Eu/P4GhJn9ZcLqYAqy1XulzUYBkLjvG+e4e
 bG6FDrneR0LBSUnGRznk2qEDeSTi4+82kEjChOWhmL46kzLG6N1YT7ge64EubZBGva9oaEDB8tG
 tFuo=
X-Received: by 2002:a05:620a:628c:b0:891:e10a:9d3f with SMTP id
 af79cd13be357-8bab312ac5cmr85142385a.10.1765397749339; 
 Wed, 10 Dec 2025 12:15:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUZIOWSWI26YPkygJYL+Rxayb8S/p9pO3I+zpACTdV0YYOK5WkS8MIPr51SBP/Q4XJyJ8pow==
X-Received: by 2002:a05:620a:628c:b0:891:e10a:9d3f with SMTP id
 af79cd13be357-8bab312ac5cmr85137085a.10.1765397748724; 
 Wed, 10 Dec 2025 12:15:48 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8bab5d3da25sm34578585a.44.2025.12.10.12.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 12:15:48 -0800 (PST)
Date: Wed, 10 Dec 2025 15:15:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
Message-ID: <aTnU8oMqK9n5g2Y6@x1.local>
References: <20251209162857.857593-1-peterx@redhat.com>
 <aTlZIlgB20OpdSEl@redhat.com> <aTle5C2pN8ZslZX7@redhat.com>
 <aTmdJ5H67mk8qmSC@x1.local>
 <6b0f2fec-ddde-4b24-90f9-df906ac73253@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b0f2fec-ddde-4b24-90f9-df906ac73253@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 10, 2025 at 09:25:16PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 10.12.25 19:17, Peter Xu wrote:
> > On Wed, Dec 10, 2025 at 11:52:04AM +0000, Daniel P. Berrangé wrote:
> > > On Wed, Dec 10, 2025 at 12:27:30PM +0100, Kevin Wolf wrote:
> > > > Am 09.12.2025 um 17:28 hat Peter Xu geschrieben:
> > > > > [This is an RFC series, as being marked out.  It is trying to collect
> > > > >   opinions.  It's not for merging yet]
> > > > > 
> > > > > Background
> > > > > ==========
> > > > > 
> > > > > It all starts with machine compat properties..
> > > > > 
> > > > > Machine compat properties are the major weapon we use currently in QEMU to
> > > > > define a proper guest ABI, so that whenever we migration a VM instance from
> > > > > whatever QEMU version1 to another QEMU version2, as long as the machine
> > > > > type is the same, logically the ABI is guaranteed, and migration should
> > > > > succeed.  If it didn't, it's a bug.
> > > > > 
> > > > > These compat properties are only attached to qdev for now.  It almost
> > > > > worked.
> > > > > 
> > > > > Said that, it's also not true - we already have non-qdev users of such, by
> > > > > explicitly code it up to apply the compat fields.  Please refer to the
> > > > > first patch commit message for details (meanwhile latter patches will
> > > > > convert them into a generic model).
> > > > > 
> > > > > Obviously, we have demands to leverage machine compat properties even
> > > > > outside of qdev.  It can be a network backend, it can be an object (for
> > > > > example, memory backends), it can be a migration object, and more.
> > > > 
> > > > This doesn't feel obvious to me at all. A machine type defines what
> > > > hardware the guest sees. Guest hardware is essentially qdev.
> > > > 
> > > > I don't see any reasons why a backend should be interested in what guest
> > > > hardware looks like, that would seem like a bad layering violation. Many
> > > > backends can even exist without a guest at all, and are also used in
> > > > tools like qemu-storage-daemon. Having a machine type in a tool that
> > > > doesn't run a guest doesn't make any sense.
> > > 
> > > The sev-guest compat property for 'legacy-vm-type' is an interesting
> > > example.
> > > 
> > > This property ultimately controls which of two different kernel ioctls
> > > for KVM are used for initializing the SEV guest. It can casue guest
> > > VM measurement changes, but none the less this is not really a guest
> > > ABI knob, it is a host kernel compatibility knob.  You need a newer
> > > host kernel version if this is set to 'off'.
> > > 
> > > So by associating this legacy-vm-type type with the machine type,
> > > we don't affect the guest hardware, but we *do* impact the ability
> > > to use that machine type depedning on what kernel version you have.
> > 
> > Yes.
> > 
> > Maybe I emphasized too much on "guest ABI" in the cover letter, so it can
> > be confusing when not reading into the details of the patchset (I did
> > mention all the existing users in patch 1, then converted all existing
> > users in patch 2-5).
> > 
> > Besides SEV, I can also quickly go over the rest ones if that wasn't clear
> > we're already using this feature.. in a open-coded way.  Maybe that'll make
> > it slightly easier to grasp for reviewers.
> > 
> > The current use case for hostmem (2nd example) on compat properties, see:
> > 
> >      commit fa0cb34d2210cc749b9a70db99bb41c56ad20831
> >      Author: Marc-André Lureau <marcandre.lureau@redhat.com>
> >      Date:   Wed Sep 12 16:18:00 2018 +0400
> > 
> >      hostmem: use object id for memory region name with >= 4.0
> > 
> > So that's not strictly "guest ABI", but the goal was to persist the name of
> > MRs so that migration is not broken.  It's not strictly "guest ABI" but
> > more like "guest ABI for migration" - even if the guest OS cannot see the
> > names of MRs, migration can see (via ramblocks).  So it can be more than
> > the guest HWs.
> > 
> > 3rd example in accel:
> > 
> >      commit fe174132478b4e7b0086f2305a511fd94c9aca8b
> >      Author: Paolo Bonzini <pbonzini@redhat.com>
> >      Date:   Wed Nov 13 15:16:44 2019 +0100
> > 
> >      tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"
> > 
> > That was trying to keep some old behavior for accel cmdlines.  It's not
> > even a migration ABI, but cmdline ABI.
> > 
> > Hence OBJECT_COMPAT might be useful whenever we want to persist some ABI.
> > It can be machine compat properties, it can be something else that has
> > nothing to do with machine types.  The accel example used a separate entry
> > in object_compat_props[] (index 0) for the same purpose, out of three:
> > 
> > /*
> >   * Global property defaults
> >   * Slot 0: accelerator's global property defaults
> >   * Slot 1: machine's global property defaults
> >   * Slot 2: global properties from legacy command line option
> >   * Each is a GPtrArray of GlobalProperty.
> >   * Applied in order, later entries override earlier ones.
> >   */
> > static GPtrArray *object_compat_props[3];

[1]

> > 
> > > 
> > > IOW, QEMU machine types version 9.1 or later are no longer runnable
> > > on many old kernels.
> > > 
> > > Over the years we've had a good number of occassions where we want
> > > defaults changes, or worse, where we auto-negotiate features, which
> > > depend on host kernel version.
> > > 
> > > I've suggested in the past that IMHO we're missing a concept of a
> > > "versioned platform", to complement the "versioned machine" concept.
> > > 
> > > That would let mgmt apps decide what platform compatibility level
> > > they required, independantly of choosing machine types, and so avoid
> > > creating runability constraints on machine types.
> > 
> > Yes, I agree some kind of "versioned platform" would be nice.  In practise,
> > I wonder if it needs to be versioned at all, or something like a
> > query-platform QMP API that will return the capabilities of the host in
> > QEMU's view.  Maybe versioning isn't needed here.
> > 
> > Taking USO* feature for virtio-net as example, it should report what kind
> > of USO* features are supported on this host.
> > 
> > IMHO it doesn't need to be the "yet another" weapon to define guest ABI /
> > QEMU ABI.
> > 
> > Mgmt should leverage that interface to query and get platform informations
> > across the whole cluster, then find a minimum set. Maybe also plus
> > something the user would specify, for example, an user may want to
> > explicitly disable USO feature on the whole cluster, then mgmt should also
> > take it into account.
> > 
> > After the min subset of platform features selected, mgmt will need to map
> > them into device properties and apply then when booting VM.  Then guest ABI
> > is guaranteed.
> > 
> > So I think it might still be good we stick with the solo way to define the
> > ABI, I hope we can stick with machine types.
> > 
> > There're also other things that may not be attached to platform
> > capabilities, like the current discussion in:
> > 
> > https://lore.kernel.org/all/20251030203116.870742-1-vsementsov@yandex-team.ru/
> > 
> > That is about some new capability of network backend (in this case, TAP)
> > that we should always enable for new QEMUs, but disable for old QEMUs.
> > Such won't appear at all in query-platform..  Current solution proposed in
> > that series was adding per-device special QMP commands to query and set
> > these features.  However IMHO essentially it's the same problem that
> > object_compat_props() is solving.  It's just that we need it to work
> > outside of QDEV.
> > 
> > With OBJECT_COMPAT, we could QOMify TAP into an object and inherit from
> > OBJECT_COMPAT.
> > 
> > Thanks,
> > 
> 
> My two cents.
> 
> 1. QAPI vs QOM
> 
> First, QEMU has too many object-like interfaces: QOM, QAPI structures, vmstates..
> Of course, it would be better to have one generic. Should it be QAPI or QOBJECT?

Just to make sure we're on the same page - this series didn't introduce any
new concept.  Patch 1-6 can be seen as a "cleanup" because we already use
object compat properties before.

It was explicitly coded though to invoke object_apply_compat_props() in
whatever objects that care about it.  This "cleanup" introduced another
class so that explicit call (in most cases, post_init hook) can be avoided.

Side benefit is, anything else can start to inherit from OBJECT_COMPAT now
even if not a qdev, with no further open-coded invocations.

I need to confess I don't fully get how this can be defined in QAPI,
however no matter how it can be defined, we already have the QOBJECT
solution..  Some elaboration on that part would be helpful.

> 
> If I understand correctly, these series expand the QOBJECTS's zone of influence. And
> Kevin argue, that it could be QAPI instead. Right?
> 
> QOBJECT is better in a way that it represent existing in-QEMU state. QAPI structures
> are normally used only temporarily during QMP calls.
> 
> If everything was a QOBJECT, we probably should not have to invent all these -replace-
> and -change- commands in QMP for block layer object, but only implement set/get for
> corresponding QOBJECT properties. And we'd not have to unite the namespaces of
> qom paths, block export names and block node names, they all would be qom paths..
> 
> So we could live in the world, where we need to implement only "action" QMP commands,
> like "migrate", "quit", "cont". But to change/query the state, we always use qom-set
> qom-get, and don't invent a new command for each piece of state.
> 
> On the other hand, QAPI is a lot better in a way that it have explicit json schema.
> QAPI definition is a protocol specification in the same time, we don't have such
> thing for QOM. Probably the best world would be a QAPI-like interface to internal
> QEMU objects, which are defined by QAPI structures. A kind of combination of best
> options of QOM and QAPI worlds. But that's only a dream.

This part of discussion seems to have some block layer internals involved
that I'm not familiar with.  I'm not sure I get it, but I'll leave others
to chime in..

> 
> 2. Machine types
> 
> I'd not care about them too much. Machine type is a syntax sugar, it's simply a
> "set of defaults".
> 
> So, I think it's OK to share the concept wider than guest-ABI. What's wrong if
> we just rename "Machine Type" into "Set Of QOM Defaults", and follow Peter's
> suggestion? This way it will not conflict with tools that doesn't start the
> guest, or don't have frontends.

Yes, it's not only about machine types.  Per discussed above [1], literally
it was called object_compat_props[].

An object applies it with object_apply_compat_props().  Machine type is
only using index 1, and it's only one user of compat properties, only that
it's the major user.

Thanks,

-- 
Peter Xu


