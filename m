Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AC6C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Lqf-0000PP-KG; Fri, 25 Apr 2025 12:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8LqX-0000N2-Rx; Fri, 25 Apr 2025 12:24:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8LqW-0003AI-5S; Fri, 25 Apr 2025 12:24:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1895377f8f.2; 
 Fri, 25 Apr 2025 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745598248; x=1746203048; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8PLyfEvjyuDmWYpO9e/icQaEaKHYCDJzYOLujjraZMA=;
 b=BFOS50hOG13h9OAA+nEEGJUeom73vgIHHLNVoNOPoOARR4cUouhtgryc3GVEYyT2YB
 shOgpyHWIsVrxupKOhNPTWgAukFR5+lEtuabTr/X2s+Xtc/kdUsFS/J2t4Sy9QE/JZh9
 TYrkpG+6OQOSDa63pce2CpXTrVl0WVq+WBusihMvTk0PSuRi1dIsjIpiI4HB/sANuYL2
 hWVL8wert+PYTMZZFP2oybG/LzzBv1ze9P9GZNsxibcWJWgVbAZEj/qIcMNvYNDGR4OD
 a9dnOA4F0Q/6F4lxIGjq9iY0RSJg/6EZ8Pau20pi4EDCTucMIO9PLmZ4PHMkwtza9VVl
 17vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745598248; x=1746203048;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8PLyfEvjyuDmWYpO9e/icQaEaKHYCDJzYOLujjraZMA=;
 b=YnDP+HkQPmdtYnLuJe8wFAVwWh5u2Dws+qdvbqSFbosrlKEwWdrlS9ihoocX2J19uI
 g1qEojlToTNqp5nmlOdftoucqE5XtCW6BmrLj5z/v3hdiZOcvxGg87XvyvAvN515d/pE
 lqO3RAmBl6qZBU7HSnUsbsFYebmwPKKj3YTcYaqvdsHpGayPnZJjod+tAElv2sMreov2
 4nhaWloyw6R6DTqhmb4UtRk+7QLZr6B8Ti+5KCUNdXXgUYwb9R9ALSDAjHrJzjSk/HUv
 mNVkM3h3lHvaLIEy9FHqHwKO/MkPwHrYfkaViIJBx9F3oaeTk3DMKdRhtxH8aq0YUFRD
 /T1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1kCJxHSY5WLzNaecoH7Gyuw0NAiRrKt/+Pi0QDzhnDjNGTNwIiLtYmMJUHRif3ReNP1CK1ipzIQ==@nongnu.org
X-Gm-Message-State: AOJu0YxgTGxroOwmuepHVVl6L9DzKSqfVIM1EMeZDvsOregm/bKfDSKm
 RiOdiWx8i5v2sVoNm+M1R+RcBWxd08Xb5cuwnjjUBWjB/jiFPX8k
X-Gm-Gg: ASbGncu5+XWL2JWRmn4P36eGgWl7t4rH9+fqKajK1x5yAAGhbAYUkNr05zeCub4ulm+
 VzOuVVjpFP5PVcp+5dckAOBT9GQTGP+gtYznCi59q6YQCY4FUV9hEvgQxpFmyYBc1RudIDJD+G+
 hDTvZYRS/LztzWxJWptiUULAoseAbcUFkGHSRvF9rbZQzdNrzevLil7+d7jrfVguqvfzfAnOZdR
 gPX5g/Z1VE79TcVUr0q5shS9/fGo319mRPdsC7IjnkeVZgNuxYcfoDYjI8h64gkK7dc8Qe83t6q
 arlCVyk/nIWjovVr/xttreyECyj4kQ54d2ZUlh9KOEn23O6exR6N/cx2o7BfVZczTbCe5tHIosd
 g268Wt+BcV3fw
X-Google-Smtp-Source: AGHT+IEcCb5HRZGXGuucBbM5QeBCV6qgyguxW5iUBby+mzpKC94QBgNUdY4MnKGL6eIbtCz9A2166w==
X-Received: by 2002:a05:6000:178b:b0:39c:1f10:d294 with SMTP id
 ffacd0b85a97d-3a074e419f2mr2455177f8f.26.1745598248314; 
 Fri, 25 Apr 2025 09:24:08 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca52e5sm2872985f8f.36.2025.04.25.09.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:24:07 -0700 (PDT)
Date: Fri, 25 Apr 2025 18:24:07 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Corvin =?iso-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Yannick =?iso-8859-1?Q?Vo=DFen?= <y.vossen@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Corvin =?iso-8859-1?Q?K=F6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 07/21] hw/dma/zynq-devcfg: Indicate power-up status of PL
Message-ID: <aAu3J7Xyr-aSWKcK@zapote>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
 <20250318130817.119636-8-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318130817.119636-8-corvin.koehne@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wr1-x434.google.com
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

On Tue, Mar 18, 2025 at 02:07:58PM +0100, Corvin Kˆhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> It is assumed, that the programmable logic (PL) is always powered
> during emulation. Therefor the PCFG_POR_B bit in the MCTRL register
> is set.
> 
> This commit is necessary for the Beckhoff CX7200 board emulation
> that has a FPGA implemented in the PL.
> 
> Signed-off-by: Yannick Voﬂen <y.vossen@beckhoff.com>
> ---
>  hw/dma/xlnx-zynq-devcfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
> index c44b802b22..c595d090fa 100644
> --- a/hw/dma/xlnx-zynq-devcfg.c
> +++ b/hw/dma/xlnx-zynq-devcfg.c
> @@ -339,7 +339,7 @@ static const RegisterAccessInfo xlnx_zynq_devcfg_regs_info[] = {
>         /* Silicon 3.0 for version field, the mysterious reserved bit 23
>          * and QEMU platform identifier.
>          */
> -       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 | R_MCTRL_QEMU_MASK,
> +       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 | 1 << R_MCTRL_PCFG_POR_B_SHIFT | R_MCTRL_QEMU_MASK,

This line is too long, ./scripts/checkpatch will complain.
You can use R_MCTRL_PCFG_POR_B_MASK here instead of the shift.




>         .ro = ~R_MCTRL_INT_PCAP_LPBK_MASK,
>         .rsvd = 0x00f00303,
>      },
> -- 
> 2.49.0
> 

