Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915CEC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 05:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdNxd-0003QU-N5; Fri, 23 Feb 2024 00:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdNxb-0003QG-Hn
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:18:59 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdNxY-0003PG-UN
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:18:59 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-564372fb762so469075a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 21:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708665535; x=1709270335; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/OYAyDrUDmSkiKyUEpO0ofR/3J0rahnv3h97tH4VtXk=;
 b=Qhrr4c7j6PSl/GId3vp8gurXq3bfJaiZx0KEtpweufU3RCkI/tagdOdcPsmY5GIhFT
 UNfO0uxFnSoO5QPoCCicLVluV9AqkjSUG6oYuePp3ImZRXVXy1uyH+0P16gyRvDfKqeL
 YjHiRQoDGKA9bu4IEcJy3TJKwIIaI6pVrG30xECkWGQpWTBkpkMk5uwlrM+a6LxE2zm3
 exYcdbfgtu31xuJ0QmG8ft7PDoaeLQ4bfFov24mNmt4Cg81Pydaig57Juw2BDezhyGfi
 w7ZmFm4NaFctLE8O2nLSlkSTNqHZpORPZEdXyx9E9wsJp3xYSd34a3FBPwJnPuheWm3K
 4uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708665535; x=1709270335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/OYAyDrUDmSkiKyUEpO0ofR/3J0rahnv3h97tH4VtXk=;
 b=NVwwZrCPeZZe+i5fn6ATEQIMB14Rh3Hr1y44akZ18xgnbZzoRGY4fGz/6WqugA410c
 cHrLS05wEj6iDT9q497VGtYflwiWj0Y6uAu4JVv5M/rjYZe+jVPke5XjIzIOIMNH8WCt
 vIIoWH5kRMYxg3FwEQXemt28K0yG5Q4dqoEjkqKTdr8JKJWYLh9dFFW5KWkJhp1C4nPp
 iNIcus8Hcg0dp8M741W41OoNf399Fh5OCLKLz1kMwUZZDg2wbAHjfbGhSSHI87kv0ebY
 2eao/LZbzsshpggZxVQO1OYx3zKXHbvxY3QrgJ97lxWsBeb4/lpj10cenieDlzIThaim
 2mbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHAPNVIoa8FmkUUxcNdkgqn6ueuTLeUnmPgF4HEsvfSVFZFPB08TkojR0C8/3E8OkN+7pY9+yhlMnP5+ikBWR52j4JJ6g=
X-Gm-Message-State: AOJu0YzBq0+lfmzIf98LfF2QtjXi8iNKCUzTnFoyu27SAzkl9onzPTvg
 /471B/xmoEPcUFaHlnq8mvA+O9GTMN/F39OoSID0y6kifHnmT9hqkktfFltofcYQEhxUdUXiEhl
 fqaCbQN/TMafdJBUpemGOqPoytjsUNp6gahBW1w==
X-Google-Smtp-Source: AGHT+IEGruuuFGGItpfX4kCktUQTmBX369q/ZHjm6iIKRj6qbTh7OL5SKFMWqys0zGmv9hksSUZxGYQR//FaCUBQ0DE=
X-Received: by 2002:a17:906:154e:b0:a3f:870:535c with SMTP id
 c14-20020a170906154e00b00a3f0870535cmr462308ejd.44.1708665534967; Thu, 22 Feb
 2024 21:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-4-hao.xiang@bytedance.com> <877cixbkc5.fsf@suse.de>
In-Reply-To: <877cixbkc5.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 22 Feb 2024 21:18:43 -0800
Message-ID: <CAAYibXjcLii6qTrHC7bFZ03SvDLT+XizOpiF_cxASYDvULJfUA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/7] migration/multifd: Zero page
 transmission on the multifd thread.
To: Fabiano Rosas <farosas@suse.de>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, 
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x534.google.com
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

On Wed, Feb 21, 2024 at 1:04=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > 1. Implements the zero page detection and handling on the multifd
> > threads for non-compression, zlib and zstd compression backends.
> > 2. Added a new value 'multifd' in ZeroPageDetection enumeration.
> > 3. Add proper asserts to ensure pages->normal are used for normal pages
> > in all scenarios.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  migration/meson.build         |  1 +
> >  migration/multifd-zero-page.c | 59 +++++++++++++++++++++++++++++++++++
> >  migration/multifd-zlib.c      | 26 ++++++++++++---
> >  migration/multifd-zstd.c      | 25 ++++++++++++---
> >  migration/multifd.c           | 50 +++++++++++++++++++++++------
> >  migration/multifd.h           |  7 +++++
> >  qapi/migration.json           |  4 ++-
> >  7 files changed, 151 insertions(+), 21 deletions(-)
> >  create mode 100644 migration/multifd-zero-page.c
> >
> > diff --git a/migration/meson.build b/migration/meson.build
> > index 92b1cc4297..1eeb915ff6 100644
> > --- a/migration/meson.build
> > +++ b/migration/meson.build
> > @@ -22,6 +22,7 @@ system_ss.add(files(
> >    'migration.c',
> >    'multifd.c',
> >    'multifd-zlib.c',
> > +  'multifd-zero-page.c',
> >    'ram-compress.c',
> >    'options.c',
> >    'postcopy-ram.c',
> > diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-pag=
e.c
> > new file mode 100644
> > index 0000000000..f0cd8e2c53
> > --- /dev/null
> > +++ b/migration/multifd-zero-page.c
> > @@ -0,0 +1,59 @@
> > +/*
> > + * Multifd zero page detection implementation.
> > + *
> > + * Copyright (c) 2024 Bytedance Inc
> > + *
> > + * Authors:
> > + *  Hao Xiang <hao.xiang@bytedance.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/cutils.h"
> > +#include "exec/ramblock.h"
> > +#include "migration.h"
> > +#include "multifd.h"
> > +#include "options.h"
> > +#include "ram.h"
> > +
> > +void multifd_zero_page_check_send(MultiFDSendParams *p)
> > +{
> > +    /*
> > +     * QEMU older than 9.0 don't understand zero page
> > +     * on multifd channel. This switch is required to
> > +     * maintain backward compatibility.
> > +     */
> > +    bool use_multifd_zero_page =3D
> > +        (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_MULT=
IFD);
> > +    MultiFDPages_t *pages =3D p->pages;
> > +    RAMBlock *rb =3D pages->block;
> > +
> > +    assert(pages->num !=3D 0);
> > +    assert(pages->normal_num =3D=3D 0);
> > +    assert(pages->zero_num =3D=3D 0);
>
> We can drop these before the final version.

Elena has the same concern. I will drop these.

>
> > +
> > +    for (int i =3D 0; i < pages->num; i++) {
> > +        uint64_t offset =3D pages->offset[i];
> > +        if (use_multifd_zero_page &&
> > +            buffer_is_zero(rb->host + offset, p->page_size)) {
> > +            pages->zero[pages->zero_num] =3D offset;
> > +            pages->zero_num++;
> > +            ram_release_page(rb->idstr, offset);
> > +        } else {
> > +            pages->normal[pages->normal_num] =3D offset;
> > +            pages->normal_num++;
> > +        }
> > +    }
>
> I don't think it's super clean to have three arrays offset, zero and
> normal, all sized for the full packet size. It might be possible to just
> carry a bitmap of non-zero pages along with pages->offset and operate on
> that instead.
>
> What do you think?
>
> Peter, any ideas? Should we just leave this for another time?
>
> > +}
> > +
> > +void multifd_zero_page_check_recv(MultiFDRecvParams *p)
> > +{
> > +    for (int i =3D 0; i < p->zero_num; i++) {
> > +        void *page =3D p->host + p->zero[i];
> > +        if (!buffer_is_zero(page, p->page_size)) {
> > +            memset(page, 0, p->page_size);
> > +        }
> > +    }
> > +}
> > diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> > index 012e3bdea1..cdfe0fa70e 100644
> > --- a/migration/multifd-zlib.c
> > +++ b/migration/multifd-zlib.c
> > @@ -123,13 +123,20 @@ static int zlib_send_prepare(MultiFDSendParams *p=
, Error **errp)
> >      int ret;
> >      uint32_t i;
> >
> > +    multifd_zero_page_check_send(p);
> > +
> > +    if (!pages->normal_num) {
> > +        p->next_packet_size =3D 0;
> > +        goto out;
> > +    }
> > +
> >      multifd_send_prepare_header(p);
> >
> > -    for (i =3D 0; i < pages->num; i++) {
> > +    for (i =3D 0; i < pages->normal_num; i++) {
> >          uint32_t available =3D z->zbuff_len - out_size;
> >          int flush =3D Z_NO_FLUSH;
> >
> > -        if (i =3D=3D pages->num - 1) {
> > +        if (i =3D=3D pages->normal_num - 1) {
> >              flush =3D Z_SYNC_FLUSH;
> >          }
> >
> > @@ -138,7 +145,7 @@ static int zlib_send_prepare(MultiFDSendParams *p, =
Error **errp)
> >           * with compression. zlib does not guarantee that this is safe=
,
> >           * therefore copy the page before calling deflate().
> >           */
> > -        memcpy(z->buf, p->pages->block->host + pages->offset[i], p->pa=
ge_size);
> > +        memcpy(z->buf, p->pages->block->host + pages->normal[i], p->pa=
ge_size);
> >          zs->avail_in =3D p->page_size;
> >          zs->next_in =3D z->buf;
> >
> > @@ -172,10 +179,10 @@ static int zlib_send_prepare(MultiFDSendParams *p=
, Error **errp)
> >      p->iov[p->iovs_num].iov_len =3D out_size;
> >      p->iovs_num++;
> >      p->next_packet_size =3D out_size;
> > -    p->flags |=3D MULTIFD_FLAG_ZLIB;
> >
> > +out:
> > +    p->flags |=3D MULTIFD_FLAG_ZLIB;
> >      multifd_send_fill_packet(p);
> > -
> >      return 0;
> >  }
> >
> > @@ -261,6 +268,14 @@ static int zlib_recv_pages(MultiFDRecvParams *p, E=
rror **errp)
> >                     p->id, flags, MULTIFD_FLAG_ZLIB);
> >          return -1;
> >      }
> > +
> > +    multifd_zero_page_check_recv(p);
> > +
> > +    if (!p->normal_num) {
> > +        assert(in_size =3D=3D 0);
> > +        return 0;
> > +    }
> > +
> >      ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp=
);
> >
> >      if (ret !=3D 0) {
> > @@ -310,6 +325,7 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Er=
ror **errp)
> >                     p->id, out_size, expected_size);
> >          return -1;
> >      }
> > +
> >      return 0;
> >  }
> >
> > diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> > index dc8fe43e94..27a1eba075 100644
> > --- a/migration/multifd-zstd.c
> > +++ b/migration/multifd-zstd.c
> > @@ -118,19 +118,26 @@ static int zstd_send_prepare(MultiFDSendParams *p=
, Error **errp)
> >      int ret;
> >      uint32_t i;
> >
> > +    multifd_zero_page_check_send(p);
> > +
> > +    if (!pages->normal_num) {
> > +        p->next_packet_size =3D 0;
> > +        goto out;
> > +    }
> > +
> >      multifd_send_prepare_header(p);
> >
> >      z->out.dst =3D z->zbuff;
> >      z->out.size =3D z->zbuff_len;
> >      z->out.pos =3D 0;
> >
> > -    for (i =3D 0; i < pages->num; i++) {
> > +    for (i =3D 0; i < pages->normal_num; i++) {
> >          ZSTD_EndDirective flush =3D ZSTD_e_continue;
> >
> > -        if (i =3D=3D pages->num - 1) {
> > +        if (i =3D=3D pages->normal_num - 1) {
> >              flush =3D ZSTD_e_flush;
> >          }
> > -        z->in.src =3D p->pages->block->host + pages->offset[i];
> > +        z->in.src =3D p->pages->block->host + pages->normal[i];
> >          z->in.size =3D p->page_size;
> >          z->in.pos =3D 0;
> >
> > @@ -161,10 +168,10 @@ static int zstd_send_prepare(MultiFDSendParams *p=
, Error **errp)
> >      p->iov[p->iovs_num].iov_len =3D z->out.pos;
> >      p->iovs_num++;
> >      p->next_packet_size =3D z->out.pos;
> > -    p->flags |=3D MULTIFD_FLAG_ZSTD;
> >
> > +out:
> > +    p->flags |=3D MULTIFD_FLAG_ZSTD;
> >      multifd_send_fill_packet(p);
> > -
> >      return 0;
> >  }
> >
> > @@ -257,6 +264,14 @@ static int zstd_recv_pages(MultiFDRecvParams *p, E=
rror **errp)
> >                     p->id, flags, MULTIFD_FLAG_ZSTD);
> >          return -1;
> >      }
> > +
> > +    multifd_zero_page_check_recv(p);
> > +
> > +    if (!p->normal_num) {
> > +        assert(in_size =3D=3D 0);
> > +        return 0;
> > +    }
> > +
> >      ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp=
);
> >
> >      if (ret !=3D 0) {
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index a33dba40d9..fbb40ea10b 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +#include "qemu/cutils.h"
> >  #include "qemu/rcu.h"
> >  #include "exec/target_page.h"
> >  #include "sysemu/sysemu.h"
> > @@ -126,6 +127,8 @@ static int nocomp_send_prepare(MultiFDSendParams *p=
, Error **errp)
> >      MultiFDPages_t *pages =3D p->pages;
> >      int ret;
> >
> > +    multifd_zero_page_check_send(p);
> > +
> >      if (!use_zero_copy_send) {
> >          /*
> >           * Only !zerocopy needs the header in IOV; zerocopy will
> > @@ -134,13 +137,13 @@ static int nocomp_send_prepare(MultiFDSendParams =
*p, Error **errp)
> >          multifd_send_prepare_header(p);
> >      }
> >
> > -    for (int i =3D 0; i < pages->num; i++) {
> > -        p->iov[p->iovs_num].iov_base =3D pages->block->host + pages->o=
ffset[i];
> > +    for (int i =3D 0; i < pages->normal_num; i++) {
> > +        p->iov[p->iovs_num].iov_base =3D pages->block->host + pages->n=
ormal[i];
> >          p->iov[p->iovs_num].iov_len =3D p->page_size;
> >          p->iovs_num++;
> >      }
> >
> > -    p->next_packet_size =3D pages->num * p->page_size;
> > +    p->next_packet_size =3D pages->normal_num * p->page_size;
> >      p->flags |=3D MULTIFD_FLAG_NOCOMP;
> >
> >      multifd_send_fill_packet(p);
> > @@ -202,6 +205,13 @@ static int nocomp_recv_pages(MultiFDRecvParams *p,=
 Error **errp)
> >                     p->id, flags, MULTIFD_FLAG_NOCOMP);
> >          return -1;
> >      }
> > +
> > +    multifd_zero_page_check_recv(p);
> > +
> > +    if (!p->normal_num) {
> > +        return 0;
> > +    }
> > +
> >      for (int i =3D 0; i < p->normal_num; i++) {
> >          p->iov[i].iov_base =3D p->host + p->normal[i];
> >          p->iov[i].iov_len =3D p->page_size;
> > @@ -339,7 +349,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
> >
> >      packet->flags =3D cpu_to_be32(p->flags);
> >      packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
> > -    packet->normal_pages =3D cpu_to_be32(pages->num);
> > +    packet->normal_pages =3D cpu_to_be32(pages->normal_num);
> >      packet->zero_pages =3D cpu_to_be32(pages->zero_num);
> >      packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
> >
> > @@ -350,18 +360,25 @@ void multifd_send_fill_packet(MultiFDSendParams *=
p)
> >          strncpy(packet->ramblock, pages->block->idstr, 256);
> >      }
> >
> > -    for (i =3D 0; i < pages->num; i++) {
> > +    for (i =3D 0; i < pages->normal_num; i++) {
> >          /* there are architectures where ram_addr_t is 32 bit */
> > -        uint64_t temp =3D pages->offset[i];
> > +        uint64_t temp =3D pages->normal[i];
> >
> >          packet->offset[i] =3D cpu_to_be64(temp);
> >      }
> >
> > +    for (i =3D 0; i < pages->zero_num; i++) {
> > +        /* there are architectures where ram_addr_t is 32 bit */
> > +        uint64_t temp =3D pages->zero[i];
> > +
> > +        packet->offset[pages->normal_num + i] =3D cpu_to_be64(temp);
> > +    }
> > +
> >      p->packets_sent++;
> > -    p->total_normal_pages +=3D pages->num;
> > +    p->total_normal_pages +=3D pages->normal_num;
> >      p->total_zero_pages +=3D pages->zero_num;
> >
> > -    trace_multifd_send(p->id, packet_num, pages->num, pages->zero_num,
> > +    trace_multifd_send(p->id, packet_num, pages->normal_num, pages->ze=
ro_num,
> >                         p->flags, p->next_packet_size);
> >  }
> >
> > @@ -451,6 +468,18 @@ static int multifd_recv_unfill_packet(MultiFDRecvP=
arams *p, Error **errp)
> >          p->normal[i] =3D offset;
> >      }
> >
> > +    for (i =3D 0; i < p->zero_num; i++) {
> > +        uint64_t offset =3D be64_to_cpu(packet->offset[p->normal_num +=
 i]);
> > +
> > +        if (offset > (p->block->used_length - p->page_size)) {
> > +            error_setg(errp, "multifd: offset too long %" PRIu64
> > +                       " (max " RAM_ADDR_FMT ")",
> > +                       offset, p->block->used_length);
> > +            return -1;
> > +        }
> > +        p->zero[i] =3D offset;
> > +    }
> > +
> >      return 0;
> >  }
> >
> > @@ -842,7 +871,7 @@ static void *multifd_send_thread(void *opaque)
> >
> >              stat64_add(&mig_stats.multifd_bytes,
> >                         p->next_packet_size + p->packet_len);
> > -            stat64_add(&mig_stats.normal_pages, pages->num);
> > +            stat64_add(&mig_stats.normal_pages, pages->normal_num);
> >              stat64_add(&mig_stats.zero_pages, pages->zero_num);
> >
> >              multifd_pages_reset(p->pages);
> > @@ -1256,7 +1285,8 @@ static void *multifd_recv_thread(void *opaque)
> >          p->flags &=3D ~MULTIFD_FLAG_SYNC;
> >          qemu_mutex_unlock(&p->mutex);
> >
> > -        if (p->normal_num) {
> > +        if (p->normal_num + p->zero_num) {
> > +            assert(!(flags & MULTIFD_FLAG_SYNC));
>
> This breaks 8.2 -> 9.0 migration. QEMU 8.2 is still sending the SYNC
> along with the data packet.

I keep missing the compatibility thing. Will remove this.

>
> >              ret =3D multifd_recv_state->ops->recv_pages(p, &local_err)=
;
> >              if (ret !=3D 0) {
> >                  break;
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 9822ff298a..125f0bbe60 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -53,6 +53,11 @@ typedef struct {
> >      uint32_t unused32[1];    /* Reserved for future use */
> >      uint64_t unused64[3];    /* Reserved for future use */
> >      char ramblock[256];
> > +    /*
> > +     * This array contains the pointers to:
> > +     *  - normal pages (initial normal_pages entries)
> > +     *  - zero pages (following zero_pages entries)
> > +     */
> >      uint64_t offset[];
> >  } __attribute__((packed)) MultiFDPacket_t;
> >
> > @@ -224,6 +229,8 @@ typedef struct {
> >
> >  void multifd_register_ops(int method, MultiFDMethods *ops);
> >  void multifd_send_fill_packet(MultiFDSendParams *p);
> > +void multifd_zero_page_check_send(MultiFDSendParams *p);
> > +void multifd_zero_page_check_recv(MultiFDRecvParams *p);
> >
> >  static inline void multifd_send_prepare_header(MultiFDSendParams *p)
> >  {
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 99843a8e95..e2450b92d4 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -660,9 +660,11 @@
> >  #
> >  # @none: Do not perform zero page checking.
> >  #
> > +# @multifd: Perform zero page checking on the multifd sender thread. (=
since 9.0)
> > +#
> >  ##
> >  { 'enum': 'ZeroPageDetection',
> > -  'data': [ 'legacy', 'none' ] }
> > +  'data': [ 'legacy', 'none', 'multifd' ] }
> >
> >  ##
> >  # @BitmapMigrationBitmapAliasTransform:

