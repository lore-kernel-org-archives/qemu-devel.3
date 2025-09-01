Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436D9CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2jd-00072H-MT; Mon, 01 Sep 2025 07:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2jZ-00070I-J5
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:30:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2jX-00071Q-9Q
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:30:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b873a2092so14630265e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756726197; x=1757330997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CUeYKEF9YUGOEOmr6AOP4g+gurf8mRGjO5YsfU0OIIw=;
 b=Yu8vr4ggofQAsmBupi+3ml25hW3veOaMx/c020uLXQj1q6WPATJBusoE3qJGJrdAzI
 El/HQ+8/ozAXXZM6pFFIDKaxf2TjO9YF3DV3nVyu/L6v3gqKvBbQw+1p3d41Rpnpjzox
 sKEfoIgbmw+uObk+8tbTuLe7qbxlDbBZjOOEj8X5qcALPi2lP3LBodbV8Y10SFogIIMo
 t2OV/L0OVdwpaEiPHEXxPzLSWcIKLvMNjOgmpssQppiUeID8khQJU2Tci8T6hAA74dQc
 kHlWHXiw1uiMKB5uAcfc9U/DNu+X2tsrdlswn+VjJephn7oik/ssbM9TjXCr9we5Totc
 lU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756726197; x=1757330997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CUeYKEF9YUGOEOmr6AOP4g+gurf8mRGjO5YsfU0OIIw=;
 b=i4Mgh/pUwMS37qWuYXFyPBofL9d8E83quoEUNjF3DjqNd4ZCefo/8lVApvm5/CBoOT
 ulr4BHs4DTBdFvwSVhctAqMAbEmhHWGENMJcoeRffm8jsMm2KkRJ7Viq/viWba+/x06N
 tu0jtB1jDcdX0VZW3H15XiyKdyxW1AQJgrdjb78HyhZ9+AGlll61TCLRLuX4VPcNXWNq
 BGTOwnPv5bIw2qdNpNGA+UkBf5eHyKKM4RvUsihyeaX9CmMvLCCVGsqNsUIcPufciZX9
 gqRVzi3rpsMbpuHyYyQD0lqPUg2zFCECoEgjObtCaYHQ7HnLFGel9m/9C9g8I1mhIUXq
 afpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+/iY7c5oJio9UAhmCKmwgbLqbVgphTjNbGKKCEq7lbmYIbCLcpKfYX79GdldrYu4dPT1idJ/8jUdS@nongnu.org
X-Gm-Message-State: AOJu0YxcuRi2eHTR4ghcP+ez22APo51+xUgvg86D36TlbXq5B7l+XjX4
 psoWCosaVl3Oe0tKt9epypKjT/LuXUo1j+vZfXJGXvlBkFxbK4MuWs6JxvQC8/3qDcA=
X-Gm-Gg: ASbGnctXfinB6Ax1vfyF0gL3PtJWrBPpLkjrX23lRaZBTInBo/ZpZqpAwbRmxW+tUEC
 wjYXNsN2YNDRLE+D66ABPFVb74UW5wl97AW++zGUOp7gLmzcjOdLaHTUx3BLQihJwb1qzbskZey
 dzwbM1ZVrqoa1AURMjO1U/2l7vJMmme8Gzb/YaTkkJ1IMfUpt+/1SKAp09xCOcHD6Hp2lXvF1te
 NiQ6uvtVwt9Z40XKZm173fooG6K/sUlPqOdpfRfgT9dTQ4R8PhKNd7+eo2NvD+6+qFweKF5D5+E
 R6ihIMhQtW2cPMXeRmzVnJe6qrFObO1oThSA1dlxGf/m0F5XuuJ+IKXTPLpgGsV99F7VHVmX4zL
 iWYbrjOQoyaNibgz45QtW7G0qfmqKEHuTPAHk9sjOXt+SDuTZMFmCmNmQaFydZlPWmYzUQJO8Zm
 JJ
X-Google-Smtp-Source: AGHT+IF4AQHXoFYeJrRM/5+e3VAXjebU+BOI8V2opQGybd3wftAwyckYiOenfZPT7aHcK8tRERYLhQ==
X-Received: by 2002:a05:6000:24c3:b0:3cd:590c:61e0 with SMTP id
 ffacd0b85a97d-3d1e07a8164mr6479021f8f.54.1756726196826; 
 Mon, 01 Sep 2025 04:29:56 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm15034622f8f.27.2025.09.01.04.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:29:56 -0700 (PDT)
Message-ID: <e6f01bf9-18aa-4426-a6d7-348582c8b52d@linaro.org>
Date: Mon, 1 Sep 2025 13:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] accel: make all calls to qemu_wait_io_event look
 the same
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-13-pbonzini@redhat.com>
 <7deb3e06-96a6-4ad8-ac51-6387b5f51ccf@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7deb3e06-96a6-4ad8-ac51-6387b5f51ccf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 30/8/25 00:16, Richard Henderson wrote:
> On 8/30/25 01:31, Paolo Bonzini wrote:
>> There is no reason for some accelerators to use qemu_wait_io_event_common
>> (which is separated from qemu_wait_io_event() specifically for round
>> robin).  They can also check for events directly on the first pass 
>> through
>> the loop, instead of setting cpu->exit_request to true.
>>
>> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
>> ---
>>   accel/dummy-cpus.c                |  2 +-
>>   accel/hvf/hvf-accel-ops.c         |  2 +-
>>   accel/kvm/kvm-accel-ops.c         |  3 ++-
>>   accel/tcg/tcg-accel-ops-mttcg.c   |  7 ++---
>>   accel/tcg/tcg-accel-ops-rr.c      | 43 ++++++++++++++-----------------
>>   target/i386/nvmm/nvmm-accel-ops.c |  6 ++---
>>   target/i386/whpx/whpx-accel-ops.c |  6 ++---
>>   7 files changed, 30 insertions(+), 39 deletions(-)
> 
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> To-do for myself: It appears as if we can reduce the number of checks 
> for cpu == NULL in the rr loop by moving the cpu=first_cpu assignment to 
> the right place.

This was my intent here:
https://lore.kernel.org/qemu-devel/20250128142152.9889-2-philmd@linaro.org/

