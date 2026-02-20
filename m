Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A067C5516A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 09:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtMQX-000344-Rj; Fri, 20 Feb 2026 04:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.guryanov@gmail.com>)
 id 1vtMQT-00033b-9o
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:03:53 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitry.guryanov@gmail.com>)
 id 1vtMQQ-0006eX-Tb
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:03:53 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-65bfe9c585cso2903285a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 01:03:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771578228; cv=none;
 d=google.com; s=arc-20240605;
 b=FBjwruEvAARiDBjnvLdkG0p381grCJ6f8jaEv05Qc/Xcv2Alom9DZQotrCoV05kRZX
 SgxYkuAblZn2BMYBYKanabxFeBiKfZZVkhx6ArjTXjWekJSuNB/3oITjTM/5gn/NdgYa
 c1XWlAW4SZPhbNzyyqQHaGd0BeKPjlZssMFgs2q6h696P4suW9jj6qj3i76gfh+icj5x
 F0smbyt45Uz7hfeUwWKRu727UOgGCXhJFaXsaoSUMemyH9iRqFg3ylSakV6mTnjLGT/f
 izjubAyeLIG11t5xMTDtmfmiX60zcOqB6TeefthMhOkH7MMYLChqAV5UUlgERlqQep2i
 c+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/sYp3AdWj0r5JFfdOPYtFk26NN3xfa4h+fvRQB9xXZs=;
 fh=wdIvRubVrD/8PBoRejL95i+yItihh//XehwG4cBMtpY=;
 b=dKi6GvT54ggpS+73b9q/QnvNiNDnq15sH2F1C6fjjlZtSrEA75vYaxl/EJpGdiApEv
 EF7ROF371FpdQCTl0FK1Qt4kr9uoVvOL0w8SQgR8YK37wt4Y7s6xJdORxnnRap3TswCt
 xApi75UqqgXisscRPIUoTqXzmJ2cJsPuWe5SkjsQz68FiYhBCfQ4HJNh88pAKti445Kf
 aRnCfbSMEAi1KtlvAlCeGYeRsbO1HlgkGBh92fMlDYgmKEk0xzNVTvwNOKUu/3u+m0Al
 246A38qKNW7mWyiYlF4Dj96hZo5BzKNpqep3M4E+OztNbepJYgEixiEOrj24bS324try
 p7Fw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771578228; x=1772183028; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/sYp3AdWj0r5JFfdOPYtFk26NN3xfa4h+fvRQB9xXZs=;
 b=ahXHcHeOfZwiaCjkV+4O9U+qKyMpZY9DWrD8PTN0jT6weaRQapQRPvGu6gpuUgsEUS
 lCJQ9G8eMg2e3vKKhAKeID48wsi87IAgPUAmcTLHEcuBbEukalCUJHvu5uaHBcfrbPSx
 JSs+JYbE9PMg+Lw/WuEUz+AAHfQ2cr/dp2TxktPuUOjjHjy2sA7z8m07i89Ktq6J8+kj
 0OnaG2qyHD7iJnuhFJ7bncWZrPvZCdk37D4vn6N9Gl0tfd0fCJbepD/VoMIFjzvf7zmA
 2TJBnHbm/asGC4tLUD2RAGgN92/PDAu0qoPiiiRca3GBVfRRn4b8/S1yaZ3fqR0ZD9WC
 mR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771578228; x=1772183028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sYp3AdWj0r5JFfdOPYtFk26NN3xfa4h+fvRQB9xXZs=;
 b=lNlRIZm9dEtWh11PMvBo2C9vFKodmwkmwn7CqNyFN2YI/I4BUlhbmCxVpruNNU1ceu
 CrX3dUgh2ay1gqew9iBSnzEszgQZVxtCf3NA0rt105pSlI17QyZbtHHWcJmhYY1bPV7Q
 XnYY76nkulUw6TXaIaHohqYdGhpaGJzhYCm6Cox4cbdmOwfToEfTbAXYSw+zmwsgKTwm
 yViYLZofS8y79/GMXiocEsXJLXQKGY+raoaDDDuQFosjWEev4kVnirbdcL4poOMjlb7O
 HQ9AURHjt8j5pZ/uNerrKT2QR8Upkg9A3ZF9tP6fW7XaVAX10N7kjYAwbIpAbd4cf1wo
 aCpw==
X-Gm-Message-State: AOJu0YwTY021qH2x9iL5pMHXgLAOKZwSsJ4nEIkg76W+E0mDjKSHw3LA
 1VpsjFX55aWX8gUxceZis0HxyDNZQ4WTktp7y9z+2kgVOKXQvdVS5NFL5qxcWHKcb3QJB761TTr
 kGYVRrBqC/5BDyc0U9kSWUymITqoDPKJzHUZb
X-Gm-Gg: AZuq6aJba87yMBmZspopqQJoMuQRluo2dc2UKmlHaW7FyNINfTIFPHHQzLQ9TbaTBWZ
 poaAdoFJ2TbN+Rf8jRK7KIG86AttWMKsOVGTXaLJWB38fh5ofrhRzUCFlfHY3v8Ql5lfDG5MJcf
 46T2WB9cgxzow56HyQsfnznocjrq/enU0u+yKpAgsdf7QXRSN5MUfZbK7IurqTw+DcmHX/WWdnW
 QDkK2B5aEA7WQYKQV/cFnja+Nh8ey8YsGMTCynBOVoRAnzr4/TwaZLXINXKnLTJ9rlmqdptxOU0
 DKdPlE6EkPzplTLZJJfvMaZpRA==
X-Received: by 2002:a17:907:d0e:b0:b89:fb0b:6602 with SMTP id
 a640c23a62f3a-b8fc38f23d8mr1247655966b.4.1771578227673; Fri, 20 Feb 2026
 01:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20251208085528.890098-1-dmitry.guryanov@gmail.com>
In-Reply-To: <20251208085528.890098-1-dmitry.guryanov@gmail.com>
From: Dmitry Guryanov <dmitry.guryanov@gmail.com>
Date: Fri, 20 Feb 2026 12:03:34 +0300
X-Gm-Features: AaiRm50lLqe1iOYRRmVuLZ5SDhehP3hQ4Hmp3h7ZtscSIv2YEGa53dmc0G57CVk
Message-ID: <CABOTTXu9OPtBHviGJnLQorddg7gzFE6_89VKD2TJw3s-0PXbDw@mail.gmail.com>
Subject: Re: [PATCH resend] block/throttle-groups: fix deadlock with iolimits
 and muliple iothreads
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f3ce12064b3db224"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=dmitry.guryanov@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000f3ce12064b3db224
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi! Could, someone, please, comment? The issue in gitlab is still open.

On Mon, Dec 8, 2025 at 11:55=E2=80=AFAM Dmitry Guryanov <dmitry.guryanov@gm=
ail.com>
wrote:

> Details: https://gitlab.com/qemu-project/qemu/-/issues/3144
>
> The function schedule_next_request is called with tg->lock held and
> it may call throttle_group_co_restart_queue, which takes
> tgm->throttled_reqs_lock, qemu_co_mutex_lock may leave current
> coroutine if other iothread has taken the lock. If the next
> coroutine will call throttle_group_co_io_limits_intercept - it
> will try to take the mutex tg->lock which will never be released.
>
> Here is the backtrace of the iothread:
> Thread 30 (Thread 0x7f8aad1fd6c0 (LWP 24240) "IO iothread2"):
>  #0  futex_wait (futex_word=3D0x5611adb7d828, expected=3D2, private=3D0) =
at
> ../sysdeps/nptl/futex-internal.h:146
>  #1  __GI___lll_lock_wait (futex=3Dfutex@entry=3D0x5611adb7d828, private=
=3D0)
> at lowlevellock.c:49
>  #2  0x00007f8ab5a97501 in lll_mutex_lock_optimized (mutex=3D0x5611adb7d8=
28)
> at pthread_mutex_lock.c:48
>  #3  ___pthread_mutex_lock (mutex=3D0x5611adb7d828) at
> pthread_mutex_lock.c:93
>  #4  0x00005611823f5482 in qemu_mutex_lock_impl (mutex=3D0x5611adb7d828,
> file=3D0x56118289daca "../block/throttle-groups.c", line=3D372) at
> ../util/qemu-thread-posix.c:94
>  #5  0x00005611822b0b39 in throttle_group_co_io_limits_intercept
> (tgm=3D0x5611af1bb4d8, bytes=3D4096, direction=3DTHROTTLE_READ) at
> ../block/throttle-groups.c:372
>  #6  0x00005611822473b1 in blk_co_do_preadv_part (blk=3D0x5611af1bb490,
> offset=3D15972311040, bytes=3D4096, qiov=3D0x7f8aa4000f98, qiov_offset=3D=
0,
> flags=3DBDRV_REQ_REGISTERED_BUF) at ../block/block-backend.c:1354
>  #7  0x0000561182247fa0 in blk_aio_read_entry (opaque=3D0x7f8aa4005910) a=
t
> ../block/block-backend.c:1619
>  #8  0x000056118241952e in coroutine_trampoline (i0=3D-1543497424, i1=3D3=
2650)
> at ../util/coroutine-ucontext.c:175
>  #9  0x00007f8ab5a56f70 in ?? () at
> ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:66 from
> target:/lib64/libc.so.6
>  #10 0x00007f8aad1ef190 in ?? ()
>  #11 0x0000000000000000 in ?? ()
>
> The lock is taken in line 386:
> (gdb) p tg.lock
> $1 =3D {lock =3D {__data =3D {__lock =3D 2, __count =3D 0, __owner =3D 24=
240, __nusers
> =3D 1, __kind =3D 0, __spins =3D 0, __elision =3D 0, __list =3D {__prev =
=3D 0x0, __next
> =3D 0x0}},
>     __size =3D "\002\000\000\000\000\000\000\000\260^\000\000\001", '\000=
'
> <repeats 26 times>, __align =3D 2}, file =3D 0x56118289daca
> "../block/throttle-groups.c",
>   line =3D 386, initialized =3D true}
>
> The solution is to use tg->lock to protect both ThreadGroup fields and
> ThrottleGroupMember.throttled_reqs. It doesn't seem to be possible
> to use separate locks because we need to first manipulate ThrottleGroup
> fields, then schedule next coroutine using throttled_reqs and after than
> update token field from ThrottleGroup depending on the throttled_reqs
> state.
>
> Signed-off-by: Dmitry Guryanov <dmitry.guryanov@gmail.com>
> ---
>  block/throttle-groups.c         | 21 ++++++---------------
>  include/block/throttle-groups.h |  1 -
>  2 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 66fdce9a90..bb01e52516 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -295,19 +295,15 @@ static bool
> throttle_group_schedule_timer(ThrottleGroupMember *tgm,
>  /* Start the next pending I/O request for a ThrottleGroupMember. Return
> whether
>   * any request was actually pending.
>   *
> + * This assumes that tg->lock is held.
> + *
>   * @tgm:       the current ThrottleGroupMember
>   * @direction: the ThrottleDirection
>   */
>  static bool coroutine_fn
> throttle_group_co_restart_queue(ThrottleGroupMember *tgm,
>
> ThrottleDirection direction)
>  {
> -    bool ret;
> -
> -    qemu_co_mutex_lock(&tgm->throttled_reqs_lock);
> -    ret =3D qemu_co_queue_next(&tgm->throttled_reqs[direction]);
> -    qemu_co_mutex_unlock(&tgm->throttled_reqs_lock);
> -
> -    return ret;
> +    return qemu_co_queue_next(&tgm->throttled_reqs[direction]);;
>  }
>
>  /* Look for the next pending I/O request and schedule it.
> @@ -378,12 +374,8 @@ void coroutine_fn
> throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm
>      /* Wait if there's a timer set or queued requests of this type */
>      if (must_wait || tgm->pending_reqs[direction]) {
>          tgm->pending_reqs[direction]++;
> -        qemu_mutex_unlock(&tg->lock);
> -        qemu_co_mutex_lock(&tgm->throttled_reqs_lock);
>          qemu_co_queue_wait(&tgm->throttled_reqs[direction],
> -                           &tgm->throttled_reqs_lock);
> -        qemu_co_mutex_unlock(&tgm->throttled_reqs_lock);
> -        qemu_mutex_lock(&tg->lock);
> +                           &tg->lock);
>          tgm->pending_reqs[direction]--;
>      }
>
> @@ -410,15 +402,15 @@ static void coroutine_fn
> throttle_group_restart_queue_entry(void *opaque)
>      ThrottleDirection direction =3D data->direction;
>      bool empty_queue;
>
> +    qemu_mutex_lock(&tg->lock);
>      empty_queue =3D !throttle_group_co_restart_queue(tgm, direction);
>
>      /* If the request queue was empty then we have to take care of
>       * scheduling the next one */
>      if (empty_queue) {
> -        qemu_mutex_lock(&tg->lock);
>          schedule_next_request(tgm, direction);
> -        qemu_mutex_unlock(&tg->lock);
>      }
> +    qemu_mutex_unlock(&tg->lock);
>
>      g_free(data);
>
> @@ -569,7 +561,6 @@ void throttle_group_register_tgm(ThrottleGroupMember
> *tgm,
>                           read_timer_cb,
>                           write_timer_cb,
>                           tgm);
> -    qemu_co_mutex_init(&tgm->throttled_reqs_lock);
>  }
>
>  /* Unregister a ThrottleGroupMember from its group, removing it from the
> list,
> diff --git a/include/block/throttle-groups.h
> b/include/block/throttle-groups.h
> index 2355e8d9de..374c7c0215 100644
> --- a/include/block/throttle-groups.h
> +++ b/include/block/throttle-groups.h
> @@ -36,7 +36,6 @@
>  typedef struct ThrottleGroupMember {
>      AioContext   *aio_context;
>      /* throttled_reqs_lock protects the CoQueues for throttled requests.
> */
> -    CoMutex      throttled_reqs_lock;
>      CoQueue      throttled_reqs[THROTTLE_MAX];
>
>      /* Nonzero if the I/O limits are currently being ignored; generally
> --
> 2.51.1
>
>

--=20
Dmitry Guryanov

--000000000000f3ce12064b3db224
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi! Could, someone, please, comment? The issue in git=
lab is still open.</div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 8, 2025 at 11:55=E2=80=
=AFAM Dmitry Guryanov &lt;<a href=3D"mailto:dmitry.guryanov@gmail.com">dmit=
ry.guryanov@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Details: <a href=3D"https://gitlab.com/qemu-project/qe=
mu/-/issues/3144" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/q=
emu-project/qemu/-/issues/3144</a><br>
<br>
The function schedule_next_request is called with tg-&gt;lock held and<br>
it may call throttle_group_co_restart_queue, which takes<br>
tgm-&gt;throttled_reqs_lock, qemu_co_mutex_lock may leave current<br>
coroutine if other iothread has taken the lock. If the next<br>
coroutine will call throttle_group_co_io_limits_intercept - it<br>
will try to take the mutex tg-&gt;lock which will never be released.<br>
<br>
Here is the backtrace of the iothread:<br>
Thread 30 (Thread 0x7f8aad1fd6c0 (LWP 24240) &quot;IO iothread2&quot;):<br>
=C2=A0#0=C2=A0 futex_wait (futex_word=3D0x5611adb7d828, expected=3D2, priva=
te=3D0) at ../sysdeps/nptl/futex-internal.h:146<br>
=C2=A0#1=C2=A0 __GI___lll_lock_wait (futex=3Dfutex@entry=3D0x5611adb7d828, =
private=3D0) at lowlevellock.c:49<br>
=C2=A0#2=C2=A0 0x00007f8ab5a97501 in lll_mutex_lock_optimized (mutex=3D0x56=
11adb7d828) at pthread_mutex_lock.c:48<br>
=C2=A0#3=C2=A0 ___pthread_mutex_lock (mutex=3D0x5611adb7d828) at pthread_mu=
tex_lock.c:93<br>
=C2=A0#4=C2=A0 0x00005611823f5482 in qemu_mutex_lock_impl (mutex=3D0x5611ad=
b7d828, file=3D0x56118289daca &quot;../block/throttle-groups.c&quot;, line=
=3D372) at ../util/qemu-thread-posix.c:94<br>
=C2=A0#5=C2=A0 0x00005611822b0b39 in throttle_group_co_io_limits_intercept =
(tgm=3D0x5611af1bb4d8, bytes=3D4096, direction=3DTHROTTLE_READ) at ../block=
/throttle-groups.c:372<br>
=C2=A0#6=C2=A0 0x00005611822473b1 in blk_co_do_preadv_part (blk=3D0x5611af1=
bb490, offset=3D15972311040, bytes=3D4096, qiov=3D0x7f8aa4000f98, qiov_offs=
et=3D0, flags=3DBDRV_REQ_REGISTERED_BUF) at ../block/block-backend.c:1354<b=
r>
=C2=A0#7=C2=A0 0x0000561182247fa0 in blk_aio_read_entry (opaque=3D0x7f8aa40=
05910) at ../block/block-backend.c:1619<br>
=C2=A0#8=C2=A0 0x000056118241952e in coroutine_trampoline (i0=3D-1543497424=
, i1=3D32650) at ../util/coroutine-ucontext.c:175<br>
=C2=A0#9=C2=A0 0x00007f8ab5a56f70 in ?? () at ../sysdeps/unix/sysv/linux/x8=
6_64/__start_context.S:66 from target:/lib64/libc.so.6<br>
=C2=A0#10 0x00007f8aad1ef190 in ?? ()<br>
=C2=A0#11 0x0000000000000000 in ?? ()<br>
<br>
The lock is taken in line 386:<br>
(gdb) p tg.lock<br>
$1 =3D {lock =3D {__data =3D {__lock =3D 2, __count =3D 0, __owner =3D 2424=
0, __nusers =3D 1, __kind =3D 0, __spins =3D 0, __elision =3D 0, __list =3D=
 {__prev =3D 0x0, __next =3D 0x0}},<br>
=C2=A0 =C2=A0 __size =3D &quot;\002\000\000\000\000\000\000\000\260^\000\00=
0\001&quot;, &#39;\000&#39; &lt;repeats 26 times&gt;, __align =3D 2}, file =
=3D 0x56118289daca &quot;../block/throttle-groups.c&quot;,<br>
=C2=A0 line =3D 386, initialized =3D true}<br>
<br>
The solution is to use tg-&gt;lock to protect both ThreadGroup fields and<b=
r>
ThrottleGroupMember.throttled_reqs. It doesn&#39;t seem to be possible<br>
to use separate locks because we need to first manipulate ThrottleGroup<br>
fields, then schedule next coroutine using throttled_reqs and after than<br=
>
update token field from ThrottleGroup depending on the throttled_reqs<br>
state.<br>
<br>
Signed-off-by: Dmitry Guryanov &lt;<a href=3D"mailto:dmitry.guryanov@gmail.=
com" target=3D"_blank">dmitry.guryanov@gmail.com</a>&gt;<br>
---<br>
=C2=A0block/throttle-groups.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 21 ++++++-=
--------------<br>
=C2=A0include/block/throttle-groups.h |=C2=A0 1 -<br>
=C2=A02 files changed, 6 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/block/throttle-groups.c b/block/throttle-groups.c<br>
index 66fdce9a90..bb01e52516 100644<br>
--- a/block/throttle-groups.c<br>
+++ b/block/throttle-groups.c<br>
@@ -295,19 +295,15 @@ static bool throttle_group_schedule_timer(ThrottleGro=
upMember *tgm,<br>
=C2=A0/* Start the next pending I/O request for a ThrottleGroupMember. Retu=
rn whether<br>
=C2=A0 * any request was actually pending.<br>
=C2=A0 *<br>
+ * This assumes that tg-&gt;lock is held.<br>
+ *<br>
=C2=A0 * @tgm:=C2=A0 =C2=A0 =C2=A0 =C2=A0the current ThrottleGroupMember<br=
>
=C2=A0 * @direction: the ThrottleDirection<br>
=C2=A0 */<br>
=C2=A0static bool coroutine_fn throttle_group_co_restart_queue(ThrottleGrou=
pMember *tgm,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ThrottleDirection d=
irection)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 bool ret;<br>
-<br>
-=C2=A0 =C2=A0 qemu_co_mutex_lock(&amp;tgm-&gt;throttled_reqs_lock);<br>
-=C2=A0 =C2=A0 ret =3D qemu_co_queue_next(&amp;tgm-&gt;throttled_reqs[direc=
tion]);<br>
-=C2=A0 =C2=A0 qemu_co_mutex_unlock(&amp;tgm-&gt;throttled_reqs_lock);<br>
-<br>
-=C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 return qemu_co_queue_next(&amp;tgm-&gt;throttled_reqs[direct=
ion]);;<br>
=C2=A0}<br>
<br>
=C2=A0/* Look for the next pending I/O request and schedule it.<br>
@@ -378,12 +374,8 @@ void coroutine_fn throttle_group_co_io_limits_intercep=
t(ThrottleGroupMember *tgm<br>
=C2=A0 =C2=A0 =C2=A0/* Wait if there&#39;s a timer set or queued requests o=
f this type */<br>
=C2=A0 =C2=A0 =C2=A0if (must_wait || tgm-&gt;pending_reqs[direction]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tgm-&gt;pending_reqs[direction]++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock(&amp;tg-&gt;lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_co_mutex_lock(&amp;tgm-&gt;throttled_reqs=
_lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_co_queue_wait(&amp;tgm-&gt;throttled=
_reqs[direction],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;tgm-&gt;throttled_reqs_lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_co_mutex_unlock(&amp;tgm-&gt;throttled_re=
qs_lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock(&amp;tg-&gt;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;tg-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tgm-&gt;pending_reqs[direction]--;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -410,15 +402,15 @@ static void coroutine_fn throttle_group_restart_queue=
_entry(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0ThrottleDirection direction =3D data-&gt;direction;<br>
=C2=A0 =C2=A0 =C2=A0bool empty_queue;<br>
<br>
+=C2=A0 =C2=A0 qemu_mutex_lock(&amp;tg-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0empty_queue =3D !throttle_group_co_restart_queue(tgm, d=
irection);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* If the request queue was empty then we have to take =
care of<br>
=C2=A0 =C2=A0 =C2=A0 * scheduling the next one */<br>
=C2=A0 =C2=A0 =C2=A0if (empty_queue) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock(&amp;tg-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_next_request(tgm, direction);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock(&amp;tg-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;tg-&gt;lock);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(data);<br>
<br>
@@ -569,7 +561,6 @@ void throttle_group_register_tgm(ThrottleGroupMember *t=
gm,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 read_timer_cb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 write_timer_cb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tgm);<br>
-=C2=A0 =C2=A0 qemu_co_mutex_init(&amp;tgm-&gt;throttled_reqs_lock);<br>
=C2=A0}<br>
<br>
=C2=A0/* Unregister a ThrottleGroupMember from its group, removing it from =
the list,<br>
diff --git a/include/block/throttle-groups.h b/include/block/throttle-group=
s.h<br>
index 2355e8d9de..374c7c0215 100644<br>
--- a/include/block/throttle-groups.h<br>
+++ b/include/block/throttle-groups.h<br>
@@ -36,7 +36,6 @@<br>
=C2=A0typedef struct ThrottleGroupMember {<br>
=C2=A0 =C2=A0 =C2=A0AioContext=C2=A0 =C2=A0*aio_context;<br>
=C2=A0 =C2=A0 =C2=A0/* throttled_reqs_lock protects the CoQueues for thrott=
led requests.=C2=A0 */<br>
-=C2=A0 =C2=A0 CoMutex=C2=A0 =C2=A0 =C2=A0 throttled_reqs_lock;<br>
=C2=A0 =C2=A0 =C2=A0CoQueue=C2=A0 =C2=A0 =C2=A0 throttled_reqs[THROTTLE_MAX=
];<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Nonzero if the I/O limits are currently being ignore=
d; generally<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Dm=
itry Guryanov<br></div></div>

--000000000000f3ce12064b3db224--

