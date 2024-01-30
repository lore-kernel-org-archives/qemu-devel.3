Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F242FC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 09:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUktl-0000c8-Gh; Tue, 30 Jan 2024 04:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUkti-0000bx-FW
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:59:19 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUktf-0002Gu-G8
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:59:18 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ddb807e23bso1759940b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 01:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706608754; x=1707213554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mJ5CrPpUSXgPeXcBUrXI64tCXkyiRPRbRWQBb0m1aVg=;
 b=R9jg1I+2v63gcC5FElA2nuVJzecCi/GoihGOH/qVguU96cxqlkM8i15fq15CrCWIZN
 axW3Cp7hBr6s5EiGvRqli457McoXlPUPqXtvI98Q2wukLwT08FxkG6OosoiITD5aCNnn
 Wuyrj7ADMczgeODGtRqO17u8V694INa+j4QJTtpamjp1J6qb7ZOeVMiWd3vgk+1fdk/R
 12CZ+iQYKsQ7PMFBoYN7kkt+XiIzc/c5O8JNlsxvws9uLewLIMpfmG0cbRt7meUWS4k3
 6+s4SeIRmcsc0jYvRIFwkTIcBx51zfFZsd7SwtNn0HCybUX4pyV+DdyhaDj419YLjLfu
 6FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706608754; x=1707213554;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mJ5CrPpUSXgPeXcBUrXI64tCXkyiRPRbRWQBb0m1aVg=;
 b=YRn9aqxBoDauo60NV3VhSAfCoaYo/y7eHXWDlZq76Lc6c6I3YjkLtDq3NblP2wj61L
 W6B5G7KWBu/7LM9uAhJP/2Xz8J1kAB0pT8WOTdVyiJZ7Y/ArJuUdDppe8ZZpoAOOWZXz
 6EUyER/CNfckyeVtC3yJWqedIt28tZ4dtaUjyAHkwF+M+DV2dxfiC8k3Efo+ot0/ikdW
 wdKKYR7OatU50JG8BQN79cTpjwNne5bUuEb2OpwM3iuq62mVZ3LEy50NY+QHXxg+blRT
 8CzC3Fzs5aENUDDOzVj2q3KzKBBtF6FiUtZ48D6k14Cz67mmVIK3zZXoCB5tizMurxXf
 SFMg==
X-Gm-Message-State: AOJu0Yzvt1X8F4X5R2bQHuDDz6tlZ94q7OgqpbidDU4l0AlYWLccRB40
 0YIOclZuLuxg5gRduktADvM3rSKH3tzUtA+Wac+JHKseHiTnoPC3hIE77TIjIOM=
X-Google-Smtp-Source: AGHT+IGPX5rw1oO2e7nxgYlMOq/IhYd51boXbYS7NZ6Ezs6zK8h4AZMkCMHlpiJzSAcokWlqBm49Dw==
X-Received: by 2002:a05:6a00:2b56:b0:6de:5ad:fc91 with SMTP id
 du22-20020a056a002b5600b006de05adfc91mr3654653pfb.22.1706608753888; 
 Tue, 30 Jan 2024 01:59:13 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 gu7-20020a056a004e4700b006db105027basm7382769pfb.50.2024.01.30.01.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 01:59:13 -0800 (PST)
Message-ID: <11754d4f-c0b7-47a5-9305-84c86436dbc0@linaro.org>
Date: Tue, 30 Jan 2024 19:59:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/29] target/arm: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240129164514.73104-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/30/24 02:44, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/intc/arm_gicv3_cpuif.c        |  7 ++-----
>   hw/intc/arm_gicv3_cpuif_common.c |  5 +----
>   target/arm/cpu.c                 | 19 +++++--------------
>   target/arm/debug_helper.c        |  8 ++------
>   target/arm/gdbstub.c             |  6 ++----
>   target/arm/gdbstub64.c           |  6 ++----
>   target/arm/helper.c              |  9 +++------
>   target/arm/hvf/hvf.c             | 12 ++++--------
>   target/arm/kvm.c                 |  3 +--
>   target/arm/ptw.c                 |  3 +--
>   target/arm/tcg/cpu32.c           |  4 +---
>   target/arm/tcg/translate.c       |  3 +--
>   12 files changed, 25 insertions(+), 60 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

