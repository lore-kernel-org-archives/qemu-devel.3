Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A9EC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 19:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpBOW-0005h3-F9; Mon, 03 Mar 2025 14:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpBOM-0005eB-Lt
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:23:57 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpBOB-0003vD-0u
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:23:53 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390e6ac844fso4213199f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 11:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741029817; x=1741634617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bl5On9k/V9AzXz5wfiLyRv7wQgqEYXE2HlwhsnKy1sk=;
 b=qAnlaAfwM5tWfZ6l2C4ySBGaf3AdJD4IOZU6C2RxTFnYpObQTtTDyypSVJfB89cKfI
 PAEdDgucqPJbJcLMCbxDnhxbGEmaDrwYIM3K6YGmjUeRwrvMIV+ITOUfN5XlNnywG2Oi
 iAy+icq1rf8nE0XWk62NJKDHSx4hzycy2PeV2SH2Q1+1foYro/mY66KveeFsxH7yMc7V
 4fEXL90j5bNM+PLTQ0Q9Ig5/Ui5sX1voOhc03ENvXNh4NS0EcDnmUHPlAh4rBWa9E0nL
 P/+0PF4DGWOaDzRhmSEe4Dwg6KeqbuVL0vEdkGjnSriVq/E+Om+4Bxmb6XmlsSPmdiYE
 VLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741029817; x=1741634617;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bl5On9k/V9AzXz5wfiLyRv7wQgqEYXE2HlwhsnKy1sk=;
 b=Qt8iohwZR/+ShB1a5t+wIpag7csJyqoSVT1o4lGCMlhi64jZltqEXeQg5SJQm83mL5
 dHxffhDqRytlAa9ugao1x0/NwV3eihZBh9RWKLuJd5PZbXJw0/8gefH0zyNiFbNxgt3L
 fmuKqx5rzPDfxggzoeS2Ju3R2UBzXQ9x/oB8auB3XpXKbbgOj5dbEMfgbTx/K82vV+mJ
 oFMmA7E40Bsgphs2L9eJS2KhIUwkzhVWprn8Mz11G7gJct9amfpE01xckVMNmGO4Abjr
 J+mtLlVjKev5QaLt0yDz99K1L+mUZrDAYJv3A5uOyq1517+yoxfg8zSu3GwVyeMJb/0a
 C74g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ7BryWoPxKP0w9t9pvfXQLk5s/ataZeTNi8p9ZxDdFIz0fIuv+IpQRy6SuwybhmPtpzJkQrBFA5H2@nongnu.org
X-Gm-Message-State: AOJu0YyyiPjDDReZgIE7+xPZ8+qIrX5Q9Rhdd2JiRSu4b6kLW1LJZihV
 O9bYgz/Ty1NY+PZqavUxCD9luKAY4GQYF4QQdUJ1BNd/3TNH+TIH2gnk7CUT9Bw=
X-Gm-Gg: ASbGncu0WAh3SKM/86I0JMnPbad/Q4MXn+Ta54HfdaBoT/jyNQgvS1UA0BnXxnQDOVx
 eBoknpL4X0AzvyzcxqqIcRBA+TeGiFkW8blM9kDupIOSJQFg5lEBoHmTRLtaL/u75cmomntqau3
 uikVi0u3/q+s/9RgNAxQpnM+isvJE5Cw7B3LYgJhEWvnQ7vic7H1X+4B7TFKGrmUo0nC/3jeRka
 yXTkHpPg1h2oXkiJ8nAL3F+axAjze8rciqYhipE+yHlk7jVJ2KSkDMMxfivv+80o2t1eZnwIRrQ
 iQO3YroeYkVn5rRfrD1Ju5rxq3EiFgDwKS3j8PaKUKsqXU797/lwIaYanEcu1yyDf8l87pj3xdh
 Ow4/DKXZdUVgm
X-Google-Smtp-Source: AGHT+IGBTv1hO3ddAudZvFWQ+Sp3hhlnCcuqo7eZjuvFgEkZHcQf8rOibCcFUScrvV798Hj9fme6Ew==
X-Received: by 2002:a5d:64af:0:b0:390:f738:2467 with SMTP id
 ffacd0b85a97d-390f7382999mr9655552f8f.33.1741029816706; 
 Mon, 03 Mar 2025 11:23:36 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4796084sm15584542f8f.19.2025.03.03.11.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 11:23:36 -0800 (PST)
Message-ID: <1f53a845-1680-41c5-82c2-606492098b80@linaro.org>
Date: Mon, 3 Mar 2025 20:23:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 11/11] hw/vmapple/vmapple: Add vmapple machine type
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 marcandre.lureau@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Alexander Graf
 <graf@amazon.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20250112210056.16658-1-phil@philjordan.eu>
 <20250112210056.16658-12-phil@philjordan.eu>
 <2a4229cf-c789-41ed-ab46-0f0fd9efd19a@linaro.org>
Content-Language: en-US
In-Reply-To: <2a4229cf-c789-41ed-ab46-0f0fd9efd19a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 3/3/25 19:20, Philippe Mathieu-Daudé wrote:
> On 12/1/25 22:00, Phil Dennis-Jordan wrote:
>> From: Alexander Graf <graf@amazon.com>
>>
>> Apple defines a new "vmapple" machine type as part of its proprietary
>> macOS Virtualization.Framework vmm. This machine type is similar to the
>> virt one, but with subtle differences in base devices, a few special
>> vmapple device additions and a vastly different boot chain.
>>
>> This patch reimplements this machine type in QEMU. To use it, you
>> have to have a readily installed version of macOS for VMApple,
>> run on macOS with -accel hvf, pass the Virtualization.Framework
>> boot rom (AVPBooter) in via -bios, pass the aux and root volume as pflash
>> and pass aux and root volume as virtio drives. In addition, you also
>> need to find the machine UUID and pass that as -M vmapple,uuid= 
>> parameter:
>>
>> $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=0x1234 -m 4G \
>>      -bios /System/Library/Frameworks/Virtualization.framework/ 
>> Versions/A/Resources/AVPBooter.vmapple2.bin
>>      -drive file=aux,if=pflash,format=raw \
>>      -drive file=root,if=pflash,format=raw \
>>      -drive file=aux,if=none,id=aux,format=raw \
>>      -device vmapple-virtio-blk-pci,variant=aux,drive=aux \
>>      -drive file=root,if=none,id=root,format=raw \
>>      -device vmapple-virtio-blk-pci,variant=root,drive=root
>>
>> With all these in place, you should be able to see macOS booting
>> successfully.
>>
>> Known issues:
>>   - Currently only macOS 12 guests are supported. The boot process for
>>     13+ will need further investigation and adjustment.
>>
>> Signed-off-by: Alexander Graf <graf@amazon.com>
>> Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
> 
> 
>>   MAINTAINERS                 |   1 +
>>   contrib/vmapple/uuid.sh     |   9 +
>>   docs/system/arm/vmapple.rst |  63 ++++
>>   docs/system/target-arm.rst  |   1 +
>>   hw/vmapple/Kconfig          |  20 ++
>>   hw/vmapple/meson.build      |   1 +
>>   hw/vmapple/vmapple.c        | 618 ++++++++++++++++++++++++++++++++++++
>>   7 files changed, 713 insertions(+)
>>   create mode 100755 contrib/vmapple/uuid.sh
>>   create mode 100644 docs/system/arm/vmapple.rst
>>   create mode 100644 hw/vmapple/vmapple.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e220744abf..3a3d9e19f4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2791,6 +2791,7 @@ M: Phil Dennis-Jordan <phil@philjordan.eu>
>>   S: Maintained
>>   F: hw/vmapple/*
>>   F: include/hw/vmapple/*
>> +F: docs/system/arm/vmapple.rst
>>   Subsystems
>>   ----------
>> diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
>> new file mode 100755
>> index 0000000000..956e8c3afe
>> --- /dev/null
>> +++ b/contrib/vmapple/uuid.sh
>> @@ -0,0 +1,9 @@
>> +#!/bin/sh
>> +# Used for converting a guest provisioned using Virtualization.framework
>> +# for use with the QEMU 'vmapple' aarch64 machine type.
>> +#
>> +# Extracts the Machine UUID from Virtualization.framework VM JSON file.
>> +# (as produced by 'macosvm', passed as command line argument)
>> +
>> +plutil -extract machineId raw "$1" | base64 -d | plutil -extract ECID 
>> raw -
>> +
>> diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
>> new file mode 100644
>> index 0000000000..5090a8997c
>> --- /dev/null
>> +++ b/docs/system/arm/vmapple.rst
>> @@ -0,0 +1,63 @@
> 
> Alex, Phil, we now mandate a SPDX tag. Due to the license used in
> vmapple.c in this patch, are you OK with me squashing here:
> 
> -- >8 --
> diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
> index 5090a8997c3..c5b1bcf45ea 100644
> --- a/docs/system/arm/vmapple.rst
> +++ b/docs/system/arm/vmapple.rst
> @@ -0,0 +1,2 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
> index 956e8c3afed..f5637221d23 100755
> --- a/contrib/vmapple/uuid.sh
> +++ b/contrib/vmapple/uuid.sh
> @@ -1,0 +2 @@
> +#
> @@ -6,0 +8,2 @@
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> ---
> 
> ?
> 
>> +VMApple machine emulation
>> +========================================================================================
>> +
>> +VMApple is the device model that the macOS built-in hypervisor called 
>> "Virtualization.framework"
>> +exposes to Apple Silicon macOS guests. The "vmapple" machine model in 
>> QEMU implements the same
>> +device model, but does not use any code from Virtualization.Framework.
>> +
>> +Prerequisites
>> +-------------
>> +
>> +To run the vmapple machine model, you need to
>> +
>> + * Run on Apple Silicon
>> + * Run on macOS 12.0 or above
>> + * Have an already installed copy of a Virtualization.Framework macOS 
>> 12 virtual
>> +   machine. Note that newer versions than 12.x are currently NOT 
>> supported on
>> +   the guest side. I will assume that you installed it using the
>> +   `macosvm <https://github.com/s-u/macosvm>` CLI.

I'm also squashing here:

-- >8 --
diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
index c5b1bcf45e..35c329ea5a 100644
--- a/docs/system/arm/vmapple.rst
+++ b/docs/system/arm/vmapple.rst
@@ -19,3 +19,3 @@ To run the vmapple machine model, you need to
     the guest side. I will assume that you installed it using the
-   `macosvm <https://github.com/s-u/macosvm>` CLI.
+   `macosvm <https://github.com/s-u/macosvm>`__ CLI.

---

to avoid when building the documentation:

docs/system/arm/vmapple.rst:17:'any' reference target not found: 
https://github.com/s-u/macosvm
ninja: build stopped: subcommand failed.

