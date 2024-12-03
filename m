Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94EAE6C61A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIOx7-0003ZS-Ug; Tue, 03 Dec 2024 04:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIOx5-0003V3-8J
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:12:15 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIOx3-0001L1-Jk
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:12:15 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so1696175f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217132; x=1733821932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ulqZnli5XUfh+oOedBt25DjTzatHk+ucTL4EcKzZyGw=;
 b=l4ohIFHQ1wv3xDmr6JqUUbvqyIiYDKYAgEa47Vc4pftjVJG/ptlVXTjLsXovVWlj67
 //ejfBy/eb2H38Qv7OoahDnu/EmmVSZPEbmBlPIbA405BuIecSLZs2lswOCCvfEnTVi7
 MdNfChRq7d8n8GsCCSO3cphx4To/zY5k+shn4Li58DUjgQr1nBvoPphhMe4tCnz33xv1
 jvHn31Ou+gy+cfuFRli8v9CzGfbvU4XrlruPz68wY5vMvo4nGV2n6/2EJa2XSoZgSo4R
 Hpzp+2EuFoKY9r1UGVSMVWQfvLwjUFVF0EYz33Zx6yP/7VCHkbGxh2hKxqI85/Cj5ZKs
 oOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217132; x=1733821932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ulqZnli5XUfh+oOedBt25DjTzatHk+ucTL4EcKzZyGw=;
 b=pwHfDvLR/i/DpF4M6X0b14Uw9uaD6StaGDhtKQAi+zxzAxGgfUeYb77ChdGKj4wGwt
 EBG4pFtEkW1ispeXrd5NpjkygvG6VseUUIHRFWLoLDvYcOu+fEbh8NoKbidC4yOGkl3r
 IIsI3SSjCgfByf+HpWbEum3z4S64DrjCHtlW++mTVtZAJ/5NBFHvd/wElDY1aX+AMR7w
 UX7CT7lfoXX7PXBRhWwQB4EzSrI/bozgtIL6MDphsdZiuYdEQ8twIvxk24kofmASg02M
 kiTGNWUcIzEZJK3fd4bvsusrfkWH59SQBLseiJEozNSw8+h1XWNRZnNZa292jkQeuJUL
 g61g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAbjxu/0OKyxn3tFG5LEDZQlvCgjZE1hbsviUxAaWbKhHa8sRFqgiBjUsa5U2SJtA4Q3xLLi4ptuHR@nongnu.org
X-Gm-Message-State: AOJu0YwmzynEmaYAJOvSnbbUobUjJ2dXnyZAbHL71adMiVzIOP8hLvH3
 3UvgJJ/oBcSavmHj0mEmXUIFFC7MbNH+4ko2KdqnreiXiurrWr/7rynQgHUzV/0=
X-Gm-Gg: ASbGncsjqNImHwHkdbqjAfRwHBMdRDk/o/PIDLmIZe0jrOMjoKGZM0Rt3Zs2GvkThbZ
 Hv4hraxLQX2QpxYE9dgGnVAZg4FknAbvkM8ILGQaUHWaQGqtYS32DZ177hjZ34e2k228sIkmdQG
 DRDTyAQQMYpH982nYGk1Gp9DkIInz/xRyv/PJnGgP68F0dPnqYbh1A9cdOfJ+bD4Yp/vVB7GYV1
 FB/LgXf4S2Iai+6fHNnQwK+s2rrwKGsePvchyev6RloIvNZAbKPy1qiByLTZGkv6A==
X-Google-Smtp-Source: AGHT+IH94KhLjN2GV3iWqfFWLOTMLpw+X0xC8EgyzXn8cbd8C9E94lhNq84WIV7gA/3NVhezgatqVg==
X-Received: by 2002:a05:6000:1568:b0:382:5010:c8de with SMTP id
 ffacd0b85a97d-385fd417c09mr1406769f8f.46.1733217131775; 
 Tue, 03 Dec 2024 01:12:11 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd3a522sm14846204f8f.52.2024.12.03.01.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 01:12:10 -0800 (PST)
Message-ID: <79005a21-00f9-4642-b93e-2ca9cde821ba@linaro.org>
Date: Tue, 3 Dec 2024 10:12:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide/ahci: Check for PCI device once in ahci_init()
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Xu <peterx@redhat.com>
References: <20241121100152.65476-1-philmd@linaro.org>
 <D1B09E85-E00F-4E8F-8332-51CB33A97E44@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D1B09E85-E00F-4E8F-8332-51CB33A97E44@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 3/12/24 07:46, Bernhard Beschow wrote:
> Am 21. November 2024 10:01:52 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> object_dynamic_cast() is expensive; IRQ helpers are certainly
>> a bad place to call it. Since the device type won't change at
>> runtime, resolve it once when the AHCI context is initialized
>> in ahci_init().
>>
>> Reported-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/hw/ide/ahci.h |  2 +-
>> hw/ide/ahci.c         | 17 +++++------------
>> 2 files changed, 6 insertions(+), 13 deletions(-)


>> @@ -196,13 +192,9 @@ static void ahci_irq_raise(AHCIState *s)
>>
>> static void ahci_irq_lower(AHCIState *s)
>> {
>> -    DeviceState *dev_state = s->container;
>> -    PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
>> -                                                           TYPE_PCI_DEVICE);
>> -
>>      trace_ahci_irq_lower(s);
>>
>> -    if (!pci_dev || !msi_enabled(pci_dev)) {
>> +    if (!s->pci_dev || !msi_enabled(s->pci_dev)) {
>>          qemu_irq_lower(s->irq);
>>      }
>> }
> 
> By always triggering the "irq" property, it might be possible to push out the above two methods to the caller, i.e. the parent PCI device. This would make this device model independent from PCI, essentially turning it into an "IP block". At the same time this eliminates the need for the dynamic casts and AFAICS would also fix the missing PCI dependency in the Kconfig file. I could send a patch.

Oh. Please go ahead, that is appreciated!

> 
> Best regards,
> Bernhard

