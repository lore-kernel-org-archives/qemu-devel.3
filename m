Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D81D0E6C7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2nUo-0004EP-QS; Mon, 21 Oct 2024 04:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t2nUS-0003sN-KY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t2nUP-0002NP-5q
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729498207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gYvuRQLPjF20XX9/qdpe+IyN+DhFfkJ6GYfh3eOA49E=;
 b=aIrPQBvxS6rzXz02RUTWIHFLJ1TuWZy+iXg0YqJ5XhBDzq1zjHrDT1uL30o+HQHxzVF4NZ
 5ZfE5kGa8r7Mrn/fw57RmzV7PA5HB6MuRmszVmG4SCAhATBMO66Oo3n7VDrhJ9G5CKifZn
 fHFNV2lVojF89CdgrmwJUcrhlgOgmv8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-qWFTArtUOguEjq9Dl4uK6A-1; Mon, 21 Oct 2024 04:10:05 -0400
X-MC-Unique: qWFTArtUOguEjq9Dl4uK6A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbe9885064so73104266d6.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 01:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498205; x=1730103005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gYvuRQLPjF20XX9/qdpe+IyN+DhFfkJ6GYfh3eOA49E=;
 b=Xo41+mY6uQyMQU3d9YklE9N4W8zpA6Zj+WezSne3QJy70dZ16oRxgQBzFGxRdN+CQK
 DkfW0ONoFoI+R5EAHPPDNwnARvkf/K+Hybz2CKWUWCYLbziDLM8f5OBCX6sijokxAnMt
 5FRHz7+CpAlDJwhOViuS1OBN/AxhxnACQxsr28RK/crfp4iCAYvpynCG1Vj/ptO/dMqo
 1Ek/BLbzNC8j1wGTxyNnCPvJgRYrZQLNTo0/UEv2oCpOHagNVJ0rMxn2aByNHwee+cYH
 s6HiIVTtu/Ajf1nj92esjVBx0KpgawTcBA0SbuUhTLTXKuoz0JeAlASI3iZrSQs8a4kd
 qbRw==
X-Gm-Message-State: AOJu0YwQ5COy/delA7bhFeYbho+sRdr/X2myF3hDX3E+RkTruJJi+uUY
 kxCwjWaAn7ii+oKznT7kGngHvdYcD6jFR1ZpuUrNbrVMKMTXY6oFviYzU8GML4PcvBWTRoqXCoj
 QwMms9r10j9DMSszCRkibjITvRTBGXCoYYGuDJ5rujuabexvZnn0alQEsAX2f/2/49EZK2A9aTn
 aREaaZsIHJgqv7NgZsNNfFvg9v9RA=
X-Received: by 2002:a05:6214:4b0e:b0:6c3:5833:260f with SMTP id
 6a1803df08f44-6cde15ded9bmr200122726d6.39.1729498204840; 
 Mon, 21 Oct 2024 01:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ965S5TFSpSzHTsvGBL6tT0E+glSCBETArqvQ4T0vY7GBqVm2rvJsjMYDv78mvHJF1iq3mbxRprO4CKATVxs=
X-Received: by 2002:a05:6214:4b0e:b0:6c3:5833:260f with SMTP id
 6a1803df08f44-6cde15ded9bmr200122576d6.39.1729498204538; Mon, 21 Oct 2024
 01:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <m15xppk9qg.fsf@nimmagadda.net>
In-Reply-To: <m15xppk9qg.fsf@nimmagadda.net>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 21 Oct 2024 11:09:53 +0300
Message-ID: <CAPMcbCqhezaxcBmaW5JrvSR50iuD5SiLYAx7M5S=esD9mGuegg@mail.gmail.com>
Subject: Re: [PATCH] qemu-ga: Fix a SIGSEGV on guest-set-time command
To: Sunil Nimmagadda <sunil@nimmagadda.net>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="0000000000001f1eaf0624f82e0d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--0000000000001f1eaf0624f82e0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Fri, Oct 18, 2024 at 1:14=E2=80=AFPM Sunil Nimmagadda <sunil@nimmagadda.=
net>
wrote:

> qemu-ga on a NetBSD -current VM terminates with a SIGSEGV upon receiving
> 'guest-set-time' command...
>
> Core was generated by `qemu-ga'.
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  0x000000000cd37a40 in ga_pipe_read_str (fd=3Dfd@entry=3D0xffffff922a2=
0,
> str=3Dstr@entry=3D0xffffff922a18)
>     at ../qga/commands-posix.c:88
> 88              *str[len] =3D '\0';
> [Current thread is 1 (process 1112)]
> (gdb) bt
> #0  0x000000000cd37a40 in ga_pipe_read_str (fd=3Dfd@entry=3D0xffffff922a2=
0,
> str=3Dstr@entry=3D0xffffff922a18)
>     at ../qga/commands-posix.c:88
> #1  0x000000000cd37b60 in ga_run_command (argv=3Dargv@entry=3D0xffffff922=
a90,
>     action=3Daction@entry=3D0xcda34b8 "set hardware clock to system time"=
,
> errp=3Derrp@entry=3D0xffffff922a70, in_str=3D0x0)
>     at ../qga/commands-posix.c:164
> #2  0x000000000cd380c4 in qmp_guest_set_time (has_time=3D<optimized out>,
> time_ns=3D<optimized out>,
>     errp=3Derrp@entry=3D0xffffff922ad0) at ../qga/commands-posix.c:304
> #3  0x000000000cd253d8 in qmp_marshal_guest_set_time (args=3D<optimized
> out>, ret=3D<optimized out>, errp=3D0xffffff922b48)
>     at qga/qga-qapi-commands.c:193
> #4  0x000000000cd4e71c in qmp_dispatch (cmds=3Dcmds@entry=3D0xcdf5b18
> <ga_commands>, request=3Drequest@entry=3D0xf3c711a4b000,
>     allow_oob=3Dallow_oob@entry=3Dfalse, cur_mon=3Dcur_mon@entry=3D0x0) a=
t
> ../qapi/qmp-dispatch.c:220
> #5  0x000000000cd36524 in process_event (opaque=3D0xf3c711a79000,
> obj=3D0xf3c711a4b000, err=3D0x0) at ../qga/main.c:677
> #6  0x000000000cd526f0 in json_message_process_token (lexer=3Dlexer@entry=
=3D0xf3c711a79018,
> input=3D0xf3c712072480,
>     type=3Dtype@entry=3DJSON_RCURLY, x=3D28, y=3D1) at
> ../qobject/json-streamer.c:99
> #7  0x000000000cd93860 in json_lexer_feed_char (lexer=3Dlexer@entry=3D0xf=
3c711a79018,
> ch=3D125 '}', flush=3Dflush@entry=3Dfalse)
>     at ../qobject/json-lexer.c:313
> #8  0x000000000cd93a00 in json_lexer_feed (lexer=3Dlexer@entry=3D0xf3c711=
a79018,
>
>     buffer=3Dbuffer@entry=3D0xffffff922d10
> "{\"execute\":\"guest-set-time\"}\n", size=3D<optimized out>)
>     at ../qobject/json-lexer.c:350
> #9  0x000000000cd5290c in json_message_parser_feed (parser=3Dparser@entry=
=3D0xf3c711a79000,
>
>     buffer=3Dbuffer@entry=3D0xffffff922d10
> "{\"execute\":\"guest-set-time\"}\n", size=3D<optimized out>)
>     at ../qobject/json-streamer.c:121
> #10 0x000000000cd361fc in channel_event_cb (condition=3D<optimized out>,
> data=3D0xf3c711a79000) at ../qga/main.c:703
> #11 0x000000000cd3710c in ga_channel_client_event (channel=3D<optimized
> out>, condition=3D<optimized out>, data=3D0xf3c711b2d300)
>     at ../qga/channel-posix.c:94
> #12 0x0000f3c7120d9bec in g_main_dispatch () from
> /usr/pkg/lib/libglib-2.0.so.0
> #13 0x0000f3c7120dd25c in g_main_context_iterate_unlocked.constprop ()
> from /usr/pkg/lib/libglib-2.0.so.0
> #14 0x0000f3c7120ddbf0 in g_main_loop_run () from
> /usr/pkg/lib/libglib-2.0.so.0
> #15 0x000000000cda00d8 in run_agent_once (s=3D0xf3c711a79000) at
> ../qga/main.c:1522
> #16 run_agent (s=3D0xf3c711a79000) at ../qga/main.c:1559
> #17 main (argc=3D<optimized out>, argv=3D<optimized out>) at ../qga/main.=
c:1671
> (gdb)
>
> The commandline options used on the host machine...
> qemu-system-aarch64 \
>    -machine type=3Dvirt,pflash0=3Drom \
>    -m 8G \
>    -cpu host \
>    -smp 8 \
>    -accel hvf \
>    -device virtio-net-pci,netdev=3Dunet \
>    -device virtio-blk-pci,drive=3Dhd \
>    -drive file=3Dnetbsd.qcow2,if=3Dnone,id=3Dhd \
>    -netdev user,id=3Dunet,hostfwd=3Dtcp::2223-:22 \
>    -object rng-random,filename=3D/dev/urandom,id=3Dviornd0 \
>    -device virtio-rng-pci,rng=3Dviornd0 \
>    -serial mon:stdio \
>    -display none \
>    -blockdev
> node-name=3Drom,driver=3Dfile,filename=3D/opt/homebrew/Cellar/qemu/9.0.2/=
share/qemu/edk2-aarch64-code.fd,read-only=3Dtrue
> \
>    -chardev socket,path=3D/tmp/qga_netbsd.sock,server=3Don,wait=3Doff,id=
=3Dqga0 \
>    -device virtio-serial \
>    -device virtconsole,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.0
>
> This patch rectifies the operator precedence while assigning the NUL
> terminator.
>
> Signed-off-by: Sunil Nimmagadda <sunil@nimmagadda.net>
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index c2bd0b4..bb41fa9 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -85,7 +85,7 @@ static ssize_t ga_pipe_read_str(int fd[2], char **str)
>          *str =3D g_realloc(*str, len + n + 1);
>          memcpy(*str + len, buf, n);
>          len +=3D n;
> -        *str[len] =3D '\0';
> +        (*str)[len] =3D '\0';
>      }
>      close(fd[0]);
>      fd[0] =3D -1;
>
>

--0000000000001f1eaf0624f82e0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, O=
ct 18, 2024 at 1:14=E2=80=AFPM Sunil Nimmagadda &lt;<a href=3D"mailto:sunil=
@nimmagadda.net">sunil@nimmagadda.net</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">qemu-ga on a NetBSD -current VM termin=
ates with a SIGSEGV upon receiving<br>
&#39;guest-set-time&#39; command...<br>
<br>
Core was generated by `qemu-ga&#39;.<br>
Program terminated with signal SIGSEGV, Segmentation fault.<br>
#0=C2=A0 0x000000000cd37a40 in ga_pipe_read_str (fd=3Dfd@entry=3D0xffffff92=
2a20, str=3Dstr@entry=3D0xffffff922a18)<br>
=C2=A0 =C2=A0 at ../qga/commands-posix.c:88<br>
88=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *str[len] =3D &#39;\0&#3=
9;;<br>
[Current thread is 1 (process 1112)]<br>
(gdb) bt<br>
#0=C2=A0 0x000000000cd37a40 in ga_pipe_read_str (fd=3Dfd@entry=3D0xffffff92=
2a20, str=3Dstr@entry=3D0xffffff922a18)<br>
=C2=A0 =C2=A0 at ../qga/commands-posix.c:88<br>
#1=C2=A0 0x000000000cd37b60 in ga_run_command (argv=3Dargv@entry=3D0xffffff=
922a90, <br>
=C2=A0 =C2=A0 action=3Daction@entry=3D0xcda34b8 &quot;set hardware clock to=
 system time&quot;, errp=3Derrp@entry=3D0xffffff922a70, in_str=3D0x0)<br>
=C2=A0 =C2=A0 at ../qga/commands-posix.c:164<br>
#2=C2=A0 0x000000000cd380c4 in qmp_guest_set_time (has_time=3D&lt;optimized=
 out&gt;, time_ns=3D&lt;optimized out&gt;, <br>
=C2=A0 =C2=A0 errp=3Derrp@entry=3D0xffffff922ad0) at ../qga/commands-posix.=
c:304<br>
#3=C2=A0 0x000000000cd253d8 in qmp_marshal_guest_set_time (args=3D&lt;optim=
ized out&gt;, ret=3D&lt;optimized out&gt;, errp=3D0xffffff922b48)<br>
=C2=A0 =C2=A0 at qga/qga-qapi-commands.c:193<br>
#4=C2=A0 0x000000000cd4e71c in qmp_dispatch (cmds=3Dcmds@entry=3D0xcdf5b18 =
&lt;ga_commands&gt;, request=3Drequest@entry=3D0xf3c711a4b000, <br>
=C2=A0 =C2=A0 allow_oob=3Dallow_oob@entry=3Dfalse, cur_mon=3Dcur_mon@entry=
=3D0x0) at ../qapi/qmp-dispatch.c:220<br>
#5=C2=A0 0x000000000cd36524 in process_event (opaque=3D0xf3c711a79000, obj=
=3D0xf3c711a4b000, err=3D0x0) at ../qga/main.c:677<br>
#6=C2=A0 0x000000000cd526f0 in json_message_process_token (lexer=3Dlexer@en=
try=3D0xf3c711a79018, input=3D0xf3c712072480, <br>
=C2=A0 =C2=A0 type=3Dtype@entry=3DJSON_RCURLY, x=3D28, y=3D1) at ../qobject=
/json-streamer.c:99<br>
#7=C2=A0 0x000000000cd93860 in json_lexer_feed_char (lexer=3Dlexer@entry=3D=
0xf3c711a79018, ch=3D125 &#39;}&#39;, flush=3Dflush@entry=3Dfalse)<br>
=C2=A0 =C2=A0 at ../qobject/json-lexer.c:313<br>
#8=C2=A0 0x000000000cd93a00 in json_lexer_feed (lexer=3Dlexer@entry=3D0xf3c=
711a79018, <br>
=C2=A0 =C2=A0 buffer=3Dbuffer@entry=3D0xffffff922d10 &quot;{\&quot;execute\=
&quot;:\&quot;guest-set-time\&quot;}\n&quot;, size=3D&lt;optimized out&gt;)=
<br>
=C2=A0 =C2=A0 at ../qobject/json-lexer.c:350<br>
#9=C2=A0 0x000000000cd5290c in json_message_parser_feed (parser=3Dparser@en=
try=3D0xf3c711a79000, <br>
=C2=A0 =C2=A0 buffer=3Dbuffer@entry=3D0xffffff922d10 &quot;{\&quot;execute\=
&quot;:\&quot;guest-set-time\&quot;}\n&quot;, size=3D&lt;optimized out&gt;)=
<br>
=C2=A0 =C2=A0 at ../qobject/json-streamer.c:121<br>
#10 0x000000000cd361fc in channel_event_cb (condition=3D&lt;optimized out&g=
t;, data=3D0xf3c711a79000) at ../qga/main.c:703<br>
#11 0x000000000cd3710c in ga_channel_client_event (channel=3D&lt;optimized =
out&gt;, condition=3D&lt;optimized out&gt;, data=3D0xf3c711b2d300)<br>
=C2=A0 =C2=A0 at ../qga/channel-posix.c:94<br>
#12 0x0000f3c7120d9bec in g_main_dispatch () from /usr/pkg/lib/libglib-2.0.=
so.0<br>
#13 0x0000f3c7120dd25c in g_main_context_iterate_unlocked.constprop () from=
 /usr/pkg/lib/libglib-2.0.so.0<br>
#14 0x0000f3c7120ddbf0 in g_main_loop_run () from /usr/pkg/lib/libglib-2.0.=
so.0<br>
#15 0x000000000cda00d8 in run_agent_once (s=3D0xf3c711a79000) at ../qga/mai=
n.c:1522<br>
#16 run_agent (s=3D0xf3c711a79000) at ../qga/main.c:1559<br>
#17 main (argc=3D&lt;optimized out&gt;, argv=3D&lt;optimized out&gt;) at ..=
/qga/main.c:1671<br>
(gdb) <br>
<br>
The commandline options used on the host machine...<br>
qemu-system-aarch64 \<br>
=C2=A0 =C2=A0-machine type=3Dvirt,pflash0=3Drom \<br>
=C2=A0 =C2=A0-m 8G \<br>
=C2=A0 =C2=A0-cpu host \<br>
=C2=A0 =C2=A0-smp 8 \<br>
=C2=A0 =C2=A0-accel hvf \<br>
=C2=A0 =C2=A0-device virtio-net-pci,netdev=3Dunet \<br>
=C2=A0 =C2=A0-device virtio-blk-pci,drive=3Dhd \<br>
=C2=A0 =C2=A0-drive file=3Dnetbsd.qcow2,if=3Dnone,id=3Dhd \<br>
=C2=A0 =C2=A0-netdev user,id=3Dunet,hostfwd=3Dtcp::2223-:22 \<br>
=C2=A0 =C2=A0-object rng-random,filename=3D/dev/urandom,id=3Dviornd0 \<br>
=C2=A0 =C2=A0-device virtio-rng-pci,rng=3Dviornd0 \<br>
=C2=A0 =C2=A0-serial mon:stdio \<br>
=C2=A0 =C2=A0-display none \<br>
=C2=A0 =C2=A0-blockdev node-name=3Drom,driver=3Dfile,filename=3D/opt/homebr=
ew/Cellar/qemu/9.0.2/share/qemu/edk2-aarch64-code.fd,read-only=3Dtrue \<br>
=C2=A0 =C2=A0-chardev socket,path=3D/tmp/qga_netbsd.sock,server=3Don,wait=
=3Doff,id=3Dqga0 \<br>
=C2=A0 =C2=A0-device virtio-serial \<br>
=C2=A0 =C2=A0-device virtconsole,chardev=3Dqga0,name=3Dorg.qemu.guest_agent=
.0<br>
<br>
This patch rectifies the operator precedence while assigning the NUL<br>
terminator.<br>
<br>
Signed-off-by: Sunil Nimmagadda &lt;<a href=3D"mailto:sunil@nimmagadda.net"=
 target=3D"_blank">sunil@nimmagadda.net</a>&gt;<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index c2bd0b4..bb41fa9 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -85,7 +85,7 @@ static ssize_t ga_pipe_read_str(int fd[2], char **str)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*str =3D g_realloc(*str, len + n + 1);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(*str + len, buf, n);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len +=3D n;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *str[len] =3D &#39;\0&#39;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*str)[len] =3D &#39;\0&#39;;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0close(fd[0]);<br>
=C2=A0 =C2=A0 =C2=A0fd[0] =3D -1;<br>
<br>
</blockquote></div>

--0000000000001f1eaf0624f82e0d--


