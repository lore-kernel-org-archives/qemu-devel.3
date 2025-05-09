Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCE4C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 08:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDJL8-0000Ou-SB; Fri, 09 May 2025 04:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uDJL7-0000OT-Ng
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uDJL6-00063X-6w
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746780254;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fBHynceJcsqRDfScd6aML6WkopdCdLRM/8UguPER3JE=;
 b=eIpUq+oYsYY9LyaqZRBlVm3r6PWQPZSERp247jtEEuyRuhunp4QE8WnY6iQYYnDhlAjW1E
 f4RWbegDLidmKWcNIjWgwobYwnllTu4LBG/3El1mB5GHXDsD4/7puBx7HHP1HhCiyo6aHv
 ub3GqIlAsUXk2eMCrSy1wa18EzeN7is=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-F2IFofT7P4646O8GQTiYsw-1; Fri, 09 May 2025 04:44:12 -0400
X-MC-Unique: F2IFofT7P4646O8GQTiYsw-1
X-Mimecast-MFC-AGG-ID: F2IFofT7P4646O8GQTiYsw_1746780252
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so10204095e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 01:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746780251; x=1747385051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fBHynceJcsqRDfScd6aML6WkopdCdLRM/8UguPER3JE=;
 b=YJNBVV3UzrSmuTHJrXxvcdReDGy/Vh9pzQB0T8xGYSt1zTjYEiWPgomOrSZeD9b4tN
 GLlHwbo0MH+dPZSwXGs+Z5/VvO8sjQSnYMNKjqaf8tTz9RQgNHx7TdkmupzBskVINmyB
 9Xrb7sJYBrwnQ8kQOthnafXeM2M9i0aq1V3YJXvg0lduJEEAbo/oemcawQ8Guk3YlRC7
 i4MhvDPvIvhC7lJG2LV+87FKMwrh3nlWYodmE7srG186Mr/+kZiM9ULBVcSeiXu0ToPZ
 ZxLfxM2liL7jWjn4TMour9IRIP+D5BhFMra2fpg439kJdGiNomj5RgAR9nqOiGhr3pVy
 Y1yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqf8kgL6YJj9t+Sl/54kGfRK/42L+Gu8jxxdUNGU1HAXJdOjTL7e8ZQlVMt8w0odG6etB5cdplj1L0@nongnu.org
X-Gm-Message-State: AOJu0Yzd627DD6YbOThN5kaJHewo57wUzTbcPX6t2RvBG2dr05YdRc/o
 Vrqp0/WqCmGy9Z8ZqYD/82Lw0OzypoEIDI2K+2YvSaAXEeTW0nBtcmpSSQHDvrfJfy+LEb4qiJl
 JP2O7spHtICUpKb674kWFTQUAXY/EwgCg0qhJmyLgnkpTFLOPspAZ
X-Gm-Gg: ASbGnctSVhTYe1oa3fEmdbJo5Wy3cpKR13AAYWVmcf6c3Bi54eSdI3i+fI4TOdPsWmx
 YxXReLP9lHWYu/Ip9uY+cQMGDpjyvx5/R/lNL2uAONlAAfRiBMsjCYTTEg9FeI1Mxoq6Uur+MSd
 d/m54oD+x6NxCzmCQqS2oilGJC7ifMBPy2yFYcuDqu9hyNMqA/SCJ2yHn1R/dDqZrtJji17jqEg
 sSEWQaF414K4WwmEFP4aFFoB2i9QS5D5EAtmIFeXF5PmxN4sBx4dKsjWWft/nghvO6DH0Z0sG8m
 abN1MoPRAhDgeDDC2wLGgK5s7A0nMVYTWgIgnJi8vOpPYTWUQhgnYPs0fvg=
X-Received: by 2002:a05:600c:3f0f:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-442d6d5d9e3mr16938755e9.18.1746780251593; 
 Fri, 09 May 2025 01:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEChzWtfrmEIKFq5vfDwtSQjINwMLBaue4MEyEeAltt3mJvqwbjm9tLuCR8aWRSjfUdoiPqFA==
X-Received: by 2002:a05:600c:3f0f:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-442d6d5d9e3mr16938485e9.18.1746780251227; 
 Fri, 09 May 2025 01:44:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb79sm64005565e9.27.2025.05.09.01.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 01:44:09 -0700 (PDT)
Message-ID: <39e01728-f0a1-4a2a-ac35-0078b7289314@redhat.com>
Date: Fri, 9 May 2025 10:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Donald Dutile <ddutile@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Shameer Kolothum via <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
 <87frhglwjl.fsf@pond.sub.org> <72f9043a73294bfc9b539ae9b94836d3@huawei.com>
 <d21e0c57-b89a-4c79-958e-e633de039e4c@redhat.com>
 <c0ab36fc56ff498196b359f5aee3746b@huawei.com> <aB25ZRu7pCJNpamt@redhat.com>
 <5b46c81a412f410494f28a2f9ebb9430@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <5b46c81a412f410494f28a2f9ebb9430@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/9/25 10:18 AM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Daniel P. Berrangé <berrange@redhat.com>
>> Sent: Friday, May 9, 2025 9:14 AM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: Donald Dutile <ddutile@redhat.com>; Markus Armbruster
>> <armbru@redhat.com>; Shameer Kolothum via <qemu-
>> devel@nongnu.org>; qemu-arm@nongnu.org; eric.auger@redhat.com;
>> peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a
>> PCIe RC
>>
> [...]
>
>>>> - bus pcie, id=pcie.<num>
>>>> - device iommu=[intel_iommu|smmuv3|amd_iommu], bus=[sysbus |
>>>> pcie.<num>], id=iommu.<num>
>>>> [Yes, I'm sticking with 'iommu' as the generic naming... everyone thinks
>> of
>>>> device SMMUs as IOMMUs,
>>>>   and QEMU should have a more arch-agnostic naming of these system
>>>> functions. ]
>>> Ok. But to circle back to what originally started this discussion—how
>> important
>>> is it to rely on the default "bus" in this case? As Markus pointed out,
>> SMMUv3
>>> is a platform device on the sysbus, so its default bus type can’t point to
>> something
>>> like PCIe. QEMU doesn’t currently support that.
>>>
>>> The main motivation for using the default "bus" so far has been to have
>> better
>>> compatibility with libvirt. Would libvirt be flexible enough if we switched
>> to using
>>> something like a "primary-bus" property instead?
>> Sorry if my previous comments misled you, when I previously talked about
>> linking via a "bus" property I was not considering the fact that "bus"
>> is a special property inside QEMU. From a libvirt POV we don't care what
>> the property is call - it was just intended to be a general illustration
>> of cross-referencing the iommu with the PCI bus it needed to be associated
>> with.
> Cool. That makes life easier 😊
Agreed ;-)

Eric


>
> Thanks,
> Shameer


