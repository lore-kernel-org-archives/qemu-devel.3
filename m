Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16654CDD578
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwj-0006A8-Po; Thu, 19 Sep 2024 09:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwX-0005XQ-Rv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:36 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwU-00015h-Qt
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:33 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f75e5f3debso7786381fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751488; x=1727356288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4mM7auy/FOUtYcyKkKCo8MHtp21fztts72NvbXMteRw=;
 b=y0fB4jMYwAblAIHercYElA6N8oChrUZiqVUbOi9bWEUcXiDieZhIwyMFEKqTt5VA89
 r177cLE30PJxPJDHBeTQLyN/VWMLJa3nZUdTmjIW76lzAWnM3t9z6HAnCFj3MSeP8JQQ
 dLGyxX6V7umRTq70we6Vx/pFhNz+QsRIGPdVMGs1izTQnUhCXHVM96OPStpwkN/3ztAm
 bnJvUhy7yBpPzTdw92GZmDxM9eU9+qq0dLCppexhKEfpxRuK6R46iTqVUssaAn6s4LQD
 kbK8Jq24M0tSKkP0vmZC7k/R4jcXaUiTwCmMHqI2g04xRYgJSP6VxNgnsr32CYGh1MYx
 H/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751488; x=1727356288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4mM7auy/FOUtYcyKkKCo8MHtp21fztts72NvbXMteRw=;
 b=AxXycTyeVmk70XVhAiefnh/hZdkeV4cZI08ay0vy+vfkJ31GQ0YCuUDhaYAQKqt7kK
 eZW/mA4Wx0dh6TMoFuwMhCXUdl38Wp97MiCTYemX5958UxcSAf52ORhmVK4T5Suv7LK6
 5WGCOhyvrTjjwYD8g2DFDunQ100K/tjRzv244aecNU7ZPFEjkEYxPpbQZ2V0NSbPA/2P
 kf+pXWiRJ31KiZosulDO+zCyybhF4VSZUKa2LIyYJXdIa+Zwtj6XLypHh9tPlPk5gkSW
 0U4L5AvQMQslnr7BRaDy+Lx5bi79AQdSpErI9JSAz+fBXYMbDK+LcMT1IXqEChgfPZwT
 ETiQ==
X-Gm-Message-State: AOJu0YyIRbuHtXAZ0kn9Ogc7ityRYZ1323C20k8CtdqdJ1lkPhAiSRdj
 Y3PETgCBLBxU6JNhyTYHRYKaTd7J9zLpzDUiOxTxlb1y47iz7fpmOmHvqmDLlhuwdQQf5RPiCaP
 W
X-Google-Smtp-Source: AGHT+IEdQvOO+eyhhmWjd08K49z3UADY4tLot4c6bE6h5c6h5qH/ZThRlkbjE7WIr/fONao/q553yA==
X-Received: by 2002:a05:651c:2118:b0:2f7:528f:421e with SMTP id
 38308e7fff4ca-2f79183a94emr112200111fa.0.1726751487939; 
 Thu, 19 Sep 2024 06:11:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/38] tests: drop OpenBSD tests for aarch64/sbsa-ref
Date: Thu, 19 Sep 2024 14:11:02 +0100
Message-Id: <20240919131106.3362543-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

OpenBSD 7.3 we use is EoL. Both 7.4 and 7.5 releases do not work on
anything above Neoverse-N1 due to PAC emulation:

https://marc.info/?l=openbsd-arm&m=171050428327850&w=2

OpenBSD 7.6 is not yet released.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20240910-b4-move-to-freebsd-v5-4-0fb66d803c93@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/test_aarch64_sbsaref.py | 44 ------------------------
 1 file changed, 44 deletions(-)

diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 1648e8ceb68..b50e1a59657 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -143,50 +143,6 @@ def test_sbsaref_alpine_linux_max(self):
         self.boot_alpine_linux("max")
 
 
-    ASSET_OPENBSD_ISO = Asset(
-        ('https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img'),
-        '7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5')
-
-    # This tests the whole boot chain from EFI to Userspace
-    # We only boot a whole OS for the current top level CPU and GIC
-    # Other test profiles should use more minimal boots
-    def boot_openbsd73(self, cpu=None):
-        self.fetch_firmware()
-
-        img_path = self.ASSET_OPENBSD_ISO.fetch()
-
-        self.vm.set_console()
-        self.vm.add_args(
-            "-drive", f"file={img_path},format=raw,snapshot=on",
-        )
-        if cpu:
-            self.vm.add_args("-cpu", cpu)
-
-        self.vm.launch()
-        wait_for_console_pattern(self,
-                                 "Welcome to the OpenBSD/arm64"
-                                 " 7.3 installation program.")
-
-    def test_sbsaref_openbsd73_cortex_a57(self):
-        self.boot_openbsd73("cortex-a57")
-
-    def test_sbsaref_openbsd73_default_cpu(self):
-        self.boot_openbsd73()
-
-    def test_sbsaref_openbsd73_max_pauth_off(self):
-        self.boot_openbsd73("max,pauth=off")
-
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
-                'Test might timeout due to PAuth emulation')
-    def test_sbsaref_openbsd73_max_pauth_impdef(self):
-        self.boot_openbsd73("max,pauth-impdef=on")
-
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
-                'Test might timeout due to PAuth emulation')
-    def test_sbsaref_openbsd73_max(self):
-        self.boot_openbsd73("max")
-
-
     ASSET_FREEBSD_ISO = Asset(
         ('https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/'
          '14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso'),
-- 
2.34.1


