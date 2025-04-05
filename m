Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5EAC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u15xH-00033p-T2; Sat, 05 Apr 2025 12:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15wf-0002oc-Cu
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:00:34 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15wc-0003mU-Oz
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:00:33 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7376e311086so4063729b3a.3
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743868829; x=1744473629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PLatWfw9oInPRvtkWdF3os9zqoZUGIBJEQl0fXM2vH4=;
 b=LiFWTidWfs6fWktuA2UYR0UXvSsnuqYEV+bn5jtGYB1+OhHwGOR9YySyufiHZFsEKy
 2gMoegiXFVVh2vCs8ga+0MGP2kbkjLWnq5am3X4EMdEo9d00OGi4tedIeEaLGNAhPBg1
 T1CNSh5vD1KpDgeUkv0cZEhNqV3obISevNPPaebPcsAj1ON2ffrxNaUPhRl8N3ZfxqqM
 toISmM2LcqylYht2szujUj56zcH0kvkusvceEb9Z73Vjb87BzmtUmF9eHoausryw5kYF
 7XTMQDdyKZdmJl5pTb0J2ZcIMWtDKcV5qMUyft+j1ShMiYQ3e7IPZCZxAl+ksEOeCtwi
 v22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743868829; x=1744473629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PLatWfw9oInPRvtkWdF3os9zqoZUGIBJEQl0fXM2vH4=;
 b=mvNA2Pas7t0teUeAUUOmexWrKIn8u0jLOw/1No6ZJrzXmYx8NZ4A/ninpaX0/ePSHY
 H/M8ATUmar5KFNqNuRv8vrvpQvVmbt+2LxGT6GtMic3i8Xuj+/b73oU4ZG6j8AgKzVZJ
 pUbxiUtcldgzlip5f/l4N4vIk/GWU0lRtNYNw/lnVjVWFAmbjgvNkWMtndANy10vAxMZ
 PnPn6Vlkb4oajiTMAEutRzwNYF3qyVHfzJcFgpoU3lXaZmgxjb2/wMCs91JjYvVQT9m4
 F/0Z/7++KgWMR730WTKcf7abvDVu3syrUU8X+kUyJGZBpKY6GUds4ItaN2xF3silJs4x
 I7Yg==
X-Gm-Message-State: AOJu0YwvY0kpjVYfHpeUItcODYMots2IFinAVdvcqEj4VMQ6OrWaqru+
 Y1MIizhOwEvLFrm57szmdVJQU7PPtmU8S9md6sBDOgzcgyhPj35Qu1BFLgsVg2f6eEABq/ooOcG
 c
X-Gm-Gg: ASbGncupwACQZUVrc6v9gY6O3GiCyw70mKh0hwMqDPbGS/1Oafp8Klq+z3xP62lBH3c
 dEa0aPaoXABbMtd0PkIqWbZW6QeBlC4MpLEguY/DONtE0YUjTWUtJdtEw40O3A7cwvwH+X6NoUM
 AF/Of+Jm7H64vaZkbvFUPs6Y43c6Ny3gdzNIhWCNv3CgOAS2097UvEeB8bn+BDhZ/ta+u1GOqe6
 NHU6gwd82+p0xNPTyecfR+mAH67xXgXlpk7DsaoUVJx+xli0XrwInPR9tULkZSNKs+ovcSOFJKW
 JJgt9wp8t0UwmzzcMqO6IBwiLnH+klgf6j+ce6NfbtHdjJgOhK78n+ftU80cYoXK
X-Google-Smtp-Source: AGHT+IGmilmWGJ4mLQqdtY7CayG1bqg7a5+ZRb7R7PHcMMSwtQSJc2IUstDd4U4eRqQVM0oP7A+f7A==
X-Received: by 2002:a05:6a21:920e:b0:1f5:a3e8:64d3 with SMTP id
 adf61e73a8af0-201080159cfmr9824811637.21.1743868829032; 
 Sat, 05 Apr 2025 09:00:29 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97f2fdesm5548407b3a.65.2025.04.05.09.00.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:00:28 -0700 (PDT)
Message-ID: <754f6bd8-263f-4f7c-bdc6-79f0633ead8a@linaro.org>
Date: Sat, 5 Apr 2025 09:00:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/9] target/arm: Remove uses of TARGET_AARCH64 in
 arch_dump.c
To: qemu-devel@nongnu.org
References: <20250404223521.38781-1-philmd@linaro.org>
 <20250404223521.38781-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404223521.38781-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/4/25 15:35, Philippe Mathieu-Daudé wrote:
> It is safe to remove TARGET_AARCH64 #ifdef'ry for code
> guarded by runtime check on aa64_sve ISA feature, which
> is only available for Aarch64 CPUs.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/arch_dump.c | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

