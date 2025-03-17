Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13EDC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuEsj-0005nq-31; Mon, 17 Mar 2025 14:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuEsg-0005jf-QB
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuEsf-0001ZA-3S
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742234882;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1dZQSG9QVTqJh0M8+zktW9DJ3Coh0zKQ6iynN8QqYQE=;
 b=RR6Kxf3qsye/Kkomc8mgAOkXvnsIv+umzvlNwoUYsENPZbFosacbF5n68kyIWRiqailAbo
 ubw4tQA6nL/W/Wd8ABDaCkGTrmiVxhjV3FCvv5jK7VN7VwTakAfKGDsO/smFYhhIInAh9m
 1ENp06zCXHI+pzaHyrUmpwneSvPob+0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-WsE9wlcyMEmkUTM6CytAOw-1; Mon, 17 Mar 2025 14:07:59 -0400
X-MC-Unique: WsE9wlcyMEmkUTM6CytAOw-1
X-Mimecast-MFC-AGG-ID: WsE9wlcyMEmkUTM6CytAOw_1742234879
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-85b5a7981ccso448540239f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742234879; x=1742839679;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1dZQSG9QVTqJh0M8+zktW9DJ3Coh0zKQ6iynN8QqYQE=;
 b=mhI+glx7cbvd4cql6NxWgi5D3lu6Cc2OYUS4Hw+jWbefdG/wDA+nfvUjF0sycsJChz
 tR+WEl8G4UEzxfChesYBJzMOVaGTnO4xAlq3rj39qVinpY7wLIINtXEW1SQhZTGOQ0+7
 V2EyPsxHsuddPfIGPP7zwlzsg79GirW7hv/WCbrFTlET0t1dHxHH/GQeuntyaoVnaIF8
 vBmdvwu9g3pQ+Ms15SHUhXBd1AY5f8lZBKp98gK12ZeLRJWUgEoWSgRWV9U9NnzPJlei
 OcLtWRU/hkvcYWBvYLp8OyJ/syeK3B9rQx3or0EAMDN3V+8Z3krwspgMon2ySNzWH46L
 7YTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViwtjL8vymBGhZPs59LcJd7L/po5FCWe17lOyGJYkoOpuRFF0jcUifScYjPaT6IJtfz+ixN1Bp6g0x@nongnu.org
X-Gm-Message-State: AOJu0Yx3BL2ZYf+6zPM3sKRGr71pfUGQWqt5K5Mnk4aQhbYMa/3V2xzz
 oe6ltASvHcQMEF3zBrP7ZU7As2+CXMAEh5NHn7bfWXvJjYCiGuLAw4HPUV7oJAqsfquVPaWnxS0
 D18v9GRi4U1o01+sMtPjoxAPKjCZXZcpap1L+Gy5T+/niu0cT5C/Q
X-Gm-Gg: ASbGncu+anj6hNfLtRL+bNbMwc7zenSiCjRVB3xWZ/BoGE3TYAq7g4Ktpvrd8cQa6ky
 R0kN74uJV/fn95mAHV4fLUXGrfLYTV2SSQnFbVT74ty/Uq5EAAisGMLOx10wwkA8Ift/5bHc2c4
 3OwToWf9wTWqTmQQET+tru+M4QEBnQi955AmZ47JHt0MnSTZKL0VSrwaWlv5CTikDTqA35sX8cc
 vhYWHaAZangk6EK8c92dtaAo5W73vRDkvb2+lxSsaQWAio16m2YypDCK7oXxjLT7XRDqskMwPEQ
 roDljDFZ/l8wlELCYYcn4PStrtSRlFjmjkOfuIDPOqq0Yhlg+GrDRrrsnlIi5jQ=
X-Received: by 2002:a05:6602:3a15:b0:85b:3fda:7dbf with SMTP id
 ca18e2360f4ac-85dc48570fcmr1746513639f.9.1742234878715; 
 Mon, 17 Mar 2025 11:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmZUzLk+04vwMTaVgS7cTDwzmxfKRuRwg/pM+E/dAzS/QP8w6s7wh5Fo3/2+Imh8Vm4iFOlA==
X-Received: by 2002:a05:6602:3a15:b0:85b:3fda:7dbf with SMTP id
 ca18e2360f4ac-85dc48570fcmr1746510439f.9.1742234878424; 
 Mon, 17 Mar 2025 11:07:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85db8750862sm224814739f.9.2025.03.17.11.07.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 11:07:57 -0700 (PDT)
Message-ID: <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
Date: Mon, 17 Mar 2025 19:07:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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




On 3/17/25 6:54 PM, Nicolin Chen wrote:
> On Wed, Mar 12, 2025 at 04:15:10PM +0100, Eric Auger wrote:
>> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
>>> Based on SMMUv3 as a parent device, add a user-creatable smmuv3-accel
>>> device. In order to support vfio-pci dev assignment with a Guest
>> guest
>>> SMMUv3, the physical SMMUv3 has to be configured in nested(S1+s2)
>> nested (s1+s2)
>>> mode, with Guest owning the S1 page tables. Subsequent patches will
>> the guest
>>> add support for smmuv3-accel to provide this.
>> Can't this -accel smmu also works with emulated devices? Do we want an
>> exclusive usage?
> Is there any benefit from emulated devices working in the HW-
> accelerated nested translation mode?

Not really but do we have any justification for using different device
name in accel mode? I am not even sure that accel option is really
needed. Ideally the qemu device should be able to detect it is
protecting a VFIO device, in which case it shall check whether nested is
supported by host SMMU and then automatically turn accel mode?

I gave the example of the vfio device which has different class
implementration depending on the iommufd option being set or not.

Thanks

Eric

>
> Thanks
> Nicolin
>


