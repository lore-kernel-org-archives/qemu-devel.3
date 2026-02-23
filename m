Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46269EC1127
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 19:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vubSb-00045A-Lb; Mon, 23 Feb 2026 14:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vubSH-00044M-1i
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 14:18:54 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vubSD-0006jz-OO
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 14:18:51 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65a3527c5easo8222277a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 11:18:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771874327; cv=none;
 d=google.com; s=arc-20240605;
 b=Q8Arl6lxv4C+gJWStzTFry+mUqWyYvXSjX/XR4UUnEGC9YTOt/lH6Fh3UwFHHbm/zI
 /TX+mBwISX05mFMhTu87jgDhxwzTlysTllg4tsEX/5hjt7uWA3xts+l6ycfFfHkZjZoX
 SS5U9VpboiDMYv8/EgGTnpCrKU03dOwBFUXTDq7ZWri04tFfICtQNT7dpHwOhViDrWPh
 XxNwvKN0OyMS2bSsjAsh5eM6uoHB9vTsmWhcdFtEfMFFeIZXeIa1zH9ChxEOGq4nboLw
 N7Udk6qfxsVgydGI9glk21pNL5pYJwqS7T2OLpDFyT9Vd/+f2CsNomEcjkUhSrVnZJ/x
 YM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Wel4qYBQBsQTcadDcbrnaN/Gk5MpHDN+HUhT4aWO7GM=;
 fh=9e9aI5kPfUwW3iYrqPzJ0moEUMF+yia+cJP+sdTdzsI=;
 b=VMTwA/cHHfKRjkL0cW9eTgwpe2sy15Bxlj6qvk1LeRzrJBI2CPWbG0rjKiWM8fRnNH
 6EfqL2fs10ECXsMrFVmsbSV8wAu28nedKCE11uLReA3HYxVWMXFPuEycjNcnqoDF3azV
 2ge/QafVDQ2V+pRhx+2QxHLSj8MWNXYWBYs4UjpEgFufdH+tTMuUGB2UnrTnm2WfU+kJ
 /cia1rueMHyN2omzELjps4abzx/ekFOlkxkjgyrSVbwYXXnKoCE8sUIwa9ga2aFEIITs
 /fGoV2kynVYl7NWwnjkOU0qHBAbeWlmiZuqPWHyvJKPF7B5AVQIJc6I8hYqhdBOlbWFB
 nBew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771874327; x=1772479127; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wel4qYBQBsQTcadDcbrnaN/Gk5MpHDN+HUhT4aWO7GM=;
 b=iKcFOjAQ8RY8RdOslJn+qhs2Z4sd4Do4PaqPKz6eJuY39ZXUcZ65fHNe5JzBi4byOk
 GyjOMxpWx/xj4CU0i9GE8ewth9K8vY3MJGYYeOrKiWUg19Pg3VoKJPFce8pe5oclPSxn
 tW4hP5OHYqM7sH6ALS6hEZ9DnkaYPAqGs9EZ6HuqLj4JQ8SuOVYpZ2iuRXzf6yoYV3DK
 ucLOB58hO4xy2/8BFaJyjP4vc6lgNSNVq1Cfrm3Eyg/Z/tTw+YR8v6chK6yyXJlqYdAp
 sIvybuKKCUTe2Ob05l0dP7Gr7gLROBPTRrpFqHBioq7qrepYjSLLKcN99ZRVyAALMx7U
 hutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771874327; x=1772479127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wel4qYBQBsQTcadDcbrnaN/Gk5MpHDN+HUhT4aWO7GM=;
 b=VeOOicSLd0sWeog3VhhA2zc1EEzQzUmAuzHKOVR7h+jV76Bm4jxTMuVlpMx/Bw0/H2
 Jvgs7uMmmPkaXChIOWe12VhhF2pyU70QTZ9TPrHvbx6Gr7jkkdCUKQA57/ubCVeUB0AA
 fLE8fmVOpUkoiIF/T1ewJBtVEX1G956geiVWyKONNf4zD5qmeCUG+R9053d9c5EwKrEs
 Yggutj/axxXT9yvPvlwypRLdbOzZ88z6hq+5OIWSYuef9KTgV1KXE0pNes8VLTrZPvIM
 yxCW2uvLUl7kF0OZarrWSf1Kr8uuyf3DiubOHFQorzroXoTKrEmHbLz9OutTQIl99r5F
 gTew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkjv2Jvt7ITdIvofiz3aLhuCO1E8xPi4LS6j7AX66DkznkHk0zNiskEidHDgdJ+MBjy1xNzayMQVkf@nongnu.org
X-Gm-Message-State: AOJu0YyhMV3AvP3wcRdtcTEIqw8atfpZ3Ik35Yfk6zJzEqmzFq267D7o
 SEnYCTmF3COXs4UGaj4mMe0xn7K88SfIR8aKB5lXkIMvWpnd5Sk3qU/uM/l2wVgNtXIYQruBKQB
 dKb+wPRaEGV4JUxx8pmGe96OeiRQ0ooE=
X-Gm-Gg: ATEYQzwU30tvZKBzSwSRWCsgZv3rY4C4zLX8LjT+9kIpDlK3yD//qktjpgPwoDQy2eu
 GwF8mBthliT8whldj4KHch5h16s8f/6fD+75pjp82d2I0Hc8IYh7zzx1lDJ0L6Wq4Gc13PaJIR1
 84tmlT10F18pCUPevxbtYk0io7qTS3jRNpArYcrjWUZnKYuEjzFKhum69GkctFl79cbHJsYDXA7
 9g2jw2wcyBMFjPynJ9gTqSeiC6BtCzoqCOM8iJEVx0Hs2Yt14TvKXUSu0QvQhHYEJpeB2rCuJq9
 uxxwZw2Xdg==
X-Received: by 2002:a05:6402:268d:b0:659:4383:c62c with SMTP id
 4fb4d7f45d1cf-65ea4efa708mr5058361a12.23.1771874327395; Mon, 23 Feb 2026
 11:18:47 -0800 (PST)
MIME-Version: 1.0
References: <CAFMJydMjLq+O+wuez_eSPYAqMgH9DPBXAW-o9zMZCSQVb_3e0w@mail.gmail.com>
In-Reply-To: <CAFMJydMjLq+O+wuez_eSPYAqMgH9DPBXAW-o9zMZCSQVb_3e0w@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 24 Feb 2026 03:18:32 +0800
X-Gm-Features: AaiRm52A2L_lkHgrBak9hZFs_yZ3xj_t6TRNuWmhlqcB1goMvmBux08VAXn3rAQ
Message-ID: <CAJSP0QV7V-r_tm7e204PgCWFFy4Vzw4w0Em7f6h22QLt4jtivg@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Arun Krishna K <arunkrishnak2407@gmail.com>
Cc: Alex Bennee <alex.bennee@linaro.org>, danpb@redhat.com,
 Helge Deller <deller@gmx.de>, 
 German Maglione <gmaglione@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 kvm <kvm@vger.kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 imp@bsdimp.com
Content-Type: multipart/alternative; boundary="000000000000df0295064b82a302"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
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

--000000000000df0295064b82a302
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 24, 2026, 00:18 Arun Krishna K <arunkrishnak2407@gmail.com>
wrote:

> I am reaching out to you regarding a potential GSoC project, as suggested
> by Warner Losh.
>

Warner did not volunteer to mentor this year. This sounds like an idea from
a previous year. Is this the project idea?
https://wiki.qemu.org/Internships/ProjectIdeas/FreeBSDUser


> I have been researching potential areas for contribution and noticed that
> QEMU currently has several missing ioctl calls. I am curious if
> implementing these would be a suitable topic for a GSoC project or a
> general contribution.
>
> I want to be clear that I am still evaluating this idea and am not
> entirely sure of its feasibility or scope. My current plan is to focus on
> the discrepancy between the ioctl headers and their actual implementations
> in linux-user/syscall.c to identify unimplemented ioctls. I also noticed
> that the current automation relies on regex, which I think can be improved
> in complex cases.
>

You will need to provide more details in order to find a mentor. Which
ioctls and which functionality will it enable?

Alternatively, maybe there is a project idea in the project ideas list that
you would like to apply for?
https://wiki.qemu.org/Google_Summer_of_Code_2026

Stefan


> I am interested in building a more reliable method to identify and address
> these gaps.
> If this is a viable path, I would appreciate your guidance on how to best
> approach it or if there are specific areas within this topic I should focus
> on.
>
> Thank you for your time.
>
> Best regards,
> Arun Krishna K
>
>

--000000000000df0295064b82a302
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 24, 2026, 00:18 Arun=
 Krishna K &lt;<a href=3D"mailto:arunkrishnak2407@gmail.com">arunkrishnak24=
07@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div>I am reaching out to you regarding a pote=
ntial GSoC project, as suggested by Warner Losh.</div></div></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Warner did not volu=
nteer to mentor this year. This sounds like an idea from a previous year. I=
s this the project idea?</div><div dir=3D"auto"><a href=3D"https://wiki.qem=
u.org/Internships/ProjectIdeas/FreeBSDUser">https://wiki.qemu.org/Internshi=
ps/ProjectIdeas/FreeBSDUser</a></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><br></div><div>I
 have been researching potential areas for contribution and noticed that
 QEMU currently has several missing ioctl calls. I am curious if=20
implementing these would be a suitable topic for a GSoC project or a=20
general contribution.</div><div><br></div><div>I want to be clear that I am=
 still evaluating this idea and am not entirely sure of its feasibility or=
=20
scope. My current plan is to focus on the discrepancy between the ioctl=20
headers and their actual implementations in linux-user/syscall.c to=20
identify unimplemented ioctls. I also noticed that the current=20
automation relies on regex, which I think can be improved in complex=20
cases.=C2=A0</div></div></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">You will need to provide more details in order to find =
a mentor. Which ioctls and which functionality will it enable?=C2=A0</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Alternatively, maybe there is =
a project idea in the project ideas list that you would like to apply for?=
=C2=A0</div><div dir=3D"auto"><a href=3D"https://wiki.qemu.org/Google_Summe=
r_of_Code_2026">https://wiki.qemu.org/Google_Summer_of_Code_2026</a></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Stefan</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container=
"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><=
br></div><div>I am interested in building a more reliable method to identif=
y=20
and address these gaps.</div><div>If this is a viable path, I would=20
appreciate your guidance on how to best approach it or if there are=20
specific areas within this topic I should focus on.</div><div><br></div><di=
v>Thank you for your time.</div><div><br></div><div>Best regards,</div><div=
>Arun Krishna K</div><br></div>
</blockquote></div></div></div>

--000000000000df0295064b82a302--

