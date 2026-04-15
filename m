Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E07F4199E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCzQD-00037L-TM; Wed, 15 Apr 2026 08:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCzQC-000357-4U
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:32:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCzQA-0000WK-6j
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:32:43 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so4573245f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 05:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776256360; x=1776861160; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=J9GOETvH1UBePUBC0uHbyc6l2+33zsoxktEsUgVlxX0=;
 b=o3/iAZrRffB3Rw/2wJsqVr2q8nOQ0qr0fsq6IVYhEBPsE3wSPs8iUIDIHKJ6p4uGD7
 TDOmbpshlEHokDVA6LbPLFuNIoD1aR77ywqCDJpQ8kP4eTh9FgasJjYepBL6d6MiY3G+
 F5wzfhMTvHyD08FX1AcmrK8VHF422SUM6Zflqkf85+BCRBeQWeQ2JX/xBL7oO9R5i5Xj
 Jw91OKCfR9eqEJnYZ/X72BX1QsamiMmCEp5EfoTA4vv1NoH2nKTu+oolxPZpE9jqqJxO
 UxBh6HlWRnhVSYUeKEmx8gFxjO+i05/zlY2nMupsulFGJ+j+F4cGD+BTmO6/M7Jccf3j
 Cx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776256360; x=1776861160;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9GOETvH1UBePUBC0uHbyc6l2+33zsoxktEsUgVlxX0=;
 b=B2KSJ5yZ8kgQ1DHYToiaMRT6M7CtNAiyyWcvdgDMw2srKBgpLluQ1CNElXEKjOujrc
 8V7vihdKHVYOmzjp/B4ymv7XJcUhwFWFtX2N9ZrLt7sIPKu+Lne9SETJoOs9zc0GkKxL
 fIJwkLpxgNtneMBH5CI857MB2DtpJG+92HzagXMPYWDC/MqQK7lSPUydPtLfdihK+e4o
 B1Y2bsty9DnZ5WSvv6/SD/pJdxkHZsL6cZShV9LhgNmSh4l4bre56CicN3qn2QPxg8KB
 PMMHg6ioo4G59LNeebuhvJ03T5zRMWECVZUI62RAgCqlsY86QBY6ezq0g6GG1Nzy3TsX
 94Qg==
X-Gm-Message-State: AOJu0YxAxhR/Wl/BVq5Tuj1Jkf2KUeVv6gWFSe4yHea4zDI3NZecXCqD
 edfJiiz1cdzFA20Jhi0/w9KWdvnpBmBRCpaVsWzmuPy1llHK/c9adTMEsko6pIN1PX4=
X-Gm-Gg: AeBDieum+IARgMHyQR9UNW0Ob01dfQeWzA6lgy9UhkaRCsqiJrUsvuqOQmcCtfjxDhF
 YxojRWbfXQKk57DYg4AnWDXOWmj5Xp5Rj8URPHubDky1oJS8qNzV1BW3AR3lIc3to+fOCmXqge5
 +zwZehl5PJAV4N3tayQkjj6Vf1v+TjtSay0P9kwX39HdbXwJ3GmFWxPemeCj5HzHHKAZi7Kytzu
 n2vPvwQMbJc+W0QAYFRgHC9EDwusUPhO7IqOki5qLOjVgFYkPKRMMrZhQZqgebxl33+rlHDv1A9
 yW2Bx6yjzHLeS/1Dv6Sb/KoPnpwc46P8+KpfnOupvXbpzoyhqIx+Tzgd8AsrqHgLlYZdFW253bp
 np4oFqwWEyDP9RbWwm6i28GzpphZ7g/izkVcHS8O7js4DZStEmNHnElWn7vRqSkI+26TRraxHAq
 2IEArDku8btfl/4YGYs7/PeNaoJoiCo/yE7JWdFOjYsAupO93S9SmQPxv3+r4s/FvNSGEPEXQGi
 F4ECEfUSwSOqq/zK6LkXhpz6jUxVA0sHnLME90ljqEv8Dxo9sIrISHa9ox4YdjZCZhLV5tiiAkL
 ZNJN2Mk=
X-Received: by 2002:a05:6000:26cf:b0:43b:4212:2ee8 with SMTP id
 ffacd0b85a97d-43d642b9daamr31166401f8f.24.1776256359872; 
 Wed, 15 Apr 2026 05:32:39 -0700 (PDT)
Received: from smtpclient.apple
 (2a01cb001411480010f92e9cd3b40a22.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:10f9:2e9c:d3b4:a22])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3e263csm4636531f8f.29.2026.04.15.05.32.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Apr 2026 05:32:39 -0700 (PDT)
From: Matthieu Rolla <matthieu@minio.io>
Message-Id: <7E17AD80-CF52-44FC-A0FE-29B481EF5B40@minio.io>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_4E509D55-0C84-4F99-B206-D78148A088EB"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 2/2] block/monitor: add drive_insert HMP command
Date: Wed, 15 Apr 2026 14:32:39 +0200
In-Reply-To: <ad9s9CRT0niUAPQn@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, stefanha@redhat.com, mr-083 <matthieu@min.io>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260409060155.94704-3-matthieu@min.io> <ad9s9CRT0niUAPQn@redhat.com>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=matthieu@minio.io; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Apple-Mail=_4E509D55-0C84-4F99-B206-D78148A088EB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks Daniel,=20

It makes sense Thanks.=20

Looking at the existing code, blockdev-insert-medium already does the =
backend/frontend association via blk_insert_bs(), but is restricted to =
removable devices.=20
A new QMP command like blockdev-attach could reuse the same logic =
without the removable restriction, paired with blockdev-add for creating =
the block node.

Would that be a better approach ?=20

Thanks


	.=09
Matthieu
www.min.io <>
matthieu@min.io <>=20

> On Apr 15, 2026, at 12:48=E2=80=AFPM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
>  see v3 has dropped this new command, but in case you have plans
> to re-introduce it..
>=20
> First no new HMP-only commands please. Anything new must be =
implemented
> in QMP, and the HMP must be a shim to the QMP.
>=20
> drive_insert semantics are somewhat overloaded - it is doing two jobs,
> first creating the block backend, and then associating the backend =
with
> a device.  IMHO those tasks should be separate.  "drive_add" or
> "blockdev-add" can already do the first task, so we shouldn't =
replicate
> that. AFAICT, it would only need a way to do the backend/frontend
> association, and possibly the PCI error injection should be done as
> a standard part of that re-association of backends, which would avoid
> the need for pcie_aer_inject_error which has no QMP impl currently.


--Apple-Mail=_4E509D55-0C84-4F99-B206-D78148A088EB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div>Thanks =
Daniel,&nbsp;</div><div><br></div><div>It makes sense =
Thanks.&nbsp;</div><div><br></div><div>Looking at the existing code, =
blockdev-insert-medium already does the backend/frontend association via =
blk_insert_bs(), but is restricted to removable =
devices.&nbsp;</div><div>A new QMP command like blockdev-attach could =
reuse the same logic without the removable restriction, paired with =
blockdev-add for creating the block node.</div><div><br></div><div>Would =
that be a better approach =
?&nbsp;</div><div><br></div><div>Thanks</div><div>
<br>
<br>
<table>
   <tbody>
       <tr>
           <td style=3D"padding: 0 50px 0 0;"><img =
src=3D"https://cdn.bfldr.com/Q955TODV/at/f5h9pjj8f8t3ng5t6vxs2n/emailsigna=
ture-logo-standalone.png?auto=3Dwebp&amp;format=3Dpng" height=3D"34"></td>=

           <td style=3D"width: 1px; padding: 0; background-color: =
#D6DAE1; color: #D6DAE1; font-size: 1px;">.</td>
           <td style=3D"padding:0 20px 0 50px;">
               <div style=3D"margin-top: -6px; margin-bottom: -4px;">
                   <strong><span =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: =
1.1em; color: #353638;" color=3D"#353638">Matthieu</span></strong><br>
                   <div style=3D"height: 6px;"></div>
                   <a =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: 1em; =
color: #353638; text-decoration: none; line-height: 118%;" =
color=3D"#353638">www.min.io</a><br>
                   <a =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: 1em; =
color: #353638; text-decoration: none; line-height: 118%;" =
color=3D"#353638">matthieu@min.io</a>
               </div>
           </td>
       </tr>
   </tbody>
</table>

</div>
<div><br><blockquote type=3D"cite"><div>On Apr 15, 2026, at 12:48=E2=80=AF=
PM, Daniel P. Berrang=C3=A9 &lt;berrange@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;"><span =
class=3D"Apple-converted-space">&nbsp;</span>see v3 has dropped this new =
command, but in case you have plans</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">to re-introduce it..</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">First no new HMP-only commands please. =
Anything new must be implemented</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">in QMP, and the HMP must be a shim to the =
QMP.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">drive_insert semantics are somewhat =
overloaded - it is doing two jobs,</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">first creating the block backend, and then =
associating the backend with</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">a device. &nbsp;IMHO those tasks should be =
separate. &nbsp;"drive_add" or</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">"blockdev-add" can already do the first =
task, so we shouldn't replicate</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">that. AFAICT, it would only need a way to =
do the backend/frontend</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">association, and possibly the PCI error =
injection should be done as</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">a standard part of that re-association of =
backends, which would avoid</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">the need for pcie_aer_inject_error which =
has no QMP impl =
currently.</span></div></blockquote></div><br></body></html>=

--Apple-Mail=_4E509D55-0C84-4F99-B206-D78148A088EB--

