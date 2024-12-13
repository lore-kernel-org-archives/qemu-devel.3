Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F98E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 12:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM4OM-0007aa-MM; Fri, 13 Dec 2024 07:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tM4OG-0007ZY-KZ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:03:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tM4OD-0008FE-94
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734091403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DkNN2/tvunvK0nDD8Ihj9fplKSNzjuZKYRqHyzISMbY=;
 b=WsxAJwrKLcpItkwGPZ4MiysN0lWOwI5+R94t7iqnhh47gHoqv61YCeLCGRGZzgs+FMzJQn
 Vkoy9dSG/t5s799MljjbTBsqR9hgWcvGrsORT3mvwSaTBLY9kJEXECmQQVN8iejmCa2Ix/
 Ha2x9uDDzNQ/Yol9TsBHfGMMfkCmu4w=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-jcbASiRfMaKDslTLVWHZuQ-1; Fri, 13 Dec 2024 07:03:21 -0500
X-MC-Unique: jcbASiRfMaKDslTLVWHZuQ-1
X-Mimecast-MFC-AGG-ID: jcbASiRfMaKDslTLVWHZuQ
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-21661949f23so24325215ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734091400; x=1734696200;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DkNN2/tvunvK0nDD8Ihj9fplKSNzjuZKYRqHyzISMbY=;
 b=VXRkl3pvK3A9+JzEQwZMt/dt8GILa/5Kis3oAGx1NloRC3+OGvFU/6KDe6JO77EdPl
 lyvavOYeVhz/R2IVMcCAiKD5ImOkr7w2Y3hhCtWlU8tEwIEBsZ+7Hrb/Wt/UlfVh8ppt
 KE0ot6h0g2FSWb8j6xP3wRzdFmmrZAD5h/3HLFtt7HZOev7qs4HPZ2mi1SumRa7NzhHW
 gnQFTDirNBLgBPmRJALmez4wIxj5Z6DvH+ooFfJGCwtdPZQdwG4Zxi0P4dbu7LT55dAo
 wd/eCjUzDAj723vre/FOoPV4BQPclEIjuD+sm5GaK5WE5lkOXtgUtZ7lvCUOCAAtoW+w
 X36A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPCjQgg3D5D9rbugAQW3ka/DT5iIjl6U795uX4BkRfGxYiUQZDdHXWOkNx7HpYArS8U1Ky8QzMBb9R@nongnu.org
X-Gm-Message-State: AOJu0YwjHuIYAKjUQ2YxNtnrzo0M1QRK5uNknAGXZnRtvZXzuQq5psad
 QFbW5ueIGvEWj2QQ7E1tDXf11SPzjcHHUShdaxutQNZPzHHBJc9/5Hf1AL8t4Veauw1K5OEqK9A
 a7AZ+60LmnQBgiNT2bSdleAH08vvBrKGWnJw9UODn5HAedAUAqe7g
X-Gm-Gg: ASbGncu0JDVGEghK0Xs7KXy/y7PzCmNv8Fe6MmeDIxXrrFDbli6aNmFN7yWrqYLPWW1
 B1Il9AuOxZ39BVbHYn2AxIK+3zEly23qsaE/tEWYwIJXRCgDcOXhsxY8I2PRMKeAlHXv2MytZTi
 tGfllZBbpg19opeJkCtqgxQtlb5VFUCAwyWU6sJaHzrCoGbP7B1xPEPwaaR/t5zPWxBOmL5O37S
 PSNl1+D7fWpHlTwMfEM9AnUUg4eN3JMW9PhzUd9mCtypqqeU7Cduoro
X-Received: by 2002:a17:903:1212:b0:216:4b1f:499 with SMTP id
 d9443c01a7336-21892a5d74bmr34747945ad.31.1734091400030; 
 Fri, 13 Dec 2024 04:03:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPeQTG73Oowow/xBL4E5kAu8dztvAtCYs7JbabkmqxbnT6/jxPvpenj2ubISDKsFMHeUpRpw==
X-Received: by 2002:a17:903:1212:b0:216:4b1f:499 with SMTP id
 d9443c01a7336-21892a5d74bmr34747595ad.31.1734091399704; 
 Fri, 13 Dec 2024 04:03:19 -0800 (PST)
Received: from [10.72.112.56] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d90d07sm2998345a91.3.2024.12.13.04.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 04:03:15 -0800 (PST)
Message-ID: <bed63115-017a-4e80-9581-680fd6f29f4c@redhat.com>
Date: Fri, 13 Dec 2024 22:03:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/26] hw/arm/virt: Reserve one bit of guest-physical
 address for RME
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-19-jean-philippe@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241125195626.856992-19-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Jean,

On 11/26/24 5:56 AM, Jean-Philippe Brucker wrote:
> When RME is enabled, the upper GPA bit is used to distinguish protected
> from unprotected addresses. Reserve it when setting up the guest memory
> map.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   hw/arm/virt.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9836dfbdfb..eb94997914 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3035,14 +3035,24 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>       VirtMachineState *vms = VIRT_MACHINE(ms);
>       int rme_vm_type = kvm_arm_rme_vm_type(ms);
>       int max_vm_pa_size, requested_pa_size;
> +    int rme_reserve_bit = 0;
>       bool fixed_ipa;
>   
> -    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
> +    if (rme_vm_type) {
> +        /*
> +         * With RME, the upper GPA bit differentiates Realm from NS memory.
> +         * Reserve the upper bit to ensure that highmem devices will fit.
> +         */
> +        rme_reserve_bit = 1;
> +    }
> +
> +    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
> +                     rme_reserve_bit;
>   

For realm, @max_vm_pa_size is decreased by 1 ...

>       /* we freeze the memory map to compute the highest gpa */
>       virt_set_memmap(vms, max_vm_pa_size);
>   
> -    requested_pa_size = 64 - clz64(vms->highest_gpa);
> +    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
>   

... For realm, @requested_pa_size is increased by 1, meaning there are two bits in
the gap.

>       /*
>        * KVM requires the IPA size to be at least 32 bits.

One bit instead of two bits seems the correct gap for the followup check?

     if (requested_pa_size > max_vm_pa_size) {
         error_report("-m and ,maxmem option values "
                      "require an IPA range (%d bits) larger than "
                      "the one supported by the host (%d bits)",
                      requested_pa_size, max_vm_pa_size);
         return -1;
     }

Thanks,
Gavin


