Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DBAD43366
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 02:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTsY6-00059M-Uf; Thu, 11 Dec 2025 21:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTsY2-00058c-OJ
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 21:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTsY0-0006cM-QW
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 21:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765505179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vEVcIsB/Y4V/qhqTQlR5nssRYxfURybOQ/TOZ2gvcf8=;
 b=gKnqOMxPXCh0RGGKzwL8Xx4jz4rvg5elKma2GrNkK/IMxFlNccfqer3TffGMvVg8Kw+6J7
 zsCrzAJ7kf2FBMGMqAlTYdcjsc37eRk1Z48wDFgvGxKSqoLhlcK/bMLJnNrXY2y3mLpzw9
 a3VRrP7HXdURdvc8G4n3OwWYmqrTLx8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-QdS3w_GaPlqKTrlEpCtxhg-1; Thu, 11 Dec 2025 21:06:17 -0500
X-MC-Unique: QdS3w_GaPlqKTrlEpCtxhg-1
X-Mimecast-MFC-AGG-ID: QdS3w_GaPlqKTrlEpCtxhg_1765505176
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2ffe9335so392162f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 18:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765505176; x=1766109976; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vEVcIsB/Y4V/qhqTQlR5nssRYxfURybOQ/TOZ2gvcf8=;
 b=ZUDhriNJ4hFTtKsKGn0kJ0FeiK3enzmtNStMGq/rrC8OqToybHzGwgqSFs6ZC+agUT
 npMxuktId9LqXKvLm+JcPgfljNuv+w5svaHRoS1tnsY9Skzx50WpL5kTELrLcUwIoE3+
 Yl8/80x3NIVfEIeMAqxBW+dkTXy3XwfxnQkNkwBnlbNEsmtm/3pwEN7nixPB78WYn7Yb
 1oKY4us8M5DfcxJiqFTaFWBVOSUh9eqP56PC9wfRc1RQBfx6lJT/XW1GXy/YXUXqUdQ/
 HbzFXOYOLPWN8gH7ZcxpBRvtPvwcaiSMSAmxvb/tm/cKV+KQKQ+cX6Am5n6ipeTUE3EQ
 at6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765505176; x=1766109976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEVcIsB/Y4V/qhqTQlR5nssRYxfURybOQ/TOZ2gvcf8=;
 b=UKLTLBOjolyOKVQHJ76mlv2RYbv1YtUtKUj33CwOFe3S368vy1Yx3qA20O8T5VhLec
 h1WHB7dHTuAHIK3JHsUZauHTI59kgWPURy99G1+YSaiKwYbDAwPwGQA1NmcHWA+hlzmU
 NtoIAEzgarp3Gjtvz1DjGVMO5k1mfs8+3eb+NQ14v5gIUF/Vjq2DpPl4p3hL7BzYQS+F
 drmgMZTJp5wuFbOIUZmWTO4OlZAlla6e+z+IkN9m0AEfkUv9DOkIH81Y6UDCKIoul+y/
 Objw2TBBP2GQLbbJa87UoN6b4osPKDramXPmDMaRHSQVhH6vqspqvryOBKfcTqTciXDI
 rNAQ==
X-Gm-Message-State: AOJu0YxrWlf1RikGMwv7WtjWVsu7yg7Sr8zQb5JbEbdMmLQkmCZHPIKD
 i1iHGInKgpksyfMYKTQ0dJ7cu6pkdYkTKGljuNdOcCS00AlBZziS0yIJ+buZTmP6vsszbPLSk81
 Pp8WIxGNI5M3+veY+CMLd2EQjCo5eEKV4bQ2K8b5c3Dtk9h6ur+91Hzj++159pEzdKv8L2PWF0S
 2xy7eVw6USpAOZ1VuYjv7KxkJI1mqACno=
X-Gm-Gg: AY/fxX7520yzLSEoBW1oGUbfa8yVcfIJm1d/rdB0CqG5gEfEQw3ALK1n2mEAprdewiF
 xopeXIwZ+9G7Rve3GSSxax7gmuoPQTKItxlTW2xJazyo8Z5WaxYrq7eABaky5FTVrqGGxNVmz5m
 Fk8MOiqRrwolvQQLp7ArKX2lQahxsUGjNCJHN8MyqB/AAbkTMUkpnudm0UubqGLapIfoCYCkMva
 JY+8RSiFpdlKNTTQZcVjmZo2u2DkJHvZ/jilDYAv5A9aSNmwVfgQXHE6hDBcwfprTR2HrA=
X-Received: by 2002:a05:6000:2507:b0:42b:3ad7:fdd4 with SMTP id
 ffacd0b85a97d-42fb44d45bamr308075f8f.3.1765505176138; 
 Thu, 11 Dec 2025 18:06:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu7X3kWyjOydNCgVcWT1VCFZMC+JnzNbsqJMJB5fDXHEIEMXLbFaEMaQbfaO+8RwL2VkgmBEUpv4aQBRNdako=
X-Received: by 2002:a05:6000:2507:b0:42b:3ad7:fdd4 with SMTP id
 ffacd0b85a97d-42fb44d45bamr308068f8f.3.1765505175824; Thu, 11 Dec 2025
 18:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-2-pbonzini@redhat.com>
 <bbca9504-2b47-4aa0-8cc0-be17b3db85d0@linaro.org>
 <CABgObfb7xNov4tW1m1Yru+-p55zGW_3jsNXyzL68_NjY0XnMtA@mail.gmail.com>
 <755aed45-4ebf-4828-817a-ebe6106ea2ad@linaro.org>
In-Reply-To: <755aed45-4ebf-4828-817a-ebe6106ea2ad@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Dec 2025 03:06:04 +0100
X-Gm-Features: AQt7F2pauVbnsJB5wlPYktJDnzL-ewpQ93wVdqA8EnUQwzxtW5Wi431lEfo7rKk
Message-ID: <CABgObfbrfSytFOKxAdcgeWPSu9BKsVkLuBSDSVsZLB-=LEBbdQ@mail.gmail.com>
Subject: Re: [PATCH 01/18] target/i386/tcg: fix check for invalid VSIB
 instruction
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000dac16a0645b7b4a1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000dac16a0645b7b4a1
Content-Type: text/plain; charset="UTF-8"

Il gio 11 dic 2025, 23:22 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> > Yes, I was confused by the comment and by QEMU's incorrect decoding
> logic:
> >
> >          if (CODE32(s) && !VM86(s)) {
> >
> > which should be changed to
> >
> >         if (PE(s) && !VM86(s)) {
>
> I can't find the language for that.  Can you point me at it?
>

It's the exception condition tables. They all mention that you get #UD for
the VEX prefix in real or vm86 mode.

Several BMI instructions also have language like "This instruction is not
supported in real mode and virtual-8086 mode".

Paolo


> > And by the way, this also means that we need either separate helpers
> > for 32- and 64-bit addresses, or a mask argument.
>
> Of course.
>
>
> r~
>
>

--000000000000dac16a0645b7b4a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 11 dic 2025, 23:22 Richard Henderson &lt;<a hre=
f=3D"mailto:richard.henderson@linaro.org" target=3D"_blank" rel=3D"noreferr=
er">richard.henderson@linaro.org</a>&gt; ha scritto:</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; Yes, I was confused by the comment and by QEMU&#39;s incorrect decodin=
g logic:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (CODE32(s) &amp;&amp; !VM86(s)) {=
<br>
&gt; <br>
&gt; which should be changed to<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (PE(s) &amp;&amp; !VM86(s)) {<br>
<br>
I can&#39;t find the language for that.=C2=A0 Can you point me at it?<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39=
;s the exception condition tables. They all mention that you get #UD for th=
e VEX prefix in real or vm86 mode.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Several BMI instructions also have language like &quot;This inst=
ruction is not supported in real mode and virtual-8086 mode&quot;.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br=
></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
&gt; And by the way, this also means that we need either separate helpers<b=
r>
&gt; for 32- and 64-bit addresses, or a mask argument.<br>
<br>
Of course.<br>
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--000000000000dac16a0645b7b4a1--


