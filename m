Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E2ECD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzsA-0006l9-CY; Mon, 18 May 2026 11:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzs8-0006kQ-B9
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:27:12 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzs7-0001KW-25
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:27:12 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36931e4f5e8so2117406a91.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779118029; x=1779722829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TkE6E/y6DQOhXDaG2aqnXKmzXFeQGCHctZizLtNNkAc=;
 b=MXf3XWpJ9LKbMmPhFkaOtvjEVqrokX0LUYhLlI/s+B0tAuzBUyqOEKUnQ3hMDoZNMl
 DW9bu1kecu0IcAZtchlVLKYlc5FOOYDbB5Obpg30r7CIVA4u9lBe/gT0eOIADjZoiFoK
 Ed0wyF8XLR2gxBztag6VOzn/cshWCGeDeh0TmRiP84q+UADcwUIS1XsUa2t/96X6YC1O
 mQYMJWVaSPIH7bJ6Hr/yiw5CChVAmHNiHh/7ZxDyMRV9tgfox16+cq5XbhQH0G4xmPp8
 DrOaSql2HcFHxcaqxdKvQfyMiPRPNOaLKnPF1uiJrMHTi5n3Z4RtQuVVuKWA2nzmOO2A
 U4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779118029; x=1779722829;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TkE6E/y6DQOhXDaG2aqnXKmzXFeQGCHctZizLtNNkAc=;
 b=BT2+kSn9p7FFeLo49mheFrssQXTLD21DCA+ht05F4qbGAkEQDMF6Gpa4Tu+jAx5S8f
 eM/uXxjr1Erta3v++YeBqpJHMoaB9fMuYzoKiKH5kkG5JaZvMa9dpkENPTOsqMci0oAd
 GjAmkvxgn8Joj5jt1ZWt2KzOPShtJjDNkGZJSvzsMlXN04uNaWIdExaUeno/tSBnyfs7
 tzuDZGJHpfSTlmvHrzb52+gc9IxILlE9crxqSKRnyxnJb8Zw+rydTPxpTtNR3R8whEIW
 7fiC+2Sod1netFao3RQfqlkQmOV35rVN9vTGrT1BrziNrGMwjOg+3RkeQQkzkD2dCkBE
 O6nA==
X-Gm-Message-State: AOJu0YwAJ3FX04sHo4zTCl4Py1lnDX7vC8DA9o9dqICsrqZjklrre5uA
 KeK6Vl2BMtvwTObUphzO4NnPsQLLqQUrjtDOzTE+qxQMRuj6Pw3mUEEGNa8oy8kwdL9zG59LClX
 tSZVA25c=
X-Gm-Gg: Acq92OHAOLJhSv9d8oxw2W3DCwieSKT7DyJs1zcDekIpvYTEpFxzU/cZOXnmXQ8BZF/
 AReJVadk4ySsjGQAvBYerYofoZLLyhUL8nOdYAzc5P7N7ykvGWG6c+BG3Emkmynifd4dWKyOLI0
 P2FcjTZdYUJQVKl24nBlGqGV0bPukB/5SRbZ5GwWYmPiJEmxEXZwbgEXJ04yJVHOaskotm9VHEa
 RAidHcmTD2K9EGOtlTCYcX5L4fE8UTV84O+zkZXPyvbU2/LLXQ0AlceQapLUapWHdHF/tv32AOU
 HcCXn3KRPdVV5Q4EEWexu6RJf31K4GvhA6lHHIy9fIOtzIcbecjrcIXUIZI6OU3UNTqgpcfw+tJ
 umCiPcDb/i8thjXRFM3sLP5w3hrrrbiY808fmyllpd8icuu7BvEUmiMjdFVfd79nUImhoslqKR7
 6aIzlz101SuicyqV1fHm8IDZFEIeVUSP81T2PJFTlahzuKD48=
X-Received: by 2002:a17:90b:5284:b0:367:bafd:9431 with SMTP id
 98e67ed59e1d1-369519e1633mr15375535a91.8.1779118029180; 
 Mon, 18 May 2026 08:27:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369517a8612sm11589242a91.12.2026.05.18.08.27.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:27:08 -0700 (PDT)
Message-ID: <2d761507-7182-49bd-8e0f-04d56d28a88b@linaro.org>
Date: Mon, 18 May 2026 08:27:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/14] target/arm/ptw: Flip sense of
 get_phys_addr_pmsav8 return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/15/26 07:25, Peter Maydell wrote:
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

