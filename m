Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B442AC83F2D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 21:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubnEM-0007HB-TS; Tue, 15 Jul 2025 17:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubnD8-0006ek-SI
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 17:29:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubnD6-000404-V2
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 17:29:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-235ea292956so56133415ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752614951; x=1753219751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6l+0C+UGbHAJtkqka30GvC5sClrPTPa6suxK3B3wEQY=;
 b=oxfiJfvWQzQQ/n5KCGOj0ht9sk19kLicY/wpw4qLRqFjuCDtadcpdXch5pBy+smbd5
 w+xjRtsSsgSyJfhFbB7Wb/9qelGe9So+pePOTZi2uF1sqaIwtll1mgpo4DI/fS3m2XKp
 mnY9LbfRANiuy9WQNTc9kADznkKW4GfS7edC0UyCIkz25Qm+Q/PK+DHpyCBeyQ1zsLTC
 nuiie71yNKwMc1YyQu01qqn8CUTOJk8fPb9VOQVFsvMXlTJjSmZ4yFIOWOgm7Jos6cIi
 tsy0LZExR2P/3ykDkhqKd8OitYWytGIbj16z+wDsMhtHFc54j5wIU3QOsiJXaACD4EYV
 mFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752614951; x=1753219751;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6l+0C+UGbHAJtkqka30GvC5sClrPTPa6suxK3B3wEQY=;
 b=Df/58pCoWbbyQVJMe9FYjcdYlyc6sOODahu87BkO6Y4oh2Qr4nCDFqiOsMn0FjLrFh
 z+jbZtrMMdGuppTuM+QyZhNATFb7x+BUPCfM4dN+2WOwxO8l9R/7Cm9RJPyuW1QWbE5a
 J31ZCPITHIUEpZeV5R7DpL64R3AVQIRlbXatuDjlKQVZCprl5RghuMdjviyWJDvi7x5d
 wqN5X7YWXS36TArRO0pAlH3T4p9D9wertL0onlakqHQsT1seOOk0uPNjNP/loc6SIE+z
 LNizUw7h/g5bTFPbVS7XsAn152F4IBorme9XuCCNBJjLG3zbPMtZfBZiX/s2qK8Gsm70
 sNSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjZm5Lj0muIA9yzpA+/vuGwHPyTAE32OOzUJ9TnfyXZdf+voty9GcCwPuP/MZH3LRV4jn/f/P9mhlG@nongnu.org
X-Gm-Message-State: AOJu0Yx7szpTM3ogY64SyAY9hQXanI+/SYUV1vzVVqPwhldNabfCo/JU
 K52nBGXVqo8tt7PKvyDow+WA9cJiNaPztRHIuqSF13sYA0Q8UkoVDnF+aWyXOcr7jEc=
X-Gm-Gg: ASbGncvJN2PlXMf7A9UqMqC9BmDnlHpccMI6Ho9mQKvfPSXRsXVtsmVm7NC66KRuM2l
 AkxPiW8A1KY/2br4/f1P1rLvXm+UNksvkWpGk7SE81bYrQEktO11rePCSZvR+1SEtIT+rLKEceN
 xGvLBjUpAB686g0bluildgUaBq8prwlOgOt72qyyYTzNLMGFQviTSNL2udIM+yJyrynzoqMllOC
 WYF3foztnowk+MW9gYST/ABikiBY0R7qIcUCq9f5O8TvFpYrTHMQTUac41qfeq17fIhiit4I5o3
 7HINZyIFdInbz6bXUTzyzcqP7Kx3dddqDt3bRI2KFyGc1sJTcwstR2r3J6sfIsQ1cmaeFfhMIvX
 7+KHE0sepFuSzorVXtEH8dpzDaB/rm/FH984=
X-Google-Smtp-Source: AGHT+IGJF1xVJa/IhyK8K4jUskHC5KXi8q4c5AzZt81ORy1E+DkglG94/O6ZxJ2i9hQLBFT1wFNG6g==
X-Received: by 2002:a17:903:32d2:b0:234:909b:3dba with SMTP id
 d9443c01a7336-23e256c99b3mr4119945ad.20.1752614950974; 
 Tue, 15 Jul 2025 14:29:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de43228b3sm119187535ad.135.2025.07.15.14.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 14:29:10 -0700 (PDT)
Message-ID: <c2c5d91d-3531-4f60-8ffb-e47eba82eec8@linaro.org>
Date: Tue, 15 Jul 2025 14:29:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] target/arm: Add FEAT_MEC to max cpu
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org
References: <20250714155836.1514748-1-richard.henderson@linaro.org>
 <97292e35-b7f2-40ca-aed6-34ef39396433@linaro.org>
In-Reply-To: <97292e35-b7f2-40ca-aed6-34ef39396433@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/14/25 10:09 AM, Pierrick Bouvier wrote:
> On 7/14/25 8:58 AM, Richard Henderson wrote:
>> Changes for v8:
>>     - Re-order SCTLR2 and TCR2 so that they are independent of MEC.
>>     - Enable the SCTLR2 and TCR2 enable bits.
>>     - Squash 3 smaller MEC patches together.
>>
>> This still fails the RME tests, because we still need TF-A rebuilt
>> with ENABLE_FEAT_SCTLR2 and ENABLE_FEAT_TCR2.  Pierrick, since you
>> have just done such a build, could you re-test with this series?
>>
> 
> I tested that on my local Realm enabled setup and I can confirm this
> solved the issue and current series works.
> Both flags are needed in TF-A. ENABLE_FEAT_TCR2 is needed to boot host,
> and ENABLE_FEAT_SCTLR2 is needed to boot nested guest.
> 
> As I'm off today, I'll update that properly tomorrow when I have time,
> and not rush things. I'll update RME images for sbsa and virt tests +
> device passthrough test, and post associated patches.
>

Richard, patches updating tests images have been sent [1].
I tested them with and without current series.

You're welcome to merge that in current series (preferably before the 
current series, to not break bisection for concerned tests).

[1] 
https://lore.kernel.org/qemu-devel/20250715212335.2215509-1-pierrick.bouvier@linaro.org/T/#t

Regards,
Pierrick

