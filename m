Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67133CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 07:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7Ev-0004oI-Dp; Tue, 21 Oct 2025 03:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7Ep-0004ny-K5
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:56:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7En-0003Eo-Bf
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:56:59 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-427007b1fe5so3415758f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761033415; x=1761638215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u4HogZ447onm6i5w4wjIEfRLzXDP2fFHtetWzSWgxSk=;
 b=VG1w8iMYXfIUw1khUIHbLaKtAc85PT4WASKtuU5AH0LgY8JhkJFOLzvet5/HZtoELe
 WbKsT3re8RxEk8wBsEUXveQryBK6SEcxHqUQ81khWCAq5GLX8d/bFeIDqXwfxGbO2rNR
 YlliFWdcuXwZYeZueXPs+K+oHVQqjUeLoL8Zmc5osYepqUPG5rVkLWM7R7bGyjCIwRTb
 i4oszVuerfLB8kxGUkzZ+mY0811HnBIHh+S583cwdM2LEGSWSNUFU7iKKYP5TBho5Mot
 O6n0FzprYhmYi4VD4StXbI3wGFmZA9n6cJugFi/Eg6dUCNDajCuS2OretoNp6o0EB/Z2
 B0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761033415; x=1761638215;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u4HogZ447onm6i5w4wjIEfRLzXDP2fFHtetWzSWgxSk=;
 b=fCP8aj474HL1yfnQ3FLO9snksYs60LwNUqKVDoUmoULIX50ko5EgXRWKKfXYHfGITf
 +zFTKCWa39BNXGP8UEz+Tb2vzXi8oAzcjksTM769x3IGA8AeLuN6RyaO1R7Rt01QC3Gf
 TmorbsYDybgagOwstO2L//GA2mP5wUgcLC3hsjG5XXLej7lHdVYAMJ+utmY00ooqTj+B
 Rjgsh/0jSeFbMRAoYDm7bd4e/pswPWxyi+5BlRnBY5gwsuPnggwmwL4s45fna2hkLjgH
 VhhEmrvFP6iYFLQ55AON54hwhYF+YQyjw2S8J8c9g59s/ME+RKdjvhzwViMFTrL1EIpf
 Hjzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLn7EY1FJY9WloZZf7lrx5K0YtX17GVLnzteWu9xqisF9xjITLQxUABGkR6JxORabzOepy937Ml3J3@nongnu.org
X-Gm-Message-State: AOJu0YwyjE7hX7NfDxA3h8rKRxRKcgrL1FPWJZLO2zqTLQIl0NkvmDlT
 S0AfGT/XlF9U3qRB0r7skpM/mRbTCoMqntveDTFyWtWvoN7ZwXM2tbGypgLLxWlhAOwUFGAtDNZ
 TRCaUIVY=
X-Gm-Gg: ASbGncvQfgKoOnA/WWtiIRqM6HM+kS5dj3f86camxmlCP/ve708Qswv1ohs+CfyRI78
 QXPJMQTt+DJYnTg/4pDcF9RzquMgqfZ+HvZDvaQ2MWuUSlMkHocDmYJ8KdUB269lZf23ttdsQxQ
 c83vzsNY7wpmHEoukDqgCpOqGf7qkWw+lZv+baeQiQn28FehoiPO/KUPBEHyuTuOxB/U7j3vygG
 9yFsDZWbwPb9v7RlWcteAwcVZ2yDW1LhJYnvdWCDVX4Qc6OM0ugPJuMYIz/Vy0lxEVsvFeuYACT
 QUod8cTm1qHWgiVtLwwpBBHJ+RB6+a12rl0IaYawVClOBipXjBC7/N4YtN1WdX6PR0WSj+eVBqI
 Qo+65cWNlL/IWcvAsVULZ7QRVVth7z60cBWlZYQC9BIrbcRVisuCcrJTQa++Uvf+p2UNcIbcZlJ
 CDGby43FHzFLsAdfdOt4a1SJ3PDFM9uJ7NE2laoFbHgmI5XqWHaE4rQg==
X-Google-Smtp-Source: AGHT+IF9Mt/xdcVpPpO9tLO2NXjKi61+oi9n1PuQMlmsARTkm0W1HpwtkbloqZpoL8jOrX9uraeqbA==
X-Received: by 2002:a05:6000:2884:b0:428:3f70:4b3 with SMTP id
 ffacd0b85a97d-4283f7007b9mr7190043f8f.59.1761033415099; 
 Tue, 21 Oct 2025 00:56:55 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9f9dsm19073902f8f.39.2025.10.21.00.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 00:56:54 -0700 (PDT)
Message-ID: <e1a8e242-5653-4af2-98da-b576140314cf@linaro.org>
Date: Tue, 21 Oct 2025 09:56:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio/helpers: Check base architecture at runtime
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, Zhao Liu <zhao1.liu@intel.com>,
 Luc Michel <luc.michel@amd.com>
References: <20251020222315.68963-1-philmd@linaro.org>
 <1892476d-6176-4a49-92c9-bae0d0c3a0ba@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1892476d-6176-4a49-92c9-bae0d0c3a0ba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 21/10/25 09:05, Cédric Le Goater wrote:
> On 10/21/25 00:23, Philippe Mathieu-Daudé wrote:
>> Replace the compile time check of the TARGET_ARM definition
>> by a runtime call to target_base_arm().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <20251020220941.65269-1-philmd@linaro.org>
>> ---
>>   hw/vfio/helpers.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index 23d13e5db5f..007c37b28b8 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -20,6 +20,7 @@
>>    */
>>   #include "qemu/osdep.h"
>> +#include "qemu/target-info.h"
>>   #include <sys/ioctl.h>
>>   #include "system/kvm.h"
>> @@ -220,9 +221,5 @@ bool vfio_arch_wants_loading_config_after_iter(void)
>>        * See commit d329f5032e17 ("vfio: Move the saving of the config 
>> space to
>>        * the right place in VFIO migration").
>>        */
>> -#if defined(TARGET_ARM)
>> -    return true;
>> -#else
>> -    return false;
>> -#endif
>> +    return target_base_arm();
> 
> 
> is that a new helper ? I don't see it being used anywhere else.

Linked in the Based-on tag after the S-o-b:
https://lore.kernel.org/qemu-devel/20251020221508.67413-5-philmd@linaro.org/

