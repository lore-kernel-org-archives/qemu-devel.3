Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F811CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 19:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slD97-0000xx-Na; Mon, 02 Sep 2024 15:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slD94-0000wy-Oe
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 15:55:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slD91-0006gQ-G6
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 15:55:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-371941bbfb0so2944513f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725306921; x=1725911721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6OYk5H/64/a6pHEKQ2Q7Gqfy9ogtkpUw5e0fdfG20z0=;
 b=ztpyL5wWP6KJ7ldveUn8flwxg/PHDHr1ptjhl53VTIi6M6wTe1RwQM/JtPM2c82F0Z
 txWCOR9vk+PrSoL4cL0DbWAkK8krzZA1/6PBFq+7iPc+Ed2/5IYvWccALqcrKfciiMkO
 J1sKD5GjzMBZXluYVI97IC0/J1SL6Zf5rEIoFvikrwFHb8ZespjN2NtoNcJBNZfoh9Dl
 umXKHnGz+75I2E0XPfI6GNasJ18DkgDKfqhmBCU87xR3vpkuxojXul2Gz5UIt27MlwLb
 QbD/fHUV5/rdytOWhIT7SNtCiLmrystgm1d7+rsn8BkDI0zXUrgPHU9YpmnyE8plEoLU
 J8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725306921; x=1725911721;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6OYk5H/64/a6pHEKQ2Q7Gqfy9ogtkpUw5e0fdfG20z0=;
 b=H440qE6epJNck5kSfeTvN6aKvccJBRbtdNWkfYHd6pwBb084i9RRR2rG6Jo/4X2Irc
 u9XbcjYPNdDym1kna53UorjYdXu4rIYnlCP/6LpR/HKjWHqqvp6E+EDML+t9MYeZpiny
 sPtBKMjUlyzKDyaFE4GzJ/RXfn5Nfk6F7zrJd2Yb2NuoZ3EvS7OhSI6LV6drCntI/JAr
 VFz560lJRJEu+VA6m11/qwjqJAKsSnolzYzL/c5nJ+wf6k0VW0chguRsZYf0a/10ERE0
 aHeKD/iJ71Wk5Rp6xzXwiHe21i3Z1s1xeimR92bOqHFAJ2e4dF9XxLPoXOd1rvKpGGOk
 RVaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZn9hIIY4dq2TnkAorkKdXd3/IR7IBHU173dB6VJeGy5tTgz7WPx3VYLIY4boOFobg8YqgNrcjjSki@nongnu.org
X-Gm-Message-State: AOJu0Yz84VNukzCvGUDTWiKbd3ub06CIre/ynrze+yaUSrlFm/KezGjg
 SlMbtjC7SkNFmCNJpf6s9x69zXsssOtGLbNu7SDexPNQLEB+hVEJ+sdmxFMJVHk=
X-Google-Smtp-Source: AGHT+IGS2J4ZOq+kznLyouCG6K98X7oHLSHl0GDOlXkAQwYE04cneK4P4etelnmwl9OWUoTjZ0AysQ==
X-Received: by 2002:adf:e645:0:b0:374:c942:a6b4 with SMTP id
 ffacd0b85a97d-374c942a842mr2544212f8f.20.1725306921276; 
 Mon, 02 Sep 2024 12:55:21 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ef7ea08sm12206215f8f.68.2024.09.02.12.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 12:55:20 -0700 (PDT)
Message-ID: <7c67704e-a067-4b6e-8acb-51b33cf17ee0@linaro.org>
Date: Mon, 2 Sep 2024 21:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/boot: Report error msg if loading elf/dtb failed
To: Changbin Du <changbin.du@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240830105304.2547406-1-changbin.du@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830105304.2547406-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Changbin,

On 30/8/24 12:53, Changbin Du via wrote:
> Print errors before exit. Do not exit silently.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> 
> ---
> v2: remove msg for arm_load_dtb.
> ---
>   hw/arm/boot.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index d480a7da02cf..e15bf097a559 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -839,6 +839,7 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
>                         1, data_swab, as);
>       if (ret <= 0) {
>           /* The header loaded but the image didn't */
> +        error_report("could not load elf '%s'", info->kernel_filename);

"Could ..." (caps)

"hw/loader.h" is not well documented, but it seems load_elf*() returns:

   #define ELF_LOAD_FAILED       -1
   #define ELF_LOAD_NOT_ELF      -2
   #define ELF_LOAD_WRONG_ARCH   -3
   #define ELF_LOAD_WRONG_ENDIAN -4
   #define ELF_LOAD_TOO_BIG      -5

And we can display this error calling:

   const char *load_elf_strerror(ssize_t error);

So we can be more precise here using:

   error_report("Could not load elf '%s'", info->kernel_filename,
                load_elf_strerror(ret));

>           exit(1);
>       }
>   

Better (but out of scope of this patch) could be to pass an Error *errp
argument to the load_elf*() family of functions, and fill it with the
appropriate error message.

Regards,

Phil.

