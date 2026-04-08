Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA12810F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXx2-0005rj-MB; Wed, 08 Apr 2026 14:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wAXx0-0003kp-Ke
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:48:30 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wAJ0M-0003Th-3j
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 22:50:59 -0400
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-50d59d249fbso59988891cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 19:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775616657; x=1776221457; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SFYzWO0kymEuKE6VT/7y8OEyhoZ+X2nk+qpIe7V877c=;
 b=EBfU5zGdoMaXDhYUHTiapdmhJ1OMClDlrRwF8se6DHRf2Mn15GtA+60uYFCEqSXnkv
 Vt9Eo8eSEHQSYZJYuvi4qaLLtLMJUZoFAaUCeZcsRhVzf9aQ0k13glPEYmc0ofjTPQvI
 iXQEdL9BTCxw8WU/GBWvARfXIg7TaXC8vVDZN7QkQsHlCfYb1GXotmQ6k0QgJMA7oRPY
 Sqwnemn3ndWl7K+PNe3lhUuQf+rDpgsMeXQPm56Hj6ctRh0tyaOuw8VZqEJ0P6/59dgv
 UDjjH9inz5tvBU+eoG3eCNIkzK8xCaZ8tPikKwnJO2qIR4S6wYwQSmCHd4tkD93Rve3G
 J5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775616657; x=1776221457;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFYzWO0kymEuKE6VT/7y8OEyhoZ+X2nk+qpIe7V877c=;
 b=ezEYv3nN6jJDXwZNjCJVXYKxq16h2wE8vIa4ly8jgsz/JkcBpyD8j9NlzJmhqWdsx3
 9Lsmc4Erlk2Zbor75sbDbvq5jeSGzvVdmaHBd0dLOinmABZ1EUjZ8bd6xKlqemLUSp8K
 ddxrtqEvrqyR4AjKsV48KPrKgZRw27YlaPpZmJSmyu2s0m8GfRpfPHGSsxCZjazOfrK1
 pIqlnZoS10EoSErQKymMOrUcy/vh9PNoq4ettGxYRibN9bHxkthmYBzoxrf1vRZ9OVHh
 C0EKFGX9F/P78eXGwd1i1z3tJHqng+PIvYrn2mGfbHew9EpivWboSbO9ZTxAWxJrqhfR
 DCbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVws3vwibwxNb4vqAy0URo0ci64exwKWJQGKUbIoAhhMEU/NNm3G8qJNBZfv5qoAOa2UvClU5Ms3bg@nongnu.org
X-Gm-Message-State: AOJu0YwxuWbqKWkstBkCrUGoSK4EGUz0sEcprNTohF6KGv1ASS5uxdSx
 9Jv4TJQePf/Tm80ly6F3vGpTyhVO3ztoXlab+eybkAJ5eHVIvQwaEvhL
X-Gm-Gg: AeBDiesCS9kWrdY3cFCLwnmvBQ3P34i6IY5bghDZy9xEFDVtgth6b5lWQ13T+zrlOPi
 s1zMXr61I0XCgkgIz7VgEOhjufKCQgdOcL7LtU5vfXYyOjM3NRG3GhTCQqfqXACSkZAehqW2hPY
 5UOVavE1rqB0qwKl2Gm6MfIfWeJcAPAOvfSXg8qkVXFU0ehYcmfSoGsflQAo9FHA5ckZKrIveev
 xe2DjejAeV8MTwwcsMpQLYTSGbDvMtTfbezaH+sRg6x64OqLxoCGOy9KBIlx5DMl8/6dCHJ/32h
 Mk848W3GsVevkStXZFTUu1cltIb+wbJJZ1xwaxP3i31rbHNbs5IS7y3hkv/ff79V2RmOkBotbQJ
 m8gr2X6C8ZeAZLSlbGYt7OXyemIsfvOCB3BtSEM/KwPUhAh/cmQWkwKeTejS5AcxHGp2+HrATyr
 RFFd6cWHns5TnR3Ph1i1kHga5kQXqxHDZxmlfCtEt4OAIBDcKPXHFndmZyGFe69KFelisy3DgkI
 vN1IL93JOI=
X-Received: by 2002:a05:622a:5593:b0:509:25ab:f545 with SMTP id
 d75a77b69052e-50d62614e3bmr283530561cf.11.1775616656865; 
 Tue, 07 Apr 2026 19:50:56 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a59691580bsm161271956d6.26.2026.04.07.19.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 19:50:56 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:50:40 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 4/5] hw/timer: ibex_timer: Update IRQs after writing CTRL
Message-ID: <adXCbkj4PfvNDFYy@ZEVORN-PC.localdomain>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-5-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407043614.372871-5-alistair.francis@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qt1-x843.google.com
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

On Tue, Apr 07, 2026 at 02:36:13PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When writing to rv_timer.CTRL after setting the compare values the timer
> doesn't fire as we don't update the interrupts. Ensure we update the
> interrupts after a write to the rv_timer.CTRL register.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2796
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  hw/timer/ibex_timer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
> index 0f12531934..571633803d 100644
> --- a/hw/timer/ibex_timer.c
> +++ b/hw/timer/ibex_timer.c
> @@ -193,6 +193,7 @@ static void ibex_timer_write(void *opaque, hwaddr addr,
>          break;
>      case R_CTRL:
>          s->timer_ctrl = val;
> +        ibex_timer_update_irqs(s);
>          break;
>      case R_CFG0:
>          qemu_log_mask(LOG_UNIMP, "Changing prescale or step not supported");
> -- 
> 2.53.0
> 

