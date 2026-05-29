Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683F0CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5vn-00062p-Kb; Fri, 29 May 2026 18:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wT5vj-00062b-Cs
 for qemu-devel@nongnu.org; Fri, 29 May 2026 18:43:51 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wT5vh-000315-58
 for qemu-devel@nongnu.org; Fri, 29 May 2026 18:43:51 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-36bcbd7821fso506731a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 15:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780094627; cv=none;
 d=google.com; s=arc-20240605;
 b=eb6DjrfRxAUPnaLYAoy/bZDAR8mtmAUJP1rWR/B2Kw6hofPgq9bc01vIRGry8y6fuQ
 zXAnn61MD44znQuup8XlPcFZvGExOAFddSrkucV4WvFWgE9Wj+bWgfV7JpgGawzeXbDt
 mrL50Lq36n1AiMGo9/dqYvyoIgXXe1YW6tiof0Xwg+q/zMwSRwjptE3MJ4agFDq0TfxD
 Ja+zfb8m3gr40K4I/QtUW62DLg5DL2AvYKIM3QGxVMz1yveh/OZzXqisUbCAhM0FA8nW
 0v3OK2OUeoNCKFnsAvOAJpZnYSYXj2VScl2hmsYSwNLdXkxz/Fsa4PH/OFcSMnS9GwRA
 Ju+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VS47PpnZMt76WVU5RFeRL3+FqpjuWRuNgKZ3zQvgmUg=;
 fh=sliOHIA2CuU4oJ0LFMgobUfSs69G+It2frpVay4tKFE=;
 b=EO+B9w9pYyYiTRXVRWmQqIGX3AXnUA1zjNKhkmwnWpePgcyQbvGOtjojQIpfA0SfBB
 DLFivmpXhK4CBUNRAfyifoeE8mp2yXFrqv1M9qwEPi5CVSvxKdxsRmv14wjLNtzWa25j
 Rl3xsFpXnphnUBLu9hDkiZk8LxhF8MMUM+skFqQhA7edQQfQZo1cBpKes8CH4u1GwdSU
 uELIdKqzO73EOOaIXFJQmgMDmm7BHgVNzgozkN1t50IihGqCmcFfevUT/d0fY7G9pL/5
 IWxhRnredlHQgpH3vSO0aflUWDe8likWUHanAKXi9p6FE/zIyYtzRfIZLO4SsWXyyfgv
 /QLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780094627; x=1780699427;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VS47PpnZMt76WVU5RFeRL3+FqpjuWRuNgKZ3zQvgmUg=;
 b=r+Sbs2Ga87mwcAgxQ94zEe4MnpFoivVCR4vMWVhGVSPsW4nrbsNaqO6OmAVheOm88I
 3hq/ym3/bhUI7nzKkW12EQXng09g4UPOpOqzEst039xNJdrAlO/AXlV1HFYr3kvXxBOc
 wqZVSUIROCoVJjRWFsQP2JURUbauFOfeyah5MpbkU8osq+2WiwKIwT/TGgl0WX97UQRS
 io11/FPTvpcg92ATghsqvWwW1emaOJ8wqUCYgVIvJjSwyHnnpdGGWQk9/1zaaJaRdPMk
 l31DpznSO1eq3iYA/VRhiZx6s6mevkaMkNr/wGzdq1EH1q0U1x8YfbDIOppxyV5bJcy0
 Yydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780094627; x=1780699427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VS47PpnZMt76WVU5RFeRL3+FqpjuWRuNgKZ3zQvgmUg=;
 b=SeK1Stt1t90VSzV2anFhcfjw5SgYBgV80yU1Ga3aojjdVTctPkLmoMGCxbvSvT+Gzm
 yovfl3Zw0jK99qE/cCS7g7dtr2KQ5DKzz704ptK+UBsLTZhSnFT9vsHBuItZL+JwYILU
 SbRvEtAZ9FCg/5ADYgRcjD9biTGsWTzPqFav9mvJsgkVravo4D/1Uj534eVUItO1qZV+
 3qC8BqqZtUns7dlSZnqG/7TCVsllT5/3+2DoYMdiArr3LzsMXnvXoZmimVxnN5MF8WEE
 9hyJBH2EVCDptC0mubZE5YxdrPTqCXL4sDq3u2K2bPU8uqRPVeUXowh6fe1YQHn9hd4u
 h66Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/zbIMcCaH3MCORJAiDLQqLo7hmfrO8XjVbvhq2ShZ4Z4Hb6zdZFueNBXtsD/4uVJ5089BAMb/VdNK@nongnu.org
X-Gm-Message-State: AOJu0Ywr19AB02NrnvTspS46OvbUi8g/Ymp0+rm2zPN3Ig1z/zOa+Yot
 sdnf3IMXAFkTfXJw4RuHNPEDLBfxc31rudxI/fXyi8ULnb7nMyCTgn51691ZF+KzRsY3BBaI9iP
 MqqvqEzm164CFzzGXXHFSKBcff5u5z402vcdudmfSQw==
X-Gm-Gg: Acq92OFVPEIyPgND1v8UcmPukjzMc+bHjV0hOKstA7HmK1PXQYze+y9ax60/CW7bgfQ
 AY1p94BVC4jUrHveR6quU0J8XD+SZ9fmxAMsKvyseNwiqNHworP/x5iPEUksNNFvFal0w1044ue
 D+ZlPDLm+Oxixe85Y+rybJSP4OiEwl6gmykMXcIQHBVTd6oPzkUQaXHerewbtMBVZfUMYenVRjk
 g1L9Vn6AobDmKCHJRGnla+bMwHwz4IAsJik4g59uMMHwmlxZdu/v9fy51PuwnGoT2SSZb3mpn9V
 Y9MUdEc9sf/cnb5DLz6IqCHBfKF8
X-Received: by 2002:a17:90b:3b90:b0:368:78da:803 with SMTP id
 98e67ed59e1d1-36c4ff86dc5mr1162533a91.12.1780094627138; Fri, 29 May 2026
 15:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
 <CAJSP0QWt8Q5+yY1F6--XyvcAV3afg3msAcO6vaNDeWS=B9Oqag@mail.gmail.com>
 <CANCZdfpbDU+jCr6+Lj-ZV7h5H_ByHf=VJordfQ8OcH3+JsmJ4Q@mail.gmail.com>
 <CAJSP0QX=Uu0cy6z8oCsQK_EKJ8LUW1v3Tsd09JoAU=Py4MkRrw@mail.gmail.com>
 <CANCZdfrfiVp=BiCEUzYRFFeZBpUoODBwL5b-QQgbA21Ev76noA@mail.gmail.com>
 <CAJSP0QWrNzf_NS1hx4c2TFRLp0Son=_kAx7qq_CeMBinEV=CNw@mail.gmail.com>
 <CAJSP0QUMZ76ioyGNLemN0qROCFxh_yAZGUkwFReFxgFiMJx70Q@mail.gmail.com>
 <CANCZdfpQA=90x-dS=d4-Vtt43zdSWYg==rcx326wrCfWAbuP_w@mail.gmail.com>
 <CAJSP0QU27JHhDq0k9+pgu3PVzAwfppReWRzdi-UCrT9CdbRG0g@mail.gmail.com>
In-Reply-To: <CAJSP0QU27JHhDq0k9+pgu3PVzAwfppReWRzdi-UCrT9CdbRG0g@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 29 May 2026 16:43:36 -0600
X-Gm-Features: AVHnY4KNSN6V0H-P-qBpcGJuyxHCINfu-t_7CVxpp0JJ0_O3wdyAfDt8uaxT78Y
Message-ID: <CANCZdfppQVMtQYMRDVZaB4_k3Vt5X7=k-5a1HBUvUT3+Pp3i7Q@mail.gmail.com>
Subject: Re: FreeBSD CI after Cirrus shuts down?
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Li-Wen Hsu <lwhsu@freebsd.org>, Alex Bennee <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000eae09a0652fc93e0"
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1036.google.com
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

--000000000000eae09a0652fc93e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 4:07=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:

> On Fri, May 29, 2026, 16:56 Warner Losh <imp@bsdimp.com> wrote:
>
>>
>>
>> On Fri, May 29, 2026 at 7:18=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.=
com>
>> wrote:
>>
>>> Hi Warner,
>>> How are things going? A few options if you're willing to take on the
>>> maintenance of a FreeBSD gitlab-runner VM hosted at OSUOSL:
>>>
>>
>> They are going well...
>>
>>
>>> 1. A FreeBSD 14.1 (zfs) VM as a temporary solution until a more recent
>>> FreeBSD guest can be deployed.
>>>
>>
>> Yea, let's start here, though see below.
>>
>
> Great, I will send you the login details tomorrow.
>

Cool. There's a good chance that I'll be out tomorrow, but I'll be around
Sunday.

2. A FreeBSD 13.1 (zfs) or Linux VM for the purposes of a live system
>>> installation (e.g. dd and reboot or some other trick to overwrite the
>>> live system). We can screen share and you tell me what to type if
>>> remote console access is needed.
>>> 3. You provide a recent FreeBSD disk image, I upload it to OSUOSL's
>>> OpenStack, and I create a new VM from your image.
>>>
>>
>> What format is this VM in?
>>
>
> The image should be a raw image for x86_64 guests with virtio drivers. My
> understanding is that you can use EFI if you want, but the default is BIO=
S.
>

Yea, I have some scripts to do this...


> You can find details on the OSUOSL OpenStack setup and how to create
> images here:
> https://wiki.osuosl.org/openstack/guests.html#manual-guest-installation
>

"Create a 3G qcow2 disk image"

OK. I know how I need to tweak my scripts!  I'll let you know when I have
this
and/or when there's a gitlab runner.

Warner

--000000000000eae09a0652fc93e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 29,=
 2026 at 4:07=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gma=
il.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"auto"><div><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 29, 2026, 16:56 Warner L=
osh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 29, 2026 at 7:18=E2=80=AFA=
M Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com" rel=3D"noreferr=
er" target=3D"_blank">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Hi Warner,<br>
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
e login details tomorrow.=C2=A0</div></div></blockquote><div><br></div><div=
>Cool. There&#39;s a good chance that I&#39;ll be out tomorrow, but I&#39;l=
l be around Sunday.</div><div><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
2. A FreeBSD 13.1 (zfs) or Linux VM for the purposes of a live system<br>
installation (e.g. dd and reboot or some other trick to overwrite the<br>
live system). We can screen share and you tell me what to type if<br>
remote console access is needed.<br>
3. You provide a recent FreeBSD disk image, I upload it to OSUOSL&#39;s<br>
OpenStack, and I create a new VM from your image.<br></blockquote><div><br>=
</div><div>What format is this VM in?</div></div></div></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">The image should be a ra=
w image for x86_64 guests with virtio drivers. My understanding is that you=
 can use EFI if you want, but the default is BIOS.</div></div></blockquote>=
<div><br></div><div>Yea, I have some scripts to do this...</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><=
div dir=3D"auto">You can find details on the OSUOSL OpenStack setup and how=
 to create images here:</div><div dir=3D"auto"><a href=3D"https://wiki.osuo=
sl.org/openstack/guests.html#manual-guest-installation" target=3D"_blank">h=
ttps://wiki.osuosl.org/openstack/guests.html#manual-guest-installation</a><=
/div></div></blockquote><div><br></div><div>&quot;Create a 3G qcow2 disk im=
age&quot;</div><div><br></div><div>OK. I know how I need to tweak my script=
s!=C2=A0 I&#39;ll let you know when I have this</div><div>and/or when there=
&#39;s a gitlab runner.</div><div><br></div><div>Warner<br><br></div><div>=
=C2=A0</div></div></div>

--000000000000eae09a0652fc93e0--

