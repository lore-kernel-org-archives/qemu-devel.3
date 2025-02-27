Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA0BC021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 01:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnT9A-0008WK-Ef; Wed, 26 Feb 2025 20:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnT98-0008Vo-Ex; Wed, 26 Feb 2025 20:57:06 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnT96-00062p-Lj; Wed, 26 Feb 2025 20:57:05 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22349dc31bcso6247685ad.3; 
 Wed, 26 Feb 2025 17:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740621423; x=1741226223; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Arub7aZlZ6pXMCkbhrl0oQ4a3TKW5SrYggBPelLo6j0=;
 b=k7xwUqU00GxeABhpyxTJ9ii9y5PkE/8MFR5DaJ/JUvSlQWD8o+H5Gq3LUV7OAEE+KK
 A5ypdH+mhx8loHnYn/aZH4hrl9ffKJpl6ze5qkbzPp74LmclwrYiKMx34YzGfHtQl2KX
 XKijvDHw8JbDuUyYGxQMJ9H0Xi+zZ8TeYIX2shvcUkKVie6kvMKYP4jRcW6huQItHq+w
 1hTrw1SJiqI2Nah6rO/HPiARSCZY+qwCW/74xIj+djgPCbcK9Q8zgVhVZo+c7gvnvjJm
 NAl39u7DOpM1uCwyaMgpVwtwRrJZ3Kvi+zp2z/WPBbZC3LhgGKw69rj8G2x1Z8UA6O3Q
 uw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740621423; x=1741226223;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Arub7aZlZ6pXMCkbhrl0oQ4a3TKW5SrYggBPelLo6j0=;
 b=ozkgQIH5D7uS6IFTY1DYDGjmLg7yL/AhnFL8zUhFpkaVy7fnSWmWqQooPPrnEB/wo4
 BzgNKkmP5GumWMGNq+6x4lDyq8k+jodZqmogzmQVKWxOQnQ50WsU82EeeyM7Znl2k8VW
 Zr9LwwxALsiGUbkJzVTdYxcp7bTbRhbz+WqC+vTZ37P9bxkLAuP54K1VLFK7lF5TYIm4
 6TIFKa+i9B47K4kMpiv8z8PmXPKgvLGe4a34i91V86vu9/YMjfZQT++qHhvr7HsGRu6w
 2ADF0crOX8fuBdvNhY2FvWPiexLFx3ZPfm66y2HVIEQWGM567qUwHSq4siv3tdCMZb4g
 wr7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIL0+42zgLvC5b8l70b4ztNonYX6esYcUH4wjklsYIQ6CYjIuA6R6XNU+93FTeRLwiDpXoRauqEvie@nongnu.org
X-Gm-Message-State: AOJu0YwMq70dxlbTDPYW9RKLDTfBIP33j+/de8R+x40+wg5Jf/I/KhBe
 2Koenh8GViXQzxGMa/TgJV38W1D4roAPr2CaMcbI+QZPM9+zH4UglPrRMw==
X-Gm-Gg: ASbGncsRHm9UPiGCTc2rNMi7amrBbF3T+P2p9gYaHGQdsTWIywECasdcOHrGlM4gMBo
 OSlqLlJar2SMlICYqWynSPKSAMI86kH0uuktGeRs4XpEy8RfwmdYUzyBv21jGI3zHsbfHxnkght
 iwSc2ynPWc5SoLH213LpggObja/ohJqjp6aqwkZWquJfvfkkmg5D6Mnd08Lqmy2iDnk02dVaQXu
 KNFngY73Uh6ualKVTlojrX4qAL4+fhOzRbcQlLUljJ/itg5w8c7n25GGsLH89lE69O/L5FKaEEf
 CU4DsLH20HT6Rdc/gA==
X-Google-Smtp-Source: AGHT+IFx/vukSs3zKOECV/7bWYocnyyXh1Nq1c508b1Rzt8vJcIZzDnN5r3dlFLfaqxwz//WH42M+Q==
X-Received: by 2002:a17:902:ce88:b0:21f:4c8b:c511 with SMTP id
 d9443c01a7336-221a1191b71mr381902545ad.33.1740621422782; 
 Wed, 26 Feb 2025 17:57:02 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501d2732sm3394055ad.23.2025.02.26.17.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 17:57:02 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 11:56:54 +1000
Message-Id: <D82USMP2EKXB.1LFUGZQZKVFL2@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@linux.ibm.com>, <chalapathi.v@ibm.com>, <saif.abrar@linux.ibm.com>,
 <dantan@linux.vnet.ibm.com>, <milesg@linux.ibm.com>, <philmd@linaro.org>,
 <alistair@alistair23.me>
Subject: Re: [PATCH v5 4/4] hw/ssi/pnv_spi: Put a limit to RDR match failures
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
 <20250103161824.22469-5-chalapathi.v@linux.ibm.com>
In-Reply-To: <20250103161824.22469-5-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Sat Jan 4, 2025 at 2:18 AM AEST, Chalapathi V wrote:
> There is a possibility that SPI controller can get into loop due to indef=
inite
> RDR match failures. Hence put a limit to failures and stop the sequencer.
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  hw/ssi/pnv_spi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index 41beb559c6..d605fa8b46 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -20,6 +20,7 @@
>  #define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
>  #define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
>  #define PNV_SPI_FIFO_SIZE 16
> +#define RDR_MATCH_FAILURE_LIMIT 16
> =20
>  /*
>   * Macro from include/hw/ppc/fdt.h
> @@ -838,21 +839,31 @@ static void operation_sequencer(PnvSpi *s)
>               */
>              if (GETFIELD(SPI_STS_RDR_FULL, s->status) =3D=3D 1) {
>                  bool rdr_matched =3D false;
> +                static int fail_count;

This will be shared by SPI instances, is that okay or should it be
in PnvSpi?

Other than that, looks good.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

