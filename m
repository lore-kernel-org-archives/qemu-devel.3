Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92803C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 23:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHtGa-00006o-0P; Wed, 21 May 2025 19:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1uHtGU-00005t-T8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 19:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1uHtGS-0004gx-9p
 for qemu-devel@nongnu.org; Wed, 21 May 2025 19:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747871661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aIEsADfMxGCubH6K//UVxoho4gM0V5AfnS6wwT1cj8=;
 b=T2q4X3g87Nl93Wz/jQgxdVRdmmexEt/4B5T90Hj3Kq3GMxeKzfa84Yp7XoE2L1jW39MMJP
 neYzrcD9uzdrSJj5koLHfzqU1Ng3+N6oaRsE4JXevJDC6gWWxGy6ASPrJ/pSrzv4eDmBt/
 5M/+CI2a04vSOm8h1qjrgnrawmwjIi0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-WTZXh6tsNRSLQwlWuORyHQ-1; Wed, 21 May 2025 19:54:20 -0400
X-MC-Unique: WTZXh6tsNRSLQwlWuORyHQ-1
X-Mimecast-MFC-AGG-ID: WTZXh6tsNRSLQwlWuORyHQ_1747871659
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-742aa6581caso5147215b3a.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 16:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747871659; x=1748476459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6aIEsADfMxGCubH6K//UVxoho4gM0V5AfnS6wwT1cj8=;
 b=ftqzG6uereX4pI86jRtEM4UgYuwPfVdw8S2cAWw+ov2RP4d0+0NomO+6i4rYbUs6OB
 3vRfz2dPfnUhSiK2wnHEkw/24flBuJ5V5ns8asGIjhIhuINQhEGM0feNqKKvLD0b+6ed
 4dkX3IOKRwOYEgUZAi5zgLEqLcZLYSUiCjbJjH1tR79K8b3BBa3TPUH8x7/W9v0KVQG3
 b8+JjVo6iZn8kSGgsAjrNUuYBItCyDieE2rPuXTcw7JaHiCiuwRNbBOfefxLtsuYSMF2
 eS2gY+dADB2RTJaZVQbyD3gVud2YxOho8Ss+Esb2tjJUPLjF07Flhxc1AOfuno6957Ue
 yCyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4FUu/SKiGusd5DcR1QYASchU2WeQtHYncegMUbfbvPWgVRq/XpHWFyEqDIR2QZd16NCxZF0U2IYH2@nongnu.org
X-Gm-Message-State: AOJu0YxTYaGUbRkwEmd6xIF1jX7m9x7cqqTRdYuK8uXCAO+8gqKBjjKn
 o4+da24NNurTEm4kJqYMSLA68rr4Fgi12Qqe4loPz2P8pUxrsp2aSyXwl7BQh+J5ZTFZRYwroIX
 ADXIVrJOHmKnqe2mqR7W+L8aW6KOntuV7ycbVJkwhQaiU7PkoTSI9rdbq
X-Gm-Gg: ASbGncs8tXKSL1CzUVEHEJ8KlpGhzVNWJTKdHAS+Iix30sT9gL/j9N2QUcaXmn6Caam
 PWhM2mCjPY6v1ssqr+8DKxpPQ+b1mcWFQZunPdEqtldzN/43iU0REMTSKoSb2ZLp16/mc02QKNN
 vXMyJ7MG74yEpO1k9ICzL7yLiMoU99ovAlPtJTTtPIYKN5AFFcSzKpbwZVpS1Fvogqj9SvCn5MX
 7mjZq+py9OjlUSyY75yVDumx8A6fwbB0E6frUM8sQD4TEcEoQAv7IqqjwbowgxnVKQMyimZiqGd
 r4RsCFzthy0b
X-Received: by 2002:a05:6a00:4b05:b0:736:3c2f:acdd with SMTP id
 d2e1a72fcca58-742acce2deemr31040331b3a.14.1747871659070; 
 Wed, 21 May 2025 16:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt56iun9AwMSwpaOywuDj21Jdr12C4CVEsf6U2M3gruCkDgBA+PFPJLg9/iJHsUI7qsdt0EQ==
X-Received: by 2002:a05:6a00:4b05:b0:736:3c2f:acdd with SMTP id
 d2e1a72fcca58-742acce2deemr31040287b3a.14.1747871658676; 
 Wed, 21 May 2025 16:54:18 -0700 (PDT)
Received: from [192.168.68.51] ([180.233.125.65])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9829ad2sm10537063b3a.93.2025.05.21.16.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 16:54:18 -0700 (PDT)
Message-ID: <0d1208fa-9fca-4b4b-bad0-8b596d5102fb@redhat.com>
Date: Thu, 22 May 2025 09:54:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V5 00/30] Support of Virtual CPU Hotplug for ARMv8 Arch
To: Gustavo Romero <gustavo.romero@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Eric Auger <eauger@redhat.com>
Cc: maz@kernel.org, jean-philippe@linaro.org, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 peterx@redhat.com, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, linuxarm@huawei.com
References: <20241015100012.254223-1-salil.mehta@huawei.com>
 <b65590b1-8a6f-43e5-b367-732d6305c095@redhat.com>
 <429a8131-2b59-4800-891b-bcfbc6e44737@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <429a8131-2b59-4800-891b-bcfbc6e44737@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Gustavo and Salil,

On 5/22/25 1:06 AM, Gustavo Romero wrote:
> Hi Salil, Gavin, and folks,
> 
> On 5/20/25 21:22, Gavin Shan wrote:
>> Hi Salil,
>>
>> A kindly ping. vCPU hotplug is an important feature and You has put so much
>> energies and amazing efforts to enable the feature from QEMU side, but it
>> seems it has been stuck recently. I received many messages from Redhat
>> internal and external to ask if vCPU hotplug has been supported on aarch64
>> in the past. So I'm heading up to check if you have bandwidth to continue
>> the effort, any kinds of helps are needed, especially from me.
> 
> You can count on me as well, Salil. I'm definitely in a better position now
> to help you with the technical review of the series, and I can also weigh in
> to help resolve any remaining issues so we can finally get it merged. Don't give up! :)
> 
> My suggestion: go ahead and post what you have now. Just highlight the main
> points of objection raised in the last review that still need to be addressed.
> 

Thanks for your response and to offer helps. Another suggestion I have in mind:
if there is uncertainty regarding the design, it would be nice to post a specific
thread for discussion until it's cleared prior to diving into code. After the
design is acknowledged by maintainers, our life will be much easier. The point
is to get enough attentions and feedbacks from the maintainers until it's
acknowledged.

> 
>> Besides, I'm reluctantly to ask if you're fine for some body else to pick this
>> up and continue the effort. The credits for all the contributors (Keqian Zhu,
>> Jean Philippe, Miguel Luis and you) will be kept.
> 
> I don’t want to speak for others, but in my view, Salil should ideally be the
> one to complete this work — as you said, he’s already invested a great deal of
> time and energy into it.
> 
> It would be tremendously helpful if maintainers could support Salil in bringing
> this to completion, kindly guiding him toward the path to get it finalized.
> 

Absolutely, Salil knows all the details, especially the historic steps how vCPU
hotplug has been evolving. I truly hope Salil is able to continue the efforts until
the feature lands upstream!

Thanks,
Gavin


