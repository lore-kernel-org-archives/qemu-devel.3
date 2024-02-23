Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470BCC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 06:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdOdw-0000kv-KM; Fri, 23 Feb 2024 01:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdOdp-0000js-V2
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:02:37 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdOdn-0005PS-5G
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:02:37 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-564a53b8133so455761a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 22:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708668153; x=1709272953; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/uquJp25FAp7/6UCrxXOmOF+UskV1WXogdOmsNLuHE=;
 b=WMfGHTH1kyqJ8eYSJCvmVP4rMKW0ZH+9RQTbVmH1hLQf+xdVPRCYPjGo44PO76cy/4
 TTA9VgJB8odYdAz+x+COuELBiLBG96GZ6XYJGhaL3NoV7Opd54JKO1pCSqnh+O7CbnWC
 jNLeZX2iUO5bMRXUyYDb80HTB4c6JVP6y/5wQuyAzMDk6dK1cXNk8q11TLjAmY7McoBO
 uV+1c84EpIWe2oFz9QFQSzeoa9GPj1ptSU6XG6ICaJ3YMyXxDApCDAMM0cQbyxDogYdx
 lgg/rEQs2ZAKH+ty8xwI9oA1tWYUFXUYWzJRl2K8vwlm/hitWdJrAhVVHdW1nEQrd6C0
 6EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708668153; x=1709272953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/uquJp25FAp7/6UCrxXOmOF+UskV1WXogdOmsNLuHE=;
 b=W4SaOXdPnWOK/vRilfhBJKTNhyIg80f71pUIJeopATWJ/DIsNAHTtoNT/WzPK/OUR1
 7odFro15zoUACsfhR8cztbea6H8Dv0S2ZuV+UexfQ/niHXItLiPUNFTLVTbFP4Z7wXjG
 6oEcWiJVbZfdxAH3TQ5z3F8tSPcU9qze5jHzR0nFNntf1pZ4b7mp1+8nO91hUsGIYSUJ
 FJ/6KbiHljTOiuJaxWqCks+hSDG5Np7eLf6OJR5XzPQ/LCmqSol6KghvmezKEO4+w237
 igoFEREVnZZLESOmK1QLiPXKjMBQu3HPVTEHdEjRwN8O4QopQiyos0WNl8FLDPUehnY9
 gN8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfIPl9cVi5NUqrkoJcDKdBuS+SoTn3OGMFIXDYKHlhVmk8eZ/RLBlOYuCTLlO9LmEBzIpK0lSmur8TuAR4CBYUCR8DBWQ=
X-Gm-Message-State: AOJu0YwZkyv8vq4hzmQEvMnAdzPKzhRwIZH9ZBy8xlrb0Ip4ahqaSfzC
 fy+mJVXaQwCS1Jx/Vh4GCoUilKQjAG7MlhVcHHN81wI46SslmSS4kU86OsahXJuPzOKZoh1FcSC
 9vlK3YlXekJZ0Klo9JqzWS8v0ueEDpo3zbeNW3g==
X-Google-Smtp-Source: AGHT+IF0mlsfNlQj3kKoUBCYDg8YM1zGJrIDiJaWyw8mDQFMC7dB1PLfCrZ55Xl4aaCOws676BybnGgWQbEKi1i5/Cw=
X-Received: by 2002:aa7:c897:0:b0:564:cadc:c2db with SMTP id
 p23-20020aa7c897000000b00564cadcc2dbmr429391eds.3.1708668152837; Thu, 22 Feb
 2024 22:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-5-hao.xiang@bytedance.com> <875xyhbk8k.fsf@suse.de>
 <ZdgD-eqUYxbQMJQN@x1n>
In-Reply-To: <ZdgD-eqUYxbQMJQN@x1n>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 22 Feb 2024 22:02:21 -0800
Message-ID: <CAAYibXjBX8CeCL3-9BcUoGxY6UY9-N8sriJ7N_GUzVPUX1y3YQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 4/7] migration/multifd: Enable zero page
 checking from multifd threads.
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x531.google.com
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

On Thu, Feb 22, 2024 at 6:33=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Feb 21, 2024 at 06:06:19PM -0300, Fabiano Rosas wrote:
> > Hao Xiang <hao.xiang@bytedance.com> writes:
> >
> > > This change adds a dedicated handler for MigrationOps::ram_save_targe=
t_page in
> >
> > nit: Add a dedicated handler...
> >
> > Usually "this patch/change" is used only when necessary to avoid
> > ambiguity.
> >
> > > multifd live migration. Now zero page checking can be done in the mul=
tifd threads
> > > and this becomes the default configuration. We still provide backward=
 compatibility
> > > where zero page checking is done from the migration main thread.
> > >
> > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > > ---
> > >  migration/multifd.c |  1 +
> > >  migration/options.c |  2 +-
> > >  migration/ram.c     | 53 ++++++++++++++++++++++++++++++++++---------=
--
> > >  3 files changed, 42 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/migration/multifd.c b/migration/multifd.c
> > > index fbb40ea10b..ef5dad1019 100644
> > > --- a/migration/multifd.c
> > > +++ b/migration/multifd.c
> > > @@ -13,6 +13,7 @@
> > >  #include "qemu/osdep.h"
> > >  #include "qemu/cutils.h"
> >
> > This include...
> >
> > >  #include "qemu/rcu.h"
> > > +#include "qemu/cutils.h"
> >
> > is there already.
> >
> > >  #include "exec/target_page.h"
> > >  #include "sysemu/sysemu.h"
> > >  #include "exec/ramblock.h"
> > > diff --git a/migration/options.c b/migration/options.c
> > > index 3c603391b0..3c79b6ccd4 100644
> > > --- a/migration/options.c
> > > +++ b/migration/options.c
> > > @@ -181,7 +181,7 @@ Property migration_properties[] =3D {
> > >                        MIG_MODE_NORMAL),
> > >      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", Migration=
State,
> > >                         parameters.zero_page_detection,
> > > -                       ZERO_PAGE_DETECTION_LEGACY),
> > > +                       ZERO_PAGE_DETECTION_MULTIFD),
> >
> > I think we'll need something to avoid a 9.0 -> 8.2 migration with this
> > enabled. Otherwise it will go along happily until we get data corruptio=
n
> > because the new QEMU didn't send any zero pages on the migration thread
> > and the old QEMU did not look for them in the multifd packet.
>
> It could be even worse, as the new QEMU will only attach "normal" pages
> after the multifd packet, the old QEMU could read more than it could,
> expecting all pages..
>
> >
> > Perhaps bumping the MULTIFD_VERSION when ZERO_PAGE_DETECTION_MULTIFD is
> > in use. We'd just need to fix the test in the new QEMU to check
> > (msg.version > MULTIFD_VERSION) instead of (msg.version !=3D MULTIFD_VE=
RSION).
>
> IMHO we don't need yet to change MULTIFD_VERSION, what we need is perhaps=
 a
> compat entry in hw_compat_8_2 setting "zero-page-detection" to "legacy".
> We should make sure when "legacy" is set, multifd ran the old protocol
> (zero_num will always be 0, and will be ignored by old QEMUs, IIUC).
>
> One more comment is, when repost please consider split this patch into tw=
o;
> The new ram_save_target_page_multifd() hook can be done in another patch,
> AFAIU.

Sorry, I kept missing this. I will keep telling myself, compatibility
is king. I will set the hw_compat_8_2 setting and make sure to test
migration 9.0 -> 8.2 fails with "multifd" option set.
Will split patches.

>
> >
> > >
> > >      /* Migration capabilities */
> > >      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index 5ece9f042e..b088c5a98c 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -1123,10 +1123,6 @@ static int save_zero_page(RAMState *rs, PageSe=
archStatus *pss,
> > >      QEMUFile *file =3D pss->pss_channel;
> > >      int len =3D 0;
> > >
> > > -    if (migrate_zero_page_detection() !=3D ZERO_PAGE_DETECTION_LEGAC=
Y) {
> > > -        return 0;
> > > -    }
> >
> > How does 'none' work now?
> >
> > > -
> > >      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> > >          return 0;
> > >      }
> > > @@ -1256,6 +1252,10 @@ static int ram_save_page(RAMState *rs, PageSea=
rchStatus *pss)
> > >
> > >  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
> > >  {
> > > +    assert(migrate_multifd());
> > > +    assert(!migrate_compress());
> > > +    assert(!migration_in_postcopy());
> >
> > Drop these, please. Keep only the asserts that are likely to trigger
> > during development, such as the existing ones at multifd_send_pages.
> >
> > > +
> > >      if (!multifd_queue_page(block, offset)) {
> > >          return -1;
> > >      }
> > > @@ -2046,7 +2046,6 @@ static bool save_compress_page(RAMState *rs, Pa=
geSearchStatus *pss,
> > >   */
> > >  static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatu=
s *pss)
> > >  {
> > > -    RAMBlock *block =3D pss->block;
> > >      ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BIT=
S;
> > >      int res;
> > >
> > > @@ -2062,17 +2061,40 @@ static int ram_save_target_page_legacy(RAMSta=
te *rs, PageSearchStatus *pss)
> > >          return 1;
> > >      }
> > >
> > > +    return ram_save_page(rs, pss);
> >
> > Look at where git put this! Are you using the default diff algorithm? I=
f
> > not try using --patience to see if it improves the diff.
> >
> > > +}
> > > +
> > > +/**
> > > + * ram_save_target_page_multifd: save one target page
> > > + *
> > > + * Returns the number of pages written
> >
> > We could be more precise here:
> >
> >  ram_save_target_page_multifd: send one target page to multifd workers
> >
> >  Returns 1 if the page was queued, -1 otherwise.
> >
> > > + *
> > > + * @rs: current RAM state
> > > + * @pss: data about the page we want to send
> > > + */
> > > +static int ram_save_target_page_multifd(RAMState *rs, PageSearchStat=
us *pss)
> > > +{
> > > +    RAMBlock *block =3D pss->block;
> > > +    ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BIT=
S;
> > > +
> > > +    /* Multifd is not compatible with old compression. */
> > > +    assert(!migrate_compress());
> >
> > This should already be enforced at options.c.
> >
> > > +
> > > +    /* Multifd is not compabible with postcopy. */
> > > +    assert(!migration_in_postcopy());
> >
> > Same here.
> >
> > > +
> > >      /*
> > > -     * Do not use multifd in postcopy as one whole host page should =
be
> > > -     * placed.  Meanwhile postcopy requires atomic update of pages, =
so even
> > > -     * if host page size =3D=3D guest page size the dest guest durin=
g run may
> > > -     * still see partially copied pages which is data corruption.
> > > +     * Backward compatibility support. While using multifd live
> > > +     * migration, we still need to handle zero page checking on the
> > > +     * migration main thread.
> > >       */
> > > -    if (migrate_multifd() && !migration_in_postcopy()) {
> > > -        return ram_save_multifd_page(block, offset);
> > > +    if (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_LEG=
ACY) {
> > > +        if (save_zero_page(rs, pss, offset)) {
> > > +            return 1;
> > > +        }
> > >      }
> > >
> > > -    return ram_save_page(rs, pss);
> > > +    return ram_save_multifd_page(block, offset);
> > >  }
> > >
> > >  /* Should be called before sending a host page */
> > > @@ -2984,7 +3006,12 @@ static int ram_save_setup(QEMUFile *f, void *o=
paque)
> > >      }
> > >
> > >      migration_ops =3D g_malloc0(sizeof(MigrationOps));
> > > -    migration_ops->ram_save_target_page =3D ram_save_target_page_leg=
acy;
> > > +
> > > +    if (migrate_multifd()) {
> > > +        migration_ops->ram_save_target_page =3D ram_save_target_page=
_multifd;
> > > +    } else {
> > > +        migration_ops->ram_save_target_page =3D ram_save_target_page=
_legacy;
> > > +    }
> > >
> > >      bql_unlock();
> > >      ret =3D multifd_send_sync_main();
> >
>
> --
> Peter Xu
>

