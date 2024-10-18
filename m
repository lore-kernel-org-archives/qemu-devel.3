Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B97AD3C53F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 01:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1cE3-0004sv-Ej; Thu, 17 Oct 2024 21:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1cDw-0004sT-T0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 21:56:17 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1cDu-0002WH-1y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 21:56:16 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-28896d9d9deso675081fac.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 18:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729216571; x=1729821371;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c1TJj7pRuR03Zeqg5G2OXt8yqceVwXb1wQPnqDBXCzI=;
 b=Xyl5r9F+RlqzzOuxzEdPPh2yCbfDl2JHJykgh6lrSlDpQB7eewg3nmI1VmzRuZQVfC
 iEaAZGj2ZgHnvmbPgrtP7anUZZH6DDvZl4FSJ/0Sg+RWVwdwAcadaCr7oMA11/Jwks9n
 P7jsSMD5wBMws556MUdg611wi/bfZtQtFV8AfxpReNffz7zfoxTjzcG5ugNUYTkWwwNU
 +WpOj+KbcJVIiG8IE1TEVq2y8xEBrWQtnkDlai1gpzPo4qJH/WE41N8pPATh85n+Grqo
 EwtYXEeBzPJ1a6jQKf/0c1wJ6lNTL5bUKeZQAaP4UpZ+gcuMffqUbojauynj/qXybIys
 seFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729216571; x=1729821371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c1TJj7pRuR03Zeqg5G2OXt8yqceVwXb1wQPnqDBXCzI=;
 b=V4HiNL46X/47QtUvuo6rtpzE0TEJdTqacs58ewFkmFftSExyTIWOAOuEcblVe7WkeT
 FyvJN9NLGWOMkqOYIE/WEtjKlPNCcDC7hdxF+sp+kE/HSDdwv7XxwowUDqlefFSMp6vr
 cOxnOf/hPF/o9e5wEGs/7/AbzWyJ67mHQrD70AwOG6cLiA0+smzctFi0hM3Rer3nue7I
 ooGRQHIPWqV2dT2ExB0lrDrFAECztNC3fI1R0uMwlmLP831FCAQvjnmAr/88iojbfbbO
 GjOPRrSMd75zOB2PKq6Bm7ZKtBoYB0r+/9lIng2rSY8gW4fKH777rX5wMpTESxbb5a4+
 L7Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSXa4h0J4I1F/OAvtLXlmVYWX7/lS+7hYP0knlUGFDMuul7nq0vxPHBWBMpIZBaW9rP3B+JZb+bNZ7@nongnu.org
X-Gm-Message-State: AOJu0Yyo4pHAx2kO7gGaALoVm869psmmb2+gdg0pOXrocpP/qDGATqai
 rXAp3Ll0RIzKrf/YdgCrtwoj0645pEXqdrNzfem2XVhixzR6JmTlSbYBxAvQgHeKzLFl+MVzdk+
 aI8bxRcPMf818leTYroCU9kGhtYmqf73zgeYKGg==
X-Google-Smtp-Source: AGHT+IEw6TQNZgVEq5tmCD00+FkqmhVCSbK7tAsZT0r7L5YZzJ6B79EO4Vruy8Pqb9mJkMS2de2xLqC764dcaLi0atA=
X-Received: by 2002:a05:6870:80d4:b0:27b:583b:bfc2 with SMTP id
 586e51a60fabf-2892bf07a8cmr906086fac.0.1729216570919; Thu, 17 Oct 2024
 18:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729146786.git.yong.huang@smartx.com>
 <f61f1b3653f2acf026901103e1c73d157d38b08f.1729146786.git.yong.huang@smartx.com>
 <ZxFmnZqgRlGaQax_@x1n>
In-Reply-To: <ZxFmnZqgRlGaQax_@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 18 Oct 2024 09:55:55 +0800
Message-ID: <CAK9dgmbeCgAcbzWFGDDGM+yF2hWTaL0J7P5ttDwJMTBGe+tPGw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] migration: Support periodic RAMBlock dirty bitmap
 sync
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000073228c0624b69bc2"
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x30.google.com
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

--00000000000073228c0624b69bc2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:33=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Thu, Oct 17, 2024 at 02:42:54PM +0800, yong.huang@smartx.com wrote:
> > +void cpu_throttle_dirty_sync_timer_tick(void *opaque)
> > +{
> > +    static uint64_t prev_sync_cnt;
>
> We may need to reset this in case migration got cancelled and invoked
> again, to make sure it keeps working in the 2nd run.
>
> > +    uint64_t sync_cnt =3D stat64_get(&mig_stats.dirty_sync_count);
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
>
> Please both of you have a look on whether you agree I squash below into
> this patch when merge:
>

Thanks for the fixup, it looks good to me.


>
> =3D=3D=3D8<=3D=3D=3D
> From 84a2544eab73e35dbd35fed3b1440169915f9aa4 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 17 Oct 2024 15:27:19 -0400
> Subject: [PATCH] fixup! migration: Support periodic RAMBlock dirty bitmap
> sync
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/cpu-throttle.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> index 342681cdd4..3df287d8d3 100644
> --- a/migration/cpu-throttle.c
> +++ b/migration/cpu-throttle.c
> @@ -36,6 +36,7 @@
>  static QEMUTimer *throttle_timer, *throttle_dirty_sync_timer;
>  static unsigned int throttle_percentage;
>  static bool throttle_dirty_sync_timer_active;
> +static uint64_t throttle_dirty_sync_count_prev;
>
>  #define CPU_THROTTLE_PCT_MIN 1
>  #define CPU_THROTTLE_PCT_MAX 99
> @@ -133,7 +134,6 @@ int cpu_throttle_get_percentage(void)
>
>  void cpu_throttle_dirty_sync_timer_tick(void *opaque)
>  {
> -    static uint64_t prev_sync_cnt;
>      uint64_t sync_cnt =3D stat64_get(&mig_stats.dirty_sync_count);
>
>      /*
> @@ -145,7 +145,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
>          goto end;
>      }
>
> -    if (sync_cnt =3D=3D prev_sync_cnt) {
> +    if (sync_cnt =3D=3D throttle_dirty_sync_count_prev) {
>          trace_cpu_throttle_dirty_sync();
>          WITH_RCU_READ_LOCK_GUARD() {
>              migration_bitmap_sync_precopy(false);
> @@ -153,7 +153,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
>      }
>
>  end:
> -    prev_sync_cnt =3D stat64_get(&mig_stats.dirty_sync_count);
> +    throttle_dirty_sync_count_prev =3D
> stat64_get(&mig_stats.dirty_sync_count);
>
>      timer_mod(throttle_dirty_sync_timer,
>          qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
> @@ -171,6 +171,11 @@ void cpu_throttle_dirty_sync_timer(bool enable)
>
>      if (enable) {
>          if (!cpu_throttle_dirty_sync_active()) {
> +            /*
> +             * Always reset the dirty sync count cache, in case migratio=
n
> +             * was cancelled once.
> +             */
> +            throttle_dirty_sync_count_prev =3D 0;
>              timer_mod(throttle_dirty_sync_timer,
>                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
>                      CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
> --
> 2.45.0
>
> --
> Peter Xu
>
>
Acked-by: Hyman Huang <yong.huang@smartx.com>

--=20
Best regards

--00000000000073228c0624b69bc2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 18, 20=
24 at 3:33=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pet=
erx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">On Thu, Oct 17, 202=
4 at 02:42:54PM +0800, <a href=3D"mailto:yong.huang@smartx.com" target=3D"_=
blank">yong.huang@smartx.com</a> wrote:<br>
&gt; +void cpu_throttle_dirty_sync_timer_tick(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 static uint64_t prev_sync_cnt;<br>
<br>
We may need to reset this in case migration got cancelled and invoked<br>
again, to make sure it keeps working in the 2nd run.<br>
<br>
&gt; +=C2=A0 =C2=A0 uint64_t sync_cnt =3D stat64_get(&amp;mig_stats.dirty_s=
ync_count);<br>
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
<br>
Please both of you have a look on whether you agree I squash below into<br>
this patch when merge:<br></blockquote><div><br></div><div><div style=3D"fo=
nt-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Tha=
nks for the fixup, it looks good to me.</div></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-=
left:1ex">
<br>
=3D=3D=3D8&lt;=3D=3D=3D<br>
From 84a2544eab73e35dbd35fed3b1440169915f9aa4 Mon Sep 17 00:00:00 2001<br>
From: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"_blank">p=
eterx@redhat.com</a>&gt;<br>
Date: Thu, 17 Oct 2024 15:27:19 -0400<br>
Subject: [PATCH] fixup! migration: Support periodic RAMBlock dirty bitmap s=
ync<br>
<br>
Signed-off-by: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"=
_blank">peterx@redhat.com</a>&gt;<br>
---<br>
=C2=A0migration/cpu-throttle.c | 11 ++++++++---<br>
=C2=A01 file changed, 8 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c<br>
index 342681cdd4..3df287d8d3 100644<br>
--- a/migration/cpu-throttle.c<br>
+++ b/migration/cpu-throttle.c<br>
@@ -36,6 +36,7 @@<br>
=C2=A0static QEMUTimer *throttle_timer, *throttle_dirty_sync_timer;<br>
=C2=A0static unsigned int throttle_percentage;<br>
=C2=A0static bool throttle_dirty_sync_timer_active;<br>
+static uint64_t throttle_dirty_sync_count_prev;<br>
<br>
=C2=A0#define CPU_THROTTLE_PCT_MIN 1<br>
=C2=A0#define CPU_THROTTLE_PCT_MAX 99<br>
@@ -133,7 +134,6 @@ int cpu_throttle_get_percentage(void)<br>
<br>
=C2=A0void cpu_throttle_dirty_sync_timer_tick(void *opaque)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 static uint64_t prev_sync_cnt;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t sync_cnt =3D stat64_get(&amp;mig_stats.dirty_s=
ync_count);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
@@ -145,7 +145,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (sync_cnt =3D=3D prev_sync_cnt) {<br>
+=C2=A0 =C2=A0 if (sync_cnt =3D=3D throttle_dirty_sync_count_prev) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_cpu_throttle_dirty_sync();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WITH_RCU_READ_LOCK_GUARD() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0migration_bitmap_sync_preco=
py(false);<br>
@@ -153,7 +153,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0end:<br>
-=C2=A0 =C2=A0 prev_sync_cnt =3D stat64_get(&amp;mig_stats.dirty_sync_count=
);<br>
+=C2=A0 =C2=A0 throttle_dirty_sync_count_prev =3D stat64_get(&amp;mig_stats=
.dirty_sync_count);<br>
<br>
=C2=A0 =C2=A0 =C2=A0timer_mod(throttle_dirty_sync_timer,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) =
+<br>
@@ -171,6 +171,11 @@ void cpu_throttle_dirty_sync_timer(bool enable)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (enable) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cpu_throttle_dirty_sync_active()) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Always reset the dirty s=
ync count cache, in case migration<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* was cancelled once.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 throttle_dirty_sync_count_prev =
=3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timer_mod(throttle_dirty_sy=
nc_timer,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_clock_ge=
t_ms(QEMU_CLOCK_VIRTUAL_RT) +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);<br>
-- <br>
2.45.0<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Acked-by: Hyman Huan=
g &lt;<a href=3D"mailto:yong.huang@smartx.com">yong.huang@smartx.com</a>&gt=
;</div><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div =
dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic =
sans ms, sans-serif">Best regards</font></div></div></div>

--00000000000073228c0624b69bc2--

