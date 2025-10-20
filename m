Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE09CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAshe-0008WK-HI; Mon, 20 Oct 2025 12:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAshc-0008Ve-7H
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:25:44 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAshV-0001Vy-Dg
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:25:43 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b6bbfc57b75so132854666b.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760977533; x=1761582333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQuPshMzkIrvhRsLr4+UpwbIXsxCxAErajYfnhGwsSQ=;
 b=Zf412BXOKWvx8znIYEGsKedXDBmSDPI8MWmNbnsNhbtJCZYiA6y3XGXHFsFlWCgD0l
 AWPZs/5e7Z5BbZv6XUEILOihOm3MP0+WvPHatp5DgXzoKuKYgtW2KxX6QZm6uFUGRRqs
 YvPKYlfwn2iamE4LLGB+x9Y5hvxkfK25huyXY71ZAXhLgLo2VLyhsIKNa7Pw7qp98C7v
 I5g6ox3njjMxl6N8mKD6bPyVaq6C2wGVlpHohNW04EFO9eqtwa2dwmKK09KEO+c/sorC
 dcJWpg37iVlTPqgPNHKJ8+zlVB/x2lDmN+4Alc1j1j0UeiORjQQ8Smjhap++d++LlLbc
 XCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760977533; x=1761582333;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bQuPshMzkIrvhRsLr4+UpwbIXsxCxAErajYfnhGwsSQ=;
 b=dR2DfzO1y5q3gz7UQcLGdGMFzkxO1Np/eQX/G0ZHaJfS0HTbjEpuxmnbZJuD30hrZU
 jSXXZGNsLc1xB2KwfIjRjTM2xjp2kIbEwLHt8av15t3PZ0/3k8xr3wVgNUNxzTveVROg
 b3KW6ebFnnv4hHasxYRHKRX2ga/ZTCbnPFTjAXm/Qy9lY+oM1I+C35fYkDF/W5V/hDc0
 bH31kC5tO+EiwwzC4TzYulEwevY38Ool8PhsqbeFgedMXq4hT0s17Ld6mMM+fYBYEnyc
 gYjeicYbqQRkTdkf6cogenvHSiShFSFNl+Szv06ui2qIbR0Nr+LDTvguWfLbslFPFA5r
 H/Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZIQOYa1+e0GET4Gd/hiPC4rJZdz4FFxmJPEN/M9cW3XH4NzcSLQq+Irhuyp1qDcrvx5CsAF98MADP@nongnu.org
X-Gm-Message-State: AOJu0YyKGEsdf5OAr1cPC69IfLe5OGLqFBXcxFZhqdGcflAPgf0iqxg2
 3D0rTp2LjtDFBSAwtJf5OXquZEMfNJFYtZusqya8np76N1P+jb5CWZZtNTaVnpP8xz0=
X-Gm-Gg: ASbGncuDC8+zaGedwM91cc2IHdKP6iXtD3NTXXfAIb9N2XYANOHfkmBAuPIYOFwdi8a
 9TRsUwMwS4KHVsXEuUMT0hXlao4HseL9Ye8B4gwxYPhUbKMt1kZJrIukDt4slvz9eoEV7TuvZm1
 ygjIrfuUTNfO54ZGk/QhfMwnnbYVenlop3ExJX1pmep0Qqn4HMUv3UQaMwmDWUlWByiyA8c38zp
 4u8eRn68+jF4yBjOtgBgUUk/NChSSOI3hpdCKB1BqtO8JNI4fBV0W6mPkTHdhZQcanflv8I545p
 gn8yCeVfw268Hmxy1oK2WUWMQj42Ndh9fHSU2qahvDoBvWUZMLRlIFuIjMlCI5HUmbWgyqE4IqW
 Vl4QRMxVgRrJUCD2fcztY1AC4YckEf1mSyTJ0oU4L6tK3WtKdcRFt2FF3yJ+n2NPsOb/s+sCv7b
 1f
X-Google-Smtp-Source: AGHT+IEek5rrH9Up/JZnx5fDgUl6U/1F/fO1q3vBA6k/PYZXdO6Rxy//UtWDkio5q09Dsg1CBZ7/0g==
X-Received: by 2002:a17:907:868f:b0:b41:c602:c75d with SMTP id
 a640c23a62f3a-b645f7ef255mr1738972466b.31.1760977533289; 
 Mon, 20 Oct 2025 09:25:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65ebc42963sm836563666b.77.2025.10.20.09.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 09:25:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C4A9D5F83E;
 Mon, 20 Oct 2025 17:25:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  Luc Michel
 <lmichel@kalray.eu>
Subject: Re: [PATCH 2/3] semihosting: Fix GDB File-I/O FLEN
In-Reply-To: <20251017213529.998267-3-sean.anderson@linux.dev> (Sean
 Anderson's message of "Fri, 17 Oct 2025 17:35:28 -0400")
References: <20251017213529.998267-1-sean.anderson@linux.dev>
 <20251017213529.998267-3-sean.anderson@linux.dev>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 20 Oct 2025 17:25:31 +0100
Message-ID: <87jz0p7d6s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Sean Anderson <sean.anderson@linux.dev> writes:

> fstat returns 0 on success and -1 on error. Since we have already
> checked for error, ret must be zero. Therefore, any call to fstat on a
> non-empty file will return -1/EOVERFLOW.
>
> Restore the original logic that just did a byteswap. I don't really know
> what the intention of the fixed commit was.
>
> Fixes: a6300ed6b7 ("semihosting: Split out semihost_sys_flen")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
>  semihosting/arm-compat-semi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index 6100126796..c5a07cb947 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -316,10 +316,7 @@ common_semi_flen_fstat_cb(CPUState *cs, uint64_t ret=
, int err)
>                                  &size, 8, 0)) {
>              ret =3D -1, err =3D EFAULT;
>          } else {
> -            size =3D be64_to_cpu(size);
> -            if (ret !=3D size) {
> -                ret =3D -1, err =3D EOVERFLOW;
> -            }
> +            ret =3D be64_to_cpu(size);
>          }
>      }
>      common_semi_cb(cs, ret, err);

well this sent me on a rat hole to figure out the be64_to_cpu. Really I
think the callback function should be renamed to gdb_semi_flen_fstat_cb
because it is only called for the GDB File I/O implementation.

Otherwise the logic looks fine:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

