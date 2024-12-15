Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBFAE7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 15:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMqNF-0002Al-RH; Sun, 15 Dec 2024 10:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMqMk-00029t-DY
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:17:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMqMi-00055U-ER
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734275823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iADiutrz997L5M8qBD4+5LNP0DCy4D9rQ5qjgyhBpkY=;
 b=TQxl58e3eGL7Zj70BKUTX8zE7qbv3Ea8g0sEjj9soLpe9n5TeIxnTk5xvaL5e2z40Cmp3y
 xNz03AHjF2LF5WWT6wRiDVemWzgBohZJyxSY/Xpe/iiOfOh/4KN4yFRyzJTfUQB0IGdzhL
 aTkbT7KxE/hmRcfT4UhptmrMM/lpuRA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-euFLdxBtNZujVqENPKUaAQ-1; Sun, 15 Dec 2024 10:15:24 -0500
X-MC-Unique: euFLdxBtNZujVqENPKUaAQ-1
X-Mimecast-MFC-AGG-ID: euFLdxBtNZujVqENPKUaAQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3862f3ccf4fso1168279f8f.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 07:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734275722; x=1734880522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iADiutrz997L5M8qBD4+5LNP0DCy4D9rQ5qjgyhBpkY=;
 b=tADPQz47YzmltesLCwMHXz+/1RMOlJEIxKJ1GDlek32J8jB8nY/E+HVESHbE0kHXza
 R++rvaElYmcUNFHUIDC47P7VjiKo07Qtviv/ZMmc3rbVEtMwZpic1M7pAlbHA3U0seK4
 4SNU5V300PHckfQRziAVsWFKXhPCCPETMbUZlu2dYiPN/pCreMjiZC0m6Yx8MAzeiZRY
 dIXrD6EjlnQ4+8evEJiaELuqf8KrI4WFJGSwUyF8ckCDHdV0i2g5/iTC5ENHluE1JAWE
 0E85c7DZIDRN7jAsbuZQQurcvOEOpJ+SfSZPlEkwDiIF+kelMU9UsyVOYNuCcWolKAJM
 6nzg==
X-Gm-Message-State: AOJu0Yxu8wSCbwbiXbE/zoiSrauVgqHEeWeWIi1V0gSxhD/kP++jXRwY
 ctWptLJLHCuDvHjWCQ39h2DEB/RBbeWyfMQ9olVt90sO4dstLCPfMEBBIQBvN/EnUhVw7e88RBR
 LzPM+eDQ2Lh/sBK1+43LIqr0RgdPYyfxZWuTxbeVIYoezGL1ILJclaMIuRF651qUyxg8PvQSl3G
 u+ZFrfbqhuLIzDfR8U3lIpXlK381LS1Pbxtxc=
X-Gm-Gg: ASbGnctRPhlkPRLrgsnGUM9QWtF8rY9QYSx5YSqnsuDeUSW1DxNI8Kr2mGjlamDhRG5
 x+JAT0w//sKBO7IckmWEmB/hXNTzM8LLRwAU0
X-Received: by 2002:a05:6000:2ae:b0:386:1cd3:89fa with SMTP id
 ffacd0b85a97d-38880adb156mr7965272f8f.33.1734275722329; 
 Sun, 15 Dec 2024 07:15:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG39CayUjO58CSISMpMIVBtphQxE6MsxXzrHOLxVbIYv8a49sva4PL9DyQPvJxOslPtattFJ5zGDWaRBMPjnDw=
X-Received: by 2002:a05:6000:2ae:b0:386:1cd3:89fa with SMTP id
 ffacd0b85a97d-38880adb156mr7965259f8f.33.1734275722018; Sun, 15 Dec 2024
 07:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-10-pbonzini@redhat.com>
 <436ff2e8-96c2-4743-89dc-765e823d634b@linaro.org>
In-Reply-To: <436ff2e8-96c2-4743-89dc-765e823d634b@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 15 Dec 2024 16:15:10 +0100
Message-ID: <CABgObfYEzvPjtz3vgYwinKgTUYLNCHRsmaXask1r_gydHvhWQA@mail.gmail.com>
Subject: Re: [PATCH 09/13] target/i386: do not use gen_op_jz_ecx for repeated
 string operations
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000005aa15606295088e6"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000005aa15606295088e6
Content-Type: text/plain; charset="UTF-8"

Il dom 15 dic 2024, 15:50 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> gen_op_jz_ecx should become unused now.
>
> And maybe gen_op_jnz_ecx went unused a few patches ago, when
> gen_jz_ecx_string got merged?
>

IIRC LOOP{,Z,NZ} use both of them. I can inline them as a follow-up.

Paolo

Anyway, I think there are some dead inlines which clang would Werror about.
>
> With those fixed,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>
>

--0000000000005aa15606295088e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il dom 15 dic 2024, 15:50 Richar=
d Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hen=
derson@linaro.org</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
gen_op_jz_ecx should become unused now.<br>
<br>
And maybe gen_op_jnz_ecx went unused a few patches ago, when gen_jz_ecx_str=
ing got merged?<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">IIRC LOOP{,Z,NZ} use both of them. I can inline them as a fo=
llow-up.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Anyway, I think there are some dead inlines which clang would Werror about.=
<br>
<br>
With those fixed,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org</=
a>&gt;<br>
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--0000000000005aa15606295088e6--


