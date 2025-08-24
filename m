Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4B5CA0EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 16:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqDJY-0003qX-E5; Sun, 24 Aug 2025 12:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqDJU-0003pz-7I; Sun, 24 Aug 2025 12:11:24 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqDJR-0000Pw-55; Sun, 24 Aug 2025 12:11:22 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-55f30367cbeso2169420e87.1; 
 Sun, 24 Aug 2025 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756051877; x=1756656677; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2t7RIRiIFS6lwa7V0aDsSmE13uSsevOGfi2Mr9xzndw=;
 b=KwZSI4SZHBiuPXbeRDU89AAwMin3tXxXIVBqRnPEJ6zzm19IwcNhCgX4oEpTPjyBD9
 Zb1h2BRC5FA2KkWSUB5fVu2f0nzY96Dbvzt/F9Qm3T8sYdrjClf/XRTMmv1OUXQx4ARm
 V9Rmy/NLqqvUcPwUtogyu2Ae4PcwQ1cUZoQeyMiiJEPsJXG49ybhBQH1QjDuMi13FssR
 tsPNh8AKI8EN5u7Vk4YIExN46lU6x1EogvTP1fk6vVQ9CQHozCyxI5I5bnJFh+OuLhsi
 IZ1zBj3ire/tIyvKGLWER/2IdcXt2jghCUzCmy/k+4/9kZty2XtbKCV77NMme67XFMxs
 QD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756051877; x=1756656677;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2t7RIRiIFS6lwa7V0aDsSmE13uSsevOGfi2Mr9xzndw=;
 b=iV0/FfGzlYHDF6x2OzOUBhmrZnFc0Pcl+UyYVWn+o0sgr8ORgMtz8+ZXW/GWHai8sK
 c2DX+RiPrXZbJ1BvSPm3LRMZ4ixPOv2DqwS5EN5xQjleVddBMfuKPqQJA64/9czkJfoJ
 EkXle6vyLPhHuGT/PZLGvxhR9RC97aPxz/d3aq/5WeD9lFX2Ht4pys/yvUB2NbhQAI6N
 BsaWhof8F8BmbAdDX2MZF1uGzQ1dPpzWkYJ3F6YC2feHjCM14vXNP1YEE1VPuDzqykiE
 egYz0mrk2VgjkfhaqTPUwNNWODowK4VsX+Xwh47hgyL7+OqLPGD2CPtPKHABtfK372a8
 01Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgKXrvrqA7U8C99yXE7VDXthD+gdAiQeT6Radmjfl5iLnKu5uk0UVW9es0aMXSvYoRo3x0+zOV2g==@nongnu.org,
 AJvYcCXYnpa8lTPbffOUPr1NoEzYY2bevkNH+OORCZMJuYJ1dlUjUyDjPs/Oavy6Ca7R0mYt/y+8Bd3aSa9+5Q==@nongnu.org
X-Gm-Message-State: AOJu0YyTs/q2+6964NpdCbiaKveoxgh18z8rymahD4OI8LY1Vywawv43
 C3b7Vd2GFMDr42RumlB2057c0WU6mPdblYZ8BWPQhOvR1EqwOJxj/r3u
X-Gm-Gg: ASbGncsdYPjc7Ksb9Cs3zbpdyZfiziw2as6vTSqiQsAGlkAsjVp6alEXuocLwrKWLBT
 +ZiOFscJL5Cgfosa6Ini03+gf4cBtHUNRdjZqzBfBhZcwbzsTv6ovneE6GbQf0ZNdagnqT4RsYs
 5bejwBMmoxUqfVckkeLHUo83VLfBjyxH0Oe5RE0lrokEZprPhcq8TzV1BYaVr51dHjOqmqcgHcC
 k9xvPC4kJkoCv5HSTnYsuZoFHNkB5CSe4DZ48Af5vqlUSnLY9QZcTGvrxiD7LnVdukuwOtRwjAU
 MyG1maskoo5ojoaDfFyWWxZG+bUGTfYaRyyVOAmLY8NSg1AAgfnzF2DcRS9crqCex+3oSSmn5CS
 8AUd9mT9RoaKqi/EoWHA7bT/8T+/+IBlMi8muSKeN5LrKaeyunc4SP8kyKujKtLkNG+awE/bdax
 2G9j1D
X-Google-Smtp-Source: AGHT+IHwlo5z5oWvronNupSs44Ql6wq9JSxxedSkPk9pnGExF7jGXDV9TjjBCeObzHsvXBeXyky30g==
X-Received: by 2002:a05:6512:63d7:20b0:55f:3dbb:4567 with SMTP id
 2adb3069b0e04-55f3dbb473emr957707e87.32.1756051877318; 
 Sun, 24 Aug 2025 09:11:17 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35c8bb59sm1117821e87.91.2025.08.24.09.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 09:11:16 -0700 (PDT)
Date: Sun, 24 Aug 2025 18:11:16 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Corvin =?iso-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Corvin =?iso-8859-1?Q?K=F6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Yannick =?iso-8859-1?Q?Vo=DFen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 07/14] hw/dma/zynq-devcfg: Indicate power-up status of
 PL
Message-ID: <aKs5pO1qJ-h6MGIF@zapote>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <20250815090113.141641-8-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815090113.141641-8-corvin.koehne@gmail.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12f.google.com
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

On Fri, Aug 15, 2025 at 11:01:05AM +0200, Corvin Kˆhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> It is assumed, that the programmable logic (PL) is always powered
> during emulation. Therefor the PCFG_POR_B bit in the MCTRL register
> is set.
> 
> Signed-off-by: Yannick Voﬂen <y.vossen@beckhoff.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  hw/dma/xlnx-zynq-devcfg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
> index c699df6ad4..064955a0f8 100644
> --- a/hw/dma/xlnx-zynq-devcfg.c
> +++ b/hw/dma/xlnx-zynq-devcfg.c
> @@ -333,7 +333,8 @@ static const RegisterAccessInfo xlnx_zynq_devcfg_regs_info[] = {
>         /* Silicon 3.0 for version field, the mysterious reserved bit 23
>          * and QEMU platform identifier.
>          */
> -       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 | R_MCTRL_QEMU_MASK,
> +       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 |
> +                R_MCTRL_PCFG_POR_B_MASK | R_MCTRL_QEMU_MASK,
>         .ro = ~R_MCTRL_INT_PCAP_LPBK_MASK,
>         .rsvd = 0x00f00303,
>      },
> -- 
> 2.50.1
> 

