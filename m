Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B26FE77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 11:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRUjt-0008J0-Fe; Sat, 28 Dec 2024 06:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRUjT-0007d3-Gs
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 06:11:47 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRUjQ-0006sV-Jm
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 06:11:47 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5187f6f7bcaso2415876e0c.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 03:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735384302; x=1735989102;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g+g4uZSe7tDMwRI1+dUSMWooYqiG6fHVZBKOIf+xLfs=;
 b=mQT1uvPhZHwYPOHsurbMdW8s51Z7Px3aETkgMqY+BbzvWROcVqIQIX5rrqChJDjkXG
 LWEiW0QHWVcVEtWg60Mk2+fLp9NI75Cak80rI67r2a/sZYa83di6IxQgkB+Zg4IaUbDh
 MDRJlwgn7cloYAD7cLKFYyoaMoRiNBCkdvz88OsBXUOTi7hBBHhriY4s+DkoISsd8lqY
 vzc+pYdFuVGCT0wDBJP5x3OiRFsifLqU5lJFkdNC4HO3iuAkd2vEA1I7HIxfKmZF5eQv
 6OaLu1U9Ktj1UOm20AiEznwwmTuisxpFOV/VKRpMqSVHksveDwR2PWqch7oBh5ggX++4
 GyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735384302; x=1735989102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g+g4uZSe7tDMwRI1+dUSMWooYqiG6fHVZBKOIf+xLfs=;
 b=qeOJHsZQKE74FzAjxfCugt0HZxYeOQJrwrA6bWO7G68MLuSicgMtzWO1S04ybGqRdm
 d2pJ+gfG3T4j9mlIASejZrwgQ7Miv6bTUUKI2p/SJqzz2KtoNJL7xQXS3RYnPh4B3lr9
 uGHH2r1Myyl2lXuoIt6yfxmvgmA/pFBINHhueRPGxazf2bvcYa46XmBLHBrEVWDywMSC
 +eOtzmSyFpRKwXN4FV0Uc8FySaIbDOxW9G7wBDVqB3njlvh9LMi0Cnt52y2VKYEJZZl2
 w9bfjqHTeUEgMN+Vua3atDJfR/6P1Usg3u74uzPSZn7Lmj0haoFX2uzgPMpfWNaVbLWn
 Mi+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv08sKB7JnspFcThYPkPkZeYpEhbGkQ7sODUi2SHNn2P5WHTSISekhwGK7MwMCn9AonLDWuPWrdU7i@nongnu.org
X-Gm-Message-State: AOJu0YyXzdclICF6wt7kA7FrmhR+1b6RrVrx3IE6xI0Mb4N642ldb7fI
 xl1MfGk7E4ZP5GUi2VLGNpFG3SYbsVooU9erKdL7Z0rl/REVIYL4Gex78kVIGIDia6s3i/6V7YS
 rLGpyT69ZYHeGc0UqPBkx+3/+u+Ma5cjzn3AC
X-Gm-Gg: ASbGncu5MksMig2YOBYnF5dwopgkO21v4TNbiLy7ugJqj+9nF0uUoUBNcdMMOxMlTAT
 jp1xpYPNpqnHrQxMD9eLHGXX+DuBSx4BGvEOXpQ==
X-Google-Smtp-Source: AGHT+IGApnC8cKy19pXkWv/Q94Yz3zeGbGZ39FuENfWJKAjw3m/FsFQFu9UDGN8//NX/ZSR3BbSC1YOsUA4N6MDisAo=
X-Received: by 2002:a05:6102:d8f:b0:4b2:9f20:51d3 with SMTP id
 ada2fe7eead31-4b2cc116633mr27962296137.0.1735384302367; Sat, 28 Dec 2024
 03:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
 <20241225-event-v1-1-a58c8d63eb70@daynix.com>
In-Reply-To: <20241225-event-v1-1-a58c8d63eb70@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sat, 28 Dec 2024 12:11:31 +0100
Message-ID: <CAAibmn0u1oveoxVXbTzZn4RahxDbtxDvGHZ2y=JF5NsEfdoE_g@mail.gmail.com>
Subject: Re: [PATCH 1/8] futex: Check value after qemu_futex_wait()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 qemu-devel@nongnu.org, devel@daynix.com
Content-Type: multipart/alternative; boundary="000000000000e44d3d062a52a4bd"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000e44d3d062a52a4bd
Content-Type: text/plain; charset="UTF-8"

This is somewhat orthogonal to the issue being addressed here, but:
While reading the man page to make sense of this patch, I noticed the
following:

> If the futex value does not match val, then the call fails
>              immediately with the error EAGAIN.

And qemu_futex_wait does not seem to handle that case. In fact it seems
like it would take the default: abort(); code path?

If I've got this right, I'm surprised there aren't spurious abort()s
happening, but I suppose QemuEvent and qemu_futex_* are used fairly
sparingly and in low-contention areas.


On Wed, 25 Dec 2024 at 06:44, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> futex(2) - Linux manual page
> https://man7.org/linux/man-pages/man2/futex.2.html
> > Note that a wake-up can also be caused by common futex usage patterns
> > in unrelated code that happened to have previously used the futex
> > word's memory location (e.g., typical futex-based implementations of
> > Pthreads mutexes can cause this under some conditions).  Therefore,
> > callers should always conservatively assume that a return value of 0
> > can mean a spurious wake-up, and use the futex word's value (i.e.,
> > the user-space synchronization scheme) to decide whether to continue
> > to block or not.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>

In any case, for the specific issue addressed here:

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>


> ---
>  include/qemu/futex.h              |  9 +++++++++
>  tests/unit/test-aio-multithread.c |  4 +++-
>  util/qemu-thread-posix.c          | 28 ++++++++++++++++------------
>  3 files changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/include/qemu/futex.h b/include/qemu/futex.h
> index 91ae88966e12..f57774005330 100644
> --- a/include/qemu/futex.h
> +++ b/include/qemu/futex.h
> @@ -24,6 +24,15 @@ static inline void qemu_futex_wake(void *f, int n)
>      qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
>  }
>
> +/*
> + * Note that a wake-up can also be caused by common futex usage patterns
> in
> + * unrelated code that happened to have previously used the futex word's
> + * memory location (e.g., typical futex-based implementations of Pthreads
> + * mutexes can cause this under some conditions).  Therefore, callers
> should
> + * always conservatively assume that it is a spurious wake-up, and use
> the futex
> + * word's value (i.e., the user-space synchronization scheme) to decide
> whether
> + * to continue to block or not.
> + */
>  static inline void qemu_futex_wait(void *f, unsigned val)
>  {
>      while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
> diff --git a/tests/unit/test-aio-multithread.c
> b/tests/unit/test-aio-multithread.c
> index 08d4570ccb14..8c2e41545a29 100644
> --- a/tests/unit/test-aio-multithread.c
> +++ b/tests/unit/test-aio-multithread.c
> @@ -305,7 +305,9 @@ static void mcs_mutex_lock(void)
>      prev = qatomic_xchg(&mutex_head, id);
>      if (prev != -1) {
>          qatomic_set(&nodes[prev].next, id);
> -        qemu_futex_wait(&nodes[id].locked, 1);
> +        while (qatomic_read(&nodes[id].locked) == 1) {
> +            qemu_futex_wait(&nodes[id].locked, 1);
> +        }
>      }
>  }
>
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index b2e26e21205b..eade5311d175 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -428,17 +428,21 @@ void qemu_event_wait(QemuEvent *ev)
>
>      assert(ev->initialized);
>
> -    /*
> -     * qemu_event_wait must synchronize with qemu_event_set even if it
> does
> -     * not go down the slow path, so this load-acquire is needed that
> -     * synchronizes with the first memory barrier in qemu_event_set().
> -     *
> -     * If we do go down the slow path, there is no requirement at all: we
> -     * might miss a qemu_event_set() here but ultimately the memory
> barrier in
> -     * qemu_futex_wait() will ensure the check is done correctly.
> -     */
> -    value = qatomic_load_acquire(&ev->value);
> -    if (value != EV_SET) {
> +    while (true) {
> +        /*
> +         * qemu_event_wait must synchronize with qemu_event_set even if
> it does
> +         * not go down the slow path, so this load-acquire is needed that
> +         * synchronizes with the first memory barrier in qemu_event_set().
> +         *
> +         * If we do go down the slow path, there is no requirement at
> all: we
> +         * might miss a qemu_event_set() here but ultimately the memory
> barrier
> +         * in qemu_futex_wait() will ensure the check is done correctly.
> +         */
> +        value = qatomic_load_acquire(&ev->value);
> +        if (value == EV_SET) {
> +            break;
> +        }
> +
>          if (value == EV_FREE) {
>              /*
>               * Leave the event reset and tell qemu_event_set that there
> are
> @@ -452,7 +456,7 @@ void qemu_event_wait(QemuEvent *ev)
>               * like the load above.
>               */
>              if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
> -                return;
> +                break;
>              }
>          }
>
>
> --
> 2.47.1
>
>

--000000000000e44d3d062a52a4bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This is somewhat orthogonal to the issue being addres=
sed here, but:</div><div>While reading the man page to make sense of this p=
atch, I noticed the following:<br></div><div><br></div><div>&gt; If the fut=
ex value does not match val, then the call fails<br>&gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 immediately with the error EAGAIN.</div><di=
v><br></div><div>And qemu_futex_wait does not seem to handle that case. In =
fact it seems like it would take the default: abort(); code path?</div><div=
><br></div><div>If I&#39;ve got this right, I&#39;m surprised there aren&#3=
9;t spurious abort()s happening, but I suppose QemuEvent and qemu_futex_* a=
re used fairly sparingly and in low-contention areas.<br></div><div><br></d=
iv><div><br></div><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, 25 Dec 2024 at 06:44, Akihiko Odaki &=
lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">fute=
x(2) - Linux manual page<br>
<a href=3D"https://man7.org/linux/man-pages/man2/futex.2.html" rel=3D"noref=
errer" target=3D"_blank">https://man7.org/linux/man-pages/man2/futex.2.html=
</a><br>
&gt; Note that a wake-up can also be caused by common futex usage patterns<=
br>
&gt; in unrelated code that happened to have previously used the futex<br>
&gt; word&#39;s memory location (e.g., typical futex-based implementations =
of<br>
&gt; Pthreads mutexes can cause this under some conditions).=C2=A0 Therefor=
e,<br>
&gt; callers should always conservatively assume that a return value of 0<b=
r>
&gt; can mean a spurious wake-up, and use the futex word&#39;s value (i.e.,=
<br>
&gt; the user-space synchronization scheme) to decide whether to continue<b=
r>
&gt; to block or not.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br></blockquote><div><=
br></div><div>In any case, for the specific issue addressed here:<br></div>=
<div><br></div><div>Reviewed-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:p=
hil@philjordan.eu">phil@philjordan.eu</a>&gt;</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0include/qemu/futex.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 9 +++++++++<br>
=C2=A0tests/unit/test-aio-multithread.c |=C2=A0 4 +++-<br>
=C2=A0util/qemu-thread-posix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 28 +++++=
+++++++++++------------<br>
=C2=A03 files changed, 28 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/include/qemu/futex.h b/include/qemu/futex.h<br>
index 91ae88966e12..f57774005330 100644<br>
--- a/include/qemu/futex.h<br>
+++ b/include/qemu/futex.h<br>
@@ -24,6 +24,15 @@ static inline void qemu_futex_wake(void *f, int n)<br>
=C2=A0 =C2=A0 =C2=A0qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Note that a wake-up can also be caused by common futex usage patterns i=
n<br>
+ * unrelated code that happened to have previously used the futex word&#39=
;s<br>
+ * memory location (e.g., typical futex-based implementations of Pthreads<=
br>
+ * mutexes can cause this under some conditions).=C2=A0 Therefore, callers=
 should<br>
+ * always conservatively assume that it is a spurious wake-up, and use the=
 futex<br>
+ * word&#39;s value (i.e., the user-space synchronization scheme) to decid=
e whether<br>
+ * to continue to block or not.<br>
+ */<br>
=C2=A0static inline void qemu_futex_wait(void *f, unsigned val)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL,=
 0)) {<br>
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multit=
hread.c<br>
index 08d4570ccb14..8c2e41545a29 100644<br>
--- a/tests/unit/test-aio-multithread.c<br>
+++ b/tests/unit/test-aio-multithread.c<br>
@@ -305,7 +305,9 @@ static void mcs_mutex_lock(void)<br>
=C2=A0 =C2=A0 =C2=A0prev =3D qatomic_xchg(&amp;mutex_head, id);<br>
=C2=A0 =C2=A0 =C2=A0if (prev !=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qatomic_set(&amp;nodes[prev].next, id);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_futex_wait(&amp;nodes[id].locked, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (qatomic_read(&amp;nodes[id].locked) =3D=
=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_futex_wait(&amp;nodes[id].l=
ocked, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c<br>
index b2e26e21205b..eade5311d175 100644<br>
--- a/util/qemu-thread-posix.c<br>
+++ b/util/qemu-thread-posix.c<br>
@@ -428,17 +428,21 @@ void qemu_event_wait(QemuEvent *ev)<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(ev-&gt;initialized);<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* qemu_event_wait must synchronize with qemu_event_set=
 even if it does<br>
-=C2=A0 =C2=A0 =C2=A0* not go down the slow path, so this load-acquire is n=
eeded that<br>
-=C2=A0 =C2=A0 =C2=A0* synchronizes with the first memory barrier in qemu_e=
vent_set().<br>
-=C2=A0 =C2=A0 =C2=A0*<br>
-=C2=A0 =C2=A0 =C2=A0* If we do go down the slow path, there is no requirem=
ent at all: we<br>
-=C2=A0 =C2=A0 =C2=A0* might miss a qemu_event_set() here but ultimately th=
e memory barrier in<br>
-=C2=A0 =C2=A0 =C2=A0* qemu_futex_wait() will ensure the check is done corr=
ectly.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 value =3D qatomic_load_acquire(&amp;ev-&gt;value);<br>
-=C2=A0 =C2=A0 if (value !=3D EV_SET) {<br>
+=C2=A0 =C2=A0 while (true) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* qemu_event_wait must synchronize with =
qemu_event_set even if it does<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* not go down the slow path, so this loa=
d-acquire is needed that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* synchronizes with the first memory bar=
rier in qemu_event_set().<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If we do go down the slow path, there =
is no requirement at all: we<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* might miss a qemu_event_set() here but=
 ultimately the memory barrier<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* in qemu_futex_wait() will ensure the c=
heck is done correctly.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D qatomic_load_acquire(&amp;ev-&gt;val=
ue);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value =3D=3D EV_SET) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value =3D=3D EV_FREE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Leave the event reset an=
d tell qemu_event_set that there are<br>
@@ -452,7 +456,7 @@ void qemu_event_wait(QemuEvent *ev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * like the load above.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qatomic_cmpxchg(&amp;ev=
-&gt;value, EV_FREE, EV_BUSY) =3D=3D EV_SET) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
<br>
-- <br>
2.47.1<br>
<br>
</blockquote></div></div>

--000000000000e44d3d062a52a4bd--

