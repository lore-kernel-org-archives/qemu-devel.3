Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50F9C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 05:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQgUh-0003b2-E1; Mon, 08 Jul 2024 01:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQgUg-0003WL-4d
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:00:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sQgUe-0007Li-Fn
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 01:00:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4256742f67fso24490005e9.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 22:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1720414850; x=1721019650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xsUzmV9J4QrgMBnJmkHaaNNm5FbxOTyH6rMEMlffB2U=;
 b=J1bKHslQmoirIhNidNYOwNsvG+dpMPypEAHwQCQbgsOgeJncq4RXJpsIF59adP/h+q
 ckF+Vr46LqxMk2huP578ZbnIrHfv1uhHIdcBpQuqHtsf64aNBl/+0d6HeWNY8oVYvj0d
 kuvXnDs7odE8kOhffVnotRR+BJ0k8fu11HZeeuWiLhwwI1FDkUyI0anTvxipHQE6KSlE
 T2CbDlMMuLPrYNdiVr5B68VWIrcyz0tA69ZU+iSzkFwz6rkSwk1uEBEhTLeRILID0jVW
 WJEURTKBn96h33jKAoddTiMKLeIU1Jyl7Y5wsYIh+L8K2NbZ7ZZxxGOXrx/hHghEBpBP
 FzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720414850; x=1721019650;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xsUzmV9J4QrgMBnJmkHaaNNm5FbxOTyH6rMEMlffB2U=;
 b=D3h5QSZne1vwShuyxQn6yUnuWVrYWvT3bNFhejUCy12FgrNXfL/v8Ddp8BkPF6udTP
 xnxj9BEAw5RTAJpWNk8zBUUdGUxWqeaeMmdlMOXoiwl2O10pOcoehhhTWbsj2n3cb6MX
 EulSuA3i9KhZILajDqgKqzCoHx5LhAtv+yp4Ad5+Fy1ncVlpKHYtrYZbmkUNvsRCaXEc
 Puzx/MTOMcFuJx4A5KphmUZOxb+XZo/Uw9+AnXpFZdeW4anhYXXh1oYgqfHrduqY/dbv
 /Lsiv9kP3reagX880SLFcWVJD8BXPfX+VhJQEHnJD8QHcRmqodP1fq63q8c/aPyU1qLA
 lRPA==
X-Gm-Message-State: AOJu0YwoH0Lpp6lMB8q+2Sb7sCwQLm5AF08vIW1+ZLtuOMw1n85MGr4V
 eP0N9psAlDb3l3JPcNITjQfg9kX1WxwQsDJYlHggxmzwQ6paRRsd8YO5GRZhCag=
X-Google-Smtp-Source: AGHT+IG3tuNXkXe8cTqkx9W2AdRnSbb20e8YNoKquxs/q7e6nGfphS2h8o7f/bVjE1ma2mcbx6xAPg==
X-Received: by 2002:a05:600c:2e16:b0:426:5ee5:3130 with SMTP id
 5b1f17b1804b1-4265ee53334mr32149085e9.3.1720414849615; 
 Sun, 07 Jul 2024 22:00:49 -0700 (PDT)
Received: from [10.11.12.72] ([90.220.10.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d50f5sm148211915e9.9.2024.07.07.22.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 22:00:49 -0700 (PDT)
Message-ID: <ae65f50c-f5b7-49ef-a8b1-20366634caf6@opnsrc.net>
Date: Mon, 8 Jul 2024 05:00:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 2/8] hw/acpi: Move CPU ctrl-dev MMIO region len macro
 to common header file
To: Igor Mammedov <imammedo@redhat.com>, Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, oliver.upton@linux.dev,
 pbonzini@redhat.com, mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Shaoqin Huang <shahuang@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-3-salil.mehta@huawei.com>
 <20240706152050.4f5f8109@imammedo.users.ipa.redhat.com>
Content-Language: en-GB
From: Salil Mehta <salil.mehta@opnsrc.net>
In-Reply-To: <20240706152050.4f5f8109@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x32a.google.com
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

Hi Igor,

On 06/07/2024 13:20, Igor Mammedov wrote:
> On Fri, 7 Jun 2024 12:56:43 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
>
>> CPU ctrl-dev MMIO region length could be used in ACPI GED and various other
>> architecture specific places. Move ACPI_CPU_HOTPLUG_REG_LEN macro to more
>> appropriate common header file.
>>
>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>> Tested-by: Xianglai Li <lixianglai@loongson.cn>
>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>> Tested-by: Zhao Liu <zhao1.liu@intel.com>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>   hw/acpi/cpu.c                 | 2 +-
>>   include/hw/acpi/cpu_hotplug.h | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
>> index 2d81c1e790..69aaa563db 100644
>> --- a/hw/acpi/cpu.c
>> +++ b/hw/acpi/cpu.c
>> @@ -1,13 +1,13 @@
>>   #include "qemu/osdep.h"
>>   #include "migration/vmstate.h"
>>   #include "hw/acpi/cpu.h"
>> +#include "hw/acpi/cpu_hotplug.h"
>>   #include "hw/core/cpu.h"
>>   #include "qapi/error.h"
>>   #include "qapi/qapi-events-acpi.h"
>>   #include "trace.h"
>>   #include "sysemu/numa.h"
>>   
>> -#define ACPI_CPU_HOTPLUG_REG_LEN 12
>>   #define ACPI_CPU_SELECTOR_OFFSET_WR 0
>>   #define ACPI_CPU_FLAGS_OFFSET_RW 4
>>   #define ACPI_CPU_CMD_OFFSET_WR 5
>> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
>> index 3b932abbbb..48b291e45e 100644
>> --- a/include/hw/acpi/cpu_hotplug.h
>> +++ b/include/hw/acpi/cpu_hotplug.h
> this file has deps on x86 machine and contains mainly
> legacy CPU hotplug API for x86.

sure.

>
>> @@ -19,6 +19,8 @@
>>   #include "hw/hotplug.h"
>>   #include "hw/acpi/cpu.h"
>>   
>> +#define ACPI_CPU_HOTPLUG_REG_LEN 12
> the better place for it would be include/hw/acpi/cpu.h

ok.


Thanks

Salil.

>
>>   typedef struct AcpiCpuHotplug {
>>       Object *device;
>>       MemoryRegion io;

