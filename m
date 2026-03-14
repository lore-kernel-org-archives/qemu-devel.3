Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16EB10706E4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 16:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1Rhy-0003DE-Hn; Sat, 14 Mar 2026 12:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w1Rhw-00036H-M6
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 12:19:20 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w1Rhu-0007Ow-RG
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 12:19:20 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-127380532eeso2711840c88.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773505155; x=1774109955; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xbN9T7w+GivOSAMEgAE4PSRkBF7p72D6sxxSIX5wQZ4=;
 b=LmyPWq3Ftn4BzqBXx6u66h4qGFrNmlScYwUnB/Zy2F9EoTpYVRJqZNEssP/3B0kZKh
 BGo9AU5jM3xdjVo0LXYnG0gzbsh5KX2lu1v+txyVj/AxbdCfcM0WbwWmMuuAZNg6c7lD
 lVuO/rPj4a17/poXHw946T9jwWReS9jJZPYyC/EECdblNwShDeAciVL4v4XXxm3CXoIF
 g4BAPmIQLzv9Np03/peTc6a5gzCzev7taT8EkHiLsk+HfVD9GhvfnyTz1da+OVxCAgMK
 E6ebS7EifIIIUnUWenNDeEmuOmOxoMUWJrBX07ylD36YRXEnA6UYNSW/1nHVrfLVtg1E
 Fydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773505155; x=1774109955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xbN9T7w+GivOSAMEgAE4PSRkBF7p72D6sxxSIX5wQZ4=;
 b=qRUbXuzJxtYp+TJxeUkUNL7IPhZa/pOxCKDux91/wTdgRsB8ILVgG+GXXgp6WMMxew
 oGoCfeExrDmq5oTVwmY2QATjq0ow+ef+5ZZguuhHfUzjqfAcK1HB2Eq+kOY/FKGhPm+v
 rFCLMZeEqDXo7kY+u7fY1SEWTnHne2gsATpPcbb8XiYKfkKa+Hd2jNSX9eL5HgqEPAgF
 JoueWkIVK1LecxaLKDDXD/2xkOMOR3ziJYhmJL+qwVxe+7r22dVo61tmfYeSq4GzXvOI
 My3WUIOjtQZDnwvYaA3Snn5GzeB4mQNPequH519LoYXlFQKNGG1Au5msBQ0ltjQHc9Mx
 gvRg==
X-Gm-Message-State: AOJu0YydizA0x6VF3arA81SAJrKx9bg3zkEExk/nPw9PjNCmngC2RGXO
 XX+YTYMOJeo1aGwNVM1JITf/SzBIN73vWC4AohfroI5BpVYaEI3jr6oq
X-Gm-Gg: ATEYQzy7o83zN8+K2stKPUEYcqbAIu8/lIOWkHDNwgEu2FqAya558A1xzs03Fds/pAy
 tPjkrB9xbH9lYGDIcrM+Luuxo97OJS/RxdLTRXS2ijSp84HHycH60fzXGW5Zy4WT9i+JjcG0Ju4
 f0qJiAUOt9XSSs5Oc9pY7h/EzAM04VWPvF1jQPsxJ0xb378T4pDUJoTzkTnY4akwMazWJsGUTK0
 vHl4O6CNLHmtYKGzRwUznnkjEO1ldIsT72kr6mG6u+mJinI3tYahwGAtnErUQAEZL3c2V/MaRbm
 ig7FP21agg9SdgG+4lbZwCST10Fgha7jsL8bLpC273f7eYFjMZvnLXudlYoZBq/o6D0ZirKxksn
 PO9Ui6Dqgp/+LDHEbw/+7I0ou4yLSzdDvYOlILHNtoaox8K7MjLNG2W+OA+4HeL3Ltyc9ZcSqtd
 2XzVZgtWxu4oN9Otx42Z57XGHzjCImpxDn34Qe0UCJSD6VzrJe1eIVvMCfFVeJH0/3peDM5uDBF
 jyG1dtuiKw/mdgHE4TPRvweLCs/YQA=
X-Received: by 2002:a05:7300:6d05:b0:2be:171c:5047 with SMTP id
 5a478bee46e88-2bea54a4dccmr3467118eec.14.1773505154844; 
 Sat, 14 Mar 2026 09:19:14 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3cd473sm6977582eec.8.2026.03.14.09.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 09:19:14 -0700 (PDT)
Date: Sun, 15 Mar 2026 00:19:09 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v3 3/4] hw/char: sifive_uart: Update IRQ when rxctrl is
 written
Message-ID: <abWKWF9X5gLHMgAd@ZEVORN-PC.localdomain>
References: <20260312033201.1619554-1-frank.chang@sifive.com>
 <20260312033201.1619554-4-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312033201.1619554-4-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 12, 2026 at 11:32:00AM +0800, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> When rxctl is updated, we also need to check whether the IRQ should be
> raised, as the user may activate the Rx channel or change the Rx FIFO
> watermark level.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  hw/char/sifive_uart.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index ae71a15a2a4..f255cca960d 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -216,6 +216,7 @@ sifive_uart_write(void *opaque, hwaddr addr,
>          return;
>      case SIFIVE_UART_RXCTRL:
>          s->rxctrl = val64;
> +        sifive_uart_update_irq(s);
This is correct. As noted in the 1/4 review, the same treatment
should be applied to the SIFIVE_UART_TXCTRL case for consistency
-- the user may also change the Tx watermark level or toggle txen,
which affects the txwm pending state.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
>          return;
>      case SIFIVE_UART_DIV:
>          s->div = val64;
> -- 
> 2.43.0
> 
> 

