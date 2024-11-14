Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E45AD68B2D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBb22-0001p4-LZ; Thu, 14 Nov 2024 09:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBb1t-0001my-1D
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:41:05 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBb1o-00068T-Mp
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:41:04 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ea12c1c78dso23060a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 06:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731595258; x=1732200058;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AX+YhPQDOGx0NB3HnRCM6t66xRMmkoHiMkbUMw2H61M=;
 b=fr9AuJGigjwkKBxWg5tYgrnvCPDaIYwBoT4/1QylQQ5evYLMLUJeZfYAO/I+GDfNql
 EOrsv+QIjQgCBxRS9W3wXMb3VI5e5yZShqnJsluyo+qZFyWwhlSc3iKSbkEtTlGkw+ZF
 xgL8WOaJydZEhhuQLH0RvqN3TogwmYAds0kp+j+2AGmx9tYGYDjH4N0ru/dBSWcHvzKg
 wUP5V5fCfcCIBZfyr0YM6sHNdSK8lNdnzF7RC2x/AmVCJmideThdRqin0TzjwWtUmGz+
 cWn6zCbG5Mzy1M7LgrOx6LroEEQNH9Xb1KsbkcFzgCnVfErbSaWE6fhI1J/vKYHi5q8o
 GU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731595258; x=1732200058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AX+YhPQDOGx0NB3HnRCM6t66xRMmkoHiMkbUMw2H61M=;
 b=Sc/pYbPbyEZq8sdrQ8sGd/mIaqv7uY+O4NC851P6zf3noVGxxQCmx25uXi1wgsn1H1
 ZsrNjcYa4UHyNWuOlYDVtqpwHyulBVChGEvVG45KERFXIfOcDJYOmOWrBFMo9H/W39ah
 mSWBtG1dCIQlJZ6wgljzUeGB6v/qQVirAw24hp04LWLSXMuonhncZCP11v1FUJf8QWgE
 SV6oQCG999EJoMmIWdFzg3uOSRNO4p+kY++BLBZn3NRx9UwN0lVK7GN3YrbPc2LtjY/r
 rYL9pU4uULlhBN09yUdQ9oodgqepqx77Tw60nuGcPOm1pLuAwQAtB63wFPJgh1KueS2g
 ZgoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtLCmaKtJly7NZKwmtOPntubhEddlDr+NDEQ7LrB/f3VEj8HmyGPN1jjpDkklXItG4cUnq6BzoPtyM@nongnu.org
X-Gm-Message-State: AOJu0YxXtaZpYPEO+Rkv2bW8g6VqD5q71KSgouigNtZzza6tBZK17TY3
 KbT2/v2zgFmsUQp98K7sAMxj/GT2XFnpvxzjxF+CwIxwjRAlc6t6ppKK1gj3jJktyMhzSIgBbN4
 517YqqJ+/LZMNQ3PNy9dag0i60vKLeVo+bK2j
X-Google-Smtp-Source: AGHT+IHbTvimpqHKRgZY9L/J3ybF/BsfqC2eQto0Qekh3ykaTA+rDBTusYNn8ZomZ+T13LQI/fta0lCA3c1OYmxDsUo=
X-Received: by 2002:a17:90b:5203:b0:2e0:f896:b806 with SMTP id
 98e67ed59e1d1-2e9e4c73c37mr12677591a91.27.1731595257921; Thu, 14 Nov 2024
 06:40:57 -0800 (PST)
MIME-Version: 1.0
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-2-phil@philjordan.eu>
 <c0983059-ab11-4bc5-ab60-c5b23d1c290e@redhat.com>
 <CAGCz3vv+5y=YGqZaXnGkVj0zA9fX-n3BOZyuPQC+dRMKN8VJZw@mail.gmail.com>
 <CABgObfat1JwiBFNKHK6wwMkW5kgaqZfKJa=rW_9VvEdMWJR75A@mail.gmail.com>
In-Reply-To: <CABgObfat1JwiBFNKHK6wwMkW5kgaqZfKJa=rW_9VvEdMWJR75A@mail.gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Thu, 14 Nov 2024 15:40:46 +0100
Message-ID: <CAGCz3vuEGHyz9PP_-rZ1oh1CSFvwGV6XDfms5X+Hr+_HShPxiA@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 agraf@csgraf.de, 
 peter.maydell@linaro.org, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, balaton@eik.bme.hu
Content-Type: multipart/alternative; boundary="0000000000003e5cc40626e07027"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1035;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x1035.google.com
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

--0000000000003e5cc40626e07027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2024 at 14:27, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Thu, Nov 14, 2024 at 11:32=E2=80=AFAM Phil Dennis-Jordan <lists@philjo=
rdan.eu>
> wrote:
> >> I checked what GTK+ does and, either way, you have to create another
> >> thread: timers are handled with a CFRunLoopTimer, but file descriptors
> >> are polled in a separate thread and sent to the main thread with a
> >> single CFRunLoopSource.  It's a bit nicer that the main thread is in
> >> charge, but it's more complex and probably slower too.
> >
> >
> > Just to clarify: is this supposed to be happening inside the GTK+
> library itself? i.e. GTK should spawn its own thread to poll file
> descriptors that are owned by GTK? (As opposed to the file descriptors us=
ed
> by QEMU's own event loop - what on Linux are eventfds, but on macOS I thi=
nk
> are just pipes*.)
>
> It's what I saw in the GTK+ source code.
>
>
> https://gitlab.gnome.org/GNOME/gtk/-/blob/main/gdk/macos/gdkmacoseventsou=
rce.c?ref_type=3Dheads
>
> > This doesn't describe what I'm seeing when I run with -display gtk on
> macOS. There's no extra thread created. There's a dock icon, but it's
> non-interactive ("Application not responding"), there aren't any menus, a=
nd
> there's no window. QEMU's own simulation is running in the background - I
> can reach a guest via the network. So I guess there's some function in GT=
K
> we're supposed to be calling that will make it crank the native event loo=
p
> on macOS, but this isn't being done?
>
> In theory it should work, with the event source added as soon as GTK+
> is started... aha!
>
> We do not use the GMainContext's poll_func, we use qemu_poll_ns.
> That's the missing part: GDK replaces the poll_func with one that
> calls nextEventMatchingMask:
>
>
> https://gitlab.gnome.org/GNOME/gtk/-/blame/main/gdk/macos/gdkmacoseventso=
urce.c?ref_type=3Dheads#L767
>

Thanks for explaining. That makes sense - I was looking in the Qemu source
for where exactly it was polling the GLib/GTK event handler, now I know why
I couldn't find it. Tracing the poll_func setting, it looks like GTK
expects g_main_context_iteration() to be called regularly, or the main
thread needs to call and block inside g_main_loop_run.

But in QEMU it's not as easy a fix as just going ahead and doing one of
those two things because QEMU semi-replicates the GLib poll function, and
we can't use both at the same time. Right?


> There could be more issues, but I think for now it's better to block
> the GTK+ UI under macOS.
>

OK, I've created a new issue on GitLab where any further decision making
and action can be tracked:

https://gitlab.com/qemu-project/qemu/-/issues/2676

I'm not sure this patchset is the best place for a patch blocking GTK on
macOS, especially if you want it in 9.2.



> [...]
>
> >> As long as it's clear that any handlers that go through the CFRunLoop
> >> run outside the BQL, as is already the case for the Cocoa UI, I see no
> >> problem with this approach.
> >
> > I'm not entirely sure what you're getting at here, to be honest. The UI
> thread can definitely not assume to be holding the BQL all the time; we'd
> have to treat it more like an AIOContext. It could pave the way towards
> putting the display and UI subsystems on their own AIOContext or
> AIOContext-like-thing, rather than hogging the BQL for expensive image
> operations.
>
> Don't worry, I was mostly talking to myself... The UI thread, and more
> specifically any handlers that are called from CFRunLoop instead of
> QEMU's main loop, will have to use mutexes or bql_lock()/bql_unlock(),
> like ui/cocoa.m already does.
>
> In other words, code that interacts with Apple's paravirtualized
> graphics needs to know if it runs from the CFRunLoop or from
> qemu_main().
>

We already have extremely careful threading code in patch 02/15 for safely
interfacing the threading models of the PV Graphics/libdispatch world and
QEMU's world of BQL, AIOs, BHs, and so on.



> > (*By the sound of it, Win32 has an all-UI-calls-on-one-thread
> requirement as well which we may be violating to some degree via the GTK
> and/or SDL backends as well; my adventures with Win32 are almost 20 years
> back now so I'm a bit out of the loop there.)
>
> Hmm, no I don't remember anything like that for Windows but it's also
> been many years for me.
>

Sorry, this was in reference to Daniel Berrang=C3=A9's comment on this rela=
ted
bug: https://gitlab.com/qemu-project/qemu/-/issues/2537#note_2203183775
(QEMU's SDL UI also falls afoul of macOS's threading requirements in some
specific cases.)

--0000000000003e5cc40626e07027
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, 14 Nov 2024 at 14:27, Paolo B=
onzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu=
, Nov 14, 2024 at 11:32=E2=80=AFAM Phil Dennis-Jordan &lt;<a href=3D"mailto=
:lists@philjordan.eu" target=3D"_blank">lists@philjordan.eu</a>&gt; wrote:<=
br>
&gt;&gt; I checked what GTK+ does and, either way, you have to create anoth=
er<br>
&gt;&gt; thread: timers are handled with a CFRunLoopTimer, but file descrip=
tors<br>
&gt;&gt; are polled in a separate thread and sent to the main thread with a=
<br>
&gt;&gt; single CFRunLoopSource.=C2=A0 It&#39;s a bit nicer that the main t=
hread is in<br>
&gt;&gt; charge, but it&#39;s more complex and probably slower too.<br>
&gt;<br>
&gt;<br>
&gt; Just to clarify: is this supposed to be happening inside the GTK+ libr=
ary itself? i.e. GTK should spawn its own thread to poll file descriptors t=
hat are owned by GTK? (As opposed to the file descriptors used by QEMU&#39;=
s own event loop - what on Linux are eventfds, but on macOS I think are jus=
t pipes*.)<br>
<br>
It&#39;s what I saw in the GTK+ source code.<br>
<br>
<a href=3D"https://gitlab.gnome.org/GNOME/gtk/-/blob/main/gdk/macos/gdkmaco=
seventsource.c?ref_type=3Dheads" rel=3D"noreferrer" target=3D"_blank">https=
://gitlab.gnome.org/GNOME/gtk/-/blob/main/gdk/macos/gdkmacoseventsource.c?r=
ef_type=3Dheads</a><br>
<br>
&gt; This doesn&#39;t describe what I&#39;m seeing when I run with -display=
 gtk on macOS. There&#39;s no extra thread created. There&#39;s a dock icon=
, but it&#39;s non-interactive (&quot;Application not responding&quot;), th=
ere aren&#39;t any menus, and there&#39;s no window. QEMU&#39;s own simulat=
ion is running in the background - I can reach a guest via the network. So =
I guess there&#39;s some function in GTK we&#39;re supposed to be calling t=
hat will make it crank the native event loop on macOS, but this isn&#39;t b=
eing done?<br>
<br>
In theory it should work, with the event source added as soon as GTK+<br>
is started... aha!<br>
<br>
We do not use the GMainContext&#39;s poll_func, we use qemu_poll_ns.<br>
That&#39;s the missing part: GDK replaces the poll_func with one that<br>
calls nextEventMatchingMask:<br>
<br>
<a href=3D"https://gitlab.gnome.org/GNOME/gtk/-/blame/main/gdk/macos/gdkmac=
oseventsource.c?ref_type=3Dheads#L767" rel=3D"noreferrer" target=3D"_blank"=
>https://gitlab.gnome.org/GNOME/gtk/-/blame/main/gdk/macos/gdkmacoseventsou=
rce.c?ref_type=3Dheads#L767</a><br></blockquote><div><br></div><div>Thanks =
for explaining. That makes sense - I was looking in the Qemu source for whe=
re exactly it was polling the GLib/GTK event handler, now I know why I coul=
dn&#39;t find it. Tracing the poll_func setting, it looks like GTK expects =
g_main_context_iteration() to be called regularly, or the main thread needs=
 to call and block inside g_main_loop_run.</div><div><br></div><div>But in =
QEMU it&#39;s not as easy a fix as just going ahead and doing one of those =
two things because QEMU semi-replicates the GLib poll function, and we can&=
#39;t use both at the same time. Right?</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
There could be more issues, but I think for now it&#39;s better to block<br=
>
the GTK+ UI under macOS.<br></blockquote><div><br></div><div>OK, I&#39;ve c=
reated a new issue on GitLab where any further decision making and action c=
an be tracked:</div><div><br></div><div><a href=3D"https://gitlab.com/qemu-=
project/qemu/-/issues/2676">https://gitlab.com/qemu-project/qemu/-/issues/2=
676</a></div><div><br></div><div>I&#39;m not sure this patchset is the best=
 place for a patch blocking GTK on macOS, especially if you want it in 9.2.=
<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
[...]<br>
<br>
&gt;&gt; As long as it&#39;s clear that any handlers that go through the CF=
RunLoop<br>
&gt;&gt; run outside the BQL, as is already the case for the Cocoa UI, I se=
e no<br>
&gt;&gt; problem with this approach.<br>
&gt;<br>
&gt; I&#39;m not entirely sure what you&#39;re getting at here, to be hones=
t. The UI thread can definitely not assume to be holding the BQL all the ti=
me; we&#39;d have to treat it more like an AIOContext. It could pave the wa=
y towards putting the display and UI subsystems on their own AIOContext or =
AIOContext-like-thing, rather than hogging the BQL for expensive image oper=
ations.<br>
<br>
Don&#39;t worry, I was mostly talking to myself... The UI thread, and more<=
br>
specifically any handlers that are called from CFRunLoop instead of<br>
QEMU&#39;s main loop, will have to use mutexes or bql_lock()/bql_unlock(),<=
br>
like ui/cocoa.m already does.<br>
<br>
In other words, code that interacts with Apple&#39;s paravirtualized<br>
graphics needs to know if it runs from the CFRunLoop or from<br>
qemu_main().<br></blockquote><div><br></div><div>We already have extremely =
careful threading code in patch 02/15 for safely interfacing the threading =
models of the PV Graphics/libdispatch world and QEMU&#39;s world of BQL, AI=
Os, BHs, and so on.</div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; (*By the sound of it, Win32 has an all-UI-calls-on-one-thread requirem=
ent as well which we may be violating to some degree via the GTK and/or SDL=
 backends as well; my adventures with Win32 are almost 20 years back now so=
 I&#39;m a bit out of the loop there.)<br>
<br>
Hmm, no I don&#39;t remember anything like that for Windows but it&#39;s al=
so<br>
been many years for me.<br></blockquote><div><br></div><div>Sorry, this was=
 in reference to Daniel Berrang=C3=A9&#39;s comment on this related bug: <a=
 href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2537#note_2203183775=
">https://gitlab.com/qemu-project/qemu/-/issues/2537#note_2203183775</a> (Q=
EMU&#39;s SDL UI also falls afoul of macOS&#39;s threading requirements in =
some specific cases.)</div><div><br></div></div></div>

--0000000000003e5cc40626e07027--

