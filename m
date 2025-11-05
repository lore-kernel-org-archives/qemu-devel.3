Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C98CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 10:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGaTZ-0005jr-FK; Wed, 05 Nov 2025 05:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGaTX-0005jR-6X
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 05:10:47 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGaTV-0004lS-Gk
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 05:10:46 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b3e9d633b78so147439266b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 02:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762337443; x=1762942243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OxDu0BZXPK1pUujWXOYNC0CI29ChSmse7//KeYhOe8w=;
 b=vJPo/aNLJ83+lX5PuFcUTQrCMgZrUtW6kASCIuroscbOgj2xQoZ85VKb6UTukrhWXa
 DEOEU0CWiDnQMWUQVp1P8U1Q4WOxztoDSnHM1L+75+t7oLaQjmHYwLmPJAMTPCDFS80U
 oEs35maVqsj0KcTYvmSGSKcTQQ4yQuDRamvRETWl8Y/vKR/dgUs6TlQBN2R9ZGPjM7B6
 kkLWHd7N0eYyIjDNNOPYJU19KyVdw9NbmKUW0cdbM5lL0I5Vb71mbJDDd7I6HLpVlODd
 UkPQxuP+cl6L+F7H1qP/nsuSfIvmYAW+G2LWETT5nZFwxyEfVMiIyEpMXihR3Jn8iDae
 j2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762337443; x=1762942243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OxDu0BZXPK1pUujWXOYNC0CI29ChSmse7//KeYhOe8w=;
 b=MRtRAQaX3f9GZNoElvY0dDDj54aF4clueSix5v4bUbmifo5DHf8rNq/QbO85mNieH/
 yum9cZTQp3X0Si5phxwCV6RdPcxD6QGb1MU0fnro2SXVxyrBXi0HkUTEYDtxRw0uq1JI
 0CUVkEPF9ZeuQg2VtE1mZyChmkZKmcKwDCGp52sgQgfgk+IDN9YCYBxjbwK/1QbmZZjY
 zJr1ZIXLstKOHKOvw2ZCYhWacav1Tc4vBF2rHjNzl3HHuQWokNQpHrh1GdqV4rFIqYGa
 JC0fAZunJLxtEXKCk/Pu13q+524fNbM6/d/kntYJ6LmbSOExKsrjXr7GoyfoC4N+5E9v
 UTLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJGVLofAaXb7YN3/Ik5QA1QTC2Oq/2xVV+6oVboTUO9mL2/YRhmDR/+U3A//5HJXyqPepuTezk+19z@nongnu.org
X-Gm-Message-State: AOJu0YzA0vZJU4fKcC/nf9Pcs3zDse0w4WwaWmkNRDMuDIFu+sY2i2k5
 iwR8EgcN5doG0EVARWR6Z2A0SUsTUZ/xEcL4+HcwYo0U5v4BZEpc7XGoA+++PorWf18=
X-Gm-Gg: ASbGncuo+pCbWXTaFkxl6A55yO0nECnhgjT3E+kaRECptmMziYwiMRobbwFN3yywdKA
 kP7l/uxcwSnn76B6X8tbWshtvb6KiCKMF+1TVDC7KOeemgeooBlqFPt3VZLl3Q7pgRJ6t0qPk+D
 qFHXmdokuEYzf8XU7VxN0FUpGE3fGC7ApycH2LFiha2Qgg18qTnL88LYuTUrcFN7cC4bhAGiD2c
 ZNhK8Q428g2fgXYlX1UbsBcEs2CqbtOx55O6SW03xTLvBP28RK0Sc4pzEXuEufzCZBq8Kd7rXDt
 eb6keb1FOcPwSQfdhDkQLOnvKVM+4T5eIGMhOeadK5SpaLRPJ2rbGKdGqsSkDEVGrjyzMWOLYVn
 uX4+n4aFRwah0euku9JhHin/6Zc0Q05uUeZbAIRrCzBE98P18Aqc03cURuesvJzlE+XT+3iPA64
 2n/NBoCZY70vVloAvvMkU=
X-Google-Smtp-Source: AGHT+IGD6+nEwMVhVzjoC0nPmiijvTMXUi8w46QtiHeSXMPMqJqaXxqFNsltb+2vvs6kndJ3K+yw8w==
X-Received: by 2002:a17:906:e2cc:b0:b72:6330:e651 with SMTP id
 a640c23a62f3a-b7263311eb3mr232652266b.21.1762337443505; 
 Wed, 05 Nov 2025 02:10:43 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fd40da4sm440635866b.59.2025.11.05.02.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 02:10:42 -0800 (PST)
Message-ID: <93dc298b-f352-49db-8e67-2c5f47db6fad@linaro.org>
Date: Wed, 5 Nov 2025 11:10:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 26/37] hw/misc: Add RISC-V CMGCR device implementation
Content-Language: en-US
To: alistair23@gmail.com, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
 <20251023043520.1777130-5-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023043520.1777130-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 23/10/25 06:35, alistair23@gmail.com wrote:
> From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
> 
> Add RISC-V implementation of the Coherent Manager Global Control
> Register (CMGCR) device. It is based on the existing MIPS CMGCR
> implementation but adapted for RISC-V systems.
> 
> The CMGCR device provides global system control for multi-core
> configurations in RISC-V systems.
> 
> This is needed for the MIPS BOSTON AIA board.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Message-ID: <20251018154522.745788-9-djordje.todorovic@htecgroup.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   include/hw/misc/riscv_cmgcr.h |  50 +++++++
>   hw/misc/riscv_cmgcr.c         | 248 ++++++++++++++++++++++++++++++++++
>   hw/misc/Kconfig               |   9 ++
>   hw/misc/meson.build           |   2 +
>   4 files changed, 309 insertions(+)
>   create mode 100644 include/hw/misc/riscv_cmgcr.h
>   create mode 100644 hw/misc/riscv_cmgcr.c
> 
> diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
> new file mode 100644
> index 0000000000..c57d4ada1c
> --- /dev/null
> +++ b/include/hw/misc/riscv_cmgcr.h
> @@ -0,0 +1,50 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.

Apparently another variant, not included in commit 1f59381d6c0
("scripts/checkpatch: reject license boilerplate on new files")
checks.

> + *
> + * Copyright (C) 2015 Imagination Technologies
> + *
> + * Copyright (C) 2025 MIPS
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */


