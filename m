Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D87CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHgz-0004Vc-4h; Wed, 24 Jun 2026 03:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wcHgw-0004VM-6J
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:06:34 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wcHgt-0002MX-Ip
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:06:33 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5ad68b30252so771268e87.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782284789; cv=none;
 d=google.com; s=arc-20240605;
 b=hkFH+XGCAOPDYbXvuAd5b8vyhTjCSTqyhGEcKDzdwH2KJ+r0YB5x7/sAEdmC+0lu3K
 hx8TH0aGPiCy03MQIhM6LIYQcM5oltblD1d8TAymc9FPZj0BoVzg7qhkWPxptH1tDcfO
 40RPRc6Y87BEgpW3nVaxhbjNIl9eJgdCQU9U9KqBIfcteAV4tDdsDX89ym4kK9SK3pKt
 t3R8PgkvbyeXQiVCQQjAUVzW6HThbNkJJYNgd6bW/RgitHuqrgnTNTWPOuYyLbuCSYGx
 PY8euH48XO/jCsn7myC/RJcCVuFyT9KAYueCIUeD7fxADK1jktlvRFbyzKimtFi6JbyB
 7huQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aFGQIz0UQvjTFtWy515AW8liaHOnt4SBaUKiaUDWmdM=;
 fh=NT0kq7NgLJ0wOp/qMyvn1NIPXsDSAQYGUZFkUZ2OApE=;
 b=dvnH30qaTxT7DgrVWqFwKbSbJO8eLlzyt48Aefh9pOU6pBffiihy0VLltM10ipm96Y
 5z0ZLW5rQKcz/sF2uoXgtiFMB+7t1jH7IiysO8C8h0y1zDfbZHDTZnTmQkHlMKRntEbl
 rha0oYT38l0C1vAFlRlR23qXAbAAqRgYqHQ+lYbhVmcveHz/SGcJmck9tlSUdn8RYbvo
 CZDxMg32qQ55rdfkM18HwaRzWo0w9/CWgBgTLJv/TYAVLHoGDRsIURact0grd1SdsKgr
 HnrbCm9JBSWihSSSibM13YOgJ88ZZHXF7faoRBensQg+zkWMvrBKDTC7rLH5w2dZ2eZd
 EuFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284789; x=1782889589; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFGQIz0UQvjTFtWy515AW8liaHOnt4SBaUKiaUDWmdM=;
 b=azg9An73rF1EodpoKvpLvaHt1h9rDE1gELriwPHL6FMN95c1hY6r3HjqsB4jJTqQxJ
 K+aovxWNAtrU7px7uxmZUCk48V/qAYkAeW2ssW3HlmlM2VECG74o9bfTVOQ/MXjMEhvu
 j8W8he2+SKC1htozwodK5RW61ALIfxo+FQ5SY0QiqBb6WAGQEkwp65rxBMAlLtqjnAUY
 AbizflWhzYs+ywiCCI0lLg6d4FQtGv5k98HxLxz6sA/93k+QG8bKkGzjG5RVh3e+gbeu
 n9Ps31Ds+WVCdJCPQwR8n3BNqhWbgr4BvcDlFjBlxRfrLVTOW7OxpaemuBm8QYisSCyV
 gefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284789; x=1782889589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aFGQIz0UQvjTFtWy515AW8liaHOnt4SBaUKiaUDWmdM=;
 b=EkYQjWQaub79oaaEiGYic3hpqy1Cmpi/qY1gNHrcPjqs36VHmzmAcdQ/sq/F7AfbAr
 90Anrl+HTlui+TEY32C43W0GJ80oFD8h0W6f4Y4AT9xsTFT8msjwpzroG0t5AKF1C6ZD
 5dHJ94n8oD56x02GTvWPOqA850fOT6VkPLpy8jM7HD7/4K9REv5cutDHhB+6x79qlvcQ
 QgFsM2Gs1yjr1n396pvY9RiYEy2UA9F9s/4JjV/gtyxJlmFW64D9vsnV50z0qNWp/Cj8
 /uvnbKVwLbpwovnFLkC8jkUrzZiChdBYDN0LxuI9MGam+M2s29lN+s4pOVULFbMQoOni
 eclg==
X-Gm-Message-State: AOJu0Yzr+30vRTIk6Vnkr/TpNu0F5xJs+wJwti7VoFobld9YMhVbJNuo
 VGbcjFN4WGIHtp24IGvPqqaK/PQSuMU+BFZWkBk3bMWItp56YzHu47dYwAPe34At9gddMntnq8N
 qTgpw9V35/JU3FymFTDNyYdO4xTS1iic=
X-Gm-Gg: AfdE7ckIr/3iuPyDhyk+7U4LbKYR4/IenxxFC4wXigncZzj13arDtZaWyIQwyLQUzJ+
 G4MlF+lQbc33koyie/T7TZNg1Ysd4Br7hi8dzWcf5nKiuA4KM3Rd0n4udEAgTO4I5hAQmBKskop
 wisYbqWMQPhpmYa3Dk/aRNczvMf+mVkZlQu2E5YF4lH/MNlOzHz/apR6k0DXNZbWCPeL6M71Fxg
 2tYdtfg1pve+h4Y0ui08yPiZCAVTqb4G9KXjtJOdHYp0gcAKKqwxOEmjp2HtU8gjWnexlaz2FBw
 jV4WxEJ6KkM+Uxdr+FKpx/JcqpzMG2m3UfzxPskW0xvdkV0cuUkW9b1GX4sk
X-Received: by 2002:a05:6512:251e:b0:5ad:4f1c:8e50 with SMTP id
 2adb3069b0e04-5ae9d5a57f4mr478916e87.37.1782284788947; Wed, 24 Jun 2026
 00:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-2-aadeshveer07@gmail.com> <ajlhiEZ4TdBFvdMu@x1.local>
In-Reply-To: <ajlhiEZ4TdBFvdMu@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 24 Jun 2026 12:36:16 +0530
X-Gm-Features: AVVi8CfI0LG8rPkQQDQTQbspGty-fM3mJ9Wgko8tUF0HrrJax_pW3Zhi3GJsx_U
Message-ID: <CA++cPvJGwOQpSD3zTNAmpxE2JSCZrh5K4taVuAavDMOggBLcJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] migration: add RAM Block fields and helpers for
 fast snapshot load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 22, 2026 at 9:53=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jun 18, 2026 at 08:50:06AM +0530, Aadeshveer Singh wrote:
> > Add two fields per RAMBlock:
> >
> > - nonzeropages: Mirrors the mapped-ram bitmap for storing which pages
> >   are present in file and which are zero.
> > - pending_bmap: Bitmap to store internal state of which pages have been
> >   read by some thread to ensure coordination between threads.
> >
> > Both fields are allocated and initialized in ram_load_setup and freed i=
n
> > ram_load_cleanup. nonzeropages is populated in parse_ramblock_mapped_ra=
m
> > eliminating the use of a temporary bitmap.
> >
> > Change ram_load() to load using ram_load_precopy() in case of fast
> > snapshot load.
> >
> > Also add migrate_fast_snapshot_load() returning true when both
> > postcopy-ram and mapped-ram capabilities are set.
> >
> > Update qemu_get_buffer_at() to not set error to make it thread safe. Al=
l
> > the callers of qemu_get_buffer_at(), take care of error handling.
> >
> > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > ---
> >  include/system/ramblock.h |  8 +++++
> >  migration/options.c       |  5 ++++
> >  migration/options.h       |  1 +
> >  migration/qemu-file.c     | 10 +------
> >  migration/ram.c           | 61 ++++++++++++++++++++++++++++++++-------
> >  5 files changed, 65 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/system/ramblock.h b/include/system/ramblock.h
> > index 4435f8d55f..73275d0459 100644
> > --- a/include/system/ramblock.h
> > +++ b/include/system/ramblock.h
> > @@ -60,6 +60,14 @@ struct RAMBlock {
> >
> >      /* Bitmap of already received pages.  Only used on destination sid=
e. */
> >      unsigned long *receivedmap;
> > +    /* Bitmap of zero pages. Used for fast snapshot load. */
> > +    unsigned long *nonzeropages;
>
> We have file_bmap, only used on source for now.  I think we can safely
> reuse it by caching the pointer allocated.
Agreed will drop nonzeropages and reuse file_bmap for this in v2

>
> > +    /*
> > +     * Bitmap for pages that are yet to be read from disk. It is requi=
red for
> > +     * fault thread and eager thread to keep note of which pages are c=
urrently
> > +     * being read. Used by fast snapshot load.
> > +     */
> > +    unsigned long *pending_bmap;
>
> We have receivedmap right above, and it's always allocated on dest.  IIUC
> we can directly use it.
>
> It's also already set by uffd helpers, see qemu_ufd_copy_ioctl().
> Currently it's a bit ugly put under a "if (!ret)"..  if you want you can
> clean it up a bit.
>
> There, we may want to skip page_requested or page_request_mutex operation=
s
> for file load because they're not necessary.
>

I looked into reusing receivedmap here instead of creating
pending_bmap, but doing so creates a race condition that breaks the
postcopy blocktime calculations.

receivedmap strictly tracks pages that have been successfully placed
in the VM. My pending_bmap tracks pages that any thread is actively
loading (reading from disk).

If we use receivedmap to track in-load pages, and a vCPU faults on a
page that the eager thread is currently reading, the fault thread will
see the bit set in receivedmap. It will then incorrectly assume the
page is already in the VM and skip tracking the blocktime for that
fault, even though the eager thread hasn't actually called place_page
yet. Keeping pending_bmap separate ensures the fault thread accurately
tracks blocktime until placement is actually complete.

Regarding the cleanup in qemu_ufd_copy_ioctl(), I agree we can skip
the page_requested operations for the file load. I also noticed a
potential race where if the eager thread places a page just before the
fault thread attempts to, we might hit an assert there. I will look
into returning safely instead of asserting to harden this, and I will
include the cleanup in v2.

> >
> >      /*
> >       * bitmap to track already cleared dirty bitmap.  When the bit is
> > diff --git a/migration/options.c b/migration/options.c
> > index 5cbfd29099..5f80dd5b42 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -467,6 +467,11 @@ bool migrate_rdma(void)
> >      return s->rdma_migration;
> >  }
> >
> > +bool migrate_fast_snapshot_load(void)
> > +{
> > +    return migrate_mapped_ram() && migrate_postcopy_ram();
> > +}
> > +
> >  typedef enum WriteTrackingSupport {
> >      WT_SUPPORT_UNKNOWN =3D 0,
> >      WT_SUPPORT_ABSENT,
> > diff --git a/migration/options.h b/migration/options.h
> > index b46221998a..a81ca40d23 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -54,6 +54,7 @@ bool migrate_multifd_flush_after_each_section(void);
> >  bool migrate_postcopy(void);
> >  bool migrate_rdma(void);
> >  bool migrate_tls(void);
> > +bool migrate_fast_snapshot_load(void);
> >
> >  /* capabilities helpers */
> >
> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > index d5a48115bd..602ece1b74 100644
> > --- a/migration/qemu-file.c
> > +++ b/migration/qemu-file.c
> > @@ -553,17 +553,9 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t=
 *buf, size_t buflen,
> >  size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
> >                            off_t pos)
> >  {
> > -    Error *err =3D NULL;
> > -
> > -    if (f->last_error) {
> > -        return 0;
> > -    }
>
> Let's keep this line, this is thread-safe and if we have a prior error it
> seems still reasonable to return immediately.  Then leave below one line
> change to be a small separate patch would be nicer.
>
> > -
> > -    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, &err) < 0) {
> > -        qemu_file_set_error_obj(f, -EIO, err);
> > +    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, NULL) < 0) {
> >          return 0;
> >      }
> > -
> >      return buflen;
> >  }
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index fc38ffbf8a..c2bacf3dfc 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -252,6 +252,31 @@ int foreach_not_ignored_block(RAMBlockIterFunc fun=
c, void *opaque)
> >      return ret;
> >  }
> >
> > +static void ramblock_non_zero_map_init(void)
> > +{
> > +    RAMBlock *rb;
> > +
> > +    RAMBLOCK_FOREACH_NOT_IGNORED(rb)
> > +    {
>
> Let's follow QEMU's coding style, see:
>
> https://qemu-project.gitlab.io/qemu/devel/style.html#block-structure
>
> So:
>
>     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>         ...
>     }
>
> The other thing is, if we pre-allocate this bmap, then it might be wise t=
o
> double check this size suites what to be read later in the snapshot file
> header, in parse_ramblock_mapped_ram().  We can fail the load immediately
> if we found the size requested in header is larger than what is allocated
> here (aka, max_length).
>
> We have some length checks, like:
>
>     if (length !=3D block->used_length) {
>         ret =3D qemu_ram_resize(block, length, &local_err);
>         if (local_err) {
>             error_report_err(local_err);
>             return ret;
>         }
>     }
>
> But I think that !=3D isn't as safe.. we should likely check max_length
> first.  This can also be a separate patch just to introduce the file_bmap
> to RAMBlock, so that sync mapped-ram can already use it.
>
> > +        assert(!rb->nonzeropages);
> > +        size_t size =3D rb->max_length >> qemu_target_page_bits();
> > +        rb->nonzeropages =3D bitmap_new(size);
> > +    }
> > +}
> > +
> > +static void ramblock_pending_bmap_init(void)
> > +{
> > +    RAMBlock *rb;
> > +
> > +    RAMBLOCK_FOREACH_NOT_IGNORED(rb)
> > +    {
>
> Similar indent issue, IIUC this function can be dropped after reusing
> receivedmap.
>
> > +        assert(!rb->pending_bmap);
> > +        size_t size =3D rb->max_length >> qemu_target_page_bits();
> > +        rb->pending_bmap =3D bitmap_new(size);
> > +        bitmap_set(rb->pending_bmap, 0, size);
> > +    }
> > +}
> > +
> >  static void ramblock_recv_map_init(void)
> >  {
> >      RAMBlock *rb;
> > @@ -3749,6 +3774,12 @@ static int ram_load_setup(QEMUFile *f, void *opa=
que, Error **errp)
> >  {
> >      xbzrle_load_setup();
> >      ramblock_recv_map_init();
> > +    if (migrate_mapped_ram()) {
> > +        ramblock_non_zero_map_init();
> > +    }
> > +    if (migrate_fast_snapshot_load()) {
> > +        ramblock_pending_bmap_init();
> > +    }
> >
> >      return 0;
> >  }
> > @@ -3768,6 +3799,10 @@ static int ram_load_cleanup(void *opaque)
> >      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> >          g_free(rb->receivedmap);
> >          rb->receivedmap =3D NULL;
> > +        g_free(rb->pending_bmap);
> > +        rb->pending_bmap =3D NULL;
> > +        g_free(rb->nonzeropages);
> > +        rb->nonzeropages =3D NULL;
>
> For new code, IMHO we can use g_clear_pointer().
>
> >      }
> >
> >      return 0;
> > @@ -4102,7 +4137,7 @@ static bool read_ramblock_mapped_ram(QEMUFile *f,=
 RAMBlock *block,
> >              host =3D host_from_ram_block_offset(block, offset);
> >              if (!host) {
> >                  error_setg(errp, "page outside of ramblock %s range",
> > -                           block->idstr);
> > +                            block->idstr);
>
> Looks like irrelevant line changes, let's try to not touch them if they'r=
e
> not needed.
>
> >                  return false;
> >              }
> >
> > @@ -4110,10 +4145,10 @@ static bool read_ramblock_mapped_ram(QEMUFile *=
f, RAMBlock *block,
> >
> >              if (migrate_multifd()) {
> >                  read =3D ram_load_multifd_pages(host, size,
> > -                                              block->pages_offset + of=
fset);
> > +                                                block->pages_offset + =
offset);
> >              } else {
> >                  read =3D qemu_get_buffer_at(f, host, size,
> > -                                          block->pages_offset + offset=
);
> > +                                            block->pages_offset + offs=
et);
>
> Same here.
>
> >              }
> >
> >              if (!read) {
> > @@ -4142,7 +4177,6 @@ err:
> >  static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
> >                                        ram_addr_t length, Error **errp)
> >  {
> > -    g_autofree unsigned long *bitmap =3D NULL;
> >      MappedRamHeader header;
> >      size_t bitmap_size;
> >      long num_pages;
> > @@ -4174,15 +4208,18 @@ static void parse_ramblock_mapped_ram(QEMUFile =
*f, RAMBlock *block,
> >      num_pages =3D length / header.page_size;
> >      bitmap_size =3D BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
> >
> > -    bitmap =3D g_malloc0(bitmap_size);
> > -    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
> > +    if (qemu_get_buffer_at(f, (uint8_t *)block->nonzeropages, bitmap_s=
ize,
> >                             header.bitmap_offset) !=3D bitmap_size) {
> >          error_setg(errp, "Error reading dirty bitmap");
> >          return;
> >      }
> >
> > -    if (!read_ramblock_mapped_ram(f, block, num_pages, bitmap, errp)) =
{
> > -        return;
> > +    if (!migrate_fast_snapshot_load()) {
>
> Nitpick: when reaching here it must have mapped-ram enabled, we can
> directly check migrate_postcopy_ram() here.
>
> > +        /* Do not load RAM during setup for fast snapshot load */
> > +        if (!read_ramblock_mapped_ram(f, block, num_pages, block->nonz=
eropages,
> > +                                      errp)) {
> > +            return;
> > +        }
> >      }
> >
> >      /* Skip pages array */
> > @@ -4460,9 +4497,11 @@ static int ram_load(QEMUFile *f, void *opaque, i=
nt version_id)
> >      static uint64_t seq_iter;
> >      /*
> >       * If system is running in postcopy mode, page inserts to host mem=
ory must
> > -     * be atomic
> > +     * be atomic. However, fast snapshot load uses the mapped ram prec=
opy like
> > +     * path to read block headers and populating bitmaps.
> >       */
> > -    bool postcopy_running =3D postcopy_is_running();
> > +    bool load_using_postcopy =3D
> > +        postcopy_is_running() && !migrate_fast_snapshot_load();
>
> I think this change is correct, it's just that I believe it'll be hard to
> follow for most readers.
>
> Here, what you really need is to parse the ramblock headers only, it's ju=
st
> that we used to have both steps (RAM setup + precopy) all processed in th=
e
> same ram_load_precopy() function, and here you want to leverage the "RAM
> setup" phase only.
>
> Maybe rename the bool to load_postcopy_pages?  That may help to explain w=
hy
> in your case postcopy-ram=3Don but you don't set this bool to true: it's
> because your case doesn't need to load any page in postcopy way.
>
> Maybe something like this to be slightly more verbose:
>
>   bool ram_should_load_postcopy_pages(void)
>   {
>       /* This is pure precopy, we don't need to load pages in postcopy wa=
y */
>       if (!postcopy_is_running()) {
>           return false;
>       }
>
>       /*
>        * This is postcopy, but when with mapped-ram, pages are not loaded
>        * in the migration stream here, but done separately in a thread ea=
gerly
>        * reading pages from the snapshot.  Here, we only need to read the
>        * ram headers, reusing the precopy code.  TODO: when we have separ=
ate
>        * function to parse RAM headers we should switch to that.
>        */
>        if (migrate_mapped_ram()) {
>            return false;
>        }
>
>        /*
>         * Genuine network postcopy, we will load pages in this current st=
ream
>         * and they need to be done in postcopy way.
>         */
>        return true;
>   }
>
>   ...
>   bool load_postcopy_pages =3D ram_expects_postcopy_pages();
>
> Thanks,
>
> >
> >      seq_iter++;
> >
> > @@ -4478,7 +4517,7 @@ static int ram_load(QEMUFile *f, void *opaque, in=
t version_id)
> >       */
> >      trace_ram_load_start();
> >      WITH_RCU_READ_LOCK_GUARD() {
> > -        if (postcopy_running) {
> > +        if (load_using_postcopy) {
> >              /*
> >               * Note!  Here RAM_CHANNEL_PRECOPY is the precopy channel =
of
> >               * postcopy migration, we have another RAM_CHANNEL_POSTCOP=
Y to
> > --
> > 2.54.0
> >
>
> --
> Peter Xu
>

