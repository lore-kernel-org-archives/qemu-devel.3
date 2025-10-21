Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13895CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEHa-0005zP-OT; Tue, 21 Oct 2025 11:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vBEHY-0005yh-R5
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vBEHW-00043t-9n
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761060492;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbrzgMo94ooAa/hP7tAvefYUfhTg/GV6LnkjfJ4a/hU=;
 b=DzMbwQ6UE6UNOmA17mO030bt2a9183eD3G+KkynWGerywz7CdT+VLJbSQB5WUr2oQlBcKm
 /CHn3R+CquiGaYSUCVjb3ACFtZbBQpmBOUyuz3RFiYY+rie70AuPmONB+Ir+ezr8voA8Sc
 yae2ttUyoot0IarCoBgMC1Jh4rsX44g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-e5jfnus6PVSrRYscxrcEfw-1; Tue, 21 Oct 2025 11:28:10 -0400
X-MC-Unique: e5jfnus6PVSrRYscxrcEfw-1
X-Mimecast-MFC-AGG-ID: e5jfnus6PVSrRYscxrcEfw_1761060490
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4721b4f3afbso14755105e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761060489; x=1761665289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mbrzgMo94ooAa/hP7tAvefYUfhTg/GV6LnkjfJ4a/hU=;
 b=dAk9Y1UqfBxqlrQ0gcBfgq64pc8VclAY4ZU+OUkDtVYzpjhJePeNyGV14Ua7+im90g
 J0JM1qO3M0W1Qu1PIgPBx9YBBi8oah+24BKHb5IpKEX8u9bxoWm8enu+ORKTtIwSP74t
 HHDbcoqltbzA8ScNPZA8yFxW4gGmcBANspjS9StmzJVdJgDa+5ECTOGxHEEYAh+J/Mwy
 kk/1c15MufOAIg67uTBtLAhg237Ygo2LSrpvZ0YZi4kEClizQ4lc3/LKdjai9AeZMaGF
 EizNdn8imaRXi7dFOAv/SXHkvTV1hB/fQXT5oVs4JrQdxG669fQxQRg9PjhB6hfOP1vo
 uv8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG8eV0ZGAuN5vu8RRb2iA4zhydVOyr/XlBwkby+GB4cUJoClJQ3qnQkNvXssYuNsrUTSFD4VPCiG3O@nongnu.org
X-Gm-Message-State: AOJu0Yw7pF0E66nSKHOcIF/jIzaNZnH1qR3KzB6l8m+Mccl6V5ADaBUX
 j3mPPkHy+kxwpjHLRGM0UkbM++CkTCEwJMg8K6OA/s5o0xqq7hTMCaSk59gb3CV8VUCD8aacSEO
 DxSyV1z2BxtH9JS4UU+SEMKs32blRZLkU8NbzfuOEhkYZiF7XTrjwTT79
X-Gm-Gg: ASbGncuIJhIVo/r1whB/SxuovDsnBw3Z05BJOklPEeB27jKMTXm8Q6e07pB4kc+p3Yq
 Q87zfj38IZsPxZZlbQ30gimq4EN1xXgG4a6x4TR9LoVNSe0/MFySfrnAybqk9jBomI+IfdNoaqH
 AdbVVhjLGnub2j8fBQwaNmoUqi5ABgnqZy+WEQLwyEuyEe28AtA0hUBAXy5scPlcIqeBF+XnoN2
 fS/b0rDfo3dLeBQWrKo0gwH9UBIz8Bnl2YgE4cUkMqZ75kc4qtzTiiLPp0m0IRNfTXvwdzzCv1R
 ihNcjXldjiFuHJhe/E7tsdhkvWRSlM/xfPkZpD11/hsPfAwsXhmViqfyZq8imAhnS7Bpiv5GvTa
 3nUPe
X-Received: by 2002:a05:600c:3541:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-4711791934dmr133225015e9.30.1761060489575; 
 Tue, 21 Oct 2025 08:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiEMgEdUK1kr3M17GRhS1inC/gUeQo+zbKZIJbu14Dbv7PX3rHQ29+tWi708fkbKAob6TmfA==
X-Received: by 2002:a05:600c:3541:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-4711791934dmr133224695e9.30.1761060489106; 
 Tue, 21 Oct 2025 08:28:09 -0700 (PDT)
Received: from [192.168.43.95] ([78.245.103.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3b45sm20985267f8f.11.2025.10.21.08.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 08:28:07 -0700 (PDT)
Message-ID: <8d87fa88-2b1c-4ae8-b4c6-89a788da4bcc@redhat.com>
Date: Tue, 21 Oct 2025 17:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3
 to vfio-pci endpoints with iommufd
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
 <b222848f-c933-43dc-b6e0-97dd8455cee6@redhat.com>
 <aPZ+i6Vgxww1OTTo@Asurada-Nvidia>
 <CH3PR12MB754822875EB806B9C5F6889EABF5A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB754822875EB806B9C5F6889EABF5A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/20/25 8:59 PM, Shameer Kolothum wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: 20 October 2025 19:25
>> To: Eric Auger <eric.auger@redhat.com>
>> Cc: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
>> Jason Gunthorpe <jgg@nvidia.com>; ddutile@redhat.com;
>> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> shameerkolothum@gmail.com
>> Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
>> SMMUv3 to vfio-pci endpoints with iommufd
>>
>> On Mon, Oct 20, 2025 at 06:31:38PM +0200, Eric Auger wrote:
>>> On 9/29/25 3:36 PM, Shameer Kolothum wrote:
>>>> +    /*
>>>> +     * We return the system address for vfio-pci devices(with iommufd as
>>>> +     * backend) so that the VFIO core can set up Stage-2 (S2) mappings for
>>>> +     * guest RAM. This is needed because, in the accelerated SMMUv3
>> case,
>>>> +     * the host SMMUv3 runs in nested (S1 + S2)  mode where the guest
>>>> +     * manages its own S1 page tables while the host manages S2.
>>>> +     *
>>>> +     * We are using the global &address_space_memory here, as this will
>> ensure
>>>> +     * same system address space pointer for all devices behind the
>> accelerated
>>>> +     * SMMUv3s in a VM. That way VFIO/iommufd can reuse a single IOAS
>> ID in
>>>> +     * iommufd_cdev_attach(), allowing the Stage-2 page tables to be
>> shared
>>>> +     * within the VM instead of duplicating them for every SMMUv3
>> instance.
>>>> +     */
>>>> +    if (vfio_pci) {
>>>> +        return &address_space_memory;
>>> From that comment one understands the need of a single and common AS.
>>> However it is not obvious why it shall be
>>>
>>> &address_space_memory and not an AS created on purpose.
>> We tried creating an AS, but it was not straightforward to share across vSMMU
>> instances, as most of the structures are per vSMMU.
>>
>> Only SMMUv3Class seems to be shared across vSMMU instances, but it
>> doesn't seem to be the good place to hold an AS pointer either.
>>
>> The global @address_space_memory is provisioned as the system AS, so it's
>> easy to use.
> We had discussed this previously here,
> https://lore.kernel.org/qemu-devel/aJKn650gOGQh2whD@Asurada-Nvidia/

Thank you for the pointer. I definitively missed that thread. Seems
Peter was not very keen either to use the address_space_memory. Why
can't we use a global variable in smmu-accel.c ? in hw/vfio/container.c
there is a list of VFIOAddressSpace for instance.
Is there anything wrong doing that?

Thanks

Eric

Eric
>
> Thanks,
> Shameer
>


