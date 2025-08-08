Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEFFC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPXd-0003LR-MX; Fri, 08 Aug 2025 12:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukPVx-0000MZ-Bb
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:00:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukPVr-0005sn-6G
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:00:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-459ddf9019cso8600325e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754668807; x=1755273607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U31oiKsgx+8pzsWRmfBacKIbeg55k+w2ihJyrAPos7o=;
 b=Cxn0OlmCEz9Um5w2Ccji8vi/o/ZlrwhhhWu4b1xSaaU17kC7CCECQcWr3yR+AlautR
 +KQ4NPmVZ9Ba+L3MeRK3wrr+AsPVa3zjGQKF4bKUVJC5Jn2kEF2C7N24AUx3sWxWql+W
 Sm2PDINgkojeswO2D6IQI9YtuItEhReqFz2/hXq9zhY8VdTWcu6EtQ416cCCHBjVij6U
 0Hsmvv5WRTmX1+0pHc8rlnrzr4YYqn7sspfLlyGV1Jg15Ff3yJJC/dxTVxfNRiNYmtLi
 YaB8JqJlGWdUHVXgJQGdCHgPcI+c41maMeXQrS/7KYg36K4w1TcrZXdwGga5/B0IMdIU
 +3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754668807; x=1755273607;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U31oiKsgx+8pzsWRmfBacKIbeg55k+w2ihJyrAPos7o=;
 b=iotv8KOMsoOSYRkJxYIoPUh4sajLMQWePHUWwUVUSJ5jJQ6AKl16FZT0qbegWSJXPR
 st6XFsfkRJ5vPhgRWpGYFCo4aF4yVXUvIUu3PSlWou6ApmcOXRHMcfzQCXSYGWtaAqug
 Plsd/WZ+yHc8HYZD6MDfoWceTBwW+O3BLCAnfUY5sXIE7JUR+lErNwSsWDs4hqHWFJla
 AaLCgRZVs3bnR+2B3NXc0WeB6mPCCZIHeII7Jm1Onmo7TR9QdwsjpkXO9ckyf2MtNAV2
 V+/thFk3Yzbpa/b2lvCxlKJJT1m3NJ/m7iD2VaDP9jLUliqKDK+aPd3mcT0HvC5Aqzgu
 mYow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvRlz8Gpi0GzyLyMdCQbhjL2N7npRdz0H4nkHskCrfWvww9RUIWg3jzpZ6LTZJLL/p2UyE125vcsf4@nongnu.org
X-Gm-Message-State: AOJu0YzzZNPXiYxRGUZ9jDlPahAl/onylzsVFhBJkuoUekvh8AE9nvu3
 3BmVo6aRoPv3KFOwCIgJbjZS5IIdRmEfIF4bevdnQmM7nNzdclWrS5Tng1WaV1ogxLE=
X-Gm-Gg: ASbGncvKDg2tp+Jq3BG0Vmb2KJAWIxtMeEzGwcOc5nj7N8GvwSzFodcU87xaxaTwV13
 yhR7PCs0IMZTOkddbB04ZzJJJTwI815px2zqIWnOmEdMj35VhjKYgUzTdbG7uSWpMjqV4PrzJTn
 OybduuT8KsAjgV5yz9qTuujhscldrTfF4tb5X6B7WAG71Jpk5X4/vGYKGxAaaoXTeyUymd8lBxj
 2U4+HvV0Zbrp7yL5SyjyWuwxN7n2XPKp5XS6pItuFufJgGSpLokO7CzhMtdO6tGbUseUX+gYdG2
 tYdUmo6eGNI5qyoYs+lTCSHRAilWPDrVVyTVNfL3MtgTmWsHSGrbNpCF09XVCIW/7esIE8u3fAT
 FL+ZrMiJl9S/5V4QMWoUqE8R73k43tIKealTZOol4JToF8/XnkldCruKvHV7wNx14dQ==
X-Google-Smtp-Source: AGHT+IHLIlXbXN8fjsUj603FuCKXF6oEaAVEnyi8xeupi0dYAUzrDVAKsLTsoa4ulHOLrE/y1mT7hw==
X-Received: by 2002:a05:600c:4fc4:b0:459:dc99:51bf with SMTP id
 5b1f17b1804b1-459f4f289e7mr29396045e9.25.1754668807184; 
 Fri, 08 Aug 2025 09:00:07 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e6867193sm138084875e9.6.2025.08.08.09.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:00:06 -0700 (PDT)
Message-ID: <a9874cc7-e18e-4b6c-aaac-2c6ce56c1bf7@linaro.org>
Date: Fri, 8 Aug 2025 18:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/14] hw/misc: Add RISC-V CMGCR device implementation
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-9-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250717093833.402237-9-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/7/25 11:38, Djordje Todorovic wrote:
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
> ---
>   hw/misc/Kconfig               |  10 ++
>   hw/misc/meson.build           |   2 +
>   hw/misc/riscv_cmgcr.c         | 234 ++++++++++++++++++++++++++++++++++
>   include/hw/misc/riscv_cmgcr.h |  49 +++++++
>   4 files changed, 295 insertions(+)
>   create mode 100644 hw/misc/riscv_cmgcr.c
>   create mode 100644 include/hw/misc/riscv_cmgcr.h


> +static void riscv_gcr_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVGCRState *s = RISCV_GCR(dev);

Please report an error for invalid num_vps values (0 or >MAX).

> +
> +    /* Create local set of registers for each VP */
> +    s->vps = g_new(RISCVGCRVPState, s->num_vps);
> +}

