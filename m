Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3EAE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV0h-0001Lg-7t; Wed, 08 Jan 2025 07:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUuo-0000yJ-7e
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:12:06 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUuS-0007Lh-GM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:11:56 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaef00ab172so1943995666b.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338272; x=1736943072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vq4Qkciwh7M0vksShefS4DYNksffCFzZUscSyEDE7S8=;
 b=VqfnSUHNjOcgBZE04BOvNWXgKJHrFimB2VxNBj/BCCLPBNqcEd2zRQqk7hHsr5/EwT
 77WAEm3wiCj732dGPrDhzf1CDkSc3OM+bxe22QaXTKsUlYs+66lI/2YBCIN7D7XpnAYW
 oXEfbJhBi6NW5SZdg5qabvAxNY6gWUKaScbHz0QyAVfz71MqdQ+f/jbnyFMdrvQN+64z
 Mxtkqr/1/HKZbHIhjrDwGSijppGdpEPF0CW2kz8iP8++IJi8sy2+YxCulU89iW+uFD4I
 bu+W3swjnQtib0mlb+faHZ95LXEnenxbgMj0Ylo1XW94pRGJDVC0iolWTl3ZdE+W5ep6
 V8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338272; x=1736943072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vq4Qkciwh7M0vksShefS4DYNksffCFzZUscSyEDE7S8=;
 b=UGFegUvlYh1iKtesAsefhQK9ihuj9NP5vUJSuTtE0xP09f6mYyAvvZBdPCZtdKlMyc
 mla+9o1zX+1FhhRPM3NUqFE2HjbLfm+N4K8oiMSIW9PaqQS8oOkDYDzVk5CLYz4wOg5i
 NPiM+yAOYElUzfswN7YhMH0kD0QJuc3NDazbfgJ/EvnBezHvgymQJpEk7CbuYGVE9nmo
 1YJ38UXfqFIS4TrEu+tQDFwiSj+9lJfPyvrqLG+PqKWgU6fh4aXHRF0GiVvjjpF/BSKN
 I66kvPbZFkqXepHjAcjdDmswqrGoYojUTpQtUJrvBh7JLZODuLgMW8lm5d1YQzeR18lX
 5T6g==
X-Gm-Message-State: AOJu0YzeRT4vn/6uHrdm009dRTbtj6Uw2z9GpD4RGLTYfk8pXbnCV8s8
 84D0GLcJoLEjUdWj4OLIatI81YzL/eLrM9VRzH/w69Zge4ThiXBqms4Cfks7BpU=
X-Gm-Gg: ASbGncsKxTlhlCLimrNqXk8dPQThdK34Q6Ojm5roY8N7ksurHjjNS3QqbsscZ5SEwF3
 rkmrc9FPkMcS28zxJIzNSRn7GVySOtSbXQ2sxN5HT7JBxeJqjofeI4yLR/GdDfRO2jnYqOuVqvp
 wvCXiOWITduj4pRteS0POQLvuxjhECJzQuewO9taPHwtj01fgnsfEzHND5V6dX7uKV8EOZoISaJ
 MhjGn1NvvjICjWGRuQr1BaxTu71NiUKiCLyssbpcjhlcybB7bg2ZaQ=
X-Google-Smtp-Source: AGHT+IGqyVWL23twfGdSv62KajzlAjpNkDYLneH2hB6KzCps4JesxIYZgfHVCvDT80j/13aZwVMeHQ==
X-Received: by 2002:a05:6402:400a:b0:5d2:7199:ac2 with SMTP id
 4fb4d7f45d1cf-5d972e00032mr5639415a12.2.1736338271482; 
 Wed, 08 Jan 2025 04:11:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806fed4e1sm26068538a12.70.2025.01.08.04.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:11:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBD195F8AC;
 Wed,  8 Jan 2025 12:10:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Subject: [PATCH v4 23/32] tests/functional: extend test_aarch64_virt with
 vulkan test
Date: Wed,  8 Jan 2025 12:10:45 +0000
Message-Id: <20250108121054.1126164-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Now that we have virtio-gpu Vulkan support, let's add a test for it.
Currently this is using images build by buildroot:

  https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.html

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use decorator for has_cmd(zstd)
  - un-handled->unhandled
  - drop extra - from --snapshot
  - drop unneeded virtualization=on
  - only show 1s of each scene
  - fix long lines
v3
  - move set_machine/require_accelerator to top of test
  - use uncompress utility function
  - remove extra ()'s from ASSETS
v4
  - split misc fixups into earlier commits
  - don't swallow leading newlines before class
  - fixup commit message
---
 tests/functional/test_aarch64_virt.py | 74 ++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 201c5ed023..6b2336a28d 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -13,10 +13,12 @@
 import logging
 from subprocess import check_call, DEVNULL
 
+from qemu.machine.machine import VMLaunchFailure
+
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
-from qemu_test import get_qemu_img
+from qemu_test import skipIfMissingCommands, get_qemu_img
 
 
 class Aarch64VirtMachine(QemuSystemTest):
@@ -132,5 +134,73 @@ def test_aarch64_virt_gicv2(self):
         self.common_aarch64_virt("virt,gic-version=2")
 
 
+    ASSET_VIRT_GPU_KERNEL = Asset(
+        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
+        'download?path=%2F&files='
+        'Image',
+        '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462f6')
+
+    ASSET_VIRT_GPU_ROOTFS = Asset(
+        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
+        'download?path=%2F&files='
+        'rootfs.ext4.zstd',
+        '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
+
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_gpu(self):
+        # This tests boots with a buildroot test image that contains
+        # vkmark and other GPU exercising tools. We run a headless
+        # weston that nevertheless still exercises the virtio-gpu
+        # backend.
+
+        self.set_machine('virt')
+        self.require_accelerator("tcg")
+
+        kernel_path = self.ASSET_VIRT_GPU_KERNEL.fetch()
+        image_path = self.uncompress(self.ASSET_VIRT_GPU_ROOTFS, format="zstd")
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0 root=/dev/vda')
+
+        self.vm.add_args("-accel", "tcg")
+        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=on")
+        self.vm.add_args("-machine", "virt,gic-version=max",
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.add_args("-smp", "2", "-m", "2048")
+        self.vm.add_args("-device",
+                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
+        self.vm.add_args("-display", "egl-headless")
+        self.vm.add_args("-display", "dbus,gl=on")
+        self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
+        self.vm.add_args("-blockdev",
+                         "driver=raw,file.driver=file,"
+                         "node-name=hd0,read-only=on,"
+                         f"file.filename={image_path}")
+        self.vm.add_args("-snapshot")
+
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as excp:
+            if "old virglrenderer, blob resources unsupported" in excp.output:
+                self.skipTest("No blob support for virtio-gpu")
+            elif "old virglrenderer, venus unsupported" in excp.output:
+                self.skipTest("No venus support for virtio-gpu")
+            else:
+                self.log.info("unhandled launch failure: {excp.output}")
+                raise excp
+
+        self.wait_for_console_pattern('buildroot login:')
+        exec_command(self, 'root')
+        exec_command(self, 'export XDG_RUNTIME_DIR=/tmp')
+        exec_command_and_wait_for_pattern(self,
+                                          "weston -B headless "
+                                          "--renderer gl "
+                                          "--shell kiosk "
+                                          "-- vkmark -b:duration=1.0",
+                                          "vkmark Score")
+
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.39.5


