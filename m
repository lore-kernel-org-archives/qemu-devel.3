Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3D8D6101C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 14:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSz6-0006zH-QD; Thu, 29 Jan 2026 09:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlSz5-0006u1-CA
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:26:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlSz3-0000eb-OG
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769696817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1aoUT7LXqCzW9ig1uZ0ybsDhTmWsYY4vy996VwEdEHY=;
 b=XSO2QvCKfeGIiKO7mT10eH1C0HT2PetxwyS7zyDG/S228NZAXkPBcNPTnUAESEtKyK3hp3
 CsvKPopL6P+sDqEXnPzMiwDdJgZh8UHQACI8TfYLuhj7k6dVoVdUMq9s5fAIxqYrsBCvG9
 r/m+7ti5fqgKq4NkPDu76ADHWdbbMvY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616--vujY66-OxaPRgiTn5tshQ-1; Thu, 29 Jan 2026 09:26:53 -0500
X-MC-Unique: -vujY66-OxaPRgiTn5tshQ-1
X-Mimecast-MFC-AGG-ID: -vujY66-OxaPRgiTn5tshQ_1769696812
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f5dcd4cdso758286f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 06:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769696812; x=1770301612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1aoUT7LXqCzW9ig1uZ0ybsDhTmWsYY4vy996VwEdEHY=;
 b=q4KRcath65foZaWf8OVMmRtTQQepF1J7N02udxYtxw0xPMChwkkA36HVRzyWRg4m1V
 5dzPXUTfwVyy149u446jLzbk9UqVz71MqvUSQ0COlQagQOWxBB1xF47Mmt1gLW2tNrKq
 oB7OQZXc6ljIJ7ztLjigBczw0ZeTA4+WG+BNtZDUCNPWOLvHWgB+rUNLHpr+bHRXZM2W
 CQtaxGlqRI4GY0NM6WitUJL/jo6lIckfO2NJTWTzuD7h+mFYssf5VAbeUhOD4HLM7CRk
 1yY4rxY3NxBKVV4YVh9C60RV3L2Gz202ll3n5PQ6vQ5FdnBY56wjxNaBd1Bo2jNR1GZG
 4lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769696812; x=1770301612;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1aoUT7LXqCzW9ig1uZ0ybsDhTmWsYY4vy996VwEdEHY=;
 b=mCrcMZ3Qk6QAMkgyhILnXND88sfMTZaRobDe67j/6/kLnXSOIKpUeqBdjLQMaML/0q
 QwT+2cZhpkQEOFCcm2lBXW8RPnkVfDwb0zj4HHWNKO2PzkG3ABauHjcGkgu5JYRzAPzA
 nZzxSjW34WcG1aUPnELuwhqcCjwYlyHtQC4DTDHF4hJM5OP5zW2ruxnQZ44vZMDDGZub
 wCMfjLdQlJLPvSRvrf12PHtjaDzoQNyXi4V5JEvTIiS2C7USv3vVWm9o0hQ3NaNNXfm3
 wAvqPpXnNblaKi7g2cfJ6K1xILmW6nSRMkiyLmkncoxKl3FBr+OiDGgKJ7SNU0GGy/t0
 xn5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCtkmOvyHSkgcaUp/JcUrN0RcfNbFDwabJRYJKnn06Qwi8iXDcC0WWPdTmrzpcMi7n/9D2hwkhVZpD@nongnu.org
X-Gm-Message-State: AOJu0Yz1ImtilUTebgjCofGkuqgwfhZ4X3qUvZCwiWeQ7bQ4QoRDC6nJ
 58TcE+SRuYxHXyDWucS+DRrVDfEFwkeC8MXg53K4oOcAktCQbknlUUP/6ciETFSQi8RudrEyiyC
 ql3TgyxeczBrOg2GrUEpb3sL71II0gHlTqwxm6PStNFGUNyGKyfqGMD8e
X-Gm-Gg: AZuq6aJ/ICk/7UIu+sPZmQeXoEz/VnfeaEfqLjK5yly4mCVzi6sl7ho2aB72AjTpskJ
 0m/Nl5U4cxg/uP8qc5aMVwT+YGLSCBIqfJdS43vC3eatKGZE3QMyqU8jxzQmH5rIgsDVsAdpCsX
 C054NoG0fHnoTD1V2q29BYUnfj1AB3BHWbOPXk8Ad+FYdb6QSWGhG7gP3N57G7sxyEJuGegzr65
 SQadjbhua0G6/HkSH1ZUmbea2hGSRcgZsqa4DYV3lVb8p0BdYR9uq96+KCyYheRQIp5S7KM6VEr
 IUHB/uyLfYAi5NKSM1HqDTo7pJ/tu+66veqwXnzF0B3E/YnX3uLzDAdf5862m2WljkDhc6B5SLK
 tBh7eB4c=
X-Received: by 2002:a05:6000:1843:b0:435:a673:bca5 with SMTP id
 ffacd0b85a97d-435dd1bda5dmr13141161f8f.42.1769696812255; 
 Thu, 29 Jan 2026 06:26:52 -0800 (PST)
X-Received: by 2002:a05:6000:1843:b0:435:a673:bca5 with SMTP id
 ffacd0b85a97d-435dd1bda5dmr13141112f8f.42.1769696811769; 
 Thu, 29 Jan 2026 06:26:51 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cefdsm14859874f8f.23.2026.01.29.06.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 06:26:51 -0800 (PST)
Message-ID: <e694cacf-8156-4ba7-9a64-8f6fa06a48d0@redhat.com>
Date: Thu, 29 Jan 2026 15:26:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] pc-bios/s390-ccw: Introduce CLP Architecture
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-8-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260127161547.459443-8-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/01/2026 17.15, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Call Logical Processor (CLP) Architecture is used for managing PCI functions on
> s390x. Define and include the structures and routines needed to interact with
> PCI devices during IPL.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/Makefile |  2 +-
>   pc-bios/s390-ccw/clp.c    | 96 +++++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/clp.h    | 24 ++++++++++
>   3 files changed, 121 insertions(+), 1 deletion(-)
>   create mode 100644 pc-bios/s390-ccw/clp.c
>   create mode 100644 pc-bios/s390-ccw/clp.h
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 259cff09db..9c29548f84 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>   
>   OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
>   	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
> -	  virtio-ccw.o
> +	  virtio-ccw.o clp.o
>   
>   SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>   
> diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
> new file mode 100644
> index 0000000000..2a14bb9b73
> --- /dev/null
> +++ b/pc-bios/s390-ccw/clp.c
> @@ -0,0 +1,96 @@
> +/*
> + * Call Logical Processor (CLP) architecture
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "clp.h"
> +#include <stdio.h>
> +#include <string.h>
> +
> +int clp_pci(void *data)
> +{
> +    struct { uint8_t _[2048]; } *req = data;
> +    int cc = 3;
> +
> +    asm volatile (
> +        "     .insn   rrf,0xb9a00000,0,%[req],0,2\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), "+m" (*req)
> +        : [req] "a" (req)
> +        : "cc");
> +    return cc;
> +}

Since this instruction is not part of the public Principles of Operation, 
I'd appreciate if someone from IBM could review this patch.

 From my side, I can only provide:
Acked-by: Thomas Huth <thuth@redhat.com>


