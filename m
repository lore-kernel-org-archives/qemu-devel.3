Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391C7C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 21:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttC8G-0001Fm-Sj; Fri, 14 Mar 2025 16:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttC8D-0001AY-4F
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:59:49 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttC8B-0008C0-Gg
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:59:48 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so269675a91.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741985985; x=1742590785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XZ3K2WbM6tltlOHPyd4FtoiXB3ISik49Nr6oU8A8zuM=;
 b=Urf8p12iU8NBxQ4fPCSvACEZFdcbPNKQjGkZsYV4ARTiKQv/YJN2TNYnqfHj9E+Kl0
 UQ1RD9fbOZ+U7j3yR0XD7Sh0TmxM2xCDdehzZTnsqAIHKPUmSOCBwS9r4vKsS2kaB3nO
 YH1KAmuBGVFs4ZkczZ6xSxhGe/9NvdBbJwTimc8MuRL9e8ki+oikszTmwqgN05DAJzKb
 82ZVXh9q1tw0LKmFMiCC87rpN7+ZZ4Ix0WJslsySmrqU0JqX6VEcEIZkGlcHZ/nCI26+
 Y+FNT0tyNpeYGXK8WwBmko/rIWICFwzKrgNYG92pX11ar+zHO8d9CuoVTSSTvhDk6AAP
 eLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741985985; x=1742590785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XZ3K2WbM6tltlOHPyd4FtoiXB3ISik49Nr6oU8A8zuM=;
 b=FmsVNcdJD6jbOXZvEBkGc7LeYegiXeijp9ENEwkz1aa3H3e6Bh0/wnzq7O/CW6CvQo
 iusbrigAuVRi33Xrsn/4BGGFqnSl9tBr1o4Z0dUFw7edkyRjP+qfMmbuB8ZNhxeyuuir
 3cn/CHiri9JAJz3JtELqcTpuHKkF6kgYOtdzeXBOaQ3GbJMULdYcq95JfjGOhMS4wmkI
 UFy0Lq5NhQT6q0aGDwJ6hfkCgWVqQcU/hDloPEujmZSDglJrpIgPR/IE+Ct9C3pftztQ
 DxXAVEYcMeHeBwuxBUadRfB/BQ4vVX11P8doh1fZ+7lxKAOJ0Fq8KM+OHra7b5UT5Y23
 m9Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSt9x8pUr7ToC/Z0OScbsanmrKcMEwFmn2/GiiXaOyMXlhPuMtGOYZVV3zZKGEyg9mS+5mvSGvvywv@nongnu.org
X-Gm-Message-State: AOJu0Yy5+HCPV+pakXex8TB7QJaZxECqL0h814HNgbiYUcrTHX6u2xLx
 eG5pe9u6Dmo5zjhlbqAuqDADWlhQUm7+lxIQc/wPkqijpxRHxHgHSskPIU3AXYg=
X-Gm-Gg: ASbGncu9jH3FilGF7uqHY8y3Kdy1/I34kwtbyBz3PigQUZKqDC4BmYtjh9ZB8udEVDW
 p6KAcn61yc6a4LHZrWJ+xzW4v0Ag4Owm79z/0uEIOVtIjFRJsYgmbVF58LL0osu+s2PAzuaCnre
 DPqRfGanJh7YPIN0FAGJojNr9BdvOFmvi1iU1TXXG8HnzRc5COgcH4Nj6nRuTjO5OUoKMVpRyDr
 vqg7OKuU8mmjKvyypbfv74ckp9k4PQJ/E2gfuKJacGvU56thKe5u18rouTFPoJf8NJ4+cFM2nWE
 fcgzmNY+YOW3n0xtjz5GaHKH0sPixkE9JLG8E1g1dhq1VTEbPLBM/kIiXzlTwmA7uXbuN6a1aJr
 MJ2nTufym
X-Google-Smtp-Source: AGHT+IFXF1yDzSMsGr8yjoge/4OKEieRnB/O148epHfxjfPZkpUvkQiTlcJEDxDV9x6q1wk8uWp7Kg==
X-Received: by 2002:a17:90a:c2cd:b0:2ff:6f8a:3a12 with SMTP id
 98e67ed59e1d1-30151dc7542mr5362316a91.33.1741985985678; 
 Fri, 14 Mar 2025 13:59:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301539ed074sm1466187a91.15.2025.03.14.13.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 13:59:45 -0700 (PDT)
Message-ID: <7f10a102-5cea-4543-bae0-927e89e8e471@linaro.org>
Date: Fri, 14 Mar 2025 13:59:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/37] include/hw/intc: Remove ifndef CONFIG_USER_ONLY
 from armv7m_nvic.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-33-richard.henderson@linaro.org>
 <7f665a47-2bba-4c3a-980c-a252ec44723c@linaro.org>
 <807dbc0d-db15-4bd3-95f3-b3e87951bd7f@linaro.org>
 <42b1f9f3-2ed4-461b-9460-0318011097ee@linaro.org>
 <e3d39823-734e-4186-95b6-07717663bdf2@linaro.org>
 <ad7cd476-1830-4806-b4d2-20d8456af849@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ad7cd476-1830-4806-b4d2-20d8456af849@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 3/14/25 13:34, Pierrick Bouvier wrote:
> On 3/14/25 13:03, Richard Henderson wrote:
>> I'm not quite sure what you're arguing for here.
>> A build-time error is vastly preferable to a run-time error.
>>
> 
> Even though this specific patch is safe (code calling those functions should be under 
> system anyway, so it should not be linked in a user binary), I just wonder if we should 
> not add explicit checks for this, for other kind of replacement we'll have to do.

Any such runtime check should not be for "system" vs "user", but for "feature enabled".

>> If it's a lesser used configuration or feature, a run-time error could lay dormant for
>> years before a user encounters it.
>>
> 
> Sure, but wouldn't it better to have an explicit assert, instead of observing a random 
> behaviour?

What random behaviour are you suggesting?

> I'm just worried we end up calling something we should not (user vs system, or any other 
> ifdef CONFIG/TARGET that might be hidden somewhere), and silently return a wrong value, 
> which would not be covered by our test suite.

Where is the wrong value going to be returned from, the stub?
Yes, many stubs do abort, typically after the "enabled" stub returns false.

It's still best if "feature enabled" is compile-time false when possible, such that 
everything after the feature check gets compiled out.  At which point we don't need the 
stubs: they won't be reachable and errors are caught at build-time.


r~

