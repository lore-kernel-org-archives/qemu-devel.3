Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFC6CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTUy-00086r-Vd; Tue, 16 Jun 2026 09:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZTUq-00086K-4A
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZTUk-0008L4-Vn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781615170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xryuPSpS6+SSpJbBxSLGRCfvs1sPVE0E4bx5TQ25MzY=;
 b=JnyKI2kxUkkvCaNcqJ1VWxqvTtCs+6yj3RJQNPaP8tjnA8/4eYEVSqhjiSpgPNj1YjldRj
 DH/BJJYWICpmNfQoVz2edg+PHlL2I6lIfHLkBXpr5aMF8WMX1A9Zn8n5nNGRMDJ5QtOD5p
 BrKjBFGrGa23CmzmZ3PIqFQvfbdrBh8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-2wBakOJXM5OY5N9pXgp9Hw-1; Tue, 16 Jun 2026 09:06:09 -0400
X-MC-Unique: 2wBakOJXM5OY5N9pXgp9Hw-1
X-Mimecast-MFC-AGG-ID: 2wBakOJXM5OY5N9pXgp9Hw_1781615168
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aa7a510fbdso3240482e87.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781615168; x=1782219968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xryuPSpS6+SSpJbBxSLGRCfvs1sPVE0E4bx5TQ25MzY=;
 b=tOhMbcwFEgW5jXdJQc9N4P4K01dqywPfusFhu3sNcpCKUODFSO6EM+Pj2OuH5FA5yW
 KStff9uV39nghIgkqNQWRzmFMGiFzgpnoyijeeLdTAkI2RVYwUvUESjYF4RZJSRPaH+A
 u9K20LUy6TFXcIOomzERHc52scqDFvfsYuPRZ2VNEI6pKABWb92v4YRt5d4F69T4GQ5h
 MPBMCcN47eRa7YGgmBlG7NpZhKBdLpkMRviYtsQX/JEof/K3jw6QStlURWpzgoLUQHQh
 otBkgTYdm/M1KYtASWu0VYg3OZKjSqwEbbfKxNSfZJq2KI18Aj407ATGQFIfrHadj37Y
 /KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781615168; x=1782219968;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xryuPSpS6+SSpJbBxSLGRCfvs1sPVE0E4bx5TQ25MzY=;
 b=rPaan+wC/kqcYfh1Ruj9Mpi89CTbALO+h5GiuUgCl+2TQ1Qfap4GiqwoN4WLNETz9s
 5QdJj7u5pNlvnmTZS+8q3jk8aLE2e9kxjBbiCxst61zUUp9H/E5GYmygMCtjWLsOu6Pp
 WbQ+I7EDkV3srVbbl4oyg4T10mtExJH8xM2thOUFQrgqejPYS27oeW6fxYGYlnH7yZau
 8vG1GEiMQh8qrIm/7Ga/PBjH2oDZNh3BFLkMr5NHkIPLx7NZOcnabWR6jdccLzsqmSDi
 Pie1vF9MBkPL7GO+OAlogW2uI2/FwbaBEyqcevk2WUJOiWKTEDCAgsjhSmbGKvoUsfX8
 cG2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eCnlwQm68TpSQNcnwIpTBw18DEu/FBUOoD4naDQSGihQSbe94kR5T1H4ebVQLQixcxXd4K/cC+Axq@nongnu.org
X-Gm-Message-State: AOJu0YzY05P5cJUrJ9TYMLlqmxUiJ1yxaTNMh1O8QyMkzFvGdTTzp4sd
 +KYfQjU5SRSaC16ybBn5+0QHDKDUurU02vSUTCpffv/xwAV3z3VtMJJHeS3pz2hDogtpsAOPt8f
 U540lX6cViHd1UVXSD6vQGfQkEX78pRrH4ETxSPbJ4eae/7VBBUc4/F8D
X-Gm-Gg: Acq92OHnJ6MWRcYjnrGS+VmHPDyiEKO4IZQX8c2mARgAkKuXuNVZVJIOrJksTzXpYqY
 CZm/lmydZYODTtpI3N4PUE4afn2fiUnF/jTiw6P51LiRhaFleeILextgJQFGXqqY911Yqg59cIF
 8B8M1ptrW9WgsbdtU8QFm4IUb30IdWtGBPkFuLykHw2YD2KypDQPZSfHIMi/WZZQYE1l+Ls9yDL
 Islm3ogsJGbb86tjHBNKSlOYtjoDv70L2Nagu/0ICUKjayfnjQVXxE5WoghndOn7H2v/Sp8V1Xf
 AfDU3HKCNoLu1+NaKwQcndmzqj/VMap4+mS94ZhXl+uXbkAeQSbcmlHf2bksfX7x9wEugx2ZR9C
 LLZEdyhygdkczYhbFFBczE/Ukojq7paHT7u9f9aSKDrM7wGgxb6BECfyOg3i/
X-Received: by 2002:ac2:50b6:0:b0:5aa:5c69:42f6 with SMTP id
 2adb3069b0e04-5ad4375eb7dmr904228e87.42.1781615167337; 
 Tue, 16 Jun 2026 06:06:07 -0700 (PDT)
X-Received: by 2002:ac2:50b6:0:b0:5aa:5c69:42f6 with SMTP id
 2adb3069b0e04-5ad4375eb7dmr904202e87.42.1781615166784; 
 Tue, 16 Jun 2026 06:06:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e169038sm3517919e87.18.2026.06.16.06.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 06:06:06 -0700 (PDT)
Message-ID: <2e3e119b-3068-4899-8486-60f5986c603a@redhat.com>
Date: Tue, 16 Jun 2026 15:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] vfio/pci: Warn when ats=on but host device lacks
 ATS cap
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260615204849.3659647-1-nathanc@nvidia.com>
 <20260615204849.3659647-4-nathanc@nvidia.com>
 <317cdabd-b4a0-4ef8-b65e-f2b5d7456cd3@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <317cdabd-b4a0-4ef8-b65e-f2b5d7456cd3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/16/26 02:42, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 15/6/26 22:48, Nathan Chen wrote:
>> From: Nathan Chen <nathanc@nvidia.com>
>>
>> Emit a warning when ats=on is requested but the physical device does not
>> advertise ATS, since ATS cannot be exposed to the guest in this case.
>>
>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>> ---
>>   hw/vfio/pci.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 0f592ada89..49ba6813ee 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2592,6 +2592,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>>   {
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>>       bool pasid_cap_added = false;
>> +    bool ats_cap_present = false;
>>       Error *err = NULL;
> 
>          ^^^^^^^^^^
> 
>>       uint32_t header;
>>       uint16_t cap_id, next, size;
>> @@ -2680,6 +2681,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>               break;
>>           case PCI_EXT_CAP_ID_ATS:
>> +            ats_cap_present = true;
>>               /*
>>                * If ATS is requested and supported according to the kernel, add
>>                * the ATS capability. If not supported according to the kernel or
>> @@ -2699,6 +2701,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>>           error_report_err(err);
> 
>              ^^^^^^^^^^^^^^^^
> 
>>       }
>> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_cap_present) {
>> +        warn_report("vfio-pci: ats=on requested, but host device has no "
>> +                    "ATS extended capability");
>> +    }
> 
> At a quick glance vfio_pci_add_capabilities() should pass its @errp
> to vfio_add_ext_cap() so the latter can propagate any error instead
> of calling error_report_err() or warn_report(). I note this is
> pre-existing and could be cleaned later, IMHO the sooner the better
> but up to the maintainers.

It would be nice to have and can be done later. It's not strictly part
of this series.

Thanks,

C.



