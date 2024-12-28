Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4942DE77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 11:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRUuO-0000hj-56; Sat, 28 Dec 2024 06:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRUuM-0000hW-OR
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 06:23:02 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRUuJ-0004MN-Vv
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 06:23:02 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4afe6a8d2e1so4198027137.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 03:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735384978; x=1735989778;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x9Rjb6f4H8Dh+vcy1jfZv/U72TRzl0MHjF0aPXBbRMo=;
 b=161ohpACoFdCPCkuZSF9Z38L8+q1UcAOYQGgD0S6eZWyQNZxvj7xVuO8E7OLy4nwLT
 acjSjguj5zcMQ6lkvTCMQ17ILKvbxcyfbu/L/oRqAVW76kd3YHE1cQYc0ZLpfHEdqaBJ
 CpgvfKUFEpmRcmVBPwOh0ryx//POVkxAQN4mW9oHdFMXKG9sZ3hXTr4oRpWdpXCGInpK
 g/EoGty/MiJP3EY9oPj5nkZ3pnIDr3T8RqZRXACyiGjgEq1olEXtOuTgfL15gueSvHyo
 0fpt5sFsQ3gCTOdsHVw/1nCB/lONFD4VkxFzV7AQTvzUMUTF0BDSNlB+neuuztshLAX/
 3d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735384978; x=1735989778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x9Rjb6f4H8Dh+vcy1jfZv/U72TRzl0MHjF0aPXBbRMo=;
 b=FeIGRzm1nDo+eweHzU8RIYAK0O5T6xBuPZSOkWV+NC0pZGT9MguiIJBtHQ/NMKK2DY
 J+L+SiPOCUDVsImO7y6KXDp8MRmaWau38dXvAkgr1hnykdibchf8bAJJditAbnljO4jo
 wqBi/ZDc66NxI7+i87uF0YhaFn27OoWVjgXK3Y35HafZMBj+g7ThUTpL/vRVkosipHIR
 8p2KhZ57PzNHeWCfN62LxCHx+XkHJXhA+lD6WMTmkY90Sv6EFB4jmJoL1kPY5VGuWbA3
 3FAbnadmfo8i1FU8aa9U2w7DfDWwneTXdYzvqf8vWWOSgJpXkiH5E7Y1T+sbnJd4xIZm
 CVHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0hZUG0H1NTUTbAGzLzhrqPtc31PpL8Hw3ySqNdeX0wjcvuIzzJNThQA9dVIDk2Od3bV+nU1Ir7Ro/@nongnu.org
X-Gm-Message-State: AOJu0YwxGqU4VuO/Eh9l+czjTuqlh9scTISJrNCj5G8ysMTGMoEtZl2L
 eqTqTBa80tzoL2pYMqguGaD/yXew9qmcD1tMjo8qoCFtbq3wOYgUjCFpCFbS5hv7wx32DwuZJK0
 QYSZ8IWx8xrWhD4mi4I7tPVX7b+ZF2AMEZn3K
X-Gm-Gg: ASbGncvjNihfcKOJgbOY2C9gftcw/bBsqzpPBxWxaRnB9KZYjzRXceldlj4c2pbUfjb
 s48TZFTxfbFsnjbzVI6LMASZpsxZQsuIiA/RQQg==
X-Google-Smtp-Source: AGHT+IESz2RY4HYUUgJfMLrDVQ133q2S8nzJ/GHAvfr8NXiJEoB8+PQ5jnKSanyMouCi9QYn7gxd9ZObwZK2i3mpiMU=
X-Received: by 2002:a05:6102:e0c:b0:4b1:1808:2fbf with SMTP id
 ada2fe7eead31-4b2cd829c28mr17058616137.13.1735384978257; Sat, 28 Dec 2024
 03:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
 <20241225-event-v1-3-a58c8d63eb70@daynix.com>
In-Reply-To: <20241225-event-v1-3-a58c8d63eb70@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sat, 28 Dec 2024 12:22:46 +0100
Message-ID: <CAAibmn0uwa7qTGHkCfxQw1Jh0mAYKK_vJp2sBVWt4yOq96D8Dg@mail.gmail.com>
Subject: Re: [PATCH 3/8] qemu-thread: Avoid futex abstraction for non-Linux
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002d937c062a52cd0d"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e32;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe32.google.com
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

--0000000000002d937c062a52cd0d
Content-Type: text/plain; charset="UTF-8"

This fix makes sense. I've also successfully tested with this new "pure"
pthread-based QemuEvent in the apple-gfx code where we initially considered
using QemuEvent and ran into the destruction issue on macOS.

Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>

(Unrelated: email to the devel@daynix.com address in the cc list seems to
bounce.)

On Wed, 25 Dec 2024 at 06:44, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> qemu-thread used to abstract pthread primitives into futex for the
> QemuEvent implementation of POSIX systems other than Linux. However,
> this abstraction has one key difference: unlike futex, pthread
> primitives require an explicit destruction, and it must be ordered after
> wait and wake operations.
>
> It would be easier to perform destruction if a wait operation ensures
> the corresponding wake operation finishes as POSIX semaphore does, but
> that requires to protect state accesses in qemu_event_set() and
> qemu_event_wait() with a mutex. On the other hand, real futex does not
> need such a protection but needs complex barrier and atomic operations
> before wait and wake operations instead.
>
> Add special implementations of qemu_event_set() and qemu_event_wait()
> using pthread primitives. qemu_event_wait() will ensure qemu_event_set()
> finishes, and these functions will avoid complex barrier and atomic
> operations.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  util/qemu-thread-posix.c | 45
> ++++++++++++++++++---------------------------
>  1 file changed, 18 insertions(+), 27 deletions(-)
>
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 13459e44c768..805cac444f15 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -319,28 +319,6 @@ void qemu_sem_wait(QemuSemaphore *sem)
>
>  #ifdef __linux__
>  #include "qemu/futex.h"
> -#else
> -static inline void qemu_futex_wake(QemuEvent *ev, int n)
> -{
> -    assert(ev->initialized);
> -    pthread_mutex_lock(&ev->lock);
> -    if (n == 1) {
> -        pthread_cond_signal(&ev->cond);
> -    } else {
> -        pthread_cond_broadcast(&ev->cond);
> -    }
> -    pthread_mutex_unlock(&ev->lock);
> -}
> -
> -static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
> -{
> -    assert(ev->initialized);
> -    pthread_mutex_lock(&ev->lock);
> -    if (ev->value == val) {
> -        pthread_cond_wait(&ev->cond, &ev->lock);
> -    }
> -    pthread_mutex_unlock(&ev->lock);
> -}
>  #endif
>
>  /* Valid transitions:
> @@ -363,7 +341,7 @@ static inline void qemu_futex_wait(QemuEvent *ev,
> unsigned val)
>
>  void qemu_event_init(QemuEvent *ev, bool init)
>  {
> -#ifndef __linux__
> +#ifndef CONFIG_LINUX
>      pthread_mutex_init(&ev->lock, NULL);
>      pthread_cond_init(&ev->cond, NULL);
>  #endif
> @@ -376,7 +354,7 @@ void qemu_event_destroy(QemuEvent *ev)
>  {
>      assert(ev->initialized);
>      ev->initialized = false;
> -#ifndef __linux__
> +#ifndef CONFIG_LINUX
>      pthread_mutex_destroy(&ev->lock);
>      pthread_cond_destroy(&ev->cond);
>  #endif
> @@ -386,6 +364,7 @@ void qemu_event_set(QemuEvent *ev)
>  {
>      assert(ev->initialized);
>
> +#ifdef CONFIG_LINUX
>      /*
>       * Pairs with both qemu_event_reset() and qemu_event_wait().
>       *
> @@ -403,6 +382,12 @@ void qemu_event_set(QemuEvent *ev)
>              qemu_futex_wake_all(ev);
>          }
>      }
> +#else
> +    pthread_mutex_lock(&ev->lock);
> +    qatomic_set(&ev->value, EV_SET);
> +    pthread_cond_broadcast(&ev->cond);
> +    pthread_mutex_unlock(&ev->lock);
> +#endif
>  }
>
>  void qemu_event_reset(QemuEvent *ev)
> @@ -424,10 +409,9 @@ void qemu_event_reset(QemuEvent *ev)
>
>  void qemu_event_wait(QemuEvent *ev)
>  {
> -    unsigned value;
> -
>      assert(ev->initialized);
>
> +#ifdef CONFIG_LINUX
>      while (true) {
>          /*
>           * qemu_event_wait must synchronize with qemu_event_set even if
> it does
> @@ -438,7 +422,7 @@ void qemu_event_wait(QemuEvent *ev)
>           * might miss a qemu_event_set() here but ultimately the memory
> barrier
>           * in qemu_futex_wait() will ensure the check is done correctly.
>           */
> -        value = qatomic_load_acquire(&ev->value);
> +        unsigned value = qatomic_load_acquire(&ev->value);
>          if (value == EV_SET) {
>              break;
>          }
> @@ -467,6 +451,13 @@ void qemu_event_wait(QemuEvent *ev)
>           */
>          qemu_futex_wait(ev, EV_BUSY);
>      }
> +#else
> +    pthread_mutex_lock(&ev->lock);
> +    if (qatomic_read(&ev->value) != EV_SET) {
> +        pthread_cond_wait(&ev->cond, &ev->lock);
> +    }
> +    pthread_mutex_unlock(&ev->lock);
> +#endif
>  }
>
>  static __thread NotifierList thread_exit;
>
> --
> 2.47.1
>
>

--0000000000002d937c062a52cd0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This fix makes sense. I&#39;ve also successfully test=
ed=C2=A0with this new &quot;pure&quot; pthread-based QemuEvent in the apple=
-gfx code where we initially considered using QemuEvent and ran into the de=
struction issue on macOS. <br></div><div><br></div><div>Tested-by: Phil Den=
nis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu">phil@philjordan.eu</a>=
&gt;</div><div>Reviewed-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@p=
hiljordan.eu">phil@philjordan.eu</a>&gt;<br></div><div><br></div><div>(Unre=
lated: email to the <a href=3D"mailto:devel@daynix.com">devel@daynix.com</a=
> address in the cc list seems to bounce.)<br></div></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Wed, 25 Dec 2024 at 06:44, Akihiko Odaki &lt;<a href=3D"mailto:akihiko.od=
aki@daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">qemu-thread used to abstract pthrea=
d primitives into futex for the<br>
QemuEvent implementation of POSIX systems other than Linux. However,<br>
this abstraction has one key difference: unlike futex, pthread<br>
primitives require an explicit destruction, and it must be ordered after<br=
>
wait and wake operations.<br>
<br>
It would be easier to perform destruction if a wait operation ensures<br>
the corresponding wake operation finishes as POSIX semaphore does, but<br>
that requires to protect state accesses in qemu_event_set() and<br>
qemu_event_wait() with a mutex. On the other hand, real futex does not<br>
need such a protection but needs complex barrier and atomic operations<br>
before wait and wake operations instead.<br>
<br>
Add special implementations of qemu_event_set() and qemu_event_wait()<br>
using pthread primitives. qemu_event_wait() will ensure qemu_event_set()<br=
>
finishes, and these functions will avoid complex barrier and atomic<br>
operations.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
---<br>
=C2=A0util/qemu-thread-posix.c | 45 ++++++++++++++++++---------------------=
------<br>
=C2=A01 file changed, 18 insertions(+), 27 deletions(-)<br>
<br>
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c<br>
index 13459e44c768..805cac444f15 100644<br>
--- a/util/qemu-thread-posix.c<br>
+++ b/util/qemu-thread-posix.c<br>
@@ -319,28 +319,6 @@ void qemu_sem_wait(QemuSemaphore *sem)<br>
<br>
=C2=A0#ifdef __linux__<br>
=C2=A0#include &quot;qemu/futex.h&quot;<br>
-#else<br>
-static inline void qemu_futex_wake(QemuEvent *ev, int n)<br>
-{<br>
-=C2=A0 =C2=A0 assert(ev-&gt;initialized);<br>
-=C2=A0 =C2=A0 pthread_mutex_lock(&amp;ev-&gt;lock);<br>
-=C2=A0 =C2=A0 if (n =3D=3D 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_cond_signal(&amp;ev-&gt;cond);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_cond_broadcast(&amp;ev-&gt;cond);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 pthread_mutex_unlock(&amp;ev-&gt;lock);<br>
-}<br>
-<br>
-static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)<br>
-{<br>
-=C2=A0 =C2=A0 assert(ev-&gt;initialized);<br>
-=C2=A0 =C2=A0 pthread_mutex_lock(&amp;ev-&gt;lock);<br>
-=C2=A0 =C2=A0 if (ev-&gt;value =3D=3D val) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_cond_wait(&amp;ev-&gt;cond, &amp;ev-&g=
t;lock);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 pthread_mutex_unlock(&amp;ev-&gt;lock);<br>
-}<br>
=C2=A0#endif<br>
<br>
=C2=A0/* Valid transitions:<br>
@@ -363,7 +341,7 @@ static inline void qemu_futex_wait(QemuEvent *ev, unsig=
ned val)<br>
<br>
=C2=A0void qemu_event_init(QemuEvent *ev, bool init)<br>
=C2=A0{<br>
-#ifndef __linux__<br>
+#ifndef CONFIG_LINUX<br>
=C2=A0 =C2=A0 =C2=A0pthread_mutex_init(&amp;ev-&gt;lock, NULL);<br>
=C2=A0 =C2=A0 =C2=A0pthread_cond_init(&amp;ev-&gt;cond, NULL);<br>
=C2=A0#endif<br>
@@ -376,7 +354,7 @@ void qemu_event_destroy(QemuEvent *ev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0assert(ev-&gt;initialized);<br>
=C2=A0 =C2=A0 =C2=A0ev-&gt;initialized =3D false;<br>
-#ifndef __linux__<br>
+#ifndef CONFIG_LINUX<br>
=C2=A0 =C2=A0 =C2=A0pthread_mutex_destroy(&amp;ev-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0pthread_cond_destroy(&amp;ev-&gt;cond);<br>
=C2=A0#endif<br>
@@ -386,6 +364,7 @@ void qemu_event_set(QemuEvent *ev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0assert(ev-&gt;initialized);<br>
<br>
+#ifdef CONFIG_LINUX<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Pairs with both qemu_event_reset() and qemu_event_wa=
it().<br>
=C2=A0 =C2=A0 =C2=A0 *<br>
@@ -403,6 +382,12 @@ void qemu_event_set(QemuEvent *ev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_futex_wake_all(ev);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#else<br>
+=C2=A0 =C2=A0 pthread_mutex_lock(&amp;ev-&gt;lock);<br>
+=C2=A0 =C2=A0 qatomic_set(&amp;ev-&gt;value, EV_SET);<br>
+=C2=A0 =C2=A0 pthread_cond_broadcast(&amp;ev-&gt;cond);<br>
+=C2=A0 =C2=A0 pthread_mutex_unlock(&amp;ev-&gt;lock);<br>
+#endif<br>
=C2=A0}<br>
<br>
=C2=A0void qemu_event_reset(QemuEvent *ev)<br>
@@ -424,10 +409,9 @@ void qemu_event_reset(QemuEvent *ev)<br>
<br>
=C2=A0void qemu_event_wait(QemuEvent *ev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 unsigned value;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0assert(ev-&gt;initialized);<br>
<br>
+#ifdef CONFIG_LINUX<br>
=C2=A0 =C2=A0 =C2=A0while (true) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * qemu_event_wait must synchronize with =
qemu_event_set even if it does<br>
@@ -438,7 +422,7 @@ void qemu_event_wait(QemuEvent *ev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * might miss a qemu_event_set() here but=
 ultimately the memory barrier<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * in qemu_futex_wait() will ensure the c=
heck is done correctly.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D qatomic_load_acquire(&amp;ev-&gt;val=
ue);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned value =3D qatomic_load_acquire(&amp;e=
v-&gt;value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value =3D=3D EV_SET) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -467,6 +451,13 @@ void qemu_event_wait(QemuEvent *ev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_futex_wait(ev, EV_BUSY);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#else<br>
+=C2=A0 =C2=A0 pthread_mutex_lock(&amp;ev-&gt;lock);<br>
+=C2=A0 =C2=A0 if (qatomic_read(&amp;ev-&gt;value) !=3D EV_SET) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_cond_wait(&amp;ev-&gt;cond, &amp;ev-&g=
t;lock);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 pthread_mutex_unlock(&amp;ev-&gt;lock);<br>
+#endif<br>
=C2=A0}<br>
<br>
=C2=A0static __thread NotifierList thread_exit;<br>
<br>
-- <br>
2.47.1<br>
<br>
</blockquote></div>

--0000000000002d937c062a52cd0d--

