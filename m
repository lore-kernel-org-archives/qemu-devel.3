Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D5FC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDu1-0004W9-AL; Fri, 11 Jul 2025 09:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDts-0004Qw-Ix
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtq-000348-56
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45555e3317aso4183795e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240888; x=1752845688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z/tqj/ko8WEeVpxtCck+nDGeWxY6ZT+VKsk2/PDMd8Q=;
 b=gMJl0g4Qa7wFlp20dwQzq6+oE37XbmPyuhMQJWBQ4T7T4o1KPg/guh8my4iSAEj4x3
 3c1U9Tw2n/p2FBGu/VYsw3gHuGhR5WfNdyF8ougwriyOpLOKeRZwbJhIrm9BuR/qgh3L
 oADPqnH92aeL3v+hcmcFa219bmGbggu/7FiFtPUGbbVjl2H2W+qP5GvM9vb3fPbHh5xR
 ud+gosHISKxq5i/26TmlI1HSr8Veu+ojlBEL30FZgyVGwAgyyKW6aHNEJSlMQ0hHc0Ri
 tPWfIXR6qSYPzdTScrN0amYG6amppWcwcDM4JynhAqAh0hVT0ryO8XrxhNBIynEEwmVH
 pkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240888; x=1752845688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/tqj/ko8WEeVpxtCck+nDGeWxY6ZT+VKsk2/PDMd8Q=;
 b=ZK2qNzGcaFNNr28cdT+xiOOwdis1qoizje2Wb36i0E/tyqYSU0ASRTgIaQhzbrWj7+
 2kPgjdcFmpHNdnkrV461+I2mFIZz9/+axeykBhSdu/7wA4vyvhzXOoLktOwrASNryJwq
 /HdouDQbPBwu5MZ8HkUSmWz47gRsvHKHEKkKjDWZN3u0D+AlvbXXe33tAng+tKztIeWt
 2bR7vgeF3xO75fiYT4vrBoHHdlA+/j033BN7MqCP2JpMCZ1UhjUwylUbeUS1Nk4wcmUj
 YQz9MdJzo71+WJN+n2Tvi8eP4WZSNp1QtWXGXKMIzTfv1IVOMINpr662tiUjMAUT2C1Q
 xHEg==
X-Gm-Message-State: AOJu0Ywp4X+OVyz2qeyk+TTJaud04ssJNkvIGPxB2rLmf3jr6qMvzyrs
 3OiP9Xjq8Hz4gGuMZ534YWuIrQFA7om3i5tdVS/XmpzU01HsvwZf7nKrk3q16qI7kNFx5T3lnj4
 huwuW
X-Gm-Gg: ASbGncsiGQZQsCU4Fnd6v+5HGjVin2R0pJEmK5q6qSvLVHrnDGP6gzn1ikSmxwv493r
 2i+sk/IJeITEOltqHHKoiuFDdNFnKP7qc7SNrOBjb6QrIIBZvVHtB9yKP+7yNuOztJX3AEPye3B
 fWs0JYqiLGCvF5BAUcxMCuEhzggr53dwPJYDjbJBWLEhfl5KCqyRVDfLVXq71MN5U2AhaIKbm2m
 MI1aHD3DYe7ljASjOpI4W8qYo9B7g1ruF5KeKt/TUseObg6deWEq7N3G52DjKpvlKpaS98Xp+Oy
 av+4kQwzz2KjBEYkYlCgZH5DIRAMEwQbYqk5fjZPtyZkC2Ea52RF4JOfqubXMwIU3BKFHayyRoe
 NATjyZbQGTnmWBVijpOYkASss7iGW
X-Google-Smtp-Source: AGHT+IH1VaYSUQnz3XrsTenMXkbJsXMHztbZz2iPD5JrG4OHiJBcycGhoVBo5LoYYWNg0aIop/4Wow==
X-Received: by 2002:a05:600c:c11c:b0:453:66f:b96e with SMTP id
 5b1f17b1804b1-454ec146a71mr22329455e9.11.1752240888576; 
 Fri, 11 Jul 2025 06:34:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/36] qtest/cxl: Add aarch64 virt test for CXL
Date: Fri, 11 Jul 2025 14:34:09 +0100
Message-ID: <20250711133429.1423030-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add a single complex case for aarch64 virt machine.

Given existing much more comprehensive tests for x86 cover the common
functionality, a single test should be enough to verify that the aarch64
part continues to work.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Message-id: 20250703104110.992379-6-Jonathan.Cameron@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/cxl-test.c  | 58 ++++++++++++++++++++++++++++++++---------
 tests/qtest/meson.build |  1 +
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index a6003318439..8fb7e58d4f1 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -19,6 +19,12 @@
     "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
     "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
 
+#define QEMU_VIRT_2PXB_CMD \
+    "-machine virt,cxl=on -cpu max " \
+    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
+    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
+
 #define QEMU_RP \
     "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
 
@@ -197,25 +203,51 @@ static void cxl_2pxb_4rp_4t3d(void)
     qtest_end();
     rmdir(tmpfs);
 }
+
+static void cxl_virt_2pxb_4rp_4t3d(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    g_autofree const char *tmpfs = NULL;
+
+    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
+
+    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP QEMU_4T3D,
+                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
+                    tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+    rmdir(tmpfs);
+}
 #endif /* CONFIG_POSIX */
 
 int main(int argc, char **argv)
 {
-    g_test_init(&argc, &argv, NULL);
+    const char *arch = qtest_get_arch();
 
-    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
-    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
-    qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
-    qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
-    qtest_add_func("/pci/cxl/rp", cxl_root_port);
-    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
+    g_test_init(&argc, &argv, NULL);
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
+        qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
+        qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
+        qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
+        qtest_add_func("/pci/cxl/rp", cxl_root_port);
+        qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
 #ifdef CONFIG_POSIX
-    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
-    qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
-    qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
-    qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
-    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
-    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp_4t3d);
+        qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
+        qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
+        qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
+        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
+        qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
+        qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
+                       cxl_2pxb_4rp_4t3d);
 #endif
+    } else if (strcmp(arch, "aarch64") == 0) {
+#ifdef CONFIG_POSIX
+        qtest_add_func("/pci/cxl/virt/pxb_x2_root_port_x4_type3_x4",
+                       cxl_virt_2pxb_4rp_4t3d);
+#endif
+    }
+
     return g_test_run();
 }
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 91b4a71a186..5ad969f6165 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -262,6 +262,7 @@ qtests_aarch64 = \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
+  qtests_cxl +                                                                                  \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
-- 
2.43.0


