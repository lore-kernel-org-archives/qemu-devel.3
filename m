Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41047CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbj2m-000086-Uf; Mon, 22 Jun 2026 14:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wbj2l-00007T-2u
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 14:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wbj2j-00089c-2F
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 14:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782151603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bHj7EECHHKcSOIRLXYad/7G+QxnGcNm4VS5J5qwACjc=;
 b=BH5LSec5cnZ7esfbDIACwVHlML28ENPsSboYUft4XQLrU2Dx9cTJ8b3xn6nJ9rbFwFDBPB
 D9ZTDJIBLnnK1g7KanCzM0CJHp/Ub2g1Jf9rHPqbzyNZeD/W1FrOocAwc5Ok3YIdGsVfHY
 6Ex/4TrOurnEkcjk4yeNH4TgmcN7sEU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-MoFPZifAN_KmdiirObX7NQ-1; Mon, 22 Jun 2026 14:06:42 -0400
X-MC-Unique: MoFPZifAN_KmdiirObX7NQ-1
X-Mimecast-MFC-AGG-ID: MoFPZifAN_KmdiirObX7NQ_1782151602
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8dd6d58b606so105477786d6.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782151602; cv=none;
 d=google.com; s=arc-20240605;
 b=N0+C1n+kO/lz06+pGpNry427ik8SeMD7Pm1hQtKdD5+hYn22xNQ0MuJDQvs2DIeIxH
 Y69e0otzA+JWbSab7mcpLpsDT7GD/2q+hB1YHYh7HHpIgB8bJfq62WZ3qmz+OUl7MzCb
 T9a2AIqwcQ3NH5RDnKDZaGQBJporndhC04kBYg64Uly8O4q66BByeZRMl8H5wlJIUSCI
 ROdBlc3WMCuBMrqbOZxNZpSl+6X+oNaUwp/kmzqBunCpL1vflF/xJp1MENItSvRRsurz
 zz7mDQa9DXy8ouE8XLyxsMItCukNtzu9hx7xSvoh5GNzYAyQQ4TI3LRhYcAa3Ffwn4fY
 sb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bHj7EECHHKcSOIRLXYad/7G+QxnGcNm4VS5J5qwACjc=;
 fh=KmxliCzzZRrU4tz2MTsspdQtxWXo/cgKYLm1DR6MHrI=;
 b=lCSYVmj+08s1LQ1FzL+n0BjpyQiq27pbXFaNmPjP7Y3D4bojlF4xXP+kLiNoekhLFt
 mZ13+EL13OFGuWQgx3qvBep934okq2WX5WDUgNWiK6OTP2l5kG/QXZoLBncodPOu0xBH
 hf0qzbymltWVjkgGj+/fGrcoxWJgM1pDFDWkqP720H2JcRuSMMZ/jfDZ8aj7fMII+DFa
 iuULguz1OCo5oo++4yKMz5MNCcKK4mK3p0Bz5UYSl0j2k0t2bs8D+coUimGLAaSn6oSl
 HgG1vs42iigXViGxZMZHWErgdRgj+Ke96awZUHDRYV7YHL+FP8xtmtIZBstOhJ2rpniO
 6Tgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782151602; x=1782756402; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bHj7EECHHKcSOIRLXYad/7G+QxnGcNm4VS5J5qwACjc=;
 b=Zil/OdWs7Q++wW/S/8NiOzspeLjlbD6fAAX3nj06NodjKggA1rg0VR6W+ODAYd3xnn
 iZ2Cg5xdzpt9qfF5fKeIrKDr3wZFxZwM3GNVpM4JyKovaGKUHPO6QCYRedPncJk5CFrn
 Gm0Xm2phuvL7NAM7LXfCpQ70XuE6cr4ZRd1JbIor9zd2OFFAKpL7uWy+cgHb5FZgM4W3
 JIqYQEJ5a7Lgz3HunNuF3vJJOTdKeY6zlkEYVrqsTBe+1ID9F8gAZdM3k3O+IDxo7LSh
 Uw4yyAXapNetej9RdY28llkseyToXeXI6hPloXqlsDT0W3znL+gYMCZNPHOAGv5AsDpQ
 /bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782151602; x=1782756402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHj7EECHHKcSOIRLXYad/7G+QxnGcNm4VS5J5qwACjc=;
 b=fvX+glPPjzYKOznucYBYlA/8pb1b7DiYPU9tKRS61Xw3bDjF9QbB7pq9USxllyjlVd
 Z+803w+MZhb9UZ2bgqistGz+NJ7ElVAGgPPH+NGAJLDaXm8AQx7GFtEsK3+wuxeWokhS
 NzqvBSbiFKGaotE52qCSjJb6d+tSvHL2v2NQzCQ9F4jOqicZqF4xE361vNApMgDXt/VT
 NTSUszAjasrS+Qk2SMNcijWEsNmRRi/eYPKFcm0VIpa3PcsLNIr+3RZWuWsKc2MHNIVJ
 zX1F5QF7hLvrWcBDwWoT7RMHrlxY5knup7RtQRaCF7OpHAAMC9pw1MEbDDR52Je0w93D
 /9xw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtLHbHQMW30qNZ+ijI6Sorn08SVaLB3vYm3mv9KEvHAWT02lbruc2UQnKLlLrLfLwDpZwBTWFwRi7B@nongnu.org
X-Gm-Message-State: AOJu0YxQx/9eTs+4ZX4jmHjdoZtBfJNwUmnIS8mACUuG/8ZnW+nyKStE
 A8ZjH0EgCSTdlOaYgEWorX5aKLHaV1ajDULJSSoU1eNyoPjnT48Sy9Ba2Wa7GlttfQ6XCniZdgv
 jbrQ19LTHL3mEXJN5m4lWdqteWPX6dLOdfs23Z8MyVyv6qDP4QBQXeTkxhwQrZq28XM3m2DjRdp
 I4Z/7IGUlmSKrMSgVanqfCoFDlFDuIEQ8=
X-Gm-Gg: AfdE7ckialuXtlUuHKTBY/xfVAxQEEBm85bHRd+Qjid54KfprvJ9pvJeBRzI7Rjrn74
 3wyuQyalXkpns3LqK9lxElUCoSHt6vB+h4hcsOCBx7vGEUdeY0h+SBkzKmnRwhLUPKSyAKKhxnk
 f/aTG0dw0YJWU2PoCY2y9FnS2OSR5eaEVAWUqS1ikonDzSv2HVvxtOEFmqvZjMc4qROb7g0Q==
X-Received: by 2002:a05:6214:459b:b0:8cc:dfd2:b929 with SMTP id
 6a1803df08f44-8dea40c6f97mr337439456d6.29.1782151601532; 
 Mon, 22 Jun 2026 11:06:41 -0700 (PDT)
X-Received: by 2002:a05:6214:459b:b0:8cc:dfd2:b929 with SMTP id
 6a1803df08f44-8dea40c6f97mr337438146d6.29.1782151600846; Mon, 22 Jun 2026
 11:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260619180121.2982356-1-polina.vishneva@virtuozzo.com>
 <20260619180121.2982356-5-polina.vishneva@virtuozzo.com>
 <CAPMcbCphbipUTQm5d+A3hPJMLXVo3jBVxxzCii8axjTyQtBGSQ@mail.gmail.com>
 <3fc4bc652795f349d0f82bd30c7aaac9323fd14f.camel@virtuozzo.com>
In-Reply-To: <3fc4bc652795f349d0f82bd30c7aaac9323fd14f.camel@virtuozzo.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 22 Jun 2026 21:06:29 +0300
X-Gm-Features: AVVi8CfmXSaC39Fd-X2tH-6EUSpIp4PRQaiFG9mHsP99z41XODKL244NU6tx7zw
Message-ID: <CAPMcbCod4Pv20=Wvw+Yd=2yY3WcRLFY0LXGpdsOtF95aBaZP+w@mail.gmail.com>
Subject: Re: [PATCH 4/4] qga: Add AF_VSOCK channel support on Windows
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Den Lunev <den@virtuozzo.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "philmd@mailo.com" <philmd@mailo.com>, 
 "berrange@redhat.com" <berrange@redhat.com>,
 "michael.roth@amd.com" <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000001ac9510654db81e8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000001ac9510654db81e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 5:17=E2=80=AFPM Polina Vishneva <
polina.vishneva@virtuozzo.com> wrote:

> On Mon, 2026-06-22 at 12:00 +0300, Kostiantyn Kostiuk wrote:
> > Hi Polina,
> >
> > First of all, thanks for your patches.
> >
> > Before reviewing this patch, I want to ask: why is it needed?
> >
> > I understand the patch "qemu-sockets: Enable AF_VSOCK on Windows",
> > but AF_VSOCK has the same behavior on Linux and Windows.
> > I expected that we could totally reuse the POSIX part, so just move it =
to
> > common with
> > some defines like:
> > ```
> > #ifdef G_OS_WIN32
> >         in_ch =3D g_io_channel_win32_new_fd(in_fd);
> > #else
> >         in_ch =3D g_io_channel_unix_new(in_fd);
> > #endif
> > ```
> >
> > We tested our driver with SSH over VSOCK, and standard Linux SSH works
> > well.
> > So, what is the difference in this case that you add win32-specific cod=
e
> > for VSOCK?
>
> 1. There's no shared GIOChannel path on Windows to #ifdef into.
> channel-posix.c is built on GIOChannels + g_io_add_watch();
> channel-win32.c is built on overlapped I/O over a Win32 HANDLE with a
> reader thread and a custom GSource. There's no in_ch =3D g_io_channel_*()
> line to wrap. vsock is the first GIOChannel-based channel on Windows.
>
>
I know that currently windows virtio-sock driver does not
support overlapped I/O.
But what if we add it and reuse the same logic with overlapped I/O over a
Win32 HANDLE?
What do you think?

In general, my wish is to simplify new source code and reuse existing one.


> 2. g_io_channel_win32_new_fd() is the wrong constructor, as it's for CRT
> fds, not sockets. GLib wants g_io_channel_win32_new_socket() (it sets up
> WSAEventSelect). And qemu_accept()/socket_listen() return a CRT fd
> wrapping a SOCKET via _open_osfhandle(), so we recover it with
> _get_osfhandle(), which is also why teardown needs the explicit
> qemu_close_socket_osfhandle() ordering, to avoid a double closesocket().
>
> 3. Winsock disconnect detection differs: GLib passes FD_READ|FD_CLOSE as
> one G_IO_IN and Winsock reports FD_CLOSE only once, so a peer that
> writes-then-closes never yields G_IO_HUP and the listener hangs
> half-open. That's why the MSG_PEEK probe logic is required on Windows,
> while on POSIX poll()/epoll() reports POLLHUP reliably and doesn't need
> it.
>
> Best regards,
> Polina.
>
> >
> > Best Regards,
> > Kostiantyn Kostiuk.
> >
> >
> > On Fri, Jun 19, 2026 at 9:03=E2=80=AFPM Polina Vishneva <
> > polina.vishneva@virtuozzo.com> wrote:
> >
> > > Add vsock-listen channel mode to the Windows guest agent.
> > >
> > > The listen/accept path uses the standard QEMU socket helpers
> > > (socket_parse(), socket_listen(), qemu_accept()) and plugs the
> resulting
> > > SOCKET into the GMainLoop via g_io_channel_win32_new_socket().
> > >
> > > Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> > > ---
> > >  docs/interop/qemu-ga.rst |   4 +
> > >  qga/channel-win32.c      | 257 ++++++++++++++++++++++++++++++++-----=
--
> > >  qga/main.c               |   6 +
> > >  3 files changed, 222 insertions(+), 45 deletions(-)
> > >
>

--0000000000001ac9510654db81e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 22,=
 2026 at 5:17=E2=80=AFPM Polina Vishneva &lt;<a href=3D"mailto:polina.vishn=
eva@virtuozzo.com">polina.vishneva@virtuozzo.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 2026-06-22 at 12:00=
 +0300, Kostiantyn Kostiuk wrote:<br>
&gt; Hi Polina,<br>
&gt; <br>
&gt; First of all, thanks for your patches.<br>
&gt; <br>
&gt; Before reviewing this patch, I want to ask: why is it needed?<br>
&gt; <br>
&gt; I understand the patch &quot;qemu-sockets: Enable AF_VSOCK on Windows&=
quot;,<br>
&gt; but AF_VSOCK has the same behavior on Linux and Windows.<br>
&gt; I expected that we could totally reuse the POSIX part, so just move it=
 to<br>
&gt; common with<br>
&gt; some defines like:<br>
&gt; ```<br>
&gt; #ifdef G_OS_WIN32<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in_ch =3D g_io_channel_win32_new_fd(i=
n_fd);<br>
&gt; #else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in_ch =3D g_io_channel_unix_new(in_fd=
);<br>
&gt; #endif<br>
&gt; ```<br>
&gt; <br>
&gt; We tested our driver with SSH over VSOCK, and standard Linux SSH works=
<br>
&gt; well.<br>
&gt; So, what is the difference in this case that you add win32-specific co=
de<br>
&gt; for VSOCK?<br>
<br>
1. There&#39;s no shared GIOChannel path on Windows to #ifdef into.<br>
channel-posix.c is built on GIOChannels + g_io_add_watch();<br>
channel-win32.c is built on overlapped I/O over a Win32 HANDLE with a<br>
reader thread and a custom GSource. There&#39;s no in_ch =3D g_io_channel_*=
()<br>
line to wrap. vsock is the first GIOChannel-based channel on Windows.<br>
<br></blockquote><div><br></div><div>I know that currently windows virtio-s=
ock driver does not support=C2=A0overlapped I/O.</div><div>But what if=C2=
=A0we add it and reuse the same logic with=C2=A0overlapped I/O over a Win32=
 HANDLE?</div><div>What do you think?</div><div><br><span class=3D"Asgive n=
g" style=3D"border-style:none;background:none">In general, my wish is</span=
> to simplify new source code and reuse existing one. </div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
2. g_io_channel_win32_new_fd() is the wrong constructor, as it&#39;s for CR=
T<br>
fds, not sockets. GLib wants g_io_channel_win32_new_socket() (it sets up<br=
>
WSAEventSelect). And qemu_accept()/socket_listen() return a CRT fd<br>
wrapping a SOCKET via _open_osfhandle(), so we recover it with<br>
_get_osfhandle(), which is also why teardown needs the explicit<br>
qemu_close_socket_osfhandle() ordering, to avoid a double closesocket().<br=
>
<br>
3. Winsock disconnect detection differs: GLib passes FD_READ|FD_CLOSE as<br=
>
one G_IO_IN and Winsock reports FD_CLOSE only once, so a peer that<br>
writes-then-closes never yields G_IO_HUP and the listener hangs<br>
half-open. That&#39;s why the MSG_PEEK probe logic is required on Windows,<=
br>
while on POSIX poll()/epoll() reports POLLHUP reliably and doesn&#39;t need=
<br>
it.<br>
<br>
Best regards,<br>
Polina.<br>
<br>
&gt; <br>
&gt; Best Regards,<br>
&gt; Kostiantyn Kostiuk.<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Jun 19, 2026 at 9:03=E2=80=AFPM Polina Vishneva &lt;<br>
&gt; <a href=3D"mailto:polina.vishneva@virtuozzo.com" target=3D"_blank">pol=
ina.vishneva@virtuozzo.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Add vsock-listen channel mode to the Windows guest agent.<br>
&gt; &gt; <br>
&gt; &gt; The listen/accept path uses the standard QEMU socket helpers<br>
&gt; &gt; (socket_parse(), socket_listen(), qemu_accept()) and plugs the re=
sulting<br>
&gt; &gt; SOCKET into the GMainLoop via g_io_channel_win32_new_socket().<br=
>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Polina Vishneva &lt;<a href=3D"mailto:polina.vishn=
eva@virtuozzo.com" target=3D"_blank">polina.vishneva@virtuozzo.com</a>&gt;<=
br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 docs/interop/qemu-ga.rst |=C2=A0 =C2=A04 +<br>
&gt; &gt;=C2=A0 qga/channel-win32.c=C2=A0 =C2=A0 =C2=A0 | 257 +++++++++++++=
+++++++++++++++++++-------<br>
&gt; &gt;=C2=A0 qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A06 +<br>
&gt; &gt;=C2=A0 3 files changed, 222 insertions(+), 45 deletions(-)<br>
&gt; &gt; <br>
</blockquote></div></div>

--0000000000001ac9510654db81e8--


