Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6B2C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJw7l-0007VZ-LW; Tue, 27 May 2025 11:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJw7k-0007Un-3D
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:21:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJw7Z-0000QE-Uk
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:21:51 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4cad7d6bdso2315768f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748359297; x=1748964097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DjHiHOQO6JIJa796okapzVVnNBoIzDrjt8TCX2d77YA=;
 b=Lr5tt7wxKvNByKZsCtd7WZbEiVrxvUZfR5jsHSW/rw3k4uDUeFZ/HvgZhVeDiXCrKL
 RcjG7NFqq3gL78oW0YYL8Dmk25PwdU+fJ27KPemalEULpGkhFcNp+GFZ4UgI8iG8HUB7
 2GyuK9ZUZ9SFdf2L3JvBDdlT+FkEO8ZUtj42Y1cFJwxIvgzJZEKqoZqgf+KXxiJOAEAR
 CUBUfJYrxKAb2+dvmc0PWsblNcfexJKHRnpOYpXf1rRs75VfTEYf9FSSJ8AXYlGePEPp
 ViTxy878iTcFXOEA2HCYFXcuiaudxjAyht+kE1wos51Nxn2FR3/ETk3ZQGyDrwg98XZJ
 s7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748359297; x=1748964097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DjHiHOQO6JIJa796okapzVVnNBoIzDrjt8TCX2d77YA=;
 b=QorkrkQFXzGotcosKtsSDUMPSKBzqq+ZIiFu8tjK25GU/Rs6Dqii9JTsRHfhF/RWNK
 Cn6eo1ZIC0SPosorYPwqJRvgszlqRI0ZB7UZJCNX0CkNL37rDyiZQ25TAfP8XdQ1/Dau
 A8NBmuTmsJdef3cRdX/mLkp0xLFYYOhGm9TUYTiapVuHWbv/Dbo0YknAVa6HJQ7dVM39
 PSAO4Edpo98qSustvsTSHQXOi1yAKHsQ3RaFHQmu7Y1mQCF71LEqXmA6ox4m6+nwBZ0X
 OAbEU91c5d0s+XqTGZIi4LSIfexockGp/Tr1WOo0Gtg1yBujk6hcfx1nSTZW3SlDFVcA
 TwxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDBa2lUG7n52Q/rVZTB+8iUFaBofSDGW0ZP/Gp6+fYGgAjaNAdqINTZ7qM+iSIavbvv3Ovba2EF1bR@nongnu.org
X-Gm-Message-State: AOJu0Yw00URO3+KbWxok9sOXfpIhIq1RHPaNAzYQtOqR1mTx4xEBqGQz
 OyYkpeLMKX1Muia7lFlHWQ5/7Dw1UzAhR+4FgJyQTILshWZVj87mPseYoQD/PS/WqdU=
X-Gm-Gg: ASbGncuDnf2MxtQd+XLCjZ6mcB2I/ew1x6JC0tjYnpDc5VTeheXlkokM059CO3YwFvo
 cjrbtHCiAlZ0c8GFOKSfDSLh2LATrGDeOr0TsJmroA+IIGkYAggf5oVHyI/6rBsxNRCUblECips
 UeaXVqURT5NhtyKvHJay42gK0HIR1ttD4u27dNR1mwB1kwSj3BYjw9IxtII6leJKh90SMDdbgqG
 aW7XQvKz/qQp3VVo0hzGteDcK/MfhdbR+tt5NATozD7/2d8WC952Kag2P2ZZa9SytpqWgbc0zpt
 bpzU5j07f49sBVJ2UlnA4UFH+ua44Wtuh0FeTVx3VD7JelrVk+j38EWYIJ+3V7bIHMuzwgUu5OS
 XH7JbMljjPNvmkP4ienB4mPSE
X-Google-Smtp-Source: AGHT+IElDK0J0n2yRQ5HB79NN8pg4YJ5E2nr//72TnfMYHApQlBkraltrMwwN+h/2UmQafNlULxjUA==
X-Received: by 2002:a05:6000:290b:b0:3a4:df8c:dd3 with SMTP id
 ffacd0b85a97d-3a4e5e9e458mr1072697f8f.21.1748359296676; 
 Tue, 27 May 2025 08:21:36 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c9cd023csm11704586f8f.10.2025.05.27.08.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 08:21:36 -0700 (PDT)
Message-ID: <04a1bb03-5823-4c6e-9f0a-10882b96a6b4@linaro.org>
Date: Tue, 27 May 2025 17:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/25] hw/arm/virt: Let virt support pci hotplug/unplug
 GED event
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-23-eric.auger@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250527074224.1197793-23-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Eric,

On 27/5/25 09:40, Eric Auger wrote:
> Set up the IO registers used to communicate between QEMU
> and ACPI.
> 
> Move the create_pcie() call after the creation of the acpi
> ged device since hotplug callbacks will soon be called on gpex
> realize and will require the acpi pcihp state to be initialized.
> 
> The hacky thing is the root bus has not yet been created on
> acpi_pcihp_init() call so it is set later after the gpex realize.
> 
> How to fix this chicken & egg issue?

FYI I have this question tagged since v1, I will try to look at it in
some days...

> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - use ACPI_PCIHP_REGION_NAME
> ---
>   include/hw/arm/virt.h    |  1 +
>   hw/arm/virt-acpi-build.c |  1 +
>   hw/arm/virt.c            | 42 +++++++++++++++++++++++++++++++++++-----
>   3 files changed, 39 insertions(+), 5 deletions(-)


