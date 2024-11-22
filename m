Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B92E69188
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 18:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEYcb-0007OR-FP; Fri, 22 Nov 2024 13:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEYca-0007OD-36
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:43:12 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEYcU-0006fd-UL
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:43:11 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e6359ab118so1165794b6e.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 10:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732300984; x=1732905784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PdM+BqQIo22AKDYK9Rrza0MTeseChHAw5oixQAco274=;
 b=wVS0J1XKM+7nQrKSUUGWlizkKJfzvqSgpVnUE2BMTYwCCkQiLlmIa9iImmlXlLtgi/
 BqUNTvWddvxYk9jVzrfF0U1f7CKzXKrHeN3YI0YGANHOWTTATQpvi02fZIsQsVNRnvs/
 d2cp4kA8IMsASaELHZzwBkH17bhFc1e9nJto0qcyXZSrX9mViPD4Bu8Z/wVF3l5mJRsv
 ofM7kEGULzuAp9X2N/Rz+AnGzBMpiBpdyc0yzJ0is+InHslPQ4hoDL6NPXhpHwOXd5QC
 AqWzgSSRCDvsTeTwjaQwG0r6F+42z+klYpFXOiyczXpV5sQrPToPJrBTyeJYWi88liKI
 UnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732300984; x=1732905784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PdM+BqQIo22AKDYK9Rrza0MTeseChHAw5oixQAco274=;
 b=D9jsHdzczL5I2O20vKtKtLfid6vxduIMaNbKmPPE0SHeUjVGBtx8kFbNw6J12pTkK4
 TibLXhwzbqlloHtqHTSm8w0owEWYyW3fKVrj800O+APygzlQOfezMRXGsXdWclIDyepS
 RGPPQn0OtGHnRlyotLnWR1zGsmbLqppvA7WbijKV+t57mGfnMl+vQoO0VNVuGZZWumg8
 UZv6EA0r1OqKJbLHneh57btiR6TDcfesOg8SoiHOKBtVy6bpK8GDX50ZGLEng7KECAjL
 yGZvbGfhUzYBvvaGsRNc6D+SUPmC8HmwigkYiLSEghM1svn7YCI/QcLXQqZe/N4zISrj
 1XNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/qiG/x9Au7vWZHWQI7W+tyqw3srHmze/uVcZ4Ghcdb8zSHvQdAywx5yGBsPHD5lfPjGcHU/DRr9j/@nongnu.org
X-Gm-Message-State: AOJu0Yz/SFf5mSI4zzESgIqoJG6jS8aTWDlBLFxUw2/Kii4BTKfbIfyl
 Vm6FF5K+bk/0XFZp3xSTOWlO91+bJsRp/nHe7MUBiRofM/ck5rH4ZAyqNOCMWoQ=
X-Gm-Gg: ASbGncuFGmRcz97GDf3xfQmJPa0fNDh27RaXkv3YHq1e2sM3uxuMnQuyrGXvMt3uWGL
 yib6RY3QgyOfbU/6c005SxlmRZao8HwB5Izpcpis5MI4UAyYShgcpo473E13RRkCihI2Uy2H00J
 6dTXcqDFWc2GBriCxiUnZcGBUiKJn3TJS/KscQBRDn1mdS0+05dUnitsJuzIkevuFs5lQfKRpaI
 YjMwuCHFQNseagoqAvnUMZfN/Wu2bx4G7xow//JdifeHcJtwwI70OslzblJdZLCVQ==
X-Google-Smtp-Source: AGHT+IGRW22WPxybUy5N+SUqg7icWDX9HNSoX09+wqzdLd5D9KzjaBpCr+fYLEJaIRqt5TM1YrWAxg==
X-Received: by 2002:a05:6808:1b13:b0:3e7:9e8c:304f with SMTP id
 5614622812f47-3e7f0f7a0e1mr5539041b6e.7.1732300984649; 
 Fri, 22 Nov 2024 10:43:04 -0800 (PST)
Received: from [10.25.2.124] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e91500f765sm505131b6e.50.2024.11.22.10.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 10:43:04 -0800 (PST)
Message-ID: <eaf906e2-3973-466b-8a2e-f7749e844968@linaro.org>
Date: Fri, 22 Nov 2024 12:35:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 36/43] target/hexagon: Add temporary vector storage
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-37-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-37-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 11/20/24 19:49, Anton Johansson wrote:
> Temporary vectors in helper-to-tcg generated code are allocated from an
> array of bytes in CPUArchState, specified with --temp-vector-block.
> 
> This commits adds such a block of memory to CPUArchState, if
> CONFIG_HELPER_TO_TCG is set.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hexagon/cpu.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 7be4b5769e..fa6ac83e01 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -97,6 +97,10 @@ typedef struct CPUArchState {
>       MMVector future_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>       MMVector tmp_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>   
> +#ifdef CONFIG_HELPER_TO_TCG
> +    uint8_t tmp_vmem[4096] QEMU_ALIGNED(16);
> +#endif
> +
>       MMQReg QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>       MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>   

Wow.  Do you really require 4k in temp storage?


r~

