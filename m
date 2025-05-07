Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DA7C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 11:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCcpf-0007rl-7Q; Wed, 07 May 2025 07:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCcpb-0007rX-Ug
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:20:56 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCcpZ-0004V6-W3
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:20:55 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so150865666b.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 04:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746616851; x=1747221651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Gi2oRbXjOwJpuVAeeoDIuMhy38nox/SY5lBy1G1AAk=;
 b=v1cmlxlRBxO+BS1iYUOoeWCd+I5X1utDT1qWYDa5roorVB7TsiDvN/4d+xpNgGRTW3
 GSTH1z28ugwDpuL36EV+/uYPHDHEyviYFy48v2m+XmBhy42ElDHoNYZ9gKFOtT3QQc5Z
 AZTX7gI2tqnHJTn4+pdrplYAUWjFl+P9i4oex4q4/dGAmW5hFDpEFjwRieKGlsr6ufqB
 CVKfwumW4JTcS3I+WOEDB2UBeHx9F1j504QDYGK7rmDggDUYFr8a/oCx5O1bbMcQDliS
 iyY4xxidgf5ZoM86viemXRiUccIWbi6mDc2UF1jb3uPdYJW+T4QaodSyvTax0bX1/5c1
 IepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746616851; x=1747221651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Gi2oRbXjOwJpuVAeeoDIuMhy38nox/SY5lBy1G1AAk=;
 b=FbZITxj0mbH2zE/2PkSaMitPKnoMG7afrPfWStBSLwFlrihDEpMekcS04iygsMyaRt
 zAs/JtqJwpG+bVnCMaHvslVCSHY3/XNO7JLthBFR/cQMuxxyE7jUbQw48KFXEZ7H4Jaw
 uDOyG6lNpYTD5k5+uuhxR6K7+3I2WgAwln1C4tYzZtMIAlcaLVB92OapykfPf9j7w8XC
 UVAYMjCPUOL4QEemVJ3JRJVu0Wc2Omcl1etNqozUMW2c/Ibg/6OktTijSvnEJpTGJHRQ
 jgreLjvYSWkiHJJPyMjbB8q79MP9o72qo/e2D+5+9GHGha7UkWsGNOZUvXvxY7xm4IZB
 74hQ==
X-Gm-Message-State: AOJu0YzS6VgiXr5wnrDwnFdxeKb85CpEaDLk0E9p3nbUBW3lZaMcBPi4
 iDVf6zbeEKSYPZpevTOeSbW6vnXAHzwm5QO0+SUzzkEmfvm6mC/u3cW8OPwZLws=
X-Gm-Gg: ASbGnct8BmLc9TBNFqLXVnkm64BKwh26emj35bZBpvBO2n19qsbCHkVQk13O0iH1LYz
 IQEAMVeQMoqMGoKwARE30XTdCp8rQePchAsio9XPT0WMuOSNR+ul5jkHfewocqwxlX86NleLWPv
 D0vTrsP03yBuJgvU38Xu1jWEAYArpimcznmkAVH/ZvOM24do8ndLqkJ417z84S0k67N3Jkz7c6Q
 BYe3qnnkGFCCUn1XC/Nh2KiTItZ9/ELv1j+8SP0hVPQBMJzo/sHKiIdOE7phf644yuHVl9YKIkd
 bhPhVuvIUwXiy/nbj90RaoAt+GXBjG9poprCOVEgJDfaph30toN2dr0=
X-Google-Smtp-Source: AGHT+IGG4+C30y9y4/yP3poV1hF+T06FFcFzFGpSrL3HyhzbZnh4htdK/zQo4R1dd9N4OBAE4GjE3Q==
X-Received: by 2002:a17:907:9449:b0:ace:e863:cd8e with SMTP id
 a640c23a62f3a-ad1e782b179mr341147466b.14.1746616851189; 
 Wed, 07 May 2025 04:20:51 -0700 (PDT)
Received: from [192.168.55.72] ([176.171.151.116])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189509262sm882457666b.157.2025.05.07.04.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 04:20:50 -0700 (PDT)
Message-ID: <36eee8b9-2ffe-461f-a1c6-2e19ad623a10@linaro.org>
Date: Wed, 7 May 2025 13:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/22] target/i386/hvf: Include missing
 'exec/target_page.h' header
To: Wei Liu <wei.liu@kernel.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
 <20250506143512.4315-6-philmd@linaro.org>
 <aBr_MzqaoGwN7gpQ@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aBr_MzqaoGwN7gpQ@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Hi Wei,

On 7/5/25 08:35, Wei Liu wrote:
> On Tue, May 06, 2025 at 04:34:54PM +0200, Philippe Mathieu-Daudé wrote:
>> Include "exec/target_page.h" to be able to compile HVF on x86_64:
>>
>>    ../target/i386/hvf/hvf.c:139:49: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
>>                uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
>>                                                  ^
>>    ../target/i386/hvf/hvf.c:141:45: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
>>                hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
>>
>> Fixes: 9c2ff9cdc9b ("exec/cpu-all: remove exec/target_page include")
>> Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reported-by: Wei Liu <wei.liu@kernel.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Message-Id: <20250425174310.70890-1-philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> FYI Paolo merged a patch from me that does the same thing. My patch is
> already in the master branch.

Paolo said he'd replace your patch by this older one which mentions
the problematic commit, which is why I didn't notice your patch,
I was expecting this one to disappear on rebase. I don't plan to
repost this PR except if there is a serious problem with it. In
this case, we can still revert if we are picky. Duplicated includes
aren't a problem, missing ones are.

BTW since you are testing / using HVF on x86, do you know if your
employer could help extending our CI infrastructure coverage for
your use cases?

Regards,

Phil.

