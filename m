Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381D7C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thV6y-0006IN-8T; Mon, 10 Feb 2025 09:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thV6v-0006GQ-I0
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:50:09 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thV6t-0002ju-LC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:50:09 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso49936805e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739199005; x=1739803805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AbEyidvJBGkPGF2YI7GSDkLKFmUfQX3zxKwf0dPK170=;
 b=hKmNUJGjXeL5Xk5Vh2y6eRQ0eF5hG9i2flTKq9iG5neTnvp30TsODjIqF4wfUXKVAO
 IxYTWiyutjN+l+NjlBfHb7ZXjlWsGLJ1VU/JQDFYcii9cJZcxNGp50kBAFIzTh3x03qx
 cX8Dd18U/KC7Srsrwde7NQC6xc1I6IJfaDLrZ3Y2ddxq29g5zMePVoEZ8gXucC9tsSt9
 BO/QgYF8mqFS4BuOdTY0H7BJiyKiDFFdRYdhGIYPcurEo372QIbQ7nHG2fGvLPIzcDLY
 eoOGtnFic3CdGCUBFYM6sngVMRYkpOqCg8J8JeusysEpoc3DHkDxmGd7VpoUdP4of/2W
 gWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739199005; x=1739803805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AbEyidvJBGkPGF2YI7GSDkLKFmUfQX3zxKwf0dPK170=;
 b=EBg5ZfQyZZMXKsJEvZVTYLNF1RCCZ037DNmPtogZxlrfROs6FjTLB0dYdn4n3unZUe
 UPhWSSQF1LguT2BNoFCHk0TCfpDWkkpV8VO5RT/DdE4wmUW72ZPBRqtJVD1FhOMfPVFw
 Xi5XoWoFPD2O5uNdeBF5fCCLMADvBKQNpZjsBGtLuq+iIgnSvq1KTxrpJtktZSPCvZOz
 CBkcEHIkZbimSjOQyA+ZXqDYoNKto644tmYyUTKVWzDvhbzllGXJP495NHUo3IvGdAdP
 He2VnAR4sjaVFSlmmQxkwN/W1bWsYGwuFB9Cs7z14z4XKabo7Ua3IadKMUDiY3JkCLxg
 FIAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb9U6vhEPc0a3mSaonVbu419yKLrLqsuIr5nYxszxo6kFxenjLzmQwWbgD9Uu6KX7vAW9Elm4jY3Oo@nongnu.org
X-Gm-Message-State: AOJu0Yz+321BCg5/r61b8+zDdm7cekxzTl+quT5jOfXpcuoQniHdHN3b
 AT/ShRNarmjY+bgZKa3ufFJLjoOmMqkBBOKXjol7nYbVhLjxC+APqLfbO24iof8=
X-Gm-Gg: ASbGnctFjzrK5CVr9jTSN/odNbnDHw0bokDeTZ3hKA5cgaglQe9gfus0T5uay4COYOT
 ocJiQuEIi7o0ncWwf2l9RLQHWcV0NDDlS2Gz23CMApLi9OYKq9wbJGK2iUBrLymhcWN1vrpz0sM
 7jl/FjIAQa+cDGumgSztuWyBEygGCdwRwbZCTjl5tETRzo2jkH2PzlR0GxzZeCYh896h4Zcg4id
 LjVEic1BfOxjBgpw+Eewpi2SNt9TwT/Azj4f1rXeKoT6/m3CW3DeVf2pGUNvMKDeODni0jN+9PQ
 uI/B/d/Ouwn8mUk5l8yy33lV8vKLS1NxEjMhW+fbY8aiUejP1wp7+5UnevA=
X-Google-Smtp-Source: AGHT+IH8Dyjm4nrusW80geQnZfgroldk4zxGRiKQt7Bzi6yWw26SPUdZZDKepVWbZmlc9+DxJszvig==
X-Received: by 2002:a05:6000:1fa6:b0:38d:c364:d516 with SMTP id
 ffacd0b85a97d-38dc93528a2mr10695957f8f.54.1739199005479; 
 Mon, 10 Feb 2025 06:50:05 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf4480sm183236735e9.27.2025.02.10.06.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 06:50:04 -0800 (PST)
Message-ID: <c3948f21-bb30-4d43-9b8c-9db1c41f01bd@linaro.org>
Date: Mon, 10 Feb 2025 15:50:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/17] hw/misc: Support NPCM8XX CLK Module Registers
To: Hao Wu <wuhaotsh@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com,
 titusr@google.com, chli30@nuvoton.corp-partner.google.com,
 pbonzini@redhat.com, jasowang@redhat.com, alistair@alistair23.me
References: <20250206221203.4187217-1-wuhaotsh@google.com>
 <20250206221203.4187217-14-wuhaotsh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206221203.4187217-14-wuhaotsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 6/2/25 23:11, Hao Wu wrote:
> NPCM8XX adds a few new registers and have a different set of reset
> values to the CLK modules. This patch supports them.
> 
> This patch doesn't support the new clock values generated by these
> registers. Currently no modules use these new clock values so they
> are not necessary at this point.
> Implementation of these clocks might be required when implementing
> these modules.
> 
> Reviewed-by: Titus Rwantare <titusr@google.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/misc/npcm_clk.c         | 113 +++++++++++++++++++++++++++++++++++--
>   include/hw/misc/npcm_clk.h |  10 +++-
>   2 files changed, 117 insertions(+), 6 deletions(-)


> diff --git a/include/hw/misc/npcm_clk.h b/include/hw/misc/npcm_clk.h
> index f47614ac8d..8fa1e14bdd 100644
> --- a/include/hw/misc/npcm_clk.h
> +++ b/include/hw/misc/npcm_clk.h
> @@ -1,5 +1,5 @@
>   /*
> - * Nuvoton NPCM7xx Clock Control Registers.
> + * Nuvoton NPCM7xx/8xx Clock Control Registers.
>    *
>    * Copyright 2020 Google LLC
>    *
> @@ -21,11 +21,12 @@
>   #include "hw/sysbus.h"
>   
>   #define NPCM7XX_CLK_NR_REGS             (0x70 / sizeof(uint32_t))
> +#define NPCM8XX_CLK_NR_REGS             (0xc4 / sizeof(uint32_t))
>   /*
>    * Number of maximum registers in NPCM device state structure. Don't change
>    * this without incrementing the version_id in the vmstate.
>    */
> -#define NPCM_CLK_MAX_NR_REGS            NPCM7XX_CLK_NR_REGS
> +#define NPCM_CLK_MAX_NR_REGS            NPCM8XX_CLK_NR_REGS

This also breaks vmstate_npcm_clk migration.


