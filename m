Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17D1E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEtw-0004iS-Ba; Fri, 10 Jan 2025 08:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtl-0004cA-Pw
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:01 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtj-0004hJ-98
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:01 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436341f575fso21891355e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515077; x=1737119877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XsOBuDsdsXncH1mjxaZnWXPtp0PeddlD/M2VgDxx0s=;
 b=xkpvZrrpIqznqIXWEBIpS3luZIDWCZ0mNOAOigMnqOz50PexAQjmOgAz5a6XMGDXwl
 cRYQpgjsLLAKOFN+n2eCC5EEv/fP2YV0WJd7zov5VtoQPtxLE+7Oc2+0DxnlKI2nbXPM
 siaFu2WGusiWx+qBTUFif6eArvEHtiPY4+W+NFyxGZoUaR7ZDBVZBRFtJzg7uns8OKAa
 D3GeNtTTwGrD6RZvV6qACAVFZi6HsCmifZ2HZ4vizipl25QyDm4zzPEpXv8N24rdyySf
 4WY34Gca0CntXNEaEVsK3GsCoxtw9hSxVWDZuL3/FGoh/GPJP53JnZ3nuS3c9qaa8bLu
 ZxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515077; x=1737119877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XsOBuDsdsXncH1mjxaZnWXPtp0PeddlD/M2VgDxx0s=;
 b=U24ts1Uw0G5IEEIHcvey4mUcnBJqXp+2p78ruZcCWA8Yatln1RdzyLk/b6388wKCKt
 MGOGSkNCADkUVGoEgXxn3v00yRpq2z69dE/NsU5Z/7fyULLHErCIAgLvLoTGTkbHEyiK
 ZoCodsya1WEAVngAhYv4XmegIMs0bu7y5cy2+MSMdTFFqC5MpLAwcdR6kSygv1ThJ31i
 oK96m9cJ+MGADqZG5qpBmJ8Af9vORDA5NvTogN4qQp8h7nVplkC78gJUeU/gIt4/H7Z4
 hYN76HHRDnw8/2w/EusDO4Mv2o7ia0swD/NrdkHC5NJ9jWhUbRXYMwLDjrPsS/td589s
 RTBw==
X-Gm-Message-State: AOJu0Yz1PN3jnJKBvFzdf4O52eNzq4jmWswS9cFj4Lgt2KPjtYHm/+PR
 psYRyZr3tYelMKJIyEvdzbH/Vktppspbef3EdQHBfZvd4lXyS6nSOvN8+LAW7mMHfXH5R6iet/s
 Swv8=
X-Gm-Gg: ASbGnct9zcRqrku330b/RvEMFQWWKzlyFqWzh8bR1bDxrf3H/uAQJOqWmA09IdHSFa1
 dzdBfz7KXEObQWXLLW6oU1GrlWYLWHbkOsgQceS6JlRGY8yxGQ5E/FB2jMw2NxlDf5+Jq0nk6+J
 spg85ADmTHlKLJoIqpZ/jBZTtes4nRHRLNoXiKS0oKoMugAoiBYY+ulIhpRsPLSueXBcP+HF6Zc
 bIA/E9HZmAYZlhZR40RDrhgQNWTSGS8HiExyBExG22TGn6IKgfSQkw=
X-Google-Smtp-Source: AGHT+IHLtw1CBRPMhBQd6OZHSt73A19EGUmsjwVJSR2q6DoWq0EgYAp/0HNE5eDGVSutO422Nc72yA==
X-Received: by 2002:a05:600c:6b6f:b0:436:e86e:e4ab with SMTP id
 5b1f17b1804b1-436e86ee529mr81675945e9.30.1736515076999; 
 Fri, 10 Jan 2025 05:17:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03f8bsm51712215e9.23.2025.01.10.05.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:55 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E5895F9E2;
 Fri, 10 Jan 2025 13:17:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/32] tests/functional: add a m68k tuxrun tests
Date: Fri, 10 Jan 2025 13:17:25 +0000
Message-Id: <20250110131754.2769814-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

We didn't have this before and as it exercises the m68k virt platform
it seems worth adding. We don't wait for the shutdown because QEMU
will auto-exit on the shutdown.

Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-4-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 2101b51217..cab9018d9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1288,6 +1288,7 @@ F: include/hw/intc/goldfish_pic.h
 F: include/hw/intc/m68k_irqc.h
 F: include/hw/misc/virt_ctrl.h
 F: docs/specs/virt-ctlr.rst
+F: tests/functional/test_m68k_tuxrun.py
 
 MicroBlaze Machines
 -------------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index a5087fcb34..7890dcb86d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -116,6 +116,7 @@ tests_m68k_system_thorough = [
   'm68k_mcf5208evb',
   'm68k_nextcube',
   'm68k_q800',
+  'm68k_tuxrun',
 ]
 
 tests_microblaze_system_thorough = [
diff --git a/tests/functional/test_m68k_tuxrun.py b/tests/functional/test_m68k_tuxrun.py
new file mode 100755
index 0000000000..7eacba135f
--- /dev/null
+++ b/tests/functional/test_m68k_tuxrun.py
@@ -0,0 +1,34 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots known good tuxboot images the same way
+# that tuxrun (www.tuxrun.org) does. This tool is used by things like
+# the LKFT project to run regression tests on kernels.
+#
+# Copyright (c) 2024 Linaro Ltd.
+#
+# Author:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from qemu_test.tuxruntest import TuxRunBaselineTest
+
+class TuxRunM68KTest(TuxRunBaselineTest):
+
+    ASSET_M68K_KERNEL = Asset(
+        'https://storage.tuxboot.com/buildroot/20241119/m68k/vmlinux',
+        '7754e1d5cec753ccf1dc6894729a7f54c1a4965631ebf56df8e4ce1163ad19d8')
+    ASSET_M68K_ROOTFS = Asset(
+        'https://storage.tuxboot.com/buildroot/20241119/m68k/rootfs.ext4.zst',
+        '557962ffff265607912e82232cf21adbe0e4e5a88e1e1d411ce848c37f0213e9')
+
+    def test_m68k(self):
+        self.set_machine('virt')
+        self.cpu="m68040"
+        self.common_tuxrun(kernel_asset=self.ASSET_M68K_KERNEL,
+                           rootfs_asset=self.ASSET_M68K_ROOTFS,
+                           drive="virtio-blk-device")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.39.5


