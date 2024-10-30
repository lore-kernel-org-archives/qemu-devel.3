Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7063CD74956
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 02:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5y9q-00077c-8x; Tue, 29 Oct 2024 22:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t5y9o-00076r-5A
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 22:10:00 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t5y9l-0003r1-Ak
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 22:09:59 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-718066adb47so3508761a34.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 19:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1730254195; x=1730858995;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=McJGDH3h6u6nNKhdSV/u1OcErpChP9H3jvZMdwZf8I8=;
 b=Bg+ZtLBnQdYz3wI244P303S/9vjERCQw7XtcTRwbzI/dGCylRKVFsElGG57NoW83+7
 Xjvf5hFn8mUst7uNwojX3ARgVLIMK+7pMo5es8S0V49ex2fEWwxWJeB6tIjNg+5cXYRU
 JzkGe2tjbqiPJSRdzkQnNvOF+l30RsdfnSkx2CEcqiqnF5SX8fkDYkfxW/Eho9EnoWa8
 chSfYeFonu59roDmUqJgsetAFrhyFWsqnOPz0Jgg9+JExFa0X+I2/eROuJQU4SEl5eos
 RiNvc+tCWr1Q+faEsKocROtUuWXIvENlkZSQ0dhEbZHwgIrtstZjAdAPa/lRZXnqWNKS
 eexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730254195; x=1730858995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=McJGDH3h6u6nNKhdSV/u1OcErpChP9H3jvZMdwZf8I8=;
 b=tEZe4BxKrQqgARPojJLXgqWDC+OyPjUHS0fNRa9/0XmNqh1JJpTvJ1gRcKPDXRdPXC
 acmi4TemFJU1oBLiWiM56uqYWbVBp25uW0joMBak5aOF9qYPfAqI8f3hRAc0jYUL33gT
 SBB9f4/gGOrMXuiBUOB8AZtm4OWDqSpIpiRl0itJRSfZyvgRMs+vLuJvugmCMLk4adNK
 pBehMPhD75UfeBPG0m0QRV1HM0wZuTdVNOG5ANBCsNpCXU/bJdtCDwnony4PH2wPu0kq
 QrU5ETqYwCfZm9Popa0b3iIY2KCVpdyOVCoUoINCfdBi4euRcshZ6l7xWypM/tLAZ/d2
 534w==
X-Gm-Message-State: AOJu0YxU2dL66JqJAeBR+GHgD9tGwpjlcJI2qlCNEyhgE0W1R9wTeARl
 I73uz7515sxw9jTE8YEHlmkRFuzx4Tj1ZnfCZqTwjYIrr1CKN3ay/oqNFujP08E9eXZyPMJjxIz
 pwHGHvLg3ACQuFiC9um2OqSWm4gqAQq3apm2muw==
X-Google-Smtp-Source: AGHT+IEYnzM22jsv4F+yFwrvwaojtG839AQCKiWqpdLkRZz84VwQUiwRF15bJT4QGH0cxsii1iWRalvKN8GRu+P39eU=
X-Received: by 2002:a05:6870:7ec5:b0:260:e3fa:ab8d with SMTP id
 586e51a60fabf-29051d6ba0bmr12558518fac.37.1730254194389; Tue, 29 Oct 2024
 19:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729648695.git.yong.huang@smartx.com>
 <76f0ea57ac7f4c2a68203d17fec1c34bb3d16a4a.1729648695.git.yong.huang@smartx.com>
 <ZyELi_ax8zM_kFbZ@x1n>
In-Reply-To: <ZyELi_ax8zM_kFbZ@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 30 Oct 2024 10:09:38 +0800
Message-ID: <CAK9dgmZ_++jEmhRfO9QR3WQFs18AwUnvn=_dTyfUnv5PHXYBYA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] migration: Avoid doing RAMBlock dirty sync in the
 initial iteration
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a0d0c10625a832d9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x331.google.com
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

--000000000000a0d0c10625a832d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 12:21=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:

> On Wed, Oct 23, 2024 at 10:09:51AM +0800, yong.huang@smartx.com wrote:
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > KVM always returns 1 when userspace retrieves a dirty bitmap for
> > the first time when KVM_DIRTY_LOG_INITIALLY_SET is enabled; in such
> > scenario, the RAMBlock dirty sync of the initial iteration can be
> > skipped.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  migration/cpu-throttle.c |  3 ++-
> >  migration/ram.c          | 30 +++++++++++++++++++++++++++---
> >  2 files changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> > index 342681cdd4..06e3b1be78 100644
> > --- a/migration/cpu-throttle.c
> > +++ b/migration/cpu-throttle.c
> > @@ -27,6 +27,7 @@
> >  #include "hw/core/cpu.h"
> >  #include "qemu/main-loop.h"
> >  #include "sysemu/cpus.h"
> > +#include "sysemu/kvm.h"
> >  #include "cpu-throttle.h"
> >  #include "migration.h"
> >  #include "migration-stats.h"
> > @@ -141,7 +142,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaqu=
e)
> >       * effect on guest performance, therefore omit it to avoid
> >       * paying extra for the sync penalty.
> >       */
> > -    if (sync_cnt <=3D 1) {
> > +    if (sync_cnt <=3D (kvm_dirty_log_manual_enabled() ? 0 : 1)) {
> >          goto end;
> >      }
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index d284f63854..b312ebd69d 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
> >  {
> >      MigrationState *ms =3D migrate_get_current();
> >      RAMBlock *block;
> > -    unsigned long pages;
> > +    unsigned long pages, clear_bmap_pages;
> >      uint8_t shift;
> >
> >      /* Skip setting bitmap if there is no RAM */
> > @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
> >
> >          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >              pages =3D block->max_length >> TARGET_PAGE_BITS;
> > +            clear_bmap_pages =3D clear_bmap_size(pages, shift);
> >              /*
> >               * The initial dirty bitmap for migration must be set with
> all
> >               * ones to make sure we'll migrate every guest RAM page to
> > @@ -2751,7 +2752,17 @@ static void ram_list_init_bitmaps(void)
> >                  block->file_bmap =3D bitmap_new(pages);
> >              }
> >              block->clear_bmap_shift =3D shift;
> > -            block->clear_bmap =3D bitmap_new(clear_bmap_size(pages,
> shift));
> > +            block->clear_bmap =3D bitmap_new(clear_bmap_pages);
> > +            /*
> > +             * Set the clear bitmap by default to enable dirty logging=
.
> > +             *
> > +             * Note that with KVM_DIRTY_LOG_INITIALLY_SET, dirty loggi=
ng
> > +             * will be enabled gradually in small chunks using
> > +             * KVM_CLEAR_DIRTY_LOG
> > +             */
> > +            if (kvm_dirty_log_manual_enabled()) {
> > +                bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
> > +            }
>
> Why it needs to be relevant to whether DIRTY_LOG is enabled?
>
> I wonder if we should always set clear_bmap to 1 unconditionally, as we
> always set bmap to all 1s by default.
>

OK, this works. We can drop it.


>
> Then we skip sync always during setup, dropping patch 1.
>

IIUC, KVM initializes the slot->dirty_bitmap with 1 only when
KVM_DIRTY_LOG_INITIALLY_SET is enabled, 0 otherwize.
This means that if KVM does not support the
KVM_DIRTY_LOG_INITIALLY_SET feature, userspace should
do the first sync so that KVM could set the WP bit and clear
the D-bit of the PTE.

Skipping first sync could handle this scenario?


> >          }
> >      }
> >  }
> > @@ -2771,6 +2782,7 @@ static void
> migration_bitmap_clear_discarded_pages(RAMState *rs)
> >
> >  static bool ram_init_bitmaps(RAMState *rs, Error **errp)
> >  {
> > +    Error *local_err =3D NULL;
> >      bool ret =3D true;
> >
> >      qemu_mutex_lock_ramlist();
> > @@ -2783,7 +2795,19 @@ static bool ram_init_bitmaps(RAMState *rs, Error
> **errp)
> >              if (!ret) {
> >                  goto out_unlock;
> >              }
> > -            migration_bitmap_sync_precopy(false);
> > +
> > +            if (kvm_dirty_log_manual_enabled()) {
> > +                /*
> > +                 * Bypass the RAMBlock dirty sync and still publish a
> > +                 * notification.
> > +                 */
> > +                if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC,
> > +                            &local_err)) {
> > +                    error_report_err(local_err);
> > +                }
> > +            } else {
> > +                migration_bitmap_sync_precopy(false);
> > +            }
> >          }
> >      }
> >  out_unlock:
> > --
> > 2.27.0
> >
>
> --
> Peter Xu
>
>

--=20
Best regards

--000000000000a0d0c10625a832d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 30, 20=
24 at 12:21=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pe=
terx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">On Wed, Oct 23, 20=
24 at 10:09:51AM +0800, <a href=3D"mailto:yong.huang@smartx.com" target=3D"=
_blank">yong.huang@smartx.com</a> wrote:<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; <br>
&gt; KVM always returns 1 when userspace retrieves a dirty bitmap for<br>
&gt; the first time when KVM_DIRTY_LOG_INITIALLY_SET is enabled; in such<br=
>
&gt; scenario, the RAMBlock dirty sync of the initial iteration can be<br>
&gt; skipped.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 migration/cpu-throttle.c |=C2=A0 3 ++-<br>
&gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 30 +++++++++=
++++++++++++++++++---<br>
&gt;=C2=A0 2 files changed, 29 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c<br>
&gt; index 342681cdd4..06e3b1be78 100644<br>
&gt; --- a/migration/cpu-throttle.c<br>
&gt; +++ b/migration/cpu-throttle.c<br>
&gt; @@ -27,6 +27,7 @@<br>
&gt;=C2=A0 #include &quot;hw/core/cpu.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/main-loop.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/cpus.h&quot;<br>
&gt; +#include &quot;sysemu/kvm.h&quot;<br>
&gt;=C2=A0 #include &quot;cpu-throttle.h&quot;<br>
&gt;=C2=A0 #include &quot;migration.h&quot;<br>
&gt;=C2=A0 #include &quot;migration-stats.h&quot;<br>
&gt; @@ -141,7 +142,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaq=
ue)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* effect on guest performance, therefore omi=
t it to avoid<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* paying extra for the sync penalty.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 if (sync_cnt &lt;=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 if (sync_cnt &lt;=3D (kvm_dirty_log_manual_enabled() ? =
0 : 1)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; index d284f63854..b312ebd69d 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MigrationState *ms =3D migrate_get_current();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 RAMBlock *block;<br>
&gt; -=C2=A0 =C2=A0 unsigned long pages;<br>
&gt; +=C2=A0 =C2=A0 unsigned long pages, clear_bmap_pages;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint8_t shift;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Skip setting bitmap if there is no RAM */<br>
&gt; @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RAMBLOCK_FOREACH_NOT_IGNORED(block) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pages =3D block-&gt;ma=
x_length &gt;&gt; TARGET_PAGE_BITS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_bmap_pages =3D clear_=
bmap_size(pages, shift);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The initial di=
rty bitmap for migration must be set with all<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ones to make s=
ure we&#39;ll migrate every guest RAM page to<br>
&gt; @@ -2751,7 +2752,17 @@ static void ram_list_init_bitmaps(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&g=
t;file_bmap =3D bitmap_new(pages);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_bmap_s=
hift =3D shift;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_bmap =3D bi=
tmap_new(clear_bmap_size(pages, shift));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;clear_bmap =3D bi=
tmap_new(clear_bmap_pages);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set the clear bitma=
p by default to enable dirty logging.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Note that with KVM_=
DIRTY_LOG_INITIALLY_SET, dirty logging<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* will be enabled gra=
dually in small chunks using<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* KVM_CLEAR_DIRTY_LOG=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kvm_dirty_log_manual_en=
abled()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bitmap_set(bl=
ock-&gt;clear_bmap, 0, clear_bmap_pages);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Why it needs to be relevant to whether DIRTY_LOG is enabled?<br>
<br>
I wonder if we should always set clear_bmap to 1 unconditionally, as we<br>
always set bmap to all 1s by default.<br></blockquote><div><br></div><div><=
div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gma=
il_default">OK, this works. We can drop it.</div></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padd=
ing-left:1ex">
<br>
Then we skip sync always during setup, dropping patch 1.<br></blockquote><d=
iv><br></div><div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif" class=3D"gmail_default">IIUC, KVM initializes the slot-&gt;dirty_bit=
map with 1 only when</div><div class=3D"gmail_default"><font face=3D"comic =
sans ms, sans-serif">KVM_DIRTY_LOG_INITIALLY_SET is enabled, 0 otherwize.</=
font></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" =
class=3D"gmail_default"></div></div><div style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif" class=3D"gmail_default">This means that if KVM doe=
s not support the</div><div style=3D"font-family:&quot;comic sans ms&quot;,=
sans-serif" class=3D"gmail_default">KVM_DIRTY_LOG_INITIALLY_SET feature, us=
erspace should</div><div style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif" class=3D"gmail_default">do the first sync so that KVM could set th=
e WP bit and clear</div><div style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif" class=3D"gmail_default">the D-bit of the PTE.</div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t"><br></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif=
" class=3D"gmail_default">Skipping first sync could handle this scenario?</=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color=
:rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt; @@ -2771,6 +2782,7 @@ static void migration_bitmap_clear_discarded_pag=
es(RAMState *rs)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static bool ram_init_bitmaps(RAMState *rs, Error **errp)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool ret =3D true;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock_ramlist();<br>
&gt; @@ -2783,7 +2795,19 @@ static bool ram_init_bitmaps(RAMState *rs, Erro=
r **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out=
_unlock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_bitmap_sync_preco=
py(false);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kvm_dirty_log_manual_en=
abled()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Bypas=
s the RAMBlock dirty sync and still publish a<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* notif=
ication.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (precopy_n=
otify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;local_err)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 error_report_err(local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_bit=
map_sync_precopy(false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 out_unlock:<br>
&gt; -- <br>
&gt; 2.27.0<br>
&gt; <br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>

--000000000000a0d0c10625a832d9--

