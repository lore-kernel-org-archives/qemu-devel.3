Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C998C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 06:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHGq6-0004Gx-4y; Tue, 20 May 2025 02:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHGq4-0004Gf-Hc
 for qemu-devel@nongnu.org; Tue, 20 May 2025 02:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHGq2-0007Si-GP
 for qemu-devel@nongnu.org; Tue, 20 May 2025 02:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747723953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/gmqkLKzypVJlMLMtxzhBJCXF5RGVteJI4SwJrbaYWo=;
 b=ea+ZMC9ksp8LmsyALUm+Kqai742oekBgUE7rBK9LFzW2yQBtJ6mU5NEpliFiFZzMEmxqnY
 N7yHPr0iwWLzNELcVvz7LyOQmcjvGxqkbVO4JLHiC2vTZ+C5ntQvTd4vXqbzALaNkTNP3Z
 GRxLc4uwR5Um9KK4+HGHkeUwUbhxt9Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-_XjiiPBtMfyPS7TfhNLbdw-1; Tue, 20 May 2025 02:52:31 -0400
X-MC-Unique: _XjiiPBtMfyPS7TfhNLbdw-1
X-Mimecast-MFC-AGG-ID: _XjiiPBtMfyPS7TfhNLbdw_1747723950
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a371fb826cso783824f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 23:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747723950; x=1748328750;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gmqkLKzypVJlMLMtxzhBJCXF5RGVteJI4SwJrbaYWo=;
 b=XJrvbvf/Kn/3oetLxCsYU7ReE7MpABXkwdkNdct4zakN9x3G3lM+epYdlzorIPHUfw
 dfYOShM3ToQL5Cpd1hsOsR6IxHQinlIozg7B2ApMDpH8YM0LNz3DgJOUP82VsDMT1XJI
 GiP/AACYWnLayppEmzENRIRbUQvFL8doNjVeP+XZKDQuoJmCd6HQxIu3DdJ9ZyMQhwj1
 wLazT1lIgQJqa1UazOHqiPcaCtIDZ2ppRH7j/i+tZYhjKJaXo4UoozcLOPnGK7bawfEy
 gQxjODa3MHUHQq0NcVjEZmhKxR8oooQlAk0klLbVA2lOpjwxqOGb8o/iaiUWue26RLlf
 T6cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSvsGCudkfYJdbaRANAnNwni0mOx9vwKXeU7uD5P8lCNDy9b+HBK3GwYo3AnNIFfsY/RcdTv/9ey87@nongnu.org
X-Gm-Message-State: AOJu0YxxRnI/7R5jZiF6y7YaWBQDZkV2gzNCdwMh5KDzfui+iWyAydbH
 pjEXP9lJwhJ+Ka/m1XUJAZQNxo7jCjkLxrIyHOOveNoBChC+MFzZFc0cTbFWqs1KXOe+lyjmz12
 0/S0TX8Ica0nx2iSIWMkrpWf1Vvlyl2F6hA/pHMBKsx2gIh2wLJxOKiAfq4bsF5B9u5o=
X-Gm-Gg: ASbGncvXmiY9A5uA8HVlp/NAKqrPHed7kgk8uWkDAHtPxqHiUwfLUgHSX9X2Xk90qEY
 9zkl/DX7US/yQwFQbUO5eBdrx149z9OeO6twH39lxXUDQZT2SPq5xH0a97Z7NDC4bx96L7IsLI+
 exXFswuOF18yCJDBQRF4Rs3QO3aZ0fhzIPU+TOMeRDmQKR4hWT/KK4Opx9fHJh9GX/PmGp2uVj9
 pgrVkrhXdCR4AeU5KV8WslhM6Zvv9QER0KISwNZwq89FUS5WuPDujvCCOxygyqWtRDtGT924+uk
 cueLzXVgZFQ0KIPYS5sg3KDw+xN07c4zrUlp4cpdQe/QirEd/A==
X-Received: by 2002:a5d:5848:0:b0:3a3:5c7c:18a7 with SMTP id
 ffacd0b85a97d-3a35c858007mr12529858f8f.52.1747723949930; 
 Mon, 19 May 2025 23:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJfLOmgAqUmAB6J5aHj22k0neqmpLgx9iqdt73tiYn++T4RJANbX/KCTRbXUwdHXa8+EFMXQ==
X-Received: by 2002:a5d:5848:0:b0:3a3:5c7c:18a7 with SMTP id
 ffacd0b85a97d-3a35c858007mr12529833f8f.52.1747723949519; 
 Mon, 19 May 2025 23:52:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d230sm15057490f8f.4.2025.05.19.23.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 23:52:29 -0700 (PDT)
Message-ID: <779b2cc9-a028-4b59-b72d-e361647996ea@redhat.com>
Date: Tue, 20 May 2025 08:52:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 4/4] s390: implementing CHSC SEI for AP config
 change
To: Anthony Krowiak <akrowiak@linux.ibm.com>,
 Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-5-rreyes@linux.ibm.com>
 <d95ae850-a6d4-4a26-8bae-3c4619fe25f2@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <d95ae850-a6d4-4a26-8bae-3c4619fe25f2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/13/25 13:38, Anthony Krowiak wrote:
> 
> 
> 
> On 5/12/25 2:02 PM, Rorie Reyes wrote:
>> Handle interception of the CHSC SEI instruction for requests
>> indicating the guest's AP configuration has changed.
>>
>> If configuring --without-default-devices, hw/s390x/ap-stub.c
>> was created to handle such circumstance. Also added the
>> following to hw/s390x/meson.build if CONFIG_VFIO_AP is
>> false, it will use the stub file.
>>
>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> 
> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> 
>> ---
>>   MAINTAINERS           |  1 +
>>   hw/s390x/ap-stub.c    | 25 +++++++++++++++++++++++++
>>   hw/s390x/meson.build  |  1 +
>>   target/s390x/ioinst.c | 11 +++++++++--
>>   4 files changed, 36 insertions(+), 2 deletions(-)
>>   create mode 100644 hw/s390x/ap-stub.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 23174b4ca7..070c746c69 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -112,6 +112,7 @@ F: hw/intc/s390_flic.c
>>   F: hw/intc/s390_flic_kvm.c
>>   F: hw/s390x/
>>   F: hw/vfio/ap.c
>> +F: hw/s390x/ap-stub.c
>>   F: hw/vfio/ccw.c
>>   F: hw/watchdog/wdt_diag288.c
>>   F: include/hw/s390x/
>> diff --git a/hw/s390x/ap-stub.c b/hw/s390x/ap-stub.c
>> new file mode 100644
>> index 0000000000..e2dacff959
>> --- /dev/null
>> +++ b/hw/s390x/ap-stub.c
>> @@ -0,0 +1,25 @@
>> +/*
>> + * VFIO based AP matrix device assignment
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Rorie Reyes <rreyes@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.

FYI, I dropped the redundent license boilerplate. See [1].

C.

[1] https://github.com/legoater/qemu/commit/8db3dbac401c56da6e865dcba1304f305555c22d

>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/s390x/ap-bridge.h"
>> +
>> +int ap_chsc_sei_nt0_get_event(void *res)
>> +{
>> +    return 0;
>> +}
>> +
>> +int ap_chsc_sei_nt0_have_event(void)
>> +{
>> +    return 0;
>> +}
>> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
>> index 3bbebfd817..99cbcbd7d6 100644
>> --- a/hw/s390x/meson.build
>> +++ b/hw/s390x/meson.build
>> @@ -33,6 +33,7 @@ s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
>>   ))
>>   s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
>>   s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
>> +s390x_ss.add(when: 'CONFIG_VFIO_AP', if_false: files('ap-stub.c'))
>>   virtio_ss = ss.source_set()
>>   virtio_ss.add(files('virtio-ccw.c'))
>> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
>> index fe62ba5b06..2320dd4c12 100644
>> --- a/target/s390x/ioinst.c
>> +++ b/target/s390x/ioinst.c
>> @@ -18,6 +18,7 @@
>>   #include "trace.h"
>>   #include "hw/s390x/s390-pci-bus.h"
>>   #include "target/s390x/kvm/pv.h"
>> +#include "hw/s390x/ap-bridge.h"
>>   /* All I/O instructions but chsc use the s format */
>>   static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
>> @@ -574,13 +575,19 @@ out:
>>   static int chsc_sei_nt0_get_event(void *res)
>>   {
>> -    /* no events yet */
>> +    if (s390_has_feat(S390_FEAT_AP)) {
>> +        return ap_chsc_sei_nt0_get_event(res);
>> +    }
>> +
>>       return 1;
>>   }
>>   static int chsc_sei_nt0_have_event(void)
>>   {
>> -    /* no events yet */
>> +    if (s390_has_feat(S390_FEAT_AP)) {
>> +        return ap_chsc_sei_nt0_have_event();
>> +    }
>> +
>>       return 0;
>>   }
> 


