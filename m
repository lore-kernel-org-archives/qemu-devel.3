Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207F1CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENzU-00058N-Nb; Thu, 30 Oct 2025 04:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vENzS-00057x-9G
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:26:38 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vENzH-0004UJ-OM
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:26:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso9276765e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 01:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761812779; x=1762417579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IMpD1IobNynpgHW9PQ36c0YaL7XHeIDV0yVw7+C9h08=;
 b=dgcQCE0GPonFesZ5zGlmXe1QNxzwkq0VdqVx8TxAzFmVZLARarr0MFrrsvK95MEVMO
 SmGlN+rW4MhcWltVrzLPWNWty8S9QIiHYY+rA6EFf1nvFo1/ADjPHFA8VRecKMc/a+Op
 O8pJGiIqxsFVuf6A87ygzDm07NkeTJNCBLSZMh4BaIqtBdcO6jXR8XmJ6Q6v+I4oMLui
 xzyKiEPSKc8Z+3I6xRJ9OUJX0oLFtMCxPIAdUS0z4wk4N2l/et9nlSbo5G/zblHbro9Q
 UmPLIyCVsDYHLyyOCkbPbYJWp3AbguojF4rKOflIE96bf6lqZsfQvV2oQ3qek6QitC4b
 I1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761812779; x=1762417579;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IMpD1IobNynpgHW9PQ36c0YaL7XHeIDV0yVw7+C9h08=;
 b=igcHEr2hEKMhAD3xNCAYyrOWn3gl606RWysJua2zCouyo/NhYrvGzCtygzYVxCVsWo
 lU5JQNjpx63VDwpf1d6Zuk5AMBgy6KvJvzPrQ7jup9CIjfWpzsLUh7oOxTtE6H46l17k
 3srKHzI67KX2/XkRzRZEHN/LWe1qfX3R3E0xcI0MZUU/o9EkF8mIwinR+7fs81lECk/M
 ryItBWRh4xB3MOp5UwEhgYVO/EGKUCW5D66fUCYWItC4YYCOyI5YYIq3SM4Wa9OKAzrb
 /O+AUxu5Juw7vtLkc3INvepQu5bDElRT6Bxdh4Uag7yAyIIUrE53lhzFZUHIR/cz38iE
 JQnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU30zmzw2v5LbU7YV4jG2JjQIdsUNbUAwMjvwc+RyWHcO6cF6LOZN5Gmz8SgLKD0H/lYST6MFchs3eB@nongnu.org
X-Gm-Message-State: AOJu0Yynhalernp76CFqVtefay8NMe1YgHmT5anyyT/T6Isdcy/E8NTq
 H0YvzyI0hAJ7cVIPUcX+ndIlmYAMrb3r3NvB7A7ILLhyO6n5R1S3pmL9UjCvosy8NMM=
X-Gm-Gg: ASbGncuOSF1xM7GC5DLBbBgYhLhbWg99Ksl0YJU8ZIFA+lUH/rkjypORBgGG4FQVvz4
 7DbZENcvtPjeMqTS/b9iIQpgmNDG75nl8vieQHaOuAxTclRKmhgNPodQSMBgS7I0RQyQPXULqNP
 9slDbSRfLqxFpyBw85VKwuNDc6dmSBKmPp31ztllPEUoofjlsFMzJug1sEmE2P6cJzhb6Ve8TxR
 STbkBb3AG08huRAJXtqw7kHA1Lef/YDhIei3MFyEYzNsSKXugz4PN+vtRoIc8R/PwfbpO6diyx7
 kpNYwVmAMXSiC0gLxN7KGOXFk31yXMSfvF27s+rmN98B2q4/eaeXJOj8yWVAc30XP0ox4QtVGRZ
 fWPnCVVdHQRwgNsXn/aTWlDvA6N1uwW88170cVkbHcaEHd/rA6bVAMOpy9x+T7Kjzi5jM3bFUf/
 vilCoBjXu5+9aFSiCkRgleuAutSRO3ehWR1ON6mcOF9Wc=
X-Google-Smtp-Source: AGHT+IEh4zrV7iVQg6ymaQz3H8FqUu9848oDWMIppJT+NESVwUtvMZWTvrYauYcUXXlVJt4nPtocIQ==
X-Received: by 2002:a05:600c:1e1d:b0:475:de14:db16 with SMTP id
 5b1f17b1804b1-477267f24e2mr18497225e9.25.1761812778653; 
 Thu, 30 Oct 2025 01:26:18 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289998f3sm27051575e9.4.2025.10.30.01.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 01:26:18 -0700 (PDT)
Message-ID: <611a9905-f01f-4b28-afc7-b73faadc4546@linaro.org>
Date: Thu, 30 Oct 2025 09:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/core/loader: Free the allocated string from
 size_to_str()
Content-Language: en-US
To: alistair23@gmail.com, alistair.francis@wdc.com, vishalc@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20251030015306.2279148-1-alistair.francis@wdc.com>
 <20251030015306.2279148-3-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030015306.2279148-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 30/10/25 02:53, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The string needs be be freed with g_free() according to the functions
> documentation.
> 
> Coverity: CID 1642762
> Fixes: f62226f7dc44 ("hw/core/loader: improve error handling in image loading functions")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/core/loader.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 1598dca03c..e83d245202 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -153,8 +153,12 @@ ssize_t load_image_targphys_as(const char *filename,
>       }
>   
>       if (size > max_sz) {
> +        char *size_str = size_to_str(max_sz);
> +
>           error_setg(errp, "%s exceeds maximum image size (%s)",
> -                   filename, size_to_str(max_sz));
> +                   filename, size_str);
> +
> +        g_free(size_str);

Or g_autofree. Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           return -1;
>       }
>   


