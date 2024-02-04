Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C183DC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 09:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWZ0V-0006Kv-VQ; Sun, 04 Feb 2024 04:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <masscry@gmail.com>) id 1rWZ0T-0006Kd-Fo
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 04:41:46 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <masscry@gmail.com>) id 1rWZ0R-0005vN-NL
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 04:41:45 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6e117e0fee8so1877578a34.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 01:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707039702; x=1707644502; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BPQp6mp3W7B9614FksRqkI9DVfyOMDCa7deDHD6efHk=;
 b=Fgb1DXJfEyXt+9uLVekRZt7IvPuw4aw1U0r9awyFxnXPDW5MN2S1srhzllWLDDre7k
 xP5aunDtowq3s1c99KqORPZUNwUEisFkrpg9LijlAsW21MXfsL2niG3PvUxm6J7TWkmy
 Y4nBt7+5AYtR65aBathSPmHw6YUSwilRCbSZm6jOWD8+gROWZoSpsJkHhWAZC/yWNFdx
 ztb5c03amjkIjnzLc+YXpeairwqjfVaUIT32fRYfMJvemfrlEJsODhlKqumuVNcpu/oj
 2thYscfcX/zh96Cd2CiShGAJnM6FcH0oW2hzX/lxcJcknpueKzLwfAyR8TcCoWCzOMwW
 uyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707039702; x=1707644502;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BPQp6mp3W7B9614FksRqkI9DVfyOMDCa7deDHD6efHk=;
 b=j+qWuLJOr8p1Ink4Ah6DSCEKz2UzWHp6ed1p+yYM9RODmRU6SiWKivTqJqvuoDFQHa
 S1rLK7GMS4gOO9Z7/3DABsidoF3zrMXfEfGwSgpNZk9sW75QkTB+y+tL+OiOsS1DOlSe
 6CDuubH4wA5UAfsfN92G/cI78r6EXQmfzSR1g6+089xMrtMCEsdbPEhrWYQKi3YZuU0y
 +1AG4O2RQh33D9IHVyBuMzaH12hSw6cntDY78jfHAmckrx30zN5jGG5LOtMN92oyBFCq
 ivYddLYOm82AQnOtH5OL1/MTO/Hevzp9ZAB6+guA7TH4kZxpL3i+COVoYZ9QHXxLhDPo
 GXCQ==
X-Gm-Message-State: AOJu0YyVgC3MFkCX6St49O+g3XSsH5hzAWKWiP2B1hSdTOaa4Yltlovs
 ZDFX+OarnXOjWXQlm4Kkz7gLAQdzFW5Fu5PYgQNKCgQsOQK+4itPUvxxRq30+puScwaJUEGfVID
 tl7N8lzg7puKVYK7UfMbRqxIJ2YZ7fDYNAcI=
X-Google-Smtp-Source: AGHT+IGBh90xF5fAJZp1y3l7EF6SZ7yXzzdHytHtWppolajQlJJOlaR0vazm0vuWTbkUR3737v6wFK/H2sNvAYOGlvQ=
X-Received: by 2002:a9d:7444:0:b0:6dd:f075:e45b with SMTP id
 p4-20020a9d7444000000b006ddf075e45bmr13983727otk.16.1707039701906; Sun, 04
 Feb 2024 01:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20240113012741.54664-1-masscry@gmail.com>
In-Reply-To: <20240113012741.54664-1-masscry@gmail.com>
From: =?UTF-8?B?0KLQuNC80YPRgA==?= <masscry@gmail.com>
Date: Sun, 4 Feb 2024 12:41:31 +0300
Message-ID: <CABH+J_76pW0-XQVUsJ+7faK-gCVaoa7DScDcdHmcZxdc25GC5g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix pointer arithmetic in indirect read for
 libvhost-user and libvduse
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000cbb5306108b27c1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=masscry@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000000cbb5306108b27c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, I am very sorry for bothering community on a such minor problem
again, but I got no response for a few weeks, so maybe I have started
thread on a wrong mailing list, so I made an issue in gitlab issue tracker:
https://gitlab.com/qemu-project/qemu/-/issues/2149 referencing this thread.

Maybe, it would help attract proper eyes to such a simple problem, so no
one bothers in trying to fix it, albeit it lives in the codebase for some
time already and is being copied around.

Sincerely,
Temir.

=D1=81=D0=B1, 13 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 04:28, Tem=
ir Zharaspayev <masscry@gmail.com>:

> Hello! I have found a problem with virtqueue_read_indirect_desc function,
> which
> was advancing pointer to struct as it was a byte pointer, so every elemen=
t
> comming after first chunk would be copied somewhere out of buffer.
>
> As I understand this is cold path, but nevertheless worth fixing.
>
> Also, exacly same problem in vduse_queue_read_indirect_desc function,
> because
> as I understand it is a copy of virtqueue_read_indirect_desc with vduse
> backend.
>
> I was not sure if element of scattered buffer may end in the middle of
> vring_desc struct data, so instead of writing
> desc +=3D read_len/sizeof(struct vring_desc)
> have implemented fix with proper byte pointer arithmetic.
>
> Sincerely,
> Temir.
>
> Temir Zharaspayev (2):
>   libvhost-user: Fix pointer arithmetic in indirect read
>   libvduse: Fix pointer arithmetic in indirect read
>
>  subprojects/libvduse/libvduse.c           | 11 ++++++-----
>  subprojects/libvhost-user/libvhost-user.c | 11 ++++++-----
>  2 files changed, 12 insertions(+), 10 deletions(-)
>
> --
> 2.34.1
>
>

--0000000000000cbb5306108b27c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello, I am very sorry for bothering community on a s=
uch minor problem again, but I got no response for a few weeks, so maybe I =
have started thread on a wrong mailing list, so I made an issue in gitlab i=
ssue tracker: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2149=
">https://gitlab.com/qemu-project/qemu/-/issues/2149</a> referencing this t=
hread.<br></div><div><br></div><div>Maybe, it would help attract proper eye=
s to such a simple problem, so no one bothers in trying to fix it, albeit i=
t lives in the codebase for some time already and is being copied around.</=
div><div><br></div><div>Sincerely,</div><div>Temir.<br></div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D0=B1, =
13 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 04:28, Temir Zharaspayev=
 &lt;<a href=3D"mailto:masscry@gmail.com">masscry@gmail.com</a>&gt;:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hello! I have found a =
problem with virtqueue_read_indirect_desc function, which<br>
was advancing pointer to struct as it was a byte pointer, so every element<=
br>
comming after first chunk would be copied somewhere out of buffer.<br>
<br>
As I understand this is cold path, but nevertheless worth fixing.<br>
<br>
Also, exacly same problem in vduse_queue_read_indirect_desc function, becau=
se<br>
as I understand it is a copy of virtqueue_read_indirect_desc with vduse<br>
backend.<br>
<br>
I was not sure if element of scattered buffer may end in the middle of<br>
vring_desc struct data, so instead of writing<br>
desc +=3D read_len/sizeof(struct vring_desc)<br>
have implemented fix with proper byte pointer arithmetic.<br>
<br>
Sincerely,<br>
Temir.<br>
<br>
Temir Zharaspayev (2):<br>
=C2=A0 libvhost-user: Fix pointer arithmetic in indirect read<br>
=C2=A0 libvduse: Fix pointer arithmetic in indirect read<br>
<br>
=C2=A0subprojects/libvduse/libvduse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 11 ++++++-----<br>
=C2=A0subprojects/libvhost-user/libvhost-user.c | 11 ++++++-----<br>
=C2=A02 files changed, 12 insertions(+), 10 deletions(-)<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--0000000000000cbb5306108b27c1--

