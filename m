Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF182E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL763-0007bk-6t; Tue, 10 Dec 2024 15:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75h-0007Gl-74
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:22 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75Q-00026W-0q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:20 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434a766b475so57718885e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863442; x=1734468242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqKxllH7xMCrc05dAd59jYuHz9i+OMonrBqQrwPpDV8=;
 b=HlniPmCJgqF27x6tLF05zuSDk8dzbQzIV11PBcts6x5lrA4njkKG7sAC6x5elez6q2
 2bf0JVCfaYFXL+FVcr+Csxq9u42bqiGRxH/IyuYa3GlDHCg5D9aTAKEhzzl3g/lDB7YA
 SolR5a8AfN0K7cJq+KY5YH/+dP43K2IAVIMKk8YtL7HXLeutH0UNm09GGBwPh7TshJBh
 CRMI+afInbS3DBtWiAaPZcyjHTxjcXpoRhWP1K6RXueoXhlaKSMhgqTx1ld5r+iFDB9K
 s/83gcdH6Hbm64OwkrJPq3fm1gwkZAvK7LIZpjAeVpyhRGxzzRwt2EUeFcR8q3AqM56B
 /pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863442; x=1734468242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqKxllH7xMCrc05dAd59jYuHz9i+OMonrBqQrwPpDV8=;
 b=G22waZfbts8ghGAqaCzJP3t4gUieJ3y7NSpyta02/xUl8LJe5+7kiWHXU32+0mFYxR
 xrWdxT6txBgeCU8d8s/Bs7/hUN3TxVi5zF44zq5K6k3esxcV1/Sn5pQzpvuIxjnBtr4Q
 7VW4UB5XEm+pVtSQymlqy8F1bu9BiLD078pdL4I6wXBNPtqP5V6sivG9pnLexdJoLJvB
 GirgWuvcZqc+j9hCcrMI5KlatHFMug4AkvThl9GrbXeZFhfxpGngkkplkga0t6jKTXB3
 IRmhb/7u5ZE76NOBG23uLX9Rr5uC7LLIP4OR5Q1HeQvs+OjZUoLckoHfyeqcjfhEdNvG
 lo8w==
X-Gm-Message-State: AOJu0YwXexMa1Co48QP8aMw0IInr2AV64rIaX5UJy1nfKXS50KqEXo7V
 G/YHxfmkj1ejvchwUCAuK+a+/6/CvKkKvpx1C69OTqkDdY2aVv7XQiijwK0E8VE=
X-Gm-Gg: ASbGncuaLde4v2Jcn/s9M5bUigiHB1gGkd4nI28qhyG3BAL9kYfjR7VWjmFvAoHHCxZ
 1fWG2i5Na7EWy1jd6rEbAYnNkj1Vu/uotxuJV/6pGGN1oDloSUXXLIaHS+2oFvZhUBLpmRHRfzy
 IqzlRaxa/h+pMDsK9YFBv6lZGZ4dRe4MseRPJRkxJer2sOqoy8QRzWQvjcOlkTwoHXxf+W1YqyP
 lyLSTL2OIs6dWIE7PoU3L3JYAXrp5mraOKhreEmS0H4xbUAqrfG
X-Google-Smtp-Source: AGHT+IGex5LNwcMXTkoZVumCiygtyC0YeUBCcAKydQS2OFpD9yOmHfg3vvDzMZNB8ZBpaOIIMrkLsg==
X-Received: by 2002:a05:600c:4f86:b0:430:5887:c238 with SMTP id
 5b1f17b1804b1-4361c35f09fmr1871105e9.11.1733863442518; 
 Tue, 10 Dec 2024 12:44:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da11935asm204248395e9.37.2024.12.10.12.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1697760BA3;
 Tue, 10 Dec 2024 20:43:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cleber Rosa <crosa@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 20/20] tests/functional: extend test_aarch64_virt with vulkan
 test
Date: Tue, 10 Dec 2024 20:43:49 +0000
Message-Id: <20241210204349.723590-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Now we have virtio-gpu Vulkan support lets add a test for it.
Currently this is using images build by buildroot:

  https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.html

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt.py | 83 ++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 801300607c..25d11e2626 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -14,11 +14,12 @@
 import os
 import logging
 
+from qemu.machine.machine import VMLaunchFailure
+
 from qemu_test import BUILD_DIR
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command, wait_for_console_pattern
-from qemu_test import get_qemu_img, run_cmd
-
+from qemu_test import exec_command, wait_for_console_pattern, exec_command_and_wait_for_pattern
+from qemu_test import has_cmd, get_qemu_img, run_cmd
 
 class Aarch64VirtMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
@@ -125,5 +126,81 @@ def test_aarch64_virt_gicv2(self):
         self.common_aarch64_virt("virt,gic-version=2")
 
 
+    ASSET_VIRT_GPU_KERNEL = Asset(
+        ('https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
+         'download?path=%2F&files='
+         'Image'),
+        '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462f6')
+
+    ASSET_VIRT_GPU_ROOTFS = Asset(
+        ('https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
+         'download?path=%2F&files='
+         'rootfs.ext4.zstd'),
+        '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
+
+    def test_aarch64_virt_with_gpu(self):
+        # This tests boots with a buildroot test image that contains
+        # vkmark and other GPU exercising tools. We run a headless
+        # weston that nevertheless still exercises the virtio-gpu
+        # backend.
+
+        (has_zstd, msg) = has_cmd('zstd')
+        if has_zstd is False:
+            self.skipTest(msg)
+        self.zstd = 'zstd'
+
+        image_path_zst = self.ASSET_VIRT_GPU_ROOTFS.fetch()
+        kernel_path = self.ASSET_VIRT_GPU_KERNEL.fetch()
+
+        image_path = self.workdir + "/rootfs.ext4"
+
+        run_cmd([self.zstd, "-f", "-d", image_path_zst,
+                 "-o", image_path])
+
+        self.set_machine('virt')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0 root=/dev/vda')
+        self.require_accelerator("tcg")
+
+        self.vm.add_args("-accel", "tcg")
+        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=on")
+        self.vm.add_args("-machine",
+                         "virt,virtualization=on,"
+                         "gic-version=max",
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.add_args("-smp", "2", "-m", "2048")
+        self.vm.add_args("-device", "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
+        self.vm.add_args("-display", "egl-headless")
+        self.vm.add_args("-display", "dbus,gl=on")
+        self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
+        self.vm.add_args("-blockdev",
+                         "driver=raw,file.driver=file,node-name=hd0,read-only=on,"
+                         f"file.filename={image_path}")
+        self.vm.add_args("--snapshot")
+
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as e:
+            if "old virglrenderer, blob resources unsupported" in e.output:
+                self.skipTest("No blob support for virtio-gpu")
+            elif "old virglrenderer, venus unsupported" in e.output:
+                self.skipTest("No venus support for virtio-gpu")
+            else:
+                self.log.info(f"un-handled launch failure: {e.output}")
+                raise e
+
+        self.wait_for_console_pattern('buildroot login:')
+        exec_command(self, 'root')
+        exec_command(self, 'export XDG_RUNTIME_DIR=/tmp')
+        exec_command_and_wait_for_pattern(self,
+                                          "weston -B headless "
+                                          "--renderer gl "
+                                          "--shell kiosk "
+                                          "-- vkmark",
+                                          "vkmark Score")
+
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.39.5


