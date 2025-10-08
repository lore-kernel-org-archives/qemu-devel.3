Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D6ECCD187
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Y0Y-0005Cc-S0; Wed, 08 Oct 2025 13:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6Y0X-0005BW-G3
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:31:21 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6Y0P-0003KM-Hf
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:31:21 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso78146b3a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759944668; x=1760549468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pxnCFCBudtDODB23ss7bR/+MC7Me2ifwO0zlSvqntmo=;
 b=h4MyIHeMvf2Wr2P16WFEOK+3jXF67liG1bvfOqEpwHPjwJvs6NR803yOA8e8M8/DuR
 v99UgvtL13uAKvmoj76lzFO/6tbrEtg424O0mbMY1FTlj2jf/gc70qHDqN/k4pgPF8B3
 7f3gcs0bq906n5HKiZo7zW+PCtRMXpo7H1f1+wd+QUnQMzVmbfYocreIEy7wBLMuykMM
 1ruEWvsHdKI+iq6u2TI0LJdr5Oz4gwdKtNe/Rfs9OdNh86tMGpSnFS/nYBbr4M5H+IhO
 XjhumdyfnV8c3+7cqsIQ3FxmVJLUaLPaPO9GE02uUPHTqrVv6cIKqNAjgszuq9CJWa75
 ZCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759944668; x=1760549468;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pxnCFCBudtDODB23ss7bR/+MC7Me2ifwO0zlSvqntmo=;
 b=OA95bqNSQ+nk+AY3jBfb2XJqwi4fmj6z+FSZ756X09Inmtd/q5Iq4N465oW6sND42m
 RI5yQOra9SuvCKERGMxJebqOSvQI9ukCx6qNTdfd679RrU35T9TqBlGjVLZGGIIJMQPw
 f9sK0HFjpK3Y5hQkWKrXsjsjqDHeuGVfro+m8cgpDe2rC+t3ulOhRtNvSTR4qLld+kQe
 2fcT7du5FCb3/U+zG3MUx0fca8Unx9kASkJkf38aUsMLK2oTFz7eBuqHi+Tp+5DMnnlq
 ZMvtGpiwVVLFd4KBwYJx9cjeqJCsIYQ9DErzj0G+pq6fwOOgfU8EHETkjK8bFI1ezPmC
 pf1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEoyHXUh+9wFheGFIoeouRcIssyseuzH/UCDPftDsXk+D/4BOEh/0Qe2PIgMuoOXAAzSXZSCFe8H0o@nongnu.org
X-Gm-Message-State: AOJu0YwXaB07EIVxFPzMKMAxLg26xtJz6cD4nsClg7VaVjbkyrmlbkBj
 72EHHt5pzuETnbn6tSi3UOLo0ib2Z7BASv6WjgkpYCjcBrFxm30CBrC32PtEKy0YJ8psTsOwsoH
 NqFegTeE=
X-Gm-Gg: ASbGnctrL17/j+AWXVD1kDWr/YF3ioiRklI5oX/YcoaaD3blwULw2B/oTT8aVjy8YOm
 bb76jWpz5WMeXXTxaNxL7WPSC1+9WwlsyKoWWGU3Z+xIq/3ZLrb8us2AIPTKChEpqV69ijnxkjG
 AnqkJIpqtmduRZEc0m998wUbOjNsvFvtpz8O8YUhVU2Wo2/wVPYblMzKUSKTYltl70W6dCJ9WWE
 pvk2Yd30xdeEZRIpUrQCceDv2189c9TIzV5U3U7t2+ix/3lkbMGttkUjieCfLv8VC3fAYKCRpfK
 8xUfdbRfgigJeVMKTcwbz4j1+zDVbNIPJTDD8r0SI54K3hiMviAZl7vJ3dku1mdSAsKIGGXomKi
 qDxDxShnmrmxD1xRj5S8jf/pydSs5aBWHx4eTOhefAWyATYjBqol1A5Ie2P5uRDw=
X-Google-Smtp-Source: AGHT+IH/+nyZogA3xLWgyglyQrEd6s7JdTzliGz6Fosf4Y3yIuihYLFH8+rtg5qZ0cjOUHBOZdByfA==
X-Received: by 2002:a05:6a21:328c:b0:24a:1b2d:6414 with SMTP id
 adf61e73a8af0-32da8154248mr5545983637.18.1759944667680; 
 Wed, 08 Oct 2025 10:31:07 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b5137dea8sm4079473a91.13.2025.10.08.10.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 10:31:07 -0700 (PDT)
Message-ID: <5b420362-f067-4e11-b732-c8a2b9b998e7@linaro.org>
Date: Wed, 8 Oct 2025 10:31:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/microblaze: Remove target_ulong use in
 gen_goto_tb()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251008060129.87579-1-philmd@linaro.org>
 <20251008060129.87579-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251008060129.87579-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 10/7/25 11:01 PM, Philippe Mathieu-Daudé wrote:
> translator_use_goto_tb() expects a vaddr type since commit
> b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
> translator_*()").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 5098a1db4dc..ff33e64a710 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -116,7 +116,7 @@ static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
>       gen_raise_exception_sync(dc, EXCP_HW_EXCP);
>   }
>   
> -static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *dc, int n, vaddr dest)
>   {
>       if (translator_use_goto_tb(&dc->base, dest)) {
>           tcg_gen_goto_tb(n);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


