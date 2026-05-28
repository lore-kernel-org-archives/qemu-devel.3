Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6235ECD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 11:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSYqV-0002bt-6i; Thu, 28 May 2026 07:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wSYqH-0002Uq-Ja
 for qemu-devel@nongnu.org; Thu, 28 May 2026 07:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wSYqF-0004vh-H4
 for qemu-devel@nongnu.org; Thu, 28 May 2026 07:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779967437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vEc99dVBYHFovn4jM6dMr8Mo0YEo+VlxEaTA/0juKnM=;
 b=CVL7R/Qbf1Sqz7kWxuK2d0CcOl6ICkTrBGR8u5Cm1ng2t4SZQ7xRsfR8sHTedV1LyCLipL
 i2tddf3UakBmtKYpa9VKdYXgrmSl2Dd2pk8jew0vUPLc58dAGF7PDPzsUV5G1aPMj+UP8N
 ravBVty4hzCPvEQTzjiOuabAI3DWEFo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-mE5cTBsENnuCM_xa2cWvZQ-1; Thu, 28 May 2026 07:23:54 -0400
X-MC-Unique: mE5cTBsENnuCM_xa2cWvZQ-1
X-Mimecast-MFC-AGG-ID: mE5cTBsENnuCM_xa2cWvZQ_1779967432
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso8497691f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779967432; x=1780572232; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=vEc99dVBYHFovn4jM6dMr8Mo0YEo+VlxEaTA/0juKnM=;
 b=WBTNkJal27h1fGvkfIY/n+ZnhjGWv0OCftrzr5Zk2wqxym7icEm1FD16ouWxv4rcGz
 LWvtQYrLvEV+c4AJf6AOZ4zPLiX5oac0dbOJlhn0m/0sDpyQK3ycqa/Afq1ouaL1zvfY
 CCQ29ph7ZkFwejHmqHKh9sj715nPnQ0OovKM0ElCyvhkfZxmIHgUJslDs/34RLzJHGzD
 AmqpyOZYmlsialZvi+FD+111B8Kr8qox3QgJRs4z8d8rkU+K23cZKTPrwLnNTgeq+HeT
 Xs9tPq/kjvzutdJJfnKDnLz56qUuNc8wu3u2C/41znngtl4JOMdnqBeDzSfxrlHFTkzj
 c2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779967432; x=1780572232;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vEc99dVBYHFovn4jM6dMr8Mo0YEo+VlxEaTA/0juKnM=;
 b=cJf5eSzsB1QVM0je+J0b7DzDniyKioUFHQT7mtvAht6xTgFNvKpFAvyUAxUWr95+Rz
 AONRfVn9dd6Zi0KF3uI4MLHrk+0YIfhZSACdoWVda1JAFM+YqOoeuqbjnfp9E3b6V2Cx
 vMj+JJj9Vew+bU6HWz8tlLgUJ3/jn7Ujex34kvSS/yIvl57P2BaFoRdIE+qt3n4Y3tok
 orO/klq83M6hp/9aQoVs+YXE8cXyLoaok5Kh22yHTIDFfBcGHhn4evkUre7/PN/lUnqn
 tcT+AqKtUFfHpyDpiQuFgFvKp6+UFo0Nf2zMEpjAqXziSHb2VDkCN8KDb+IGML8tRXJ8
 BiRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+L/O1ib2hQ2DKJu4f3mUQeGGKQ18NsmD0R3rmbYa8eu3XK+iBxUTyaUBzZ7ESAD10fBg5FA1DKVgUN@nongnu.org
X-Gm-Message-State: AOJu0YyNAINkFWVQA/a0YFzZRmhcXTAd3kb/o3/k5TvdAJQVM3QpUtfe
 ZmcRSAWCl6lXXq9DL+yvvNIWDPbt8r0Bl17i1Vjt3xcB2gHXF0DFc2sKS0Ak+NlyqRYNYnVTOFY
 vqtkOIRw1ZliuB99Wbx9V8kPOJfCsH2Fd/INw+/1nNnVNRsFdf+QQjiSs
X-Gm-Gg: Acq92OHfW2nMnuNam/nzonhhA7kLii+hfMegzHl1KGxvSmh4uy+hhj+dwVZ7vohr+qJ
 7d59KlWRFqByHaLXq5aPInfLWlXL/ue7it4pD4OADrcR9j2YmuNeBy2Aeko3AlqtW1ftPIi4hlB
 Ul2SPncMrQTtgz5KymL31r25xd6cxt7zTDmG62d/jePbrSjNQ5Y1CyDD5lvy1kM0iY3EEgjvPuZ
 jCoCZZEZX5yN7PrHV9lYm8wbNyqt4LYKzIqZrViZGYXt0wX7sQBE2o/Xly/C3jjqWKymVS6jDfC
 t+DVV3+ssZ4TmVtUZibtqUHnGadOvE3lYy8F/trVYuOCQMJ0W+sQ1SI+uCWYzthV8nqDp5FE8eG
 aObmkAlXBc/Qz7pPForPT56gzLvnTS+Ra/77oto4/J6vTF8wWgUmWYKYQWHWy5XESJUQfFeb9li
 mZ6ViC4g==
X-Received: by 2002:a05:600c:8214:b0:490:5000:917 with SMTP id
 5b1f17b1804b1-490947855eamr18587235e9.1.1779967431860; 
 Thu, 28 May 2026 04:23:51 -0700 (PDT)
X-Received: by 2002:a05:600c:8214:b0:490:5000:917 with SMTP id
 5b1f17b1804b1-490947855eamr18586645e9.1.1779967431309; 
 Thu, 28 May 2026 04:23:51 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b59c53asm15178305e9.6.2026.05.28.04.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 04:23:50 -0700 (PDT)
Date: Thu, 28 May 2026 13:23:49 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: mst@redhat.com, Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/virt: preserve config for ACPI PCI hotplug
In-Reply-To: <CAFEAcA-PkO3aeGoaAzpbJGrrE-_-RjJy9Q4D4MnQ=9W61--3hA@mail.gmail.com>
Message-ID: <582348f6-c128-96b6-4d40-1c078e24038d@redhat.com>
References: <0de640a2-8807-69cf-4429-672263e3e759@redhat.com>
 <CAFEAcA-PkO3aeGoaAzpbJGrrE-_-RjJy9Q4D4MnQ=9W61--3hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 28 May 2026, Peter Maydell wrote:
> On Thu, 28 May 2026 at 10:23, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> ACPI PCI hotplug of a PCI device using a bar > 2M fails on ARM
>> with a resource allocation failure in the guest kernel (Linux):
>>
>> qemu-system-aarch64 [..] -device pcie-root-port,id=rp1,bus=pcie.0 \
>>                     -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on \
>>                     -pflash /usr/share/edk2/aarch64/QEMU_EFI-silent-pflash.qcow2
>>
>> (qemu) device_add pci-testdev,bus=rp1,membar=4M
>>
>> [   55.106283] pci 0000:01:00.0: [1b36:0005] type 00 class 0x00ff00 conventional PCI endpoint
>> [   55.107627] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00000fff]
>> [   55.107864] pci 0000:01:00.0: BAR 1 [io  0x0000-0x00ff]
>> [   55.108015] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x003fffff 64bit pref]
>> [   55.118609] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
>> [   55.118653] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
>> [   55.118671] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned
>> [   55.122828] pci 0000:01:00.0: BAR 1 [io  0x1000-0x10ff]: assigned
>> [   55.127090] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: releasing
>> [   55.127098] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
>> [   55.127102] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
>> [   55.127106] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned
>>
>> This behavior is exactly the same on x86 - except the busses are created
>> with a default window size of 256M there. If the PCI devices being
>> hotplugged use a bar > 256M you get the same failure like on ARM.
>>
>> The workaround on x86 is to specify "pref64-reserve=" for the PCIe
>> root-port. On ARM this is currently ignored.
>
> From the perspective of somebody who doesn't know much about
> ACPI or PCI, this commit message doesn't really tell me why
> QEMU needs to change. The above reads like "this is a kernel
> problem" to me. Why is the kernel unable to allocate this BAR?

DSM #5 defaults to 1 on ARM which tells the OS that it could
ignore the firmwares PCI configuration at boot time. Linux is
just doing that. The acpi pci hotplug controller can't find a
sufficient resource window of the parent bus and resource
allocation fails. DSM #5 == 0 tells the OS to not ignore the
boot time config from firmware.

>> The following patch changes ACPI DSM #5 to return 0 (only when
>> ACPI HP is used) which basically tells the guest kernel to keep
>> all PCI resource allocations.
>
> If this makes things work why isn't it the default for all ACPI?
> Why doesn't the kernel ignore the ACPI table setting and do
> the thing that works all the time? Do we break some other use
> case by setting it to 0 ?

From what I was able to find in the archives this has been tried
before but led to regressions for legacy devices:
https://lore.kernel.org/all/20210724185234.GA2265457@roeck-us.net

It was recently selectively enabled for accel SMMU - I guess the
rational was that you don't use accel SMMU with legacy devices:
45c57eaefd hw/arm/virt: Set PCI preserve_config for accel SMMUv3

>
>> ------->8
>> From 92cd64b8398f13e51b67ff8baf62f15cac300c94 Mon Sep 17 00:00:00 2001
>> From: Sebastian Ott <sebott@redhat.com>
>> Date: Wed, 20 May 2026 10:39:26 -0400
>> Subject: [PATCH] hw/arm/virt: preserve config for ACPI PCI hotplug
>>
>> Change ACPI DSM #5 to return 0 when ACPI PCI hotplug is used
>> to tell the guest kernel to keep all PCI resource allocations.
>>
>> This allows to use the pref64-reserve= option for pcie-root-ports
>> and thus enables hotplug of PCI devices with a barsize > 2M.
>>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> ---
>>   hw/arm/virt.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index b090233893..293a0c2163 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1094,6 +1094,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>>           pcihp_region_index = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
>>                                                     vms->memmap[VIRT_ACPI_PCIHP].base);
>>           assert(pcihp_region_index >= 0);
>> +        vms->pci_preserve_config = true;
>>       }
>
> If we set this here, do we still need to set it in
> virt_machine_device_pre_plug_cb(), or is that now redundant?

I guess you can use accel SMMU without acpi pci hotplug and vice versa.

Thanks,
Sebastian


