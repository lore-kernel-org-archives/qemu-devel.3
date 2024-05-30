Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07244C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 16:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCiGA-0001GO-6S; Thu, 30 May 2024 12:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sCiG7-0001Dx-LN
 for qemu-devel@nongnu.org; Thu, 30 May 2024 12:04:07 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sCiG5-0007D1-7m
 for qemu-devel@nongnu.org; Thu, 30 May 2024 12:04:07 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-24c9f630e51so532449fac.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717085042; x=1717689842; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xdgm8QJcYXkeE8cQB8B/98ao0otS8q4UmA1QQQjk34A=;
 b=Xz+aiY5yOR+8OYuL077AOJZAJKDgdWSRUgxL2BDcZujEIizbh/k117ZM4IItNX9kN0
 psEZc5hZaapSlJczJBKwYfFzwc34Lsmm+55SsuwjW2ToyzpOd2JQcRN140OcQg1waVxn
 DpizX4Z5pAm2eHWE2/5eJ4gw5Oty2A77yC6E6NsuOXLKebXKkPO1e/jf6TlFUnI+iUMp
 k1CBKjwAoCoyCNnR++AuMx23qNbWm3Sb/PsNuG1uatVhaOA9zjLTsFJzb4ZK0ITjWWgv
 VmnkubGdC2SxntSiWtQw1TwuSAew5BZJxSujF9YbFL6hykQdYbV27c/IpMuO3vhLxvTO
 ZKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717085042; x=1717689842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xdgm8QJcYXkeE8cQB8B/98ao0otS8q4UmA1QQQjk34A=;
 b=Aw64hzs9VtGiFLREI4YUkC6KC6U0ltj5eVzi0Fj/rTM4lvY5qY6ILM0mH/zeIkP+i/
 Y50MZqR0qTiHXRozzqXamrED4JBRlzQ7ysuTiyOounfOZnEzvHFnZCrXR5s7llWHInMr
 3AS9JcsIJA4htq+3tWlDmRmfBeJ2vAucXiAfyWN5sVeCH223jX4GCsvTRuCtJ2s0JE4j
 BXJ/porofaNmK2KyYYdD8u4Ck0mMg0d3pRUbAra1Xj9r6fDrqBGvqZlSq/5OtKrWHoAo
 VgeqNVY2xXROG2QGMbcVlknNNpQgqkD8/JtcXqDQ2ZeuuvU+mMh7IV/8VbA770fXJPKs
 ct0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkSdKETS9BNVCcCjrzs0Iba50+JxSz+3ZBfBeG6gdOIl6lxcANv9vhzvzRRZHExCEukoN1czJpq1pd7H4msY56P6n+HKY=
X-Gm-Message-State: AOJu0YxzChJb9DVJdtfXNjj0Zq2yhv+6f1Sxtp2GXQQ2advV3HRZuMu9
 jvUUMsUEgUe+c0X78pnBO0q8EVIJSj4mXHSaaX0uoXHs3HyITb/xfjupYQht3lOrIV6ew090TG6
 fUt2WfkArrQmwm73ptboh3EvisRQ=
X-Google-Smtp-Source: AGHT+IFQWyOomzKQCbU9BBoXZ7u87zB0GGYD8VBcJZHiYoYl3Sgq/+4u1rTX/Anf+T5PBVPQQG8DIgJyWjIMGyFgXbg=
X-Received: by 2002:a05:6871:2885:b0:24f:d159:ea2 with SMTP id
 586e51a60fabf-25060bf912amr2865545fac.28.1717085042222; Thu, 30 May 2024
 09:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <CAFEAcA9aum5+z3sr-OpCHZRWxFtZGS_kGOjjmRh7H1TBTZuFRQ@mail.gmail.com>
 <CACBuX0Q3TMvmxuuAHfVY679wpKF+0N+-aw=A7PLiba7ndc5v+w@mail.gmail.com>
 <CAFEAcA9XvHOF22m-9ZFtKLAaShE5gVjsy-AxQyBwVAkRZ2QW6g@mail.gmail.com>
 <CACBuX0Rzh9g4BEei8=vk0vOr7BwEZqom4LBGLcqH_omnBy9fLQ@mail.gmail.com>
 <CAFEAcA9V1J4w00PJB+Ct_3z2KGHcfGs_C8OqX8mdnW_bLxbUiQ@mail.gmail.com>
 <CACBuX0SR2cuFu+GaFGxp5rD_b+4HnNHfhQx2Csdw8L8QN+T7AA@mail.gmail.com>
 <87zfs7d7i6.fsf@draig.linaro.org>
In-Reply-To: <87zfs7d7i6.fsf@draig.linaro.org>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Thu, 30 May 2024 11:03:50 -0500
Message-ID: <CACBuX0T6aPHEQzgqDJs14NvOTPj9ngQ4Avw-dZ8yn4q4fGbnqA@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000fdaf6f0619ae0356"
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=dmamfmgm@gmail.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.006, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000fdaf6f0619ae0356
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 3:33=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Cord Amfmgm <dmamfmgm@gmail.com> writes:
>
> > On Tue, May 28, 2024 at 11:32=E2=80=AFAM Peter Maydell <peter.maydell@l=
inaro.org>
> wrote:
> >
> >  On Tue, 28 May 2024 at 16:37, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> >  >
> >  > On Tue, May 28, 2024 at 9:03=E2=80=AFAM Peter Maydell <
> peter.maydell@linaro.org> wrote:
> >  >>
> >  >> On Mon, 20 May 2024 at 23:24, Cord Amfmgm <dmamfmgm@gmail.com>
> wrote:
> >  >> > On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter Maydell <
> peter.maydell@linaro.org> wrote:
> <snip>
> >  >> > And here's an example buffer of length 0 -- you probably already
> know what I'm going to do here:
> >  >> >
> >  >> > char buf[0];
> >  >> > char * CurrentBufferPointer =3D &buf[0];
> >  >> > char * BufferEnd =3D &buf[-1]; // "address of the last byte in th=
e
> buffer"
> >  >> > // The OHCI Host Controller than advances CurrentBufferPointer
> like this: CurrentBufferPointer +=3D 0
> >  >> > // After the transfer:
> >  >> > // CurrentBufferPointer =3D &buf[0];
> >  >> > // BufferEnd =3D &buf[-1];
> >  >>
> >  >> Right, but why do you think this is valid, rather than
> >  >> being a guest software bug? My reading of the spec is that it's
> >  >> pretty clear about how to say "zero length buffer", and this
> >  >> isn't it.
> >  >>
> >  >> Is there some real-world guest OS that programs the OHCI
> >  >> controller this way that we're trying to accommodate?
> >  >
> >  >
> >  > qemu versions 4.2 and before allowed this behavior.
> >
> >  So? That might just mean we had a bug and we fixed it.
> >  4.2 is a very old version of QEMU and nobody seems to have
> >  complained in the four years since we released 5.0 about this,
> >  which suggests that generally guest OS drivers don't try
> >  to send zero-length buffers in this way.
> >
> >  > I don't think it's valid to ask for a *popular* guest OS as a
> proof-of-concept because I'm not an expert on those.
> >
> >  I didn't ask for "popular"; I asked for "real-world".
> >  What is the actual guest code you're running that falls over
> >  because of the behaviour change?
> >
> >  More generally, why do you want this behaviour to be
> >  changed? Reasonable reasons might include:
> >   * we're out of spec based on reading the documentation
> >   * you're trying to run some old Windows VM/QNX/etc image,
> >     and it doesn't work any more
> >   * all the real hardware we tested behaves this way
> >
> >  But don't necessarily include:
> >   * something somebody wrote and only tested on QEMU happens to
> >     assume the old behaviour rather than following the hw spec
> >
> >  QEMU occasionally works around guest OS bugs, but only as
> >  when we really have to. It's usually better to fix the
> >  bug in the guest.
> >
> > It's not, and I've already demonstrated that real hardware is consisten=
t
> with the fix in this patch.
> >
> > Please check your tone.
>
> I don't think that is a particularly helpful comment for someone who is
> taking the time to review your patches. Reading through the thread I
> didn't see anything that said this is how real HW behaves but I may well
> have missed it. However you have a number of review comments to address
> so I suggest you spin a v2 of the series to address them and outline the
> reason to accept an out of spec transaction.
>
>
I did a rework of the patch -- see my email from May 20, quoted below --
and I was under the impression it addressed all the review comments. Did I
miss something? I apologize if I did.

> index acd6016980..71b54914d3 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
ohci_ed *ed)
>          if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
>              len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
>          } else {
> -            if (td.cbp > td.be) {
> -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> +            if (td.cbp - 1 > td.be) {  /* rely on td.cbp !=3D 0 */


> Reading through the thread I didn't see anything that said this is how
real HW behaves but I may well have missed it.

This is what I wrote regarding real HW:

Results are:

 qemu 4.2   | qemu HEAD  | actual HW
------------+------------+------------
 works fine | ohci_die() | works fine

Would additional verification of the actual HW be useful?

Peter posted the following which is more specific than "qemu 4.2" -- I
agree this is most likely the qemu commit where this thread is focused:

> Almost certainly this was commit 1328fe0c32d54 ("hw: usb: hcd-ohci:
> check len and frame_number variables"), which added these bounds
> checks. Prior to that we did no bounds checking at all, which
> meant that we permitted cbp=3Dbe+1 to mean a zero length, but also
> that we permitted the guest to overrun host-side buffers by
> specifying completely bogus cbp and be values. The timeframe is
> more or less right (2020), at least.
>
> -- PMM

Where does the conversation go from here? I'm under the impression I have
provided objective answers to all the questions and resolved all review
comments on the code. I receive the feedback that I missed something -
please restate the question?

--000000000000fdaf6f0619ae0356
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 30, 2024 at 3:33=E2=80=AF=
AM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D=
"_blank">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm=
@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Tue, May 28, 2024 at 11:32=E2=80=AFAM Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org=
</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 On Tue, 28 May 2024 at 16:37, Cord Amfmgm &lt;<a href=3D"mailto:=
dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; wrote:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; On Tue, May 28, 2024 at 9:03=E2=80=AFAM Peter Maydell &lt;<=
a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@=
linaro.org</a>&gt; wrote:<br>
&gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;&gt; On Mon, 20 May 2024 at 23:24, Cord Amfmgm &lt;<a href=
=3D"mailto:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt;=
 wrote:<br>
&gt;=C2=A0 &gt;&gt; &gt; On Mon, May 20, 2024 at 12:05=E2=80=AFPM Peter May=
dell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">pete=
r.maydell@linaro.org</a>&gt; wrote:<br>
&lt;snip&gt;<br>
&gt;=C2=A0 &gt;&gt; &gt; And here&#39;s an example buffer of length 0 -- yo=
u probably already know what I&#39;m going to do here:<br>
&gt;=C2=A0 &gt;&gt; &gt;<br>
&gt;=C2=A0 &gt;&gt; &gt; char buf[0];<br>
&gt;=C2=A0 &gt;&gt; &gt; char * CurrentBufferPointer =3D &amp;buf[0];<br>
&gt;=C2=A0 &gt;&gt; &gt; char * BufferEnd =3D &amp;buf[-1]; // &quot;addres=
s of the last byte in the buffer&quot;<br>
&gt;=C2=A0 &gt;&gt; &gt; // The OHCI Host Controller than advances CurrentB=
ufferPointer like this: CurrentBufferPointer +=3D 0<br>
&gt;=C2=A0 &gt;&gt; &gt; // After the transfer:<br>
&gt;=C2=A0 &gt;&gt; &gt; // CurrentBufferPointer =3D &amp;buf[0];<br>
&gt;=C2=A0 &gt;&gt; &gt; // BufferEnd =3D &amp;buf[-1];<br>
&gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;&gt; Right, but why do you think this is valid, rather than<=
br>
&gt;=C2=A0 &gt;&gt; being a guest software bug? My reading of the spec is t=
hat it&#39;s<br>
&gt;=C2=A0 &gt;&gt; pretty clear about how to say &quot;zero length buffer&=
quot;, and this<br>
&gt;=C2=A0 &gt;&gt; isn&#39;t it.<br>
&gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;&gt; Is there some real-world guest OS that programs the OHC=
I<br>
&gt;=C2=A0 &gt;&gt; controller this way that we&#39;re trying to accommodat=
e?<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; qemu versions 4.2 and before allowed this behavior.<br>
&gt;<br>
&gt;=C2=A0 So? That might just mean we had a bug and we fixed it.<br>
&gt;=C2=A0 4.2 is a very old version of QEMU and nobody seems to have<br>
&gt;=C2=A0 complained in the four years since we released 5.0 about this,<b=
r>
&gt;=C2=A0 which suggests that generally guest OS drivers don&#39;t try<br>
&gt;=C2=A0 to send zero-length buffers in this way.<br>
&gt;<br>
&gt;=C2=A0 &gt; I don&#39;t think it&#39;s valid to ask for a *popular* gue=
st OS as a proof-of-concept because I&#39;m not an expert on those.<br>
&gt;<br>
&gt;=C2=A0 I didn&#39;t ask for &quot;popular&quot;; I asked for &quot;real=
-world&quot;.<br>
&gt;=C2=A0 What is the actual guest code you&#39;re running that falls over=
<br>
&gt;=C2=A0 because of the behaviour change?<br>
&gt;<br>
&gt;=C2=A0 More generally, why do you want this behaviour to be<br>
&gt;=C2=A0 changed? Reasonable reasons might include:<br>
&gt;=C2=A0 =C2=A0* we&#39;re out of spec based on reading the documentation=
<br>
&gt;=C2=A0 =C2=A0* you&#39;re trying to run some old Windows VM/QNX/etc ima=
ge,<br>
&gt;=C2=A0 =C2=A0 =C2=A0and it doesn&#39;t work any more<br>
&gt;=C2=A0 =C2=A0* all the real hardware we tested behaves this way<br>
&gt;<br>
&gt;=C2=A0 But don&#39;t necessarily include:<br>
&gt;=C2=A0 =C2=A0* something somebody wrote and only tested on QEMU happens=
 to<br>
&gt;=C2=A0 =C2=A0 =C2=A0assume the old behaviour rather than following the =
hw spec<br>
&gt;<br>
&gt;=C2=A0 QEMU occasionally works around guest OS bugs, but only as<br>
&gt;=C2=A0 when we really have to. It&#39;s usually better to fix the<br>
&gt;=C2=A0 bug in the guest.<br>
&gt;<br>
&gt; It&#39;s not, and I&#39;ve already demonstrated that real hardware is =
consistent with the fix in this patch.<br>
&gt;<br>
&gt; Please check your tone.<br>
<br>
I don&#39;t think that is a particularly helpful comment for someone who is=
<br>
taking the time to review your patches. Reading through the thread I<br>
didn&#39;t see anything that said this is how real HW behaves but I may wel=
l<br>
have missed it. However you have a number of review comments to address<br>
so I suggest you spin a v2 of the series to address them and outline the<br=
>
reason to accept an out of spec transaction.<br>
<br></blockquote><div><br></div><div>I did a rework of the patch -- see my =
email from May 20, quoted below -- and I was under the impression it addres=
sed all the review comments. Did I miss something? I apologize if I did.</d=
iv><div><br></div><div>&gt; index acd6016980..71b54914d3 100644</div>&gt; -=
-- a/hw/usb/hcd-ohci.c<br>&gt; +++ b/hw/usb/hcd-ohci.c<br>&gt; @@ -941,8 +9=
41,8 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)<br>=
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((td.cbp &amp; 0xfffff000) !=3D (=
<a href=3D"http://td.be" target=3D"_blank">td.be</a> &amp; 0xfffff000)) {<b=
r>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D (<a href=3D"=
http://td.be" target=3D"_blank">td.be</a> &amp; 0xfff) + 0x1001 - (td.cbp &=
amp; 0xfff);<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (td.cbp &gt; <a href=3D"http://=
td.be" target=3D"_blank">td.be</a>) {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, <a=
 href=3D"http://td.be" target=3D"_blank">td.be</a>);<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (td.cbp - 1 &gt; <a href=3D"http://td.be"=
 target=3D"_blank">td.be</a>) { =C2=A0/* rely on td.cbp !=3D 0 */</div><div=
 class=3D"gmail_quote"><br></div><div class=3D"gmail_quote"><br></div><div =
class=3D"gmail_quote">&gt; Reading through the thread I didn&#39;t see anyt=
hing that said this is how real HW behaves but I may well have missed it.</=
div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">This is=
 what I wrote regarding real HW:</div><div class=3D"gmail_quote"><br></div>=
<div class=3D"gmail_quote">Results are:<br><br>=C2=A0qemu 4.2 =C2=A0 | qemu=
 HEAD =C2=A0| actual HW<br>------------+------------+------------<br>=C2=A0=
works fine | ohci_die() | works fine<br></div><div class=3D"gmail_quote"><b=
r></div><div class=3D"gmail_quote">Would additional verification of the act=
ual HW be useful?</div><div class=3D"gmail_quote"><br></div><div class=3D"g=
mail_quote">Peter posted the following which is more specific than &quot;qe=
mu 4.2&quot; -- I agree this is most likely the qemu commit where this thre=
ad is focused:</div><div class=3D"gmail_quote"><br></div><div class=3D"gmai=
l_quote">&gt; Almost certainly this was commit 1328fe0c32d54 (&quot;hw: usb=
: hcd-ohci:<br>&gt; check len and frame_number variables&quot;), which adde=
d these bounds<br>&gt; checks. Prior to that we did no bounds checking at a=
ll, which<br>&gt; meant that we permitted cbp=3Dbe+1 to mean a zero length,=
 but also<br>&gt; that we permitted the guest to overrun host-side buffers =
by<br>&gt; specifying completely bogus cbp and be values. The timeframe is<=
br>&gt; more or less right (2020), at least.<br>&gt;=C2=A0<br>&gt; -- PMM<b=
r></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Whe=
re does the conversation go from here? I&#39;m under the impression I have =
provided objective answers to all the questions and resolved all review com=
ments on the code. I receive the feedback that I missed something - please =
restate the question?</div></div>

--000000000000fdaf6f0619ae0356--

