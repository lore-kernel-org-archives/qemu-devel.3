Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EDAC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 22:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta09N-0004so-GN; Mon, 20 Jan 2025 17:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fahhem@fahhem.com>) id 1ta09L-0004sS-C4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 17:21:39 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fahhem@fahhem.com>) id 1ta09J-0001kS-Cp
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 17:21:39 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5447fae695so8334265276.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 14:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fahhem.com; s=google; t=1737411696; x=1738016496; darn=nongnu.org;
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mDZQXxH0TD/ifJyMq0A2JhwzMvoxhjbh11jn58vdJDw=;
 b=j39D0DPFL5gEGgJ9Ta0Z25mFxfDJGBy8om0OIVRT9stTz9jOqZH/ejFfpEzCnh8Bft
 PxunMxDR9NAz0rwYyNUnuvlpnxyxujjh/7TnsdtFfSXyP/RKmVXL+0UVJ6lb8tBe2BC+
 AKyl4pJyz2Sa+j4ONDit/xechM96GJdqdwI/phHFdyB+i6ihaQmPOMpnqdgAu5aNEeyN
 to7BIXc2fconsv3FISJmfLHzLEkaztAaDqu2qaiwY6w7IVQrRPiSQONSirHZ0TftRyUm
 /DoLPpQcRi5tlZl7hEW/Yy7UXHinGpKuZFAECVnotKQYBy2X6V5xXtogADNeJEn0mMSr
 hOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737411696; x=1738016496;
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mDZQXxH0TD/ifJyMq0A2JhwzMvoxhjbh11jn58vdJDw=;
 b=RZdZp1EiQxrSUV4oFajtXEf30B0t7oz/7iP93sYQjCnVyOh9l4oXfAs6smilF+dcSl
 kJxJd98Ufl8Xz3UrPzqazbVZ03o+o4NMMdktHQYI7zNxhnGu8HBFH2R5m0xTD0GExaUB
 Kx5rlU+21QdD7P29/f/518ftRv+JcwMRBiPs7evJFC4tzQPBi74SuDPlKCRhjQHE+t3i
 VeRtY4so3t/O66cHwGrzji/QrMyj5HVEOZXEtmBrI5xDfZPGeotuGkzjtARrdVkkHhgF
 gu6ePw7pP6GW95Q9zpWN47Ic283VufnFP11FXNMkzfoJwTCUyAMr3niqQsiIHygwGEPt
 AfBw==
X-Gm-Message-State: AOJu0YwfYu1xWzIbfXxh20qrffqJyYYQMPdufI2rof4arQ+TJ6IvUvj6
 haCaPaAx6bctSiycYozewWJ6TFhC+fiAwkw89fIr0n2RcH/81v9mbbEmFoI8IHUZMr2tTh7+acc
 =
X-Gm-Gg: ASbGnctXVDFWP9M4cRW0RgFnlZef8DQ4Kg3q1gELFwqaI6T20XK2YHhxo91DC5c4Fa1
 Pc1pJ0xmy3X7c+aAXXpFKVx0/zxXIrFHdMMn7Xvmonf1v2B91VBnltNd9doH8OF1hMmCixYaP4m
 xoJH9rL1QpXKyqqvMPkdL+Rq5V6/AsuhAHIE3RNbv+D2LI5gwGIe408owH++yvJQiS3CGMJCBRj
 Jz9G5WJhNuq2OzW9PZ3EwhHZA/j/vxaWw6C+XdfJ7RbvuDAcWSn4KxFYBgOBHCi3owl+hWXyduM
 JScsQHYyJSnOYzjrgcAizTEoVw+CGHU1
X-Google-Smtp-Source: AGHT+IFlqmf7La3EtE/8uddkhRn58g2yA9Mlqc7qV+IQXgOJRcjvREmCPecFviIpC821N8zeLUmFZA==
X-Received: by 2002:a05:690c:6405:b0:6f4:8207:c68d with SMTP id
 00721157ae682-6f6eb65c9cfmr103870427b3.3.1737411695956; 
 Mon, 20 Jan 2025 14:21:35 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com.
 [209.85.219.177]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f6e63fddb1sm15213407b3.30.2025.01.20.14.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 14:21:35 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so8241361276.3; 
 Mon, 20 Jan 2025 14:21:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWx3a2N1ZA1FgboOBFyazlyw1giHIb8Bnf7gCRdZZ5v52cEwH1QUlOWETCOXaDXvlOpmYVtSU5JnPEA@nongnu.org
X-Received: by 2002:a05:690c:c94:b0:6ef:6035:828e with SMTP id
 00721157ae682-6f6eb9414ebmr111063737b3.35.1737411695357; Mon, 20 Jan 2025
 14:21:35 -0800 (PST)
Received: from 281799484056 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 14:21:34 -0800
Received: from 281799484056 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 14:21:34 -0800
MIME-Version: 1.0
From: Fahrzin Hemmati <fahhem@fahhem.com>
X-Shortwave-Message-Id: m-0b747540-87a3-4ed9-addd-11235ab0ba93
In-Reply-To: <b3e7b218-66eb-4d5f-b9ed-6a20dbca2a8a@tls.msk.ru>
References: <20250120103711.836753-1-fahhem@fahhem.com>
 <Z45ANK-m2XZazDi3@redhat.com>
 <CAHJ_xmW3YCrKEpNGBJxRzqM99Aoe=nwOSJWF+BO5VbySP9763g@mail.gmail.com>
 <b3e7b218-66eb-4d5f-b9ed-6a20dbca2a8a@tls.msk.ru>
Date: Mon, 20 Jan 2025 14:21:34 -0800
X-Gmail-Original-Message-ID: <CAHJ_xmVDZ159ixki4qpvOMdA1zLpwSkVnB_ukx_EfW1ve0o=+A@mail.gmail.com>
X-Gm-Features: AbW1kvaVnQ7mxqEktqRZD1uuygmCSz5kbPvtBRnHHK2M87YlJkDtUedaj0qBdBM
Message-ID: <CAHJ_xmVDZ159ixki4qpvOMdA1zLpwSkVnB_ukx_EfW1ve0o=+A@mail.gmail.com>
Subject: Re: [PATCH] Skip resizing image to the same size
To: Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ee3bb8062c2aae53"
Received-SPF: none client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=fahhem@fahhem.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000ee3bb8062c2aae53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Happy to wait until your patchset is in.

Yes, this is a no-op, but it reads the entire disk image to perform that
no-op, so this is merely a time-saving improvement, not a behavior change.

On Mon Jan 20, 2025, 09:49 PM GMT, Michael Tokarev <mjt@tls.msk.ru> wrote:

20.01.2025 23:17, Fahrzin Hemmati wrote:

My apologies, I saw the Signed-off-by requirement at first, but as I
followed the docs I got to "git publish" and didn't realize "git publish"
was
actually able to send emails on my system (I don't remember setting up any
SMTP settings). By that time, I forgot and thought this patch was short
enough to not warrant much of a commit message.

The main practical advantage is for users that call "qemu-img resize" via
scripts or other systems (like Packer in my case) that don't check the
image
size ahead of time. I can upstream this change into them (by using
"qemu-img info =E2=80=94output=3Djson ...") but I figured it would be usefu=
l to more
users here.

This could trivially be added to block/io.c:bdrv_co_truncate(), as well as
blockdev.c:qmp_block_resize() with a little more work. I'm not familiar
with those workflows, but if needed I can do that as well.

Here's the new patch:

From 17f5c5f03d930c4816b92b97e0e54db0725d7b94 Mon Sep 17 00:00:00 2001
From: Fahrzin Hemmati <fahhem@fahhem.com <mailto:fahhem@fahhem.com>>
Date: Mon, 20 Jan 2025 01:56:24 -0800
Subject: [PATCH] Skip resizing image to the same size

Higher-level software, such as Packer, blindly call "qemu-img resize"
even when the size is the same. This change can be pushed to those
users, but it's very cheap to check and can save many other users more
time here.

Signed-off-by: Fahrzin Hemmati <fahhem@fahhem.com <mailto:fahhem@fahhem.com
>>
---
qemu-img.c | 6 ++++++
tests/qemu-iotests/061 | 8 ++++++++
tests/qemu-iotests/061.out | 9 +++++++++
3 files changed, 23 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 2f2fac90e8..3345c4e63f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4184,6 +4184,12 @@ static int img_resize(int argc, char **argv)
goto out;
}

+ if (total_size =3D=3D current_size) {
+ qprintf(quiet, "Image already has the desired size.\n");
+ ret =3D 0;
+ goto out;
+ }



I don't think this is necessary: the actual operation is a no-op
anyway, there's no need to special-case it.

Please also refrain from changing qemu-img until my refresh
patchset is either accepted or rejected. It was a large work
and it'd be sad to lose it.

Thanks,

/mjt

--000000000000ee3bb8062c2aae53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div><div><span>Happy to wait until your patchset is in.</span>=
</div><br><div><span>Yes, this is a no-op, but it reads the entire disk ima=
ge to perform that no-op, so this is merely a time-saving improvement, not =
a behavior change.</span></div></div><br><div><div>On Mon Jan 20, 2025, 09:=
49 PM GMT, <a href=3D"mailto:mjt@tls.msk.ru">Michael Tokarev</a> wrote:<br>=
</div><blockquote style=3D"margin:0 0 0 4pt;padding-left:4pt;border-left:1p=
x solid #ccc"><div style=3D"color:#212121;font-size:14px;font-weight:normal=
;line-height:20px">20.01.2025 23:17, Fahrzin Hemmati wrote:<blockquote>My a=
pologies, I saw the Signed-off-by requirement at first, but as I followed t=
he docs I got to &quot;git publish&quot; and didn&#39;t realize &quot;git p=
ublish&quot; was <br>actually able to send emails on my system (I don&#39;t=
 remember setting up any SMTP settings). By that time, I forgot and thought=
 this patch was short <br>enough to not warrant much of a commit message.<b=
r><br>The main practical advantage is for users that call &quot;qemu-img re=
size&quot; via scripts or other systems (like Packer in my case) that don&#=
39;t check the image <br>size ahead of time. I can upstream this change int=
o them (by using &quot;qemu-img info =E2=80=94output=3Djson ...&quot;) but =
I figured it would be useful to more users here.<br><br>This could triviall=
y be added to block/io.c:bdrv_co_truncate(), as well as blockdev.c:qmp_bloc=
k_resize() with a little more work. I&#39;m not familiar <br>with those wor=
kflows, but if needed I can do that as well.<br><br>Here&#39;s the new patc=
h:<br><br> From 17f5c5f03d930c4816b92b97e0e54db0725d7b94 Mon Sep 17 00:00:0=
0 2001<br>From: Fahrzin Hemmati &lt;<a href=3D"mailto:fahhem@fahhem.com">fa=
hhem@fahhem.com</a> &lt;mailto:<a href=3D"mailto:fahhem@fahhem.com">fahhem@=
fahhem.com</a>&gt;&gt;<br>Date: Mon, 20 Jan 2025 01:56:24 -0800<br>Subject:=
 [PATCH] Skip resizing image to the same size<br><br>Higher-level software,=
 such as Packer, blindly call &quot;qemu-img resize&quot;<br>even when the =
size is the same. This change can be pushed to those<br>users, but it&#39;s=
 very cheap to check and can save many other users more<br>time here.<br><b=
r>Signed-off-by: Fahrzin Hemmati &lt;<a href=3D"mailto:fahhem@fahhem.com">f=
ahhem@fahhem.com</a> &lt;mailto:<a href=3D"mailto:fahhem@fahhem.com">fahhem=
@fahhem.com</a>&gt;&gt;<br>---<br>qemu-img.c | 6 ++++++<br>tests/qemu-iotes=
ts/061 | 8 ++++++++<br>tests/qemu-iotests/061.out | 9 +++++++++<br>3 files =
changed, 23 insertions(+)<br><br>diff --git a/qemu-img.c b/qemu-img.c<br>in=
dex 2f2fac90e8..3345c4e63f 100644<br>--- a/qemu-img.c<br>+++ b/qemu-img.c<b=
r>@@ -4184,6 +4184,12 @@ static int img_resize(int argc, char **argv)<br>go=
to out;<br>}<br><br>+ if (total_size =3D=3D current_size) {<br>+ qprintf(qu=
iet, &quot;Image already has the desired size.\n&quot;);<br>+ ret =3D 0;<br=
>+ goto out;<br>+ }</blockquote><br><br>I don&#39;t think this is necessary=
: the actual operation is a no-op<br>anyway, there&#39;s no need to special=
-case it.<br><br>Please also refrain from changing qemu-img until my refres=
h<br>patchset is either accepted or rejected.  It was a large work<br>and i=
t&#39;d be sad to lose it.<br><br>Thanks,<br><br>/mjt<br></div></blockquote=
></div></body></html>

--000000000000ee3bb8062c2aae53--

