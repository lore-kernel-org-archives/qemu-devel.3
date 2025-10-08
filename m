Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFAFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c4x-00036P-NO; Wed, 08 Oct 2025 17:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6c4u-00036F-Rc
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:52:09 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1v6c4o-00068v-Vv
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:52:08 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-92cebee95a8so11994139f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759960320; x=1760565120; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ej1mRa0WTK5Czq03i2hmIzUcLd8bsZ4MlR+Rgsd0ew=;
 b=R11c2dxse3Cgk6X2+Hz6zeiz0YUiuMv2zXE2ZlBaAZlpBqhZ8ys/BXMi6+Dvr6ZmCR
 O6AxODX2+h+Vyst5sifMf4zsr495sMYvGAuhv7ppETtvz/SiGzh39zI0cqAUcslNvmMW
 m7tT/RfhHkj9siYnV9gH9Xtl9d8lhlhyai2J5p8x0rBoih5ilo8YkqpBdw4I1xUwV869
 ugtfZEEMc6cWn+uqbGePeXiskPx2KVn2rG4Ni1ghsTuDfZQ3jhOdWR1u9T0Qggsjrozh
 btLdsRYI2plh9BERSW7gyt9sfKQixzUhDzhPCoZXsVMm1jHHGX2vm4F5wyvI4m9S4JvI
 Siag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960320; x=1760565120;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ej1mRa0WTK5Czq03i2hmIzUcLd8bsZ4MlR+Rgsd0ew=;
 b=dxurWwtDiyGr/z/OsM0P+g9uXgVaHUOHIjB9SmbWNQwBFMqffp7iHWG8Qf5JyKNMUo
 mLMNkgw6Z0cDXkC5Mpnmntj4btVdrCc6UyBhNLK8tfhNJEhtXIJ1yMYDYMPD11hoIFDG
 h6D4/xKDxnjMOTyZEqu4J59U/qd1fdWp9M/moznC43/9fYKA0U4b53UJ4JaNwaa2243t
 Yp5QtZH5y3P2Hlatgy/EZMVbgP522+Sn6rwxLOLssyZGe30kf31onGXUiHI6NfoRNWd/
 3NqAkvtvHH96ohOrpeeVbR1p07x6qQ3zazSPwwxmPhNNH18PJ4vAYzY8z+f+zvPzW7xl
 aKfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvOmhvuzkKSwVpfiZawdIo3PtTikS++lkvUgEYw5MNcGdlxTiAjAHNgvyK6LzTNRIdMnsz3Op2So4C@nongnu.org
X-Gm-Message-State: AOJu0YzBHeZdLsMYvqW6Tv3yWkhS12ygXJi1g0ya6Gw7p1dZo10ve9eh
 LESTi2dJ8FdFwviAshEfaUEMOZFXWBJvz1dUBja529oRqNOYizeDyTDu
X-Gm-Gg: ASbGncu4kyISMWHr+c5DLJU4xQLy6BLKKW8kt3tPwG+vLqry+FpE0e6XwOtYZ6/A6gb
 ZPFvFeIztdroV8viWufMrT0ldXEAsFGUYfy7WVlIlEjKJn3teXntm0KkUvsHfPMnevG71JnUAN9
 K5g9Es6hoU4J8umG1C5pTxIOuBbluzGZllBlKrh582DkIByVrOsqj+3CeaEEZ72jla9jbK/8NAe
 aK2sWL5KdCRS7hqWc6kQny9OTaVcpKmE1YxiDkETm3bCbs99Shvc1tAa21mWTlHKbewWGgjwU1o
 iJrRWNQHq+8ZYh9NP3Wm0JHApymWNY2xO1zy/dBiRBWUKZQk6gSXTVaGYcLq08vdH2yNXgtcyqA
 HpcRjSnyJjeaD95WX24b0oPp9rdkdIy3ImNdWVgtmJeDRi/T9vnOuYrATskhheLsZh17fU3i5uA
 ==
X-Google-Smtp-Source: AGHT+IHMadnzCds/UrirTqmKh4iCnzmrCl2uNMKzPjzJ+ifa8/ldkFCsIPalRu4z2uCwqBsQmjGJhQ==
X-Received: by 2002:a05:6e02:1a22:b0:424:bec:4a01 with SMTP id
 e9e14a558f8ab-42f873d6985mr41329645ab.16.1759960320351; 
 Wed, 08 Oct 2025 14:52:00 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:281:881:bb90:7176:1e71:15fd:4673])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ebc84dbsm7282787173.35.2025.10.08.14.51.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Oct 2025 14:51:59 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <matheus.bernardino@oss.qualcomm.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <marco.liebel@oss.qualcomm.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sid.manning@oss.qualcomm.com>
References: <20251008014754.3565553-1-brian.cain@oss.qualcomm.com>
 <20251008014754.3565553-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20251008014754.3565553-2-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 2/2] tests/tcg/hexagon: Add cs{0,1} coverage
Date: Wed, 8 Oct 2025 15:51:58 -0600
Message-ID: <024001dc389d$c5f5bf30$51e13d90$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHus+aLkVWMPesY8ig/bcBi9wF1CAIgp0qQtILNCQA=
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Tuesday, October 7, 2025 7:48 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com; ale@rev.ng;
> anjo@rev.ng; marco.liebel@oss.qualcomm.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sid.manning@oss.qualcomm.com
> Subject: [PATCH 2/2] tests/tcg/hexagon: Add cs{0,1} coverage
>=20
> Cover cs0,1 register corruption in the signal_context test case.
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/signal_context.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/tcg/hexagon/signal_context.c
> b/tests/tcg/hexagon/signal_context.c
> index 7202fa64b6..00bbb3efc7 100644
> --- a/tests/tcg/hexagon/signal_context.c
> +++ b/tests/tcg/hexagon/signal_context.c
> @@ -26,7 +26,11 @@ void sig_user(int sig, siginfo_t *info, void *puc)
>          "p1 =3D r7\n\t"
>          "p2 =3D r7\n\t"
>          "p3 =3D r7\n\t"
> -        : : : "r7", "p0", "p1", "p2", "p3");
> +        "r6 =3D #0x12345678\n\t"
> +        "cs0 =3D r6\n\t"
> +        "r6 =3D #0x87654321\n\t"
> +        "cs1 =3D r6\n\t"
> +        : : : "r6", "r7", "p0", "p1", "p2", "p3");

Add cs0, cs1 to the clobber list.

>  }
>=20
>  int main()
> @@ -52,7 +56,11 @@ int main()
>      it.it_value.tv_nsec =3D 100000;
>      timer_settime(tid, 0, &it, NULL);
>=20
> -    asm("loop0(1f, %1)\n\t"
> +    asm("r9 =3D #0xdeadbeef\n\t"
> +        "   cs0 =3D r9\n\t"
> +        "   r9 =3D #0xbadc0fee\n\t"
> +        "   cs1 =3D r9\n\t"

Should these be inside the loop?

> +        "   loop0(1f, %1)\n\t"
>          "1: r8 =3D #0xff\n\t"
>          "   p0 =3D r8\n\t"
>          "   p1 =3D r8\n\t"
> @@ -74,10 +82,18 @@ int main()
>          "   r8 =3D p3\n\t"
>          "   p0 =3D cmp.eq(r8, #0xff)\n\t"
>          "   if (!p0) jump 2b\n\t"
> +        "   r8 =3D cs0\n\t"
> +        "   r9 =3D #0xdeadbeef\n\t"
> +        "   p0 =3D cmp.eq(r8, r9)\n\t"
> +        "   if (!p0) jump 2b\n\t"
> +        "   r8 =3D cs1\n\t"
> +        "   r9 =3D #0xbadc0fee\n\t"
> +        "   p0 =3D cmp.eq(r8, r9)\n\t"
> +        "   if (!p0) jump 2b\n\t"
>          "4: {}: endloop0\n\t"
>          :
>          : "r"(&err), "r"(i)
> -        : "memory", "r8", "p0", "p1", "p2", "p3");
> +        : "memory", "r8", "r9", "p0", "p1", "p2", "p3");

Add cs0, cs1 to the clobber list.  Also, add sa0, lc0 due to the loop0 =
instruction.


>=20
>      puts(err ? "FAIL" : "PASS");
>      return err;
> --
> 2.34.1



