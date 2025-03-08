Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93263C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr270-0003GP-93; Sat, 08 Mar 2025 16:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26w-0003Di-1w
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:34 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26t-0000u9-6s
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:33 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso409003f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470810; x=1742075610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpopK86QINh7V5h6ymzYJTc948St9iL142EhrxVQFuE=;
 b=Fe4gFkl5xhJf6QE6/0HwsDTgpHbWod7y2tguMNchoPCTmO34uv6yBvuDSLbiuc0USP
 cBBxMUS4JAhSXqQXXz9k8MQTHYVKthZDCXFOgS7gHTXuk9kHORrtG5pY5TBsceBkdZyT
 DxPg/v1L3/HWQxsuRSfqNtleEwIn4YhULGDHYOTy6x4DxSolByhGFGFcyDGzbLpVh29Y
 0ICkL9eGsqucJZafLa8K1cAkSQ6x/u4tBJKhwmZG/WADgkNqzejCq5dLAc4p1Nw7WuVu
 YEuD8aKEm0kz3dvLOYq3dRiOtjOfR3pCH0fpgg4YRVKGQesMc59ktErID6cafQfdGvdB
 Wh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470810; x=1742075610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GpopK86QINh7V5h6ymzYJTc948St9iL142EhrxVQFuE=;
 b=d5fWGsDuJOmk29kvTHzkMk5UwPUVxRNQuMRX8+gCtxTGzLrJk56SLOyGt4H1xUhIlI
 Iw2iQ/6xz3rxBPw+SoIMrXQdgE5g14fHq+WzdqqLHIWMpe8Ovs97PbV/Qg0vBtJ6Qwav
 S/KdNOFvZCh2/ToWE/R9UqkB1gpVLM7MMdoxZ43PVBqJ0or5Pn4ajsuUOjNiAu+3EDEt
 mgKFNJ7KEFr7xZu0vpiv/CA0OhBB3cbzBRQXmaMvI8qZJHQE3xf4BPl+Umb7clocPnfp
 6SSpYZIzxE46mv5gKI4kTIDVdNa8B90SFujQ0cSvPqPuy6ifo0bNdX2hxhlhdFZSdp8L
 pvPw==
X-Gm-Message-State: AOJu0YyiKOLXX1eMU7WFg+CbNd4++af4gUCHYMxGfHXiDmezkSLbyZdr
 2F6mSymCuLNqz7WKcAnsAH0gYX5UQo+s9+/deaZNF/BS+NXC550Qn9Vv4wr3AIY=
X-Gm-Gg: ASbGncs+IbpOSYokieegUh/uWuD0k3F2ddIWvrxfnGmcfRxGfjY/QbS8SB18fN0PVNR
 y4ib1xa4BFkuS7LYtgLDUsCgoNveR2qhEsBg2Sb5eUNUfKz/b6OzcMnBLCLxKmj2l5XDOaJevbZ
 ykAI+A1l4JRKKDHVGQYBv9HrmBRiIxBDSs8f3sjXvYDDRWQtolVDGk0LDUHqqRUqug3Co7XggMt
 2Xl6sGb+nolY+GszibNBX4KNT1tcVOWxTBx9CPhtmKqEIJ63DJHxSIejlHT1QUR1JBYFfv+KiMv
 pQqmDArFgBVf/hZLEVImy4/WkbHto3b4AP4oRfFzkdWsvUs=
X-Google-Smtp-Source: AGHT+IFG3L+dyCEHi+bfCxf01T0I5x8mCkhNtDG76sNTN6hK/OyCCFaXLzB9e0HauEgr/UG+LX0X9g==
X-Received: by 2002:a5d:47c1:0:b0:390:fe8b:f442 with SMTP id
 ffacd0b85a97d-39132dc35b2mr5398521f8f.54.1741470809696; 
 Sat, 08 Mar 2025 13:53:29 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cee22c13fsm17319125e9.40.2025.03.08.13.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E366A5FAA0;
 Sat,  8 Mar 2025 21:53:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/31] tests/functional: bail early if vkmark hangs
Date: Sat,  8 Mar 2025 21:52:59 +0000
Message-Id: <20250308215326.2907828-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

The message:

  MESA-VIRTIO: debug: stuck in fence wait with iter at %d

Seems to occur more often on debug builds. Rather than waiting for our
long timeout to hit we might as well bail as soon as we see the
message.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-5-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 9a1ee2befc..eea1e8c973 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -78,7 +78,7 @@ def _launch_virt_gpu(self, gpu_device):
         self.wait_for_console_pattern('buildroot login:')
         ec_and_wait(self, 'root', '#')
 
-    def _run_virt_weston_test(self, cmd):
+    def _run_virt_weston_test(self, cmd, fail = None):
 
         # make it easier to detect successful return to shell
         PS1 = 'RES=[$?] # '
@@ -87,7 +87,7 @@ def _run_virt_weston_test(self, cmd):
         ec_and_wait(self, 'export XDG_RUNTIME_DIR=/tmp', '#')
         ec_and_wait(self, f"export PS1='{PS1}'", OK_CMD)
         full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {cmd}"
-        ec_and_wait(self, full_cmd, OK_CMD)
+        ec_and_wait(self, full_cmd, OK_CMD, fail)
 
     @skipIfMissingCommands('zstd')
     def test_aarch64_virt_with_vulkan_gpu(self):
@@ -95,7 +95,9 @@ def test_aarch64_virt_with_vulkan_gpu(self):
         self.require_device('virtio-gpu-gl-pci')
 
         self._launch_virt_gpu("virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
-        self._run_virt_weston_test("vkmark -b:duration=1.0")
+        self._run_virt_weston_test("vkmark -b:duration=1.0",
+                                   "debug: stuck in fence wait with iter at")
+
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.39.5


