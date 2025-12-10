Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500DBD3C92B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 16:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTMt1-0006ht-54; Wed, 10 Dec 2025 11:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTMsz-0006hL-9t
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTMsw-0006Yv-JU
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765383468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41y1zzghdEcNS++aePV9Pl0wglMyTIC4EdeA5Ciiu14=;
 b=S+FHHiP7daa7EZ8DGUg47VPnAhRrOa+Vhm+UL4XaBUK33mOxHxaKyenSS/1m3haj58Rjgt
 luXYjrJLpwDiODmuYn++YFh5hFXDGPU2rHJGvgpjJtohgGUgEaOJRZYaMTiTAKVPhf/ZqI
 yw8Zm4fyxdhKCAWC2EPtK3R7XcdVvQY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-YM4mfMZDOpyDIYGC9uITEA-1; Wed, 10 Dec 2025 11:17:47 -0500
X-MC-Unique: YM4mfMZDOpyDIYGC9uITEA-1
X-Mimecast-MFC-AGG-ID: YM4mfMZDOpyDIYGC9uITEA_1765383466
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee0995fa85so218274511cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 08:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765383466; x=1765988266; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=41y1zzghdEcNS++aePV9Pl0wglMyTIC4EdeA5Ciiu14=;
 b=t7eUsSdqe/cHzGvjbGsAoMv5bdm+hqxu+6Pbjm9pgyeBWT0uRzI9ttwgHYe1Ch0MAq
 YwYsgQQ7W+DRk2UYO2cvss1c1FB3qh7rdGIExyBG+cCPFT7D9+iyJEtDnXCaNvJGbneI
 GRnE/hE3/XtdCTXZlWWzKJHFMbVx9t1ymMvaifb23IkScpYHVfI0Cnl9KfvDbn+3nmXX
 ywI1+Sk8bvvAplSDew1nsdgW1clMfY4QxDOiuGsZnwvieiSqpYBYSIXk304FT4bhEN4U
 olnyClAw6B8TsEK+3iY8H6KTXBwLXlwCIcfJ8BXGWf2fxD/muncqi3OnbLAZWI3w3wkS
 Jjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765383466; x=1765988266;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=41y1zzghdEcNS++aePV9Pl0wglMyTIC4EdeA5Ciiu14=;
 b=C8TvhTmXOlH0ewhFXLN5mfZ6NLn+pQsaOpo7zIMA1UzQ6HCQFpAwR++Y8KS7y5N5vB
 fTWAt2G0G6fl/xpfvx39LfSIxq+tUymh+7x4tQsoIHDRmctspRHxXLTsTKRVTeqK5DeD
 C+LY7jrH54/IB3UtkEVao+ICn3rZoMsmKCC56hIokvgkFjoOL6b95/Qe0fjcPeE8idgw
 IG8mw0tmEWvew1U+kCnOb93t+u6lFB4J3aeaI+k80Fd1yADCBLOYxiav6maAaBdT9SWn
 mRg8lPN/hoz4KkR6DTf6+/m0NLsQbvskwFmPd0VlOs9+7chV7mupJNXFSudrnd08k8HY
 7UpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9MwFk9yFaY6na87YD+Ch+8hyQK8KL8X3vdiRF6UEa7ipj1IC3gxJ5Vb+Pn44OtTirkyqG6UWTH8Dd@nongnu.org
X-Gm-Message-State: AOJu0YxE4mlJfTZAvW3u8lorw25U2aepEpdHgISL7zE4epH5qa0wWs5i
 rwC6njV0oe1x7ylsbAvX/ypEOeN9PZ4y8hutxRZIF75X9hLyTAOGAhvhdpCfoJERUHCl+JAczJw
 RYonAfxRkBllVF579JPaQlg1DplLEnQHtpKbutAPTCAv3Uc8/H2i6V4fc
X-Gm-Gg: ASbGncsV16z3bd2vLZ7qzimNLTdsinHwIHL7uclo3AbDuUTJpG62nVTVM2pn6trYyRK
 aFKTy72X3flkNDLAPQ9xx3nWlFkW6pXSz7IMOm+OPNQuAx5Z37/kQ4s9rciAV1LG0mHC4y9vdz8
 A4E7khe4oHdJ6OpXRd0BL0JOfGl5ZL8ZnMPIAconl+2T+IofZCF9ul7+qFAqWkbFAIiy9RhVBOq
 A4BthoF9avo6uKsxtxVnL8hKIcyDz07LAEd0vrH1TZULcoRpk38HPZTDlplxCztZaX5vmi7ShkL
 RVfHBn23LffrWYini2v79067jboh/CtO2HCywfrRyKoUQ6D0NsK5WYkrLJ24+xqqQxbLxueUclI
 GHcM=
X-Received: by 2002:a05:622a:1450:b0:4ec:e1aa:ba4a with SMTP id
 d75a77b69052e-4f1b19b8823mr35989371cf.1.1765383466335; 
 Wed, 10 Dec 2025 08:17:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg3KGNc9cD30NUFbrcWhD9VXgdxPcZB7lV+cx7xq5G3UyL3Dh8ztqx9RmlldCe12ES9YJIbw==
X-Received: by 2002:a05:622a:1450:b0:4ec:e1aa:ba4a with SMTP id
 d75a77b69052e-4f1b19b8823mr35988721cf.1.1765383465659; 
 Wed, 10 Dec 2025 08:17:45 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02766991fsm127790191cf.2.2025.12.10.08.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 08:17:45 -0800 (PST)
Date: Wed, 10 Dec 2025 11:17:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
Message-ID: <aTmdJ5H67mk8qmSC@x1.local>
References: <20251209162857.857593-1-peterx@redhat.com>
 <aTlZIlgB20OpdSEl@redhat.com> <aTle5C2pN8ZslZX7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTle5C2pN8ZslZX7@redhat.com>
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

On Wed, Dec 10, 2025 at 11:52:04AM +0000, Daniel P. Berrangé wrote:
> On Wed, Dec 10, 2025 at 12:27:30PM +0100, Kevin Wolf wrote:
> > Am 09.12.2025 um 17:28 hat Peter Xu geschrieben:
> > > [This is an RFC series, as being marked out.  It is trying to collect
> > >  opinions.  It's not for merging yet]
> > > 
> > > Background
> > > ==========
> > > 
> > > It all starts with machine compat properties..
> > > 
> > > Machine compat properties are the major weapon we use currently in QEMU to
> > > define a proper guest ABI, so that whenever we migration a VM instance from
> > > whatever QEMU version1 to another QEMU version2, as long as the machine
> > > type is the same, logically the ABI is guaranteed, and migration should
> > > succeed.  If it didn't, it's a bug.
> > > 
> > > These compat properties are only attached to qdev for now.  It almost
> > > worked.
> > > 
> > > Said that, it's also not true - we already have non-qdev users of such, by
> > > explicitly code it up to apply the compat fields.  Please refer to the
> > > first patch commit message for details (meanwhile latter patches will
> > > convert them into a generic model).
> > > 
> > > Obviously, we have demands to leverage machine compat properties even
> > > outside of qdev.  It can be a network backend, it can be an object (for
> > > example, memory backends), it can be a migration object, and more.
> > 
> > This doesn't feel obvious to me at all. A machine type defines what
> > hardware the guest sees. Guest hardware is essentially qdev.
> > 
> > I don't see any reasons why a backend should be interested in what guest
> > hardware looks like, that would seem like a bad layering violation. Many
> > backends can even exist without a guest at all, and are also used in
> > tools like qemu-storage-daemon. Having a machine type in a tool that
> > doesn't run a guest doesn't make any sense.
> 
> The sev-guest compat property for 'legacy-vm-type' is an interesting
> example.
> 
> This property ultimately controls which of two different kernel ioctls
> for KVM are used for initializing the SEV guest. It can casue guest
> VM measurement changes, but none the less this is not really a guest
> ABI knob, it is a host kernel compatibility knob.  You need a newer
> host kernel version if this is set to 'off'.
> 
> So by associating this legacy-vm-type type with the machine type,
> we don't affect the guest hardware, but we *do* impact the ability
> to use that machine type depedning on what kernel version you have.

Yes.

Maybe I emphasized too much on "guest ABI" in the cover letter, so it can
be confusing when not reading into the details of the patchset (I did
mention all the existing users in patch 1, then converted all existing
users in patch 2-5).

Besides SEV, I can also quickly go over the rest ones if that wasn't clear
we're already using this feature.. in a open-coded way.  Maybe that'll make
it slightly easier to grasp for reviewers.

The current use case for hostmem (2nd example) on compat properties, see:

    commit fa0cb34d2210cc749b9a70db99bb41c56ad20831
    Author: Marc-André Lureau <marcandre.lureau@redhat.com>
    Date:   Wed Sep 12 16:18:00 2018 +0400

    hostmem: use object id for memory region name with >= 4.0

So that's not strictly "guest ABI", but the goal was to persist the name of
MRs so that migration is not broken.  It's not strictly "guest ABI" but
more like "guest ABI for migration" - even if the guest OS cannot see the
names of MRs, migration can see (via ramblocks).  So it can be more than
the guest HWs.

3rd example in accel:

    commit fe174132478b4e7b0086f2305a511fd94c9aca8b
    Author: Paolo Bonzini <pbonzini@redhat.com>
    Date:   Wed Nov 13 15:16:44 2019 +0100

    tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"

That was trying to keep some old behavior for accel cmdlines.  It's not
even a migration ABI, but cmdline ABI.

Hence OBJECT_COMPAT might be useful whenever we want to persist some ABI.
It can be machine compat properties, it can be something else that has
nothing to do with machine types.  The accel example used a separate entry
in object_compat_props[] (index 0) for the same purpose, out of three:

/*
 * Global property defaults
 * Slot 0: accelerator's global property defaults
 * Slot 1: machine's global property defaults
 * Slot 2: global properties from legacy command line option
 * Each is a GPtrArray of GlobalProperty.
 * Applied in order, later entries override earlier ones.
 */
static GPtrArray *object_compat_props[3];

> 
> IOW, QEMU machine types version 9.1 or later are no longer runnable
> on many old kernels.
> 
> Over the years we've had a good number of occassions where we want
> defaults changes, or worse, where we auto-negotiate features, which
> depend on host kernel version.
> 
> I've suggested in the past that IMHO we're missing a concept of a
> "versioned platform", to complement the "versioned machine" concept.
> 
> That would let mgmt apps decide what platform compatibility level
> they required, independantly of choosing machine types, and so avoid
> creating runability constraints on machine types.

Yes, I agree some kind of "versioned platform" would be nice.  In practise,
I wonder if it needs to be versioned at all, or something like a
query-platform QMP API that will return the capabilities of the host in
QEMU's view.  Maybe versioning isn't needed here.

Taking USO* feature for virtio-net as example, it should report what kind
of USO* features are supported on this host.

IMHO it doesn't need to be the "yet another" weapon to define guest ABI /
QEMU ABI.

Mgmt should leverage that interface to query and get platform informations
across the whole cluster, then find a minimum set. Maybe also plus
something the user would specify, for example, an user may want to
explicitly disable USO feature on the whole cluster, then mgmt should also
take it into account.

After the min subset of platform features selected, mgmt will need to map
them into device properties and apply then when booting VM.  Then guest ABI
is guaranteed.

So I think it might still be good we stick with the solo way to define the
ABI, I hope we can stick with machine types.

There're also other things that may not be attached to platform
capabilities, like the current discussion in:

https://lore.kernel.org/all/20251030203116.870742-1-vsementsov@yandex-team.ru/

That is about some new capability of network backend (in this case, TAP)
that we should always enable for new QEMUs, but disable for old QEMUs.
Such won't appear at all in query-platform..  Current solution proposed in
that series was adding per-device special QMP commands to query and set
these features.  However IMHO essentially it's the same problem that
object_compat_props() is solving.  It's just that we need it to work
outside of QDEV.

With OBJECT_COMPAT, we could QOMify TAP into an object and inherit from
OBJECT_COMPAT.

Thanks,

> 
> > So if we do introduce some mechanism to provide different defaults for
> > compatibility with older versions, it has to be separate from machine
> > types.
> > 
> > Maybe it would make most sense to address this on the QAPI level then
> > and finally fully QAPIfy the command line. Adding defaults to the QAPI
> > schema is something that has come up again and again, so maybe we could
> > introduce that and do it in a versioned way from the start.
> 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

-- 
Peter Xu


