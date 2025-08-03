Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E9FC87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 16:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uibvr-0000t0-Tq; Sun, 03 Aug 2025 12:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uibtm-000871-Cu
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 12:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uibtf-0003IW-QR
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 12:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754239755;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bldPOmhW+tpVLm4p4wnYqA2Lty4/GhuNrJNOHtese9k=;
 b=RX0ePwdH21UToGZKVP9ABrm1e8hlFw+XDfx9CE3vkurPEz9QmLHndgdicW1TQJ/OVpDPft
 HaL+FxoiGL7YT2yazDqcC7GOVddByL+3KvMKhmlDidHH7IbWwLkt4QHQDcj0x2d7EGUXvH
 fWCd0Q9rNIGikcGuAWlvnxylBMywjOE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-W6Y3WNYxOQWZA22sb0kYaQ-1; Sun, 03 Aug 2025 12:49:13 -0400
X-MC-Unique: W6Y3WNYxOQWZA22sb0kYaQ-1
X-Mimecast-MFC-AGG-ID: W6Y3WNYxOQWZA22sb0kYaQ_1754239752
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b79c28f8ceso2699805f8f.3
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 09:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754239752; x=1754844552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bldPOmhW+tpVLm4p4wnYqA2Lty4/GhuNrJNOHtese9k=;
 b=bXAeiGWKszNyDTVk0xo/mJwTF0bMRTK20j01c4E12O6UQ8rQN5yqegr3CyNEaDQLkp
 0JSXKxoMVYXcbhRH3qFi/65H07V2mJR+2yEfUUzZq60qz/uY8t823OZ3tQBU1asqlWSZ
 MALWO+ewzTKvMpYtQnI8TGHKInjJ+/mw8n/00QLaYUsw4ZzXiV1d/dR4vn0/0rz6KkOw
 W16g4fRN1CpUgmc03cVSJ1fZTUQo2RQ8URkFezgGTiqX+YEZfyXVY5MDsNXtzogZhY0Q
 fizZGGhCPAKrPf+j3NLMOcNfNemYSz3l3FtJhrMnWnxt8V/VNrwYFZXyrGV5xYPqSOYV
 lCFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwBSnmMO3mYMlJAN33g1nrQQUJzrjMmd+J+sLhIl8L+pSP7sh9FwlWq0nXTE4Wn4XQ0DtvDqOtLBgt@nongnu.org
X-Gm-Message-State: AOJu0YwlSoB7nTExRYFgeJZc+p6Bm4S2gZjSbLU6L0l/9RbB4cNmJafo
 zQ0V35VTyvxj6l2J1D5rX2V/VOEuZBVBNufz3iKly+gRn2wq6StWFUQKipk99dGZhoPgwBYWYNQ
 TCfYkZip31eX1lC6ofHQHH5TjAjIvYESdiCPXcwFCCYSo9a4cDfZG6rlg
X-Gm-Gg: ASbGncuVvVhcsHYp4AmsqywLz2qjv2//vx+8q4YGGtJyuCGwM1WUsHDYOZJfARLg0I4
 haDwB2ewAjilhJTNBycF30dRMq5DalZVUxSqOvBhWv2a2cpQVP6lp/QWheMuk6II/x8+nJaiU2K
 h0q2ta7BB7mcUzHIrymvKBZKtULLAwRgTHH7VxCqZ6e216a1FWooiXruBe8fjljedV51PkAAylf
 NVlOvczu/dZ8H5aDJfSeCVpH0/YWIemAdmwenpxWWcU9gvBplOLd895hQrD/C48VHbOjdK3aM51
 Wjahfi/kfaG6vHG0e4OHUN6hRjyrvjLyfA8RxO396NeBh0Bx2ou/dnsdlG5l+v6cg1dAWVW1mcO
 HAw9p7bJUpTM=
X-Received: by 2002:a5d:64cb:0:b0:3b7:83c0:a9ab with SMTP id
 ffacd0b85a97d-3b8d94ce6damr5104630f8f.55.1754239752157; 
 Sun, 03 Aug 2025 09:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgue15/fVGcaS5KxenImh/2PbNT+qmScxmhnHLAoXI1EfKWBFLhVfvKMlo1ntzZOOECwIKrA==
X-Received: by 2002:a5d:64cb:0:b0:3b7:83c0:a9ab with SMTP id
 ffacd0b85a97d-3b8d94ce6damr5104610f8f.55.1754239751650; 
 Sun, 03 Aug 2025 09:49:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453328sm13272666f8f.46.2025.08.03.09.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Aug 2025 09:49:10 -0700 (PDT)
Message-ID: <2f2bc1e5-22fd-4cea-82fa-6be6bc82ad2c@redhat.com>
Date: Sun, 3 Aug 2025 18:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/36] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, shannon.zhaosl@gmail.com,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
References: <20250714080639.2525563-1-eric.auger@redhat.com>
 <20250714080639.2525563-10-eric.auger@redhat.com>
 <ddf6f9e3-daaa-4ea1-a5e6-d402a75524c8@tls.msk.ru>
 <914677f4-07ba-45fe-9dc2-dea40940e789@tls.msk.ru>
 <53971ad6-9f50-45b0-80c4-eeedb24e53db@redhat.com>
 <20250801082904-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250801082904-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Michael,

On 8/1/25 2:29 PM, Michael S. Tsirkin wrote:
> On Mon, Jul 28, 2025 at 04:56:37PM +0200, Eric Auger wrote:
>> Hi Michael,
>>
>> On 7/28/25 11:07 AM, Michael Tokarev wrote:
>>> On 27.07.2025 14:48, Michael Tokarev wrote:
>>>> On 14.07.2025 11:04, Eric Auger wrote:
>>>>> gpex build_host_bridge_osc() and x86 originated
>>>>> build_pci_host_bridge_osc_method() are mostly identical.
>>>>>
>>>>> In GPEX, SUPP is set to CDW2 but is not further used. CTRL is
>>>>> same as Local0.
>>>>>
>>>>> So let gpex code reuse build_pci_host_bridge_osc_method() and remove
>>>>> build_host_bridge_osc().
>>>>>
>>>>> Also add an imply ACPI_PCI clause along with
>>>>> PCI_EXPRESS_GENERIC_BRIDGE to compile hw/acpi/pci.c when its
>>>>> dependency is resolved (ie. CONFIG_ACPI_PCI). This is requested
>>>>> to link qemu-system-mips64el.
>>>> This patch somehow broke microvm-only build which is used by debian.
>>>>
>>>> configure options used (trimmed a bit):
>>>>
>>>> ../configure \ --without-default-features \ --target-list=x86_64-
>>>> softmmu \ --enable-kvm --disable-tcg \ --enable-pixman \ --enable-
>>>> vnc \ --audio-drv-list="" \ --without-default-devices \ --with-
>>>> devices-x86_64=microvm \ --enable-vhost-user
>>>>
>>>> configs/devices/x86_64-softmmu/microvm.mak: ---- cut ---- # see
>>>> configs/devices/i386-softmmu/default.mak # for additional devices
>>>> which can be disabled # CONFIG_PCI_DEVICES=n
>>>>
>>>> CONFIG_MICROVM=y
>>>>
>>>> CONFIG_VIRTIO_BLK=y CONFIG_VIRTIO_SERIAL=y CONFIG_VIRTIO_INPUT=y
>>>> CONFIG_VIRTIO_INPUT_HOST=y CONFIG_VHOST_USER_INPUT=y
>>>> CONFIG_VIRTIO_NET=y CONFIG_VIRTIO_SCSI=y CONFIG_VIRTIO_RNG=y
>>>> CONFIG_VIRTIO_CRYPTO=y CONFIG_VIRTIO_BALLOON=y CONFIG_VIRTIO_GPU=y
>>>> CONFIG_VHOST_USER_GPU=y ---- cut ----
>>>>
>>>> The result: FAILED: qemu-system-x86_64 cc -m64 @qemu-system-
>>>> x86_64.rsp /usr/bin/ld: libsystem.a.p/hw_pci-host_gpex-acpi.c.o: in
>>>> function `acpi_dsdt_add_host_bridge_methods': hw/pci-host/gpex-
>>>> acpi.c:83:(.text+0x274): undefined reference to
>>>> `build_pci_host_bridge_osc_method' collect2: error: ld returned 1
>>>> exit status
>>> In hw/i386/Kconfig, MICROVM selects ACPI_HW_REDUCED (not ACPI or
>>> ACPI_PCI), *and* PCI_EXPRESS_GENERIC_BRIDGE.  But in hw/pci/meson.build,
>>> pci.c (where the function in question is defined) is built when
>>> ACPI_PCI is enabled.  Something's not right here.
>> This commit added an imply ACPI_PCI to the PCI_EXPRESS_GENERIC_BRIDGE
>> config in hw/pci-host/Kconfig:
>>
>> config PCI_EXPRESS_GENERIC_BRIDGE
>>     bool
>>     select PCI_EXPRESS  -> selects PCI
>>     imply ACPI_PCI
>>
>> In hw/acpi/Kconfig we have:
>>
>> config ACPI_PCI
>>     bool
>>     depends on ACPI && PCI
>>
>> ACPI is selected by ACPI_HW_REDUCED
>>
>> config ACPI_HW_REDUCED
>>     bool
>>     select ACPI
>>     select ACPI_MEMORY_HOTPLUG
>>     select ACPI_NVDIMM
>>
>> so logically the ACPI && PCI dependencies for ACPI_PCI should be
>> resolved. What do I miss?
>> regards
>>
>> Eric
>>
>
> Not sure I get what are you proposing?
I have not proposed anything ;-) - sorry I am on vacation - I was trying
to enumerate the various config settings and to me dependencies should
be resolved so I fail to understand. Unfortunately I cannot test because
the problem happens with a custom microvm.mak. I would need this latter
to reproduce and try to fix.

if the microvm.mak selects PCI_EXPRESS_GENERIC_BRIDGE (which selects
PCI_EXPRESS which itself selects PCI) and ACPI_HW_REDUCED (which selects
ACPI), the imply ACPI_PCI should end up as a selection because PCI and
ACPI are resolved. At least that's my understanding. Reading it again,
please can you check whether ACPI_HW_REDUCED is selected *before*
PCI_EXPRESS_GENERIC_BRIDGE in the custom microvm.mak. Depending on the
order of dependency resolution it might make a difference. Otherwise
please can you send the full microvm.mak and configure command so that I
can try reproducing. Thanks Eric
>
>>
>>
>>
>>
>>
>>
>>> Addig kraxel for 24db877ab6e6 "microvm: add pcie support".
>>>
>>> Thanks
>>>
>>> /mjt
>>>


