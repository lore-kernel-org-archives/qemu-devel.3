Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44256CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJRn-0005OO-DL; Mon, 12 Oct 2026 13:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRZ-0005Gd-P6
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:11 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRV-0007At-DY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:08 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1203578f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791824641; x=1792429441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ch2ZoIADYgnoxJF6H4RUbty/jOOihKcMHABghoAwLPQ=;
 b=ap42NfLMyMeAK9p1L/1RpWJJCUYIB6K5izVHR/z2CdMAdCQe/3OPpSswj5r4JccreL
 Hz+hTuluZAee7m2yI59W3rQg7tfZq+VPNqkTEgrW3I9n53cqKXsj0mQdp7PuanP8QfgJ
 04ydecHDNRfIVTrlaAytqtMEzs0MCzVibN5eYRGqJbLy3Yc3NK/Dyj4G8BHkCIj2C2zJ
 I729346sWwG6K3M+gESF8HqyCac2iRUOons5DUujUxGRr8xIzhbW0K6ArNd3k72FVZBs
 mQks72zlEmxfCkMmdIZVg8UuelYvtCrll2tMILiCK8ejx4MdZkKWzONV3Us53S30s5Yt
 Hf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824641; x=1792429441;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ch2ZoIADYgnoxJF6H4RUbty/jOOihKcMHABghoAwLPQ=;
 b=iwhj5b6VybPgkEwO8vZiQbjA2KD+mMC6A9cGwufhmsXm9nAysTfXdsMom+q1+UVeb7
 rQkts7hy8CuaymieWP6rXFxA4e3gZoLXHjl/b0ylZTHsjG92WvGa7TYBmzi+B2li7Arh
 iwr3l7t9Ag5l5pRMdg+/aqgIx/d5lmiJ20Pt8wHTHffqxKGjIfGLWnFfRnMv0uQzZ190
 79ESq3i5WMB8NSZ4RaPSPY0mqDp1sXsnLkrtY0ll1RxyWsyb+LLMdCjPWMjqioQwz4+D
 Tp3lw/xw3dn2H/8WvfJf4+Hd+KhvY3BetAp2DvK/EfiRMWl9gX6+vPQfbBqNMCvBK1hp
 Cwlw==
X-Gm-Message-State: AFq9FYIjXxRqjs8/wsu4AShQk7hDhs1KzI5Cf7YPT8stXdlIM9WDb80O
 qSNGyR3FPVXYihJjC22HEFS+DhdLf5VBoCRD9vH3tnZsosSTKS2Mvn3ci665ax8Z9ZY=
X-Gm-Gg: AYBFou1Iaz04BZNhPdJZzj2qDjwlCn0oVjfv9NDy3Zu1365IVRuvTVwq5J3p78dgG7H
 LGP00xkl0s1Ka9/AdkRj3Jm88nk0SbVR9gkiPNosv2nNnlGzFDAmtcl9xMLeVCQ+BGNY8FslevN
 4ZPjEjndpIsM4r9g/X6ujwPshHDluw6Nz0LrU39Vy+tfeLQ4fiRM4h6KxInb31a98p4yvsH/bp8
 45RqNLMk7jH50mzB2hpzYgec6phiDx9HC+ZQgrE7B7OMj87ZD4z/Z7Bxobzy/Fazfr8Dl/EBgRo
 RsmyMfXTvmO961RFp5a4BS75WoE0dr+Th3Q1rXu3gvMDMy11xep0mIwPT2qv8dUrZOq15pbVZfw
 nrhzBkgR4cTY0adwAqG3udvsuhW9bf+zpkPFSXjsqvcow6qsRZLO+PelYYvUFrFhmNuUqNfNIVh
 jPycxUNdW6Q60B4YOdOHFVcSqgMVMnw9D2jT6WboVE4ODj/GPSLnWhY+VHxUOK+PfU9koL3ZQPw
 d0SdVTL
X-Received: by 2002:a05:600c:310b:b0:4a1:7659:9b94 with SMTP id
 5b1f17b1804b1-4a18e4a9774mr226157305e9.13.1791824641316; 
 Mon, 12 Oct 2026 10:04:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bbbdd75sm232040515e9.1.2026.10.12.10.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:03:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5337561703;
 Mon, 12 Oct 2026 18:03:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 13/16] tests/functional: add tuxrun kvm gdb test for arm64
Date: Mon, 12 Oct 2026 18:03:27 +0100
Message-ID: <20261012170330.1144446-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012170330.1144446-1-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

As with x86_64 we now have the bits to add a KVM gdb test

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/aarch64/test_tuxrun.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
index 6de02e1d8b2..2ff321582d3 100755
--- a/tests/functional/aarch64/test_tuxrun.py
+++ b/tests/functional/aarch64/test_tuxrun.py
@@ -11,7 +11,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from qemu_test import Asset, skipIfMissingEnv
 from qemu_test.tuxruntest import TuxRunBaselineTest
 
 class TuxRunAarch64Test(TuxRunBaselineTest):
@@ -19,6 +19,9 @@ class TuxRunAarch64Test(TuxRunBaselineTest):
     ASSET_ARM64_KERNEL = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/arm64/Image.gz',
         '39f4633bbcb444267d4d829bd28d8868a287c4c160cda64b0fd23fb090571c4e')
+    ASSET_ARM64_VMLINUX = Asset(
+        'https://storage.tuxboot.com/kernels/6.18.54/arm64/vmlinux.xz',
+        '6487eb113ef6e841aedab6cb6fa704006377d68f64dd544570aa42f462a52b85')
     ASSET_ARM64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/arm64/rootfs.ext4.zst',
         '4ab8cec9d1e17dbb1abdf2ae1939ad4f9d0dc2466230f6a119a7c1845cdef0b1')
@@ -42,6 +45,18 @@ def test_arm64_kvm(self):
                            rootfs_asset=self.ASSET_ARM64_ROOTFS,
                            accel="kvm")
 
+    @skipIfMissingEnv("QEMU_TEST_GDB")
+    def test_arm64_kvm_gdb(self):
+        self.set_machine('virt')
+        self.require_accelerator('kvm')
+        self.cpu='host'
+        self.console='ttyAMA0'
+        self.wait_for_shutdown=False
+        self.common_tuxrun_gdb(kernel_asset=self.ASSET_ARM64_KERNEL,
+                               vmlinux_asset=self.ASSET_ARM64_VMLINUX,
+                               rootfs_asset=self.ASSET_ARM64_ROOTFS,
+                               accel="kvm")
+
     ASSET_ARM64BE_KERNEL = Asset(
         'https://storage.tuxboot.com/buildroot/20241119/arm64be/Image',
         'fd6af4f16689d17a2c24fe0053cc212edcdf77abdcaf301800b8d38fa9f6e109')
-- 
2.47.3


