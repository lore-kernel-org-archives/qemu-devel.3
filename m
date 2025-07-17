Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B6CC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLnF-0001vD-BV; Thu, 17 Jul 2025 06:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ucLnB-0001sm-J9; Thu, 17 Jul 2025 06:24:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ucLn9-00081E-Eq; Thu, 17 Jul 2025 06:24:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so5429935e9.2; 
 Thu, 17 Jul 2025 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752747881; x=1753352681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=iDkLruCjaACSk3OsJ4aa2qN5ilaONt7yxXecg7QGufI=;
 b=QqiY/mSQni3IkI6NWFLtkzfM50klWKq+VYsxsLf7uEkOSMd/IVrIxp2iwMLptI8XyA
 ph7GfRHFE2/+oTHUljcS4CACFjQ0QSOxp+D8iSiVWISnmJ89ZmJLP3+TDEZJUiJkAG+D
 JDKIBJZDrtL0o4dcvQC8SpsOns8EDLJTg5mCjBZ0Pq4aZPaGbLyES+kjs+1tHxg9NjqV
 PUp9SUTSbY/6/kgl+AokgDNyF2miX6VdkjAZzGObpXSxyzsQlVu0yzL5mm2LGMpnIbHi
 gAjWOV1HlktlDmWNheAY5ixedkzPlYjJJMCEWoKzFPPQSdRhH+MMD+r/JAB9cky8mmbe
 fW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752747881; x=1753352681;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDkLruCjaACSk3OsJ4aa2qN5ilaONt7yxXecg7QGufI=;
 b=KCRcTPc8mV5ygW3XiSI4gC3+77DuN5bXjRkS1OeR6aNlYFrA6GL9l/qEZSZsMGcwyZ
 o6zr05q5iI6qStbG4aKyh0kI6L4DBOrvtN8Xxfkp3Nro5FBpi8gu3YNFDoLgDnzjhVyl
 k0lrO6GhmTyHkXhKgpAjgV1kvu9mwYRWqWIbxr7FwFtswansUs9Vw+A4lpNiA1QYmfew
 nDF3by798UEJJIWLB2j3sa86//KSc+LkWc2Qa52Abf6PbDkuUGqGJ2Whi+Zlbxa3lYWT
 5V12p4OK6P1ZR9TR2cxwcTc+EpXwnKu3vS/KSCYsksXHdVDIPyy/ztFyluHKK2UqIB8y
 9PLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOw50HRAb3RX7eOsKZRxXsBYpZihXdA9ngHE86NmCfeu9Z2RPnjTTupmOJiOFJ6h0WXSulRxUjkp2OYQ==@nongnu.org,
 AJvYcCVcUq+5chNMc1P7DqFkLtwwGGORCddZ7JZM9VD3V5mdoZVQz+WXAoJyQ1IRPACUHr7LOtsAIyRbXA==@nongnu.org
X-Gm-Message-State: AOJu0YybWXyeKG6HdTUA+w4F9WPpPlts8R7mdIXWs88Q0snCh/UoMJgl
 z2FfTByGlk9mAcWRCj1kQeBK+lKpUmdCK5ZQQG1Muu2bMQRWESOYD1nZ
X-Gm-Gg: ASbGncu/GDxXgsn9NIhYmCAwIMNJSNlrzQj3vPY2c0cMooYKXThycElgv1yfVAI4Kjr
 sTYsQhmK+AG22jM0PxqJazqwsAGZfcO1QNBtsvmFudbynZaQe9ojNhFj4Zh0P2ShPef90ICMpLR
 DSgV8pnJp2NdB6/3+ms4X8jOQ9UAfOT+CqHlxoxdfjfccM1t7qpzXsVpDCPl394vWRL6Qv9ToGc
 LlkPU8leXIwoXrQgptKrDPs5fF0aR+QB2LnoNR2/zQVe1OsNrIum32mfiNP/A6+fcxX7h+N4m63
 dTMiiCZeBSpXb7Gje1PeZozLPX/0uuDlDfL3C8pthPISWk/muGwOVKCdZ/sitf3s1AHkvDweXoR
 VzzQ4G709BYL6PhWSI4ZfgouNxOM=
X-Google-Smtp-Source: AGHT+IFentCCnT9+NK/vAg8pgh5FnIb7qaKt7FTOqSARnyOpfXR90kGFG/RzyanFg2/O5hMdpB4vLQ==
X-Received: by 2002:a05:600c:8b28:b0:456:1e5a:8879 with SMTP id
 5b1f17b1804b1-4562e341199mr64746805e9.9.1752747880450; 
 Thu, 17 Jul 2025 03:24:40 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45634f6bc51sm18164045e9.17.2025.07.17.03.24.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 03:24:40 -0700 (PDT)
Date: Thu, 17 Jul 2025 10:24:32 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: zhangzhijie <zhangzhijie@bosc.ac.cn>, qemu-devel@nongnu.org,
 wangran@bosc.ac.cn, zhangjian@bosc.ac.cn, peter.maydell@linaro.org,
 andrew.smirnov@gmail.com, qemu-arm@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1=5D_PCIE-Host_Support_64?=
 =?US-ASCII?Q?Bit_resource_for_DesignwarePCIEHost?=
In-Reply-To: <0029ad6d-c25e-46d3-be2f-5d23087df287@bosc.ac.cn>
References: <20250715064400.2289152-1-zhangzhijie@bosc.ac.cn>
 <631BA6B2-268F-4DDC-9DA6-77697373A5DF@gmail.com>
 <0029ad6d-c25e-46d3-be2f-5d23087df287@bosc.ac.cn>
Message-ID: <03BC71CC-647D-418E-88A3-7D66D858D2B5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 17=2E Juli 2025 00:51:28 UTC schrieb zhangzhijie <zhangzhijie@bosc=2Eac=
=2Ecn>:
>
>
>=E5=9C=A8 2025/7/17 1:53, Bernhard Beschow =E5=86=99=E9=81=93:
>>=20
>>=20
>> Am 15=2E Juli 2025 06:44:00 UTC schrieb zhangzhijie <zhangzhijie@bosc=
=2Eac=2Ecn>:
>>> 0=2E DW pcie support 64bit resource
>>> 1=2E DW version type using Linux kernel
>>=20
>> Which machines in QEMU require this change?
>>=20
>after support 64bit resource, will support on riscv

Nice=2E Is there a datasheet (standalone or for the riscv SoC using this I=
P block) which you could provide? The QEMU emulation has some bugs which I'=
d like to fix=2E

>>>=20
>>> Signed-off-by: zhangzhijie <zhangzhijie@bosc=2Eac=2Ecn>
>>> ---
>>> hw/pci-host/designware=2Ec         | 12 +++++++++---
>>> include/hw/pci-host/designware=2Eh |  2 +-
>>> 2 files changed, 10 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/hw/pci-host/designware=2Ec b/hw/pci-host/designware=2Ec
>>> index f6e49ce9b8=2E=2E99d791c0a7 100644
>>> --- a/hw/pci-host/designware=2Ec
>>> +++ b/hw/pci-host/designware=2Ec
>>> @@ -41,6 +41,8 @@
>>> #define DESIGNWARE_PCIE_MSI_INTR0_ENABLE           0x828
>>> #define DESIGNWARE_PCIE_MSI_INTR0_MASK             0x82C
>>> #define DESIGNWARE_PCIE_MSI_INTR0_STATUS           0x830
>>> +#define PCIE_VERSION_NUMBER                        0x8F8
>>> +#define PCIE_VERSION_TYPE                          0x8FC
>>> #define DESIGNWARE_PCIE_ATU_VIEWPORT               0x900
>>> #define DESIGNWARE_PCIE_ATU_REGION_INBOUND         BIT(31)
>>> #define DESIGNWARE_PCIE_ATU_CR1                    0x904
>>> @@ -144,6 +146,10 @@ designware_pcie_root_config_read(PCIDevice *d, ui=
nt32_t address, int len)
>>>      uint32_t val;
>>>=20
>>>      switch (address) {
>>> +    case PCIE_VERSION_NUMBER:
>>> +    case PCIE_VERSION_TYPE:
>>> +        val =3D 0x3534302a;
>>> +        break;
>>>      case DESIGNWARE_PCIE_PORT_LINK_CONTROL:
>>>          /*
>>>           * Linux guest uses this register only to configure number of
>>> @@ -427,7 +433,7 @@ static void designware_pcie_root_realize(PCIDevice=
 *dev, Error **errp)
>>>          viewport->inbound =3D true;
>>>          viewport->base    =3D 0x0000000000000000ULL;
>>>          viewport->target  =3D 0x0000000000000000ULL;
>>> -        viewport->limit   =3D UINT32_MAX;
>>> +        viewport->limit   =3D UINT64_MAX;
>>>          viewport->cr[0]   =3D DESIGNWARE_PCIE_ATU_TYPE_MEM;
>>>=20
>>>          source      =3D &host->pci=2Eaddress_space_root;
>>> @@ -451,7 +457,7 @@ static void designware_pcie_root_realize(PCIDevice=
 *dev, Error **errp)
>>>          viewport->inbound =3D false;
>>>          viewport->base    =3D 0x0000000000000000ULL;
>>>          viewport->target  =3D 0x0000000000000000ULL;
>>> -        viewport->limit   =3D UINT32_MAX;
>>> +        viewport->limit   =3D UINT64_MAX;
>>>          viewport->cr[0]   =3D DESIGNWARE_PCIE_ATU_TYPE_MEM;
>>>=20
>>>          destination =3D &host->pci=2Ememory;
>>> @@ -558,7 +564,7 @@ static const VMStateDescription vmstate_designware=
_pcie_viewport =3D {
>>>      =2Efields =3D (const VMStateField[]) {
>>>          VMSTATE_UINT64(base, DesignwarePCIEViewport),
>>>          VMSTATE_UINT64(target, DesignwarePCIEViewport),
>>> -        VMSTATE_UINT32(limit, DesignwarePCIEViewport),
>>> +        VMSTATE_UINT64(limit, DesignwarePCIEViewport),
>>>          VMSTATE_UINT32_ARRAY(cr, DesignwarePCIEViewport, 2),
>>>          VMSTATE_END_OF_LIST()
>>>      }
>>> diff --git a/include/hw/pci-host/designware=2Eh b/include/hw/pci-host/=
designware=2Eh
>>> index a35a3bd06c=2E=2E6e06f54801 100644
>>> --- a/include/hw/pci-host/designware=2Eh
>>> +++ b/include/hw/pci-host/designware=2Eh
>>> @@ -46,7 +46,7 @@ typedef struct DesignwarePCIEViewport {
>>>=20
>>>      uint64_t base;
>>>      uint64_t target;
>>> -    uint32_t limit;
>>> +    uint64_t limit;
>>>      uint32_t cr[2];
>>>=20
>>>      bool inbound;
>

