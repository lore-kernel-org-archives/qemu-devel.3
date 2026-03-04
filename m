Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751F9EF8FE1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxm9n-0004vf-9J; Wed, 04 Mar 2026 08:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxm9l-0004uK-SM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:20:53 -0500
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxm9k-0001SS-Bq
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:20:53 -0500
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2be1b5fe11cso2970978eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772630449; x=1773235249; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TdS2Xz84x6RCdg1UvRLOAprOtQ0Ymp+pWlhMtRSLAS0=;
 b=lo8nOcgo6Ur+xgg2YQhnpqmOJHwBAvdgCpq+hbvo+Uq+98fcRGkBJYrpVaVJeMgdLo
 8mcOB1w51rneaxpplxkTZxoaG+Pji6NXew0eKpbE473Y421yIlTUW82d4ISUiglldE4c
 xeuWVscTxGnllOpqa+S12OyLXVwmwD1pEoluHW0trY6A/ZMlDazLf/hSxrfyrPZ0YTAr
 6a2vAQZ6+mbEfZDsiPr9vCJxZXZdb5YNm+lxzitx4X0HBzad1TWxiCU5JwL+jWYRMxF4
 WJM8ytY6Tfr5ejpa9Egm+JH/7SG8xS2YCOA4ATDOkmiPWNdFwTMeXTR2J5FdzrQrsFEE
 uXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630449; x=1773235249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TdS2Xz84x6RCdg1UvRLOAprOtQ0Ymp+pWlhMtRSLAS0=;
 b=BmyAwdMp1Snq0gj/FGFjdE1lM+ooXwlH0cUO32RfkEqkSeFCR2QyQVowjlENWY/kSv
 VJAm7sb7s8z7ogupRKIxpnPdOt83O64BxxFvYNne106vVGgSh3zl19n03bQ6gZN+vaP/
 QBUCwqX9lSGSPcayAnVGGH+8YER4ga+iQykO00GnWAl3Tjh6sHYmoCEetb0ff8qUmdD3
 3pSReDPAWtYDwinaWkq/VGAXJAA1/6OJAfD/m3Kr1FBstWazcdNq2lBU5CJcs4ScrbiI
 UPfyNya2gAavHbzVH9sfquvvY87vDlyQavuE8sg99i+OMnC1URUqwgzsGB0sCHHmBQha
 i0hw==
X-Gm-Message-State: AOJu0YyQNS8UysUnw0iEISd5+/7SYws001JAxzpyauCt5PuVkNYulmyL
 rGlsOc+MRcWjBmVAjIHMTNvW+CWn1RY9J73ddmEJBroANcfHx/x1RBew
X-Gm-Gg: ATEYQzygj9ErAvUFKdIt90Tm5CoNZyx9xwfQ4bmUPXXFv+mHnRlwWbovo5hMcMkbT48
 Fdo4KRitqxBKkRnwiSBivYbhAta4LRVASv2WX41MW53MFMqT/1qwVrxO92Nkn+VHloP+jjXiQVf
 hWaw8cILBRC4pXIlH4hgQyjMYrywzw34UnWyezTw3HatzqALgRSzAwhqCszF44jRiZm8pSlgy2p
 QNEZafsIEZPv5Eqrsa2aGcvf5UftBAxEwA6ZTzJVF577mAiGtU8DTxmdDqFZEqnAMjN9/5bHaN1
 LVa0ezvdoY/dMmYXpOB1S5jJoe4dlL/0psAa/lrcTxgS6AW8QnEnzXo2Z7NWKDPUDMUu45utlTh
 dFKfirXQ9V+CXvHiEK+Z1NvZGGbtbEFyLnlwtdN62V3AZZh9+fYr46ObI2pegw6qxee8bQjOxwU
 myLofbBLC6tVqdMTIZVxkg28+XcEJpDkP0DPvIRuj7MbG0jzz+YTUSYfEheELEATdje+IWxwrLo
 a4M4PR1jq1ob3zIzEoFh3QKwJj2KfE=
X-Received: by 2002:a05:7300:5720:b0:2be:8da:321c with SMTP id
 5a478bee46e88-2be30fd3a4cmr805780eec.2.1772630449309; 
 Wed, 04 Mar 2026 05:20:49 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1a45a58sm14503328eec.0.2026.03.04.05.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:20:48 -0800 (PST)
Date: Wed, 4 Mar 2026 21:20:22 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Subject: Re: [PATCH 1/2] hw/riscv/riscv-iommu-hpm: Fix irq_overflow_left
 residual value bug
Message-ID: <aagxUh_cFPSKvUtZ@ZEVORN-PC.localdomain>
References: <20260304040959.47267-1-jay.chang@sifive.com>
 <20260304040959.47267-2-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304040959.47267-2-jay.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 04, 2026 at 12:09:58PM +0800, Jay Chang wrote:
> Reset irq_overflow_left to 0 before setting up a new timer. Without
> this fix, a stale irq_overflow_left value from a previous timer setup
> could cause incorrect timer behavior.
> 
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>  hw/riscv/riscv-iommu-hpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> index c5034bff79..e8d284ac8b 100644
> --- a/hw/riscv/riscv-iommu-hpm.c
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -228,6 +228,7 @@ static void hpm_setup_timer(RISCVIOMMUState *s, uint64_t value)
>      }
>  
>      overflow_at = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + overflow_ns;
> +    s->irq_overflow_left = 0;
>  
Looks good. Without this reset, if a previous call set
irq_overflow_left (overflow_at > INT64_MAX) and the current
call does NOT overflow, the stale value persists and the
two-phase timer fires incorrectly.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Best regards,
Chao Liu
>      if (overflow_at > INT64_MAX) {
>          s->irq_overflow_left = overflow_at - INT64_MAX;
> -- 
> 2.48.1
> 

