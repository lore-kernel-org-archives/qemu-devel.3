Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1496FC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 15:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVBpY-00037n-Dk; Sat, 20 Jul 2024 11:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sVBpU-00037H-Fa
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 11:17:02 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sVBpS-0006PF-Cc
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 11:17:00 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-49294575ad8so107426137.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 08:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1721488616; x=1722093416;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rkBII/dmjhvafbnUah5DYm3F2M5Rvfzyr+ZXcNJRmy0=;
 b=SgE7dwHSCXYDvMemjpH9e1IhRJrVLsRKtQQTW3QiszAb9eCxQ772ESRvjMt/oSv0Vq
 3xNAqbzMvuCDgKTTgfEtaAIQyFQ9xKRkGj81iwAtwyyVX1KhmSd/sRm1Mg5/8TNdL+hZ
 10auyWXdh2R3bNhES0Z0OrEbkZMlTfZhtBQrAYjINvi/cEs6haE1NoIKWFKynMFvD9m/
 j074zT6dk1nWhRXSs7JE3exHt1HvN8n3rQg3qXi5HJyJMqCf7olF0bVZeSUljzgslMVl
 3LGublONPd27nsAXg2QkXAl2ag6KZF9k6Bg424Q3E8QE0/HWFJpEeYqJBwhX8KjKDgZX
 +mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721488616; x=1722093416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rkBII/dmjhvafbnUah5DYm3F2M5Rvfzyr+ZXcNJRmy0=;
 b=N4KXiaTYyVTBMr16HQv2Ux29SgQjLUkzTTJ4p3VmxcMIkUx2UP0B6hCBZZHvaxM099
 vMci8JjMTBDciPtKFypeE85lGzn18ZrcxAr8MQoU84HC6ZuwRaUTb//1fO+PuQC7SFjw
 IWRqupttZRMbalviAr1z2hveiy6epEkxjY6NY1yS5cTwsqyGgr3/hRMrYYNqnMuhAzCp
 SsVWlKpYlct4U6+uX22eNvLrwrLXhGLJwyjcFFd8RzWLeX6vIHN45AEdDRW4bM+BoZGx
 ySAiPERXajXHRhN5WPLjvegNn6c60CbX36gd2VqLb86rRuSd+XHRb6u74srzBqnKRsna
 czuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVROv5Mm3Cgrk7egWORZ+deXXgCJrI3RC4/ZjAYEjBzUdfOTtxqHuBnI6Fzh2wkFBxhsjpZlNKdcYfYk3Yu+pBGKdre5FQ=
X-Gm-Message-State: AOJu0YyKTZyd1y+3Ui86qurNi3DrMJ1Uof1LWt++QSmbnk1ih4AooHZ3
 EnP4H8eSmbd7yStjlHK1bvT4KPBEkDbf+FT9JdF6cJNwPqCUKe/7HVQuipS4kFMyJJhfzpKRrS3
 oNKLxm6AaYR0peOcJuVb8/pJ3w974e9cUCVo7
X-Google-Smtp-Source: AGHT+IEhuDUkmzOrj5p3mVEeoUyt43JIAO2i9iqQs6GWxIS+AJYPBrHlxCkDLr5MDKc9YdBjNUUuDfKUGrydY8twknk=
X-Received: by 2002:a05:6102:955:b0:48f:62bb:357c with SMTP id
 ada2fe7eead31-4925c19f256mr7383232137.3.1721488615630; Sat, 20 Jul 2024
 08:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240717110326.45230-1-phil@philjordan.eu>
 <7c545db7-1899-49a9-82ba-967f9e0a9000@daynix.com>
In-Reply-To: <7c545db7-1899-49a9-82ba-967f9e0a9000@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sat, 20 Jul 2024 17:16:44 +0200
Message-ID: <CAAibmn2NuXWkqVVR6-gZLGr6dNRY3YmR5AQ3v9i8pifOkdL_BA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] hw/display/apple-gfx: New macOS PV Graphics device
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: agraf@csgraf.de, berrange@redhat.com, marcandre.lureau@redhat.com, 
 pbonzini@redhat.com, peter.maydell@linaro.org, philmd@linaro.org, 
 qemu-devel@nongnu.org, thuth@redhat.com
Content-Type: multipart/alternative; boundary="0000000000006b8158061daf4d46"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe2a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000006b8158061daf4d46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat 20. Jul 2024 at 16:42, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

>
> > It also became clear in out-of-band communication that Alexander would
> > probably not end up having the time to see the patch through to
> inclusion,
> > and was happy for me to start making changes and to integrate my PCI
> code.
>
> I think you also need to take over the base vmapple change because PVG
> cannot be tested without it; Only macOS can use PVG, and macOS requires
> vmapple in my understanding.


The PCI device variant works fine with x86-64 macOS as the guest system.
(Or technically any UEFI based guest as the bootrom comes with a UEFI frame
buffer driver; it just won=E2=80=99t have any acceleration features unless =
you boot
macOS.)

If preferable I can leave out the vmapple/MMIO device variant (the
-vmapple.m file) until the rest of the vmapple machine type modifications
are ready. There still appears to be some kind of interrupt delivery issue
with some devices on vmapple, so USB HID events are very slow. Or I can
submit it as is if that=E2=80=99s not a dealbreaker. (How do I handle Alex=
=E2=80=99
unmodified patches though, as git send-email tries to send them from the
patch author=E2=80=99s email address, which means the email rapidly gets sh=
ot down
by DKIM mismatch or whatever?)

Thanks,
Phil

--0000000000006b8158061daf4d46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sat 20. Jul 2024 at 16:42, Akihiko Odaki &lt;<a href=3D"=
mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><br>
&gt; It also became clear in out-of-band communication that Alexander would=
<br>
&gt; probably not end up having the time to see the patch through to inclus=
ion,<br>
&gt; and was happy for me to start making changes and to integrate my PCI c=
ode.<br>
<br>
I think you also need to take over the base vmapple change because PVG <br>
cannot be tested without it; Only macOS can use PVG, and macOS requires <br=
>
vmapple in my understanding.</blockquote><div dir=3D"auto"><br></div><div d=
ir=3D"auto">The PCI device variant works fine with x86-64 macOS as the gues=
t system. (Or technically any UEFI based guest as the bootrom comes with a =
UEFI frame buffer driver; it just won=E2=80=99t have any acceleration featu=
res unless you boot macOS.)</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">If preferable I can leave out the vmapple/MMIO device variant (the -vma=
pple.m file) until the rest of the vmapple machine type modifications are r=
eady. There still appears to be some kind of interrupt delivery issue with =
some devices on vmapple, so USB HID events are very slow. Or I can submit i=
t as is if that=E2=80=99s not a dealbreaker. (How do I handle Alex=E2=80=99=
 unmodified patches though, as git send-email tries to send them from the p=
atch author=E2=80=99s email address, which means the email rapidly gets sho=
t down by DKIM mismatch or whatever?)</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Thanks,</div><div dir=3D"auto">Phil</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex" dir=3D"a=
uto"></blockquote></div></div>

--0000000000006b8158061daf4d46--

