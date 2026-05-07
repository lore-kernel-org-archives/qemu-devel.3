Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AA5CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKtHa-0002Wl-6Q; Thu, 07 May 2026 03:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wKtHD-0002Tc-DH
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wKtGw-0005Qf-RR
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778139127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mccKfwgoxdGJMN8rSYKDpYCif5jm/WbV0jG77LJDpDs=;
 b=f6aHVc7Go4lIeOaWqhMYRir048h6josXHAPWi0JS79CzpPiwsKee5fBWriZv941AumKjvJ
 CZ8DnhMKM2gipzrAzquOTWRW3I9G1iSdKT/6QOg5s3WjUSkN0sR9QHhVfL10UwrQan7gLp
 4yAirn1KyHHPuQOUCae9qnT+DA5bZ6w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-uKqb_Y9eO7izHDRiSMhMLg-1; Thu, 07 May 2026 03:32:05 -0400
X-MC-Unique: uKqb_Y9eO7izHDRiSMhMLg-1
X-Mimecast-MFC-AGG-ID: uKqb_Y9eO7izHDRiSMhMLg_1778139123
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4411a36715dso358638f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778139122; x=1778743922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mccKfwgoxdGJMN8rSYKDpYCif5jm/WbV0jG77LJDpDs=;
 b=XAgfRufh9PWKuB2zL6r7admx2cbIS3G9KHUhgtusDTmqP9pJ1bIQplVX2kBi9kw/xg
 BJcC5LzpI/UQhf5SVqookle1opQINKKpVLTyvd/AoB5wmkUAuTmUvoUF0BHrRCBQestF
 P5zz4cVb0ldfIJzBsfoErOizTxIDjJbXfZprcR84P8+wxLHiT7oqY4ihWqKxIpeGsBvY
 doHCKYgI5U35ZK0/0gmuMTJTmYyiWJAw29HhDJRgihBonSRZd0r3KU0gXuvX44l84GNq
 u8JbG7K7WVd0kmsDKBfsyKl8YKrjdP+05fg8adaAjsPMYHWtuaxhRxINXGm39i9bhAUP
 VuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778139122; x=1778743922;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mccKfwgoxdGJMN8rSYKDpYCif5jm/WbV0jG77LJDpDs=;
 b=QI1+mLQqZmXloPqBld0Q5wAeGMdZif2ZxiJbxGv1NIpfeR8afTxOvx7JvBBWIYgvax
 PVMa9GbgCMjMOVGierZvqwOPVe7oO0QjNuQFUiGnY6O1DBK7bSPzS+35k5mfsiLiBjz+
 8jzLanR1PWnXrZzGxfJ3aON1oRS9Jgc+ZR454RMgvqGOara5m2NXtqkzTctG0HWz6I2E
 4EBxOtOrfwKs6KXbqMOg5dthpdDUO4yt3OxAjUleBVp9NHJteBLv8zMqjRSPIgNjShG+
 kLHtiwQmDERMW5CNUiZaVdqSq76QYbRZKE2Q2Xw86iZspt2q4GwLvw0TpPsrHgIEsG31
 yonA==
X-Forwarded-Encrypted: i=1;
 AFNElJ96oF6XHptJ/pXxf5TkjiCVlMWkqllvA8WU7ZmCFl9uD1YomzSdqg0ZkgYbBu0funOXHH2UKNf4rhGx@nongnu.org
X-Gm-Message-State: AOJu0YwtAA9vGJ2uOMymvzI/Fzcl03FJzzJtIgRHaKma6Mqb1rMiYs+w
 6p3JINssvxSwYERb3z2F38wsEh78hFSCdtZkJlvzJv8v/JA01b6yYzrhSoa4IQIrD9TelrNmS/k
 xn9HTZ/h9G5euTHBBr2Wb0EF3jg3zJ9tm8PbSEc3YM1CiETJfKQhxK971
X-Gm-Gg: AeBDiesppyPJJoXzYiEp1vXlojstWmTcxARICrNhRKiK3QogfwOBdKWpLkUfGJHoFsl
 sOsQ6n1ro1+ODj44ceLUYJlxWOAZbsU8X2fGaOuqDOKWbwviON/DEDwBLYtmTNSTIhjSKKELX+H
 MOZ1vE549Xi6NZynbi3R9Hqo+/sroFTcDyquL64kP3+Gb2J6syf84+cc3xKmcv08s9rhETP0Hlm
 6qo2vxZfAZv+8cCWkMj1lcRmcALj69VVhQPJixe/olSUofvPHCiRH+KjNjrBPeWT8PfRuxJAock
 J8iPlTRegR3wtQsgcEwPO+fEWtPouf0cWWRywSSCWZiMzqdljvNEO49VbMi3NN0IG6ajw6nkVKM
 LevjezAsI1Q8Vtq1Vth1aLI3tC4CF+MTb2hT2o3km
X-Received: by 2002:a05:6000:2f87:b0:43d:67f4:91aa with SMTP id
 ffacd0b85a97d-4515dc80aabmr9995378f8f.40.1778139122638; 
 Thu, 07 May 2026 00:32:02 -0700 (PDT)
X-Received: by 2002:a05:6000:2f87:b0:43d:67f4:91aa with SMTP id
 ffacd0b85a97d-4515dc80aabmr9995306f8f.40.1778139122120; 
 Thu, 07 May 2026 00:32:02 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960902sm19783705f8f.28.2026.05.07.00.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 00:32:01 -0700 (PDT)
Message-ID: <1400ae28-5bac-4c18-afa2-64fd11293c05@redhat.com>
Date: Thu, 7 May 2026 09:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Fix memory leaks after removing elements with
 QTAILQ_REMOVE
To: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali
 <alifm@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
References: <20260506174135.2630613-1-thuth@redhat.com>
 <946651d9-0cd5-4482-96e5-a4c59b4d5fcc@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <946651d9-0cd5-4482-96e5-a4c59b4d5fcc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 06/05/2026 21.45, Matthew Rosato wrote:
> On 5/6/26 1:41 PM, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The elements that get removed with QTAILQ_REMOVE are never referenced
>> afterwards anymore, so the corresponding memory should get freed.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/s390x/s390-pci-bus.c  | 1 +
>>   hw/s390x/s390-pci-vfio.c | 1 +
>>   2 files changed, 2 insertions(+)
>>
> 
> Thanks Thomas!  Code looks good and I did some regression testing with
> this patch applied:
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> Should we also consider adding:
> 
> Fixes: b354d5d804 ("s390x/pci: clean up s390 PCI groups")
> Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")

Yes, that makes sense.

Actually, looking at the commit description of b354d5d804, I think this code 
has been added with a wrong assumption: The unrealize method is not called 
during system reset.
So to free the memory, this should likely be added to a reset handler 
instead? Could you maybe have a look?

> Also out of curiosity, did you just stumble on this or was there some
> tooling or testing that was being employed here that found this?

I asked Claude Code to find bugs in the QEMU sources, and this was something 
that looked reasonable to me. (I only used Claude to find bugs, the patch 
has been 100% written by myself of course)

  Thomas


