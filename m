Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313ADD2F7E9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 03:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Heb-00027f-RB; Wed, 16 Oct 2024 23:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1HeZ-00027F-LW
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 23:58:23 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1HeW-0000q2-1M
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 23:58:23 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3e41eabddffso292619b6e.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 20:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729137497; x=1729742297;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HuoQnD3mVNF7Y4usxQGhKW5EFBZrvFZaCd4tuxYE/wQ=;
 b=Bmg53McjApUdrHtaN5uK7SFZtEkktsnAM+Jo3XarXkvKW2rVI/+uXk0DJ16WCejdBe
 DlXPRV2oVBHLRKNg7BHmXoSjm4xD1oFa3pYM6Za4b0GmViWmIfMyBsNKWMdxvwDAd06Z
 sjqZwXeklBNxoBJKnmtTl3Qu61kVMfbTdlZX0K7FI8gV30EX7bt/DmeswQk+CWAAQ18r
 9VijQYittv2CQM6BH9Z8iVi5Ax5OjbGQE/VflrvYCx2OWWTisGD6sdhe5Wtsl0z+XSzL
 0X3QX3JqrZdLZdfD+Qg4PfPijhOkHSFSV8W7pSTM4W8wfiGi4KNYQIYkd+E/o3asHgJY
 ZT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729137497; x=1729742297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HuoQnD3mVNF7Y4usxQGhKW5EFBZrvFZaCd4tuxYE/wQ=;
 b=q9MdLTmcDWQRpzorjXZ6xP5FOaeDhTJar3uhcwtaSqWLepOLB2VCj/6zNkkH2CNDRV
 KAxBxIZNZeCP45YRBLafWamJ9/xTanb13dOPk98gZAc0YFjSsfveqRrZFYqQ/TAM1bIM
 fM5LzDpGFbcPuVF46NHOwwUaSKtpgWG9cQSekx7lw3/RyCLfIwrVIlSQDnvXOEufoNL6
 5whzaoyW7ktoEnCbSz5NHvCsfBaJ9ya/iYJHwK8CgkEf8Qg9t9RScZqJApP4iE7op1lP
 CCwzkHMCHsFoUNPAkX9BEQyHp4IbPC0jDIgJW/LY9eHrpSOiPTNp/3W/eI9BTke2cPM6
 0J2g==
X-Gm-Message-State: AOJu0YwwkG/2gJU5QRHFtaWLuHX/kpSN/XYzJ2BetguPAw73+LBXK7ZG
 S4Wa/plyVMgkVfRzgl2piouIy7wdnopEXMu49ESybFE39AQfTxbf9m/a9kiI8kLNkWgIyA8Rl+M
 97cQXxGUZcbYuhTX+3uxq24bm87yQwL4NyqyJNrbvgJLCI0ZDC9HLFg==
X-Google-Smtp-Source: AGHT+IHGXahr5SsLvStlPsFqX5PDw3x3rJbLWjVsTFBPwi+sCftzaoa/HLqk0MzipsiMGp41z7EgikVcRndlYObfLsQ=
X-Received: by 2002:a05:6870:b294:b0:288:b902:1b6d with SMTP id
 586e51a60fabf-288b90223a3mr10297811fac.26.1729137496578; Wed, 16 Oct 2024
 20:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729064919.git.yong.huang@smartx.com>
 <f1067c9ddca005629e64d7e77c98686612bb1f82.1729064919.git.yong.huang@smartx.com>
 <ZxAKp_qUU4ClLzs6@x1n>
In-Reply-To: <ZxAKp_qUU4ClLzs6@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 17 Oct 2024 11:58:00 +0800
Message-ID: <CAK9dgmbxVrB_QdbHtrutAQDjA+Q1f3rwtHc-nCo_oR+S5wK16w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] migration: Support periodic ramblock dirty sync
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000407b750624a432b9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22c.google.com
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

--000000000000407b750624a432b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 2:49=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Wed, Oct 16, 2024 at 03:56:44PM +0800, yong.huang@smartx.com wrote:
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > When VM is configured with huge memory, the current throttle logic
> > doesn't look like to scale, because migration_trigger_throttle()
> > is only called for each iteration, so it won't be invoked for a long
> > time if one iteration can take a long time.
> >
> > The periodic dirty sync aims to fix the above issue by synchronizing
> > the ramblock from remote dirty bitmap and, when necessary, triggering
> > the CPU throttle multiple times during a long iteration.
> >
> > This is a trade-off between synchronization overhead and CPU throttle
> > impact.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  migration/cpu-throttle.c | 70 +++++++++++++++++++++++++++++++++++++++-
> >  migration/cpu-throttle.h | 14 ++++++++
> >  migration/migration.h    |  1 +
> >  migration/ram.c          |  9 ++++--
> >  migration/trace-events   |  1 +
> >  5 files changed, 92 insertions(+), 3 deletions(-)
> >
> > diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> > index fa47ee2e21..784b51ab35 100644
> > --- a/migration/cpu-throttle.c
> > +++ b/migration/cpu-throttle.c
> > @@ -28,16 +28,23 @@
> >  #include "qemu/main-loop.h"
> >  #include "sysemu/cpus.h"
> >  #include "cpu-throttle.h"
> > +#include "migration.h"
> > +#include "migration-stats.h"
> > +#include "options.h"
> >  #include "trace.h"
> >
> >  /* vcpu throttling controls */
> > -static QEMUTimer *throttle_timer;
> > +static QEMUTimer *throttle_timer, *throttle_dirty_sync_timer;
> >  static unsigned int throttle_percentage;
> > +static bool throttle_dirty_sync_timer_active;
> >
> >  #define CPU_THROTTLE_PCT_MIN 1
> >  #define CPU_THROTTLE_PCT_MAX 99
> >  #define CPU_THROTTLE_TIMESLICE_NS 10000000
> >
> > +/* RAMBlock dirty sync trigger every five seconds */
>
> Maybe enrich it to say "making sure it is synchronized every five seconds=
"?
> Because it can synchronize faster if each iteration runs faster than 5sec=
,
> so just to emphasize it's a fallback sync, and only with auto converge.
>

Agree, I'll refine the comment in the next version.


>
> > +#define CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS 5000
> > +
> >  static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
> >  {
> >      double pct;
> > @@ -112,6 +119,7 @@ void cpu_throttle_set(int new_throttle_pct)
> >  void cpu_throttle_stop(void)
> >  {
> >      qatomic_set(&throttle_percentage, 0);
> > +    cpu_throttle_dirty_sync_timer(false);
> >  }
> >
> >  bool cpu_throttle_active(void)
> > @@ -124,8 +132,68 @@ int cpu_throttle_get_percentage(void)
> >      return qatomic_read(&throttle_percentage);
> >  }
> >
> > +void cpu_throttle_dirty_sync_timer_tick(void *opaque)
> > +{
> > +    static uint64_t prev_sync_cnt =3D 2;
>
> IIUC the hard coded "2" isn't needed, as long as it's guaranteed to be
> updated for each timer call, and you special cased "1" anyway below.
>

Ok.


>
> > +    uint64_t sync_cnt =3D stat64_get(&mig_stats.dirty_sync_count);
> > +
> > +    if (!migrate_auto_converge()) {
> > +        /* Stop the timer when auto converge is disabled */
> > +        return;
>
> I think we can try to make sure this never starts if !auto-converge, so
> assuming this path will never trigger in real life.
>

Indeed, this makes the code cleaner.


> > +    }
> > +
> > +    /*
> > +     * The first iteration copies all memory anyhow and has no
> > +     * effect on guest performance, therefore omit it to avoid
> > +     * paying extra for the sync penalty.
> > +     */
> > +    if (sync_cnt <=3D 1) {
> > +        goto end;
> > +    }
> > +
> > +    if (sync_cnt =3D=3D prev_sync_cnt) {
> > +        trace_cpu_throttle_dirty_sync();
> > +        WITH_RCU_READ_LOCK_GUARD() {
> > +            migration_bitmap_sync_precopy(false);
> > +        }
> > +    }
> > +
> > +end:
> > +    prev_sync_cnt =3D stat64_get(&mig_stats.dirty_sync_count);
> > +
> > +    timer_mod(throttle_dirty_sync_timer,
> > +        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
> > +            CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
> > +}
> > +
> > +static bool cpu_throttle_dirty_sync_active(void)
> > +{
> > +    return qatomic_read(&throttle_dirty_sync_timer_active);
> > +}
> > +
> > +void cpu_throttle_dirty_sync_timer(bool enable)
> > +{
> > +    if (enable) {
> > +        assert(throttle_dirty_sync_timer);
> > +        if (!cpu_throttle_dirty_sync_active()) {
>
> I suppose this can be logically racy? As I think after this patch this pa=
th
> can be invoked both in main thread and migration thread.
>

Indeed, thanks for pointing this out.


>
> The simplest way to do is to move cpu_throttle_stop() call to be under
> bql_lock(), so that this will be serialized by BQL.  Then we can add an
> assertion at the entry of the function for bql_locked().


> > +            timer_mod(throttle_dirty_sync_timer,
> > +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
> > +                    CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
> > +            qatomic_set(&throttle_dirty_sync_timer_active, 1);
> > +        }
> > +    } else {
> > +        if (throttle_dirty_sync_timer !=3D NULL) {
>
> IIUC throttle_dirty_sync_timer is never destroyed, aka, timer_del() only
> disables it.  So you should probably use throttle_dirty_sync_timer_active=
?
>
> > +            timer_del(throttle_dirty_sync_timer);
> > +            qatomic_set(&throttle_dirty_sync_timer_active, 0);
> > +        }
> > +    }
> > +}
> > +
> >  void cpu_throttle_init(void)
> >  {
> >      throttle_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
> >                                    cpu_throttle_timer_tick, NULL);
> > +    throttle_dirty_sync_timer =3D
> > +        timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
> > +                     cpu_throttle_dirty_sync_timer_tick, NULL);
> >  }
> > diff --git a/migration/cpu-throttle.h b/migration/cpu-throttle.h
> > index d65bdef6d0..420702b8d3 100644
> > --- a/migration/cpu-throttle.h
> > +++ b/migration/cpu-throttle.h
> > @@ -65,4 +65,18 @@ bool cpu_throttle_active(void);
> >   */
> >  int cpu_throttle_get_percentage(void);
> >
> > +/**
> > + * cpu_throttle_dirty_sync_timer_tick:
> > + *
> > + * Dirty sync timer hook.
> > + */
> > +void cpu_throttle_dirty_sync_timer_tick(void *opaque);
> > +
> > +/**
> > + * cpu_throttle_dirty_sync_timer:
> > + *
> > + * Start or stop the dirty sync timer.
> > + */
> > +void cpu_throttle_dirty_sync_timer(bool enable);
> > +
> >  #endif /* SYSEMU_CPU_THROTTLE_H */
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 38aa1402d5..fbd0d19092 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -537,4 +537,5 @@ int migration_rp_wait(MigrationState *s);
> >   */
> >  void migration_rp_kick(MigrationState *s);
> >
> > +void migration_bitmap_sync_precopy(bool last_stage);
> >  #endif
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 9b5b350405..ac34e731e2 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1020,6 +1020,11 @@ static void migration_trigger_throttle(RAMState
> *rs)
> >          migration_transferred_bytes() - rs->bytes_xfer_prev;
> >      uint64_t bytes_dirty_period =3D rs->num_dirty_pages_period *
> TARGET_PAGE_SIZE;
> >      uint64_t bytes_dirty_threshold =3D bytes_xfer_period * threshold /
> 100;
> > +    bool auto_converge =3D migrate_auto_converge();
> > +
> > +    if (auto_converge) {
> > +        cpu_throttle_dirty_sync_timer(true);
> > +    }
>
> If you have the guard to skip the 1st sync in the timer fn(), IIUC you ca=
n
> move this earlier to e.g. migration_thread() before iteration starts.
> Otherwise it'll be not as clear on when this timer will start if it hides
> in the sync path itself.
>
> >
> >      /*
> >       * The following detection logic can be refined later. For now:
> > @@ -1031,7 +1036,7 @@ static void migration_trigger_throttle(RAMState
> *rs)
> >      if ((bytes_dirty_period > bytes_dirty_threshold) &&
> >          (++rs->dirty_rate_high_cnt >=3D 2)) {
> >          rs->dirty_rate_high_cnt =3D 0;
> > -        if (migrate_auto_converge()) {
> > +        if (auto_converge) {
> >              trace_migration_throttle();
> >              mig_throttle_guest_down(bytes_dirty_period,
> >                                      bytes_dirty_threshold);
> > @@ -1088,7 +1093,7 @@ static void migration_bitmap_sync(RAMState *rs,
> bool last_stage)
> >      }
> >  }
> >
> > -static void migration_bitmap_sync_precopy(bool last_stage)
> > +void migration_bitmap_sync_precopy(bool last_stage)
> >  {
> >      Error *local_err =3D NULL;
> >      assert(ram_state);
> > diff --git a/migration/trace-events b/migration/trace-events
> > index 9a19599804..0638183056 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -381,3 +381,4 @@ migration_pagecache_insert(void) "Error allocating
> page"
> >
> >  # cpu-throttle.c
> >  cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by
> %d%%"
> > +cpu_throttle_dirty_sync(void) ""
> > --
> > 2.27.0
> >
>
> --
> Peter Xu
>
>
All the comments above are advisable, thanks Peter, I'll try it in the next
version.

Yong

--=20
Best regards

--000000000000407b750624a432b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 17, 20=
24 at 2:49=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pet=
erx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">On Wed, Oct 16, 202=
4 at 03:56:44PM +0800, <a href=3D"mailto:yong.huang@smartx.com" target=3D"_=
blank">yong.huang@smartx.com</a> wrote:<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; <br>
&gt; When VM is configured with huge memory, the current throttle logic<br>
&gt; doesn&#39;t look like to scale, because migration_trigger_throttle()<b=
r>
&gt; is only called for each iteration, so it won&#39;t be invoked for a lo=
ng<br>
&gt; time if one iteration can take a long time.<br>
&gt; <br>
&gt; The periodic dirty sync aims to fix the above issue by synchronizing<b=
r>
&gt; the ramblock from remote dirty bitmap and, when necessary, triggering<=
br>
&gt; the CPU throttle multiple times during a long iteration.<br>
&gt; <br>
&gt; This is a trade-off between synchronization overhead and CPU throttle<=
br>
&gt; impact.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 migration/cpu-throttle.c | 70 ++++++++++++++++++++++++++++++++++=
+++++-<br>
&gt;=C2=A0 migration/cpu-throttle.h | 14 ++++++++<br>
&gt;=C2=A0 migration/migration.h=C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 ++++=
--<br>
&gt;=C2=A0 migration/trace-events=C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 5 files changed, 92 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c<br>
&gt; index fa47ee2e21..784b51ab35 100644<br>
&gt; --- a/migration/cpu-throttle.c<br>
&gt; +++ b/migration/cpu-throttle.c<br>
&gt; @@ -28,16 +28,23 @@<br>
&gt;=C2=A0 #include &quot;qemu/main-loop.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/cpus.h&quot;<br>
&gt;=C2=A0 #include &quot;cpu-throttle.h&quot;<br>
&gt; +#include &quot;migration.h&quot;<br>
&gt; +#include &quot;migration-stats.h&quot;<br>
&gt; +#include &quot;options.h&quot;<br>
&gt;=C2=A0 #include &quot;trace.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* vcpu throttling controls */<br>
&gt; -static QEMUTimer *throttle_timer;<br>
&gt; +static QEMUTimer *throttle_timer, *throttle_dirty_sync_timer;<br>
&gt;=C2=A0 static unsigned int throttle_percentage;<br>
&gt; +static bool throttle_dirty_sync_timer_active;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define CPU_THROTTLE_PCT_MIN 1<br>
&gt;=C2=A0 #define CPU_THROTTLE_PCT_MAX 99<br>
&gt;=C2=A0 #define CPU_THROTTLE_TIMESLICE_NS 10000000<br>
&gt;=C2=A0 <br>
&gt; +/* RAMBlock dirty sync trigger every five seconds */<br>
<br>
Maybe enrich it to say &quot;making sure it is synchronized every five seco=
nds&quot;?<br>
Because it can synchronize faster if each iteration runs faster than 5sec,<=
br>
so just to emphasize it&#39;s a fallback sync, and only with auto converge.=
<br></blockquote><div><br></div><div><div style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif" class=3D"gmail_default">Agree, I&#39;ll refine th=
e comment in the next version.</div></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt; +#define CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS 5000<br>
&gt; +<br>
&gt;=C2=A0 static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data o=
paque)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 double pct;<br>
&gt; @@ -112,6 +119,7 @@ void cpu_throttle_set(int new_throttle_pct)<br>
&gt;=C2=A0 void cpu_throttle_stop(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qatomic_set(&amp;throttle_percentage, 0);<br>
&gt; +=C2=A0 =C2=A0 cpu_throttle_dirty_sync_timer(false);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 bool cpu_throttle_active(void)<br>
&gt; @@ -124,8 +132,68 @@ int cpu_throttle_get_percentage(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return qatomic_read(&amp;throttle_percentage);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +void cpu_throttle_dirty_sync_timer_tick(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 static uint64_t prev_sync_cnt =3D 2;<br>
<br>
IIUC the hard coded &quot;2&quot; isn&#39;t needed, as long as it&#39;s gua=
ranteed to be<br>
updated for each timer call, and you special cased &quot;1&quot; anyway bel=
ow.<br></blockquote><div><br></div><div><div style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif" class=3D"gmail_default">Ok.</div></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(20=
4,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 uint64_t sync_cnt =3D stat64_get(&amp;mig_stats.dirty_s=
ync_count);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!migrate_auto_converge()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Stop the timer when auto converge is d=
isabled */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
I think we can try to make sure this never starts if !auto-converge, so<br>
assuming this path will never trigger in real life.<br></blockquote><div><b=
r></div><div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif=
" class=3D"gmail_default">Indeed, this makes the code cleaner.</div></div><=
div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(=
204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The first iteration copies all memory anyhow an=
d has no<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* effect on guest performance, therefore omit it =
to avoid<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* paying extra for the sync penalty.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (sync_cnt &lt;=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (sync_cnt =3D=3D prev_sync_cnt) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_cpu_throttle_dirty_sync();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 WITH_RCU_READ_LOCK_GUARD() {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_bitmap_sync_preco=
py(false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +end:<br>
&gt; +=C2=A0 =C2=A0 prev_sync_cnt =3D stat64_get(&amp;mig_stats.dirty_sync_=
count);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 timer_mod(throttle_dirty_sync_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) =
+<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU_THROTTLE_DIRTY_SYNC_TIM=
ESLICE_MS);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool cpu_throttle_dirty_sync_active(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return qatomic_read(&amp;throttle_dirty_sync_timer_acti=
ve);<br>
&gt; +}<br>
&gt; +<br>
&gt; +void cpu_throttle_dirty_sync_timer(bool enable)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (enable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(throttle_dirty_sync_timer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cpu_throttle_dirty_sync_active()) {<=
br>
<br>
I suppose this can be logically racy? As I think after this patch this path=
<br>
can be invoked both in main thread and migration thread.<br></blockquote><d=
iv><br></div><div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif" class=3D"gmail_default">Indeed, thanks for pointing this out.</div><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-co=
lor:rgb(204,204,204);padding-left:1ex">
<br>
The simplest way to do is to move cpu_throttle_stop() call to be under<br>
bql_lock(), so that this will be serialized by BQL.=C2=A0 Then we can add a=
n<br>
assertion at the entry of the function for bql_locked().=C2=A0</blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);p=
adding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(throttle_dirty_sy=
nc_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_clock_ge=
t_ms(QEMU_CLOCK_VIRTUAL_RT) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_set(&amp;throttle_d=
irty_sync_timer_active, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (throttle_dirty_sync_timer !=3D NULL) =
{<br>
<br>
IIUC throttle_dirty_sync_timer is never destroyed, aka, timer_del() only<br=
>
disables it.=C2=A0 So you should probably use throttle_dirty_sync_timer_act=
ive?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(throttle_dirty_sy=
nc_timer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_set(&amp;throttle_d=
irty_sync_timer_active, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 void cpu_throttle_init(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 throttle_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL=
_RT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_throttle_timer_=
tick, NULL);<br>
&gt; +=C2=A0 =C2=A0 throttle_dirty_sync_timer =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cpu_throttle_dirty_sync_timer_tick, NULL);<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/migration/cpu-throttle.h b/migration/cpu-throttle.h<br>
&gt; index d65bdef6d0..420702b8d3 100644<br>
&gt; --- a/migration/cpu-throttle.h<br>
&gt; +++ b/migration/cpu-throttle.h<br>
&gt; @@ -65,4 +65,18 @@ bool cpu_throttle_active(void);<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 int cpu_throttle_get_percentage(void);<br>
&gt;=C2=A0 <br>
&gt; +/**<br>
&gt; + * cpu_throttle_dirty_sync_timer_tick:<br>
&gt; + *<br>
&gt; + * Dirty sync timer hook.<br>
&gt; + */<br>
&gt; +void cpu_throttle_dirty_sync_timer_tick(void *opaque);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * cpu_throttle_dirty_sync_timer:<br>
&gt; + *<br>
&gt; + * Start or stop the dirty sync timer.<br>
&gt; + */<br>
&gt; +void cpu_throttle_dirty_sync_timer(bool enable);<br>
&gt; +<br>
&gt;=C2=A0 #endif /* SYSEMU_CPU_THROTTLE_H */<br>
&gt; diff --git a/migration/migration.h b/migration/migration.h<br>
&gt; index 38aa1402d5..fbd0d19092 100644<br>
&gt; --- a/migration/migration.h<br>
&gt; +++ b/migration/migration.h<br>
&gt; @@ -537,4 +537,5 @@ int migration_rp_wait(MigrationState *s);<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 void migration_rp_kick(MigrationState *s);<br>
&gt;=C2=A0 <br>
&gt; +void migration_bitmap_sync_precopy(bool last_stage);<br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; index 9b5b350405..ac34e731e2 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -1020,6 +1020,11 @@ static void migration_trigger_throttle(RAMState=
 *rs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_transferred_bytes() - rs-&=
gt;bytes_xfer_prev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t bytes_dirty_period =3D rs-&gt;num_dirty_p=
ages_period * TARGET_PAGE_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t bytes_dirty_threshold =3D bytes_xfer_peri=
od * threshold / 100;<br>
&gt; +=C2=A0 =C2=A0 bool auto_converge =3D migrate_auto_converge();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (auto_converge) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_throttle_dirty_sync_timer(true);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
If you have the guard to skip the 1st sync in the timer fn(), IIUC you can<=
br>
move this earlier to e.g. migration_thread() before iteration starts.<br>
Otherwise it&#39;ll be not as clear on when this timer will start if it hid=
es<br>
in the sync path itself.<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* The following detection logic can be refin=
ed later. For now:<br>
&gt; @@ -1031,7 +1036,7 @@ static void migration_trigger_throttle(RAMState =
*rs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if ((bytes_dirty_period &gt; bytes_dirty_threshold=
) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (++rs-&gt;dirty_rate_high_cnt &gt;=
=3D 2)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rs-&gt;dirty_rate_high_cnt =3D 0;<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (migrate_auto_converge()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (auto_converge) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_migration_thrott=
le();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mig_throttle_guest_dow=
n(bytes_dirty_period,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_dirty_=
threshold);<br>
&gt; @@ -1088,7 +1093,7 @@ static void migration_bitmap_sync(RAMState *rs, =
bool last_stage)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static void migration_bitmap_sync_precopy(bool last_stage)<br>
&gt; +void migration_bitmap_sync_precopy(bool last_stage)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 assert(ram_state);<br>
&gt; diff --git a/migration/trace-events b/migration/trace-events<br>
&gt; index 9a19599804..0638183056 100644<br>
&gt; --- a/migration/trace-events<br>
&gt; +++ b/migration/trace-events<br>
&gt; @@ -381,3 +381,4 @@ migration_pagecache_insert(void) &quot;Error alloc=
ating page&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # cpu-throttle.c<br>
&gt;=C2=A0 cpu_throttle_set(int new_throttle_pct)=C2=A0 &quot;set guest CPU=
 throttled by %d%%&quot;<br>
&gt; +cpu_throttle_dirty_sync(void) &quot;&quot;<br>
&gt; -- <br>
&gt; 2.27.0<br>
&gt; <br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><div><br></div><div style=3D"font-family:&quot;comic san=
s ms&quot;,sans-serif" class=3D"gmail_default">All the comments above are a=
dvisable, thanks Peter, I&#39;ll try it in the next version.</div><br clear=
=3D"all"><div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f" class=3D"gmail_default">Yong</div><br></div><span class=3D"gmail_signatu=
re_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div di=
r=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font></div=
></div></div>

--000000000000407b750624a432b9--

