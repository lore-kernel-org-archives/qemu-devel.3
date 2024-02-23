Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A0CC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 05:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdNuT-0002V4-OI; Fri, 23 Feb 2024 00:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdNuN-0002US-FK
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:15:39 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdNuE-0002kO-C0
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:15:39 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56566dfeb3bso355455a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 21:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708665326; x=1709270126; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZBbNiFgHHEMGjySZZ6/ffBPAgQN9EFBz0eKNJu/Tn8=;
 b=Q+S1Pp2S5zH80MrG0vekzKtMMFldTaUBcT/OZPhzCZ7JQXZ40gAxwluByXa7gpBb5v
 Et9n60WqzMSmTMxr7jjabNNIoLrjGih36lIGelbA8V/u1DquGV+NyxEuk0TvvlHuuwxh
 iBWvxydxVmmjGkylimtkIJUmPp/hjTXpC/ktagZ7xke3wqs7XZEU1ZavQjQtjQxdl3uT
 pXAOtT0PB3CCS80+l0CcQkhgWwMKkhzodSUWLRgW7NA/G5Zw/qHjPq9qdj/Ak8/xZUqc
 iDOrh9ht/QCd/t4vHa322LvzHCvtPZ0aXXTfPbxwSoTVwTn08hJQBG18w01nMsLJXvEq
 3I3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708665326; x=1709270126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZBbNiFgHHEMGjySZZ6/ffBPAgQN9EFBz0eKNJu/Tn8=;
 b=jbToIARPhpejb2lNqeEQU/gCLgvBiiRnT4wr2UfzlC0fXp4avFa7srJAQlh0umG6cy
 cxoESbepLNy1jT63n/i3qxkJRTFA2+m23ZKk5jCG9CelDNt9GJnXfUeeVt8WK+Oez0ds
 mv4F/rT2PFRi1/KA3RyXdQ0Km3Y4fHy8k7C3Uu0OvXpBkx8qxueDd8Qm/uPAenNCaAaj
 gaqt4PVbVgww++VyjoV+9DRn+4BIC3k18MzVMhLaO205Uq48IywS1tgpaWVzYoYqmHAP
 /pnvLFdpiv7udMaV2PEUosIgJQpQ9ISarGOL+2O4A+jLdSyDg2GLoQ//QOqdCrOcNiQ0
 S5ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJOC8lBueHQJAGYL8I+6zPi82NG3hgbSOkQLWL+PMkZqfY2DV6CMlMlFdsM/kEOhzSD2Gsp/SM1ihM26Vu9EEnXv4asKI=
X-Gm-Message-State: AOJu0YymbvaGi7pLotJzhRIAbH0ySPOa9cUxRba3Rqx/c1zsA46IsjFU
 +mhuau5X3uZa7rU66FIrfUgv6wrhvrjf+KzXgIAMDCG4Qm1m88ms+NcK+80Uka0Z8Z2c3T6TnBd
 fCXNiZGEQWwI+bnVoOcKEcNrUS37m2eyY69VkuQ==
X-Google-Smtp-Source: AGHT+IHf+T2F6b53RhXgp9x+WXNbOWYNOqCpHy030UrvNigOIhMw+B8HW9bd87TKtueK89wvJlo4Ic5d7O8hrS2/2NQ=
X-Received: by 2002:aa7:c68b:0:b0:565:21f1:4f27 with SMTP id
 n11-20020aa7c68b000000b0056521f14f27mr400724edq.23.1708665326055; Thu, 22 Feb
 2024 21:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-4-hao.xiang@bytedance.com> <877cixbkc5.fsf@suse.de>
 <ZdgA-Wv9xlZbedD5@x1n>
In-Reply-To: <ZdgA-Wv9xlZbedD5@x1n>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 22 Feb 2024 21:15:14 -0800
Message-ID: <CAAYibXiPEqFdypDwK2e=6D+A1O_Q3OLdakqjanT3PaPKgXtg2w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/7] migration/multifd: Zero page
 transmission on the multifd thread.
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 22, 2024 at 6:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Feb 21, 2024 at 06:04:10PM -0300, Fabiano Rosas wrote:
> > Hao Xiang <hao.xiang@bytedance.com> writes:
> >
> > > 1. Implements the zero page detection and handling on the multifd
> > > threads for non-compression, zlib and zstd compression backends.
> > > 2. Added a new value 'multifd' in ZeroPageDetection enumeration.
> > > 3. Add proper asserts to ensure pages->normal are used for normal pag=
es
> > > in all scenarios.
> > >
> > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > > ---
> > >  migration/meson.build         |  1 +
> > >  migration/multifd-zero-page.c | 59 +++++++++++++++++++++++++++++++++=
++
> > >  migration/multifd-zlib.c      | 26 ++++++++++++---
> > >  migration/multifd-zstd.c      | 25 ++++++++++++---
> > >  migration/multifd.c           | 50 +++++++++++++++++++++++------
> > >  migration/multifd.h           |  7 +++++
> > >  qapi/migration.json           |  4 ++-
> > >  7 files changed, 151 insertions(+), 21 deletions(-)
> > >  create mode 100644 migration/multifd-zero-page.c
> > >
> > > diff --git a/migration/meson.build b/migration/meson.build
> > > index 92b1cc4297..1eeb915ff6 100644
> > > --- a/migration/meson.build
> > > +++ b/migration/meson.build
> > > @@ -22,6 +22,7 @@ system_ss.add(files(
> > >    'migration.c',
> > >    'multifd.c',
> > >    'multifd-zlib.c',
> > > +  'multifd-zero-page.c',
> > >    'ram-compress.c',
> > >    'options.c',
> > >    'postcopy-ram.c',
> > > diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-p=
age.c
> > > new file mode 100644
> > > index 0000000000..f0cd8e2c53
> > > --- /dev/null
> > > +++ b/migration/multifd-zero-page.c
> > > @@ -0,0 +1,59 @@
> > > +/*
> > > + * Multifd zero page detection implementation.
> > > + *
> > > + * Copyright (c) 2024 Bytedance Inc
> > > + *
> > > + * Authors:
> > > + *  Hao Xiang <hao.xiang@bytedance.com>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> > > + * See the COPYING file in the top-level directory.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/cutils.h"
> > > +#include "exec/ramblock.h"
> > > +#include "migration.h"
> > > +#include "multifd.h"
> > > +#include "options.h"
> > > +#include "ram.h"
> > > +
> > > +void multifd_zero_page_check_send(MultiFDSendParams *p)
> > > +{
> > > +    /*
> > > +     * QEMU older than 9.0 don't understand zero page
> > > +     * on multifd channel. This switch is required to
> > > +     * maintain backward compatibility.
> > > +     */
> > > +    bool use_multifd_zero_page =3D
> > > +        (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_MU=
LTIFD);
> > > +    MultiFDPages_t *pages =3D p->pages;
> > > +    RAMBlock *rb =3D pages->block;
> > > +
> > > +    assert(pages->num !=3D 0);
> > > +    assert(pages->normal_num =3D=3D 0);
> > > +    assert(pages->zero_num =3D=3D 0);
> >
> > We can drop these before the final version.
> >
> > > +
> > > +    for (int i =3D 0; i < pages->num; i++) {
> > > +        uint64_t offset =3D pages->offset[i];
> > > +        if (use_multifd_zero_page &&
> > > +            buffer_is_zero(rb->host + offset, p->page_size)) {
> > > +            pages->zero[pages->zero_num] =3D offset;
> > > +            pages->zero_num++;
> > > +            ram_release_page(rb->idstr, offset);
> > > +        } else {
> > > +            pages->normal[pages->normal_num] =3D offset;
> > > +            pages->normal_num++;
> > > +        }
> > > +    }
> >
> > I don't think it's super clean to have three arrays offset, zero and
> > normal, all sized for the full packet size. It might be possible to jus=
t
> > carry a bitmap of non-zero pages along with pages->offset and operate o=
n
> > that instead.
> >
> > What do you think?
> >
> > Peter, any ideas? Should we just leave this for another time?
>
> Yeah I think a bitmap should save quite a few fields indeed, it'll howeve=
r
> make the latter iteration slightly harder by walking both (offset[],
> bitmap), process the page only if bitmap is set for the offset.
>
> IIUC we perhaps don't even need a bitmap?  AFAIU what we only need in
> Multifdpages_t is one extra field to mark "how many normal pages", aka,
> normal_num here (zero_num can be calculated from num-normal_num).  Then
> the zero page detection logic should do two things:
>
>   - Sort offset[] array so that it starts with normal pages, followed up =
by
>     zero pages
>
>   - Setup normal_num to be the number of normal pages
>
> Then we reduce 2 new arrays (normal[], zero[]) + 2 new fields (normal_num=
,
> zero_num) -> 1 new field (normal_num).  It'll also be trivial to fill the
> packet header later because offset[] is exactly that.
>
> Side note - I still think it's confusing to read this patch and previous
> patch separately.  Obviously previous patch introduced these new fields
> without justifying their values yet.  IMHO it'll be easier to review if y=
ou
> merge the two patches.

Fabiano, thanks for catching this. I totally missed the backward
compatibility thing.
Peter, I will code the sorting and merge this patch with the previous one.

>
> >
> > > +}
> > > +
> > > +void multifd_zero_page_check_recv(MultiFDRecvParams *p)
> > > +{
> > > +    for (int i =3D 0; i < p->zero_num; i++) {
> > > +        void *page =3D p->host + p->zero[i];
> > > +        if (!buffer_is_zero(page, p->page_size)) {
> > > +            memset(page, 0, p->page_size);
> > > +        }
> > > +    }
> > > +}
> > > diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> > > index 012e3bdea1..cdfe0fa70e 100644
> > > --- a/migration/multifd-zlib.c
> > > +++ b/migration/multifd-zlib.c
> > > @@ -123,13 +123,20 @@ static int zlib_send_prepare(MultiFDSendParams =
*p, Error **errp)
> > >      int ret;
> > >      uint32_t i;
> > >
> > > +    multifd_zero_page_check_send(p);
> > > +
> > > +    if (!pages->normal_num) {
> > > +        p->next_packet_size =3D 0;
> > > +        goto out;
> > > +    }
> > > +
> > >      multifd_send_prepare_header(p);
> > >
> > > -    for (i =3D 0; i < pages->num; i++) {
> > > +    for (i =3D 0; i < pages->normal_num; i++) {
> > >          uint32_t available =3D z->zbuff_len - out_size;
> > >          int flush =3D Z_NO_FLUSH;
> > >
> > > -        if (i =3D=3D pages->num - 1) {
> > > +        if (i =3D=3D pages->normal_num - 1) {
> > >              flush =3D Z_SYNC_FLUSH;
> > >          }
> > >
> > > @@ -138,7 +145,7 @@ static int zlib_send_prepare(MultiFDSendParams *p=
, Error **errp)
> > >           * with compression. zlib does not guarantee that this is sa=
fe,
> > >           * therefore copy the page before calling deflate().
> > >           */
> > > -        memcpy(z->buf, p->pages->block->host + pages->offset[i], p->=
page_size);
> > > +        memcpy(z->buf, p->pages->block->host + pages->normal[i], p->=
page_size);
> > >          zs->avail_in =3D p->page_size;
> > >          zs->next_in =3D z->buf;
> > >
> > > @@ -172,10 +179,10 @@ static int zlib_send_prepare(MultiFDSendParams =
*p, Error **errp)
> > >      p->iov[p->iovs_num].iov_len =3D out_size;
> > >      p->iovs_num++;
> > >      p->next_packet_size =3D out_size;
> > > -    p->flags |=3D MULTIFD_FLAG_ZLIB;
> > >
> > > +out:
> > > +    p->flags |=3D MULTIFD_FLAG_ZLIB;
> > >      multifd_send_fill_packet(p);
> > > -
> > >      return 0;
> > >  }
> > >
> > > @@ -261,6 +268,14 @@ static int zlib_recv_pages(MultiFDRecvParams *p,=
 Error **errp)
> > >                     p->id, flags, MULTIFD_FLAG_ZLIB);
> > >          return -1;
> > >      }
> > > +
> > > +    multifd_zero_page_check_recv(p);
> > > +
> > > +    if (!p->normal_num) {
> > > +        assert(in_size =3D=3D 0);
> > > +        return 0;
> > > +    }
> > > +
> > >      ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, er=
rp);
> > >
> > >      if (ret !=3D 0) {
> > > @@ -310,6 +325,7 @@ static int zlib_recv_pages(MultiFDRecvParams *p, =
Error **errp)
> > >                     p->id, out_size, expected_size);
> > >          return -1;
> > >      }
> > > +
> > >      return 0;
> > >  }
> > >
> > > diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> > > index dc8fe43e94..27a1eba075 100644
> > > --- a/migration/multifd-zstd.c
> > > +++ b/migration/multifd-zstd.c
> > > @@ -118,19 +118,26 @@ static int zstd_send_prepare(MultiFDSendParams =
*p, Error **errp)
> > >      int ret;
> > >      uint32_t i;
> > >
> > > +    multifd_zero_page_check_send(p);
> > > +
> > > +    if (!pages->normal_num) {
> > > +        p->next_packet_size =3D 0;
> > > +        goto out;
> > > +    }
> > > +
> > >      multifd_send_prepare_header(p);
>
> If this forms a pattern we can introduce multifd_send_prepare_common():

I will add that in the next version.

>
> bool multifd_send_prepare_common()
> {
>     multifd_zero_page_check_send();
>     if (...) {
>
>     }
>     multifd_send_prepare_header();
> }
>
> > >
> > >      z->out.dst =3D z->zbuff;
> > >      z->out.size =3D z->zbuff_len;
> > >      z->out.pos =3D 0;
> > >
> > > -    for (i =3D 0; i < pages->num; i++) {
> > > +    for (i =3D 0; i < pages->normal_num; i++) {
> > >          ZSTD_EndDirective flush =3D ZSTD_e_continue;
> > >
> > > -        if (i =3D=3D pages->num - 1) {
> > > +        if (i =3D=3D pages->normal_num - 1) {
> > >              flush =3D ZSTD_e_flush;
> > >          }
> > > -        z->in.src =3D p->pages->block->host + pages->offset[i];
> > > +        z->in.src =3D p->pages->block->host + pages->normal[i];
> > >          z->in.size =3D p->page_size;
> > >          z->in.pos =3D 0;
> > >
> > > @@ -161,10 +168,10 @@ static int zstd_send_prepare(MultiFDSendParams =
*p, Error **errp)
> > >      p->iov[p->iovs_num].iov_len =3D z->out.pos;
> > >      p->iovs_num++;
> > >      p->next_packet_size =3D z->out.pos;
> > > -    p->flags |=3D MULTIFD_FLAG_ZSTD;
> > >
> > > +out:
> > > +    p->flags |=3D MULTIFD_FLAG_ZSTD;
> > >      multifd_send_fill_packet(p);
> > > -
> > >      return 0;
> > >  }
> > >
> > > @@ -257,6 +264,14 @@ static int zstd_recv_pages(MultiFDRecvParams *p,=
 Error **errp)
> > >                     p->id, flags, MULTIFD_FLAG_ZSTD);
> > >          return -1;
> > >      }
> > > +
> > > +    multifd_zero_page_check_recv(p);
> > > +
> > > +    if (!p->normal_num) {
> > > +        assert(in_size =3D=3D 0);
> > > +        return 0;
> > > +    }
> > > +
> > >      ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, er=
rp);
> > >
> > >      if (ret !=3D 0) {
> > > diff --git a/migration/multifd.c b/migration/multifd.c
> > > index a33dba40d9..fbb40ea10b 100644
> > > --- a/migration/multifd.c
> > > +++ b/migration/multifd.c
> > > @@ -11,6 +11,7 @@
> > >   */
> > >
> > >  #include "qemu/osdep.h"
> > > +#include "qemu/cutils.h"
> > >  #include "qemu/rcu.h"
> > >  #include "exec/target_page.h"
> > >  #include "sysemu/sysemu.h"
> > > @@ -126,6 +127,8 @@ static int nocomp_send_prepare(MultiFDSendParams =
*p, Error **errp)
> > >      MultiFDPages_t *pages =3D p->pages;
> > >      int ret;
> > >
> > > +    multifd_zero_page_check_send(p);
> > > +
> > >      if (!use_zero_copy_send) {
> > >          /*
> > >           * Only !zerocopy needs the header in IOV; zerocopy will
> > > @@ -134,13 +137,13 @@ static int nocomp_send_prepare(MultiFDSendParam=
s *p, Error **errp)
> > >          multifd_send_prepare_header(p);
> > >      }
> > >
> > > -    for (int i =3D 0; i < pages->num; i++) {
> > > -        p->iov[p->iovs_num].iov_base =3D pages->block->host + pages-=
>offset[i];
> > > +    for (int i =3D 0; i < pages->normal_num; i++) {
> > > +        p->iov[p->iovs_num].iov_base =3D pages->block->host + pages-=
>normal[i];
> > >          p->iov[p->iovs_num].iov_len =3D p->page_size;
> > >          p->iovs_num++;
> > >      }
> > >
> > > -    p->next_packet_size =3D pages->num * p->page_size;
> > > +    p->next_packet_size =3D pages->normal_num * p->page_size;
> > >      p->flags |=3D MULTIFD_FLAG_NOCOMP;
> > >
> > >      multifd_send_fill_packet(p);
> > > @@ -202,6 +205,13 @@ static int nocomp_recv_pages(MultiFDRecvParams *=
p, Error **errp)
> > >                     p->id, flags, MULTIFD_FLAG_NOCOMP);
> > >          return -1;
> > >      }
> > > +
> > > +    multifd_zero_page_check_recv(p);
> > > +
> > > +    if (!p->normal_num) {
> > > +        return 0;
> > > +    }
> > > +
> > >      for (int i =3D 0; i < p->normal_num; i++) {
> > >          p->iov[i].iov_base =3D p->host + p->normal[i];
> > >          p->iov[i].iov_len =3D p->page_size;
> > > @@ -339,7 +349,7 @@ void multifd_send_fill_packet(MultiFDSendParams *=
p)
> > >
> > >      packet->flags =3D cpu_to_be32(p->flags);
> > >      packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
> > > -    packet->normal_pages =3D cpu_to_be32(pages->num);
> > > +    packet->normal_pages =3D cpu_to_be32(pages->normal_num);
> > >      packet->zero_pages =3D cpu_to_be32(pages->zero_num);
> > >      packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
> > >
> > > @@ -350,18 +360,25 @@ void multifd_send_fill_packet(MultiFDSendParams=
 *p)
> > >          strncpy(packet->ramblock, pages->block->idstr, 256);
> > >      }
> > >
> > > -    for (i =3D 0; i < pages->num; i++) {
> > > +    for (i =3D 0; i < pages->normal_num; i++) {
> > >          /* there are architectures where ram_addr_t is 32 bit */
> > > -        uint64_t temp =3D pages->offset[i];
> > > +        uint64_t temp =3D pages->normal[i];
> > >
> > >          packet->offset[i] =3D cpu_to_be64(temp);
> > >      }
> > >
> > > +    for (i =3D 0; i < pages->zero_num; i++) {
> > > +        /* there are architectures where ram_addr_t is 32 bit */
> > > +        uint64_t temp =3D pages->zero[i];
> > > +
> > > +        packet->offset[pages->normal_num + i] =3D cpu_to_be64(temp);
> > > +    }
> > > +
> > >      p->packets_sent++;
> > > -    p->total_normal_pages +=3D pages->num;
> > > +    p->total_normal_pages +=3D pages->normal_num;
> > >      p->total_zero_pages +=3D pages->zero_num;
> > >
> > > -    trace_multifd_send(p->id, packet_num, pages->num, pages->zero_nu=
m,
> > > +    trace_multifd_send(p->id, packet_num, pages->normal_num, pages->=
zero_num,
> > >                         p->flags, p->next_packet_size);
> > >  }
> > >
> > > @@ -451,6 +468,18 @@ static int multifd_recv_unfill_packet(MultiFDRec=
vParams *p, Error **errp)
> > >          p->normal[i] =3D offset;
> > >      }
> > >
> > > +    for (i =3D 0; i < p->zero_num; i++) {
> > > +        uint64_t offset =3D be64_to_cpu(packet->offset[p->normal_num=
 + i]);
> > > +
> > > +        if (offset > (p->block->used_length - p->page_size)) {
> > > +            error_setg(errp, "multifd: offset too long %" PRIu64
> > > +                       " (max " RAM_ADDR_FMT ")",
> > > +                       offset, p->block->used_length);
> > > +            return -1;
> > > +        }
> > > +        p->zero[i] =3D offset;
> > > +    }
> > > +
> > >      return 0;
> > >  }
> > >
> > > @@ -842,7 +871,7 @@ static void *multifd_send_thread(void *opaque)
> > >
> > >              stat64_add(&mig_stats.multifd_bytes,
> > >                         p->next_packet_size + p->packet_len);
> > > -            stat64_add(&mig_stats.normal_pages, pages->num);
> > > +            stat64_add(&mig_stats.normal_pages, pages->normal_num);
> > >              stat64_add(&mig_stats.zero_pages, pages->zero_num);
> > >
> > >              multifd_pages_reset(p->pages);
> > > @@ -1256,7 +1285,8 @@ static void *multifd_recv_thread(void *opaque)
> > >          p->flags &=3D ~MULTIFD_FLAG_SYNC;
> > >          qemu_mutex_unlock(&p->mutex);
> > >
> > > -        if (p->normal_num) {
> > > +        if (p->normal_num + p->zero_num) {
> > > +            assert(!(flags & MULTIFD_FLAG_SYNC));
> >
> > This breaks 8.2 -> 9.0 migration. QEMU 8.2 is still sending the SYNC
> > along with the data packet.
> >
> > >              ret =3D multifd_recv_state->ops->recv_pages(p, &local_er=
r);
> > >              if (ret !=3D 0) {
> > >                  break;
> > > diff --git a/migration/multifd.h b/migration/multifd.h
> > > index 9822ff298a..125f0bbe60 100644
> > > --- a/migration/multifd.h
> > > +++ b/migration/multifd.h
> > > @@ -53,6 +53,11 @@ typedef struct {
> > >      uint32_t unused32[1];    /* Reserved for future use */
> > >      uint64_t unused64[3];    /* Reserved for future use */
> > >      char ramblock[256];
> > > +    /*
> > > +     * This array contains the pointers to:
> > > +     *  - normal pages (initial normal_pages entries)
> > > +     *  - zero pages (following zero_pages entries)
> > > +     */
> > >      uint64_t offset[];
> > >  } __attribute__((packed)) MultiFDPacket_t;
> > >
> > > @@ -224,6 +229,8 @@ typedef struct {
> > >
> > >  void multifd_register_ops(int method, MultiFDMethods *ops);
> > >  void multifd_send_fill_packet(MultiFDSendParams *p);
> > > +void multifd_zero_page_check_send(MultiFDSendParams *p);
> > > +void multifd_zero_page_check_recv(MultiFDRecvParams *p);
> > >
> > >  static inline void multifd_send_prepare_header(MultiFDSendParams *p)
> > >  {
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 99843a8e95..e2450b92d4 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -660,9 +660,11 @@
> > >  #
> > >  # @none: Do not perform zero page checking.
> > >  #
> > > +# @multifd: Perform zero page checking on the multifd sender thread.=
 (since 9.0)
> > > +#
> > >  ##
> > >  { 'enum': 'ZeroPageDetection',
> > > -  'data': [ 'legacy', 'none' ] }
> > > +  'data': [ 'legacy', 'none', 'multifd' ] }
> > >
> > >  ##
> > >  # @BitmapMigrationBitmapAliasTransform:
> >
>
> --
> Peter Xu
>

