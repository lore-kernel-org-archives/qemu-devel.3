Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0EFCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 13:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuW7X-0005hW-Au; Fri, 05 Sep 2025 09:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuW7U-0005gX-7M
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuW7N-0000RM-E4
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757077477;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dyeve++oj0PCnI7CU5T6k2ziHJ5mbvTXiAifvdXMaCk=;
 b=G99l9WyLHzMwwBWJvYngsURTgI0fyDffludniRENB2iH7+J3imgJM0pmsqvdsVWQLKMTxR
 MT71PZ/auxb9q53IiAGGyuv+EdTFFTPV6dADkx2J0D8rri6YIKePixj1jJcdRm0Kh05mYM
 oR3wJnmgGc+p9MGrpQXQsUhDN2RPlSQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-6px3w9juP_uif7Q_y4C7zw-1; Fri, 05 Sep 2025 09:04:36 -0400
X-MC-Unique: 6px3w9juP_uif7Q_y4C7zw-1
X-Mimecast-MFC-AGG-ID: 6px3w9juP_uif7Q_y4C7zw_1757077475
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b990eb77cso14010575e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 06:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757077475; x=1757682275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dyeve++oj0PCnI7CU5T6k2ziHJ5mbvTXiAifvdXMaCk=;
 b=Z8/j3avEwYoAEMO/THyFQi8ADmCftJw9VPWRSLFJwycbUP32q8LVR/Ae6a84tFsK7B
 yShLgWo7Uim+kbPB1VSs0IGEfexNdzAPyJPgyBC8lUwIyMulrjBrPbSBShMnSe/uHrZz
 EknekcPI/R2d+IJPGSok1WSJL3ci+Dhllpu34wt7vY5wd0j3dYjmNBWetcX+I8LKwura
 c9Zz6CHhS6NpSgFIS2YvCkl6unotjYcrX5S32crsg8F/scJ1T89zrCL/eTiFkiNP+6qg
 dDBVkqAsrowVaEjbaNYtJ9K2rluomwdvydVxv2N/diML55LMS693qiwh4Os0ng0WTPu+
 aFHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwVXN75FWMlktaY5ru9pFrTQp2qJGcWFjf+7RN2qD+r2MKg4Vz2kamFToWaoBZFPNi4bwtOD1FG/ar@nongnu.org
X-Gm-Message-State: AOJu0YxT1Z3hhEXrgaUxBnCYTpTYCRB1DUrZc4F+xttyB/2sLKNjTAk2
 nlNrsfO3vkQWEa2NE5hZMO0ekMTZk3KoGHw0I7KYoo36uIw46OMzBfmeM8/zxHpKEGn2eNR7pLp
 4hBTID6yUwmfIwavDgTcwmaG6VY+RRA+TxyG18dQlx4UMqoIFC+pQcLQP
X-Gm-Gg: ASbGncvL7mCd5Ddo3iO7Q3CNmDgcz/QFmQ8ScReUdv2vZ57BpoBuRUdFZoaUlP4OUqE
 Dd/ulYU2Y02kKm3x5y2ZuCDpmEgL0kxrmZTpn+QX3Xur+97xb1E/FqLw/OdXPws5l1AR+YQIPjK
 Aqc8LIDbBxJpNbinMRZO10ZhpePcOFZ0ZkHpZRNfYfMRVDzqQH5Lfwi305vcwUjCFPSSYOwXZ6d
 HuEDA1DysWQoc2l5PO20iW2bhyeWzjNNi9mrDgoAUxQWJc9kZLW2x/nWaHanRW1rKYWfJ5YenEW
 0mCPSnHq/Y//G5z/TDUkwyEvWrD0iQTXJgssqMesKUfjJFvRNbX3DaKFvIb357xjsQMK7pIscre
 ObON4JKcTn7I=
X-Received: by 2002:a05:600c:4746:b0:45c:b642:87a6 with SMTP id
 5b1f17b1804b1-45dd5aa03ccmr31597695e9.0.1757077475265; 
 Fri, 05 Sep 2025 06:04:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQrDW0V369DKSpe86zQrU0Ynuw1yVekNA5wS/HtixNoWrhyU3gGEBKPujq0aXDW2YwM65aig==
X-Received: by 2002:a05:600c:4746:b0:45c:b642:87a6 with SMTP id
 5b1f17b1804b1-45dd5aa03ccmr31596695e9.0.1757077474381; 
 Fri, 05 Sep 2025 06:04:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7fec07sm319466755e9.10.2025.09.05.06.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 06:04:33 -0700 (PDT)
Message-ID: <73390abf-bb75-4e0d-886d-7879a01f2aba@redhat.com>
Date: Fri, 5 Sep 2025 15:04:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, shameerkolothum@gmail.com
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
 <aHcVNYtd9qe+sHAT@Asurada-Nvidia> <20250716115123.GW2067380@nvidia.com>
 <aHfi3SS/V6qlx77H@Asurada-Nvidia> <20250716174506.GB2177622@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250716174506.GB2177622@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

On 7/16/25 7:45 PM, Jason Gunthorpe wrote:
> On Wed, Jul 16, 2025 at 10:35:25AM -0700, Nicolin Chen wrote:
>> On Wed, Jul 16, 2025 at 08:51:23AM -0300, Jason Gunthorpe wrote:
>>> On Tue, Jul 15, 2025 at 07:57:57PM -0700, Nicolin Chen wrote:
>>>>> +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN4K);
>>>>> +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
>>>>> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, val);
>>>>> +    }
>>>>> +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN16K);
>>>>> +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
>>>>> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, val);
>>>>> +    }
>>>>> +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN64K);
>>>>> +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
>>>>> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, val);
>>>> Unless there is some conflicts between the QEMU emulation and the
>>>> SMMU HW, I think we should probably just override these fields to
>>>> the HW values,
>>> The qemu model should be fully independent of the underlying HW, it
>>> should not override from HW.
>>>
>>> It should check if the underlying supports the model and fail if it
>>> doesn't.
>> For every bit? If there is a conflict at a certain field (e.g.
>> VMM only supports little endian while HW supports big endian),
>> it must fail.
> Yes every bit.
>
>> But here, I mean for these specific fields such as GRANxK and
>> RIL (range-based invalidation), we should override them with
>> the HW values. Otherwise, the guest OS seeing RIL for example
>> will issue TLBI commands that the host can't support. Right?
> No.
>
> If the SMMU model does not include RIL then RIL is not available to
> the guest.

For virtio-iommu several parameters are dynamically computed: the pgsize
mask, the aw (using ReservedRegion info). They are computed according to
the assigned device requirements, if not conflicting with anything else.

For instance you can have a look at 5c3cfe33f418 ("virtio-iommu: Set
supported page size mask"). I don't quite remember but intel-iommu might
also have such dynamic settings depending on the host.

However I am unsure we enforce the computed granule/aw on dest (VFIO mig
was not supported when the feature were implemented). as this is part of
the device config it may be but it would be worth to check.

Thanks

Eric
>
> If the SMMU model only supports GRAN4K, then the guest only uses 4k.
>
> This exactness is critical for live migration. We cannot have the IDRs
> change during live migration.
>
> So there should be some built in models in qemu that define exactly
> what kind of SMMU you get, and things like if 4k/16k/64k or RIL are
> included in that model or not should be command line parameters/etc
> like everything else in qemu..
>
> Jason
>


