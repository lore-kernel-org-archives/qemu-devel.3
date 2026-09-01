Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38A0C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uvc-0001YP-9R; Tue, 01 Sep 2026 16:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x1Uvb-0001YD-GA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:17:55 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x1UvZ-0002Ye-Lr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:17:55 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so369103a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788293872; cv=none;
 d=google.com; s=arc-20260327;
 b=hmClI+jZaVUBI+Rpzjrv43lMJNjb70exsSOxVrvSROktohGIqE33JoDN36Y/9VW2jF
 OCfOjUexo50bXKGtTLOp7JC5E6QC20VpFirwoDir3kOPIOr4QkjQAn9KoCdrHgJXaEHd
 EqsVObwTRUH9tbs6Sa0xRW+Ldy77FQDHCuJKBs96qHNVqh/z39oqdrtv5amfrkX9GuOw
 jG7p5ymAN0nqnq12PxlhAT5dEr8hln6U1UDOXIbEANuBhJvGGAYro7t9UCoWsz0bTXCG
 di26oNFUoi9N+XEnnx6qQQpy+sRQXjN0umcuQm/yvtClorJuKi80sUd3LafTjm1S8G/z
 VFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b6FLdr0o2cZ4ANeX8st8I/VAgTL0oasJXz7PbhJ7IfY=;
 fh=9EfZk84xpGKhymtmZreIYkfMlh54OsiL0enBsPvuUHM=;
 b=ZvyyI5BqpW9L7f4XtEw2GNufjf6o6O/Zlz1/f6zVyDfMW48fXsjdFfTxDstFn+qXE5
 in8p6P/gwj1932YrcIBXznQtcj6sQbtWDYKZRmY6OQaa2RYR0XeQhVZmGXzsdTqpmFtU
 i79pof2ytt1JRhv9i10GCVTONYFq+QrcpT03M6UfzAuwXeIprDMQLeLL80b2LX+4497w
 whsQjQ4MgszYM3VwsWlBVhAUMqR3/CuGcQ7HCGzGVXC53ztlJ9ya0ypSJK5YeZYLG/4c
 UpbLo4E7DEaASrI+Bvu5NRkV/qGX/c3X6StT9TGFRD17rWXnmzUaXv/btGJSul8abIgG
 ebDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788293872; x=1788898672; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b6FLdr0o2cZ4ANeX8st8I/VAgTL0oasJXz7PbhJ7IfY=;
 b=M44JpEbV1PGNqxEN6tmqMla1fJ7aonb2nu3i1QE7diSCUVdE5ojjLSwpXuoZgCqSyN
 NwtfD1K1lricj8iefihaBDOmvIrlInsi7iCLxJJSovvRqui+gir4K89zDx7qetY+AVmL
 QbOAyEg9Es4oYerO1kFuxQ/veTLHsFssGy4AKwckPoZWExI8DGicRbGWCXC14v8JcJB1
 XJM8/nswwyL6xzJDjKRDD3iU+52mVIgzhQ0/tLS43Z6k8KuLhE1eMA3+34Y8MCBOfuTN
 mPZzhkhdjXNEhOoJcx9BTyUeVXYMtxPHeswJNCc8C4T9dubXikSHsGMi/hdRZ9Zu8+Um
 t4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788293872; x=1788898672;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b6FLdr0o2cZ4ANeX8st8I/VAgTL0oasJXz7PbhJ7IfY=;
 b=K70BfdEtELAxqS4es+WcOWvl8DLmy301M5hDZOsGRckPh4Mvr6himpDo67gUlmUtTk
 rCPvK9FbqklCIrfU2QG452mEN1I9YJwrmfW1jaAlC+k72Zsa2LpvcH2RzmMsfyywcxHq
 6K77BJq3C18UYHzZ9ITdC5i49YzhfL9/LY9vAyc4MrEWsCtsvXnGF0L9tDo9HSDQLbDc
 q2DKURNXd74ZcpzxofKCwBEyTC6UOJKv21VbisCtx0b7xq9dghynP/X4qX/xijU3kHly
 1noi2X0o8GDWIexfX4P07Vsn2+gae7/JOgk7J2hESJ28QltkvbxyC9rlr9BD0u0gObiy
 VGhw==
X-Gm-Message-State: AFuF++khruYHNTKGKlPIQnWPQhT31TInxnE/1Ix0aH0M3B5DxEThKBm4
 t2xdwo/IzlUqPsXHU32vEum0mTQVVeMk4B8Ius60Hn4kxo1nWb0ASqTKWZD5AsCeQm+fnH3IRHS
 UAtKE4YDHKY+9KQAAAO3lwLeFWv0NaeA=
X-Gm-Gg: AYBFou35f8BJVk2av+8A5xipG1dKXTmVHnyKIXub6RbmWyBCbr1fLMThP/jCsNrCtMF
 wVBnToZSbanTQIbDFhg4yUlRWegQI51EBBzW+ecsgOdQVAkVGBZh6Ia+Xmi2c/7FqWJj/HrbIPX
 AI2xpFYx7+f0QzXTHLCOLvrrysph8F/uuPF10duT5WiMX+Uh9vhl5GkqxgnoL4hI22NnYhEPKmc
 yG82loFURZtBn0oPklWajKwdwhQAEK/gUwlTNmeVji3GC6LUlwDafzz75JsvmXAlO33eg+tTUwR
 qPyoUgFM5ybQ6jcjPSzhzIEwcWKOn8Itblc1YJrKay7md+g2lxhuyDIjBo37nZR80NMbKc1Uy9g
 4
X-Received: by 2002:a17:90a:1c08:b0:399:1b08:28de with SMTP id
 98e67ed59e1d1-3991b082a7emr8245252a91.7.1788293871940; Tue, 01 Sep 2026
 13:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260901195334.463267-1-jsnow@redhat.com>
In-Reply-To: <20260901195334.463267-1-jsnow@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 2 Sep 2026 00:17:41 +0400
X-Gm-Features: AcwNN1W7SkPSHGV9BGnpdaLUPpC5ZQO52ogJDXXkj7UBu1wgCcQkppTf1lBt6M4
Message-ID: <CAJ+F1CKA-UPwzx7XLLhvA+VW8PuDQGbXKXDBK0mVfo0E4C6-hA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove stale contact info for Stefan Berger
To: John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Stefan Berger <stefanb@linux.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fdbc09065a719c07"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x102c.google.com
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

--000000000000fdbc09065a719c07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Le mar. 1 sept. 2026, 23:54, John Snow <jsnow@redhat.com> a =C3=A9crit :

> I was unable to get in touch with Stefan and I am not currently sure
> if this module is maintained or not. To prevent an avalanche of
> bounced emails, remove his contact information.
>

Really? There must be something wrong. He is a very responsive and active
maintainer.


> Signed-off-by: John Snow <jsnow@redhat.co <jsnow@redhat.com>
> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a0ee348c4e..69803afe995 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3839,8 +3839,7 @@ S: Maintained
>  F: scripts/simpletrace.py
>
>  TPM
> -M: Stefan Berger <stefanb@linux.ibm.com>
> -S: Maintained
> +S: Orphan
>  F: system/tpm*
>  F: hw/tpm/*
>  F: include/hw/acpi/tpm.h
> @@ -3849,7 +3848,6 @@ F: qapi/tpm.json
>  F: backends/tpm/
>  F: tests/qtest/*tpm*
>  F: docs/specs/tpm.rst
> -T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
>
>  SPDM, PCIe DOE
>  M: Alistair Francis <alistair.francis@wdc.com>
> --
> 2.55.0
>
>
>

--000000000000fdbc09065a719c07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div><br></div><div>Hi</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le mar. =
1 sept. 2026, 23:54, John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsno=
w@redhat.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">I was unable to get in touch with Stefan and I am not currently sure<=
br>
if this module is maintained or not. To prevent an avalanche of<br>
bounced emails, remove his contact information.<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Really? There must be someth=
ing wrong. He is a very responsive and active maintainer.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_con=
tainer"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">jsnow@redhat.co</a><br>
---<br>
=C2=A0MAINTAINERS | 4 +---<br>
=C2=A01 file changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 2a0ee348c4e..69803afe995 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -3839,8 +3839,7 @@ S: Maintained<br>
=C2=A0F: scripts/simpletrace.py<br>
<br>
=C2=A0TPM<br>
-M: Stefan Berger &lt;<a href=3D"mailto:stefanb@linux.ibm.com" target=3D"_b=
lank" rel=3D"noreferrer">stefanb@linux.ibm.com</a>&gt;<br>
-S: Maintained<br>
+S: Orphan<br>
=C2=A0F: system/tpm*<br>
=C2=A0F: hw/tpm/*<br>
=C2=A0F: include/hw/acpi/tpm.h<br>
@@ -3849,7 +3848,6 @@ F: qapi/tpm.json<br>
=C2=A0F: backends/tpm/<br>
=C2=A0F: tests/qtest/*tpm*<br>
=C2=A0F: docs/specs/tpm.rst<br>
-T: git <a href=3D"https://github.com/stefanberger/qemu-tpm.git" rel=3D"nor=
eferrer noreferrer" target=3D"_blank">https://github.com/stefanberger/qemu-=
tpm.git</a> tpm-next<br>
<br>
=C2=A0SPDM, PCIe DOE<br>
=C2=A0M: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.com" t=
arget=3D"_blank" rel=3D"noreferrer">alistair.francis@wdc.com</a>&gt;<br>
-- <br>
2.55.0<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000fdbc09065a719c07--

