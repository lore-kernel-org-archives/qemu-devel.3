Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EB8C83F34
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Jul 2025 04:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucyj1-000482-5z; Fri, 18 Jul 2025 23:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucyit-0003zk-J1
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 23:58:57 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucyio-00071d-QZ
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 23:58:54 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3139027b825so2203538a91.0
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 20:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752897529; x=1753502329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9sy/GkKxEpvogxAbQ/BlWtpttvEFz3MkYKybtI+dz8=;
 b=hKWCakLnPjS58o4dUckOMieEzDE2kEtfRmm4J/bRxn9hIG11/QYObeEQgP6ZSfVXzE
 dB+4DuSoo6JqIEJg5p8vFWBqyrB0shi6D3+RR+wmebvIShi6HQSkaTR46aPpLpTVJlcW
 U8P75Z76mppRZg2fwvb4MjBbRYcm9tGGvUn65yUz3rJCYz2B2GvT1C0kVcF14P7WznIM
 UZLvuxndn4M1UkqKu7P02LMQ8m9zuPdT+JX2nFfc0Z4n/z7dbFCCZtMJjaACztEqwTub
 V+lepnuvIwQphveI/H2T6wSI/5H+H/rxm3pMwNCfa9NGmvrVjtLz7LgVX66dpjLZq7u+
 4J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752897529; x=1753502329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9sy/GkKxEpvogxAbQ/BlWtpttvEFz3MkYKybtI+dz8=;
 b=qzhWzf3XpF2XWzt4M2+P4Uj9SxBWrfpG2UAzq6hCCqPAFH5ktI7d3Ali+ZjLEF2hV+
 FmmSL1zSqIxjypOXiKT3icQg+oLgCKykxJg4n3LkcxkuyNZa7SspDUSR8j1FiGxnqTLN
 Ta4nbiuAc2MILwmAS5NrvP20wJaY/laZ414+UCVuUmsikHVf0GmnM/lFubY8/Szk9Zxy
 d81/IueBkRzHdlSwxUuc/dYI0O2jVJgJDx2HdIQs+pjZN38xF//eXtDwq4N1hpJYx5Wd
 Ti2vBDFzXpd0CPsG2bTENVtakO8usxRgPYkPtN1cCNingY8ATAQACDKgHvSm8hx4FM7z
 EFyw==
X-Gm-Message-State: AOJu0YwHMq1382acLjDVEPx3GO8Hi+UFBg5upGOUloMVpW5MudPEHXyb
 CBkoxEpLvoP9d020NcluH5tjyWUsvnZxy0Vwp38c81KHGftHsKC4Gd8cUExYrrxevSWNCBs8pO6
 remCmZWg=
X-Gm-Gg: ASbGncsZ62sGblqzme4qzlgvo7PfiIzWOccYSbrUrgLIjvvGtYU9eaxaawwTF3gZKUu
 8mR4U8TaK+3cocyMzXKJZz8TNGAMq2nqcUxOTOemfwaUeKGX9kkx8b/gJdnIiz13yQzJl/ovK3c
 JUDz0CMCmzJJQ2Cgib2bsvWkeK3MUdX1d3UQqT1jcJfMlr7ktXHWceQsv+LdbhLL63kriZEkmK4
 U07RLKhWS8QT4w/qM1gMdQQ0kiPeb/YTt5e5XNznY7x9Ei9+d/SFuUDeW735LhqfkjBl4WBCUEl
 19Do6uS05cCCbzeW2RPMnElaEFOFmNE2T+1O61d43ZyybevXoqN4I70HLAdcl2Aw5iJQZ+IGPMg
 qpaAQruGGh4wHCji6JRU/uX2XRuGoOqsL
X-Google-Smtp-Source: AGHT+IGiXq8suzeZY2Gbl4zSLPsU4W8ayUC9ZDlyL7V+8Em5vBVJq2C2jL8BMVdcm5qXkHeq6XVxOw==
X-Received: by 2002:a17:90b:514d:b0:311:b413:f5e1 with SMTP id
 98e67ed59e1d1-31c9f45b1admr16462512a91.32.1752897528951; 
 Fri, 18 Jul 2025 20:58:48 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f2ff88cf8sm1961819a12.49.2025.07.18.20.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 20:58:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, richard.henderson@linaro.org,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, gustavo.romero@linaro.org,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/2] tests/functional/test_aarch64_device_passthrough:
 update image
Date: Fri, 18 Jul 2025 20:58:37 -0700
Message-ID: <20250719035838.2284029-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250719035838.2284029-1-pierrick.bouvier@linaro.org>
References: <20250719035838.2284029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

TF-A needs to be patched to enable support for FEAT_TCR2 and
FEAT_SCTLR2. This new image contains updated firmware.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 .../test_aarch64_device_passthrough.py        | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tests/functional/test_aarch64_device_passthrough.py b/tests/functional/test_aarch64_device_passthrough.py
index 1f3f158a9ff..17437784bbe 100755
--- a/tests/functional/test_aarch64_device_passthrough.py
+++ b/tests/functional/test_aarch64_device_passthrough.py
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
2.47.2


