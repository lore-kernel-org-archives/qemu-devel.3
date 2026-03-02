Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0488EB3638
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 21:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxAi4-0001v5-T1; Mon, 02 Mar 2026 16:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vxAi1-0001ut-OV
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:21:45 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vxAhz-0003Rk-FC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:21:45 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso36652375ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 13:21:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772486501; cv=none;
 d=google.com; s=arc-20240605;
 b=lYzpQMVKJSMxXH/UwvOVWmirY9DrUsYbJWl4imPknBXfVNm0di5kGHTOZ23Jp3WSqC
 UBNokKJ6Ml9IgbTaP1IRMPWCkNiaS1YmZEuQu8vfM5AlxVDksSuUtGc0BD6J+0/kqOOm
 plZKQA1NPaWNe/c4hEDoS+eutPBOf9n7pJVRqLOs38WWq8nNbhAusu0DQdSsjANPmVqs
 5bK/6/wW9MRD0w/4klsa6VTVa8HM1coM1A1I7hLFzsESbHYwubqnKfkm1cyYUnOK0p2f
 JyVqZuhfo/+248mPwkuj37lUWuxfIVL2Rpbn0k3h6FMp3A8Hn6Fih98hF676PrjlCC1B
 pxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Sg+xfEwA6MvGytdG/rA7xP5iUDiOhMHzZ64iHi+PzSg=;
 fh=n/2g6091IoMWMMiR3h5fkPEPud19wotKT44jRnRvKvQ=;
 b=DQ7C5i3ZAqHOSUgIxN4QiuG9O2rcECRhMxNPy2dhfRrFiNYMdG7j1MX+dLbnsAKenr
 TjX0AE/ui3QWu6Hs6Sqv+Ze8sft9a4jRIqkMDBweSvTPby32NFJPUh25JrcCH+ylZKiR
 7EwaObUQhe1iB9uxLvq75JL1mg4Bm7X8fSBHdnpprIq3l/CAZX/smfLui/pw1YP57kKm
 LUfIH/yux5DBfm6w+e17XjfM2M4Vh0VphpVjY1dWXa2dRsaWrUt4wH0cYyKWxiddPKzi
 0XQ74orTJURbqBB6OpphZZ6I68FPTBvAbS8TXTM0+t3NOn2fhnyBpT+buEODnJSPl3qI
 SH2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772486501; x=1773091301;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sg+xfEwA6MvGytdG/rA7xP5iUDiOhMHzZ64iHi+PzSg=;
 b=fAVkemN/ki3MwLx2YN6FdN8nH2RXAjhklxJXFXRj/7j6Gc+Mg5mYPAMR53rWSXXNOt
 9XimgGk59Ubxz7FhOzMm9wlXXRgBLYzpM80jA+hJ8u3SNYluFq2lD7fPVB83RlSCHl1I
 ODAcADrPWIFHiKkipG8Lzp7t5RcombRVxhoQ/mPmNGYPUbU/Jv3yC+XBWQyBQ0TrGVKE
 mmWq3QAUfgVXybuqhVo3LdSTPnYp1wFvKn8HcLGodMv1I5a/tvDVyiW7NAmYJmNZcODc
 Z4lsar96lvjzREw6li4C90FxhBCEGd1O0s27wxDmKRdm5oHIgGsijmkIJrlCTWrXsG76
 eqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772486501; x=1773091301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sg+xfEwA6MvGytdG/rA7xP5iUDiOhMHzZ64iHi+PzSg=;
 b=ZAfkrmWtlUBDgQYtqif1rLtoLwbV0GMJ8a1gBJi6H6HLTulEX4ZgD6Zje6CY564o+K
 ussRAP4RgyVZKwDWmk0z7wnS7gOYpL9XkWX0QUsnjBqSjIBHeIJTcJXkdtFSqoHoXsE0
 i7Fr+MRuODru4uY8kJusq1LsRTtiwgzOHt0iv8ANHfiTz8arGGXRCG3//2pb8VM4JIfX
 x5EDTSHDasDxYiVP366PzkTdjAo2XLxGG+kzriy9PdWL/5GpsU5aKN1bkAbUfvUpvgKG
 F29DkkCH26Y0TBMwfY7Qn4d4ttn9LF1b1naUfHTzWiwATpy9WrtQPS4qie3/JFArEF8x
 3qLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCLHTR9pzEaeKWxsGd5+a8ZcVfRm8jV2ZVJfjC81V8I+e6U2fmrodpef2d4AOww/G+G84JZblIHlLp@nongnu.org
X-Gm-Message-State: AOJu0Yyc00QeqfOxqreRFTLUCQyrp+n5cJlalNJlZpiXGLpRh3Qh3+NA
 1PW7ZaIdB1U3LBVW4VH7HIfEONyC84QEx7AzMF9+6eoA5APK9970wtMiG2w0gXkTc2hNbU61TV+
 pg/KolLibta2j3Of9XuIC9DfODWMGDjLCn1CqbySpxA==
X-Gm-Gg: ATEYQzzCq+t62Xl6Blc7aUsKS7j/Zh1SbR4innD1aFX9oui0cHS8RHcuUwdn4IL96tv
 kqmOnL2IFOW7mdLIUax/5NkkHR8uUpiKWMG0zkuQ82aZqhndUARKVUlj0CyT2HbVpCaF4Z/5dwV
 ov8agn9RzjfvB/xfX8kqXXtBSvQcSvg4MimzE3FHtpjmRn73GCeThbF7iMm6s0q1sP9YFirqPqV
 RNQdU1lcABOlIKT3wK5lY5NEW4dK5hwCp/F4cxEU/row/TcJ/M4HXLzOFZV38tB+eY3a3fDnseA
 9S/8+UgoGCPC4WOaUA==
X-Received: by 2002:a17:903:1a0f:b0:2ae:525a:f971 with SMTP id
 d9443c01a7336-2ae525afc1cmr47139565ad.23.1772486501013; Mon, 02 Mar 2026
 13:21:41 -0800 (PST)
MIME-Version: 1.0
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
 <b280d4ad-522d-4d28-b203-b87f114d0d81@epfl.ch>
 <CANCZdfqML5j5TLOQn2vCNAgxF9iWrL=92x_+oL4_NOUUJqt+-Q@mail.gmail.com>
 <535bf813-7926-40d4-b0de-3cd181dbcfa5@linaro.org>
In-Reply-To: <535bf813-7926-40d4-b0de-3cd181dbcfa5@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 2 Mar 2026 14:21:29 -0700
X-Gm-Features: AaiRm53drF_1ybopvEdQ2Ssdf5XixbXTPoMLBTJqdxqU-79wdjo8xSHt0aJw--w
Message-ID: <CANCZdfqdC4xn3eQ35MjY09PLr1-hDoNgJ3quZfqU8UcrshhuVw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] linux-user: make syscall emulation interruptible
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org, 
 alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu, 
 berrange@redhat.com
Content-Type: multipart/alternative; boundary="000000000000432917064c112ce9"
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x634.google.com
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

--000000000000432917064c112ce9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 10:50=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@linaro.org> wrote:

> On 3/2/26 7:15 AM, Warner Losh wrote:
> >
> >
> > On Mon, Mar 2, 2026 at 7:03=E2=80=AFAM Florian Hofhammer
> > <florian.hofhammer@epfl.ch <mailto:florian.hofhammer@epfl.ch>> wrote:
> >
> >     The syscall emulation code previously wasn't interruptible via
> >     cpu_loop_exit(), as this construct relies on a longjmp target that
> >     is not
> >     live anymore in the syscall handling code. Consequently, longjmp()
> would
> >     operate on a (potentially overwritten) stale jump buffer. This patc=
h
> >     adds an additional
> >     setjmp and the necessary handling around it to make longjmp() (and =
by
> >     proxy cpu_loop_exit() safe to call even within a syscall context.
> >
> >     Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch
> >     <mailto:florian.hofhammer@epfl.ch>>
> >     ---
> >
> >
> > So bsd-user would need something similar, I'd think. But it still uses
> > the older-style
> > TARGET_EJUSTRETURN. With half of the archs still out of tree, I'm not
> > entirely
> > sure the best way to approach this.
> >
> > The code does what you say, which is good, but there may be some subtle
> > reason to do something else.
> >
> > Reviewed-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
> >
>
> At the moment, syscall filtering is not available for bsd-user, it's
> (sadly) only implemented for linux-user. Which implies that current
> changes are not needed for bsd-user neither, since they can't be tested
> anyway.
>

OK. I'll add it to the backlog list then...

Warner

--000000000000432917064c112ce9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, =
2026 at 10:50=E2=80=AFAM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 3/2/26 7:15 AM, Warner Losh=
 wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Mon, Mar 2, 2026 at 7:03=E2=80=AFAM Florian Hofhammer <br>
&gt; &lt;<a href=3D"mailto:florian.hofhammer@epfl.ch" target=3D"_blank">flo=
rian.hofhammer@epfl.ch</a> &lt;mailto:<a href=3D"mailto:florian.hofhammer@e=
pfl.ch" target=3D"_blank">florian.hofhammer@epfl.ch</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The syscall emulation code previously wasn&#39;t in=
terruptible via<br>
&gt;=C2=A0 =C2=A0 =C2=A0cpu_loop_exit(), as this construct relies on a long=
jmp target that<br>
&gt;=C2=A0 =C2=A0 =C2=A0is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0live anymore in the syscall handling code. Conseque=
ntly, longjmp() would<br>
&gt;=C2=A0 =C2=A0 =C2=A0operate on a (potentially overwritten) stale jump b=
uffer. This patch<br>
&gt;=C2=A0 =C2=A0 =C2=A0adds an additional<br>
&gt;=C2=A0 =C2=A0 =C2=A0setjmp and the necessary handling around it to make=
 longjmp() (and by<br>
&gt;=C2=A0 =C2=A0 =C2=A0proxy cpu_loop_exit() safe to call even within a sy=
scall context.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Florian Hofhammer &lt;<a href=3D"mai=
lto:florian.hofhammer@epfl.ch" target=3D"_blank">florian.hofhammer@epfl.ch<=
/a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:florian.hofhammer@epfl=
.ch" target=3D"_blank">florian.hofhammer@epfl.ch</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt; <br>
&gt; <br>
&gt; So bsd-user would need something similar, I&#39;d think. But it still =
uses <br>
&gt; the older-style<br>
&gt; TARGET_EJUSTRETURN. With half of the archs still out of tree, I&#39;m =
not <br>
&gt; entirely<br>
&gt; sure the best way to approach this.<br>
&gt; <br>
&gt; The code does what you say, which is good, but there may be some subtl=
e<br>
&gt; reason to do something else.<br>
&gt; <br>
&gt; Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=
=3D"_blank">imp@bsdimp.com</a> &lt;mailto:<a href=3D"mailto:imp@bsdimp.com"=
 target=3D"_blank">imp@bsdimp.com</a>&gt;&gt;<br>
&gt; <br>
<br>
At the moment, syscall filtering is not available for bsd-user, it&#39;s <b=
r>
(sadly) only implemented for linux-user. Which implies that current <br>
changes are not needed for bsd-user neither, since they can&#39;t be tested=
 <br>
anyway.<br></blockquote><div><br></div><div>OK. I&#39;ll add it to the back=
log list then...=C2=A0</div><div><br></div><div>Warner=C2=A0</div></div></d=
iv>

--000000000000432917064c112ce9--

