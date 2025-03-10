Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA527C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 03:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trTjW-00031T-Iq; Sun, 09 Mar 2025 23:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trTjN-00030L-L7; Sun, 09 Mar 2025 23:23:07 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trTjL-0005Gf-TS; Sun, 09 Mar 2025 23:23:05 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so4522635a91.1; 
 Sun, 09 Mar 2025 20:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741576981; x=1742181781; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3R0Q93nr1IJe8MQVvelF0y9qBKU1481GwrKtY1xvySU=;
 b=ebpXwh3V4buspaHKs57536fWkTZDKJnKqEoNA3U0sH29i8+M6aIT1isESMByowAGYe
 sB8Xw1tyiDuPy/yLHrFuGcO4rIe/x63JaEL4qJ5rohgSNAFIqgAR8W584whbCjZoDxt8
 gmdPNz0kPnnworSMhp//U2ft+sBPu89rIQJddOTDz0qrFVpAKi/i7ggsHw4+bNVa4ZlP
 Z4VY9wR5cOh16vVZOujSL3h6VM28aCwe1jU0hj5KGBsACDXJNmIjUr3jS88Ajr0EUcbQ
 2Rxok6dbAyjsJzZiCT75X5UUdI6cqwVrVIA8rbeB+tHRuVjrRX2lKgjJTeR8+x8y4V20
 oE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741576981; x=1742181781;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3R0Q93nr1IJe8MQVvelF0y9qBKU1481GwrKtY1xvySU=;
 b=U9q4Ftr2Myw6upQD+IRwXyBAJYf2Tl4H6hkcmnRgBfn3BE1KaAMD1wUSkL8vqikCbm
 UyA/wMTAooFQhdMR8w4AtB9Bh+2VztMUTCbm4xAqFuVzevHJZdCVYJOVgGU59xr5Y8SE
 cuqDYu2fXPmHibRALaB5dhtxuIg2bYTUO9LOkCLFPoF6oSCwqIcl4fbScShLA5LwGYnV
 xjy554UXzwLzAPJxtohRgHR+hcWdZR8mJhx3f1IJ8a7kEo3UqsgUIKFR75ECUUrZOGEb
 LlFqYa3c4Bcqf6Igb/xFkG3CFkfVpUvGujWupIpSYSL1rn/MioWeFZGRbWKq3LC8I5wT
 KsAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU584bP/nAGAo05b7SNYom2AeVLD87FuumtixM+J8CJoQ2LG9jQQJkJuujIyTwemf9tRJ1qnw5vPfG/@nongnu.org
X-Gm-Message-State: AOJu0Yx64D/cTaB1oXf2HEKpMidQ10LcW5cPAq1MDeUibulXv2WPCOiR
 GIq/Rai8saNwHycSmSGOZEfuzdhe4ZhUBbw7OthBJ4Z1yAhBtWVF
X-Gm-Gg: ASbGncszp9PUagsYYxN/etbkZyQMpxzeUhNrxdrbyo5TKeK2O7kNUl1bl37FFRH3t0v
 c5SSJunyE5E9B4bv3Aqd47priOMKFVjpe4PtEZX1ZnWsN1USJzoSM9IRPSyd6CUYW5lAh/CBtAr
 ZHCOyScQbjtzZ6QmAw2Bnka4kDlP3ZYGg0iJejezlKRIB0W0Z+/9TI4CuVYHEqFzjIERK1okis7
 bTZ7sHp1yROH1DO81QmENsN7K7pSFUlUm24n3l4wqn18XxUHicth/ijeup+GLarIjaomzirNZRZ
 QDDOF+yzLVegmx09WmXawPswElzWxO334CtRaWt4xHr9gJ2tVkA=
X-Google-Smtp-Source: AGHT+IHoLEjb2gaAnbIxH6TfOkRp+pvvZSsikzlvzWie7wZWvb+QJaxlNgA0g+1lhPmxs7f9offhJQ==
X-Received: by 2002:a17:90b:3887:b0:2ee:c6c8:d89f with SMTP id
 98e67ed59e1d1-2ff7ce84497mr20681290a91.14.1741576981318; 
 Sun, 09 Mar 2025 20:23:01 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff69374306sm6796602a91.22.2025.03.09.20.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 20:23:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 13:22:54 +1000
Message-Id: <D8C9IGYPAKYS.1SCN2F0HQSP4Z@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 01/14] ppc/xive2: Update NVP save/restore for group
 attributes
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-2-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-2-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102b.google.com
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

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
>
> If the 'H' attribute is set on the NVP structure, the hardware
> automatically saves and restores some attributes from the TIMA in the
> NVP structure.
> The group-specific attributes LSMFB, LGS and T have an extra flag to
> individually control what is saved/restored.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/hw/ppc/xive2_regs.h | 10 +++++++---
>  hw/intc/xive2.c             | 23 ++++++++++++++++++-----
>  2 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index 1d00c8df64..e88d6eab1e 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -1,10 +1,9 @@
>  /*
>   * QEMU PowerPC XIVE2 internal structure definitions (POWER10)
>   *
> - * Copyright (c) 2019-2022, IBM Corporation.
> + * Copyright (c) 2019-2024, IBM Corporation.
>   *
> - * This code is licensed under the GPL version 2 or later. See the
> - * COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> =20
>  #ifndef PPC_XIVE2_REGS_H
> @@ -152,6 +151,9 @@ typedef struct Xive2Nvp {
>          uint32_t       w0;
>  #define NVP2_W0_VALID              PPC_BIT32(0)
>  #define NVP2_W0_HW                 PPC_BIT32(7)
> +#define NVP2_W0_L                  PPC_BIT32(8)
> +#define NVP2_W0_G                  PPC_BIT32(9)
> +#define NVP2_W0_T                  PPC_BIT32(10)
>  #define NVP2_W0_ESC_END            PPC_BIT32(25) /* 'N' bit 0:ESB  1:END=
 */
>  #define NVP2_W0_PGOFIRST           PPC_BITMASK32(26, 31)
>          uint32_t       w1;
> @@ -163,6 +165,8 @@ typedef struct Xive2Nvp {
>  #define NVP2_W2_CPPR               PPC_BITMASK32(0, 7)
>  #define NVP2_W2_IPB                PPC_BITMASK32(8, 15)
>  #define NVP2_W2_LSMFB              PPC_BITMASK32(16, 23)
> +#define NVP2_W2_T                  PPC_BIT32(27)
> +#define NVP2_W2_LGS                PPC_BITMASK32(28, 31)
>          uint32_t       w3;
>          uint32_t       w4;
>  #define NVP2_W4_ESC_ESB_BLOCK      PPC_BITMASK32(0, 3)  /* N:0 */
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index d1df35e9b3..24e504fce1 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1,10 +1,9 @@
>  /*
>   * QEMU PowerPC XIVE2 interrupt controller model (POWER10)
>   *
> - * Copyright (c) 2019-2022, IBM Corporation..
> + * Copyright (c) 2019-2024, IBM Corporation..
>   *
> - * This code is licensed under the GPL version 2 or later. See the
> - * COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> =20
>  #include "qemu/osdep.h"
> @@ -313,7 +312,19 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, X=
iveTCTX *tctx,
> =20
>      nvp.w2 =3D xive_set_field32(NVP2_W2_IPB, nvp.w2, regs[TM_IPB]);
>      nvp.w2 =3D xive_set_field32(NVP2_W2_CPPR, nvp.w2, regs[TM_CPPR]);
> -    nvp.w2 =3D xive_set_field32(NVP2_W2_LSMFB, nvp.w2, regs[TM_LSMFB]);
> +    if (nvp.w0 & NVP2_W0_L) {
> +        /*
> +         * Typically not used. If LSMFB is restored with 0, it will
> +         * force a backlog rescan
> +         */
> +        nvp.w2 =3D xive_set_field32(NVP2_W2_LSMFB, nvp.w2, regs[TM_LSMFB=
]);
> +    }
> +    if (nvp.w0 & NVP2_W0_G) {
> +        nvp.w2 =3D xive_set_field32(NVP2_W2_LGS, nvp.w2, regs[TM_LGS]);
> +    }
> +    if (nvp.w0 & NVP2_W0_T) {
> +        nvp.w2 =3D xive_set_field32(NVP2_W2_T, nvp.w2, regs[TM_T]);
> +    }
>      xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
> =20
>      nvp.w1 =3D xive_set_field32(NVP2_W1_CO, nvp.w1, 0);
> @@ -527,7 +538,9 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router =
*xrtr, XiveTCTX *tctx,
>      xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 2);
> =20
>      tctx->regs[TM_QW1_OS + TM_CPPR] =3D cppr;
> -    /* we don't model LSMFB */
> +    tctx->regs[TM_QW1_OS + TM_LSMFB] =3D xive_get_field32(NVP2_W2_LSMFB,=
 nvp->w2);
> +    tctx->regs[TM_QW1_OS + TM_LGS] =3D xive_get_field32(NVP2_W2_LGS, nvp=
->w2);
> +    tctx->regs[TM_QW1_OS + TM_T] =3D xive_get_field32(NVP2_W2_T, nvp->w2=
);
> =20
>      nvp->w1 =3D xive_set_field32(NVP2_W1_CO, nvp->w1, 1);
>      nvp->w1 =3D xive_set_field32(NVP2_W1_CO_THRID_VALID, nvp->w1, 1);


