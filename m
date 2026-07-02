Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3554C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIbx-00085B-Bx; Thu, 02 Jul 2026 10:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfIbo-00081x-LX
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:41:49 -0400
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfIbm-0006A9-Pe
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:41:44 -0400
Received: by mail-pj2-x04.google.com with SMTP id
 98e67ed59e1d1-37e1ff48b94so496856a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783003301; x=1783608101; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TR5Yj+jnC+eI/ZZxaHf3fwGoW6DrtKmYIMhR0sP7/ww=;
 b=QlvkUEXB5759zN9Fe6Xpymx8jXoORmVXGLGqDq+tCWMF32oRWGkMG59VZqwcsecvZ4
 GFcwECyPmwc6kFpjV0uSRo9rfbhYnlzAzkgdPyWVdNaUckOVVuXu/0800dCrf4t1Y/ns
 7xY2XSKUk9ni08E2lEnQTkSh24IWxSimlPj50ji4LLSo+Jrn/T7rfb5AFyxrl76r/DNo
 0yAwNKHosV0GPwhCqljHjfBOWsu22eUg5POJLeuPdMDqdU+a36U7Ri4YObdKDzvA02ZU
 5GX1YIvHbvsU/nEGq5nvOEr/lWNJaOOgS2nLsSTYAnD850PILFH/BQDQW7zIOcEIAcHt
 U1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783003301; x=1783608101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TR5Yj+jnC+eI/ZZxaHf3fwGoW6DrtKmYIMhR0sP7/ww=;
 b=laaqwENdVea6wFzeB6Tt0a8NtsZhuOSVkqrCT697DacWejkzQtifBmtxKpvFR6aLdg
 YkGc6dQNneZTajHgiAGaq+wn+AcIhb8ofTtcG1ygHfwumKLvo8GdETPiec39YnnWDvr2
 EOse0CT/tnBlIXXA2P4R12Hg5j3jXTRtdnKVI/mh9UuwY+JUZsdURyplVW/wFvcJDEQ5
 S+xK/7PrHvqtGDoP+iF/BZaSOvfsQocBSE40+65/bAYtkqVXF9HGkUDlJ3YhWNSOXX2C
 cDoyx951Si7eE5m5d/Ky3uhTv0sqMY54LdbbgHxDc5ptvfDyXstexxKwyDZvON1OeMSi
 okVw==
X-Gm-Message-State: AOJu0YzZXYQq8iK0jV3J5RS/5o9/vR8JbenzVgsqwLUmltwIcK4bg/Gn
 yh+O9nK/KbKz2bjFerXXQc7H6y8B57FuQLn1/yVuR09XpBnJpRecOYm/
X-Gm-Gg: AfdE7clVeQ5W2dlR2lN/NHF/MGpsjSD7csrEENVQHVr45FSKxHr3HPxxERetb5rzygH
 Rz/FaQcX8gu1RLBRB15HVs2dpJfXoNf8x1zQoLYBEI7UrGXP/h78CoEaSj9GRQmhGfGTXvuSUEf
 MfudW/gcVx5jU1dpMk85iM51HOm0OYKo/tkDoIkm2cAQGUb8F5mdDG4Mc5uDooPVxE/s4BHJXBK
 nBkasZude/t5yHHgMksroToXchXup718xfl2GOzbKmvDSwh4uyw/E2bShMUXul0OyES75+7kDwe
 COPHB0jThF3+mc9qHorpLFbwpG+ynbwVB5pwY1dEH0ReP7Bzvc556URhXXKNBL7VQ0K4lGeeHNK
 NAYSOWO7HvnzCGT1dLyLTxzB0gvQF6vspKEiBWTRXldMec7zvJjLsHrQk9npiY43w9k7ZRRMusI
 1jqXNTLl6LEhnnkUbJrvPrYTxvxC71QDNkUgpkEFV4nDA4Y8n8
X-Received: by 2002:a05:6a20:2589:b0:3b4:8300:7019 with SMTP id
 adf61e73a8af0-3bff40dd9e9mr6158803637.18.1783003301090; 
 Thu, 02 Jul 2026 07:41:41 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bb84405sm14492228eec.17.2026.07.02.07.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:41:40 -0700 (PDT)
Date: Thu, 2 Jul 2026 22:41:38 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 andrew.jones@oss.qualcomm.com, 
 leif.lindholm@oss.qualcomm.com, uwu@icenowy.me,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v8 4/7] tests/functional/riscv64: add riscv-server-ref
 tests
Message-ID: <akZ4mVkirzIknpZ-@ChaodeMacBook-Pro.local>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-5-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610214133.1882563-5-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::4;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x04.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 10, 2026 at 06:41:30PM +0800, Daniel Henrique Barboza wrote:
> Add two tests for the recently added riscv-server-ref machine:
> 
> - a new test_opensbi.py test.  The idea is to have a quick test that can
> catch trivial regressions that would prevent OpenSBI to finish;
> - a new Linux boot "thorough" test that will boot the machine up to the
> buildroot prompt.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  tests/functional/riscv64/meson.build        |  2 +
>  tests/functional/riscv64/test_opensbi.py    |  4 ++
>  tests/functional/riscv64/test_server_ref.py | 59 +++++++++++++++++++++
>  3 files changed, 65 insertions(+)
>  create mode 100755 tests/functional/riscv64/test_server_ref.py
> 
> diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
> index 5871211e89..2eb12586bf 100644
> --- a/tests/functional/riscv64/meson.build
> +++ b/tests/functional/riscv64/meson.build
> @@ -2,6 +2,7 @@
>  
>  test_riscv64_timeouts = {
>    'boston' : 120,
> +  'server_ref' : 120,
>    'tuxrun' : 120,
>  }
>  
> @@ -13,6 +14,7 @@ tests_riscv64_system_quick = [
>  tests_riscv64_system_thorough = [
>    'endianness',
>    'boston',
> +  'server_ref',
>    'sifive_u',
>    'tuxrun',
>  ]
> diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/riscv64/test_opensbi.py
> index d077e40f42..057f55f90b 100755
> --- a/tests/functional/riscv64/test_opensbi.py
> +++ b/tests/functional/riscv64/test_opensbi.py
> @@ -32,5 +32,9 @@ def test_riscv_virt(self):
>          self.set_machine('virt')
>          self.boot_opensbi()
>  
> +    def test_riscv_server_ref(self):
> +        self.set_machine('riscv-server-ref')
> +        self.boot_opensbi()
> +
>  if __name__ == '__main__':
>      QemuSystemTest.main()
> diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/functional/riscv64/test_server_ref.py
> new file mode 100755
> index 0000000000..2ecfcf60ad
> --- /dev/null
> +++ b/tests/functional/riscv64/test_server_ref.py
> @@ -0,0 +1,59 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +"""
> +riscv-server-ref board test
> +"""
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +
> +class RiscvServerRefTest(QemuSystemTest):
> +    """
> +    Test the riscv-server-ref board
> +    """
> +
> +    ASSET_KERNEL = Asset(
> +        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
> +         'master/riscv/images/virt64/buildroot/Image'),
> +        '6bacc876c769c1bb6057d2bf549eba67fbe83916e8223f9fe21c8e8fff665a36')
> +
> +    ASSET_ROOTFS = Asset(
> +        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
> +         'master/riscv/images/virt64/buildroot/rootfs.ext2'),
> +        'f00bb88749f945d80675540a1338bd1ccb226574685a5b6c65ab44027d0411a8')
> +
> +    def test_boot_linux_test(self):
> +        self.set_machine('riscv-server-ref')
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        rootfs_path = self.ASSET_ROOTFS.fetch()
> +
> +        self.vm.add_args('-kernel', kernel_path)
> +        self.vm.add_args('-append', 'rw rootwait root=/dev/sda')
> +        self.vm.add_args('-drive',
> +            f'file={rootfs_path},format=raw,id=hd0,snapshot=on,if=none')
> +        self.vm.add_args('-device', 'ahci,id=ahci')
> +        self.vm.add_args('-device', 'ide-hd,drive=hd0,bus=ahci.0')
> +
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +        # Wait for OpenSBI
> +        wait_for_console_pattern(self, 'OpenSBI')
> +
> +        # Wait for Linux kernel boot
> +        wait_for_console_pattern(self, 'Linux version')
> +        wait_for_console_pattern(self, 'Machine model: qemu,riscv-server-ref')
> +
> +        # Test e1000e network card functionality
> +        wait_for_console_pattern(self, 'e1000e')
> +        wait_for_console_pattern(self, 'Network Connection')
> +
> +        # Wait for boot to complete - system reaches login prompt
> +        wait_for_console_pattern(self, 'Run /sbin/init as init process')
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()
> -- 
> 2.43.0
> 

