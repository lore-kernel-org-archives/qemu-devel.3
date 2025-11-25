Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492B2D0E6F8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNuTI-00051w-Bn; Tue, 25 Nov 2025 09:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNuTH-000516-1A
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:56:47 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNuT3-0008PC-6R
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:56:46 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-429c7869704so4710907f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 06:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764082590; x=1764687390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBzliVcewr6XXBxV4JKoQahBhW5fi0fkR1iBbtWQl6g=;
 b=suQPZ2IJUOSWrjgto/5jbuQ7QVOqj8lTV2iKsnvk3NP6HzE0w8opmtUHJJXbwpvxQT
 yryYCwyR3+pnjXKq8yQeWXz/JfIA6LWx1ahzdFyS5zJMu+IGC0c6JE8GKfTqvlGopGOz
 n10fwdq/CEoX+uL0vQIHeVZcimDgJUt1J3iNJYbZ7C9sY1kmUeQqbrmhRF8jeacVWaaE
 pnvV54WxHtUfv0j8MnYoR29j4pB35jB8X7+pdEDXkiWtbfWzYjtAFXQv6VMEm1YuAyfx
 PfYGSdo5dvzvDLFgaBWmONNt5mJSV2ep3F4rldDKZlJP9Yd5bVEVX/lToSO/3E4Uiv1y
 jD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764082591; x=1764687391;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gBzliVcewr6XXBxV4JKoQahBhW5fi0fkR1iBbtWQl6g=;
 b=r90G21S2muA8V+qhhas+wiym959UC2oH27EBa30WlrafsZ/8ooJiZnlcoXqqtRbdTq
 RpWf5viBkEQXfF1YwebhuYUE9Khg+8cP7/Ea5TZwdvvQLKmPBIqtGCivwj5/dSYDDtrv
 SREKp3/daLOayt3Ztd+66MGRn6OhbH1vAPqDbdMHSy4bobgBVBB4O71glvhgB1QZoLjY
 yJ0uVzSUf+yW+bcb2qvkh38CEPMDL5V9jKf+rGPAbFvQ3FrSWEWd9YcBcrJEMLH/PBmC
 ayrtVLS9f62Xph2Vgwkn0Ea+i6Qjp162/AtH+OVu8Yv94kdBjwR2GWxyKRbV8RhVJCsm
 FNQQ==
X-Gm-Message-State: AOJu0Yzdai26Vs9b0ebPsU7rBEj43wCRQwe0/frXd0RCxqNUCTX/KZiG
 AiJNw9QPgQvc9nQ0gUpLZNGgBn/Vhhhc17CIzDzzJxgHlceDmq72/IbsI1bmV5O6duQ=
X-Gm-Gg: ASbGncvTd908pQsUVja9zss5tFR79PvzQ8INzzF/2uWJzxXgyZAcjIbLs6NJxVJNQGm
 b8QNVRlHnTbCrmDmnjQdiOLJUo2yAb532K7y0CXyjQ/iXaZYsKiPepj1uJb//Gq+Lbx3MA9VE6+
 tsyJN/5BXbdh3QoH2vHNd1sJmge5wwID7DvePyBgbVI7d0XW3/uOhIYIIiotYr3zbRB2nR/2ClR
 CQPTBNs0p5mm0PCJnRkOMiWi+giGu1nURou91hxpzizcCIOh8tsbOjIm9Qjcb7+pKURTVbO/Ab5
 2+DIshsmnhy5LYyBm31fEEe/DddK+rNiOi1Shpb4uKvPac7Zfe59zvcO4Yx9miKIx6bvP6a7ziV
 8iGTLX1/++DmrgwG2nWveIhmnAWjhKakvlRMcvHnSkM2psxPQMtdSUvRwFd32d1b4vSvj1Skbzs
 /bA81mtlq5isDlXlr9vKBJTA==
X-Google-Smtp-Source: AGHT+IGKTzU4IfszDhLjgz9ywOW3KZY90dXL6Cg2pkffHhu+2bqgAdcOmJJxuGRUQGObXj6b4Fv9uA==
X-Received: by 2002:a05:6000:2404:b0:429:8d0f:ebf with SMTP id
 ffacd0b85a97d-42e0f34ec4bmr3225443f8f.42.1764082590551; 
 Tue, 25 Nov 2025 06:56:30 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb919bsm34596099f8f.34.2025.11.25.06.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:56:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4859C5F7EF;
 Tue, 25 Nov 2025 14:56:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 2/3] docs/system/generic-loader: Don't mention QemuOpts
 implementation detail
In-Reply-To: <20251125143141.216056-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 25 Nov 2025 14:31:40 +0000")
References: <20251125143141.216056-1-peter.maydell@linaro.org>
 <20251125143141.216056-3-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 25 Nov 2025 14:56:29 +0000
Message-ID: <87a50a6u02.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> We currently say "All values are parsed using the standard QemuOpts
> parsing".  This doesn't tell the user anything useful because we
> don't mention QemuOpts anywhere else in the docs.  What we're really
> trying to tell the user is what we mention afterwards: that the
> values are decimal, and you need an 0x prefix for hex.  How we
> achieve it is an implementation detail the user doesn't need to know.
>
> Drop the explicit mention of QemuOpts; this in passing removes a typo
> "QemuOps" that we made in one place. Put the informative note
> more closely associated with the <addr> suboption which is the
> one that users might most reasonably assume to default to hex.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/generic-loader.rst | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loader.=
rst
> index 3ac39cfbbe2..d5416711e93 100644
> --- a/docs/system/generic-loader.rst
> +++ b/docs/system/generic-loader.rst
> @@ -21,6 +21,10 @@ can be done by following the syntax below::
>  ``<addr>``
>    The address to store the data in.
>=20=20
> +  Note that as usual with QEMU numeric option values, the default is to
> +  treat the argument as decimal.  To specify a value in hex, prefix it
> +  with '0x'.
> +
>  ``<data>``
>    The value to be written to the address. The maximum size of the data
>    is 8 bytes.
> @@ -37,10 +41,6 @@ can be done by following the syntax below::
>    The number of the CPU's address space where the data should be
>    loaded. If not specified the address space of the first CPU is used.
>=20=20
> -All values are parsed using the standard QemuOps parsing. This allows th=
e user
> -to specify any values in any format supported. By default the values
> -will be parsed as decimal. To use hex values the user should prefix the =
number
> -with a '0x'.
>=20=20
>  An example of loading value 0x8000000e to address 0xfd1a0104 is::
>=20=20
> @@ -57,14 +57,13 @@ can be done by following the syntax below::
>  ``<addr>``
>    The value to use as the CPU's PC.
>=20=20
> +  Note that as usual with QEMU numeric option values, the default is to
> +  treat the argument as decimal.  To specify a value in hex, prefix it
> +  with '0x'.
> +
>  ``<cpu-num>``
>    The number of the CPU whose PC should be set to the specified value.
>=20=20
> -All values are parsed using the standard QemuOpts parsing. This allows t=
he user
> -to specify any values in any format supported. By default the values
> -will be parsed as decimal. To use hex values the user should prefix the =
number
> -with a '0x'.
> -
>  An example of setting CPU 0's PC to 0x8000 is::
>=20=20
>      -device loader,addr=3D0x8000,cpu-num=3D0
> @@ -85,6 +84,10 @@ shown below:
>    The memory address where the file should be loaded. This is required
>    for raw images and ignored for non-raw files.
>=20=20
> +  Note that as usual with QEMU numeric option values, the default is to
> +  treat the argument as decimal.  To specify a value in hex, prefix it
> +  with '0x'.
> +
>  ``<cpu-num>``
>    This specifies the CPU that should be used. This is an
>    optional argument with two effects:
> @@ -104,10 +107,6 @@ shown below:
>    This can be used to load supported executable formats as if they
>    were raw.
>=20=20
> -All values are parsed using the standard QemuOpts parsing. This allows t=
he user
> -to specify any values in any format supported. By default the values
> -will be parsed as decimal. To use hex values the user should prefix the =
number
> -with a '0x'.
>=20=20
>  An example of loading an ELF file which CPU0 will boot is shown below::

This isn't wrong but I wonder if there is a way to avoid so much
repetition? Is there a way to have common footnotes we could apply
anywhere we are discussing QEMU's numeric parsing?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

