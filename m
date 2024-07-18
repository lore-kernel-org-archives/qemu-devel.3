Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F513C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNhi-0003dD-Ms; Thu, 18 Jul 2024 05:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhe-0003Mq-Mx
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:34 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhY-0007bP-L5
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:34 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eefc3d707dso7507161fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295926; x=1721900726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fK9wM/QALdoRYcPahbnEbwp8pC6VCEMrlhDYV6cnZU=;
 b=Hw+4REFP/OjxJaxIzK6Boh0wq06h91sCJ27Zr5FZ4e2QQvw64ZIUlTdztQD7KZQuzp
 zqoK8/ZDd4QlbPOL32VE5lfTCyAoP9xd+CWkGuoC5VJNbho7p9wkbO12PgI3e2e6KNl2
 uMSvX7OPehv6O2p44BNpDQdzkk4xKDrxOOiBgeoRgM43XeFAkWlNESSZMGGrWsmHS54j
 bQCkxdUkrz5f3E51O6Zwf+LCJWR1p5auwPM/1iMFT9pZOeSf8GfShbe+UT32+95exK3T
 p2EH/vOmKcuLfDcUjeQX70Dv9sVvXFJm/uHDxXUBOmUv5HCRm/PMO5i7EUg7swa8e+pz
 sOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295926; x=1721900726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fK9wM/QALdoRYcPahbnEbwp8pC6VCEMrlhDYV6cnZU=;
 b=lDjALLVwkJOnvYUo6ntPqQU9Q6roaEriSEMftEMeYOxMOmqxuqDiy98ztYGmVuAhal
 IyZAETCguW6OkDq+slnW0Z1O6ZSNxB4ceYQ4ZC1iek2UFUIZUhr80ivo5Jwgqg7MkB5k
 edBOtPMCJMaCWLGUlbuJGuCfdE54UhxSFXVk3oE4Cy2+ZvgYtGmTJUGaWozeDLYGZuAb
 1Lis7lA6IoPbcCUXVblZwO2ofJwG2ZoKK43GS1VwLhF61RztGQMac+adEI8gMY31f+wU
 u8DmhUPQgdQ2+73CaQDikNa7nn1ic3iA4e1bYDeR7QOHd2oRtGz/vl8pzkAxY2+6yuDx
 UO4g==
X-Gm-Message-State: AOJu0YyrP0e6z5PxOvHsSNOp1C8AxZBjyGnweOVQGV42YTdD7VQrU87q
 k4rwv0RogAJQ+kM0gMG5IQxhKWSPNk2OvUPheP+6ujjLyeKO3u3pK1Qb5XXWRyo=
X-Google-Smtp-Source: AGHT+IF/+XQmkK9rfUbjAIlD8dfodmMqLckxl++yXE+/1wVTorCVEWh9kUHOhGAaNQK0v9ej3uyFXw==
X-Received: by 2002:a2e:3502:0:b0:2ee:7a71:6e3b with SMTP id
 38308e7fff4ca-2ef05c99152mr12055521fa.27.1721295925742; 
 Thu, 18 Jul 2024 02:45:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a21662e2f3sm295410a12.40.2024.07.18.02.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2BD625F929;
 Thu, 18 Jul 2024 10:45:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 02/15] tests/avocado: Remove non-working sparc leon3 test
Date: Thu, 18 Jul 2024 10:45:10 +0100
Message-Id: <20240718094523.1198645-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718094523.1198645-1-alex.bennee@linaro.org>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
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

From: Thomas Huth <thuth@redhat.com>

The test has been marked as broken more than 4 years ago, and
so far nobody ever cared to fix it. Thus let's simply remove it
now ... if somebody ever needs it again, they can restore the
file from an older version of QEMU.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Clément Chigot <chigot@adacore.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240710111755.60584-1-thuth@redhat.com>
[AJB: fix MAINTAINERS]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS                          |  1 -
 tests/avocado/machine_sparc_leon3.py | 37 ----------------------------
 2 files changed, 38 deletions(-)
 delete mode 100644 tests/avocado/machine_sparc_leon3.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d9811458c..d5ff6c2498 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1727,7 +1727,6 @@ S: Maintained
 F: hw/sparc/leon3.c
 F: hw/*/grlib*
 F: include/hw/*/grlib*
-F: tests/avocado/machine_sparc_leon3.py
 
 S390 Machines
 -------------
diff --git a/tests/avocado/machine_sparc_leon3.py b/tests/avocado/machine_sparc_leon3.py
deleted file mode 100644
index e61b223185..0000000000
--- a/tests/avocado/machine_sparc_leon3.py
+++ /dev/null
@@ -1,37 +0,0 @@
-# Functional test that boots a Leon3 machine and checks its serial console.
-#
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later. See the COPYING file in the top-level directory.
-
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado import skip
-
-
-class Leon3Machine(QemuSystemTest):
-
-    timeout = 60
-
-    @skip("Test currently broken")
-    # A Window Underflow exception occurs before booting the kernel,
-    # and QEMU exit calling cpu_abort(), which makes this test to fail.
-    def test_leon3_helenos_uimage(self):
-        """
-        :avocado: tags=arch:sparc
-        :avocado: tags=machine:leon3_generic
-        :avocado: tags=binfmt:uimage
-        """
-        kernel_url = ('http://www.helenos.org/releases/'
-                      'HelenOS-0.6.0-sparc32-leon3.bin')
-        kernel_hash = 'a88c9cfdb8430c66650e5290a08765f9bf049a30'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        self.vm.set_console()
-        self.vm.add_args('-kernel', kernel_path)
-
-        self.vm.launch()
-
-        wait_for_console_pattern(self, 'Copyright (c) 2001-2014 HelenOS project')
-        wait_for_console_pattern(self, 'Booting the kernel ...')
-- 
2.39.2


