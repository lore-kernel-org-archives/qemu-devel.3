Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8D3C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTJc-0002lD-13; Wed, 08 Jul 2026 10:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1whTJX-0002kZ-SB
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:31:51 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1whTJV-00072O-PQ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:31:51 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-39c7ac9b8c3so5846971fa.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783521108; cv=none;
 d=google.com; s=arc-20260327;
 b=BW//heKzI19TkzZwGNFyHkeJ7jUerGskcSF85wqPgqO/XFJJa66rhXIaRX94xIVWAP
 7t0+bqNW1H4MbeGvPIjiRl8Z44dgqn4YM5F0W+sKladpVCIlTtOdmASKnwWDBQJ4j33X
 OwPJDjCcBHTzKAcF/mvtRZU6FScASKBHI79iZ/I1DKXaa5a8ylRRNyB+zxhaNeNfkn78
 ecEr98LXTogE65nqwsii/m7RBlqJKtoKQhN1Skz3ozKnf2726eXj6+8m8CPkOrDjugTA
 cuPdISpg4Z2v+BTcxuCvxY4hvvq+7tshrrXf8CrqvcMiFyZh0EJOumbaFS5uyfiSmJcv
 O4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xVYeQLwWKOlvp97s86y+Tyaawy9c31mFZYCciuC3pLs=;
 fh=NT0kq7NgLJ0wOp/qMyvn1NIPXsDSAQYGUZFkUZ2OApE=;
 b=MCcCr87VOSiTNupWQ2hhwNH7Wz8jQVEK/13Ovv2VldYpLMqnU6oPDQtxGi3E6nS8Cm
 pbL/bMx1OGeP20SoG6vMzmewFfUu1qNPaMBaNAA4/aHPZRsv0aJQ68l+aaIQ/GSUVNsY
 GK7oXhMsMf2OK4vfWZrasn9ekJpZk2gJYXD61eU9lwvDLNUoHT+AGUn8VcXbdagfPSM+
 V7TQVvpMKGUAtdHeHhXekLu+ChX1E3VyGCeZzjf6hfCCzD80EK0P3N6IiVzZMoH8jbAd
 4Syttp9625a/4RoPg4iVYhTGA78pE105FkafPNu4Ico8hVp4pSEnAkArOQX3Q51xTBfH
 VEWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783521108; x=1784125908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xVYeQLwWKOlvp97s86y+Tyaawy9c31mFZYCciuC3pLs=;
 b=hr3WK/sWXqqxmzFlxFxWwEMLqfCN6QCxgi/dBCuJWcdeiQ7sw1ktdto4amTfxrRLW2
 3RmkkXkfFvxaFRRYl6qLhwu9T8r4ya5LAc54CnJyKd7sbpYxrYnfW9kW19cCctU8ZTOZ
 I34Wn2442wsKoLhYXJ2vrhFPBcoHRKRxehTuLQSt8wxvEM9uyaQuahevhLsHQF674zvf
 CrGoV2Kw7889XCIffgc69F2W9G3IgZggIGLIU7RUV96mjDNQFB4QlJJyF7HJMyt87WTM
 pREdZlwfCNhV0owIBkd5pVwHgYz9KFUXJlABZIDIKLYGi7mqFjoheY8dQyJPgGMvrSrq
 eaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783521108; x=1784125908;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xVYeQLwWKOlvp97s86y+Tyaawy9c31mFZYCciuC3pLs=;
 b=Tok0Z5oLKp2EI1AnYkwir1/nL19md+GmzzwpdTmTpUIwDuDFmZ5yTIMpv7ZB9FT1pH
 p+Pl17CBf3Nj/4mm8Bmv+bUEi+k+z9BrKA9glgPMuIM15ViJGMS4nmEtXnt+h6YQYuvV
 CPMMRy4gR+8f8VR2c82zZixpHFXm9qdhlEqzahRjr8IGfeDpI7Xfi0TRWwQgbU/D/gaQ
 GBl/YVBE06uKUb3d5OItCTLO35oOHjRqz3iuE1KIOD7s2poPnhEe2krBgOR+DLOowjYJ
 sk3ghPY1oup8xxWy+c12vy8fdFSkC7iH1YVA64l+L2yxyQKnTQIhVG413R+Vmhi6ENna
 uD9Q==
X-Gm-Message-State: AOJu0Yw9yO5AEL/UHmL6DqWnwH6PPevz/stnl8zcHh5C64P1MGHP+i8B
 RKuJi2/C2l0rwW0faVPQkdyr+QgU6MpjyKZAHE2VDA0w3ngk3JvSfrXmTNdZZcoI6xNXoFGKXRZ
 q3oFPONh8xSKduGOfB+eX4YKcnAUQzhY=
X-Gm-Gg: AfdE7cmqQdTxdG4rMXvGgJnOy/gU2kHZvUIca//H/8l/8hcUYfM+oz1NRfMe/Dm6Tug
 nutQTkFGX0jxKEWH7bWbIXpRjn4MV+yRX3wqNUPM+6iNbyKjUWP/dJR8dS8Jqx5zGfQh9VQHKlT
 aH81q+yS8z8J3PG+W6Ga9fcXi92ljr4qOsLv11DwRTW9Y8xFMCTsY2thfoaZdSMQ+kgHASzOSF0
 NfR0y3uJ8sODKrFtJQ1Yxnl0c6K1KHQondYHY9/OH/d5dOUUbahW/qeEdtyfv6rBQUKM0KGhSZ0
 B1V/nqwMsVEnQoQP/X+H2Q0jE+GN4fe8mdiWQAKHC0pBMzdL4MPjL3LoQYv4
X-Received: by 2002:a2e:a5c9:0:b0:39a:e29b:790a with SMTP id
 38308e7fff4ca-39c79a0f3cfmr6429081fa.33.1783521106891; Wed, 08 Jul 2026
 07:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <20260630081940.611092-7-aadeshveer07@gmail.com> <akwRqYY3vfzafZ_X@x1.local>
In-Reply-To: <akwRqYY3vfzafZ_X@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 8 Jul 2026 20:01:34 +0530
X-Gm-Features: AVVi8CcprG4oONw4tz96jBcK7z-ZtuAh_Ucf69biHDK8HK0K4VsEVSIaOVLkCto
Message-ID: <CA++cPvJ2N_oke1iMP083MDKxeV-YoKDZuWFtAfwoYKwoR65ocA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/7] migration: add support for fault thread to
 load pages from disk
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lj1-x22a.google.com
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

On Tue, Jul 7, 2026 at 2:05=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Jun 30, 2026 at 01:49:39PM +0530, Aadeshveer Singh wrote:
> > In fast snapshot load, we would like to serve faults as soon as possibl=
e
> > hence loading pages directly instead of requesting a source
> >
> > Add postcopy_mapped_ram_load_page() function which serves single page
> > fault by reading the snapshot file. It uses bitmap_test_and_clear_atomi=
c
> > on pending_bmap to coordinate between threads so each page is loaded
> > exactly once. Non-zero pages are read using qemu_get_buffer_at into a
> > temporary page (for loading page atomically), which is then placed usin=
g
> > postcopy_place_page. Zero pages are placed directly using
> > postcopy_place_page_zero.
> >
> > Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_page
> > instead of requesting source in case of fast snapshot load. to_src_file
> > check is bypassed in fast snapshot load case as there is no source.
> >
> > Add postcopy-blocktime support by calling mark_postcopy_blocktime_begin
> > on every fault. We need to aqcuire the page_request_mutex lock and chec=
k
> > the recv bitmap to make sure we prevent a race condition when a fault
> > occurs but before the fault thread can mark the page for tracking the
> > eager thread loads in the page making us fail the assert for recv bitma=
p
> > being clear while marking in mark_postcopy_blocktime_begin().
> >
> > Allocate another channel in postcopy_temp_pages_setup(like the preempt
> > case), for both the fault thread and eager thread to load pages
> > independently.
> >
> > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > ---
> >  migration/postcopy-ram.c | 121 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 104 insertions(+), 17 deletions(-)
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 96a65aa976..be9edac572 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -949,6 +949,68 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
> >                         pagesize);
> >  }
> >
> > +/**
> > + * postcopy_mapped_ram_load_page() - Load a page to given host address=
.
> > + * @mis: Migration Incoming State.
> > + * @rb: RAMBlock from where page is loaded.
> > + * @rb_offset: Offset of page in RAMBlock.
> > + * @haddr: Base of page where to load in page.
> > + * @channel: Used to identify between threads and use corresponding te=
mp.
>
> Missing @errp.
>
> > + *
> > + * Load a page from RAMBlock at offset at given host address. Used by =
postcopy
> > + * ram fault thread and eager thread in fast snapshot load case.
> > + *
> > + * Return: True on success.
> > + */
> > +static bool postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> > +                                          RAMBlock *rb, ram_addr_t rb_=
offset,
> > +                                          uint64_t haddr, int channel,
> > +                                          Error **errp)
> > +{
> > +    void *place_source =3D mis->postcopy_tmp_pages[channel].tmp_huge_p=
age;
> > +    size_t page;
> > +    size_t read;
> > +
> > +    page =3D rb_offset / qemu_ram_pagesize(rb);
>
> Yes, here it is correct to use qemu_ram_pagesize().
>
> > +
> > +    if (bitmap_test_and_clear_atomic(rb->pending_bmap, page, 1)) {
> > +        if (test_bit(page, rb->file_bmap)) {
>
> We'll need to be careful here when you add huge page support, because
> file_bmap so far is guest-psize based.  This line will start to break for
> huge pages, I am not sure if this is the bug you hit when developing huge
> page support, maybe yes?
>
> Not sure how you resolved it there if this is the case, but one idea is
> when postcopy-ram is enabled, you can convert the per-guest-psize bitmap
> into per-host-psize bitmap (when any bit set within the huge page range,
> set the bit in the new bitmap), then here it will be correct.
>

For hugepages, I replaced this test_bit() with a ranged check. I felt
changing the semantics of file_bmap for when postcopy-ram is enabled
might make it more complex with insignificant return.

> > +            /*
> > +             * This can happen concurrently, but it's thread-safe beca=
use
> > +             * qemu_get_buffer_at() is thread-safe, and the caller wil=
l be using
> > +             * different temporary buffers.
> > +             */
> > +            read =3D qemu_get_buffer_at(mis->from_src_file, place_sour=
ce,
> > +                                      qemu_ram_pagesize(rb),
> > +                                      rb->pages_offset + rb_offset);
> > +
> > +            if (read !=3D qemu_ram_pagesize(rb)) {
> > +                error_setg(errp, "Could not read page %zu from RAM Blo=
ck %s",
> > +                           page, rb->idstr);
> > +                return false;
> > +            }
> > +
> > +            if (postcopy_place_page(mis, (void *)haddr, place_source, =
rb)) {
> > +                error_setg(errp,
> > +                           "Failed to place page %zu from RAM Block %s=
 at "
> > +                           "address %" PRIu64,
> > +                           page, rb->idstr, haddr);
> > +                return false;
> > +            }
> > +
>
> Nit: unnecessary newline.
>
> > +        } else {
> > +            if (postcopy_place_page_zero(mis, (void *)haddr, rb)) {
> > +                error_setg(errp,
> > +                           "Failed to place zero page %zu from RAM Blo=
ck %s at "
> > +                           "address %" PRIu64,
> > +                           page, rb->idstr, haddr);
> > +                return false;
> > +            }
> > +        }
> > +    }
> > +    return true;
> > +}
> > +
> >  /*
> >   * NOTE: @tid is only used when postcopy-blocktime feature is enabled,=
 and
> >   * also optional: when zero is provided, the fault accounting will be =
ignored.
> > @@ -1279,6 +1341,7 @@ static void *postcopy_ram_fault_thread(void *opaq=
ue)
> >      int ret;
> >      size_t index;
> >      RAMBlock *rb =3D NULL;
> > +    Error *local_err =3D NULL;
> >
> >      trace_postcopy_ram_fault_thread_entry();
> >      rcu_register_thread();
> > @@ -1320,11 +1383,13 @@ static void *postcopy_ram_fault_thread(void *op=
aque)
> >              break;
> >          }
> >
> > -        if (!mis->to_src_file) {
> > +        if (!migrate_mapped_ram() && !mis->to_src_file) {
> >              /*
> > -             * Possibly someone tells us that the return path is
> > -             * broken already using the event. We should hold until
> > -             * the channel is rebuilt.
> > +             * Possibly someone tells us that the return path is broke=
n already
> > +             * using the event. We should hold until the channel is re=
built.
> > +             * Fast snapshot load doesn't support pause and recover, b=
ecause
> > +             * it's not necessary: we can fail right away when QEMU ju=
st booted
> > +             * with nothing to lose.
> >               */
> >              postcopy_pause_fault_thread(mis);
> >          }
> > @@ -1387,18 +1452,37 @@ static void *postcopy_ram_fault_thread(void *op=
aque)
> >                                                  qemu_ram_get_idstr(rb)=
,
> >                                                  rb_offset,
> >                                                  msg.arg.pagefault.feat=
.ptid);
> > +
> > +            if (migrate_mapped_ram()) {
> > +                /* Load page directly in case of fast snapshot load */
> > +                WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
> > +                    if (!ramblock_recv_bitmap_test(
> > +                            rb, (void *)msg.arg.pagefault.address)) {
> > +                        mark_postcopy_blocktime_begin(
> > +                            msg.arg.pagefault.address,
> > +                            msg.arg.pagefault.feat.ptid, rb);
> > +                    }
> > +                }
>
> This part needs some more thought.
>
> First of all, if the page is set already in receivedmap, it means it's
> already installed, we shouldn't bother postcopy_mapped_ram_load_page().
>
> But the problem is not only about that.
>
> So far looks like the blocktime feature relies on the receivedmap, then i=
t
> means the easy way for this series is to support receivedmap too.  Then
> with receivedmap, we should unify the receivedmap detection rather than
> testing the bit at multiple places.
>
> Say, you can provide a small helper like this:
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 278cad502a..79f737bc69 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -573,12 +573,10 @@ int migrate_send_rp_message_req_pages(MigrationInco=
mingState *mis,
>      return migrate_send_rp_message(mis, msg_type, msglen, bufc);
>  }
>
> -int migrate_send_rp_req_pages(MigrationIncomingState *mis,
> -                              RAMBlock *rb, ram_addr_t start, uint64_t h=
addr,
> -                              uint32_t tid)
> +bool postcopy_page_received(MigrationIncomingState *mis, RAMBlock *rb,
> +                            ram_addr_t start, uint64_t haddr, uint32_t t=
id)
>  {
> -    void *aligned =3D (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_page=
size(rb));
> -    bool received =3D false;
> +    bool received;
>
>      WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
>          received =3D ramblock_recv_bitmap_test_byte_offset(rb, start);
> @@ -598,11 +596,20 @@ int migrate_send_rp_req_pages(MigrationIncomingStat=
e *mis,
>          }
>      }
>
> +    return received;
> +}
> +
> +int migrate_send_rp_req_pages(MigrationIncomingState *mis,
> +                              RAMBlock *rb, ram_addr_t start, uint64_t h=
addr,
> +                              uint32_t tid)
> +{
> +    void *aligned =3D (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_page=
size(rb));
> +
>      /*
>       * If the page is there, skip sending the message.  We don't even ne=
ed the
>       * lock because as long as the page arrived, it'll be there forever.
>       */
> -    if (received) {
> +    if (postcopy_page_received(mis, rb, start, aligned, tid)) {
>          return 0;
>      }
>
> Then I think we can use postcopy_page_received() here to avoid duplicatin=
g
> the code.
>
> It means with your feature we will also maintain the tree of page_request=
ed
> but I think it's fine; if we really want we can make that optional based =
on
> whether mapped-ram enabled, but not yet required.
>
> PS: I feel like there was a bug in existing code passing "haddr" (rather
> than "aligned") into mark_postcopy_blocktime_begin() in the current impl =
of
> migrate_send_rp_req_pages().  Please help to check if it's an issue, if
> true we can have a separate patch fixing that first.  In general, I think
> we should use a page-aligned address in both the tree and blocktime.
>

Thanks for the snippet, I will integrate it in the next version.
You are right to point out the alignment bug, I will resolve that in
the next version too.

> > +                if (!postcopy_mapped_ram_load_page(
> > +                        mis, rb, rb_offset, msg.arg.pagefault.address,
> > +                        RAM_CHANNEL_POSTCOPY, &local_err)) {
> > +                    error_report_err(local_err);
> > +                    break;
> > +                }
> > +            } else {
> >  retry:
> > -            /*
> > -             * Send the request to the source - we want to request one
> > -             * of our host page sizes (which is >=3D TPS)
> > -             */
> > -            ret =3D postcopy_request_page(mis, rb, rb_offset,
> > -                                        msg.arg.pagefault.address,
> > -                                        msg.arg.pagefault.feat.ptid);
> > -            if (ret) {
> > -                /* May be network failure, try to wait for recovery */
> > -                postcopy_pause_fault_thread(mis);
> > -                goto retry;
> > +                /*
> > +                 * Send the request to the source - we want to request=
 one
> > +                 * of our host page sizes (which is >=3D TPS)
> > +                 */
> > +                ret =3D postcopy_request_page(mis, rb, rb_offset,
> > +                                            msg.arg.pagefault.address,
> > +                                            msg.arg.pagefault.feat.pti=
d);
> > +                if (ret) {
> > +                    /* May be network failure, try to wait for recover=
y */
> > +                    postcopy_pause_fault_thread(mis);
> > +                    goto retry;
> > +                }
> >              }
> >          }
> >
> > @@ -1470,8 +1554,11 @@ static int postcopy_temp_pages_setup(MigrationIn=
comingState *mis, Error **errp)
> >      unsigned i, channels;
> >      void *temp_page;
> >
> > -    if (migrate_postcopy_preempt()) {
> > -        /* If preemption enabled, need extra channel for urgent reques=
ts */
> > +    if (migrate_postcopy_preempt() || migrate_mapped_ram()) {
> > +        /*
> > +         * If preemption enabled or it is fast snapshot load, need ext=
ra channel
> > +         * for urgent requests/faults
> > +         */
> >          mis->postcopy_channels =3D RAM_CHANNEL_MAX;
> >      } else {
> >          /* Both precopy/postcopy on the same channel */
> > --
> > 2.54.0
> >
>
> --
> Peter Xu
>

