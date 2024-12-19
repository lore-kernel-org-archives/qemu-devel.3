Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF06E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 21:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOOPp-0007bF-4f; Thu, 19 Dec 2024 16:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tOOPl-0007ax-9n
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 16:50:37 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tOOPh-0004Nk-83
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 16:50:36 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso13044375e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 13:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734645028; x=1735249828; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=15080CGi8MR7dh89EArQWWxhQHLdNi+jtiKyychT2BQ=;
 b=D8x2Qow/7A6QD2LthfdPnaj7FWuOISgQzskwPhQKHujcq1g1/IfSx6WQyAQ2lJoio7
 rj/aO7gnrWNSGFx9O2leyaNEq88rq1y3K33ZITAzauTzGnDO/4vCHiXmRCpHxpkwRskt
 c+RRc9cf0uqBc99shkK0lT7ow8DGLwXBJmH6c8Qa7VQPy0XScqG2UiUUuhef4Tb0ohgF
 hmRPlAmeXNf2z61GMW/Cyl9JWMe+NMEJ3TpX4TJCnRQQc9bwVvj6U9DZ1hM8giwEOPYP
 tJPCqdnY7Y8t55hSjRNDMTvsl3E2O4cBJsdQ3X9/Fl3A2xjO/tVz9XUzoAFVGsFGGLwn
 FNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734645028; x=1735249828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15080CGi8MR7dh89EArQWWxhQHLdNi+jtiKyychT2BQ=;
 b=NTUfHW/gyDR+sdhPoz15tz4L5QuiQeyK/nAeSTZ7hphQ8MXzv2oKGEZoA3pp+y0C+U
 xj7lbHwr5+cYLPwwhRZphFDrtwiw4mKfDI3h0aW7y3D6sc+DTYKu9nVsdFL6A0DeNi18
 AYaE6limoXP7Oe9o3uc9xWxqbPxfDpt26W6oPuKkMr4h3v+lGn3JyF2u79tPuWmTgdmc
 PC4nkHn35p60cGpFz82rP5NrNzrDW8h1YIlBqQdb1vALoo//5T47vMS4SmJRa4ylG1Jc
 3s/KhCK16DQzXOxcCHexwokitluj4pkF9E6XkJkhEshNi2oTuyVbvCN1JC2WINLyq/1e
 iMbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgVASrW3QLSDhIbuQPlnrZbYozyMroNiQDrWfaY+hHhu30X98tRhVo/SvwOcwIc5XFRs8dcXhFv+nE@nongnu.org
X-Gm-Message-State: AOJu0YwQCTvXDYRAgg/G7Nq3PLefG4n6cJ75W4GSGrTNmYnDZHB+OA4K
 t1lETTa0o/NawuWgjPCEy2t6tBGALEcYDaE5hiYMbVCAPYDndz9b
X-Gm-Gg: ASbGnctfW5Ihw9SxkoFvo8RuMgnlmxLwmkeLP0Y6DYnpyGGSJLbbPWnvOUJA7i+g+h/
 80C5Y3vopEyaTvbTkSzicSYwCXOBcDUzbfiTw9mBdpIKVCGUJwfEs0H3Iq3IlDFYDrmZrBNWjUH
 mVaP/qWcZCp0BKNa2/M0Wo4nLBnb9Ex2SweweVLsL4EBuZ0SrkxAyGBKstXU96cZQbAO9cSrpOP
 fgq3XxZ4YUMSf3ZgItS6hHuiGZqYp33vMpRLhta6/vtNdr85ybKqnog0soakicsHpS956dcxkcn
 0RLwITm3P//OfpEroO37
X-Google-Smtp-Source: AGHT+IHjAChO5wEjRIJyto5d7YtWusQdi0QhsKIuJ75off0hT7dZOwmpicyHAz8gFGlD0ASKVauyNg==
X-Received: by 2002:a05:600c:3b20:b0:434:fa73:a907 with SMTP id
 5b1f17b1804b1-43668643bccmr3747025e9.13.1734645027916; 
 Thu, 19 Dec 2024 13:50:27 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b417afsm62891955e9.36.2024.12.19.13.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 13:50:27 -0800 (PST)
Date: Thu, 19 Dec 2024 21:50:26 +0000
From: Stafford Horne <shorne@gmail.com>
To: Joel Holdsworth <jholdsworth@nvidia.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] hw/openrisc: Fixed undercounting of TTCR in
 continuous mode
Message-ID: <Z2SVIopc8Fgfajkk@antec>
References: <DM4PR12MB656535602DEDBA2D60321A54C8062@DM4PR12MB6565.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB656535602DEDBA2D60321A54C8062@DM4PR12MB6565.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32b.google.com
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

On Thu, Dec 19, 2024 at 08:08:14PM +0000, Joel Holdsworth wrote:
> > > > > +        /* Zero the count by applying a negative offset to the counter */
> > > > > +        or1k_timer->ttcr_offset += UINT32_MAX - (cpu->env.ttmr & TTMR_TP);
> > > >
> > > > Since UINT32_MAX is -1 in this context, this appears to be off-by-one.
> > > > I think -(ttmr & mask) alone is correct.
> > > 
> > > Thanks, I did send a mail to Joel asking about this bit.  He didn't respond for 2
> > > weeks to I just sent the patch as is as it appears to work.  As I understand,
> > > yes UINT32_MAX is just -1.  But why the -1?  I guess it's because after
> > > ttcr_offset is updated we call cpu_openrisc_timer_update() which calls
> > > cpu_openrisc_count_update() to update ttcr.  Since a few _ns would have passed
> > > and we are rounding up it will update ttcr to 0.
> > >
> > > But maybe I am reading too much into it.
> >
> > I think you're reading too much into it -- I just think it's a bug which isn't particularly noticeable because the clock is only off by 1ns.
> 
> Richard is correct. It should be:
> 
> or1k_timer->ttcr_offset += -(cpu->env.ttmr & TTMR_TP);
> 
> Stafford: sorry for not being responsive. I've been very busy lately, and it's been several months since I touched anything OpenRISC-related. Are you able to push this the rest of the way through the acceptance process? I had understood that you were looking for a more elaborate overhaul of the OpenRISC timer design which I haven't had time to work on. But if the patch can go forward in its current form, I think the improvement is worth having even it doesn't address other design issues.

Hi Joel,

Yes, I was able to sort out the issues and get everything tested and fixed up.
The patch is now committed upstream in QEMU for the 9.2.0 release.  I also
thought its better to have this upstream in its current form rather than wait
for further improvements.

Thanks for your help.  I look forward to you getting some free cycles and
helping more with OpenRISC when you get any chance.

I was also busy last year until November and didn't have much time to work on
this.

-Stafford

