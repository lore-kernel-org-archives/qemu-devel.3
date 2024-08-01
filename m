Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB95C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZDg-0007SZ-Vk; Thu, 01 Aug 2024 13:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZZDb-00075W-L5
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:04:02 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZZDX-0003rr-Rc
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:03:58 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5a3b866ebc9so10127005a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722531834; x=1723136634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YoYmXsRq3qE1c2bVOPeoI5CBf/nWG/tqLAsaxm/mGJs=;
 b=enVwQvYkDhEobbDCw4TRp49UpkMqEbo6aj4bhpUqjwR+gX64GPc5la7JFvBc8h6j80
 bdOessxoa3XFpVbUcz8BoNYuBhqxG2f4tWQKYN+Mz3N6cOgGknR8NEJ1KvIcRecXHu/B
 v2mv7YCdeOaaVZcC6hCNIjuOHSvMcpms4S0C4EHgFBbHMJIcaA1m3wOe7qu9VrtvwNkO
 6XsgKL3TYxjatCvtbKL5WMSxCftuu1Z4shbO/+ROVhRVbmb+cYAqBMYA3Y4tAdyU9Bqu
 lvAyKm8WDB/8+Phda+SzNxWg+Y2AYjn134Mx/F2U22SihBSEUdkXKdMp/Tz3xxkbM04J
 ORtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722531834; x=1723136634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YoYmXsRq3qE1c2bVOPeoI5CBf/nWG/tqLAsaxm/mGJs=;
 b=ZfzylUkdAR9lvbzwDwXrQenEleonsi4/pB+JYts1HCLTkAetnGfJEpvBo9Gk3qHDba
 HuI0zwk7J2ZGKpgvmUGNZ+fd1/BrfTdK/sna4cmhXIJItzCB2xeKrVSAWENrYbEF5evL
 F5yynLc/9muFEwSshq+0DLcRBB5HQl94X7TsIcKhV6VHKg8TpecUwB2nBshiSKGAQBk1
 TQaspluhCqQcXu0Y1XlBgo/bQVYpGTD3xFKZUMwyHRPoLQv385nbAY+4K7vLokqFPq0f
 JmsX4duIF6dVkFLU4p2w0S8PjbR7tYpkhQzm5QsNsVF9kP9yWxcFqUNZasiCj7CAWvBl
 rTQQ==
X-Gm-Message-State: AOJu0YzfREUUdrW98Ytiy8+adTdV5R/HC1U1RhGtLpVGqyWZp1D3cNxH
 ss0UQK9BaCICsyf57V5N+2GLZmVmrPzHTiWVc1mboAyV2wYaYWYi4uWoFt615HE=
X-Google-Smtp-Source: AGHT+IHUeIk3rr7mkNDJjNzguGNXTgnhMt5bUvzWyodaElnnMzgNgHPU6oAIQkPzmoavoCTbW3YjeA==
X-Received: by 2002:a17:907:7f24:b0:a7d:a29e:5c41 with SMTP id
 a640c23a62f3a-a7dc5029a1dmr66909366b.40.1722531833400; 
 Thu, 01 Aug 2024 10:03:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e841b6sm1439866b.168.2024.08.01.10.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 10:03:52 -0700 (PDT)
Message-ID: <0d19415f-4ec8-4089-b158-3cc3183232ed@linaro.org>
Date: Thu, 1 Aug 2024 19:03:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v3 1/2] hw/pci-host/gt64120: Reset config
 registers during RESET phase
To: "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
References: <20240801150021.52977-1-philmd@linaro.org>
 <20240801150021.52977-2-philmd@linaro.org>
 <5e765e4d-5314-0737-fccf-635d9365f796@eik.bme.hu>
 <20240801113646-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240801113646-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

+Peter who is tackling our Reset interface limitations,
+Daniel for deprecation advices.

On 1/8/24 17:37, Michael S. Tsirkin wrote:
> On Thu, Aug 01, 2024 at 05:30:38PM +0200, BALATON Zoltan wrote:
>> On Thu, 1 Aug 2024, Philippe Mathieu-Daudé wrote:
>>> Reset config values in the device RESET phase, not only once
>>> when the device is realized, because otherwise the device can
>>> use unknown values at reset.
>>>
>>> Mention the datasheet referenced. Remove the "Malta assumptions
>>> ahead" comment since the reset values from the datasheet are used.
>>>
>>> Reported-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> hw/pci-host/gt64120.c | 14 +++++++++++---
>>> 1 file changed, 11 insertions(+), 3 deletions(-)


>>> @@ -1231,8 +1238,9 @@ static void gt64120_pci_class_init(ObjectClass *klass, void *data)
>>> {
>>>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>>>
>>> -    k->realize = gt64120_pci_realize;
>>> +    rc->phases.hold = gt64120_pci_reset_hold;
>>
>> Why reset_hold and not a simple reset method which is more usual?

DeviceReset is deprecated since 4 years now, see commit c11256aa6f
("hw/core: add Resettable support to BusClass and DeviceClass") and
the effort to convert the legacy interface to this new API:

$ git log --oneline |egrep -i 'convert.*(Resettable|3.*phase)'
cee78fa513 hw/arm/stellaris: Convert I2C controller to Resettable interface
bebd89e166 hw/arm/stellaris: Convert ADC controller to Resettable interface
ead17ebf53 hw/intc/pxa2xx: Convert to Resettable interface
d43e967f69 q800-glue.c: convert to Resettable interface
4dd5cb5d84 hw/pci-host/bonito: Convert to 3-phase reset
a0c2e80afc hw/pci-host/pnv_phb3_msi: Convert TYPE_PHB3_MSI to 3-phase reset
a359da4c62 hw/intc/xics: Convert TYPE_ICS to 3-phase reset
f4c636b0c2 pci: Convert child classes of TYPE_PCIE_ROOT_PORT to 3-phase 
reset
bb27210c8c pci: Convert TYPE_PCIE_ROOT_PORT to 3-phase reset
0d89890466 hw/display/virtio-vga: Convert TYPE_VIRTIO_VGA_BASE to 
3-phase reset
54da41834f hw/virtio: Convert TYPE_VIRTIO_PCI to 3-phase reset
d66e64dd00 target/xtensa: Convert to 3-phase reset
efcc10682e target/tricore: Convert to 3-phase reset
3b4fff1bd5 target/sparc: Convert to 3-phase reset
9049383002 target/sh4: Convert to 3-phase reset
88c41e4082 target/rx: Convert to 3-phase reset
4fa485a78e target/riscv: Convert to 3-phase reset
a1c5d644b7 target/ppc: Convert to 3-phase reset
0409750479 target/openrisc: Convert to 3-phase reset
4245a71662 target/nios2: Convert to 3-phase reset
c08dfb7ae2 target/mips: Convert to 3-phase reset
d4bc6c1a79 target/microblaze: Convert to 3-phase reset
bf90b345d7 target/m68k: Convert to 3-phase reset
f78b49ae8d target/loongarch: Convert to 3-phase reset
e86787d33b target/i386: Convert to 3-phase reset
ab85156d8a target/hexagon: Convert to 3-phase reset
1d2eb1c0c5 target/cris: Convert to 3-phase reset
605787606e target/avr: Convert to 3-phase reset
9130cade5f target/arm: Convert to 3-phase reset
3b750f1b1a hw/core/cpu-common: Convert TYPE_CPU class to 3-phase reset
ed053e8997 hw/misc: Convert TYPE_MOS6522 subclasses to 3-phase reset
8bdaed0f30 hw/misc/mos6522: Convert TYPE_MOS6522 to 3-phase reset
fc2fc3c1ed hw/input/ps2.c: Convert TYPE_PS2_{KBD, MOUSE}_DEVICE to 
3-phase reset
2bb3f93037 hw/input/ps2: Convert TYPE_PS2_DEVICE to 3-phase reset
227b5866c0 hw/intc: Convert TYPE_KVM_ARM_ITS to 3-phase reset
1bcb90762b hw/intc: Convert TYPE_ARM_GICV3_ITS to 3-phase reset
1f6887616f hw/intc: Convert TYPE_ARM_GICV3_ITS_COMMON to 3-phase reset
823300f0fc hw/intc: Convert TYPE_KVM_ARM_GICV3 to 3-phase reset
183cac319e hw/intc: Convert TYPE_ARM_GICV3_COMMON to 3-phase reset
d39270b559 hw/intc: Convert TYPE_ARM_GIC_KVM to 3-phase reset
fe3c6174f2 hw/intc: Convert TYPE_ARM_GIC_COMMON to 3-phase reset
503819a347 hw/arm: Convert TYPE_ARM_SMMUV3 to 3-phase reset
3c1a7c4197 hw/arm: Convert TYPE_ARM_SMMU to 3-phase reset
ef4989b0a8 hw/gpio/pl061: Convert to 3-phase reset and assert GPIO lines 
correctly on reset
fae5a04207 hw/rtc/mc146818rtc: Convert to 3-phase reset (Resettable 
interface)
72fe4742c6 hw/timer/etraxfs_timer: Convert to 3-phase reset (Resettable 
interface)

Peter, Daniel, do we have a way to hint developers about
deprecated API uses (like for versioned machines macros,
commit a35f8577a0 "hw: add macros for deprecation & removal
of versioned machines"), to settle on a release when API
must be converted by?

> Good point.And I'd keep it limited, e.g. wmask can be set once,
> no need to tweak it on reset.

I'll set wmask in the DeviceRealize handler.

Thanks,

Phil.

