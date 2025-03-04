Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8ACC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpahO-0005aP-N6; Tue, 04 Mar 2025 17:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah0-0005O5-L8
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:50 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagy-0006Ui-1G
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:49 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e4bed34bccso8662200a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127086; x=1741731886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAUG1VLjHRc42q2vET8iAizrXLG97QnhMiOAEe3585Y=;
 b=OjOI5fMerQKo76eKSRNyrI/xT3v7jvdtUJT3zI/DTMgp01ZHQX+HcMWLYLmLZWgtt9
 Jy/X7VO8t90pnBPnAbHxw5MN9eYTrCxns4Lddn+Ft2QNoN+ufU6nYuBJy3rdff9HVmmJ
 pXE4Ik4BRNjEeguu6v/iabX3lA9SL+V6iqyPpw4xgXd86i00Q6puC16LiCgpqMtMtim3
 4Ijp0OOcYxNxCUkEZyQngIafUDJBCayn3j1g+HIBNLAnUEu/1pxglzm2HaolXhbT/gLP
 zmGZQ2TikKVXzPM9zYFORA/a8LUMrH4hTvHuzZzNXUnCnnkwbnzhxGwcLTVPo4efKYqg
 1jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127086; x=1741731886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TAUG1VLjHRc42q2vET8iAizrXLG97QnhMiOAEe3585Y=;
 b=G7xnTSeO29+6w2pfFz/yMA3RtGOP7P2dc7XrtcYCSrDiSHju8Z2+GuF2Doo2hliPNm
 TdehdHiYDejiPReC1lzkLQMCGa8Ff9jGOCpZw7V/VqYNO6PVJr95+w/5vXU48xsg09lk
 /pKis/TOb2s20SdSqeqJMHzgl4NUmwzbCQr/0XXUDLrydDlhkusZBJqvg+t6cPGAXAKT
 tnHerxslSUhMg75pkjado8cjKAGJ+xMhCFYnWUZYZiiB3zzjGjFSU6XKQhsLmz7g+7Pz
 x8ItOu4CsD8asnnhpynb5VXNElsBwxCSuxmI5ZFPQqyQZEmZd8CTeyB2iBEZcl+dPhh1
 pr1Q==
X-Gm-Message-State: AOJu0YxWfdAJ39JUN5srszG9zPclF56bCnQtcWeX4kVEG/rNWQ59vM5E
 G2nWumQYOwlOjPZRNWjPqaPYRwK1Qm6KuXs08J4c9LP9Hb2wWXTUMrf9h6JGhF4=
X-Gm-Gg: ASbGncvz+V9SMNj536Ko4W/adCLrO1/50AEAVcbyPajjri8incNW5ixkCkx2RHJVi8F
 GJgqlCioc1t2CELJbRFPXqQZZHlp6A5fh6VtUscdrfA8oI10i24nIrWp+h1sTt0eyUtdrPg0jK/
 4FXzcnAaOI4Fd2EhRlqgaEWAD5I3i7MRNhwBhXsvUQL/ps0tgGwr4tC7jNm4ScJqATeiKV5532U
 mZWmeZU0dB+h76qAmRKZ3PnjalKhm+lnhZxi9UIKrTAnOkZJysb0De3O5dJ1+jJUcWa3LJ9njq/
 7KHNfSoUyr/ZDYuBDHgQqp34je0bvi6mJE/ysRpc0mhZDbk=
X-Google-Smtp-Source: AGHT+IE+0nDw/amky+R2fftOjcXsLsMMARO45PGlgqIFvJNAUxxj4jGTs/n4AXe4mvF1ud6R8mk/CQ==
X-Received: by 2002:a17:907:7d93:b0:abf:6cc9:7ef5 with SMTP id
 a640c23a62f3a-ac20db05bc9mr102150066b.47.1741127085711; 
 Tue, 04 Mar 2025 14:24:45 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf5453f468sm663503566b.51.2025.03.04.14.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ECB705FCF6;
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
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 06/32] tests/functional: expand tests to cover virgl
Date: Tue,  4 Mar 2025 22:24:13 +0000
Message-Id: <20250304222439.2035603-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Add two more test modes using glmark2-wayland to exercise the OpenGL
pass-through modes with virgl. Virgl can run with or without the
hostmem blob support. To avoid repeating ourselves too much we make
the initial pass a simple --validate pass.

We might want to eventually add more directed tests and individual
features later on but the glmark/vkmark tests are a good general
smoke test for accelerated 3D.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250226140343.3907080-5-alex.bennee@linaro.org>

---
v2
  - re-base with re-factor and don't run whole suite of glmark on both
  virgl builds
---
 tests/functional/test_aarch64_virt_gpu.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 55957dae0a..3fdb31f034 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -92,6 +92,28 @@ def _run_virt_weston_test(self, cmd, fail = None):
         full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {cmd}"
         ec_and_wait(self, full_cmd, OK_CMD, fail)
 
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_virgl_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
+        self._launch_virt_gpu("virtio-gpu-gl-pci")
+
+        # subset of the glmark tests
+        tests = " ".join([f"-b {test}" for test in
+                          ["build", "texture", "shading",
+                           "bump", "desktop", "buffer"]])
+
+        self._run_virt_weston_test("glmark2-wayland --validate " + tests)
+
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_virgl_blobs_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
+        self._launch_virt_gpu("virtio-gpu-gl-pci,hostmem=4G,blob=on")
+        self._run_virt_weston_test("glmark2-wayland -b:duration=1.0")
+
     @skipIfMissingCommands('zstd')
     def test_aarch64_virt_with_vulkan_gpu(self):
 
-- 
2.39.5


