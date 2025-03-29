Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573CFC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 06:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyQ1X-0002mb-Vr; Sat, 29 Mar 2025 02:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyQ1W-0002ls-9g
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 02:50:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyQ1T-00057L-BV
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 02:50:30 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so2519876f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743231025; x=1743835825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n1YCMFDGVvaToTIZlQjBluFawR+SDibDCGwk9w//TQw=;
 b=iivsbt6xUxqdGjfYsnUGpY94ObKlaWetZEidTpjEdrs34l+vxomkJTjX+QVJvFlSC0
 G/bT7OrYQTfjCLMKEujgeGxeIRDvgmsRb+aPogO90dwjVmtc6ntj6ecCAXgEpShfMs8f
 NegdB0G+gebrlD2OTa4gqkOcYzq+dkJ8xW2gmakLZUKTkG3jBCv3vT0eMiy7nzatGqQv
 +QG58v15L93Kg0+wh6LSH6XYTQ2+aehmFHWj7kXOGjDFfSUBvii52sExodm/K4mYZPcr
 F8g10OnLOkloHb6nLEUCs/BqovJkfXLOcfsqiKs5ibu6MALyMpLH8uNc4BaiH4ZYlPhz
 JZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743231025; x=1743835825;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n1YCMFDGVvaToTIZlQjBluFawR+SDibDCGwk9w//TQw=;
 b=teSApyFoPdVkJ+THruBMhNPD3NofToXqwk5S9nG9cYQMcfyWfw2ACLDqSvweBqI8Ms
 Y3x7rjlnH1WhI9M/hohCd1rW9j1PwHdr7QQD8ojgsflmhBOAxHoDepaDMuwvbT0ILipq
 0HpwNJRe2IMaBmj4hIuQql+uVCaSB2Tjy4xFrkZaeST0DK5UVTQ/IY60EevtPUp0IHmm
 TJFwO6nMBR7Qeen9xqnVKzZiv0Ea87EgV56gvOeqrcKCfVnXkWaPLAROAx5oy2cf8zVn
 VvDmaYIQLk7NeHsUAUWHm4wDYhsWMUOdNejwZE0y0jLxkOGazF+Q5zfokx3xx41RM+LZ
 PE6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgaa4nLAjfInsE+/1zHZC6UwuMcugmZqUaUDnmlmWfasvDIOPbAeJFi578MnG8MO9d+7KhBHb14otm@nongnu.org
X-Gm-Message-State: AOJu0YxHyfIlFnwSfqkKmExdcn/mly+5A2XoL8UUZNZXtsgdLiatATyy
 gU7bHPRqZAjLpPp67FfcGcF/epIMEVpY5z/mnht7o0Y6s1yjwlB65yxHh3FRQn8=
X-Gm-Gg: ASbGncsb5YeMJeGIfKGCLPG/uJxhfyoaVuC8dQSHy4G417cEKpNZmhtVJcymCUybMro
 LLS0NnaedrtE/zvL8NaFKfaPqP+SCeo/7Jhz1TjDroU8bNQFe74kYISkAJl5hD0AN6CGBemOAcb
 /6AbymMrZnxN7WbVAP9xVzbVA6o+ek5mV5aBYZ6n60do7FxOmHV6u8AISz8ejECz1AWx0DMmrrd
 QYzgDRbtyIZr6XUSKrAPGt+R8CQ7h9syBt5E487+ytpBvQsi4cNP4zm/qRdKHLf8YR3+WsN8JOS
 JttVTVdP9Zarh6Ht3t8X62jmKRskmMGme4AMfb3rYI4xRyFDw80C9VCjyhtlv4BkBgAPiRX8CQz
 XlRH1vldi
X-Google-Smtp-Source: AGHT+IFEJTHc7FajbxuEfSGaZoTTjsYj2ydHxYrU5dpQTP6lEKPufUVksmShHkqXw7TSm52ycl+bYg==
X-Received: by 2002:a5d:47c1:0:b0:391:2995:5ef2 with SMTP id
 ffacd0b85a97d-39c12114e24mr1324602f8f.37.1743231025393; 
 Fri, 28 Mar 2025 23:50:25 -0700 (PDT)
Received: from [10.155.70.213] (21.170.88.92.rev.sfr.net. [92.88.170.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a41b4sm4752798f8f.85.2025.03.28.23.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 23:50:24 -0700 (PDT)
Message-ID: <9ab477f9-6743-4652-a0d4-42c26f92f843@linaro.org>
Date: Sat, 29 Mar 2025 07:50:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] include: Add a header to define PCI MMIO functions
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, schnelle@linux.ibm.com, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
References: <20250328190627.3025-1-alifm@linux.ibm.com>
 <20250328190627.3025-3-alifm@linux.ibm.com>
 <b6b45e60-026e-4228-a5a1-451bbccdd7dc@linaro.org>
 <e6d49082-4808-4d68-970f-7cd6bc23a9c5@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e6d49082-4808-4d68-970f-7cd6bc23a9c5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 29/3/25 07:03, Farhan Ali wrote:
> 
> On 3/28/2025 1:44 PM, Philippe Mathieu-Daudé wrote:
>> On 28/3/25 20:06, Farhan Ali wrote:
>>> Add a generic QEMU API for PCI MMIO reads/writes.
>>> The functions access little endian memory and returns
>>> the result in host cpu endianness.
>>>
>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>   include/qemu/pci-mmio.h | 116 ++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 116 insertions(+)
>>>   create mode 100644 include/qemu/pci-mmio.h
>>>
>>> diff --git a/include/qemu/pci-mmio.h b/include/qemu/pci-mmio.h
>>> new file mode 100644
>>> index 0000000000..2ef92455b1
>>> --- /dev/null
>>> +++ b/include/qemu/pci-mmio.h
>>> @@ -0,0 +1,116 @@
>>> +/*
>>> + * QEMU PCI MMIO API
>>> + *
>>> + * Copyright 2025 IBM Corp.
>>> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef QEMU_PCI_MMIO_H
>>> +#define QEMU_PCI_MMIO_H
>>> +
>>> +#ifdef __s390x__
>> > +#include "s390x_pci_mmio.h"
>>
>> Does this ifdef belong to the header instead?
>> Otherwise remove?
> 
> Just to clarify, are you suggesting to move this ifdef to the 
> s390x_pci_mmio.h header file? so we can include s390x_pci_mmio.h file 
> here without any ifdef?

Exactly!


