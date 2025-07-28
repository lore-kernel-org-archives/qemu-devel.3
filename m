Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5638C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 14:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPHb-0004DX-Op; Mon, 28 Jul 2025 10:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ugPHV-00048O-Ut
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ugPHU-0005Vd-CX
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753714605;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gYlRwsysDFvMEftSH+hVG3IjU7h5zOtQnktwNoOFdsE=;
 b=fv1P5WS57dOMYScwzu4hQTbd8mzmmVC2R0swoZKWQPPcs35RBP40FKNj3iRz1GZqjwVy6a
 QWTUd51rmd0gOlLCV696LQwxjbGR+wT/+sKbR0/cMTR/X6k0gq5RUeEjdFtyrdO5AwyW8l
 r12J8u2rPPQIPRJ4FaFAekW/Uk0SF9g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-unCscx9YNVS-JsPoLb9SMw-1; Mon, 28 Jul 2025 10:56:43 -0400
X-MC-Unique: unCscx9YNVS-JsPoLb9SMw-1
X-Mimecast-MFC-AGG-ID: unCscx9YNVS-JsPoLb9SMw_1753714602
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b78c983014so221144f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 07:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753714601; x=1754319401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gYlRwsysDFvMEftSH+hVG3IjU7h5zOtQnktwNoOFdsE=;
 b=VMEQXbHzlP0BVpWiCnXk79h0KjUSHppmmVuzjd9bYJNNIOmbIxpXE2TptrODHWg3RT
 aXaD+6KW7tA3678eQBg5qShpX67SnOt2rE6cHUfiljzgaLNz7yDPoQwwZlqFloQb/3LL
 YHhF7+Xr8MxrxnLGsnUiMrc9ycu0uwrGM9QXe8BiPdmHEojYURpFbyHhLBIqI5fGLHXL
 JkH8LcsZMo/ekS4JQFYUwKcp2V7/qKH1oUru+VpYltUqBTEjb5QBXYCDPvpI1GTrYN/c
 trjXOnEVNTRjTQrOz31jd3V+fQu2jlXZVH0XXAWhGuvOY62yHnbBuSplbYTXelP8fl+P
 EaqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAy5ey+/IiWCVoSO3SAvWFoDv5hyk6CtvzpYRIE8R6jwhLIkKv22Ax4HfLhl804E+E3Uk+bc7dz4f9@nongnu.org
X-Gm-Message-State: AOJu0YyLb62vdrMyTr2r5HE6O+e6RiHJi8eXRZp4YlN68VMWnVqllo2J
 ROrMKRkymsFmtBbDCp1LUJvOqLajg27ECflZCd9m/iPzkSfwuY50wBePfsQ87vtgeJRzQEpIJwP
 vyNEV1iWkkFVcOEABM0SaaRZgqK961zD7VhYq3sNMgwQv+nVbtJ9NvJVa
X-Gm-Gg: ASbGncucjQtv+R44nQ5U41BSJjOljThvViZW2uuSe2qaeJuGymLfrsBVQofu0oWfT8L
 oP0AWO9BFEQUkELXfLyKxMJVYYOtS+euv3VVPq685ns9CDubbSUvOqFKmhpxlJvUBIlFKGD+ow2
 KGqYNTsXBYFqJPV0Sjiyqa3tGDJGu8cH4V0UJy+gPPkn7Y0rErNOQocateYkLtp1BjZB1FCjJT9
 hBPCsDIuSJbBOJueRVFzqVMR4WF58jqiRjLCBF67NKUA0WsEr3wDOdMStIDPpCeJcnBownN0wt8
 +IV9VlNtI4b/PW1wEgB049ZzUirigY5HF3iLt79I0ubd56he8DL870Cv7O6gAM8kw+M6V0x2Qg=
 =
X-Received: by 2002:a05:6000:18a7:b0:3a5:1471:d885 with SMTP id
 ffacd0b85a97d-3b77678b79cmr8951668f8f.56.1753714601519; 
 Mon, 28 Jul 2025 07:56:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeg8JTfCliXSXnKJGPEcy50fyOw83AzHw1NSCsLF2Je5nJ7chushckVg/6WAMKTF4lay/mYA==
X-Received: by 2002:a05:6000:18a7:b0:3a5:1471:d885 with SMTP id
 ffacd0b85a97d-3b77678b79cmr8951642f8f.56.1753714600956; 
 Mon, 28 Jul 2025 07:56:40 -0700 (PDT)
Received: from [192.168.3.191] (228.246.150.77.rev.sfr.net. [77.150.246.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f08f3esm8980355f8f.43.2025.07.28.07.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 07:56:40 -0700 (PDT)
Message-ID: <53971ad6-9f50-45b0-80c4-eeedb24e53db@redhat.com>
Date: Mon, 28 Jul 2025 16:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/36] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
To: Michael Tokarev <mjt@tls.msk.ru>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250714080639.2525563-1-eric.auger@redhat.com>
 <20250714080639.2525563-10-eric.auger@redhat.com>
 <ddf6f9e3-daaa-4ea1-a5e6-d402a75524c8@tls.msk.ru>
 <914677f4-07ba-45fe-9dc2-dea40940e789@tls.msk.ru>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <914677f4-07ba-45fe-9dc2-dea40940e789@tls.msk.ru>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Michael,

On 7/28/25 11:07 AM, Michael Tokarev wrote:
> On 27.07.2025 14:48, Michael Tokarev wrote:
>> On 14.07.2025 11:04, Eric Auger wrote:
>>> gpex build_host_bridge_osc() and x86 originated
>>> build_pci_host_bridge_osc_method() are mostly identical.
>>>
>>> In GPEX, SUPP is set to CDW2 but is not further used. CTRL is
>>> same as Local0.
>>>
>>> So let gpex code reuse build_pci_host_bridge_osc_method() and remove
>>> build_host_bridge_osc().
>>>
>>> Also add an imply ACPI_PCI clause along with
>>> PCI_EXPRESS_GENERIC_BRIDGE to compile hw/acpi/pci.c when its
>>> dependency is resolved (ie. CONFIG_ACPI_PCI). This is requested
>>> to link qemu-system-mips64el.
>>
>> This patch somehow broke microvm-only build which is used by debian.
>>
>> configure options used (trimmed a bit):
>>
>> ../configure \ --without-default-features \ --target-list=x86_64-
>> softmmu \ --enable-kvm --disable-tcg \ --enable-pixman \ --enable-
>> vnc \ --audio-drv-list="" \ --without-default-devices \ --with-
>> devices-x86_64=microvm \ --enable-vhost-user
>>
>> configs/devices/x86_64-softmmu/microvm.mak: ---- cut ---- # see
>> configs/devices/i386-softmmu/default.mak # for additional devices
>> which can be disabled # CONFIG_PCI_DEVICES=n
>>
>> CONFIG_MICROVM=y
>>
>> CONFIG_VIRTIO_BLK=y CONFIG_VIRTIO_SERIAL=y CONFIG_VIRTIO_INPUT=y
>> CONFIG_VIRTIO_INPUT_HOST=y CONFIG_VHOST_USER_INPUT=y
>> CONFIG_VIRTIO_NET=y CONFIG_VIRTIO_SCSI=y CONFIG_VIRTIO_RNG=y
>> CONFIG_VIRTIO_CRYPTO=y CONFIG_VIRTIO_BALLOON=y CONFIG_VIRTIO_GPU=y
>> CONFIG_VHOST_USER_GPU=y ---- cut ----
>>
>> The result: FAILED: qemu-system-x86_64 cc -m64 @qemu-system-
>> x86_64.rsp /usr/bin/ld: libsystem.a.p/hw_pci-host_gpex-acpi.c.o: in
>> function `acpi_dsdt_add_host_bridge_methods': hw/pci-host/gpex-
>> acpi.c:83:(.text+0x274): undefined reference to
>> `build_pci_host_bridge_osc_method' collect2: error: ld returned 1
>> exit status
>
> In hw/i386/Kconfig, MICROVM selects ACPI_HW_REDUCED (not ACPI or
> ACPI_PCI), *and* PCI_EXPRESS_GENERIC_BRIDGE.  But in hw/pci/meson.build,
> pci.c (where the function in question is defined) is built when
> ACPI_PCI is enabled.  Something's not right here.
This commit added an imply ACPI_PCI to the PCI_EXPRESS_GENERIC_BRIDGE
config in hw/pci-host/Kconfig:

config PCI_EXPRESS_GENERIC_BRIDGE
    bool
    select PCI_EXPRESS  -> selects PCI
    imply ACPI_PCI

In hw/acpi/Kconfig we have:

config ACPI_PCI
    bool
    depends on ACPI && PCI

ACPI is selected by ACPI_HW_REDUCED

config ACPI_HW_REDUCED
    bool
    select ACPI
    select ACPI_MEMORY_HOTPLUG
    select ACPI_NVDIMM

so logically the ACPI && PCI dependencies for ACPI_PCI should be
resolved. What do I miss?
regards

Eric









>
> Addig kraxel for 24db877ab6e6 "microvm: add pcie support".
>
> Thanks
>
> /mjt
>


