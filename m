Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242FACCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESmx-0002g6-Qh; Thu, 30 Oct 2025 09:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vESmv-0002fg-6n
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:34:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vESmg-0006pI-0v
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:34:00 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7a59ec9bef4so1431736b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761831218; x=1762436018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hyKcxysZ33fMPNDWi/eaUxMVEvS6a6uurtUUuzAIyvI=;
 b=Kxxn00Cd4U8EEFpoFRq4hQEK45DyAcL/+xMO90hMljWzXAQ9EKeMwpq2hKSr8bOoMk
 5tWDihx1GUFZ/5pkl231mRHVbB/9We2epuQS5585+PON8B9vQMF20DwXYKGCwSYcmc+7
 U3r6aRFQKmEiPbX5ExJQO545ZXu5hLtiff/Lnp4K0/yKzTWQ6Yc1+zG1b2ajInZLcNJj
 RRgGVl+/UglyHA0d4bOznWH/JwJRNwort3y9XY8HVvNTzPGQBOR56mXfP/XAuSK/mCNA
 iihHt4+mLYvtwDpKiXUTlTBaaaup83jfEKJXW5Q1W/IjmADCjg1KmxG378y1jTo0KEbW
 XtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761831218; x=1762436018;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hyKcxysZ33fMPNDWi/eaUxMVEvS6a6uurtUUuzAIyvI=;
 b=tSO8Fz6zqMRUV8MpJe+NLfUBtBLpOiTC4pXsfYYQZ8NSRur5Bs5uOETiV+WJMUgKfq
 q1MgP0Xu9Xw1mknUqhLQWObHqcnilXq2ye03Ix6u8TSgHHSdY5sUVJYGWO16kCZMi2yp
 Yl/HcYsGvw/ddoU+guE3QTt2hWcXFTwJXlBZxlSxR7BKLRzrhboKFWXbk0r1A6hBieI7
 MsfYENR+MlnTiqlHxeAzsilzRQF56ZWgKpneM9ujUaka84J63386721sgsqYb7kFktOW
 ymvghmpPa/mTmkTdtQU83clNNkNYPsc6lZT4hvxb5iV3UM53bcafCbapqeRSO5HZAP0j
 wBFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg0aAE7oi7dpT3VOB1potv1IkUd8fDjw3KLbomO4wZmnOBmHLNCWEJAqOAIofzPs5GpQAReVTTTf2I@nongnu.org
X-Gm-Message-State: AOJu0Yy8C2uUmvKUx0gqJl5obGBoXAacHQL9pCmp6ty3mSnpzybCBDnY
 PE9ZUV8mTeetJsjTv80ECQF+ldYvQIPop+EFloQiQzvvzNrSvG+/NZFDbhaeNYiP3WA=
X-Gm-Gg: ASbGnctbRKOQJ5aO0SUW5iF0kmL0TLxmlGDF5u3hGgMOr5ViE6gmWy9ADxEcgLdIYM7
 dVz2sZv1xVh9VuTID5sgmCMC4sRMbE4KxE/Wb6TqjQfLWcb/6beni44U5jys3r31kGo/M9jCSG2
 37xMCfNWy/Fz9J+gxdqxiovPuJPwCRXqubJUoPpqkwzxlpikzJJY3SV88fV3JREogPQLPGN9Dy3
 qGw2tipWpV8jJ5qCo8ie/v0Fe//BBjV/Qnue3JfnhF4Yofykp/0byDeZgtIvzGAw2KYDVl22THS
 qL/A0zZlVUN9eyH/MIdpCv6XdquCt+q5O8qb9yCXP3798a7w9S5xLRtWD9pv21+yRNQoEZp7X7n
 FWJOoQsPH/sE7oR2uKMdDDAIGibSHeArgksuk6F5t+MNKvO11S7O+JLrxqfAndGyuA0pL040dnL
 1fRKr3zMjSDQTRSXt9Eg5js4M=
X-Google-Smtp-Source: AGHT+IGN+2/BYTADlEWte1/fQ3B/o6wQCO54i1intE15dQQUOw4wU5/FJlK2TDhJQbbZNuyi0Ab8EA==
X-Received: by 2002:a05:6a20:7284:b0:344:de3e:3249 with SMTP id
 adf61e73a8af0-34658562b01mr9803411637.25.1761831218256; 
 Thu, 30 Oct 2025 06:33:38 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.65.79])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414065418sm19075473b3a.41.2025.10.30.06.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 06:33:37 -0700 (PDT)
Message-ID: <18dc5a20-85c6-4e85-b76f-66dca6771bc1@ventanamicro.com>
Date: Thu, 30 Oct 2025 10:33:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] hw/riscv: Add Server Platform Reference Board
To: Chao Liu <chao.liu@zevorn.cn>
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 zhiwei_liu@linux.alibaba.com
References: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
 <dbbdc597-9b4d-4dd3-8143-821ac5d82a3a@zevorn.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <dbbdc597-9b4d-4dd3-8143-821ac5d82a3a@zevorn.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
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



On 10/30/25 8:48 AM, Chao Liu wrote:
> On Wed, May 28, 2025 at 05:01:29PM -0300, Daniel Henrique Barboza wrote:
>> Hi,
>>
>> This is my attempt to ressurect the Server SoC Platform reference work
>> that has been buried for an year. The last posting was made an year ago
>> [1].
>> Most of the changes were made due to upstream differences from one year
>> ago. Patch 1 is an example of that.
>>
>> In patch 2 (former 1), the main difference is the new CPU is rva23s64
>> compliant. This wasn't possible in May 2024 because we didn't have this
>> support back then.
>>
>> Patch 3 consists mostly of code base changes rather than functional
>> changes. There was a discussion about whether we should supply fdts in
>> this machine back in the v2 review [2]. The answer is yes: machine mode
>> requires fdt to work, and we want to be flexible enough to generate our
>> own fdt instead of relying on EDK2 to supply them. Note that we can also
>> supply an EDK2-generated fdt via command line, bypassing the fdt created
>> by QEMU, if desired.
>>
>> Patch 4 adds a riscv-iommu-sys device to the board. This wasn't possible
>> back then because we didn't have the required upstream support for it.
>>
> 
> Hi, Daniel.
> 
> Do we have any plans to support virt-io on the rvsp-ref machine in the future?

Hmmm good question. In theory we're interested only in implementing the rvsp-ref
spec but adding virt-io support doesn't hurt the spec implementation in any
way ... I think. Drew, any comments?


> 
> Recently, I have been using the RISC-V reference platform built on this set of
> patches to support running the OpenEuler RISC-V operating system.
> 
> I will actively feed back any test results to the upstream.


This series has been stale because, as you might've read in the thread, it turns
out we're missing a mandatory extension (sdext).

I get emails from time to time from people asking about the status of this work
so I'm considering pushing the patches as is, without sdext, and add documentation
saying that this isn't a 100% rsvp-ref compliant board. The absence of sdext
seems tolerable for the current uses ppl have for the board ATM, so upstreaming
it as is can be beneficial for everyone. We can add sdext support later and
then update the docs claiming 100% compliance.

At very least I'll have to send a v4 now that you pointed out a wrong memory
address in the memmap, so I'll start with that.


Thanks,

Daniel


> 
> Thanks,
> Chao


