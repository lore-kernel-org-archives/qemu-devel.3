Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09096FCB61A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXPn-0000te-00; Fri, 06 Mar 2026 10:48:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.guryanov@gmail.com>)
 id 1vyXPk-0000rv-VG
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:48:32 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitry.guryanov@gmail.com>)
 id 1vyXPi-0002TU-U3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:48:32 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b941762394aso199865066b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:48:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772812109; cv=none;
 d=google.com; s=arc-20240605;
 b=QSuYZik0esii21vFqhuHE2C9nMmVX5Pq+2sDBPSyL9X1pVWdwwC7nJUp6qME0eS0mG
 hBKt1fcwasnFV1sF61QXTSUD4AK+vdy75vvb8e4E5e8uJqqHrQ/AF53AVk/hUssSvE+L
 8FDtACVEuKqegRx3/9uDOzPJqojZ8qHei6sIDFenqWO/n8t2l/eBFOlQBnpqkmu5+jD+
 8H0VxYxPioBHXKWa9DmtqQ7vPNaKgDL4Ezqg6qhCeNi85xb5QMtyNjLx132vPrx3kaTj
 N6KBCUsFDen8PyWl4TphZh21TZHbRaRvHqxDC9ND/PjAeCls2Bs9+Fgv+4SUNRxHQUd1
 G5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fVsMFMSOYZJfhvmYU50CxoqdqB0YpaFwqntL/HcQ0FE=;
 fh=6kGXI8wt330dRbM/wQRAR4SHXwQ9vhne35h5TbR7PNk=;
 b=W6HudYLkvdCmpnlEvMKs1zRMR78R06sd4hTmqhTqe7qaAzmU1Z15zdhU5ymQOr+3ME
 lIZ7opW0MU3X9zD9lvF64O9mOmTmkoS2RYIgAMfdC0oZL5Bt4s0TR9GqM04BBEhLhI7h
 B1TtwA5cl8vAkMW4jtEWrcpmJzUWuAiTdVoOhfah/vNpZDLYLKL6frYPKG5+9Sij8kEp
 kOvn58k7TBKLmAa759OmZNYI/2+n9O1j3OIytsykYKMDYEKRgMbksLLnV2Md9qxK/2pN
 ZM2fu1zAScIinw3lqbnyhZbNQtiJM0iKwUFd7oEB5gLhm+OfGin07X7YyHEeMAXsw/3i
 rzWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772812109; x=1773416909; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fVsMFMSOYZJfhvmYU50CxoqdqB0YpaFwqntL/HcQ0FE=;
 b=NaEH+BYCrejCd+x18Ud8cAcYkyagg9BMJg9dzK+Clmv+ccCY0sxzATC4ZZp2qBHeeO
 /8O/MqH6WOLDS37ZntXEilfS6lcsxpx74FefIpdLcPjsRqSkQCkzW7GWqbGQO5K/VZtu
 /rqMBe+o2DXn/nT77lVGLb4YvhTv0DR0xH82/pnJsXyx9Ne35TtWVFOwwout14O+CU2+
 f3DtPwPGWB+9rSErP1Dus60oUGFwkjK12vaQrd1ORigc3ruXxkw9p6RW89KstVjr3xYm
 P889Yt8/D8yv2Ll8WATLYnOR1GkXdzMHQ5feczuGxUDqcItWldA3yqekQtQEKElLrzPf
 zGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772812109; x=1773416909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVsMFMSOYZJfhvmYU50CxoqdqB0YpaFwqntL/HcQ0FE=;
 b=wLcTEia+J9x9++FGEERXbKvLjTCRFEyscnCtRJy9tf8Dgb+vN0zbbEAV4fPOcwX/5Z
 HVTDwozX4rOVRt+A4vy5AhxhiA/zTMVrWmPYoyAIVbdOe4TKoAPoLzya1YtQJD1o5MXT
 wWL5PnSfmeOrO+FRj2aDh57X3kockmmrPtoCpExA+TDKvTzMiAxjD3itp/jgTRt8RNIR
 f6G4MpXPQEeGLdhPT75sCFpjlk9QH7K+CxzJt/SA6xy2SIgKK86KMODv3is9cqQiuvWh
 gG0cXecNDNjH7UpICWNSnt81MWcy5RV7ExR63NeA/6DqdGDtsAiAHSaj1B9Y7nvcpBXc
 vIHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU509yWUCP/vptdIsivHo47hw6NAz2anvO11wBTXBxs0drQ5p9o2JEhzmxVT/EYdkciJv+xjMtwqOLg@nongnu.org
X-Gm-Message-State: AOJu0Ywe6fccrq9gXeiLOcv34XnHSbfkTYOUSocwIOGVddJCl2+yU8dY
 lovTIK2AXiw1+g9hPoQiZlG6j410eNNMFEcgmF4MFwT7mmysMj/PqHhhO3h0NVAg7LMKz4M2YRo
 cmM49hjqXYzqviOMgOMTzfPKJs5w+5CUCGFl+
X-Gm-Gg: ATEYQzxOn3DQ1Dw0VKKheUiLsctpgR5LdgS3zvlLOB3TNf6hFzAvMGv2BoUnMHtl4ps
 bs9rjgTO33nhG4008z+QzUjJdqAowHMWZpCbgw7reQ4tsZAZhC/UO+ON4+k9ES0vy3dJx7U1Unm
 0stGelhDcnUZMLylG4bIvY91VIHCPCPIdxrfSx1Xcb4skKM6ZOboqG07RvETzN7ylqX88wgtOwj
 IMulTN/7HANq29t9+fWlfe2qqgW1pC2qUtgvzgOVjL0P2Ih+85DClIXaC8amabWnL75G136PETE
 9TIgxEq+KSdjW7Kd
X-Received: by 2002:a17:907:6d11:b0:b87:3168:2ccc with SMTP id
 a640c23a62f3a-b942dfb434emr150988166b.39.1772812108553; Fri, 06 Mar 2026
 07:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20251208085528.890098-1-dmitry.guryanov@gmail.com>
 <5011ccf5-7af5-4f88-8261-35514c72bc84@redhat.com>
 <aaCmmgtIlDQMaj8V@redhat.com>
In-Reply-To: <aaCmmgtIlDQMaj8V@redhat.com>
From: Dmitry Guryanov <dmitry.guryanov@gmail.com>
Date: Fri, 6 Mar 2026 18:48:16 +0300
X-Gm-Features: AaiRm50URzpCYsciIATHoEtn9X30x4pUW_vPWHCHxTh2Gamzn_HbBCDa4tMWZ70
Message-ID: <CABOTTXt8_VQt3UoqWYUTqir9=+PLpDd_RhEjKL4mRQqKxPttbw@mail.gmail.com>
Subject: Re: [PATCH resend] block/throttle-groups: fix deadlock with iolimits
 and muliple iothreads
To: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>
Content-Type: multipart/alternative; boundary="000000000000fbe268064c5cfb8e"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=dmitry.guryanov@gmail.com; helo=mail-ej1-x634.google.com
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

--000000000000fbe268064c5cfb8e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

On Thu, Feb 26, 2026 at 11:01=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrot=
e:

> Am 26.02.2026 um 15:37 hat Hanna Czenczek geschrieben:
> > On 08.12.25 09:55, Dmitry Guryanov wrote:
> > > Details: https://gitlab.com/qemu-project/qemu/-/issues/3144
> > >
> > > The function schedule_next_request is called with tg->lock held and
> > > it may call throttle_group_co_restart_queue, which takes
> > > tgm->throttled_reqs_lock, qemu_co_mutex_lock may leave current
> > > coroutine if other iothread has taken the lock. If the next
> > > coroutine will call throttle_group_co_io_limits_intercept - it
> > > will try to take the mutex tg->lock which will never be released.
> > >
> > > Here is the backtrace of the iothread:
> > > Thread 30 (Thread 0x7f8aad1fd6c0 (LWP 24240) "IO iothread2"):
> > >   #0  futex_wait (futex_word=3D0x5611adb7d828, expected=3D2, private=
=3D0) at
> ../sysdeps/nptl/futex-internal.h:146
> > >   #1  __GI___lll_lock_wait (futex=3Dfutex@entry=3D0x5611adb7d828,
> private=3D0) at lowlevellock.c:49
> > >   #2  0x00007f8ab5a97501 in lll_mutex_lock_optimized
> (mutex=3D0x5611adb7d828) at pthread_mutex_lock.c:48
> > >   #3  ___pthread_mutex_lock (mutex=3D0x5611adb7d828) at
> pthread_mutex_lock.c:93
> > >   #4  0x00005611823f5482 in qemu_mutex_lock_impl
> (mutex=3D0x5611adb7d828, file=3D0x56118289daca "../block/throttle-groups.=
c",
> line=3D372) at ../util/qemu-thread-posix.c:94
> > >   #5  0x00005611822b0b39 in throttle_group_co_io_limits_intercept
> (tgm=3D0x5611af1bb4d8, bytes=3D4096, direction=3DTHROTTLE_READ) at
> ../block/throttle-groups.c:372
> > >   #6  0x00005611822473b1 in blk_co_do_preadv_part (blk=3D0x5611af1bb4=
90,
> offset=3D15972311040, bytes=3D4096, qiov=3D0x7f8aa4000f98, qiov_offset=3D=
0,
> flags=3DBDRV_REQ_REGISTERED_BUF) at ../block/block-backend.c:1354
> > >   #7  0x0000561182247fa0 in blk_aio_read_entry (opaque=3D0x7f8aa40059=
10)
> at ../block/block-backend.c:1619
> > >   #8  0x000056118241952e in coroutine_trampoline (i0=3D-1543497424,
> i1=3D32650) at ../util/coroutine-ucontext.c:175
> > >   #9  0x00007f8ab5a56f70 in ?? () at
> ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:66 from
> target:/lib64/libc.so.6
> > >   #10 0x00007f8aad1ef190 in ?? ()
> > >   #11 0x0000000000000000 in ?? ()
> > >
> > > The lock is taken in line 386:
> > > (gdb) p tg.lock
> > > $1 =3D {lock =3D {__data =3D {__lock =3D 2, __count =3D 0, __owner =
=3D 24240,
> __nusers =3D 1, __kind =3D 0, __spins =3D 0, __elision =3D 0, __list =3D =
{__prev =3D
> 0x0, __next =3D 0x0}},
> > >      __size =3D "\002\000\000\000\000\000\000\000\260^\000\000\001",
> '\000' <repeats 26 times>, __align =3D 2}, file =3D 0x56118289daca
> "../block/throttle-groups.c",
> > >    line =3D 386, initialized =3D true}
> > >
> > > The solution is to use tg->lock to protect both ThreadGroup fields an=
d
> > > ThrottleGroupMember.throttled_reqs. It doesn't seem to be possible
> > > to use separate locks because we need to first manipulate ThrottleGro=
up
> > > fields, then schedule next coroutine using throttled_reqs and after
> than
> > > update token field from ThrottleGroup depending on the throttled_reqs
> > > state.
> > >
> > > Signed-off-by: Dmitry Guryanov <dmitry.guryanov@gmail.com>
> > > ---
> > >   block/throttle-groups.c         | 21 ++++++---------------
> > >   include/block/throttle-groups.h |  1 -
> > >   2 files changed, 6 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> > > index 66fdce9a90..bb01e52516 100644
> > > --- a/block/throttle-groups.c
> > > +++ b/block/throttle-groups.c
> > > @@ -295,19 +295,15 @@ static bool
> throttle_group_schedule_timer(ThrottleGroupMember *tgm,
> > >   /* Start the next pending I/O request for a ThrottleGroupMember.
> Return whether
> > >    * any request was actually pending.
> > >    *
> > > + * This assumes that tg->lock is held.
> > > + *
> > >    * @tgm:       the current ThrottleGroupMember
> > >    * @direction: the ThrottleDirection
> > >    */
> > >   static bool coroutine_fn
> throttle_group_co_restart_queue(ThrottleGroupMember *tgm,
> > >
> ThrottleDirection direction)
> > >   {
> > > -    bool ret;
> > > -
> > > -    qemu_co_mutex_lock(&tgm->throttled_reqs_lock);
> > > -    ret =3D qemu_co_queue_next(&tgm->throttled_reqs[direction]);
> > > -    qemu_co_mutex_unlock(&tgm->throttled_reqs_lock);
> > > -
> > > -    return ret;
> > > +    return qemu_co_queue_next(&tgm->throttled_reqs[direction]);;
> >
> > Double semicolon here, should just be one.
> >
> > >   }
> > >   /* Look for the next pending I/O request and schedule it.
> >
> > [...]
> >
> > > diff --git a/include/block/throttle-groups.h
> b/include/block/throttle-groups.h
> > > index 2355e8d9de..374c7c0215 100644
> > > --- a/include/block/throttle-groups.h
> > > +++ b/include/block/throttle-groups.h
> > > @@ -36,7 +36,6 @@
> > >   typedef struct ThrottleGroupMember {
> > >       AioContext   *aio_context;
> > >       /* throttled_reqs_lock protects the CoQueues for throttled
> requests.  */
> >
> > This comment should be updated to something like "Protected by
> > ThrottleGroup.lock".
> >
> > With both of these fixed:
> >
> > Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
>
> Thanks, I applied the series based on your review and made the changes
> you suggested.
>
> Kevin
>
>

--=20
Dmitry Guryanov

--000000000000fbe268064c5cfb8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks!</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 26, 2026 at 11:01=
=E2=80=AFPM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Am 26.02.2026 um 15:37 hat Hanna Czenczek geschrieben:<br>
&gt; On 08.12.25 09:55, Dmitry Guryanov wrote:<br>
&gt; &gt; Details: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues=
/3144" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project=
/qemu/-/issues/3144</a><br>
&gt; &gt; <br>
&gt; &gt; The function schedule_next_request is called with tg-&gt;lock hel=
d and<br>
&gt; &gt; it may call throttle_group_co_restart_queue, which takes<br>
&gt; &gt; tgm-&gt;throttled_reqs_lock, qemu_co_mutex_lock may leave current=
<br>
&gt; &gt; coroutine if other iothread has taken the lock. If the next<br>
&gt; &gt; coroutine will call throttle_group_co_io_limits_intercept - it<br=
>
&gt; &gt; will try to take the mutex tg-&gt;lock which will never be releas=
ed.<br>
&gt; &gt; <br>
&gt; &gt; Here is the backtrace of the iothread:<br>
&gt; &gt; Thread 30 (Thread 0x7f8aad1fd6c0 (LWP 24240) &quot;IO iothread2&q=
uot;):<br>
&gt; &gt;=C2=A0 =C2=A0#0=C2=A0 futex_wait (futex_word=3D0x5611adb7d828, exp=
ected=3D2, private=3D0) at ../sysdeps/nptl/futex-internal.h:146<br>
&gt; &gt;=C2=A0 =C2=A0#1=C2=A0 __GI___lll_lock_wait (futex=3Dfutex@entry=3D=
0x5611adb7d828, private=3D0) at lowlevellock.c:49<br>
&gt; &gt;=C2=A0 =C2=A0#2=C2=A0 0x00007f8ab5a97501 in lll_mutex_lock_optimiz=
ed (mutex=3D0x5611adb7d828) at pthread_mutex_lock.c:48<br>
&gt; &gt;=C2=A0 =C2=A0#3=C2=A0 ___pthread_mutex_lock (mutex=3D0x5611adb7d82=
8) at pthread_mutex_lock.c:93<br>
&gt; &gt;=C2=A0 =C2=A0#4=C2=A0 0x00005611823f5482 in qemu_mutex_lock_impl (=
mutex=3D0x5611adb7d828, file=3D0x56118289daca &quot;../block/throttle-group=
s.c&quot;, line=3D372) at ../util/qemu-thread-posix.c:94<br>
&gt; &gt;=C2=A0 =C2=A0#5=C2=A0 0x00005611822b0b39 in throttle_group_co_io_l=
imits_intercept (tgm=3D0x5611af1bb4d8, bytes=3D4096, direction=3DTHROTTLE_R=
EAD) at ../block/throttle-groups.c:372<br>
&gt; &gt;=C2=A0 =C2=A0#6=C2=A0 0x00005611822473b1 in blk_co_do_preadv_part =
(blk=3D0x5611af1bb490, offset=3D15972311040, bytes=3D4096, qiov=3D0x7f8aa40=
00f98, qiov_offset=3D0, flags=3DBDRV_REQ_REGISTERED_BUF) at ../block/block-=
backend.c:1354<br>
&gt; &gt;=C2=A0 =C2=A0#7=C2=A0 0x0000561182247fa0 in blk_aio_read_entry (op=
aque=3D0x7f8aa4005910) at ../block/block-backend.c:1619<br>
&gt; &gt;=C2=A0 =C2=A0#8=C2=A0 0x000056118241952e in coroutine_trampoline (=
i0=3D-1543497424, i1=3D32650) at ../util/coroutine-ucontext.c:175<br>
&gt; &gt;=C2=A0 =C2=A0#9=C2=A0 0x00007f8ab5a56f70 in ?? () at ../sysdeps/un=
ix/sysv/linux/x86_64/__start_context.S:66 from target:/lib64/libc.so.6<br>
&gt; &gt;=C2=A0 =C2=A0#10 0x00007f8aad1ef190 in ?? ()<br>
&gt; &gt;=C2=A0 =C2=A0#11 0x0000000000000000 in ?? ()<br>
&gt; &gt; <br>
&gt; &gt; The lock is taken in line 386:<br>
&gt; &gt; (gdb) p tg.lock<br>
&gt; &gt; $1 =3D {lock =3D {__data =3D {__lock =3D 2, __count =3D 0, __owne=
r =3D 24240, __nusers =3D 1, __kind =3D 0, __spins =3D 0, __elision =3D 0, =
__list =3D {__prev =3D 0x0, __next =3D 0x0}},<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 __size =3D &quot;\002\000\000\000\000\000\000=
\000\260^\000\000\001&quot;, &#39;\000&#39; &lt;repeats 26 times&gt;, __ali=
gn =3D 2}, file =3D 0x56118289daca &quot;../block/throttle-groups.c&quot;,<=
br>
&gt; &gt;=C2=A0 =C2=A0 line =3D 386, initialized =3D true}<br>
&gt; &gt; <br>
&gt; &gt; The solution is to use tg-&gt;lock to protect both ThreadGroup fi=
elds and<br>
&gt; &gt; ThrottleGroupMember.throttled_reqs. It doesn&#39;t seem to be pos=
sible<br>
&gt; &gt; to use separate locks because we need to first manipulate Throttl=
eGroup<br>
&gt; &gt; fields, then schedule next coroutine using throttled_reqs and aft=
er than<br>
&gt; &gt; update token field from ThrottleGroup depending on the throttled_=
reqs<br>
&gt; &gt; state.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Dmitry Guryanov &lt;<a href=3D"mailto:dmitry.gurya=
nov@gmail.com" target=3D"_blank">dmitry.guryanov@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0block/throttle-groups.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 21 ++++++---------------<br>
&gt; &gt;=C2=A0 =C2=A0include/block/throttle-groups.h |=C2=A0 1 -<br>
&gt; &gt;=C2=A0 =C2=A02 files changed, 6 insertions(+), 16 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/block/throttle-groups.c b/block/throttle-groups.c<br=
>
&gt; &gt; index 66fdce9a90..bb01e52516 100644<br>
&gt; &gt; --- a/block/throttle-groups.c<br>
&gt; &gt; +++ b/block/throttle-groups.c<br>
&gt; &gt; @@ -295,19 +295,15 @@ static bool throttle_group_schedule_timer(T=
hrottleGroupMember *tgm,<br>
&gt; &gt;=C2=A0 =C2=A0/* Start the next pending I/O request for a ThrottleG=
roupMember. Return whether<br>
&gt; &gt;=C2=A0 =C2=A0 * any request was actually pending.<br>
&gt; &gt;=C2=A0 =C2=A0 *<br>
&gt; &gt; + * This assumes that tg-&gt;lock is held.<br>
&gt; &gt; + *<br>
&gt; &gt;=C2=A0 =C2=A0 * @tgm:=C2=A0 =C2=A0 =C2=A0 =C2=A0the current Thrott=
leGroupMember<br>
&gt; &gt;=C2=A0 =C2=A0 * @direction: the ThrottleDirection<br>
&gt; &gt;=C2=A0 =C2=A0 */<br>
&gt; &gt;=C2=A0 =C2=A0static bool coroutine_fn throttle_group_co_restart_qu=
eue(ThrottleGroupMember *tgm,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Throt=
tleDirection direction)<br>
&gt; &gt;=C2=A0 =C2=A0{<br>
&gt; &gt; -=C2=A0 =C2=A0 bool ret;<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 qemu_co_mutex_lock(&amp;tgm-&gt;throttled_reqs_loc=
k);<br>
&gt; &gt; -=C2=A0 =C2=A0 ret =3D qemu_co_queue_next(&amp;tgm-&gt;throttled_=
reqs[direction]);<br>
&gt; &gt; -=C2=A0 =C2=A0 qemu_co_mutex_unlock(&amp;tgm-&gt;throttled_reqs_l=
ock);<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 return ret;<br>
&gt; &gt; +=C2=A0 =C2=A0 return qemu_co_queue_next(&amp;tgm-&gt;throttled_r=
eqs[direction]);;<br>
&gt; <br>
&gt; Double semicolon here, should just be one.<br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0/* Look for the next pending I/O request and schedule=
 it.<br>
&gt; <br>
&gt; [...]<br>
&gt; <br>
&gt; &gt; diff --git a/include/block/throttle-groups.h b/include/block/thro=
ttle-groups.h<br>
&gt; &gt; index 2355e8d9de..374c7c0215 100644<br>
&gt; &gt; --- a/include/block/throttle-groups.h<br>
&gt; &gt; +++ b/include/block/throttle-groups.h<br>
&gt; &gt; @@ -36,7 +36,6 @@<br>
&gt; &gt;=C2=A0 =C2=A0typedef struct ThrottleGroupMember {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AioContext=C2=A0 =C2=A0*aio_context;<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* throttled_reqs_lock protects the CoQ=
ueues for throttled requests.=C2=A0 */<br>
&gt; <br>
&gt; This comment should be updated to something like &quot;Protected by<br=
>
&gt; ThrottleGroup.lock&quot;.<br>
&gt; <br>
&gt; With both of these fixed:<br>
&gt; <br>
&gt; Reviewed-by: Hanna Czenczek &lt;<a href=3D"mailto:hreitz@redhat.com" t=
arget=3D"_blank">hreitz@redhat.com</a>&gt;<br>
<br>
Thanks, I applied the series based on your review and made the changes<br>
you suggested.<br>
<br>
Kevin<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Dm=
itry Guryanov<br></div>

--000000000000fbe268064c5cfb8e--

