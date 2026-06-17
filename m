Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9DBCD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZspN-0007Kq-2R; Wed, 17 Jun 2026 12:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francismicheal037@gmail.com>)
 id 1wZspL-0007KQ-59
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:09:19 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francismicheal037@gmail.com>)
 id 1wZspJ-0002TK-Ih
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:09:18 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-51788280e71so64378301cf.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781712556; cv=none;
 d=google.com; s=arc-20240605;
 b=jwNZaINSyULaa33ivFkksQO4Y6ZirkqRPteN4GxlZV7QCd5fjJt5lSzS17qq/VS3J3
 WpeEl21yCTkqaRO4K1L4FFQ4Uy5eotjdG9Z+soAvyKIxzhim5Q/a/kobZh/p1+5xwLn6
 O24eTpSVInJq/q2sHlZ8Fe0toH0iIeCk4ZlH5PW+oKS6GJ2R9XpYI3Ac5mK4Pv9f5aNu
 0rEK+6l3Qj7f3/rfWE4e6VAVaS/sdejrHIRht3eYa6xJXcbvPuoIVAnaLjWDOrxCjULL
 WI3/aUbf4WGQL2A2OBzp0fSE74HX7K43Va/jRdFqub+90XX8O1MHeylbtzt4Upuy/C37
 6V4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=TMTiCmwlJLeyQvlwuwJ32kwc3lB2eydS/vmc7BoNenY=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=FpD6UyApvII0EOcS8JV1IWBLe59ffLWGqhCiA7K5gWWWBQ6/XFPkq6NZtiYebuk09S
 hnUXkd9HHEL8qExxDPAFhYmkvOPzDskix8NHJgq8xPBuRU2TalFXqD0QiSFOXj9tn1Em
 NHFeBoQX4Cb2rLOo4ZC/fgcQ4ojPW+Z0Wn32Qh0XnMBaM/5kuWib9R0YtdwZYoJGLdPX
 RjRNydu0sjtL9wWtXlcfcZVCzjGYxUuzNFcZAOrZZzmG7pYOT/42I1caUKg6ti0mfIE+
 ShlvIm7DLV53wA1UOIeRc1NuMbhDE6oy14GiKQ0cxbQeLdMF8xKW/LV6H27edNlNYNGY
 mzcA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781712556; x=1782317356; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TMTiCmwlJLeyQvlwuwJ32kwc3lB2eydS/vmc7BoNenY=;
 b=eE33JD17IegQq0Jc6lFGlzF3voWXcBE8giOkrrZAzZuneepAzI2UG/gWN3WwOpvH1t
 +QQ2rkiUrxcGaip5B2t8CKcrf98tHkkGBDdYrqR0Nx9gmrYxww3Lgv4r1v/xPvWNI4kc
 VybLrNCBYFSPySLi5PBGPbQDbCYRS8HK7PlrI8h6i9/4KJ2ApxO8quUdw91eh7/gR9Ck
 mpDYT68LHRef6lPD+NT3zbfDawIfzOBarLoQGSgsRu+LENWyK7BE81I8cfEsoriy7puv
 zdE3HtfBph0MYT/nBHMu8e5yrOsAq2r4BCPsGJ+HY5QqsMgmgtHbB11CIkX6NW+vEMTK
 OtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781712556; x=1782317356;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TMTiCmwlJLeyQvlwuwJ32kwc3lB2eydS/vmc7BoNenY=;
 b=kNQJ01xfpwP1ZuwxxuzcQeAFEi7vUvB1d5HATQck540g7l0C7tvQtOcAKJptYvozGa
 Y5y82WvcYsYO9P5LLCNyeyv6wtFsxFZjPU2cTcPGSkQhHsktrKYNtRqZf7A8gRoOk+5a
 iBfu4HDSbD5yTg5IqcngSCPCbH/kZR6Nl8a/GpfWrc5ha/m956kIrnyyjPTE5phzRdq1
 Ltr1IfrR4RSeg2HyjH5LwxRt0m1HkX9MC5TeVcurBBOF71h0f7RKCDSxV+IN3KNMwrTE
 dWSH/V2xDUprAmdw2Sf8Yz2CqvnkFO7aKBMuT0VVeywi0dIWFvWFtjkIE9sqxh+OuCHl
 7+tA==
X-Gm-Message-State: AOJu0Yxbtdhdily9zwKKkROQV2xrpWtFCH7MdP4gMS93gnaWtNtnH9/O
 ulBtKsFoDP5H8YVvfOMWqqb4t9k36hX9zZwMgPd08fRqOzgk+sktwoAYfg/h0oMidqJoWeC4wP6
 +8sGX1eklc28YksjfcSZYPoaYCzaAfn8PW49vpbuWOw==
X-Gm-Gg: Acq92OEGRGPvbD/WcY26FEZPvUd7VC4sqwfpvHtH3J0JdiXJofEJPT39c4BYLJcS8P1
 2g3NJVlJaNQzU/HlBHcrfOy6GZaLaz+outDnD2hF5G4GC4O/p8WzFJwqzT4r49Zlc4Q1ThMVNyt
 i/0f8UxovzLX2kk2vHf1ceE2w4Pnq94G1O/2vLnCdh7T353Bn9aDcHrId5OY6zzfhzde7Xu+kka
 2DSkFLAqQ4ENNMutz1vVTTfQo4bZMldFf/IoMGAio6rmdwMbdWZnpKYg6Mgx1dXj1rm8/I14QPQ
 RRbTKcd/1gu6+uKRRbkoyaF2AiADl/aze1PkChXxMFxuDsJWxUemyZXUTlLC/tDmZYWd7S5nfA=
 =
X-Received: by 2002:a05:622a:8359:b0:517:78c7:d93a with SMTP id
 d75a77b69052e-519a8cb90f5mr56962771cf.16.1781712556185; Wed, 17 Jun 2026
 09:09:16 -0700 (PDT)
MIME-Version: 1.0
From: Francis Michael <francismicheal037@gmail.com>
Date: Wed, 17 Jun 2026 09:09:09 -0700
X-Gm-Features: AVVi8CdBLZxH5SrEz65vgImeI2vLTb0M4wnJbVgduJYVuN9HkkdTQtd76KhAdHM
Message-ID: <CAFiVdhG=B-eeL_8QxDy71pX52pc00JtSbXjnQxSgYVScGct+gg@mail.gmail.com>
Subject: Interested in iPXE
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000000dd3d0654754841"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=francismicheal037@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_IMAGE_ONLY_16=1.092,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_REMOTE_IMAGE=0.01 autolearn=no autolearn_force=no
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

--00000000000000dd3d0654754841
Content-Type: text/plain; charset="UTF-8"

Hey QEMU Team,

I came across https://github.com/qemu/ipxe and thought the project was
interesting. I especially liked the focus on network booting and
infrastructure automation, which remains incredibly useful in modern
deployment environments.

I think a project like this could benefit from more visibility,
contributors, forks, stars, and community engagement.

If you're interested in my approach, kindly drop your WhatsApp or Telegram
handle.


francismicheal037@gmail.com

--00000000000000dd3d0654754841
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><p>Hey QEMU Team,</p><p>I came across=C2=A0<a hr=
ef=3D"https://github.com/qemu/ipxe" target=3D"_blank">https://github.com/qe=
mu/ipxe</a>=C2=A0and thought the project was interesting. I especially like=
d the focus on network booting and infrastructure automation, which remains=
 incredibly useful in modern deployment environments.</p><p>I think a proje=
ct like this could benefit from more visibility, contributors, forks, stars=
, and community engagement.</p><p>If you&#39;re interested in my approach, =
kindly drop your WhatsApp or Telegram handle.</p></div><div dir=3D"ltr" cla=
ss=3D"gmail_signature"></div><br class=3D"gmail-Apple-interchange-newline">=
</div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_si=
gnature"><div dir=3D"ltr"><img width=3D"82" height=3D"96" src=3D"https://ci=
3.googleusercontent.com/mail-sig/AIorK4wUJKGHRZnCIbA2IuWrCwJWDs594SR-PYmhqc=
cE_oXn33yRVWTHoKZG_1q3lkonhQwXFf75PDeIrYL4"><br><span style=3D"color:rgb(31=
,31,31);font-family:&quot;Google Sans&quot;,Roboto;font-size:14px;text-alig=
n:center;background-color:rgb(233,238,246)"><a href=3D"mailto:francismichea=
l037@gmail.com" target=3D"_blank">francismicheal037@gmail.com</a></span></d=
iv></div><img width=3D"0" height=3D"0" class=3D"mailtrack-img" alt=3D"" sty=
le=3D"display:flex" src=3D"https://p.mailmerge.eu/trace/mail/c13119ef3de67b=
55a87973ba4549c4b84b4cb21d.png?u=3D14137903"></div>

--00000000000000dd3d0654754841--

