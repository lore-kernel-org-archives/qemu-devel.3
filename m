Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85407C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglAU-0000gU-IS; Wed, 21 Aug 2024 09:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sglAL-0000Nz-UC
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sglAG-0008MM-6I
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724246053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EheRRG847oiyyKF0lDkTGHDNhR+DEnD14RF/UVKpCrI=;
 b=ZBA/A4Rc81MgrbsdAATgeBXwOBZ0E+CU++eYOoV/5OKO+csTchUSbUXkKuoDZkGDQ85ptw
 25qLB5GnRgUpZfHDo5cepbVa2KLE7chQF219oQrYjOciCbHcUrBg+VArofl7vga73WZcTV
 G3k8YoQn5bZL3CHMXwlWPMnmKHE1SaU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-oYzRktOgPkCgc2aVUfIncw-1; Wed, 21 Aug 2024 09:14:11 -0400
X-MC-Unique: oYzRktOgPkCgc2aVUfIncw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280a434147so56392355e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 06:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724246050; x=1724850850;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EheRRG847oiyyKF0lDkTGHDNhR+DEnD14RF/UVKpCrI=;
 b=H2hAUz68IMip0QFyrVWPSxh5FgTT+4BjanSekaTbsPgpZQqSQgNva82qkxZbIFucTp
 1blHKAh4cnKJrbTpZSrkc87gIVgqRclXucqNcCsxkKICFoiUSzNI2wjN9s90RliHmzug
 nfzmlLTiaZH/yqPAx8v323vgYh+OamAm33TXxZkXZJY6lIUj5z3alCBa54JadKhUGkGo
 fF9Fg1cxaac5BB8E62SHLGmJX8b8BIhNfPHh7GnGlsYF7nEgv+a9NmTE9S10CH9bhh0N
 m9/2F5M45FE41n+yLDQKuPVrY4fdwAkAXAfrY+O1s7ydn7lDoxVY85JfI7Htxt032Ihy
 k5MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEkY7gr42p/xtbOO6l8X1/50oMFfrA3R9W6PfGWe6q6b7syUbSp+q07/2U3bQo1rLFNQV3o/dQC8x/@nongnu.org
X-Gm-Message-State: AOJu0YwSYSJxOxUbxm/00c4zHQJmKcM3TSNKu4dnXbyvLVf9nYM8Za6M
 6gSefKzsIX7UkS/ttwmkQAJtBxMTOIUTqzwbkgmHQsFUnKNY1L9/Vo5eVloLDya9svwGfBJAh7f
 T3Y8yM6+qzy+9cAuHA7GbNiS307Y+d9vMKD/JGEuSnjUPw5+aeH97lyvD18vC
X-Received: by 2002:a05:600c:5489:b0:426:6b92:387d with SMTP id
 5b1f17b1804b1-42abf05d434mr14010765e9.21.1724246050109; 
 Wed, 21 Aug 2024 06:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXw+/Ct5jVX2A7MwuTC5ozSOFmXbgqqoO6lfIkTbdL5aRZSnibh3OkZvKe73InkhUxNygcmw==
X-Received: by 2002:a05:600c:5489:b0:426:6b92:387d with SMTP id
 5b1f17b1804b1-42abf05d434mr14010535e9.21.1724246049635; 
 Wed, 21 Aug 2024 06:14:09 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abed8b86bsm25443145e9.4.2024.08.21.06.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 06:14:09 -0700 (PDT)
Message-ID: <cba8d04b-f4af-4f3c-9f19-456180af84dc@redhat.com>
Date: Wed, 21 Aug 2024 15:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: Convert mips64el Malta I6400
 avocado tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Beraldo Leal <bleal@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240821125701.63042-1-philmd@linaro.org>
 <20240821125701.63042-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240821125701.63042-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 21/08/2024 14.57, Philippe Mathieu-Daudé wrote:
> Straight forward conversion. Update the SHA1 hashes to SHA256
> hashes since SHA1 should not be used anymore nowadays.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                             |   1 +
>   tests/avocado/machine_mips_malta.py     | 108 -----------------------
>   tests/functional/meson.build            |   1 +
>   tests/functional/test_mips64el_malta.py | 111 ++++++++++++++++++++++++
>   4 files changed, 113 insertions(+), 108 deletions(-)
>   create mode 100755 tests/functional/test_mips64el_malta.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77fbb5d42e..3a91017979 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1369,6 +1369,7 @@ F: hw/pci-host/gt64120.c
>   F: include/hw/southbridge/piix.h
>   F: tests/avocado/linux_ssh_mips_malta.py
>   F: tests/avocado/machine_mips_malta.py
> +F: tests/functional/test_mips64el_malta.py
>   
>   Mipssim
>   R: Aleksandar Rikalo <arikalo@gmail.com>
> diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
> index 07a80633b5..05c64e18c4 100644
> --- a/tests/avocado/machine_mips_malta.py
> +++ b/tests/avocado/machine_mips_malta.py
> @@ -8,121 +8,13 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
>   import os
> -import gzip
> -import logging
>   
> -from avocado import skipUnless
> -from avocado import skipUnless
>   from avocado.utils import archive
>   from avocado_qemu import QemuSystemTest
> -from avocado_qemu import exec_command_and_wait_for_pattern
>   from avocado_qemu import interrupt_interactive_console_until_pattern
>   from avocado_qemu import wait_for_console_pattern
>   
>   
> -NUMPY_AVAILABLE = True
> -try:
> -    import numpy as np
> -except ImportError:
> -    NUMPY_AVAILABLE = False
> -
> -CV2_AVAILABLE = True
> -try:
> -    import cv2
> -except ImportError:
> -    CV2_AVAILABLE = False
> -
> -
> -@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> -@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> -class MaltaMachineFramebuffer(QemuSystemTest):
> -
> -    timeout = 30
> -
> -    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> -
> -    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
> -        """
> -        Boot Linux kernel and check Tux logo is displayed on the framebuffer.
> -        """
> -        screendump_path = os.path.join(self.workdir, 'screendump.pbm')
> -
> -        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
> -                      'a5966ca4b5/mips/malta/mips64el/'
> -                      'vmlinux-4.7.0-rc1.I6400.gz')
> -        kernel_hash = '096f50c377ec5072e6a366943324622c312045f6'
> -        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> -        kernel_path = self.workdir + "vmlinux"
> -        archive.gzip_uncompress(kernel_path_gz, kernel_path)
> -
> -        tuxlogo_url = ('https://github.com/torvalds/linux/raw/v2.6.12/'
> -                       'drivers/video/logo/logo_linux_vga16.ppm')
> -        tuxlogo_hash = '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
> -        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash)
> -
> -        self.vm.set_console()
> -        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> -                               'clocksource=GIC console=tty0 console=ttyS0')
> -        self.vm.add_args('-kernel', kernel_path,
> -                         '-smp', '%u' % cpu_cores_count,
> -                         '-vga', 'std',
> -                         '-append', kernel_command_line)
> -        self.vm.launch()
> -        framebuffer_ready = 'Console: switching to colour frame buffer device'
> -        wait_for_console_pattern(self, framebuffer_ready,
> -                                 failure_message='Kernel panic - not syncing')
> -        self.vm.cmd('human-monitor-command', command_line='stop')
> -        self.vm.cmd('human-monitor-command',
> -                    command_line='screendump %s' % screendump_path)
> -        logger = logging.getLogger('framebuffer')
> -
> -        match_threshold = 0.95
> -        screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)
> -        tuxlogo_bgr = cv2.imread(tuxlogo_path, cv2.IMREAD_COLOR)
> -        result = cv2.matchTemplate(screendump_bgr, tuxlogo_bgr,
> -                                   cv2.TM_CCOEFF_NORMED)
> -        loc = np.where(result >= match_threshold)
> -        tuxlogo_count = 0
> -        h, w = tuxlogo_bgr.shape[:2]
> -        debug_png = os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
> -        for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=1):
> -            logger.debug('found Tux at position (x, y) = %s', pt)
> -            cv2.rectangle(screendump_bgr, pt,
> -                          (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
> -        if debug_png:
> -            cv2.imwrite(debug_png, screendump_bgr)
> -        self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
> -
> -    def test_mips_malta_i6400_framebuffer_logo_1core(self):
> -        """
> -        :avocado: tags=arch:mips64el
> -        :avocado: tags=machine:malta
> -        :avocado: tags=cpu:I6400
> -        """
> -        self.do_test_i6400_framebuffer_logo(1)
> -
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
> -    def test_mips_malta_i6400_framebuffer_logo_7cores(self):
> -        """
> -        :avocado: tags=arch:mips64el
> -        :avocado: tags=machine:malta
> -        :avocado: tags=cpu:I6400
> -        :avocado: tags=mips:smp
> -        :avocado: tags=flaky
> -        """
> -        self.do_test_i6400_framebuffer_logo(7)
> -
> -    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
> -    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
> -        """
> -        :avocado: tags=arch:mips64el
> -        :avocado: tags=machine:malta
> -        :avocado: tags=cpu:I6400
> -        :avocado: tags=mips:smp
> -        :avocado: tags=flaky
> -        """
> -        self.do_test_i6400_framebuffer_logo(8)
> -
>   class MaltaMachine(QemuSystemTest):
>   
>       def do_test_yamon(self):
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 8d28313a65..1823f88897 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -56,6 +56,7 @@ tests_mips64el_quick = [
>   ]
>   
>   tests_mips64el_thorough = [
> +  'mips64el_malta',
>     'mips64el_loongson3v',
>   ]

Maybe keep the list in alphabetical order?

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


