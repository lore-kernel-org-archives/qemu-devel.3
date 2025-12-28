Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9713DD3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 15:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZsqg-0002vU-UQ; Sun, 28 Dec 2025 10:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZsqd-0002vJ-L0
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 10:38:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZsqb-00059M-Lp
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 10:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766936299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=00m2Hi1SJyRBkSxIEh5W84mAAJ4K4slxwL2bwwtOb00=;
 b=jPp96JPb9Qc4Cc5ySWvlBilmPvvJxCd0gze7Y4aKwQgQOQWkTb93Pj+r95r/cn7pOhmG5L
 /wZ46SPQGt8pNEGv3oqRZ2Cu9Qfo2OZJ/PVmj3/jZnbfTefy/AfxdAt/txsze6zHAl9XYl
 hX4BIXssGxCIkwenP6Qh0/mx84h7tqA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-LJ_uNQHoN82YHI3h02ceVA-1; Sun, 28 Dec 2025 10:38:17 -0500
X-MC-Unique: LJ_uNQHoN82YHI3h02ceVA-1
X-Mimecast-MFC-AGG-ID: LJ_uNQHoN82YHI3h02ceVA_1766936296
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d28e7960fso27685145e9.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 07:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766936296; x=1767541096; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=00m2Hi1SJyRBkSxIEh5W84mAAJ4K4slxwL2bwwtOb00=;
 b=oA+yFFKw/pAGSv2NWCaaT2WIyJuRpC0WWVVbJ/LHj8d2KvHiK2cw//jjUZOH/hn0BH
 Owq59kl35sS1tfcpdwZfAF1q9btCWj74TQw6YLrewX4wuEunE5QrcAWbp55HJ0hEUoB/
 9E2m+kpothk5zvUqsXyc57h3K8NXcvqli3HX5pZmLeApCaRjyNpLHmIn+fVU8X1gpHBC
 xCRVWE0Rao23K4KxRxBFD6G/+tn060F3gA+xzVh8muY3OqWpUO/P9no6OAUgXiCt+L1o
 7NlMaaEBNqaO4MY1Ws1q96l4MzkpXSRzo/qtlQFRCjOxZGP1QYzbWYopkZg9vPVE7Kpw
 iq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766936296; x=1767541096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00m2Hi1SJyRBkSxIEh5W84mAAJ4K4slxwL2bwwtOb00=;
 b=RNM/lU+jGmf2jsBp9Whib3ZhRfYt6p8JzG+QIV2MB463GXFLJNLeN7H/PojoSInqJw
 /FDq6cslzAjleYOgYqitbrrK0KOH/LO2jfGC9B0sF2XY0/SZSqFM8vvu/i31UIepYRva
 l+R1Uk229BQTVQ7zUN5FKgrjw5/PZUPS4BDifHo4+RhUmbKoZym+YdWkGY4nSjJv1MqA
 dis8mBVjna+coF3znvOzA5USZ+itFc37i4luTjtw19V5NB8eYTOv0IfyP2gQ6lQ4+u/o
 ffkKTYPpENRenyUSLftGb45P25ztvONIe4uOWyRHnCMQ0FKFTKQHafc7EFeOeqafNYWX
 AFAg==
X-Gm-Message-State: AOJu0Yy+MF2a+2XarX4GM1gl6oTeOU8WEuSmI1UJ4exh1ON/kX2bVQRt
 OzaQMwifCnLL86aTriypUMX2P2dtitF+bxESZZ6xQrcb+lJKA51S4b4nsdd5NkK0bdVyvlkI26+
 bhciUf9EFQTDy6cZQ78+qRJfd530SsXw/9rk3ZAl7LCVMvU2XZMPDXICiMCpCuwwosdWRE8bIHa
 Y7Vp+znjrZtGFODA17VJu/dQUijPaBcvc=
X-Gm-Gg: AY/fxX7UVgrtZ3WY7KKTy15jLhnD/oY9kmtX402+4jtPXUfkhNV2rpzlgctzcbAd0m7
 B0Uj0Txb7zoyPSZ3Zd/yZ1lsioWcLD4Fg+8KetAwX6pVC6SVwZHARJCvW0QFCW11EGwrZTRS6ft
 qN1VvFqQGD7laJU5e7LcoeOxaJ5R7ilmkIAQ7PhohUCrw/QbhXKqm8BVKlcZ8FzlMFC9cWG42hd
 ScaRvBQ4AkgAIjLfrJ3cayOvUa+SU4LHmm7co6LI6Lb38bRQRYZINLwJlMIlnJ7/b7PSB4=
X-Received: by 2002:a05:600c:5251:b0:477:8a29:582c with SMTP id
 5b1f17b1804b1-47d195a425bmr318273725e9.34.1766936296364; 
 Sun, 28 Dec 2025 07:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRDbg/8Do5OkyNEtTRqJ07TRrdjzp36RecTWhb/twnpnH2eWOhTGfdDCqmLQsi+6UTdkTop0kdBfdsxS8sFO8=
X-Received: by 2002:a05:600c:5251:b0:477:8a29:582c with SMTP id
 5b1f17b1804b1-47d195a425bmr318273385e9.34.1766936296017; Sun, 28 Dec 2025
 07:38:16 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-17-philmd@linaro.org>
 <CABgObfa9gHpK3CR8Aa6MA4YqfaMs3bn70pba58QQ2+32+xwxzQ@mail.gmail.com>
 <e0b99887-934e-4587-9410-b090a4fcfdc8@linaro.org>
 <5e44a3e7-5eb3-4220-9193-8eb86690535c@linaro.org>
 <CABgObfaXgpdPe32ks+xkzOuNxvJMJhsfpvtjFobBJTueR1X24A@mail.gmail.com>
 <913b7541-d8f0-47b9-8523-9e1389bf4f84@linaro.org>
In-Reply-To: <913b7541-d8f0-47b9-8523-9e1389bf4f84@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Dec 2025 16:38:04 +0100
X-Gm-Features: AQt7F2os16yCy2FI1H2URnC_9mKiDwOtZAuwt-Z0w9W-eFHK6mBUb5Rau5hq5Uo
Message-ID: <CABgObfYXW7RqZjqHVQd8T-RfZvy8oxb7-uWK0Au1W5VXzHVSNA@mail.gmail.com>
Subject: Re: [PATCH v3 16/25] system: Allow restricting the legacy ld/st_he()
 'native-endian' API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Content-Type: multipart/alternative; boundary="00000000000043e0e2064704eae8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000043e0e2064704eae8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il dom 28 dic 2025, 16:14 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> > Perhaps the source of the confusion is that they are in bswap.h but the=
y
> > (quite obviously since it's host endianness) never swap?
>
> Hmm, maybe not well named API then.
>

The name is fine, the placement maybe a bit less; they could be moved out
of bswap.h but it's not really necessary to do it now.

OK. Let's consider the following patches removed then:
>
> - 03/25 system: Use explicit endianness in subpage_ops::read/write()
> - 14/25 system: Use explicit endianness in ram_device::read/write()
> - 16/25 system: Allow restricting legacy ld/st_he() 'native-endian' API
>
> All the series I posted this week build fine without them.
>

Great, the other change I suggested was about the handling of MO_BSWAP but
it can be done separately.

If you don't want to repost and prefer to drop patch 14, we will also
remove DEVICE_NATIVE_ENDIAN from subpages in a second step, for example by
using "HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN" as in
the ram_device ops.

--00000000000043e0e2064704eae8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il dom 28 dic 2025, 16:14 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" rel=3D"noreferre=
r">philmd@linaro.org</a>&gt; ha scritto:</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
&gt; Perhaps the source of the confusion is that they are in bswap.h but th=
ey <br>
&gt; (quite obviously since it&#39;s host endianness) never swap?<br>
<br>
Hmm, maybe not well named API then.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">The name is fine, the placement maybe a =
bit less; they could be moved out of bswap.h but it&#39;s not really necess=
ary to do it now.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
OK. Let&#39;s consider the following patches removed then:<br>
<br>
- 03/25 system: Use explicit endianness in subpage_ops::read/write()<br>
- 14/25 system: Use explicit endianness in ram_device::read/write()<br>
- 16/25 system: Allow restricting legacy ld/st_he() &#39;native-endian&#39;=
 API<br>
<br>
All the series I posted this week build fine without them.<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Great, the other =
change I suggested was about the handling of MO_BSWAP but it can be done se=
parately.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">If you d=
on&#39;t want to repost and prefer to drop patch 14, we will also remove DE=
VICE_NATIVE_ENDIAN from subpages in a second step, for example by using &qu=
ot;HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN&quot; as in t=
he ram_device ops.</div></div>

--00000000000043e0e2064704eae8--


