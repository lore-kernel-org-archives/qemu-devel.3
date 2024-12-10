Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA283E77183
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL75L-0006xP-UR; Tue, 10 Dec 2024 15:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75I-0006vB-EW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:43:56 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75F-0001yO-1D
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:43:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso6882165e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863431; x=1734468231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uld2y1nXUdPcLte2Xz1oCDzFJnjzfMw21fGvMGR5aoA=;
 b=J897ggcq2YQAJni0t8do5oMQc9brAQV+n17IiEioZvSAbZ5HCreTJ7hI9p3pjAjTa7
 uU43gpSDkZQMByNZmIpdrRm81UiyfFOxgTtSLPzzzTWuYKi+c4hPse3568QpmoJlLpRb
 gKSpDNq+ImYzDswkjPD18n9lrZj48romvv3EsgvN/EeNnrCQ7zYAna02AKtDRazz9RAV
 AOWD4EhrJo4vY1MZPNd3hdHqjQHhEbjlwxpkaeEuF75kk6UeODr5EyzUkCWl7LRDAZ83
 3rrEC2obvMZwMM/0uGUWKFazLsFP22uYGQaAeog0f0qYXCt7DNmpkyeE7HPNc/7cv7SE
 n94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863431; x=1734468231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uld2y1nXUdPcLte2Xz1oCDzFJnjzfMw21fGvMGR5aoA=;
 b=SenqT4PVFMWsKD56IW28SzYTh6MBPCrHYMEyoJD/10BOPfincY0a5Z1a+BlofuEF5H
 zOP4cYrwFBKWyvCWqyIvHmGZ0prkdQIyzEHpSbo6lzKwdaPV3flvBKs36R51iPpjogwG
 NlHqcv+tmke0GS+aYfWtgOZzzEKkhmfldnb3D8Q49f744ITIgRFo5JRZKkoJnxc0eptw
 cswTSbsmxPamJ2lJlhgNQrBlPNmzZxACLnupYHWnmJlc2/oUjnjsXTTq40F7IoLHw043
 rguySPghDEiJkwWEGByb+6vDeDhlhJkfkiiBhF567PcByQOYLWlppH+18CCvZf52Sgch
 xnmQ==
X-Gm-Message-State: AOJu0YzV4Diam66p+xuU0kOeAt8NEQC0Q/e+blW4lkrNWsuCLiRNzSxM
 y32geiL8ojRdmv74+n4rCDbco8rvP9RwPqaxUSfQmYvSn/CUwbT/FylukUqXj0I=
X-Gm-Gg: ASbGncvKXRZcWYtMf4mBNx2oVblOTFl6qvchBuKFTs+sv9yrFyY5hx3V3aXfq/A6wXQ
 S6HxxJ8m+f8rHlfavKVvfp4655SWRlHz7J+LDRtVinIzw8phyXtgoJp1x7dwW7JZDzNHxbCQueh
 7GzyGKSZuD4tCMBDhVeQoyvq2Wc0rGMO6EAyy8wTSrYuQRmT1FZNvgB8OmZ0glD0yV6TAs4oOac
 dk6GaMIpLi7vMsnnj7W1Zu+UBW+jFEJ3EhGWrDamDGGe7pLQawN
X-Google-Smtp-Source: AGHT+IFAQHn+o8L0zBOKR7Ob4liA73H1CFZW/9ubv4bGm8vu+BJkaXCXmF+1N8nzLShs75+hQi1gwQ==
X-Received: by 2002:a05:600c:1c1c:b0:434:a350:207c with SMTP id
 5b1f17b1804b1-4361c3f4cbcmr1619755e9.23.1733863431065; 
 Tue, 10 Dec 2024 12:43:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52cbefasm238843805e9.43.2024.12.10.12.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB15F5FA16;
 Tue, 10 Dec 2024 20:43:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cleber Rosa <crosa@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 03/20] tests/functional: add a m68k tuxrun tests
Date: Tue, 10 Dec 2024 20:43:32 +0000
Message-Id: <20241210204349.723590-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Message-Id: <20241121165806.476008-24-alex.bennee@linaro.org>
---
 tests/functional/meson.build         |  1 +
 tests/functional/test_m68k_tuxrun.py | 34 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 tests/functional/test_m68k_tuxrun.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d6d2c0196c..0a76bd9954 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -97,6 +97,7 @@ tests_m68k_system_thorough = [
   'm68k_mcf5208evb',
   'm68k_nextcube',
   'm68k_q800',
+  'm68k_tuxrun',
 ]
 
 tests_microblaze_system_thorough = [
diff --git a/tests/functional/test_m68k_tuxrun.py b/tests/functional/test_m68k_tuxrun.py
new file mode 100644
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


