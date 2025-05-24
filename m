Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E654C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsOX-00006i-KK; Sat, 24 May 2025 13:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsOW-00006P-Kq
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:10:48 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsOV-0005m8-17
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:10:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a35c894313so814137f8f.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748106645; x=1748711445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZHBdK1JKSIe12TJlsez3nYd9yA24c+JeQ8s5nRAjEaQ=;
 b=XIHMDgxuyfTZzsnPxuwS71q+TKfwP+F55LmQL1uGM+geEIWCAerCCbbMuFLeNSyfQp
 J0I+cZeN6Gjl9ZX9IaGFhK1WQnpMWn/FMdfLEwE8qTfvdAd7xlh6LVKux0N6E9ACVnKS
 3Zx0sGExHQNmxG8q6xtLnWp5gonrwaZNAuFsbxSx2G1x+/bd4t7V7UDdlEH0rjr4b6Ny
 IR8uuFUX8lM88VYdpNXLMbUoC+xaa11Ak8qRsV+5nrx2bmujkhAKu6li4sA+sGriM4TZ
 7lxfCxM/t1FE7WfaNwt6+1RXIFWBaUH5fgGjXmTI4svmSBZCmxCg3bVjErFFOM1B0Tva
 3Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748106645; x=1748711445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHBdK1JKSIe12TJlsez3nYd9yA24c+JeQ8s5nRAjEaQ=;
 b=udFXPCvAOqKCVImI/8tkCp8LfuIp3jQG5o2sLlxxTty3BPslKpYJiLE6Tge+LPO8ue
 SzdGd8ALTbZRgyyJsgjAUitR46nezxnG55HxTbc5xmND1FcR6t+Sh5la7MBaYPhHNRM2
 z3urPMEoGqtbOH5G+OxYmBf7Kk2mhaUBdE1NhuQxzCb+iku0fsfz4s95OLEGdKkC7HZe
 Pw+5Ujy9NsDRgdTlysoZgDKWybLu2iY7sfyxPJ3pllemsW/bUWJ2QfhWaI+aGQUZXghH
 5VZ/xjfijavGHUMnQ2eei7kn/vFLSZ2h2kSjwVhmNA0wdtoo+FzQoYQCaLDPLK2SVgoD
 ICiQ==
X-Gm-Message-State: AOJu0YypacwKhoW2c0sPR9veZTnLoofoPcFGL6cZoDwlmndzBF4/lYby
 jInHy7AmugSHn7YQcp6PiKqfCYK/clh2YM8q8wGh3na+hdojJ9bSfjRpduJ2NvdW7tFLuT2PFbK
 1ommXDwYpBw==
X-Gm-Gg: ASbGncuec4k8g76BbpWHBB2Yk5zanbh9PcV74gYj2+JGC7Jz30R4dnux8+b01/8FQwX
 5eJvG4cBW+36IW+Kd8xyrZ/PmPNoZoNh9cpRiLyUkvS64LV8W7hXMw3N85VIu1sJMsNEYuHqMuc
 9Nh6GDyKNirActMzgYR1wbKCIMNZqxhzux6vjwrKajWVK/1HzMJo6IPmIDThAI6woUagbfps0F/
 FDM9MqoZUP+B/Pp9XemxnMOoBx+QA+UF/7LVmCBvxdG5wwKmy9AQ/4jgt707scjwxCN4CqZ1hYo
 8op9xTLlRuVm1QL1G5zaV4RKsRyENsqJBzNy1Gn6aKgzrDCUbb6PmO8L0l5GT8kJbw==
X-Google-Smtp-Source: AGHT+IEkt7SsYdQlHG5LYvSR3/iLpAsc6koHZFiKk+OJbn7kSuvTGWf7SclUzNAqwhuLau9XywFWEQ==
X-Received: by 2002:a5d:5846:0:b0:3a4:bafb:adc0 with SMTP id
 ffacd0b85a97d-3a4cb47b7abmr3226084f8f.31.1748106644783; 
 Sat, 24 May 2025 10:10:44 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d0bb54e6sm1164021f8f.97.2025.05.24.10.10.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:10:44 -0700 (PDT)
Message-ID: <c6399e38-b7b9-4c8a-8dde-2270a1bce13c@linaro.org>
Date: Sat, 24 May 2025 18:10:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/25] target/loongarch: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <3f021f55b98787ad5aac1532b18bb3fa05ea2741.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3f021f55b98787ad5aac1532b18bb3fa05ea2741.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for loongarch targets. This architecture
> has one special "exception" for interrupts and no host calls.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/loongarch/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

