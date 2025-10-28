Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2155CCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDfBM-0008K8-DL; Tue, 28 Oct 2025 04:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDfBK-0008J8-J7
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:35:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDfBD-0005Ep-ST
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:35:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4298b49f103so1906507f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761640542; x=1762245342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TtvsyZntfbZpHbgrqmfxrE7LT3mniEg8vYlsMWvcWT8=;
 b=ZmB1tHnU5C2oUcmgkf62S7KC4ptv89LDoqPOHXHwhMVFdv4I8jf47ZbTegwu/JIOnF
 fHXYPJSP9MRy1VYeITGNPZwAhcI4j4KxnbO0gt2NZjakswcsrc80ZTrOTWjFtfa9aYWu
 G8FrYRM95jhDjky8g8mNok34XeVtmlomRmMEHO6KyfZ1lumrZqInZvL+kjl6caiulj/m
 7jGHM55Q+z/9mWoFNS0dkhLdcokpQ8ku6sdoxZKRsI+y0XkRvhEd+qhqK2ZnrOcjQNhv
 15xN3DFefETsU9T6lGhHkoGmh6Fvi4Eo79vyQk6MTp9PUtJpdApmlEr8IeWV9FRbcswb
 0JGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761640542; x=1762245342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TtvsyZntfbZpHbgrqmfxrE7LT3mniEg8vYlsMWvcWT8=;
 b=ozlmzHX730jM6VZkEZqjm9POOg80uZV/DzhqQ4RJHpAt5Can3iYe83xQtj+0597mBS
 CDeaE+uYp0wQEhYq3RtjqEnoA2Ygwnw6D0Q8uCqamxW53RsMRsTpiGPub2wydxhMJ2tZ
 zWYg+L7YsUo+DpWWa+GzC3pP1x143FKh+W7c9STYNibyyxgJdYXd+VFa8D1Bx/fRwkjR
 ZsmcVdE8HV/R13T4iOHEjPJ5iAXOznlxelfSvFAf9f3II01AywDV11ZsIz8/eCVUndUW
 GeeqXuOi5XrW69HxUQZBsmhVEOemmFLKu+9ozH5Y8gM7dSfnVmaBqt+0CYbHA16rlATu
 zZ8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzE9z14A5A2yIzX5PtPXvi+SEj0v/NVP4M4yummKJ/hYVljOa252bKao6iai8lqHXr4ZSe0gTCe6mI@nongnu.org
X-Gm-Message-State: AOJu0YwF4ubJ5G6km1jMs5PTEzZC0YgeXUleT080iU5/kQPEm4UDYHRq
 YCIndwZjw60Kn6RUZDV6gRxjeX3yv8zRgtsYZM3iNAm5ntUD61h7pM0MaNQnDhDiKaA=
X-Gm-Gg: ASbGnctJCXvAO9MoMzEM6/GM1cW1sdL159lC/j/PokJm/y18CEZOvfe+Fbf5kJa4ylP
 Hzyba+GQqBAQxHxDvyakiAX8DgwETab6l9P9Zg6958F/b2kg+eotT1QK9x1K+VeaU/CtqcqwoyC
 M5EVCUK2qWG6fAtifK/weAw1xIAR3Rgw2A/j3sNgblaRZDWznSCPHlvehKZFGF7McDhd7XogkQ1
 zVLB1/0Uu4KzqYnYlBL8BZFoYbqzhp00uniUkUBtOgppYLhp/Y2NHW5/2zf1WXpP08q1ay0PVO6
 2RKSHYhcBZPkiE3pg7ED0Y0TKhaomjtaLh6d4Bhupn/sY+cwKX03dF5Jr9Iq/EHiduqYC2Jfj1k
 ZqHGqrI/0sP4shk+PwBR5iTQTEu9Dc0P8Q1o6FKcsduiJIuDczPozzuPmPTsJrfaRea+5FaWyQV
 w4UhXKObN7dg0/WmS+zcdhPZ0iYl5NCQ32MbqYDsSK1OfVlFn1
X-Google-Smtp-Source: AGHT+IFQmW2ssxGNqTKYsgAgM889WGfYqLB9PDuz53WLewOsRzD61FgrGyyzVXfGd8dSOcbgVlAClA==
X-Received: by 2002:a05:6000:2908:b0:3e0:c28a:abbb with SMTP id
 ffacd0b85a97d-429a7e4ec21mr2059923f8f.13.1761640541999; 
 Tue, 28 Oct 2025 01:35:41 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d3532sm19581538f8f.20.2025.10.28.01.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:35:41 -0700 (PDT)
Message-ID: <8d5a8cce-d769-4cd8-9753-7e9ad37d8a47@linaro.org>
Date: Tue, 28 Oct 2025 09:35:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/ppc: Fix missing return on allocation failure
Content-Language: en-US
To: Shivang Upadhyay <shivangu@linux.ibm.com>, peter.maydell@linaro.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 sourabhjain@linux.ibm.com
References: <20251028080551.92722-1-shivangu@linux.ibm.com>
 <20251028080551.92722-2-shivangu@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251028080551.92722-2-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 28/10/25 09:05, Shivang Upadhyay wrote:
> Fixes coverity (CID 1642026)
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA-SPmsnU1wzsWxBcFC=ZM_DDhPEg1N4iX9Q4bL1xOnwBg@mail.gmail.com/
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   hw/ppc/spapr_fadump.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> index fa3aeac94c..883a60cdcf 100644
> --- a/hw/ppc/spapr_fadump.c
> +++ b/hw/ppc/spapr_fadump.c
> @@ -234,6 +234,7 @@ static bool do_preserve_region(FadumpSection *region)
>           qemu_log_mask(LOG_GUEST_ERROR,

FWIW host heap exhaustion is not really a *guest* error, because the
guest can not control it.

>               "FADump: Failed allocating memory (size: %zu) for copying"
>               " reserved memory regions\n", FADUMP_CHUNK_SIZE);
> +        return false;
>       }
>   
>       num_chunks = ceil((src_len * 1.0f) / FADUMP_CHUNK_SIZE);


