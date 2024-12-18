Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B1BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwnR-0007OM-9i; Wed, 18 Dec 2024 11:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnP-0007N5-Am
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:11 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnL-0006bu-Ib
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:10 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso1195763366b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538866; x=1735143666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vz2EL6CTwFEi6T4j67jXxOQuHyLmeJyyOHpPY04XAmo=;
 b=aWZ1Ejl7CmfGccD7LokM4N5hwLY7luHsdNdqR5cTL22K4ZvwurppjDHKxT7hTa5IR9
 XrCOvA5zJNNvi9t4dmLAKmyX3ajqabtJjWaKStGBO80UMpeLwnGD+mHpq/zfq1txG+z6
 zEEpi2krWoL/1DsIQz9Yeb9YZcbPzSgfQLmpceizEv8iofv6kNahvGs4hXphGVL6glnK
 Q5DybIv4Q8cobUJM3a1eqQmjFZivTUSRXr4EJPvFJSC6kKuRKI1w/jFPkjOS4mK8MKKH
 4mWvwOXgMF/ymL/1YXYcqIJzFAszIE3ru8YfRETTWokZY39fB7bekXG/jnSgxQp3AEyO
 4hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538866; x=1735143666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vz2EL6CTwFEi6T4j67jXxOQuHyLmeJyyOHpPY04XAmo=;
 b=wPY1R6iuVdbXlfHoql1Hp25GXBlzaZpAopMrL9CVF2x3Bux5Bn6mhZzBNPt4YfkVwm
 E6A+a4cEbXz0yT1XsdCO/92RX16vk2k0nhcHKrgCqMawCw/L4NzmOscQPXeqs3SB3UkM
 wcMxv2TnyezYzjCepR/CStGW9W52y9skUE7Oo7+csbCVdDhFLc4WydptEAXocV/wWxqI
 XATgS+jDc4kjqZZOhchE9uWS5/105yfeD/kRp9k3fPLTgOAN+FYdoX2pqe8rDChrBMN5
 b2dSXXcyBRpgXbSC1P1ciQgZMDR1XBUfhZG1iwZ2+5PC7Ex8o4zJk+7D1aDlyh7Z1QTA
 yQbQ==
X-Gm-Message-State: AOJu0Yy03RC4ba9jpRe29gefz2FwGY9gNkclw/LtfjEJBZaHUSQAUcDo
 VxCeroeUvZw30JomNv7PQRu59DI8e2K7LcQa0kRVNKCC9NxclxrWMFQh5cQcL58=
X-Gm-Gg: ASbGnctJeG9+2Z7tWPHWjfo742kx4nmb12Vo3F5E2t6A66vTTlBTVol8Aag8WxtjuN+
 8SuEY4HC2lPV/542m9UzFQCeZAaKbliBGGGh6JP+89LYTP3u1Wr+908eYpqI79RJzGC84ehV847
 OJ0VB41pGE8tQEWVhmLsoCWnO49bfRQcWhoAvDhy7hKWh7TIn55CjT6AsUjfj+vvGSPkVqQo6zh
 NqTLHyBPBP44IOhYY6seCCykoKGJRgU5w4gFl5jylEkl6U6cQzUKKY=
X-Google-Smtp-Source: AGHT+IGnMUT3OywAG9CsFo+XVUiZ4w7jR+R68xT85Lx56jJweE+LTeY47nibDo9GbWE7OyVDILtCyQ==
X-Received: by 2002:a17:906:7313:b0:aa6:2fdc:db1a with SMTP id
 a640c23a62f3a-aabf48d513cmr274876366b.38.1734538865820; 
 Wed, 18 Dec 2024 08:21:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9600dd9csm578696466b.10.2024.12.18.08.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 640F55FBC6;
 Wed, 18 Dec 2024 16:21:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Beraldo Leal <bleal@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 03/27] tests/functional: add a m68k tuxrun tests
Date: Wed, 18 Dec 2024 16:20:39 +0000
Message-Id: <20241218162104.3493551-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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
index 822f34344b..f7aa069d47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1283,6 +1283,7 @@ F: include/hw/intc/goldfish_pic.h
 F: include/hw/intc/m68k_irqc.h
 F: include/hw/misc/virt_ctrl.h
 F: docs/specs/virt-ctlr.rst
+F: tests/functional/test_m68k_tuxrun.py
 
 MicroBlaze Machines
 -------------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 1bc5ba5229..0e1bfb8c44 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -112,6 +112,7 @@ tests_m68k_system_thorough = [
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


