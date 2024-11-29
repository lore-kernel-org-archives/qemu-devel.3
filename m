Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65613D729E9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH3HL-0004Jh-2S; Fri, 29 Nov 2024 10:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tH3HH-0004IS-9R
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:51:31 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tH3HF-0004G9-JS
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:51:31 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53de7321675so2165000e87.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 07:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732895487; x=1733500287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l6GbRsi4xYGNJmdLMTpuhoNW1mMD7LaCmhGSt+KTelE=;
 b=a1sW/bJnZnHBU5PBPiyp6C555eRZr0rAnCChwca1CKlezl9Sd9Hn4+OWKQw1wH2DQV
 Xv4Nzms4XFCoWPZIMJfZGymY2gVNmdOiZ6diZZzhgo1fRaMPM7BNPv89++4N/QpobWjm
 BlVMCudlZ8l0J8N4ErDFDE2vQOAu3/jigBckOlvON5FsDRNi9W1L/E6xvs9W50yo97ar
 VI2qUPBlKLPEBRlAjDgAatKbZd6FX9+D4wPrSfHB+IvyoOHXj3IYFc7t5Ck3L+RmVg14
 Msbd9RVNm+cU1wd5pfhHXOIdHBdrMbkCLTLIkq0uIpP6E5vuIPbR2aKST1+bwPm07IcF
 Xbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732895487; x=1733500287;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l6GbRsi4xYGNJmdLMTpuhoNW1mMD7LaCmhGSt+KTelE=;
 b=bm/Jz5BUjxfJZwQCsrRvsK9iJ+O+An/7BfHwTFg+FNRiFYtQz595b0pu3YPxCrofCk
 RKL3KfM22tZz8afVb0juYuH5c/+scBIsvSx/OtwNLNiMe87m5glHCPC1rel1PqrMVaJv
 qnN90xTmZKl6a6Jrev18spKg/4EkMRIxfgjI9nb1I9RL+BJR3WfkwlIeFb+/FgYoXj1d
 /bchYhJjLQuw6GIlaX6t4eG4DQ4ZRIozzHSsdImiNwurvZQyL3a3GGdHBDHS/pD/GS0L
 zMihZWlXHGtSrSdT3re/N29XgVxpvieTdRKcarX0dcRxCf98CxT8hX3eU0VIqCETKaWY
 V8bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs0ODDZah7vyrFICi5u3bDYsRbJX74zBiJhfmMzb2eVMwE/OIVakUMPXWutKtKz9BAuig5TnJzdnFJ@nongnu.org
X-Gm-Message-State: AOJu0YwGu3L8toYwn39lSpVMXrwaMJaHOlj1ZInynroiOXj8jftK/yVt
 fpv09P4lkxRVbQxWUtQZZdut9Jof0wMUjk52RkAcqMlehi8xnN4MhyQ+ztkGLLk=
X-Gm-Gg: ASbGncv7dpYvWL+P4ljisbv0nh9BxxI+xHFboKtB4BgzUcxWUbBZMVDz3mdIdzsQYPZ
 arBRqIt9zRV0ri0E6PpDOdsOVxNWcBr3w+Q35jDvmCn8dQcv+qyKB8w4jMPkA31MvHqNRKYovUV
 ezYtSjyzr1aIJ+LACbuutMQ+AGogqc6YIMlxCJg7j7y7kxHIsgots95Q1bcNiki9pm5ahXBVB8z
 WpmHQkinJ4Enni0JrwEJJ9Uq86alm40v6OQWYB8YBPgyGQBkpbrrfSVUn05tLIAXA==
X-Google-Smtp-Source: AGHT+IFKW8cymzU6xEaEBXVBhlzG16+Lr5c3OANtasHaI+TJygDXYCZOPaNkb4Pr+2BBsGH7dO/M0w==
X-Received: by 2002:a05:6512:ac7:b0:53d:e50a:7032 with SMTP id
 2adb3069b0e04-53df00ff78amr7179877e87.44.1732895486725; 
 Fri, 29 Nov 2024 07:51:26 -0800 (PST)
Received: from [192.168.69.100] ([176.176.147.124])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5997d413asm185768966b.59.2024.11.29.07.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 07:51:26 -0800 (PST)
Message-ID: <38e7ffed-9579-4c8f-a4de-12b57c5e03cd@linaro.org>
Date: Fri, 29 Nov 2024 16:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd_iommu: Fix kvm_enable_x2apic link error with clang in
 non-KVM builds
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Suravee.Suthikulpanit@amd.com, Vasant.Hegde@amd.com, 
 Santosh Shukla <santosh.shukla@amd.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20241114114509.15350-1-sarunkod@amd.com>
 <11a21260-cf71-495e-94bf-461fc0f39686@linaro.org>
Content-Language: en-US
In-Reply-To: <11a21260-cf71-495e-94bf-461fc0f39686@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

On 29/11/24 11:29, Philippe Mathieu-Daudé wrote:
> On 14/11/24 12:45, Sairaj Kodilkar wrote:
>> Commit b12cb3819 (amd_iommu: Check APIC ID > 255 for XTSup) throws
>> linking error for the `kvm_enable_x2apic` when kvm is disabled
>> and Clang is used for compilation.
>>
>> This issue comes up because Clang does not remove the function callsite
>> (kvm_enable_x2apic in this case) during optimization when if condition
>> have variable. Intel IOMMU driver solves this issue by creating separate
>> if condition for checking variables, which causes call site being
>> optimized away by virtue of `kvm_irqchip_is_split()` being defined as 0.
>> Implement same solution for the AMD driver.
>>
>> Fixes: b12cb3819baf (amd_iommu: Check APIC ID > 255 for XTSup)
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
>> Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> ---
>>   hw/i386/amd_iommu.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> And queued, thanks.

Already merged by Paolo as commit 0266aef8cd6. Noticing that
earlier would have saved me some time.

