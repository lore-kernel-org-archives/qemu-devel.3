Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FAAC3ABAA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 21:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBK2H-00088N-9W; Sat, 03 May 2025 17:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBK2F-00088F-Fa
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:04:35 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBK2D-0003yb-Cy
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:04:34 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22435603572so39333395ad.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746306272; x=1746911072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TORx/2/Y2JhSzoHxBmjTB4FLvtQF6tGXSCoip6hDio8=;
 b=K20hjobLryOWCeWEUWWpm1Ews4abrMtdVDg/+pecL+uIiHW1z5cYVFBlTpIM/uLmSu
 SCGkswNcSMPMkWc04q7a3TZpTJV0Ynm88wVZyrDiDcktIdKpLUcnfaG/gRQp6AXC0k+7
 Rlbte1WhQCs0DL70dpaIMjzpBJ2gxkU6O+1KqNvIfB+QhFoyHbZ4cNLjzH/+rX3AB4hO
 0TenzwFVEZotQWUPYtajCfsLbwNt9vDf4PHZoC90kSy0Fd6r3EhmJQSHCCOFr7SqKDtm
 J/H61Si9lcrvIrkE/lvy2oRSh4HAMminbNjEIL/bSp37Yg1+fQW5gYvFrutxcFpFjiE2
 /kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746306272; x=1746911072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TORx/2/Y2JhSzoHxBmjTB4FLvtQF6tGXSCoip6hDio8=;
 b=kE0wUNyC7AqHZmp961TQgWFWxALKkShI/E6u+PDoxd0TQChv9GKyEN8GnvEPzrcNxS
 P3JEROzWV09+zel4fxHSEakLmJvixZwVriOR1dSyafUJd7DREFUzlm5g90DUfUGLuDHp
 lPRG/R0FD4GW4TywVgPUd8HiI1wVM2v50td8rvU5qEbouhszMw2coWpw0Vui/N+tPlqY
 QzQUnpnghpkr6hDE+6LdlpTl+6ZK1fD8oQtApX8hQGrMWRZMxv4efGry8qxewZy2GGIU
 4kgeuhoflnR360RsQDB3201QHC6TJvgQjs0QGKQ22VX0hzL63jNPB/rH8jrQBK/VgsdF
 lV7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX79V2P8/lfSGUqGhHqLhkAZcihxrIAQC1T3FKHSlVZCm8j2G2dm2WEV3URX9HollGvaKK+pGNMEyI7@nongnu.org
X-Gm-Message-State: AOJu0YxEJU9Z9wnKXom6NbLxPwwiu2xRro85GzYISR9hrhEySyP38Eiq
 A13Ksvs0XIk48zjC7Nsv1Z41DMqMYCd8mRLCV56HYuo2c8tkwYjaiRpryRdyQ8c=
X-Gm-Gg: ASbGncvADiGYuxkCJYaao5p3718mnVUDvQJMOKlQTtzioCp2rt7ChGVgthxG6IlLwIv
 qKeiYu6rSSaizeoRpn7QAkIjRv+Td5cNEhTupg/t/xInNyiuoV+V2Vi4n2YQt+NGBYYBioneWO7
 IFxud4IqJEeLwbJX9BiSCUcpoxEscPo+7D7WR0FSAzocqdFyU8yaMG13LP8nUD8cBiJO1KZgxbC
 crOdrJVlQg3cbUbktgNf7MkWyz3VW61tWlFBYk0oxwVwIvmWtjfc9Aa+8e+xeWAph5Vnii7mtIE
 Wo9liaf7a6fdKrFM2XIl2irZqHTZga7VHUjH1kEsmThFq7IW3M+dFQ==
X-Google-Smtp-Source: AGHT+IE3K5TN+BZs/hnHEJdKe8czHykOn8xgmcKXoTjK4u+Jx9xC+QZal9LrI//3LhL+wUe1CVHr5g==
X-Received: by 2002:a17:903:291:b0:223:2aab:462c with SMTP id
 d9443c01a7336-22e1e8e6848mr29383425ad.15.1746306271879; 
 Sat, 03 May 2025 14:04:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e15232648sm28028255ad.258.2025.05.03.14.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 14:04:31 -0700 (PDT)
Message-ID: <76d64f04-c1ba-4dd6-8014-b7e31a00d3a6@linaro.org>
Date: Sat, 3 May 2025 14:04:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] semihosting/uaccess: Remove uses of target_ulong type
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250502220524.81548-1-philmd@linaro.org>
 <20250502220524.81548-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250502220524.81548-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 5/2/25 3:05 PM, Philippe Mathieu-Daudé wrote:
> Replace target_ulong by vaddr or size_t types to match
> cpu_memory_rw_debug() prototype in "exec/cpu-common.h":
> 
>    int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>                            void *ptr, size_t len,
>                            bool is_write);
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/semihosting/uaccess.h | 12 ++++++------
>   semihosting/uaccess.c         | 10 +++++-----
>   2 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


