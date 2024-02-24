Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7CBC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 22:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1re0wf-0006Ea-Sf; Sat, 24 Feb 2024 17:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1re0wb-0006Db-Vj
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 17:56:34 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1re0wY-0003x3-LD
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 17:56:33 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5645960cd56so1885756a12.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 14:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708815387; x=1709420187; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhKjVuSKHdxmZ6FMJqWej32CakT9b+B/Kf8kFYqJweg=;
 b=AUEWH8tQi95ZFVq0bW8zHkmsx08NDON8M2X6F6S3m6+t78vEYiM/31kRNmDGFd7LBN
 QP0p3Jk+A1x2A6cEDeTQQ2QHDC0TcfrzXt3jePA3OXNhb/GpTR2vblGrQlDoSYfsqXuI
 EkyKuHit0RfICaArlUBVnM+OWvxfk1npSH+hYzziJneU24wK+bAMI32ci8HOLJYVAJZI
 W6tFe0Ky0y89/8AuJKXfakZP7tB9vZSDSmHwzbFz8WbOj+eQarSf80I6/750v3ryN9qE
 8FQWPiK5HsU5xc+H5ODo1jV7OcQuAsLxj0Q06rVFGEsjBMzyZ/cBvNiMrDCDznQ+KpDX
 Rn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708815387; x=1709420187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhKjVuSKHdxmZ6FMJqWej32CakT9b+B/Kf8kFYqJweg=;
 b=P+u4JYJIRmq1p9umuncZFweBPY7mqhpbTxnl65ikCrOJL7jcQdauWW5gDjdnpfwZgn
 j5Ph5+30m3ze8gqono1lImJ4nkeAvXYPmHoGQjnQ0U59C6coGqGoDOc/HdaZAkYIc/vE
 QhEe613tFvsWcmSbWXyHR1roiRGZZL6LbaLNZUDHsBl4q1YMTKH/P8R3ojYpCTQTPEjm
 HeqGBG9cYWJkb+drl+T1mOoFVm622KkUKFDpSe5C//9R4gQn9asdEYIoIypMhAV6ZnYE
 jjjBimnN9lYysGOQmK2r/lHkwE8kh3QCY7Va6JE8lQPwzK80wGKXwtXxIi3rH+6LuGFC
 h6Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ35dJ6Rf3Hib1xgiC5ltyclCR/NP9JuddOMuaCwh/FXutI07TpXQgbVliPD1v8cSdf2Q0fA9oiHdxhzG5foTBfyw3/hk=
X-Gm-Message-State: AOJu0Yyh/oLQMunyARSFQCSAYchDgUU+dq1skrkRLdDBwRMdVeyJmuB8
 IIPL9jfn6kkHFMJ0MM1jGtsQYH9lNQ2Oboc/v4GFCiElm+Ypakf/zHK9elgy1drV3KADMMNl4vz
 QEx0Vz0ZYqAiTwUnoaLw4B9RIEXwGITd/gNy1AA==
X-Google-Smtp-Source: AGHT+IG2GgSZfAcmzl4TCtf5PsrEqrHFIn/rxmjaj5fow17CX5tSXdrb6Qd8HNW1ZaYWy7cj80DVDcVDQFO6uq+PrR4=
X-Received: by 2002:a05:6402:2693:b0:565:ac6f:9f73 with SMTP id
 w19-20020a056402269300b00565ac6f9f73mr1734038edd.34.1708815386578; Sat, 24
 Feb 2024 14:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-4-hao.xiang@bytedance.com> <877cixbkc5.fsf@suse.de>
 <ZdgA-Wv9xlZbedD5@x1n>
 <CAAYibXiPEqFdypDwK2e=6D+A1O_Q3OLdakqjanT3PaPKgXtg2w@mail.gmail.com>
In-Reply-To: <CAAYibXiPEqFdypDwK2e=6D+A1O_Q3OLdakqjanT3PaPKgXtg2w@mail.gmail.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Sat, 24 Feb 2024 14:56:15 -0800
Message-ID: <CAAYibXhA=U8mp5Mid30OvgGfSOD5Ly2ESKjc67sPsouO429Xeg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/7] migration/multifd: Zero page
 transmission on the multifd thread.
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 22, 2024 at 9:15=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.com>=
 wrote:
>
> On Thu, Feb 22, 2024 at 6:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Wed, Feb 21, 2024 at 06:04:10PM -0300, Fabiano Rosas wrote:
> > > Hao Xiang <hao.xiang@bytedance.com> writes:
> > >
> > > > 1. Implements the zero page detection and handling on the multifd
> > > > threads for non-compression, zlib and zstd compression backends.
> > > > 2. Added a new value 'multifd' in ZeroPageDetection enumeration.
> > > > 3. Add proper asserts to ensure pages->normal are used for normal p=
ages
> > > > in all scenarios.
> > > >
> > > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > > > ---
> > > >  migration/meson.build         |  1 +
> > > >  migration/multifd-zero-page.c | 59 +++++++++++++++++++++++++++++++=
++++
> > > >  migration/multifd-zlib.c      | 26 ++++++++++++---
> > > >  migration/multifd-zstd.c      | 25 ++++++++++++---
> > > >  migration/multifd.c           | 50 +++++++++++++++++++++++------
> > > >  migration/multifd.h           |  7 +++++
> > > >  qapi/migration.json           |  4 ++-
> > > >  7 files changed, 151 insertions(+), 21 deletions(-)
> > > >  create mode 100644 migration/multifd-zero-page.c
> > > >
> > > > diff --git a/migration/meson.build b/migration/meson.build
> > > > index 92b1cc4297..1eeb915ff6 100644
> > > > --- a/migration/meson.build
> > > > +++ b/migration/meson.build
> > > > @@ -22,6 +22,7 @@ system_ss.add(files(
> > > >    'migration.c',
> > > >    'multifd.c',
> > > >    'multifd-zlib.c',
> > > > +  'multifd-zero-page.c',
> > > >    'ram-compress.c',
> > > >    'options.c',
> > > >    'postcopy-ram.c',
> > > > diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero=
-page.c
> > > > new file mode 100644
> > > > index 0000000000..f0cd8e2c53
> > > > --- /dev/null
> > > > +++ b/migration/multifd-zero-page.c
> > > > @@ -0,0 +1,59 @@
> > > > +/*
> > > > + * Multifd zero page detection implementation.
> > > > + *
> > > > + * Copyright (c) 2024 Bytedance Inc
> > > > + *
> > > > + * Authors:
> > > > + *  Hao Xiang <hao.xiang@bytedance.com>
> > > > + *
> > > > + * This work is licensed under the terms of the GNU GPL, version 2=
 or later.
> > > > + * See the COPYING file in the top-level directory.
> > > > + */
> > > > +
> > > > +#include "qemu/osdep.h"
> > > > +#include "qemu/cutils.h"
> > > > +#include "exec/ramblock.h"
> > > > +#include "migration.h"
> > > > +#include "multifd.h"
> > > > +#include "options.h"
> > > > +#include "ram.h"
> > > > +
> > > > +void multifd_zero_page_check_send(MultiFDSendParams *p)
> > > > +{
> > > > +    /*
> > > > +     * QEMU older than 9.0 don't understand zero page
> > > > +     * on multifd channel. This switch is required to
> > > > +     * maintain backward compatibility.
> > > > +     */
> > > > +    bool use_multifd_zero_page =3D
> > > > +        (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_=
MULTIFD);
> > > > +    MultiFDPages_t *pages =3D p->pages;
> > > > +    RAMBlock *rb =3D pages->block;
> > > > +
> > > > +    assert(pages->num !=3D 0);
> > > > +    assert(pages->normal_num =3D=3D 0);
> > > > +    assert(pages->zero_num =3D=3D 0);
> > >
> > > We can drop these before the final version.
> > >
> > > > +
> > > > +    for (int i =3D 0; i < pages->num; i++) {
> > > > +        uint64_t offset =3D pages->offset[i];
> > > > +        if (use_multifd_zero_page &&
> > > > +            buffer_is_zero(rb->host + offset, p->page_size)) {
> > > > +            pages->zero[pages->zero_num] =3D offset;
> > > > +            pages->zero_num++;
> > > > +            ram_release_page(rb->idstr, offset);
> > > > +        } else {
> > > > +            pages->normal[pages->normal_num] =3D offset;
> > > > +            pages->normal_num++;
> > > > +        }
> > > > +    }
> > >
> > > I don't think it's super clean to have three arrays offset, zero and
> > > normal, all sized for the full packet size. It might be possible to j=
ust
> > > carry a bitmap of non-zero pages along with pages->offset and operate=
 on
> > > that instead.
> > >
> > > What do you think?
> > >
> > > Peter, any ideas? Should we just leave this for another time?
> >
> > Yeah I think a bitmap should save quite a few fields indeed, it'll howe=
ver
> > make the latter iteration slightly harder by walking both (offset[],
> > bitmap), process the page only if bitmap is set for the offset.
> >
> > IIUC we perhaps don't even need a bitmap?  AFAIU what we only need in
> > Multifdpages_t is one extra field to mark "how many normal pages", aka,
> > normal_num here (zero_num can be calculated from num-normal_num).  Then
> > the zero page detection logic should do two things:
> >
> >   - Sort offset[] array so that it starts with normal pages, followed u=
p by
> >     zero pages
> >
> >   - Setup normal_num to be the number of normal pages
> >
> > Then we reduce 2 new arrays (normal[], zero[]) + 2 new fields (normal_n=
um,
> > zero_num) -> 1 new field (normal_num).  It'll also be trivial to fill t=
he
> > packet header later because offset[] is exactly that.
> >
> > Side note - I still think it's confusing to read this patch and previou=
s
> > patch separately.  Obviously previous patch introduced these new fields
> > without justifying their values yet.  IMHO it'll be easier to review if=
 you
> > merge the two patches.
>
> Fabiano, thanks for catching this. I totally missed the backward
> compatibility thing.
> Peter, I will code the sorting and merge this patch with the previous one=
.
>
It turns out that we still need to add a "zero_pages" field in
MultiFDPacket_t because the existing field "pages_alloc" is not the
total number of pages in "offset". So source can set "zero_pages" from
pages->num - pages->num_normal but "zero_pages" needs to be set in the
packet.
> >
> > >
> > > > +}
> > > > +
> > > > +void multifd_zero_page_check_recv(MultiFDRecvParams *p)
> > > > +{
> > > > +    for (int i =3D 0; i < p->zero_num; i++) {
> > > > +        void *page =3D p->host + p->zero[i];
> > > > +        if (!buffer_is_zero(page, p->page_size)) {
> > > > +            memset(page, 0, p->page_size);
> > > > +        }
> > > > +    }
> > > > +}
> > > > diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> > > > index 012e3bdea1..cdfe0fa70e 100644
> > > > --- a/migration/multifd-zlib.c
> > > > +++ b/migration/multifd-zlib.c
> > > > @@ -123,13 +123,20 @@ static int zlib_send_prepare(MultiFDSendParam=
s *p, Error **errp)
> > > >      int ret;
> > > >      uint32_t i;
> > > >
> > > > +    multifd_zero_page_check_send(p);
> > > > +
> > > > +    if (!pages->normal_num) {
> > > > +        p->next_packet_size =3D 0;
> > > > +        goto out;
> > > > +    }
> > > > +
> > > >      multifd_send_prepare_header(p);
> > > >
> > > > -    for (i =3D 0; i < pages->num; i++) {
> > > > +    for (i =3D 0; i < pages->normal_num; i++) {
> > > >          uint32_t available =3D z->zbuff_len - out_size;
> > > >          int flush =3D Z_NO_FLUSH;
> > > >
> > > > -        if (i =3D=3D pages->num - 1) {
> > > > +        if (i =3D=3D pages->normal_num - 1) {
> > > >              flush =3D Z_SYNC_FLUSH;
> > > >          }
> > > >
> > > > @@ -138,7 +145,7 @@ static int zlib_send_prepare(MultiFDSendParams =
*p, Error **errp)
> > > >           * with compression. zlib does not guarantee that this is =
safe,
> > > >           * therefore copy the page before calling deflate().
> > > >           */
> > > > -        memcpy(z->buf, p->pages->block->host + pages->offset[i], p=
->page_size);
> > > > +        memcpy(z->buf, p->pages->block->host + pages->normal[i], p=
->page_size);
> > > >          zs->avail_in =3D p->page_size;
> > > >          zs->next_in =3D z->buf;
> > > >
> > > > @@ -172,10 +179,10 @@ static int zlib_send_prepare(MultiFDSendParam=
s *p, Error **errp)
> > > >      p->iov[p->iovs_num].iov_len =3D out_size;
> > > >      p->iovs_num++;
> > > >      p->next_packet_size =3D out_size;
> > > > -    p->flags |=3D MULTIFD_FLAG_ZLIB;
> > > >
> > > > +out:
> > > > +    p->flags |=3D MULTIFD_FLAG_ZLIB;
> > > >      multifd_send_fill_packet(p);
> > > > -
> > > >      return 0;
> > > >  }
> > > >
> > > > @@ -261,6 +268,14 @@ static int zlib_recv_pages(MultiFDRecvParams *=
p, Error **errp)
> > > >                     p->id, flags, MULTIFD_FLAG_ZLIB);
> > > >          return -1;
> > > >      }
> > > > +
> > > > +    multifd_zero_page_check_recv(p);
> > > > +
> > > > +    if (!p->normal_num) {
> > > > +        assert(in_size =3D=3D 0);
> > > > +        return 0;
> > > > +    }
> > > > +
> > > >      ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, =
errp);
> > > >
> > > >      if (ret !=3D 0) {
> > > > @@ -310,6 +325,7 @@ static int zlib_recv_pages(MultiFDRecvParams *p=
, Error **errp)
> > > >                     p->id, out_size, expected_size);
> > > >          return -1;
> > > >      }
> > > > +
> > > >      return 0;
> > > >  }
> > > >
> > > > diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> > > > index dc8fe43e94..27a1eba075 100644
> > > > --- a/migration/multifd-zstd.c
> > > > +++ b/migration/multifd-zstd.c
> > > > @@ -118,19 +118,26 @@ static int zstd_send_prepare(MultiFDSendParam=
s *p, Error **errp)
> > > >      int ret;
> > > >      uint32_t i;
> > > >
> > > > +    multifd_zero_page_check_send(p);
> > > > +
> > > > +    if (!pages->normal_num) {
> > > > +        p->next_packet_size =3D 0;
> > > > +        goto out;
> > > > +    }
> > > > +
> > > >      multifd_send_prepare_header(p);
> >
> > If this forms a pattern we can introduce multifd_send_prepare_common():
>
> I will add that in the next version.
>
> >
> > bool multifd_send_prepare_common()
> > {
> >     multifd_zero_page_check_send();
> >     if (...) {
> >
> >     }
> >     multifd_send_prepare_header();
> > }
> >
> > > >
> > > >      z->out.dst =3D z->zbuff;
> > > >      z->out.size =3D z->zbuff_len;
> > > >      z->out.pos =3D 0;
> > > >
> > > > -    for (i =3D 0; i < pages->num; i++) {
> > > > +    for (i =3D 0; i < pages->normal_num; i++) {
> > > >          ZSTD_EndDirective flush =3D ZSTD_e_continue;
> > > >
> > > > -        if (i =3D=3D pages->num - 1) {
> > > > +        if (i =3D=3D pages->normal_num - 1) {
> > > >              flush =3D ZSTD_e_flush;
> > > >          }
> > > > -        z->in.src =3D p->pages->block->host + pages->offset[i];
> > > > +        z->in.src =3D p->pages->block->host + pages->normal[i];
> > > >          z->in.size =3D p->page_size;
> > > >          z->in.pos =3D 0;
> > > >
> > > > @@ -161,10 +168,10 @@ static int zstd_send_prepare(MultiFDSendParam=
s *p, Error **errp)
> > > >      p->iov[p->iovs_num].iov_len =3D z->out.pos;
> > > >      p->iovs_num++;
> > > >      p->next_packet_size =3D z->out.pos;
> > > > -    p->flags |=3D MULTIFD_FLAG_ZSTD;
> > > >
> > > > +out:
> > > > +    p->flags |=3D MULTIFD_FLAG_ZSTD;
> > > >      multifd_send_fill_packet(p);
> > > > -
> > > >      return 0;
> > > >  }
> > > >
> > > > @@ -257,6 +264,14 @@ static int zstd_recv_pages(MultiFDRecvParams *=
p, Error **errp)
> > > >                     p->id, flags, MULTIFD_FLAG_ZSTD);
> > > >          return -1;
> > > >      }
> > > > +
> > > > +    multifd_zero_page_check_recv(p);
> > > > +
> > > > +    if (!p->normal_num) {
> > > > +        assert(in_size =3D=3D 0);
> > > > +        return 0;
> > > > +    }
> > > > +
> > > >      ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, =
errp);
> > > >
> > > >      if (ret !=3D 0) {
> > > > diff --git a/migration/multifd.c b/migration/multifd.c
> > > > index a33dba40d9..fbb40ea10b 100644
> > > > --- a/migration/multifd.c
> > > > +++ b/migration/multifd.c
> > > > @@ -11,6 +11,7 @@
> > > >   */
> > > >
> > > >  #include "qemu/osdep.h"
> > > > +#include "qemu/cutils.h"
> > > >  #include "qemu/rcu.h"
> > > >  #include "exec/target_page.h"
> > > >  #include "sysemu/sysemu.h"
> > > > @@ -126,6 +127,8 @@ static int nocomp_send_prepare(MultiFDSendParam=
s *p, Error **errp)
> > > >      MultiFDPages_t *pages =3D p->pages;
> > > >      int ret;
> > > >
> > > > +    multifd_zero_page_check_send(p);
> > > > +
> > > >      if (!use_zero_copy_send) {
> > > >          /*
> > > >           * Only !zerocopy needs the header in IOV; zerocopy will
> > > > @@ -134,13 +137,13 @@ static int nocomp_send_prepare(MultiFDSendPar=
ams *p, Error **errp)
> > > >          multifd_send_prepare_header(p);
> > > >      }
> > > >
> > > > -    for (int i =3D 0; i < pages->num; i++) {
> > > > -        p->iov[p->iovs_num].iov_base =3D pages->block->host + page=
s->offset[i];
> > > > +    for (int i =3D 0; i < pages->normal_num; i++) {
> > > > +        p->iov[p->iovs_num].iov_base =3D pages->block->host + page=
s->normal[i];
> > > >          p->iov[p->iovs_num].iov_len =3D p->page_size;
> > > >          p->iovs_num++;
> > > >      }
> > > >
> > > > -    p->next_packet_size =3D pages->num * p->page_size;
> > > > +    p->next_packet_size =3D pages->normal_num * p->page_size;
> > > >      p->flags |=3D MULTIFD_FLAG_NOCOMP;
> > > >
> > > >      multifd_send_fill_packet(p);
> > > > @@ -202,6 +205,13 @@ static int nocomp_recv_pages(MultiFDRecvParams=
 *p, Error **errp)
> > > >                     p->id, flags, MULTIFD_FLAG_NOCOMP);
> > > >          return -1;
> > > >      }
> > > > +
> > > > +    multifd_zero_page_check_recv(p);
> > > > +
> > > > +    if (!p->normal_num) {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > >      for (int i =3D 0; i < p->normal_num; i++) {
> > > >          p->iov[i].iov_base =3D p->host + p->normal[i];
> > > >          p->iov[i].iov_len =3D p->page_size;
> > > > @@ -339,7 +349,7 @@ void multifd_send_fill_packet(MultiFDSendParams=
 *p)
> > > >
> > > >      packet->flags =3D cpu_to_be32(p->flags);
> > > >      packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
> > > > -    packet->normal_pages =3D cpu_to_be32(pages->num);
> > > > +    packet->normal_pages =3D cpu_to_be32(pages->normal_num);
> > > >      packet->zero_pages =3D cpu_to_be32(pages->zero_num);
> > > >      packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
> > > >
> > > > @@ -350,18 +360,25 @@ void multifd_send_fill_packet(MultiFDSendPara=
ms *p)
> > > >          strncpy(packet->ramblock, pages->block->idstr, 256);
> > > >      }
> > > >
> > > > -    for (i =3D 0; i < pages->num; i++) {
> > > > +    for (i =3D 0; i < pages->normal_num; i++) {
> > > >          /* there are architectures where ram_addr_t is 32 bit */
> > > > -        uint64_t temp =3D pages->offset[i];
> > > > +        uint64_t temp =3D pages->normal[i];
> > > >
> > > >          packet->offset[i] =3D cpu_to_be64(temp);
> > > >      }
> > > >
> > > > +    for (i =3D 0; i < pages->zero_num; i++) {
> > > > +        /* there are architectures where ram_addr_t is 32 bit */
> > > > +        uint64_t temp =3D pages->zero[i];
> > > > +
> > > > +        packet->offset[pages->normal_num + i] =3D cpu_to_be64(temp=
);
> > > > +    }
> > > > +
> > > >      p->packets_sent++;
> > > > -    p->total_normal_pages +=3D pages->num;
> > > > +    p->total_normal_pages +=3D pages->normal_num;
> > > >      p->total_zero_pages +=3D pages->zero_num;
> > > >
> > > > -    trace_multifd_send(p->id, packet_num, pages->num, pages->zero_=
num,
> > > > +    trace_multifd_send(p->id, packet_num, pages->normal_num, pages=
->zero_num,
> > > >                         p->flags, p->next_packet_size);
> > > >  }
> > > >
> > > > @@ -451,6 +468,18 @@ static int multifd_recv_unfill_packet(MultiFDR=
ecvParams *p, Error **errp)
> > > >          p->normal[i] =3D offset;
> > > >      }
> > > >
> > > > +    for (i =3D 0; i < p->zero_num; i++) {
> > > > +        uint64_t offset =3D be64_to_cpu(packet->offset[p->normal_n=
um + i]);
> > > > +
> > > > +        if (offset > (p->block->used_length - p->page_size)) {
> > > > +            error_setg(errp, "multifd: offset too long %" PRIu64
> > > > +                       " (max " RAM_ADDR_FMT ")",
> > > > +                       offset, p->block->used_length);
> > > > +            return -1;
> > > > +        }
> > > > +        p->zero[i] =3D offset;
> > > > +    }
> > > > +
> > > >      return 0;
> > > >  }
> > > >
> > > > @@ -842,7 +871,7 @@ static void *multifd_send_thread(void *opaque)
> > > >
> > > >              stat64_add(&mig_stats.multifd_bytes,
> > > >                         p->next_packet_size + p->packet_len);
> > > > -            stat64_add(&mig_stats.normal_pages, pages->num);
> > > > +            stat64_add(&mig_stats.normal_pages, pages->normal_num)=
;
> > > >              stat64_add(&mig_stats.zero_pages, pages->zero_num);
> > > >
> > > >              multifd_pages_reset(p->pages);
> > > > @@ -1256,7 +1285,8 @@ static void *multifd_recv_thread(void *opaque=
)
> > > >          p->flags &=3D ~MULTIFD_FLAG_SYNC;
> > > >          qemu_mutex_unlock(&p->mutex);
> > > >
> > > > -        if (p->normal_num) {
> > > > +        if (p->normal_num + p->zero_num) {
> > > > +            assert(!(flags & MULTIFD_FLAG_SYNC));
> > >
> > > This breaks 8.2 -> 9.0 migration. QEMU 8.2 is still sending the SYNC
> > > along with the data packet.
> > >
> > > >              ret =3D multifd_recv_state->ops->recv_pages(p, &local_=
err);
> > > >              if (ret !=3D 0) {
> > > >                  break;
> > > > diff --git a/migration/multifd.h b/migration/multifd.h
> > > > index 9822ff298a..125f0bbe60 100644
> > > > --- a/migration/multifd.h
> > > > +++ b/migration/multifd.h
> > > > @@ -53,6 +53,11 @@ typedef struct {
> > > >      uint32_t unused32[1];    /* Reserved for future use */
> > > >      uint64_t unused64[3];    /* Reserved for future use */
> > > >      char ramblock[256];
> > > > +    /*
> > > > +     * This array contains the pointers to:
> > > > +     *  - normal pages (initial normal_pages entries)
> > > > +     *  - zero pages (following zero_pages entries)
> > > > +     */
> > > >      uint64_t offset[];
> > > >  } __attribute__((packed)) MultiFDPacket_t;
> > > >
> > > > @@ -224,6 +229,8 @@ typedef struct {
> > > >
> > > >  void multifd_register_ops(int method, MultiFDMethods *ops);
> > > >  void multifd_send_fill_packet(MultiFDSendParams *p);
> > > > +void multifd_zero_page_check_send(MultiFDSendParams *p);
> > > > +void multifd_zero_page_check_recv(MultiFDRecvParams *p);
> > > >
> > > >  static inline void multifd_send_prepare_header(MultiFDSendParams *=
p)
> > > >  {
> > > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > > index 99843a8e95..e2450b92d4 100644
> > > > --- a/qapi/migration.json
> > > > +++ b/qapi/migration.json
> > > > @@ -660,9 +660,11 @@
> > > >  #
> > > >  # @none: Do not perform zero page checking.
> > > >  #
> > > > +# @multifd: Perform zero page checking on the multifd sender threa=
d. (since 9.0)
> > > > +#
> > > >  ##
> > > >  { 'enum': 'ZeroPageDetection',
> > > > -  'data': [ 'legacy', 'none' ] }
> > > > +  'data': [ 'legacy', 'none', 'multifd' ] }
> > > >
> > > >  ##
> > > >  # @BitmapMigrationBitmapAliasTransform:
> > >
> >
> > --
> > Peter Xu
> >

