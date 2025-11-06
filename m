Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC6BCCFA0D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 03:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGqTq-0003tG-3N; Wed, 05 Nov 2025 22:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGqTo-0003sk-T8
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 22:16:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGqTl-00035U-6C
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 22:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762398962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dc+EgfG+CEzokJ22MK58FUPyJQ3TfKNKbmBl+mINl6U=;
 b=JzZZE2MJCRzC1Te2BiIm6OozmPr0UiktcE91BKM1dlZf5sF545sSktUUwtIJma6JqIbs/0
 sVY++QHpfRZcP1aMyUWNG+sJB+KNvM/CTyNRn6oeyTlpAo/yz2RALOTCrsUWPliJM12bf0
 8Hg5BeR68O9Ym76mXhhyNwbzQLqKTL4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-xa94WKfyPLeN11PwHhju1Q-1; Wed, 05 Nov 2025 22:16:00 -0500
X-MC-Unique: xa94WKfyPLeN11PwHhju1Q-1
X-Mimecast-MFC-AGG-ID: xa94WKfyPLeN11PwHhju1Q_1762398960
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-29598910dd2so14762405ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 19:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762398960; x=1763003760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dc+EgfG+CEzokJ22MK58FUPyJQ3TfKNKbmBl+mINl6U=;
 b=DhHmLCr/Wq8nQ+zCe2W4CL0uxFBD2yWKgfHUlW1BHeOedecpuGUTPE3EIt4Q1/soIb
 sE5+cwnda/L7JfamxmHwZcdy/7cM9eFWpSG9ms7rEHRniQFPSpA77TObOZxScGAlbt7M
 F5VU0hMGQk8fjvP9s04LWjADgowpSwl8jwulHOHdzGlFSMNhJQZeKiFBsbg8B6jvEp1o
 58h3MIH9yobqr3059mABm1v2hpozuL0gjBnzfnvHUu4dIVejTEKCvUiCJpThj3KidNac
 tyIz8++vr7gu4w8ZS+lw4VSiu+WYdK9Kz1Hou2dViK3MMmtQHxcbjPyTDyVUaUEz6lHO
 TlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762398960; x=1763003760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dc+EgfG+CEzokJ22MK58FUPyJQ3TfKNKbmBl+mINl6U=;
 b=Sjd86JSu1WtnWhULP3d89nmUuGvW8zchCOTVkoagK7dAvtzS03iglxTymezQ/Q6m0K
 LqE09r6u370BmHiIoczMzN5yJYJFhBUc+Q/NCWkpU9GJ90MEUqanT3g3+LMr1SoDCIg7
 9ciEWcaCEeVOUlTvF3ro8VMJdAGSHGVIgMaS3ycA5PU/K+r/pPu1WlABcYVS2TFbJ2Xf
 JUGLl4/0I6shSRRuV5isuDHFnYu8ypijigglVIWj0lHIF7+EvhETgboVCSlPZd9YfbXx
 EV/3WboIALdEDNOaCef+8gqPvQLHh983L3NMy9lY+P/QC1vp3ey4eEMz4onnIxB/z1Yz
 616g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjRI7y86VLGvaWv7VORDtF0xcwbcxZHcsndZA/i8wY/+0vwjJwe/Basv1ncOakTFL7yxOGFuNh9YF2@nongnu.org
X-Gm-Message-State: AOJu0YwSFB2yxiu+K+8WSlwova2jViXws2Bk7jHtGy9oFK9iNjCmqX8I
 j0gFm7V6IpcvQVzd+HkdTU40pgwkXaQsuZDfpInEuTCywBveGMFcBf7mDNH/h7//8dzS90o5TEy
 x3rvUU9RWjJbNad1OmbQRSUR9vVdyoWviv4DH81BoenpU2rLR+fvRs7Vx
X-Gm-Gg: ASbGncvCNcXgcMcW+ZgWryEoc/eZbFNA7fjCfSlOoc/RGrfsr0sRepdcFckCoCsjB/d
 3bEVsQHp6OJPovgrcM3sD7sUnloAgV9rkgkSZ1JDNxRmBy/1hXqR1MH0EwW6QPhk8+9+rFMD9bA
 PAIuG7/v2ko90kSKmJr+iEVhOttCcZgT62A0KS0T0zaG492MkrDbl+fwe11O7dDNPtoz0Mbl4jz
 l0roYmfWkXXDp6J97eOWOvgwfo+U4zhscW3B+7R9LxRwoEGsnbWtteB2lkVp7BhmXrHuwYADqif
 QNbUJcSZu7+vRV/pBkO1uEby1eNcNfSgo7aXnSsl/EHd6G0Z1vF3yQbR246RmMijr8tc/Owt7Yh
 jtyE3+mCLHMqQ8Q53MnYxdckqYALLcjXo4AhQOGk=
X-Received: by 2002:a17:903:350c:b0:295:94fe:d5dc with SMTP id
 d9443c01a7336-2962ad0c67bmr78049965ad.2.1762398959890; 
 Wed, 05 Nov 2025 19:15:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrHJjnnAxVxaVyJREL6rViJyXgqF0UXgZTx6h+0BQpLA15hAYDTMPKoK0bZ+j7MLeXOOquXA==
X-Received: by 2002:a17:903:350c:b0:295:94fe:d5dc with SMTP id
 d9443c01a7336-2962ad0c67bmr78049615ad.2.1762398959479; 
 Wed, 05 Nov 2025 19:15:59 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c6f201sm10240195ad.55.2025.11.05.19.15.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 19:15:58 -0800 (PST)
Message-ID: <cc07dfc9-f58a-4654-8854-c16a2e85fecd@redhat.com>
Date: Thu, 6 Nov 2025 13:15:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] acpi/ghes: Extend acpi_ghes_memory_errors() to
 support multiple CPERs
To: Jonathan Cameron <jonathan.cameron@huawei.com>, shan.gavin@gmail.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 gengdongjiu1@gmail.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-5-gshan@redhat.com>
 <20251105141455.000052f0@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251105141455.000052f0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

Hi Jonathan and Igor,

On 11/6/25 12:14 AM, Jonathan Cameron wrote:
> On Wed,  5 Nov 2025 21:44:49 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> In the situation where host and guest has 64KiB and 4KiB page sizes,
>> one problematic host page affects 16 guest pages. we need to send 16
>> consective errors in this specific case.
>>
>> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
>> hunk of code to generate the GHES error status is pulled out from
>> ghes_gen_err_data_uncorrectable_recoverable(). The status field of
>> generic error status block is also updated accordingly if multiple
>> error data entries are contained in the generic error status block.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Hi Gavin,
> 
> Mostly fine, but a few comments on the defines added and a
> question on what the multiple things are meant to mean?
> 

Thanks for your review and comments, replies as below.

>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>> index a9c08e73c0..527b85c8d8 100644
>> --- a/hw/acpi/ghes.c
>> +++ b/hw/acpi/ghes.c
>> @@ -57,8 +57,12 @@
>>   /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
>>   #define ACPI_GHES_MEM_CPER_LENGTH           80
>>   
>> -/* Masks for block_status flags */
>> -#define ACPI_GEBS_UNCORRECTABLE         1
>> +/* Bits for block_status flags */
>> +#define ACPI_GEBS_UNCORRECTABLE           0
>> +#define ACPI_GEBS_CORRECTABLE             1
>> +#define ACPI_GEBS_MULTIPLE_UNCORRECTABLE  2
>> +#define ACPI_GEBS_MULTIPLE_CORRECTABLE    3
> 
> So this maps to the bits in block status.
> 
> I'm not actually sure what these multiple variants are meant to tell us.
> The multiple error blocks example referred to by the spec is a way to represent
> the same error applying to multiple places.  So that's one error, many blocks.
> I have no idea if we set these bits in that case.
> 
> Based on a quick look I don't think linux even takes any notice.  THere
> are defines in actbl1.h but I'm not seeing any use made of them.
> 

I hope Igor can confirm since it was suggested by him.

It's hard to understand how exactly these multiple variants are used from the
spec. In ACPI 6.5 Table 18.11, it's explained as below.

Bit [2] - Multiple Uncorrectable Errors: If set to one, indicates that more
than one uncorrectable errors have been detected.

I don't see those multiple variants have been used by Linux. So I think it's
safe to drop them.

>> +#define ACPI_GEBS_ERROR_DATA_ENTRIES      4
> 
> This is bits 4-13 and the define isn't used. I'd drop it.
> 

The definition is used in acpi_ghes_memory_errors() of this patch. However,
I don't see it has been used by Linux. This field isn't used by Linux to determine
the total number of error entries. So I think I can drop it either if Igor is ok.

Thanks,
Gavin




