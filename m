Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFBACCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 16:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGgMr-0001iL-4P; Wed, 05 Nov 2025 11:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGgMo-0001hx-61
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 11:28:14 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGgMm-0003Ku-3Y
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 11:28:13 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b71397df721so587418066b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 08:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762360090; x=1762964890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IH1U4I3MCbTnObFXnkeqp7wb4KlsccPgdr4I2dlBMTI=;
 b=r3KTqK7v3VSCEJ/cUovRrVulDsGup3EPJSlj14fMwa53v0kHbxa5AKszljmvYwu/Wi
 NAaot9776GcXRl+DHMjvvwjrxy4GF3PINGukv3RHN715nO3XrjYCcJMpY296rgbgz0ho
 F7mujovqA9Zd/J3i+KV0TVhA/itgl8g2J4p7JRxuM4XMAAvc6wnSH1Ot456RFC1lr+xi
 YZ6lclMBGwfrdMWhwoJhIuTjDwgnDW6R/HB4RIMUjyelMoW2KZ8cPspEL9hAfOs1fM+0
 KbMKGo+5ybMYD3SoVIeNwm5YUbjx/Y4Y0lANWXfy4uu72U7NZ2JGKmCeQ4jv8NO4C8nT
 jDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762360090; x=1762964890;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IH1U4I3MCbTnObFXnkeqp7wb4KlsccPgdr4I2dlBMTI=;
 b=gLT7MbLn6tmgSW8wT8SGBqTny/CGp9E/UVxN2VmEU1mDHtFD44MxnBZO+d8kAMpB1W
 Xe9d1vuwVnq7fnXvfdl5ucWhj6AaxY4hBgWnCG4zICIbTx3HE64OBkLwNeAJKgpclWrH
 NesTqiHjZlupF8NxGNCe+Lhiw3Ifd4DDLH9IfrrPHguTh8ly+Q/Wvw7Nmh6E4/2SOtUi
 eMnsOnmhi+MRWPumnmB22k50UOdR+hDQqfps3A3jxzFrbHPSXS1r4Njf7jOPq5NF76wa
 6rMDrggugFulwDeeQj4ZugqskpIDqcWtSrzztIb/1rWoShsWBXsrYCPof26kJBcK8Qzh
 D6VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT3q+qAE1LHzjkxCZqRDDDOq3EHTDfUO9SB22Atr+qDRCL2Ni4YbyHlnpB0lmxcrLXhmYkgFlFeFUD@nongnu.org
X-Gm-Message-State: AOJu0Yzm8VbWK6PnjHbUS1nl/MJ8uOqyYa/vVSoAbzxdKIJsHJ1AgkE0
 toNmyrDWV0B/hsA9ZPaqjQgX8fPXNVIQ2d9IywAqjyNHhfwPKtFrdEnOj9rUlgUSVRoD83G10vn
 lxRyOgH11og==
X-Gm-Gg: ASbGnctvUcNZQv2EJqhu4rYQ361Vi0SUcbxIdmkecYPmV4HdCgAoUA/UKNjt5ox4T5W
 O8Djq8M9M2QPGpJYMtYKQxsxEevf+hxUNFSUn5iFrDb/zm69+AXk74kYELG+gV6Taf1Bhm+yTR8
 T5tzkHP3gtrfHpXraYz5xla+hmQ+Bz1Ngaam/vmBYlQ7uKjeqWPtm9y32HltsKFYu6uuNGzTIjf
 MpcqF2rYOHse9oiZoUrYDJ01pF1u3HUJ3U1jP2mBwlKHyntJVMpL93k6R4gkTr6ju7uha8gJa9t
 TqGQs1rh3kbtqYBaKt2OujcesVEPZKCWWSi5zhqfCo9vzReWTVDwl4ce8NnDSaLWiumon0Ej9iS
 hE9p6OdnGExZzENf80buwxArlrpaNyoH1NWfHoPe7TIrKz5BhKYk8rAfJ8fxViriGxl4VENK5Z8
 o1skTgZlzDkSyDlg==
X-Google-Smtp-Source: AGHT+IGx/mJUtBgGdVTgC5Bn0KhcUR/lhOnAkhD72MxkXim8RFVQ22g5uCiAvRjmN1F0dDh7SiGgxw==
X-Received: by 2002:a17:907:3c96:b0:b4e:fc90:47a8 with SMTP id
 a640c23a62f3a-b726515a9d2mr457787366b.4.1762360090169; 
 Wed, 05 Nov 2025 08:28:10 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7270b56f18sm153742566b.33.2025.11.05.08.28.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 08:28:09 -0800 (PST)
Message-ID: <a56926ea-5659-452e-b527-712c56cb6851@linaro.org>
Date: Wed, 5 Nov 2025 17:28:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] sd: Add RPMB emulation to eMMC model
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Alistair Francis
 <alistair@alistair23.me>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Warner Losh <imp@bsdimp.com>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <8176d000-92cb-4c10-ab75-3e2d4dee4c29@linaro.org>
Content-Language: en-US
In-Reply-To: <8176d000-92cb-4c10-ab75-3e2d4dee4c29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/11/25 17:13, Philippe Mathieu-Daudé wrote:
> On 4/11/25 14:03, Jan Kiszka wrote:
> 
>> This closes an old gap in system integration testing for the very
>> complex ARM firmware stacks by adding fairly advanced Replay Protected
>> Memory Block (RPMB) emulation to the eMMC device model. Key programming
>> and message authentication are working, so is the write counter. Known
>> users are happy with the result. What is missing, but not only for RPMB-
>> related registers, is state persistence across QEMU restarts. This is OK
>> at this stage for most test scenarios, though, and could still be added
>> later on.
> 
> 
>> Jan Kiszka (6):
>>    hw/sd/sdcard: Fix size check for backing block image
>>    hw/sd/sdcard: Allow user-instantiated eMMC
>>    hw/sd/sdcard: Add basic support for RPMB partition
>>    hw/sd/sdcard: Handle RPMB MAC field
>>    scripts: Add helper script to generate eMMC block device images
>>    docs: Add eMMC device model description
> 
> FTR:
> Tested-by: Cédric Le Goater <clg@redhat.com>
> 
> and also for u-boot I got a late:
> Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

(and my own testing with your scripts)

(qemu) info block
disk (#block156): 
/isar-cip-core/build/tmp/deploy/images/qemu-arm64/cip-core-image-cip-core-trixie-qemu-arm64.qemu-emmc 
(raw)
     Attached to:      /machine/peripheral-anon/device[4]
     Removable device: not locked, tray closed
     Cache mode:       writeback

root@demo:~# dmesg|fgrep -i mmc
[    3.586239] mmc0: SDHCI controller on PCI [0000:00:01.0] using ADMA
[    3.660691] mmc0: new high speed MMC card at address 0001
[    3.668342] mmcblk0: mmc0:0001 QEMU!! 2.65 GiB
[    3.999076]  mmcblk0: p1 p2 p3 p4 p5 p6
[    4.006997] mmcblk0rpmb: mmc0:0001 QEMU!! 2.00 MiB, chardev (239:0)


