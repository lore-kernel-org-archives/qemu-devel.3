Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1FDC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x13SC-0006YE-4M; Mon, 31 Aug 2026 10:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x13S9-0006Xu-Uv
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:57:42 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x13S8-0006pK-7G
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:57:41 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so82687866b.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788188258; cv=none;
 d=google.com; s=arc-20260327;
 b=WWHdFwvQNSp3kjTupxdLe5MMAaUiCPv3xf6SBdRsc37x5FszPyGQxdeCdPw9LMxZve
 rjV0wysYvfUiTALmnU0S/8ELUovmr542c04uT42vAXxFj2U5D4Omus7G5YAlC94yWS+o
 t2DuW5enDMZ+y2mafGdWwUHZofb+5Vb0fp97sUXMf62AhB1JZUccxtZqvoCLRvaq1uib
 9HR1CDiEO/VveFfT646DiJ5jhkqHOMx/t9ewzjDF63D3vBwrDh8kY0mPnXJa2g7Z+/yr
 ry7pgkF/jW2lIW0uDkP5HHmtZm46fOjcvSVjGSSYF005tXJlKMX8vrVcrQu276sU9YyH
 bziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2E86yaHmg9J8PA4AfawD1RHzreWG8nVs8bHPfrzrBCg=;
 fh=emWpo89BJyBUgGiKtnJENZ9xPANJps0Myx2H671eRe0=;
 b=oZWK9CEtVkmt0CZQfsYRHVpf3pRJRZc20Shj75pFzztWIOc73BuLbZn95cBTGzl7oX
 aA1+WSBJYNd0OublOTDV3Stegw9smLhdCbw5E66KMeFa1JxAHTcJqYHvIc0pm7PPiPvW
 gkSbJY7/DUB44BlBhrOmDPeI5aVVgombx7j8I5bOFiM3qVJNfgBY5UnECbM1zJiwp2QR
 Lj14fEr3l/qB4gIII8MunCudt+pwTTRI5LYBSqQSFPV10xWRQmdawozUEJ0kHJWIj7+s
 9sTlllO+FJeMlExNGdpG3aPaMb18diCm0KwNgzCGrbcePEkupcymRdtyFcW/qkUhzfW7
 ATWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788188258; x=1788793058; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2E86yaHmg9J8PA4AfawD1RHzreWG8nVs8bHPfrzrBCg=;
 b=nDG5Ca1M+pIy1UFWR8vtZFQtGf7aOuvtzX5z71SXuSZFF+Pwd6tc7lFQqDvg4Ty0S5
 6sCOyXNYYBSpXujYptpm7lNj9IvG2f3FlLzgfVQ/eOkKM3JfhwjPgGAAuXJ1Q8A6OOa9
 BhsGOF0mioNRUGRL1Sj3HdXjw/ftQpn4N+A1u1bmatFvD0MXcHQmDxgtDGZWBpK/t+31
 KIHHu6AN8krL/aczGXyu9ZEBuzPeLj5N3AieQ0dTvy1CmTHxi6PuLaVfoyyKjfAnC0Tc
 IA0hwB4JOwGRIUTA51fKyyN6IJ56MdVGHzFQv/TAMNpzoma/Rky/5CDThYe/eJAE50ji
 q42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788188258; x=1788793058;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2E86yaHmg9J8PA4AfawD1RHzreWG8nVs8bHPfrzrBCg=;
 b=FUPiIiDbzMwa0b25P3RhcmjmD9uUSF2w7nrP0BQrnMUn/CctSlA5by+9ofapWIZBFv
 ZU/fpBlO1HolFqjfQV+DZ6rttGIBEXUCS5efExNGdGycg5ZCWSNkHP1amJSJcTFXQHyI
 UnKd73JZXnRmi18yqyoY7WDyI75fYISmf5+B0GZV69LmS54AdHN4YZtxRstafVuLJqbh
 2HtqTDIe7+2d2UUgX8PYHFvAYa1kw7/aUC9K5r3MC9SdxvRFNvx98wcfxyprXZ0a6IxA
 q6X0CmpRbadyQZPQh3/MPSdUkwwNX+LMra5t6i2AekG8XHoNGKoPn+PVW/ZldamTfm6o
 3+BA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyvkPh7UItxfw++zKbJWJwFe89qyTr3uYrVz9pc5MT/LeQXqF88owaRrQnfLazGWnRx6YN5RbG8jHz@nongnu.org
X-Gm-Message-State: AFuF++muf/FVn6poJcfvh+CA1reszVKNYNciCcZMJLCYB9TvAxVSI/4j
 Vm0z3PZfUhteruTb5irUmCESpCA50w0X9/YDxiX2z96aXPt9W3AynlUw9plnoIjYnrFjRR+3A28
 pBFjVCW4xIoWl9BaMcq8Jc/mAQv2PDMc=
X-Gm-Gg: AR+sD13s8b5l6V6G3W/OZAKv9Zz87hvaC+7/E4yYDxbFNBdAdC1tmCZu5Udo5PK+A/f
 iyA3+qZK7eDVzbHsyKg8czwtiGoddRTJvyuzICiWWjvmds48CLFIVQFvWgnD2vmBc4Xl98uJDt0
 LDHCVKz11UFi4Fpc70nZiRp6XQeZLDtr3UwU7300IRtpRc7N7pOzwH4YCYDkgu3+OcihSSEPG36
 sz/MHUjLhWdu2J0Qj/RP1ZClxVutQraRWgVzgq4WJ8cjWQfZX91thVtqpOQzUpBdHGi+/xfQuEt
 a/BWyN3FdlFzuJ5UTXSRc046oqekPDo35kE5+wAm8Evr
X-Received: by 2002:a17:906:fe0c:b0:c21:1b58:fa96 with SMTP id
 a640c23a62f3a-c2556fe9e76mr1935220066b.3.1788188257362; Mon, 31 Aug 2026
 07:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-24-pierrick.bouvier@oss.qualcomm.com>
 <479920ab-cc83-474d-ba1a-89352cb0986c@oss.qualcomm.com>
In-Reply-To: <479920ab-cc83-474d-ba1a-89352cb0986c@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 31 Aug 2026 22:57:24 +0800
X-Gm-Features: AcwNN1WgB4gvzy2B9ON78qUDT1BCfIfNVsIHqwoOfQdwKT3rrZlVSULyjOWJRo4
Message-ID: <CAE2XoE_WNY-yWZg2nbqOE_iVa74v2S2nGq1+6Ch+Ypt4errDFA@mail.gmail.com>
Subject: Re: [PATCH 23/47] target-info: add target_config_multiprocess
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000df29cd065a59059d"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x636.google.com
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

--000000000000df29cd065a59059d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> diff --git a/include/hw/remote/mpqemu-link.h
> b/include/hw/remote/mpqemu-link.h
> index 4ec0915885..2dee94ac64 100644
> --- a/include/hw/remote/mpqemu-link.h
> +++ b/include/hw/remote/mpqemu-link.h
> @@ -98,2 +98,7 @@ bool mpqemu_msg_valid(MPQemuMsg *msg);
>
> +static inline bool target_config_multiprocess(void)
> +{
> +    return IS_ENABLED(CONFIG_MULTIPROCESS_ALLOWED);
> +}

Why inline it here?
as target_config_multiprocess should be used as a function pointer for
example:
```
static const TypeInfo remote_machine =3D {
    .name =3D TYPE_REMOTE_MACHINE,
    .parent =3D TYPE_MACHINE,
    .instance_size =3D sizeof(RemoteMachineState),
    .instance_init =3D remote_machine_instance_init,
    .class_init =3D remote_machine_class_init,
    .is_available =3D target_config_multiprocess,
    .interfaces =3D (const InterfaceInfo[]) {
        { TYPE_HOTPLUG_HANDLER },
        { }
    }
};
```

> +
>   #endif
> ---
>
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000df29cd065a59059d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>&gt; diff --git a/include/hw/remote/mpqemu-link.h<br>&=
gt; b/include/hw/remote/mpqemu-link.h<br>&gt; index 4ec0915885..2dee94ac64 =
100644<br>&gt; --- a/include/hw/remote/mpqemu-link.h<br>&gt; +++ b/include/=
hw/remote/mpqemu-link.h<br>&gt; @@ -98,2 +98,7 @@ bool mpqemu_msg_valid(MPQ=
emuMsg *msg);<br>&gt;<br>&gt; +static inline bool target_config_multiproces=
s(void)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0return IS_ENABLED(CONFIG_MULTIPRO=
CESS_ALLOWED);<br>&gt; +}<br><br>Why inline it here?<br>as target_config_mu=
ltiprocess should be used as a function pointer for example:<div>```<br>sta=
tic const TypeInfo remote_machine =3D {<br>=C2=A0 =C2=A0 .name =3D TYPE_REM=
OTE_MACHINE,<br>=C2=A0 =C2=A0 .parent =3D TYPE_MACHINE,<br>=C2=A0 =C2=A0 .i=
nstance_size =3D sizeof(RemoteMachineState),<br>=C2=A0 =C2=A0 .instance_ini=
t =3D remote_machine_instance_init,<br>=C2=A0 =C2=A0 .class_init =3D remote=
_machine_class_init,<br>=C2=A0 =C2=A0 .is_available =3D target_config_multi=
process,<br>=C2=A0 =C2=A0 .interfaces =3D (const InterfaceInfo[]) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 { TYPE_HOTPLUG_HANDLER },<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 { }<br>=C2=A0 =C2=A0 }<br>};<br>```<br><br>&gt; +<br>&gt; =C2=A0 #en=
dif<br>&gt; ---<br>&gt;<br>&gt;<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=
=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000df29cd065a59059d--

