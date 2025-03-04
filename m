Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443C4C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 15:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpUTd-000189-EZ; Tue, 04 Mar 2025 10:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpUT9-0000x5-BA
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:46:08 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpUT6-0008TM-Ho
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:46:07 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390ec7c2cd8so2968225f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 07:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741103162; x=1741707962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gQazKJhcBmZcUYaJVfatuVH8iti9QYWy1n/temZkY/0=;
 b=KYVHfI140hmke6PihPdUxkE/Fm+JkYk8KVU58B3ocEgGRknP7yyDzs9q4IvfdMVnZJ
 ZAuZ6U0Hz3DcfMimHCvXv1WYvDmLfngFc1EkqEtysRdcu3dcGq9KQgISotMoVcBUH0qU
 xGKTrisIdMOTWzurE/7seCqlhwO8+KVfrzgIJZz9BK3ohRpYF2vmbMC/PU9ZBZSF4odL
 +ifMIp+RpdOZvZnGyT9W5sam3RGk0cEnUpP1+TlSh0mC/K7tcW8DJ4Uo7eSLMFCG7pUt
 7oA3R839DrlD6QvOAHwHxNKCcQZx9QXbGdTnYq7Rld9TKOecffGu8v8//HtmBYYay4R9
 Ogsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741103162; x=1741707962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gQazKJhcBmZcUYaJVfatuVH8iti9QYWy1n/temZkY/0=;
 b=uxklOvnRo2507FlL2Nck4nTm1+MK+gwkEAJgpklJSpeHlP0Ke4booCyhSvMvFwO0pD
 KVN8L3gw3pejNvrcHEJoSD5Cxn8F97m/Rs7OZ0k3CE/12U467QpSU7I1dkQ2kTIyIuRY
 gtJOxS3uBiWBeWkuDGk0XVXswTkucTuLP+NUq8/4Tfdr/UYp1HqXBlhOGFujwB+qykvD
 9YkYjBmZyCOQ0QfsVzqRuDGrnurbjG4O1ihK8+PALbBRIgqDHiazlt5nm1qZZn2/mbRf
 BHUgJUGewLd6nJUAvN/8U2WVILgFUeyWV5cSmwsv1TQnYL+zhKoGI5iFGMHgaH2YIjBP
 mtbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaPDC4AH+XFsqbcWaxUp8+mzJycCVj2aho+tZPGOx6B3bizKp9QF37hSsCfKZ2yGF0sUeQ80vQV70C@nongnu.org
X-Gm-Message-State: AOJu0Yz2tS7c6YRfp35nzpG6WWRTRkNHXxWO86wD2LbMa12csllk1/a/
 Gg+MGX6X0SPPtHk5YL/psr0lTYxCyfIGdxXjP75A+KdDYhPuQonY7sv+Y21EzCg=
X-Gm-Gg: ASbGncuVenDDHKRe9JGRMVRgUdqX8jmBVbiaTy79m3CbJD7cS/8DUduL9i9/aRkR0dE
 UJYeJR8QKmUC5I3/7V0gg8Mip6gSYskLdpFpURNYSihiSEVyFG4kxzYAD/YKgPLU87kJ5BsP3sb
 94XYZMovDsCM7vtEqOOJK/Y9Z7EMb0UFegaIlA2ylvhML/VXiYbnM8cU+Qj8O0H2x20OVJ6QHTR
 BxVv82qKhNrHMfjmVQYMfrwoR2vpCmpjE1cK8uBkSUVBynNJ3DEDEizX9WadevWXY+VMZLO13E5
 onrXTFqz4/WLgwOdFsMIxfH67xUzrO0M2GeLyIwaeOoXmIsIE8VwqsDNL076LhJJhNmKCxgRukb
 v+WpweMGvwLKF
X-Google-Smtp-Source: AGHT+IHoZPm7EmdOYNXpG1YoQ7sQHwRE57VSo4N0aNsJbQ59esZ/M2oKLaAD1seDHqL7t3c1YPJWmQ==
X-Received: by 2002:a5d:6489:0:b0:390:f641:d8bb with SMTP id
 ffacd0b85a97d-390f641d990mr12099444f8f.36.1741103162184; 
 Tue, 04 Mar 2025 07:46:02 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e479596dsm17990877f8f.7.2025.03.04.07.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 07:46:01 -0800 (PST)
Message-ID: <38afa09a-6b3f-4f4f-a9a3-78bab25f0e3a@linaro.org>
Date: Tue, 4 Mar 2025 16:46:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] tests/functional: Add a hexagon minivm test
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-9-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250301172045.1295412-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi Brian,

On 1/3/25 18:20, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>

A bit opaque...

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                             |  1 +
>   tests/functional/meson.build            |  8 +++++
>   tests/functional/test_hexagon_minivm.py | 42 +++++++++++++++++++++++++
>   3 files changed, 51 insertions(+)
>   create mode 100755 tests/functional/test_hexagon_minivm.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deeb7878c8..48a5e7c005 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -247,6 +247,7 @@ F: gdb-xml/hexagon*.xml
>   F: docs/system/target-hexagon.rst
>   F: docs/devel/hexagon-sys.rst
>   F: docs/devel/hexagon-l2vic.rst
> +F: tests/functional/test_hexagon_minivm.py
>   T: git https://github.com/quic/qemu.git hex-next
>   
>   Hexagon idef-parser
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 111d8bab26..78b42e58f9 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -135,6 +135,14 @@ tests_i386_system_quick = [
>     'migration',
>   ]
>   
> +test_timeouts += {
> +  'hexagon_minivm': 180,
> +}
> +
> +tests_hexagon_system_quick = [
> +  'hexagon_minivm',
> +]
> +
>   tests_i386_system_thorough = [
>     'i386_tuxrun',
>   ]
> diff --git a/tests/functional/test_hexagon_minivm.py b/tests/functional/test_hexagon_minivm.py
> new file mode 100755
> index 0000000000..2ba92bcce3
> --- /dev/null
> +++ b/tests/functional/test_hexagon_minivm.py
> @@ -0,0 +1,42 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright(c) 2024-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +from glob import glob
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +
> +class MiniVMTest(QemuSystemTest):
> +
> +    timeout = 180
> +    GUEST_ENTRY = 0xc0000000
> +
> +    REPO = 'https://artifacts.codelinaro.org/artifactory'
> +    ASSET_TARBALL = \
> +        Asset(f'{REPO}/codelinaro-toolchain-for-hexagon/'
> +               '19.1.5/hexagon_minivm_2024_Dec_15.tar.gz',
> +        'd7920b5ff14bed5a10b23ada7d4eb927ede08635281f25067e0d5711feee2c2a')
> +
> +    def test_minivm(self):
> +        self.set_machine('virt')
> +        self.archive_extract(self.ASSET_TARBALL)
> +        rootfs_path = f'{self.workdir}/hexagon-unknown-linux-musl-rootfs'
> +        kernel_path = f'{rootfs_path}/boot/minivm'

$ readelf -h hexagon-unknown-linux-musl-rootfs/boot/minivm
   Entry point address:               0xffff0000

I suppose this is a bootloader which runs guest code at
GUEST_ENTRY = 0xc0000000.

> +
> +        assert(os.path.exists(kernel_path))
> +        for test_bin_path in glob(f'{rootfs_path}/boot/test_*'):
> +            print(f'# Testing "{os.path.basename(test_bin_path)}"')

$ ls -1 hexagon-unknown-linux-musl-rootfs/boot/test_*
hexagon-unknown-linux-musl-rootfs/boot/test_interrupts
hexagon-unknown-linux-musl-rootfs/boot/test_mmu
hexagon-unknown-linux-musl-rootfs/boot/test_processors

I'd rather 1 test per binary to easily see which one failed.

> +
> +            vm = self.get_vm()
> +            vm.add_args('-kernel', kernel_path,
> +                  '-device',
> +                  f'loader,addr={hex(self.GUEST_ENTRY)},file={test_bin_path}')
> +            vm.launch()
> +            vm.wait()
> +            self.assertEqual(vm.exitcode(), 0)

...
----------------
IN:
0xc0000000:  0x6a09c019 { R25 = C9/pc }
0xc0000004:  0x00004040 { immext(#0x1000)
0xc0000008:  0x7800c018  R24 = ##0x1000 }
0xc000000c:  0xf318d918 { R24 = add(R24,R25) }
0xc0000010:  0x00004000 { immext(#0x0)
0xc0000014:  0x7800c03a  R26 = ##0x1 }
0xc0000018:  0x0c004000 { immext(#0xc0000000)
0xc000001c:  0x7800c001  R1 = ##0xc0000000 }
0xc0000020:  0x0ffc4000 { immext(#0xffc00000)
0xc0000024:  0x7601c001  R1 = and(R1,##0xffc00000) }
0xc0000028:  0x8c01d622 { R2 = lsr(R1,#0x16) }
0xc000002c:  0xc402d840 { R0 = addasl(R24,R2,#0x2) }
0xc0000030:  0xb0e1f8a1 { R1 = add(R1,#0xfc5) }
0xc0000034:  0x00044000 { immext(#0x400000)
0xc0000038:  0x7800c002  R2 = ##0x400000 }
0xc000003c:  0x601ac008 { loop0(PC+4,R26) }
0xc0000040:  0xab80c108 { memw(R0++#0x4) = R1 }
0xc0000044:  0xf3018201 { R1 = add(R1,R2)
0xc0000048:  0x7f00c000  nop }  :endloop0
...
do_raise_exception: 0x00000002, @ 20000090
  hexagon_cpu_do_interrupt: event 0x2:(null), cause 0x25(37)
  hexagon_cpu_do_interrupt: event 0x9:HEX_EVENT_TRAP1, cause 0x1(1)
0x20000104:  0x5400c000 { trap0(#0x0) }

  hexagon_cpu_do_interrupt: event 0x8:HEX_EVENT_TRAP0, cause 0x0(0)
  hexagon_cpu_do_interrupt: event 0x9:HEX_EVENT_TRAP1, cause 0x1(1)

0xc00002a0:  0x7060c002 { R2 = R0 }
0xc00002a4:  0x5480c20c { trap1(R0,#0x13) }

  hexagon_cpu_do_interrupt: event 0x9:HEX_EVENT_TRAP1, cause 0x13(19)
0xffff0518:  0x5800c02a { jump PC+84 }
0xffff056c:  0x6460c000 { stop(R0) }

How can we be sure errors won't exit(0) or hang?

(qemu) info mtree
address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-00000000ffffffff (prio 0, ram): ddr.ram
     0000000010000000-0000000010000fff (prio 0, i/o): pl011
     0000000011000000-00000000110001ff (prio 0, i/o): virtio-mmio
     0000000012000000-00000000120001ff (prio 0, i/o): virtio-mmio
     00000000d81e0000-00000000d81effff (prio 0, i/o): fast
     00000000d8400000-00000000d87fffff (prio 0, ram): vtcm.ram
     00000000de000000-00000000de0001ff (prio 0, rom): config_table.rom
     00000000fc910000-00000000fc910fff (prio 0, i/o): l2vic

Could we have minimal debug output on the console?

> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


