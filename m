Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0C4C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhrxr-0001cS-32; Fri, 01 Aug 2025 11:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uhrKH-0002yw-BN
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uhrKE-0001VL-PN
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754060735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xd1WprH4czu29bIBsl/hcKfwDL31cdaP2X3vf/RrN4U=;
 b=evDEWn6cmsFPLBAqOMTRffclibZY+kLlnZPGQhtKMGC5S81PyGyvQpPdX7fNLXyQ2B/zQH
 AcgjbcdTrAlnyLVJseZbPACrVLiFX5Aakp4bVa8WoScwALrZBfrhLNSdDqfkNEJ4PUlF23
 5QB6KrkxiV1BRBgsnVuBZIRVorzLplI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-6-m8LBNKOxec_ZKBp1xRFA-1; Fri, 01 Aug 2025 11:05:32 -0400
X-MC-Unique: 6-m8LBNKOxec_ZKBp1xRFA-1
X-Mimecast-MFC-AGG-ID: 6-m8LBNKOxec_ZKBp1xRFA_1754060731
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b8d612996cso320499f8f.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060731; x=1754665531;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xd1WprH4czu29bIBsl/hcKfwDL31cdaP2X3vf/RrN4U=;
 b=jnZ2wZYo1Y8a7Gl23vHvw8lfe389xkl+pwQ6B20Jrh3QQA5e2HexXTGFbfsMeWlgla
 AA1Vwxb/0spHDA7GAJ301P1y8QIJQ1XjqCLu1Z385xdz/LbK0H4FPH7Y8McA/+vDs8Cn
 kqOIY/V3iiqVfd/rwz0xZdKR72ubDslQeeXGPvOJ7X+fqXokLo6tyPBz/aIzhxhNE8gY
 9Fgi/t2muJc7fG9tULcU92/b7a/wmwDuB2k5cko9R1qZRno+Pp/iK7HRZvVbLJQc6YEi
 MSB66cDO8NRi89glAJqpAEJomYqTQ8zTlAFH4GCV8NADB1VX/lus7K0Vppz27w6Xe5p3
 8BuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Vno9QNRupTbi4H+1SFbXGEj/QL//vFIT8hSbb5neVR+cmXeKo23OkZTtmdO6kBRPrI+RtTyNsiAh@nongnu.org
X-Gm-Message-State: AOJu0YxZJpZuqrD0Pb2fgLs1/6fBnwghP5Yojc4Dk/bUkFWd6zc+s5in
 q3vQDYjPQ1zzWRVwXjBi7gB6PCFfVhJ2GGbv2IUCG+mfon4Vq47Ymh/eixJgX1mzT1Zrfg7viUb
 U8N/NYUc+o2h0tr+s4UOP5+aXg1Yh902ogolSVSZTMerKGcJL3KrfIpg5
X-Gm-Gg: ASbGncvUB8MGwXmJjVpX0iPsJeqqMQdr30EHXW15XkKIWjZwQ5Tv6zlT8Kmjyzy+arS
 mAIshe/VZH1eeLvOx6iJuyxahrWkQs8M9dfU5x4AsYaoXpLjQ0eSnaCjzMcvHpXWWvoZO/Jfyjz
 JlHsm1Ez3j5LI1EPQKaoIrW8RQq5w51xMxedb+C9xuEFAsqfAVAZywxrsmVdrBaCE2aQBjNMbca
 /RQ30d5n3Xu+SOEmMBJeOk/ffmqL7IdlaZrt3dHpycCi3Qa7DO0wJbt4uAyz8sMRCQp3H3sha91
 SwwQLXVx13vGv47nSd8MEnF10zCWiXvvCh39+SwYykVyS29T2r/8D1XFIv3FWc8I87hmVYtpjSJ
 D3+1wG6I=
X-Received: by 2002:a05:6000:420d:b0:3b7:8473:312c with SMTP id
 ffacd0b85a97d-3b8d94064dfmr146351f8f.0.1754060730923; 
 Fri, 01 Aug 2025 08:05:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrd95GabwUtniMXB5QtMhVHwkYXEeOJbttHlpWrDNoM6tcl0Oe8dvE8Mbk7uu6fcStSi3KjQ==
X-Received: by 2002:a05:6000:420d:b0:3b7:8473:312c with SMTP id
 ffacd0b85a97d-3b8d94064dfmr146301f8f.0.1754060730351; 
 Fri, 01 Aug 2025 08:05:30 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453aeasm6398808f8f.40.2025.08.01.08.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 08:05:29 -0700 (PDT)
Message-ID: <ed8451bd-853a-429e-987c-4ec86e01efe9@redhat.com>
Date: Fri, 1 Aug 2025 17:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio: Introduce helper vfio_pci_from_vfio_device()
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 =?UTF-8?Q?=27Philippe_Mathieu-Daud=C3=A9=27?= <philmd@linaro.org>
References: <20250801023533.1458644-1-zhenzhong.duan@intel.com>
 <8b599c19-1901-4707-a8ca-943f61c0e2f9@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8b599c19-1901-4707-a8ca-943f61c0e2f9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhenzhong,

On 8/1/25 07:42, Cédric Le Goater wrote:
> On 8/1/25 04:35, Zhenzhong Duan wrote:
>> Introduce helper vfio_pci_from_vfio_device() to transform from VFIODevice
>> to VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.
>>
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>> v3: add one line comment to the helper
>> v2: move helper to hw/vfio/pci.[hc]
>>      rename with vfio_pci_ prefix
>>
>>   hw/vfio/pci.h       | 1 +
>>   hw/vfio/container.c | 4 ++--
>>   hw/vfio/device.c    | 2 +-
>>   hw/vfio/iommufd.c   | 4 ++--
>>   hw/vfio/listener.c  | 4 ++--
>>   hw/vfio/pci.c       | 9 +++++++++
>>   6 files changed, 17 insertions(+), 7 deletions(-)
> 
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks,
> 
> C.

I have modified your patch with :

+/**
+  * vfio_pci_from_vfio_device: Transform from VFIODevice to
+  * VFIOPCIDevice
+  *
+  * This function checks if the given @vbasedev is a VFIO PCI device.
+  * If it is, it returns the containing VFIOPCIDevice.
+  *
+  * @vbasedev: The VFIODevice to transform
+  *
+  * Return: The VFIOPCIDevice on success, NULL on failure.
+  */

See https://github.com/legoater/qemu/tree/vfio-10.2.

I don't think it's really necessary, as these are internal APIs and
none are documented, but Philippe seems keen on it. I guess he plans
to volunteer to document the rest ;)

No need to resend a v4.

Thanks,

C.



