Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CC3C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 13:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCeTd-00057U-25; Wed, 07 May 2025 09:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1uCeTb-000547-MB
 for qemu-devel@nongnu.org; Wed, 07 May 2025 09:06:19 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1uCeTZ-0007mq-IG
 for qemu-devel@nongnu.org; Wed, 07 May 2025 09:06:19 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2d5e5e21b92so4459440fac.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1746623175; x=1747227975;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdO84SBT+yzy9Vdl7PflEH11rZSK9840HXhCWIBmk2I=;
 b=HaaaGTNhuJ7bxLkEuobxfVmFVjuiy2G6OAwvMpOI3Z2Nnl7fKUF53gNOaj0O6xHhhZ
 j5WAAQwDBVqKKqwsUzyIxMazKoKnSdLQ5E9lVIAfIiQbrGyy8Mcfm6KtsFS0TAVUt3zy
 qMLMej7ld0CF8JGEU3yKMBg1AYoN7U9F+KHH7snIr52vU41EvqioesfgheyFXo5/GXS/
 8HKgja0UcXaIu3j6VTYq0U9odH6LnV01bGGGpWJkiESsvYau6P2tRXqq09fyg+RR7bUD
 8KmqwxHgjGJWlwKmkzbfzIbUhUqHMsPeSUHSScikR0eNmst0LN0hx4nrZHZ8qHHhLI+W
 85fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746623175; x=1747227975;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mdO84SBT+yzy9Vdl7PflEH11rZSK9840HXhCWIBmk2I=;
 b=WycvXHqu+MbH2f3E3cOTovbKRmhFRvAUGvh8nvyfTR0lH5BWKkyBdM4u1KLDQxdkT/
 /PjrKHfsUpL34Mk2dCtCIBEmuwPE7KOMShA8NlATzm3OX7t0izAiVLjtnm0PunaIHOGJ
 uyFdvfKH3wEpMgdXDrU41v9aUOXnXvm+xT4oR6R5v02MqaLH2Qzsc/qi+nMTssbB8wtV
 ilH5JHKCqLFSMkADlOpATCtVyp6rrumUYeiyB8b3d4fALgErO7tJ5Sq+8mHd32pWRkmc
 JuKCHRYXFR2oO7omjkcrjDrHSweKhlpReSkh5d1NZBxhgSsFcLS78vBfef9ANQEoQ7Vp
 59tQ==
X-Gm-Message-State: AOJu0YzZQjWmBrTf4qegU2hB7bszlU7RAsqJT2qlinRZp3SAtSU6A85E
 Zjf071HcW0wIMLKZlMeqbva36tISnLJPJtG1L3+MUFf1V57qDRj8LU8AnxxhXvw=
X-Gm-Gg: ASbGncvx88DO9ScZe2KVnpizAhKxFbdGYH2xmeCXRxL6k6lz5igAnpJKq5ufLVqc07j
 /HT7hIeVzD0fnZzkTMGXFbapjyuQn1r8QsrnlRGo4VRiUzMA0xdYbx+9jx9ik5BfBwnvLkyANsf
 rK18V7HTErldk0v/KrrJRec48ZJ+r1Wpbb4Y3o1j2Va/eWKFYA7uBXiUklQ48UTDfFIoi2nHD4H
 ND//CbKUQCPoIx/kFwrvDWsDtCTJ2C/maB4OY+uk4QT0qeqSWUFagSD4OzuDzEFGstFltImlT8L
 IJwdpw34Q788TYemRw8MJYX9xGMvhpi+xQ4ixC6sbP52
X-Google-Smtp-Source: AGHT+IGBatNMZ3LoYPLlzevng97lGmeUx8t1svako6Ux5+a8KZ3l8LkQxZufobGlZtC02tF732EDzQ==
X-Received: by 2002:a05:6870:548f:b0:2d4:d9d6:c8c2 with SMTP id
 586e51a60fabf-2db5c114a03mr1906432fac.34.1746623175102; 
 Wed, 07 May 2025 06:06:15 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:5eb9:1067:bea9:6bfe])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5d0dcd34sm570787fac.41.2025.05.07.06.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 06:06:13 -0700 (PDT)
Date: Wed, 7 May 2025 08:06:06 -0500
From: Corey Minyard <corey@minyard.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/i2c/imx_i2c: Always set interrupt status bit if
 interrupt condition occurs
Message-ID: <aBtavpDt1yfoavj7@mail.minyard.net>
References: <20250507124040.425773-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507124040.425773-1-shentey@gmail.com>
Received-SPF: none client-ip=2001:4860:4864:20::2c;
 envelope-from=corey@minyard.net; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 07, 2025 at 02:40:40PM +0200, Bernhard Beschow wrote:
> According to the i.MX 8M Plus reference manual, the status flag I2C_I2SR[IIF]
> continues to be set when an interrupt condition occurs even when I2C interrupts
> are disabled (I2C_I2CR[IIEN] is clear). However, the device model only sets the
> flag when I2C interrupts are enabled which causes U-Boot to loop forever. Fix
> the device model by always setting the flag and let I2C_I2CR[IIEN] guard I2C
> interrupts only.
> 
> Also remove the comment in the code since it merely stated the obvious and would
> be outdated now.

This looks good to me.  I can give you an:

Acked-by: Corey Minyard <cminyard@mvista.com>

or I can take it into my tree.

-corey

> 
> Fixes: 20d0f9cf6a41 ("i.MX: Add I2C controller emulator")
> cc: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/i2c/imx_i2c.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
> index 91f84c2ad7..d26177c85d 100644
> --- a/hw/i2c/imx_i2c.c
> +++ b/hw/i2c/imx_i2c.c
> @@ -79,13 +79,12 @@ static void imx_i2c_reset(DeviceState *dev)
>  
>  static inline void imx_i2c_raise_interrupt(IMXI2CState *s)
>  {
> -    /*
> -     * raise an interrupt if the device is enabled and it is configured
> -     * to generate some interrupts.
> -     */
> -    if (imx_i2c_is_enabled(s) && imx_i2c_interrupt_is_enabled(s)) {
> +    if (imx_i2c_is_enabled(s)) {
>          s->i2sr |= I2SR_IIF;
> -        qemu_irq_raise(s->irq);
> +
> +        if (imx_i2c_interrupt_is_enabled(s)) {
> +            qemu_irq_raise(s->irq);
> +        }
>      }
>  }
>  
> -- 
> 2.49.0
> 
> 

