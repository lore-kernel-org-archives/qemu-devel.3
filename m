Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E746C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77oO-0003Tf-Le; Tue, 22 Apr 2025 03:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77oM-0003Sy-4v
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:12:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77oK-0002hK-8c
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:12:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so38105765e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745305970; x=1745910770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Docl5Hj1KGZuFaVssYnNvSeAQHUBkOQcmY8C4dhJquM=;
 b=phe074qiSMLkSw+cHxAkL8NpCL2/YqdfpZr+kB8x2pAR+qHd3Fe2x2Nttc5DGPNPcu
 hv7nutTWrsO/JQ3fdJ6KcGqG2RObN4a/LmUXBEVp1xo5nwhhESsua9p7UQH3/XkQhyUH
 aEBCs4zRjbpPG/BxJUeaIyKaGJVAE12pwfZKruIovGTYDVPzPU6X7DfDOLQsJOxJKuSX
 Yx0qxypUCEbPwJW2fZypeAY7swSHkC4xHCr1giBKssMlYGh91OqTsc9OPuUWKgQdaJQK
 ohPJ3nVu5MlGEs8f56jwZtksUuVv2DJlHmxOSm/9cEyK63mBSweNZt6D6+iZZ755WHmq
 R7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745305970; x=1745910770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Docl5Hj1KGZuFaVssYnNvSeAQHUBkOQcmY8C4dhJquM=;
 b=xRBb8ZtYV5vtRKbyfV+MPUTkBPQSZZhJXhNuZ4DSKhjlOon2SN/Jfl/6ectALcf/mc
 4BWFk1jPafNKD+w8lRoPkISUOMksARTGsMVMLvCmimZbn9jAHnWUjUVyykaY9Jnb27G7
 tm68gknxTCSHKm9dNO/0N36mM5XqVRtepUVfbP0jMdVwtD65DYvJ8ai3ejVOr/Y7o+YY
 gAhV2L7Q8pmuIEEErx+PEGMeqvZ5PlKIqc6D5D2BuS3cbx8BOQAFDNKbysSyWH7hR0g3
 Ac+nhzAm6vC5h/c/aON2g1+by06DxUq7HMvx3XEZkWnq44l/4v0+hJvDYYUrg1oEZKDM
 hUIA==
X-Gm-Message-State: AOJu0Ywd+KeGhgwA5w/zd6HrmC9NfnHSheu+eE8ymORv/IOrtL3Hrd70
 R2BgvdAxrqIfNhioZ6n5JJgNpN40Xwig7gnrPDBWHhEf0poepdcgxXUZHiObEZg=
X-Gm-Gg: ASbGncs22F3eEZiLkkDmeq+iPJLz61eq6cEuJ10aSz2h0z3Azy7L6JDLl5X46/CyCnV
 NhzQi4FuMWScDNDwmoTbfIc/fF6BIi19NpT+Kak+03lQLOl5MgZ3p19rdUnFGS6KKV4yASBktgJ
 CG4cMZEbcvrVRVXZC+wjUiqBGnSxt56tdFbcyURkb85kUWqWMmLekeGWryHCAl+Qdx2m+o5Sppt
 i5rsaQmDHcMpVBm6SpI2Hd+RVFDPnSETdQ028naorpdVTMEx3KDir4kC7W6ERwSglGWab/DVZJD
 NJHvyYNgG8CoWEF0zikR6o58vyfpC0Pe57cXfIDZp6NCiQ0q8/sGP7j9KQQa/F0abyegouq6neK
 IIiQU8wNI
X-Google-Smtp-Source: AGHT+IElL/tFb1ynYyULmMOE8McfBaRUjjkA+SXaPmkXPnaeuUoq8ct1nQZM8d0rnWA/qctYNwbJpQ==
X-Received: by 2002:a05:600c:3555:b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-4406ab7efd0mr134064745e9.2.1745305970025; 
 Tue, 22 Apr 2025 00:12:50 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5cf2easm161743415e9.31.2025.04.22.00.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 00:12:48 -0700 (PDT)
Message-ID: <a2f973a8-e0c4-4eb5-9f4c-bc0f0d1ce123@linaro.org>
Date: Tue, 22 Apr 2025 09:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add common-user/host/riscv to RISC-V section
To: Alistair Francis <alistair23@gmail.com>, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, uwu@icenowy.me
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250422024752.2060289-1-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422024752.2060289-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 22/4/25 04:47, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


