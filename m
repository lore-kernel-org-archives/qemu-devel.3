Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBC5D609C1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 09:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGEe9-0001L9-Kx; Wed, 27 Nov 2024 04:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGEe7-0001Kg-Qo
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 04:47:43 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGEe5-0008UW-TN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 04:47:43 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a752140eso12757385e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 01:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732700860; x=1733305660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VN3u6wWkERZNGNGGGvSyfpNe2pEDLlhLupStzXI7GIY=;
 b=XM5RCRdI1691PlSbWXLYV4NNr00JxKavC/Kx6znHfON2aaWEVr7GD712RMKIpqxe1N
 Tdsdd1pvOggiVKM0RDix+kscJyr7uQNUyQfV9gEeclUZNbq7iDSCBsFBP85KdWUgOqP4
 M12S8Vpe1x+BGRFIkdnoosa/RlcZIrbhRhi+tz9OpQWRjvAcWjI/0de8QzfYs06DF/Wc
 rFVFZd90lrpK+B+I1T4nkwft75XHTg3kEKsVTpMRnl1h4mPt5caVUPMl4krOpUWvJWbe
 BG+FUkYm9kjJ4K2xprrOe/9UAOyu3VpOTSrfQ7TTLS3Z9lP+urdGhHSfkvX9ufgd1qLx
 1FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732700860; x=1733305660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VN3u6wWkERZNGNGGGvSyfpNe2pEDLlhLupStzXI7GIY=;
 b=wF/fo3n1WMsSaZPQuzgkO7THSe2irufy18/lx/egaebF+sktM41EJ4jmkBs2NAqOO3
 Vx7GCKsU9HxmTk0SkZASJf4JhM7LP52AkmdS6lgDKNagSjre8nmp/1aPlkCabCxaKnRY
 eZA1+RsEBVCgELXqkujVLQRfNJmEkg5J8x0MI0RCQuxVzJ8CJMSVSSauGU0FIZI3N26J
 GnFSB3O1TzJxfvW7qMdzg/4/8ViI69TwQ2X18iMmY9IuQGlWxeIMya2Moe/EEzjd1Nth
 5OR924xcRsWJ5WEdo8iKl0l+GVAZ/kjjdu3zZGVSLhNkSG4NxrEhCGeLmt+MxfDlID2Q
 K10A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT0pGyrVTQNyCrsPm2Yb2eBeguAi26Qpv/8Hf2ryMVHQISmSXA1uxTcNAQJmaWOTT0Wqk7bZLgeIv8@nongnu.org
X-Gm-Message-State: AOJu0Yzh/uJZKOHUeLp7y0KLRlKnWdq5TF96G8TuqGcrJOjLETQd4f5A
 Iu9aGiWej/66WcPUb0pIcAhp6kzVk8uAB0L9I3kIVzm+FxlUXoE2zoEf2OmxBYQ=
X-Gm-Gg: ASbGncsTwk5IW7ljVAxIlN3tjf+XB2qKFb7MrkUf4osiMYSqWHxNGB/woh2SrdO1QUD
 yvJ14H+Q7YlsSt5aeipwQJ0oI0LTv2Nv0R0P2U76Xrz0uHbKSlNOnspIwvHUY3fHZAp1TYUnckd
 FscAzupXqGCMS0dW3tbNC+l2iTfGNl5Svtz0z0HPE/8Usoe22ixD4FoeRH+CqDfdy3ddNiroT8Q
 Ym1Gwu3RTp8Ts/8QkhURdmLAwjKqNZtL1NYFRTkuwWAs94s0uSP21fjoLS69zP8ZztFSSrix3wh
 NWwmCYooDrCtwED9aepRO+apVeCJmT68+619
X-Google-Smtp-Source: AGHT+IGpowm6z1opauhL4aIWf455fMKr356UmlX5dZsW06r7M3Pwe0sPQUkyY14Q4tzDs+3JmCw6bw==
X-Received: by 2002:a05:600c:4fc9:b0:434:a315:19c with SMTP id
 5b1f17b1804b1-434a9dbc455mr23014595e9.3.1732700859787; 
 Wed, 27 Nov 2024 01:47:39 -0800 (PST)
Received: from [192.168.69.146] (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr.
 [176.184.14.96]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74f2c7sm15805485e9.2.2024.11.27.01.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 01:47:39 -0800 (PST)
Message-ID: <f986d30b-0b15-4889-9e46-8a8d9afe918d@linaro.org>
Date: Wed, 27 Nov 2024 10:47:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Fix the running test case causes
 loongarch64 to hang
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Song Gao <gaosong@loongson.cn>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, peter.maydell@linaro.org
References: <20241127013438.2206426-1-lixianglai@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241127013438.2206426-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 27/11/24 02:34, Xianglai Li wrote:
> There is a bug in the process of resolving the serial port base address
> in the fdt of the loongarch VM UEFI. When both serial port information
> and rng-seed information are chosen in the fdt, there is a probability
> that the serial port base address cannot be resolved correctly.

> This problem can be fixed by updating UEFI.
> 
> issue link:

s/issue link/Resolves/

> https://gitlab.com/qemu-project/qemu/-/issues/2686
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: <peter.maydell@linaro.org>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
>   tests/functional/test_loongarch64_virt.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/test_loongarch64_virt.py b/tests/functional/test_loongarch64_virt.py
> index 2b8baa2c2a..b7d9abf933 100755
> --- a/tests/functional/test_loongarch64_virt.py
> +++ b/tests/functional/test_loongarch64_virt.py
> @@ -18,16 +18,16 @@ class LoongArchMachine(QemuSystemTest):
>   
>       ASSET_KERNEL = Asset(
>           ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
> -         'releases/download/2024-05-30/vmlinuz.efi'),
> +         'releases/download/2024-11-26/vmlinuz.efi'),
>           '08b88a45f48a5fd92260bae895be4e5175be2397481a6f7821b9f39b2965b79e')
>       ASSET_INITRD = Asset(
>           ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
> -         'releases/download/2024-05-30/ramdisk'),
> +         'releases/download/2024-11-26/ramdisk'),
>           '03d6fb6f8ee64ecac961120a0bdacf741f17b3bee2141f17fa01908c8baf176a')
>       ASSET_BIOS = Asset(
>           ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
> -         'releases/download/2024-05-30/QEMU_EFI.fd'),
> -        '937c1e7815e2340150c194a9f8f0474259038a3d7b8845ed62cc08163c46bea1')
> +         'releases/download/2024-11-26/QEMU_EFI.fd'),
> +        'f55fbf5d92e885844631ae9bfa8887f659bbb4f6ef2beea9e9ff8bc0603b6697')
>   
>       def wait_for_console_pattern(self, success_message, vm=None):
>           wait_for_console_pattern(self, success_message,


