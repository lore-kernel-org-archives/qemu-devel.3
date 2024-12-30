Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73837E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 20:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSMZv-00030S-EB; Mon, 30 Dec 2024 15:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMZt-000304-2U
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:41:29 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMZr-0001TP-D1
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:41:28 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so13964905e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 12:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735591285; x=1736196085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cDoOQ6A94ADjZFLI0OKMq+Lkw60SSodLXu6b2bkBykQ=;
 b=cxatyHwzt/AWl5eBYVGfzdo7rjWs/J5+j/UQtlZZVwzZdgpa15YXrCpXFWAeucPycI
 FrHD3TU0CswCfakq/IFEZKDmrxacBe1lJHW9hcfcYQOlksuROlSccTPkvf+ZmXlf3t4e
 piNQfl2K86mnzMUSgYPXLpkOqvuyAlXX1uf0NCWot+cZnvvbibLEd3n0RCianeGqWvOK
 v+sGLHxEhNSv8LWRD+6W2986rNz/q0UsElpJxYAZPGf/ty9rNzMK5ePUVsoM2vb0+z0o
 HGLHm5shPSVRdDxMYJ9XhxYTkNb34ksnnmWJiTnv0cuXWoJ01hiRMJ0AHHI4ZSGoJXi8
 xPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735591285; x=1736196085;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cDoOQ6A94ADjZFLI0OKMq+Lkw60SSodLXu6b2bkBykQ=;
 b=JLvZepgmva2z1IYUKQz1W3g2RZ7sQSekZ0ZFprzUGQBH7DBk/sdeuA0fadDuC627kW
 91UH4AOy2bANoL1d5z/6Tu2+ep9gqr7FHuwPMxrwnbH+9X/FxAYEGMFfOHDLcwdgTXt2
 htd+647EOytREd3jTpIqDSN1K+kukGVNd08vn70dOEHjPLWDB1iWA02ZOFu2Qum7vebI
 30A2UOmXAsdwGCNmOMPP3/MrEJQ0r0949jlMpYrabOzby6UZ2fxr/Cp/ZPMb4lanEIfk
 B1I2g6aCzJq9+EKNmCCmltHID7jNrzZXGsPVwcmVgwUTnzG88rrhmk8ZrziLMWXFnVe8
 tAxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNY5HILiyDfQbyGhs8UhWxHx6mPXnm/uY4kg2alWI+6qSgPXausi/2Sm3F2A4vaauzgq0SOy35ZreL@nongnu.org
X-Gm-Message-State: AOJu0Yzi25dGWuQGsujlV8BXCLc//y9xEI9vguLyrvnknTqPzxL9THSv
 3/h0bJmPd9qRyshVoI5gT4YKNbq9t4NjfuyQnZmnqXyvVwKVe5IGxbaVnGSUAbA=
X-Gm-Gg: ASbGncsOeGOlFKPh/98i5Ok4sNTS2fqQX96L2DFGX0p608gKdvcHiy1Jc0Q7mkMnSff
 yuepAzZqYGgjib6sAhUMsLpwGGVNomU0kJlkKZ7TsQZrDC+1vjjl4b1D5rYp+Df6orU43OfYSnS
 Mhnnlc54w9m6lhPCNRcIe/KZBCoLzExhk4+axyVDwjRYj6PU0kNSFjZKjXlTr2+qTzoEp7iYMQn
 ZBxuZZD9u9nq0GEx/yM9yjUZO1WU+hvbA4CY8RbRpS0X42Jz1QZCT40k46UjUkmBnefS2gNl6dS
 lL9uz5LQyafBTBxmM5/mQERf
X-Google-Smtp-Source: AGHT+IG54AP85ReLeStzm50YloqihGpwC4SrTBSqpreaYPWTNyh+YRChW1XWOR9iB/p5XSFvReEt9g==
X-Received: by 2002:adf:a19b:0:b0:38a:418e:21c7 with SMTP id
 ffacd0b85a97d-38a418e22c3mr14024707f8f.53.1735591285437; 
 Mon, 30 Dec 2024 12:41:25 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828ba0sm30423061f8f.14.2024.12.30.12.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 12:41:24 -0800 (PST)
Message-ID: <1e1b7a2b-a7bb-4feb-8443-3ff263508c28@linaro.org>
Date: Mon, 30 Dec 2024 21:41:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hppa CPU reset and speedup
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
 <32a4d72c-6cc2-4c33-876d-ddf66b71fab4@gmx.de>
 <c778e5f6-8b9b-4a7b-a3cd-a7f8cced87bb@linaro.org>
Content-Language: en-US
In-Reply-To: <c778e5f6-8b9b-4a7b-a3cd-a7f8cced87bb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 30/12/24 21:39, Philippe Mathieu-Daudé wrote:
> On 30/12/24 21:24, Helge Deller wrote:
>> Hi Philippe,
>>
>> On 12/30/24 16:25, Philippe Mathieu-Daudé wrote:
>>> Respin of:
>>> https://lore.kernel.org/qemu-devel/20241229234154.32250-1- 
>>> deller@kernel.org/
>>> "Add CPU reset function and speed up runtime and translation."
>>>
>>> - Remove hppa_cpu_init()
>>
>> Thanks for picking up my patches and integrating them properly
>> with the reset code.
>> But sadly your changes somehow break hppa 64-bit CPU support.
>> I think it's to when the reset code is called.
> 
> Likely hppa_is_pa20() called *before* CPU reset...?

Indeed:

(lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.10
   * frame #0: 0x000000010024df30 qemu-system-hppa`hppa_ptlbe [inlined] 
hppa_is_pa20(env=0x000000011f822230) at cpu.h:304:17
     frame #1: 0x000000010024df30 qemu-system-hppa`hppa_ptlbe [inlined] 
HPPA_BTLB_ENTRIES(env=0x000000011f822230) at cpu.h:309:12
     frame #2: 0x000000010024df30 
qemu-system-hppa`hppa_ptlbe(env=0x000000011f822230) at mem_helper.c:642:29
     frame #3: 0x0000000100250564 
qemu-system-hppa`hppa_cpu_realizefn(dev=0x000000011f81fa00, 
errp=<unavailable>) at cpu.c:188:9
     frame #4: 0x00000001002f812c 
qemu-system-hppa`device_set_realized(obj=<unavailable>, 
value=<unavailable>, errp=0x000000016fdfebc0) at qdev.c:495:13

> 
>>
>> Easy reproducer (no other options/disc/network needed):
>> ./qemu-system-hppa -smp cpus=4 -nographic -machine C3700


