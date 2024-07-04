Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26252C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTjl-0001u3-5K; Thu, 04 Jul 2024 17:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <giacomo.parmeggiani@gmail.com>)
 id 1sPTji-0001tb-Tw
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:11:26 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <giacomo.parmeggiani@gmail.com>)
 id 1sPTjg-00085G-Bi
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:11:26 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-36796a9b636so736079f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720127483; x=1720732283; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMwaWncjWvRYOpyY+8XQB9IVhPBKMXdU6EZFMxf21O8=;
 b=Lba4DcRwDtsrnfi9k7M0f/TUUY4cVKZOxyc/hTh9bDMumxQGiZR9oLwYUsybAlBjTs
 J7oVRwKeD9+w/NdjjawIwyxr0T1zxBYGfOPCjKShi9g7bANUx4DQ18LaUYCe/ExeoIW0
 eiBrsTG884JidRSIhrEFGVbK3vHstlDRuHsc9WBZOhPQhVA4T/hlsHm7QAU/13oegrE1
 Ozd+DYNZNMp1ds5dDHtZE9X/fyjV8axFyRbtyhdvHiXwuYBuiT+T6FePiW8mb2dhGfMA
 rEY3egZzcDdqOA3VAcX80b6sKuNASqOkeyhJwmrKkf6ovSukncOS+VmpKBs/wHsSyNDK
 BuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720127483; x=1720732283;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SMwaWncjWvRYOpyY+8XQB9IVhPBKMXdU6EZFMxf21O8=;
 b=DYsDyhtjv2gHTUgS9kJd4hufRD0BfmrTqY0W5Lulcii7b5LJGFuFdiv6xrKwPDIs4O
 rJPBky4gf25Q7Zx3jvYs9YlqzB/9jfd4pfGQ2AYK7mP1uak6OGLTadsdjcTvogduQniK
 oiue5R7/6hsOyjyFLMXl5RJ5kl5EU0NqnkhN6B8C5IbRXC8epdxz0ZWhp+tcZHwvWHuQ
 Gcjl60rx0iByS0m0Sa0sVnAMAph2Fds+zM5iWQQdAmp6UM9B7ScSqARzTZxpIYmukYPx
 AKY6T/ySNoMh5MiGlUuCVkA//0BGJf8x+s6XLTi1lR8ep7T62fTSlAIB5X1UBnZ+Vx9Q
 aLLw==
X-Gm-Message-State: AOJu0Yx802qC9Av9jz9xe3h8J0oSg0zihVazLDJZfuMFZ6C8sGYGinef
 0jzVo1IhhBI5dghoTMBAS8aiGKU1f8MzfJnS//XS40L87G4cDtGe
X-Google-Smtp-Source: AGHT+IGkn4xXtU8jNWN5lo4v3rIJUmxRoYq/T7sgO7nEZ1FuoPnseJwaFfTUJ0sclav/hsxC/hBLSw==
X-Received: by 2002:a5d:58f9:0:b0:367:8aa3:4366 with SMTP id
 ffacd0b85a97d-3679dd34c08mr2121938f8f.38.1720127481991; 
 Thu, 04 Jul 2024 14:11:21 -0700 (PDT)
Received: from smtpclient.apple ([213.55.241.196])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678e68a622sm6712091f8f.106.2024.07.04.14.11.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2024 14:11:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 7/7] crypto: Add test suite for ECDSA algorithm
From: Giacomo Parmeggiani <giacomo.parmeggiani@gmail.com>
In-Reply-To: <20220622091549.31115-8-helei.sig11@bytedance.com>
Date: Thu, 4 Jul 2024 23:11:20 +0200
Cc: qemu-devel@nongnu.org, berrange@redhat.com, f4bug@amsat.org,
 mst@redhat.com, pizhenwei@bytedance.com, jasowang@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D69E1A4-5694-44FC-B3FD-C6BE7EC68EA3@gmail.com>
References: <20220622091549.31115-1-helei.sig11@bytedance.com>
 <20220622091549.31115-8-helei.sig11@bytedance.com>
To: Lei He <helei.sig11@bytedance.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=giacomo.parmeggiani@gmail.com; helo=mail-wr1-x42b.google.com
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

PING
Hello Li He, maintainers,

Any chance to revive this thread?=20
The patch series no longer applies to latest QEMU and it would be a =
useful feature to have.

BR
Giacomo

> On 22 Jun 2022, at 11:15, Lei He <helei.sig11@bytedance.com> wrote:
>=20
> 1. add test suite for ecdsa algorithm.
> 2. use qcrypto_akcihper_max_xxx_len to help create buffers in
>=20
> Signed-off-by: lei he <helei.sig11@bytedance.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
> tests/unit/test-crypto-akcipher.c | 338 =
++++++++++++++++++++++++++++++++++++--
> 1 file changed, 323 insertions(+), 15 deletions(-)
>=20
> diff --git a/tests/unit/test-crypto-akcipher.c =
b/tests/unit/test-crypto-akcipher.c
> index 4f1f4214dd..414387cfb4 100644
> --- a/tests/unit/test-crypto-akcipher.c
> +++ b/tests/unit/test-crypto-akcipher.c
> @@ -314,12 +314,117 @@ static const uint8_t rsa2048_public_key[] =3D {
>    0xed, 0x02, 0x03, 0x01, 0x00, 0x01
> };
>=20
> +static const uint8_t ecdsa_p192_public_key[] =3D {
> +    0x04, 0xc4, 0x16, 0xb3, 0xff, 0xac, 0xd5, 0x87,
> +    0x98, 0xf7, 0xd9, 0x45, 0xfe, 0xd3, 0x5c, 0x17,
> +    0x9d, 0xb2, 0x36, 0x22, 0xcc, 0x07, 0xb3, 0x6d,
> +    0x3c, 0x4e, 0x04, 0x5f, 0xeb, 0xb6, 0x52, 0x58,
> +    0xfb, 0x36, 0x10, 0x52, 0xb7, 0x01, 0x62, 0x0e,
> +    0x94, 0x51, 0x1d, 0xe2, 0xef, 0x10, 0x82, 0x88,
> +    0x78,
> +};
> +
> +static const uint8_t ecdsa_p192_private_key[] =3D {
> +    0x30, 0x53, 0x02, 0x01, 0x01, 0x04, 0x18, 0xcb,
> +    0xc8, 0x86, 0x0e, 0x66, 0x3c, 0xf7, 0x5a, 0x44,
> +    0x13, 0xb8, 0xef, 0xea, 0x1d, 0x7b, 0xa6, 0x1c,
> +    0xda, 0xf4, 0x1b, 0xc7, 0x67, 0x6b, 0x35, 0xa1,
> +    0x34, 0x03, 0x32, 0x00, 0x04, 0xc4, 0x16, 0xb3,
> +    0xff, 0xac, 0xd5, 0x87, 0x98, 0xf7, 0xd9, 0x45,
> +    0xfe, 0xd3, 0x5c, 0x17, 0x9d, 0xb2, 0x36, 0x22,
> +    0xcc, 0x07, 0xb3, 0x6d, 0x3c, 0x4e, 0x04, 0x5f,
> +    0xeb, 0xb6, 0x52, 0x58, 0xfb, 0x36, 0x10, 0x52,
> +    0xb7, 0x01, 0x62, 0x0e, 0x94, 0x51, 0x1d, 0xe2,
> +    0xef, 0x10, 0x82, 0x88, 0x78,
> +};
> +
> +static const uint8_t ecdsa_p256_private_key[] =3D {
> +    0x30, 0x77, 0x02, 0x01, 0x01, 0x04, 0x20, 0xf6,
> +    0x92, 0xdd, 0x29, 0x1c, 0x6e, 0xef, 0xb6, 0xb2,
> +    0x73, 0x9f, 0x40, 0x1b, 0xb3, 0x2a, 0x28, 0xd2,
> +    0x37, 0xd6, 0x4a, 0x5b, 0xe4, 0x40, 0x4c, 0x6a,
> +    0x95, 0x99, 0xfa, 0xf7, 0x92, 0x49, 0xbe, 0xa0,
> +    0x0a, 0x06, 0x08, 0x2a, 0x86, 0x48, 0xce, 0x3d,
> +    0x03, 0x01, 0x07, 0xa1, 0x44, 0x03, 0x42, 0x00,
> +    0x04, 0xed, 0x42, 0x9c, 0x67, 0x79, 0xbe, 0x46,
> +    0x83, 0x88, 0x3e, 0x8c, 0xc1, 0x33, 0xf3, 0xc3,
> +    0xf6, 0x2c, 0xf3, 0x13, 0x6a, 0x00, 0xc2, 0xc9,
> +    0x3e, 0x87, 0x7f, 0x86, 0x39, 0xe6, 0xae, 0xe3,
> +    0xb9, 0xba, 0x2f, 0x58, 0x63, 0x32, 0x62, 0x62,
> +    0x54, 0x07, 0x27, 0xf9, 0x5a, 0x3a, 0xc7, 0x3a,
> +    0x6b, 0x5b, 0xbc, 0x0d, 0x33, 0xba, 0xbb, 0xd4,
> +    0xa3, 0xff, 0x4f, 0x9e, 0xdd, 0xf5, 0x59, 0xc0,
> +    0xf6,
> +};
> +
> +static const uint8_t ecdsa_p256_public_key[] =3D {
> +    0x04, 0xed, 0x42, 0x9c, 0x67, 0x79, 0xbe, 0x46,
> +    0x83, 0x88, 0x3e, 0x8c, 0xc1, 0x33, 0xf3, 0xc3,
> +    0xf6, 0x2c, 0xf3, 0x13, 0x6a, 0x00, 0xc2, 0xc9,
> +    0x3e, 0x87, 0x7f, 0x86, 0x39, 0xe6, 0xae, 0xe3,
> +    0xb9, 0xba, 0x2f, 0x58, 0x63, 0x32, 0x62, 0x62,
> +    0x54, 0x07, 0x27, 0xf9, 0x5a, 0x3a, 0xc7, 0x3a,
> +    0x6b, 0x5b, 0xbc, 0x0d, 0x33, 0xba, 0xbb, 0xd4,
> +    0xa3, 0xff, 0x4f, 0x9e, 0xdd, 0xf5, 0x59, 0xc0,
> +    0xf6,
> +};
> +
> +static const uint8_t ecdsa_p384_public_key[] =3D {
> +    0x04, 0xab, 0xd5, 0xf8, 0x87, 0x1d, 0x23, 0x9b,
> +    0x26, 0xb9, 0x57, 0x7e, 0x97, 0x78, 0x10, 0xcd,
> +    0x13, 0xe3, 0x98, 0x25, 0xa8, 0xd6, 0xab, 0x66,
> +    0x35, 0x26, 0x68, 0x8a, 0x0e, 0x49, 0xd9, 0x4a,
> +    0x91, 0x7d, 0x6c, 0x94, 0x06, 0x06, 0x99, 0xf1,
> +    0x8d, 0x2a, 0x25, 0x8d, 0xf9, 0xbf, 0x40, 0xfa,
> +    0xb7, 0xcb, 0xe1, 0x14, 0x22, 0x0a, 0xa7, 0xfb,
> +    0x0a, 0xb4, 0x02, 0x05, 0x8b, 0x98, 0xaa, 0x78,
> +    0xcd, 0x53, 0x00, 0x1e, 0xd1, 0x79, 0x6a, 0x5f,
> +    0x09, 0x01, 0x88, 0xb4, 0xbc, 0x32, 0x62, 0x83,
> +    0x92, 0x84, 0x2d, 0xc6, 0xf8, 0xda, 0xc4, 0x7f,
> +    0x10, 0xa3, 0x18, 0x1d, 0xae, 0x0d, 0xa4, 0x41,
> +    0x9f,
> +};
> +
> +static const uint8_t ecdsa_p384_private_key[] =3D {
> +    0x30, 0x81, 0x9b, 0x02, 0x01, 0x01, 0x04, 0x30,
> +    0xb6, 0x04, 0xef, 0xb1, 0x2c, 0x98, 0xdf, 0xcf,
> +    0xd4, 0x16, 0x31, 0xd4, 0x69, 0x0c, 0x27, 0x81,
> +    0x4a, 0xac, 0x1a, 0x83, 0x3c, 0xe4, 0xef, 0x65,
> +    0xe1, 0x7a, 0x6a, 0xc6, 0xd6, 0xf7, 0xea, 0x79,
> +    0xbe, 0xf1, 0x00, 0x3c, 0xdf, 0x6e, 0x9d, 0x10,
> +    0x22, 0x61, 0x1b, 0x11, 0xcf, 0x49, 0x6e, 0x62,
> +    0xa1, 0x64, 0x03, 0x62, 0x00, 0x04, 0xab, 0xd5,
> +    0xf8, 0x87, 0x1d, 0x23, 0x9b, 0x26, 0xb9, 0x57,
> +    0x7e, 0x97, 0x78, 0x10, 0xcd, 0x13, 0xe3, 0x98,
> +    0x25, 0xa8, 0xd6, 0xab, 0x66, 0x35, 0x26, 0x68,
> +    0x8a, 0x0e, 0x49, 0xd9, 0x4a, 0x91, 0x7d, 0x6c,
> +    0x94, 0x06, 0x06, 0x99, 0xf1, 0x8d, 0x2a, 0x25,
> +    0x8d, 0xf9, 0xbf, 0x40, 0xfa, 0xb7, 0xcb, 0xe1,
> +    0x14, 0x22, 0x0a, 0xa7, 0xfb, 0x0a, 0xb4, 0x02,
> +    0x05, 0x8b, 0x98, 0xaa, 0x78, 0xcd, 0x53, 0x00,
> +    0x1e, 0xd1, 0x79, 0x6a, 0x5f, 0x09, 0x01, 0x88,
> +    0xb4, 0xbc, 0x32, 0x62, 0x83, 0x92, 0x84, 0x2d,
> +    0xc6, 0xf8, 0xda, 0xc4, 0x7f, 0x10, 0xa3, 0x18,
> +    0x1d, 0xae, 0x0d, 0xa4, 0x41, 0x9f,
> +};
> +
> static const uint8_t test_sha1_dgst[] =3D {
>    0x3c, 0x05, 0x19, 0x34, 0x29, 0x19, 0xc7, 0xe0,
>    0x87, 0xb6, 0x24, 0xf9, 0x58, 0xac, 0xa4, 0xd4,
>    0xb2, 0xd9, 0x03, 0x9e,
> };
>=20
> +static const uint8_t test_sha512_dgst[] =3D {
> +    0x8b, 0x79, 0xc0, 0x3c, 0xcb, 0x15, 0x26, 0x51,
> +    0x50, 0xca, 0xb1, 0xa7, 0xf3, 0xf6, 0x1e, 0x0a,
> +    0xbb, 0x39, 0x7c, 0x97, 0x7f, 0xad, 0x9e, 0x51,
> +    0xb4, 0xa0, 0xb0, 0xd8, 0xd6, 0xb9, 0xd8, 0x81,
> +    0xac, 0x8a, 0xb3, 0x30, 0x07, 0xea, 0x6e, 0x63,
> +    0x2f, 0xda, 0x8f, 0x2c, 0x4b, 0xa0, 0xee, 0x9a,
> +    0xda, 0x32, 0x2d, 0x6c, 0xb1, 0x8b, 0xe2, 0xd8,
> +    0x79, 0x48, 0xd4, 0xf9, 0xb1, 0xfa, 0xf1, 0xa2,
> +};
> +
> static const uint8_t exp_signature_rsa2048_pkcs1[] =3D {
>    0x4e, 0x82, 0x56, 0x4c, 0x84, 0x66, 0xca, 0x1e,
>    0xc6, 0x92, 0x46, 0x20, 0x02, 0x6b, 0x64, 0x46,
> @@ -374,6 +479,82 @@ static const uint8_t =
exp_signature_rsa1024_pkcs1[] =3D {
>    0xab, 0x0d, 0xc6, 0x59, 0x1d, 0xc7, 0x33, 0x7b,
> };
>=20
> +static const uint8_t exp_signature_ecdsa_p192[] =3D {
> +    0x30, 0x35, 0x02, 0x19, 0x00, 0xba, 0xf7, 0xc0,
> +    0xc1, 0x7e, 0xf5, 0x69, 0xd5, 0xb7, 0x5d, 0x06,
> +    0xcb, 0x92, 0x28, 0x57, 0x52, 0x96, 0x9a, 0xdc,
> +    0xc9, 0xf9, 0xd5, 0x2c, 0x51, 0x02, 0x18, 0x26,
> +    0x21, 0x5d, 0x16, 0xba, 0xff, 0x19, 0x74, 0x56,
> +    0x8e, 0xdf, 0x51, 0x2b, 0x2c, 0xce, 0xc2, 0x7b,
> +    0x5b, 0x03, 0x10, 0x56, 0x57, 0x63, 0x47,
> +};
> +
> +static const uint8_t exp_signature_ecdsa_p192_sha512[] =3D {
> +    0x30, 0x35, 0x02, 0x19, 0x00, 0xbb, 0x03, 0x61,
> +    0x98, 0x28, 0xb3, 0x02, 0xca, 0x61, 0x08, 0xce,
> +    0x98, 0xfd, 0x57, 0x6e, 0x60, 0xfa, 0xa0, 0x06,
> +    0x03, 0xe2, 0xb2, 0x07, 0x22, 0x02, 0x18, 0x26,
> +    0xdc, 0x17, 0x3b, 0xf1, 0x88, 0x0a, 0x2c, 0xd5,
> +    0x51, 0x23, 0xbc, 0x83, 0x54, 0x05, 0x77, 0x28,
> +    0xd5, 0x84, 0xdf, 0x16, 0x4f, 0x50, 0x20,
> +};
> +
> +static const uint8_t exp_signature_ecdsa_p256[] =3D {
> +    0x30, 0x45, 0x02, 0x21, 0x00, 0xac, 0x09, 0xf3,
> +    0x32, 0xb6, 0xf6, 0x7e, 0x12, 0x4f, 0x68, 0xdb,
> +    0x10, 0x14, 0x61, 0xf6, 0x29, 0xbd, 0xdd, 0x72,
> +    0x9f, 0x81, 0xf8, 0x83, 0x8a, 0xf3, 0x29, 0x87,
> +    0x7b, 0xbb, 0xcf, 0xea, 0x64, 0x02, 0x20, 0x14,
> +    0xfc, 0x2e, 0x2f, 0x3e, 0x06, 0xb1, 0xd0, 0xbb,
> +    0x91, 0x44, 0xd5, 0x53, 0xb4, 0x72, 0xa1, 0x83,
> +    0xc7, 0x3a, 0xa8, 0xfc, 0x43, 0x1b, 0x2e, 0xbb,
> +    0xb0, 0xe9, 0xef, 0x0b, 0x03, 0x32, 0x74,
> +};
> +
> +static const uint8_t exp_signature_ecdsa_p256_sha512[] =3D {
> +    0x30, 0x46, 0x02, 0x21, 0x00, 0xe0, 0x48, 0x74,
> +    0x65, 0xaa, 0x63, 0x97, 0x68, 0x45, 0x68, 0xfa,
> +    0xec, 0x51, 0x64, 0xfe, 0x09, 0xc7, 0x5c, 0x65,
> +    0x5d, 0x93, 0x04, 0x17, 0x23, 0xbe, 0x1b, 0x2f,
> +    0x89, 0x5e, 0x02, 0xcd, 0x55, 0x02, 0x21, 0x00,
> +    0xe9, 0x24, 0xbd, 0x7a, 0xbd, 0x05, 0x89, 0x04,
> +    0x92, 0x2d, 0x67, 0x8d, 0x66, 0xa8, 0x9d, 0x7b,
> +    0xb1, 0x5b, 0xae, 0xd1, 0xd4, 0x7b, 0xe8, 0x72,
> +    0xe9, 0xd9, 0x45, 0xfd, 0xd3, 0x76, 0xbe, 0xfb,
> +};
> +
> +static const uint8_t exp_signature_ecdsa_p384[] =3D {
> +    0x30, 0x64, 0x02, 0x30, 0x3c, 0x79, 0x7f, 0x5a,
> +    0x91, 0x08, 0x79, 0xde, 0x6e, 0x03, 0x19, 0x39,
> +    0xcb, 0x94, 0x9c, 0xc6, 0x09, 0x12, 0xfa, 0xbd,
> +    0xa8, 0x35, 0x5e, 0x3f, 0x74, 0x05, 0x12, 0xd1,
> +    0x8e, 0xd9, 0x3c, 0x79, 0x9d, 0x7c, 0x1a, 0xae,
> +    0x96, 0x05, 0x0e, 0x35, 0x21, 0x73, 0xd8, 0xfe,
> +    0x1b, 0x43, 0x06, 0xb9, 0x02, 0x30, 0x11, 0xdf,
> +    0xa7, 0xba, 0x70, 0x84, 0x4b, 0x74, 0xab, 0x1e,
> +    0x9e, 0x6a, 0xc1, 0x46, 0xe3, 0x98, 0x0a, 0x25,
> +    0x82, 0xf5, 0xff, 0xb5, 0x6f, 0x04, 0xda, 0xc3,
> +    0xfd, 0x3e, 0xea, 0x96, 0x03, 0x0c, 0x22, 0xf2,
> +    0xda, 0x86, 0xeb, 0x91, 0x2f, 0x36, 0x13, 0xba,
> +    0x37, 0xcd, 0xe7, 0x91, 0x85, 0xf3,
> +};
> +
> +static const uint8_t exp_signature_ecdsa_p384_sha512[] =3D {
> +    0x30, 0x64, 0x02, 0x30, 0x04, 0xa2, 0x3e, 0xb0,
> +    0xc0, 0x1f, 0xa0, 0xbb, 0x19, 0x60, 0x56, 0x04,
> +    0x11, 0x95, 0xa9, 0x34, 0x0d, 0x0a, 0x80, 0x7f,
> +    0x5b, 0x08, 0xb3, 0xf9, 0x33, 0xc2, 0xd4, 0x6d,
> +    0x23, 0x0a, 0xed, 0x29, 0xca, 0x93, 0xba, 0x8c,
> +    0xee, 0xbf, 0x2d, 0xb8, 0x45, 0xda, 0xaf, 0x2f,
> +    0x2e, 0x5b, 0xda, 0x62, 0x02, 0x30, 0x2e, 0x6f,
> +    0xa4, 0x24, 0xf7, 0xcf, 0x58, 0xc3, 0xca, 0x29,
> +    0xd8, 0x0b, 0xe7, 0xb5, 0x88, 0xeb, 0x81, 0xbe,
> +    0x50, 0x2a, 0xd3, 0x37, 0xeb, 0x23, 0xcc, 0x55,
> +    0x6f, 0xf5, 0x02, 0xb9, 0xf9, 0xa1, 0x58, 0x2a,
> +    0x35, 0x00, 0xe9, 0x2f, 0xc8, 0x73, 0x5c, 0x27,
> +    0xbc, 0x4b, 0x8c, 0x0e, 0x4d, 0xde,
> +};
> +
> static const uint8_t test_plaintext[] =3D {
>    0x00, 0x44, 0xbc, 0x6f, 0x77, 0xfb, 0xe2, 0xa4,
>    0x98, 0x9e, 0xf5, 0x33, 0xa0, 0xbd, 0x81, 0xb9,
> @@ -870,7 +1051,114 @@ static QCryptoAkCipherTestData =
akcipher_test_data[] =3D {
>        .signature =3D exp_signature_rsa2048_pkcs1,
>        .slen =3D sizeof(exp_signature_rsa2048_pkcs1),
>    },
> +    {
> +        .path =3D "/crypto/akcipher/ecdsa-nist-p192-with-sha1",
> +        .opt =3D {
> +            .alg =3D QCRYPTO_AKCIPHER_ALG_ECDSA,
> +            .u.ecdsa =3D {
> +                .curve_id =3D QCRYPTO_CURVE_ID_NIST_P192,
> +            },
> +        },
> +        .pub_key =3D ecdsa_p192_public_key,
> +        .pub_key_len =3D sizeof(ecdsa_p192_public_key),
> +        .priv_key =3D ecdsa_p192_private_key,
> +        .priv_key_len =3D sizeof(ecdsa_p192_private_key),
> +
> +        .dgst =3D test_sha1_dgst,
> +        .dlen =3D sizeof(test_sha1_dgst),
> +        .signature =3D exp_signature_ecdsa_p192,
> +        .slen =3D sizeof(exp_signature_ecdsa_p192),
> +    },
> +    {
> +        .path =3D "/crypto/akcipher/ecdsa-nist-p192-with-sha512",
> +        .opt =3D {
> +            .alg =3D QCRYPTO_AKCIPHER_ALG_ECDSA,
> +            .u.ecdsa =3D {
> +                .curve_id =3D QCRYPTO_CURVE_ID_NIST_P192,
> +            },
> +        },
> +        .pub_key =3D ecdsa_p192_public_key,
> +        .pub_key_len =3D sizeof(ecdsa_p192_public_key),
> +        .priv_key =3D ecdsa_p192_private_key,
> +        .priv_key_len =3D sizeof(ecdsa_p192_private_key),
> +
> +        .dgst =3D test_sha512_dgst,
> +        .dlen =3D sizeof(test_sha512_dgst),
> +        .signature =3D exp_signature_ecdsa_p192_sha512,
> +        .slen =3D sizeof(exp_signature_ecdsa_p192_sha512),
> +    },
> +    {
> +        .path =3D "/crypto/akcipher/ecdsa-nist-p256-with-sha1",
> +        .opt =3D {
> +            .alg =3D QCRYPTO_AKCIPHER_ALG_ECDSA,
> +            .u.ecdsa =3D {
> +                .curve_id =3D QCRYPTO_CURVE_ID_NIST_P256,
> +            },
> +        },
> +        .pub_key =3D ecdsa_p256_public_key,
> +        .pub_key_len =3D sizeof(ecdsa_p256_public_key),
> +        .priv_key =3D ecdsa_p256_private_key,
> +        .priv_key_len =3D sizeof(ecdsa_p256_private_key),
>=20
> +        .dgst =3D test_sha1_dgst,
> +        .dlen =3D sizeof(test_sha1_dgst),
> +        .signature =3D exp_signature_ecdsa_p256,
> +        .slen =3D sizeof(exp_signature_ecdsa_p256),
> +    },
> +    {
> +        .path =3D "/crypto/akcipher/ecdsa-nist-p256-with-sha512",
> +        .opt =3D {
> +            .alg =3D QCRYPTO_AKCIPHER_ALG_ECDSA,
> +            .u.ecdsa =3D {
> +                .curve_id =3D QCRYPTO_CURVE_ID_NIST_P256,
> +            },
> +        },
> +        .pub_key =3D ecdsa_p256_public_key,
> +        .pub_key_len =3D sizeof(ecdsa_p256_public_key),
> +        .priv_key =3D ecdsa_p256_private_key,
> +        .priv_key_len =3D sizeof(ecdsa_p256_private_key),
> +
> +        .dgst =3D test_sha512_dgst,
> +        .dlen =3D sizeof(test_sha512_dgst),
> +        .signature =3D exp_signature_ecdsa_p256_sha512,
> +        .slen =3D sizeof(exp_signature_ecdsa_p256_sha512),
> +    },
> +    {
> +        .path =3D "/crypto/akcipher/ecdsa-nist-p384-with-sha1",
> +        .opt =3D {
> +            .alg =3D QCRYPTO_AKCIPHER_ALG_ECDSA,
> +            .u.ecdsa =3D {
> +                .curve_id =3D QCRYPTO_CURVE_ID_NIST_P384,
> +            },
> +        },
> +        .pub_key =3D ecdsa_p384_public_key,
> +        .pub_key_len =3D sizeof(ecdsa_p384_public_key),
> +        .priv_key =3D ecdsa_p384_private_key,
> +        .priv_key_len =3D sizeof(ecdsa_p384_private_key),
> +
> +        .dgst =3D test_sha1_dgst,
> +        .dlen =3D sizeof(test_sha1_dgst),
> +        .signature =3D exp_signature_ecdsa_p384,
> +        .slen =3D sizeof(exp_signature_ecdsa_p384),
> +    },
> +    {
> +        .path =3D "/crypto/akcipher/ecdsa-nist-p384-with-sha512",
> +        .opt =3D {
> +            .alg =3D QCRYPTO_AKCIPHER_ALG_ECDSA,
> +            .u.ecdsa =3D {
> +                .curve_id =3D QCRYPTO_CURVE_ID_NIST_P384,
> +            },
> +        },
> +        .pub_key =3D ecdsa_p384_public_key,
> +        .pub_key_len =3D sizeof(ecdsa_p384_public_key),
> +        .priv_key =3D ecdsa_p384_private_key,
> +        .priv_key_len =3D sizeof(ecdsa_p384_private_key),
> +
> +        .dgst =3D test_sha512_dgst,
> +        .dlen =3D sizeof(test_sha512_dgst),
> +        .signature =3D exp_signature_ecdsa_p384_sha512,
> +        .slen =3D sizeof(exp_signature_ecdsa_p384_sha512),
> +    },
> };
>=20
> static void test_akcipher(const void *opaque)
> @@ -879,6 +1167,8 @@ static void test_akcipher(const void *opaque)
>    g_autofree uint8_t *plaintext =3D NULL;
>    g_autofree uint8_t *ciphertext =3D NULL;
>    g_autofree uint8_t *signature =3D NULL;
> +    int signature_len, ciphertext_len, plaintext_len;
> +    int max_plen, max_slen, max_clen;
>    QCryptoAkCipher *pub_key, *priv_key;
>=20
>    if (!qcrypto_akcipher_supports((QCryptoAkCipherOptions =
*)&data->opt)) {
> @@ -894,32 +1184,41 @@ static void test_akcipher(const void *opaque)
>                                    data->priv_key, data->priv_key_len,
>                                    &error_abort);
>    g_assert(priv_key !=3D NULL);
> +    max_plen =3D qcrypto_akcipher_max_plaintext_len(pub_key);
> +    max_clen =3D qcrypto_akcipher_max_plaintext_len(pub_key);
> +    max_slen =3D qcrypto_akcipher_max_signature_len(priv_key);
>=20
>    if (data->plaintext !=3D NULL) {
>=20
> -        ciphertext =3D g_new0(uint8_t, data->clen);
> -        g_assert(qcrypto_akcipher_encrypt(pub_key, data->plaintext, =
data->plen,
> -                                          ciphertext, data->clen,
> -                                          &error_abort) > 0);
> +        ciphertext =3D g_new0(uint8_t, max_clen);
> +        ciphertext_len =3D qcrypto_akcipher_encrypt(pub_key,
> +                                                  data->plaintext, =
data->plen,
> +                                                  ciphertext, =
max_clen,
> +                                                  &error_abort);
> +        g_assert(ciphertext_len > 0);
>=20
>        /**
>         * In the asymmetric encryption algorithms, the ciphertext =
generated
>         * each time may be different, here only compare the decrypted
>         * plaintext
>         */
> -        plaintext =3D g_new0(uint8_t, data->clen);
> -        g_assert(qcrypto_akcipher_decrypt(priv_key, ciphertext,
> -                                          data->clen, plaintext,
> -                                          data->plen,
> -                                          &error_abort) =3D=3D =
data->plen);
> +        plaintext =3D g_new0(uint8_t, max_plen);
> +        plaintext_len =3D qcrypto_akcipher_decrypt(priv_key,
> +                                                 ciphertext, =
ciphertext_len,
> +                                                 plaintext, max_plen,
> +                                                 &error_abort);
> +        g_assert(plaintext_len =3D=3D data->plen);
>        g_assert(!memcmp(plaintext, data->plaintext, data->plen));
>    }
>=20
>    if (data->signature !=3D NULL) {
> -        signature =3D g_new(uint8_t, data->slen);
> -        g_assert(qcrypto_akcipher_sign(priv_key, data->dgst, =
data->dlen,
> -                                       signature, data->slen,
> -                                       &error_abort) > 0);
> +        signature =3D g_new(uint8_t, max_slen);
> +        signature_len =3D qcrypto_akcipher_sign(priv_key,
> +                                              data->dgst, data->dlen,
> +                                              signature, max_slen,
> +                                              &error_abort);
> +        g_assert(signature_len > 0);
> +
>        /**
>         * The signature generated each time may be different, here =
only check
>         * the verification.
> @@ -927,12 +1226,21 @@ static void test_akcipher(const void *opaque)
>        g_assert(qcrypto_akcipher_verify(pub_key, data->signature, =
data->slen,
>                                         data->dgst, data->dlen,
>                                         &error_abort) =3D=3D 0);
> -        g_assert(qcrypto_akcipher_verify(pub_key, signature, =
data->slen,
> +        g_assert(qcrypto_akcipher_verify(pub_key, signature, =
signature_len,
> +                                         data->dgst, data->dlen,
> +                                         &error_abort) =3D=3D 0);
> +
> +        g_assert(qcrypto_akcipher_verify(priv_key, data->signature, =
data->slen,
> +                                         data->dgst, data->dlen,
> +                                         &error_abort) =3D=3D 0);
> +        g_assert(qcrypto_akcipher_verify(priv_key, signature, =
signature_len,
>                                         data->dgst, data->dlen,
>                                         &error_abort) =3D=3D 0);
>        ++signature[0];
>        /* Here error should be ignored */
> -        g_assert(qcrypto_akcipher_verify(pub_key, signature, =
data->slen,
> +        g_assert(qcrypto_akcipher_verify(pub_key, signature, =
signature_len,
> +                                         data->dgst, data->dlen, =
NULL) !=3D 0);
> +        g_assert(qcrypto_akcipher_verify(priv_key, signature, =
signature_len,
>                                         data->dgst, data->dlen, NULL) =
!=3D 0);
>    }
>=20
> --=20
> 2.11.0
>=20


