Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7E8CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5NF-0006p6-N0; Fri, 29 May 2026 18:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wT5NB-0006oQ-Ev
 for qemu-devel@nongnu.org; Fri, 29 May 2026 18:08:09 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wT5N7-000392-9i
 for qemu-devel@nongnu.org; Fri, 29 May 2026 18:08:09 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd8faef2e18so1857893566b.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 15:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780092478; cv=none;
 d=google.com; s=arc-20240605;
 b=h5QoggOM1FfUzdfqsaU0bSQrY2gqYysrJ3d4RzKW0nm5H3y/HoVPl3pHPUxHN/Zz9t
 KkbvHIrOThPO62F5ILYt8MZQcbaQI5OhZ6IFggK7IDysqSAXBqtDZGTBx9bCOqphaGgf
 C5a5Lvx0wLr5zC/+HppHzq2tRR5NlcTwYFAiSslJMBoqIDyucUQ2P3OqL/40sePysdA6
 A4DTmPG/s67BNeXR6mvpCZi+ZCI+wLP3XEzJB6zHVqUrtyiI0qkVqNKvnjuGHeoh8I54
 yByGLyNubXqrnjhMCdBYTHCAOyX1diXxlQ8mp3p8vqUqqyxHhkLlf1upFHbmaSmKsd0R
 sNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l18mT7LR95e73mJamQUXBSzkqFI7yD1r7XIpEbzT32A=;
 fh=owoGgXqdEjuXIF8XOa7JOHtGBeY8D0b8TGVbTfsLIuw=;
 b=GZZM7laE00hANkThR9J2zc/K61iok5uNx5K4XA/pB7pSWoJxupOdM81ZtGZVpJk2lr
 QUS/cK06aeYokk4nDEfUKYuKWXO3j5xazeWoKMgsQPdATHZegXEU9QUIYYegCS8eXlGh
 hE4fJVfotCFR6Ey9kf5kh9jOevDSl8w4qrBJ3mHmVx7rEP+d/tneXIn98E1OwRAOZDhE
 LAmmQN0czh9DeYj6bdy4G8zQ/lVD7ngPc3uHQSFTW4a/6BBgAbRIGmxQQ6VDN1xKnbSB
 zupf1QsE87yj6xfKH4Uj82u9WylEMeXpOqpWUMP18RxeB2oFYTfOLWJIO+EuagITJmjO
 ymVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780092478; x=1780697278; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l18mT7LR95e73mJamQUXBSzkqFI7yD1r7XIpEbzT32A=;
 b=hHt5eVvxYwQmtHPKi7OvVLrYgcD1bcapjnTnXqMgHs7ClNxwonorUb8TyHm4g3BRLd
 Sdiro4zHqOWc9JkYcPBHvbNWf+szu8i5PAhLugYDTHq7C8EfwjOT0ggf9syd37R0aKc1
 U9al59xMwbPJye/CAAN9SuV084RKMAOGCmEG7iyVeLwroGDRbZdxHVn1Gy7ZuDB6UNkc
 +8RJ8ZyNNRrdxlh58WV5NRL5fvk0fw1Ks58YfO4VS088XDK9RkoMJzR8wBHodXZO9T+y
 SV3B8k1HIxIxLhnR6nV1oSLDpcujEEaK+K96A515G5hQh1qRLwatOdtVBfeVIdrvU8iL
 9P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780092478; x=1780697278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l18mT7LR95e73mJamQUXBSzkqFI7yD1r7XIpEbzT32A=;
 b=b7yH2NFlYVZ9hqVn6aAA1Ks9sS2kGtv6vpOaXdYTiNgq9Wbw+Tbt+KUjreifQ/TAgn
 b5O48JARuWlIABhikGWCNF5ZgwNLhv+fQg56NHVZ4KLwGRtXfyhsTWK0DgBZZzQ1CjCI
 G+WoUuyREj3jkp6RoYtRaYgnMwg+3SU2lj0NG9xA01ci0Uq+LTz1/zXrrtBy1UaBV24I
 LNgeUlS7dt/fCNTdsAe5SLRCY3/pY8qWbwFenNvXigowodAGk7K/3TMjpJf21bNpJmL6
 bxbHDL0jWF5+GzswXQa/f+IL5B+o6Xlu7fv8Ijyh0JlnwY8OB4Uzt9CCfnSHNOxT8HT1
 cLIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+v2hRQKvABPd1cta3RnAehzTnspQZr0B+giLocrxJ0P9OiYnoMhNgnFDOsSQ7OwwVOI82OzhS+g6e5@nongnu.org
X-Gm-Message-State: AOJu0YxUDsLSFW+zfTCkj6a4nqkWkG5qzbOV78lQzPlLsPbXL6LedCEP
 fTcjY0LCuAtpJzYzGyLPg3cRneeN7VPPX0eHYoFkZbMYpWUhmB7vjaWU3zZyCGmEgkyCbpjAWAY
 HVwusk8N3uqBXS8vNtejGrFAqAyOn4PA=
X-Gm-Gg: Acq92OHVGaLh6App94lNR2Nek59lGjibQSsRlCWDgf0vzKh6H38o/iU24VRe54qEr/A
 j50tIRVJqjpLaV7oyIIc6UwLRKWRDNyNuxAjKl7tkD1lkFM0AmDBgxUB/TA/u+AR75giRULSmKE
 ix9wdCE+prP/b+O6dpcorNW43cE+MS43K82IAAAEeJKLJPD6kxZL6MCndskDlgFcuT1Q1BEs21i
 VleuMnceWzuDMfRhsFaCGpbk7Q5y6SD7ErF1JIlMvjLT96K+X1PrVTYklg9YcaXsCpDC9W6I18Y
 Pa13Zy8ioxOFa6+phC5yJL979DDQ6hXjVN3qCh3/tG8Kpv2HIQ==
X-Received: by 2002:a17:907:b593:b0:bda:24df:232 with SMTP id
 a640c23a62f3a-beab227a543mr63532366b.48.1780092478391; Fri, 29 May 2026
 15:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
 <CAJSP0QWt8Q5+yY1F6--XyvcAV3afg3msAcO6vaNDeWS=B9Oqag@mail.gmail.com>
 <CANCZdfpbDU+jCr6+Lj-ZV7h5H_ByHf=VJordfQ8OcH3+JsmJ4Q@mail.gmail.com>
 <CAJSP0QX=Uu0cy6z8oCsQK_EKJ8LUW1v3Tsd09JoAU=Py4MkRrw@mail.gmail.com>
 <CANCZdfrfiVp=BiCEUzYRFFeZBpUoODBwL5b-QQgbA21Ev76noA@mail.gmail.com>
 <CAJSP0QWrNzf_NS1hx4c2TFRLp0Son=_kAx7qq_CeMBinEV=CNw@mail.gmail.com>
 <CAJSP0QUMZ76ioyGNLemN0qROCFxh_yAZGUkwFReFxgFiMJx70Q@mail.gmail.com>
 <CANCZdfpQA=90x-dS=d4-Vtt43zdSWYg==rcx326wrCfWAbuP_w@mail.gmail.com>
In-Reply-To: <CANCZdfpQA=90x-dS=d4-Vtt43zdSWYg==rcx326wrCfWAbuP_w@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 29 May 2026 18:07:46 -0400
X-Gm-Features: AVHnY4LimzaFNXFR-J93j04nN1dEjB9tPPc4JVwBJr5CkN4AhR7o1yXJgVr-2LU
Message-ID: <CAJSP0QU27JHhDq0k9+pgu3PVzAwfppReWRzdi-UCrT9CdbRG0g@mail.gmail.com>
Subject: Re: FreeBSD CI after Cirrus shuts down?
To: Warner Losh <imp@bsdimp.com>
Cc: Li-Wen Hsu <lwhsu@freebsd.org>, Alex Bennee <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d788970652fc13b5"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000d788970652fc13b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026, 16:56 Warner Losh <imp@bsdimp.com> wrote:

>
>
> On Fri, May 29, 2026 at 7:18=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.c=
om>
> wrote:
>
>> Hi Warner,
>> How are things going? A few options if you're willing to take on the
>> maintenance of a FreeBSD gitlab-runner VM hosted at OSUOSL:
>>
>
> They are going well...
>
>
>> 1. A FreeBSD 14.1 (zfs) VM as a temporary solution until a more recent
>> FreeBSD guest can be deployed.
>>
>
> Yea, let's start here, though see below.
>

Great, I will send you the login details tomorrow.


>
>> 2. A FreeBSD 13.1 (zfs) or Linux VM for the purposes of a live system
>> installation (e.g. dd and reboot or some other trick to overwrite the
>> live system). We can screen share and you tell me what to type if
>> remote console access is needed.
>> 3. You provide a recent FreeBSD disk image, I upload it to OSUOSL's
>> OpenStack, and I create a new VM from your image.
>>
>
> What format is this VM in?
>

The image should be a raw image for x86_64 guests with virtio drivers. My
understanding is that you can use EFI if you want, but the default is BIOS.

You can find details on the OSUOSL OpenStack setup and how to create images
here:
https://wiki.osuosl.org/openstack/guests.html#manual-guest-installation

Stefan

--000000000000d788970652fc13b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Fri, May 29, 2026, 16:56 Warner Losh =
&lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div d=
ir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, May 29, 2026 at 7:18=E2=80=AFAM Stefan Hajnoczi &lt=
;<a href=3D"mailto:stefanha@gmail.com" target=3D"_blank" rel=3D"noreferrer"=
>stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hi Warner,<br>
How are things going? A few options if you&#39;re willing to take on the<br=
>
maintenance of a FreeBSD gitlab-runner VM hosted at OSUOSL:<br></blockquote=
><div><br></div><div>They are going well...</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
1. A FreeBSD 14.1 (zfs) VM as a temporary solution until a more recent<br>
FreeBSD guest can be deployed.<br></blockquote><div><br></div><div>Yea, let=
&#39;s start here, though see below.</div></div></div></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Great, I will send you th=
e login details tomorrow.=C2=A0</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quot=
e"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
2. A FreeBSD 13.1 (zfs) or Linux VM for the purposes of a live system<br>
installation (e.g. dd and reboot or some other trick to overwrite the<br>
live system). We can screen share and you tell me what to type if<br>
remote console access is needed.<br>
3. You provide a recent FreeBSD disk image, I upload it to OSUOSL&#39;s<br>
OpenStack, and I create a new VM from your image.<br></blockquote><div><br>=
</div><div>What format is this VM in?</div></div></div></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">The image should be a ra=
w image for x86_64 guests with virtio drivers. My understanding is that you=
 can use EFI if you want, but the default is BIOS.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">You can find details on the OSUOSL OpenStack set=
up and how to create images here:</div><div dir=3D"auto"><a href=3D"https:/=
/wiki.osuosl.org/openstack/guests.html#manual-guest-installation">https://w=
iki.osuosl.org/openstack/guests.html#manual-guest-installation</a></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Stefan</div></div>

--000000000000d788970652fc13b5--

