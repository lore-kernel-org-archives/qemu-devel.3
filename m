Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB5ECDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcOaw-0001Xz-Ti; Wed, 24 Jun 2026 10:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wcOau-0001VS-29
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wcOas-0000oO-1Q
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782311323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nft1FJkaR8RruG3DipMG+IA54+9Qc9LeJUQlQ4FUC2g=;
 b=GjOEHKrqepJZuMNL+4xQawduBW/kqBfSN8y67j5EO5KGJdC5XmcztNKD0NMG+y5VczDKSW
 Kaf27ID9s24Epy5htU4yVrOxJhp11iV5GQKW+uvSk+U7agF6/b/MXKrZRjOQDQVGlTbw7t
 kc0RjCLTvv+H/BFUv7WGjto3DyJZHX8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-dXkONqsrPr2JCvTsh15xtg-1; Wed, 24 Jun 2026 10:28:42 -0400
X-MC-Unique: dXkONqsrPr2JCvTsh15xtg-1
X-Mimecast-MFC-AGG-ID: dXkONqsrPr2JCvTsh15xtg_1782311321
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ddd042321dso20359906d6.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782311321; x=1782916121; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nft1FJkaR8RruG3DipMG+IA54+9Qc9LeJUQlQ4FUC2g=;
 b=CwyVhGH0dQKyR+mRORTMFUQ7iddWbZlPnLvKxiOhcvbKkfaD+2la/cryT81r5CgwK0
 0cAE5hBvBF22mmZlu7u5XZKuLst0umeG6aGDu+sTf558KlBKtpYzJk1eN8banKQ2fAvz
 w+4TtbkbQNEQpeDHM9ARwvZQMDkAdUx3+TUJi8p28AOzbpk1K5pAx+xWcy8xRG14dOeE
 RJVPUE5GFSrDfqFRif3Q483xrNu3erqOlm6T1dLhBFkQiS1XCJrbDWuhBloHnqSOv+Gi
 DSM8yNT1sNE3z3/4PQKHQ7BR7PyTuvNm0OlnQf9+zdpudbDL2SrnqXGL0iJgvccnMa3c
 WYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782311321; x=1782916121;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nft1FJkaR8RruG3DipMG+IA54+9Qc9LeJUQlQ4FUC2g=;
 b=XRFw17GF//iD0B8+6FzxhwdT7YCDGkNxvZgDlRzDIF/5wzQpBQfqoB1rB3KZbLWnJ0
 J/PlEjKOlWxSYooh/s9Y0gX1oAPT6Q+r3NMp6hcjyY4huvYROXPq2uxLdW/Y0C2BmELf
 z65IwEjnlKfgD3lgarqYoUdTBeLTnCcQlQxEtY/Xwrms5xlipwHhdV1CKnDuNu2yoil2
 wbLaLHtrsZZTqS6K/cOHdbF9Vp34g7ID62pUjsHzE0pMrZO5skDtiRG/TKbnjAIpd37q
 yFrJQRHUZmUuv1ryjgVDX+0y2/ZXFUMIncY7WAymXbMVnMD1mkmq2IPTamr4uHJczVEm
 keMg==
X-Gm-Message-State: AOJu0YzHDo0oPeuWsRTJUXaZ0VzcyamtfYF1zUL5spYlreaZD8tnr/U4
 UDH3ieeb311Tma27b2uioesrJAkQQt3K+CLvjjnFD7zF0+rDPtQj9C3zRa2W/H7kFkO31LlZ0k4
 BWE49u3Mp6lmcPvoac16Sw4fPzhhRifYBDnjUIrgCvimS61ZMFKSNjmli
X-Gm-Gg: AfdE7cnX/1rUkopj9G/Q9kvyZUwaMk8QKghL8I8M2uGq5Ns8lOFSCH1y5TQpzen1jQD
 WSV8dkW8qw5Lk43gDsLpnJaoQSvovrxeY9yWvFC6Rb+RLsZfE1cUWjgKOGxDpSHZ8Mpal4H1tTv
 FVoz0YXlgbEFOlX1m8ZMJucNSm9YshMsHH13UM5DnVY6Z2X4M7CDstXyOS46y7DTi7OqGIho5zj
 qM39gamLUTtZl2lR25IFxEN10t7DSRzJzCbSUj/AWlEephfLT5qpBMuU/wFMgupy7CPp+ziLhRv
 nVdVfGHosFun/IDFjBeEjn/cTMs7hz5bmXR3olavsO7LsJbkpnrAaAai4r3GBYLPtBcsTWs2uYa
 zhtRb02bDLsa4l6jF8fN4mSwsPRmlPuSezIepndebQpVKn2W5Bepqb21WUbS24cvRg6GwJNbj
X-Received: by 2002:a05:6214:488e:b0:8cc:d29:9f78 with SMTP id
 6a1803df08f44-8df8f90f599mr370865476d6.11.1782311321207; 
 Wed, 24 Jun 2026 07:28:41 -0700 (PDT)
X-Received: by 2002:a05:6214:488e:b0:8cc:d29:9f78 with SMTP id
 6a1803df08f44-8df8f90f599mr370864456d6.11.1782311320365; 
 Wed, 24 Jun 2026 07:28:40 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-157.dsl.bell.ca. [174.91.117.157])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df82b67affsm155129476d6.45.2026.06.24.07.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:28:39 -0700 (PDT)
Date: Wed, 24 Jun 2026 10:28:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH 1/5] migration: add RAM Block fields and helpers for
 fast snapshot load
Message-ID: <ajvpj_pxXpvGWKb4@x1.local>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-2-aadeshveer07@gmail.com>
 <ajlhiEZ4TdBFvdMu@x1.local>
 <CA++cPvJGwOQpSD3zTNAmpxE2JSCZrh5K4taVuAavDMOggBLcJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA++cPvJGwOQpSD3zTNAmpxE2JSCZrh5K4taVuAavDMOggBLcJQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 24, 2026 at 12:36:16PM +0530, Aadeshveer Singh wrote:
> On Mon, Jun 22, 2026 at 9:53 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Jun 18, 2026 at 08:50:06AM +0530, Aadeshveer Singh wrote:
> > > Add two fields per RAMBlock:
> > >
> > > - nonzeropages: Mirrors the mapped-ram bitmap for storing which pages
> > >   are present in file and which are zero.
> > > - pending_bmap: Bitmap to store internal state of which pages have been
> > >   read by some thread to ensure coordination between threads.
> > >
> > > Both fields are allocated and initialized in ram_load_setup and freed in
> > > ram_load_cleanup. nonzeropages is populated in parse_ramblock_mapped_ram
> > > eliminating the use of a temporary bitmap.
> > >
> > > Change ram_load() to load using ram_load_precopy() in case of fast
> > > snapshot load.
> > >
> > > Also add migrate_fast_snapshot_load() returning true when both
> > > postcopy-ram and mapped-ram capabilities are set.
> > >
> > > Update qemu_get_buffer_at() to not set error to make it thread safe. All
> > > the callers of qemu_get_buffer_at(), take care of error handling.
> > >
> > > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > > ---
> > >  include/system/ramblock.h |  8 +++++
> > >  migration/options.c       |  5 ++++
> > >  migration/options.h       |  1 +
> > >  migration/qemu-file.c     | 10 +------
> > >  migration/ram.c           | 61 ++++++++++++++++++++++++++++++++-------
> > >  5 files changed, 65 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/system/ramblock.h b/include/system/ramblock.h
> > > index 4435f8d55f..73275d0459 100644
> > > --- a/include/system/ramblock.h
> > > +++ b/include/system/ramblock.h
> > > @@ -60,6 +60,14 @@ struct RAMBlock {
> > >
> > >      /* Bitmap of already received pages.  Only used on destination side. */
> > >      unsigned long *receivedmap;
> > > +    /* Bitmap of zero pages. Used for fast snapshot load. */
> > > +    unsigned long *nonzeropages;
> >
> > We have file_bmap, only used on source for now.  I think we can safely
> > reuse it by caching the pointer allocated.
> Agreed will drop nonzeropages and reuse file_bmap for this in v2
> 
> >
> > > +    /*
> > > +     * Bitmap for pages that are yet to be read from disk. It is required for
> > > +     * fault thread and eager thread to keep note of which pages are currently
> > > +     * being read. Used by fast snapshot load.
> > > +     */
> > > +    unsigned long *pending_bmap;
> >
> > We have receivedmap right above, and it's always allocated on dest.  IIUC
> > we can directly use it.
> >
> > It's also already set by uffd helpers, see qemu_ufd_copy_ioctl().
> > Currently it's a bit ugly put under a "if (!ret)"..  if you want you can
> > clean it up a bit.
> >
> > There, we may want to skip page_requested or page_request_mutex operations
> > for file load because they're not necessary.
> >
> 
> I looked into reusing receivedmap here instead of creating
> pending_bmap, but doing so creates a race condition that breaks the
> postcopy blocktime calculations.
> 
> receivedmap strictly tracks pages that have been successfully placed
> in the VM. My pending_bmap tracks pages that any thread is actively
> loading (reading from disk).

Yes, I think if we want to reuse the bitmap, we need to redefine
receivedmap a little bit.

Remote postcopy needs to remember it not only to maintain the GTree for
page_requested, but also when postcopy is interrupted it needs to sync the
bitmap to source to know what exactly have landed destination.  Here
setting the bit _after_ the placement is critical.

In your case, you don't need to remember "what pages we have loaded".

So if we could redefine receivedmap in your case to be "who will place this
page, eager load thread or fault thread", then it could work.

Said that, maybe this will need some work to make it work, you can evaluate
how much needed before going too deep.  Then if you think it's still easier
to have the new bitmap, then it's still ok to consider having it.

It may also matter on how you plan to refactor qemu_ufd_copy_ioctl(),
maybe.  So you can take all these problems together in mind when
considering the final decision.

> 
> If we use receivedmap to track in-load pages, and a vCPU faults on a
> page that the eager thread is currently reading, the fault thread will
> see the bit set in receivedmap. It will then incorrectly assume the
> page is already in the VM and skip tracking the blocktime for that
> fault, even though the eager thread hasn't actually called place_page
> yet. Keeping pending_bmap separate ensures the fault thread accurately
> tracks blocktime until placement is actually complete.
> 
> Regarding the cleanup in qemu_ufd_copy_ioctl(), I agree we can skip
> the page_requested operations for the file load. I also noticed a
> potential race where if the eager thread places a page just before the
> fault thread attempts to, we might hit an assert there. I will look
> into returning safely instead of asserting to harden this, and I will
> include the cleanup in v2.

What is the assertion about?

Logically if the fault thread will atomically fetch and set the bitmap bits
(either your new bitmap, or reuse receivedmap), then it should already see
the eager thread set the bit already, so it should avoid further playing
with the page.  Vice versa.

But as long as you have clue on how to resolve it and move on, we're good!
You can mention that in the next cover letter then we can review it in the
next version directly.

Thanks,

-- 
Peter Xu


