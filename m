Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC50E8FDBA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 22:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZGYj-0003om-AT; Fri, 26 Dec 2025 17:45:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZGYf-0003nb-2t
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 17:45:19 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZGYd-000572-DT
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 17:45:16 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so72069175e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766789113; x=1767393913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+1ZrpH1Qd4eaaZUqwHF2Qx8uvchxCk6mcwGTUh6GbcU=;
 b=WdHjdST1FXHl7IXAC1ucz8GJ5R34r8bsU8E0j7RBmBsxCdO8TvWHTcWRpwFHAvTtnH
 c0nW67eCa/yiwqzrNnPUDffDtmuSG3Ijgv521N5L3SHDAkRy1YzhAoHtXyNdEef7IRP3
 ZjRMu3KPu5t5p17W4JWz6YSTylv1+LMR32oPoCJ4akz9VjnL+1+eJndQ6rk802WmX4iF
 /KKZ6R9wD9a2cyyae4//vZYmUii3HO7BcwHiysDz1wzi8ITG1kse0lIDoY0yoj946ayd
 WT8LzSNztX7oHHHpiOr6RV4MBn+UdqO3umoqukMc5YzTsYcSV92W2EcS0KiwqCH25kzu
 qM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766789113; x=1767393913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+1ZrpH1Qd4eaaZUqwHF2Qx8uvchxCk6mcwGTUh6GbcU=;
 b=a6C7W6x1sfcopkEFk3nhjiR9idTMVARgLpQjjcVp9tq4axl2D7Egvg18LGrMURJ6kP
 wi0iMr4dmpQZIHTQcPRblelsa3EMrheqP+50KqzunFsd9Xym5yWTQcT1vrWYkgMtJ9YW
 5q7xeByRJhRwOZrXOQewsHD0RYwdxwGuoUr1JQOmFib+/SKa+SEopasdZJ0KVygfdRId
 EZhqvxbbss6w+rxIWAOOjZZICipGDYgfI08cx0uvfvphzNOaRI8yP6fS9a0n8M8WpTeI
 2ExQpgBNnzqmaO3JcIAkmhhCARG/DxUHBGRYFDMa8JHBwaK4QtPW1w8Pv28yIQ+XCLYN
 fRSg==
X-Gm-Message-State: AOJu0YyE53wwJo3G8zukRjRexNqylQcRmGvQ/Cu9klH8zBHk440uizBi
 X59kOoSKlfDOlXVtWH9Vup5Dr8yJ2EY5GnVQn8WZ1PeTVUeSGT+o+pi6q115+oCdbU0=
X-Gm-Gg: AY/fxX6a0tRJ5mRyydMg5Io1s9XkBxlKMSb4gvkY0tSG/xYETzc+j1TnexENEV12W1i
 LFO/PAmGvkdJLrz36eGDq/GUFlzWqohF+VofWYCEx9jkbQMHtH+DajpxWfRPISa290PlTCdruBf
 fo71X+DecFLCBhV36nMdxER3kCt+Z0pkOjjnSl2JbAUJT6wgGP9pBTrsxHTVh+Za2IMoFLACiiX
 8VY+9bKkgo1jTnWXl/49M3K8M5pOpkDija0DS44fNgVst9XGasnRTpOcQ4JHvRE8mpNhgbC54vZ
 qx+dSepOiDENTRxpuIpJ9C19+dqoRhUs9lbLsaxW2RuXjy6P2Fx4DyS7o9aRceZ6LXcgcQw8b0/
 sCQ5n9upYyzcBfmv5LjJ+2wJdT74j+hXTnQ/fNhwD8GryddKQ665pOEy1ZHFP1X7K0XaMnwkcOi
 iz1O6sCdaA17NCxmqiE7rRwUQftzmEwuSi84hORLma2qXqiFNvAh/4/Bj/VaCnx44C40qwP4AU
X-Google-Smtp-Source: AGHT+IGdYt2ecIcHs8+aoYjOXznpt9W5u3YM1q3S96kC+Pj+r6zfKZ4hyNYcAHLoH52Z2e5hWfq6yg==
X-Received: by 2002:a05:600c:4e42:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-47d1956eb65mr212684195e9.2.1766789112605; 
 Fri, 26 Dec 2025 14:45:12 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279c637sm444421425e9.11.2025.12.26.14.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Dec 2025 14:45:12 -0800 (PST)
Message-ID: <1c56c2d4-d472-4ec7-b3f2-22c7b4e935fb@linaro.org>
Date: Fri, 26 Dec 2025 23:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 1/7] hw/arm/smmuv3: Extract common definitions to
 smmuv3-common.h
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-2-tangtao1634@phytium.com.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251224034647.2596434-2-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 24/12/25 04:46, Tao Tang wrote:
> Move register definitions, command enums, and Stream Table Entry (STE) /
> Context Descriptor (CD) structure definitions from the internal header
> hw/arm/smmuv3-internal.h to a new common header
> include/hw/arm/smmuv3-common.h.
> 
> This allows other components, such as generic SMMUv3 tests or test devices,
> to utilize these definitions without including the specific SMMUv3 device
> internal state.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/arm/smmuv3-internal.h       | 255 +------------------------------
>   include/hw/arm/smmuv3-common.h | 268 +++++++++++++++++++++++++++++++++
>   2 files changed, 269 insertions(+), 254 deletions(-)
>   create mode 100644 include/hw/arm/smmuv3-common.h


> --- /dev/null
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -0,0 +1,268 @@
> +/*
> + * ARM SMMUv3 support - Common API
> + *
> + * Copyright (C) 2014-2016 Broadcom Corporation
> + * Copyright (c) 2017 Red Hat, Inc.
> + * Written by Prem Mallappa, Eric Auger
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_ARM_SMMUV3_COMMON_H
> +#define HW_ARM_SMMUV3_COMMON_H
> +
> +/* Configuration Data */
> +
> +/* STE Level 1 Descriptor */
> +typedef struct STEDesc {
> +    uint32_t word[2];
> +} STEDesc;
> +
> +/* CD Level 1 Descriptor */
> +typedef struct CDDesc {
> +    uint32_t word[2];
> +} CDDesc;
> +
> +/* Stream Table Entry(STE) */
> +typedef struct STE {
> +    uint32_t word[16];
> +} STE;
> +
> +/* Context Descriptor(CD) */
> +typedef struct CD {
> +    uint32_t word[16];
> +} CD;
Pre-existing: should these be QEMU_PACKED?

