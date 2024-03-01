Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACB4C48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 01:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfs7U-00011o-5C; Thu, 29 Feb 2024 20:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfs7Q-00011G-8c
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:55:24 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfs7K-0007Lc-IM
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:55:23 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56533e30887so2794818a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 17:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709258115; x=1709862915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOj0UyudyQcLye1Gew7V2OGyd5/S2g0HuFWAyD0JezA=;
 b=OW5ym6QA1Qwk8MkeKyMnEI7rqhUpSx9EKCVUh9IwK7f/5K0nbzsQQ47VESFCq6qdcX
 sGtUUGpsHvQm1Xuxp/CbVp9LrsrFxSgksfI9MCdrjgIS8WoJc8zpmbyEm7vHqRxxrWCH
 0qdUfG8m/5G6WhELsTfKtGmHN0ugaVUB0+y/IiLIOAKvmKwYuaRCj0Ct760KJ+d6EJTV
 NfHPctO1NYaAZXcUjymAYQUMmPRXYFsZSoABkORXhWCQ5luQvoq2lshqyHLYHMz6PtA8
 6PL7eZH/8V/kOKfxmEh4pG2X1XtiQy/7dJHflbyVbq2sm8DQNZHnHoZK3ThRR2O5dxfD
 tbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709258115; x=1709862915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOj0UyudyQcLye1Gew7V2OGyd5/S2g0HuFWAyD0JezA=;
 b=gdrI0de/eMhkT1e8GU17pWFwHBmJY30wagPZOmkHxI7dJw6qr+gquZEOB+3Les8AXA
 PygC0VeG8VKKwN3+m9lcEF9GjV9HnHlyVAHrd12Wsl+j+HxtPBO0TOrf201ptlVg3Uvk
 bfpdN11kNDSxoix5Ty0bu7ypYSEDQHcmpfebHs5ebtxcbAeY4OnhXJ/tJQzA+c32vqy1
 3pjpzJsltRL8l71maBlMOLXEvO+OkGbi/N1R0Hnlx7gwgDq4E66VEZNxFburXkF0Y119
 Yc+Pc1LiFobDfSe8zVtmvSURPJRTWwo+AJCJeLUL4rXLRqohiqbDErMo6XyWuxj/a8fJ
 sbaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs2IwN8792ufdTVpnHfDFne1cEWMnVkQrd4C9/y8V7wlVSvfE59r14G4wxHWoqgHBvbxojKLJSQBDTMtW3BhVDErHl8yQ=
X-Gm-Message-State: AOJu0Yy7tXs/d9wbs6c4AZIceoluAzu5TiW1/qlc+acsGi1lXsQh5AkE
 2bXU2y6c4nZOl1JwQBH5CpJ9u8P3bhiaaab2VtAJUBuL2Hu60sQoK7OGd4vV6yGj+GqGzlPI51+
 Bo/Iau1CWyfGSXrCbLYt7vbIF1miUglddVMx6cg==
X-Google-Smtp-Source: AGHT+IFMYJgBu4q09jqXUBYNU20Z5f/AWBihLUZie0RVQLSI5v5oq+pO0LDnuT7DMNRR8BQLWdhyrpsUUFDGALLCZkU=
X-Received: by 2002:a05:6402:c1b:b0:566:6899:d5b with SMTP id
 co27-20020a0564020c1b00b0056668990d5bmr190956edb.41.1709258115035; Thu, 29
 Feb 2024 17:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-3-hao.xiang@bytedance.com> <878r34qsmu.fsf@suse.de>
In-Reply-To: <878r34qsmu.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 29 Feb 2024 17:55:03 -0800
Message-ID: <CAAYibXhHnD1TYc7cx0c-_fwzuXrQKL1-AXC7VWEXdr2cqYJUHQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/7] migration/multifd: Implement zero
 page transmission on the multifd thread.
To: Fabiano Rosas <farosas@suse.de>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, 
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x533.google.com
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

On Wed, Feb 28, 2024 at 11:46=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wr=
ote:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > 1. Add zero_pages field in MultiFDPacket_t.
> > 2. Implements the zero page detection and handling on the multifd
> > threads for non-compression, zlib and zstd compression backends.
> > 3. Added a new value 'multifd' in ZeroPageDetection enumeration.
> > 4. Handle migration QEMU9.0 -> QEMU8.2 compatibility.
> > 5. Adds zero page counters and updates multifd send/receive tracing
> > format to track the newly added counters.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  hw/core/machine.c                |  4 +-
> >  hw/core/qdev-properties-system.c |  2 +-
> >  migration/meson.build            |  1 +
> >  migration/multifd-zero-page.c    | 78 ++++++++++++++++++++++++++++++
> >  migration/multifd-zlib.c         | 21 ++++++--
> >  migration/multifd-zstd.c         | 20 ++++++--
> >  migration/multifd.c              | 83 +++++++++++++++++++++++++++-----
> >  migration/multifd.h              | 24 ++++++++-
> >  migration/ram.c                  |  1 -
> >  migration/trace-events           |  8 +--
> >  qapi/migration.json              |  5 +-
> >  11 files changed, 214 insertions(+), 33 deletions(-)
> >  create mode 100644 migration/multifd-zero-page.c
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index fb5afdcae4..746da219a4 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -32,7 +32,9 @@
> >  #include "hw/virtio/virtio-net.h"
> >  #include "audio/audio.h"
> >
> > -GlobalProperty hw_compat_8_2[] =3D {};
> > +GlobalProperty hw_compat_8_2[] =3D {
> > +    { "migration", "zero-page-detection", "legacy"},
> > +};
> >  const size_t hw_compat_8_2_len =3D G_N_ELEMENTS(hw_compat_8_2);
> >
> >  GlobalProperty hw_compat_8_1[] =3D {
> > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties=
-system.c
> > index 228e685f52..6e6f68ae1b 100644
> > --- a/hw/core/qdev-properties-system.c
> > +++ b/hw/core/qdev-properties-system.c
> > @@ -682,7 +682,7 @@ const PropertyInfo qdev_prop_mig_mode =3D {
> >  const PropertyInfo qdev_prop_zero_page_detection =3D {
> >      .name =3D "ZeroPageDetection",
> >      .description =3D "zero_page_detection values, "
> > -                   "none,legacy",
> > +                   "none,legacy,multifd",
> >      .enum_table =3D &ZeroPageDetection_lookup,
> >      .get =3D qdev_propinfo_get_enum,
> >      .set =3D qdev_propinfo_set_enum,
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
> > index 0000000000..1650c41b26
> > --- /dev/null
> > +++ b/migration/multifd-zero-page.c
> > @@ -0,0 +1,78 @@
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
> > +static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
> > +{
> > +    ram_addr_t temp;
> > +
> > +    if (a =3D=3D b) {
> > +        return;
> > +    }
> > +
> > +    temp =3D pages_offset[a];
> > +    pages_offset[a] =3D pages_offset[b];
> > +    pages_offset[b] =3D temp;
> > +}
> > +
> > +/**
> > + * multifd_zero_page_check_send: Perform zero page detection on all pa=
ges.
> > + *
> > + * Sort the page offset array by moving all normal pages to
> > + * the left and all zero pages to the right of the array.
>
> Let's move this to the loop as a comment. Here it's better to just
> inform about the side effects:
>
> Sorts normal pages before zero pages in p->pages->offset and updates
> p->pages->normal_num.
>
> > + *
> > + * @param p A pointer to the send params.
> > + */
> > +void multifd_zero_page_check_send(MultiFDSendParams *p)
>
> Use multifd_send_zero_page_check for consistency with the rest of the cod=
e.
>
> > +{
> > +    /*
> > +     * QEMU older than 9.0 don't understand zero page
> > +     * on multifd channel. This switch is required to
> > +     * maintain backward compatibility.
> > +     */
> > +    bool use_multifd_zero_page =3D
> > +        (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_MULT=
IFD);
>
> Could introduce a helper for this.
>
> static bool multifd_zero_page(void)
> {
>     return migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_MULTI=
FD;
> }
>
> > +    MultiFDPages_t *pages =3D p->pages;
> > +    RAMBlock *rb =3D pages->block;
> > +    int index_normal =3D 0;
> > +    int index_zero =3D pages->num - 1;
>
> IMHO, i and j are more idiomatic, makes the code easier on the eyes.
>
> > +
> > +    while (index_normal <=3D index_zero) {
> > +        uint64_t offset =3D pages->offset[index_normal];
> > +        if (use_multifd_zero_page &&
>
> You don't need to check this at every iteration. Could check at the top
> and exit right away.
>
> > +            buffer_is_zero(rb->host + offset, p->page_size)) {
> > +            swap_page_offset(pages->offset, index_normal, index_zero);
> > +            index_zero--;
> > +            ram_release_page(rb->idstr, offset);
> > +        } else {
> > +            index_normal++;
> > +            pages->normal_num++;
>
> Not a fan of changing pages->normal_num like this. Let's make the loop
> just sort and update normal_num at the end.
>
> Putting all together:
>
> void multifd_send_zero_page_check(MultiFDSendParams *p)
> {
>     MultiFDPages_t *pages =3D p->pages;
>     RAMBlock *rb =3D pages->block;
>     int i =3D 0;
>     int j =3D pages->num - 1;
>
>     if (!multifd_zero_page()) {
>         pages->normal_num =3D pages->num;
>         return;
>     }
>
>     /*
>      * Sort the offsets array by moving all normal pages to the start
>      * and all zero pages to the end of the array.
>      */
>     while (i <=3D j) {
>         uint64_t offset =3D pages->offset[i];
>
>         if (!buffer_is_zero(rb->host + offset, p->page_size)) {
>             i++;
>             continue;
>         }
>
>         swap_page_offset(pages->offset, i, j);
>         ram_release_page(rb->idstr, offset);
>         j--;
>     }
>
>     pages->normal_num =3D i;
> }
>

Sure. Will fix these in the next version.

> > +        }
> > +    }
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

