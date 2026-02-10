Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80F7EB2718
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpv14-0007qR-Um; Tue, 10 Feb 2026 16:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpv13-0007qJ-Ue
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:11:25 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vpv11-0002xM-IH
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:11:25 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-352f60d6c2fso3087258a91.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:11:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770757882; cv=none;
 d=google.com; s=arc-20240605;
 b=hOkqRuV5+VNVSepQ4EOWl3MnzG+8+hnIeyMJGjads45iWGmf0YyN+cCpDchtTFxTwq
 pcgMjQ8buqXBpu50gyIE0gomZRS0MtHGUp1mm9CpGT1V/lwE7yUSCBIubbY677szes3q
 oO3R7LSInr++L/HFFU15x1mnIV+GUp2Ix0E40aq6ijbSU66WW/KAWsF/dI/ZPpfesC4B
 l/GAUcVQNUSdjcFjLm9NnU3acw1KCOwjez0odao0aAQTbHk04bwX0MIdjnFelTseDAiN
 LsQDjlHwaC83Ru+pydIAoB8d6cr+FVatjsRhAaxVIhg5IcwtqFDJnc0gGxlbzGCz02PW
 L0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c/EHen+O7kH943lmLOOgibUNCQgACgCI6BP05eOsIqc=;
 fh=KfNA4twi5yKjZolFArD6GKxNbv+5932nte5njHWJM0I=;
 b=YYeixeltpOIur6fisoH05W6mNcSR0ZjEYqk0dok140qXIjg8OAtPKyhDussxXi3kAn
 f09AFcdqzcc1Gpqaaic2hO4cWKqfCTnewuFGEvgv90vk7fnn7h0x104xaVKXii4L7vV2
 eZFV40KKjXWTRU9wlPezLO0ScQLpInb4OCTgJXpbt8fyEyRUt6XR1jlg8xtpf8xWQKXQ
 3XalE4wIykAkzwc/lUXT/8V2qXOmp3ih3ex58iuEmy3VGzcfj+xV5kJY9poBNYrzp9ss
 l/ME5GQcYIfe3h1fPnu4u/UFqw2eq31+57vN1o6wzWfTuxFQFR6eIPmuy6/Svk+U303z
 ovrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770757882; x=1771362682;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c/EHen+O7kH943lmLOOgibUNCQgACgCI6BP05eOsIqc=;
 b=JAvWQVBR1+0yfo4VyY816p2hFO4E4PVvjI/gdi1UTVjlUVFW1/E+NNJZP7H6ADfhax
 8oAal3X7jdy4IELJlDR3R5t5bLml3IL6CzyumA0HklWxB10miK8XJf5lY/aaOSYgOYoa
 bgHYL7T1G8TwmT1yLdabMgKqstm92d9iLu7HtVKod7cfiKneFp6R6uhFPqHtd1QmNFin
 73s8MZW9IHEpnsfzPEO9nGTXnS+WruXtGaLD7ycEvZhlNSbC7pV0XFpf45IktB2Hwolr
 4BTmtpd1Mwu3kGNhfVRmvUTgW5KwFuJVqGIGUIc8ZalJDmWXsc6LVCpe5o4rCee99Cia
 KsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770757882; x=1771362682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/EHen+O7kH943lmLOOgibUNCQgACgCI6BP05eOsIqc=;
 b=YcP1y6oWaIsb4eqdjf8fsIA/tW041TvB32oo9yT5KGAen2Aw6+p5u0ZX/+PSoDMEZZ
 RHnFVHCX/J1S8d0fpztunu++imzu/xwrsR9jmN7yoyld753heGf9r3jZMEc4aww0skch
 UyZocIbJjAb3ufrDmd5SJ3TF9v0JpZW8LZJ/pY5O3ARZ/63Y3n7SX3sOKSO89LMSlXSH
 ojdrU+0Zj4oQ0Z4A/3GMpc6YDQ/AfGvITE1WIFipa+Fze4YB+y62qSsc+rBtyMljYDN1
 mJ7jEEQnBbziLlaFYA+IpuwNymf5osk869lr7LxahD+2fk0A4b63kOShwn1mJ7GWKsNU
 OR/Q==
X-Gm-Message-State: AOJu0YwoBbfGunLkGWqi0QceCof7yT7guT+lvwgzf6hgaWWKlzZtIqaG
 zrER+p8h5cxSDRRoUY0j37GmXivah385F6tcxw6WoHY+h5i2OGaKRjoUXMbsly1o6OpbnKaPsW3
 hcxT7y8SsS7TbYPC3GUizLnnO+Y5/TIS0ICdletrUTA==
X-Gm-Gg: AZuq6aKN1xkBk6bjLyRPWGu22sCKorNv/JC6ll5t9qeoWy17eWubYZ+CLS5XBGvQ38a
 cb28PUawxPjScIEi0iiKG+37uQmaSasKdUk5dGiMzIu44QPWdAUDsUm/KhJLtf0jbbjWNVyS5Iu
 W/3mKmsIU7paaBSu1kWdAOA+UfOPLyldTQ3VyPGxnZIu7BrDMa9J5UnPV2WcOuS/B8MQDp9J4pI
 /Kmz3AmQHlG9UerKfQnCfEDsGHD4N99scdCGQNURhiLax43gwChwr4dbikotslB6EbalogXpxwj
 MXyjUYFVAzqs8pmeGA==
X-Received: by 2002:a17:90a:d006:b0:34a:b1ea:6648 with SMTP id
 98e67ed59e1d1-3567afcbd67mr428117a91.2.1770757882038; Tue, 10 Feb 2026
 13:11:22 -0800 (PST)
MIME-Version: 1.0
References: <20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com>
 <20260210-bsd-user-rm-openbsd-netbsd-v1-3-8b8b0f50c29d@bsdimp.com>
 <def06a55-ab7f-4a2b-b43d-f9571c26a5a1@linaro.org>
In-Reply-To: <def06a55-ab7f-4a2b-b43d-f9571c26a5a1@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Feb 2026 14:11:11 -0700
X-Gm-Features: AZwV_QjeLvALypTMCXOOKMqez8-Hf0X23beYCTIdi-NNvA9C1ZcEy7XUGmAidnw
Message-ID: <CANCZdfpcVBpLMeZ3Wpbj_g+-_NpBd=mBKLfRQjp33X3GxtD-rQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] bsd-user: Remove NetBSD supprot
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
Content-Type: multipart/alternative; boundary="0000000000008ad9e2064a7eb2c0"
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102d.google.com
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

--0000000000008ad9e2064a7eb2c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 1:56=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 10/2/26 16:06, Warner Losh wrote:
> > Remove the NetBSD specific code form bsd-user. It's not been maintained
> > in any meaningful way since it was introduced to the tree in 2008. It
> > hasn't been connected to the build since 2021, and last time (in 2023) =
I
> > tried to mock-up the meson support it needed, it failed to build. While
> > there were some out-of-tree work, I've not been able to connect with
> > that code.
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/netbsd/host-os.h           |  25 ---
> >   bsd-user/netbsd/os-strace.h         |   1 -
> >   bsd-user/netbsd/strace.list         | 145 --------------
> >   bsd-user/netbsd/syscall_nr.h        | 373
> ------------------------------------
> >   bsd-user/netbsd/target_os_elf.h     | 148 --------------
> >   bsd-user/netbsd/target_os_siginfo.h |  82 --------
> >   bsd-user/netbsd/target_os_signal.h  |  69 -------
> >   bsd-user/netbsd/target_os_stack.h   |  56 ------
> >   bsd-user/netbsd/target_os_thread.h  |  25 ---
> >   bsd-user/qemu.h                     |   8 -
> >   bsd-user/strace.c                   |  17 --
> >   bsd-user/syscall_defs.h             |  13 --
> >   12 files changed, 962 deletions(-)
>
> Typo "support" in $Subject.
>

<blush> OK. Will fix.


> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

--0000000000008ad9e2064a7eb2c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 10,=
 2026 at 1:56=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 10/2/26 16:06, Warner Losh wrote:<br=
>
&gt; Remove the NetBSD specific code form bsd-user. It&#39;s not been maint=
ained<br>
&gt; in any meaningful way since it was introduced to the tree in 2008. It<=
br>
&gt; hasn&#39;t been connected to the build since 2021, and last time (in 2=
023) I<br>
&gt; tried to mock-up the meson support it needed, it failed to build. Whil=
e<br>
&gt; there were some out-of-tree work, I&#39;ve not been able to connect wi=
th<br>
&gt; that code.<br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/netbsd/host-os.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 25 ---<br>
&gt;=C2=A0 =C2=A0bsd-user/netbsd/os-strace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A01 -<br>
&gt;=C2=A0 =C2=A0bsd-user/netbsd/strace.list=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 145 --------------<br>
&gt;=C2=A0 =C2=A0bsd-user/netbsd/syscall_nr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
373 ------------------------------------<br>
&gt;=C2=A0 =C2=A0bsd-user/netbsd/target_os_elf.h=C2=A0 =C2=A0 =C2=A0| 148 -=
-------------<br>
&gt;=C2=A0 =C2=A0bsd-user/netbsd/target_os_siginfo.h |=C2=A0 82 --------<br=
>
&gt;=C2=A0 =C2=A0bsd-user/netbsd/target_os_signal.h=C2=A0 |=C2=A0 69 ------=
-<br>
&gt;=C2=A0 =C2=A0bsd-user/netbsd/target_os_stack.h=C2=A0 =C2=A0|=C2=A0 56 -=
-----<br>
&gt;=C2=A0 =C2=A0bsd-user/netbsd/target_os_thread.h=C2=A0 |=C2=A0 25 ---<br=
>
&gt;=C2=A0 =C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 -<br>
&gt;=C2=A0 =C2=A0bsd-user/strace.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 --<br>
&gt;=C2=A0 =C2=A0bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 13 --<br>
&gt;=C2=A0 =C2=A012 files changed, 962 deletions(-)<br>
<br>
Typo &quot;support&quot; in $Subject.<br></blockquote><div><br></div><div>&=
lt;blush&gt; OK. Will fix.</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
</blockquote></div></div>

--0000000000008ad9e2064a7eb2c0--

