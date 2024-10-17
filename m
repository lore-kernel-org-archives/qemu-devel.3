Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FED4D2F7EC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 05:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1JAT-0002gT-4T; Thu, 17 Oct 2024 01:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t1JAR-0002g8-OD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 01:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t1JAP-0007IU-VK
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 01:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729143320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tv63YOIP9q8YGBw2rs4krQFFKyf4BlLlIOosdPx8iJk=;
 b=CUCGNBPE0pf78fkG6UaV+V/VYZyxVMnEI/Imi2T2Lell58UzRPdbSFIV/Zsk4M+eOEjHtr
 W10apk53BwaMCnG2VqpgW4kobYGw7x1RsKnyJnWAMhM02YGxAj8KnNJLzyH2wHIqO6iruA
 t7J7exQCEznAU46J/2NFlm5avSxJjGw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-iSBSt2OeNLm6nNTjsb2fbg-1; Thu, 17 Oct 2024 01:35:17 -0400
X-MC-Unique: iSBSt2OeNLm6nNTjsb2fbg-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5eb584e7aacso478960eaf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 22:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729143316; x=1729748116;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tv63YOIP9q8YGBw2rs4krQFFKyf4BlLlIOosdPx8iJk=;
 b=BZKBnYHv/VnHfqwWQ2KyLTxB4hEQF38CmjWfYPbpROX4YRsJJlqVT2+usenIc7oK0K
 /rkckfWAXgnBi5NxABgzdyZbMCaYE+kj5kw4FAkeJPZkqgIPUtIk/QrNRn+3IwqZ44nx
 Czil0QQzAUFCdQUIBzmrfnQFuXpe4w0XSiXr70o4eA544380IAwjfdU2NK2JLoTuXsrN
 8urAxHYnYQt2e5uDi7t6jhQpcwtFfn9iSciiYTG8ayas56GuLZ0GGHwwynbkcVL/Pp3d
 ms0/2fIjYBmJOSwi0phlumF2kOgWjEok4NR2YeqoaMxqyO2kig5lZtSk/hQbxTE1+8K9
 JGRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhUXnDMJ2/Dam+1BCaQjAbzqBso+KcRhpf/DIVF2Iv9MTUze7mhkw1mrNedxvPwrcZRw05YhSv3J8/@nongnu.org
X-Gm-Message-State: AOJu0YzumdSle8ZOmHvIcvan/9FxzCyCEpvOah3DbQm3yaF85OpesHzq
 LIwCUQWYH1fAaqZiAcZga2JmJFeMW7bc9PXsXsngbzdlFqWtfeRzxS2LDyWjuw0QbGQZfbmbc5f
 +uwDWZ17RVi6lsuSrMkN96zDLn3+W2Fm60IfIgtRaMkJMJGy4eI+X
X-Received: by 2002:a05:6358:7e49:b0:1bc:d1b9:ccc8 with SMTP id
 e5c5f4694b2df-1c32ba78da2mr1393203255d.14.1729143316631; 
 Wed, 16 Oct 2024 22:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdDmtu1r7umwJt/cp5RiuPvTYrbarxsQ5NpXKoCgMfoC84wy8bzzB0N8V3fLGOLuAl7I3mLg==
X-Received: by 2002:a05:6358:7e49:b0:1bc:d1b9:ccc8 with SMTP id
 e5c5f4694b2df-1c32ba78da2mr1393199255d.14.1729143316200; 
 Wed, 16 Oct 2024 22:35:16 -0700 (PDT)
Received: from [192.168.68.54] ([180.233.125.129])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77370a83sm3981518b3a.5.2024.10.16.22.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 22:35:15 -0700 (PDT)
Message-ID: <a45bd567-3570-40e6-8c59-070199512496@redhat.com>
Date: Thu, 17 Oct 2024 15:35:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/4] hw/acpi: Initialize ACPI Hotplug CPU Status with
 Support for vCPU `Persistence`
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com, gustavo.romero@linaro.org
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-2-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241014192205.253479-2-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/15/24 5:22 AM, Salil Mehta wrote:
> Certain CPU architecture specifications [1][2][3] prohibit changes to CPU
> presence after the kernel has booted. This limitation exists because many system
> initializations rely on the exact CPU count at boot time and do not expect it to
> change later. For example, components like interrupt controllers, which are
> closely tied to CPUs, or various per-CPU features, may not support configuration
> changes once the kernel has been initialized. This presents a challenge for
> virtualization features such as vCPU hotplug.
> 
> To address this issue, introduce an `is_enabled` state in the `AcpiCpuStatus`,
> which reflects whether a vCPU has been hot-plugged or hot-unplugged in QEMU,
> marking it as (un)available in the Guest Kernel. The `is_present` state should
> be set based on the `acpi_persistent` flag. In cases where unplugged vCPUs need
> to be deliberately simulated in the ACPI to maintain a persistent view of vCPUs,
> this flag ensures the guest kernel continues to see those vCPUs.
> 
> Additionally, introduce an `acpi_persistent` property that can be used to
> initialize the ACPI vCPU presence state accordingly. Architectures requiring
> ACPI to expose a persistent view of vCPUs can override its default value. Refer
> to the patch-set implelenting vCPU hotplug support for ARM for more details on
> its usage.
> 
> References:
> [1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
>      architectures that don’t Support CPU Hotplug (like ARM64)
>      a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
>      b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
> [2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
>      SoC Based Systems (like ARM64)
>      Link: https://kvmforum2020.sched.com/event/eE4m
> [3] Check comment 5 in the bugzilla entry
>      Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   cpu-target.c          |  1 +
>   hw/acpi/cpu.c         | 35 ++++++++++++++++++++++++++++++++++-
>   include/hw/acpi/cpu.h | 21 +++++++++++++++++++++
>   include/hw/core/cpu.h | 21 +++++++++++++++++++++
>   4 files changed, 77 insertions(+), 1 deletion(-)
> 

[...]
    
> +/**
> + * acpi_persistent_cpu:
> + * @cpu: The vCPU to check
> + *
> + * Checks if the vCPU state should always be reflected as *present* via ACPI
> + * to the Guest. By default, this is False on all architectures and has to be
> + * explicity set during initialization.
       ^^^^^^^^^
       explicitly

> + *
> + * Returns: True if it is ACPI 'persistent' CPU
> + *
> + */
> +static inline bool acpi_persistent_cpu(CPUState *cpu)
> +{
> +    /*
> +     * returns if 'Presence' of the vCPU is persistent and should be simulated
> +     * via ACPI even after vCPUs have been unplugged in QOM
> +     */
> +    return cpu && cpu->acpi_persistent;
> +}
>   #endif

Thanks,
Gavin


