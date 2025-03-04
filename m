Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1090BC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpahN-0005Tz-S1; Tue, 04 Mar 2025 17:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagx-0005LK-5c
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:48 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagu-0006TV-He
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:46 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac202264f9cso144153866b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127083; x=1741731883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnSHjGtDRpaEDbyYC8kppAAfhPC7ZbGjHbQwEVFXiqQ=;
 b=FjzdPsQVs0FEx5CrD6hhu4BB5yiRKHblofXS3IK6gweEDFF6SG2XacuHtfKoEhqMgc
 iiTpk6sajjb+uWCa/B6DIXCW3CXaqUBk8FUnkhR54KjtstcZ1/9EReP4mPPZWTBIKoyG
 r7FtLY+ijKi43ZDEtAUQymkTJbZzocBoEBIrY3nsh7v5TjGFc6AP9HziVmaS5xFCttv8
 B9OvKXJwkHkox/O7yepQfEOiM4ruzSXmiVDq35ITZJmxDbl8ox97Eo3AIuQLReArrG4x
 YSZTF3uh1qX4Cjylrw67/J69jSK5sLgsWnrpCxlsVn8l+uBUu0ah3Q9uUQzW+ueA9WaY
 vUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127083; x=1741731883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnSHjGtDRpaEDbyYC8kppAAfhPC7ZbGjHbQwEVFXiqQ=;
 b=JQtyG7piXePn0WPgYogNDINqybNvjFOkPASmAAO+QvXYjXouo02vDrVWWq+kWbolnE
 ZO91CmvviINst8YlljPAgnankw6YurhCh/+/9zt1GrSRU31PURcu8/YMqprkrwD3Qyd6
 lLNe6SovJz7ezrf/GxbQoTNFKYDy9ri+VfmB/NAlxG5S8WDH+fhl2zYKNPUZLLbx2LmJ
 sbMl7VYG/1XXFY7cknk38XnwPIYauIVwJFa3bvQnrRSyINnhv0EF88DK6865YZJCaqd7
 VFbTFacos0ZbJUqfiNxy4hi11Ru6o05pVTJ7J8hyqWwIjYhDrV8Qx2gD0uoous86+ddO
 VTWg==
X-Gm-Message-State: AOJu0YypN2PRJlptNwD7koSd47LHy3j1ieONpRstN8APmFD2Pis32yq4
 mks+YuzC0QsQHYRzTYjS2RKHm61YhqFCqnYdRzDwfBHwDYPL1Gls/dGSNOf9udg=
X-Gm-Gg: ASbGncuAcw9qBuV/8rZorPjERS/AQhqSG+6W8d1gxRtd7k/0k8pxwvEWQKwcw6Z62kQ
 KpgyOhB5QyQfikZPj/HP6pctfeUPE2x9xF4cpXs3bt8TPkrJ5FhVClEyDwEW5NvhDbGjPvD2XzX
 cvtO65wRiguLM1kVwtC7Id1vcwFbc6smlh+kisAdWJIF8N9XUdDI5CIVJGF9wN4J9cvoSl8e/dp
 6t3EG8z1gL8NLY4Wd6OP6/jH+f0ogo5ya+A3b0u91CJ774TOKVe1pve3hXg5j1P5bKNeY6jPb8F
 0IG6WUMZ/fI1HZTqUjFD5sxAhF7x8H8r7tVxBcMG874is84=
X-Google-Smtp-Source: AGHT+IH+ZShXvgauKpsbJcXwNAXI3McoiVdTBaDlrpYFgc/AJjvqME6T4opPDW4J2nYEVNMf62fdZw==
X-Received: by 2002:a17:907:7247:b0:ac1:de14:6d6d with SMTP id
 a640c23a62f3a-ac20db37f95mr73021066b.28.1741127082771; 
 Tue, 04 Mar 2025 14:24:42 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf4f8a2035sm692348266b.107.2025.03.04.14.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0DE725FD05;
 Tue,  4 Mar 2025 22:24:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 07/32] tests/functional: update the aarch64_virg_gpu images
Date: Tue,  4 Mar 2025 22:24:14 +0000
Message-Id: <20250304222439.2035603-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Update to the most recent aarch64_virt_gpu image. The principle
differences are:

  - target a v8.0 baseline CPU
  - latest vkmark (2025.1)
  - actually uses the rootfs (previously was initrd)
  - rootfs includes more testing tools for interactive use

See README.md in https://fileserver.linaro.org/s/ce5jXBFinPxtEdx for
details about the image creation and the buildroot config.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt_gpu.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 3fdb31f034..e417ca9beb 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -25,14 +25,14 @@ class Aarch64VirtGPUMachine(LinuxKernelTest):
     ASSET_VIRT_GPU_KERNEL = Asset(
         'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
         'download?path=%2F&files='
-        'Image',
-        '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462f6')
+        'Image.6.12.16.aarch64',
+        '7888c51c55d37e86bbbdeb5acea9f08c34e6b0f03c1f5b2463285f6a6f6eec8b')
 
     ASSET_VIRT_GPU_ROOTFS = Asset(
         'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
         'download?path=%2F&files='
-        'rootfs.ext4.zstd',
-        '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
+        'rootfs.aarch64.ext2.zstd',
+        'd45118c899420b7e673f1539a37a35480134b3e36e3a59e2cb69b1781cbb14ef')
 
     def _launch_virt_gpu(self, gpu_device):
 
@@ -47,7 +47,7 @@ def _launch_virt_gpu(self, gpu_device):
                                'console=ttyAMA0 root=/dev/vda')
 
         self.vm.add_args("-accel", "tcg")
-        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=on")
+        self.vm.add_args("-cpu", "cortex-a72")
         self.vm.add_args("-machine", "virt,gic-version=max",
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
-- 
2.39.5


