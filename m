Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4862EC5AD69
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 20:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtX7G-0005lq-48; Fri, 20 Feb 2026 15:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vtX7C-0005kS-RK
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 15:28:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vtX7A-0005f0-Ci
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 15:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771619317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/48DeeAFSXbOHRgzgfj1Dvf3GpZcG6f2yHrcvSYykPE=;
 b=LWYT9a3Xx1WzIxREbda4DyXryTJjDoTHiA1ldFTu0lyyHzlfJNKSzTPMrdA4DMs6XodE8e
 LuQH+imIfL92UTxGLBi0mr6Q9/BSNHZ0gdyukJF7g8gqE5+4Eaqm86LA17307cwZf4M1UN
 i+PsCuq6rg8wt4jsNz/yQUNMyLlfbUw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-56g41R6KOnmRPYuOITdchA-1; Fri, 20 Feb 2026 15:28:36 -0500
X-MC-Unique: 56g41R6KOnmRPYuOITdchA-1
X-Mimecast-MFC-AGG-ID: 56g41R6KOnmRPYuOITdchA_1771619315
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a79164b686so39456425ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 12:28:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771619315; cv=none;
 d=google.com; s=arc-20240605;
 b=EmiNfnZA7To7BQDNXohHtbqz/4+t9+6vRmTfIOvaG7lIiulCc8bRYM6xD9BVhjBmi/
 l7W9Bu/HsCot7klV8+K7hcJikhTNHhajRKavjSPpU3jBBhnczxenTKLjZZSK5v8RZE0w
 J3rH7NHxfzbsSUYc00eCXRbCTKqkHzHM/wngOqXu1Yx5LQ85EthYT4Nid3TljWHHloW6
 8xm04zIivLMYLbzAHB5euTYKI3mS85CjP3XMy1bGlR6t6SQY2SxFRQmWm/FEXwHwKjpS
 11FGRgBVeQJt52QWO3ZvmVWCFUTDNvzPxFtz15yBcRsRCFjqfeFdNW5+WJKosPUxOZQw
 O/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/48DeeAFSXbOHRgzgfj1Dvf3GpZcG6f2yHrcvSYykPE=;
 fh=lG2r3kfSk76tY8Nc20WHgvISZsSELbVu3NxKSMvFTBY=;
 b=UvKDRmyog0h71NOFP4xJ77yhLSOiojM46zcCY9N4mXAWXqsMNVZ3TCmGRnYubsmuZJ
 Qa5HRG4PqdxdhYs/9AMksxu/n8riZ0+KxoAVvPCoivvPtF7kxTO6s7gjtYKmJ85pdnK1
 ibzg2SW9LxnlJLHdp3TcdI90XD7sO+Lb9KOOHTn9KwhuDXhQUuuJnepvYA/PJFnErSX1
 NmqsTIwysF7eQ91TMSoAmdZzdKIh3Wi0I1Q/5lb5WDPnpu/Hr7c0QdjBRpdIZ1pw7kLq
 Rc46obsZ8RL6NDBuogwxlAUIGZuOpUltAuIE8eUAwOALe2mlW+Es7yYE24jyhUDvR86l
 IbLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771619315; x=1772224115; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/48DeeAFSXbOHRgzgfj1Dvf3GpZcG6f2yHrcvSYykPE=;
 b=n2jf9VqN5TMeD5u74uyZrogo4oBJ0/r5oaNJ2d+snu5RtP9ruIrsvF7vFj6ZslqJww
 SDspiAD6ue9yywYlFZ/GHdMUKkvXtR8MExd/yMAUwG7EgEOGz3bIADlHvWQUxM2LG0eb
 Wrp7CQ2u8BetyVFjpeFN/KLRmaBwiOSJlObXl5gZGXhQ/AL833FU2E0C/542Xe5Qrq6k
 M0i+IPl/tC6be5bM2HUy+58gwtYEaJ8FXyPmAIm7+j/21ZYZ7ZYHutw5K7sZo3kUnfd2
 e/cWkFJaXvqOtYpCBLKYWOqggtrwB/0KSrxscDXAhm7IPFo14iQRbG7RbPk7EGJ8QQnb
 KnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771619315; x=1772224115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/48DeeAFSXbOHRgzgfj1Dvf3GpZcG6f2yHrcvSYykPE=;
 b=qTytBzluTJ82YVHRhhYkUeHFpX6ItgafCX3pwgmTf4GU+aYS7wppvTH7oSSapP3ZjB
 /QgCgJ+BP9Y/XsVc7i/sgc5mVcAfS8zo/tBrGKe/Wmc+5R+lE7rIOXdaJNarRAGBoPlS
 RIHJFwnr25NrUSLTcKTn8n2/GDXaCT3F78rxhmd1bGZiwQD11B0cnGJRElqKrlz3yDJX
 hl7XJTGFlQvTM20GAsWzQlMai8uTTptNLqoTtA5ebI52jzxkXa1SPOcu1KF/Ooy9aXAa
 xTv7tDReV/X4BQ2U3Umb+sF5EQhbEE9DBaJ0j93tk3bFaBvGHT/0tSkQn9Unddj4K/ln
 dfWQ==
X-Gm-Message-State: AOJu0YwTCmzonpy8vob1tHgur2Fq7MWK+r5aaImCfBQcE0srzWIotBRb
 zIvwTW8Lkz75G7LbikDzQM5DNfHM2YcnRGYxjEVV345voNd9p4yi6g1OfBUeTpv/YmKwwQBcSzI
 /+ezOCqv6dd5zowrfL5WhHL82exOj4na7F1JIPDPM3kNAG6VEVrFurxTC3UkmMGP6bICT64xCTh
 QZu15iKJOq5KSkTJ0L4BRrypT/pgDTPOc=
X-Gm-Gg: AZuq6aLNglWgEO/9nDgOvNW/572IIOrM6fW6NCSLiK1x/PGhaWK252s/Z/EovKMamoR
 kqppa1K8v5oOmzQsS7FTXhjOg8XD+CZ83fBpBWorgTYXDIPaBeL7smTwSaAFQD2uWGWOJE0FsID
 t6hEJ2dj2NKXSYjGZot2nXbpsAfH1A8Cx6vI5elWK6xegz+DlhkBBPdtaLDgJ7klMSnacI1HUF2
 f3F12kur7L9rC1l39tKRxgQcz9w5YlBBqqR+w==
X-Received: by 2002:a17:90b:562d:b0:356:2872:9c50 with SMTP id
 98e67ed59e1d1-358ae8eaed3mr616541a91.35.1771619315068; 
 Fri, 20 Feb 2026 12:28:35 -0800 (PST)
X-Received: by 2002:a17:90b:562d:b0:356:2872:9c50 with SMTP id
 98e67ed59e1d1-358ae8eaed3mr616521a91.35.1771619314667; Fri, 20 Feb 2026
 12:28:34 -0800 (PST)
MIME-Version: 1.0
References: <20260204100708.724800-1-marcandre.lureau@redhat.com>
 <20260204100708.724800-7-marcandre.lureau@redhat.com>
 <aZdnDrs9ivLctEIj@x1.local>
In-Reply-To: <aZdnDrs9ivLctEIj@x1.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 20 Feb 2026 21:28:23 +0100
X-Gm-Features: AaiRm50yX9GlRKPEH4YFffQtdOOsyPXPDbVGDGEckzbk5UhrHfiBW2nsykpY7jA
Message-ID: <CAMxuvax5uYVr0V3qKFV3t63BLkdqJco5thx23EKggH_dbKsAdQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] system/memory: split RamDiscardManager into source
 and manager
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 kvm@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Kanda <mark.kanda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Thu, Feb 19, 2026 at 8:40=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Feb 04, 2026 at 02:07:02PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Refactor the RamDiscardManager interface into two distinct components:
> > - RamDiscardSource: An interface that state providers (virtio-mem,
> >   RamBlockAttributes) implement to provide discard state information
> >   (granularity, populated/discarded ranges, replay callbacks).
> > - RamDiscardManager: A concrete QOM object that wraps a source, owns
> >   the listener list, and handles listener registration/unregistration
> >   and notifications.
> >
> > This separation moves the listener management logic from individual
> > source implementations into the central RamDiscardManager, reducing
> > code duplication between virtio-mem and RamBlockAttributes.
> >
> > The change prepares for future work where a RamDiscardManager could
> > aggregate multiple sources.
>
> The split of sources v.s. manager makes sense to me.
>
> I didn't follow the whole history of how the discard manager evolved, but
> IIUC it was called "discard manager" only because initially we were prett=
y
> much focused on the DONTNEED side of things so that when things got dropp=
ed
> we need to notify.
>
> However IIUC the current status quo of the discard manager covers both
> sides (population and discards).  It maintains what ranges of memory is
> available in general for consumption by listeners.
>
> For that, I wonder if during this major refactoring we should think about
> renaming this slightly misleading name.  Considering that the major
> difference of such special MR (either managed by virtio-mem or ramattr) i=
s
> about its "sparseness": say, not all of the memory is used but only a
> portion of it to be used in a somehow sparsed fashion, maybe
> SparseRamSources / SparseRamManager?  Another option I thought about is
> DynamicRam*.
>
> No strong feelings on the namings.  But raising this up in case you also
> think it might be a good idea.

That makes sense, it can be done later though, it's not blocking imho

>
> [...]
>
> > @@ -699,50 +682,60 @@ struct RamDiscardManagerClass {
> >       * @replay_discarded:
> >       *
> >       * Call the #ReplayRamDiscardState callback for all discarded part=
s within
> > -     * the #MemoryRegionSection via the #RamDiscardManager.
> > +     * the #MemoryRegionSection via the #RamDiscardSource.
> >       *
> > -     * @rdm: the #RamDiscardManager
> > +     * @rds: the #RamDiscardSource
> >       * @section: the #MemoryRegionSection
> >       * @replay_fn: the #ReplayRamDiscardState callback
> >       * @opaque: pointer to forward to the callback
> >       *
> >       * Returns 0 on success, or a negative error if any notification f=
ailed.
> >       */
> > -    int (*replay_discarded)(const RamDiscardManager *rdm,
> > +    int (*replay_discarded)(const RamDiscardSource *rds,
> >                              MemoryRegionSection *section,
> >                              ReplayRamDiscardState replay_fn, void *opa=
que);
>
> A major question I have here is how we should process replay_populated()
> and replay_discarded() when split the class.
>
> I had a gut feeling that this should not belong to the *Source object,
> instead it might be more suitable for the manager?
>
> I read into some later patches and I fully agree with your definition of
> aggregations when there're multiple sources, which mentioned in the commi=
t
> messsages later of this part:
>
>     The aggregation uses:
>     - Populated: ALL sources populated
>     - Discarded: ANY source discarded
>
> IOW, a piece of mem that is "private" in terms of ram attr manager, but
> "populated" in terms of virtio-mem, should be treated as discarded indeed=
.
>
> However I also saw that in some follow up patches the series did a trick =
to
> fetch the first Source then invoke the replay hook on the first source:
>
> int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
>                                          const MemoryRegionSection *secti=
on,
>                                          ReplayRamDiscardState replay_fn,
>                                          void *opaque)
> {
>     RamDiscardSourceEntry *first;
>     ReplayCtx ctx;
>
>     first =3D QLIST_FIRST(&rdm->source_list);
>     if (!first) {
>         return replay_fn(section, opaque);
>     }
>
>     ctx.rdm =3D rdm;
>     ctx.replay_fn =3D replay_fn;
>     ctx.user_opaque =3D opaque;
>
>     return ram_discard_source_replay_populated(first->rds, section,
>                                                aggregated_replay_populate=
d_cb,
>                                                &ctx);
> }
>
> It seems to me that aggregated_replay_populated_cb() will indeed still do
> the proper aggregations, however if we could move the replay functions in=
to
> the manager (or do we need it to be a hook at all?  Perhaps it will just =
be
> an API of the manager?), then we don't need this trick of fetching the 1s=
t
> source, instead the manager should do the math of "AND all the sources on
> reported populated info" then invoke the listener handlers.  Maybe that'l=
l
> be cleaner from the high level.
>
> What do you think?


Do you mean that we could drop replay_populated/replay_discarded from
the source? I think we could. replay_by_populated_state() already
handles the aggregation logic by using is_populated() alone. There
isn't much gain in the above implementation narrowing the iteration
from the first source replay.

thanks for the review


