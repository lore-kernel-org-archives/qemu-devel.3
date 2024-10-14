Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DADD1812F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Nzf-0003DA-4U; Mon, 14 Oct 2024 12:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0NzX-0003Cb-DI
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:32:19 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0NzV-0000u7-V4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:32:19 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e2e23f2931so3312793a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728923536; x=1729528336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1PrQn+uWeoZZP3OGAh+vxfmzh/N4rXkfXjfPzHNbc4U=;
 b=PrHQGOe2zZnkSKVbyz+0kHDd2tiBk0l9tYU9aTgal3ddbqS1lviZhHGQY1W3gnKTSU
 ouY6lWI2flrLFu4cPmBdRiKcmxwmdV3W7iq6Py4X0H/Vya9wN5tyUirqBhXvLoA8EbhX
 f/AEKn4iBBYr1gnVQAsn+UzJhx/6KZA6/xzy16CpR3UWgD+83zgqMe8XUP6mPjloySUV
 quzOOFGXCAM+o8rHXIF5L3v0vhM1//j0h/Y4G4KiSPtXQBwn25SfxKA7qSb9AIPhKvD0
 r1AI9oyJv7oNlHsJDdhh85f1ypc2Ftduc5z5LOUI/OtT0dnb3/vGJLaiUNTYF7ecGKyJ
 pjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728923536; x=1729528336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1PrQn+uWeoZZP3OGAh+vxfmzh/N4rXkfXjfPzHNbc4U=;
 b=SquaMXAy8P/rmNPmCv44IhHJU3sDOZSvJSg3MhzDlNbz52KpIncJMxZ2+Gi5qaiHL/
 UODJVlXvQ1cupsxkDzSJkQbH4jWBgveG6+ejWtti/AhS/08bsO88PsdSaHW1KplhxZGV
 KNmhdJu64K8CfqgTT3hew2QLgVm1kIN5n7ZKwh6c0HdGATPI0fOtLngZIJY/cayRU549
 euuo+45GGk2tcfqmqcKF3b0bnOOHw2urv5EVMG06+brCipBnQjHhcqCwtO+w0i9jrn81
 4x8CzZT+N4A4zaV9midK/UZi8xt0x9owEjzOPdOmvLskC4ZyqZUOgjkf4dnIlpfpbQbH
 Sf/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/c8BFfUcHAp3oOn1qZKRb4h+RK+qgU0FvY6Krel77hzkkJrNPoUczRn8qhVRv+/5HelLMcvpaMYbk@nongnu.org
X-Gm-Message-State: AOJu0YylJ1iINPaNheBAJE33vGI5qytJcFdANeSgwfJ88UuQt97hgnyA
 gkuGGc9D8OLQyucZzh9AClLkYlB01pzQZ0Z+2upRi+czc8N8OpycTLlW2sOEQE321GF5MgzgEH2
 p
X-Google-Smtp-Source: AGHT+IHq6JXbaP5wCC+pQvRLb3rg8Cd9S5mAks/esJzjkvq/WShD5cfqQmFDJEmMC21+s/kk8HKQbw==
X-Received: by 2002:a17:90a:ae0b:b0:2e2:b514:ca1 with SMTP id
 98e67ed59e1d1-2e3151b78b6mr12000540a91.6.1728923535805; 
 Mon, 14 Oct 2024 09:32:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5fc5e29sm9170822a91.53.2024.10.14.09.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 09:32:15 -0700 (PDT)
Message-ID: <55d9edf7-9320-4b97-84dc-793cb1e72dbc@linaro.org>
Date: Mon, 14 Oct 2024 09:32:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] arm/tcg/cpu64: add FEAT_XS feat in max cpu
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
 <20241014-arm-feat-xs-v1-3-42bb714d6b11@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241014-arm-feat-xs-v1-3-42bb714d6b11@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 10/14/24 03:48, Manos Pitsidianakis wrote:
> Add FEAT_XS feature report value in max cpu's ID_AA64ISAR1 sys register.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   target/arm/tcg/cpu64.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 0168920828651492b1114d66ab0fc72c20dda2a8..8c8f88d84151952872f1b1987e98d789b501fb23 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1163,6 +1163,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>       t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 2);     /* FEAT_BF16, FEAT_EBF16 */
>       t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* FEAT_DGH */
>       t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
> +    t = FIELD_DP64(t, ID_AA64ISAR1, XS, 1);       /* FEAT_XS */
>       cpu->isar.id_aa64isar1 = t;
>   
>       t = cpu->isar.id_aa64isar2;
> 

Actually, this or a follow-up is missing the change to
docs/system/arm/emulation.rst.


r~

