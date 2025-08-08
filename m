Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24899C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 06:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukGiy-0002Rh-7d; Fri, 08 Aug 2025 02:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ukGiw-0002RF-Hj
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:37:06 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ukGit-00027o-4r
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:37:06 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-61998205433so710581eaf.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 23:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1754635020; x=1755239820;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vbljm6hZ9Lb4+bmF2vLZw4YUGRtapMzr2yCUZD7dS5g=;
 b=wNULY9VfDkR9hMG8dOPvDf8kJ3kpdgJ5PjJKW1FzcbH+dvJw0ULDm3msRPda2MyPBk
 wtms020kZC9oOsjF0YjnAO2q4kz1+7v+j+xNzHlbDHjtLM0lJXXTqQICEVaay/K9YHb/
 /0o+icX0nqx7Gvb3JY5WETNyBEUWFwL9lPcLd9Bbn7YotNWFQ73vZqXkxLchMklYDeHm
 D/SkEQ3ir0Mf2k0GuA2dC0Hpn72zr96WiBIuRAYlY7kxatr8UlEVZSZNVc8uOMEYqx3W
 9vw3DG4zqrZ0H69C1EyNJ2yDXLYySyJ8ceAvn/7BcW6Byskf/p3zDH13YWFbNHPpFipu
 U7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754635020; x=1755239820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vbljm6hZ9Lb4+bmF2vLZw4YUGRtapMzr2yCUZD7dS5g=;
 b=eV6q7nOn1IWshgCZ+7gTkf/TEl3gOTElJ7VnlmLTUhfQhcQDCayVIs8IIvj7+oqEKh
 4ugaJf2W5Oh+WFujPjwCWi98+HcTRqCUa7SHN/TMnaSmqhTt3nb9lkEhRyHiaOVjtpJl
 atUNlX6B+6oiw5VTyPUK++gRymKXhg6I5HCHIpIec0sUvSVGDNWMJKVeINBm3Dxrvw6u
 y+D9ZuNGWRguEwcP4Mp/Cet2xF43C+pmvKODxbkceIV6dCKDMQa/DzS6iDCZPUaDgLxi
 RxYIpAnyDvbkXfgPHVJ51/kG3fAsKR3vxdeCK5/T/9eoNret7ALBtWsuBeHEOOZHHV/9
 zFiA==
X-Gm-Message-State: AOJu0Yz3RBSlYkW2zA3nq8Sid3gfgrZl22D4X9lt8pA28HhgPLVLT/xd
 wjhNf5s2tB5hMVbKVifoqKLTvU8zFfIOu/4LtVWu2rmD+Hr9A3hNHwJcSjnBBad8lTRYrzzsDjJ
 0n2ANzO/cQo6935eTGbLFQVYAdnij4GH5O0jgcLWx2xCLs9IkZToGhVlc5Q==
X-Gm-Gg: ASbGncsipVKU/Ne64abc1a/+3x5Xcw2FYU+38hfysaCENu+5KyU4LyjJdMl+uSP5PqU
 iPhyEAgvfF9mzh18IEOEMW4x4ZZfY4P7kzb9aylDKCBEC0b2WA0fnPflCDVBQjWYsiY+ezBxHqx
 7AEMuJDKLl0Tx0EjxgxfHIcO8JVpLJ4lpJqx/YN605azwMHRjcMkpvmxtn0kP/6KJsyURuznYRL
 Rtuc/SSIgMhX5np+YYR
X-Google-Smtp-Source: AGHT+IFRhoEnGSnHY4cHHfSp5YzaTMPm1pl15CffKtFPIOpDgZSJ+UzAaV5dBdpYJV5pORMuCDfI/Qa1kriv6DM60TI=
X-Received: by 2002:a05:6871:c706:b0:30b:86ed:a23b with SMTP id
 586e51a60fabf-30c20f500e6mr1155761fac.15.1754635020493; Thu, 07 Aug 2025
 23:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
In-Reply-To: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 8 Aug 2025 14:36:44 +0800
X-Gm-Features: Ac12FXwkpejMGaB-uBji02yzi2Yh0ZeLmSSEf-A5AAKiBhmi86tqPwdUmAOjQBk
Message-ID: <CAK9dgmZmLS+TuosmN3BTN0Nmj4CKm3G3A=9zEsVRdPxVL=7bVA@mail.gmail.com>
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="0000000000001b7c49063bd4cd15"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2f.google.com
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

--0000000000001b7c49063bd4cd15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:04=E2=80=AFAM <yong.huang@smartx.com> wrote:

> From: Hyman Huang <yong.huang@smartx.com>
>
> When there are network issues like missing TCP ACKs on the send
> side during the multifd live migration. At the send side, the error
> "Connection timed out" is thrown out and source QEMU process stop
> sending data, at the receive side, The IO-channels may be blocked
> at recvmsg() and thus the main loop gets stuck and fails to respond
> to QMP commands consequently.
>
> The QEMU backtrace at the receive side with the main thread and two
> multi-channel threads is displayed as follows:
>
> multifd thread 2:
> Thread 10 (Thread 0x7fd24d5fd700 (LWP 1413634)):
> 0  0x00007fd46066d157 in __libc_recvmsg (fd=3D46, msg=3Dmsg@entry=3D0x7fd=
24d5fc530,
> flags=3Dflags@entry=3D0) at ../sysdeps/unix/sysv/linux/recvmsg.c:28
> 1  0x00005556d52ffb1b in qio_channel_socket_readv (ioc=3D<optimized out>,
> iov=3D<optimized out>, niov=3D<optimized out>, fds=3D0x0, nfds=3D0x0,
> flags=3D<optimized out>, errp=3D0x7fd24d5fc6f8) at ../io/channel-socket.c=
:513
> 2  0x00005556d530561f in qio_channel_readv_full_all_eof
> (ioc=3D0x5556d76db290, iov=3D<optimized out>, niov=3D<optimized out>, fds=
=3D0x0,
> nfds=3D0x0, errp=3Derrp@entry=3D0x7fd24d5fc6f8) at ../io/channel.c:142
> 3  0x00005556d53057d9 in qio_channel_readv_full_all (ioc=3D<optimized out=
>,
> iov=3D<optimized out>, niov=3D<optimized out>, fds=3D<optimized out>,
> nfds=3D<optimized out>, errp=3D0x7fd24d5fc6f8) at ../io/channel.c:210
> 4  0x00005556d4fa4fc9 in multifd_recv_thread (opaque=3Dopaque@entry=3D0x5=
556d7affa60)
> at ../migration/multifd.c:1113
> 5  0x00005556d5414826 in qemu_thread_start (args=3D<optimized out>) at
> ../util/qemu-thread-posix.c:556
> 6  0x00007fd460662f1b in start_thread (arg=3D0x7fd24d5fd700) at
> pthread_create.c:486
> 7  0x00007fd46059a1a0 in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:98
>
> multifd thread 1:
> Thread 9 (Thread 0x7fd24ddfe700 (LWP 1413633)):
> 0  0x00007fd46066d157 in __libc_recvmsg (fd=3D44, msg=3Dmsg@entry=3D0x7fd=
24ddfd530,
> flags=3Dflags@entry=3D0) at ../sysdeps/unix/sysv/linux/recvmsg.c:28
> 1  0x00005556d52ffb1b in qio_channel_socket_readv (ioc=3D<optimized out>,
> iov=3D<optimized out>, niov=3D<optimized out>, fds=3D0x0, nfds=3D0x0,
> flags=3D<optimized out>, errp=3D0x7fd24ddfd6f8) at ../io/channel-socket.c=
:513
> 2  0x00005556d530561f in qio_channel_readv_full_all_eof
> (ioc=3D0x5556d76dc600, iov=3D<optimized out>, niov=3D<optimized out>, fds=
=3D0x0,
> nfds=3D0x0, errp=3Derrp@entry=3D0x7fd24ddfd6f8) at ../io/channel.c:142
> 3  0x00005556d53057d9 in qio_channel_readv_full_all (ioc=3D<optimized out=
>,
> iov=3D<optimized out>, niov=3D<optimized out>, fds=3D<optimized out>,
> nfds=3D<optimized out>, errp=3D0x7fd24ddfd6f8) at ../io/channel.c:210
> 4  0x00005556d4fa4fc9 in multifd_recv_thread (opaque=3Dopaque@entry=3D0x5=
556d7aff990)
> at ../migration/multifd.c:1113
> 5  0x00005556d5414826 in qemu_thread_start (args=3D<optimized out>) at
> ../util/qemu-thread-posix.c:556
> 6  0x00007fd460662f1b in start_thread (arg=3D0x7fd24ddfe700) at
> pthread_create.c:486
> 7  0x00007fd46059a1a0 in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:98
>
> main thread:
> Thread 1 (Thread 0x7fd45f1fbe40 (LWP 1413088)):
> 0  0x00007fd46066b616 in futex_abstimed_wait_cancelable (private=3D0,
> abstime=3D0x0, clockid=3D0, expected=3D0, futex_word=3D0x5556d7604e80) at
> ../sysdeps/unix/sysv/linux/futex-internal.h:216
> 1  do_futex_wait (sem=3Dsem@entry=3D0x5556d7604e80, abstime=3D0x0) at
> sem_waitcommon.c:111
> 2  0x00007fd46066b708 in __new_sem_wait_slow (sem=3Dsem@entry=3D0x5556d76=
04e80,
> abstime=3D0x0) at sem_waitcommon.c:183
> 3  0x00007fd46066b779 in __new_sem_wait (sem=3Dsem@entry=3D0x5556d7604e80=
) at
> sem_wait.c:42
> 4  0x00005556d5415524 in qemu_sem_wait (sem=3D0x5556d7604e80) at
> ../util/qemu-thread-posix.c:358
> 5  0x00005556d4fa5e99 in multifd_recv_sync_main () at
> ../migration/multifd.c:1052
> 6  0x00005556d521ed65 in ram_load_precopy (f=3Df@entry=3D0x5556d75dfb90) =
at
> ../migration/ram.c:4446
> 7  0x00005556d521f1dd in ram_load (f=3D0x5556d75dfb90, opaque=3D<optimize=
d
> out>, version_id=3D4) at ../migration/ram.c:4495
> 8  0x00005556d4faa3e7 in vmstate_load (f=3Df@entry=3D0x5556d75dfb90,
> se=3Dse@entry=3D0x5556d6083070) at ../migration/savevm.c:909
> 9  0x00005556d4fae7a0 in qemu_loadvm_section_part_end (mis=3D0x5556d6082c=
c0,
> f=3D0x5556d75dfb90) at ../migration/savevm.c:2475
> 10 qemu_loadvm_state_main (f=3Df@entry=3D0x5556d75dfb90, mis=3Dmis@entry=
=3D0x5556d6082cc0)
> at ../migration/savevm.c:2634
> 11 0x00005556d4fafbd5 in qemu_loadvm_state (f=3D0x5556d75dfb90) at
> ../migration/savevm.c:2706
> 12 0x00005556d4f9ebdb in process_incoming_migration_co (opaque=3D<optimiz=
ed
> out>) at ../migration/migration.c:561
> 13 0x00005556d542513b in coroutine_trampoline (i0=3D<optimized out>,
> i1=3D<optimized out>) at ../util/coroutine-ucontext.c:186
> 14 0x00007fd4604ef970 in ?? () from target:/lib64/libc.so.6
>
> Once the QEMU process falls into the above state in the presence of
> the network errors, live migration cannot be canceled gracefully,
> leaving the destination VM in the "paused" state, since the QEMU
> process on the destination side doesn't respond to the QMP command
> "migrate_cancel".


Actually, in our case, QEMU on the destination side doesn't respond to
the QMP command "query-status" instead of "migrate-cancel".
See the details in the mail that was replied to Lukas.

It is my mistake for not checking the comment, I'll fix the comment in
the next version. :(


>
> To fix that, make the main thread yield to the main loop after waiting
> too long for the multi-channels to finish receiving data during one
> iteration. 10 seconds is a sufficient timeout period to set.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/multifd.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b255778855..aca0aeb341 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1228,6 +1228,16 @@ void multifd_recv_sync_main(void)
>              }
>          }
>          trace_multifd_recv_sync_main_signal(p->id);
> +        do {
> +            if (qemu_sem_timedwait(&multifd_recv_state->sem_sync, 10000)
> =3D=3D 0) {
> +                break;
> +            }
> +            if (qemu_in_coroutine()) {
> +                aio_co_schedule(qemu_get_current_aio_context(),
> +                                qemu_coroutine_self());
> +                qemu_coroutine_yield();
> +            }
> +        } while (1);
>          qemu_sem_post(&p->sem_sync);
>      }
>      trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
> --
> 2.27.0
>
> Thanks,
Yong

--=20
Best regards

--0000000000001b7c49063bd4cd15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, Aug 7, 2025 at 11:04=E2=80=AFAM &lt;<a href=3D"mailto:yong.huan=
g@smartx.com">yong.huang@smartx.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;=
border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex=
">From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"=
_blank">yong.huang@smartx.com</a>&gt;<br>
<br>
When there are network issues like missing TCP ACKs on the send<br>
side=C2=A0during the multifd live migration. At the send side, the error<br=
>
&quot;Connection timed out&quot; is thrown out and source QEMU process stop=
<br>
sending data, at the receive side, The IO-channels may be blocked<br>
at recvmsg() and thus the=C2=A0main loop gets stuck and fails to respond<br=
>
to QMP commands consequently.<br>
<br>
The QEMU backtrace at the receive side with the main thread and two<br>
multi-channel threads is displayed as follows:<br>
<br>
multifd thread 2:<br>
Thread 10 (Thread 0x7fd24d5fd700 (LWP 1413634)):<br>
0=C2=A0 0x00007fd46066d157 in __libc_recvmsg (fd=3D46, msg=3Dmsg@entry=3D0x=
7fd24d5fc530, flags=3Dflags@entry=3D0) at ../sysdeps/unix/sysv/linux/recvms=
g.c:28<br>
1=C2=A0 0x00005556d52ffb1b in qio_channel_socket_readv (ioc=3D&lt;optimized=
 out&gt;, iov=3D&lt;optimized out&gt;, niov=3D&lt;optimized out&gt;, fds=3D=
0x0, nfds=3D0x0, flags=3D&lt;optimized out&gt;, errp=3D0x7fd24d5fc6f8) at .=
./io/channel-socket.c:513<br>
2=C2=A0 0x00005556d530561f in qio_channel_readv_full_all_eof (ioc=3D0x5556d=
76db290, iov=3D&lt;optimized out&gt;, niov=3D&lt;optimized out&gt;, fds=3D0=
x0, nfds=3D0x0, errp=3Derrp@entry=3D0x7fd24d5fc6f8) at ../io/channel.c:142<=
br>
3=C2=A0 0x00005556d53057d9 in qio_channel_readv_full_all (ioc=3D&lt;optimiz=
ed out&gt;, iov=3D&lt;optimized out&gt;, niov=3D&lt;optimized out&gt;, fds=
=3D&lt;optimized out&gt;, nfds=3D&lt;optimized out&gt;, errp=3D0x7fd24d5fc6=
f8) at ../io/channel.c:210<br>
4=C2=A0 0x00005556d4fa4fc9 in multifd_recv_thread (opaque=3Dopaque@entry=3D=
0x5556d7affa60) at ../migration/multifd.c:1113<br>
5=C2=A0 0x00005556d5414826 in qemu_thread_start (args=3D&lt;optimized out&g=
t;) at ../util/qemu-thread-posix.c:556<br>
6=C2=A0 0x00007fd460662f1b in start_thread (arg=3D0x7fd24d5fd700) at pthrea=
d_create.c:486<br>
7=C2=A0 0x00007fd46059a1a0 in clone () at ../sysdeps/unix/sysv/linux/x86_64=
/clone.S:98<br>
<br>
multifd thread 1:<br>
Thread 9 (Thread 0x7fd24ddfe700 (LWP 1413633)):<br>
0=C2=A0 0x00007fd46066d157 in __libc_recvmsg (fd=3D44, msg=3Dmsg@entry=3D0x=
7fd24ddfd530, flags=3Dflags@entry=3D0) at ../sysdeps/unix/sysv/linux/recvms=
g.c:28<br>
1=C2=A0 0x00005556d52ffb1b in qio_channel_socket_readv (ioc=3D&lt;optimized=
 out&gt;, iov=3D&lt;optimized out&gt;, niov=3D&lt;optimized out&gt;, fds=3D=
0x0, nfds=3D0x0, flags=3D&lt;optimized out&gt;, errp=3D0x7fd24ddfd6f8) at .=
./io/channel-socket.c:513<br>
2=C2=A0 0x00005556d530561f in qio_channel_readv_full_all_eof (ioc=3D0x5556d=
76dc600, iov=3D&lt;optimized out&gt;, niov=3D&lt;optimized out&gt;, fds=3D0=
x0, nfds=3D0x0, errp=3Derrp@entry=3D0x7fd24ddfd6f8) at ../io/channel.c:142<=
br>
3=C2=A0 0x00005556d53057d9 in qio_channel_readv_full_all (ioc=3D&lt;optimiz=
ed out&gt;, iov=3D&lt;optimized out&gt;, niov=3D&lt;optimized out&gt;, fds=
=3D&lt;optimized out&gt;, nfds=3D&lt;optimized out&gt;, errp=3D0x7fd24ddfd6=
f8) at ../io/channel.c:210<br>
4=C2=A0 0x00005556d4fa4fc9 in multifd_recv_thread (opaque=3Dopaque@entry=3D=
0x5556d7aff990) at ../migration/multifd.c:1113<br>
5=C2=A0 0x00005556d5414826 in qemu_thread_start (args=3D&lt;optimized out&g=
t;) at ../util/qemu-thread-posix.c:556<br>
6=C2=A0 0x00007fd460662f1b in start_thread (arg=3D0x7fd24ddfe700) at pthrea=
d_create.c:486<br>
7=C2=A0 0x00007fd46059a1a0 in clone () at ../sysdeps/unix/sysv/linux/x86_64=
/clone.S:98<br>
<br>
main thread:<br>
Thread 1 (Thread 0x7fd45f1fbe40 (LWP 1413088)):<br>
0=C2=A0 0x00007fd46066b616 in futex_abstimed_wait_cancelable (private=3D0, =
abstime=3D0x0, clockid=3D0, expected=3D0, futex_word=3D0x5556d7604e80) at .=
./sysdeps/unix/sysv/linux/futex-internal.h:216<br>
1=C2=A0 do_futex_wait (sem=3Dsem@entry=3D0x5556d7604e80, abstime=3D0x0) at =
sem_waitcommon.c:111<br>
2=C2=A0 0x00007fd46066b708 in __new_sem_wait_slow (sem=3Dsem@entry=3D0x5556=
d7604e80, abstime=3D0x0) at sem_waitcommon.c:183<br>
3=C2=A0 0x00007fd46066b779 in __new_sem_wait (sem=3Dsem@entry=3D0x5556d7604=
e80) at sem_wait.c:42<br>
4=C2=A0 0x00005556d5415524 in qemu_sem_wait (sem=3D0x5556d7604e80) at ../ut=
il/qemu-thread-posix.c:358<br>
5=C2=A0 0x00005556d4fa5e99 in multifd_recv_sync_main () at ../migration/mul=
tifd.c:1052<br>
6=C2=A0 0x00005556d521ed65 in ram_load_precopy (f=3Df@entry=3D0x5556d75dfb9=
0) at ../migration/ram.c:4446<br>
7=C2=A0 0x00005556d521f1dd in ram_load (f=3D0x5556d75dfb90, opaque=3D&lt;op=
timized out&gt;, version_id=3D4) at ../migration/ram.c:4495<br>
8=C2=A0 0x00005556d4faa3e7 in vmstate_load (f=3Df@entry=3D0x5556d75dfb90, s=
e=3Dse@entry=3D0x5556d6083070) at ../migration/savevm.c:909<br>
9=C2=A0 0x00005556d4fae7a0 in qemu_loadvm_section_part_end (mis=3D0x5556d60=
82cc0, f=3D0x5556d75dfb90) at ../migration/savevm.c:2475<br>
10 qemu_loadvm_state_main (f=3Df@entry=3D0x5556d75dfb90, mis=3Dmis@entry=3D=
0x5556d6082cc0) at ../migration/savevm.c:2634<br>
11 0x00005556d4fafbd5 in qemu_loadvm_state (f=3D0x5556d75dfb90) at ../migra=
tion/savevm.c:2706<br>
12 0x00005556d4f9ebdb in process_incoming_migration_co (opaque=3D&lt;optimi=
zed out&gt;) at ../migration/migration.c:561<br>
13 0x00005556d542513b in coroutine_trampoline (i0=3D&lt;optimized out&gt;, =
i1=3D&lt;optimized out&gt;) at ../util/coroutine-ucontext.c:186<br>
14 0x00007fd4604ef970 in ?? () from target:/lib64/libc.so.6<br>
<br>
Once the QEMU process falls into the above state in the presence of<br>
the network errors, live migration cannot be canceled gracefully,<br>
leaving the destination VM in the &quot;paused&quot; state, since the QEMU<=
br>
process on the destination side doesn&#39;t respond to the QMP command<br>
&quot;migrate_cancel&quot;.<span class=3D"gmail_default" style=3D"font-fami=
ly:&quot;comic sans ms&quot;,sans-serif"></span></blockquote><div><br></div=
><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"g=
mail_default">Actually, in our case, QEMU on the destination side doesn&#39=
;t respond to</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif" class=3D"gmail_default">the QMP command &quot;query-status&quot; in=
stead of &quot;migrate-cancel&quot;.=C2=A0</div><div style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">See the detail=
s in the mail that was replied to Lukas.=C2=A0</div><div style=3D"font-fami=
ly:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div>=
<div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gm=
ail_default">It is my mistake for not checking the comment,  I&#39;ll fix t=
he comment in</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif" class=3D"gmail_default">the next version. :(</div><div style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,=
204);padding-left:1ex"><br>
<br>
To fix that, make the main thread yield to the main loop after waiting<br>
too long for the multi-channels to finish receiving data during one<br>
iteration. 10 seconds is a sufficient timeout period to set.<br>
<br>
Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" tar=
get=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
---<br>
=C2=A0migration/multifd.c | 10 ++++++++++<br>
=C2=A01 file changed, 10 insertions(+)<br>
<br>
diff --git a/migration/multifd.c b/migration/multifd.c<br>
index b255778855..aca0aeb341 100644<br>
--- a/migration/multifd.c<br>
+++ b/migration/multifd.c<br>
@@ -1228,6 +1228,16 @@ void multifd_recv_sync_main(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_multifd_recv_sync_main_signal(p-&gt=
;id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 do {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_sem_timedwait(&amp;mult=
ifd_recv_state-&gt;sem_sync, 10000) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_in_coroutine()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_co_schedule(qe=
mu_get_current_aio_context(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_coroutine_self());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_coroutine_yie=
ld();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_sem_post(&amp;p-&gt;sem_sync);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0trace_multifd_recv_sync_main(multifd_recv_state-&gt;pac=
ket_num);<br>
-- <br>
2.27.0<br>
<br>
</blockquote></div><div><div style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif" class=3D"gmail_default"></div><div style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks,</div><div s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_de=
fault">Yong</div></div><div><br></div><span class=3D"gmail_signature_prefix=
">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"=
><font face=3D"comic sans ms, sans-serif">Best regards</font></div></div></=
div>

--0000000000001b7c49063bd4cd15--

