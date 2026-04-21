Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBB6F327B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF5gL-0007zS-Kf; Tue, 21 Apr 2026 03:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wF5gK-0007zA-0e
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wF5gH-0002uc-6A
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776757079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NFY7zODWKoCbPxshRzqqRA7jmNfepQRkcfwINhCC/mQ=;
 b=RRNv6L8DX1hZo5KiUWiItq82ehPef00Wg2D51zMa9ZDareqNBLb8lXhLfYIslyY5yrFK84
 Kz1swTla0HWYnE7boWNbP4agZkHJ1lzwGp1xQ1oCgRZsbrvTOlNGUZ0rEKk781Z4yqFdsT
 pXm+KWjqiuApZTJQMuynqQhSOlfNrL8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-i82_FytWOV20UwihXnB_rQ-1; Tue, 21 Apr 2026 03:37:57 -0400
X-MC-Unique: i82_FytWOV20UwihXnB_rQ-1
X-Mimecast-MFC-AGG-ID: i82_FytWOV20UwihXnB_rQ_1776757077
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488e097a270so28798065e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 00:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776757076; x=1777361876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NFY7zODWKoCbPxshRzqqRA7jmNfepQRkcfwINhCC/mQ=;
 b=kz0R4ECWpx2yQF5iae//CBpNnlG3PEZbv3e7lUKC2TsTfymfWALePF2Cr8GJeG+dYJ
 C0m0zb5sDLbXxEGJJ8ppyv3JoO63ls+4bLHTjOR1ouquYaTFYdty1WRGRODiB9gk0OnE
 AJ8yD7nARxDiYbVSQF44U0v51cPXBYR44OKBYIgMw2h1aTW9+K8E02BHmZJn1ZiMcbuw
 Fl73tPHhes/GBt2mtV1f0Jojid+Bp7w0ZW/FRHFvO8VX4Bw9o2SYWFEe3sFAkqioWF9X
 yDORijRaf/NvQVNAUP1SpMQ+ZYKfXbqxSJoRjjZvVIuJmqZYt+tySSXfAVwhZw/TsoY/
 asvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776757076; x=1777361876;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFY7zODWKoCbPxshRzqqRA7jmNfepQRkcfwINhCC/mQ=;
 b=F9NpzQQSXu3JEy08zLeHeKEciV/lma20m8EFjifW3JSloR1wo9PE/WysXba4aeKvhS
 BACj+7qrANBJ+hBgrU/KwutG7Lbs7bUvMtqGSBrD3p7UhAjIb6xL8TvBF3Lp/KTmgU9j
 ftAGqSv6dpR2nHhQJCzJkTI0m8Je2KXGLzJ+U4XfIDKMfrw7ILtXamJTjlfEXnF7r5BX
 Ph4rVMsei8AhG5NLhEj72EXbNmaQ+LdnZqhz2WPGjeuLCmWa7gVjfHjzhSvS5Zw4Y8qc
 9d9sqHHcGRjeYBEEHFqbgX3wy98knS7vrlgMuQO7497b0r0KWjxykI5ge89/m3bRB8gC
 M3iw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8H6Cb/SSJwbPnOPy+U5xhtCaKDGy53hZW/Cd9XQ1/aYXsOjQ5l5fN0ui4DFEeiL0Htg5rHxFLznuHi@nongnu.org
X-Gm-Message-State: AOJu0Yygd58JDig6LSYvieC5O9MwXFEGBhUTU0vDsdtWrZOw87vkCJQN
 aLqhtNvSJ1Zd8Vb0Sahg4vfSpRIuCT9JybfswVNeZBIranHUC9sMjCs+J6BaeaOdxYSliLMtRT1
 CnE4ctqm+LlvTb6rEbf/rHJ6eEGeY5qDZex/PmAVFwecnXBuZErhzYKxP
X-Gm-Gg: AeBDietKq8elHmwY5VB5R1o5GoL+nGDmNFrgKYYt7ufDnY92EwzVQgdt3Gi1wJLWGYC
 ozK5KUn0txzBAKSL+Xbbpf0J05Xn49EzvdDPiQpY9mHLg/ZJipG/9OGwwNbeXG0Gu3/1g3xf/t+
 cL2Ug45xK3Fgm31iB3r+d+qPO0C5e8/6OyqXxAuKhgXe4BG+vNye5jsiqoqfgLh2CPTuACCZmNs
 Oo9jZFG6SGPX6+tZFrRIxjJqnYJrjVGRfmVbe124VsVX5nnglthkwR75CEaVxKRqPqlqGG4xG1L
 0OoAWP3KO2jhciZJ4xxnlp8hwTYwyoPdgrp3Coa4EoDwhVnjq09xSiwbNbpFroMQon4vNO2EN8i
 WN1eCY4c4aKOF/SGEM0S0MlcxT3CxKQ==
X-Received: by 2002:a05:600c:41d6:b0:487:2439:b7c8 with SMTP id
 5b1f17b1804b1-488fb745294mr154402695e9.1.1776757076458; 
 Tue, 21 Apr 2026 00:37:56 -0700 (PDT)
X-Received: by 2002:a05:600c:41d6:b0:487:2439:b7c8 with SMTP id
 5b1f17b1804b1-488fb745294mr154402435e9.1.1776757075994; 
 Tue, 21 Apr 2026 00:37:55 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc140c82sm319082555e9.12.2026.04.21.00.37.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 00:37:55 -0700 (PDT)
Message-ID: <ada1250f-6c67-45e5-b2fa-f0b2212ff502@redhat.com>
Date: Tue, 21 Apr 2026 09:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 15/15] hw/arm/fsl-imx8mm: Adding functional testing of
 iMX8MM emulation
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
References: <20260421065226.3907745-1-gaurav.sharma_7@nxp.com>
 <20260421065226.3907745-16-gaurav.sharma_7@nxp.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260421065226.3907745-16-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21/04/2026 08.52, Gaurav Sharma wrote:
> Added script that would validate the iMX8MM emulation by checking the
> linux console log. If it succeeds, it will return:-
> 
> ok 1 test_imx8mm_evk.Imx8mmEvkMachine.test_aarch64_imx8mm_evk_usdhc
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   MAINTAINERS                                 |  1 +
>   tests/functional/aarch64/meson.build        |  2 +
>   tests/functional/aarch64/test_imx8mm_evk.py | 67 +++++++++++++++++++++
>   3 files changed, 70 insertions(+)
>   create mode 100755 tests/functional/aarch64/test_imx8mm_evk.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e254e34882..beb118f0a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -924,6 +924,7 @@ F: hw/arm/fsl-imx8mm.c
>   F: hw/arm/imx8mm-evk.c
>   F: include/hw/arm/fsl-imx8mm.h
>   F: docs/system/arm/imx8m.rst
> +F: tests/functional/aarch64/test_imx8mm_evk.py
>   
>   MCIMX8MP-EVK / i.MX8MP
>   M: Bernhard Beschow <shentey@gmail.com>
> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
> index 7ea8c22b04..1067f181f2 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -5,6 +5,7 @@ test_aarch64_timeouts = {
>     'aspeed_ast2700a2' : 600,
>     'aspeed_ast2700fc' : 600,
>     'device_passthrough' : 720,
> +  'imx8mm_evk' : 240,
>     'imx8mp_evk' : 240,
>     'raspi4' : 480,
>     'reverse_debug' : 180,
> @@ -29,6 +30,7 @@ tests_aarch64_system_thorough = [
>     'aspeed_ast2700fc',
>     'device_passthrough',
>     'hotplug_pci',
> +  'imx8mm_evk',
>     'imx8mp_evk',
>     'kvm',
>     'multiprocess',
> diff --git a/tests/functional/aarch64/test_imx8mm_evk.py b/tests/functional/aarch64/test_imx8mm_evk.py
> new file mode 100755
> index 0000000000..224fe4669e
> --- /dev/null
> +++ b/tests/functional/aarch64/test_imx8mm_evk.py
> @@ -0,0 +1,67 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a Linux kernel and checks the console
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset
> +

In case you respin, please add a second empty line here (to keep flake8 happy).

> +class Imx8mmEvkMachine(LinuxKernelTest):
> +
> +    ASSET_IMAGE = Asset(
> +        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
> +         'debian-12-generic-arm64-20231210-1590.tar.xz'),
> +        '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
> +
> +    KERNEL_OFFSET = 0x51000000
> +    KERNEL_SIZE = 32622528
> +    INITRD_OFFSET = 0x76000000
> +    INITRD_SIZE = 30987766
> +    DTB_OFFSET = 0x64DB5000
> +    DTB_SIZE = 36812
> +
> +    def extract(self, in_path, out_path, offset, size):
> +        try:
> +            with open(in_path, "rb") as source:
> +                source.seek(offset)
> +                data = source.read(size)
> +            with open(out_path, "wb") as target:
> +                target.write(data)
> +        except (IOError, ValueError) as e:
> +            self.log.error(f"Failed to extract {out_path}: {e}")
> +            raise
> +
> +    def setUp(self):
> +        super().setUp()
> +
> +        self.image_path = self.scratch_file("disk.raw")
> +        self.kernel_path = self.scratch_file("linux")
> +        self.initrd_path = self.scratch_file("initrd.zstd")
> +        self.dtb_path = self.scratch_file("imx8mm-evk.dtb")
> +
> +        self.archive_extract(self.ASSET_IMAGE)
> +        self.extract(self.image_path, self.kernel_path,
> +                     self.KERNEL_OFFSET, self.KERNEL_SIZE)
> +        self.extract(self.image_path, self.initrd_path,
> +                     self.INITRD_OFFSET, self.INITRD_SIZE)
> +        self.extract(self.image_path, self.dtb_path,
> +                     self.DTB_OFFSET, self.DTB_SIZE)
> +
> +    def test_aarch64_imx8mm_evk_usdhc(self):
> +        self.require_accelerator("tcg")
> +        self.set_machine('imx8mm-evk')
> +        self.vm.set_console(console_index=1)
> +        self.vm.add_args('-m', '2G',
> +                         '-smp', '4',
> +                         '-kernel', self.kernel_path,
> +                         '-initrd', self.initrd_path,
> +                         '-dtb', self.dtb_path,
> +                         '-append', 'root=/dev/mmcblk2p1',
> +                         '-drive', f'file={self.image_path},if=sd,bus=2,'
> +                                    'format=raw,id=mmcblk2,snapshot=on')
> +
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Welcome to ')
> +

Dito, add a second empty line here (in case we ever want to support flake8 
for the functional tests).

> +if __name__ == '__main__':
> +    LinuxKernelTest.main()

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


