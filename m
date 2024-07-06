Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE34AC38150
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 20:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQCMA-0001Rk-Eb; Sat, 06 Jul 2024 16:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sQCM8-0001RZ-Po
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 16:50:04 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sQCM6-0003RZ-Sz
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 16:50:04 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4f30f3be999so252327e0c.3
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1720299001; x=1720903801;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=doMMZaGPW/C5tQb7BhjEZmtdAW3IaKGN8TY/3B8AgXQ=;
 b=grOj45UU9kSHTtLa92w7/I8Z2g8TBZ/Q3lhZ+OUFwZ7tIDKnUHR2sizV+JJP7ch9/c
 spSn760SgKZi0pbrYG9hsqJGfFDjxb5yFxXkpgzGmIiuUVit1Le6v7hKWH0SpKl+zO2O
 /1zgk1roKl00+0dg0+X4/EUI2jCOmCi6oXbb0Nfgtt54u0bfQng/2wGnZkYXdrKMRCi4
 U5XpMPsbNtX+kZLvP92jfPL1SyDqhfHKDhYizykNOCpu5MX4xssTNTCT8nCfBXkXGgji
 MZy/9V04uE24W3B+CtfnUHyj5MymJOlVTWWkXoj54FGqhFehDee/ZOlZ+rD4fKoKB122
 35ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720299001; x=1720903801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=doMMZaGPW/C5tQb7BhjEZmtdAW3IaKGN8TY/3B8AgXQ=;
 b=KuTttkULqjcYPoAbsAZf/0O3ISuDOvYlOETuY+uqV3ObEtPzJrXe7YuTedLN6X4Fw4
 P2J6EP/QySPXdpJWTvJkVZF2Y5+Ol6mfbv/XMhOmw5L7f5ZXfdIQbupTN06tgj/lYOej
 V8h/o2R1m8/x2f12mtBjTY91j0kVeoJEmNDaadMd+oDbu7wPI4KrhdDnI5MYAYTJ9wiI
 eZAoKyMVoKeZLeJEuXxIavT99UB/DhmJmWY5LvVr7M1j+ew3T/ab4EEkNU+SwAuv6Mnu
 S49vCdXGnZly+oQ8yHX4zOlaESRqeunvOZx7UqpVeHcn2tYSWO7/wOWxtc7fEzZXwKJt
 f7yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj7jynmE8Pggr3Wfr8o7vnODzUIP8VizMDkuJ/TM6HLg7A50svqEI8SGeSNJMn8S+HqtZl3shJbX5GDZAuBG67csSCyjE=
X-Gm-Message-State: AOJu0Yx/tiMO09uqpnbVCFZbhUxCTOBOYUxA+UkZlaubC65ifPsiiieb
 eUvz7KTONrSM1cP3aJgAKwfEZ/NB1SyGaeSZqkCbjanF+xOz5FMal9qMS7c116Tm8AkkKfwCGOL
 8Uw8XiKwa+2G/qSga4W3St340h/I5VUMhIURC
X-Google-Smtp-Source: AGHT+IGIXqoe3AH9z6gMggD8PlexLtocCXb91rjGqKistBFtbaNWAQRYEGhRm6ySWqAlqlKAU+UidYWzlCVcBe9TJcw=
X-Received: by 2002:a05:6122:2807:b0:4eb:5d30:3fad with SMTP id
 71dfb90a1353d-4f2f3f90dbdmr8815011e0c.10.1720299000964; Sat, 06 Jul 2024
 13:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
In-Reply-To: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sat, 6 Jul 2024 22:49:50 +0200
Message-ID: <CAAibmn071UEvfdzShxnS5QhjgL0b0QdvYo-o5s18ycqqaLYVFw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ui/cocoa: Add cursor composition
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000dc424d061c9a5257"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a36;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa36.google.com
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

--000000000000dc424d061c9a5257
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 13:17, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> Add accelerated cursor composition to ui/cocoa. This does not only
> improve performance for display devices that exposes the capability to
> the guest according to dpy_cursor_define_supported(), but fixes the
> cursor display for devices that unconditionally expects the availability
> of the capability (e.g., virtio-gpu).
>
> The common pattern to implement accelerated cursor composition is to
> replace the cursor and warp it so that the replaced cursor is shown at
> the correct position on the guest display for relative pointer devices.
> Unfortunately, ui/cocoa cannot do the same because warping the cursor
> position interfers with the mouse input so it uses CALayer instead;
> although it is not specialized for cursor composition, it still can
> compose images with hardware acceleration.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>

After fixing the typo in patch 3/4, the code appears to work as intended.
(Tested on macOS 13 & 14, virtio-gpu with Cocoa UI.)

So, for the whole patch set:

Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>

--000000000000dc424d061c9a5257
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, 27 Jun 2024 at 13:17, Akihiko Odaki &lt;<a href=3D"mailto:ak=
ihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add accel=
erated cursor composition to ui/cocoa. This does not only<br>
improve performance for display devices that exposes the capability to<br>
the guest according to dpy_cursor_define_supported(), but fixes the<br>
cursor display for devices that unconditionally expects the availability<br=
>
of the capability (e.g., virtio-gpu).<br>
<br>
The common pattern to implement accelerated cursor composition is to<br>
replace the cursor and warp it so that the replaced cursor is shown at<br>
the correct position on the guest display for relative pointer devices.<br>
Unfortunately, ui/cocoa cannot do the same because warping the cursor<br>
position interfers with the mouse input so it uses CALayer instead;<br>
although it is not specialized for cursor composition, it still can<br>
compose images with hardware acceleration.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br></blockquote><div>=
=C2=A0</div><div><div>After fixing the typo in patch 3/4, the code appears =
to work as=20
intended. (Tested on macOS 13 &amp; 14, virtio-gpu with Cocoa UI.)</div><di=
v><br></div><div>So,=20
for the whole patch set:</div><div><br></div><div>Tested-by: Phil Dennis-Jo=
rdan &lt;<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philj=
ordan.eu</a>&gt;</div><div><br><br></div>=C2=A0</div></div></div>

--000000000000dc424d061c9a5257--

