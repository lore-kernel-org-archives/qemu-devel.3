Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5450C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIiY-0001to-Kb; Thu, 02 Jul 2026 10:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfIiK-0001s9-TU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:48:30 -0400
Received: from mail-pz2-x01.google.com ([2607:f8b0:4864:3b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfIiJ-0000jp-9s
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:48:28 -0400
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-c8c1ebd68a1so682583a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783003706; x=1783608506; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SCeMv0MMAa9iI6Ds6fpjAC1GlUKqmp+8wT1cCzkDQOM=;
 b=bT7/RvovRYI6TTdBtCDOMSPTh8FidaFoO4EppDxc79U3GgifAIXYJ4Zl+gOx86WQ6i
 YWhclzWOL876oe8XGq81hkOfXYalkgm116CVfi4qd1Fdmtrc8VYuyap1zu775rGdg2+w
 d37RjzR4ZeUMwvo//STx+20coC/yJmPdKVRddgUs2UejYRNvtzKJGiIyxkKj2vGeFzWc
 0ky9I4E/M0mJH+wFsPFtLv6twWPxL8f6hapiBr7gmRIuW5YlOZcH3E6m2TugmWekNiXa
 O/baFKCvTAvZ4H5H0AfNx1zJuK5IgILSHi8dS0RrOBfVbFNGA2pqel0bgeS/avYRWcHf
 baAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783003706; x=1783608506;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SCeMv0MMAa9iI6Ds6fpjAC1GlUKqmp+8wT1cCzkDQOM=;
 b=JH88e8ds+ISODYFYpPnrU7TrGS7q6tC/hVusqmGtO475oXt0gbT6t8Za7Vvzq217iB
 ervZbR+oe0GHX6lpcAyFCKPQxRut8KuaXFWxIU9YjvxfoH3EgFu532WeKqeTEZ3jKmuj
 aUEL01IhcgHCR/yGA08kXWPEONKQ+6PfLQcxr8pUrnQ4zx575F3xhIgHTb831cboDp0P
 X6uIvm8yEDjPkiyCUTsopSN7rzsyydekmF8DZR5+1kP5vX+mXdIFGfzHS88/Q3gQpk9T
 xKml5wRFcq7HagawhuKEMsDQr9eqaCaijY0XcC/XWBV+mlhN0kbxIvWxFBXYchPLpgvX
 C8iQ==
X-Gm-Message-State: AOJu0YyBTnDPuRvFo3cY7+HuB9H+JePvckMs35R4Fkm2lJxbha+cFxP6
 fdKuzHA55lCmrkNzi2i8BdGGxL2ycKMNtAMrmOqGjQ5ucSE/hSJjSTzr
X-Gm-Gg: AfdE7cnVuCkQTqu66da7hcb1UPHJoyV53L2B94kIhuSZvIa/VAkKOvVyODt0P1ndDoF
 6Ncs+t7JMFbPdZ+RyeOLeJ+xGyPdSFxluJ33P376eYPSd9XwzUW5aqPbHOF2i7ztltDWa4sPAVg
 arateCOXdCPGP5DWIq+xgO2lhOuEPSkmH+v3t6kBXkKkMgkaq3pC5CYRzViiFW+nwGSXAiHtwCR
 2RO+oc0PMhozabfXcl45bqa+3zr0wYJZ1ZFZSJCjRdx9aZkJafrv5i/LH+oqtjAMryvyrrxkkTt
 ous0YvTLag6AI/rOybbn/ATM3/uytQocnJfX9bB+dCawZQRL6dUAUgh7cWQXvq93F5ZINtkZYyJ
 3bu1CAOz7mNLWMNcacYPFCwEhgRBJB6omzuZHQ2GMTIM9mggHFU+o5Miod3a0WVGhjEEsHKJpJT
 jhbuwZkfBuG+TiQjFD2wt83jjlVVJ3PNdFF2JPmr9uLp1+7rsh
X-Received: by 2002:a05:6a21:4ccb:b0:3bf:6c08:4ebb with SMTP id
 adf61e73a8af0-3bfed592afamr7465642637.48.1783003705940; 
 Thu, 02 Jul 2026 07:48:25 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd223esm10673017eec.21.2026.07.02.07.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:48:25 -0700 (PDT)
Date: Thu, 2 Jul 2026 22:48:22 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 andrew.jones@oss.qualcomm.com, 
 leif.lindholm@oss.qualcomm.com, uwu@icenowy.me,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v8 6/7] tests/functional/riscv64: add riscv-server-ref
 TPM selftest
Message-ID: <akZ6LnH2X4NZ-cz8@ChaodeMacBook-Pro.local>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-7-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610214133.1882563-7-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::1;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pz2-x01.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jun 10, 2026 at 06:41:32PM +0800, Daniel Henrique Barboza wrote:
> Add a TPM specific selftest for the riscv-server-ref board.  The test
> will be skipped if there's no 'swtpm' in the host.
> 
> The test has been basically cloned from our Aspeed ast2600 friends.
> Shoutout to monsieur Cédric Le Goater for the code.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  tests/functional/riscv64/test_server_ref.py | 31 ++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/functional/riscv64/test_server_ref.py
> index 2ecfcf60ad..9b120628dc 100755
> --- a/tests/functional/riscv64/test_server_ref.py
> +++ b/tests/functional/riscv64/test_server_ref.py
> @@ -8,8 +8,13 @@
>  riscv-server-ref board test
>  """
>  
> +import os
> +import tempfile
> +import subprocess
> +
>  from qemu_test import QemuSystemTest, Asset
>  from qemu_test import wait_for_console_pattern
> +from qemu_test import skipIfMissingCommands
>  
>  class RiscvServerRefTest(QemuSystemTest):
>      """
> @@ -26,7 +31,7 @@ class RiscvServerRefTest(QemuSystemTest):
>           'master/riscv/images/virt64/buildroot/rootfs.ext2'),
>          'f00bb88749f945d80675540a1338bd1ccb226574685a5b6c65ab44027d0411a8')
>  
> -    def test_boot_linux_test(self):
> +    def _test_boot_linux_test(self, tpmstate_dir=None):
>          self.set_machine('riscv-server-ref')
>          kernel_path = self.ASSET_KERNEL.fetch()
>          rootfs_path = self.ASSET_ROOTFS.fetch()
> @@ -38,6 +43,22 @@ def test_boot_linux_test(self):
>          self.vm.add_args('-device', 'ahci,id=ahci')
>          self.vm.add_args('-device', 'ide-hd,drive=hd0,bus=ahci.0')
>  
> +        if tpmstate_dir is not None:
> +            # Note: code taken verbatim from
> +            # tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
> +
> +            # We must put the TPM state dir in /tmp/, not the build dir,
> +            # because some distros use AppArmor to lock down swtpm and
> +            # restrict the set of locations it can access files in.
> +            socket = os.path.join(tpmstate_dir, 'swtpm-socket')
> +            subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
> +                            '--tpmstate', f'dir={tpmstate_dir}',
> +                            '--ctrl', f'type=unixio,path={socket}'],
> +                           check=True)
> +            self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
> +            self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
> +            self.vm.add_args('-device', 'tpm-tis-device,tpmdev=tpm0')
> +
>          self.vm.set_console()
>          self.vm.launch()
>  
> @@ -55,5 +76,13 @@ def test_boot_linux_test(self):
>          # Wait for boot to complete - system reaches login prompt
>          wait_for_console_pattern(self, 'Run /sbin/init as init process')
>  
> +    def test_boot_linux_test(self):
> +        self._test_boot_linux_test()
> +
> +    @skipIfMissingCommands('swtpm')
> +    def test_boot_linux_test_tpm(self):
> +        with tempfile.TemporaryDirectory(prefix="qemu_") as tpmstate_dir:
> +            self._test_boot_linux_test(tpmstate_dir)
> +
>  if __name__ == '__main__':
>      QemuSystemTest.main()
> -- 
> 2.43.0
> 

