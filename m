Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2C3CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9mYT-0001OI-UW; Fri, 17 Oct 2025 11:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9mYR-0001Np-Jz
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:39:43 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9mYL-0002EF-Ct
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:39:41 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-290ac2ef203so20022425ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760715574; x=1761320374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qvnMkWhw0leeHpPTaTx6TsuOXQ4kT0gTDGiEKRId8ak=;
 b=K44UqoP8E1gEJLtcoSuDp0mUFzc6jcf/emd+jTPgS2Tqy5u0Ff7c+cDM9qKHIGRdmq
 tWqjunmBK5CjDR8BNtZBO1QXZnXHzzFEMGaO8OTImWcIQ+tbnJnAtK2vFrgycMk2rMSE
 g+c3eh1/oVpUKUfX7i+v7XU0gAwzN10PHSTFuOJB9NIEVLPQrYN3vBDhYj76Uv+fewhr
 K6wnYimBoFlEcMXlBVdbvnwTD+sifvgkSq1rg7tV+oKl0g02CqH2VVBNaDVQjgHNBWvi
 2CrS1FzP/X8q1BzIk3hHRImnBfVOIdsDmD/V5KAh8QdPsHDvJKHsFsrQZRj1pl0u05pC
 LVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760715574; x=1761320374;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qvnMkWhw0leeHpPTaTx6TsuOXQ4kT0gTDGiEKRId8ak=;
 b=U5exVgW3J6AZi37WShWu5rV7JOktd1BIEVMwfiPsEqQGpzqiqArxBmf0RLbh1RJ7G5
 aw9MQC7X+F3tGmCW1UHiUQpRyUBYUq/TEC/v3chtOsNrXy1kvxE0HVRUJTS1a9zABPHr
 4017ZtsJmksyqlUAjpdkou1rHil0rlgvJryyBrkIzP3urbsw0IauDshUftOtzoC3TM7s
 3Q0HdaP1KMd2FBZRmVWjOuTCKa5BALzyuq55GjLWsvjg6az0+tgX4DkTRGnKq4SSmcxb
 ga+swAz1jYqpILQwRK538ypypiMWv+jHk0X/GYcLhwGmJgdb3wJVLkdIIduBNxdTLExy
 mW4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXopcKurjBdvRVbOtsjfuCoV4nXJFu9Cg2R4phtYKhjX9aqHxRln/5kiaV2nW5u0Q5s/vyVaFtUYbVC@nongnu.org
X-Gm-Message-State: AOJu0YyGDpUHPqe8b/UojiC2hZINkq/KcpQhPYhdQrusvMkTfqVWy0vt
 0ddy6q+KzOmIGuqT4fK+dPjiYcffQKQIpzYEMABTGjq3YYaQkPdFkFVjEk1VlPAYlEpvZcc1DHR
 joZ/cyi0=
X-Gm-Gg: ASbGncs6fOg28u4GPBYwqbsFX6cAhlFgIK8UuLAZUSOsKvj7Op37e6QoVPEsqnvj/HG
 pUw5lDEwUmunqxE3WSTOTb2YqZfklL3VP0rZg8qsk98yptD9h89+asbhIF6C8D+NtXt2Hzkgozy
 LeG5g12Q9DDrDMcOiSjGsOtw5ReHA7QR1XszhaQlyqJvYc1z0cfpo2KCmCgrs+Qz5exhvaPzSxk
 ArGiXCtCn5x5VedrI0MMyJhyON0BIefzZVL/Mbd2RZcfdhvee5H01+4aJuaU9ihIv1ynR1wAoT5
 L04LyPMTHjef7CAzu9IQEfzjD2PkEQnI0shcr/GSGjhY2YdduMXV+tFAgSnBwk8jWLA6eq8H8Y+
 Wn5N8/SqUc+/p4nQMuwHwhYkAXlQmJnt3w77j7f/0yJPCyadb9Hdo0PMllpuDaXZ6Qd+vrlresO
 Ye5eb+Zv57dEvwpP6B5gzT/hKPBIp0LOzRguQ=
X-Google-Smtp-Source: AGHT+IFrM+TIv3pyVBAk8nkgPPlMne7UszfrdySdSYrMYqZEIZu8zR6mPimh9AwaO9Z2uk6irZxz8Q==
X-Received: by 2002:a17:902:e743:b0:290:ad79:c613 with SMTP id
 d9443c01a7336-290cb27c76cmr50670655ad.47.1760715573943; 
 Fri, 17 Oct 2025 08:39:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099348afcsm67887525ad.37.2025.10.17.08.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 08:39:33 -0700 (PDT)
Message-ID: <518e1d4e-abdc-4f03-a60e-9a7c413cb858@linaro.org>
Date: Fri, 17 Oct 2025 08:39:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/arm: Implement org.gnu.gdb.aarch64.tls XML
 feature in gdbstub
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
References: <20251017153027.969016-1-peter.maydell@linaro.org>
 <20251017153027.969016-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017153027.969016-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 10/17/25 08:30, Peter Maydell wrote:
> GDB expects the TLS registers to be exposed via org.gnu.gdb.aarch64.tls,
> which will contain either just "tpidr", or else "tpidr" and "tpidr2".
> 
> This will be important for SME in future, because the lazy state
> restoration scheme requires GDB to use the TPIDR2 information.
> GDB doesn't currently implement that, but we should provide the
> register via the XML so that we are ready when future GDB versions
> support it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h       |  1 +
>   target/arm/internals.h |  3 ++
>   target/arm/gdbstub.c   |  6 ++++
>   target/arm/gdbstub64.c | 63 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 73 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

