Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0E7CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOBC-0000BJ-PM; Mon, 27 Oct 2025 10:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDOBB-0000Ah-0I
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDOB5-000617-4S
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761575179;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNo+7U08zeZ1t/qGpXrtxPjo3ELlZLKLF79nlbKmt2o=;
 b=BpS2eRWFPaIT0yF6ubay6U4925QtXDwzXjubrXfuITw/3FObCZAnEj9EI+r6nWbDjmqMy9
 anz6XtAPvvg8NHehqSVfOJ2wj3A8b7Z7f7GAAnk4HiEuQMmaZBSCXeVGrRuVTiaI8RvT19
 bRBB1OnoI1ykGR9APP83hQ8XxyjVTsI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-9CHDFGbENFiBReWr6fvhYQ-1; Mon, 27 Oct 2025 10:26:18 -0400
X-MC-Unique: 9CHDFGbENFiBReWr6fvhYQ-1
X-Mimecast-MFC-AGG-ID: 9CHDFGbENFiBReWr6fvhYQ_1761575177
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477113a50fcso11945385e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761575177; x=1762179977;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nNo+7U08zeZ1t/qGpXrtxPjo3ELlZLKLF79nlbKmt2o=;
 b=kGBXlfvk1qAH1axlvSXx2vmI649n1SJ/+tlTxgGWdSPepACOmU/msNooLKX93ZjKzS
 izWLdEUZsun61RbJJUGkbZm5heGYocGF80FItAj5YhHDpzcOoOj+1/N2m8sV9gQMh1Ci
 0FVstSM9U+wAzz3fWbttGReV8Dd7zgZ6sQVsg1NLqYkpb+EVwm4UHEJnl9fJIXa0ptR+
 I3oROf3kUFj84nNyvm+GeAdukKIt1VR6twunRNkwkdWm/kkkzwsDKTEBPheRSvC6MTfO
 P3+9qvpX6zsvJwJPyhYQIwJ/f1Cm9+SrAmRIOSh/hgFRAyho37/Dlr86CgC+Orj+dWxV
 r/Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG/ua7ZseiM1XeWtaRAy1h0Q7KfAIgg5wrHZ5qCrxDxBElurAglD2rGFnuwnNXq2xyZy4UotWrNpDR@nongnu.org
X-Gm-Message-State: AOJu0YyHsYN3WUQYQAoeJ9bQULbhFxv0RWQVk7em09rTspxVyv8b9d2b
 dqGmfMH0kgq/4Pjfs1Pi4fRMuonCThkT8eCaA9HHUUfkj98lMs+j/OMUMV4nebfJoHWr3dljCpR
 SOnYrIAQyq+c76/cAMWTf/JDwjrB7v0gPfzj7nQqrVYolDFqmjQaaiHFq
X-Gm-Gg: ASbGnctUMVdp2itLZoUaLA0nXsf+BXWVUQ2NbMsy9rJqC1Y/nkIU4XxiTkpWdS91Li+
 9gb+Ym64BwtvJ5c3R2gdqEYR3p6GrnBzmhyKY3EEor8r58uR8fOBxiYeSJAeHlR03oeTf7fuQ9i
 t1dLZVhovJ6VyrPlh/VVv+u8ER9XlZ5MJyWIQTptpRSyrtddfzZQdyWluQKM+bWshY0WaLmw2HL
 Puny8daWlQTngBEE664zLlRgq7ExCvy/phPgQiMPZXXrJ2H2CLYT38y+2rBbAm8qfYhsCD/wTn7
 +pt3ultlU5foiKUQIa9ijZ4zmBrzXILwWNdfVYfil/1IHLZ6h9CRu+M0/MAkFSVVct27c0jhitq
 oysWKAsrrXa/vYiaKNRZngqgAQuhc7+voTN0eH3kfLt11ag==
X-Received: by 2002:a05:600c:3488:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-4711786c586mr278417655e9.1.1761575177067; 
 Mon, 27 Oct 2025 07:26:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFKV5fwmYY/onkm0PCR9TuoYxaemxfRUL7rWK2Cl+CRsuyuTkmcOMK2wgJxviM01qagVNIsQ==
X-Received: by 2002:a05:600c:3488:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-4711786c586mr278417255e9.1.1761575176634; 
 Mon, 27 Oct 2025 07:26:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd042499sm139643985e9.8.2025.10.27.07.26.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 07:26:16 -0700 (PDT)
Message-ID: <76ce5b05-98fe-4682-a5ca-2f87b7535f35@redhat.com>
Date: Mon, 27 Oct 2025 15:26:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-20-skolothumtho@nvidia.com>
 <aPF9l5GwctGN0tqT@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aPF9l5GwctGN0tqT@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/17/25 1:19 AM, Nicolin Chen wrote:
> On Mon, Sep 29, 2025 at 02:36:35PM +0100, Shameer Kolothum wrote:
>> When the guest reboots with devices in nested mode (S1 + S2), any QEMU/UEFI
>> access to those devices can fail because S1 translation is not valid during
>> the reboot. For example, a passthrough NVMe device may hold GRUB boot info
>> that UEFI tries to read during the reboot.
>>
>> Set S1 to bypass mode during reset to avoid such failures.
> GBPA is set to bypass on reset so I think it's fine. Yet, maybe the
> code should check that.

shouldn't we check its actual value before setting bypass?

By the way the spec says is ABORT is set to 0x0:
"Do not abort incoming transactions. Transactions bypass the SMMU with
attributes given by other fields in this register."

Wondering about those attributes and they can apply on the host?

Eric
>
>> Reported-by: Matthew R. Ochs <mochs@nvidia.com>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> ---
>>  hw/arm/smmuv3-accel.c | 29 +++++++++++++++++++++++++++++
>>  hw/arm/smmuv3-accel.h |  4 ++++
>>  hw/arm/smmuv3.c       |  1 +
>>  3 files changed, 34 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index defeddbd8c..8396053a6c 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -634,6 +634,35 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>>      .get_msi_address_space = smmuv3_accel_find_msi_as,
>>  };
>>  
>> +/*
>> + * If the guest reboots and devices are configured for S1+S2, Stage1 must
>> + * be switched to bypass. Otherwise, QEMU/UEFI may fail when accessing a
>> + * device, e.g. when UEFI retrieves boot partition information from an
>> + * assigned vfio-pci NVMe device.
>> + */
>> +void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s)
> We could rename it to something like smmuv3_accel_reset().
>
> Nicolin
>


