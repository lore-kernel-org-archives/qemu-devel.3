Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11096C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1yjI-00062i-Sj; Thu, 03 Sep 2026 00:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x1yjH-00062a-A9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:07:11 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x1yjF-0000y7-1s
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:07:11 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c25366c9b42so12471366b.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788408427; cv=none;
 d=google.com; s=arc-20260327;
 b=CsXL+3X/5wAoFjQx+TXF9Lu9u4UPcbvl5kEwU0OrWGNYvecDxxWOA5qGMaVi6ThjoA
 oKyMntBaKYWn7PVFLT4fr09HBeitAaPC1IsBrAcDnnTH0UvPPKZLrUiSoGB+bOf2LB5i
 J48e918TVqCffrFLlltR6aCiqlerTwJX5ZclXguDwictmcwTQfFvK2AXKw4FTZS94H20
 9HX76G49QZ8IWgR0cWnZ3lyY86MuDZNScqvttteh1msvnMJmc8L5p64VTT+goZTMUJ6H
 dSyyV0dn7vmdDkAkvfD86tqmn9ZWCjA0RLUa+OZveeTFWknmo2dhng9BuaWUJ8OdQX3P
 tF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AXIM4mzcE27hZd682ICMq1vVmeDMXVoovK+MfnbNTOU=;
 fh=4+Kq85QY6c1pchBs6KbanqAjJh3L4cU2lB6FcwXkSlc=;
 b=SNhZMWKKg/tgDGBOXyvuyYHo/cYddD6Gw7u4ET0Ss7Cm4dCy5enPhC5MTR+gp4qOl9
 ixX5RyJuYdtEJUAaBVIQGbwK44Yu5Gsft+bWuFTavsnGdFP5EuQq3FFVWFj8bCo4VQjp
 mr/mnmxKLWQRHKX8p8jBoCyuavt+l5Q6Gd1dlTIk1F8S4aI9QMAY33tHynAHtt9kcTvg
 W4QDSWjf5rj1a0CT1txxBPXQTyiALo9i0qsdOD4tlW7aLbntTkg3hniisFDZp0ovrSRM
 d1QSLCLb4rn9XFSDZ3KSwUbx/+9wCWtblvLV1vLhdi6AwEcujj//fwM6t8RpHMAhzDGW
 1iYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788408427; x=1789013227; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AXIM4mzcE27hZd682ICMq1vVmeDMXVoovK+MfnbNTOU=;
 b=QkPxy81fzqICJ0CG0K3YBgCkzYYQ4fJnYSf6hljwSedgMCcMTjJO+A93pgkJL9RpXD
 61vMPXR8wQuMeuIC8WCOFLdPyN6Aim/AJsB2Kcgxf4WeI6W7OsbFHeBD9+9+WGQuokOU
 7VESV4sVxDOK4Q1WvUXZUf294jT8TU9z/+F9G3Grbvzp8iUjMDszaCNgI5ESiys819hV
 rHsdhJoBV3/g4szgiEGfQ0wjsQ95SCKT+Nahk4KmZrTu8RKSa6lttFQ/I1EogQu6DaXH
 D81hxt0nHHW5NT+3NgZ8UzDXGw4AFxsQeHIRS5FMc7Bt9MZQCpV6MVZhH7LTxMoLBzHg
 fM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788408427; x=1789013227;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AXIM4mzcE27hZd682ICMq1vVmeDMXVoovK+MfnbNTOU=;
 b=D1Afv/L5LcqJod0MOEbJ1RXzSoRO3bEfFJr7x80FwCwroMfx9kGKH7q5daWRAbj74c
 x1qkIBNvT1DH/4Kqx6vTgrZ2SA2Yhl/PQ5SDYrNswRzyL0CN2bPOTRL2pu3rlQsKiVEJ
 6hS3g6WW77RpIATQi7W1gcnIw7/RQbgiqVJ/3V/pvIWBFruIcPuRqx3xzKS/zC0mT+k0
 QPbWdpnlgf9Hac+ZGYJTkbJKPp+JsuRqPlkavVkFr8vRHnJKPtQ+ItYuJo5xncf8LLUL
 WAI9aI2rWQRFpbvf9k+WiaIDnHiau5u5reJ6QTwC/Gvf7WAsXagOlMo5ib2HE7EOZAFV
 NAmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBUMirCxHtWwqv1Ydpc33ucYGSKob7woVNXBdM9M2MJ7ANhqgXF4m+eJ/5nHaceU3MileDb1wf3h5C@nongnu.org
X-Gm-Message-State: AFuF++npRNaueRcoFXFeyS8S4sqW6OrtA49YGJIe34g5VDUTDGkk5eXG
 jv+f1r88wCLToHw+iKqsG11sNBtbeRmTEXBiRghp8tDeCgcgdSXo9/VKGDWUCBhZH40skCmgSVA
 /Ji6dZLlQA0dm9qLtxps5Ceuy7z2KjZY=
X-Gm-Gg: AYBFou0uZ8v957KLRXF4U0Ixm6LDQ++hQ/J6GUetn5drVtBcylVC159N1XfKdQP8eVR
 vyvD6p0zay2IcnPp85Fkx6q9IOH0T3AObjTFmph0n58sFEKadWJSb2djQ5eITKiNiidSYqo5XKm
 Z3EwwfAWrllZ5Mw7Yph/xHgIWNLS7VG2hiVdZH9a++w8U7HtQbH8MpQ7gy/GNd9CH+Wc4ir9oAh
 mnRF0Jgf0GJFeBYFWWueH4GY8kZEZzEYHmm/j4o7BG7m6qfSS64ifRtqloWekFlOR5exU9Yy9dR
 7u/LvGQVlwyC4FmzW8KL7OXPpjzOf6NzvKOpkR//2fAJ1wXL4sdqq+M=
X-Received: by 2002:a17:907:7250:b0:c1f:c061:569a with SMTP id
 a640c23a62f3a-c25d545303emr656624066b.7.1788408426654; Wed, 02 Sep 2026
 21:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-9-pierrick.bouvier@oss.qualcomm.com>
 <d41a6ac9-86b1-4283-baf4-78b5df67fe50@oss.qualcomm.com>
In-Reply-To: <d41a6ac9-86b1-4283-baf4-78b5df67fe50@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2026 12:06:53 +0800
X-Gm-Features: AcwNN1WPPf5FNBub0WYgdZGwDALtPShh2XEFF5PPZIIG4389gKP4-H5IcmNwjCU
Message-ID: <CAE2XoE8AkNPTsyykiuPnbkaNaBU=-rxjZd8qGy=ZKUD156he5w@mail.gmail.com>
Subject: Re: [PATCH 08/14] hw/arm: remove {arm, arm_aarch64,
 aarch64}_machine_interfaces
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fbee15065a8c4844"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x62f.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000fbee15065a8c4844
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >   target/arm/machine.c                      | 12 ------------
> >   57 files changed, 9 insertions(+), 107 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>

When do queue, should add the following change after rebase to tip

 hw/arm/mps2-tz.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index bbf2812e04..4e6744eddf 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1654,7 +1654,6 @@ static const TypeInfo mps3tz_an555_info =3D {
     .name =3D TYPE_MPS3TZ_AN555_MACHINE,
     .parent =3D TYPE_MPS2TZ_MACHINE,
     .class_init =3D mps3tz_an555_class_init,
-    .interfaces =3D arm_machine_interfaces,
 };

 static void mps2tz_machine_init(void)


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000fbee15065a8c4844
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>&gt; &gt; =C2=A0 target/arm/machine.c =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 --------=
----<br>&gt; &gt; =C2=A0 57 files changed, 9 insertions(+), 107 deletions(-=
)<br>&gt;<br>&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"m=
ailto:philmd@oss.qualcomm.com">philmd@oss.qualcomm.com</a>&gt;<br>&gt;<br><=
br>When do queue, should add the following change after rebase to tip<br><b=
r>=C2=A0hw/arm/mps2-tz.c | 1 -<br>=C2=A01 file changed, 1 deletion(-)<br><b=
r>diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c<br>index bbf2812e04..4e6=
744eddf 100644<br>--- a/hw/arm/mps2-tz.c<br>+++ b/hw/arm/mps2-tz.c<br>@@ -1=
654,7 +1654,6 @@ static const TypeInfo mps3tz_an555_info =3D {<br>=C2=A0 =
=C2=A0 =C2=A0.name =3D TYPE_MPS3TZ_AN555_MACHINE,<br>=C2=A0 =C2=A0 =C2=A0.p=
arent =3D TYPE_MPS2TZ_MACHINE,<br>=C2=A0 =C2=A0 =C2=A0.class_init =3D mps3t=
z_an555_class_init,<br>- =C2=A0 =C2=A0.interfaces =3D arm_machine_interface=
s,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static void mps2tz_machine_init(void)<br>=
<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=
=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<=
br>Yonggang Luo</div>

--000000000000fbee15065a8c4844--

