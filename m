Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A0BEE01FA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 01:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soCOL-0000HF-Vq; Tue, 10 Sep 2024 21:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCOK-0000G9-06
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:43:32 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCOH-0005Ef-Ps
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:43:31 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso4417068a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726019008; x=1726623808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YQWpPexpBS2I0pThjgcD6HLRrYJV4ps+4McuEYnewnw=;
 b=Ursz3VYcf9tXdEwhZi9J9mI7I1wnPzJeyBg6E2p8uToAMzhpPgh1e46CROSzoakWvr
 SKh7T1bamr+C9MBUHuErcs8y9kL642UST8ldqWO//NmdZ+KGJhUE8hCtW1Gr/8J2B+82
 Pic6jpboNQVyH8W3eb2yUox4S6bXIFW0nlAn7BHJ2Hrl3vYqsA3AojaoVQPlytWmhmz0
 5qPlVIB4ZskqD8GBFsIE7z7WH5CwvREcXeeX6GZKW0sutt5r+21bzifz0fpVMzSBpZ4B
 cuv1S4xk7yP8mHNB4uzEBSuKtdSjq6efgzMmYdD0ZvBLzpgauhBuEmg1evFBU18aEYWx
 pP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726019008; x=1726623808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YQWpPexpBS2I0pThjgcD6HLRrYJV4ps+4McuEYnewnw=;
 b=OB8mPkKP+/j4rDA/8E/R+Oz4QIOS6v1YFn6uWOHU84onx78SEkEDb2cHaaJzOwdWro
 Ddssp7Vpj8/I9grpsS2Twz4Du9J4y0U0LQnew5Eu/F54edmctRMc2TnvTo6CWw2uiP9Z
 7LjzNQ/YeFkBy2Ureo8bEn2/iSzL5FqHLkK5GXKgAraDgiUx4qTfOZpKheEgMFpG46Id
 dSPykitf/B6FhgJfzQArqV6rJjzC+A5vNmpRkRjcDno7YrXmM4zFUyTSrAqxhHk40XQB
 dCHX4crrrIiG03tMI4r9sEakvnBC3ibu+4Ar58Ie3IZRsZkt20eiU8D+S/ITm7alpZQi
 Z68w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhOv1WVr7BrU4Sk5Gbrp1YB0c20LyzEe1Bz5VVbRC2/MFybb2em4lM35FuAQbEeQ01F7byvvBp7WUU@nongnu.org
X-Gm-Message-State: AOJu0YzDneXfqPJIdhHHcutViQ9fIplp+nA5I8w5zHQr0du8J+82gUCS
 Hb9R2tfOuiyGZUbXUKG+ilOOgSkA20NWvL0K8ELf9dhrkBF1SDRpdS14nUmFfj401lE4BXGmOhX
 D
X-Google-Smtp-Source: AGHT+IFgATdbhdesoPUsWdjylIGm7LVjdm2WoEvSJRE9gVy7oBmhMTNDQOs9YNUbACRygmrbsLtdkw==
X-Received: by 2002:a17:90b:2644:b0:2da:8730:5683 with SMTP id
 98e67ed59e1d1-2daffe292a1mr13988335a91.39.1726019007856; 
 Tue, 10 Sep 2024 18:43:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc014a58sm9213686a91.17.2024.09.10.18.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 18:43:27 -0700 (PDT)
Message-ID: <28a6a09a-c288-4b89-8d00-4f6a307e0bf2@linaro.org>
Date: Tue, 10 Sep 2024 18:43:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/39] hw/core: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/core/numa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index f8ce332cfe9..14283293b42 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -380,7 +380,7 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
>           }
>           lb_data.data = node->bandwidth;
>       } else {
> -        assert(0);
> +        g_assert_not_reached();
>       }
>   
>       g_array_append_val(hmat_lb->list, lb_data);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

