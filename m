Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04230C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGEB-0001pa-EA; Tue, 21 Jan 2025 10:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fahhem@fahhem.com>) id 1taGDT-0001l4-1e
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:31:18 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fahhem@fahhem.com>) id 1taGDO-0006iI-8C
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:30:56 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so8311352276.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fahhem.com; s=google; t=1737473453; x=1738078253; darn=nongnu.org;
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EQAiz5YcY3KJs9AqwGd8ALQmMWrxl9M4bx30E1fBZ90=;
 b=ikDBEpRBhOqDwVurq5M63VXwZ7WRaBpKORp7VZO4iVLzex2OREoUr4yrA3CY2xDKyQ
 A62LvJwZYwAhiTpyszk2NmrMNK8z1Fr5HrwfsAt4i7He9yy6U6a+kSzDqAghnQAQchx2
 YcJYbkp4QRGZU5sxiQotjngxVe9QrqycLE7MAUYHo4Y35/Gp0k8KCXehWAxAfpzDnKdM
 3Ok5TnaIyEtJkaDeBNANlrpedzTmc8JnZ568O1sTFZJIxaHDsnsMwNfugcam+hidL8IU
 qDb6OQr9YsACKOsZG/FqX+wIwSeGzfivcV4vZ8HPwKqBA+wJvb9ybtH8Sls4rney5PF9
 ZVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737473453; x=1738078253;
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EQAiz5YcY3KJs9AqwGd8ALQmMWrxl9M4bx30E1fBZ90=;
 b=CR/S5R22uXuWVBRuGi+ws0+N1P1YqYVaSAgTr2TGDnjOHY7mtHa7k+M8XMNSh2GzUc
 tvskcOQ+Q4ynRhzlZ1E0DAB5/g8XztD++bd6bPXkaDYR01YGAsjUDX0h3dVBK7RwLXIX
 zKyaBGMS1g9IbKNc6UbXrGAVKDtkEFMvZ0yhOrjmRNolAR+s4d37tdad8SdCxttzPh3C
 N/aHtMFx1Ryoq8lNSSam9S2NvNSX3VGRn/Na63aXG7u8OS4WK5fG38hR9e7bUhl27ain
 e5TGds3gYconArfNQhQLcMYLDl1zj/VDfZD5zvAIQWOz/T/u9pe15gVDRH74xV0YpTqO
 bRYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmqOcDt9PJPoD6YeFiuDY9cw42g6K8AUnjstItsO3z4GY0g74Bo4ay5n1xns+aR56DJlRGJGutg1/K@nongnu.org
X-Gm-Message-State: AOJu0Yw/ALztX8cFWKodOzxopqXehAgh3uxAnUFoTefWMB287vbpbWFE
 plVIehozgngezE9iJy9iYtYbwVeJi20yUQC+1DL7MroHjz4vnR9dqOk/4bzFPNfloME6GM3y4Lw
 =
X-Gm-Gg: ASbGncvODWgVNOn/Ca2mZR9P04Z81Sg6kmcPRPEbkLPHLWH3KDHb6XEyzuZkpJCjfmK
 VfVvBpqwCaNHWf5sd39LmYcR9W8YR+x4dwN0UOGm/drTvvadHmlWNzL5V+LhtTZM9n4jKzSJFvS
 1CBaiV8oqATlDnmM922wYZANQd+xU6YFFMijstQD0Jfsw1f9BoZZ9BDd+LkidcSad2F+GIsDPqH
 BlY9OdLfJJ1Ojfq2JogU4PMVh5qFfjtJZP/JbOP2/ikjEgPftArwLwO/nFkZimM4C8xKbuwhNo7
 JhUIUSbG0ue0wC7hMfx9Fd7NDml5YkR0
X-Google-Smtp-Source: AGHT+IH8UP1M9mZRESjdQ/b1U8Ydh2fuoLX+TJ97YjKYAgGHLDOUlylGCTamGHimnGm9/Il7Fd2CcA==
X-Received: by 2002:a05:690c:968b:b0:6f6:d149:d64a with SMTP id
 00721157ae682-6f6eb908ca1mr134404447b3.27.1737473452730; 
 Tue, 21 Jan 2025 07:30:52 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com.
 [209.85.219.172]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f6e66d43c5sm17608097b3.82.2025.01.21.07.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:30:52 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so8311293276.0; 
 Tue, 21 Jan 2025 07:30:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVpl0LX6bx6N7wBM3HsaGsy+WUcIJl6qWGC5mbNuFBzCONpEow3oeeK6xqyTBXdwKKJPsoeSG/VlB1X@nongnu.org,
 AJvYcCWVzzO3OBL3uQMRGLYlYZSQ4h20qjScmtzFXqbeKwagdKguhUaoKmLMNUQ45dqE1Wy4QFFs4NrMgmemXw==@nongnu.org
X-Received: by 2002:a05:690c:6710:b0:6ef:60f4:3d41 with SMTP id
 00721157ae682-6f6eb671c8cmr139427787b3.16.1737473451748; Tue, 21 Jan 2025
 07:30:51 -0800 (PST)
Received: from 281799484056 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jan 2025 09:30:51 -0600
Received: from 281799484056 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jan 2025 09:30:51 -0600
MIME-Version: 1.0
From: Fahrzin Hemmati <fahhem@fahhem.com>
X-Shortwave-Message-Id: m-da9bb14d-1174-4a41-93a8-d9a34771ab32
In-Reply-To: <Z4-HlVbF2gRAgi86@redhat.com>
References: <20250120103711.836753-1-fahhem@fahhem.com>
 <Z45ANK-m2XZazDi3@redhat.com>
 <CAHJ_xmW3YCrKEpNGBJxRzqM99Aoe=nwOSJWF+BO5VbySP9763g@mail.gmail.com>
 <b3e7b218-66eb-4d5f-b9ed-6a20dbca2a8a@tls.msk.ru>
 <CAHJ_xmVDZ159ixki4qpvOMdA1zLpwSkVnB_ukx_EfW1ve0o=+A@mail.gmail.com>
 <Z4-HlVbF2gRAgi86@redhat.com>
Date: Tue, 21 Jan 2025 09:30:51 -0600
X-Gmail-Original-Message-ID: <CAHJ_xmWn=86TBwKhG3Krp2JSfY+H3UOxHaq_JU5YfcxuQuNbfg@mail.gmail.com>
X-Gm-Features: AbW1kvb-rqPAcDk-jagIDdtY8mpAj64T9Giv3Yd_UV1DtqsfPX_K6Y2YKjCTUQ0
Message-ID: <CAHJ_xmWn=86TBwKhG3Krp2JSfY+H3UOxHaq_JU5YfcxuQuNbfg@mail.gmail.com>
Subject: Re: [PATCH] Skip resizing image to the same size
To: Kevin Wolf <kwolf@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e5fe3f062c390fd9"
Received-SPF: none client-ip=2607:f8b0:4864:20::b34;
 envelope-from=fahhem@fahhem.com; helo=mail-yb1-xb34.google.com
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

--000000000000e5fe3f062c390fd9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm running packer, and with a qcow2 source image sized at 75000MB (but
only 5GB on disk) when it runs "qemu-img resize ... 75000MB" it takes about
10 seconds on my system. I guess it's not reading the whole disk since me
nvme isn't that fast, but it's a non-trivial amount of work. It also runs a
qemu-img convert call (again, from qcow2 to qcow2) that seems more like a
cp, and that takes the same 10 seconds on my system.

On Tue Jan 21, 2025, 11:40 AM GMT, Kevin Wolf <kwolf@redhat.com> wrote:

Am 20.01.2025 um 23:21 hat Fahrzin Hemmati geschrieben:

Happy to wait until your patchset is in.

Yes, this is a no-op, but it reads the entire disk image to perform that
no-op, so this is merely a time-saving improvement, not a behavior change.


Can you give more context on what exactly you're doing that it reads the
entire disk image just to resize it? This sounds completely unexpected
and if it does, there may be a different problem to be solved.

In my test, for a raw image, I see a single ftruncate() call, which is
unnecessary, but shouldn't cause any measurable time difference for the
qemu-img run. qcow2 has a little more code in QEMU to figure out that
there is nothing to do, but it doesn't involve any syscall and certainly
not reading the whole image.

Kevin

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

--000000000000e5fe3f062c390fd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div><div><span>I&#39;m running packer, and with a qcow2 source=
 image sized at 75000MB (but only 5GB on disk) when it runs &quot;qemu-img =
resize ... 75000MB&quot; it takes about 10 seconds on my system. I guess it=
&#39;s not reading the whole disk since me nvme isn&#39;t that fast, but it=
&#39;s a non-trivial amount of work. It also runs a qemu-img convert call (=
again, from qcow2 to qcow2) that seems more like a cp, and that takes the s=
ame 10 seconds on my system. </span></div></div><br><div><div>On Tue Jan 21=
, 2025, 11:40 AM GMT, <a href=3D"mailto:kwolf@redhat.com">Kevin Wolf</a> wr=
ote:<br></div><blockquote style=3D"margin:0 0 0 4pt;padding-left:4pt;border=
-left:1px solid #ccc"><div style=3D"color:#212121;font-size:14px;font-weigh=
t:normal;line-height:20px">Am 20.01.2025 um 23:21 hat Fahrzin Hemmati gesch=
rieben:<blockquote>Happy to wait until your patchset is in.<br><br>Yes, thi=
s is a no-op, but it reads the entire disk image to perform that<br>no-op, =
so this is merely a time-saving improvement, not a behavior change.</blockq=
uote><br>Can you give more context on what exactly you&#39;re doing that it=
 reads the<br>entire disk image just to resize it? This sounds completely u=
nexpected<br>and if it does, there may be a different problem to be solved.=
<br><br>In my test, for a raw image, I see a single ftruncate() call, which=
 is<br>unnecessary, but shouldn&#39;t cause any measurable time difference =
for the<br>qemu-img run. qcow2 has a little more code in QEMU to figure out=
 that<br>there is nothing to do, but it doesn&#39;t involve any syscall and=
 certainly<br>not reading the whole image.<br><br>Kevin<br><blockquote>On M=
on Jan 20, 2025, 09:49 PM GMT, Michael Tokarev &lt;<a href=3D"mailto:mjt@tl=
s.msk.ru">mjt@tls.msk.ru</a>&gt; wrote:<br><br>20.01.2025 23:17, Fahrzin He=
mmati wrote:<br><br>My apologies, I saw the Signed-off-by requirement at fi=
rst, but as I<br>followed the docs I got to &quot;git publish&quot; and did=
n&#39;t realize &quot;git publish&quot;<br>was<br>actually able to send ema=
ils on my system (I don&#39;t remember setting up any<br>SMTP settings). By=
 that time, I forgot and thought this patch was short<br>enough to not warr=
ant much of a commit message.<br><br>The main practical advantage is for us=
ers that call &quot;qemu-img resize&quot; via<br>scripts or other systems (=
like Packer in my case) that don&#39;t check the<br>image<br>size ahead of =
time. I can upstream this change into them (by using<br>&quot;qemu-img info=
 =E2=80=94output=3Djson ...&quot;) but I figured it would be useful to more=
<br>users here.<br><br>This could trivially be added to block/io.c:bdrv_co_=
truncate(), as well as<br>blockdev.c:qmp_block_resize() with a little more =
work. I&#39;m not familiar<br>with those workflows, but if needed I can do =
that as well.<br><br>Here&#39;s the new patch:<br><br>From 17f5c5f03d930c48=
16b92b97e0e54db0725d7b94 Mon Sep 17 00:00:00 2001<br>From: Fahrzin Hemmati =
&lt;<a href=3D"mailto:fahhem@fahhem.com">fahhem@fahhem.com</a> &lt;mailto:<=
a href=3D"mailto:fahhem@fahhem.com">fahhem@fahhem.com</a>&gt;&gt;<br>Date: =
Mon, 20 Jan 2025 01:56:24 -0800<br>Subject: [PATCH] Skip resizing image to =
the same size<br><br>Higher-level software, such as Packer, blindly call &q=
uot;qemu-img resize&quot;<br>even when the size is the same. This change ca=
n be pushed to those<br>users, but it&#39;s very cheap to check and can sav=
e many other users more<br>time here.<br><br>Signed-off-by: Fahrzin Hemmati=
 &lt;<a href=3D"mailto:fahhem@fahhem.com">fahhem@fahhem.com</a> &lt;mailto:=
<a href=3D"mailto:fahhem@fahhem.com">fahhem@fahhem.com</a><br>&gt;&gt;<br>-=
--<br>qemu-img.c | 6 ++++++<br>tests/qemu-iotests/061 | 8 ++++++++<br>tests=
/qemu-iotests/061.out | 9 +++++++++<br>3 files changed, 23 insertions(+)<br=
><br>diff --git a/qemu-img.c b/qemu-img.c<br>index 2f2fac90e8..3345c4e63f 1=
00644<br>--- a/qemu-img.c<br>+++ b/qemu-img.c<br>@@ -4184,6 +4184,12 @@ sta=
tic int img_resize(int argc, char **argv)<br>goto out;<br>}<br><br>+ if (to=
tal_size =3D=3D current_size) {<br>+ qprintf(quiet, &quot;Image already has=
 the desired size.\n&quot;);<br>+ ret =3D 0;<br>+ goto out;<br>+ }<br><br><=
br><br>I don&#39;t think this is necessary: the actual operation is a no-op=
<br>anyway, there&#39;s no need to special-case it.<br><br>Please also refr=
ain from changing qemu-img until my refresh<br>patchset is either accepted =
or rejected. It was a large work<br>and it&#39;d be sad to lose it.<br><br>=
Thanks,<br><br>/mjt</blockquote><br></div></blockquote></div></body></html>

--000000000000e5fe3f062c390fd9--

