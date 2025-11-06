Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F25CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 10:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGxas-0002xr-2t; Thu, 06 Nov 2025 05:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGxar-0002xj-1A
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGxap-0002gA-38
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762426308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JEZHxUkya/tzjN9eGtI4bXzvLeKSd6sQguBTH8BVF0k=;
 b=H7kEh/aY+ZTjPJe26jxe7m7v2grIHz+5EJG64//1n69YRrAhwKKqwRYHQIr9dxWWT6IcfD
 rJBBFi48mTqI+yiV+LOgAao+T/IUidZSAbv7ufrhcL631hrSnileEAvJxmyf2mQ3fSFByt
 EawWz8ScNXPW6kC8dtxeNU85ODCzg4g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-IJmJVzSIOsGXlIphWsdfVg-1; Thu, 06 Nov 2025 05:51:46 -0500
X-MC-Unique: IJmJVzSIOsGXlIphWsdfVg-1
X-Mimecast-MFC-AGG-ID: IJmJVzSIOsGXlIphWsdfVg_1762426306
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4774836c376so5029355e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 02:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762426305; x=1763031105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JEZHxUkya/tzjN9eGtI4bXzvLeKSd6sQguBTH8BVF0k=;
 b=auWbS5L2qa/fzD9pwi11z+NrYcqrO2NIc34fxblZznh+IgL2IoMzkxvHLNohaopuOu
 AWI9TL1IhaYqR4/CJsJeWYaTyvZ0GxziPLQlDzVCHipr/1gKwR6B1I4z1CDnj5iHANKh
 ECfRp79K3JGfQ//+4Wvsvodj5YKtd3fco1UZsc6hF2aZeo8kr3JOuKb0NdxuS21A0+j8
 OWxVa9FWC9u933Wg9QabUPcBlXDDtuU+B1QEnRRp3S86HBzJM3MD7EXKcg9G/u0psPAd
 oV40Pf7VG+LXRPuiGuSjcy0zYuZO74cJK60JYBJhqEyhNs8e0BHSHJAH1YVauZlZw1a/
 4Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762426305; x=1763031105;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JEZHxUkya/tzjN9eGtI4bXzvLeKSd6sQguBTH8BVF0k=;
 b=eg8rSpilcYjgR/B0ChLSkHuMksczdSRk4w4I+Q9MbAiAhIi+HRIlh5h4S34meRm9j6
 YtCA9ToEPSi19qeFShisbhIM7RRrZoWTOvmhs8NfOWvnUAr+eb8fHFswfF3WBYVx56Xq
 82yOf0FDziTR+INVuTY+z/cBH2Aco1wY0W3stgMkescvBlIBY8/0yxh+m+T2nxbqkVmN
 0XY94wDfs2rMo/MWRiiQ1yW/5BqSC3SVVL7IOW9hM+50gnS6wJk3xcK3ZKovD/SvMxHx
 6VM+usHU55OCOxYBRqjPvgHxqrg/b0ieODBgEKXnZ8MJeaTYxDpm9atjZh6iRv5503kD
 lzNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh7Rjp+86SLZWFbijM+gLWGZU+dn2I/b1nAkv6htVBiajPBWNtZYxOXgwhXJK/66EX5hNBWv6e1r94@nongnu.org
X-Gm-Message-State: AOJu0YykaDx4kFYD/ArvV1n8hGjafPpVONZVoyBkXTtBSITcP0C3qVs6
 Vnsa5cMA5dMt05p/B3a6NsMWYUOk2k95OvjSF5y190uRCgquAA6UV8nRCCQQt0LU5p5KEG8DZlX
 WDYwRM27v3BpWlWlwgak30TirK5WBAII81YfaTwXbdt9/euMHDpIsiQ0Q
X-Gm-Gg: ASbGnctJSzonnyM6MXyFn9SMybZ//nKpwyQEi5ADQ/oKcU9difgYD/EPtdkkeXlA5XY
 K/pT7qvIJdFfkyvMtwug9kgrB5PRsm/0LrjkyZBIdQHvS6C6+UeeqcqtElD2/Q30EwjYb/Knosz
 o1rIgO3VB9rqXfDyH+kNI4zg5FpsExtFRDCpXE9BDWsSuqHARXAIfJG0oJ6RFh1rwEEsnQm4SY+
 t2YXIkreAvwJYw5yQxWCmYIvPtB32dVoCSyQZ4H3fTuZUEokSui7vfaYcH8HCqnA9cBhuN7OiP7
 rQkFwbUTj1HJJh2eHwLSo7LG6JYmKG7p4gAIoWMlQTUEA6JklkRPBUfDrAUSFvtl5ENzp8oxIIP
 FTwQTjUtQgIyNNW7LShWtc4obkOG8mC6ZiAdwyg==
X-Received: by 2002:a05:600c:1d88:b0:477:54cd:202e with SMTP id
 5b1f17b1804b1-4775cdad6aamr58580075e9.2.1762426305618; 
 Thu, 06 Nov 2025 02:51:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2lok1kbyL2FOQENkCcnyX830SQqBt+gtiEwNhWNbSLPL86Tbg8NLHr9t2pBm6lkCKtI9tlQ==
X-Received: by 2002:a05:600c:1d88:b0:477:54cd:202e with SMTP id
 5b1f17b1804b1-4775cdad6aamr58579875e9.2.1762426305178; 
 Thu, 06 Nov 2025 02:51:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47763eb362bsm13710565e9.4.2025.11.06.02.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 02:51:44 -0800 (PST)
Message-ID: <82ba986b-c36d-438e-9237-1ca299874572@redhat.com>
Date: Thu, 6 Nov 2025 11:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/35] hw/intc: Generalize APIC helper names from kvm_* to
 accel_*
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
 <20251009075026.505715-11-pbonzini@redhat.com>
 <929c041e-4a00-472b-82a6-0fba9022153f@redhat.com>
 <aQtsLWoAR1O0+k+A@example.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aQtsLWoAR1O0+k+A@example.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

On 11/5/25 16:24, Magnus Kulke wrote:
> On Mon, Nov 03, 2025 at 10:43:36PM +0100, Cédric Le Goater wrote:
>> Hi,
>>
>> On 10/9/25 09:50, Paolo Bonzini wrote:
>>> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
>>>
>>> Rename APIC helper functions to use an accel_* prefix instead of kvm_*
>>> to support use by accelerators other than KVM. This is a preparatory
>>> step for integrating MSHV support with common APIC logic.
>>>
>>> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
>>> Link: https://lore.kernel.org/r/20250916164847.77883-5-magnuskulke@linux.microsoft.com
>>> [Remove dead definition of mshv_msi_via_irqfd_enabled. - Paolo]
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>    include/system/accel-irq.h |  37 +++++++++++++
>>>    include/system/mshv.h      |  17 ++++++
>>>    accel/accel-irq.c          | 106 +++++++++++++++++++++++++++++++++++++
>>>    hw/intc/ioapic.c           |  20 ++++---
>>>    hw/virtio/virtio-pci.c     |  21 ++++----
>>>    accel/meson.build          |   2 +-
>>>    6 files changed, 185 insertions(+), 18 deletions(-)
>>>    create mode 100644 include/system/accel-irq.h
>>>    create mode 100644 accel/accel-irq.c
>>
>> This change seems to introduce a regression with interrupt remapping
>> when running a VM configured with an intel-iommu device and an assigned
>> PCI VF. At boot, Linux complains with :
>>
> 
> Thank you for reporting, Cédric. From glancing over it, it looks like a
> typo: we check for `ACCEL_KERNEL_GSI_IRQFD_POSSIBLE` instead of
> `ACCEL_GSI_IRQFD_POSSIBLE` in ioapic.c. The former doesn't seem to be
> defined anywhere.
> 
> Can you verify if changing that fixes the issue for you?
> 
> s/ACCEL_KERNEL_GSI_IRQFD_POSSIBLE/ACCEL_GSI_IRQFD_POSSIBLE/g

Oh I should have spotted that. Kernel does not hang anymore and messages
are gone. Sending a patch.

Thanks,

C.




