Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F20CC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwbY-0006ya-Q4; Wed, 19 Mar 2025 12:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuwbW-0006y3-RA
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuwbU-0003Hw-5u
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742402953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rAsv3bc3CfBx05pYqwNvWA3mVWumgJk7v/S1S21076o=;
 b=dEwtbN/AadH3vGE83A8sQZYabPXMW2bNgl8ql4NA/u/Gp7+G3yyOvZHlVorVPmDpVHVu6/
 1ISdDArQTyRpOtqGbqHRg5LYY4aV2Pjlfy760mwrcOkd89SI6tvXdUbiPiwomDNbfuOFXv
 1JzMhBOgBIPOp2HmeWXShVjXWoAw9tU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-mYJaORP-Mf-lrmCvQBvpBA-1; Wed, 19 Mar 2025 12:49:11 -0400
X-MC-Unique: mYJaORP-Mf-lrmCvQBvpBA-1
X-Mimecast-MFC-AGG-ID: mYJaORP-Mf-lrmCvQBvpBA_1742402950
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-394bbefc98cso4502831f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742402950; x=1743007750;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAsv3bc3CfBx05pYqwNvWA3mVWumgJk7v/S1S21076o=;
 b=bpCsoSmRM9RXVHws0PjX/aUeIaDiXXrBDqaxlFc3U1R7t6H2zHfQuaWWkTTh7QN9W1
 TDArvMCIrsTr8Wt6TdhRh9MSlEC2jqu8xbrnZ55p6GPZ/gVEypmAHe84eRNOWx+GUEhG
 LyL47ssxtW0oTpKFoDbT2Qt54TT7o5losF1R6/wTU1e0KKCCBXyUTwD0Qc+xbc8EqBAe
 2NtQ+uSAwKzZJTr7oJ4ieYJ5bFTh9hj3Sq1H3cc7R5EGgnyAT0baVaPzjn+Nya7UfIjR
 zry0Ck5ERx/X3B7SGpA7myI1BT3tIDtFS0lDTeu9pQfx+Do2/cHcH0G/sNG0ur0UfuXY
 BWXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8Ja4xwp3HrPFipe702RnB2pN26/ZLIVeKtPwhm2K2A9VGLk3hXWkvX0/VgxJFQBI3NW2wSs00E7Ij@nongnu.org
X-Gm-Message-State: AOJu0YzhD2zJ11fvFVkO50Wpj9fBkdUFG3DRqCXmUKTJT42pp+RuRbuc
 NGJIUzPMoNGYgz4JdL5tvoE9/zb3XLh7NUj0s/wI0Fo+i3pGHHgrjUzagBkJa0cImaEBq4gMLCj
 nhKi5D/ZW9TvTZJlLQamIQI3TTbE1P7x8kiDoniTNmBf2pjnlMYW7
X-Gm-Gg: ASbGncsZO77whssU6HLj1IlNJFr7zZZGLN084Eg2RGngZbJi1MXLA3tF+PVCBcbmu43
 4MCN+RZHM1pi25PR2kw4pCnJMJwoKbiD9HgCVjJ3ymv2GCdJQZ78o1HJjbnce/twZsoNVx0YZFf
 5GT35Ozv/aLefN3/w4wWcTpL82B1V39GYJocHxlcVZAErRcc830ZFaBs5YZchhUVX9qct1bPUOT
 Dge9Ol7lDRAMGGkHeTPuFuqcI46TyE0EFqZu3VmPWL187PJ/37Xxt7uGpo5cmsuLd0FmbtMyQJ/
 FEb6vUKChVef0hQRxR1rmyC/4dfz+//QOkRl4Va5Pw+o+dHv2Gl3iw==
X-Received: by 2002:a05:6000:188b:b0:391:4940:45c3 with SMTP id
 ffacd0b85a97d-39973b2b8e0mr3347490f8f.54.1742402950041; 
 Wed, 19 Mar 2025 09:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9MwSKgGXTfjnaefLDJrAfv6q7NoQA4Z7m5cOIAhcToBZkjY0i5dasj/yEDKrItNNCtIXC8A==
X-Received: by 2002:a05:6000:188b:b0:391:4940:45c3 with SMTP id
 ffacd0b85a97d-39973b2b8e0mr3347464f8f.54.1742402949550; 
 Wed, 19 Mar 2025 09:49:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975b90sm21866392f8f.53.2025.03.19.09.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:49:09 -0700 (PDT)
Message-ID: <686dd11d-7018-4b91-8d68-7ea9f4f4d508@redhat.com>
Date: Wed, 19 Mar 2025 17:49:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 03/32] vfio: Introduce a new header file for
 external migration services
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-4-clg@redhat.com>
 <df484075-f6a0-41b5-9c7f-c4817c160489@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <df484075-f6a0-41b5-9c7f-c4817c160489@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

On 3/19/25 13:37, Avihai Horon wrote:
> 
> On 18/03/2025 11:53, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> The migration core subsytem makes uses of the VFIO migration API to
>> collect statistics on the number of bytes transferred. These services
>> are declared in "hw/vfio/vfio-common.h" which also contains VFIO
>> internal declarations. Move the migration declarations into a new
>> header file "hw/vfio/vfio-migration.h" to reduce the exposure of VFIO
>> internals.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/hw/vfio/vfio-common.h    |  4 ----
>>   include/hw/vfio/vfio-migration.h | 17 +++++++++++++++++
>>   hw/vfio/migration-multifd.c      |  1 +
>>   hw/vfio/migration.c              |  1 +
>>   migration/target.c               |  2 +-
>>   5 files changed, 20 insertions(+), 5 deletions(-)
>>   create mode 100644 include/hw/vfio/vfio-migration.h
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 9cfb3fb6931e71395ef1d67b0a743d8bc1433fdc..5fc7ee76573375bc8464baee29ab88974fac3d3b 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -290,13 +290,9 @@ extern VFIODeviceList vfio_device_list;
>>   extern const MemoryListener vfio_memory_listener;
>>   extern int vfio_kvm_device_fd;
>>
>> -bool vfio_mig_active(void);
>>   int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>>   void vfio_unblock_multiple_devices_migration(void);
>>   bool vfio_viommu_preset(VFIODevice *vbasedev);
>> -int64_t vfio_mig_bytes_transferred(void);
>> -void vfio_mig_reset_bytes_transferred(void);
>> -void vfio_mig_add_bytes_transferred(unsigned long val);
>>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>>
>> diff --git a/include/hw/vfio/vfio-migration.h b/include/hw/vfio/vfio-migration.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..259c532f64bdd002d512375df3140f291a0ade85
>> --- /dev/null
>> +++ b/include/hw/vfio/vfio-migration.h
>> @@ -0,0 +1,17 @@
>> +/*
>> + * VFIO migration interface
>> + *
>> + * Copyright Red Hat, Inc. 2025
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_VFIO_VFIO_MIGRATION_H
>> +#define HW_VFIO_VFIO_MIGRATION_H
>> +
>> +bool vfio_mig_active(void);
>> +int64_t vfio_mig_bytes_transferred(void);
>> +void vfio_mig_reset_bytes_transferred(void);
>> +void vfio_mig_add_bytes_transferred(unsigned long val);
> 
> IIUC, vfio_mig_add_bytes_transferred is not used externally. Maybe move it to the internal migration header?

sure. let's do that.

Thanks,

C.



> 
> Thanks.
> 
>> +
>> +#endif /* HW_VFIO_VFIO_MIGRATION_H */
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index 378f6f3bf01f6a4155fb424f8028cb5380f27f02..fe84735ec2c7bd085820d25c06be558761fbe0d5 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -11,6 +11,7 @@
>>
>>   #include "qemu/osdep.h"
>>   #include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-migration.h"
>>   #include "migration/misc.h"
>>   #include "qapi/error.h"
>>   #include "qemu/bswap.h"
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 8bf65b8e11094b8363692dba3084b762362c7dd6..75096377ffecf62b3bab91102a00d723827ea4c7 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -17,6 +17,7 @@
>>
>>   #include "system/runstate.h"
>>   #include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-migration.h"
>>   #include "migration/misc.h"
>>   #include "migration/savevm.h"
>>   #include "migration/vmstate.h"
>> diff --git a/migration/target.c b/migration/target.c
>> index f5d8cfe7c2a3473f4bd3f5068145598c60973c58..e1eacd1db7a471cba51b4e257a834eb7581f9671 100644
>> --- a/migration/target.c
>> +++ b/migration/target.c
>> @@ -11,7 +11,7 @@
>>   #include CONFIG_DEVICES
>>
>>   #ifdef CONFIG_VFIO
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-migration.h"
>>   #endif
>>
>>   #ifdef CONFIG_VFIO
>> -- 
>> 2.48.1
>>
> 


