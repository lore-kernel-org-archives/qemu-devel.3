Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77913E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJkK-00047Y-Q3; Thu, 19 Dec 2024 11:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1tOJkI-00046Z-E4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:51:30 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1tOJkF-0001Sd-29
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:51:29 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-728f337a921so1136536b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 08:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1734627085; x=1735231885;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hfOXEnbGnd04HWPLniuRSU99I7dBkwrHmkjKV0gIeq8=;
 b=yyU5fVraKhAF/YMtA33LVifBuoZjxZMzRr6Q/NivqY4/UmpneyZxWgsm+1EkPxG2Jg
 5F25C4qfZGXqkSiKdZU3onvOqOim9WwMtvpSOl+WDgMbuhvwiJZQa+PHSDu87TdjEIhN
 FmnsrchHEcSQrHG4hPZz7nN3YDnZMWmVvGr82CTdNHnfz9S0KfUD9jUY2XhRfgsSZR3F
 d1oc3N6I/LLWT7L7lS8wILntW2bDhjMm6d3DuEyd1s3gg+GkRpjyg6DnnX/35EV/AQaC
 mA82DrQnqbtVV87rQWei4p/CPoePqP5gRjO7itBYCUTszX0FrQNHNrkBFSL/TGuojiU/
 //SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734627085; x=1735231885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hfOXEnbGnd04HWPLniuRSU99I7dBkwrHmkjKV0gIeq8=;
 b=t3591lHHDkhtTARrORzGby1v7iL1V/awPnFo9aynrCV5/gmakN1TjTkfdg/dLYynVn
 VVdm+SrqstUI80gb7rH+zVl03KonvHXzKHdOPAr8UDwLJCn1xrDvin7BZJRZ4ETo2vxm
 AwEFh0M06wO17m8TBJa25RpWMK6hP6q3EA+y24n7P/aDaY/CzuadVj/QWDGHMvmbCTy1
 xyPcgvWlF+7qFGeGaM1B3vbPqRHK65E+jZvzo89gInZagpy2Ui3jUrTYYSm7YkA4Gywa
 aK8a911k15Qha7DG3vALZrVuNz15YYvTzyxnQcNELj0cU/WvWFQx36/nbff4/jao/pkd
 N6rw==
X-Gm-Message-State: AOJu0Yxug+TNqK38lYXpAltEJyFLKZptNq/e+cjpu6Iib5ThhkwwNKQ6
 /h9R6ZAmSMGLdfNFKPA+3dszRAk5HUFmyVBcr6gTeBoWcuNrPQJMIzFWcktsI5sFfl/YpE6uqKx
 x3cSQSDsYrLi+yzqR0z4gTjIXXez7YyEfIqXK4A==
X-Gm-Gg: ASbGncuvVzi8NYUFu5+xzO+76wf0vE1O2SU3fnDaeDALyQF4UjYWbwcFtwtmZQJRwNe
 t6RtUBDI+VzTJJ5P4o0vdOXgvGqbcGOe+rWV1qg==
X-Google-Smtp-Source: AGHT+IEC7PcPPa8/j9ntajp20LMncl5l1MhBbk5E601RSBckz96nNfN8nBbplW0JSGj6gvM1I8yW1sgCMW8+Whbu6aQ=
X-Received: by 2002:a05:6a00:2907:b0:725:973f:9d53 with SMTP id
 d2e1a72fcca58-72aa8d3db56mr5458295b3a.15.1734627084924; Thu, 19 Dec 2024
 08:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20241219013535.GB4298@darkstar>
In-Reply-To: <20241219013535.GB4298@darkstar>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 19 Dec 2024 09:51:13 -0700
Message-ID: <CANCZdfodkH0Mf8jkxs3Gybh8-nOAm79X+QXrbAvo0RHR9tBfXg@mail.gmail.com>
Subject: Re: Ideas to Improve GDB Stub in Qemu for i8086
To: Davidson Francis <davidsondfgl@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000037190d0629a2571a"
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x434.google.com
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

--00000000000037190d0629a2571a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 6:36=E2=80=AFPM Davidson Francis <davidsondfgl@gmai=
l.com>
wrote:

> Hi,
> Some time ago, I wrote a Gist [1] outlining what I believe to be the
> ideal environment for debugging 16-bit code in real mode on Qemu. Based
> on the feedback I've received, I decided to share it here to gather more
> opinions.
>
> It is commonly known that Qemu does not handle real/16-bit mode well with
> GDB. To work around this, there are various hacks available, most of
> which involve GDB scripts to make debugging less painful.
>
> Basically, my idea involves two small and specific changes to the GDB
> stub:
> 1) Returning the correct CPU mode as "i8086" or "i386" depending on the
> current CPU mode (on x86_gdb_arch_name), instead of always returning
> "i386".
>
> 2) Translating segmented memory to linear if in real mode, i.e.,
> returning CS*0x10+EIP instead of just EIP, and similarly for ESP, etc.
>
> Originally, I considered submitting a patch directly, but I wanted to get
> your thoughts first. I understand that Bochs and similar tools have
> sufficiently good debuggers, but it would be interesting if Qemu had some
> improvements in this area.
>
> I also acknowledge that my solution might not help in all scenarios, such
> as CPU mode switches, so its effectiveness would be limited.
>
> Ref:
> [1]: https://gist.github.com/Theldus/4e1efc07ec13fb84fa10c2f3d054dccd


I might be interested in debugging some i8086 stuff for my Venix/86
emulation
project.

I'm curious, though. I see special cases just for EIP being returned as (CS
<< 4):EIP
and similar for ESP being just (SS << 4):SP. What does the debugger do,
though,
for other cases where you need segment:offset addresses? Does it translate
properly
behind the scenes in ways it doesn't do for ESP/EIP or do you have to
examine those
addresses by hand as well? If I'm chasing a linked list with 16-bit
addresses that assume
a particular DS, how does that work?

Warner

--00000000000037190d0629a2571a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 18,=
 2024 at 6:36=E2=80=AFPM Davidson Francis &lt;<a href=3D"mailto:davidsondfg=
l@gmail.com">davidsondfgl@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hi,<br>
Some time ago, I wrote a Gist [1] outlining what I believe to be the <br>
ideal environment for debugging 16-bit code in real mode on Qemu. Based <br=
>
on the feedback I&#39;ve received, I decided to share it here to gather mor=
e <br>
opinions.<br>
<br>
It is commonly known that Qemu does not handle real/16-bit mode well with <=
br>
GDB. To work around this, there are various hacks available, most of <br>
which involve GDB scripts to make debugging less painful.<br>
<br>
Basically, my idea involves two small and specific changes to the GDB <br>
stub:<br>
1) Returning the correct CPU mode as &quot;i8086&quot; or &quot;i386&quot; =
depending on the <br>
current CPU mode (on x86_gdb_arch_name), instead of always returning <br>
&quot;i386&quot;.<br>
<br>
2) Translating segmented memory to linear if in real mode, i.e., <br>
returning CS*0x10+EIP instead of just EIP, and similarly for ESP, etc.<br>
<br>
Originally, I considered submitting a patch directly, but I wanted to get <=
br>
your thoughts first. I understand that Bochs and similar tools have <br>
sufficiently good debuggers, but it would be interesting if Qemu had some <=
br>
improvements in this area.<br>
<br>
I also acknowledge that my solution might not help in all scenarios, such <=
br>
as CPU mode switches, so its effectiveness would be limited.<br>
<br>
Ref:<br>
[1]: <a href=3D"https://gist.github.com/Theldus/4e1efc07ec13fb84fa10c2f3d05=
4dccd" rel=3D"noreferrer" target=3D"_blank">https://gist.github.com/Theldus=
/4e1efc07ec13fb84fa10c2f3d054dccd</a></blockquote><div><br></div><div>I mig=
ht be interested in debugging some i8086 stuff for my Venix/86 emulation</d=
iv><div>project.</div><div><br></div><div>I&#39;m curious, though. I see sp=
ecial cases just for EIP being returned as (CS &lt;&lt; 4):EIP</div><div>an=
d similar for ESP being just (SS &lt;&lt; 4):SP. What does the debugger do,=
 though,</div><div>for other cases where you need segment:offset addresses?=
 Does it translate properly</div><div>behind the scenes=C2=A0in ways it doe=
sn&#39;t do for ESP/EIP or do you have to examine those</div><div>addresses=
 by hand as well? If I&#39;m chasing a linked list with 16-bit addresses th=
at assume</div><div>a particular DS, how does that work?</div><div><br></di=
v><div>Warner=C2=A0</div></div></div>

--00000000000037190d0629a2571a--

