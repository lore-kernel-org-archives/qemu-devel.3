Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5115CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 18:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5TVQ-00088N-V1; Sun, 05 Oct 2025 14:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5TVP-00087x-1b
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 14:30:47 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5TVM-0001xW-Qd
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 14:30:46 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b57d93ae3b0so2795393a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759689043; x=1760293843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HML2Z9SJtp9j8oVDau24ShONtMFfv7e8TigagCYna3Q=;
 b=de8qrGSrbWBmHWQEXqwjZehqvoYvsSGTUCTeelPVUwuQyUhmi1+EPmXGPzO6u6S7QH
 qMctq7ieOKctlHWdlDCjBY55oorDUmJLIrjLhEo8MBvF2vFDLLxrZQVQNyH6B9tXQ4PM
 0f4m46NFhEnVRQFAlqQg6fo2jTleOZObVGK3Knfot2FRS4wZt9RHZNXgcQVH6K+P1sA5
 Wsdl1MOwmTocacWFlmAlTmXDF1gRRlYt2+CYSkT/dzMZ1pk3bZ9KIz46JZzrOGqxYpnP
 acL1SmC3KMdxkThteX1EU4J3vqUog+3pT9MQw/K8WGHchvLFrzB722LKcbjkmNV8i4Uk
 JicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759689043; x=1760293843;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HML2Z9SJtp9j8oVDau24ShONtMFfv7e8TigagCYna3Q=;
 b=Z4uTCFdn0pyldCc7kAPl9QiVCyTpFvDspBI6NpCP7IMKm7Zxa5657sZlaVRDtgw+bb
 8NpeeeVfL9jgeJuRAYPb8kJz7RYVcB10L6hJhhO+b89YI06ty9C9T3R++gTrBQJUNx2/
 sGQbZENbp0UFpAXmOaKvGc/clHf5xnVI4eOxp5OSstibsdEkuo/9fFcZSsibxJJoAVei
 I6sgEyz9WMVTW3T4aNnX7+Mtt/cWbaSmbSVHwUPIxUhpHUQFbHueNWtoMwP9pQAd1ONJ
 NQt5NL6nhVrsJddBn7o441kfgs5y7Z4rQkRbrC4YwWq+4l0U1CihkQn31MeL+G/wGJCx
 j/lg==
X-Gm-Message-State: AOJu0Yx7M0Ttq+UkvIrH2Kshyud11B/tzyJk4fp5ZPuCoYBR+jZSztwM
 dAviISdAUhQ2bNODYMOvotRzDF7lGVx66R6ZyqkkOOwJ2tx3dNpC/Gee3SW2pV4ViyA=
X-Gm-Gg: ASbGncv/igglpHgsOmv36KTKl/03Fb57pc4q3cCLSvKmS40bEGugrZuZ6Bsz6tHtJRE
 vNsrcvCmU2yuMMj8NKKXUO0rtoB4VIQwiR9/ztyqdCVRvjM7mBv7WuJu6IWerO3g5lrcWD8Nw+T
 eKJB6vrddXf1MwK1MbUAVigrl3DYByS3YbRC0dMcw3SxXksvZmY5LIKR3nQc9mQMsd2P2Sg09iN
 bEWCeilotXztzj5jJfaLEwECnCSLSc/Ugratez0ndOwPHZRU6vDn8ahNOXPIY0Nk+iK0+sjopjI
 BzLFHkWMbDcjU7/qtDbfhM4KxNDHARxMPDRCmyLCSh2SDuYvraq96Dt8yPwTnTCSsbSpV13rswa
 gwI0wUCnVSkWnJY13WMcaf+8LX4bl7q7pX6F+S10vd83nEO+kTCOAo02K1/HuKjZoYyUevGV8DY
 o=
X-Google-Smtp-Source: AGHT+IF6EKNFI96c+llcFYxMk1kreCG16l/3J4MEJsezhgYU7TsyizKSjhFbcjzZ3nYYOTRgSU7pEA==
X-Received: by 2002:a17:903:11c6:b0:262:79a:93fb with SMTP id
 d9443c01a7336-28e9a61a8a9mr94389775ad.32.1759689042798; 
 Sun, 05 Oct 2025 11:30:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d038e4asm109529565ad.0.2025.10.05.11.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Oct 2025 11:30:42 -0700 (PDT)
Message-ID: <b95bf540-0b6e-4812-9393-9b7991ed501a@linaro.org>
Date: Sun, 5 Oct 2025 11:30:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sh4: Use MO_ALIGN for system UNALIGN()
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-devel@nongnu.org, ysato@users.sourceforge.jp
References: <20250503212708.3235806-1-richard.henderson@linaro.org>
 <46ea9b87-cc73-4408-82c4-2de96dddca0a@roeck-us.net>
 <6c23f546-c135-4345-93a4-25d75a038902@roeck-us.net>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <6c23f546-c135-4345-93a4-25d75a038902@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 10/5/25 08:43, Guenter Roeck wrote:
> On Sat, Oct 04, 2025 at 05:14:45PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Sat, May 03, 2025 at 02:27:08PM -0700, Richard Henderson wrote:
>>> This should have been done before removing TARGET_ALIGNED_ONLY,
>>> as we did for hppa and alpha.
>>>
>>> Fixes: 8244189419f9 ("target/sh4: Remove TARGET_ALIGNED_ONLY")
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> When trying to run sh4 emulations with qemu 10.1.0, I get quite interesting
>> error messages. Bisect points to this patch, and reverting it fixes the
>> problem.
> 
> Actually, it is worse: Commit a4027ed7d4 ("target: Use cpu_pointer_wrap_notreached
> for strict align targets")  claims that "Alpha, HPPA, and SH4 always use aligned
> addresses" which just is not true. At least sh4 generates an unaligned trap and
> handles the problem in the trap handler. Result is
> 
> ERROR:../accel/tcg/cputlb.c:2944:cpu_pointer_wrap_notreached: code should not be reached
> Bail out! ERROR:../accel/tcg/cputlb.c:2944:cpu_pointer_wrap_notreached: code should not be reached

Yes, I posted a fix for this one yesterday.

https://patchew.org/QEMU/20251004192414.1404950-1-richard.henderson@linaro.org/


r~

