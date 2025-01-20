Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9299AC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZzCV-00028G-Pe; Mon, 20 Jan 2025 16:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fahhem@fahhem.com>) id 1tZyDQ-00015L-Eg
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:17:44 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fahhem@fahhem.com>) id 1tZyDO-00068U-1z
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:17:44 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e399e904940so7317786276.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fahhem.com; s=google; t=1737404260; x=1738009060; darn=nongnu.org;
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mZnV800hRobfbAMySphqpfbmTDEhnDESiwZuPpwfNuM=;
 b=YRkPMRlW0P9SD/ePvuoUnFAV6etuLSoMw35iMEclVGKRBRN2EBMpkiWY3h4gp3NIY0
 y5URh0BQlqV21vOMeBvFZXEGGkdJLwaEppNy1NSIrqfJHQwzYut9Dixmndh7+Iqp12KV
 YfLpImw2HvhVJf7GfbpSAmqN/Xf3h2X8oT6qStW1HdV0qtPO3kaJ0UiG0FmJdd8Nut1g
 HvwfWgmL9FcRLsfDEyM3hdbtjb1ZYmvLkWYFJS7Mv9np0hxhNROn7TcD3kPnzBspew9l
 Qp1Eq1mDnH8+0ZR8zI6YJtyEU7COPQutsbsTasx7k+AR2PqlwJhdI84UPQk8O4YAbktz
 +ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737404260; x=1738009060;
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZnV800hRobfbAMySphqpfbmTDEhnDESiwZuPpwfNuM=;
 b=Ev8UzRe9obAod6A50D4THuqDZdNEZj9mlRs84pZ0rVJb1HFyBkranMhShnDdwAALYV
 BSgXVesSjR9ULxZFLgmuiG9531v/reR672SjzKuMMfK28SpJ9cIiZuK0pewHFnd0gfac
 HURix6NbNxgXQ00Scq4FZ0LGy0cBOQ2lgq1abvaJuXixrw0S2NK/BhziP1OeG+i9cd08
 TLXUnabOfEY4urMUuIcmkGzcSHGlZJYtrvIxxqVT+f/eTbNbMjdTefZnESzCaggwKXzy
 E2xQPpczTaOxZpJso3bclOfP8PeyaJOZYFnHU/SGKfOReZL7f2biNlKMw8niZnEWq31M
 WEAQ==
X-Gm-Message-State: AOJu0Yz80pCQqhgTMMEYh0fJSCXXohL2alAZPQzg3d6e/wyBEdGR1UfM
 jA4PnGqWwdGFtKrKF+lOPpSZ+hYtRqN7QRPMHFhQkxYhvwmv3dJt4fE5br3tKCpoKUGYvAWfEDI
 =
X-Gm-Gg: ASbGncuh1+Jvdwmee+IYIVpZv0Fg2KqphF13UwUw2Mc7kC304ejK1JXKbjx70P2V+Ad
 p0SGdmCyA4tFL0eIeVNrvR/aG3MI+qXybB9HPUBVFslGpUhl+Papn96csKJ0smDtcf1z6TdiaP3
 +TXpVz1SPMIVJJC0kYhi1dz1hjVb9gGrGK7PyiaKi7XAMrA4ZuEqxcUdABXVeDULgYGdZ4R0c6d
 3SKQ0pAt3Gc752cGFlvgMgYyIWSqe/LX+886ULUYn0kWgu05+I2/my/9Khh7OOt6FGrPJI9RQan
 5kzH5LvVJozO6pKt+glpp8xlnlZN4dBY
X-Google-Smtp-Source: AGHT+IF09yyVPgu9TkMHBBHlfwnugwK5y2OCvcbJlFDPskl9qMGSY7nU/DggtLbwo6/TTIgFLmB4hw==
X-Received: by 2002:a05:690c:6888:b0:6ef:5ca3:d0d9 with SMTP id
 00721157ae682-6f6eb6b28a7mr139409887b3.20.1737404259937; 
 Mon, 20 Jan 2025 12:17:39 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com.
 [209.85.219.179]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f6e66d1839sm15267857b3.78.2025.01.20.12.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 12:17:39 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so8744005276.1; 
 Mon, 20 Jan 2025 12:17:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXcOtwQ8QbE9ucswGVD6iKryZraK8K1FsHMPdMEJ12c6MgMWcZqJIivpA49qqavY1JoNRWYLKSouY1L@nongnu.org
X-Received: by 2002:a05:690c:6b0e:b0:6f6:ccf8:614a with SMTP id
 00721157ae682-6f6eb6b0f57mr110470557b3.17.1737404259246; Mon, 20 Jan 2025
 12:17:39 -0800 (PST)
Received: from 281799484056 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 14:17:38 -0600
Received: from 281799484056 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 14:17:38 -0600
MIME-Version: 1.0
From: Fahrzin Hemmati <fahhem@fahhem.com>
X-Shortwave-Message-Id: m-85636d76-26f6-4bfe-bafb-56610da613eb
In-Reply-To: <Z45ANK-m2XZazDi3@redhat.com>
References: <20250120103711.836753-1-fahhem@fahhem.com>
 <Z45ANK-m2XZazDi3@redhat.com>
Date: Mon, 20 Jan 2025 14:17:38 -0600
X-Gmail-Original-Message-ID: <CAHJ_xmW3YCrKEpNGBJxRzqM99Aoe=nwOSJWF+BO5VbySP9763g@mail.gmail.com>
X-Gm-Features: AbW1kvZtcJ5OtH3LomlfwAqoUV7Ek2QayZkGVC28DSS62Imtxa9cV-0sEH3ZFgw
Message-ID: <CAHJ_xmW3YCrKEpNGBJxRzqM99Aoe=nwOSJWF+BO5VbySP9763g@mail.gmail.com>
Subject: Re: [PATCH] Skip resizing image to the same size
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b433f3062c28f34b"
Received-SPF: none client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=fahhem@fahhem.com; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jan 2025 16:20:49 -0500
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

--000000000000b433f3062c28f34b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My apologies, I saw the Signed-off-by requirement at first, but as I
followed the docs I got to "git publish" and didn't realize "git publish"
was actually able to send emails on my system (I don't remember setting up
any SMTP settings). By that time, I forgot and thought this patch was short
enough to not warrant much of a commit message.

The main practical advantage is for users that call "qemu-img resize" via
scripts or other systems (like Packer in my case) that don't check the
image size ahead of time. I can upstream this change into them (by using
"qemu-img info =E2=80=94output=3Djson ...") but I figured it would be usefu=
l to more
users here.

This could trivially be added to block/io.c:bdrv_co_truncate(), as well as
blockdev.c:qmp_block_resize() with a little more work. I'm not familiar
with those workflows, but if needed I can do that as well.

Here's the new patch:

From 17f5c5f03d930c4816b92b97e0e54db0725d7b94 Mon Sep 17 00:00:00 2001
From: Fahrzin Hemmati <fahhem@fahhem.com>
Date: Mon, 20 Jan 2025 01:56:24 -0800
Subject: [PATCH] Skip resizing image to the same size

Higher-level software, such as Packer, blindly call "qemu-img resize"
even when the size is the same. This change can be pushed to those
users, but it's very cheap to check and can save many other users more
time here.

Signed-off-by: Fahrzin Hemmati <fahhem@fahhem.com>
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
+
/*
* The user expects the image to have the desired size after
* resizing, so pass @exact=3Dtrue. It is of no use to report
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index b71ac097d1..88aec4ebc6 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -150,6 +150,14 @@ _qcow2_dump_header | grep '^\(version\|size\|nb_snap\)=
'

_check_test_img

+echo
+echo "=3D=3D=3D Testing resize to same size =3D=3D=3D"
+echo
+_make_test_img -o "compat=3D0.10" 32M
+$QEMU_IMG resize "$TEST_IMG" 32M ||
+ echo "unexpected fail"
+_qcow2_dump_header | grep '^\(version\|size\|nb_snap\)'
+_check_test_img

echo
echo "=3D=3D=3D Testing dirty lazy_refcounts=3Doff =3D=3D=3D"
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 24c33add7c..d94eb9d513 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -299,6 +299,15 @@ size 33554432
nb_snapshots 1
No errors were found on the image.

+=3D=3D=3D Testing resize to same size =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432
+Image already has the desired size.
+version 2
+size 33554432
+nb_snapshots 0
+No errors were found on the image.
+
=3D=3D=3D Testing dirty lazy_refcounts=3Doff =3D=3D=3D

Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
--=20
2.43.0

On Mon Jan 20, 2025, 12:23 PM GMT, Kevin Wolf <kwolf@redhat.com> wrote:

Am 20.01.2025 um 11:37 hat Fahrzin Hemmati geschrieben:

---
qemu-img.c | 6 ++++++
tests/qemu-iotests/061 | 8 ++++++++
tests/qemu-iotests/061.out | 9 +++++++++
3 files changed, 23 insertions(+)


This is lacking a commit message.

Please describe in it why this is change is made, i.e. which practical
advantages the change brings, and why having it in qemu-img, but not in
other places like the block_resize monitor command is desirable.

Also, without a Signed-off-by line, with which you sign the DCO, patches
can't be accepted into QEMU.

Kevin

--000000000000b433f3062c28f34b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div><div><span>My apologies, I saw the Signed-off-by requireme=
nt at first, but as I followed the docs I got to &quot;git publish&quot; an=
d didn&#39;t realize &quot;git publish&quot; was actually able to send emai=
ls on my system (I don&#39;t remember setting up any SMTP settings). By tha=
t time, I forgot and thought this patch was short enough to not warrant muc=
h of a commit message.</span></div><br><div><span>The main practical advant=
age is for users that call &quot;qemu-img resize&quot; via scripts or other=
 systems (like Packer in my case) that don&#39;t check the image size ahead=
 of time. I can upstream this change into them (by using &quot;qemu-img inf=
o =E2=80=94output=3Djson ...&quot;) but I figured it would be useful to mor=
e users here.</span></div><br><div><span>This could trivially be added to b=
lock/io.c:bdrv_co_truncate(), as well as blockdev.c:qmp_block_resize() with=
 a little more work. I&#39;m not                familiar with those workflo=
ws, but if needed I can do that as well.</span></div><br><div><span>Here&#3=
9;s the new patch:</span></div><br><div><span>From 17f5c5f03d930c4816b92b97=
e0e54db0725d7b94 Mon Sep 17 00:00:00 2001</span></div><div><span>From: Fahr=
zin Hemmati &lt;</span><a href=3D"mailto:fahhem@fahhem.com">fahhem@fahhem.c=
om</a><span>&gt;</span></div><div><span>Date: Mon, 20 Jan 2025 01:56:24 -08=
00</span></div><div><span>Subject: [PATCH] Skip resizing image to the same =
size</span></div><br><div><span>Higher-level software, such as Packer, blin=
dly call &quot;qemu-img resize&quot;</span></div><div><span>even when the s=
ize is the same. This change can be pushed to those</span></div><div><span>=
users, but it&#39;s very cheap to check and can save many other users more<=
/span></div><div><span>time here.</span></div><br><div><span>Signed-off-by:=
 Fahrzin Hemmati &lt;</span><a href=3D"mailto:fahhem@fahhem.com">fahhem@fah=
hem.com</a><span>&gt;</span></div><div><span>---</span></div><div><span> qe=
mu-img.c                 | 6 ++++++</span></div><div><span> tests/qemu-iote=
sts/061     | 8 ++++++++</span></div><div><span> tests/qemu-iotests/061.out=
 | 9 +++++++++</span></div><div><span> 3 files changed, 23 insertions(+)</s=
pan></div><br><div><span>diff --git a/qemu-img.c b/qemu-img.c</span></div><=
div><span>index 2f2fac90e8..3345c4e63f 100644</span></div><div><span>--- a/=
qemu-img.c</span></div><div><span>+++ b/qemu-img.c</span></div><div><span>@=
@ -4184,6 +4184,12 @@ static int img_resize(int argc, char **argv)</span></=
div><div><span>         goto out;</span></div><div><span>     }</span></div=
><br><div><span>+    if (total_size =3D=3D current_size) {</span></div><div=
><span>+        qprintf(quiet, &quot;Image already has the desired size.\n&=
quot;);</span></div><div><span>+        ret =3D 0;</span></div><div><span>+=
        goto out;</span></div><div><span>+    }</span></div><div><span>+</s=
pan></div><div><span>     /*</span></div><div><span>      * The user expect=
s the image to have the desired size after</span></div><div><span>      * r=
esizing, so pass @exact=3Dtrue.  It is of no use to report</span></div><div=
><span>diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061</span><=
/div><div><span>index b71ac097d1..88aec4ebc6 100755</span></div><div><span>=
--- a/tests/qemu-iotests/061</span></div><div><span>+++ b/tests/qemu-iotest=
s/061</span></div><div><span>@@ -150,6 +150,14 @@ _qcow2_dump_header | grep=
 &#39;^\(version\|size\|nb_snap\)&#39;</span></div><br><div><span> _check_t=
est_img</span></div><br><div><span>+echo</span></div><div><span>+echo &quot=
;=3D=3D=3D Testing resize to same size =3D=3D=3D&quot;</span></div><div><sp=
an>+echo</span></div><div><span>+_make_test_img -o &quot;compat=3D0.10&quot=
; 32M</span></div><div><span>+$QEMU_IMG resize &quot;$TEST_IMG&quot; 32M ||=
</span></div><div><span>+    echo &quot;unexpected fail&quot;</span></div><=
div><span>+_qcow2_dump_header | grep &#39;^\(version\|size\|nb_snap\)&#39;<=
/span></div><div><span>+_check_test_img</span></div><br><div><span> echo</s=
pan></div><div><span> echo &quot;=3D=3D=3D Testing dirty lazy_refcounts=3Do=
ff =3D=3D=3D&quot;</span></div><div><span>diff --git a/tests/qemu-iotests/0=
61.out b/tests/qemu-iotests/061.out</span></div><div><span>index 24c33add7c=
..d94eb9d513 100644</span></div><div><span>--- a/tests/qemu-iotests/061.out=
</span></div><div><span>+++ b/tests/qemu-iotests/061.out</span></div><div><=
span>@@ -299,6 +299,15 @@ size                      33554432</span></div><d=
iv><span> nb_snapshots              1</span></div><div><span> No errors wer=
e found on the image.</span></div><br><div><span>+=3D=3D=3D Testing resize =
to same size =3D=3D=3D</span></div><div><span>+</span></div><div><span>+For=
matting &#39;TEST_DIR/t.IMGFMT&#39;, fmt=3DIMGFMT size=3D33554432</span></d=
iv><div><span>+Image already has the desired size.</span></div><div><span>+=
version                   2</span></div><div><span>+size                   =
   33554432</span></div><div><span>+nb_snapshots              0</span></div=
><div><span>+No errors were found on the image.</span></div><div><span>+</s=
pan></div><div><span> =3D=3D=3D Testing dirty lazy_refcounts=3Doff =3D=3D=
=3D</span></div><br><div><span> Formatting &#39;TEST_DIR/t.IMGFMT&#39;, fmt=
=3DIMGFMT size=3D67108864</span></div><div><span>-- </span></div><div><span=
>2.43.0</span></div></div><br><div><div>On Mon Jan 20, 2025, 12:23 PM GMT, =
<a href=3D"mailto:kwolf@redhat.com">Kevin Wolf</a> wrote:<br></div><blockqu=
ote style=3D"margin:0 0 0 4pt;padding-left:4pt;border-left:1px solid #ccc">=
<div style=3D"color:#212121;font-size:14px;font-weight:normal;line-height:2=
0px">Am 20.01.2025 um 11:37 hat Fahrzin Hemmati geschrieben:<blockquote>---=
<br> qemu-img.c                 | 6 ++++++<br> tests/qemu-iotests/061     |=
 8 ++++++++<br> tests/qemu-iotests/061.out | 9 +++++++++<br> 3 files change=
d, 23 insertions(+)</blockquote><br>This is lacking a commit message.<br><b=
r>Please describe in it why this is change is made, i.e. which practical<br=
>advantages the change brings, and why having it in qemu-img, but not in<br=
>other places like the block_resize monitor command is desirable.<br><br>Al=
so, without a Signed-off-by line, with which you sign the DCO, patches<br>c=
an&#39;t be accepted into QEMU.<br><br>Kevin<br><br></div></blockquote></di=
v></body></html>

--000000000000b433f3062c28f34b--

