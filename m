Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749C3D1AD2A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 08:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0zTt-000291-Qb; Wed, 16 Oct 2024 04:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t0zTs-00028g-2r
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 04:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t0zTq-000516-JE
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 04:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729067645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/zBOeVUzfK9vEvigywvBietv8ESWr8ZZzPuzJM4e00E=;
 b=Dvv9vmjDtAb9f50yFIBXhX5LR404O8RxF20LLBRPzcVATacqvAY1pgh3Phzzutv93hnKyS
 l8Si1nhG+/ZAwrZJp6rq6SspRiVwe8sdESYK9cSIGIOQj6wiCDGecqSh8w3EL7k2BFnIMN
 X8FmG5NdjB2nSS9o48D0XyNB1J0VAco=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-7uTGxOFGOzO814i-mWr36g-1; Wed, 16 Oct 2024 04:34:02 -0400
X-MC-Unique: 7uTGxOFGOzO814i-mWr36g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a9a0c259715so235521066b.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 01:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729067642; x=1729672442;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/zBOeVUzfK9vEvigywvBietv8ESWr8ZZzPuzJM4e00E=;
 b=CV7zzAyMFZnESptUr0JmQAYZ2KwzaavU427SH8qvG1C7aEB+dCGFtRfgjRRm57mRbL
 mvYT1gzW2fK0QgknYmAF94Y/8YlM+ezfeJz3y36u7tds1LRLHiLOOyNEqp0yUXWfzLf6
 LFaPd3QXO1FF6HhIknHr+PPCwfF3BovU+SEg3hvtIIySfFl6bmO/vcqQB+TLVfhc3OLn
 9fVTRJkBKHSxYC+z+G9rq3LWArgO3AHD2Cr7+p/8+VS4e0DlMk2l5W4qyF0lNoAJ6vQy
 UVijy/fq44yYEibuTpw3MEXXQ3D/Mh6HsBF3Nwbjo9uBw9qVHkfCLgKGeDyWjrr63SC/
 SzUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCw5kjyTVE6F1qOuOUUbKTJF1rrpjt0naN0PvURo9o4lHC4bh5fltewbhaML3taKSeeS2m4NxHApZ/@nongnu.org
X-Gm-Message-State: AOJu0YziKWVT85gG5C8CAJQZHcNdtyX4QPOVqySQeTsfKycIJkrrbX6H
 iEKiSWL9RZhcvCv2GovtPurFlCfmvS56SBcCn+lvlp3yETcNsMUHOk85dqLidufzpWF4DVk2Bdq
 y6Z4rtGZcUYGH4m2kJXECyCeJhBZD4/hhEazhyJ2wYRCXJ9Itgo6O
X-Received: by 2002:a17:907:3e0d:b0:a9a:b34:94c7 with SMTP id
 a640c23a62f3a-a9a0b35651fmr894758366b.3.1729067641814; 
 Wed, 16 Oct 2024 01:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZnXxcV+6B0z3lGrSo++ApWHksvgtZWPvZAe2BclN7bipccelGxmgI/QKZdJiCzpAzgyC5EA==
X-Received: by 2002:a17:907:3e0d:b0:a9a:b34:94c7 with SMTP id
 a640c23a62f3a-a9a0b35651fmr894755966b.3.1729067641470; 
 Wed, 16 Oct 2024 01:34:01 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-109.web.vodafone.de.
 [109.42.48.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2974c2d0sm155242566b.85.2024.10.16.01.33.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 01:34:01 -0700 (PDT)
Message-ID: <b2274edc-02fc-4c90-9cbb-80a89fd845b3@redhat.com>
Date: Wed, 16 Oct 2024 10:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] qtest/xive: Add test of pool interrupts
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, lvivier@redhat.com,
 pbonzini@redhat.com, Fabiano Rosas <farosas@suse.de>
References: <20241015211329.21113-1-kowal@linux.ibm.com>
 <20241015211329.21113-15-kowal@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241015211329.21113-15-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 15/10/2024 23.13, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
> 
> Added new test for pool interrupts.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>   tests/qtest/pnv-xive2-test.c | 77 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
> index a6008bc053..6e7e7f0d9b 100644
> --- a/tests/qtest/pnv-xive2-test.c
> +++ b/tests/qtest/pnv-xive2-test.c
> @@ -4,6 +4,7 @@
>    *  - Test 'Pull Thread Context to Odd Thread Reporting Line'
>    *  - Test irq to hardware group
>    *  - Test irq to hardware group going through backlog
> + *  - Test irq to pool thread
>    *
>    * Copyright (c) 2024, IBM Corporation.
>    *
> @@ -267,6 +268,79 @@ static void test_hw_irq(QTestState *qts)
>       g_assert_cmphex(cppr, ==, 0xFF);
>   }
>   
> +static void test_pool_irq(QTestState *qts)
> +{
> +    uint32_t irq = 2;
> +    uint32_t irq_data = 0x600d0d06;
> +    uint32_t end_index = 5;
> +    uint32_t target_pir = 1;
> +    uint32_t target_nvp = 0x100 + target_pir;
> +    uint8_t priority = 5;
> +    uint32_t reg32;
> +    uint16_t reg16;
> +    uint8_t pq, nsr, cppr, ipb;
> +
> +    printf("# ============================================================\n");
> +    printf("# Testing irq %d to pool thread %d\n", irq, target_pir);

Please don't use direct printfs in the qtest framework. If you really have 
to log stuff, use g_test_message() instead.

  Thomas


