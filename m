Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C446C35FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDmo-0008Pl-JK; Mon, 17 Mar 2025 12:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuDmh-0008Ox-II
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuDmX-0003yY-Ks
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742230656;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jn0mL8Uy/CFPQop64/UetnBCUzfjhxm2sPZVA0oO3aQ=;
 b=jNTNIdy9qGJRIuYRHlXsns3Nr8XXkSUPFJ8lSyX0gnes48E8LD5wy0w4r524egeKV5LnC/
 zYYi6CAVgtMeM6xZfYi1CNI/xHelAePtsLWnJWxAIMp7r5Fx3+i7scaG5dxOb3FECWOp8/
 4773fyZpBjlQbNdBOx+SS0s2Mo/cG1g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-QraY0K1-O9axAIV5rBd04A-1; Mon, 17 Mar 2025 12:57:34 -0400
X-MC-Unique: QraY0K1-O9axAIV5rBd04A-1
X-Mimecast-MFC-AGG-ID: QraY0K1-O9axAIV5rBd04A_1742230654
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c0b0cf53f3so782874985a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742230654; x=1742835454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jn0mL8Uy/CFPQop64/UetnBCUzfjhxm2sPZVA0oO3aQ=;
 b=FlXlqBXirbL+oAjFS/O9hJiat0J8VuPjjLzh9jlHi3qRwKtFvByFdJqik3mGi7xJWN
 5miFu6BEtDq+KKGwlMfpE1vIsKuHNiXFS0CzFunQ7D+cmU8jwufD9bUtzjNdVzc8wn5H
 Gvi/HFQ8CD+7uYNjl+CjvawhKqmrhr0KAXZcbIhKJ5wX5DOLhXfdZWCdWzSsu4Pf+rNx
 XnZ+asT/x1lHAyHLhcEIMlQs8pWDiv/pWiZmtbs2NH8FCH0FDvceudsQHk9WUIQaPPQH
 9J1KM9XFr90Ho12V70Mh7/s2iv5iuImyzKnVYtlK7Y0ocM02vgQD1M3FwAFZsbbEzewN
 neuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGetM6VHzc9Z2yFh/sjrNivD/Wlcur4qvQFqQSfw9g/qPe+ylBYie5BW5brbp+gxLQgbrCNLJKcf6G@nongnu.org
X-Gm-Message-State: AOJu0Yy+CWKc4VI8ncR4W3aQMO1T2RX2CShbHTi+qXWpaLQ02WuS+D0y
 GfFrHT7YEI3q4NAcjUCuHasDfDZiZVe/oGkjougWbpAvepn+8iKK+Ic21ECXR8cqyrebd3mZxvI
 50UpBdY0O3fYmEaRjGYML1rvxLBAlUXynoeiCxV+knfhYmWyB18l4
X-Gm-Gg: ASbGncv0wAEmm3dbr9kUSWqBt9APFUSPkjcOrKxZfOtMHjEKd2RO6cpYXL3aE5DPInX
 Q+VsacVQC6T56pN0P3xzQPcNNuSllRdZk3gqUPr6Mj7kpZF9AKachp9gLi4XqyTcYYKV/fdseoP
 g0PMsUWQDnLEJYUwblkwXMIm3V6rTNruiyjYzSgt/imybvxB+kRFbMJPCi7Y0eFIOMXB6UjfjpL
 NibHhUxLw99aDoGdmnuYvvqvUdNfIOXV4uOWGlzM+GVvo4PfeAudd5cVRE495jODVTJdwJZMojj
 EDZxH+1TGk4a5w2+n/zxcaMm0hUmbh3+wxCoLUUB3QsMqJ/U99X6G94rY7aoMmw=
X-Received: by 2002:a05:620a:404b:b0:7c5:7a1f:4d89 with SMTP id
 af79cd13be357-7c57c8fb866mr2432198085a.54.1742230654043; 
 Mon, 17 Mar 2025 09:57:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHAQ3SGGtXwihM2GgDDujTj2QAon9EV4DbjHRV6c7ir0l1RMsBwo4Oc5rF0734w+wXjkvM6w==
X-Received: by 2002:a05:620a:404b:b0:7c5:7a1f:4d89 with SMTP id
 af79cd13be357-7c57c8fb866mr2432194485a.54.1742230653756; 
 Mon, 17 Mar 2025 09:57:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c4dd9fsm613080085a.4.2025.03.17.09.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:57:33 -0700 (PDT)
Message-ID: <829ec481-b380-4d41-b441-0c4ee81ae1f9@redhat.com>
Date: Mon, 17 Mar 2025 17:57:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <79bcc36c-1a12-4b18-a54c-afe734d6bef0@redhat.com>
 <9ffee8119fc441aeb760073c5f152fa4@huawei.com>
 <5fcaf9ee-4c95-400d-a641-20e0f17be87b@redhat.com>
 <c0048ea814ed46278804621753a3a78c@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <c0048ea814ed46278804621753a3a78c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 3/13/25 9:22 AM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, March 12, 2025 4:42 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-
>> pcie bus
>>
>>
>>
>>
>> On 3/12/25 5:34 PM, Shameerali Kolothum Thodi wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Sent: Wednesday, March 12, 2025 4:08 PM
>>>> To: Shameerali Kolothum Thodi
>>>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>>>> qemu-devel@nongnu.org
>>>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>>>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>>>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>>>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>>>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>>>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>>>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a
>> pxb-
>>>> pcie bus
>>>>
>>>> Hi Shameer,
>>>>
>>>>
>>>> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
>>>>> User must associate a pxb-pcie root bus to smmuv3-accel
>>>>> and that is set as the primary-bus for the smmu dev.
>>>> why do we require a pxb-pcie root bus? why can't pci.0 root bus be used
>>>> for simpler use cases (ie. I just want to passthough a NIC in
>>>> accelerated mode). Or may pci.0 is also called a pax-pcie root bus?
>>> The idea was since pcie.0 is the default RC with virt, leave that to cases
>> where
>>> we want to attach any emulated devices and use pxb-pcie based RCs for
>> vfio-pci.
>> yes but for simpler use case you may not want the extra pain to
>> instantiate a pxb-pcie device. Actually libvirt does not instantiate it
>> by default.
>>>> Besides, why do we put the constraint to plug on a root bus. I know that
>>>> at this point we always plug to pci.0 but with the new -device option it
>>>> would be possible to plug it anywhere in the pcie hierarchy. At SOC
>>>> level can't an SMMU be plugged anywhere protecting just a few RIDs?
>>> In my understanding normally(or atleast in the most common cases) it is
>> attached
>>> to root complexes. Also IORT mappings are at the root complex level,
>> right?
>> Yes I do agree the IORT describes ID mappings between RC and SMMU but
>> the actual ID mappings allow you to be much more precise and state that
>> a given SMMU only translates few RIDs within that RID space. If you
>> force the device bus to be a root bus you can't model that anymore.
>>
> Do we really need to support that? What if the user then have another smmuv3-accel
> in the associated upstream buses/RC as well? Not sure how to handle that.
Well I agree we would need to reject such kind of config. Maybe we can
relax this requirement and connect the smmu to a root bus (including
pci.0 though). Then this SMMU would translate all the input RIDs. This
is not as flexible as what the IORT allows but maybe that's enough for
our use cases.

Thanks

Eric
>  
> Thanks,
> Shameer


