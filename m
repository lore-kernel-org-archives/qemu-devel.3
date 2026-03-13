Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7753B105F7AE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13AS-0004Hk-Gu; Fri, 13 Mar 2026 10:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1w13AQ-0004HH-N1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1w13AO-0005TC-0v
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773410822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjEo/YyWrrr4yEVw+DijuGGKmJk2iE7iLXRfESxbDwU=;
 b=M1LJ6a4zr9u5b0BCw75eKsWuwTARvC1VNxLm2r7r8ipjGDr3VaGz5diTGzIo/IwmvUOvdn
 Tkgrm5OnA/UIhzE9yDFn/ZvKANM+HIIw+VI6kRJ91YuUAPpe7E1D2PL3s8aOZ42yAusKo0
 kfmT4t9KGjssOt9mwnfrX3gZRlZDYxg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-WxBwvWnkMtqF2cePELhH1w-1; Fri, 13 Mar 2026 10:05:21 -0400
X-MC-Unique: WxBwvWnkMtqF2cePELhH1w-1
X-Mimecast-MFC-AGG-ID: WxBwvWnkMtqF2cePELhH1w_1773410720
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439da07c5bfso1665205f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773410720; x=1774015520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hjEo/YyWrrr4yEVw+DijuGGKmJk2iE7iLXRfESxbDwU=;
 b=J89pZjGPhAp36qvsRMSd9kyeEN6h+UFk2eH8Uwk39086C6s/+uUgv5jZ53X61+5UPo
 zsZQ4T8wqvmV+V8hGOtXOX8mIZWBe78k9TuTVuwZLCDR0Gr0PIoxikY+rmECo/KZlre/
 nViVrsmZv97wgz+h3rKJMoelfNHZh+tq4CT0FNJ2BlhR9xM2LXT/7ZJz2JLQiptmabFX
 1igvF2teeqGkD9Zu0jtHtWTstFfzDv1yFHuLeiZAdEtUUUAhyaDOfgofrTPe+gpZHyv1
 D287z1+q0Av7zjgk+xuVQJYsk4ueo6SsAUE16PqkQgBvwKbMOnSGhkI8z+sl66GVllZg
 HdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773410720; x=1774015520;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hjEo/YyWrrr4yEVw+DijuGGKmJk2iE7iLXRfESxbDwU=;
 b=IQIcmFrWU9+K1u/Hcfmq3VczRVsrD/uZX3dsDvP9tzbcji2SZCYKuh74sx0copKZrD
 9bOpPOujzvczMRST7ByCknegip0Q3kvHvW2Zbp9wY6GORUmE3nWw2J7mV363XGhsn9Ba
 IGIZFpz7gzkRCb/gPAOVKFeh3z9loZlcycMl1voGhPbLhCnFIwX6qtQ8mnv32ucfIB1W
 uYw8r7mCEMSp1jqrtlD5bj1pRXxidEWK939fjBiHCAoikSU3ZROUAtBTPj5rQTB7zNfJ
 pGhmlUUXKfivHF6ZCnuOHi6K56rAAvsuq5BAzXu39KGXhoz2hpblrwBmh7H0kJCUXFuy
 Y50w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdX0+5BqR9aIwL2ckBePBkGl5eqAhDF05jFQtzwiiUe40U8yafzYr2PQ/PJyHVGZ1ZVsrNfSdpqdHd@nongnu.org
X-Gm-Message-State: AOJu0YyOtb/o6I6ILzC0H4Yb/k7YP/ssFCnNX3QEC352wPB/IBNMkGo4
 Ph1wx36TmDbwSbXSv7dImkU0iwI3jWIihxkewe8S4bIpwuikaDgaN2SYUHUdGRtCelQkD19Yxs/
 cxzVSwv+IpN5UvnORtp1vWSSa/m4I9dT624gj37ML1ed5EaDc6H0yGrP0
X-Gm-Gg: ATEYQzyAFxeeED/TcYkI8mQuWXlVSwZFFJyfQ0LMZ5J9mKt6Tb2KT0RKvy4FMCYOPXE
 DE/C3GqRa4OCIDztF9yE7kobKbtXOoCV/Fyu9LcN9ajUZg+uLo31O7gqoVKraxvxu8aJu7WiuHY
 vCXLt4vG8A/F0JxU3mm/htaRadMTzcAv5zwVS4pqj4NcTn1J8CKQo5yzMpYRcalR4neVS+2v4Kw
 C9yrASDRugbUlS9rlSy+D9RQmqKwSVForRMm7nrTtbYt2rBaDu3LJ31xahs4QBSLryzyp9KQwI8
 1tEqCEQPIca86gP2omF+gHxVko1wnszRS3MZrFT10xgE+zYDixfrbpAUyatIUFvNMo4Kh4XaBLZ
 zDWFM3Af9dZbxbWhpHCjyCgWn6kQCVxwEJUkHw1js7/mOsVzI7yYbHeEBkjQ/JDIE5Gk=
X-Received: by 2002:a05:6000:4011:b0:439:b1d8:6084 with SMTP id
 ffacd0b85a97d-43a04dc30b9mr5908623f8f.44.1773410719882; 
 Fri, 13 Mar 2026 07:05:19 -0700 (PDT)
X-Received: by 2002:a05:6000:4011:b0:439:b1d8:6084 with SMTP id
 ffacd0b85a97d-43a04dc30b9mr5908550f8f.44.1773410719397; 
 Fri, 13 Mar 2026 07:05:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1a76e5sm17137371f8f.12.2026.03.13.07.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 07:05:18 -0700 (PDT)
Message-ID: <daa35e89-f407-45e7-a37a-72299ac6b2c9@redhat.com>
Date: Fri, 13 Mar 2026 15:05:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/38] hw/s390x/vfio: Replace TARGET_PAGE_BITS ->
 qemu_target_page_bits()
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-4-philmd@linaro.org>
 <1ab35d61-a06b-4e89-8ce8-e857470fdc86@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <1ab35d61-a06b-4e89-8ce8-e857470fdc86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/13/26 11:25, Thomas Huth wrote:
> On 13/03/2026 07.20, Philippe Mathieu-Daudé wrote:
>> Get the target page bits at runtime.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/s390x/s390-pci-vfio.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
>> index 8ce44dbecce..7c754b656da 100644
>> --- a/hw/s390x/s390-pci-vfio.c
>> +++ b/hw/s390x/s390-pci-vfio.c
>> @@ -22,6 +22,7 @@
>>   #include "hw/vfio/pci.h"
>>   #include "hw/vfio/vfio-container-legacy.h"
>>   #include "hw/vfio/vfio-helpers.h"
>> +#include "exec/target_page.h"
>>   /*
>>    * Get the current DMA available count from vfio.  Returns true if vfio is
>> @@ -150,7 +151,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>>        * to request that the guest free DMA mappings as necessary.
>>        */
>>       if (!pbdev->rtr_avail) {
>> -        vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
>> +        vfio_size = pbdev->iommu->max_dma_limit << qemu_target_page_bits();
>>           if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
>>               pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
>>           }
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


