Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41D1C25B7B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7F4V-0005hv-Rb; Wed, 15 May 2024 09:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7F4T-0005hQ-RB
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:53:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7F4S-0004LC-64
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:53:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41fc2f7fbb5so38289095e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715781205; x=1716386005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2rRYY1tbaFLs06ZLXiAiTCU0HEW7WH/PkDkeLN8JGtI=;
 b=JBe3TtyoP5VfQQIMbm9FDdwtOMPNk3ePO4pwZxnVH1IUWLk4BwRfGw+gH3ds5879Ma
 13jBTJ7c0W8ICUiE/o5486ymp6wwlOnTiB9h8e7+yt3NOyDtsnnk6iSaasYgjV8amNq/
 iI/D5QTuzA9mrRMNdfFDtmPHCrLtRLq3YkQninrluy4QOYYMuUz/Zy/PIkiyU2QBCV7f
 UKcJVIFXeyQGaMBNlBpSR93iF4pIKdtYvBySjGIIiuwTSCfYTCOySuEu85I2i5eH/WdZ
 7144YLjq+Ey/QZBIBNhAqdxGdek/qSLNImXr5T7JH5b+fEcICs4m8d1b9/3TD148s5r2
 V6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715781205; x=1716386005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2rRYY1tbaFLs06ZLXiAiTCU0HEW7WH/PkDkeLN8JGtI=;
 b=I0TS2ig1qsOdszViil6eqQgNhl11ul8OUDnzDvn7AVVmWrEq6hYASIqsXmqhb7crTa
 4K2gbx3G0LQAf5byGIGXxzSHdZ/1rs8sUuc/oC6yS9ft01Abm3XY08QhItGt1GA1wfwA
 uTpADrQQLWnEmPTSiJI0nyiZg6THIRsO/P8QVFD3ax1f4Fly58c9P9pK+ni4fd9eL5VU
 jnsz9625nNVP6+O6L7+5eBAOMODXq82PWOKPxjnLgddToqIrTszvkmBFujY0cqEgDlNq
 eNwoLBAPlb7xqW/4wF8+AFByUTRbbgAVcERN8RHBOLQxYDYp3HFJp2Y1xSSs2WyLYmu2
 tf/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYpWyI9QS8pNxR/oqFHshHGQ/eeVGBESzMqZLFPihsv12HxDB+SFs3Wn/9fzozZY2U+RxuwN2ytqiZiF3bFSo3irsy4Us=
X-Gm-Message-State: AOJu0Yy+pGwfHrLOv+0s59SEYS/n6RiiOOr+b+mXzo8j+Oh13Pd6vDvV
 4chCXoUPrRqDaBYgO6e1oVnVNArzWnh2dMk8VcmlaKow+FbdRD31zdjRB1Ni9sM=
X-Google-Smtp-Source: AGHT+IG0tE6MB7lmgDf+9rvOLVNbG/+q0tYnumT9V3knT6Ej8wsjIqNTXjKEOYHC+sGHGaEANoGJdg==
X-Received: by 2002:adf:e256:0:b0:34e:3d3a:e144 with SMTP id
 ffacd0b85a97d-35017fe1ed2mr15637507f8f.2.1715781205371; 
 Wed, 15 May 2024 06:53:25 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce25casm233835825e9.20.2024.05.15.06.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 06:53:24 -0700 (PDT)
Message-ID: <7af9d602-8252-4e94-b34b-a194f1f5e9ae@linaro.org>
Date: Wed, 15 May 2024 15:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] ppc64: Fix <sys/user.h> include order
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-2-richard.henderson@linaro.org>
 <e24b2563-b2cf-407e-a4b3-e0c5ef847ef4@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e24b2563-b2cf-407e-a4b3-e0c5ef847ef4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 5/15/24 15:11, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 11/5/24 13:53, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   risu_ppc64.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/risu_ppc64.c b/risu_ppc64.c
>> index 9df8d58..62cf6aa 100644
>> --- a/risu_ppc64.c
>> +++ b/risu_ppc64.c
>> @@ -11,9 +11,8 @@
>>    *     based on Peter Maydell's risu_arm.c
>>    *****************************************************************************/
>> -#include <sys/user.h>
>> -
>>   #include "risu.h"
>> +#include <sys/user.h>
> 
> What is fixed exactly?

I don't remember (patch dated in 2022).
It is probably a #define namespace issue with cfarm hosts running Centos 7.9?
I suppose I should investigate, and drop it if irrelevant.


r~

