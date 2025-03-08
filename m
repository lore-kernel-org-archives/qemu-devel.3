Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC62FC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr26z-0003G5-TL; Sat, 08 Mar 2025 16:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26x-0003EF-2L
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:35 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26u-0000ua-JN
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:34 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-390fdaf2897so2946761f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470811; x=1742075611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPeKq9Y1elDW4TopisjmaJUNcVaePa54zZmUT5VyNw4=;
 b=M7AQDsSdtHAfVgta3N+PMa2EIrKnTmeN65XzoqzbqgAlLHK4S1TUal+FI6CuMi0doL
 5VfR84EIkviEk2v+xBeNdkS2n5n59M2zK4hIZEz8fl75KfbPvurdgIE1LFAmnpDClwzE
 9lRaTWUlmLvByCEdENafjkCo22j7S/njf9MXkD7NRG9+LLZvv3JV6Xox8saGJLdz5pda
 xn2OuLmMjofccoBzP7mMlsLzsx1vs0G64dwqPwGR3jarjraql9Gdc2aQjE3b2JzQ8yo3
 U5U7ocbykTLLjBXvrsnaTTJDJOBcgvs3dtY3JfIl9OpMsBv0gcAv+7+/xVGbkB38YMaX
 Ytww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470811; x=1742075611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPeKq9Y1elDW4TopisjmaJUNcVaePa54zZmUT5VyNw4=;
 b=YCystZDfavWwdNOkGWs5kbgVUlVVk2axyM75qILN2VCDMxpe2bwfR9wYqhLcON/4UZ
 gs/98S8VoOTh7dOdUG87NBbhdFdxwu9ZRlJvdEumdMfOMRcMc3maOzRcKrYtTrMwLz56
 WxZwbGtooPgRWUhU7kT6p9Ch2h//ErZdxkUXtFUdJLaD0TTVf2vAHsOZXH7rNiyMKwzr
 fTH1CR8Rt4X87zZfQx/2nx+zXfguh7CoiIRX0rNuVAebRLUNQBfS5iqrF+OgOaiy4fMf
 mefW8SOsMWbDRdN3UpQkDQ2i2rGNxif3mKWrIAX+b0V1OnAYMCL6Fw3tK1fjRPuQzvXm
 6pIg==
X-Gm-Message-State: AOJu0YwS+ReJSp99pSXU/MyFBYQq/Ag4qM2uNSYpzcgvITEeX8b0Hifo
 C+NpxxRiZ05F3uqXwwuyUv1tR1IZUc8B05ThciHbbxWLuv/xAmYWzKc+A3U64Kg=
X-Gm-Gg: ASbGncsNFPe+bWwprkK0tmDtSNfnfPVXvLDEjb3rnzIhX+MsqfY1HNcVhUJ3UNUobt/
 uPdRFNjSqo5fGQTHzYMUk4TjIeqYSzkn3WkKuNNVyzhpShOvrbEL/w//Gwd7VMyN6A5tM2npk5g
 NvGzAAlyctjJSd8kI9d7CyCZEjWlkoeMLga8bj4XsuSCyoaGammYyuYH37dY87OVbE9NH6E/GQV
 lhtZ04JJTe2f+3FiFOY1x77m4izgHJgmLLBHNV+pvrUw/IeFLQ5AVffR76vzLPw7Wl67Uj0Bt0l
 ee2/ZkRr+ygSI2c/zDJWxq4dZC9NWaAkagAx4riV3CWLUBg=
X-Google-Smtp-Source: AGHT+IEeSBEGPqofpX90PlhcsZJyG2XZz2S05cDg3P7rrBO3yIHDbYKoiOksU42JaFeTxAnc+lLhrA==
X-Received: by 2002:a5d:6c63:0:b0:390:f0f3:138a with SMTP id
 ffacd0b85a97d-39132d5b4bfmr7387198f8f.27.1741470811166; 
 Sat, 08 Mar 2025 13:53:31 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf04ae69dsm6711725e9.0.2025.03.08.13.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2F164602CF;
 Sat,  8 Mar 2025 21:53:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 07/31] tests/functional: update the aarch64_virg_gpu images
Date: Sat,  8 Mar 2025 21:53:02 +0000
Message-Id: <20250308215326.2907828-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Update to the most recent aarch64_virt_gpu image. The principle
differences are:

  - target a v8.0 baseline CPU
  - latest vkmark (2025.1)
  - actually uses the rootfs (previously was initrd)
  - rootfs includes more testing tools for interactive use

See README.md in https://fileserver.linaro.org/s/ce5jXBFinPxtEdx for
details about the image creation and the buildroot config.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-8-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 4a21d8c6cd..c6f7738e93 100755
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


