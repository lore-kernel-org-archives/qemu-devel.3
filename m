Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE359CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 16:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNZQ2-0002BU-TU; Mon, 24 Nov 2025 11:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNZQ0-0002B5-Ln
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 11:28:00 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNZPx-0003yk-BS
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 11:28:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso28828615e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764001675; x=1764606475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T2dwCYYa3ervrITpiwB3L7hO3YrvKF+imZwiyIl1FPE=;
 b=YqChycif/QXd00b8/B6Y6y46pfdNMqtS0bnHlQlO5qBzwIkt8t0Tn4bj5kvK2YBx9Q
 DNCNFkBy5BwS1asFm6KlnSnWfo+kY0XPo7lfwXvFcjLy7fL7mZmxKXBpXhjCY83Lhua0
 8ZAxMqz2oedM0YJyesACw75YtW0JJWaZewIn3FntHh6RH5P/tnCqaX+5iy/zcD9o4v/M
 B7bSBaaTGkjiYy8Al5i0JYdXbe06yx2Uog/YjXCNfYqkXsa/6o0kIz5Naoo3l3lfzueT
 YG78EdWSqE+jbO2Ocn38ZBWuSemF/7CIGfR+T8pBmtXylhsLp3t43I7NT1lbIgNm4RyZ
 FsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764001675; x=1764606475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2dwCYYa3ervrITpiwB3L7hO3YrvKF+imZwiyIl1FPE=;
 b=LsC3bSo0Y2wzHCi9M8THagzcgBOfgsH1YY5zBSV28pRaG9Jz63tiM9RUjVqkqNzOPf
 QLmvTNL2CiBYrzMUh5WU0Ni6hF6sYsAQZi4b1tW7tQ591NC6s8G3xX/uv9glLlPL5rp0
 xzF+pY3zinBH0MBkEFdICTkQzkHY5gdDHNXahWdMFsx//9HsgVI9UF3ARgWdwAx8tjab
 ZAee0BtqwADnbKC8u15iwvIIvhMrT2oqJF1mZA2YfuL0V+19We7i5ZcJCtaNZBZzjIiR
 MYviUbyjAK7Pq/XQy+FAh08S8sRRK1EAEWYxxj5OFjKSqBOvXk1nGPM47TKuqC7f1rav
 lcPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsuIDi6dNrMT92JsTvyNRdDpQGmCwhoA4urfg+RBqKFC5Ud+AbMyRnKaeSBLxcYq/tmRYjnHVIq1GW@nongnu.org
X-Gm-Message-State: AOJu0YxNcaxWfNErvqiftMoYKlp0MR+4+gwVFgk2JnYcPKMHs8fro2TM
 LC0cn4Q+uRCDDpXTBGAWpQElRzefOImp07nzQoKY5x13WfVh0FSyj89XjZADECx59EE=
X-Gm-Gg: ASbGncvIj+4NQaBsMqiBDJZdqTN4wK642/zql70bbogGILjCxoIBuMHcjuAaxuBfoDz
 t6j0u+6FsourKiHfjqVMYJgWK7zQzsSW9wX1S3GNhlRoGtnfN868e3S27eMGn1vC8jBea8WyK3t
 bd+KELklyQKiOsdTWsv5PWMYKTn06gJ+RvFq8x44JSnC1sB2brRYNVJLhrtcGcDovZt0CRRRF3j
 4o8SDALl7M0ZXTUsNRw82KDEEQdOGvJY3tN3cyRCQJ36CQpY5qvANsfJM+1QgMw7I+/tJElciou
 b5Y4bGMNRW+sc+DB//O+N9aH34zmzmvJ7U9JVCPUhltS56XftFSgaT8AW5HDxj5Hd84fDS5rpo3
 nBczH+KHRDwY130xtM9/Y3hH9Y1mlvSkJgxdnLO1WTWBixZ/DAYv60hR2iYaX+unSfr6dFtO5IL
 B26bGH6uYAJ+UjnCSf23gZD6Vd2UI2f6LctCwy4aBB6m8PSStkvyUA5Q==
X-Google-Smtp-Source: AGHT+IEXCz2cVSU0+M6kSXnTBmxIikzPHTzSN1ZW6//OUB6uEoZqwrEr69CCMC0cN1nTljQJ44i4Iw==
X-Received: by 2002:a05:600c:4f45:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-477c04db9a0mr133970575e9.8.1764001675374; 
 Mon, 24 Nov 2025 08:27:55 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3558d5sm203524175e9.1.2025.11.24.08.27.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 08:27:54 -0800 (PST)
Message-ID: <cd027328-a4d0-4052-acb6-56af1122535b@linaro.org>
Date: Mon, 24 Nov 2025 17:27:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 2/2] hw/pci: Rename PCIDeviceClass::exit() ->
 PCIDeviceClass::unrealize()
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20251124103244.78932-1-philmd@linaro.org>
 <20251124103244.78932-3-philmd@linaro.org>
 <9f13fc0a-c5d8-3e73-0ec9-a6d3498888ce@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9f13fc0a-c5d8-3e73-0ec9-a6d3498888ce@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 24/11/25 14:56, BALATON Zoltan wrote:
> On Mon, 24 Nov 2025, Philippe Mathieu-Daudé wrote:
>> Commit 7ee6c1e182c ("pci: Permit incremental conversion of
>> device models to realize") renamed:
>>
>>  PCIDeviceClass::init() -> PCIDeviceClass::realize()
>>
>> Finish the conversion by renaming the counter part
>>
>>  PCIDeviceClass::exit() PCIDeviceClass::unrealize()
>>
>> This clarifies the handler is called during the DeviceUnrealize
>> path, not during Object destruction in instance_finalize().
>>
>> Manual change adapting style when needed.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/hw/pci/pci.h                |  1 -
>> include/hw/pci/pci_device.h         |  3 ++-
>> hw/audio/ac97.c                     |  8 ++++----
>> hw/audio/es1370.c                   |  8 ++++----
>> hw/audio/intel-hda.c                |  8 ++++----
>> hw/audio/via-ac97.c                 |  4 ++--
>> hw/char/diva-gsp.c                  |  6 +++---
>> hw/char/serial-pci-multi.c          |  8 ++++----
>> hw/char/serial-pci.c                |  4 ++--
>> hw/cxl/switch-mailbox-cci.c         |  4 ++--
>> hw/display/ati.c                    |  8 ++++----
>> hw/display/bochs-display.c          |  4 ++--
>> hw/display/vga-pci.c                |  4 ++--
>> hw/ide/cmd646.c                     |  4 ++--
>> hw/ide/ich.c                        |  4 ++--
>> hw/ide/piix.c                       |  6 +++---
>> hw/ide/via.c                        |  4 ++--
>> hw/mem/cxl_type3.c                  |  4 ++--
>> hw/misc/edu.c                       |  4 ++--
>> hw/misc/ivshmem-pci.c               |  4 ++--
>> hw/misc/pci-testdev.c               |  5 ++---
>> hw/net/can/can_kvaser_pci.c         |  4 ++--
>> hw/net/can/can_mioe3680_pci.c       |  4 ++--
>> hw/net/can/can_pcm3680_pci.c        |  4 ++--
>> hw/net/can/ctucan_pci.c             |  4 ++--
>> hw/net/e1000.c                      |  5 ++---
>> hw/net/e1000e.c                     |  4 ++--
>> hw/net/eepro100.c                   |  8 ++++----
>> hw/net/igb.c                        |  4 ++--
>> hw/net/igbvf.c                      |  4 ++--
>> hw/net/ne2000-pci.c                 |  4 ++--
>> hw/net/pcnet-pci.c                  |  4 ++--
>> hw/net/rocker/rocker.c              |  4 ++--
>> hw/net/rtl8139.c                    |  4 ++--
>> hw/net/sungem.c                     |  4 ++--
>> hw/net/tulip.c                      |  4 ++--
>> hw/net/vmxnet3.c                    |  4 ++--
>> hw/nvme/ctrl.c                      |  4 ++--
>> hw/pci-bridge/cxl_downstream.c      |  4 ++--
>> hw/pci-bridge/cxl_root_port.c       |  2 +-
>> hw/pci-bridge/cxl_upstream.c        |  4 ++--
>> hw/pci-bridge/gen_pcie_root_port.c  |  2 +-
>> hw/pci-bridge/pci_bridge_dev.c      |  4 ++--
>> hw/pci-bridge/pci_expander_bridge.c |  8 ++++----
>> hw/pci-bridge/pcie_pci_bridge.c     |  4 ++--
>> hw/pci-bridge/pcie_root_port.c      |  4 ++--
>> hw/pci-bridge/simba.c               |  2 +-
>> hw/pci-bridge/xio3130_downstream.c  |  4 ++--
>> hw/pci-bridge/xio3130_upstream.c    |  4 ++--
>> hw/pci-host/designware.c            |  2 +-
>> hw/pci-host/xilinx-pcie.c           |  2 +-
>> hw/pci/pci.c                        |  4 ++--
>> hw/remote/proxy.c                   |  4 ++--
>> hw/riscv/riscv-iommu-pci.c          |  4 ++--
>> hw/scsi/esp-pci.c                   |  4 ++--
>> hw/scsi/lsi53c895a.c                |  4 ++--
>> hw/scsi/megasas.c                   |  4 ++--
>> hw/scsi/mptsas.c                    |  4 ++--
>> hw/scsi/vmw_pvscsi.c                | 10 ++++------
>> hw/sd/sdhci-pci.c                   |  4 ++--
>> hw/ufs/ufs.c                        |  4 ++--
>> hw/usb/hcd-ehci-pci.c               |  4 ++--
>> hw/usb/hcd-ohci-pci.c               |  8 ++++----
>> hw/usb/hcd-uhci.c                   |  4 ++--
>> hw/usb/hcd-xhci-pci.c               |  4 ++--
>> hw/vfio/pci.c                       |  4 ++--
>> hw/virtio/virtio-pci.c              |  4 ++--
>> hw/watchdog/wdt_i6300esb.c          |  4 ++--
>> hw/xen/xen_pt.c                     |  4 ++--
>> 69 files changed, 151 insertions(+), 155 deletions(-)
>>
> [...]
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index f7c0006a879..6b9f06b6b36 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -948,7 +948,7 @@ static const MemoryRegionOps ati_mm_ops = {
>>     .endianness = DEVICE_LITTLE_ENDIAN,
>> };
>>
>> -static void ati_vga_realize(PCIDevice *dev, Error **errp)
>> +static void ati_vga_pci_realize(PCIDevice *dev, Error **errp)
> 
> Why rename this?
> 
>> {
>>     ATIVGAState *s = ATI_VGA(dev);
>>     VGACommonState *vga = &s->vga;
>> @@ -1032,7 +1032,7 @@ static void ati_vga_reset(DeviceState *dev)
>>     s->mode = VGA_MODE;
>> }
>>
>> -static void ati_vga_exit(PCIDevice *dev)
>> +static void ati_vga_pci_unrealize(PCIDevice *dev)
> 
> Can you just call it ati_vga_unrealize like in other devices?

Sure, will do in v2.


