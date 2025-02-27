Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC97FC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngO5-00051z-5F; Thu, 27 Feb 2025 11:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tngMv-0004Yy-Gj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:04:17 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tngMt-0007zm-DD
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:04:13 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-22114b800f7so23432925ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740672249; x=1741277049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1DILyirHrel6WMBzcQk+h/fm6lJ3uSL02z1Trx80nMs=;
 b=Uov4ICAy4nxtno6DhQgKTwxOYb/qjb9irlzZon86IAiTuaTfdUnujVq+Wwg/EHtFky
 AnEXDcfRMT12cR+SpMAkIc8s6N8jlVZU/urz+kIyqfXFc1n+qP6MnbXl0ONtyawmm3Y1
 GbfOtR9E+iqn4GW29dbx2hWrLnPl4kIYlDHJ7MbFhfca29oBDjVlkQO3nJxV0tRHj8ya
 lW/wEoHRChSNlbv5ym9QhelOIdqDE3Bnt/ZyQvWJNdMBD8+GGkbx6GUseVuBx4r+/81g
 ytsZHkpCESv4kaSTzVrVpIJfgwhf46D1TsAbi871xyRmb4G1zXm3YYSO5u6ESpGgZeGl
 5kxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740672249; x=1741277049;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1DILyirHrel6WMBzcQk+h/fm6lJ3uSL02z1Trx80nMs=;
 b=o8JWCLCYp7PkPltsYvAL7LJ78dRgZ5XAAAQNp3S9FEY3+WZE+AoL15yB8q4nm7nIVN
 q53EX96Jmlhuu6tsoX2ZX+5nte0LXp8LncnPs0LqMC3tk4dvkOITZhCvu/We7Mf3I5SQ
 r2kUoCabmw9pBdW9wZp3y3n7MmthP/FlRgfhA4xuuD7DqlkIH4fior5JDGLVIjIZfKJm
 L4TkhCWvSGOa96N1JGIUJyrhteFjY5f5KDu77DJx81++CGdrr3DztUkVi0dOmExeAogT
 Iq677jTzTvjYRl0hZgL6iwxv9JZnwtMXM2PPjy8eJgyms4lke4bMry5zg4vcxuQFsyU9
 xyGw==
X-Gm-Message-State: AOJu0YyLkfgVGaXozVnGgcJKRaxI8A27NccSBNX05uIBasyVyUbzNj+2
 ac7/afk22ahoZlO09LRH0M4X20h7Mk+d1qwfouYdsWTfpTh/pGRdF3Kf+iICdw==
X-Gm-Gg: ASbGnctQciOEUBppn056o7mEqpPudQn4d1B9AbeBx4MQ6ckNk+LWRBLSm4RGyFjZgb+
 dInCxJGkQItTWGeII8UyabwFfBfjnp8t+LIk2VIhL3fUaVyWZ6YI13HiQrlfC9r6Kn89n1viQEv
 awZOShit47WGoM/EWEh9tqU+GO0WQ/FSGtcQa5fl8J4O75wkUK9OBBSABBne4fbzOBw3y4es4fq
 NzD42oEXEvm1MjAidtKpGpC7S/9zEOqglfY91LlsLLKZLK2Ko2kq95EtgsM02yCxZ6A20Xzhb73
 Utdz4T1CkIt7+WCy2TYch/gMRBWQGkA=
X-Google-Smtp-Source: AGHT+IF25ZBQFyDCD7Vh2o6BjhzDXyWGtaXIDgyVITcLlYPWUXn8uDbAXC3FNVWz5IvQlD4eO0jlag==
X-Received: by 2002:a05:6a00:2e1e:b0:725:df1a:285 with SMTP id
 d2e1a72fcca58-7348bdd003bmr12544044b3a.12.1740672248848; 
 Thu, 27 Feb 2025 08:04:08 -0800 (PST)
Received: from [192.168.0.113] ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a0024b98sm1828266b3a.108.2025.02.27.08.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 08:04:08 -0800 (PST)
Message-ID: <14c1a116-2833-4a5b-812a-4477ef11f79e@gmail.com>
Date: Fri, 28 Feb 2025 00:03:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] vfio/igd: Remove legacy mode
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <corvin.koehne@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
 <4a8bcc23-8090-4877-86b2-e5ac126a6cb4@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <4a8bcc23-8090-4877-86b2-e5ac126a6cb4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
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

Hello Cédric,

On 2/27/25 16:28, Cédric Le Goater wrote:
> Hello Tomita,
> 
> +Corvin
> 
> On 2/24/25 19:29, Tomita Moeko wrote:
>> This patchset removes some legacy checks and converts the legacy mode
>> implicitly enabled by BDF 00:02.0 into x-igd-* options, including:
>> * Removing PCI ROM BAR and VGA IO/MMIO range check before applying quirk
>> * Using unified x-igd-opregion option for OpRegion access.
>> * Introducing new x-igd-lpc option for the LPC bridge / Host bridge ID
>>    quirk. Currently this is only supported on i440fx.
>> * Extending quirk support when IGD is not assigned to BDF 00:02.0
>>
>> The first 2 patches of this patchset was taken from a previous one,
>> details can be found at:
>> https://lore.kernel.org/all/20250124191245.12464-1-tomitamoeko@gmail.com/
>>
>> This patchest was mainly tested on Alder Lake UHD770, with Debian 12
>> (kernel 6.1), Windows 11 (driver 32.0.101.6458) and Intel GOP driver
>> 17.0.1081.
> 
> Did you try a Linux guest ?
> 
> Could you provide the QEMU command line please ? I would like to
> reproduce on the AlderLake-S GT1 system I have access to.

Ofcourse I did. The command line I used is:
./qemu-system-x86_64 --enable-kvm \
  -cpu host -smp 4 -m 8G -nodefaults -serial mon:stdio \
  -device vfio-pci,host=00:02.0,id=hostdev0,addr=0x2,x-igd-opregion=on \
  -drive id=drive0,if=none,file=debian-vm.qcow2,format=qcow2 \
  -netdev bridge,id=net0,br=br0 \
  -device virtio-blk-pci,drive=drive0,id=virtio-blk-pci0,addr=0x3 \
  -device virtio-net-pci,netdev=net0,addr=0x4 \
  -usb -device usb-host,hostbus=1,hostaddr=5 \
  -pflash /usr/share/OVMF/OVMF_CODE_4M.fd

My guest is running Debian 11 with 6.1.0-31 kernel. Screenshot at
https://imgur.com/a/gsHBpnn

As there is no EFI GOP driver, display can only work after i915 driver
initialized it. For Linux guest, x-igd-opregion=on is not a must as
init_vbt_missing_defaults in i915 driver mocks one if VBT in OpRegion
is not present. Looks like most desktop motherboards follows that intel
default display output configuration.

Note that currently IGD passthrough quirks only takes effect when IGD
is exposed as VGA controller, that is to say, the primary GPU must be
set to IGD in host BIOS.

Btw, If your IGD device is exposed as Display Controller, you may also
try the kernel patch at [1], and remove the vfio_is_vga check in qemu
igd.c. I'm going to make a correspoding change in qemu side after that
kernel patch gets merged.

[1] https://lore.kernel.org/all/20250123163416.7653-1-tomitamoeko@gmail.com/

If it is still not working, adding drm_debug=0x02 in kernel cmdline
enables verbose log. Related options are "Bit 1 (0x02)  will enable
DRIVER messages (drm controller code)" and  "Bit 2 (0x04)  will enable
KMS messages (modesetting code)", 0x06 for both of them.

> Also, since you spent quite of lot time on IGD support, would you
> mind adding a vfio-igd entry in the MAINTAINERS file and propose
> your self as a maintainer ? The aim would be to keep you informed
> of the proposed changes on the vfio-igd device, not to handle PRs.

Sure, I'd be glad to be a maintainer.

>> If the design is good to go, I will update the documentation also.
> 
> yes please.

I will add the documentation in v2. For now, let me wait for Alex
comment first.

Thanks,
Moeko

>> A open question is whether the old legacy mode behavior should be kept
>> or not. Checking if all the condition of legacy mode were met and
>> toggling correspoding options is more complicated then I expected :(
>> Any ideas would be appreciated.
> 
> I will let Alex comment,
> 
> Thanks,
> 
> C.
> 
>  
>> Tomita Moeko (10):
>>    vfio/igd: Remove GTT write quirk in IO BAR 4
>>    vfio/igd: Do not include GTT stolen size in etc/igd-bdsm-size
>>    vfio/igd: Remove rombar check for legacy mode
>>    vfio/igd: Remove implicit VGA access enabled by legacy mode
>>    vfio/pci: Make vfio_populate_vga static
>>    vfio/igd: Consolidate OpRegion initialization into a single function
>>    vfio/igd: Move LPC bridge initialization to a separate function
>>    vfio/pci: Add placeholder for device-specific config space quirks
>>    vfio/igd: Refactor vfio_probe_igd_bar4_quirk into pci config quirk
>>    vfio/igd: Replace legacy mode with options
>>
>>   hw/vfio/igd.c        | 476 ++++++++++++++-----------------------------
>>   hw/vfio/pci-quirks.c |  51 +----
>>   hw/vfio/pci.c        |  33 +--
>>   hw/vfio/pci.h        |  12 +-
>>   4 files changed, 166 insertions(+), 406 deletions(-)
>>
> 

