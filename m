Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A52C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 20:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u04MF-0001y1-UY; Wed, 02 Apr 2025 16:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u04ME-0001xl-J4
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:06:42 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u04MC-00066w-Sl
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 16:06:42 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-af9065f0fc0so152805a12.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743624399; x=1744229199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gGER60jBODfpJu8rmDeG0AWBSpyUDqOOLEMl7orT4bc=;
 b=HSqUtT82Oile/wl2XsPsBtndQh9lM3TEA0e4tyDQLidkecoraRHdOXKtlp9GPnzkMg
 S25SWFzCljopuKmdAiLwP2SRDpJCEFLFJ/AXNLCjYa1wwmIt2v4fPjJNNlkLAdyL8mqK
 SPoEzeRtGdrYVTDXNuVOJY/BoZ5kXgzO03APIUJNNg38qLzA92Hci9lx/laM3k8w95Rg
 jytQi3SwXDSO8XgxoOqkwPtixj2+WjsVHVCD95xENV56wjxBJEzR5oskA2NVRgDB0mNw
 d/zngJAm/ZoMkUaockGie1aqQMZfUlScvhrOWaKVV8gyXpC9Ng3+hCFv+gbXlI0v4GF1
 c5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743624399; x=1744229199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gGER60jBODfpJu8rmDeG0AWBSpyUDqOOLEMl7orT4bc=;
 b=pYv5tuTOUp3oDJJ+ZCIG3Dw8RcNRpGDT6YGmd3QclStTjVk5QfOyKURMuh5jgSNIJj
 ry1ayTHNLpAgIbD76GPs1KR4C69e29wxe7I1k/PzPfaxPP3PGcq6ZKKegF3+YYHgKW/n
 5Mc/i9UJVyGLjvgYKnWSioZWxWT3GXtInbiw8atmvJPvXHA3obhddFf24AoxMsDetCOj
 KCV6xr5HUAQapiYRHCSx2ty9PpMbYTyshJde+DR8MAhA+SY22m5gca1IMjflWPkYEEtG
 VUirNeuPM+pTXppFGo4gL7j6aN04RCopxz/wixyqruhhk4lV0wE5qxE2Q/HpJS/jLz6t
 K7YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqDJAm2tzvcsrj0BgIOd++cEcb1nHPD099DREvXFYONyHdfdtSdG0r//S1bSfH+GAeHnjdXUMWb/sk@nongnu.org
X-Gm-Message-State: AOJu0YwYF1bKltXQTGYKZnN+0JglcwsMnbye9ENcZov4xcaMzf2u4UPb
 KvYrgEX0jFPpaHPH/oafGhKza1dDJOxXb+hW1kbc4CTsqLnbHN5pXt0zBS9WIro=
X-Gm-Gg: ASbGncvmH0qJr7Vrj9wvy6sxy3Fl2BU4Pbi4Qp6K5KGPV5i8glmTcYatRt1mg0LZtTX
 /QGsaNxcwtYQeNwcsyIFuWHk/6P8ziRqEuVQdAn3HUVP75KwATBT+LGiIHfcjPKhsQybS/NKA9h
 4C72zhBjrZFexIuH7jXhy+OSDPd81o4q4t5JerahD+bNuD5yswvE4Yb4hX4/5gotNT+C8eGgnuo
 ANvWuRwlx0BRoP9hCqJDpwRHz5hwwuph3C7suUsWgZorjGg4k3MmzZtFRCM7adi1M+qO9a5dDoW
 D4CqXvvzJ0W0s5zz5LsrjmSseZgTlOyhYBr+L3RPuZSKqpFxNSCn+89bnu2TL1hG7BQZ3zLOyHg
 7rCFCDKqTEl0MxIT4p0E=
X-Google-Smtp-Source: AGHT+IHByQEo/y3ttEUvI7Q1rqoMQM1inJLb136EkfcouhY9Hr4tBoK94ajqs1xm9pdBIzhEGiscGA==
X-Received: by 2002:a17:90b:2748:b0:2f9:cf97:56ac with SMTP id
 98e67ed59e1d1-3057c9e87cfmr186289a91.0.1743624398689; 
 Wed, 02 Apr 2025 13:06:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057c85eb3fsm67390a91.0.2025.04.02.13.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 13:06:38 -0700 (PDT)
Message-ID: <1d13c66a-e932-48c4-801c-9b14890679c5@linaro.org>
Date: Wed, 2 Apr 2025 13:06:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/29] include/exec/cpu-all: move compile time check
 for CPUArchState to cpu-target.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
 <20250325045915.994760-4-pierrick.bouvier@linaro.org>
 <e11f5f2e-0838-4f28-88c1-a7241504d28a@linaro.org>
 <319fd6a2-93c1-42ec-866b-86e4d01b4b39@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <319fd6a2-93c1-42ec-866b-86e4d01b4b39@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 4/2/25 08:25, Pierrick Bouvier wrote:
> On 4/1/25 20:31, Philippe Mathieu-Daudé wrote:
>> With "cpu.h" include:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 
> I can't reproduce this error.
> With this series, cpu.h is pulled transitively from "accel/accel-cpu-target.h". Ideally, 
> it would be better to add it explicitely yes.
> 
> @Richard, could you please amend this commit on tcg-next and add a direct include to cpu.h?

Done.


r~

