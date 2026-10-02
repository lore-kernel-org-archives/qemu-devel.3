Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC985CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 04:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCUjz-0004yU-Qn; Fri, 02 Oct 2026 00:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCUjy-0004yA-SA
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 00:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCUjx-0001qI-4l
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 00:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790914760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDj5PsrMLR6HtJ0EtPwjy/23Pk1YJ2+kwXtw6FsZ4Ds=;
 b=UOvAUPZCFhyr+dnD/jxYM/2R+KvMU/BClFdVyRZZRt+DV5l3PFDV3C19znPAv3D3ydAbBP
 rxrl4K9hR4gxfB6eqxNVjsifnFLKk/SDCrl74yMD2CPxryGZdq++q+KXe5BVIC8kTBjhcW
 FWFjKGJvYG3eJ2lLFDzDHM47XfadbiI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-g25YO643NeWX-zjVStXaaQ-1; Fri, 02 Oct 2026 00:19:19 -0400
X-MC-Unique: g25YO643NeWX-zjVStXaaQ-1
X-Mimecast-MFC-AGG-ID: g25YO643NeWX-zjVStXaaQ_1790914758
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39de4a68f7cso6305926a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 21:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790914758; x=1791519558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xDj5PsrMLR6HtJ0EtPwjy/23Pk1YJ2+kwXtw6FsZ4Ds=;
 b=bilvUpINTKdrPyUdkEeqJK6qMe6/sL5v4ippM7sqHmjlBehFY+sPUR6JRxhpyA1gPX
 MCBGOYQ8jCWvDzcw4B32vjvQtGeAiQBBN4EMnbQy4WVkSCoqjIv2Va7wUpDVoSW5otlm
 NFVhTRVcnXUre4R6RK6uAIOgzrpTlxdqzx2QrV4ErshzvCSgZcQdaIFAhLTadDV4Lyc1
 3E868DEtNtmPfLaPG1D2QY2gXqvvtgXQIn/7dI1hbK60HMsHnqc2sEDMgFyAZFz2FKG5
 7zVcoNTOfJfY78MLCvn8npTeSxJQ2I7B3IxOIo/q9jOr595uNNGbvI56+n8BeEarNYWR
 +hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790914758; x=1791519558;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xDj5PsrMLR6HtJ0EtPwjy/23Pk1YJ2+kwXtw6FsZ4Ds=;
 b=DTxNTOU/YtrN9OLkzvG6chvHQLO6itCpCx34CpdvPoXsygwL9FF3/sbX/dom94vNkS
 QTlQTyAKwgJZKcmQdSzp4AtjvrcjRO5tsgJdSWQhTUy6jwlaNjt1nJRXy16Abt+388bz
 Na/X0YEG6/Mv+3cneNpKUWYVDvhzO9UxrKHsonwqDlcwL19B5DTZPYwnH1NtcEoWftrj
 hsB6xV+UJ3XwO8Nz6n+W5LIM0C5uUj4Nz0RFo9etb2LIUj1SAlEr+btBIH5FKqQl6YpN
 zWh85ySL2FOOxZfGgY2x0s+8H6zz559QbbSyz1gR3WFZFEtwRh8L4Yv2Ou7zBycLIQat
 uHzw==
X-Gm-Message-State: AFq9FYKvqoVsFVu4J8R1sgsgUMmyzKnHd/rBK5gP/ytTe2Z4NnZL0u5K
 PgaiWYLVlHAYuJ0xZKRN4EM5nWX0AXQraGmVk2vYM720gBnQos0M0zU2aDWYvumeIYt2yUDNAze
 D0MKyLtmx5lZEWNurhTrakFFqDxj7qrhOh5blJYmpvSMm9QANHq3yhjEo
X-Gm-Gg: AYBFou0l4hPm1+lbaoc8znevVBZm6YIafbwcMgaZNzY5WfJhgxIOMUv1iC8eJBo9vz4
 PN4e0yDLnrDgLjcHgriMMv8JKj65hQc7E4M+jxmGXw7cLayH6AEGsjJbXGvpddqcJJjwoLq3nA7
 eStewVyqlrL/YUeGbsjslPxgNynEr4mJs2IJkU1h7J7wK9dK5pmil+eMhHozkiTYtuHzwqW1GkZ
 8D/Bdpr75YvkqtjOjEF34+hpI9Gg4skBMD4nnc6HrlUxMOtH/miiQt6YcGdcjQeaGaw7i1YRJOT
 elUjM+NSG4obUsvOtmAs8ORWBww4vsEi4KhXG3GdpQqI7pCioiUhIz3ms+PulmwfB3L8BTapI7W
 HUyvdFtOWqD2h5PBt8LUhaM+4Z9b+GrdMmFywJhvWTw==
X-Received: by 2002:a17:90b:5805:b0:3a2:b04e:8086 with SMTP id
 98e67ed59e1d1-3a6ceca1622mr773313a91.44.1790914757835; 
 Thu, 01 Oct 2026 21:19:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5805:b0:3a2:b04e:8086 with SMTP id
 98e67ed59e1d1-3a6ceca1622mr773296a91.44.1790914757356; 
 Thu, 01 Oct 2026 21:19:17 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6c8421fe4sm2371429a91.12.2026.10.01.21.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 21:19:16 -0700 (PDT)
Message-ID: <e6fdb508-0036-4581-9c91-bbf74de1e0e5@redhat.com>
Date: Fri, 2 Oct 2026 14:19:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 17/24] hw/arm/virt: Reserve one bit of guest physical
 address for RME
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-18-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-18-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/4/26 5:36 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When RME is enabled, the upper GPA bit is used to distinguish protected
> from unprotected addresses. Reserve it when setting up the guest memory
> map.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/arm/virt.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 61751aa31e0d..cf3a9320dc3a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -4054,17 +4054,27 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(ms);
>       int max_vm_pa_size, requested_pa_size;
> +    int rme_reserve_bit = 0;
>       bool fixed_ipa;
>       int vm_type;
>   
> -    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
> -
>       vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
>   
> +    if (vm_type) {
> +        /*
> +         * With RME, the upper GPA bit differentiates Realm from NS memory.
> +         * Reserve the upper bit to ensure that highmem devices will fit.
> +         */
> +        rme_reserve_bit = 1;
> +    }

"if (vm_type)" are mapped to any VM types other than KVM_VM_TYPE_ARM_NORMAL, meaning
it can be PKVM in theory. So this would be:

        if (vm_type == KVM_VM_TYPE_ARM_REALM) {
            ...
        }

> +
> +    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
> +                     rme_reserve_bit;
> +
>       /* we freeze the memory map to compute the highest gpa */
>       virt_set_memmap(vms, max_vm_pa_size);
>   
> -    requested_pa_size = 64 - clz64(vms->highest_gpa);
> +    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
>   
>       /*
>        * KVM requires the IPA size to be at least 32 bits.
> @@ -4073,11 +4083,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>           requested_pa_size = 32;
>       }
>   
> -    if (requested_pa_size > max_vm_pa_size) {
> +    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
>           error_report("-m and ,maxmem option values "
>                        "require an IPA range (%d bits) larger than "
>                        "the one supported by the host (%d bits)",
> -                     requested_pa_size, max_vm_pa_size);
> +                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
>           return -1;
>       }
>       /*

Thanks,
Gavin


