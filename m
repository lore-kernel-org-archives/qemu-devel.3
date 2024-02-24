Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8F1C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 23:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1re13Q-0008BA-FA; Sat, 24 Feb 2024 18:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1re13N-0008Ak-Sy
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 18:03:33 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1re13L-00054o-19
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 18:03:33 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso2460323a12.2
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708815807; x=1709420607; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPxYHkE60Dt4XkcVM0AZ+GrkOMp2a5g44W92hbn4zio=;
 b=MYpHhnhiiSQl0qfeyG6p+lC+EN8Y46ZX3Iu/DFUtSyn18hBKTR4EEk2GKGqJmRSdSk
 6ULjFbUcWAQw8E9BRp2mX1nCi/JikXP1/K+kvMCi2XbcSMWrd5/nGsCcc87AlPwmylgr
 wipD4TXVkBsCxOkSGpkwClieycsxuijkyjiJgwXezCWwRxs3R99XPESsCHF0KcLED44z
 NxvJxBQYGMXFCLUw8auaB2XOIBtOK8IIKl6JTHlaE+dQQYLx9BLecEVgiloPuXUO6AZB
 NuGreU1SoT6fw7wn6ldo+6S4ASYl1Rq6DNX6VgR9qJ1JNdCiacyY1/GSsopvj/wdA/2+
 ycyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708815807; x=1709420607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPxYHkE60Dt4XkcVM0AZ+GrkOMp2a5g44W92hbn4zio=;
 b=fM17BmDuY/eLeEfAkKJgemI6lCdiW+r8skiArPjvwKhIer9dOwsbEB1f+OBC7LvBQU
 Rj5YZ4vIST3XaWjo60z41V88vz0ERwfnSKIjbi7ep4Q87habA/HrS8UtfGIHifN0cSwh
 +dbAhiUNJMKiWz2SQ+q2MqjNViqNdadgpbRvK8g0OznsznUCawagDQFKpbqK9fVIy+I/
 d+UTkJ9vconntOuqImD5hkiYGx0O06qmEeYznpy55/PDstBmBwiLQHQhe1AE82l7zqQl
 s05jHSmFUMRyNE8NcqppSOG8Hj9MB7t55a+QJ8vb6l0hiGtU9CCVImHQVMWC1tOrrKHo
 dZ4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxsSo8bfcppeo7O54NbHKfJXpgeOGJouPDFrwttCdrub5Gb1RD6Uqjl+hZY7n5y+LD3dqtkl4c10a+P/outC8UBE1q+UM=
X-Gm-Message-State: AOJu0YyfSGCseaUnsIlhJqqkKJmTE6F66f1Fu5GK1+bshK6ldnl6EUcL
 xx7MNoiyvH9VvhAGl+EbGarVO0hfOAmY6ps6xGUZm70L86UCz880a4RO/w2YJeoF3IFeYcMDptE
 o6GnL4HXl17cqrxN0NR71/WmiQzCXc9cfBkQqmg==
X-Google-Smtp-Source: AGHT+IFn+EkfWdby7Q9SvgCSSR6c212h2jeTS7lOiftFxaUdu8sA+W4KOnNg3pq6B+8SfyZgZjWqKWGUYQ9XYpT6ztk=
X-Received: by 2002:a05:6402:b2d:b0:564:151c:747a with SMTP id
 bo13-20020a0564020b2d00b00564151c747amr2170330edb.27.1708815806903; Sat, 24
 Feb 2024 15:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-5-hao.xiang@bytedance.com> <875xyhbk8k.fsf@suse.de>
 <ZdgD-eqUYxbQMJQN@x1n>
 <CAAYibXjBX8CeCL3-9BcUoGxY6UY9-N8sriJ7N_GUzVPUX1y3YQ@mail.gmail.com>
In-Reply-To: <CAAYibXjBX8CeCL3-9BcUoGxY6UY9-N8sriJ7N_GUzVPUX1y3YQ@mail.gmail.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Sat, 24 Feb 2024 15:03:15 -0800
Message-ID: <CAAYibXgp-NGqE5ATby_Y6=s7WR5yToTxWQbdeVydv0Jez98iEQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 4/7] migration/multifd: Enable zero page
 checking from multifd threads.
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x52f.google.com
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

On Thu, Feb 22, 2024 at 10:02=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.com=
> wrote:
>
> On Thu, Feb 22, 2024 at 6:33=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Wed, Feb 21, 2024 at 06:06:19PM -0300, Fabiano Rosas wrote:
> > > Hao Xiang <hao.xiang@bytedance.com> writes:
> > >
> > > > This change adds a dedicated handler for MigrationOps::ram_save_tar=
get_page in
> > >
> > > nit: Add a dedicated handler...
> > >
> > > Usually "this patch/change" is used only when necessary to avoid
> > > ambiguity.
> > >
> > > > multifd live migration. Now zero page checking can be done in the m=
ultifd threads
> > > > and this becomes the default configuration. We still provide backwa=
rd compatibility
> > > > where zero page checking is done from the migration main thread.
> > > >
> > > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > > > ---
> > > >  migration/multifd.c |  1 +
> > > >  migration/options.c |  2 +-
> > > >  migration/ram.c     | 53 ++++++++++++++++++++++++++++++++++-------=
----
> > > >  3 files changed, 42 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/migration/multifd.c b/migration/multifd.c
> > > > index fbb40ea10b..ef5dad1019 100644
> > > > --- a/migration/multifd.c
> > > > +++ b/migration/multifd.c
> > > > @@ -13,6 +13,7 @@
> > > >  #include "qemu/osdep.h"
> > > >  #include "qemu/cutils.h"
> > >
> > > This include...
> > >
> > > >  #include "qemu/rcu.h"
> > > > +#include "qemu/cutils.h"
> > >
> > > is there already.
> > >
> > > >  #include "exec/target_page.h"
> > > >  #include "sysemu/sysemu.h"
> > > >  #include "exec/ramblock.h"
> > > > diff --git a/migration/options.c b/migration/options.c
> > > > index 3c603391b0..3c79b6ccd4 100644
> > > > --- a/migration/options.c
> > > > +++ b/migration/options.c
> > > > @@ -181,7 +181,7 @@ Property migration_properties[] =3D {
> > > >                        MIG_MODE_NORMAL),
> > > >      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", Migrati=
onState,
> > > >                         parameters.zero_page_detection,
> > > > -                       ZERO_PAGE_DETECTION_LEGACY),
> > > > +                       ZERO_PAGE_DETECTION_MULTIFD),
> > >
> > > I think we'll need something to avoid a 9.0 -> 8.2 migration with thi=
s
> > > enabled. Otherwise it will go along happily until we get data corrupt=
ion
> > > because the new QEMU didn't send any zero pages on the migration thre=
ad
> > > and the old QEMU did not look for them in the multifd packet.
> >
> > It could be even worse, as the new QEMU will only attach "normal" pages
> > after the multifd packet, the old QEMU could read more than it could,
> > expecting all pages..
> >
> > >
> > > Perhaps bumping the MULTIFD_VERSION when ZERO_PAGE_DETECTION_MULTIFD =
is
> > > in use. We'd just need to fix the test in the new QEMU to check
> > > (msg.version > MULTIFD_VERSION) instead of (msg.version !=3D MULTIFD_=
VERSION).
> >
> > IMHO we don't need yet to change MULTIFD_VERSION, what we need is perha=
ps a
> > compat entry in hw_compat_8_2 setting "zero-page-detection" to "legacy"=
.
> > We should make sure when "legacy" is set, multifd ran the old protocol
> > (zero_num will always be 0, and will be ignored by old QEMUs, IIUC).
> >
> > One more comment is, when repost please consider split this patch into =
two;
> > The new ram_save_target_page_multifd() hook can be done in another patc=
h,
> > AFAIU.
>
> Sorry, I kept missing this. I will keep telling myself, compatibility
> is king. I will set the hw_compat_8_2 setting and make sure to test
> migration 9.0 -> 8.2 fails with "multifd" option set.
> Will split patches.

So I just want to make sure I am coding the right solution. I added
setting "zero-page-detection" to "legacy" in hw_compat_8_2 and tested
it. The behavior is that if I set machine type to pc-q35-8.2,
zero-page-detection will automatically be set to "legacy". But if I
set the machine type to pc-q35-9.0, zero-page-detection will be the
default value "multifd". However, this doesn't seem to be a hard
requirement because I can still override zero-page-detection to
multifd on machine type pc-q35-8.2. Is this OK?

>
> >
> > >
> > > >
> > > >      /* Migration capabilities */
> > > >      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index 5ece9f042e..b088c5a98c 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -1123,10 +1123,6 @@ static int save_zero_page(RAMState *rs, Page=
SearchStatus *pss,
> > > >      QEMUFile *file =3D pss->pss_channel;
> > > >      int len =3D 0;
> > > >
> > > > -    if (migrate_zero_page_detection() !=3D ZERO_PAGE_DETECTION_LEG=
ACY) {
> > > > -        return 0;
> > > > -    }
> > >
> > > How does 'none' work now?
> > >
> > > > -
> > > >      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> > > >          return 0;
> > > >      }
> > > > @@ -1256,6 +1252,10 @@ static int ram_save_page(RAMState *rs, PageS=
earchStatus *pss)
> > > >
> > > >  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offse=
t)
> > > >  {
> > > > +    assert(migrate_multifd());
> > > > +    assert(!migrate_compress());
> > > > +    assert(!migration_in_postcopy());
> > >
> > > Drop these, please. Keep only the asserts that are likely to trigger
> > > during development, such as the existing ones at multifd_send_pages.
> > >
> > > > +
> > > >      if (!multifd_queue_page(block, offset)) {
> > > >          return -1;
> > > >      }
> > > > @@ -2046,7 +2046,6 @@ static bool save_compress_page(RAMState *rs, =
PageSearchStatus *pss,
> > > >   */
> > > >  static int ram_save_target_page_legacy(RAMState *rs, PageSearchSta=
tus *pss)
> > > >  {
> > > > -    RAMBlock *block =3D pss->block;
> > > >      ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_B=
ITS;
> > > >      int res;
> > > >
> > > > @@ -2062,17 +2061,40 @@ static int ram_save_target_page_legacy(RAMS=
tate *rs, PageSearchStatus *pss)
> > > >          return 1;
> > > >      }
> > > >
> > > > +    return ram_save_page(rs, pss);
> > >
> > > Look at where git put this! Are you using the default diff algorithm?=
 If
> > > not try using --patience to see if it improves the diff.
> > >
> > > > +}
> > > > +
> > > > +/**
> > > > + * ram_save_target_page_multifd: save one target page
> > > > + *
> > > > + * Returns the number of pages written
> > >
> > > We could be more precise here:
> > >
> > >  ram_save_target_page_multifd: send one target page to multifd worker=
s
> > >
> > >  Returns 1 if the page was queued, -1 otherwise.
> > >
> > > > + *
> > > > + * @rs: current RAM state
> > > > + * @pss: data about the page we want to send
> > > > + */
> > > > +static int ram_save_target_page_multifd(RAMState *rs, PageSearchSt=
atus *pss)
> > > > +{
> > > > +    RAMBlock *block =3D pss->block;
> > > > +    ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_B=
ITS;
> > > > +
> > > > +    /* Multifd is not compatible with old compression. */
> > > > +    assert(!migrate_compress());
> > >
> > > This should already be enforced at options.c.
> > >
> > > > +
> > > > +    /* Multifd is not compabible with postcopy. */
> > > > +    assert(!migration_in_postcopy());
> > >
> > > Same here.
> > >
> > > > +
> > > >      /*
> > > > -     * Do not use multifd in postcopy as one whole host page shoul=
d be
> > > > -     * placed.  Meanwhile postcopy requires atomic update of pages=
, so even
> > > > -     * if host page size =3D=3D guest page size the dest guest dur=
ing run may
> > > > -     * still see partially copied pages which is data corruption.
> > > > +     * Backward compatibility support. While using multifd live
> > > > +     * migration, we still need to handle zero page checking on th=
e
> > > > +     * migration main thread.
> > > >       */
> > > > -    if (migrate_multifd() && !migration_in_postcopy()) {
> > > > -        return ram_save_multifd_page(block, offset);
> > > > +    if (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_L=
EGACY) {
> > > > +        if (save_zero_page(rs, pss, offset)) {
> > > > +            return 1;
> > > > +        }
> > > >      }
> > > >
> > > > -    return ram_save_page(rs, pss);
> > > > +    return ram_save_multifd_page(block, offset);
> > > >  }
> > > >
> > > >  /* Should be called before sending a host page */
> > > > @@ -2984,7 +3006,12 @@ static int ram_save_setup(QEMUFile *f, void =
*opaque)
> > > >      }
> > > >
> > > >      migration_ops =3D g_malloc0(sizeof(MigrationOps));
> > > > -    migration_ops->ram_save_target_page =3D ram_save_target_page_l=
egacy;
> > > > +
> > > > +    if (migrate_multifd()) {
> > > > +        migration_ops->ram_save_target_page =3D ram_save_target_pa=
ge_multifd;
> > > > +    } else {
> > > > +        migration_ops->ram_save_target_page =3D ram_save_target_pa=
ge_legacy;
> > > > +    }
> > > >
> > > >      bql_unlock();
> > > >      ret =3D multifd_send_sync_main();
> > >
> >
> > --
> > Peter Xu
> >

