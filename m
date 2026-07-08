Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2CAC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTD6-0001Pn-Rb; Wed, 08 Jul 2026 10:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1whTD2-0001P5-So
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:25:09 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1whTCw-00069v-I4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:25:08 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-39c7225e58bso4800711fa.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783520699; cv=none;
 d=google.com; s=arc-20260327;
 b=pKNARkuvBQ2MGthTFUgCeStXL0uF8EImaL4kgSwseHUTaulONXmpSaab4dk/Cu4KSD
 BqGu79rf7xnFdL564Q3Y/byokoeuY/2jrz+Zr9kdMsrcmX49ITynEY/VcaWtNudW6vcF
 yleYWoJB4xaz5qpzEt1kHMaFjWXzQrYgICnTM8RE2V6BSxJFFTKWKNOH2evPDfDtvYW2
 FuItqo/ANYlfZaWAJ+J4FqeOJWjGaK8M/bvQCO0ch7zmfiEQ9nKoqFAvqJepWJZBIXgv
 HLh4ou3jACnZnZBM6m4B0rYtlDuX/vqmEAXEH1FxhWT1ocKyM8sxYRssMlcbA8CokARH
 JIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vSOaLZcUgzAKaCYBc+/NvmHZreXoNQDfNmMgBdOBYKU=;
 fh=NT0kq7NgLJ0wOp/qMyvn1NIPXsDSAQYGUZFkUZ2OApE=;
 b=ZyfnXmIc8OI5tt2828mMgOjfQmCKmlLW1zpCz8Z2+2oxAQLuI+zIFYBu0J2VkKZ3rD
 6Cu9sG8HWSnjFd7jpGUUztA8NDdrsJwpwFKNzDxoYDVqTwLukMnrBO+7QI3KDqT7s91e
 E/6tlfwIgsqB4yc0rASlqTbCDrm94LELKR7xyMK+SLXRR5Wcu7iRax8Uy/AcbWCHcYGb
 wxjNz9MmLhwwrr9fJ2WNpNXoCYIU32lfxAyK/fN+pyHI08kaJXzfpuzMvniXs0+FC/nF
 x0EUe+aqJW2vIs8xJaq2SY/YOjxVos2pSsHkzwpV69RtNF3H2H4iPTaTtHkk7iZuIyoL
 QE+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783520699; x=1784125499; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vSOaLZcUgzAKaCYBc+/NvmHZreXoNQDfNmMgBdOBYKU=;
 b=SeOWHH8kVP0JaaN3Cv1mopJoCHlUoRJPI4I8WNsshImwlZog54ZQigwazXTMBe7r5+
 LNIO0gTbMindGfpCwywyeaGhcn+9iz8BNzgzWsfzmNOirbknXoP12xrbuPjsevjIn4Ln
 hTHOuc7FAkdhQ7sFoCkZHNte+1om+D7oNlF7cN1wzqYmCCjYqvqeAFWfmBUkaV+3BN8P
 1Ir+a63cs+Qza+SnJFU298oJehPhLJwIksmbfPLg9DkecSFhrvDOvNAxaMtaZKUs2fyb
 HoOKZqH5MVrKI0rUPKagxk7MnjfOJjpJot1KJ732H0ITW9Qiq4cPJYKGEm/R4fkqbBUc
 CBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783520699; x=1784125499;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vSOaLZcUgzAKaCYBc+/NvmHZreXoNQDfNmMgBdOBYKU=;
 b=T67FZCm2bkaocHvjzdWTJAUYXvUnDrHD878Y7wpm6Ki6OkhOa/5o7ElOIti44YUr9y
 qaLor0EdceDU0ognDIWF7ySniUqsfl6D5K7JJh4HkSFcXxP9Pj4uwuW7Vhzs/RY5Jh/t
 yo39XzaqKh+utQlqmvrSnFVkZ5vddJzH3EYOQu1n2DL6+ICxE2BH3+FLLYgPvkSHI3xL
 AXBlkHiN/e2elGGVLtnbwv+Lwd2MPTkA4wgM88BPPIFsG5KPXj3AhMdkp9yh3OvhVrJs
 h8s1HN+O6Ru5fuMd13EG6b28XTcNGzSaLpin/vCdg8A1uRxXEubLAuouwhKW7JCJrFYc
 VmLQ==
X-Gm-Message-State: AOJu0YxFVY1+JM2hNO8DEK1TTg4k/KjgqLbJNEKBuraf27sZr4xsddhF
 DRQy3tK5S002CxZT9Cof29xfNrLf39baS0QO+eOw1FPWUQH2HWJ2kMAUYN1BpPb87gfI3gkFJ6f
 wq38z01bhedmFNrMEaebkCvtx2UrDlQI=
X-Gm-Gg: AfdE7cnqR1o1zp7uuVFpUaQ27Fe19vPWBB5YG8T4pRf57IralAabR/mhAcO1ccdDtmE
 J7fMu4FYUOtU/5dF0Z7vFDFf/cBhGGFEpm7hxubtNr7cn6yCpTzSuLZvBwrvB78q+nVjKGbJXpG
 uoa21Uw2w2th0vNFlwDGYF4Cd4Ap1gp17Jknch4lWEY6MSsLiiy48heP9GzutnC+Lr6fpDD3NUu
 JWP+W8+iX6yE2HdMqyTkPWRF+Fa7bwSy0OWkZglSz5KTh2T+Ahn59osqjN0UrIiCqZ5S8qALXRh
 JV4iguR4+IE1djL/MVWpr/LJRWGzveZcuokAMlbvXwTNCJeiseXE6cMCkPDf9TAcgYwyKBY=
X-Received: by 2002:a2e:b8c4:0:b0:393:5c4c:c482 with SMTP id
 38308e7fff4ca-39c7996f866mr6779321fa.29.1783520698789; Wed, 08 Jul 2026
 07:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <20260630081940.611092-4-aadeshveer07@gmail.com> <akwCJYxBS113ZKvH@x1.local>
In-Reply-To: <akwCJYxBS113ZKvH@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 8 Jul 2026 19:54:47 +0530
X-Gm-Features: AVVi8CdKLtckqKKTGAaNMle8Yf66JbhEySizXWaua42fY-4hXhICWgzbPnEGL88
Message-ID: <CA++cPvJDBipNRk5Kz2xTx=LvVf2tOe-whoLZH9cT8wY1aKxw7w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/7] migration: Use file_bmap for RAMBlock during
 incoming file load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 7, 2026 at 12:59=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Jun 30, 2026 at 01:49:36PM +0530, Aadeshveer Singh wrote:
> > Replace the temporary bitmap with the existing file_bmap attribute of
> > the RAMBlock. This acts as a preparatory change for the upcoming fast
> > snapshot load feature.
> >
> > Reusing this bitmap allows the destination to track page types during
> > a postcopy load, enabling faster, direct placement of zero pages.
> >
> > Since file_bmap is currently only utilized during the migration save
> > phase, it can be safely repurposed during the load phase without
> > introducing conflicts.
> >
> > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > ---
> >  migration/ram.c | 33 +++++++++++++++++++++++++++------
> >  1 file changed, 27 insertions(+), 6 deletions(-)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index fc38ffbf8a..4728f14d73 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -252,6 +252,17 @@ int foreach_not_ignored_block(RAMBlockIterFunc fun=
c, void *opaque)
> >      return ret;
> >  }
> >
> > +static void ramblock_file_bmap_init(void)
> > +{
> > +    RAMBlock *rb;
> > +
> > +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> > +        assert(!rb->file_bmap);
> > +        size_t size =3D rb->max_length >> qemu_target_page_bits();
>
> Hmm, I just notice mapped-ram always use guest psize for its bitmap.. eve=
n
> for huge pages.  In that case this is correct.
>
> > +        rb->file_bmap =3D bitmap_new(size);
> > +    }
> > +}
> > +
> >  static void ramblock_recv_map_init(void)
> >  {
> >      RAMBlock *rb;
> > @@ -3749,6 +3760,9 @@ static int ram_load_setup(QEMUFile *f, void *opaq=
ue, Error **errp)
> >  {
> >      xbzrle_load_setup();
> >      ramblock_recv_map_init();
> > +    if (migrate_mapped_ram()) {
> > +        ramblock_file_bmap_init();
> > +    }
> >
> >      return 0;
> >  }
> > @@ -3766,8 +3780,8 @@ static int ram_load_cleanup(void *opaque)
> >      xbzrle_load_cleanup();
> >
> >      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> > -        g_free(rb->receivedmap);
> > -        rb->receivedmap =3D NULL;
> > +        g_clear_pointer(&rb->receivedmap, g_free);
> > +        g_clear_pointer(&rb->file_bmap, g_free);
> >      }
> >
> >      return 0;
> > @@ -4142,11 +4156,18 @@ err:
> >  static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
> >                                        ram_addr_t length, Error **errp)
> >  {
> > -    g_autofree unsigned long *bitmap =3D NULL;
> >      MappedRamHeader header;
> >      size_t bitmap_size;
> >      long num_pages;
> >
> > +    if (length > block->max_length) {
> > +        error_setg(errp,
> > +                   "mapped-ram header length %" PRIu64 " exceeds "
> > +                   "RAMBlock(\"%s\") max_length %" PRIu64,
> > +                   (uint64_t)length, block->idstr, (uint64_t)block->ma=
x_length);
> > +        return;
> > +    }
> > +
> >      if (!mapped_ram_read_header(f, &header, errp)) {
> >          return;
> >      }
> > @@ -4174,14 +4195,14 @@ static void parse_ramblock_mapped_ram(QEMUFile =
*f, RAMBlock *block,
> >      num_pages =3D length / header.page_size;
> >      bitmap_size =3D BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
>
> Here I think it would still be good to check the page_size is the same as
> what was expected (in this case, guest page size), otherwise we should fa=
il
> because then the bitmap_size may still be unpredictable and it can cause
> illegal access (beyond the size of bitmap allocated) in worst case.


Hi Peter, thanks for the review,
Currently mapped_ram_read_header() already enforces header->page_size
=3D=3D TARGET_PAGE_SIZE and will throw error before reaching this point.
However if you would like an explicit check, let me know.

>
>
> Now I start to wonder when you're working on huge pages with the feature,
> did you stick with the bmap having guest page size, or did you modify it =
to
> be host page size?
>

To maintain consistency across systems and keep it simple I kept the
guest page size and then applied the range check to it.

>
> Thanks,
>
> >
> > -    bitmap =3D g_malloc0(bitmap_size);
> > -    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
> > +    if (qemu_get_buffer_at(f, (uint8_t *)block->file_bmap, bitmap_size=
,
> >                             header.bitmap_offset) !=3D bitmap_size) {
> >          error_setg(errp, "Error reading dirty bitmap");
> >          return;
> >      }
> >
> > -    if (!read_ramblock_mapped_ram(f, block, num_pages, bitmap, errp)) =
{
> > +    if (!read_ramblock_mapped_ram(f, block, num_pages, block->file_bma=
p,
> > +                                  errp)) {
> >          return;
> >      }
> >
> > --
> > 2.54.0
> >
>
> --
> Peter Xu
>

