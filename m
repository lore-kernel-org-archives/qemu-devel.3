Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C73D2C11E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8L7K-0001iy-TC; Tue, 05 Nov 2024 10:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t8L7G-0001gv-RB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:05:11 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t8L7D-00016W-Jr
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:05:10 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso3735989a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1730819105; x=1731423905;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hZr7eV+xSvIa7Y8YpNFYfVPiKccOIrTfuXW0NMjtw+U=;
 b=b3rSZat3IjM7TEmTgfcLBFSQ/tbj9db8Ta7iMVy/s8ql0FqpUKK0TBiMsNNYlGujP0
 AFKD4RD2yRnV+MnvuA3o2JNTGkI4B4NkRUIo6LKNWEo7+fqo/PnaWAARS9PeXAupcX20
 IUtOiqGOHwZCORfc8oyrmbcFyjTCDBn9h1UACxS7BjXxp5TKMwRctDv3v1aH3bT5+1ko
 Ylqyk/RAH6t7FXRR1BnWlB5hM2BYCHd3Roqvk3cEbNwPpcQNaptp8j6uEAkO/id9720D
 dMCmTTv9clqUUJwOKjztnCT/YF6Rn1vf2Ww10GhbjH6NG0MIKIHLnlnlnbZalKhq6tHC
 XzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819105; x=1731423905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hZr7eV+xSvIa7Y8YpNFYfVPiKccOIrTfuXW0NMjtw+U=;
 b=f9cNNGQ0y+HMYr9urXzr6BD3ddEp9Ksy1x+g2RYudWbGHLzVGtVzMogsIUaoovMbOC
 r9boaXmTCea1DNXYGwIXJsNettv6WEscQ/bPEdkiCUkb2bpdqt0d9NlHcEQ9OuXvioRI
 S47O+Nzr6gtY4uoRDsLukizP54w+lPxj1TWZSeB8kBcSHqU4wRgRC5PRyFQ23rp1pqaE
 v2BLvlY1OJ7fHX2Kkxiy9AKC2UZcwQsCYkoL8L3zvYrnA2BOAdhUieWpLNmKkm74jZS5
 OCA3R5477pEdiczmyOmOXvp6a6auSN8ZtEv+ADfPzZW58nQCWazoLRpIg5wwZ9DL0tjT
 ZdAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgXLW/4l25t1ew171twJY7Ave38rGjweX9+in/mbNS6UL+U2yOI5lEXrV68a52ovVcE2AcYOMpMOxA@nongnu.org
X-Gm-Message-State: AOJu0YzW9HyhRJmhRtKzjhS53nudZgReRMmsQ8Cp3TUnAqU9t8Yx167z
 CTikEqg/r8z7Uq5Z5UVSQCHW4hTtsiowX+Y0GJJ6/gGIBtzAmGDL1L3YRy1Neiw3MRSm2b+mG+i
 pCkjydCWOILxKfAH3ALYOZ7xg6mn+Zm2qMwx/9A==
X-Google-Smtp-Source: AGHT+IEkvFkI4XbADFaLvwJBXeOA2n5ywJhANJfpBFi+9ZiDPx407ciRE/9O33PENMg9saGeuCepvI+jJfNJD72fi64=
X-Received: by 2002:a17:90b:4a07:b0:2e2:92dc:6fd4 with SMTP id
 98e67ed59e1d1-2e92ce74663mr27786193a91.23.1730819105370; Tue, 05 Nov 2024
 07:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20241024200031.80327-1-iii@linux.ibm.com>
 <20241024200031.80327-2-iii@linux.ibm.com>
 <b8080e98-c292-4760-abd8-822a1aafc932@linaro.org>
In-Reply-To: <b8080e98-c292-4760-abd8-822a1aafc932@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 5 Nov 2024 08:04:54 -0700
Message-ID: <CANCZdfq77uHf83QeoJ5QbGn5oj9pMTOHO-wiO6huCRXoCTLS0Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] gdbstub: Allow the %d placeholder in the socket path
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f25bab06262bb9f9"
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000f25bab06262bb9f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 7:41=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 10/24/24 20:59, Ilya Leoshkevich wrote:
> > Just like for QEMU_LOG_FILENAME, replace %d with PID in the GDB socket
> > path. This allows running multi-process applications with, e.g.,
> > export QEMU_GDB=3D/tmp/qemu-%d.sock. Currently this is not possible,
> > since the first process will cause the subsequent ones to fail due to
> > not being able to bind() the GDB socket.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >   gdbstub/user.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/gdbstub/user.c b/gdbstub/user.c
> > index 0b4bfa9c488..cdf5affae15 100644
> > --- a/gdbstub/user.c
> > +++ b/gdbstub/user.c
> > @@ -316,9 +316,19 @@ static bool gdb_accept_socket(int gdb_fd)
> >
> >   static int gdbserver_open_socket(const char *path)
> >   {
> > +    g_autoptr(GString) buf =3D g_string_new("");
> >       struct sockaddr_un sockaddr =3D {};
> > +    char *pid_placeholder;
> >       int fd, ret;
> >
> > +    pid_placeholder =3D strstr(path, "%d");
> > +    if (pid_placeholder !=3D NULL) {
> > +        g_string_append_len(buf, path, pid_placeholder - path);
> > +        g_string_append_printf(buf, "%d", getpid());
>
> qemu_get_thread_id().
>
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>

Same.

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000f25bab06262bb9f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 5, 2024 at 7:41=E2=80=AFA=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 10/24/24 20:59, Ilya Leoshkevich wrote:<br>
&gt; Just like for QEMU_LOG_FILENAME, replace %d with PID in the GDB socket=
<br>
&gt; path. This allows running multi-process applications with, e.g.,<br>
&gt; export QEMU_GDB=3D/tmp/qemu-%d.sock. Currently this is not possible,<b=
r>
&gt; since the first process will cause the subsequent ones to fail due to<=
br>
&gt; not being able to bind() the GDB socket.<br>
&gt; <br>
&gt; Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.co=
m" target=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0gdbstub/user.c | 10 ++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 10 insertions(+)<br>
&gt; <br>
&gt; diff --git a/gdbstub/user.c b/gdbstub/user.c<br>
&gt; index 0b4bfa9c488..cdf5affae15 100644<br>
&gt; --- a/gdbstub/user.c<br>
&gt; +++ b/gdbstub/user.c<br>
&gt; @@ -316,9 +316,19 @@ static bool gdb_accept_socket(int gdb_fd)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int gdbserver_open_socket(const char *path)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 g_autoptr(GString) buf =3D g_string_new(&quot;&quot;);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sockaddr_un sockaddr =3D {};<br>
&gt; +=C2=A0 =C2=A0 char *pid_placeholder;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd, ret;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 pid_placeholder =3D strstr(path, &quot;%d&quot;);<br>
&gt; +=C2=A0 =C2=A0 if (pid_placeholder !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append_len(buf, path, pid_placeh=
older - path);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_append_printf(buf, &quot;%d&quot=
;, getpid());<br>
<br>
qemu_get_thread_id().<br>
<br>
Otherwise,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></blockqu=
ote><div><br></div><div>Same.</div><div><br></div><div>Reviewed-by: Warner =
Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div=
>=C2=A0</div></div></div>

--000000000000f25bab06262bb9f9--

