Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00370F364A4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAsnp-0000wG-Ld; Thu, 09 Apr 2026 13:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAsno-0000w7-1n
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:04:24 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAsnm-0003G5-Ge
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:04:23 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c757a9251faso464903a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775754261; cv=none;
 d=google.com; s=arc-20240605;
 b=K8bb0rT/7nNC6Krb4DmITNBbZapufKPq95YBOjEi8Z6Hx9WFQuUV7Amn5j51KUNQIv
 fkpQo4HZLFTRYFt/4o+gLpBsfBaUaNPuv4++5zQ5SfF4wrDSzsOBWJCfPnk4URDRC6ab
 p+7PFsdwv44j3dqevckO8xC/A4UWJjNdoJeulWIvjNDjkQDPoSmsaxjnF93ULY7wzC2a
 Fk4RoOD3kyABiml1Va3TgTmUO+YfVDmKMQq+PbhMBFoYkgQ1H2zSdFBxeOsIeJ8m7q92
 1VoWWiPQ40ZTwnOnzYcBhE23qHA0iUbhT42IIEYY0l/mQ2e/7MGdN8yl34+eD+1Xbcur
 tSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=39lh81n14PZaGYE88nvsWw94W+BaROL8SHk/We1pdhM=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=GjhzY1JGdq+BdWSaF3IqOya/XhhYuftszMyvMT9FuYMheIokh/YMpfqMNj88jMyz19
 2B6W2nvV04cv/ulsUTVd2Fe2x2lpP5vhMiHoy+UAnn+dqJIeg9uCNh8YfZiSTfQdARe8
 ePpcivfUSKXPSTpT5ZWJ+lC57HCriR3Vu7qAf+vaZhzLSj/bobiHR7kUZgHZ9t87yAZd
 J2JMY6TGCahXyWBxuhagR47DAHzM8m5DBhW4Aq6QIivUlLvPus4jEkTwntQu8JDLU7ah
 kQmxxreXXFDv7o1SMRvSd6hWkh/25oigsvFQJ1QpwDdNuFVqLY5DAHKSZC4LNGk/+J3c
 xbPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775754261; x=1776359061; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=39lh81n14PZaGYE88nvsWw94W+BaROL8SHk/We1pdhM=;
 b=HBda8CwcuLRr9eEzoti7QP0MqwsTox8YABctBz+uIY+ZER7TpKFgT4y8jOMkfUz1Fr
 ydnQX4hOUOSdgCzA+JJ4pNJ/VqiwElUAjmi6UocZAwx0mRWnoLT05fDG1PHL5x7roAUq
 lFGaMrvcI16yxm7xBLPK7gFDJWel/ASVAV+kNCT49jiJ9yfg9N03DdvE80k23HJ+t5/m
 A5jIN7+vg+0vgfIHefQHyOely6Px8UJ3nqSznDtI3rqxE5NKr3kQMtEQyeTmRP+1vHNI
 uMKGJ9/aI07pYMF7OkQABeDhYyC2c+7yFFKxJV+KARXrIkoerpSUpLIplZqoozL0Xmfk
 UM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775754261; x=1776359061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39lh81n14PZaGYE88nvsWw94W+BaROL8SHk/We1pdhM=;
 b=pGrWtEGVjAAMx77IcJj4G+7t83QswqkYasVrOOxbXfYNXk2d2d79jXDTa0Vq67kbEg
 OcpgbftT+TFOSbUN/QFEhOOajoI24XUTEVQ65S8mZ+jUFlxNCr/EvGEYjG5AEyRd8SJ1
 1lEjBLCJMzy4RhJ/WS3XBTsa0Uk/fpl5x4lnjz9Fg8Wuukj1Wn7QZfzS33Th85/c1UBq
 T+mcMGx4hjHpGMgRNDzy2dpe++WtQrVDSXb0NHUxIFZvaVsXEtjjnLbQdnlhnBm6F+ie
 7ZoPSb+pzwt+8UQoobjsHax6/51vYa9wPnlxlETz3ONJmod2K9EofyyAg5y8OfyeLHhO
 mutw==
X-Gm-Message-State: AOJu0YyVKfXNb4faxeZNRzz24kCpunhHSgKd5V1s99FMmPGFki/Y/8/i
 oGs9COTsHPGdONT+DD24BisOQdIIOwJYdTokuFmHxvfPQ4qPmeirQTxw04GKvYihH+J4nQDn0pF
 z+mrEaPzqVPO23BQe+XfADllFiV1NDt0=
X-Gm-Gg: AeBDieu1Ov2xKNi36xhIsXMLeDI4OOcBfBxkBEF8cDRtW5mesbTr7aIT5e1xVaG5J8r
 Is0iWXC4myd+cKiQ8x4bhyYrHFexpEUQrnrfBV8Z2o5W4lA46gOxxMD6PVLIzQYFCsYBEfpYg3n
 KTssqrpuMPXSBi+a39bBVyW3QJzd6A85OVE1XKikDEOVAlvHZN8Y0KBLXlKg37ol9a+c12lzfL/
 j+U75FVq840JkgatKx/UpUlYgF83suQHoSEWIxxEIl2P6g16GpNd/j8ZMGSD9+jOnoYtAbidTYV
 fItqBuLM+g4eyGMiurfnqfWI5n2Mg6wFTeE89HA=
X-Received: by 2002:a17:90b:3952:b0:35c:1695:24a3 with SMTP id
 98e67ed59e1d1-35e359646cemr4477098a91.23.1775754260690; Thu, 09 Apr 2026
 10:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <e0d756ec356a90735679356e6df48ba31b82dfe0.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <e0d756ec356a90735679356e6df48ba31b82dfe0.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 9 Apr 2026 11:04:09 -0600
X-Gm-Features: AQROBzCdFzrxGTOUghHdZ8dE58BCXPpKrJ_UKEoC0QrjnQRublAXWTIHMFuHjN4
Message-ID: <CAATN3Nocx2BRUbrpUP8OoKfFwPr4+gFAVW8LbzwX_ojVgCQCYA@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] tests/hexagon: add tests for v68 HVX IEEE float
 conversions
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000eabb0b064f0a01cc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x536.google.com
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

--000000000000eabb0b064f0a01cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hex_test.h      |  14 +++
>  tests/tcg/hexagon/hvx_misc.h      |   2 +
>  tests/tcg/hexagon/fp_hvx_cvt.c    | 188 ++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target |   3 +
>  4 files changed, 207 insertions(+)
>  create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c
>
> diff --git a/tests/tcg/hexagon/Makefile.target
> b/tests/tcg/hexagon/Makefile.target
> index 789721bdac..83969e0e73 100644
> --- a/tests/tcg/hexagon/Makefile.target
> +++ b/tests/tcg/hexagon/Makefile.target
> @@ -51,6 +51,7 @@ HEX_TESTS +=3D scatter_gather
>  HEX_TESTS +=3D hvx_misc
>  HEX_TESTS +=3D hvx_histogram
>  HEX_TESTS +=3D fp_hvx
> +HEX_TESTS +=3D fp_hvx_cvt
>  HEX_TESTS +=3D fp_hvx_disabled
>  HEX_TESTS +=3D invalid-slots
>  HEX_TESTS +=3D invalid-encoding
> @@ -132,6 +133,8 @@ fp_hvx: fp_hvx.c hvx_misc.h
>  fp_hvx: CFLAGS +=3D -mhvx -mhvx-ieee-fp
>  fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
>  fp_hvx_disabled: CFLAGS +=3D -mhvx -mhvx-ieee-fp
> +fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h
>

Also hex_test.h

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000eabb0b064f0a01cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Sign=
ed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.bernard=
ino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm.com=
</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/hex_test.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +++<br>
=C2=A0tests/tcg/hexagon/hvx_misc.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br=
>
=C2=A0tests/tcg/hexagon/fp_hvx_cvt.c=C2=A0 =C2=A0 | 188 +++++++++++++++++++=
+++++++++++<br>
=C2=A0tests/tcg/hexagon/Makefile.target |=C2=A0 =C2=A03 +<br>
=C2=A04 files changed, 207 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c<br>
<br>diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Make=
file.target<br>
index 789721bdac..83969e0e73 100644<br>
--- a/tests/tcg/hexagon/Makefile.target<br>
+++ b/tests/tcg/hexagon/Makefile.target<br>
@@ -51,6 +51,7 @@ HEX_TESTS +=3D scatter_gather<br>
=C2=A0HEX_TESTS +=3D hvx_misc<br>
=C2=A0HEX_TESTS +=3D hvx_histogram<br>
=C2=A0HEX_TESTS +=3D fp_hvx<br>
+HEX_TESTS +=3D fp_hvx_cvt<br>
=C2=A0HEX_TESTS +=3D fp_hvx_disabled<br>
=C2=A0HEX_TESTS +=3D invalid-slots<br>
=C2=A0HEX_TESTS +=3D invalid-encoding<br>
@@ -132,6 +133,8 @@ fp_hvx: fp_hvx.c hvx_misc.h<br>
=C2=A0fp_hvx: CFLAGS +=3D -mhvx -mhvx-ieee-fp<br>
=C2=A0fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h<br>
=C2=A0fp_hvx_disabled: CFLAGS +=3D -mhvx -mhvx-ieee-fp<br>
+fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h<br></blockquote><div><br></div><div>Al=
so hex_test.h</div><div><br></div><div>Otherwise</div><div>Reviewed-by: Tay=
lor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylorsimpson@=
gmail.com</a>&gt;</div><div><br></div></div></div>

--000000000000eabb0b064f0a01cc--

