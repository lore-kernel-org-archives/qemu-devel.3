Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B3FCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 17:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v16Ma-0002kR-4b; Tue, 23 Sep 2025 12:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v16MU-0002jH-SJ
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:59:31 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v16MS-0002TH-KR
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:59:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77f605f22easo492405b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758646765; x=1759251565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dDrVKMlsJpPzKyE+WYmB66MymwBb3QG947Cn/zU87kQ=;
 b=iEgU5l8kVMEzp+eA0gN5k/y+yHD/JSHJ3yqkjDgFTFgZbyD/lIRjiPx+LM28YYoKEV
 nh3dMGXbLVrvsHDduTzU7WV81O2sVsAj5ajLbf+QNl7Hp4g/g90OROak62dYcT3SrkKY
 20oOTrU06XpJDHutvYCeg4XgSl+mJvjrainFCMwytqhnHtQWjswDo9LaBIYKNCDA9jfX
 asyotPM/X7BEtGkbauTWOv8lBmqDdetfet9Pmu2kd/fFhU3NKxK7rxgCS9hB45PtKWaK
 2t5HcWdXrcteVRgHWP6638dbXUmU8PREvSMK91yv8YB1eErSHP9+mI2aWoAE3bBnux7l
 A5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758646765; x=1759251565;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dDrVKMlsJpPzKyE+WYmB66MymwBb3QG947Cn/zU87kQ=;
 b=aL0E2qrHNCQpT2BxjQxz+9tF8sDD1mym8p7JWMJdZoh8RB2xg0cRaBtNsdEk0tNpfX
 1XfHtRVecjGIGIxs00sZT6WzVMHP1QC4TuisAvHp9HJA+2BjmILKoNVWLizJzz8O5IJM
 vWW1Xpz7Ekrgmcg0N3FzmVqiihpqXsv46rKKWQnbQ4mySaxG5kivdS58MGO0ZjZuti4Y
 QzEIXlUUykxJV48i6ntihT526NaKAsv/XvoWblER/LctG0DA4KHQvWFzDxgMdGjJj9z6
 p0UUaQdNizQOuil422CdZAIJMWNMEOYWOqudXM58+h8Ubjph+lAmkiqUBhLNbjtzqVSB
 mdTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhK+jaj4DzBC6je3zdhznf7LUBSR2vEmMRiIYjwW1iA/H+jbNtv9MD4eGjEMdchntIcYcpYiB3r3Re@nongnu.org
X-Gm-Message-State: AOJu0Yw6WVvhHBKhsM3wcqxB548BOnNMNiJJbD0GueZyLSg4aVpCOJeY
 KTosP3wTIkswrzzIMoTza526m+okEu0RV2FrRYxzOq8Qle9BaAFEgKMF9vGPTcPzg+Q=
X-Gm-Gg: ASbGncuiu6gC3p3CHVxLd8c2x5hBW5ZZboNs4h0GCqF/sG2FCCSsf2ZcMZPnawQNJXa
 REExNv8lA7Pm120yznNWI8Fa60oUdcY99pfa7diS6tdYkHkO+VbU3CrORn35FjLI4GS2Tk/CIsB
 gRNe4wMhy6OYlJb46my6Lj3wLGdPtuqZz++jNfrL45Domb5/9GDCvNdcDlLmyJ+RxxG2gM8JK86
 bUqrlLzclKtugohcMu/ls9kYXrJ+UmB+224uJbcBwiXUqQmUIM2d7v4zd2+W5vi8/eixUej3hV6
 IXPzXLfmL1S/xc2pcOZvtLixOyRWUuuTanbvXtchtufYOjoA42CP5imZBVDpRY9m1xkzkLqM9Vf
 i/SakfMHrwJBAbRJ7GSmH3tgTyhJBhX5jBMQDWU8ttc9fVZM=
X-Google-Smtp-Source: AGHT+IFZaO6bkzOygiVyFy78eUrTyAyKmkjpzlAkFjYtj6KRilsWA8TTUypgo/Z6i97u6lVuiRHJBg==
X-Received: by 2002:a05:6a00:18a3:b0:77c:64d8:3afd with SMTP id
 d2e1a72fcca58-77f53abb7afmr3522894b3a.28.1758646765190; 
 Tue, 23 Sep 2025 09:59:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f228b412esm9043133b3a.40.2025.09.23.09.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 09:59:24 -0700 (PDT)
Message-ID: <6f6e95b8-216c-4cb5-a427-c211ca818a45@linaro.org>
Date: Tue, 23 Sep 2025 09:59:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] hw/ppc/spapr: Use tb_invalidate_phys_range in
 h_page_init
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-7-richard.henderson@linaro.org>
 <5ed7c59b-5e61-4e79-b4e0-a8441ac5b784@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <5ed7c59b-5e61-4e79-b4e0-a8441ac5b784@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/23/25 01:55, Philippe Mathieu-Daudé wrote:
> On 23/9/25 04:39, Richard Henderson wrote:
>> We only need invalidate tbs from a single page, not flush
>> all translations.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Cc: qemu-ppc@nongnu.org
>> ---
>>   hw/ppc/spapr_hcall.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index c594d4b916..feb31d5dd8 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -8,7 +8,7 @@
>>   #include "qemu/main-loop.h"
>>   #include "qemu/module.h"
>>   #include "qemu/error-report.h"
>> -#include "exec/tb-flush.h"
>> +#include "exec/translation-block.h"
>>   #include "exec/target_page.h"
>>   #include "helper_regs.h"
>>   #include "hw/ppc/ppc.h"
>> @@ -301,7 +301,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState 
>> *spapr,
>>           if (kvm_enabled()) {
>>               kvmppc_icbi_range(cpu, pdst, len);
>>           } else if (tcg_enabled()) {
>> -            tb_flush(CPU(cpu));
>> +            tb_invalidate_phys_range(CPU(cpu), dst, len);
> 
> Shouldn't this be:
> 
>                 tb_invalidate_phys_range(CPU(cpu), dst, dst + len - 1);

Yep, good catch.


r~

