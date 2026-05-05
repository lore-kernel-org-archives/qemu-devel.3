Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C2BFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 22:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOdS-0001WC-4W; Tue, 05 May 2026 18:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wKOdP-0001Vz-9k
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:52:59 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wKOdM-00080c-Pb
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:52:59 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36528851d7dso1531055a91.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778021575; cv=none;
 d=google.com; s=arc-20240605;
 b=gSCEQ8OoUVhL+4RWniZPbYfC/pcwlS1UefPqCbU/torLLYuaJVN8+qfUxhVIo8vImx
 zCXVfPDLsyJ8VufZS4qvhdkm7sBeJdacwE1p19MJ4jD1goZQlLaA8p7i/VoVuZKyvHTg
 YTzPUT/JXxcR3JUmRxJoXtheJvUlImRo4c44b8LJULxYYOTBkV35dOxDhR8ETmokBoEQ
 vJzvetkUk5xi39SZhU9jEql9Hq+xnMUL7yl+ikmwXvKOAz/QEyptXbb6aeWF1DX39/XE
 5Jo9idUsccuDxSx02gPQwHr7sfjXtbhOctiDkQPkYz05xChJtjspGLLoCTx7ooXglKvJ
 iYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xRYK2+ZJOtgfRSWjqJZu+JUjUEIXxHzlTFDGUi4c13s=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=MlwOA7/Ybdr+hp7859MgkQDofFcWJaD71CC9r5HxkIajP1X90JH76ECetWc7/7xHl+
 CwKB3HS22Wl9c8nUkw4YwvEOgN9ZcaJaEn/dg/XEQh60tP9FsGVk+lPwoTbdgiIobaYO
 AaS6TofzK+NYWmoObFc6TyTNAW4rmw9DqyH8mU7OfGAa52e2OVdLZZsXbb7ZW0GWjeLa
 tPp0t10UcAAGHIaPmAXFqEd3U3VKabTgRq3UgREYvn9IbtDLUhzP+nvGMFn2xOUiGhfA
 sZ94UtHiQrAzoP/An/fRsRMxVooFxIXOmTHpzHt0IFCuGqxA1R4CIgwYjy0CXFS0oKV1
 9Sgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778021575; x=1778626375;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xRYK2+ZJOtgfRSWjqJZu+JUjUEIXxHzlTFDGUi4c13s=;
 b=Bb7vZiqdMs3lE6GUzfGSIcIdt1y7P8ivrTDIxdgomK9jTwAZluZK7l751XVRtRqMK0
 PQNKiYCBuN/V7iv9ElCE3SmHlaYS0ib7qX8oBISYH3C/DMXt8mBg6kCl17d2l6ndqTQk
 65OsW3lRtx1Zkdmm0Fg3PcYK1W124Rs2YW/ImcZlc3HFFXIqLCdbYNMuUGKYSZOU8oUe
 7nNsLuIXiBSijNM3FaxBcOfGXgi7zYi3Mo7TkVCx00rpflOwsAr+aSJNG/uZVu8FoCzA
 X14iA84bBsmIuziEMlU+dltAKVq3qojqnc7SNIskCb/BQRphiu5/Kq8viFvImbK23c1/
 ijsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778021575; x=1778626375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRYK2+ZJOtgfRSWjqJZu+JUjUEIXxHzlTFDGUi4c13s=;
 b=Rf1XAwrz7XFBgiebHVS1NXayrwOZh1b9AOKNYgUl+GZ+ay8OBZshgIaNp29UgKxh7B
 PhzpEaNLIcTD4Gl9iqZ/sVAvzRUWft3uEPROIsbKxPt9Rws2CEzCI8r8HPySvtOVl4Rb
 NUYLD5kjG3CBZKfekpDtLUW7lu0O3WCSFycs7kzw1iWmBo049zHkBdhCftB05gW5jwkT
 sePA/LYJAluTw3CLX+cGPNoilyDJuF88U6fOPGYKPjYdYK52UkNniZ9zOH2lua/oTzR8
 bQ+NV+xB33iTltSxtU4PEgbVeL6oeYsdER8yXij2DXENbV/YAzydwjPcStY+00WlYw6v
 YfEA==
X-Gm-Message-State: AOJu0Ywp5CgrJiA6LEBpUxeNlBJCp1vdoqL7RaK6hC6JFkugF91pRwJG
 T1Xa74eAAbmvLOaFszyBo1egqtEm0LEHb/+yqQwrcv6mwbSixsSS7i6YKqEyagGm2xDlqBl89Ha
 fDOcw9+O5qq/FkLdcb7dQE54ZzgB6p3IOmUWNiPWYtXJfoUy1P3hh/t8=
X-Gm-Gg: AeBDietlNNAXLopXRN5ninql1kjROeVB6jT7gwhmvKZNdu1fB2hp90lOv4JtxMW12Ed
 InkXjLR2VpgCdyk4Xldji4rDsEvTH8h1fIPhkwhrHflyAk8OFk9SN7XYahwqoYCtdHE36bd1Fe5
 8ECUqVaIxZ5q6l8TqtHFx5yYExSDtYyOUio4xmitZvaDFA1HdNeDK/ZaBkwyIjaT68TV3w8N7i3
 ZMB5GcejN8AXXvdnUvMb0KFbgy9hlwSUd0dxhmzaK2n1Ikwi1MzsKadBDCIT6Bee4jWf6IRZi03
 Ul6WjgSNYpG/mJkmeQ==
X-Received: by 2002:a17:90b:5448:b0:35e:d012:5a39 with SMTP id
 98e67ed59e1d1-365abe8c4e4mr717696a91.14.1778021575132; Tue, 05 May 2026
 15:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260430162941.584960-1-mohamedaymanworkspace@gmail.com>
 <20260501161106.818373-1-mohamedaymanworkspace@gmail.com>
 <c7a83814-1ce7-4092-8df5-0a845bdf5b41@linaro.org>
In-Reply-To: <c7a83814-1ce7-4092-8df5-0a845bdf5b41@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 5 May 2026 16:52:44 -0600
X-Gm-Features: AVHnY4LSjs2EBSjI6uN60CjptM0_lJQS9hWC4sDdaYI26-EzODiFuJ77CeC9ccA
Message-ID: <CANCZdfqofJ8J-0UQgRVvaM3C=swpbF=jfw8kApntNUnJBLSwew@mail.gmail.com>
Subject: Re: [PATCH v2] bsd-user: remove cached host page size and rely on
 qemu_real_host_page_size()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006390f9065119e885"
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102a.google.com
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

--0000000000006390f9065119e885
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 4:40=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 5/1/26 11:11, Mohamed Ayman wrote:
> > +++ b/bsd-user/qemu.h
> > @@ -44,12 +44,10 @@ extern char **environ;
> >   #include "accel/tcg/vcpu-state.h"
> >
> >   #include "qemu-os.h"
> > -/*
> > - * TODO: Remove these and rely only on qemu_real_host_page_size().
> > - */
> > -extern uintptr_t qemu_host_page_size;
> > -extern intptr_t qemu_host_page_mask;
> > -#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
> > +
> > +#define HOST_PAGE_SIZE        MAX(qemu_real_host_page_size(),
> TARGET_PAGE_SIZE)
> > +#define HOST_PAGE_MASK        ((intptr_t)~(HOST_PAGE_SIZE - 1))
> > +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), HOST_PAGE_SIZE)
>
> This is a bad idea, hiding the true size of the host page.
>
> There are oodles of corner cases that require the exact size of the host
> page.  If you
> hide this in a macro, you are going to stumble over them all of the time.
>

Yes. I've thought about writing test cases for maybe aarch64 16k page
binaries on a 4k x86_64 mahine.
I don't suppose there's tests like that for linux-user today?

Thinking about it for a couple of minutes, I think not hiding it, and
keeping the chunk that was deleted will
make sense. But I've not pondered all the edge cases in detail yet.

Warner

--0000000000006390f9065119e885
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 5, =
2026 at 4:40=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 5/1/26 11:11, Mohamed Aym=
an wrote:<br>
&gt; +++ b/bsd-user/qemu.h<br>
&gt; @@ -44,12 +44,10 @@ extern char **environ;<br>
&gt;=C2=A0 =C2=A0#include &quot;accel/tcg/vcpu-state.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu-os.h&quot;<br>
&gt; -/*<br>
&gt; - * TODO: Remove these and rely only on qemu_real_host_page_size().<br=
>
&gt; - */<br>
&gt; -extern uintptr_t qemu_host_page_size;<br>
&gt; -extern intptr_t qemu_host_page_mask;<br>
&gt; -#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)<b=
r>
&gt; +<br>
&gt; +#define HOST_PAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 MAX(qemu_real_host_=
page_size(), TARGET_PAGE_SIZE)<br>
&gt; +#define HOST_PAGE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((intptr_t)~(HOST_P=
AGE_SIZE - 1))<br>
&gt; +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), HOST_PAGE_SIZE)<br>
<br>
This is a bad idea, hiding the true size of the host page.<br>
<br>
There are oodles of corner cases that require the exact size of the host pa=
ge.=C2=A0 If you <br>
hide this in a macro, you are going to stumble over them all of the time.<b=
r></blockquote><div><br></div><div>Yes. I&#39;ve thought about writing test=
 cases for maybe aarch64 16k page binaries on a 4k x86_64 mahine.</div><div=
>I don&#39;t suppose there&#39;s tests like that for linux-user today?</div=
><div><br></div><div>Thinking about it for a couple of minutes, I think not=
 hiding it, and keeping the chunk that was deleted will</div><div>make sens=
e. But I&#39;ve not pondered all the edge cases in detail yet.</div><div><b=
r></div><div>Warner</div></div></div>

--0000000000006390f9065119e885--

