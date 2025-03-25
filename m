Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80F1C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 18:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx9Oz-0006V0-2o; Tue, 25 Mar 2025 14:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tx9OS-0006J3-Ik
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tx9OP-00033d-VZ
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742928772;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2nockOg3zdTf/hhPbJxWUhqz8HpUAhJJIn5SUZ5DFY=;
 b=AMC+cL5IolwbOTJNUx7oSFistGX8SjTX3nKlgbF7zjpdTkCGeuF64bJQR9PgazyUFIi0IH
 05OsJaMvUuB5j8u3sAXAnRrYfYX9L88prA6PaRbtNMUK9/HTP6Oh/wdyy/0b+/Vmxi/lBk
 nj5/cJaoW0Ex8l8iFKBDTe5PpPcDfkE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-z2m2w75pOFW83QL9pZENZQ-1; Tue, 25 Mar 2025 14:52:50 -0400
X-MC-Unique: z2m2w75pOFW83QL9pZENZQ-1
X-Mimecast-MFC-AGG-ID: z2m2w75pOFW83QL9pZENZQ_1742928769
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391425471ddso3492335f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 11:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742928769; x=1743533569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W2nockOg3zdTf/hhPbJxWUhqz8HpUAhJJIn5SUZ5DFY=;
 b=iNdZVMXu/HTm/eePd5+jMZ5uwiTTSrBz0ANSLLsGTnJ8LRg4ipGz0aE33+m7ZB+qD6
 ZIZ09kmIr5X40P7S8LDOOdrhkfWYdD/aAMiwqIOCo3BEjj4mu+xHPxRQ/fyzFc/FTPxL
 ywKuJPRDVSa0LdA7Ci448kTtjrqaUkdzgPNb4mb2WwByU2ucuZ2eSrB/XgtpH/mL6QHU
 pKRI1As3GPP2yRmsov0KS7WeSBo86bg9ANIZ4Yg8dxQK2ZSWJyPNrQ1q1d1dV+1x/8RF
 0Z15sYybTh5DteMTCbWzPceErL7TBLMQOWPsISuXxnLBXbB89LDv57bMaSI1BgLqEJa4
 OeqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTHON6GQ2r+5FykE2L1h46mb54lDOotog5trWo3lcarDpRoyFCFL47r5xEW0a/2erDFwanRbMzsQ34@nongnu.org
X-Gm-Message-State: AOJu0YwD2INh1fWcDlh/vvsoxv+dFIYDsLYlqOUNjqFlNMta8MSgj9Zj
 t6iZJfqa7dXRUyb8Dkj5QHeHKR/YvY3V6J3l6LOLGdRcI+Z8pqDjiIrlWV8sFkqpwZg0DJBgVB/
 IS0qLUkRvl5HHZqgt1Luousb7tmuvO1eCsgP78/Ii5VOpFqfiWPaW
X-Gm-Gg: ASbGncuFU5IzZvf8tDJ61HoZ6GCah9q+lQYnquBO/qVg1WBqLP6yTZ6WaHlHJhhM0F1
 S4jtogSnDtWsCR4vbaa6d4C1D5WVxh2s0vaoyAswKdMDyfZDc8rZF59IVQurzbJtdhSO+IU/hAi
 BE2bZdpZXPtWjtnu6ZuWEwoI5j9joVuYURgodV4LFgPXI/VAqrVN9aNjCQGW9pdGvXvbDjxNGzd
 DOEL932t3Z78CY8Y6M9xqnXaKcWRw9F7+ai81UOobFwwHOuCXwJk4x6xXccTN5nZBP17sRgHrAK
 4Tht9YIbhPtxWEyklSEleHn3Zu+bQeJYqFd2g2lnPo8rHotkNW1IFWSPAFNFX04=
X-Received: by 2002:a5d:5f8c:0:b0:390:e7c1:59c4 with SMTP id
 ffacd0b85a97d-3997f90123cmr17036269f8f.13.1742928768726; 
 Tue, 25 Mar 2025 11:52:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETm8tvIcpfTu9fHNpeaT+V8kpUAXOWxjWHr13AagPjRaLw/ci+CpBEm1iXrDB7fpb/65JwoA==
X-Received: by 2002:a5d:5f8c:0:b0:390:e7c1:59c4 with SMTP id
 ffacd0b85a97d-3997f90123cmr17036255f8f.13.1742928768407; 
 Tue, 25 Mar 2025 11:52:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9956b4sm14344687f8f.7.2025.03.25.11.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 11:52:47 -0700 (PDT)
Message-ID: <7202e381-530e-4336-bb18-45df966cceb0@redhat.com>
Date: Tue, 25 Mar 2025 19:52:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/20] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <dbc0ee83-cb24-4fa5-9060-54a34a324f2c@redhat.com>
 <ffff33965d2a4ed4a5bf22c1bda6d774@huawei.com> <Z+L1UEKFjBRPqXWV@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z+L1UEKFjBRPqXWV@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Shameer, Nicolin,

On 3/25/25 7:26 PM, Nicolin Chen wrote:
> On Tue, Mar 25, 2025 at 03:43:29PM +0000, Shameerali Kolothum Thodi wrote:
>>> For the record I tested the series with host VFIO device and a
>>> virtio-blk-pci device put behind the same pxb-pcie/smmu protection and
>>> it works just fine
>>>
>>> -+-[0000:0a]-+-01.0-[0b]----00.0  Mellanox Technologies ConnectX Family
>>> mlx5Gen Virtual Function
>>>  |           \-01.1-[0c]----00.0  Red Hat, Inc. Virtio 1.0 block device
>>>  \-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
>>>              +-01.0-[01]--
>>>              +-01.1-[02]--
>>>              \-02.0  Red Hat, Inc. QEMU PCIe Expander bridge
>>>
>>> This shows that without vcmdq feature there is no blocker having the
>>> same smmu device protecting both accelerated and emulated devices.
>> Thanks for giving it a spin. Yes, it currently supports the above. 
>>
>> At the moment we are not using the IOTLB for the emulated dev for a
>> config like above.  Have you checked performance for either emulated or
>> vfio dev with the above config? Whatever light tests I have done it shows
>> performance degradation for emulated dev compared to the default
>> SMMUv3(iommu=smmuv3). 
No I have not checked yet. Again I do not advocate for this kind of mix
but I wanted to check that it still works conceptually.

Thanks

Eric
>>
>> And if the emulated dev issues _TLBI_NH_ASID, the code currently will propagate
>> that down to host SMMUv3. This will affect the vfio dev as well.
> VA too. Only commands with an SID field can be simply excluded.
> I think we should be concerned that the underlying SMMU CMDQ HW
> has a very limited command executing power, so wasting command
> cycles doesn't feel very ideal as it could impact the host OS
> (and other VMs too).
>
> Thanks
> Nicolin
>


