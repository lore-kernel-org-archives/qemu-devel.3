Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B98C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURAG-0000mS-Ug; Wed, 25 Jun 2025 10:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uURAC-0000m2-30
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uURA9-0007Jp-9f
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750861901;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGXrAcauABsJvsDu0MTIOzKL5T58+phM6dr0hePCHLw=;
 b=WjC+0Rw1rRRVnM73Qdx3J0d8W/N8VeQTy0WCc9vN+VBTuXqQXLKCU31A1EHdFsYD3Sp8oV
 nZ87dJVq846/F85ouRsu+tDh2tYFq8mhupY6izgC4QmAUfMxSctJYHf5+32pLYHOuwIyEv
 P6uNA5dSw+VLbH04/FL8Qkvq9JCEHvY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-7TXcyBoHOZaebB4gTKx8kA-1; Wed, 25 Jun 2025 10:31:39 -0400
X-MC-Unique: 7TXcyBoHOZaebB4gTKx8kA-1
X-Mimecast-MFC-AGG-ID: 7TXcyBoHOZaebB4gTKx8kA_1750861898
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a5780e8137so540385f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750861898; x=1751466698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DGXrAcauABsJvsDu0MTIOzKL5T58+phM6dr0hePCHLw=;
 b=GD3Vy1PxNmUdcZHyJL35wOpEfU72c4rv7u7MDdwV1SdNYeTRTxwUMJFXGJEgTVJzHj
 O1URsJTZyt1tEb8cq92GRp7szpu6fZtM7t3ULuxHml7CpCS4O1PzO1o1da3mf6oDTk16
 lUs9TvI/lwL5XzGLlmsRALfpiImLX987WB0g7IBDrzXLCDEQl9RUwS9XSa4/JR+qHTVW
 JmvxvIxc2sao0MsRnGVdLPJMxRO3AYQlxjsUFapE2kZ10VLqltj51kGam5tIdASrmsh9
 BqqcPeFh0bU+cetVMi0J+0dyZyaqQZwIQClK8tIjLvEZ9hrKz+2muev1jTAICHKi0lP2
 NM0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGBLipH+8JXnqdz5/HalqAUIKK5Z7WeV90T1TeYJiat8cMccFTbUWITLi8UMMBw3FNKO27OG3fGVlg@nongnu.org
X-Gm-Message-State: AOJu0Yz96kUdwOa6M2F7NTxKFOLvu+3w49+KBzdZhA6StoOZGx/rmrD5
 j8NyrNuv4v3IDGsP1hPd6dxF43inP/UhpKRaNo1sJ/cA0gOe1bfXdKMow7XZZc0tizajac/3PtB
 vbDO4D3lPvaVgLpl3Z/TKVD09G9rTd+uBFy1dBHRor5Y7utJHcDrwcuzk
X-Gm-Gg: ASbGncuO62GIsu2NZj3PkvucmyFjNEkN09t3qTp40YUv5qLOjIntxZQA51oEX9VLOKi
 c1edOl0+J6fORhVDGVeC8+lXQx/oUUeeJuWFi9oIrJyS17jgRshhubW+aypH85Ij7RoE1TZO9cc
 Et9HBLzpJLt0+tKH/w6Vz1HBIPQdoJeINcrxSmB5HgQvEolRKMknx3nlvw5Pzp900Hmk0Sq/715
 q/PrN2dOBUX7APZaV5ZDK7aor1102bpLw0BrLqNAhVjavF393drKokyBK70krmYtKI9sVRr8PmE
 3sAmD1+QzKg5H3gPya64ODzsXiKwQkIWjVkwZppu5ST7vRVuAuQ7u0vYdAzwiwYzeu4nZQ==
X-Received: by 2002:a05:6000:2089:b0:3a4:e1f5:41f4 with SMTP id
 ffacd0b85a97d-3a6e71ff6ecmr6822167f8f.17.1750861898054; 
 Wed, 25 Jun 2025 07:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHtOmgA2peKooZaMq56zEbr9NpQzt2e43nlZzDoIIrQFAUj/PN8uFMuNzG6QOZq7NMx3ZUoQ==
X-Received: by 2002:a05:6000:2089:b0:3a4:e1f5:41f4 with SMTP id
 ffacd0b85a97d-3a6e71ff6ecmr6822102f8f.17.1750861897535; 
 Wed, 25 Jun 2025 07:31:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233bd14sm22302765e9.2.2025.06.25.07.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:31:36 -0700 (PDT)
Message-ID: <c93670f8-f204-448d-b795-b893237c05f5@redhat.com>
Date: Wed, 25 Jun 2025 16:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/29] hw/acpi/ged: Prepare the device to react to PCI
 hotplug events
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-21-eric.auger@redhat.com>
 <20250620104445.000033d5@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620104445.000033d5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/20/25 11:44 AM, Jonathan Cameron wrote:
> On Mon, 16 Jun 2025 11:46:49 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> QEMU will notify the OS about PCI hotplug/hotunplug events through
>> GED interrupts. Let the GED device handle a new PCI hotplug event.
>> On its occurrence it calls the \\_SB.PCI0.PCNT method with the BLCK
>> mutex held.
>>
>> The GED device uses a dedicated MMIO region that will be mapped
>> by the machine code.
>>
>> At this point the GED still does not support PCI device hotplug in
>> its TYPE_HOTPLUG_HANDLER implementation. This will come in a
>> subsequent patch.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Been a little while since I looked at how all this fits together
> but this looks right from what I can remember.  Hopefully others
> can give a more definitive review!
>
> One stray change that belongs in an earlier patch though.
> With that fixed up.
>
> So with that in mind.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
thanks!
>
>
>
>> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>> index e79a24b821..36492aa0d9 100644
>> --- a/hw/acpi/pcihp.c
>> +++ b/hw/acpi/pcihp.c
>> @@ -43,7 +43,6 @@
>>  #include "qobject/qnum.h"
>>  #include "trace.h"
>>  
>> -#define ACPI_PCIHP_SIZE 0x0018
> It goes away from here, but doesn't get added anywhere?
>
> Looks like this belongs in patch 17?
removed from 17!

Eric
>
>>  #define PCI_UP_BASE 0x0000
>>  #define PCI_DOWN_BASE 0x0004
>>  #define PCI_EJ_BASE 0x0008


