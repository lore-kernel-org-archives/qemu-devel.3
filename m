Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9FAC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 11:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq9VP-0005X1-Iq; Thu, 06 Mar 2025 06:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tq9V2-0005Sw-LM
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 06:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tq9Uz-0006QW-Tj
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 06:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741260883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qocYR3YUWOH8kPBLXbZSWw/kt5vPrSNExXQXYNvhrM8=;
 b=LEV6gvrFYPJ+w/4A9HeEzwC3N7aA1JaSBiJAdFMDbK8Guj5t5tjiEAfl3BZxTtGaWvb+/q
 HNjFg1PbaC6aYKJIfk85sfjYDzOxvVgua8GzBHE06WWLLQekCpzMFV8MZuW62pcT23DUpA
 LvpxZTxGeK1dssRjfi7hjuDa0XZ42RQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-7IeEf2GDP8WbQ0DEsj7Idg-1; Thu, 06 Mar 2025 06:34:27 -0500
X-MC-Unique: 7IeEf2GDP8WbQ0DEsj7Idg-1
X-Mimecast-MFC-AGG-ID: 7IeEf2GDP8WbQ0DEsj7Idg_1741260866
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43bd0586b86so3728125e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 03:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741260866; x=1741865666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qocYR3YUWOH8kPBLXbZSWw/kt5vPrSNExXQXYNvhrM8=;
 b=jLWMFOh6TIVPKYXcrGOFD0iReY9yvTDDkegWoUZ9R0k+n+kBg2zdgSP2Ga8hx5c6aL
 aL6TDWbsTu7lZNW9z0R2W99IiET7KCCy1A7kHUJefkexHvrIVK6iljTl0gorVGrD/aYl
 sdR2+og2tkgSWo/G3bwbXYHkqxlvdLuvF/iC1XUvgRuwUZIpdF4MOd7H2xljlafGrZd3
 YMrGttwMbVkeoY6rJUipMZmMrzg6EIyYF/IvXpySaUdTfuDy6noaFoyi4Nh2pK427GIx
 UwOUMOJGxhSd1zBVPTrgG2Qjfp5dHCNitFzceoDlwywaRWpO8l9tyKAV+cixsPDKF75k
 NlHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd1EHlui3w+EeYvuRM8z+OmHcXv51JuUB4V/q1zICexaN/VEtn0TDC2r71iRa962ogzaGhH7mUtey9@nongnu.org
X-Gm-Message-State: AOJu0YwuzPl+ekJH32uisJQtffjOeb1VSNLnmwCKsRYwp9tbczc1Cq+7
 L/XFcu17ZCBBvRRLZfZzCT0uKGhOFrZaL31OCetese+nZ7rY8bNGH+j1pQoUmd2LvDUK3r/kB9A
 N4YpMLtzXMMTv8hGivvS+HaNGaiILCiwrSWZ/OBaYYxE0XxPHw++dKiFIH7dQRxoYZGzbpREcZv
 FJSc/MdY+4BcYbSzWiBOyUXBXHZiQ=
X-Gm-Gg: ASbGncv1HlcCrAXNdZgOPPlfnQOUU0ZFQK9E6UAsRCYrbQAFc+cY8Ycs3CSDaJw7pKe
 f/a2bc2TNwivrrjcwyN/He0vsgO+VqT9puH6FvgdJRz4hvu/HCp4ITBhe1PCU+Rww6qNZncAC
X-Received: by 2002:a05:600c:4f4e:b0:439:6e08:f4 with SMTP id
 5b1f17b1804b1-43bd2ad9e3dmr47022045e9.26.1741260866123; 
 Thu, 06 Mar 2025 03:34:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEootNK5eKG8Z90UlGchgzbmPfN63oW508EH59tA6K/azxa2zKTw8TuRvAg8AJ0p7p4CKHFNlk/lsjZ8kOKzs=
X-Received: by 2002:a05:600c:4f4e:b0:439:6e08:f4 with SMTP id
 5b1f17b1804b1-43bd2ad9e3dmr47021875e9.26.1741260865774; Thu, 06 Mar 2025
 03:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-5-philmd@linaro.org>
 <35177cd6-0741-4c28-a5d5-3529208a31dc@linaro.org>
 <dd0336c2-c2ed-477c-8f40-eaee2f110238@redhat.com>
 <21a34cac-855b-4628-a154-e708ea85df59@linaro.org>
In-Reply-To: <21a34cac-855b-4628-a154-e708ea85df59@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Mar 2025 12:34:13 +0100
X-Gm-Features: AQ5f1Jpg7NxqywWfD0OsvHwSovsdIahR0desYvWDvJZXkLZSYNhTA6ju1UJcu0k
Message-ID: <CABgObfaKQLizim36Lzqzn+brc5d7m10eKbZV59ZK9+03Kt7eTg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005dc865062faae3ca"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--0000000000005dc865062faae3ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 6 mar 2025, 10:27 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> This API is to allow refactoring code for heterogeneous emulation,
> without changing user-facing behavior of current qemu-system binaries,
> which I now consider as 'legacy'.
>
> Once all current restrictions removed, the new qemu-system-heterogeneous
> binary is expected to run any combination of targets.
>
> qemu-system-$target will be a call to qemu-system-heterogeneous with
> a restricted subset, possibly in the form of:
>
>   $ qemu-system-heterogeneous --target aarch64-softmmu
>

Or just qemu-system I guess.

    ^ equivalent of today's qemu-system-aarch64
>
> If you don't like 'qemu_legacy_binary_' prefix, I can use
> 'qemu_single_binary_' instead.
>

Still there is a problem with renaming binaries (both the "qemu-kvm" case
and the good/bad case that Richard pointed out).

I think you should try creating two versions of system/arch_init.c, so that
it has a separate implementation for heterogeneous vs. single-target
binaries. Then you can keep separate linking steps for single-target
binaries and you naturally get the right target info from either the
target-specific arch_init-single.c, or the --target option for
arch_init-multi.c.

(Is --target even necessary? As long as you have a way disambiguate
same-named machines like -M virt, and have no default machine in the
multi-target binary, you shouldn't need it).

target_is_64bit() is misleading, for example in:
>
>   $ qemu-system-aarch64 -M zynqmp
>
> we create 64-bit and 32-bit ARM cores.
>

Agreed, bit size and endianness should only matter in the CPU code.

Paolo

>

--0000000000005dc865062faae3ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 6 mar 2025, 10:27 Philipp=
e Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro=
.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">This API is to allow refactoring code for heterogeneous emulatio=
n,<br>
without changing user-facing behavior of current qemu-system binaries,<br>
which I now consider as &#39;legacy&#39;.<br>
<br>
Once all current restrictions removed, the new qemu-system-heterogeneous<br=
>
binary is expected to run any combination of targets.<br>
<br>
qemu-system-$target will be a call to qemu-system-heterogeneous with<br>
a restricted subset, possibly in the form of:<br>
<br>
=C2=A0 $ qemu-system-heterogeneous --target aarch64-softmmu<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Or just qemu-sys=
tem I guess.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
=C2=A0 =C2=A0 ^ equivalent of today&#39;s qemu-system-aarch64<br>
<br>
If you don&#39;t like &#39;qemu_legacy_binary_&#39; prefix, I can use<br>
&#39;qemu_single_binary_&#39; instead.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Still there is a problem with renamin=
g binaries (both the &quot;qemu-kvm&quot; case and the good/bad case that R=
ichard pointed out).</div><div dir=3D"auto"><br></div><div dir=3D"auto">I t=
hink you should try creating two versions of system/arch_init.c, so that it=
 has a separate implementation for heterogeneous vs. single-target binaries=
. Then you can keep separate linking steps for single-target binaries and y=
ou naturally get the right target info from either the target-specific arch=
_init-single.c, or the --target option for arch_init-multi.c.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">(Is --target even necessary? As long =
as you have a way disambiguate same-named machines like -M virt, and have n=
o default machine in the multi-target binary, you shouldn&#39;t need it).</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
target_is_64bit() is misleading, for example in:<br>
<br>
=C2=A0 $ qemu-system-aarch64 -M zynqmp<br>
<br>
we create 64-bit and 32-bit ARM cores.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Agreed, bit size and endianness shoul=
d only matter in the CPU code.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Paolo</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_c=
ontainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>

--0000000000005dc865062faae3ca--


