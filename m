Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B125C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 11:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhRSi-0002rJ-Nq; Thu, 31 Jul 2025 07:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhRPH-0000U7-5b
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 07:25:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhRPA-0000YQ-OR
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 07:25:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4589180b266so4226025e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753961098; x=1754565898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8f4hgpDHnod2DklS+e6iPhmx4FSdrHWhcc2i09e6x8Y=;
 b=diHaxD+Pldi6E4fYYA094WWzJuUf4s74g1IdhPVsGmnlhQnJdNT47R/0JZgDwtTb+Z
 990zjPz+ArhpJRG9t/BnQ526hh2dUvpGnFjmN/K9vtESIph/TG4eZhPhgy6iUbr5uTOj
 XCyyTm5jPfnKURsgEKWalwyr125YsMuQFrjKA1h5YDMdtfdWTF5nVOTfdN5njTTLLuNa
 rtDiX7XgMUwf5C+wiIiCcdK1Edm8XJW+h0jFoQ3u6qn0Zrw7fGT4MIO7FhDf2jA/v9bO
 D3SFsZIur2C39N0qoJQG3CykhinBR9bgSVI4CVPFzoP5BfV6q4TF3E6TCJWzfc0csDAo
 97Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753961098; x=1754565898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8f4hgpDHnod2DklS+e6iPhmx4FSdrHWhcc2i09e6x8Y=;
 b=FElh7D1VvVCVr1f77zFcSXTOQyP36ndJmAfkaaWhh6UIDRyIH7mT+6EjMmdN5P6MpD
 gKtfScGvrD+RjlfmBsB22QRK/mwkZrkiADto9TZKh9bK3bRb0FQNSO7Yr4hr4iA27Upf
 zn0e1wJsQH0tPgahn5LmVQKgl+zvje7U49Nh4mdy2EwaiU5OIQ8h+h3srXGJwJPnI+Y3
 hrh/T3bOabUcMVQ+11GvPMDNvkgJuDE/SNQYNFCRiiDRKYy99whpjGQxLfjeN5i+V0kG
 NG5zph0BrNXkCzfxM5I8FkDQg/Ci2ml5V/dCRKL8ux2LAyDLcMyRKZBcTiEenSH3S2GU
 feLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq20wibPPIXFNrXyUmYgolg5ZirJYmEg/tuyNbnmWUU0LMZC4BT+X1JO851RdP73ZBDvgv9DGVXjhg@nongnu.org
X-Gm-Message-State: AOJu0Yzct/oZlk+bipU4Bm/6Ldo7J1HvakP0Br0uCXnWqyOLrN6m7xUP
 vLTIU5UkOO1C1/0T/QaQ6KQuAb+HxPyhYX4wB9k6suG1xXiywuKvnpx3DqDoJUm5mgg=
X-Gm-Gg: ASbGncvlCrUKrbuCDe7kJ08tQugS3WjkkMxrXcOHQdTXK08B6JU92hg9ssTZzJ59Axi
 T0LcDAsjKYzL/kCLekoxex0Yru9cb4n3YScnYJteSVMRR1vNsTyz8xn1o6ZW2x8WKJYXk4af3tz
 aTjRfj/29efRST4oLIFl9YrCXnL2RZlJggphjKv8MdYtDmdJipxdIjKhX64RIE7/uI2yUqfEMj4
 /z7DMtnNr02hSewf2U2NiuWylmjtrL9M4Ry0dDSJSLvUgJDoT2IgAfoTpvQ3c2aeaY2+aStozbS
 Vf89Zonlm1RukNsT8S1nMv0sQaSoa2L0i3jT+yaUrQywsGrm81DLcQhegUK8oO6LRREpk+frN0q
 IMaIrpRtyVSTcHbefYHF0r7Bs55flHsyM2MtsxxnNGHzJYXloRsg3h1AeM8QtlMNdyUd+d+beip
 S9
X-Google-Smtp-Source: AGHT+IFDjyV/KtAMV2GIgmAw7GYuc5bb4pA2WM/ODQIdBTZZZ32E1nhzB5VXQSLKuOko5Ahdm/I2Gg==
X-Received: by 2002:a05:600c:c0d2:20b0:456:1b6b:daaa with SMTP id
 5b1f17b1804b1-458934a4830mr39873745e9.29.1753961097813; 
 Thu, 31 Jul 2025 04:24:57 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eba17sm60633635e9.24.2025.07.31.04.24.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 04:24:57 -0700 (PDT)
Message-ID: <a5b7729f-ca9b-44c8-9ec9-89fdf2636340@linaro.org>
Date: Thu, 31 Jul 2025 13:24:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Introduce helper vfio_device_to_vfio_pci()
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250731033123.1093663-1-zhenzhong.duan@intel.com>
 <1e5263cc-23fb-44cf-a8c1-f01b6fbb6ef3@linaro.org>
 <IA3PR11MB91364FF957288A4DBC5A3F709227A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <IA3PR11MB91364FF957288A4DBC5A3F709227A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 31/7/25 10:49, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [PATCH] vfio: Introduce helper vfio_device_to_vfio_pci()
>>
>> Hi,
>>
>> On 31/7/25 05:31, Zhenzhong Duan wrote:
>>> Introduce helper vfio_device_to_vfio_pci() to transform from VFIODevice to
>>> VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.
>>>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-device.h |  1 +
>>>    hw/vfio/container.c           |  4 ++--
>>>    hw/vfio/device.c              | 10 +++++++++-
>>>    hw/vfio/iommufd.c             |  4 ++--
>>>    hw/vfio/listener.c            |  4 ++--
>>>    5 files changed, 16 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>> index 6e4d5ccdac..00df40d997 100644
>>> --- a/include/hw/vfio/vfio-device.h
>>> +++ b/include/hw/vfio/vfio-device.h
>>> @@ -157,6 +157,7 @@ bool vfio_device_attach_by_iommu_type(const
>> char *iommu_type, char *name,
>>>                                          Error **errp);
>>>    void vfio_device_detach(VFIODevice *vbasedev);
>>>    VFIODevice *vfio_get_vfio_device(Object *obj);
>>> +struct VFIOPCIDevice *vfio_device_to_vfio_pci(VFIODevice *vbasedev);
>>
>> Please return the typedef (like in the implementation), not the struct.
> 
> That will break build. VFIOPCIDevice is defined in internal header hw/vfio/pci.h,
> while include/hw/vfio/vfio-device.h is public header, I'm not sure if it's right way to include internal header in public header.

Moving the following line:

   OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)

from hw/vfio/pci.h to include/hw/vfio/vfio-device.h should be enough.

> 
>>
>> A one line comment describing what this helper does would he helpful.
> 
> Will do.

Thanks!


