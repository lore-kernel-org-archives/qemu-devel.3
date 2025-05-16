Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18C3C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFimQ-0007LR-4l; Thu, 15 May 2025 20:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFimH-0007KG-VZ; Thu, 15 May 2025 20:18:18 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFimG-0003bF-AK; Thu, 15 May 2025 20:18:17 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b20d46fcc86so1461116a12.3; 
 Thu, 15 May 2025 17:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354694; x=1747959494; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YnwbJIXiheczhpAKIPkv4Tr2AEcA1yrkjxMvY/TsPM=;
 b=RN9DELT8GdX0TX+8H7MT5uUfRO8WO3P7SNbCkgNyWMvBjsB7e2FVN4F3oN248W2oB8
 DxcAZtMes+yxBav5arUIGSSbohsyA1JsgNZ+hAlJdNUyExkWDeXrFxuU1qRvwfZID4V9
 ML7xjaOZLr0eyshrkMIW+8n2qTSefYiuvRWBtGBV5L3tbzYCbBa4BJEAMT0R5G2agzrv
 Md2+eUj5f6Vbs6hmH1zKa+OX+hwZ4YRW5lvIM4Od6dsbFryQ4g8xmMNw4CJ2QKcCGjzY
 +dfo6tpJf4nAtsTAE7UQSfnP/NNqWrY91DYSgU2suq2uqqkLBO1u0001aSV23PbG/+Nc
 FaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354694; x=1747959494;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1YnwbJIXiheczhpAKIPkv4Tr2AEcA1yrkjxMvY/TsPM=;
 b=fOmTrtqIn0iXKpGrPqh6zMvnZb5yXOzyeB2nB+jSFaQa0suXqGgru91hflmBjS55hx
 BMC2qJfyMMnQQWOwwCXIddf1PZH0x3EvZlbupPjyKpJtleFxCQU340meM5vT1K1Sxrlf
 U7Un4C3vFwEjRLAj9HDx/IwvdjUW77v+wSkunFIorpTf9u1ERdFL+qXGNgRKuY5wdA6Y
 z60PWu2h24ocNcG2GS7GkCkEhpsxI5aPw4VDkACDL9TXOzPPK5d9kNwsP0CuBIUXOrfH
 bgKZySXdltuMnUCsC0F/t2O2CbLSpXFdA099J9i0qq5/oITKSFMcq6LOn1FtB820cYiS
 SYGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWKmt+n35SK6Ln1WTjIfbtYqCByiWhlwKdXdraL/8r5CXkuYU8ek7WGT4GG3PnxkblAPAUK83FIA==@nongnu.org
X-Gm-Message-State: AOJu0Yz/fzKbZJ0F+T0KcvtzJkeCxSEda6WC2lOjPPvGpgnXR34mkrfa
 G+qKA3kbIlCUNg8tct0nAHhd03gqMuigOZxzZ3y4tSoqZv/j30h7aEap
X-Gm-Gg: ASbGnctHyOAv+1i7wuC9dM2Y68kc7wLUFYBbvWNnH2sV9RVgzgNkMCivh6wgtYU0rX7
 fPZwOYgs4SbhgVAzK55OerKnoI13eZfZxuEFBE8sEQjSQ8Sm6K0DIS6xyroIT0dKYkC2x4xuxUh
 4X5ElByzy9QNrsF68iP6+F5cGkPVTgkoa76LWeCjYLEQ90k8lOZbD6oB249TQuXWzYy+qxYatMp
 YDIUmo7j/yItMt0DWLmz80q8Bc4H1O7keNWGgSf3NnJQIatcjekoO9CmTdnlBuZ+aBVHYJTq3H/
 i/gqZTo0d1RouYKc6l3IqaJ4o7/AnTh6b0bMxHPOSWw3FP7RQOSR6i+1Zw==
X-Google-Smtp-Source: AGHT+IFXLga/ggiz0gY2kTrxmwgwtv9lbd+aCehHXCWHppeZEoMuOjizuilOjy7Lv/Zp8jFgEFQffQ==
X-Received: by 2002:a17:903:41d0:b0:22e:3aaa:8bc5 with SMTP id
 d9443c01a7336-231d43bdb61mr18240045ad.24.1747354694146; 
 Thu, 15 May 2025 17:18:14 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4edb0d0sm3353135ad.254.2025.05.15.17.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:18:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:18:08 +1000
Message-Id: <D9X5JI8HKJV7.ICYWP0CEHHKC@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 20/50] pnv/xive2: Permit valid writes to VC/PC Flush
 Control registers
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-21-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-21-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
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

On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> From: Michael Kowal <kowal@linux.ibm.com>
>
> Writes to the Flush Control registers were logged as invalid
> when they are allowed. Clearing the unsupported want_cache_disable
> feature is supported, so don't log an error in that case.

I guess there are no other fields in here that should be warned about
attempting to set.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 3c26cd6b77..c9374f0eee 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1411,7 +1411,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hw=
addr offset,
>      /*
>       * ESB cache updates (not modeled)
>       */
> -    /* case VC_ESBC_FLUSH_CTRL: */
> +    case VC_ESBC_FLUSH_CTRL:
> +        if (val & VC_ESBC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disab=
le",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>      case VC_ESBC_FLUSH_POLL:
>          xive->vc_regs[VC_ESBC_FLUSH_CTRL >> 3] |=3D VC_ESBC_FLUSH_CTRL_P=
OLL_VALID;
>          /* ESB update */
> @@ -1427,7 +1434,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hw=
addr offset,
>      /*
>       * EAS cache updates (not modeled)
>       */
> -    /* case VC_EASC_FLUSH_CTRL: */
> +    case VC_EASC_FLUSH_CTRL:
> +        if (val & VC_EASC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disab=
le",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>      case VC_EASC_FLUSH_POLL:
>          xive->vc_regs[VC_EASC_FLUSH_CTRL >> 3] |=3D VC_EASC_FLUSH_CTRL_P=
OLL_VALID;
>          /* EAS update */
> @@ -1466,7 +1480,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hw=
addr offset,
>          break;
> =20
> =20
> -    /* case VC_ENDC_FLUSH_CTRL: */
> +    case VC_ENDC_FLUSH_CTRL:
> +        if (val & VC_ENDC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disab=
le",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>      case VC_ENDC_FLUSH_POLL:
>          xive->vc_regs[VC_ENDC_FLUSH_CTRL >> 3] |=3D VC_ENDC_FLUSH_CTRL_P=
OLL_VALID;
>          break;
> @@ -1687,7 +1708,14 @@ static void pnv_xive2_ic_pc_write(void *opaque, hw=
addr offset,
>          pnv_xive2_nxc_update(xive, watch_engine);
>          break;
> =20
> -   /* case PC_NXC_FLUSH_CTRL: */
> +    case PC_NXC_FLUSH_CTRL:
> +        if (val & PC_NXC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
> +            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
> +                        " value 0x%"PRIx64" bit[2] poll_want_cache_disab=
le",
> +                        offset, val);
> +            return;
> +        }
> +        break;
>      case PC_NXC_FLUSH_POLL:
>          xive->pc_regs[PC_NXC_FLUSH_CTRL >> 3] |=3D PC_NXC_FLUSH_CTRL_POL=
L_VALID;
>          break;


