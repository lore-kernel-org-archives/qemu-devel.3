Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63515D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5oOS-0001hj-SZ; Tue, 29 Oct 2024 11:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oOB-0001eb-4G
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:44:11 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oO9-0003Qw-Ha
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:44:10 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3807dd08cfcso1383641f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730216647; x=1730821447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wGIAGL+K2YhfbwDGGce5YFPS2T80KhcXRQ1sR11CI9I=;
 b=NahO7xhVGiDzoXw+V9zxTyyRWOC654nWZaBANnafR8DjTsh/xIKMqOljwJ3nnIzIMt
 xz53JaQvohVvc7rjGrgsydfc9ilYSb8hw6HiA30LIqH1WLqBCHj20vmlTIHKV7pWKaoA
 4+SLeCdvfkNiLSo3LOKyf5hDHkr7OGGfy7aclv7pNo6LYj3UmiXRdg7mgcYcTWPoDLM2
 DQtgbW13ZCMfNJTQrO3XbwZYO6TZ6felilzF1l/1x2ES0FKZjs8GzI51fefCTCvUCZNq
 UP639/N5pA5gYo9cLRL6i+APYZiO40McU6TCN1bF9dmII4Ar5p8LqHGiqwfCzNYy6K3f
 cidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216647; x=1730821447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wGIAGL+K2YhfbwDGGce5YFPS2T80KhcXRQ1sR11CI9I=;
 b=CAQQCPfAUBTuWaLsdLcySJFZDj7z6wi9etObkGqaIBeatT5e/s00YQvZECWYFJAAjn
 ksQZmdJvINbWY4t5WzWVcpAjuMBbftPxoQyQ7/2ODScqcTVOZ4N4yxq4mj72deHTUgvZ
 dRwfuppxOXByHK4vML4gvAQVSsXxoiRre6PX7sq3FaixBivrZXcrkqH1Q5Ex1W9Jut4a
 1a1+0zX1yTDPK0g9vmzLO2GY73sypDLYmyBrmciKf1arjm2yq/5aLe23HCMYjgpwoUDB
 GC+Bv714VW/zg9gPXyoCoP89x8Faazh8g0xHhyrWWgTRZoEJJ4SRXSHWD6eDqhhia6n5
 WeHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuYknM/q7v2t2enq9mRB86WE5o3M/MxSsRkfg7r9iQHbojKS+WDhX4F3nIuWHBtHnrs+SxsMmPb3N8@nongnu.org
X-Gm-Message-State: AOJu0YyR9rl8KbaqCZrGy8fXnaf51B8VurKWctQyXpXwzhEuhD3g8fMz
 gLpkpFxAeyKSM6Lh6CMD2r4QDQi6SyH8YC+RtuKOvDTZNpVxW7ixQgXpflibRvUjWnc0MvnkyKd
 p/paHJQ==
X-Google-Smtp-Source: AGHT+IE/4lFblhfJftDw8PKzIyT2wjv2VoDirZqyvRPEaNnigZiS9K7lo2JJf9wU25JohxG2LRC/IA==
X-Received: by 2002:adf:fd8e:0:b0:37d:49be:9581 with SMTP id
 ffacd0b85a97d-38061228488mr11014119f8f.37.1730216646986; 
 Tue, 29 Oct 2024 08:44:06 -0700 (PDT)
Received: from [192.168.21.227] ([89.100.107.89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193572932sm151470365e9.1.2024.10.29.08.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 08:44:06 -0700 (PDT)
Message-ID: <ebfbb7a1-b8dd-48dc-8540-bbcacd938f35@linaro.org>
Date: Tue, 29 Oct 2024 15:44:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] target/i386: add a note about gen_jcc1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241028151851.376355-1-pbonzini@redhat.com>
 <20241028151851.376355-11-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241028151851.376355-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

On 10/28/24 15:18, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


