Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D040C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 22:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sihvf-0000dl-Jk; Mon, 26 Aug 2024 18:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sihvY-0000cG-8A
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 18:11:09 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sihvU-0000mL-IU
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 18:11:06 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4fd136aac40so1268000e0c.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724710263; x=1725315063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=33v1eQT9GnPGoXvY61UfarMCNAR9O1t+ASdJzKFEsFA=;
 b=bIcSHJlzjjsheFnk47han/DkTA/pgvap6uAZt2UAnhcFKh0OYCEdmq550GfhLNSdv6
 pwQiU4MigXSOPuh5XOjRXzXrv3gBY3wlIkY3IFWWZxorTEZIQjE+TQ+bFjAjjR5jUsuo
 k9/N7MqNkFHWhe6rmptteNBXwyx4GerP4JjBh1Oi5oQdn+7hIC0OW7c6IDZAllNr2ZQR
 2TH4+ExW0m6ZLtOf+Iw1oI/MlDv+Vohk62p5uFC5vROqNZRofIaCq2rqH9q297k2hx0I
 Q5XqUmxQUw8hoEMvzZHGVBUMi3R6iPEfbBwaSo/9i5EQB+oVNNHMfD+g1YkLl6gzgz+H
 8X1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724710263; x=1725315063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=33v1eQT9GnPGoXvY61UfarMCNAR9O1t+ASdJzKFEsFA=;
 b=AIFJrpKdlbBUR8LDC9B/W0gerQ6x4nRxvL3yZE6QsGIJR9/3PTAO+tNgOCnc54YgPU
 sR+YhB19g2c6s/oVmuIfTO8FMfv3y6Om/wthnJlQR6mUStHdzK8/gDOP3tM/hLS1kexg
 4TSZgyDhzireZHsW1t/fKytQJ2UKGm8Aa8e2Y2m5LS1iUYpxh/YuCrQGy6vEmB2zv17t
 t5tO2I2Gt50V26R2chdK51BdL41zCq0R0EvE0ly974AqorgIbalaQrfzfiM6M9s2k/y/
 HDp9IGGw5NkyGPoDRka76+iB+96Uo+tdIGu6wWiDqM9j6az9cI6vgmfSvVMLRWGddAHP
 SVmw==
X-Gm-Message-State: AOJu0YwRoLHcAkn1mUqTHXPwYsdUTxmnM57r/RF7/xZdSVyFPB3GCx83
 O/266XdHvoW4JWVSzuftSwbDqVse0DYscDGXmNdi4OrySwzgkj+IO9yM8IKEm6gQOL9pBFnqELp
 /
X-Google-Smtp-Source: AGHT+IET1ipGr6ibjleQLfCnDO8u1tzJX4sFPse00M8sTMcDxNAbPlQrTYtn/KYrYBrGAlNoZGavYg==
X-Received: by 2002:a05:6122:1d51:b0:4fc:f1e3:d238 with SMTP id
 71dfb90a1353d-4fed5d63593mr1391597e0c.1.1724710263059; 
 Mon, 26 Aug 2024 15:11:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe0f04adsm47913111cf.43.2024.08.26.15.11.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Aug 2024 15:11:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] tests/functional: Convert Raspberry Pi avocado tests
Date: Tue, 27 Aug 2024 00:10:54 +0200
Message-ID: <20240826221058.75126-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=philmd@linaro.org; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

▶ 4/5 test_aarch64_raspi3.Aarch64Raspi3Machine.test_aarch64_raspi3_atf                OK
4/5 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_raspi3   OK   1.96s   1 subtests passed
▶ 5/5 test_aarch64_raspi4.Aarch64Raspi4Machine.test_arm_raspi4                        OK
5/5 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_raspi4   OK   5.19s   1 subtests passed
▶ 6/6 test_arm_raspi2.ArmRaspi2Machine.test_arm_raspi2_initrd                         OK
▶ 6/6 test_arm_raspi2.ArmRaspi2Machine.test_arm_raspi2_uart0                          OK
6/6 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_raspi2               OK   15.31s   2 subtests passed

Based-on: <20240821082748.65853-1-thuth@redhat.com>

Philippe Mathieu-Daudé (4):
  tests/functional: Add a class containing Linux kernel helpers
  tests/functional: Convert ARM Raspi2 avocado tests
  tests/functional: Convert Aarch64 Raspi3 avocado tests
  tests/functional: Convert Aarch64 Raspi4 avocado tests

 MAINTAINERS                                |   3 +
 tests/avocado/boot_linux_console.py        | 205 ---------------------
 tests/functional/meson.build               |   6 +
 tests/functional/qemu_test/linux_kernel.py |  19 ++
 tests/functional/test_aarch64_raspi3.py    |  42 +++++
 tests/functional/test_aarch64_raspi4.py    | 106 +++++++++++
 tests/functional/test_arm_raspi2.py        | 103 +++++++++++
 7 files changed, 279 insertions(+), 205 deletions(-)
 create mode 100644 tests/functional/qemu_test/linux_kernel.py
 create mode 100755 tests/functional/test_aarch64_raspi3.py
 create mode 100755 tests/functional/test_aarch64_raspi4.py
 create mode 100755 tests/functional/test_arm_raspi2.py

-- 
2.45.2


