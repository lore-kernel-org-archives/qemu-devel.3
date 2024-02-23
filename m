Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE354C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 05:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdOQF-0007te-Mn; Fri, 23 Feb 2024 00:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdOQ9-0007mU-VC
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:48:30 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdOPt-0002Jk-Gx
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:48:29 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a3fd9063261so5712066b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 21:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708667289; x=1709272089; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVsvgr0JVy7O+a3QPqJVwM9VO52g0bU1pBr5XvfraGg=;
 b=Hz37YDJWlXke4E+JBBge/GZXk2FTwIFbxYd4XsAJfvVcK/Eh3gyjdRS83QoZVohfJe
 qYaV1VwxiSlsMl0EFaC7N/+EP2rdb2DAWMy25Pc9kTFR4krGhvaSO+fg4xCOGKFdjlQM
 yowXcHpmOJayPchWIeQt3RHZ6O7RdBOCTqcDJFsf13azBMzEe8IG1GmVV/aJ+8CKGO2n
 8eoTECPKeiIf5GcYqsfSCkSQSPUkspOOdGzKk4kttVbTQpuTtem/LNsDeNWEb9SR/CBV
 MEzFl7n9fC+7hwbxYbDZ6lnuxX/pTeChwnS1Wc9AuiEDbElNaJo+Gl8hUGYx1KhDZiol
 1hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708667289; x=1709272089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yVsvgr0JVy7O+a3QPqJVwM9VO52g0bU1pBr5XvfraGg=;
 b=craK277eYhx8v7OLizIals4Ek8ImPG1NUs44LcSN+rnjgamYyOqxn+NAL8iG1ypwk8
 6KMQ5v/DD05pCeSMdIcBKPVHihjPM2GxuFs5hVhMiQ+0QuylY4eP+VnS7Q+yqPVP7CNO
 SS45TBv4z9KRIzq6a2nsLU3EFgD+miDjdH1lhRqufQft6+JjfcOqwBlZZWnWAoh9KsFz
 hLEKHE7cepkhsXF1KyTXrTl1KqW04+KL29Lwedbeft2XP7HBlMP9SY+AyOV9wUkTtN6v
 HwyBuiqf0hG69PZHewAnpIQb+bxIQL0odcGbAnThU/r/tDffQLSHAon4QmbAI1YpuJ5d
 0biQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrEqWpheA7tdj7DHkQmBdX4ZxVS9Nm8v/uysD6sdYoHljfekmschEXupM/xC5uZOufB0YJlSWpKULQeEbqvg92BVQMLYw=
X-Gm-Message-State: AOJu0YwktwZJrPgUv/DgbfI1kVtVm2ULhWTFY7vqMijvcFw8BSdxCUdi
 QBBzCAXlIgHO1Vpd/BdW5OLReAMKd0Mk0UwWncyDqDFAAQHCXE//5l1i69ONjiJwM9uIzjO2M/v
 bydrWXHwbagjsBNP9VyzIQ7JZCIFm+fHO8be/mQ==
X-Google-Smtp-Source: AGHT+IEWNb7UPFGpH+Lb4J15UhHj9GLkuHG4nI8Dpoufje0Skbs0lpbNj+7TztZ7D3UtlRO/SK9itXQMirkdUWDN45I=
X-Received: by 2002:a17:906:f80f:b0:a3f:45b7:3af0 with SMTP id
 kh15-20020a170906f80f00b00a3f45b73af0mr471187ejb.71.1708667289401; Thu, 22
 Feb 2024 21:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-5-hao.xiang@bytedance.com> <875xyhbk8k.fsf@suse.de>
In-Reply-To: <875xyhbk8k.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 22 Feb 2024 21:47:58 -0800
Message-ID: <CAAYibXhGx=m8wbGMbpfy4vMQAQURaemLFOvCDEAMeGUiLXDfdg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 4/7] migration/multifd: Enable zero page
 checking from multifd threads.
To: Fabiano Rosas <farosas@suse.de>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, 
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x634.google.com
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

On Wed, Feb 21, 2024 at 1:06=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > This change adds a dedicated handler for MigrationOps::ram_save_target_=
page in
>
> nit: Add a dedicated handler...
>
> Usually "this patch/change" is used only when necessary to avoid
> ambiguity.

Will do.

>
> > multifd live migration. Now zero page checking can be done in the multi=
fd threads
> > and this becomes the default configuration. We still provide backward c=
ompatibility
> > where zero page checking is done from the migration main thread.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  migration/multifd.c |  1 +
> >  migration/options.c |  2 +-
> >  migration/ram.c     | 53 ++++++++++++++++++++++++++++++++++-----------
> >  3 files changed, 42 insertions(+), 14 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index fbb40ea10b..ef5dad1019 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -13,6 +13,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/cutils.h"
>
> This include...
>
> >  #include "qemu/rcu.h"
> > +#include "qemu/cutils.h"
>
> is there already.
>
> >  #include "exec/target_page.h"
> >  #include "sysemu/sysemu.h"
> >  #include "exec/ramblock.h"
> > diff --git a/migration/options.c b/migration/options.c
> > index 3c603391b0..3c79b6ccd4 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -181,7 +181,7 @@ Property migration_properties[] =3D {
> >                        MIG_MODE_NORMAL),
> >      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationSt=
ate,
> >                         parameters.zero_page_detection,
> > -                       ZERO_PAGE_DETECTION_LEGACY),
> > +                       ZERO_PAGE_DETECTION_MULTIFD),
>
> I think we'll need something to avoid a 9.0 -> 8.2 migration with this
> enabled. Otherwise it will go along happily until we get data corruption
> because the new QEMU didn't send any zero pages on the migration thread
> and the old QEMU did not look for them in the multifd packet.
>
> Perhaps bumping the MULTIFD_VERSION when ZERO_PAGE_DETECTION_MULTIFD is
> in use. We'd just need to fix the test in the new QEMU to check
> (msg.version > MULTIFD_VERSION) instead of (msg.version !=3D MULTIFD_VERS=
ION).
>
> >
> >      /* Migration capabilities */
> >      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 5ece9f042e..b088c5a98c 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1123,10 +1123,6 @@ static int save_zero_page(RAMState *rs, PageSear=
chStatus *pss,
> >      QEMUFile *file =3D pss->pss_channel;
> >      int len =3D 0;
> >
> > -    if (migrate_zero_page_detection() !=3D ZERO_PAGE_DETECTION_LEGACY)=
 {
> > -        return 0;
> > -    }
>
> How does 'none' work now?

I tested it and all pages are transferred with payload (including the
zero pages).

>
> > -
> >      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> >          return 0;
> >      }
> > @@ -1256,6 +1252,10 @@ static int ram_save_page(RAMState *rs, PageSearc=
hStatus *pss)
> >
> >  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
> >  {
> > +    assert(migrate_multifd());
> > +    assert(!migrate_compress());
> > +    assert(!migration_in_postcopy());
>
> Drop these, please. Keep only the asserts that are likely to trigger
> during development, such as the existing ones at multifd_send_pages.

I think I have got enough feedback regarding too many asserts. I will
drop these. assert is not compiled into the free build, correct?

>
> > +
> >      if (!multifd_queue_page(block, offset)) {
> >          return -1;
> >      }
> > @@ -2046,7 +2046,6 @@ static bool save_compress_page(RAMState *rs, Page=
SearchStatus *pss,
> >   */
> >  static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus =
*pss)
> >  {
> > -    RAMBlock *block =3D pss->block;
> >      ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> >      int res;
> >
> > @@ -2062,17 +2061,40 @@ static int ram_save_target_page_legacy(RAMState=
 *rs, PageSearchStatus *pss)
> >          return 1;
> >      }
> >
> > +    return ram_save_page(rs, pss);
>
> Look at where git put this! Are you using the default diff algorithm? If
> not try using --patience to see if it improves the diff.

I used the default diff algorithm.

>
> > +}
> > +
> > +/**
> > + * ram_save_target_page_multifd: save one target page
> > + *
> > + * Returns the number of pages written
>
> We could be more precise here:
>
>  ram_save_target_page_multifd: send one target page to multifd workers
>
>  Returns 1 if the page was queued, -1 otherwise.

Will do.

>
> > + *
> > + * @rs: current RAM state
> > + * @pss: data about the page we want to send
> > + */
> > +static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus=
 *pss)
> > +{
> > +    RAMBlock *block =3D pss->block;
> > +    ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> > +
> > +    /* Multifd is not compatible with old compression. */
> > +    assert(!migrate_compress());
>
> This should already be enforced at options.c.
>
> > +
> > +    /* Multifd is not compabible with postcopy. */
> > +    assert(!migration_in_postcopy());
>
> Same here.
>
> > +
> >      /*
> > -     * Do not use multifd in postcopy as one whole host page should be
> > -     * placed.  Meanwhile postcopy requires atomic update of pages, so=
 even
> > -     * if host page size =3D=3D guest page size the dest guest during =
run may
> > -     * still see partially copied pages which is data corruption.
> > +     * Backward compatibility support. While using multifd live
> > +     * migration, we still need to handle zero page checking on the
> > +     * migration main thread.
> >       */
> > -    if (migrate_multifd() && !migration_in_postcopy()) {
> > -        return ram_save_multifd_page(block, offset);
> > +    if (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_LEGAC=
Y) {
> > +        if (save_zero_page(rs, pss, offset)) {
> > +            return 1;
> > +        }
> >      }
> >
> > -    return ram_save_page(rs, pss);
> > +    return ram_save_multifd_page(block, offset);
> >  }
> >
> >  /* Should be called before sending a host page */
> > @@ -2984,7 +3006,12 @@ static int ram_save_setup(QEMUFile *f, void *opa=
que)
> >      }
> >
> >      migration_ops =3D g_malloc0(sizeof(MigrationOps));
> > -    migration_ops->ram_save_target_page =3D ram_save_target_page_legac=
y;
> > +
> > +    if (migrate_multifd()) {
> > +        migration_ops->ram_save_target_page =3D ram_save_target_page_m=
ultifd;
> > +    } else {
> > +        migration_ops->ram_save_target_page =3D ram_save_target_page_l=
egacy;
> > +    }
> >
> >      bql_unlock();
> >      ret =3D multifd_send_sync_main();

