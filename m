Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4DFC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 16:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMVGT-0004AW-5K; Wed, 26 Jun 2024 12:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMVGQ-00049B-PM
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:12:55 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMVGM-0005Dh-IQ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:12:52 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52ce6c93103so4531996e87.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719418368; x=1720023168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=seAmd6wTy1ADKAlft+hRSaoA+AE4vdMEF+mfVdiiDik=;
 b=E+2WXLXNt5JizvMWm/BOamsYNDUqCCi4Jtapl3TDrytG0qbx17CshFYejl2TlF2r2R
 rzsyeIti8MAz0gcXwKgM0tbVTWSv/9RE4D4yw4AVTFRsAA9IjJnpLQkDAsXx1pkvejbi
 hh/a+lJrHlxopm4xZVatDcK5Cw112DQHc6G5kraqlsBI23AyjcYWeFyywTWQmPwKj5Da
 xNAxHIurtEh6hjrPPSAgV044v0BgQrwO5jU3PD4NQP7h8jiVYrLggLW0YWBjCJtnJuOT
 2kB5OBnSxRPyEsa3iBTuRYPYhiy/NTlrV+2vdTTUT2ZXlkRY+j09rVuv4OyQwqHFfoWO
 ANCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719418368; x=1720023168;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=seAmd6wTy1ADKAlft+hRSaoA+AE4vdMEF+mfVdiiDik=;
 b=eN4ou3T9IVATadHwLsDXhKGDKQ/ftUUqlgTJrZ8Z0g6LQ5TwERWqcIN5WFHvPXix+P
 QMqRXrkQuRTEzjhf7jbx7oAKwkVyaBXsiWm0kUhVHttVT0TA6MAXju9luhnt7q9NyK/0
 KzT8azs0r9ubUjc+Uz21qYrKgxEBwbOB+d+snRqngBIx5hnzt5uA2FK5eEc1xBvNRN+r
 BVOML7yLIn3B4adxlkCV1hyavOnpyKo3ruk4ao4j9/mFSNFTijLO/lcwoeAjiVAIqaPS
 ZlB5P+a1E7QtqeEa32l6ZgaWuGzTiU/hycS9rCyMAhvt9s3lWJXFttUpq86Izl7e1t87
 73vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRDIvFviVALcaHEGOMJzAXWXgVJK4OsBS4YY2A6wPEg04maNVIxpY6NaT+ZU3DXZ80Ykznpc+XnB7Y5qWpq9gTocv4ghM=
X-Gm-Message-State: AOJu0YzwQ5TM8xvwXdnT1Pz9cGYuJgVjkWHfNFebM+a+JqFbBVSoxxyg
 fA7qDcFMV6dblPadNIfNWUUVM3UNCLeL+l4h9xeQlMRbYetyguknzsLixT7NUJc=
X-Google-Smtp-Source: AGHT+IGzAiNVJnN+zheQ5ZX7JPksb4EJvm2J7joqnDuOJQV7E4+vMdKRj9eiJjS4g6siO6qkBOsX/Q==
X-Received: by 2002:ac2:4e07:0:b0:52c:d5e4:9a99 with SMTP id
 2adb3069b0e04-52ce18329c2mr11309099e87.17.1719418367325; 
 Wed, 26 Jun 2024 09:12:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a724837222fsm408234466b.80.2024.06.26.09.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:12:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2763C5F8AA;
 Wed, 26 Jun 2024 17:12:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] tests/tcg/aarch64: Fix test architecture specification
In-Reply-To: <20240626-tcg-v1-2-0bad656307d8@daynix.com> (Akihiko Odaki's
 message of "Wed, 26 Jun 2024 20:26:23 +0900")
References: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
 <20240626-tcg-v1-2-0bad656307d8@daynix.com>
Date: Wed, 26 Jun 2024 17:12:45 +0100
Message-ID: <874j9fpts2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> sme-smopa-2.c requires sme-i16i64 but the compiler option used not to
> specify it. Instead, the extension was specified with the inline
> assembly, resulting in mixing assembly code targeting sme-i1664 and C
> code that does not target sme-i1664.
>
> clang version 18.1.6 does not support such mixing so properly specify
> the extension with the compiler option instead.

I think we need fixes for older clangs supported by our distros as well:

  16:08:26 [alex@aarch64:~/l/q/b/all.clang] plugins/next|=E2=9C=9A1=E2=80=
=A6(+0/-0) 2 + clang --version
  Ubuntu clang version 14.0.0-1ubuntu1.1
  Target: aarch64-unknown-linux-gnu
  Thread model: posix
  InstalledDir: /usr/bin

Gives:

  tests/tcg/aarch64-linux-user: -Wa,-march=3Darmv9-a+sme-i16i64 detected
  /home/alex/lsrc/qemu.git/tests/tcg/aarch64/sme-smopa-1.c:17:19: error: in=
struction requires: sve or sme
          "smstart\n\t"
                    ^
  <inline asm>:3:2: note: instantiated into assembly here
          index z0.b, #0, #1
          ^
  /home/alex/lsrc/qemu.git/tests/tcg/aarch64/sme-smopa-1.c:18:30: error: in=
struction requires: sve or sme
          "index z0.b, #0, #1\n\t"
                               ^
  <inline asm>:4:2: note: instantiated into assembly here
          movprfx z1, z0
          ^
  /home/alex/lsrc/qemu.git/tests/tcg/aarch64/sme-smopa-1.c:19:26: error: in=
struction requires: sve or sme
          "movprfx z1, z0\n\t"
                           ^
  <inline asm>:5:2: note: instantiated into assembly here
          add z1.b, z1.b, #16
          ^
  /home/alex/lsrc/qemu.git/tests/tcg/aarch64/sme-smopa-1.c:20:31: error: in=
struction requires: sve or sme
          "add z1.b, z1.b, #16\n\t"
                                ^
  <inline asm>:6:2: note: instantiated into assembly here
          ptrue p0.b
          ^
  /home/alex/lsrc/qemu.git/tests/tcg/aarch64/sme-smopa-1.c:22:47: error: in=
struction requires: sve or sme
          "smopa za0.s, p0/m, p0/m, z0.b, z1.b\n\t"
                                                ^
  <inline asm>:8:2: note: instantiated into assembly here
          ptrue p0.s, vl4
          ^
  5 errors generated.

>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  tests/tcg/aarch64/sme-smopa-2.c   |  2 +-
>  tests/tcg/aarch64/Makefile.target | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/tests/tcg/aarch64/sme-smopa-2.c b/tests/tcg/aarch64/sme-smop=
a-2.c
> index c9f48c3bfca2..2c9707065992 100644
> --- a/tests/tcg/aarch64/sme-smopa-2.c
> +++ b/tests/tcg/aarch64/sme-smopa-2.c
> @@ -14,7 +14,7 @@ int main()
>      long svl;
>=20=20
>      /* Validate that we have a wide enough vector for 4 elements. */
> -    asm(".arch armv8-r+sme-i64\n\trdsvl %0, #1" : "=3Dr"(svl));
> +    asm("rdsvl %0, #1" : "=3Dr"(svl));
>      if (svl < 32) {
>          return 0;
>      }
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 70d728ae9af7..f53a1d615c21 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -27,7 +27,8 @@ config-cc.mak: Makefile
>  	    $(call cc-option,-march=3Darmv8.5-a,              CROSS_CC_HAS_ARMV=
8_5); \
>  	    $(call cc-option,-mbranch-protection=3Dstandard,  CROSS_CC_HAS_ARMV=
8_BTI); \
>  	    $(call cc-option,-march=3Darmv8.5-a+memtag,       CROSS_CC_HAS_ARMV=
8_MTE); \
> -	    $(call cc-option,-Wa$(COMMA)-march=3Darmv9-a+sme, CROSS_AS_HAS_ARMV=
9_SME)) 3> config-cc.mak
> +	    $(call cc-option,-Wa$(COMMA)-march=3Darmv9-a+sme, CROSS_AS_HAS_ARMV=
9_SME); \
> +	    $(call cc-option,-Wa$(COMMA)-march=3Darmv9-a+sme-i16i64, CROSS_AS_H=
AS_ARMV9_SME_I1664)) 3> config-cc.mak
>  -include config-cc.mak
>=20=20
>  ifneq ($(CROSS_CC_HAS_ARMV8_2),)
> @@ -68,7 +69,14 @@ endif
>=20=20
>  # SME Tests
>  ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
> -AARCH64_TESTS +=3D sme-outprod1 sme-smopa-1 sme-smopa-2
> +AARCH64_TESTS +=3D sme-outprod1 sme-smopa-1
> +sme-%: CFLAGS +=3D -march=3Darmv9-a+sme
> +endif
> +
> +# SME I16I64 Tests
> +ifneq ($(CROSS_AS_HAS_ARMV9_SME_I1664),)
> +AARCH64_TESTS +=3D sme-smopa-2
> +sme-smopa-2: CFLAGS +=3D -march=3Darmv9-a+sme-i16i64+sme
>  endif
>=20=20
>  # System Registers Tests

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

