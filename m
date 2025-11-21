Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E66DCFA477
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 06:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vML0C-0003aA-9x; Fri, 21 Nov 2025 01:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vML0A-0003Za-PF
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 01:52:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vML08-0003od-IC
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 01:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763707930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gF05YVo7s9NJT1v4+oKcymDmGaLfxKAtCaFOowBY/So=;
 b=CGrH+DGpj9G5oOIVpbUkePtQ6vJBWJBSevxudplqxyt9X1lVCwE42xhX8lMW/13UiCk1zU
 JcS2ymzf2vyOlXYUhBT5E+M4Tv0kpT9K+5WblhmpZCLpuicQOysea5pjEbBP5YClwYHDlH
 ifNjppexVropRTe+2dfqzFl7/1Q1JQg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-Ujb5c26aN2WGO7l1hNwu8A-1; Fri, 21 Nov 2025 01:52:09 -0500
X-MC-Unique: Ujb5c26aN2WGO7l1hNwu8A-1
X-Mimecast-MFC-AGG-ID: Ujb5c26aN2WGO7l1hNwu8A_1763707928
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-342701608e2so1983497a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 22:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763707928; x=1764312728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gF05YVo7s9NJT1v4+oKcymDmGaLfxKAtCaFOowBY/So=;
 b=emb2l5q6PY5fhjDzNguilq8w5oY+MPWE0tFUdEDtrten1i3UsYOCWsayJjx0iAOV1V
 MLWB9S0mrOGfw+23wxMn4HcSBiP0FZ+MDz0rn/RIvOjHKOxC4qRwkQI+G4PupUVXwnzV
 X8v75XmXE6RkZcmkK1WG4MhtoAZ3EfUlejVm/mHZPNFg3Z3/eqfh1J8FqG68lwaYL/3I
 Blbd9cR9WReVseyvbHUOASTF+b6TzxxyTJOe2UU4zdz42MgV84LTdpmA1nsjh3PyGhJa
 93z+GQHmvVxz3CjhhhL1dByeQ66okBrRyJpN2ARlwmvihDgLzTSRJwL+hA71D8BsECGK
 //MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763707928; x=1764312728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gF05YVo7s9NJT1v4+oKcymDmGaLfxKAtCaFOowBY/So=;
 b=PzCtCyh0Znby+bwCSvG5q5IvrBPeJE//DNKR4OtD8piteMqM9wmEDZKIiKrHv5ZYSX
 C7gPFICw3G/LQmXpZ9Q43YlwlqTJoyG90OV9BOqaeqFaZdpjP95I0pOcloKzV6zitC05
 nWQCStqwOOIC7KQ7Y2IsrGPUS58aqHQ3xWvVZUIQ1GrrO1Vt5btDrZ5N33pCy+slxLSF
 rCitlA9ZQpiZaUj52gc8wTIRDmThuqnG+ixFU9PFy7Jay8SGns971i1cWaFdIZ8OKtkA
 ZgvJ3NkPdA67u5zZT5GVCYDr2441pNx3Y9HUlo93PJqHnlIqG14dFbCGJKq2TV+vWAch
 47cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK9AVunyexxtzDdNPoGDHJrgsB0oOMFiRtg83bVYf0PnGf9f2LDocow4jJlaON0s/SR7HKj8RXdS9k@nongnu.org
X-Gm-Message-State: AOJu0YxXWDaYcowzkaNAiDea8xPTtXfcvF5SAemwMD8RpYuYptccHkX0
 WY6HHxMGXZg583ouYi25wXJ2IxVlHM2h+C0bYgKgfijIH1hqPZLJ0TCqpKihbx/o0IeJbCxbXGJ
 0trkTGPu/XNsYa564DaiGaJwrwoAcUFrL/AphR5rOhx2/lZ17gP6YpFxH
X-Gm-Gg: ASbGncu2BSeQFEjVP96MFvSvt7Mwc4CAzix0HCpYs5JrXygGIM8EWQJzW+7ell6U8ff
 5c7TKCoag3n6m4mZKGPFYlJrLjkr6qaUGZhYYUpFnrg8PsR0cC2aaHPBIDpMFPfHuh5lvmRYB2f
 4+jhBTg9CelykM7gDpoCCkB9TC4KhuUjYbgZ1OdNc/LlFiknjDAl4KzMoh8DBR5ejhcRcd069Fr
 fR8C6jZTRzQGkhaNIrz4L/QbRjhVhiaLckeEM5VWt5hIAnM3cPtwGi+7Glludh6ovv5lkyVCrt4
 18bPpQVMij7Na6z8L89DcfASJ9AkBegD2bEbRf6haqe8Ysh309ex4Zy24gpe8Sv7RQNg3X00GL9
 Y6qnmcYDbgdUqMC/V2q0/GXHW7gCw+JYpuO7k9m6HBVgxqVJqsA==
X-Received: by 2002:a17:90b:5704:b0:340:dd2c:a3da with SMTP id
 98e67ed59e1d1-34733e436damr1299283a91.8.1763707927821; 
 Thu, 20 Nov 2025 22:52:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEPa/bTgTBH1lYBJHordkqvB86rJBWuuKv+FRp6FyAdP1qvY93kRBz9AnYJ0vbK0kLmUicDw==
X-Received: by 2002:a17:90b:5704:b0:340:dd2c:a3da with SMTP id
 98e67ed59e1d1-34733e436damr1299254a91.8.1763707927372; 
 Thu, 20 Nov 2025 22:52:07 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f155f6e7sm4854431b3a.63.2025.11.20.22.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 22:52:06 -0800 (PST)
Message-ID: <3be51d9f-366a-47a3-a048-623608aa0475@redhat.com>
Date: Fri, 21 Nov 2025 16:51:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] target/arm/kvm: Improve memory error handling
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 gengdongjiu1@gmail.com, mst@redhat.com, imammedo@redhat.com,
 armbru@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com, zhangliang5@huawei.com
References: <20251112172535.403042-1-gshan@redhat.com>
 <20251118104755.000024c8@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251118104755.000024c8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
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

Hi Jonathan,

On 11/18/25 8:47 PM, Jonathan Cameron wrote:
> On Thu, 13 Nov 2025 03:25:27 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> In the combination of 64KiB host and 4KiB guest, a problematic host
>> page affects 16x guest pages. Those 16x guest pages are most likely
>> owned by separate threads and accessed by the threads in parallel.
>> It means 16x memory errors can be raised at once. However, we're
>> unable to handle this situation because the only error source has
>> one read acknowledgement register in current design. QEMU has to
>> crash in the following path due to the previously delivered error
>> isn't acknowledged by the guest on attempt to deliver another error.
>>
>>    kvm_vcpu_thread_fn
>>      kvm_cpu_exec
>>        kvm_arch_on_sigbus_vcpu
>>          kvm_cpu_synchronize_state
>>          acpi_ghes_memory_errors
>>          abort
>>
>> This series fixes the issue by sending 16x consective CPER errors
>> which are contained in a single GHES error block.
>>
>> PATCH[1-4] Increases GHES raw data maximal length from 1KiB to 4KiB
>> PATCH[5]   Supports multiple error records in a single error block
>> PATCH[6-7] Improves the error handling in the error delivery path
>> PATCH[8]   Sends 16x consective CPERs in a single block if needed
>>
> 
> Hi Gavin,
> 
> Just a quick head's up to say we've had some internal discussions around the
> kernel handling of broader address masks in CPER and think it is probably
> broken. Rectifying that may at least simplify what is needed on the QEMU side
> of things and maybe even handle much larger blocks (2M and larger).
> 
> Will keep everyone informed of how we get on with resolving that.
> 

Thanks, Jonathan. If the broader address mask in CPER can be used to isolate
the specified memory range instead of a page, QEMU needn't the improvement
done in this series. Please copy me if the linux patches are going to be
sent for review if possible, I will try to review.

I will pull those patches improving error handling and post them separately
so that they can be merged. Those patches aren't really relevant to error handling.

Thanks,
Gavin


