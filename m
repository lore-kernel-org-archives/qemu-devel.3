Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA44C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZBz-0002JL-1a; Fri, 23 Feb 2024 12:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYhM-0005aM-6c
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:46:57 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYhK-00022z-Gr
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:46:55 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-564d9b0e96dso743439a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708706810; x=1709311610; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TsQucG+omhJ6mgWABCcp5FJT07Qhvpa41K0AC8Xithw=;
 b=cIeUsYOLdC0CFTLwZzx9414w3fZUFS7Dg8hUR1iDUxwvZRJy5t7sb/a1M/vJqBrRV6
 8oPkGAoEGa7p8EMEe+CVk+FiJgryCfWgfZefAAKfNy/BmP1+sUpBArO+je5LA72LHO3v
 l9vXzRWZ1XosBWqyne7U51KnTfDQ1O50w3mLCsw66JlZi75/9iF4szTj6AN/semu67Z/
 rJHm/Zako5oeiaZox1uKGPTnu5Aix6HAFmdsPY1GGM18iLksHe36vZgmVlA6EsiIfPb9
 +jv6TwAEBDKX8pa7yh/n3i9/6y2xf7IOqT/XoF2YWvKu07SbZip5pQkoHytgVkh0xiyA
 CLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706810; x=1709311610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TsQucG+omhJ6mgWABCcp5FJT07Qhvpa41K0AC8Xithw=;
 b=vUrJfSll55eAnfBeEZRDbGRZ7yM8EZLDYgn1T0JCdE36BoA2DZp1XHXmQhE9zNGhjw
 N7HI1A5uNq1Ejo0M0mWHB44xAVbR0OTbBt+Osr2Sa6W49lWrEi4fBEwO1lovvRQTDEvW
 GbmsTmRRjP6zzZe87JS2HNLW2PtKCPTx4/zBepJF0V9c0fzLPb4VdULfGy0Rw2/fhElN
 JxRFQQ3vw68sK7yPtxwH/8my3TcLRv9TPcG7QleJqzlLHxWvAmuXdyBAocPNmWjQWXHr
 MxcVAVxH/u25kldbvZVdLpvMlLA1JVuGlRadVjdtMN2f2JC6VzFG/5X/0qEeh9Hruq5N
 NU+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8rD0rjxNqWWVJkDTZamX2R+Z2q9iLcpoNJabr1k7yaNi2kq0cpLLwg64inuokg4Yb81nNY0Z75TfOmmweBsic2e/sd3g=
X-Gm-Message-State: AOJu0Yw73FOqtrbdr0NnL65wc0oOqRP2NJY7w4y77Q1SGPQN7+6lWxfc
 l+vIIaL8QNGkKAxzAmk+vUUxvi69nT4pLrR2OW/ENq3JKf5f0musNc/dgNZu/s75u/UCqOH2WvF
 AzpQA1XUjiGzFWfMYjapQ3zDxH2rG7yo6HCLIngM3esW03shc
X-Google-Smtp-Source: AGHT+IHCJBjvVMtnVI9ZEgXLIT+Fu+xKphSMAXl3/bKXjFcxSGFT7PPy3REYYycpbKf6UUWW1JVRBVHbMInbz39+SSc=
X-Received: by 2002:aa7:d916:0:b0:564:4504:cc2 with SMTP id
 a22-20020aa7d916000000b0056445040cc2mr283059edr.16.1708706810594; Fri, 23 Feb
 2024 08:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-12-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-12-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:46:39 +0000
Message-ID: <CAFEAcA8Uj1z4e9=OYo3ExxKZiCCQE4fuL4Cuwe_F730hFcEvGg@mail.gmail.com>
Subject: Re: [PATCH v5 11/41] Temporarily disable unimplemented rpi4b devices
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Feb 2024 at 01:21, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> This commit adds RPi4B device tree modifications:
> - disable pcie, rng200, thermal sensor and genet devices
>   (they're going to be re-enabled in the following commits)
> - create additional memory region in device tree
>   if RAM amount exceeds VC base address.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

