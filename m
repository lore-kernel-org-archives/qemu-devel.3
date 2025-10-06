Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D94CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 14:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5lq1-0004F8-9t; Mon, 06 Oct 2025 10:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5lpx-0004EM-11
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5lpt-0001GG-7k
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759759500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2YTJRvY/xmt1KyEW290HMQbcA5Z6y0xRT6GH5jNkRnE=;
 b=SaEpT2/pVdoz0giZQPMFDcXZyICu7CierlqT0K+R3RL4jxiDVl7LUa7J5dQtBI7vrHlcI9
 70CaxY3xIHlac8ETn5PuZfGmykLz5y4F3VIauMbOqvVlbAxSRVPnyb3DojpVtQHyxmmUj4
 CzEGQPK/CqwnxQfPMIjWzr7Dh73gOeA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-PanrzdSlPlOTEN6GDZqBvQ-1; Mon, 06 Oct 2025 10:04:58 -0400
X-MC-Unique: PanrzdSlPlOTEN6GDZqBvQ-1
X-Mimecast-MFC-AGG-ID: PanrzdSlPlOTEN6GDZqBvQ_1759759497
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e35baddc1so26759015e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 07:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759759497; x=1760364297;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2YTJRvY/xmt1KyEW290HMQbcA5Z6y0xRT6GH5jNkRnE=;
 b=lsz1vpW+FnnM4yc9SnlwUEdEvXc2ooc98vC1YXnF9HmqmU3P8RBTN63MDncVQ+esM2
 W9ico1gjfYLa9PVdMJk+h8VzjLGEa54Cjdhqnt5MVtnXo28wLgtFpEbyCjEFnx57QXxk
 O3AaA64l6yLJXQug5mAgTfM7hxH7dtZ9FmKmvKSCI5Vh2zuL7TT/AWXok+wDEYXNknOS
 XR/JJIyYIVVLx1kagdAc3ws5Y7OUstvpjs3zkSTy68I7FkZ5e7WuBRiNzDfK7+VqnK2U
 JbIeQNnsjIeSVp9n0NlnUwx8V76MwlX4e3VaTMN4FLlhqoAVdBL/ZfKQxV+KwK16QFIz
 UoAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNMt2spy3b1fkTLX3RZvAUTUWi3NlG6TasHjF4xJSWvQW5rmHF7QFZk88uLbMn92+S9/KkM+8zrdCz@nongnu.org
X-Gm-Message-State: AOJu0YxoBp/eiwKQbRVd1QbvH9yWiKCP2dRfvZ+xm0byceCU1HOxI4rO
 0a2ab9KB259eGy1O10VvTa0G4Y2p/LqH1hx+Uz9VFsuVIAJBNNNMntTDfWRDqCJfjGZcBWq1A7G
 d0NV3sDaBZglkOggr26eAu39MSJ31bhj3VRq0sA2Xm8r0mWLruJGPZifJ
X-Gm-Gg: ASbGncva6eJrOenWdLHcqj7x8ynjb9AI40iy5ifYEVLbRTKD3o1wR6dSsP9O36SxVwl
 Iemkm0kb8O9r1LbztJpA3txbbjgPqDklCao2Dc+YsCwyiPjru2nu8Nf19AFLMoK6itK9ASCLCm3
 WS5cCetgCAt/o0b25UVDhf0t6ikmWIDSox8r4khIlRuBlG/6IORm4UebT1fe1Zu0itp60lkARiP
 O8L7x/9rz3T951WGcNILBcR8s2FBuxSZdPno4VtAYcovcQvbovfQLfbCuR5R3un9OkkKSYZ02U8
 KjOOAtKlkjLMwDEw9NBWiFEYxaELYjKzLY9dCDIetAzTDRZtSzypFj7uxB/lBx2JcMLHMet2Eb7
 UQJOElogZ7w==
X-Received: by 2002:a05:600c:1389:b0:46e:376c:b1f0 with SMTP id
 5b1f17b1804b1-46e711002b0mr94499495e9.7.1759759496811; 
 Mon, 06 Oct 2025 07:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHImMrVm43LgzRC9+T+E4DPPv0Nm/m4ChvKQ2zYK0Ciz/GpQrKvtGktJxqbMGYCFtLuIZVwYw==
X-Received: by 2002:a05:600c:1389:b0:46e:376c:b1f0 with SMTP id
 5b1f17b1804b1-46e711002b0mr94499055e9.7.1759759496338; 
 Mon, 06 Oct 2025 07:04:56 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72374b8dsm177538595e9.19.2025.10.06.07.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 07:04:55 -0700 (PDT)
Message-ID: <9052ebc9-190c-48e2-bc4f-a4339e7692a9@redhat.com>
Date: Mon, 6 Oct 2025 16:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/s390x: Replace legacy
 cpu_physical_memory_read/write() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20251002091132.65703-1-philmd@linaro.org>
 <20251002091132.65703-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251002091132.65703-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02/10/2025 11.11, Philippe Mathieu-Daudé wrote:
> cpu_physical_memory_read() and cpu_physical_memory_write() are
> legacy (see commit b7ecba0f6f6), replace by address_space_read()
> and address_space_write() respectively.

I'm not sure whether this patch is a good idea in the current way it is done.

Commit b7ecba0f6f6 says: "there is likely to be behaviour you need to model 
correctly for a failed read or write operation" ... so if we switch to the 
address_space_* API, I think you should also implement the correct handling 
for the case where the memory transaction failed. Otherwise this is more or 
less just code churn, isn't it?

  Thomas

> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index c2fedc55213..737c3bbc5be 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -17,6 +17,7 @@
>   #include "s390x-internal.h"
>   #include "hw/watchdog/wdt_diag288.h"
>   #include "system/cpus.h"
> +#include "system/memory.h"
>   #include "hw/s390x/ipl.h"
>   #include "hw/s390x/s390-virtio-ccw.h"
>   #include "system/kvm.h"
> @@ -82,11 +83,14 @@ static bool diag_iplb_read(IplParameterBlock *iplb, S390CPU *cpu, uint64_t addr)
>           }
>           s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
>       } else {
> -        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
> +        const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
> +        AddressSpace *as = CPU(cpu)->as;
> +
> +        address_space_read(as, addr, attrs, iplb, sizeof(iplb->len));
>           if (!iplb_valid_len(iplb)) {
>               return false;
>           }
> -        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
> +        address_space_read(as, addr, attrs, iplb, be32_to_cpu(iplb->len));
>       }
>       return true;
>   }
> @@ -98,7 +102,10 @@ static void diag_iplb_write(IplParameterBlock *iplb, S390CPU *cpu, uint64_t addr
>       if (s390_is_pv()) {
>           s390_cpu_pv_mem_write(cpu, 0, iplb, iplb_len);
>       } else {
> -        cpu_physical_memory_write(addr, iplb, iplb_len);
> +        const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
> +        AddressSpace *as = CPU(cpu)->as;
> +
> +        address_space_write(as, addr, attrs, iplb, iplb_len);
>       }
>   }
>   


