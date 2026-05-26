Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D868FCD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmr-0001KY-JJ; Tue, 26 May 2026 10:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmp-0001D2-Ei
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmn-0001Tx-H7
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so6657641f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805776; x=1780410576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=elv6ee8yIKN9DCAa5de0OYQvRTlKie2FGVuOoUFOxt0=;
 b=CWTvtlFitXWdud/TLEeEtIFQBiNeNKjuVBTJhRH6GfmziRkZmEx1frDXhIrLnSjzaC
 xAixjGPmzfmWinAhCUhQuz6RksPpwPrb6e8qVK0kLYFPWGZuRIl8OVeaGEWYx/TcS8hS
 Z0tIRfsLyBwtcp4ucgHtSEFRks8VsNMPTjxEW75M2nAQIxBg7R9xb+MTb3Bp3jnOr3tt
 clru8AYisHQFLXOKuBPd1P+w6WH4df4he7JUGaVniwrK0Pg2zoY96B6L7I4jAaJEDxyo
 1NWmkxlDKsfoz5CRSzufZUd7NKXb4/NaFh6kPI9MxB0PiCPIBjc/HopTmysta4eHS7R4
 O+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805776; x=1780410576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=elv6ee8yIKN9DCAa5de0OYQvRTlKie2FGVuOoUFOxt0=;
 b=I3t4kA7C7m7EGKtjs1vsOazx77icQ5/rOhBmT5nMiFjm9dJ3eI2G+dmxSMyu1naz9y
 RLmfYEU32pA2Ulw3y0ICuaFxA7ubQjHtu8zpC7ubVdWliciRfa6uhL6ZOtqNdXOyf7gZ
 qNawgfaJJBBBR/QokR2uIfqTPyd1GQcApXzVy3jM9m0e+y1xGFNPgbCbPSo+zRu1BXjs
 EtcdbwG7TCy2pgZrm6QsmxDsL6mQe0W8to8mAizaNpKx6uqk4Qv4SPj2PFkZnHO2PJQ4
 GNU5WlDXMvFsHJf6IdMM/DU+x08ehKTpDJIebccQF2vC7Fxm74PJYXUuYbJPPt7kJ8ua
 II3A==
X-Gm-Message-State: AOJu0YwZMrzs+6XofXAdQYncTwfmnzgl2DUQV1zHAqWw/0NVWry6H/kR
 G5Waz1MHyQTf/MivMophFMSr+VWTwz/sJAhVabftYIP5dsC3Crj1lEWZbCUor1KN+asdPZIw3ST
 bYiTC
X-Gm-Gg: Acq92OEt6/9Q0gl6BOhQ0CMtQQHss4bZ7zc/iZpsG0fc1SPjTWNC1z1az6iRlYSQtkz
 e6j68bvQEkQs0Mpb60Vf3uVNLYrwmhTBsPvqNdapLmnyf5RGtwfuYutyo1SCKJvFULum55DH9mw
 3AM4Uoc9NGOI6QxoB4Z8O1TOBXYVlfNAsMMteoW/Lv71FpvAFeUpDGuxA+V+p3mS6fiNOUFZeQw
 O/YK+m7fvXjmqWODDH0UmLWJq0Fq81msTn0gB7F2QFIjOkoEC5LILrC6Dd028ZKGbnMGCLXyZue
 AXoEPPimxV3H6VFS8l+F6Dxy3g6pwUieEv5bMRxTXTXTSfZ3igYilF8fy08AJ9kgAN7Qftg7vth
 IJjPEDFNlCffESM6iOWlr9W9HqvHBP+ums3pOwPgZqxWLy/qHTeKrHmW/gKmdW9PMJrPZqnJOAI
 2MTbYPphlcuGAu024IMAlTb6ehk0tKsyXQ0yq4TqoDbChF5wy5yjoT8Sd2FDdm9cSMQpMTEQ9wS
 3wuod61/pQ5hkGjZ8QNLzBz9Fcrs0k=
X-Received: by 2002:a05:6000:480e:b0:45e:739b:3e3c with SMTP id
 ffacd0b85a97d-45eb36418d3mr28903257f8f.0.1779805776172; 
 Tue, 26 May 2026 07:29:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/54] tests/functional/aarch64/rme: update images to support
 FEAT_FP8
Date: Tue, 26 May 2026 15:28:41 +0100
Message-ID: <20260526142850.2326589-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

As well, use -smp 1 since there is no visible speedup running with -smp 2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_rme_sbsaref.py | 7 ++++---
 tests/functional/aarch64/test_rme_virt.py    | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/functional/aarch64/test_rme_sbsaref.py b/tests/functional/aarch64/test_rme_sbsaref.py
index efea80c578..d252101ac6 100755
--- a/tests/functional/aarch64/test_rme_sbsaref.py
+++ b/tests/functional/aarch64/test_rme_sbsaref.py
@@ -20,12 +20,13 @@ class Aarch64RMESbsaRefMachine(QemuSystemTest):
 
     # Stack is inspired from:
     # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
+    # Built from:
     # https://github.com/p-b-o/qemu-linux-stack/tree/rme_sbsa_release
     # ./build.sh && ./archive_artifacts.sh out.tar.xz
     ASSET_RME_STACK_SBSA = Asset(
         ('https://github.com/p-b-o/qemu-linux-stack/'
-         'releases/download/build/rme_sbsa_release-6a2dfc5.tar.xz'),
-         '5adba482aa069912292a8da746c6b21268224d9d81c97fe7c0bed690579ebdcb')
+         'releases/download/build/rme_sbsa_release-74b7fab.tar.xz'),
+         '82a754bacea04e709cb1cf2759d1d12d09fabd612e014961eb32368723c7920a')
 
     # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
     # and launching a nested VM using it.
@@ -57,7 +58,7 @@ def test_aarch64_rme_sbsaref(self):
                           ' --params "root=/dev/vda rw init=/init"')
 
         self.vm.add_args('-cpu', 'max,x-rme=on')
-        self.vm.add_args('-smp', '2')
+        self.vm.add_args('-smp', '1')
         self.vm.add_args('-m', '2G')
         self.vm.add_args('-M', 'sbsa-ref')
         self.vm.add_args('-drive', f'file={pflash0},format=raw,if=pflash')
diff --git a/tests/functional/aarch64/test_rme_virt.py b/tests/functional/aarch64/test_rme_virt.py
index dcb18678bf..2afcdc6b07 100755
--- a/tests/functional/aarch64/test_rme_virt.py
+++ b/tests/functional/aarch64/test_rme_virt.py
@@ -19,12 +19,13 @@ class Aarch64RMEVirtMachine(QemuSystemTest):
 
     # Stack is inspired from:
     # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
+    # Built from:
     # https://github.com/p-b-o/qemu-linux-stack/tree/rme_release
     # ./build.sh && ./archive_artifacts.sh out.tar.xz
     ASSET_RME_STACK_VIRT = Asset(
         ('https://github.com/p-b-o/qemu-linux-stack/'
-         'releases/download/build/rme_release-56bc99e.tar.xz'),
-         '0e3dc6b8a4b828dbae09c951a40dcb710eded084b32432b50c69cf4173ffa4be')
+         'releases/download/build/rme_release-2701e89.tar.xz'),
+         '8c40af440f5bd1518f7add7d0a43b39289865ee48430979db8024cb897a74790')
 
     # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
     # and launching a nested VM using it.
@@ -44,7 +45,7 @@ def test_aarch64_rme_virt(self):
         rootfs = join(rme_stack, 'out', 'host.ext4')
 
         self.vm.add_args('-cpu', 'max,x-rme=on')
-        self.vm.add_args('-smp', '2')
+        self.vm.add_args('-smp', '1')
         self.vm.add_args('-m', '2G')
         self.vm.add_args('-M', 'virt,acpi=off,'
                          'virtualization=on,'
-- 
2.43.0


