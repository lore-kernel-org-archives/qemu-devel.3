Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7C5E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW1uQ-00079f-6J; Thu, 09 Jan 2025 18:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1uO-00079I-Us
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:25:48 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1uN-00034a-Em
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:25:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so16040985e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736465145; x=1737069945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r6b0hRLM814SNKqd+BfCZyrHbHQigp3DUDKVB+BSMXM=;
 b=PhJrw+AeO7sd1b0HGtmjBUFJLTpE1Oup8Phyk2+g2on+LM6YsCU2ejsLj9yWxZCjUH
 7mU9MaKv82vEX+XDpauxnPFKQqL75jZ1kcNJfNQyjz1JnAIQp18lTXPjG7bJhvsPo9Vc
 xW4okpUqJ15dp7bWgKAu5DJyUegkaYWphCSQOGnUPAn4GyXtt2OWi27pIK5iO0e9j3Nd
 tz0GP8uPf2qN+ndy5SymeJ8Q+g7NRvrG6+mG86VU0Ew9rXnwAIepRzRG79doU7csgKMT
 aJbSvLaNoAohrBqDKJy62mW/k/GpvsVGEftU2RUUlT1Et2MZMloL8pqs1dj+JrQJ92Uq
 De7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736465145; x=1737069945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r6b0hRLM814SNKqd+BfCZyrHbHQigp3DUDKVB+BSMXM=;
 b=uXY/yzMnbr5Ikk19Z+MvymcvGNDAXjLJ8yGmEuliosYDeQsf4mPYOL2brPwVIVk2Q9
 yopDRT8SdB8Nym2bVjtG/0qxSIa0tP0skm8H0QjN3jQHmteLeu6fVMunE4Eq5JXLnDkm
 vfqqJ6rxmoOInEyhhda09AU2OOoifMHAc1tubrnVu8k3qMM+p3g6e6vSvqrl4UZPeyNS
 9sjCH7EYqzW+vs0LklH+RSEQkoRPmm5/eEnMK2J0VDk8YJYuZcYiV3KJhpAHT++GISzY
 bs11jeiRTcJUILHfohu33qTypLwzrI4BqeO51iN5hqMrJcnCbOc4umGuSIJ8VF42OGJc
 w1fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVk/JQ6APgbYDKffXoi73282wXZJVS4VgyFz7sJN+UqeJiLaZDeKNLa6jd1vRhMGeAhAthm+nz+C1a@nongnu.org
X-Gm-Message-State: AOJu0YyCLEce92BhqhkstLmvF+mQD4z5DDgV1dAq4g7TFQkmXTLttANG
 tMviv5hUrPJxxdv4wHD39ego+dCaSRLoReDjqk1vxeqisVkdW7UnLvMwrcUsFFd+SppRnrKWDek
 rPpo=
X-Gm-Gg: ASbGnctkwlhvqt0HgLNJ4eqSIFduSs8eTdaPN7Bh3HhMWpmC650O9X0C0CrZihfcmtm
 eT1bbgm2WCNj1M0xZFxtdIcPs5vZQSACRLU5DjRCDEufewn7NEy03GB3ltr03Y8uIKMeM/CAk00
 VpjiHMCQyrZVtqmtFluIBKsdWcR290UYI09iFqS8bzv3LY8ADIYNU1hxr+wO926+M8rosqnfc+D
 7db+NhJFIGE2SHHStpNR7VAA65ta0HhbpfMFkgC1F9ZeXZdxHelyDp4hg485CtHy/CwyWq/JV5P
 Kl8HPH2onwtanZpXxIqo2cwR+rY=
X-Google-Smtp-Source: AGHT+IF6qqffqKFvuFnVfDh4vTKfLtH6Man2RIzYFzlBp9mQOdEKqDIaisoKJZR/Rq8BTC/jCPdf+A==
X-Received: by 2002:a05:600c:1c8b:b0:434:a852:ba77 with SMTP id
 5b1f17b1804b1-436e26a7e1emr87823415e9.15.1736465145184; 
 Thu, 09 Jan 2025 15:25:45 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89df1sm68022915e9.27.2025.01.09.15.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:25:43 -0800 (PST)
Message-ID: <b0d411ab-5021-4036-995f-1c11bb978a7e@linaro.org>
Date: Fri, 10 Jan 2025 00:25:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 62/81] tcg/optimize: Fold orc with immediate to or
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-63-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-63-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


