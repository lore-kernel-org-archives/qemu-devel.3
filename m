Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E388C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 22:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tddBq-0003JN-AH; Thu, 30 Jan 2025 17:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tddBm-0003JB-E7
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:39:10 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tddBj-0005DY-NC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:39:10 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e3621518so759817f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738276745; x=1738881545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eY/0FdMNd+ZdjfdHOluP9U+9yNxcwe9zhDe7Q1hRwkE=;
 b=Bfs7fIleJRxcOohCUxbVHZQhQKfVudluJwL1TC/CEO3gfVjysBb/zaGXdJ/CHEchsP
 ZYpjHHXveawDGMCuWS6dibrmEUtm5NUfq9ES8Y05UM16KPlc6xDXQ3R9gn1hQLrVaanB
 00aBxeg9LDy9pTHqVIlaVAO8enjt9wpcwbU3nVEgaP82jNJBv377A+w7T505uCkjNpC7
 rpJeBUXpLxrjpen0URi89vwq4juAD0qJ8gJbgQc9gIC1owke315e6sWZfliLpNXTZ/g1
 2auAk83qtaNnVcqiOFuB/gQd5Ntf878HIWl3mlWseR+C2cnATdLY/P7qj5hTUAe2psxN
 DDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738276745; x=1738881545;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eY/0FdMNd+ZdjfdHOluP9U+9yNxcwe9zhDe7Q1hRwkE=;
 b=s+bZwm3vkf1v/ABJPUlYj4m2GgG0wQNC9a7Ja25bnjGad0HW3SgYfeFIOhv27YkiwB
 BbMJ7XDXBeS2kY9WAMcn7WhVWM8Orxoc1yvQ0e72hStsJk519ERDhx4VfS8YWuoQxJq5
 h7740Lopev31ij6K+EVhdHsQYmwS6F34UcnkiI2478CtozIH57DbuTVkhJvQgQv2gUr1
 pqO9dVZ1MvRwb4jHAidjEqKwYYjqF7/pjvb28m22bKlFnRaE5/xlcxbiCfoGP39mpk5O
 KyGFdCm2zQY0ERcrOqA5xpRLiN6lJRwGxts6h0fCD4gL7r8tz54BAOVK2Hq2rWFVUQxo
 z0OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV81rhWbZvH4ABNsFSe0ehdGBMc6uzHOF8r11wuPjb887nlNnSDi/RXCWfohTpsE2CT+EYRFSW7BxA@nongnu.org
X-Gm-Message-State: AOJu0YzY61b3mWQhssaAgN/26B3mz5Hzf2TipMzIWrpkes4pNWqkWDJY
 7FIIVxI9X7O97eRQoAleCmh4hmmWL/iY7PLTVZEjZL3beiaLMvdhIxaokAEePII=
X-Gm-Gg: ASbGncs0YnTy8pQhQdQQGJ4DtLSrLz2PHMscfz0jWZ5AU90KMncVhFSZcW3bUii4aJ3
 3Y62mL4djjdH7bRePm4LcNG4yr0qZYcwe3OSMF0kCfhkA3y/4LYP+XfI08n380De6mWIzI/IyWv
 qeUglKuwS6H151aqtjtRJoaKnhAfIDEMf4d+RkLD3F3vDvkTaYeDS2xwgEI12TuD8sbc8wcTZkr
 q7mx0sbyGTkEVUM6fyqpl2GkEunjH8r4pPVMsKfUL0QstK93JvWUxci8aavTZ8gAgK76TvLvkig
 Qp4Bu4+VQTnpXDLBUYUpnXyb73UnjvmzBPLgdWvJOj4MMjHsp3Qn3ACidI0=
X-Google-Smtp-Source: AGHT+IHpA7Mn0bfmhiGlXAbzsyLqCcWPEnT3VvqAIPzbAGJrq/hwLr2azitsyfCoehq2DHpgaKSWvw==
X-Received: by 2002:a5d:634f:0:b0:385:f0dc:c9fd with SMTP id
 ffacd0b85a97d-38c51974c0fmr7449054f8f.27.1738276744793; 
 Thu, 30 Jan 2025 14:39:04 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b578dsm3155352f8f.64.2025.01.30.14.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 14:39:04 -0800 (PST)
Message-ID: <1bd3c60a-45cf-4918-b495-35c775d2b76d@linaro.org>
Date: Thu, 30 Jan 2025 23:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/usb/hcd-xhci-pci: Add TI TUSB73X0 XHCI
 controller model
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20241212085207.1439501-1-npiggin@gmail.com>
 <20241212085207.1439501-3-npiggin@gmail.com>
 <B6A151CF-47E4-4E6A-BAD6-7C5BE8C35F52@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <B6A151CF-47E4-4E6A-BAD6-7C5BE8C35F52@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 19/12/24 01:48, Bernhard Beschow wrote:
> 
> 
> Am 12. Dezember 2024 08:52:07 UTC schrieb Nicholas Piggin <npiggin@gmail.com>:
>> The TI TUSB73X0 controller has some interesting differences from NEC,
>> notably a separate BAR for MSIX, and PM capabilities. The spec is freely
>> available without sign-up.
>>
>> This controller is accepted by IBM Power proprietary firmware and
>> software (when the subsystem IDs are set to Power servers, which is not
>> done here). IBM code is picky about device support, so the NEC device
>> can not be used.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> include/hw/pci/pci_ids.h        |  1 +
>> include/hw/usb/xhci.h           |  1 +
>> hw/usb/hcd-xhci-ti.c            | 92 +++++++++++++++++++++++++++++++++
>> tests/qtest/usb-hcd-xhci-test.c | 21 +++++---
>> hw/usb/Kconfig                  |  5 ++
>> hw/usb/meson.build              |  1 +
>> 6 files changed, 115 insertions(+), 6 deletions(-)
>> create mode 100644 hw/usb/hcd-xhci-ti.c


>> diff --git a/hw/usb/hcd-xhci-ti.c b/hw/usb/hcd-xhci-ti.c
>> new file mode 100644
>> index 00000000000..6d4b44f6aaf
>> --- /dev/null
>> +++ b/hw/usb/hcd-xhci-ti.c
>> @@ -0,0 +1,92 @@
>> +/*
>> + * USB xHCI controller emulation
>> + * Datasheet https://www.ti.com/product/TUSB7340
>> + *
>> + * Copyright (c) 2011 Securiforest
>> + * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft.com>
>> + * Based on usb-xhci-nec.c, emulates TI TUSB73X0
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2.1 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/usb.h"
>> +#include "qemu/module.h"
>> +#include "hw/pci/pci.h"
>> +#include "hw/qdev-properties.h"
>> +
>> +#include "hcd-xhci-pci.h"
>> +
>> +OBJECT_DECLARE_SIMPLE_TYPE(XHCITiState, TI_XHCI)
>> +
>> +struct XHCITiState {
>> +    /*< private >*/
>> +    XHCIPciState parent_obj;
>> +    /*< public >*/
> 
> These markers are obsolete. Instead, a blank line after parent_obj should be inserted.
> 
>> +    uint32_t intrs;
>> +    uint32_t slots;
>> +};
>> +
>> +static Property ti_xhci_properties[] = {
> 
> s/static Property/static const Property/ as of recent tree-wide changes.
> 
> Best regards,
> Bernhard
> 
>> +    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_UINT32("intrs", XHCITiState, intrs, 8),
>> +    DEFINE_PROP_UINT32("slots", XHCITiState, slots, XHCI_MAXSLOTS),
>> +    DEFINE_PROP_END_OF_LIST(),

Also remove this "DEFINE_PROP_END_OF_LIST()" line.

>> +};

