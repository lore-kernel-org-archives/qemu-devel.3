Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88225C7EE30
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgCe-0005qo-KZ; Mon, 23 Jun 2025 08:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgAd-0003wM-6N
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:21:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgAY-00018W-Vq
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:21:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cf214200so37523495e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681260; x=1751286060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udXllEXY1gPSi8pgPr+YWAsY2WGcZfddjVlJVNiCuOE=;
 b=p4iThvalXLPbHqb4TmUXgPVR6yY51PhtEWDHf+AVUILJsIDbybhuvI/ZID0LsZofuB
 8tyPatkaum8NYxOs8zfoQFgX5yZJqHzOmhQ1gUjhVh8FWFPTbMON52EYB/xdwHbyk1bz
 m4/+GGG8n+K6xybfo5clXVdhgUu6t8cRKZmZz4mfpoKG1QYlrlxTUptqlF6wHg64eZ4D
 FjAkCj2zniBEkbed1x802DDXjxm5DfRqff2Ko6cIfJcuKbHDT5up13+tXX4IDS/x4Tdk
 ljVarDLayp87kBV7PTXTJS5kIbmjBSfT8mssYaKDiOfXKsQvVp3+lwDIB1EzC+g8Fiyx
 ftgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681260; x=1751286060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udXllEXY1gPSi8pgPr+YWAsY2WGcZfddjVlJVNiCuOE=;
 b=Aa1IF5ohJJkn35X1r1W9RIoQjDUVrJxnayqibD+zYgD4YQMH6co89X/J4Q8zBxm296
 MOTw/G/PhqjO1/o52v431H6XfbBh29m6MYVqaSwJUM46tekqWwBq8+P4okkaMxwWw9lH
 TFr+Z/Nvk5NJcf9pyp+02XohFAVptFsY4Mt6ChX2z86SoJ2gu8CyoxsBXjqilxC6gLIX
 is4SP9fL22GABGU3DQk+HccPmJt5l2vRZHqxkP9l3+JLJvJ9lqnGlFmosIvxJddxHg+I
 OF8+1YZeN0JBd8BXUJ/2md+qZkG1aEHHG2gE6fO/xE/LVYE0qlrcvQE6ib2Y39wFedyI
 8GAw==
X-Gm-Message-State: AOJu0YwZFputHv5xnR4zBxnWTqoqgxqRZputHOcpd7ybcF3WmJM9T1EF
 zyS08YgXsXSxOwd4unZHShm1rkQtnVUCdPmENbpZPm/ihi8DTTJ8tVhgOUo63TA6Kt7bc3LJJW8
 NgJd2
X-Gm-Gg: ASbGncvr1nITaBupmn701OEvxVHnuXG3a2o3PVebmxO9jJU2i6MM69JfwHrFQGdtxZk
 rcHowBfC8uBUQ9teWvz4Owwdk3dxV5INFfyBMKjVBR9zKMdWBZGP7bw68IU3UJv/h1nEQ1dt9od
 thNm/6VUEgBNsj2RH5Z9bbhRuyqCcjeCg4W7R39dJmmb36s/XX7xSNtBqe/RwjtSTV5vFj8toGE
 t4V3sWBo6o59ZUywLv6LH9HJBCZdXrJKHGFBRCuKLz9tT9FluqvdUl5kza3DwUZqlqLVruLcXkW
 lEcUsYoHYPPoPzu9ZAjZiHGJ9uLQZA7wiYVvnETUHi+QO36VT7fNS7aghZmEY44IBrFJN8sOgPu
 JIVvm6rS3M/RDj5SUsSiAdNWAtrefbcLJxW+j
X-Google-Smtp-Source: AGHT+IGSZgVi8a4ONdtjF7+uNRguyN8Xn3B71Lmx7xCfC5fcG/JmZoeL4oP6TQwKjqTxGU0oRlOa5A==
X-Received: by 2002:a05:6000:2d11:b0:3a4:e1e1:7779 with SMTP id
 ffacd0b85a97d-3a6d130707cmr5965156f8f.32.1750681260192; 
 Mon, 23 Jun 2025 05:21:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0ec947fsm9340220f8f.0.2025.06.23.05.20.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 26/26] tests/functional: Expand Aarch64 SMMU tests to run
 on HVF accelerator
Date: Mon, 23 Jun 2025 14:18:45 +0200
Message-ID: <20250623121845.7214-27-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_aarch64_smmu.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/test_aarch64_smmu.py
index c65d0f28178..e0f4a922176 100755
--- a/tests/functional/test_aarch64_smmu.py
+++ b/tests/functional/test_aarch64_smmu.py
@@ -17,7 +17,7 @@
 
 from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
 from qemu_test import BUILD_DIR
-from qemu.utils import kvm_available
+from qemu.utils import kvm_available, hvf_available
 
 
 class SMMU(LinuxKernelTest):
@@ -45,11 +45,17 @@ def set_up_boot(self, path):
         self.vm.add_args('-device', 'virtio-net,netdev=n1' + self.IOMMU_ADDON)
 
     def common_vm_setup(self, kernel, initrd, disk):
-        self.require_accelerator("kvm")
+        if hvf_available(self.qemu_bin):
+            accel = "hvf"
+        elif kvm_available(self.qemu_bin):
+            accel = "kvm"
+        else:
+            self.skipTest("Neither HVF nor KVM accelerator is available")
+        self.require_accelerator(accel)
         self.require_netdev('user')
         self.set_machine("virt")
         self.vm.add_args('-m', '1G')
-        self.vm.add_args("-accel", "kvm")
+        self.vm.add_args("-accel", accel)
         self.vm.add_args("-cpu", "host")
         self.vm.add_args("-machine", "iommu=smmuv3")
         self.vm.add_args("-d", "guest_errors")
-- 
2.49.0


