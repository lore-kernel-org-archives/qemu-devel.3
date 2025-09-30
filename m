Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920A1CAC5BD
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WLu-0000wK-Ss; Tue, 30 Sep 2025 05:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3WLs-0000vw-Pt
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:08:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3WLk-0005QT-S9
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:08:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso4426330f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759223320; x=1759828120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ODAcWq7vVXFaEndr2ehTqidnulcbkmxlYSyT9kV0nw=;
 b=qzSQizUC3Cq/8ls9z+uG2k6aPZ2YrmyYlWJQGdtRIu2RI3m0L7NmIRD49FejZ8H6Xb
 GJMRbJO3NgDn/S0zhmm24gePrlTIX1HBGR7AyzY8bcAIzlbNMTxHSGUo7MwHKB9ZHfkj
 3Bcue8HV6MBctNi1MhEYLnGFEZYWXC+wr/qNdRbe3k+Y5nsAYuSNGh0ca7obm/gO8YjL
 TFJ7TbN2dxqrPbh2C8o6L6dYfX/xdo3CffvVzUtRT8ph5Me6RcCIVnwEheloljPSv+ik
 iOd2jVlM6LK5lQikKwUdhN8uUGoDbElXkf1nBCZQ9g3/ESyNhtTw9KrvAkUxYkiHSWJM
 EmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759223320; x=1759828120;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ODAcWq7vVXFaEndr2ehTqidnulcbkmxlYSyT9kV0nw=;
 b=ZVTCty8DV4qzvJlVCHSD7dLZQ5pzHVlfLmS9jHrckhoccgwbrag9/+ZTpjrOaKvyuL
 yX7e6iAU5XiZWkmB8O+YFtFe9+nJ1QiTX1zg01ZnNNu5XicgRrVYyX5e7QM/dZ1BWUrq
 WaI3m4+1Wxcfyaece58YSkBEMs46yGVZYnBTGgeE/3g66uKKgl3+CIu18fPQ3nrNRc89
 aMNzvkX6md3Tf5evm1ydTuX5XnhH1mM79rdgbkaZs52oWGvYavHNN+15Evx17Pf4kDHE
 CkA/C4tbxDeI/Ma/KOnEBLtOT4eUUpzsctNf0JjMHDMknhY57wutDyYeLdqWE8sUReKk
 Ucpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmS+x2GwOqfq8KzfvnoAWKGJOjbGhfVCMCxmxOsyFxEuWaW76LgOZJmkRcNVrvYwOo1j5TOkXJ+vPt@nongnu.org
X-Gm-Message-State: AOJu0YwbVNcDewMu9D7zMD9/QML+q2cW2rCyVywxrrjymRezk14gH0gp
 aKnYQDQeciLhKM+K64Ma7zui9tpdna5TnoIUcz2+qtAuIda2z5vWTcuH1R5kLFZce8o=
X-Gm-Gg: ASbGncsZMRLEdHrlFWKp/3PUa2LVIXeH06YpkWGJUkMYEoD17BluYTONyNS1KujrZZQ
 ZAtwFVLGw/XatIba5yOxEoXrFelRdyfPMbe2zHQfKnKEVIUV3uO6ULsscYxdRC3K7AwDmRYduP2
 fDLfDhW8Qf5tLI9mW/cKNckm8gICNNAC7e67KzX60idE2P+T0b7PF0pbyZLflXTBJ+hsUZFOe/9
 3wrusinZqMxszvY0wJ7I+N3f+fO4QhJP79j2tixoNhO+9aTKAXWEwH4Sf7oqh9qCOUDlmyESpFe
 qkAdfn9jhoLnGJg4xe6/kcf5rv10ot/A9x/2FedsD4Xt2Ra7Gn3nUQGuEdAVCNX0UsPFDDkn2Vz
 WsQJyEPAHpKnPdcsJInkHpCK0qviWFyK0p5lybPxT3FrQmh+o04+8Py1ICFhdKLI3l6RjdPVTbn
 weuWG+cZEU0q1jp47wPWcy755Q
X-Google-Smtp-Source: AGHT+IGx7cJG+wAr0JONlS0j5oJFOpEeISMDSHB3e28sobp2Lr//LEIMppJC0tssqCo+8LQMHwkbSg==
X-Received: by 2002:a5d:5f92:0:b0:410:88db:1c6e with SMTP id
 ffacd0b85a97d-4241111f653mr3599911f8f.16.1759223319554; 
 Tue, 30 Sep 2025 02:08:39 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603365sm22430779f8f.37.2025.09.30.02.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 02:08:39 -0700 (PDT)
Message-ID: <a4da9148-65aa-4e73-af61-68b07f4d8568@linaro.org>
Date: Tue, 30 Sep 2025 11:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/vfio: Use uint64_t for IOVA mapping size in
 vfio_container_dma_*map
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Thanos Makatos <thanos.makatos@nutanix.com>, 
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250929160807.73626-1-philmd@linaro.org>
 <20250929160807.73626-4-philmd@linaro.org>
 <e23cb913-5f53-461e-adc4-f68a8358428b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e23cb913-5f53-461e-adc4-f68a8358428b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 30/9/25 10:53, Cédric Le Goater wrote:
> On 9/29/25 18:08, Philippe Mathieu-Daudé wrote:
>> The 'ram_addr_t' type is described as:
>>
>>    a QEMU internal address space that maps guest RAM physical
>>    addresses into an intermediate address space that can map
>>    to host virtual address spaces.
>>
>> This doesn't represent well an IOVA mapping size. Simply use
>> the uint64_t type.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/vfio/vfio-container.h | 10 +++++-----
>>   hw/vfio-user/container.c         |  4 ++--
>>   hw/vfio/container-legacy.c       |  8 ++++----
>>   hw/vfio/container.c              |  5 ++---
>>   hw/vfio/iommufd.c                |  6 +++---
>>   5 files changed, 16 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio- 
>> container.h
>> index 093c360f0ee..c4b58d664b7 100644
>> --- a/include/hw/vfio/vfio-container.h
>> +++ b/include/hw/vfio/vfio-container.h
>> @@ -81,10 +81,10 @@ void vfio_address_space_insert(VFIOAddressSpace 
>> *space,
>>                                  VFIOContainer *bcontainer);
>>   int vfio_container_dma_map(VFIOContainer *bcontainer,
>> -                           hwaddr iova, ram_addr_t size,
>> +                           hwaddr iova, uint64_t size,
>>                              void *vaddr, bool readonly, MemoryRegion 
>> *mr);
>>   int vfio_container_dma_unmap(VFIOContainer *bcontainer,
>> -                             hwaddr iova, ram_addr_t size,
>> +                             hwaddr iova, uint64_t size,
>>                                IOMMUTLBEntry *iotlb, bool unmap_all);
>>   bool vfio_container_add_section_window(VFIOContainer *bcontainer,
>>                                          MemoryRegionSection *section,
>> @@ -167,7 +167,7 @@ struct VFIOIOMMUClass {
>>        * Returns 0 to indicate success and -errno otherwise.
>>        */
>>       int (*dma_map)(const VFIOContainer *bcontainer,
>> -                   hwaddr iova, ram_addr_t size,
>> +                   hwaddr iova, uint64_t size,
>>                      void *vaddr, bool readonly, MemoryRegion *mr);
>>       /**
>>        * @dma_map_file
>> @@ -182,7 +182,7 @@ struct VFIOIOMMUClass {
>>        * @readonly: map read only if true
>>        */
>>       int (*dma_map_file)(const VFIOContainer *bcontainer,
>> -                        hwaddr iova, ram_addr_t size,
>> +                        hwaddr iova, uint64_t size,
>>                           int fd, unsigned long start, bool readonly);
> 
> 
> Don't forget to change :
> 
> typedef int (*dma_map_fn)(const struct VFIOContainer *bcontainer,
>                            hwaddr iova, ram_addr_t size, void *vaddr,
>                            bool readonly, MemoryRegion *mr);
> 
> in /include/hw/vfio/vfio-cpr.h.

Odd place to declare a typedef aiming to match a prototype of
another header. No common vfio header between vfio-cpr.h and
vfio-container.h?

