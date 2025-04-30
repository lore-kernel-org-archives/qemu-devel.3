Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1124EC3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACm2-00048E-RT; Wed, 30 Apr 2025 15:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAClp-0003u6-Oe
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:07:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAClm-0002MR-Ni
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:07:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227d6b530d8so2313775ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746040016; x=1746644816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oHH/CJ/HNr3q5RCvWrg5ycf+bD+rJTBVJLQQPcyxTPE=;
 b=quOsUMmNqaPy7/0wxekEfoiozg4ao9Av8asWoOHxXrqTdy+IguFNTuNU4/WRjWkm3w
 KuM9ZOdk1f2lj3XePzMS4mNzlEI6m/ev2FnmamJKmLTquLakpWsgFglJ04aVtnqsCpmD
 qJetNm83nFlUr+7uMVPktVzGgHjSIqmEFs+ozifxggsueowVRLgWNFgJMjH1xmxYmBcv
 BZinz4nIsKF1AWpsFQ1OkMDFLB7nN/do04R7TMHqYBxFMfU9VKG37n/d9R3b+SCxzdYZ
 boboWqbH+W3KfW5LP7F6/6wpzPbLqGqNMEtMpUJbK2Fuei3Blq94OlCQ2JfIINSr8V4I
 frYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746040016; x=1746644816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHH/CJ/HNr3q5RCvWrg5ycf+bD+rJTBVJLQQPcyxTPE=;
 b=m7d+P+e1WLENs0S6/9Kqz7V1qd5IgonuUgkPgFQEdi7WkAq6+t5rCv/N1sagZobbLV
 S/cCEKvzZC1NJ/0Epmc0S8x4hpmGHE9hZbsxWaDeR2+Ecbp1FllYmzSsuTkSg6ZyEjUP
 C8xn4jHo3E2cgDzF4ljnz6YbOXQGWZFvUnoow+NkYI8+eOqb7i2tWyKgK16FzL1PnSxh
 aM2WXiwrwmul3C0qcW4vP8SxRhcVtt+0quFxCE5HYXCO6PuyiZBsMcaOIPMky8RxskgK
 OgshPTUcv5KKVvtsA5VJ3dw0k1T36pSGCBCSaiKyI9WGCrraeYX4DVWq9mN5ivTu+i9v
 hokA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjC+TYfMI34Z7gnU2FR+V6LBqErlwS8GUypGUO4hxhkQQInEeqeqkJboLhqZ8EDAqWt1DMwU1mv/Tj@nongnu.org
X-Gm-Message-State: AOJu0YzfcZK9IIC2MyuOjHthYfEPDBZS10Xru6Y9j1FC2TnNWzyBBveP
 lhLrVeITN8sBnZ1F/zAasAZTwyYKoyu0Bsz6ey5gFwA2iBwbv068//yng1hj55M=
X-Gm-Gg: ASbGncv5t694wSkq0YczvyYSyzmas0AZazF4frcfK+cD1PJAsGCFjP8LHr5UPCGVqUE
 pBdPAxcOIREqtgiu5v7ThcmUNZy6c7o8lBpcfuPs5wZx0TGOTjD7xHIqSrjOdvfa3A9/KtxxgoM
 1ZcWP3h1qa6uM5W68O4N6pgDI6O2LgdAd/T6sHGWWuN3xFRjG/NnjzAx+2613uhJieQifFPYSuw
 9wAyVccbySiCxESxI+EFwmj4WqrUCqgQjpCrdl7uTGCduUWyXgFoGz3+wQ4D4rsQgYNbPatWFDn
 q3SwWxtU3WW/6SYjnwWOyw4wmVZ/XciWTQ8CCky/hs4DPhbaku6txg==
X-Google-Smtp-Source: AGHT+IEmtsMxKzfl913AuCQz4vQAnUz/8tQEJ0yj76c7JEnnFdJLPruhJNFw8n2y3PV37pbT1B8rvw==
X-Received: by 2002:a17:90b:5347:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-30a332f2c24mr7242936a91.14.1746040016332; 
 Wed, 30 Apr 2025 12:06:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a3bcf1sm2018153a91.37.2025.04.30.12.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 12:06:55 -0700 (PDT)
Message-ID: <1e223128-a2cc-4070-a7a9-9a34e5abded8@linaro.org>
Date: Wed, 30 Apr 2025 12:06:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] accel/hvf: add hvf_enabled() for common code
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-8-pierrick.bouvier@linaro.org>
 <db654764-8377-4080-8f68-7fc61e8eaaae@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <db654764-8377-4080-8f68-7fc61e8eaaae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/30/25 11:43 AM, Richard Henderson wrote:
> On 4/30/25 07:58, Pierrick Bouvier wrote:
>> +++ b/accel/hvf/hvf-stub.c
>> @@ -0,0 +1,3 @@
>> +#include "qemu/osdep.h"
>> +
>> +bool hvf_allowed;
> 
> Even small files require license lines.  Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 

I'll add it, thanks.

> r~


