Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7372C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7HjG-0006BZ-UC; Tue, 22 Apr 2025 13:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hih-0005z4-Uh
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:47:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hif-0001IF-4H
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:47:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso5240563b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745344057; x=1745948857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/wcsraWq3/AJDnU6Bji9fHtIWW61dpCSbuM5Af+ngsI=;
 b=Fs+Pf4TZyCbPIU+ZYZ1LJxiwgxEF0cwFI8uL26IhvpudZygMsPMtrnnTDMPxohLHIR
 mugIUvTOKCH9MyO9B+kCxsbKOcjlbYtTViLyRnsF9/kOiuCR6gUyULg+nOo96k16bjI4
 tajmWyKVIRgMUfu37RWi0kOxB3Gzlmm3ao605qYcY+jn/0PYSj2lyemcexAb4zEmwwKy
 6BFbPoB40UYc4BmmnzG3Lv3pleIxJ5Al4jcoyoaIAqQLdVeyo3JBTzmXBncSqFRQ2jGl
 hGTg2EPeNX0TWjqhFjNXB1L7C7y8v/4RliVHKJpk6Io9kkqKjRSpRIhaJ8yVqHcvZfPM
 LfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745344057; x=1745948857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/wcsraWq3/AJDnU6Bji9fHtIWW61dpCSbuM5Af+ngsI=;
 b=hwD8hhrFir9HsHunArxJe9NVvh9qtwHY0v37kn3ZEXFaQJXq15L8s8hQMKIEHLZjxR
 CLx8b6rvbYf93CySTyL7bDcsfkHhifLRklb0m7/gKDmV3y3FNh6/HpM2wu8TqBhXoisg
 ZJelbzAW40oIPu+h8o78vu7sRUYvTxKkWC3UDTLfJ9Mj9uPcHJ3juVRTAEADaD7VdqXy
 P7H7LI7Eru/Iongc2PvgKHIK7RGkLQqDbt/AwVWpsIC7m/pe4YKhIsAV0dJn/QnVc7Sd
 d+Ss2lW+iQVMjvujPA1rnkdUnF+yT7K7IXG3DjY+ixZhsL7ie/wECTfj+vrYqQro7uZ8
 U2tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnejmldS+/P1J2+9XEs62Xv2d6swK6zcxmzgjIhiC/gLxB/saeWxMKIEaJGXaKwZSvu62KRyNg/25d@nongnu.org
X-Gm-Message-State: AOJu0Yx1MZSG18A6BWBKUK+9EpcWbnUOX6KzbTXTeEapJGu8CxhC6x0k
 qZ27nxq6v9OmWl9AUfEP1XYftCIlQeTOFOpJKK0QEBCRDFjJEF70YmvhI1FiFtI=
X-Gm-Gg: ASbGncud6pQOP9r2zGoTKyj2CVhm5oP3oTUQ54RN170moL+tGuOFNe4UuWMnRFPJoG9
 e6d2tqXAA6PMKJJx/6PXBb9c3FGsqpJ6nAwquCp5uPMV8Qbt8lK3T9ilv79oH+Rh4P5VaHP1jPZ
 Q6Ot3eVxFpnOrrhmJQQySN3pEdEXd1aUcdqPoymqzjOZM+WENavmBuNChJwvpMjXf1T/Vb/XWcW
 52TNjmKZ2I2lS0U+86rR1owLl0qo8ykqprTJdEE67vSoVzPyz4Ai9uIJgPearlZXXh9KrD7kXCG
 2yC4JooZFL+/FzEkLm2EtXWRxE6W6ToqN76aibYZAOJYm3Alt4obv4tb8fAScqrxzGeft9H9wEe
 +fsX8r8s=
X-Google-Smtp-Source: AGHT+IFiMHCA20whzO2uR+8iQRdh2mUy/6YIHI5FxG5lSlQdcIe6V8d/KO56GcYyvmFCKX8gHue9KA==
X-Received: by 2002:a05:6a20:c6cb:b0:1f3:388b:3b4b with SMTP id
 adf61e73a8af0-203cbc524f1mr24015829637.15.1745344057689; 
 Tue, 22 Apr 2025 10:47:37 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13c623bsm7543853a12.43.2025.04.22.10.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:47:37 -0700 (PDT)
Message-ID: <386cd2c5-7ef4-4f4d-b868-109ba48a597a@linaro.org>
Date: Tue, 22 Apr 2025 10:47:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 16/19] hw/arm/virt: Replace TARGET_AARCH64 ->
 target_aarch64()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> Replace the target-specific TARGET_AARCH64 definition
> by a call to the generic target_aarch64() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> This removes the last TARGET_AARCH64 in hw/arm/.
> ---
>   hw/arm/virt.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

