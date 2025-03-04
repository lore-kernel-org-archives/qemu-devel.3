Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5202AC282D3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaiP-0006nj-QM; Tue, 04 Mar 2025 17:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah3-0005Q7-Tq
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:07 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah1-0006X5-Ij
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:53 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-abf518748cbso663495466b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127090; x=1741731890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/Y4yehusRukFayx+a1eFqwCyDGI+iEwXMcbyZW6EPw=;
 b=FdorH+aX7GYFGAvnrpiJFFdMmUljgRlmL25MdzCgQghUy6/oxOCCCrCkzuA1S67uU6
 7e8uaWa31QLIkGGY5+VGuHT5A87kdn2+UwvvZN3xxEKcQIjTMPunFWclMcc0V0S5Bn71
 DpNec8gjTLFrZR1ptDMbjfescdZXYkhvRdUr/EPES6saNVVaYhC1JgP3LIS5B/MZvBx/
 6nk5lsXvcVJ79o/UtHFrW7/8JSo+19NMeSwN73DBf5mocqPhqO5vAYgGO7PsGG8+EfdL
 47UYDLMOC7XfFWjKnMt8TbJFgOkkaENF+Rw2pEYJKF5x6SEQ1vRNHgHbwUR381mbr1Mg
 Qkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127090; x=1741731890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/Y4yehusRukFayx+a1eFqwCyDGI+iEwXMcbyZW6EPw=;
 b=Pz8gjemIpmBFsKKVfELWI+DM8oF6FwveB46p3eo0zm74TSSW43eOjtKPskfKc9w9LS
 ylEjUHl+dsnEcKXTdlVO0yhZoFS64UmqSYf44XTjch0ibQUVrj/vaWwZOuVrVj9JZBAX
 oMPNrHgf46fd8z4Q2UnLQdQa1KJCvaHVuB2YhTFQu161IPyyZahI8FFTbCUv2rxXeCKh
 F7pn4KdNpzcD1CMAiI27zM1hwrc1sOSAx1zQliNRpPt1XxI7SVWrNpk/L6Qqa9a8l1nZ
 AB5/MhQ8kds2abbyQWQ8c4KoaBUicuxim51v58P9nKO2i2XD/dqCpoZMqmL79mGfqh11
 mk1A==
X-Gm-Message-State: AOJu0Yy1j5jyj84K2QipQHqm6HdKEV3EUtXZMP2iDoxX34tHfIMFcpbf
 AUCpMtSXaliKi7XumnheOa3VnQTn53UO+cDkQfPWmgKrYZT4NMrYXDn/zARPvOI=
X-Gm-Gg: ASbGncttSvzXBAQw25NRmM+Xx742Gbs8tNNyYOV1/7XPd3/8WLvKyIfiWRM+a/zqfCR
 vxaiLTFpFFEc2wweO3MmpUZKYQTKdY5nyeicC5Bdnos8goHs6O9wZtzI9UoQhsjt/kEFzSDGEPl
 k1+HHrbALAz9chDNexZIYHJxICOFuL0HgGu54N0bt+AOSd8SWU08UUg0GuQveg2F+pQBbiukO6l
 ZUddlzU5ozANGS6iY62SvlQWXBRUK6M95mcpy7lV74ilZGeveWJ68P73Wtaov4U+ZBY2Oer/tWh
 7J5lLZS10n/JEL5k0u9VaDuJlsiESrKuJgW/BWLLH6WpNNw=
X-Google-Smtp-Source: AGHT+IFJH+oXjZER0OdQDGOTUu5QcqUX4PtQepP1REbDTCTZvjiLLs/P1T9XoEMsQXjsSASgB0n4og==
X-Received: by 2002:a17:907:940d:b0:ac1:e7a2:f5e8 with SMTP id
 a640c23a62f3a-ac20da87bb6mr97751266b.35.1741127090017; 
 Tue, 04 Mar 2025 14:24:50 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac1e46949aasm275752566b.145.2025.03.04.14.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D40AF5FCD8;
 Tue,  4 Mar 2025 22:24:39 +0000 (GMT)
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
 Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v2 05/32] tests/functional: skip vulkan tests with nVidia
Date: Tue,  4 Mar 2025 22:24:12 +0000
Message-Id: <20250304222439.2035603-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

While running the new GPU tests it was noted that the proprietary
nVidia driver barfed when run under the sanitiser:

  2025-02-20 11:13:08,226: [11:13:07.782] Output 'headless' attempts
  EOTF mode SDR and colorimetry mode default.
  2025-02-20 11:13:08,227: [11:13:07.784] Output 'headless' using color
  profile: stock sRGB color profile

  and that's the last thing it outputs.

  The sanitizer reports that when the framework sends the SIGTERM
  because of the timeout we get a write to a NULL pointer (but
  interesting not this time in an atexit callback):

  UndefinedBehaviorSanitizer:DEADLYSIGNAL
  ==471863==ERROR: UndefinedBehaviorSanitizer: SEGV on unknown address
  0x000000000000 (pc 0x7a18ceaafe80 bp 0x000000000000 sp 0x7ffe8e3ff6d0
  T471863)
  ==471863==The signal is caused by a WRITE memory access.
  ==471863==Hint: address points to the zero page.
      #0 0x7a18ceaafe80
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16afe80)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #1 0x7a18ce9e72c0
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15e72c0)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #2 0x7a18ce9f11bb
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15f11bb)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #3 0x7a18ce6dc9d1
  (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x12dc9d1)
  (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
      #4 0x7a18e7d15326 in vrend_renderer_create_fence
  /usr/src/virglrenderer-1.0.0-1ubuntu2/obj-x86_64-linux-gnu/../src/vrend_renderer.c:10883:26
      #5 0x55bfb6621871 in virtio_gpu_virgl_process_cmd

The #dri-devel channel confirmed:

  <digetx> stsquad: nv driver is known to not work with venus, don't use
      it for testing

So lets skip running the test to avoid known failures.

Message-Id: <20250226140343.3907080-9-alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>

---
v2
  - implement block at the test level
---
 tests/functional/test_aarch64_virt_gpu.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 7d7749e243..55957dae0a 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -17,6 +17,9 @@
 
 from qemu_test.linuxkernel import LinuxKernelTest
 
+from re import search
+from subprocess import check_output
+
 class Aarch64VirtGPUMachine(LinuxKernelTest):
 
     ASSET_VIRT_GPU_KERNEL = Asset(
@@ -94,6 +97,11 @@ def test_aarch64_virt_with_vulkan_gpu(self):
 
         self.require_device('virtio-gpu-gl-pci')
 
+        vk_info = check_output(["vulkaninfo", "--summary"], encoding="utf-8")
+
+        if search(r"driverID\s+=\s+DRIVER_ID_NVIDIA_PROPRIETARY", vk_info):
+            self.skipTest("Test skipped on NVIDIA proprietary driver")
+
         self._launch_virt_gpu("virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
         self._run_virt_weston_test("vkmark -b:duration=1.0",
                                    "debug: stuck in fence wait with iter at")
-- 
2.39.5


