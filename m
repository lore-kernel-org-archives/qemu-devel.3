Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B66E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUvW-0001Ms-Sg; Wed, 08 Jan 2025 07:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUu4-0000Y0-73
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:11:20 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUtt-0007EQ-ML
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:11:12 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d41848901bso1649860a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338258; x=1736943058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pg+m2UYdTGTiO8GlV1naIIPUfqxpX1jKwvMJgPoN6cA=;
 b=dRgx/+YY+wAQoFlXVDTohGRUuJ2PbbxS0ygy0TX5OBZp0bqvNaFSp+NAEYfVBIyM9H
 sA+0XwGNOuOg44akCVcXNSW0pxnnW06PARFmX30v3lAa2rCsKFaAKxQqq003rsIK7LRM
 qqqeFib7zDblG8ILlQG2uQf4ot170g11iYMbKeWnZ3F4FySxFMkIOn/yxH+h7dqa0iWP
 5aTjQm/hnDDC4PDTVsmw4HmUVui0Ak2AIY/2QZafvZF31094cEzel65jdzVbJwH14OtI
 oXezhDNpUcZ1+LRAIU7rdUjED4j3TkBVYIGh3Ng0bS+4K699SInDQEFvi/Fv6lzg0nNw
 0Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338258; x=1736943058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pg+m2UYdTGTiO8GlV1naIIPUfqxpX1jKwvMJgPoN6cA=;
 b=gQJWr93eDk5RwS3HE1pBhQp0T7SvVFk3Ab6uQdfyeDmY+in9ehO5oqZkD1DEOUnjPe
 LAHaX2tMJ//RwCHRe5ZJ3jNDLiLmEDXZKUddgf2VX0oVACD2hNi4FQe87Bzj/JvcXzVs
 NCpC/GJvL0lYafm/1qVuVGohXRu4ampiO+DrFS271uKqDt/nZWiN+Gdqwi5xTiQmI9ZY
 /HTC2NPthj32E+/3u9ydKTdXUb0xsmtcW9Uebli5ILv2hFW86ijWp4+f1hOHdD1iW4BH
 eRdBI/jhjEEQPsyHnC5ZgRjA0JEZwHCXq5c5gWeqQScUSb4dV2uCT6UCpibWQNperQ/9
 junw==
X-Gm-Message-State: AOJu0YzFGvtCk40mIQ1X3fX31bhR7ucpCV1NeMfXNzNYusjh5A1RvaTt
 YFEbmPw4zi2DgMtzHrnsb4jlFdEJaJ8cfPHA1f0ZCS81RHyrL387XRu9ZX92GhU=
X-Gm-Gg: ASbGncvaNQ8ydM+aLU+mq2AFJsyoq57WVNbfVd+0l336TAOdxuK4W9nYso9VIjJKfV+
 VyJzBq82YxJNOhvIMcY43I77mgP9RL96IYCf6tqY61kU32ad8cz+LEtJ2BEV/jwQ/K3aqgAaLen
 LQ5TYxWpjIu3VV0ldYpiT6kfSgdc6R4YfM3JlNvZIzRBYOJWNA2UU6B4S1zgcac1fpURkrkupSR
 EfgippAOTfho1eBD/ncxM5fTh9If8a0XJLiYO0eE5GUEq33OBThv2Y=
X-Google-Smtp-Source: AGHT+IGOZY2nvTjhj3zWQSDNUTRwhKCNJNu/AcYrj5Rp4lgF4m6lof8nW7rGnNE8g7247+2hBQiIag==
X-Received: by 2002:a05:6402:4304:b0:5d3:f041:140e with SMTP id
 4fb4d7f45d1cf-5d95e916cc8mr6054857a12.13.1736338258475; 
 Wed, 08 Jan 2025 04:10:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80676f40fsm25228478a12.28.2025.01.08.04.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:10:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D67835F929;
 Wed,  8 Jan 2025 12:10:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v4 03/32] tests/functional: add a m68k tuxrun tests
Date: Wed,  8 Jan 2025 12:10:25 +0000
Message-Id: <20250108121054.1126164-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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
v2
  - add to MAINTAINERS
---
 MAINTAINERS                          |  1 +
 tests/functional/meson.build         |  1 +
 tests/functional/test_m68k_tuxrun.py | 34 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 tests/functional/test_m68k_tuxrun.py

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


