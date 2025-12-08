Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55C7D3B7EA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 17:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSesL-0001z1-SX; Mon, 08 Dec 2025 12:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSesJ-0001yA-W4
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 12:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSesH-00039T-LP
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 12:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765214292;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VL08V+9vqyEMIsPjsNaUawtDLNknNx/VuH+45FfUYxI=;
 b=SJPXYv7cxJQLtJZXkfBe4YVQa0F/XgAIPc52FgJE9hdDp4q14Ob1jpb5mNAc23gkz443zf
 jjFQdrJA5mviFuovAqfVw6fuIcwx1bLBLBULu6DGB/bu75fHAlVMVrD0Z7xhlbld+Ou5tq
 meDlYuUtXD5iHgJSpqAztfwicvSIMCc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-b9Zb4bnVPPW6dgXVzRZDFA-1; Mon, 08 Dec 2025 12:18:09 -0500
X-MC-Unique: b9Zb4bnVPPW6dgXVzRZDFA-1
X-Mimecast-MFC-AGG-ID: b9Zb4bnVPPW6dgXVzRZDFA_1765214289
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-bc0de474d4eso10375959a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 09:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765214288; x=1765819088;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VL08V+9vqyEMIsPjsNaUawtDLNknNx/VuH+45FfUYxI=;
 b=OXaQBKWUE2TkI24+QAclupFSBN3J9pZ2Ze5ST+vEtohQaN7EHeiV3Ed2JEjzEUNPAk
 zfze3jrBwvj0KVhBoqYOGYSlNc7u7TSvnPVBNwvby+JYGtESy7vZ+S3Y8xsNwFuWiUMM
 uY8Rq6dVC/E36TzeXxyykpoVxCWq56iOZ7xf4N9FVO+cbDQFboy7jXUrPQ7oIksduC/o
 bZi355pK+SqLAujmZByCbNhF8ZNuSLFoNxcc9I9VwlDQ1x/xBP03PJRiqhSyu+Hi65Fc
 vY6+BsKa1ZTX0nHwfsrifArJQzLpzsdm/nLQT9+KpD2vMJw3rI3i5KbXloV5mTEvYj3S
 omhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnKWxzU/QvfqPfpzjL+Q4ksU5JCSREghlOAzQookpUoSTBujJFF/C0fZybtXrvgXSRh+fOEcwZsZf+@nongnu.org
X-Gm-Message-State: AOJu0YwMq6UGNvykq/U8YxlDjnCVkLapYBl8CyLKY4bhBFCOwLK43qkf
 rhgWSKUFSqIBmYi41qQmlStiVlulQkWXIYsVy2iWnur3aTKnLoSjNX3aSYb8/hAQXZoNvoe+cKo
 mnOpchfh4hak7qpYm6Hw2FDjJ4vRJmOKYbbDnKXKI9bWTgVsTz9nyIiky
X-Gm-Gg: ASbGncv36KKaHhnP0FgIkd9QGOH3c+Z2gc+v75rrGcb/TkbM+RB75KQFWSaxHSePvTL
 6mE0yfRm0MlWZB8pisAPULE4w/La5EXSFF9Jou8mssKBWTxnxc+CwwoSMJRU+a9v2orl08Zf/FC
 zLJYYHly9lajJh+KlXu4mfM2VDwzjYZcPGSJ4bmbgps44sSqtmV2jz8Gf5DLNW2XxSolRK5MdXg
 lru3v9trYXUzkoypbviATJjgeboHUJbA5Np9iafhoLadHNANJpOdmnqhcy8q2Gg3DdflmhZPA2o
 zj10MTBCY7CcKDVfITVBsBajrviuuv182Gn7nnkmAcEGjVaTTfd6U95iR/Cqwd8ZKsKAGSkHW4u
 nijieabA7lUQMSs5B6ua3e+AcKDMYJoAyaTWvpYpJ44AbFMXQJ0VI5WbpYw==
X-Received: by 2002:a05:7300:d084:b0:2a4:3592:cf5d with SMTP id
 5a478bee46e88-2abc70f7864mr3708203eec.1.1765214288534; 
 Mon, 08 Dec 2025 09:18:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+EEe2PZWYlFKN+U88zJhICyFxgDpx4Q4wosJbE4lz+op2w66Q/GewNPwCJ9NFS+BsWZD9vA==
X-Received: by 2002:a05:7300:d084:b0:2a4:3592:cf5d with SMTP id
 5a478bee46e88-2abc70f7864mr3708185eec.1.1765214287991; 
 Mon, 08 Dec 2025 09:18:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2aba822b615sm35906621eec.0.2025.12.08.09.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 09:18:07 -0800 (PST)
Message-ID: <cda8507b-1cc9-41ab-96ff-b27159460ef1@redhat.com>
Date: Mon, 8 Dec 2025 18:17:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 29/33] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-30-skolothumtho@nvidia.com>
 <aR+MjODa6/XFlCqz@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aR+MjODa6/XFlCqz@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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



On 11/20/25 10:47 PM, Nicolin Chen wrote:
> On Thu, Nov 20, 2025 at 01:22:09PM +0000, Shameer Kolothum wrote:
>> QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits.
>> With accelerator mode enabled, a device may use SVA, where CPU page tables
>> are shared with the SMMU, requiring an OAS at least as large as the
>> CPU’s output address size. A user option is added to configure this.
>>
>> However, the OAS value advertised by the virtual SMMU must remain
>> compatible with the capabilities of the host SMMUv3. In accelerated
>> mode, the host SMMU performs stage-2 translation and must be able to
>> consume the intermediate physical addresses (IPA) produced by stage-1.
>>
>> The OAS exposed by the virtual SMMU defines the maximum IPA width that
>> stage-1 translations may generate. For AArch64 implementations, the
>> maximum usable IPA size on the host SMMU is determined by its own OAS.
>> Check that the configured OAS does not exceed what the host SMMU
>> can safely support.
>>
>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> ---
>>  hw/arm/smmuv3-accel.c    | 20 ++++++++++++++++++++
>>  hw/arm/smmuv3-internal.h |  3 ++-
>>  hw/arm/smmuv3.c          | 16 +++++++++++++++-
>>  include/hw/arm/smmuv3.h  |  1 +
>>  4 files changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 73c7ce586a..35a94c720a 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -27,6 +27,12 @@
>>  static MemoryRegion root, sysmem;
>>  static AddressSpace *shared_as_sysmem;
>>  
>> +static int smmuv3_oas_bits(uint32_t oas)
>> +{
>> +    static const int map[] = { 32, 36, 40, 42, 44, 48, 52, 56 };
>> +    return () ? map[oas] : -EINVAL;
> We should probably just:
> 	g_assert(oas < ARRAY_SIZE(map));
>
> -EINVAL is useless anyway in the caller that prints it.
>
> Otherwise,
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
With Nicolin's suggestion
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>


