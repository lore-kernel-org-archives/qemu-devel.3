Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81979D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 10:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZoGK-0002Ah-8n; Sun, 28 Dec 2025 05:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZoGJ-0002AY-BM
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:44:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZoGG-0001Pp-Ip
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766918670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAb4vkolnWJdHqKEozrOY8S1XG2tOKb/W8rkeDz5SB0=;
 b=VBZRQkNFqORF7YvBSvnOCo1BD6Cnw5U7WKn857nzRnEqWozA8tco+DRXMWJ4e+5EyJQh9e
 q+1+NAFglR6WEtI7+wuI0z2WOfnYoRPPOAc6FqsPesiCmMVbHbPgXEKNYiGqPhbuRZ1OPF
 DbMZORlauUQJjEiVY+pOU0qrQqLFFaQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-xwWY1Ax9OWKwcTGc-ScWEw-1; Sun, 28 Dec 2025 05:44:28 -0500
X-MC-Unique: xwWY1Ax9OWKwcTGc-ScWEw-1
X-Mimecast-MFC-AGG-ID: xwWY1Ax9OWKwcTGc-ScWEw_1766918667
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4792bd2c290so79179245e9.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 02:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766918667; x=1767523467; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WAb4vkolnWJdHqKEozrOY8S1XG2tOKb/W8rkeDz5SB0=;
 b=bD39nw43r3nGZ74+h7caMAFV9Hhie5QMoBfmobGKhw7cqFEwOr2xzQK5QkYevk6Gr/
 gcBLwUcwS+GXHRcZ8xP25JNGi6avT+HEdT3BEugHmpjv+qT57LoHWBZPl/aisNPTjtd5
 RnJm0QHT8OlBAqSZ5VA+hPOdTBnSYs9hwN1Gt5Xg7IYiQy/byl7X1ewVbuErU7Ybv+KF
 B/zBF9tuAUMVFVbMUYRp3i83YznFRAmUlIoDYd+SIuGk0UCDd7JJ3F8nvOof0wMYGVX/
 eVlW15UvqAE2c+I6LOHJgt43TI6sryKctxUbwZT7CKXLZTTOftpyxtWEtDqPG8qmp5vO
 y+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766918667; x=1767523467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAb4vkolnWJdHqKEozrOY8S1XG2tOKb/W8rkeDz5SB0=;
 b=J0qBHQFaFGhV66XhOKgPqendfen5o+tv1DSdL0/P7+Kl4H2tA1i+WcVclmTrsq8dRK
 Q+qPLI1FvYo63wICdf5MfocYmJy2sN7WGQSDCvVCy43dLvv2ShI1IVUTYZzNTFJvPxEd
 RBT+MaCz3ebagqQVH2rrDR8le3RCg9A/28nzI7mvDFzKoVrLwqtP0mhp+ZySKAcKZBnw
 3u8Clf3AylOEM2xJ3e4EYjAreZYNZnUFyOGfYuO1P4cbk+/uIJLjJTrrZy/+EbANDRVn
 1m6PtzuTyCSBcBeom2maTjIpEPrJGG0wh9IueLA792exuVWnZ4TW2qR3Zy2/bsjSRIMV
 PXZQ==
X-Gm-Message-State: AOJu0YwweD/Ry0+w2t53tHH6BAqJlbMJQDbrWtx5ttArGKglg89CKY3t
 PoTMgiw+fNDSL/whlfFrvfnZBvuToUkd2c/5oM7diarmoaDV9t2gRyxbnVryrHCyeQGqLC0IYKU
 pNbnd/vC745GMqaG9tBzo7QuKKz2MIRsNZyha9YDhXHTSVEHHktiWEVgDyETumH72Wz9MecYVAM
 tSBpf0a/CDc6LsYfjeJDVLCLiNPoDCJPs=
X-Gm-Gg: AY/fxX7zcE3lSfcFceem4Xvk2XFxtWUMcvbMA+2GTlH3+9drxrIEbb5BzrIrbixb5m5
 dBsPicxtg0/UjNs83FreZOSzqaVIjsHSLR5TsJ6Vf6Hk7BOa3caFZtfRa7qQjPq+Cu/Xy38rp/M
 DcT/+eWQxPQYxmFFkyYEBy/ASwCeHpYKpcTZdCrSxaDNplw03zCtAagRzRryGmjiBGi/XVUTgqW
 KFUphjahOzIBUiNRzC/ZFan3aKEPhDYC0b3+0cea/8x1b1S7ic0zWVOvY19a1pQ0zkM1gQ=
X-Received: by 2002:a05:6000:bc1:b0:431:c2:c632 with SMTP id
 ffacd0b85a97d-4324e703b16mr27540358f8f.57.1766918666807; 
 Sun, 28 Dec 2025 02:44:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4s8St7rIqtIbTY3wnvME1AIGlJKC3cchRCFI2jZmC8JYNDbzxTfDGIXGsrTL1k0I65H8vv9Tc1oipUIPYIvw=
X-Received: by 2002:a05:6000:bc1:b0:431:c2:c632 with SMTP id
 ffacd0b85a97d-4324e703b16mr27540343f8f.57.1766918666378; Sun, 28 Dec 2025
 02:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-17-philmd@linaro.org>
 <CABgObfa9gHpK3CR8Aa6MA4YqfaMs3bn70pba58QQ2+32+xwxzQ@mail.gmail.com>
 <e0b99887-934e-4587-9410-b090a4fcfdc8@linaro.org>
 <5e44a3e7-5eb3-4220-9193-8eb86690535c@linaro.org>
In-Reply-To: <5e44a3e7-5eb3-4220-9193-8eb86690535c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Dec 2025 11:44:14 +0100
X-Gm-Features: AQt7F2rq9XQfDNUCq6aiX4OQPdSmyPHYQI5PPREoQIzQDulnb8EGTdTzUE52wyY
Message-ID: <CABgObfaXgpdPe32ks+xkzOuNxvJMJhsfpvtjFobBJTueR1X24A@mail.gmail.com>
Subject: Re: [PATCH v3 16/25] system: Allow restricting the legacy ld/st_he()
 'native-endian' API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Content-Type: multipart/alternative; boundary="00000000000074f4af064700cf16"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--00000000000074f4af064700cf16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 27 dic 2025, 21:34 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> 1/ we can not have "guest native" endianness in single binary
> 2/ host endianness is only useful with "guest native" one,
>     otherwise if you know the guest endianness, you can just
>     use an explicit cpu_to_$endian method.
>

Host endianness is useful when not talking to the guest at all=E2=80=94e.g.=
 for
sockets or kernel APIs.

*_he_* functions are basically just memcpy in that they support unaligned
accesses; plus stn_he_p has the advantage of taking a value  unlike memcpy
which takes a pointer.

Perhaps the source of the confusion is that they are in bswap.h but they
(quite obviously since it's host endianness) never swap?

I felt confident it was coherent because, except the ATI single
> one-line case [*] which I believe is not the best implementation,
> the rest of my series proved this API is easily removable, the
> resulting code ending easier to understand IMHO.
>

It's easily removable because most of the time accesses are in guest
endianness, or aligned, but the replacement for *_he_* functions is not
picking a specific endianness; it's a normal pointer store. These are not
super common but especially in hw/display/ you can find them. stn_he_p is
the right choice for ATI.

Paolo

--00000000000074f4af064700cf16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 27 dic 2025, 21:34 Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">1/ we can not have &quot;guest native&quot; endianness in single=
 binary<br>
2/ host endianness is only useful with &quot;guest native&quot; one,<br>
=C2=A0 =C2=A0 otherwise if you know the guest endianness, you can just<br>
=C2=A0 =C2=A0 use an explicit cpu_to_$endian method.<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Host endianness is usef=
ul when not talking to the guest at all=E2=80=94e.g. for sockets or kernel =
APIs.</div><div dir=3D"auto"><br></div><div dir=3D"auto">*_he_* functions a=
re basically just memcpy in that they support unaligned accesses; plus stn_=
he_p has the advantage of taking a value=C2=A0 unlike memcpy which takes a =
pointer.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Perhaps the sou=
rce of the confusion is that they are in bswap.h but they (quite obviously =
since it&#39;s host endianness) never swap?</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">I felt confident it was coheren=
t because, except the ATI single<br>
one-line case [*] which I believe is not the best implementation,<br>
the rest of my series proved this API is easily removable, the<br>
resulting code ending easier to understand IMHO.<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s easily removable b=
ecause most of the time accesses are in guest endianness, or aligned, but t=
he replacement for *_he_* functions is not picking a specific endianness; i=
t&#39;s a normal pointer store. These are not super common but especially i=
n hw/display/ you can find them. stn_he_p is the right choice for ATI.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--00000000000074f4af064700cf16--


