Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13543D2F7E9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 03:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1HYn-00087s-Nz; Wed, 16 Oct 2024 23:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1HYl-00087k-OT
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 23:52:23 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1HYi-00008K-5R
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 23:52:23 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3e4d6abb743so279368b6e.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 20:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729137138; x=1729741938;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ln/yJqS6iE8odymK4OOH/0BmsasGiCzOo2iFoQ/jbO8=;
 b=YNxuBU9zz+SdeqMPLPHqI8hf0zemGqA4L1K35nGvXBCNsg34jrXeaq7bT7DgJq+RvW
 hj2xj24di7i5XaJPaCaJcpevJ8lI49qtvkJ83Wtvhe5g72WYUrWAA99rrx3ON+3xZWki
 JsC05CUzwNGPOhp1SO8haADN0uGWozLcYR1yc01GyaLPxtiXbTGjrj8z+PmJRkrM/XQP
 q0FMyokAUOTp+3BnL8M9mO3g1e3RIeorI8YlZdne6+OAJEH8txfNOLkZ3oltpOq7Htwf
 5LjTDDBWPwhZNlvvnCKaPYhqwqh9dYsXJqGf9HVbwFvEOZUNjuYRcxefIM0KXGaKa//0
 Ci+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729137138; x=1729741938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ln/yJqS6iE8odymK4OOH/0BmsasGiCzOo2iFoQ/jbO8=;
 b=EkXD6bhCWe+QvS7px/nMuimV0KoI4gkMNVZvtW9nvt4KWU6K1NUgCXowyO5xLYZENd
 1ZYNZe/uosceKjWtnYSRljFlVe85GxUKVvL/taN//TWzrfpabW3wbxX6xKhBzz5zKQDW
 PZ/vTg8aNY86f6asOGIB1nQawaYkZoNRLuO0GEGMLaMgHJQyQZ9PC/BndeJvGbG1K2YG
 tnEEavmgqjx7Yr4VVPw49DcKNUCXGi0XWpYW4hDBJG3aVX1839QpCufe+lCDOKE4YCZ4
 6RbjRSLuXZ/SZgAAeSS0wTBbKQiL/xaA+ftw1qyLerqVNa4FCM2xmyJXpMPBLRBt/BVA
 OMsg==
X-Gm-Message-State: AOJu0YxccvjpbQiEKJcbg/M4HeOybzZXN7voQGnc3qVEsFgqb8F2Mgtb
 zmTyREMtxX+5MbwAC06DGUe+xzaX232HL8xTbC7BbQ0ey+8QWjs9vEpkQv/7iBMxTA9zfd7mniP
 EdA6GYWu4yJylOUmpnsX2yV3uu3Rv8riFfW+Icw==
X-Google-Smtp-Source: AGHT+IHUAPvGWTcFGp3Wd6OikWNjKBR+6W8ywtMJGSUByu5IiYtXFu8qpB9UIUPZoaogKw251TEarQD4ULKaos/V62o=
X-Received: by 2002:a05:6870:3912:b0:277:f14c:844b with SMTP id
 586e51a60fabf-2886e01cb99mr16393829fac.37.1729137137216; Wed, 16 Oct 2024
 20:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729064919.git.yong.huang@smartx.com>
 <e41bdd8dde51403a25b817ec49e860f9b515b793.1729064919.git.yong.huang@smartx.com>
 <Zw_gyHy-F7_bZNfD@x1n>
In-Reply-To: <Zw_gyHy-F7_bZNfD@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 17 Oct 2024 11:52:01 +0800
Message-ID: <CAK9dgmaTWgjrXzmAn1ZXSkQkSaXFnE1fBFFtoLuC=J1K-gRSqg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] migration: Move cpu-throttole.c from system to
 migration
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d502220624a41ce6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22d.google.com
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

--000000000000d502220624a41ce6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 11:50=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:

> On Wed, Oct 16, 2024 at 03:56:42PM +0800, yong.huang@smartx.com wrote:
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > Move cpu-throttle.c from system to migration since it's
> > only used for migration; this makes us avoid exporting the
> > util functions and variables in misc.h but export them in
> > migration.h when implementing the background ramblock dirty
> > sync feature in the upcoming commits.
> >
> > Additionally, make the two modifications below:
> >
> > 1. Delay the timer registering of CPU throttle until
> >    migration starts since it is only used in migration.
> >
> > 2. Stop CPU throttle if auto converge capability is
> >    enabled since it only happens with auto converge.
> >
> > 3. Remove the unused header file reference in
> >    accel/tcg/icount-common.c.
>
> Please consider split the things into smaller patches, especially when it
> involves file movements.
>

OK.


> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  accel/tcg/icount-common.c                    |  1 -
> >  {system =3D> migration}/cpu-throttle.c         |  2 +-
> >  {include/sysemu =3D> migration}/cpu-throttle.h |  0
> >  migration/meson.build                        |  1 +
> >  migration/migration.c                        | 11 +++++++++--
> >  migration/ram.c                              |  2 +-
> >  migration/trace-events                       |  3 +++
> >  system/cpu-timers.c                          |  3 ---
> >  system/meson.build                           |  1 -
> >  system/trace-events                          |  3 ---
> >  10 files changed, 15 insertions(+), 12 deletions(-)
> >  rename {system =3D> migration}/cpu-throttle.c (99%)
> >  rename {include/sysemu =3D> migration}/cpu-throttle.h (100%)
> >
> > diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
> > index 8d3d3a7e9d..30bf8500dc 100644
> > --- a/accel/tcg/icount-common.c
> > +++ b/accel/tcg/icount-common.c
> > @@ -36,7 +36,6 @@
> >  #include "sysemu/runstate.h"
> >  #include "hw/core/cpu.h"
> >  #include "sysemu/cpu-timers.h"
> > -#include "sysemu/cpu-throttle.h"
> >  #include "sysemu/cpu-timers-internal.h"
> >
> >  /*
> > diff --git a/system/cpu-throttle.c b/migration/cpu-throttle.c
> > similarity index 99%
> > rename from system/cpu-throttle.c
> > rename to migration/cpu-throttle.c
> > index 7632dc6143..fa47ee2e21 100644
> > --- a/system/cpu-throttle.c
> > +++ b/migration/cpu-throttle.c
> > @@ -27,7 +27,7 @@
> >  #include "hw/core/cpu.h"
> >  #include "qemu/main-loop.h"
> >  #include "sysemu/cpus.h"
> > -#include "sysemu/cpu-throttle.h"
> > +#include "cpu-throttle.h"
> >  #include "trace.h"
> >
> >  /* vcpu throttling controls */
> > diff --git a/include/sysemu/cpu-throttle.h b/migration/cpu-throttle.h
> > similarity index 100%
> > rename from include/sysemu/cpu-throttle.h
> > rename to migration/cpu-throttle.h
> > diff --git a/migration/meson.build b/migration/meson.build
> > index 66d3de86f0..d53cf3417a 100644
> > --- a/migration/meson.build
> > +++ b/migration/meson.build
> > @@ -13,6 +13,7 @@ system_ss.add(files(
> >    'block-dirty-bitmap.c',
> >    'channel.c',
> >    'channel-block.c',
> > +  'cpu-throttle.c',
> >    'dirtyrate.c',
> >    'exec.c',
> >    'fd.c',
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 021faee2f3..7e71184257 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -24,7 +24,7 @@
> >  #include "socket.h"
> >  #include "sysemu/runstate.h"
> >  #include "sysemu/sysemu.h"
> > -#include "sysemu/cpu-throttle.h"
> > +#include "cpu-throttle.h"
> >  #include "rdma.h"
> >  #include "ram.h"
> >  #include "migration/global_state.h"
> > @@ -3289,7 +3289,9 @@ static MigIterateState
> migration_iteration_run(MigrationState *s)
> >  static void migration_iteration_finish(MigrationState *s)
> >  {
> >      /* If we enabled cpu throttling for auto-converge, turn it off. */
> > -    cpu_throttle_stop();
> > +    if (migrate_auto_converge()) {
> > +        cpu_throttle_stop();
> > +    }
> >
> >      bql_lock();
> >      switch (s->state) {
> > @@ -3508,6 +3510,11 @@ static void *migration_thread(void *opaque)
> >          qemu_savevm_send_colo_enable(s->to_dst_file);
> >      }
> >
> > +    if (migrate_auto_converge()) {
> > +        /* Start cpu throttle timers */
> > +        cpu_throttle_init();
> > +    }
>
> Might this leak the timer object?


> I think it perhaps needs to be moved to migration_object_init().
>

Ok, I'll fix it in the next version.


>
> > +
> >      bql_lock();
> >      ret =3D qemu_savevm_state_setup(s->to_dst_file, &local_err);
> >      bql_unlock();
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 326ce7eb79..54d352b152 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -52,7 +52,7 @@
> >  #include "exec/target_page.h"
> >  #include "qemu/rcu_queue.h"
> >  #include "migration/colo.h"
> > -#include "sysemu/cpu-throttle.h"
> > +#include "cpu-throttle.h"
> >  #include "savevm.h"
> >  #include "qemu/iov.h"
> >  #include "multifd.h"
> > diff --git a/migration/trace-events b/migration/trace-events
> > index c65902f042..9a19599804 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -378,3 +378,6 @@ migration_block_progression(unsigned percent)
> "Completed %u%%"
> >  # page_cache.c
> >  migration_pagecache_init(int64_t max_num_items) "Setting cache buckets
> to %" PRId64
> >  migration_pagecache_insert(void) "Error allocating page"
> > +
> > +# cpu-throttle.c
> > +cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by
> %d%%"
> > diff --git a/system/cpu-timers.c b/system/cpu-timers.c
> > index 0b31c9a1b6..856e502e34 100644
> > --- a/system/cpu-timers.c
> > +++ b/system/cpu-timers.c
> > @@ -35,7 +35,6 @@
> >  #include "sysemu/runstate.h"
> >  #include "hw/core/cpu.h"
> >  #include "sysemu/cpu-timers.h"
> > -#include "sysemu/cpu-throttle.h"
> >  #include "sysemu/cpu-timers-internal.h"
> >
> >  /* clock and ticks */
> > @@ -272,6 +271,4 @@ void cpu_timers_init(void)
> >      seqlock_init(&timers_state.vm_clock_seqlock);
> >      qemu_spin_init(&timers_state.vm_clock_lock);
> >      vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
> > -
> > -    cpu_throttle_init();
> >  }
> > diff --git a/system/meson.build b/system/meson.build
> > index a296270cb0..4952f4b2c7 100644
> > --- a/system/meson.build
> > +++ b/system/meson.build
> > @@ -10,7 +10,6 @@ system_ss.add(files(
> >    'balloon.c',
> >    'bootdevice.c',
> >    'cpus.c',
> > -  'cpu-throttle.c',
> >    'cpu-timers.c',
> >    'datadir.c',
> >    'dirtylimit.c',
> > diff --git a/system/trace-events b/system/trace-events
> > index 074d001e90..2ed1d59b1f 100644
> > --- a/system/trace-events
> > +++ b/system/trace-events
> > @@ -44,6 +44,3 @@ dirtylimit_state_finalize(void)
> >  dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us)
> "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " u=
s"
> >  dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty
> page rate limit %"PRIu64
> >  dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d]
> sleep %"PRIi64 " us"
> > -
> > -# cpu-throttle.c
> > -cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by
> %d%%"
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

--000000000000d502220624a41ce6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 16, 20=
24 at 11:50=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pe=
terx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">On Wed, Oct 16, 20=
24 at 03:56:42PM +0800, <a href=3D"mailto:yong.huang@smartx.com" target=3D"=
_blank">yong.huang@smartx.com</a> wrote:<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; <br>
&gt; Move cpu-throttle.c from system to migration since it&#39;s<br>
&gt; only used for migration; this makes us avoid exporting the<br>
&gt; util functions and variables in misc.h but export them in<br>
&gt; migration.h when implementing the background ramblock dirty<br>
&gt; sync feature in the upcoming commits.<br>
&gt; <br>
&gt; Additionally, make the two modifications below:<br>
&gt; <br>
&gt; 1. Delay the timer registering of CPU throttle until<br>
&gt;=C2=A0 =C2=A0 migration starts since it is only used in migration.<br>
&gt; <br>
&gt; 2. Stop CPU throttle if auto converge capability is<br>
&gt;=C2=A0 =C2=A0 enabled since it only happens with auto converge.<br>
&gt; <br>
&gt; 3. Remove the unused header file reference in<br>
&gt;=C2=A0 =C2=A0 accel/tcg/icount-common.c.<br>
<br>
Please consider split the things into smaller patches, especially when it<b=
r>
involves file movements.<br></blockquote><div><br></div><div style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">OK.</d=
iv><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D=
"gmail_default"><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-lef=
t-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 accel/tcg/icount-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 -<br>
&gt;=C2=A0 {system =3D&gt; migration}/cpu-throttle.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 {include/sysemu =3D&gt; migration}/cpu-throttle.h |=C2=A0 0<br>
&gt;=C2=A0 migration/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 migration/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 +++++++++--<br>
&gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 migration/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
&gt;=C2=A0 system/cpu-timers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ---<br>
&gt;=C2=A0 system/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
&gt;=C2=A0 system/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ---<br>
&gt;=C2=A0 10 files changed, 15 insertions(+), 12 deletions(-)<br>
&gt;=C2=A0 rename {system =3D&gt; migration}/cpu-throttle.c (99%)<br>
&gt;=C2=A0 rename {include/sysemu =3D&gt; migration}/cpu-throttle.h (100%)<=
br>
&gt; <br>
&gt; diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c<br>
&gt; index 8d3d3a7e9d..30bf8500dc 100644<br>
&gt; --- a/accel/tcg/icount-common.c<br>
&gt; +++ b/accel/tcg/icount-common.c<br>
&gt; @@ -36,7 +36,6 @@<br>
&gt;=C2=A0 #include &quot;sysemu/runstate.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/core/cpu.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/cpu-timers.h&quot;<br>
&gt; -#include &quot;sysemu/cpu-throttle.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/cpu-timers-internal.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /*<br>
&gt; diff --git a/system/cpu-throttle.c b/migration/cpu-throttle.c<br>
&gt; similarity index 99%<br>
&gt; rename from system/cpu-throttle.c<br>
&gt; rename to migration/cpu-throttle.c<br>
&gt; index 7632dc6143..fa47ee2e21 100644<br>
&gt; --- a/system/cpu-throttle.c<br>
&gt; +++ b/migration/cpu-throttle.c<br>
&gt; @@ -27,7 +27,7 @@<br>
&gt;=C2=A0 #include &quot;hw/core/cpu.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/main-loop.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/cpus.h&quot;<br>
&gt; -#include &quot;sysemu/cpu-throttle.h&quot;<br>
&gt; +#include &quot;cpu-throttle.h&quot;<br>
&gt;=C2=A0 #include &quot;trace.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* vcpu throttling controls */<br>
&gt; diff --git a/include/sysemu/cpu-throttle.h b/migration/cpu-throttle.h<=
br>
&gt; similarity index 100%<br>
&gt; rename from include/sysemu/cpu-throttle.h<br>
&gt; rename to migration/cpu-throttle.h<br>
&gt; diff --git a/migration/meson.build b/migration/meson.build<br>
&gt; index 66d3de86f0..d53cf3417a 100644<br>
&gt; --- a/migration/meson.build<br>
&gt; +++ b/migration/meson.build<br>
&gt; @@ -13,6 +13,7 @@ system_ss.add(files(<br>
&gt;=C2=A0 =C2=A0 &#39;block-dirty-bitmap.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;channel.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;channel-block.c&#39;,<br>
&gt; +=C2=A0 &#39;cpu-throttle.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;dirtyrate.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;exec.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;fd.c&#39;,<br>
&gt; diff --git a/migration/migration.c b/migration/migration.c<br>
&gt; index 021faee2f3..7e71184257 100644<br>
&gt; --- a/migration/migration.c<br>
&gt; +++ b/migration/migration.c<br>
&gt; @@ -24,7 +24,7 @@<br>
&gt;=C2=A0 #include &quot;socket.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/runstate.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/sysemu.h&quot;<br>
&gt; -#include &quot;sysemu/cpu-throttle.h&quot;<br>
&gt; +#include &quot;cpu-throttle.h&quot;<br>
&gt;=C2=A0 #include &quot;rdma.h&quot;<br>
&gt;=C2=A0 #include &quot;ram.h&quot;<br>
&gt;=C2=A0 #include &quot;migration/global_state.h&quot;<br>
&gt; @@ -3289,7 +3289,9 @@ static MigIterateState migration_iteration_run(M=
igrationState *s)<br>
&gt;=C2=A0 static void migration_iteration_finish(MigrationState *s)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* If we enabled cpu throttling for auto-converge,=
 turn it off. */<br>
&gt; -=C2=A0 =C2=A0 cpu_throttle_stop();<br>
&gt; +=C2=A0 =C2=A0 if (migrate_auto_converge()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_throttle_stop();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 bql_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (s-&gt;state) {<br>
&gt; @@ -3508,6 +3510,11 @@ static void *migration_thread(void *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_savevm_send_colo_enable(s-&gt;t=
o_dst_file);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (migrate_auto_converge()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Start cpu throttle timers */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_throttle_init();<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Might this leak the timer object? =C2=A0</blockquote><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
I think it perhaps needs to be moved to migration_object_init().<br></block=
quote><div><br></div><div><span style=3D"font-family:&quot;comic sans ms&qu=
ot;,sans-serif"><span class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">Ok, I&#39;ll fix it in the next version.</spa=
n></span><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bql_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D qemu_savevm_state_setup(s-&gt;to_dst_file,=
 &amp;local_err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bql_unlock();<br>
&gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; index 326ce7eb79..54d352b152 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -52,7 +52,7 @@<br>
&gt;=C2=A0 #include &quot;exec/target_page.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/rcu_queue.h&quot;<br>
&gt;=C2=A0 #include &quot;migration/colo.h&quot;<br>
&gt; -#include &quot;sysemu/cpu-throttle.h&quot;<br>
&gt; +#include &quot;cpu-throttle.h&quot;<br>
&gt;=C2=A0 #include &quot;savevm.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/iov.h&quot;<br>
&gt;=C2=A0 #include &quot;multifd.h&quot;<br>
&gt; diff --git a/migration/trace-events b/migration/trace-events<br>
&gt; index c65902f042..9a19599804 100644<br>
&gt; --- a/migration/trace-events<br>
&gt; +++ b/migration/trace-events<br>
&gt; @@ -378,3 +378,6 @@ migration_block_progression(unsigned percent) &quo=
t;Completed %u%%&quot;<br>
&gt;=C2=A0 # page_cache.c<br>
&gt;=C2=A0 migration_pagecache_init(int64_t max_num_items) &quot;Setting ca=
che buckets to %&quot; PRId64<br>
&gt;=C2=A0 migration_pagecache_insert(void) &quot;Error allocating page&quo=
t;<br>
&gt; +<br>
&gt; +# cpu-throttle.c<br>
&gt; +cpu_throttle_set(int new_throttle_pct)=C2=A0 &quot;set guest CPU thro=
ttled by %d%%&quot;<br>
&gt; diff --git a/system/cpu-timers.c b/system/cpu-timers.c<br>
&gt; index 0b31c9a1b6..856e502e34 100644<br>
&gt; --- a/system/cpu-timers.c<br>
&gt; +++ b/system/cpu-timers.c<br>
&gt; @@ -35,7 +35,6 @@<br>
&gt;=C2=A0 #include &quot;sysemu/runstate.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/core/cpu.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/cpu-timers.h&quot;<br>
&gt; -#include &quot;sysemu/cpu-throttle.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/cpu-timers-internal.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* clock and ticks */<br>
&gt; @@ -272,6 +271,4 @@ void cpu_timers_init(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 seqlock_init(&amp;timers_state.vm_clock_seqlock);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_spin_init(&amp;timers_state.vm_clock_lock);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 vmstate_register(NULL, 0, &amp;vmstate_timers, &am=
p;timers_state);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 cpu_throttle_init();<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/system/meson.build b/system/meson.build<br>
&gt; index a296270cb0..4952f4b2c7 100644<br>
&gt; --- a/system/meson.build<br>
&gt; +++ b/system/meson.build<br>
&gt; @@ -10,7 +10,6 @@ system_ss.add(files(<br>
&gt;=C2=A0 =C2=A0 &#39;balloon.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;bootdevice.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;cpus.c&#39;,<br>
&gt; -=C2=A0 &#39;cpu-throttle.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;cpu-timers.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;datadir.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;dirtylimit.c&#39;,<br>
&gt; diff --git a/system/trace-events b/system/trace-events<br>
&gt; index 074d001e90..2ed1d59b1f 100644<br>
&gt; --- a/system/trace-events<br>
&gt; +++ b/system/trace-events<br>
&gt; @@ -44,6 +44,3 @@ dirtylimit_state_finalize(void)<br>
&gt;=C2=A0 dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t tim=
e_us) &quot;CPU[%d] throttle percent: %&quot; PRIu64 &quot;, throttle adjus=
t time %&quot;PRIi64 &quot; us&quot;<br>
&gt;=C2=A0 dirtylimit_set_vcpu(int cpu_index, uint64_t quota) &quot;CPU[%d]=
 set dirty page rate limit %&quot;PRIu64<br>
&gt;=C2=A0 dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) &q=
uot;CPU[%d] sleep %&quot;PRIi64 &quot; us&quot;<br>
&gt; -<br>
&gt; -# cpu-throttle.c<br>
&gt; -cpu_throttle_set(int new_throttle_pct)=C2=A0 &quot;set guest CPU thro=
ttled by %d%%&quot;<br>
&gt; -- <br>
&gt; 2.27.0<br>
&gt; <br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000d502220624a41ce6--

