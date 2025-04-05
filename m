Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3DDC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 14:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u14Uy-0002nD-Vm; Sat, 05 Apr 2025 10:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u14Uw-0002mU-Gg
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:27:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u14Uv-0006Bj-1L
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:27:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c14016868so2563857f8f.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743863267; x=1744468067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gnby++DarUOJ6fJV43yPTbGbALjPoZfsApbjM0Lh28k=;
 b=YIai7bU6wU5c9/a9sjh2DZDymCQN82z3zOEQo5+h9+C8lfcPbdj5OaHk+twI2IecVb
 lrlOb5NplZR+f5J3XzUyngFQQ8ZGE9ZnfdV7NdRBL1TGAtUJoLBGmDSJZ5MUOJZ7kbLJ
 H2GiIZKv5VaH5OEcKp0T+XWRB47hzCFp9gNUVIflTfAgJCXHhCK0PQATdaHHVHjZ0uY9
 DgtwUQ4evDRFQEL28vJ4+yvSDg15pjGoW6UwQHlSY1o682RjPSFQgdbYGFznjKQBLbXp
 B7O3FPhjIDkKjMid3DCldOnIKAXd/TIFW4iCajnoPONN/haawyhYAb66ZIhZLD8a67qd
 2Zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743863267; x=1744468067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gnby++DarUOJ6fJV43yPTbGbALjPoZfsApbjM0Lh28k=;
 b=fi6Re4vR2X9QFUwCJG8skEVL5G/vJcIbZMAOvepHz+BWBfxNhwsX/RMokIXLCkosoy
 ztqdPpn0Dfj/y66qzxakWSfobAtFC59pqbUYbDtvVuhDCtAe7F5dp6sjPtScmRzLUbGq
 jgDdmxaMKFHIso9rctQGLGfWDT+lh/yYy1zrsCPaqbpPInSb3e4VwiqxCuQdDSst3dO7
 2w4ygZiXzmp2PftelxDP4ZtM2RG2uG1nUXNGNUzc2Jpo6ytlIxf26BJVjlVs+/0F8k5T
 Ftrt1mvpx3VBGdxB4vmTU+7f3QU9Wr1dmmxWOY1J71J2T1g5L9uv+h15RoUJVGB4rS74
 J5xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkICMFG66mue7NRiyzQFrzGtBvRvSLfxnzGVHrRXtNbOO3KWVtZcC9QVvp4oVXN7+o0j21IM2uOZ0/@nongnu.org
X-Gm-Message-State: AOJu0YwRm580sp7RnutHhcA3QnL8LkMnrry80hCkIy0m3/NFFCgvzpMq
 QC/yldkJByOeDUIDFLBRG3k/1PbPqxi5JtPi74q10Z/SNu5rnk4VEz+pDCh/avA=
X-Gm-Gg: ASbGncvz4h2zHu7fLKdQLGiCCfJQLjnIIWgMJT4v+9RV9e4LyBmOCmlvFUNVkuL9bNc
 nQSFuHKoLvepHG0vKzQQgk0+vAjfJV8XQ7SJEnDUnAvYDEudNt8CGjGT17dhPLDxsq89UJDQ6PS
 SFpmNoC2AsNn3goV0Erla9bEYPsjQFA3Yvt9O0g6Far9jaUx477jRlejbnr2PhIr7Zpqyh3J70S
 Ko1toaQmze1mODSWrA0U6ENRa34tMPExuwwJeJOLntjUgL0cOuvpx0FmWVQLGyvoroNnh5GYs+5
 yTG52eDy2iY2XahroHYROrmcTbfM48jTPNqDldZHrtrzn3Djg2F8g6+vjHUP2TLoA2vL9/E6LKJ
 6j3eYG9gd3yDH2nQ1NA==
X-Google-Smtp-Source: AGHT+IHsb6QxfACr125lC/5mXqPAiXA1RkFHG30XFxV/X8DOGtlb95d7TvcpsBgZex3QLhrUnu0KMg==
X-Received: by 2002:a05:6000:248a:b0:399:6d26:7752 with SMTP id
 ffacd0b85a97d-39d0de66ef0mr5269362f8f.38.1743863267269; 
 Sat, 05 Apr 2025 07:27:47 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec163156asm78523045e9.7.2025.04.05.07.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 07:27:45 -0700 (PDT)
Message-ID: <e34e8ce6-798e-4af5-9541-a2de2d4d314d@linaro.org>
Date: Sat, 5 Apr 2025 16:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 11/39] hw/arm: Use full "target/arm/cpu.h"
 path to include target's "cpu.h"
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-12-philmd@linaro.org>
 <83a57c49-93fd-4463-81bf-fc0014ff5f3d@linaro.org>
 <a3d5cd32-4a1f-4753-8536-43180229721f@linaro.org>
 <a61d8331-27ef-489f-8cd3-0374da0b4b1b@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a61d8331-27ef-489f-8cd3-0374da0b4b1b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 5/4/25 03:03, Pierrick Bouvier wrote:
> On 4/4/25 14:53, Philippe Mathieu-Daudé wrote:
>> On 4/4/25 20:20, Pierrick Bouvier wrote:
>>> On 4/3/25 16:57, Philippe Mathieu-Daudé wrote:
>>>> We would like to get rid of '-I target/$ARCH/' in the CPPFLAGS.
>>>
>>> While this change is correct, this is not strictly needed.
>>> With the current approach, using a set of common files per architecture,
>>> we can rely on this include to be present, and it does not block from
>>> having common files.
>>
>> Indeed, I rebased this commit from my heterogeneous branch.
>>
>> I'll keeping carrying / rebasing it for various months, trying to
>> remember to not keeping posting it.
>>
>> Or alternatively I'll post it in a separate "cleanup series", not
>> mentioning single-binary or heterogeneous emulation.
>>
> 
> My point was not "please post that later", but simply to say those 
> changes are not needed, now or in the future.
> We can have a specific include path for various files without 
> compromising the single binary/heterogenenous, as long as we compile it 
> only once.

Incorrect, this is required for heterogenenous emulation.

> So we don't need to remove cpu.h inclusion in target related code.
> 
>>>> Use the full path to "cpu.h": "target/arm/cpu.h".
>>>>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    include/hw/arm/digic.h      | 2 +-
>>>>    include/hw/arm/fsl-imx6.h   | 2 +-
>>>>    include/hw/arm/fsl-imx6ul.h | 2 +-
>>>>    include/hw/arm/fsl-imx7.h   | 2 +-
>>>>    include/hw/arm/fsl-imx8mp.h | 2 +-
>>>>    5 files changed, 5 insertions(+), 5 deletions(-)
>>
> 


