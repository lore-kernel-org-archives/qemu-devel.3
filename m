Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10B8CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 16:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRYMq-00024B-6R; Mon, 25 May 2026 12:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRYMm-00023y-Rv
 for qemu-devel@nongnu.org; Mon, 25 May 2026 12:41:24 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRYMl-0002Bt-2R
 for qemu-devel@nongnu.org; Mon, 25 May 2026 12:41:24 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-68719234fd8so2827066a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 09:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779727281; cv=none;
 d=google.com; s=arc-20240605;
 b=J7mXkuim9nyMlEAzH4qQWWKhZMBk24Vwp4pZDkomHFICo44nNlI5lqzIDFF2sBZi8l
 O9vDlzCgdLAtmgyHlgNSrEWz/Wq8sE8RPyBlfdKmf5E1/1+ABhimSb2nequCVCdjbDf4
 5V8DeP+QBNHGkw++uczFkhBBEZG/CaKxrx6vUwGiepTZRpUKsYWzj4u0cT706uWVqNvk
 /wJcCt5r6pPbuc/TS2l9RH1eiDVlJEVehoFsv+iKJtpYPXCO/j+Khj4v0lwboFAWKo2C
 Jkx7L1YoNzPpWgFzbIYzA1lMjZ8g/8pvlP288n6Ro5fRCw0HtllREIQQi3LY84ukjOwF
 jbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bQQE3SbdOA8mVCI1w3FU9l2xQlyISovTtzF4fGpQKFc=;
 fh=BuCZB8MAkpexmqNliCV3N9B9XN8DMmBSCEzv3GGUHvM=;
 b=Svbl212rSCvMsoaJomDSPsUbEW1w2YGhuHcB4Q066YYvAKbeWUoZqhgbEdEh9o+hOB
 s7usgstSZt0h6kXXxzTrIEIGpiUAwkxEMjuwyBR1Pa6RwAmV9/9bQNH0TAEIiqE73Mjr
 p7KOiKKo8QAdq++ju+BogWhRlZF2RgxtybHPuqDNfRSteumWVRyy+/bpcaKu7pH1BJ1D
 Nt/NJAJX6FgIKlOuWz7+ug06RB6raUm8hllRY6KmLg/VKVD3991CrV6Oior7ZyZnLN6l
 K8ZhSqioiG58ytB6BmCk34cmZ8WEl0yR2yP/rmPEu5FjTPC3DfoPPM57hveJ3w4qa7bL
 jtvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779727281; x=1780332081; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bQQE3SbdOA8mVCI1w3FU9l2xQlyISovTtzF4fGpQKFc=;
 b=Om4UYDIuleZr1AG7as3F9LlYlv9xkTEVeMUIs3qNYqv3pOswOd+/qwhjVv9cczpzdv
 qwwKmoHh2pcUr3/JPuqSmV5n+DLdZA3JSIUpW2nI5Fn510fI/xG0Hzvc198cEEDob1UG
 e/DegRm98Ir7dHllupLOoJv7C0jdGeZraVWYyR4LLdmTKnk1xG8/cSGR/Ruk6EWcSkid
 tJ2TbJ6ygPwDpuUwhK/rOXtOawkP4p/VZ/YnsnFR8AkoH2aPO7o4gfLa+PIP8yQXn5Zu
 j3IJwL5ax22oE7XPqUEsvZitoIeTRF85zxtgzOrgIPXfj2/WfPjxRHX7rq/6d/s54L0x
 ZU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779727281; x=1780332081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQQE3SbdOA8mVCI1w3FU9l2xQlyISovTtzF4fGpQKFc=;
 b=YSun77LuK+PTy09yoSZstoHsGnvAsVFCzh5BvKTOXJ7FFomLmuEz+PzBN4RFzFNd2q
 7xg9Yb2CZgaBvgzxxSTjfvqnA0MT9N7atueo8q39AFcdnO9AyDam3ii2EX6aITNy7wYd
 qHauv1N1InlaJIDAqL4zXtK1JXrop9ea+HKV6A37PFFHfj7MJNqYE2RkQpLkFq+cQG6D
 whbNbTHD/hvqwJIZWGIbFBaxD/UgVU35s/4TvOPjiNH3zwuJ4mq8quZxrBz8wcjMi2QF
 HnPUm0wZBlRF799N70H+yWOvldV4ChZS70W+eH81Pcf9AHWrRX6UaMg0inuD/mHaCKX3
 8Q/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GcCLbPnk1m+MUZ4TSrmO+4ci0w7ygVUn05EjqNlAkosn5NVS31V4TjZBYjVreJkdRCDts+8M8hCxH@nongnu.org
X-Gm-Message-State: AOJu0YwedUjSiYFEl1012DvDv+IWixxKiILRBm9SbQNDGWjAWxTnloY4
 2tHnTOslbVMdujXze1bP4acdjWcp14NPB2U5H+mlCE0FZChcMG1HgioVOkSkyEMK26tYmuqlUek
 Esk76nSd+xNGeNERxnHTMWEShQZHX/hU=
X-Gm-Gg: Acq92OHbSpXW7UBPYIYbpLx6EjWJnhZpropWvtDFHP2JsYfrMOOzjXIDN3vX6QzoFo7
 SEVXtYbggr7Ujc09sDLEGG8jwgD57Y4qHF6vFi3voMii2P1gZLS1HdESW6ikPi0V5UcGuY5I88z
 cIlwV+r6b10S8cD/YLKeX/kZSEN0GJNYiOFCmu411lwGE1n7s7+qlY1aHVCmGM5wWFDSS9XhhpJ
 8HCeBsn4bpm9vGfOK9nU+0N12VQM1LJH1WNN+OArKL3oJ2Ipcu2itmssUL8poKY99FPPCr8mXSJ
 AdGWuPkhTG3dmvLO9H7F+AORqHaRwtsfKy4YnJ6p4Q==
X-Received: by 2002:a17:906:ef0c:b0:bc6:2bd3:8176 with SMTP id
 a640c23a62f3a-bdd279d1b58mr989223966b.35.1779727280714; Mon, 25 May 2026
 09:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
 <CAJSP0QWt8Q5+yY1F6--XyvcAV3afg3msAcO6vaNDeWS=B9Oqag@mail.gmail.com>
 <CANCZdfpbDU+jCr6+Lj-ZV7h5H_ByHf=VJordfQ8OcH3+JsmJ4Q@mail.gmail.com>
In-Reply-To: <CANCZdfpbDU+jCr6+Lj-ZV7h5H_ByHf=VJordfQ8OcH3+JsmJ4Q@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 May 2026 12:41:10 -0400
X-Gm-Features: AVHnY4K0X1AX3bX6WjRBVmOeQBqbMWYk3IRSdmH9fI-gDp-wB5jlL9k6B2JDwIE
Message-ID: <CAJSP0QX=Uu0cy6z8oCsQK_EKJ8LUW1v3Tsd09JoAU=Py4MkRrw@mail.gmail.com>
Subject: Re: FreeBSD CI after Cirrus shuts down?
To: Warner Losh <imp@bsdimp.com>
Cc: Li-Wen Hsu <lwhsu@freebsd.org>, Alex Bennee <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000005d3cad0652a70c11"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
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

--0000000000005d3cad0652a70c11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026, 11:12 Warner Losh <imp@bsdimp.com> wrote:

>
>
> On Mon, May 25, 2026, 8:36=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
>> On Mon, May 25, 2026 at 10:01=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail=
.com>
>> wrote:
>> > If you have a FreeBSD build host available, you could install
>> > gitlab-runner on it and I can configure GitLab CI to send QEMU FreeBSD
>> > build jobs to your runner.
>>
>> QEMU has an Intel x86_64 KVM VM with 1 vCPU, 4 GB RAM, and 60 GB of
>> disk space available.
>>
>> The following images are available:
>> - FreeBSD 14.1
>> - FreeBSD 14.2 (ufs)
>> - FreeBSD 14.2 (zfs)
>>
>> I can provision the machine for you via remote console access and add
>> your ssh key. After initially giving you access, you would become the
>> maintainer of the VM and responsible for keeping it updated and
>> connected to QEMU's GitLab CI.
>>
>> If you would like to do this, please send me your ssh public key and
>> choice of FreeBSD image from the list above.
>>
>
> Where does that list come from? Those are older versions of FreeBSD by
> now...
>

These images are available in OSUOSL's OpenStack instance where the VM is
located.

If you can upgrade in place from FreeBSD 14 to something newer without
requiring console access, then that might be the simplest solution.

Otherwise I can upload a custom image (for QEMU's i440fx machine type with
virtio devices) if you send me a URL to the image.

Stefan

>

--0000000000005d3cad0652a70c11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><br><div class=3D"gmail_quote gmail_quote_container" =
dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 25, 2026, 11=
:12 Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div di=
r=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, May 25, 2026, 8:36=E2=80=AFAM Stefan Hajnoczi &lt;<=
a href=3D"mailto:stefanha@gmail.com" target=3D"_blank" rel=3D"noreferrer">s=
tefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Mon, May 25, 2026 at 10:01=E2=80=AFAM Stefan Hajnoczi &=
lt;<a href=3D"mailto:stefanha@gmail.com" rel=3D"noreferrer noreferrer" targ=
et=3D"_blank">stefanha@gmail.com</a>&gt; wrote:<br>
&gt; If you have a FreeBSD build host available, you could install<br>
&gt; gitlab-runner on it and I can configure GitLab CI to send QEMU FreeBSD=
<br>
&gt; build jobs to your runner.<br>
<br>
QEMU has an Intel x86_64 KVM VM with 1 vCPU, 4 GB RAM, and 60 GB of<br>
disk space available.<br>
<br>
The following images are available:<br>
- FreeBSD 14.1<br>
- FreeBSD 14.2 (ufs)<br>
- FreeBSD 14.2 (zfs)<br>
<br>
I can provision the machine for you via remote console access and add<br>
your ssh key. After initially giving you access, you would become the<br>
maintainer of the VM and responsible for keeping it updated and<br>
connected to QEMU&#39;s GitLab CI.<br>
<br>
If you would like to do this, please send me your ssh public key and<br>
choice of FreeBSD image from the list above.<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Where does that list come from?=
 Those are older versions of FreeBSD by now...</div></div></blockquote></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">These images are available =
in OSUOSL&#39;s OpenStack instance where the VM is located.=C2=A0</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">If you can upgrade in place from =
FreeBSD 14 to something newer without requiring console access, then that m=
ight be the simplest solution.=C2=A0</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Otherwise I can upload a custom image (for QEMU&#39;s i440fx m=
achine type with virtio devices) if you send me a URL to the image.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Stefan</div><div class=3D"gmail=
_quote gmail_quote_container" dir=3D"auto"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>
</blockquote></div></div>

--0000000000005d3cad0652a70c11--

