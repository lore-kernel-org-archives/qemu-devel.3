Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7256CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cxc-000836-GJ; Tue, 14 Oct 2025 07:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxU-0007wJ-Ok
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:48 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxS-00083M-Bc
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:48 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b463f986f80so184462066b.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760440364; x=1761045164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kxqMBghotsNAW3z2sKbNmh6PO8mUrbQ9ykLagwcUbrI=;
 b=vS9f/PMIKu7b/hHM6yztiOxk5YBy3SQGmparUaMPKf8DOJIPF/iqOoXELTgg1rzE2C
 1kFZ6zqx3I/iSwIdGxVS3Q2/bLb6ZP/63dXJ+zrUAor0oNnKPOPyjkJYCAGlEJzBXRhR
 TDPRGqv0Us4xLSUbfOe/+wstk7+5gwvpIo+FjYmB+sQmEflOH4leifJdzknSdU2UFRQk
 c/stZLWdF30t3MZRO0XqNWZTqTTQjMvu6VKFnhiX6wr24O0sMPwbOzBG1euRtwt6tvgm
 jFxxDWX0uO+Ip1RSjrbKKoW+zz7qvy2iPjazQ1IOQmfleK5lYzcQQf24SrINwcldr7MV
 JdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760440364; x=1761045164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kxqMBghotsNAW3z2sKbNmh6PO8mUrbQ9ykLagwcUbrI=;
 b=Qhp+1QIm3kxuJ2GvFa7kTD47oZBMxVEqk5gPBFlaPgsucwdo8zwoBMqjpOV7I7/qCA
 F3gWZCu/FhMG/ZOI6TXZnLNZB4Nk5CnvqiddVrAR0Kj0wPLj5qKFuGSyufn6uciQW5bl
 /VAROHeezxoAzGXdn6ZcCd8r0531RzpNx0me9Rc29HkZEu9zYgA3x/2m8S4Rh87qCi6n
 2aiob5O1r91IPqFY64uBWtgX5IINm3wKgcURVtc5GQbkAZ+VJaPr+o9SLdFdvK2tv+t4
 GESuL8QZbyK628ehYm1UtRCXLZnY7ZwEFgW7mesroFN/oWmJJgep9WRnA/UXu7KCNGlU
 NcEg==
X-Gm-Message-State: AOJu0YwWeW/IWKbtShivw0QYCW7RU1pDEevUHrEeM+O4S0+/vpwtYwhD
 nVT+nPHnI1VhDAyw7FTj1lhE2vLwNoo0y7Yy7HHYd969ldPAQAQPsGBsU6BL1TiRZH0=
X-Gm-Gg: ASbGnctA25pOVKP5IhfhBsCknm4KiOI7CH3iQUHgxa1dkR7dqOf+2VjA4xWu5XsiREz
 jXoEE6mU/yANK92uEoVsoYvxKliiv1MBquAkZEqRH91Cd9zHxLZ7fZNf9dKoBODpC54HoqrNM8v
 LdRdnerOtb6SdYi0/xjgzrVbDZfBdiSFpI9udyv80prixwJXzb8e/PgHmxzbUiL6bGH5SnFkEYi
 s1w6pPFBcvKYk/XNzXU0ImajrzDYy8MbqOF3KFq6jEqbnoOg2iUJtfmXuFsK3CuWbMJZvO2Lof+
 PbVvqg4MfSEBDWFNxHBfBTX2+3abbzzhcLND2UkpTlZFuFwtbWW233/VBqGnnsN6BuDVWUf95TT
 NyfYPx8cN4pLwW3T6IgnllOtNrMNgQAcsJFRWwhgUcKyKMQ==
X-Google-Smtp-Source: AGHT+IHHJHMPJYJ5v7xglCte7DfQ1AWOsH39mv1264aNNKNlWkjYNPKN6crIFVmHw8oD8baC9uYpTQ==
X-Received: by 2002:a17:907:94d0:b0:b04:7232:3e97 with SMTP id
 a640c23a62f3a-b50aa3921edmr2633393566b.21.1760440363678; 
 Tue, 14 Oct 2025 04:12:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d5cac037sm1102213566b.12.2025.10.14.04.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:12:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CA6E65FA5C;
 Tue, 14 Oct 2025 12:12:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 8/8] tests/functional: add GPU blob allocation test
Date: Tue, 14 Oct 2025 12:12:34 +0100
Message-ID: <20251014111234.3190346-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014111234.3190346-1-alex.bennee@linaro.org>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

This is a very short microkernel test that initialises and then maps
and unmaps a blob resource.

Without the other fixes in this series it causes QEMU to hang on the
unhandled unmap.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/aarch64/meson.build      |  1 +
 tests/functional/aarch64/test_gpu_blob.py | 73 +++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/functional/aarch64/test_gpu_blob.py

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 5ad52f93e1d..f6ca33b2be4 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -26,6 +26,7 @@ tests_aarch64_system_thorough = [
   'aspeed_ast2700',
   'aspeed_ast2700fc',
   'device_passthrough',
+  'gpu_blob',
   'hotplug_pci',
   'imx8mp_evk',
   'kvm',
diff --git a/tests/functional/aarch64/test_gpu_blob.py b/tests/functional/aarch64/test_gpu_blob.py
new file mode 100755
index 00000000000..a913d3b29c8
--- /dev/null
+++ b/tests/functional/aarch64/test_gpu_blob.py
@@ -0,0 +1,73 @@
+#!/usr/bin/env python3
+#
+# Functional tests for GPU blob support. This is a directed test to
+# exercise the blob creation and removal features of virtio-gpu. You
+# can find the source code for microkernel test here:
+#   https://gitlab.com/epilys/qemu-880-repro
+#
+# Copyright (c) 2025 Linaro Ltd.
+#
+# Authors:
+#  Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu.machine.machine import VMLaunchFailure
+
+from qemu_test import Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test.linuxkernel import LinuxKernelTest
+
+class Aarch64VirtBlobTest(LinuxKernelTest):
+
+    ASSET_BLOB = Asset('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/'
+                       'download?path=%2Fblob-test&files=qemu-880.bin',
+                       '2f6ab85d0b156c94fcedd2c4c821c5cbd52925a2de107f8e2d569ea2e34e42eb')
+
+    def test_virtio_gpu_blob(self):
+
+        self.set_machine('virt')
+        self.require_accelerator("tcg")
+
+        blob = self.ASSET_BLOB.fetch()
+
+        self.vm.set_console()
+
+        self.vm.add_args("-machine", "virt,memory-backend=mem0,accel=tcg",
+                         '-m', '4G',
+                         '-cpu', 'max',
+                         '-kernel', blob,
+                         '-object', 'memory-backend-memfd,share=on,id=mem0,size=4G',
+                         '-global', 'virtio-mmio.force-legacy=false',
+                         '-nic', 'none',
+                         '-device',
+                         'virtio-gpu-gl,hostmem=128M,blob=true,venus=true',
+                         '-display', 'egl-headless,gl=on',
+                         '-d', 'guest_errors')
+
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as excp:
+            if "old virglrenderer, blob resources unsupported" in excp.output:
+                self.skipTest("No blob support for virtio-gpu")
+            elif "old virglrenderer, venus unsupported" in excp.output:
+                self.skipTest("No venus support for virtio-gpu")
+            elif "egl: no drm render node available" in excp.output:
+                self.skipTest("Can't access host DRM render node")
+            elif "'type' does not accept value 'egl-headless'" in excp.output:
+                self.skipTest("egl-headless support is not available")
+            elif "'type' does not accept value 'dbus'" in excp.output:
+                self.skipTest("dbus display support is not available")
+            elif "eglInitialize failed: EGL_NOT_INITIALIZED" in excp.output:
+                self.skipTest("EGL failed to initialize on this host")
+            else:
+                self.log.info("unhandled launch failure: %s", excp.output)
+                raise excp
+
+        self.wait_for_console_pattern('[INFO] virtio-gpu test finished')
+        # the test should cleanly exit
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.3


