Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485D1C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuByn-0002tI-Nh; Wed, 12 Aug 2026 12:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wuByk-0002sr-UJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:38:58 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wuByi-0005Tq-Af
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:38:58 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-39f927721f2so9027281fa.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786552734; cv=none;
 d=google.com; s=arc-20260327;
 b=ORr02HNiQ2QNxmy6B8BCz3U5b0IUBAzEpKYkm5y5f2Gfp+6GHXUoX84iMrxImA9ZYf
 FDwZaKBuumhIHKMAz8SKutMiAF4CT1oynvU8gkwW0bBk53cGyb1PgDGmSP+l73f3Srfb
 /XZxe1oX4aOrWreSI9NfeBF/7Qx+qMLRvuagjZhOonn4WbUPDJ1fEwdQyC0CSC+hFY3A
 4LAvol0EWCQRMiPyZLyNSG2flFohi+0Znyhdu9x48v433fMBE2kckEwvVhr+WXtJTYtg
 8V5EYSO/2TL7xAQeQy82kTapOfZtlz5maHCIRpcSP6Ly/MRz1BoHnCNYCzTB3W0TJquV
 dQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=er2JAzN5OD34l82CIdazFDAjL51GEIp29Fo7+TqDdWA=;
 fh=YYFlP8b5nG0xp43ekYQGYSQr9uembBeNxJ16OtaRW/0=;
 b=GH85tKq8CYQB1m8MwJKKq3vChG8w1xqjPkKiNFyj0Kbhcpqnkvo8Hi9shdM58oHHef
 iZuKqC7756WtkUc+LPlifeh/8jD0ZzVZZnxtuAfGsbUcFOXmEGP6xIV5LHRRkbP51/ww
 nvJo1smRQNT6+uS6GMKeqXNHX5p3iNmPFhJcZyevHbAw3IFIL1+uMRLxQbalf9sGzzw0
 3dsZSM/M4xnalHA2XKEGGGEArS4ty1j/CQ1whmTAFTncXU1hc6KLBoaWa1STWhGv9OTe
 BLE5iMgeY7pXzXGy9foIVqKVdrEEh17y4kMDw0nVt/uH9uq/GQ6Y6UkKF756JvB6fuIG
 EWOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786552734; x=1787157534; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=er2JAzN5OD34l82CIdazFDAjL51GEIp29Fo7+TqDdWA=;
 b=Sruy1EALLbqlYcDhxv781BijC8xjI6Jz8GH6SbWbEsvbJmC4Q0eT0NtKRcY02gwJyU
 FJxtP7YAjrdCKRyx0sNdIvr7OJdlGRu8E7C8Hhn42f3tmVjAOYpW2S8Q1roDDrS4ibxy
 aADgKaVBlvrxkPiSBwz7fpP349pnWZXIFBiB6Qybg3DFuNyaz+tsY0Fc3PtJAwvmdnb1
 FPMCRaJDD0ArPHklrhAZi1hSlx9YxIq8TIk9csmKD4kB0ogf3mM9GhP8rVJrKMcY1w9B
 D7M2wewdx0InSHX0Z4uPTfBkqFMA0MRxPON3K3ni6NlCaircx2yw+xTr4J1Zc35gTHlt
 5cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786552734; x=1787157534;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=er2JAzN5OD34l82CIdazFDAjL51GEIp29Fo7+TqDdWA=;
 b=MGMWsnuN7gROxrAQKvp8kvSAYJORK968R059yBh7ScmY2zdyceY1b8WGSUIURE4tuK
 N5UGPhXYDrlJYiDSoB9T3WOYosYIEzFzekDnquJURoi/day1ALlbbVKWQnGNReA0gjoI
 C9dFjUtIFLkDWqVFFiMAeTVnJfBpIDFBEB9lKwGoggkEvcGLRnLzzYp4Zj5mXi4WhbMd
 G1tQ4V4eoIKmwJ8u1jErs2cjqGwadzeF3K5xj0SxZ53LjblTLZFDuJQJVwVsZFDyizcl
 NwYPc+g4bDGaUnHWh1S9w3I54RQnxeg51odAaOsrUGqz8FBtHC3VT+Qi5aV+yG6/GvSA
 LKAw==
X-Gm-Message-State: AOJu0Yz7FGfMFQuLyWpuuUXBoTcmm/VW4kyiw2g+JX1HotD8Fx9+Dj/Y
 7woltQRq129lhnEIkVCl6J7ZFuXYTi3SmMQwhk+B/ehqs8/kp7PXJaNqK4hCwoiscpYihngxph+
 jPOcoWl/n6BYxFy3cdpA8irMCJBzCNfs=
X-Gm-Gg: AR+sD1342BN10Fi9It8KB/2gwKynM3VfLRDaSZFLMocqBq6eqBFkI0z7yMuSpbWk6nI
 69PJdQqfnXC/MiqHS3qeLuEgcd2NXxOEGyEHjZictp2yBMBpAALPnOh9wRG+RB14nVa7U4AFm45
 m2t+AGk2la8J7qW+KRiDFRSLDuezbNxfYNtpzqopjGWbjoU8BsY3qaIHZ2tWetQhc5H/VK/hi/t
 iEKTHU4/HNxAfK1awHWUE+gQsFZgsleDOSYRdaMfRmpcklDUjMVNJf1kUryBWpnfod0yD+hT6Xp
 xgSriP7czHBjEyOd1UO9Uf5EMKKxSvwUYHYwA+G+ZdZRxePwI8szA+ZxVjTgsRShuxa9UweGlTR
 0
X-Received: by 2002:a2e:a554:0:b0:39c:7130:f0db with SMTP id
 38308e7fff4ca-3a10d22b3f1mr7786601fa.6.1786552733543; Wed, 12 Aug 2026
 09:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-8-aadeshveer07@gmail.com>
 <CA++cPvLsRpqcqhPg4fY_uhnZqeET0OpdxDDM1i4_rGFuR_4Hag@mail.gmail.com>
 <annw8X51cEa6yvdp@x1.local>
In-Reply-To: <annw8X51cEa6yvdp@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 12 Aug 2026 22:08:38 +0530
X-Gm-Features: AUfX_mwYZRqWdcWNk1RTSi53bokcx2MwIUpcfTS0WtEfKzPTex6vr6824PE5ZmQ
Message-ID: <CA++cPvJ=nx=4EWHQX5yYO46Dq2Ng7-EjG5J6bhWapTtumeXdPg@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] migration: add support for fault thread to load
 pages from disk
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com, 
 pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

On Mon, Aug 10, 2026 at 9:10=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Aadeshveer,
>
> Thanks for looking into this problem.  Below solution should work in
> general, but there's still one problem..
>
> On Sat, Aug 08, 2026 at 10:04:48AM +0530, Aadeshveer Singh wrote:
> > A subtle concurrency bug exists in the current patch; this small patch
> > should fix it.
> >
> > Current patch uses bitmap_test_and_clear_atomic assuming it performs
> > an atomic operation over a range, which as pointer out by Peter is not
> > the case. It performs atomic word by word operations making the
> > overall operation unsafe.
> > Therefore, keeping the same bitmap would require protection by a mutex
> > lock which might not be as efficient. Hence this small patch resizes
> > the pending_bmap to have exactly one bit per load operation(loading
> > the larger of host page and guest page).
> >
> > Thank you,
> > Aadeshveer Singh
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index e01ac628f5..0bf0f837ad 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -1031,9 +1031,13 @@ static bool
> > postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> >      host_page =3D rb_offset / qemu_ram_pagesize(rb);
> >      page =3D rb_offset >> qemu_target_page_bits();
> >
> > -    if (bitmap_test_and_clear_atomic(
> > -            rb->pending_bmap, host_page,
> > -            MAX(1, qemu_target_page_size() / qemu_ram_pagesize(rb)))) =
{
> > +    /*
> > +     * pending_bmap needs the index of host or guest page based on whi=
ch is
> > +     * larger. As page index is inversely proportional to page size we=
 use the
> > +     * minimum of both.
> > +     */
> > +    if (bitmap_test_and_clear_atomic(rb->pending_bmap, MIN(host_page, =
page),
> > +                                     1)) {
> >          if (find_next_bit(rb->file_bmap, page + guest_pages_to_load, p=
age) =3D=3D
> >              page + guest_pages_to_load) {
> >              /* It is efficient to use UFFDIO_ZERO if all pages are zer=
o */
>
> Consider the case where guest psize > host psize, here the current code
> will invoke postcopy_place_page_zero() or postcopy_place_page() only once
> for each guest page. But IIUC that's not enough: we'll need to loop over
> the few host pages that is covered by the same guest page.
I believe I missed it, confusing the page sizes. One of the solutions
can be a loop or a cleaner solution might be to give larger length to
ioctl command to handle multiple pages at once. This should be
efficient but might require some changes to basic postcopy code as
most of it hardcoded length as page size to most userfaultfd_ioctl
calls.
>
> I confess this is really a rare corner case..  so you can decide how to
> "fix" it.  There's always the option to disable this feature for now when
> guest psize is larger than host psize (OTOH, host psize > guest psize is
> much more common, because that's normally how huge page backed VMs work o=
n
> linux systems).
>
> Or just provide the loops over host pages, I think it will start working
> and IIUC it's indeed the most efficient.  But then, to make it slightly
> easier to future readers (I still think the bitmap definition will be
> slightly hard to grasp for future readers.. your comments all over
> hopefully will help), maybe we can also rename "page"; it implies guest
> page index but it's not obvious.  We can make it "guest_page" to match
> "host_page".  The "haddr" seems fine.
I believe it should be simple to implement using direct syscalls,
however for a cleaner solution current functions need to be made more
modular. I will try the latter and if the changes go out of hand might
resort to direct syscalls or loops.
>
> When preparing the new version, let's also split this diff into
> corresponding patches.
Ack
>
> Thanks,
>
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 734fd90e12..52a3af9245 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -269,7 +269,14 @@ static void ramblock_pending_bmap_init(void)
> >
> >      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> >          assert(!rb->pending_bmap);
> > -        size_t size =3D rb->max_length / qemu_ram_pagesize(rb);
> > +        /*
> > +         * The pending_bmap granularity must match the maximum of
> > host and guest
> > +         * page sizes. This ensures that every load operation checks f=
or one
> > +         * bit, allowing lockless thread coordination via a single-bit=
 atomic
> > +         * test-and-clear.
> > +         */
> > +        size_t size =3D rb->max_length /
> > +                      MAX(qemu_ram_pagesize(rb), qemu_target_page_size=
());
> >          rb->pending_bmap =3D bitmap_new(size);
> >          bitmap_set(rb->pending_bmap, 0, size);
> >      }
> >
> > On Sat, Aug 1, 2026 at 8:07=E2=80=AFAM Aadeshveer Singh <aadeshveer07@g=
mail.com> wrote:
> > >
> > > In fast snapshot load, we would like to serve faults as soon as possi=
ble
> > > hence loading pages directly instead of requesting a source
> > >
> > > Add postcopy_mapped_ram_load_page() function which serves single page
> > > fault. It uses bitmap_test_and_clear_atomic() on pending_bmap to prev=
ent
> > > multiple threads from loading same page. It loads a page or pages
> > > depending on size of guest pages and host pages, loading exactly the
> > > larger of two. If the entire page is zero postcopy_place_page_zero() =
is
> > > used for efficiency and in case some part is non zero it is part by p=
art
> > > loaded on loop using new function postcopy_mapped_ram_load_guest_page=
()
> > > which loads a single guest page in a buffer which is then placed usin=
g
> > > postcopy_place_page(). This covers all possible cases for various pag=
e
> > > sizes of host and guest.
> > >
> > > Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_pag=
e
> > > instead of requesting source in case of fast snapshot load. to_src_fi=
le
> > > check is bypassed in fast snapshot load case as there is no source.
> > >
> > > Call try_mark_postcopy_blocktime_begin on every page fault to support
> > > postcopy-blocktime.
> > >
> > > Allocate another channel in postcopy_temp_pages_setup(like the preemp=
t
> > > case), for both the fault thread and eager thread to load pages
> > > independently.
> > >
> > > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > > ---
> > >  migration/postcopy-ram.c | 174 +++++++++++++++++++++++++++++++++++--=
--
> > >  1 file changed, 157 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > index 2e2c9fae10..1da9c4309b 100644
> > > --- a/migration/postcopy-ram.c
> > > +++ b/migration/postcopy-ram.c
> > > @@ -949,6 +949,121 @@ int postcopy_wake_shared(struct PostCopyFD *pcf=
d,
> > >                         pagesize);
> > >  }
> > >
> > > +/*
> > > + * Load a single guest page from source file into the buffer.
> > > + * NOTE: This is not an atomic operation and should not be used to d=
irectly load
> > > + * pages on page faults in postcopy. It is meant to fill in buffer t=
hat can then
> > > + * be copied into the faulting location using UFFDIO_COPY.
> > > + */
> > > +static bool postcopy_mapped_ram_load_guest_page(MigrationIncomingSta=
te *mis,
> > > +                                                RAMBlock *rb,
> > > +                                                ram_addr_t rb_offset=
, void *buf,
> > > +                                                Error **errp)
> > > +{
> > > +    ERRP_GUARD();
> > > +    size_t page =3D rb_offset / qemu_target_page_size();
> > > +    size_t read;
> > > +
> > > +    if (test_bit(page, rb->file_bmap)) {
> > > +        /*
> > > +         * This can happen concurrently, but it's thread-safe becaus=
e
> > > +         * qemu_get_buffer_at() is thread-safe, and the caller will =
be using
> > > +         * different temporary buffers.
> > > +         */
> > > +        read =3D
> > > +            qemu_get_buffer_at(mis->from_src_file, buf, qemu_target_=
page_size(),
> > > +                               rb->pages_offset + rb_offset, errp);
> > > +
> > > +        if (read !=3D qemu_target_page_size()) {
> > > +            error_prepend(errp,
> > > +                          "Could not read page %zu from RAM Block %s=
: ", page,
> > > +                          rb->idstr);
> > > +            return false;
> > > +        }
> > > +    } else {
> > > +        memset(buf, '\0', qemu_target_page_size());
> > > +    }
> > > +    return true;
> > > +}
> > > +
> > > +/**
> > > + * postcopy_mapped_ram_load_page() - Load pages required to access h=
ost address.
> > > + * @mis: Migration Incoming State.
> > > + * @rb: RAMBlock from where page is loaded.
> > > + * @rb_offset: Offset of target page in RAMBlock.
> > > + * @haddr: Base of target page where to load in page.
> > > + * @channel: Used to identify between threads and use corresponding =
temp.
> > > + * @errp: Set error in case of failure
> > > + *
> > > + * Load page(s) from RAMBlock covering the faulting address. We migh=
t need to
> > > + * load multiple pages in the case when host page size is greater th=
an guest
> > > + * page size. As userfaultfd works on granularity of host pages, we =
might need
> > > + * to load guest pages in single operation.
> > > + *
> > > + * Return: True on success.
> > > + */
> > > +static bool postcopy_mapped_ram_load_page(MigrationIncomingState *mi=
s,
> > > +                                          RAMBlock *rb, ram_addr_t r=
b_offset,
> > > +                                          uint64_t haddr, int channe=
l,
> > > +                                          Error **errp)
> > > +{
> > > +    void *place_source =3D mis->postcopy_tmp_pages[channel].tmp_huge=
_page;
> > > +    char *buffer_ptr =3D (char *)place_source;
> > > +    size_t guest_pages_to_load =3D
> > > +        MAX(1, qemu_ram_pagesize(rb) / qemu_target_page_size());
> > > +    size_t host_page;
> > > +    size_t page;
> > > +
> > > +    /*
> > > +     * If guest page size is greater than host page size uffd needs =
to load one
> > > +     * guest page and multiple host pages, hence the offsets need to=
 aligned
> > > +     * with guest pages (which is automatically aligned with host pa=
ges). In the
> > > +     * same case we need to check range of bits on pending_bmap(bit =
per host
> > > +     * page) to decide whether all the page have been loaded
> > > +     */
> > > +    rb_offset =3D ROUND_DOWN(rb_offset, qemu_target_page_size());
> > > +    haddr =3D ROUND_DOWN(haddr, qemu_target_page_size());
> > > +    host_page =3D rb_offset / qemu_ram_pagesize(rb);
> > > +    page =3D rb_offset >> qemu_target_page_bits();
> > > +
> > > +    if (bitmap_test_and_clear_atomic(
> > > +            rb->pending_bmap, host_page,
> > > +            MAX(1, qemu_target_page_size() / qemu_ram_pagesize(rb)))=
) {
> > > +        if (find_next_bit(rb->file_bmap, page + guest_pages_to_load,=
 page) =3D=3D
> > > +            page + guest_pages_to_load) {
> > > +            /* It is efficient to use UFFDIO_ZERO if all pages are z=
ero */
> > > +            if (postcopy_place_page_zero(mis, (void *)haddr, rb)) {
> > > +                error_setg(errp,
> > > +                           "Failed to place zero page %zu from RAM B=
lock %s at "
> > > +                           "address %" PRIu64,
> > > +                           page, rb->idstr, haddr);
> > > +                return false;
> > > +            }
> > > +        } else {
> > > +            size_t load_size =3D guest_pages_to_load * qemu_target_p=
age_size();
> > > +            size_t offset;
> > > +
> > > +            for (offset =3D 0; offset < load_size;
> > > +                 offset +=3D qemu_target_page_size()) {
> > > +                if (!postcopy_mapped_ram_load_guest_page(
> > > +                        mis, rb, rb_offset + offset, buffer_ptr + of=
fset,
> > > +                        errp)) {
> > > +                    return false;
> > > +                }
> > > +            }
> > > +
> > > +            if (postcopy_place_page(mis, (void *)haddr, place_source=
, rb)) {
> > > +                error_setg(errp,
> > > +                           "Failed to place page %zu from RAM Block =
%s at "
> > > +                           "address %" PRIu64,
> > > +                           page, rb->idstr, haddr);
> > > +                return false;
> > > +            }
> > > +        }
> > > +    }
> > > +    return true;
> > > +}
> > > +
> > >  /*
> > >   * NOTE: @tid is only used when postcopy-blocktime feature is enable=
d, and
> > >   * also optional: when zero is provided, the fault accounting will b=
e ignored.
> > > @@ -1310,6 +1425,7 @@ static void *postcopy_ram_fault_thread(void *op=
aque)
> > >      int ret;
> > >      size_t index;
> > >      RAMBlock *rb =3D NULL;
> > > +    Error *local_err =3D NULL;
> > >
> > >      trace_postcopy_ram_fault_thread_entry();
> > >      rcu_register_thread();
> > > @@ -1351,11 +1467,13 @@ static void *postcopy_ram_fault_thread(void *=
opaque)
> > >              break;
> > >          }
> > >
> > > -        if (!mis->to_src_file) {
> > > +        if (!migrate_mapped_ram() && !mis->to_src_file) {
> > >              /*
> > > -             * Possibly someone tells us that the return path is
> > > -             * broken already using the event. We should hold until
> > > -             * the channel is rebuilt.
> > > +             * Possibly someone tells us that the return path is bro=
ken already
> > > +             * using the event. We should hold until the channel is =
rebuilt.
> > > +             * Fast snapshot load doesn't support pause and recover,=
 because
> > > +             * it's not necessary: we can fail right away when QEMU =
just booted
> > > +             * with nothing to lose.
> > >               */
> > >              postcopy_pause_fault_thread(mis);
> > >          }
> > > @@ -1418,18 +1536,37 @@ static void *postcopy_ram_fault_thread(void *=
opaque)
> > >                                                  qemu_ram_get_idstr(r=
b),
> > >                                                  rb_offset,
> > >                                                  msg.arg.pagefault.fe=
at.ptid);
> > > +
> > > +            if (migrate_mapped_ram()) {
> > > +                /* Load page directly in case of fast snapshot load =
*/
> > > +
> > > +                uintptr_t aligned =3D (uintptr_t)ROUND_DOWN(
> > > +                    msg.arg.pagefault.address, qemu_ram_pagesize(rb)=
);
> > > +
> > > +                if (try_mark_postcopy_blocktime_begin(
> > > +                        mis, rb, rb_offset, (uintptr_t)aligned,
> > > +                        msg.arg.pagefault.feat.ptid)) {
> > > +                    if (!postcopy_mapped_ram_load_page(
> > > +                            mis, rb, rb_offset, aligned, RAM_CHANNEL=
_POSTCOPY,
> > > +                            &local_err)) {
> > > +                        error_report_err(local_err);
> > > +                        break;
> > > +                    }
> > > +                }
> > > +            } else {
> > >  retry:
> > > -            /*
> > > -             * Send the request to the source - we want to request o=
ne
> > > -             * of our host page sizes (which is >=3D TPS)
> > > -             */
> > > -            ret =3D postcopy_request_page(mis, rb, rb_offset,
> > > -                                        msg.arg.pagefault.address,
> > > -                                        msg.arg.pagefault.feat.ptid)=
;
> > > -            if (ret) {
> > > -                /* May be network failure, try to wait for recovery =
*/
> > > -                postcopy_pause_fault_thread(mis);
> > > -                goto retry;
> > > +                /*
> > > +                 * Send the request to the source - we want to reque=
st one
> > > +                 * of our host page sizes (which is >=3D TPS)
> > > +                 */
> > > +                ret =3D postcopy_request_page(mis, rb, rb_offset,
> > > +                                            msg.arg.pagefault.addres=
s,
> > > +                                            msg.arg.pagefault.feat.p=
tid);
> > > +                if (ret) {
> > > +                    /* May be network failure, try to wait for recov=
ery */
> > > +                    postcopy_pause_fault_thread(mis);
> > > +                    goto retry;
> > > +                }
> > >              }
> > >          }
> > >
> > > @@ -1501,8 +1638,11 @@ static int postcopy_temp_pages_setup(Migration=
IncomingState *mis, Error **errp)
> > >      unsigned i, channels;
> > >      void *temp_page;
> > >
> > > -    if (migrate_postcopy_preempt()) {
> > > -        /* If preemption enabled, need extra channel for urgent requ=
ests */
> > > +    if (migrate_postcopy_preempt() || migrate_mapped_ram()) {
> > > +        /*
> > > +         * If preemption enabled or it is fast snapshot load, need e=
xtra channel
> > > +         * for urgent requests/faults
> > > +         */
> > >          mis->postcopy_channels =3D RAM_CHANNEL_MAX;
> > >      } else {
> > >          /* Both precopy/postcopy on the same channel */
> > > --
> > > 2.55.0
> > >
> >
>
> --
> Peter Xu
>

