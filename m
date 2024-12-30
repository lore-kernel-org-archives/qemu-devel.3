Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F2AE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 20:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSMVZ-0001LC-18; Mon, 30 Dec 2024 15:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMVW-0001Kn-Mm
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:36:58 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMVU-00011B-RW
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:36:58 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436ae3e14b4so5934885e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 12:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735591015; x=1736195815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pfwINFT/87QAWnltO2O32D3EYUMNitetmxnf8vQDxMs=;
 b=IuPfNe6K5VlzxvHDdkCVEZIthrQ3tactgh7iuV1z7qdWxxLovT1g4sSgzett1YbBvx
 /mLQdvKw/i8MTL0Pg6mX99xCn6hKhq5AJH2jJoxl8UmBpq2Z/MxafbDJWN03uNtkud49
 GcRSPGvFxqk85kH4EvXd3qCB7INwZ92hXopF9Wd3Jwt+au4sLaJB8xNtOXuwdAQAshLC
 J0eaALyD1QHW+mYHE+B3ZSYRe9p7jbNVAkFHzvuU1iVJv0AFERdCt4JKTItXP11RlcDN
 0NeGlbbBd81DKVU87l+iPvZrCGchWmUOQvM9FO+XBo04SlJqT0uS8YOo3dUoG+pAp11s
 /JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735591015; x=1736195815;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pfwINFT/87QAWnltO2O32D3EYUMNitetmxnf8vQDxMs=;
 b=iz68HP4WgLbDJlH49Kf+7/7wiS/+yYTeEcwewbuWHLPENiu8qvlznipcp56/ZqJKLj
 ZN+fUIa+7axbQ2mTJzFxPe4RjXBtKYhoCNWJGrvc6RdV/uuPxjYWxicpJqeYWxYKXoUs
 b2OM+fvuVfGO6a9b6NpYa/ImKZfDG1JGs7DnJvAfiPipJK/tg1rc7lDRnK6WITPjnHCa
 ZfOgXI/jH2LzgZEjY+umhtLKIs+O6EBvfVmuZAKfbap5v+w4lGLp8p46qhzWSQZdTMvH
 bb0UtoeGACQ5KI7jshC9KH2LjVZpcBN8fd/tYa1Tx2/BRaqykTJeqZkD9qTb1y8ESLWp
 Gzvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Fv+5DaJbvflv+as8LYGVewbk6tlnsc2Xi34fBDlDW8eBVFgEip2wu+OhT1pJx+qvrIWPBRNLzY+A@nongnu.org
X-Gm-Message-State: AOJu0YzXw4sAqx4tTr9ksFcq9FxFYI0wAk1O+N9sgwSwx96cDzXBOXpu
 U3GCwoy5UTSN/k1UPOoqQx8/l4S8lSPi84uiaETB1V6e99RqSfp+JYhkWjNyM3Q=
X-Gm-Gg: ASbGnct/e3JYV/7KREJvOmeFP2d0MC4VaueFzuikWYQP6k35oe46XpC7t+Vs7nmQfi1
 OCzOndVSOCdUvKBtoUG5ZmkOiAHitlH5r21HjC4a3fj1ufFfZggdfKuQQuk3QOYHFwC32mKEebA
 ld+9tmzVmLqlZUVvSvW9zYwUfNGErMjtPNnVMieq+XhsTq6EgLVCmwkqBvR8bJlhUbyRE2uAlxS
 h/aYV9rKT9jcDXZcc4VwY8RBPG2E4XqzcjtNQimQqsB1X6e1BKlfwkamE6U1aysKUyvmzW3fmtw
 e6gj2HtA++oyDrSbrrwfy9VL
X-Google-Smtp-Source: AGHT+IHgjx2x/6NvehOi4jmkKPUSAyPIlJmCO4vyodoHD0FpOdWiB9MAb//ux+Ha7DhDHo3KWycB5Q==
X-Received: by 2002:a05:6000:1f8d:b0:38a:5a37:4a46 with SMTP id
 ffacd0b85a97d-38a5a374a51mr2273285f8f.17.1735591014845; 
 Mon, 30 Dec 2024 12:36:54 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828a8dsm31182511f8f.2.2024.12.30.12.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 12:36:54 -0800 (PST)
Message-ID: <271cb1a7-88be-47c6-a574-605d294a2a98@linaro.org>
Date: Mon, 30 Dec 2024 21:36:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hppa CPU reset and speedup
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
 <32a4d72c-6cc2-4c33-876d-ddf66b71fab4@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <32a4d72c-6cc2-4c33-876d-ddf66b71fab4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 30/12/24 21:24, Helge Deller wrote:
> Hi Philippe,
> 
> On 12/30/24 16:25, Philippe Mathieu-Daudé wrote:
>> Respin of:
>> https://lore.kernel.org/qemu-devel/20241229234154.32250-1- 
>> deller@kernel.org/
>> "Add CPU reset function and speed up runtime and translation."
>>
>> - Remove hppa_cpu_init()
> 
> Thanks for picking up my patches and integrating them properly
> with the reset code.
> But sadly your changes somehow break hppa 64-bit CPU support.
> I think it's to when the reset code is called.
> 
> Easy reproducer (no other options/disc/network needed):
> ./qemu-system-hppa -smp cpus=4 -nographic -machine C3700

[*]

> 
>> - Reset PSW using M bit (untested)
> 
> We haven't implemented PSW-M support and the first
> thing the firmware does is to reprogram PSW.
> So, basically it's not needed.
> 
>> Helge, could we add a functional test booting Linux?
> 
> What exactly are you looking for?
> Some trivial preinstalled disc image with kernels?
> Any examples?

Your [*] example running SeaBIOS is perfect.

See tests/functional/test_riscv_opensbi.py, but using:

   wait_for_console_pattern('SeaBIOS PA-RISC 64-bit Firmware')

> 
> Helge
> 
>> Helge Deller (4):
>>    target/hppa: Convert hppa_cpu_init() to ResetHold handler
>>    hw/hppa: Reset vCPUs calling resettable_reset()
>>    target/hppa: Set PC on vCPU reset
>>    target/hppa: Speed up hppa_is_pa20()
>>
>> Philippe Mathieu-Daudé (1):
>>    target/hppa: Only set PSW 'M' bit on reset
>>
>>   target/hppa/cpu.h | 11 +++++++++--
>>   hw/hppa/machine.c |  6 +++---
>>   target/hppa/cpu.c | 20 +++++++++++++++++---
>>   3 files changed, 29 insertions(+), 8 deletions(-)
>>
> 


