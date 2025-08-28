Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A722C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uratz-0003F0-B1; Thu, 28 Aug 2025 07:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratr-0003Cz-MP
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:39 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratp-0005c9-EH
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:39 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3c854b644c1so580118f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380875; x=1756985675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g+Lwtf9Dc+UeK2oirT2wByiuRWQQHV3LBajiD+TT9Lo=;
 b=vuhfuTZQq83XwNSJuBG9+09UzP86FIPFCeuRumrYK7bEIXhDq+qinJQk2s9bkytuB7
 LNmeN7z11VhnD8Fo8UadpESWZxJPktWSFwIIjtLGUBOeZeUnwebz0x3WI0QGXZJRlekX
 jo3KV7UxPu9Wb2de02gxoHg3aY0sMJW3VEZAlTAM5qrH6nJq2gObFRlUYr2kWuhdkKu/
 Zf8DVdf7hNxcs91U2WOe5ODFBGqSPSuhcuOLq7EFEc3Z3+f4TCzbLbnA4pwMyT9nTJEG
 NhXvJs6t63wlLv1rN6e+3sNuzG1uAqSTOCD6Cb1pKc0NWMoVRD76ETgXFZRyXV56PbuR
 O6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380875; x=1756985675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+Lwtf9Dc+UeK2oirT2wByiuRWQQHV3LBajiD+TT9Lo=;
 b=S3heykD0woJl6UEOfVGIbFiX4GHJS1k7C68gFSxXT/YQhM66Qxl72gZuCiT4HS3ygm
 7RWBPTpJd5Yz8hCoO+1K8RbNxHlxI7mhD/1FE8SqMRi8UbIivMziHJt7AW7yStgfMPJF
 2MX7JYD8kAlR6Y2Dhy02tYg0d2ZPdl3NB8CYJizpPVU99fkK9zgc4hifgPzAaMNIdqRZ
 kx2ss0ikpOHdkqDs3rX2qxd47DuhlE+nnxnlV5LHOYRGpojHNrb0Y+3EV8CaH0g5Ca2X
 LGnAKzCoJdk22d+QfCG34MhjxUGl9EyukhNY3pIaFl1zRcLnxBo08fEb4YKcO3ZcEc++
 zHbw==
X-Gm-Message-State: AOJu0YzY25+ut8TkTDb2vsU6c8nLe+NlH99l/iimJOYMxItVfYSlCC6U
 akiyE6aq9I25CxJaLH3h0bIXstJOI7rUzGUjMRxbXv0gkgujD+nqHqu8XIzQiBQ+si3kNaup8ma
 QC/7b
X-Gm-Gg: ASbGncu00lT58DDow7QyORnKIF5mFVYmy064NH7qkkx/4VgOvFcRnG4INlqWlK2+M4L
 KmFkzgh87R1yFvS7J7C47HPHRZE8uUokx3F0FLb8If8T7E5vj9zdbLdmigLykLfnLNYixeCqKmY
 +mfUVsfUTsbHcgDAvh0qdb71Hv8spYd3gl05Y5Es3FO3bugFcCgppy/8IrL/piCb62JIlJOK6NU
 DuJBJbj2tZArJIK0LIOU8n+IVTCtDOsToEiTdlbxavpU1smdb3nRr20Y5uOBCPxxnYpXu/zCAHz
 Hngy8SKjWsqL7rq1DRAQqlrE6aAuZpfbc6d6HHEq5XEpTRWCPec3JRI8DFco49/iHRxaAdlcy+5
 b+9oB2t/2shU1XXK4N9i8wdUSfNAtDAiQUPvT7W8=
X-Google-Smtp-Source: AGHT+IEm8Nwu7YjSNPM2yT7tmqkI82DwZY7HTuf7JD/zCCDMhHFj5jI3OGHE5Rjw2pDvhd5ICWuamg==
X-Received: by 2002:a05:6000:647:b0:3cc:a43e:722e with SMTP id
 ffacd0b85a97d-3cca43e747cmr3304121f8f.24.1756380874983; 
 Thu, 28 Aug 2025 04:34:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/32] tests/functional/test_aarch64_device_passthrough: update
 image
Date: Thu, 28 Aug 2025 12:33:59 +0100
Message-ID: <20250828113430.3214314-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

TF-A needs to be patched to enable support for FEAT_TCR2 and
FEAT_SCTLR2. This new image contains updated firmware.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250727074202.83141-2-richard.henderson@linaro.org
Message-ID: <20250719035838.2284029-2-pierrick.bouvier@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .../aarch64/test_device_passthrough.py        | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tests/functional/aarch64/test_device_passthrough.py b/tests/functional/aarch64/test_device_passthrough.py
index 1f3f158a9ff..17437784bbe 100755
--- a/tests/functional/aarch64/test_device_passthrough.py
+++ b/tests/functional/aarch64/test_device_passthrough.py
@@ -9,7 +9,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
+from os.path import join
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command, wait_for_console_pattern
@@ -77,15 +77,16 @@
 
 class Aarch64DevicePassthrough(QemuSystemTest):
 
-    # https://github.com/pbo-linaro/qemu-linux-stack
+    # https://github.com/pbo-linaro/qemu-linux-stack/tree/device_passthrough
+    # $ ./build.sh && ./archive_artifacts.sh out.tar.xz
     #
     # Linux kernel is compiled with defconfig +
     # IOMMUFD + VFIO_DEVICE_CDEV + ARM_SMMU_V3_IOMMUFD
     # https://docs.kernel.org/driver-api/vfio.html#vfio-device-cde
     ASSET_DEVICE_PASSTHROUGH_STACK = Asset(
-        ('https://fileserver.linaro.org/s/fx5DXxBYme8dw2G/'
-         'download/device_passthrough.tar.xz'),
-         '812750b664d61c2986f2b149939ae28cafbd60d53e9c7e4b16e97143845e196d')
+        ('https://github.com/pbo-linaro/qemu-linux-stack/'
+         'releases/download/build/device_passthrough-c3fb84a.tar.xz'),
+         '15ac2b02bed0c0ea8e3e007de0bcfdaf6fd51c1ba98213f841dc7d01d6f72f04')
 
     # This tests the device passthrough implementation, by booting a VM
     # supporting it with two nvme disks attached, and launching a nested VM
@@ -96,16 +97,16 @@ def test_aarch64_device_passthrough(self):
 
         self.vm.set_console()
 
-        stack_path_tar_gz = self.ASSET_DEVICE_PASSTHROUGH_STACK.fetch()
-        self.archive_extract(stack_path_tar_gz, format="tar")
+        stack_path_tar = self.ASSET_DEVICE_PASSTHROUGH_STACK.fetch()
+        self.archive_extract(stack_path_tar, format="tar")
 
         stack = self.scratch_file('out')
-        kernel = os.path.join(stack, 'Image.gz')
-        rootfs_host = os.path.join(stack, 'host.ext4')
-        disk_vfio = os.path.join(stack, 'disk_vfio')
-        disk_iommufd = os.path.join(stack, 'disk_iommufd')
-        guest_cmd = os.path.join(stack, 'guest.sh')
-        nested_guest_cmd = os.path.join(stack, 'nested_guest.sh')
+        kernel = join(stack, 'Image.gz')
+        rootfs_host = join(stack, 'host.ext4')
+        disk_vfio = join(stack, 'disk_vfio')
+        disk_iommufd = join(stack, 'disk_iommufd')
+        guest_cmd = join(stack, 'guest.sh')
+        nested_guest_cmd = join(stack, 'nested_guest.sh')
         # we generate two random disks
         with open(disk_vfio, "wb") as d: d.write(randbytes(512))
         with open(disk_iommufd, "wb") as d: d.write(randbytes(1024))
-- 
2.43.0


