Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCAACCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 06:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB5uR-0001LE-4S; Tue, 21 Oct 2025 02:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vB5uL-0001Kz-NT
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 02:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vB5uI-0007yY-Qv
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 02:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761028300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mJdetGy7s6Eh0AFewJxRezzgesEUhmlB3Y3ANnfqFAo=;
 b=SDguyHaGAW9bjhU87qtNyirXsmvTiF92XyYgCo2gneIjjJq9aHssvQaz03TSIwIyHoADRc
 xGUVsS72emwnMWDi9rxTFC9uo3M/Bh7gI2etoWwFo5XzZLp+MdWmzA+9yr0g6JXBZRpjeQ
 uCkhjYibYKYUCEqNNeleKzUxMDbp5Wo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-EG8wDLZxPeCQsOtNgq3hTw-1; Tue, 21 Oct 2025 02:31:38 -0400
X-MC-Unique: EG8wDLZxPeCQsOtNgq3hTw-1
X-Mimecast-MFC-AGG-ID: EG8wDLZxPeCQsOtNgq3hTw_1761028297
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso32609575e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 23:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761028297; x=1761633097;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mJdetGy7s6Eh0AFewJxRezzgesEUhmlB3Y3ANnfqFAo=;
 b=pSf9iiL+edHQjLA8k240yQyN8US5e5O2v0xAVq3E3YFLhR9XoWZiIKpDNETbpQaQGc
 M1N+aThaGgLcX7hlrlOInlYbGm6FwPsFt9vWIM6CXEjAyHnzA3MJTU//mgVkSjyZ53R0
 SDxVRwx1SB9wl1YH+21+rcbiU0JL2C5LKBwuMC5JnrqoUJrcdB/0Bdo0bV3xVfuc8pNq
 AHfGHDDOBn2sFGxq6YhpgMmrpKKeRqe7MDwcr6oFxl1/sgQFkDNz/HHDJAlftb1n3CNk
 XNPaev1FzNLcC8dLhyO6PL0Nj3mAhNerjXpiDFgq3hIjRbeiBWnHJfdT2vywT4SGmOco
 RXMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW001llmTDR25Fq/inO6KTd8pMeJC5sWWDe8PFZgVTyyxarqmOEuTWm2EpnmFEFNkdwZNDZ5YHnv7ne@nongnu.org
X-Gm-Message-State: AOJu0Ywq76tBpq1npqCenWGwGkhYiiyp1y8qXSeSZECuRTT2y1Pmo/du
 Sk2j+6uH/b2XpJ2TyfW2ExmVM2nwYFxv/nnvRV/bTmkcWv/T4xk4iClk8mO4OefK29mu/fm1Q4G
 pf780Jg166PoALKWpBshcV71/fwXaHFZuv8m9LJ1pxu5S8pFB1Zci5Frw
X-Gm-Gg: ASbGncvuYPgAFKVo065Saa6dTjyGIt14Ge27xGvPtWUAB544GaFxqdB/eBGqOdGZT4M
 XnSq6FjyST/YwxZ1z+h48NGiAUHdoS/9SRSij4ksR1tyvFIj1HcQ5YWB2txtpLeAvfC/vJY0SkF
 w+WP14yIDmVC4Kl/BfVI64fZ+RWRyxSFFDGupgsdDe3SzNuZWPw+OH/TW7ogpKMnn/0RphX3v7N
 TYyGx/I5tjxP2ixEXzA/Rgofws80o01MTR27OM3gSnBe6GX/hF/Fot6NzNDh3IhhzQ6ylACSaM3
 SAC+oI8APn7/q2vDEkgA3FE81zOohuYHVhzct3eFA/jAyKQsJzfww7tUyN37h9rrxk4AfA1xjGk
 K98ex2GPN5vMZY6qsKwdCRiHmMobzwjULOuXCWg==
X-Received: by 2002:a05:600c:3492:b0:471:1774:3003 with SMTP id
 5b1f17b1804b1-4711791c88bmr114393315e9.29.1761028297299; 
 Mon, 20 Oct 2025 23:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVXDUTvidurILZlOGQfMaqSjOeQ1X+IsWdk1WGAGQttjMvrC8S2YoiOfR4b/NSqr2LLboAXQ==
X-Received: by 2002:a05:600c:3492:b0:471:1774:3003 with SMTP id
 5b1f17b1804b1-4711791c88bmr114393105e9.29.1761028296900; 
 Mon, 20 Oct 2025 23:31:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144239f4sm265962245e9.2.2025.10.20.23.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 23:31:35 -0700 (PDT)
Message-ID: <8993a80c-6cb5-4c5b-a0ef-db9257c212be@redhat.com>
Date: Tue, 21 Oct 2025 08:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] hw/ppc/spapr: Remove deprecated pseries-3.0 ->
 pseries-4.2 machines
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20251020103815.78415-1-philmd@linaro.org>
 <fdb7e249-b801-4f57-943d-71e620df2fb3@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <fdb7e249-b801-4f57-943d-71e620df2fb3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi

On 10/21/25 06:54, Harsh Prateek Bora wrote:
> +Cedric
> 
> Hi Phillipe,
> 
> It had been done and the patches were reviewed already here (you were in CC too):
> 
> https://lore.kernel.org/qemu-devel/20251009184057.19973-1-harshpb@linux.ibm.com/

I would take the already reviewed patches, as that work is done. This series
is fine, but it is extra effort for removing dead code, which isn't worth
the time.


Thanks,

C.




> 
> Let us try to avoid duplication of implementation/review efforts.
> If the motivation to re-do is just to split, I think let us consider the original series to avoid duplication of review efforts. I should probably send more frequent PRs to avoid such scenarios in future.
> 
> Thanks for your contribution in reviewing other patches though. It's highly appreciated.
> 
> regards,
> Harsh
> 
> On 10/20/25 16:07, Philippe Mathieu-Daudé wrote:
>> Remove the deprecated pseries-3.0 up to pseries-4.2 machines,
>> which are older than 6 years. Remove resulting dead code.
>>
>> Philippe Mathieu-Daudé (18):
>>    hw/ppc/spapr: Remove deprecated pseries-3.0 machine
>>    hw/ppc/spapr: Remove SpaprMachineClass::spapr_irq_xics_legacy field
>>    hw/ppc/spapr: Remove SpaprMachineClass::legacy_irq_allocation field
>>    hw/ppc/spapr: Remove SpaprMachineClass::nr_xirqs field
>>    hw/ppc/spapr: Remove deprecated pseries-3.1 machine
>>    hw/ppc/spapr: Remove SpaprMachineClass::broken_host_serial_model field
>>    target/ppc/kvm: Remove kvmppc_get_host_serial() as unused
>>    target/ppc/kvm: Remove kvmppc_get_host_model() as unused
>>    hw/ppc/spapr: Remove SpaprMachineClass::dr_phb_enabled field
>>    hw/ppc/spapr: Remove SpaprMachineClass::update_dt_enabled field
>>    hw/ppc/spapr: Remove deprecated pseries-4.0 machine
>>    hw/ppc/spapr: Remove SpaprMachineClass::pre_4_1_migration field
>>    hw/ppc/spapr: Remove SpaprMachineClass::phb_placement callback
>>    hw/ppc/spapr: Remove deprecated pseries-4.1 machine
>>    hw/ppc/spapr: Remove SpaprMachineClass::smp_threads_vsmt field
>>    hw/ppc/spapr: Remove SpaprMachineClass::linux_pci_probe field
>>    hw/ppc/spapr: Remove deprecated pseries-4.2 machine
>>    hw/ppc/spapr: Remove SpaprMachineClass::rma_limit field
>>
>>   include/hw/ppc/spapr.h     |  16 --
>>   include/hw/ppc/spapr_irq.h |   1 -
>>   target/ppc/kvm_ppc.h       |  12 --
>>   hw/ppc/spapr.c             | 298 ++++++++-----------------------------
>>   hw/ppc/spapr_caps.c        |   6 -
>>   hw/ppc/spapr_events.c      |  20 +--
>>   hw/ppc/spapr_hcall.c       |   5 -
>>   hw/ppc/spapr_irq.c         |  36 +----
>>   hw/ppc/spapr_pci.c         |  32 +---
>>   hw/ppc/spapr_vio.c         |   9 --
>>   target/ppc/kvm.c           |  11 --
>>   11 files changed, 75 insertions(+), 371 deletions(-)
>>
> 


