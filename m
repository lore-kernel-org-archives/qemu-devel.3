Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2265CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 20:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4Fc-0003dM-CM; Fri, 29 May 2026 16:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wT4FX-0003d2-Hj
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:56:12 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wT4FV-0007TT-OS
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:56:11 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36bd175fdbaso513538a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 13:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780088167; cv=none;
 d=google.com; s=arc-20240605;
 b=W756WsdOu4PZVTn8FQWFCM5U48xT82QOQH9VxMZaaaWF1iDQ34wbP7y5+5APIS7ZWN
 Qaxn4LPyWhWpLuwp/eFp/dn7RgpfNvWllTJoiEexrSm8KSxDlbgWE4ZpDJtDeobEpH9o
 QVpjR60oPZaz0XGTZEih7q3B1ZxpfFTdryeuACK3rA6zyElj9LtH3iyanjcuQCjCRPPn
 Mu7kDlUCDciv9Vg6Tq9trk/89Nz+rzdw6Z1yM3eERuKtNy/y5LtLX9gQIOStJUdCenSs
 85xG1iOGh8nagJwTU8lFUuVA8/R1TiR2wAU3055qy8fF8h2eR8P034W0WpwfVdoaykJP
 2N6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kO6WMQXPqiBITAqV87aCFHhcMyJzptUJcprT/P5DBVc=;
 fh=1G4sjlasoo91Ru9zNFnALdQe8bhnUxqTa7iQxIXZa64=;
 b=U4wEhUokiVbLE4xcqqHvIIzcllv0KkKmBTZz/bXXz/rHduBbk1/tRtsVfcZf7zk4Vr
 27Tl9cWXwxRLkOJIwcxSgOHe3x1XPDqIMC+JtbBVumPLXBHysSbW0E52zSVU2xQNNfya
 ynL36Imgin1krd+J5xhJSFL7FShOp3wuWP7b2iNhVhVcC16BquaiIubCAWDEL2JCQEvO
 tL+1/BhcAx60VfnRPLqgiMXfA2O3OgOybTLIdRFURfdChPJInaTtPweS/mhiUsjppemO
 Vx+le6rausEZEuJ38HmsNuIVW1mhuydQgAk0r7HvuX6OdtZDJVeB21EB3A6zK5twNwfC
 aUQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780088167; x=1780692967;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kO6WMQXPqiBITAqV87aCFHhcMyJzptUJcprT/P5DBVc=;
 b=QQO+dB+VZqBtsTmcVLgiDyzN/PTnPv90AVvBbZbHXLrcLsVvLv2Kjy9BKMOcYbxSyk
 O/xvMJJj25lkmCqrTkXKe6IianC6yhieWxdWUvTZdxAtSKn6V/iQ86fvlSPlhb4fDrCz
 aKyAwvvghOhTx8umqzcz9iYmjrF62a4yKzXMoUnxVtpZwYOv56zt93OL8nRFXqHxlHcg
 X80M8/BhjhwzGV6Om56cUnaUJlw8UbBZ5m4u5y9nrWbINlv0kW8Idudf5frW6bjoQIWA
 YeloPpc7RqZkeHQhVlewhX10Ve3zLoJcomShpL6RWAvY+fcP5ffG9K2uJxK1WuotpjBY
 lhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780088167; x=1780692967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kO6WMQXPqiBITAqV87aCFHhcMyJzptUJcprT/P5DBVc=;
 b=gctxFaX0SCLEp/iXE5nyICp8NQxK5fcP5P0NlYyyUaugrA7ldXw/Q/EsSZvzZgUz/p
 44Uu57FTbdPm3wKpFr+HCtdo7HhHAXDdcTKKm6JFP2ebb0rntI0fhfR4fyt49ERMdoM3
 GqO6ldf8HZ1/UtPLkDw1EaXOTzGUBagf710mjjPr6c04LfT6nvrjCyqI9sZ/i6xcyQsg
 svUB4ZM3Ml8IVAHtPJ+xgOPH0m1gRT2VzniFJiaPTsrqYvpEdhA0LBdXwdjfuDcKFCyu
 FLv4lziW7c2liBqilqHYfGJjwnhd9CtVjp7IFNcq2vQdLkLhji04dSbXdVYlYxuX/ms8
 RwQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/o9MWOB4nt3Pjpr/a+gK28+pUExGG30M0vmv7RiOj/ZbphYc60dDGE3UMsfb5vXX84FSWnrZdKekGA@nongnu.org
X-Gm-Message-State: AOJu0YwzmSv3MpD56eMJrZTeKEZeCpNTzGGrc+bbn3dzJac3kMZz3OQ0
 c5D9771zQIjQbX66v6wMaT4HG9uQm1igVjg8XzhtvRsuGKZYeLoPT59kWzo4VzoszHqyO8aV/gZ
 33CzLAmDVlRRoz8pdOmlvnYXYnDe5EifKfeILor46nA==
X-Gm-Gg: Acq92OELR7ClSsOgRUGjTagxEfm7gI807t4dkPPs4SoGbPaPUX3/bRyIYVLYfkDUPt2
 BYOT4Z6Bc8lTXmwcoTbeO2OyV6IVlypBDxxLWSOVLtoFA0epxT1v+hyLtHgv73kELr1qXbe8hbG
 4PM9Iy2jtiFMuzMacwHdbgMU7mQetAIJy2UUtrp7YYgbab1SR948OeCq6fr5FqHUxvFDJ2BOrtE
 EQ23Q1EfSKxAeQJ2NN5hh0tKwharOU/pvPSB0PDNNpKI6MVMpRifvmFkhwWVxOsVlzTP3yiPbEq
 qmO/g+qkhDRRpZt23wEf+E+YBdsh1QUt1w3lqBPtciVDmxAF
X-Received: by 2002:a17:903:37cd:b0:2bd:1903:6ced with SMTP id
 d9443c01a7336-2bf368cf64emr15660365ad.41.1780088166742; Fri, 29 May 2026
 13:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
 <CAJSP0QWt8Q5+yY1F6--XyvcAV3afg3msAcO6vaNDeWS=B9Oqag@mail.gmail.com>
 <CANCZdfpbDU+jCr6+Lj-ZV7h5H_ByHf=VJordfQ8OcH3+JsmJ4Q@mail.gmail.com>
 <CAJSP0QX=Uu0cy6z8oCsQK_EKJ8LUW1v3Tsd09JoAU=Py4MkRrw@mail.gmail.com>
 <CANCZdfrfiVp=BiCEUzYRFFeZBpUoODBwL5b-QQgbA21Ev76noA@mail.gmail.com>
 <CAJSP0QWrNzf_NS1hx4c2TFRLp0Son=_kAx7qq_CeMBinEV=CNw@mail.gmail.com>
 <CAJSP0QUMZ76ioyGNLemN0qROCFxh_yAZGUkwFReFxgFiMJx70Q@mail.gmail.com>
In-Reply-To: <CAJSP0QUMZ76ioyGNLemN0qROCFxh_yAZGUkwFReFxgFiMJx70Q@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 29 May 2026 14:55:55 -0600
X-Gm-Features: AVHnY4Jyf4p9Fiy4z-jKV87xanjMA9zlrspMuruyXrXgojXEjAf9BBKLW9Q2qVk
Message-ID: <CANCZdfpQA=90x-dS=d4-Vtt43zdSWYg==rcx326wrCfWAbuP_w@mail.gmail.com>
Subject: Re: FreeBSD CI after Cirrus shuts down?
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Li-Wen Hsu <lwhsu@freebsd.org>, Alex Bennee <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d90aff0652fb12a3"
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1035.google.com
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

--000000000000d90aff0652fb12a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 7:18=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:

> Hi Warner,
> How are things going? A few options if you're willing to take on the
> maintenance of a FreeBSD gitlab-runner VM hosted at OSUOSL:
>

They are going well...


> 1. A FreeBSD 14.1 (zfs) VM as a temporary solution until a more recent
> FreeBSD guest can be deployed.
>

Yea, let's start here, though see below.


> 2. A FreeBSD 13.1 (zfs) or Linux VM for the purposes of a live system
> installation (e.g. dd and reboot or some other trick to overwrite the
> live system). We can screen share and you tell me what to type if
> remote console access is needed.
> 3. You provide a recent FreeBSD disk image, I upload it to OSUOSL's
> OpenStack, and I create a new VM from your image.
>

What format is this VM in?


> At that point you have access to a FreeBSD VM and can install
> gitlab-runner.
>

Yea. I've found some info on this, and have some help, but I think the
help is delayed until next week.


> If we don't have the FreeBSD gitlab-runner online when Cirrus CI shuts
> down on June 1st, I will temporarily disable the CI job. We can enable
> it again when there is a runner available.
>

I'm afraid we'll need to do that on at least a temporary basis.

Warner


> Stefan
>

--000000000000d90aff0652fb12a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 29,=
 2026 at 7:18=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gma=
il.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Hi Warner,<br>
How are things going? A few options if you&#39;re willing to take on the<br=
>
maintenance of a FreeBSD gitlab-runner VM hosted at OSUOSL:<br></blockquote=
><div><br></div><div>They are going well...</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
1. A FreeBSD 14.1 (zfs) VM as a temporary solution until a more recent<br>
FreeBSD guest can be deployed.<br></blockquote><div><br></div><div>Yea, let=
&#39;s start here, though see below.</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
2. A FreeBSD 13.1 (zfs) or Linux VM for the purposes of a live system<br>
installation (e.g. dd and reboot or some other trick to overwrite the<br>
live system). We can screen share and you tell me what to type if<br>
remote console access is needed.<br>
3. You provide a recent FreeBSD disk image, I upload it to OSUOSL&#39;s<br>
OpenStack, and I create a new VM from your image.<br></blockquote><div><br>=
</div><div>What format is this VM in?</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
At that point you have access to a FreeBSD VM and can install gitlab-runner=
.<br></blockquote><div><br></div><div>Yea. I&#39;ve found some info on this=
, and have some help, but I think the</div><div>help is delayed until next =
week.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
If we don&#39;t have the FreeBSD gitlab-runner online when Cirrus CI shuts<=
br>
down on June 1st, I will temporarily disable the CI job. We can enable<br>
it again when there is a runner available.<br></blockquote><div><br></div><=
div>I&#39;m afraid we&#39;ll need to do that on at least a temporary basis.=
</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
Stefan<br>
</blockquote></div></div>

--000000000000d90aff0652fb12a3--

