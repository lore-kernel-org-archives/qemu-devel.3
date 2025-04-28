Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7952CC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WLP-0004vY-C9; Mon, 28 Apr 2025 17:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WLN-0004vN-IT
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:48:53 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WLL-0005TB-MB
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:48:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227a8cdd241so73454015ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745876930; x=1746481730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=joIdpFXzIkNPhFP+wCOvHfKzdfABNtuAjQU1o4d97E8=;
 b=aPWCkmHd3q1kI6EdmJCqi8XkokieqnpbATkda2YXXQOvRhm59bhIrEMTe0MnG1MO/R
 3no9Fw+FTZIrh5sO5/XF9ybYTpK781IpM5Gwq4o75PMysCiOuPle1vf0MOcjd7rCqVhf
 ckeTQ8VIU60w7Ln4TWUG5ES65NysDnlMr30N84xgoSqd0SQfN9MqdJc0aSLUHR1Gyb0d
 ZDucVpFzzwfEckYpe0LH8in/MSwvGdTuh7WzzfLbSC5/hFiK4T0hKCOHqxhIJ5QHS6tG
 iztLhxR1Zg0nzUipmqyBIYbrf4018HwFBYNx8rqD/cdh3ZKGEhbCw7FkBSABePEmAv9O
 +sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876930; x=1746481730;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=joIdpFXzIkNPhFP+wCOvHfKzdfABNtuAjQU1o4d97E8=;
 b=onXvV7PbtVNGkacXaym6agCrb0Xtj/pztolFieRzZacrGtem9Kzk9WbPQ1pUBZi8ZE
 qmpnirl3G9umhpTjyklfnGAUy8v6VKix+X9Y10bQ3KKVs5TyfGsBe0Vvmb6+riMGFli8
 64A2bVI1gGXj5Fv1+LAF55ZWu6dDi79Vgkgbz3plILBChcZUh4CQH2dm981manf0O8Fo
 4doA0eJmIOa9qRAlBE9BQ3l6cvd7I2kFl3QlWmzyhAlpvtwq3q8SFHlcWig1/D0pLN6D
 juk0a0HY1ArviwzMEY4YMVI6Q3PMNThYLfsyNCM5zDQjN6snimRS620g+KgZGU4Sj01N
 P06Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQIOXfmRudoN9jFTiM0JwIzUUpohfq1osz93X5HkhVMRcugd0hCv5lU2vruwK6s0Ov4Up3i1fJ/rGM@nongnu.org
X-Gm-Message-State: AOJu0Yy5x+sfIuAhTjmxjiTzlLHoU3sV/+CU32Ektu6/Af76i7m26pIs
 Ijc7WcxYgXGVBuhLf99HKMLa3vqcWTTelEJbXGkRc4Jrgv6s56s3LSX7OqhlIzw=
X-Gm-Gg: ASbGncsT2cKcFV0Ve7oVV+tnj8uq7L+6+NW9VtAeEK5/orl8L54Xpfqg9pLfhYzBPOL
 5+FSBYNKu8w7Ar6pf/t7x5FiWoG2rkPh7E06AdLvdI+YQPZkM96r+w0hcVKCmBfR7hkgQBYYLWh
 ngT8Yr5Nv3SStBQvpHWdbhj2ld3ll1NFWkdCq7YNESQdEuwClb3qw+Cgx8zwqSVdBLxMeBfMjkW
 4tl0HM3RMd12zf0r3Ej3Mv3wt92rDNlS6kiaVe38cMjeC56HrgNqrbhMMB46drPnaParSnB8FNm
 4dCDtJbE0bUFVE56h+GSoscgVeNOgTecQPZcPSxJ+BAxT5Z5yOqcXi0O9Ed1AyB3
X-Google-Smtp-Source: AGHT+IE9zqE+J1loHs1qm+aAT3VuZqXHNu1+pO/J39DRPsr19WFg6z7F240J1zU2Qp5osLpNk8ArCQ==
X-Received: by 2002:a17:903:1a2f:b0:21f:35fd:1b7b with SMTP id
 d9443c01a7336-22de7030a69mr8559785ad.50.1745876929805; 
 Mon, 28 Apr 2025 14:48:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5102d31sm88523185ad.198.2025.04.28.14.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 14:48:49 -0700 (PDT)
Message-ID: <a29d124c-eab9-4055-b097-96fd4ab3b445@linaro.org>
Date: Mon, 28 Apr 2025 14:48:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] accel/tcg: Split out accel/tcg/helper-retaddr.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428201028.1699157-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 4/28/25 1:10 PM, Richard Henderson wrote:
> Move set_helper_retaddr and clear_helper_retaddr
> to a new header file.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ldst.h       | 34 -----------------------
>   include/accel/tcg/helper-retaddr.h | 43 ++++++++++++++++++++++++++++++
>   accel/tcg/cpu-exec.c               |  1 +
>   accel/tcg/user-exec.c              |  1 +
>   target/arm/tcg/helper-a64.c        |  1 +
>   target/arm/tcg/sme_helper.c        |  1 +
>   target/arm/tcg/sve_helper.c        |  1 +
>   target/ppc/mem_helper.c            |  1 +
>   target/s390x/tcg/mem_helper.c      |  1 +
>   9 files changed, 50 insertions(+), 34 deletions(-)
>   create mode 100644 include/accel/tcg/helper-retaddr.h

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


