Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8310FCEB2D6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 02:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svSEX-0008F8-Bm; Mon, 30 Sep 2024 22:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1svSER-0008EP-4N
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 22:03:20 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1svSEN-0003EX-3a
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 22:03:18 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-710d77380cdso2916449a34.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 19:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1727748190; x=1728352990;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/0pNSxsay1RDXulJlGfwlcVYY68tNgK5KK8aI9s85QY=;
 b=AWeNcaWpz+0TFiZQY2iq1flBbPHgYjvdMwHmvrp7w32F2eBtO7k2SksriA6logR/pE
 0deyuMkpXE2Tl1QezeUfxboYCnPjP2ZageWbPcFwXGCDvhqSSCzjjIg93Rz5D/csxXe9
 7MPEQmzBsbnUrQIkpfTcuswa0xZMVBlIiHEdnRZs3Ui1nTf06V2cZ1JEAyt+dfKMw43x
 9nIrekEvsmjKfzWeUYeLbCdLgwa1cccHtBoa5U2egxI/HrIvDyYpbW4chIvRRkBMtrgB
 DTsaR7JOleQbmiugK+45tI0rbIbayNt54DKhMrkS5EdH1ljd/JY78fXbrlhLPesx0tZ5
 i0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727748190; x=1728352990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/0pNSxsay1RDXulJlGfwlcVYY68tNgK5KK8aI9s85QY=;
 b=tJKWV2kpyUhq/TEd8YEl7JLoY5Wusa4IsJlN/cexE6xk0hYE23Q+0/60NPpeLcQ8cC
 a6xp3+JAJY+65FTNQGpvEAFX+7tdwW8LHR6OiKgxPSXYGZWrn1caDnXXbl58wxkFXXSN
 QAgC19PH8PPSv2KC2Jnw/l4Wot5UXsPNNqRTQqRAPmnZNI8AzNV4xPuaXBzTB6aX8MHk
 HU6mBFxl0v5LW9H67RQskntSPZOm1vR7AT4QYRRZeIzXHueURlfgZkIR9/oEXQ7NTH6s
 thCRGFVUADHeQDbuwtuK6Xp2SNCwYzwvWkJ2m7bgE3VWit9ucp4tcuf26SlvxAujEHeC
 wbZQ==
X-Gm-Message-State: AOJu0Yy+YDqwAw+pNPD1OqbBjpwuLzXsoGzl9W4oLOb0wzvHrMKDWA0y
 EwiXW6L6EeHWyCi6ydchShUq0TEV3/D/gXOxwhiwgQmqEwitHvjPjEadz7uVQFP0bdUU+O8cT9/
 iK1pTsAhP4Vk8l0Zu4gg5Y9qdar3OS/cLcipaoA==
X-Google-Smtp-Source: AGHT+IHkuyazSZ06+XPdptAQ9/f7tshacMPSKZw0B0g0AWlsODLtnqqNJeudhHVfsJpiBjEG0alxEY+Up5fIctTDNbo=
X-Received: by 2002:a05:6870:b152:b0:278:986:1e44 with SMTP id
 586e51a60fabf-28710a2f27bmr8854230fac.18.1727748189059; Mon, 30 Sep 2024
 19:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727630000.git.yong.huang@smartx.com>
 <f36590f60307ce9647d3506e55dcbc2405c98ee2.1727630000.git.yong.huang@smartx.com>
 <ZvsM8LObQlYy6H_O@x1n>
In-Reply-To: <ZvsM8LObQlYy6H_O@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 1 Oct 2024 10:02:53 +0800
Message-ID: <CAK9dgmY+88dsg+=rqaWy_E0KX7qyCcr-r4DX8ATyRYB_QOw0WQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] migration: Support background ramblock dirty sync
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000121397062360b90c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x32c.google.com
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

--000000000000121397062360b90c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:41=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Mon, Sep 30, 2024 at 01:14:26AM +0800, yong.huang@smartx.com wrote:
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > When VM is configured with huge memory, the current throttle logic
> > doesn't look like to scale, because migration_trigger_throttle()
> > is only called for each iteration, so it won't be invoked for a long
> > time if one iteration can take a long time.
> >
> > The background dirty sync aim to fix the above issue by synchronizing
> > the ramblock from remote dirty bitmap and, when necessary, triggering
> > the CPU throttle multiple times during a long iteration.
> >
> > This is a trade-off between synchronization overhead and CPU throttle
> > impact.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  include/migration/misc.h     |  3 ++
> >  migration/migration.c        | 11 +++++++
> >  migration/ram.c              | 64 ++++++++++++++++++++++++++++++++++++
> >  migration/ram.h              |  3 ++
> >  migration/trace-events       |  1 +
> >  system/cpu-timers.c          |  2 ++
> >  tests/qtest/migration-test.c | 29 ++++++++++++++++
> >  7 files changed, 113 insertions(+)
> >
> > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > index bfadc5613b..67c00d98f5 100644
> > --- a/include/migration/misc.h
> > +++ b/include/migration/misc.h
> > @@ -111,4 +111,7 @@ bool migration_in_bg_snapshot(void);
> >  /* migration/block-dirty-bitmap.c */
> >  void dirty_bitmap_mig_init(void);
> >
> > +/* migration/ram.c */
> > +void bg_ram_dirty_sync_init(void);
>
> IMO it's better we don't add this logic to ram.c as I mentioned.  It's
> closely relevant to auto converge so I think cpu-throttle.c is more
> suitable.


> > +
> >  #endif
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 3dea06d577..224b5dfb4f 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3285,6 +3285,9 @@ static void
> migration_iteration_finish(MigrationState *s)
> >  {
> >      /* If we enabled cpu throttling for auto-converge, turn it off. */
> >      cpu_throttle_stop();
> > +    if (migrate_auto_converge()) {
> > +        bg_ram_dirty_sync_timer_enable(false);
> > +    }
>
> Please avoid adding this code.  When it's part of auto-converge,
> cpu_throttle_stop() should already guarantee that timer disabled
> altogether.


> >
> >      bql_lock();
> >      switch (s->state) {
> > @@ -3526,6 +3529,14 @@ static void *migration_thread(void *opaque)
> >
> >      trace_migration_thread_setup_complete();
> >
> > +    /*
> > +     * Tick the background ramblock dirty sync timer after setup
> > +     * phase.
> > +     */
> > +    if (migrate_auto_converge()) {
> > +        bg_ram_dirty_sync_timer_enable(true);
> > +    }
>
> Might be good to still stick the enablement with auto-converge; the latte=
r
> was done in migration_trigger_throttle().  Maybe also enable the timer on=
ly
> there?
>

Ok.


> > +
> >      while (migration_is_active()) {
> >          if (urgent || !migration_rate_exceeded(s->to_dst_file)) {
> >              MigIterateState iter_state =3D migration_iteration_run(s);
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 67ca3d5d51..995bae1ac9 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -110,6 +110,12 @@
> >   */
> >  #define MAPPED_RAM_LOAD_BUF_SIZE 0x100000
> >
> > +/* Background ramblock dirty sync trigger every five seconds */
> > +#define BG_RAM_SYNC_TIMESLICE_MS 5000
> > +#define BG_RAM_SYNC_TIMER_INTERVAL_MS 1000
>
> Why this timer needs to be invoked every 1sec, if it's a 5sec timer?
>

The logic is stupid :(, I'll fix that.


> > +
> > +static QEMUTimer *bg_ram_dirty_sync_timer;
> > +
> >  XBZRLECacheStats xbzrle_counters;
> >
> >  /* used by the search for pages to send */
> > @@ -4543,6 +4549,64 @@ static void
> ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
> >      }
> >  }
> >
> > +static void bg_ram_dirty_sync_timer_tick(void *opaque)
>
> Please consider moving this function to cpu-throttle.c.
>

Yes, I got your idea, but, IMHO, the cpu-throttle.c only implements the CPU
throttle, not the ramblock dirty sync, the migration_bitmap_sync_precopy
could or should not be called in the cpu-throttle.c.Do we want to change
this code level?

Another way is we define the bg_ram_dirty_sync_timer in cpu-throttle.c
and modify it in bg_ram_dirty_sync_timer_tick as a extern variable in ram.c
I prefer the latter, What do you think of it?


>
> Also please prefix the functions with cpu_throttle_*(), rather than bg_*(=
).
> It should be part of auto converge function.
>
> > +{
> > +    static int prev_pct;
> > +    static uint64_t prev_sync_cnt =3D 2;
> > +    uint64_t sync_cnt =3D stat64_get(&mig_stats.dirty_sync_count);
> > +    int cur_pct =3D cpu_throttle_get_percentage();
> > +
> > +    if (prev_pct && !cur_pct) {
> > +        /* CPU throttle timer stopped, so do we */
> > +        return;
> > +    }
>
> Didn't follow why this is not needed if cpu throttle is 0.
>

The sequence in my head is:

bg dirty sync -> mig_throttle_guest_down -> throttle -> throttle stop-> bg
dirty sync stop

The bg dirty sync may be invoked before throttle, and
the throttle is also 0 at that time, if we code like:

if (!cpu_throttle_get_percentage()) {
    return;
}

The bg dirty sync timer can tick only once and stop.

If we change the sequence as following, we can ignore this case:

mig_throttle_guest_down -> bg dirty sync -> throttle -> throttle stop-> bg
dirty sync stop

But as the code in migration_trigger_throttle indicate:

  if ((bytes_dirty_period > bytes_dirty_threshold) &&
        ++rs->dirty_rate_high_cnt >=3D 2) {
     ...
  }

Since the 1st iteration can not satisfy the condition rs->dirty_rate_high_c=
nt
>=3D 2
as usual, the mig_throttle_guest_down gets invoked in 3nd iteration with
high
probability. If the 2nd iteration is very long, the bg dirty sync can not
be invoked and
we may lose the chance to trigger CPU throttle as I mentioned.


> It means dirty rate is probably very low, but then shouldn't this
> background sync still working (just to notice it grows again)?
>
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
> > +        int64_t curr_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > +        assert(ram_state);
> > +        if ((curr_time - ram_state->time_last_bitmap_sync) >
> > +            BG_RAM_SYNC_TIMESLICE_MS) {
> > +            trace_bg_ram_dirty_sync();
> > +            WITH_RCU_READ_LOCK_GUARD() {
> > +                migration_bitmap_sync_precopy(ram_state, false);
> > +            }
> > +        }
> > +    }
> > +
> > +end:
> > +    prev_sync_cnt =3D stat64_get(&mig_stats.dirty_sync_count);
> > +    prev_pct =3D cpu_throttle_get_percentage();
> > +
> > +    timer_mod(bg_ram_dirty_sync_timer,
> > +        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
> > +            BG_RAM_SYNC_TIMER_INTERVAL_MS);
>
> IIUC we only need to fire per 5sec, not 1s?
>

Thanks to point out, I'll refine this logic.


>
> > +}
> > +
> > +void bg_ram_dirty_sync_timer_enable(bool enable)
> > +{
> > +    if (enable) {
> > +        bg_ram_dirty_sync_timer_tick(NULL);
> > +    } else {
> > +        timer_del(bg_ram_dirty_sync_timer);
> > +    }
> > +}
> > +
> > +void bg_ram_dirty_sync_init(void)
> > +{
> > +    bg_ram_dirty_sync_timer =3D
> > +        timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
> > +                     bg_ram_dirty_sync_timer_tick, NULL);
> > +}
>
> IMHO all these functions should move to cpu-throttle.c.
>
> > +
> >  static RAMBlockNotifier ram_mig_ram_notifier =3D {
> >      .ram_block_resized =3D ram_mig_ram_block_resized,
> >  };
> > diff --git a/migration/ram.h b/migration/ram.h
> > index bc0318b834..9c1a2f30f1 100644
> > --- a/migration/ram.h
> > +++ b/migration/ram.h
> > @@ -93,4 +93,7 @@ void ram_write_tracking_prepare(void);
> >  int ram_write_tracking_start(void);
> >  void ram_write_tracking_stop(void);
> >
> > +/* Background ramblock dirty sync */
> > +void bg_ram_dirty_sync_timer_enable(bool enable);
> > +
> >  #endif
> > diff --git a/migration/trace-events b/migration/trace-events
> > index c65902f042..3f09e7f383 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -90,6 +90,7 @@ put_qlist_end(const char *field_name, const char
> *vmsd_name) "%s(%s)"
> >  qemu_file_fclose(void) ""
> >
> >  # ram.c
> > +bg_ram_dirty_sync(void) ""
> >  get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned
> long page_abs) "%s/0x%" PRIx64 " page_abs=3D0x%lx"
> >  get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset,
> unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=3D0x%lx"
> >  migration_bitmap_sync_start(void) ""
> > diff --git a/system/cpu-timers.c b/system/cpu-timers.c
> > index 0b31c9a1b6..64f0834be4 100644
> > --- a/system/cpu-timers.c
> > +++ b/system/cpu-timers.c
> > @@ -25,6 +25,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/cutils.h"
> >  #include "migration/vmstate.h"
> > +#include "migration/misc.h"
> >  #include "qapi/error.h"
> >  #include "qemu/error-report.h"
> >  #include "sysemu/cpus.h"
> > @@ -274,4 +275,5 @@ void cpu_timers_init(void)
> >      vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
> >
> >      cpu_throttle_init();
> > +    bg_ram_dirty_sync_init();
> >  }
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.=
c
> > index d6768d5d71..3296f5244d 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -468,6 +468,12 @@ static void migrate_ensure_converge(QTestState *wh=
o)
> >      migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
> >  }
> >
> > +static void migrate_ensure_iteration_last_long(QTestState *who)
> > +{
> > +    /* Set 10Byte/s bandwidth limit to make the iteration last long
> enough */
> > +    migrate_set_parameter_int(who, "max-bandwidth", 10);
> > +}
> > +
> >  /*
> >   * Our goal is to ensure that we run a single full migration
> >   * iteration, and also dirty memory, ensuring that at least
> > @@ -2791,6 +2797,7 @@ static void test_migrate_auto_converge(void)
> >       * so we need to decrease a bandwidth.
> >       */
> >      const int64_t init_pct =3D 5, inc_pct =3D 25, max_pct =3D 95;
> > +    uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
> >
> >      if (test_migrate_start(&from, &to, uri, &args)) {
> >          return;
> > @@ -2827,6 +2834,28 @@ static void test_migrate_auto_converge(void)
> >      } while (true);
> >      /* The first percentage of throttling should be at least init_pct =
*/
> >      g_assert_cmpint(percentage, >=3D, init_pct);
> > +
> > +    /* Make sure the iteration last a long time enough */
> > +    migrate_ensure_iteration_last_long(from);
>
> There's already migrate_ensure_non_converge(), why this is needed?
>

I'm feeling that migrate_ensure_non_converge cannot ensure the
iteration lasts greater than 5s, so i and an extra util function.


> > +
> > +    /*
> > +     * End the loop when the dirty sync count greater than 1.
> > +     */
> > +    while ((dirty_sync_cnt =3D get_migration_pass(from)) < 2) {
> > +        usleep(1000 * 1000);
> > +    }
> > +
> > +    prev_dirty_sync_cnt =3D dirty_sync_cnt;
> > +
> > +    /*
> > +     * The dirty sync count must changes in 5 seconds, here we
> > +     * plus 1 second as error value.
> > +     */
> > +    sleep(5 + 1);
> > +
> > +    dirty_sync_cnt =3D get_migration_pass(from);
> > +    g_assert_cmpint(dirty_sync_cnt, !=3D , prev_dirty_sync_cnt);
> > +
> >      /* Now, when we tested that throttling works, let it converge */
> >      migrate_ensure_converge(from);
>
> Please move the test change into a separate patch.  I had a feeling 5+1 s=
ec
> might still easily fail on CIs (even though this test is not yet run).
> Maybe it needs to still provide a loop so it waits for a few rounds just =
in
> case.
>

OK.


>
> Thanks,
>
> --
> Peter Xu
>
>
Thanks,
Yong

--=20
Best regards

--000000000000121397062360b90c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 1, 202=
4 at 4:41=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pete=
rx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;border-left-color:rgb(204,204,204);padding-left:1ex">On Mon, Sep 30, 2024=
 at 01:14:26AM +0800, <a href=3D"mailto:yong.huang@smartx.com" target=3D"_b=
lank">yong.huang@smartx.com</a> wrote:<br>
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
&gt; The background dirty sync aim to fix the above issue by synchronizing<=
br>
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
&gt;=C2=A0 include/migration/misc.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++<br>
&gt;=C2=A0 migration/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 +++++++<br=
>
&gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 64 ++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 migration/ram.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 3 ++<br>
&gt;=C2=A0 migration/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 system/cpu-timers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 =
++<br>
&gt;=C2=A0 tests/qtest/migration-test.c | 29 ++++++++++++++++<br>
&gt;=C2=A0 7 files changed, 113 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/migration/misc.h b/include/migration/misc.h<br>
&gt; index bfadc5613b..67c00d98f5 100644<br>
&gt; --- a/include/migration/misc.h<br>
&gt; +++ b/include/migration/misc.h<br>
&gt; @@ -111,4 +111,7 @@ bool migration_in_bg_snapshot(void);<br>
&gt;=C2=A0 /* migration/block-dirty-bitmap.c */<br>
&gt;=C2=A0 void dirty_bitmap_mig_init(void);<br>
&gt;=C2=A0 <br>
&gt; +/* migration/ram.c */<br>
&gt; +void bg_ram_dirty_sync_init(void);<br>
<br>
IMO it&#39;s better we don&#39;t add this logic to ram.c as I mentioned.=C2=
=A0 It&#39;s<br>
closely relevant to auto converge so I think cpu-throttle.c is more<br>
suitable.</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-co=
lor:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/migration/migration.c b/migration/migration.c<br>
&gt; index 3dea06d577..224b5dfb4f 100644<br>
&gt; --- a/migration/migration.c<br>
&gt; +++ b/migration/migration.c<br>
&gt; @@ -3285,6 +3285,9 @@ static void migration_iteration_finish(Migration=
State *s)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* If we enabled cpu throttling for auto-converge,=
 turn it off. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu_throttle_stop();<br>
&gt; +=C2=A0 =C2=A0 if (migrate_auto_converge()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bg_ram_dirty_sync_timer_enable(false);<br=
>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Please avoid adding this code.=C2=A0 When it&#39;s part of auto-converge,<b=
r>
cpu_throttle_stop() should already guarantee that timer disabled<br>
altogether.=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border=
-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 bql_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (s-&gt;state) {<br>
&gt; @@ -3526,6 +3529,14 @@ static void *migration_thread(void *opaque)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 trace_migration_thread_setup_complete();<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Tick the background ramblock dirty sync timer a=
fter setup<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* phase.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (migrate_auto_converge()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bg_ram_dirty_sync_timer_enable(true);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Might be good to still stick the enablement with auto-converge; the latter<=
br>
was done in migration_trigger_throttle().=C2=A0 Maybe also enable the timer=
 only<br>
there?<br></blockquote><div><br></div><div><div style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif" class=3D"gmail_default">Ok.</div></div><div=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204=
,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 while (migration_is_active()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (urgent || !migration_rate_exceed=
ed(s-&gt;to_dst_file)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MigIterateState iter_s=
tate =3D migration_iteration_run(s);<br>
&gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; index 67ca3d5d51..995bae1ac9 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -110,6 +110,12 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #define MAPPED_RAM_LOAD_BUF_SIZE 0x100000<br>
&gt;=C2=A0 <br>
&gt; +/* Background ramblock dirty sync trigger every five seconds */<br>
&gt; +#define BG_RAM_SYNC_TIMESLICE_MS 5000<br>
&gt; +#define BG_RAM_SYNC_TIMER_INTERVAL_MS 1000<br>
<br>
Why this timer needs to be invoked every 1sec, if it&#39;s a 5sec timer?<br=
></blockquote><div><br></div><div><div style=3D"font-family:&quot;comic san=
s ms&quot;,sans-serif" class=3D"gmail_default">The logic is stupid :(, I&#3=
9;ll fix that.</div></div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:s=
olid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +static QEMUTimer *bg_ram_dirty_sync_timer;<br>
&gt; +<br>
&gt;=C2=A0 XBZRLECacheStats xbzrle_counters;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* used by the search for pages to send */<br>
&gt; @@ -4543,6 +4549,64 @@ static void ram_mig_ram_block_resized(RAMBlockN=
otifier *n, void *host,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void bg_ram_dirty_sync_timer_tick(void *opaque)<br>
<br>
Please consider moving this function to cpu-throttle.c.<br></blockquote><di=
v><br></div><div><div><div class=3D"gmail_default" style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif">Yes, I got your idea, but, IMHO, the cpu=
-throttle.c only implements the CPU=C2=A0</div><div class=3D"gmail_default"=
 style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">throttle, not t=
he ramblock dirty sync, the=C2=A0migration_bitmap_sync_precopy</div><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif">could or should not be called in the <a href=3D"http://cpu-throttle.c=
.Do">cpu-throttle.c.Do</a> we want to change</div></div><div><div class=3D"=
gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">t=
his code level?</div><div class=3D"gmail_default" style=3D"font-family:&quo=
t;comic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Another way is we =
define the=C2=A0bg_ram_dirty_sync_timer in cpu-throttle.c</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">and modify it in=C2=A0bg_ram_dirty_sync_timer_tick as a extern variable =
in ram.c</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic=
 sans ms&quot;,sans-serif"></div></div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">I prefer the=C2=A0lat=
ter, What do you think of it?</div></div><div>=C2=A0<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1=
ex">
<br>
Also please prefix the functions with cpu_throttle_*(), rather than bg_*().=
<br>
It should be part of auto converge function.<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 static int prev_pct;<br>
&gt; +=C2=A0 =C2=A0 static uint64_t prev_sync_cnt =3D 2;<br>
&gt; +=C2=A0 =C2=A0 uint64_t sync_cnt =3D stat64_get(&amp;mig_stats.dirty_s=
ync_count);<br>
&gt; +=C2=A0 =C2=A0 int cur_pct =3D cpu_throttle_get_percentage();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (prev_pct &amp;&amp; !cur_pct) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* CPU throttle timer stopped, so do we *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Didn&#39;t follow why this is not needed if cpu throttle is 0.<br></blockqu=
ote><div><br></div><div><div style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif" class=3D"gmail_default">The sequence in my head is:</div><div =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_d=
efault"><br></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif" class=3D"gmail_default">bg dirty sync -&gt;=C2=A0mig_throttle_guest_=
down -&gt; throttle -&gt; throttle stop-&gt; bg dirty sync stop</div><br></=
div><div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" cl=
ass=3D"gmail_default">The bg dirty=C2=A0sync may be invoked before throttle=
, and</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" =
class=3D"gmail_default">the throttle is also 0 at that time, if we code lik=
e:</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" cla=
ss=3D"gmail_default"><br></div><div class=3D"gmail_default"><font face=3D"c=
omic sans ms, sans-serif">if (!cpu_throttle_get_percentage()) {</font></div=
><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=C2=
=A0 =C2=A0 return;</font></div><div class=3D"gmail_default"><font face=3D"c=
omic sans ms, sans-serif">}</font></div><div class=3D"gmail_default"><font =
face=3D"comic sans ms, sans-serif"><br></font></div><div class=3D"gmail_def=
ault"><font face=3D"comic sans ms, sans-serif">The=C2=A0</font><span style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">bg dirty sync</span><=
span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">=C2=A0timer=
 can tick only once and stop.</span></div><br></div><div style=3D"font-fami=
ly:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">If we chan=
ge the sequence as following, we can ignore this case:</div><div style=3D"f=
ont-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><b=
r></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" cla=
ss=3D"gmail_default">mig_throttle_guest_down -&gt; bg dirty sync -&gt; thro=
ttle -&gt; throttle stop-&gt; bg dirty sync stop<br></div><div style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><br>=
</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default">But as the code in=C2=A0migration_trigger_throttle indic=
ate:</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" c=
lass=3D"gmail_default"><br></div><div style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif" class=3D"gmail_default">=C2=A0 if ((bytes_dirty_perio=
d &gt; bytes_dirty_threshold) &amp;&amp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ++r=
s-&gt;dirty_rate_high_cnt &gt;=3D 2) {</div><div style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif" class=3D"gmail_default">=C2=A0 =C2=A0 =C2=
=A0...</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"=
 class=3D"gmail_default">=C2=A0 }<br></div><div style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defau=
lt"><span class=3D"gmail-Apple-converted-space">Since the 1st iteration can=
 not satisfy the condition </span>rs-&gt;dirty_rate_high_cnt &gt;=3D 2</div=
><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"g=
mail_default">as usual, the mig_throttle_guest_down gets invoked in 3nd ite=
ration with high</div><div style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif" class=3D"gmail_default">probability. If the 2nd iteration is ver=
y long, the=C2=A0bg dirty sync can not be invoked and</div><div style=3D"fo=
nt-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">we =
may lose the chance to trigger CPU=C2=A0throttle as I mentioned.</div><div =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_d=
efault"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:=
rgb(204,204,204);padding-left:1ex">
<br>
It means dirty rate is probably very low, but then shouldn&#39;t this<br>
background sync still working (just to notice it grows again)?<br>
<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t curr_time =3D qemu_clock_get_ms(Q=
EMU_CLOCK_REALTIME);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ram_state);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((curr_time - ram_state-&gt;time_last_=
bitmap_sync) &gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BG_RAM_SYNC_TIMESLICE_MS) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_bg_ram_dirty_sync();<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WITH_RCU_READ_LOCK_GUARD() =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_bit=
map_sync_precopy(ram_state, false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +end:<br>
&gt; +=C2=A0 =C2=A0 prev_sync_cnt =3D stat64_get(&amp;mig_stats.dirty_sync_=
count);<br>
&gt; +=C2=A0 =C2=A0 prev_pct =3D cpu_throttle_get_percentage();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 timer_mod(bg_ram_dirty_sync_timer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) =
+<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BG_RAM_SYNC_TIMER_INTERVAL_=
MS);<br>
<br>
IIUC we only need to fire per 5sec, not 1s?<br></blockquote><div><br></div>=
<div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default">Thanks to point out, I&#39;ll refine this logic.</div></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-col=
or:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +}<br>
&gt; +<br>
&gt; +void bg_ram_dirty_sync_timer_enable(bool enable)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (enable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bg_ram_dirty_sync_timer_tick(NULL);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(bg_ram_dirty_sync_timer);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +void bg_ram_dirty_sync_init(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bg_ram_dirty_sync_timer =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bg_ram_dirty_sync_timer_tick, NULL);<br>
&gt; +}<br>
<br>
IMHO all these functions should move to cpu-throttle.c.<br>
<br>
&gt; +<br>
&gt;=C2=A0 static RAMBlockNotifier ram_mig_ram_notifier =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .ram_block_resized =3D ram_mig_ram_block_resized,<=
br>
&gt;=C2=A0 };<br>
&gt; diff --git a/migration/ram.h b/migration/ram.h<br>
&gt; index bc0318b834..9c1a2f30f1 100644<br>
&gt; --- a/migration/ram.h<br>
&gt; +++ b/migration/ram.h<br>
&gt; @@ -93,4 +93,7 @@ void ram_write_tracking_prepare(void);<br>
&gt;=C2=A0 int ram_write_tracking_start(void);<br>
&gt;=C2=A0 void ram_write_tracking_stop(void);<br>
&gt;=C2=A0 <br>
&gt; +/* Background ramblock dirty sync */<br>
&gt; +void bg_ram_dirty_sync_timer_enable(bool enable);<br>
&gt; +<br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/migration/trace-events b/migration/trace-events<br>
&gt; index c65902f042..3f09e7f383 100644<br>
&gt; --- a/migration/trace-events<br>
&gt; +++ b/migration/trace-events<br>
&gt; @@ -90,6 +90,7 @@ put_qlist_end(const char *field_name, const char *vm=
sd_name) &quot;%s(%s)&quot;<br>
&gt;=C2=A0 qemu_file_fclose(void) &quot;&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # ram.c<br>
&gt; +bg_ram_dirty_sync(void) &quot;&quot;<br>
&gt;=C2=A0 get_queued_page(const char *block_name, uint64_t tmp_offset, uns=
igned long page_abs) &quot;%s/0x%&quot; PRIx64 &quot; page_abs=3D0x%lx&quot=
;<br>
&gt;=C2=A0 get_queued_page_not_dirty(const char *block_name, uint64_t tmp_o=
ffset, unsigned long page_abs) &quot;%s/0x%&quot; PRIx64 &quot; page_abs=3D=
0x%lx&quot;<br>
&gt;=C2=A0 migration_bitmap_sync_start(void) &quot;&quot;<br>
&gt; diff --git a/system/cpu-timers.c b/system/cpu-timers.c<br>
&gt; index 0b31c9a1b6..64f0834be4 100644<br>
&gt; --- a/system/cpu-timers.c<br>
&gt; +++ b/system/cpu-timers.c<br>
&gt; @@ -25,6 +25,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/cutils.h&quot;<br>
&gt;=C2=A0 #include &quot;migration/vmstate.h&quot;<br>
&gt; +#include &quot;migration/misc.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/error-report.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/cpus.h&quot;<br>
&gt; @@ -274,4 +275,5 @@ void cpu_timers_init(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vmstate_register(NULL, 0, &amp;vmstate_timers, &am=
p;timers_state);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu_throttle_init();<br>
&gt; +=C2=A0 =C2=A0 bg_ram_dirty_sync_init();<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test=
.c<br>
&gt; index d6768d5d71..3296f5244d 100644<br>
&gt; --- a/tests/qtest/migration-test.c<br>
&gt; +++ b/tests/qtest/migration-test.c<br>
&gt; @@ -468,6 +468,12 @@ static void migrate_ensure_converge(QTestState *w=
ho)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 migrate_set_parameter_int(who, &quot;downtime-limi=
t&quot;, 30 * 1000);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void migrate_ensure_iteration_last_long(QTestState *who)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* Set 10Byte/s bandwidth limit to make the iteration l=
ast long enough */<br>
&gt; +=C2=A0 =C2=A0 migrate_set_parameter_int(who, &quot;max-bandwidth&quot=
;, 10);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Our goal is to ensure that we run a single full migratio=
n<br>
&gt;=C2=A0 =C2=A0* iteration, and also dirty memory, ensuring that at least=
<br>
&gt; @@ -2791,6 +2797,7 @@ static void test_migrate_auto_converge(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* so we need to decrease a bandwidth.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 const int64_t init_pct =3D 5, inc_pct =3D 25, max_=
pct =3D 95;<br>
&gt; +=C2=A0 =C2=A0 uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (test_migrate_start(&amp;from, &amp;to, uri, &a=
mp;args)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; @@ -2827,6 +2834,28 @@ static void test_migrate_auto_converge(void)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 } while (true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* The first percentage of throttling should be at=
 least init_pct */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(percentage, &gt;=3D, init_pct);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Make sure the iteration last a long time enough */<b=
r>
&gt; +=C2=A0 =C2=A0 migrate_ensure_iteration_last_long(from);<br>
<br>
There&#39;s already migrate_ensure_non_converge(), why this is needed?<br><=
/blockquote><div><br></div><div><div class=3D"gmail_default"><span style=3D=
"font-family:&quot;comic sans ms&quot;,sans-serif">I&#39;m feeling that</sp=
an><font face=3D"comic sans ms, sans-serif">=C2=A0migrate_ensure_non_conver=
ge cannot ensure the</font></div><div class=3D"gmail_default"><font face=3D=
"comic sans ms, sans-serif">iteration lasts greater than 5s, so i and an ex=
tra util function.</font></div></div><div class=3D"gmail_default"><font fac=
e=3D"comic sans ms, sans-serif"><br></font></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* End the loop when the dirty sync count greater =
than 1.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 while ((dirty_sync_cnt =3D get_migration_pass(from)) &l=
t; 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usleep(1000 * 1000);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 prev_dirty_sync_cnt =3D dirty_sync_cnt;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The dirty sync count must changes in 5 seconds,=
 here we<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* plus 1 second as error value.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 sleep(5 + 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dirty_sync_cnt =3D get_migration_pass(from);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpint(dirty_sync_cnt, !=3D , prev_dirty_sync_=
cnt);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Now, when we tested that throttling works, let =
it converge */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 migrate_ensure_converge(from);<br>
<br>
Please move the test change into a separate patch.=C2=A0 I had a feeling 5+=
1 sec<br>
might still easily fail on CIs (even though this test is not yet run).<br>
Maybe it needs to still provide a loop so it waits for a few rounds just in=
<br>
case.<br></blockquote><div><br></div><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">OK.</div></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(20=
4,204,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks,</div><div st=
yle=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_def=
ault">Yong</div></div><div><br></div><span class=3D"gmail_signature_prefix"=
>-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">=
<font face=3D"comic sans ms, sans-serif">Best regards</font></div></div></d=
iv>

--000000000000121397062360b90c--

