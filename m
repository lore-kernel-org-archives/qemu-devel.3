Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFE8C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSs-0005tG-Cq; Tue, 01 Jul 2025 13:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSp-0005rW-AN
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSk-0003lL-Ce
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so3099656f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389683; x=1751994483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h1wFfqXrQ7liHsZUjU0tPUQrAZmnsGYgeDtVNq+Ns4Q=;
 b=NWKXZGT4Mf0JELVhdPpul82h90g7vQTYDuufUwWet/eoRURg2DD7SMQFcdwksisZfe
 7RWCN0cQFL6sLhiqjhwAcVq5HVhH6i33ZCSRAedV6x7DIBY3F3OaqdsrwmAZkLe6IXue
 LuXDQI7qIiqfQHx+FY5iE0RRIBAC9KbUDqqQNy4wAp3C3LQZzXwp63xV7zhyoAuakCuT
 5LOzcjYiQoAzpnTGDrEHYPWAQw3tlwhqGrHZ4aYs+988cWHkBJWi3C7hjYJzT+1/mAF6
 vl1dtnLh5pm6/b96wT1ZnQiwjd/1guGcxkaCRLrbrJg98DEOmHUGl6fbeQ60LI8GB0Xk
 jKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389683; x=1751994483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1wFfqXrQ7liHsZUjU0tPUQrAZmnsGYgeDtVNq+Ns4Q=;
 b=sdSslWqyaW/JSzJaFbV47NRuQ227iLx07zcJiLaIQBZv/t2TAsmxof7zrH0Cp4r1//
 B/+STiTyJxXewxSqmMsFu8iOm74uY6EEK+wgrzWDzhXk7CeHQE6os8MqN42ujTO6bs1U
 vC6aos/zvLHEVEp34U5iISAi9tpE+dcaILETp9jhOwgIA7+annrWG86excJxlOzvQaes
 ExpmKy7vc+7ocVAqk0bctVfkq0ISzMFvoKIpbWYZenhuZMIHIZNAlFAoZG0x6/eoLOjP
 boFlQt3SKS0BgQfGqUr1GJRlt1RCCXJWIXvK9+N5mTY/sQ0/O8tAU5vcNNFDLlok/glu
 a25A==
X-Gm-Message-State: AOJu0YzxgMfjEaVHsrEFesleZGrJrDcbjH5nzj4slyBRNRm8GOWC/FSy
 BXyC5zudpiKLaImZ5oytt0MeHb7OtZ2tK9P0MRRqwwU9lCGFjapQbVBMalwBKbkUB33xvHNykHC
 gtQgy
X-Gm-Gg: ASbGncvN623egHb+zNP45bsUxt5xp804dSFBS8cD7oiY53G5z6szxdNt1HHSOJ0DTtW
 VzwGA2jObF6pAo079EBFbq4yUS0XocuhrT4pKuA2Htc78xs3PMwLfGITq6mo/gjKe/590B+TUJh
 2PvcMR9woqMdxlMKxw8+bE52a91DB0+TWM0rTgwoZEUv/Flmv10XWNfexb5XFnREKAGfLuD5vZk
 nA+OTRIFGWfjWFD+aeaHHaHgqpJuE4YihbNKDfpDR8PlqhMYAO0NDCdxKufE+8Q8UqEyRoFNxTn
 APgxqqzrlw9wmL+Oovw2hyv92P04g1LHNPSycSZZzXA1K73VeVEEO7xzzyK2WofS7xVW
X-Google-Smtp-Source: AGHT+IHPol/cDjIqMKhBWRCX++6if7wnpRmhjVWWcitWMLALet2QaBjW3IIQuMuWzvLHvR17/kXNPA==
X-Received: by 2002:a05:6000:2407:b0:3a5:783f:528a with SMTP id
 ffacd0b85a97d-3a8ff051153mr18179494f8f.59.1751389683206; 
 Tue, 01 Jul 2025 10:08:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.08.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:08:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/43] tests/functional: Expand Aarch64 SMMU tests to run on
 HVF accelerator
Date: Tue,  1 Jul 2025 18:07:18 +0100
Message-ID: <20250701170720.4072660-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250623121845.7214-27-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


