Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A14FC35FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 20:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGwa-0007D0-25; Mon, 17 Mar 2025 16:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGwW-0007CU-FK
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:20:12 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGwU-0002To-Lx
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:20:12 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6e91d323346so51570986d6.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742242809; x=1742847609; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=42SBUni0O8QVuSi0HjH/MKJsRrSTSy5sUknyLA4sC50=;
 b=RKZEascJh1pDXmYtsTPnjsZd6kY7lDVGAlTZCZwDZdAHblC57KDDkpF+b13/R1LjoJ
 2Wc7k2IUnI5DV9gzn/oCESycKd0NdLUCr3Rr3HDjfnkwZY4Y32tSZxsOD+x30qHdOTCN
 AmqSWYIFULbedsNYZG6YLXLvPsgy/RJhbxOW+DipueTal+3uzhqkhcBoyUM0XYT2bsu2
 f/7CzgpNbIJNjS/8RqhI9Kz3rAAOe2T49OLWHmmwWCfDgQSaGGRdkMLdCoxgaQgrwY25
 01kwH/V8r8hWKZDtWJiuSR0Z/bjFlTpp2BALFQiaStCDlcj1gzWVWaIW8BbVdtDZ8lZm
 kngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742242809; x=1742847609;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=42SBUni0O8QVuSi0HjH/MKJsRrSTSy5sUknyLA4sC50=;
 b=Aygaba/H8/eQDsO2SR9PAvDZCap0pvFTndOxUIfTLmg5scGY6VnKTxgl5xn8VOp+RG
 d7un1kVrGNEi503fcS0iA2sK4qkgwPkbzWziJffWZX50SDZRtAmjGy/Gpwh6Y+ZJATl8
 I4RPvvmu6TWaYSsGn244wYG4NgpdprTVX9f6T++AEJadGZldw21So9MZekP49wu1rKcA
 B3PvMdIixEmnBxwniSX/kpEcYF0fA817La8HFphwhN8o+bR6WpbwVYhaTX9vFdHny27X
 Y37/XNG2U5pirpyl/r83B3XbpLAd6TXWK7XpUMZXqSexUlsRafP2C9FQVybankfCYgcc
 jMdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUztRVIVnfpvvaHI8SauEynrMA2NbBtxZm28cN6G8L2VfCH5fboee76WN0bnjxN3kOi2X8XuQbg7hbY@nongnu.org
X-Gm-Message-State: AOJu0YxCqZ+8bUUrxtjTRzbQAXjynIswIeOnh4dHonm/OVD4R3XDTOQ3
 khsQMalizx8XY0kCxoIRZwkenNkmESWAxqIhzlNgUDb6hVq6rcMp
X-Gm-Gg: ASbGncsCJoDxF9W1xj1ik59k1yQxiuUPVw+3utcH3dai8PedFfdiGKF7mcIfZ4VikZL
 KAGUE3JQ4MfG/zsFQQuy+OA+vg2vDU8D3Gt7YFylU1HlZuRkOPtLj8A3hAZ+a4Mye45JRCVZi1v
 vg3he4zYK/LmCw4wQZLdwnP9mSY+IIFNodQx+s67ZJaJUVb2pvgSBcLjYpygkRoZUwWpVeuA4I2
 02bQBlVD6WdYrfAa35HxN/X8lxAQRswkPQ2HvZwIgxuBpGPLnbhOTgkurVyecOZU5o9PRuoclS5
 6K3HutjbIGhWZuhblDNwMFhbPvVWETL23Z4D6AkyIboWQpe2WUg5vzumuKkY4HA=
X-Google-Smtp-Source: AGHT+IEO8bTArR2pGgNf0z0sTjXgk08+iTNSJQ9AvwsOJUhFdzF5QKtjAvP3Fp2yIFQb7h2nk0lnJQ==
X-Received: by 2002:a05:6214:e4e:b0:6e4:4012:b6f1 with SMTP id
 6a1803df08f44-6eb1bbbea02mr11926606d6.3.1742242809530; 
 Mon, 17 Mar 2025 13:20:09 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:6d71:de10:2e5e:506a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade234b92sm58814756d6.43.2025.03.17.13.20.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 13:20:09 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-30-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-30-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 29/39] target/hexagon: Add pkt_ends_tb to translation
Date: Mon, 17 Mar 2025 15:20:07 -0500
Message-ID: <018b01db9779$fa969090$efc3b1b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQOKXza3suX6J/A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2c.google.com
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
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 29/39] target/hexagon: Add pkt_ends_tb to translation
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h |  1 +
>  target/hexagon/translate.c | 99
> +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 99 insertions(+), 1 deletion(-)
>=20


> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c =
index
> 060df6e5eb..475726388a 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -259,6 +259,18 @@ static bool check_for_attrib(Packet *pkt, int =
attrib)
>      return false;
>  }
>=20
> +#ifndef CONFIG_USER_ONLY
> +static bool check_for_opcode(Packet *pkt, uint16_t opcode) {
> +    for (int i =3D 0; i < pkt->num_insns; i++) {
> +        if (pkt->insn[i].opcode =3D=3D opcode) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +#endif
> +
>  static bool need_slot_cancelled(Packet *pkt)  {
>      /* We only need slot_cancelled for conditional store instructions =
*/ @@ -
> 272,6 +284,90 @@ static bool need_slot_cancelled(Packet *pkt)
>      return false;
>  }
>=20
> +#ifndef CONFIG_USER_ONLY
> +static bool sreg_write_to_global(int reg_num) {
> +    return reg_num =3D=3D HEX_SREG_SSR ||
> +           reg_num =3D=3D HEX_SREG_STID ||
> +           reg_num =3D=3D HEX_SREG_IMASK ||

The name of this function is misleading since SSR, STID, and IMASK are =
not global.
A better name would be sreg_write_ends_tb

> +           reg_num =3D=3D HEX_SREG_IPENDAD ||
> +           reg_num =3D=3D HEX_SREG_BESTWAIT ||
> +           reg_num =3D=3D HEX_SREG_SCHEDCFG; }
> +
> +static bool has_sreg_write_to_global(Packet const *pkt) {

Ditto

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



