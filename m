Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56BBC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujiPc-0005uW-9D; Wed, 06 Aug 2025 13:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujiPZ-0005tO-Vp
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 13:58:50 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujiPV-0003a1-Ve
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 13:58:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so319783b3a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754503124; x=1755107924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KUzhoRa9kWNC+956n2XC5X9V/+aRZPom4rXJNxrCnJc=;
 b=FH/2ZdqMXoKVul1VRMlEJoSjNfYnB5Kd2zyPQgLBvqy46geprLgn/imWE5dJlojBXr
 0VIcOUlzjyZkRu80IBZHWPCqniglsJKVYfw+ajb+qDoja9IvM05AWrlqLJhsgxgw3hbo
 AgrWZS9ZT8p2NHlBBXBQXxcA0iDgvzmB5tvPW/U9sJo8d+aV51haoGswjQQlqwwl7zWg
 kA72wt1OvJlauPKyiMJed4+oJ8FpzFNpqs6lFTPXw3FRPjQQ0aa1SsVgr0mGh8uPY8t8
 YquhJwKOZ1Kd2Gxbgdiqm/YiNYJlZmVESyOUrNNWAxvwipcWsl/qowxfJCZsck75Kz9I
 gsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754503124; x=1755107924;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KUzhoRa9kWNC+956n2XC5X9V/+aRZPom4rXJNxrCnJc=;
 b=aPazgm/yuIFmETX1UkAhITxfQU8joaUkvowsyH8jfvItIUkNcrg8IyUvu/C0xPWeMX
 V+FbmXoZn55RUNlr3oztyORPdz1mulpPZFs1C6Bbnyje8vJvXVlpcpR55N5bwbY09eAt
 cr7smB0TrNB9ctGJ0E2xa6480/cfxMqLPRb1PLXPN8tCTdvkject7m/Z+Cgwd4EPlFEs
 iw/ipK+8/80J8uYH0oPX/TQ8N+NzhIs02ReDj+8UWdoWvvAZ43hdaRhtDxlJkG9ITZuY
 nCZ2hVZ+jq0ynXsRQ3GDBY4UCzw4aOYuNdGvT1TqR2s0nIFd10c6B5IF/md8XDUUbinS
 qnnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6opExooszzo9CcEKoqiDwAgeY+tOARys5cdb1fPcB6oN5U9vJbyh1u2N86qx0Hzz5y8lMUadsN0ak@nongnu.org
X-Gm-Message-State: AOJu0YzSnSvFnbg+FfpiskCYut8dycRgbBRH7dxSA6/KgIJU7Yk+NeeL
 b3dvi3cKA7e3NzkqDidc0424+NchbH/6l0HAVZVaVRa/mnTpaHILfen+uTIIiL0a8oQ=
X-Gm-Gg: ASbGnctMUps95fQg/EdLVEjmCs+BAEv9c3PR+Z2VR1ccn2o7sQYVIH8eu2GsFVlUJiD
 MqQ9kEa/gqenPYT7ugjODrjYwECLGwGfe8leTJZYW/7cVHgRd6elWLW7FM5ReoyElHr0RWBn4Nl
 7/pPIWxaNyOhD9IrG+5XGE+ovx/SIZ0/kfsxHB1S3DcMKYFvu2BtmH/LjzHnZqm7b+34xZEvGma
 I+pRFi/yizEspadSPQjcM6t5xvwXHTHltfUJFK2FE+7yyVvlx4lqg1gl76OxMv8K1ngQ6QsuAfP
 7D6FLA9mMP91+/5bFRpJSM9+kgRllGgt8DkXkQduO2cUh1oiu/h6TFnojLp3e7U+Bw2Wo9xsiU/
 0DZmSPAJl5Lp3XUze2NoGneL5Hdko1iPuNbo=
X-Google-Smtp-Source: AGHT+IFuSrIvv2ahIGq5H2kSoMaEzNPI3bzvD6uYVydV+3Gftmznag6PPCNrrFiNAeRtRVihSAeXOA==
X-Received: by 2002:a05:6a20:729f:b0:240:7ed:402d with SMTP id
 adf61e73a8af0-240313ec465mr7740921637.31.1754503124081; 
 Wed, 06 Aug 2025 10:58:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76c0401f3d7sm8451375b3a.96.2025.08.06.10.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 10:58:43 -0700 (PDT)
Message-ID: <cf516dd1-51ae-45fb-a3df-6f7e0056234c@linaro.org>
Date: Wed, 6 Aug 2025 10:58:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/13] tests/functional: Test SD cards in SPI mode (using
 sifive_u machine)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, Ben Dooks
 <ben.dooks@codethink.co.uk>, Richard Henderson
 <richard.henderson@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <20250805173135.38045-1-philmd@linaro.org>
 <20250805173135.38045-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250805173135.38045-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

Hi,

On 8/5/25 10:31 AM, Philippe Mathieu-Daudé wrote:
> Add a test which uses the sifive_u machine to boot a Linux
> kernel from a SD card connected via a SPI interface.
> 
> Inspired from the command provided in:
> - https://lore.kernel.org/qemu-devel/94b2c5bf-53d0-4c74-8264-f3021916f38c@roeck-us.net/
> - https://lore.kernel.org/qemu-devel/840016d0-0d49-4ef4-8372-b62b3bcd0ac6@codethink.co.uk/
> 
> Inspired-by: Guenter Roeck <linux@roeck-us.net>
> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20250804133406.17456-12-philmd@linaro.org>
> ---
>   MAINTAINERS                               |  1 +
>   tests/functional/meson.build              |  1 +
>   tests/functional/test_riscv64_sifive_u.py | 51 +++++++++++++++++++++++
>   3 files changed, 53 insertions(+)
>   create mode 100755 tests/functional/test_riscv64_sifive_u.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28cea342718..a07086ed762 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1695,6 +1695,7 @@ S: Supported
>   F: docs/system/riscv/sifive_u.rst
>   F: hw/*/*sifive*.c
>   F: include/hw/*/*sifive*.h
> +F: tests/functional/test_riscv64_sifive_u.py
>   
>   AMD Microblaze-V Generic Board
>   M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index ecf965adc6c..311c6f18065 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -274,6 +274,7 @@ tests_riscv64_system_quick = [
>   ]
>   
>   tests_riscv64_system_thorough = [
> +  'riscv64_sifive_u',
>     'riscv64_tuxrun',
>   ]
>   
> diff --git a/tests/functional/test_riscv64_sifive_u.py b/tests/functional/test_riscv64_sifive_u.py
> new file mode 100755
> index 00000000000..dc4cb8a4a96
> --- /dev/null
> +++ b/tests/functional/test_riscv64_sifive_u.py
> @@ -0,0 +1,51 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a Linux kernel on a Sifive U machine
> +# and checks the console
> +#
> +# Copyright (c) Linaro Ltd.
> +#
> +# Author:
> +#  Philippe Mathieu-Daudé
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +
> +from qemu_test import Asset, LinuxKernelTest
> +from qemu_test import skipIfMissingCommands
> +
> +
> +class SifiveU(LinuxKernelTest):
> +
> +    ASSET_KERNEL = Asset(
> +        'https://storage.tuxboot.com/buildroot/20241119/riscv64/Image',
> +        '2bd8132a3bf21570290042324fff48c987f42f2a00c08de979f43f0662ebadba')
> +    ASSET_ROOTFS = Asset(
> +        ('https://github.com/groeck/linux-build-test/raw/'
> +         '9819da19e6eef291686fdd7b029ea00e764dc62f/rootfs/riscv64/'
> +         'rootfs.ext2.gz'),
> +        'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
> +
> +    def test_riscv64_sifive_u_mmc_spi(self):
> +        self.set_machine('sifive_u')
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
> +
> +        self.vm.set_console()
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'root=/dev/mmcblk0 rootwait '
> +                               'earlycon=sbi console=ttySIF0 '
> +                               'panic=-1 noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-drive', f'file={rootfs_path},if=sd,format=raw',
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Boot successful.')
> +
> +        os.remove(rootfs_path)
> +
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()

This new test triggers a usban error, which seems unrelated to what is 
tested.

tests/functional/riscv64/test_riscv64_sifive_u.SifiveU.test_riscv64_sifive_u_mmc_spi/default.log
../net/checksum.c:78:23: runtime error: member access within misaligned 
address 0x63300000ff71 for type 'struct eth_header', which requires 2 
byte alignment
0x63300000ff71: note: pointer points here
  00 00 00  00 33 33 00 00 00 16 52  54 00 12 34 56 86 dd 60  00 00 00 
00 24 00 01 00  00 00 00 00 00
               ^
     #0 0x56492d505aeb in net_checksum_calculate ../net/checksum.c:78
     #1 0x56492cde3b75 in gem_transmit ../hw/net/cadence_gem.c:1386
     #2 0x56492cde3b75 in gem_write ../hw/net/cadence_gem.c:1639
     #3 0x56492d35ba8d in memory_region_write_accessor 
../system/memory.c:490
     #4 0x56492d368449 in access_with_adjusted_size ../system/memory.c:566
     #5 0x56492d36de3c in memory_region_dispatch_write 
../system/memory.c:1553
     #6 0x56492d39fb22 in flatview_write_continue_step 
../system/physmem.c:2972
     #7 0x56492d3a007c in flatview_write_continue ../system/physmem.c:3002
     #8 0x56492d3a007c in flatview_write ../system/physmem.c:3033
     #9 0x56492d3a0376 in subpage_write ../system/physmem.c:2635
     #10 0x56492d368449 in access_with_adjusted_size ../system/memory.c:566
     #11 0x56492d36de3c in memory_region_dispatch_write 
../system/memory.c:1553
     #12 0x56492d6b16a4 in int_st_mmio_leN ../accel/tcg/cputlb.c:2503
     #13 0x56492d6b1a3b in do_st_mmio_leN ../accel/tcg/cputlb.c:2538
     #14 0x56492d6c80e8 in do_st_4 ../accel/tcg/cputlb.c:2708
     #15 0x56492d6c80e8 in do_st4_mmu ../accel/tcg/cputlb.c:2784
     #16 0x7fd5c72bcf7d  (/memfd:tcg-jit (deleted)+0x527ff7d)

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior 
../net/checksum.c:78:23

Regards,
Pierrick

