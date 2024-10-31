Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF65E68946
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 02:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Kck-0005Ou-Cs; Wed, 30 Oct 2024 22:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t6Kce-0005Ol-T6
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 22:09:16 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t6Kcb-0001u9-39
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 22:09:16 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5eb67d926c4so240772eaf.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1730340550; x=1730945350;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ueqLZVvFAP4SF36UVAVCKSRlTGP+2THJll8VGcHxHJo=;
 b=ZtqRDWiCFQWPHhiC8esE9QXHhOYZkadRGr96tYquOyNEG+hkqxnHoQM3uj9+grLDWh
 kTlTv8iaAxBX3dSyXea27K5TmGBEZ1E3OO8RA1Hq3bNubrmMGxRPU6sgBM3WXZeDRIgZ
 nsGcHSXsM8q8mWizN8uJnq0iRlN6kvblUtbDXrg5YTO7BcQQib8zj56TeThBKjwZ5H1H
 Z9piRq96C4FBii5AVNTsIfS4i+xuw1VwF7nCxVnCsiExzDlN+qGfq0FMgjXRVmf+chhn
 B3wyRBvCaOSEtQIFjY604/ZWGRO9eig98zjrVxGI1py8MObFdHzojvMRNFzyrEF4XbKJ
 2KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730340550; x=1730945350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ueqLZVvFAP4SF36UVAVCKSRlTGP+2THJll8VGcHxHJo=;
 b=hJKuriq6Zq5U4P1IdRyeqAtLbHykibvbl8tX5PXnBd4FmFJjMDvuMLux63VUJwSDke
 LUlbUdjw6R/Ny4bv+bnYgA7FrUwHjTjPWZz+Tc/cZa7dANXpdr1b+Kn4caFGkiG4JPEt
 f2QbY5S0PTR2WyZ5+CQql9Wpf1U0fehkNXAYlPWw3FNtgc6Qoarx5W9Q9S1LiyTRz9Of
 ENi1Ph1fnWgwDcnB1iD8RQdtJzkhjs0KC1JYMwCXqkWJGDyqg7rwUiacFFsq0z4xosQT
 2cM3qYFD5/N0MJMgZGQQE5nOKWshMaAOw02awqcOeuxFZd9HNVldRJXXiK5IlDK0KODg
 ToDg==
X-Gm-Message-State: AOJu0YxpFqXYLEhY+JGcMfgKphNX0Ulup84bwrK6r6j+jP+jrPun1hTk
 YNkfItPyo6/lNj3x+YEkzEapuQQCcepen9dgu3tzKMSzKotTS7e8i+zRnphu4EhjZuRQKShvOAl
 UEMN0UmPNLJzwJ1z9vArj9JlmTR8tYKXRAhGaRw==
X-Google-Smtp-Source: AGHT+IFSQPkTCH9kM0FLqKH/NRHCZLXLjANq00uEJa02LuCtaniiClt0NboCdaqMmSQ8UShMCo3l5IsrR3cCPTuthoc=
X-Received: by 2002:a05:6870:5489:b0:278:2d12:9ef8 with SMTP id
 586e51a60fabf-29488b2daa4mr480425fac.14.1730340549570; Wed, 30 Oct 2024
 19:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729648695.git.yong.huang@smartx.com>
 <76f0ea57ac7f4c2a68203d17fec1c34bb3d16a4a.1729648695.git.yong.huang@smartx.com>
 <ZyELi_ax8zM_kFbZ@x1n>
 <CAK9dgmZ_++jEmhRfO9QR3WQFs18AwUnvn=_dTyfUnv5PHXYBYA@mail.gmail.com>
 <ZyKMVxuJyb3SZXkj@x1n>
In-Reply-To: <ZyKMVxuJyb3SZXkj@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 31 Oct 2024 10:08:53 +0800
Message-ID: <CAK9dgmZyW7+8C+jUB0PFCenzjBM53D-tXTVZYWQhwYf35BHGJA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] migration: Avoid doing RAMBlock dirty sync in the
 initial iteration
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cc4a710625bc4d49"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000cc4a710625bc4d49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 3:43=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Wed, Oct 30, 2024 at 10:09:38AM +0800, Yong Huang wrote:
> > On Wed, Oct 30, 2024 at 12:21=E2=80=AFAM Peter Xu <peterx@redhat.com> w=
rote:
> >
> > > On Wed, Oct 23, 2024 at 10:09:51AM +0800, yong.huang@smartx.com wrote=
:
> > > > From: Hyman Huang <yong.huang@smartx.com>
> > > >
> > > > KVM always returns 1 when userspace retrieves a dirty bitmap for
> > > > the first time when KVM_DIRTY_LOG_INITIALLY_SET is enabled; in such
> > > > scenario, the RAMBlock dirty sync of the initial iteration can be
> > > > skipped.
> > > >
> > > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > > ---
> > > >  migration/cpu-throttle.c |  3 ++-
> > > >  migration/ram.c          | 30 +++++++++++++++++++++++++++---
> > > >  2 files changed, 29 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> > > > index 342681cdd4..06e3b1be78 100644
> > > > --- a/migration/cpu-throttle.c
> > > > +++ b/migration/cpu-throttle.c
> > > > @@ -27,6 +27,7 @@
> > > >  #include "hw/core/cpu.h"
> > > >  #include "qemu/main-loop.h"
> > > >  #include "sysemu/cpus.h"
> > > > +#include "sysemu/kvm.h"
> > > >  #include "cpu-throttle.h"
> > > >  #include "migration.h"
> > > >  #include "migration-stats.h"
> > > > @@ -141,7 +142,7 @@ void cpu_throttle_dirty_sync_timer_tick(void
> *opaque)
> > > >       * effect on guest performance, therefore omit it to avoid
> > > >       * paying extra for the sync penalty.
> > > >       */
> > > > -    if (sync_cnt <=3D 1) {
> > > > +    if (sync_cnt <=3D (kvm_dirty_log_manual_enabled() ? 0 : 1)) {
> > > >          goto end;
> > > >      }
> > > >
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index d284f63854..b312ebd69d 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
> > > >  {
> > > >      MigrationState *ms =3D migrate_get_current();
> > > >      RAMBlock *block;
> > > > -    unsigned long pages;
> > > > +    unsigned long pages, clear_bmap_pages;
> > > >      uint8_t shift;
> > > >
> > > >      /* Skip setting bitmap if there is no RAM */
> > > > @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
> > > >
> > > >          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> > > >              pages =3D block->max_length >> TARGET_PAGE_BITS;
> > > > +            clear_bmap_pages =3D clear_bmap_size(pages, shift);
> > > >              /*
> > > >               * The initial dirty bitmap for migration must be set
> with
> > > all
> > > >               * ones to make sure we'll migrate every guest RAM pag=
e
> to
> > > > @@ -2751,7 +2752,17 @@ static void ram_list_init_bitmaps(void)
> > > >                  block->file_bmap =3D bitmap_new(pages);
> > > >              }
> > > >              block->clear_bmap_shift =3D shift;
> > > > -            block->clear_bmap =3D bitmap_new(clear_bmap_size(pages=
,
> > > shift));
> > > > +            block->clear_bmap =3D bitmap_new(clear_bmap_pages);
> > > > +            /*
> > > > +             * Set the clear bitmap by default to enable dirty
> logging.
> > > > +             *
> > > > +             * Note that with KVM_DIRTY_LOG_INITIALLY_SET, dirty
> logging
> > > > +             * will be enabled gradually in small chunks using
> > > > +             * KVM_CLEAR_DIRTY_LOG
> > > > +             */
> > > > +            if (kvm_dirty_log_manual_enabled()) {
> > > > +                bitmap_set(block->clear_bmap, 0, clear_bmap_pages)=
;
> > > > +            }
> > >
> > > Why it needs to be relevant to whether DIRTY_LOG is enabled?
> > >
> > > I wonder if we should always set clear_bmap to 1 unconditionally, as =
we
> > > always set bmap to all 1s by default.
> > >
> >
> > OK, this works. We can drop it.
> >
> >
> > >
> > > Then we skip sync always during setup, dropping patch 1.
> > >
> >
> > IIUC, KVM initializes the slot->dirty_bitmap with 1 only when
> > KVM_DIRTY_LOG_INITIALLY_SET is enabled, 0 otherwize.
> > This means that if KVM does not support the
> > KVM_DIRTY_LOG_INITIALLY_SET feature, userspace should
> > do the first sync so that KVM could set the WP bit and clear
> > the D-bit of the PTE.
> >
> > Skipping first sync could handle this scenario?
>
> Yes, the old kernels could be tricky (!CLEAR_LOG support), but I hope it'=
s
> also working.
>
> The thing is log_start() should also protect all pages if that's the case=
.
> For x86, that should corresponds to:
>
> kvm_mmu_slot_apply_flags():
>
>                 /*
>                  * Initially-all-set does not require write protecting an=
y
> page,
>                  * because they're all assumed to be dirty.
>                  */
>                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
>                         return;
>
>                 if (READ_ONCE(eager_page_split))
>                         kvm_mmu_slot_try_split_huge_pages(kvm, new,
> PG_LEVEL_4K);
>
>                 if (kvm_x86_ops.cpu_dirty_log_size) {
>                         kvm_mmu_slot_leaf_clear_dirty(kvm, new);
>                         kvm_mmu_slot_remove_write_access(kvm, new,
> PG_LEVEL_2M);
>                 } else {
>                         kvm_mmu_slot_remove_write_access(kvm, new,
> PG_LEVEL_4K);
>                 }
>

This path does the write protecting indeed. Thanks for pointing this out.


>
> In general, I think even if GET_DIRTY_LOG in setup() is omitted, all page=
s
> should still be wr-protected already right after log_start().  Then follo=
w
> up log_clear()s will be noop, until the next sync which will reprotect
> every page again.
>

Agree. I'll drop the patch 1 and simplify the patch 2 in the next version.

Thanks for the comments.


>
> Please double check.
>
> Thanks,
>
> --
> Peter Xu
>
>
Yong

--=20
Best regards

--000000000000cc4a710625bc4d49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 31, 20=
24 at 3:43=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pet=
erx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">On Wed, Oct 30, 202=
4 at 10:09:38AM +0800, Yong Huang wrote:<br>
&gt; On Wed, Oct 30, 2024 at 12:21=E2=80=AFAM Peter Xu &lt;<a href=3D"mailt=
o:peterx@redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Wed, Oct 23, 2024 at 10:09:51AM +0800, <a href=3D"mailto:yong.=
huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a> wrote:<br>
&gt; &gt; &gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.co=
m" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; KVM always returns 1 when userspace retrieves a dirty bitmap=
 for<br>
&gt; &gt; &gt; the first time when KVM_DIRTY_LOG_INITIALLY_SET is enabled; =
in such<br>
&gt; &gt; &gt; scenario, the RAMBlock dirty sync of the initial iteration c=
an be<br>
&gt; &gt; &gt; skipped.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@=
smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 migration/cpu-throttle.c |=C2=A0 3 ++-<br>
&gt; &gt; &gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 30=
 +++++++++++++++++++++++++++---<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 29 insertions(+), 4 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/migration/cpu-throttle.c b/migration/cpu-thrott=
le.c<br>
&gt; &gt; &gt; index 342681cdd4..06e3b1be78 100644<br>
&gt; &gt; &gt; --- a/migration/cpu-throttle.c<br>
&gt; &gt; &gt; +++ b/migration/cpu-throttle.c<br>
&gt; &gt; &gt; @@ -27,6 +27,7 @@<br>
&gt; &gt; &gt;=C2=A0 #include &quot;hw/core/cpu.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;qemu/main-loop.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;sysemu/cpus.h&quot;<br>
&gt; &gt; &gt; +#include &quot;sysemu/kvm.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;cpu-throttle.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;migration.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;migration-stats.h&quot;<br>
&gt; &gt; &gt; @@ -141,7 +142,7 @@ void cpu_throttle_dirty_sync_timer_tick(=
void *opaque)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* effect on guest performance, the=
refore omit it to avoid<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* paying extra for the sync penalt=
y.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 if (sync_cnt &lt;=3D 1) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (sync_cnt &lt;=3D (kvm_dirty_log_manual_en=
abled() ? 0 : 1)) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; &gt; &gt; index d284f63854..b312ebd69d 100644<br>
&gt; &gt; &gt; --- a/migration/ram.c<br>
&gt; &gt; &gt; +++ b/migration/ram.c<br>
&gt; &gt; &gt; @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void=
)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 MigrationState *ms =3D migrate_get_curre=
nt();<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 RAMBlock *block;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 unsigned long pages;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 unsigned long pages, clear_bmap_pages;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint8_t shift;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Skip setting bitmap if there is no RA=
M */<br>
&gt; &gt; &gt; @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void=
)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RAMBLOCK_FOREACH_NOT_IGNOR=
ED(block) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pages =3D bl=
ock-&gt;max_length &gt;&gt; TARGET_PAGE_BITS;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_bmap_pages =
=3D clear_bmap_size(pages, shift);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The =
initial dirty bitmap for migration must be set with<br>
&gt; &gt; all<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ones=
 to make sure we&#39;ll migrate every guest RAM page to<br>
&gt; &gt; &gt; @@ -2751,7 +2752,17 @@ static void ram_list_init_bitmaps(voi=
d)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 block-&gt;file_bmap =3D bitmap_new(pages);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;cl=
ear_bmap_shift =3D shift;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_b=
map =3D bitmap_new(clear_bmap_size(pages,<br>
&gt; &gt; shift));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_b=
map =3D bitmap_new(clear_bmap_pages);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set the c=
lear bitmap by default to enable dirty logging.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Note that=
 with KVM_DIRTY_LOG_INITIALLY_SET, dirty logging<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* will be e=
nabled gradually in small chunks using<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* KVM_CLEAR=
_DIRTY_LOG<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kvm_dirty_log=
_manual_enabled()) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bit=
map_set(block-&gt;clear_bmap, 0, clear_bmap_pages);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; Why it needs to be relevant to whether DIRTY_LOG is enabled?<br>
&gt; &gt;<br>
&gt; &gt; I wonder if we should always set clear_bmap to 1 unconditionally,=
 as we<br>
&gt; &gt; always set bmap to all 1s by default.<br>
&gt; &gt;<br>
&gt; <br>
&gt; OK, this works. We can drop it.<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Then we skip sync always during setup, dropping patch 1.<br>
&gt; &gt;<br>
&gt; <br>
&gt; IIUC, KVM initializes the slot-&gt;dirty_bitmap with 1 only when<br>
&gt; KVM_DIRTY_LOG_INITIALLY_SET is enabled, 0 otherwize.<br>
&gt; This means that if KVM does not support the<br>
&gt; KVM_DIRTY_LOG_INITIALLY_SET feature, userspace should<br>
&gt; do the first sync so that KVM could set the WP bit and clear<br>
&gt; the D-bit of the PTE.<br>
&gt; <br>
&gt; Skipping first sync could handle this scenario?<br>
<br>
Yes, the old kernels could be tricky (!CLEAR_LOG support), but I hope it&#3=
9;s<br>
also working.<br>
<br>
The thing is log_start() should also protect all pages if that&#39;s the ca=
se.<br>
For x86, that should corresponds to:<br>
<br>
kvm_mmu_slot_apply_flags():<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Initially-a=
ll-set does not require write protecting any page,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* because the=
y&#39;re all assumed to be dirty.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kvm_dirty_log_m=
anual_protect_and_init_set(kvm))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (READ_ONCE(eager=
_page_split))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kvm_mmu_slot_try_split_huge_pages(kvm, new, PG_LEVEL_4K);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kvm_x86_ops.cpu=
_dirty_log_size) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kvm_mmu_slot_leaf_clear_dirty(kvm, new);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kvm_mmu_slot_remove_write_access(kvm, new, PG_LEVEL_2M);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kvm_mmu_slot_remove_write_access(kvm, new, PG_LEVEL_4K);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><=
div><br></div><div><div style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif" class=3D"gmail_default">This path does the=C2=A0write protecting in=
deed. Thanks for pointing this out.</div></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left=
:1ex">
<br>
In general, I think even if GET_DIRTY_LOG in setup() is omitted, all pages<=
br>
should still be wr-protected already right after log_start().=C2=A0 Then fo=
llow<br>
up log_clear()s will be noop, until the next sync which will reprotect<br>
every page again.<br></blockquote><div><br></div><div><div style=3D"font-fa=
mily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Agree. I=
&#39;ll drop the patch 1 and simplify the patch 2 in the next version.=C2=
=A0</div></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if" class=3D"gmail_default"><br></div><div style=3D"font-family:&quot;comic=
 sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks for the comments.=
</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-le=
ft-color:rgb(204,204,204);padding-left:1ex">
<br>
Please double check.<br>
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Yong</div><br></div>=
<span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-ser=
if">Best regards</font></div></div></div>

--000000000000cc4a710625bc4d49--

