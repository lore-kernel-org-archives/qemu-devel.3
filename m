Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0414CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjwo-0006l8-Nu; Wed, 20 May 2026 12:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPjwk-0006ks-N8
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:39:02 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPjwi-0005rO-Lp
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:39:02 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso26479245e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779295139; x=1779899939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8YxNL5lvFbalpvgxrslG1XXzZ2cphqKgTDIEmbPRyQw=;
 b=xkdlcMOzK19vYLQqiMr73oItGyXjkqcgOEhISlRUPSNay2UK40GdQSnOn3Hxna6Trk
 oP9kRh16akrQdHixEi18pioUcwN978tFw9JOa/DiinUM5XH141AxJ6IAoz5H2hovGobC
 vZC018Z+T2kod1Hcf3NFuTN3CI2A0SJ+UY1G5KHwSY8FVFEKqpsdeUhs+hYBAimll8DQ
 8QMu7MKLVHydee4OYw3Mk3axLTqQBHuyvLUwdG24uAvNIeQYErt7L4Gboq///4bnrOVA
 hKUw7qxqeVgN7Vuyh13E4aluuM+ZEI8Ex4sWZ2JrQDbTNeJYXRKIknYEBzhhPyJjr1WV
 2OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779295139; x=1779899939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8YxNL5lvFbalpvgxrslG1XXzZ2cphqKgTDIEmbPRyQw=;
 b=Lhu2DU8mRnmYybYhDhknkmoBrmRkaEUBvAGPjcd5HOYPM9WMB6rBL7cLNd7RmQPv8K
 RE4LpLPThv4yGp6fcuxIeZyMMCDcG5Dj9xDwNKGo9UcZOxJ+qM0eDYuzWD3e1L8JhZiO
 u+XoMn2WUOBe1kViO5YNOOvRCwQrtebPjXLjrh8rl4N6iljLdHGLXX94n41IY1+dEsRv
 viYQ8SF6S5BBtD/aeXpeeELXu6TlxHic+rfQ/OgW2GCTqukLAcz3iZfCjK1XD8u5bw5T
 YT9I7vHKsV1x04wTMDOikWx7wLvh8EDCUDDxOZjujG3lGg6TfPKMvA7f+zu+/jV1KeCW
 BQcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9v4RmL/CRYXh3WcpzvJat+SRtmXBPjraWu1KbxUY7q+yng7MLQWYg8sMa+txv7z5Wf080rhFHqjc5h@nongnu.org
X-Gm-Message-State: AOJu0YzCC9YRMjaqGPuu/OzfhENdgxz4cy/ZI+aTgQhzA3k7UJ2xcdoB
 tUcgutJynPmsIyv2VtRt8seekhGW3mETlCI2rYODjghpnx9Y1Msz8RHmfTCDU7KUIG8=
X-Gm-Gg: Acq92OEosNYz9xXqn5K5aCBkqROF+brPuuKJqo7utxF18BFfIwn3mGXkr2yXMFzH04o
 2x4q9M8/PLvKZpBRtbpgxxerGaWbpEmbwRfmQ7i43jDS05/U3EfWArlxWiHr2JA49lSK3K1TegV
 ze6GtiFYqxyIFoDjXHiFSBfmWc5tyqB3oUTRbTou7MMl1r06sFEJIWjY1TPHK2KoXPt4QJqwyFf
 rnEGnvug4Jb9t5HyRFisRP8u+G7e9ffBsiiGhBJe/2pMxDK7tZJ9kEzgqlFS4ZnzXhnylKCT1kD
 mXP9sIC/yoraZtcieFQuz37cUBMiRvkmRKHtPJBUJy014T5TLJ4dKUtDH51frrsTlZlFvo26VmN
 2vLV1DZVQ1uGOWtfW5B54fej22rrb3f4TdPW9dNwiw3O468krnD/nIM1YKMhLmD5McmR5+dFcTj
 G/q89t1RFMLXdod9RKF5Y6XC7hxSdpiqTq3GFoNTF9e9qt77DhLKuCZUdlIX6tQ5QChDcIwjE=
X-Received: by 2002:a05:600c:8715:b0:490:b07:5f27 with SMTP id
 5b1f17b1804b1-4900b07600fmr274227265e9.24.1779295138887; 
 Wed, 20 May 2026 09:38:58 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d5f21dsm3571905e9.13.2026.05.20.09.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 09:38:58 -0700 (PDT)
Message-ID: <0894c314-c2f0-4b8e-bdf1-f0a3792ff0e1@linaro.org>
Date: Wed, 20 May 2026 18:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] tests: add PIC32MK functional and qtest coverage
Content-Language: en-US
To: Ericson Joseph <ericsonjoseph@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260429-pic32mk-board-support-v1-0-1dfac14f8e2d@voltumotor.com>
 <20260429-pic32mk-board-support-v1-2-1dfac14f8e2d@voltumotor.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260429-pic32mk-board-support-v1-2-1dfac14f8e2d@voltumotor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 29/4/26 23:51, Ericson Joseph wrote:
> Wire the PIC32MK tests into the build system:
> 
> - tests/functional/mipsel: register pic32mk as a quick test (30s),
>    build pic32mk_test_fw.bin from assembly source using the mipsel-linux-gnu
>    cross toolchain when available, and run test_pic32mk.py which boots the
>    board and waits for "Hello, PIC32MK!" on UART1.
> 
> - tests/qtest/meson.build: add pic32mk-test and pic32mk-canfd-test to
>    qtests_mipsel (gated on CONFIG_PIC32MK).
> 
> Signed-off-by: Ericson Joseph <ericsonjoseph@gmail.com>
> ---
>   tests/functional/mipsel/meson.build     | 28 ++++++++++
>   tests/functional/mipsel/test_pic32mk.py | 99 +++++++++++----------------------
>   tests/qtest/meson.build                 |  4 +-
>   3 files changed, 63 insertions(+), 68 deletions(-)


> diff --git a/tests/functional/mipsel/test_pic32mk.py b/tests/functional/mipsel/test_pic32mk.py
> index 4af91c4f88..ebfc94f388 100644
> --- a/tests/functional/mipsel/test_pic32mk.py
> +++ b/tests/functional/mipsel/test_pic32mk.py
> @@ -1,9 +1,12 @@
>   #!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-or-later
>   #
> -# Functional tests for the PIC32MK board emulation
> +# Functional test for the Microchip PIC32MK GPK/MCM board emulation.
>   #
> -# Copyright (c) 2026 QEMU contributors
> -# SPDX-License-Identifier: GPL-2.0-or-later
> +# The test firmware (pic32mk_test_fw.S) is a minimal MIPS assembly program
> +# that initialises UART1 and writes "Hello, PIC32MK!\r\n" then spins.
> +# This verifies that the board boots, the CPU executes code, and UART1 TX
> +# produces output on the emulated serial console.
>   
>   import os
>   
> @@ -11,81 +14,43 @@
>   from qemu_test import wait_for_console_pattern
>   
>   
> +def _fw_path():
> +    """Return the path to the pre-built test firmware binary."""
> +    build_dir = os.environ.get('BUILD_DIR', '')
> +    if build_dir:
> +        candidate = os.path.join(build_dir,
> +                                 'tests', 'functional', 'mipsel',
> +                                 'pic32mk_test_fw.bin')
> +        if os.path.isfile(candidate):
> +            return candidate
> +    # Fallback: look next to this file (for out-of-tree runs)
> +    here = os.path.dirname(os.path.abspath(__file__))
> +    return os.path.join(here, 'pic32mk_test_fw.bin')
> +
> +
>   class PIC32MKMachine(QemuSystemTest):
>       """
> -    Tests for the PIC32MK MCU board (-M pic32mk).
> +    Boot test for the Microchip PIC32MK GPK/MCM board (-M pic32mk).
>   
> -    The FreeRTOS firmware is expected to be pre-built at
> -    tests/freertos/hello_freertos.bin relative to the source tree.
> +    Requires pic32mk_test_fw.bin built from pic32mk_test_fw.S by meson.
> +    The binary must be present in the meson build tree under
> +    tests/functional/mipsel/pic32mk_test_fw.bin.
>       """
>   
>       timeout = 30
>   
> -    def get_firmware_path(self):
> -        """Locate the pre-built FreeRTOS firmware binary."""
> -        # data_file() resolves relative to tests/functional/
> -        # We need to go up two levels to reach the source root
> -        src_root = os.path.join(
> -            os.path.dirname(__file__), '..', '..', '..')
> -        fw_path = os.path.realpath(
> -            os.path.join(src_root, 'tests', 'freertos', 'hello_freertos.bin'))
> -        if not os.path.isfile(fw_path):
> +    def test_uart_boot_message(self):
> +        """Board boots and UART1 TX prints the expected banner."""
> +        fw = _fw_path()
> +        if not os.path.isfile(fw):
>               self.skipTest(
> -                f'FreeRTOS firmware not built: {fw_path}\n'
> -                'Run: make -C tests/freertos')
> -        return fw_path
> -
> -    def test_boot_message(self):
> -        """PIC32MK boots and prints the FreeRTOS banner."""
> -        self.set_machine('pic32mk')
> -        self.vm.set_console()
> -        self.vm.add_args('-bios', self.get_firmware_path(),
> -                         '-nographic')
> -        self.vm.launch()
> -        wait_for_console_pattern(self,
> -                                 'PIC32MK QEMU booting FreeRTOS...')
> -
> -    def test_freertos_hello_task(self):
> -        """FreeRTOS scheduler starts and the Hello task fires."""
> -        self.set_machine('pic32mk')
> -        self.vm.set_console()
> -        self.vm.add_args('-bios', self.get_firmware_path(),
> -                         '-nographic')
> -        self.vm.launch()
> -        # First: boot banner
> -        wait_for_console_pattern(self,
> -                                 'PIC32MK QEMU booting FreeRTOS...')
> -        # Second: at least one Hello message (proves Timer1 tick + UART TX IRQ)
> -        wait_for_console_pattern(self,
> -                                 'Hello from FreeRTOS!')
> -
> -    def test_freertos_recurring_ticks(self):
> -        """Timer1 delivers recurring ticks — multiple Hello messages appear."""
> -        self.set_machine('pic32mk')
> -        self.vm.set_console()
> -        self.vm.add_args('-bios', self.get_firmware_path(),
> -                         '-nographic')
> -        self.vm.launch()
> -        wait_for_console_pattern(self,
> -                                 'PIC32MK QEMU booting FreeRTOS...')
> -        # Wait for a second Hello — proves the tick ISR fires repeatedly
> -        # and context switches work (CS0 yield + Timer1 preemption).
> -        wait_for_console_pattern(self,
> -                                 'Hello from FreeRTOS!')
> -        wait_for_console_pattern(self,
> -                                 'Hello from FreeRTOS!')
> -
> -    def test_freertos_ping_task(self):
> -        """Second FreeRTOS task (Ping) also runs — proves multitasking."""
> +                'pic32mk_test_fw.bin not found — '
> +                'build with: ninja -C <builddir> pic32mk_test_fw.bin')
>           self.set_machine('pic32mk')
>           self.vm.set_console()
> -        self.vm.add_args('-bios', self.get_firmware_path(),
> -                         '-nographic')
> +        self.vm.add_args('-bios', fw, '-nographic')
>           self.vm.launch()
> -        wait_for_console_pattern(self,
> -                                 'PIC32MK QEMU booting FreeRTOS...')
> -        # Ping task fires every 5 seconds
> -        wait_for_console_pattern(self, 'Ping')
> +        wait_for_console_pattern(self, 'Hello, PIC32MK!')

You just removed the tests you added in the previous patch, is this
really what you aim for?

