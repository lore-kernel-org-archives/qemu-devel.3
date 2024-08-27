Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2CBC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sisp9-00014e-HA; Tue, 27 Aug 2024 05:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sisp7-00013v-Rd
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:13 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sisp5-00087G-Ne
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:49:13 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8683dc3b17so338076466b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724752150; x=1725356950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dvCJaXQ9bwpeXIjHD3IyOmSWxfRDpEZEg9BfTaOZjso=;
 b=v6t3PKxn9vlK5f8K76JDp6fo/zrZvaDykfNmwkD00Uwl4oOzP1gElcNytk6+rgyxD2
 rKcUHolmgpJ5NyQWvwg+hVIPZ9m9ghvgzXRXbQBNWLD+rDkIIqNw6lXnq5S8P9nYji2T
 bu2PyOADotqLLNlQNTk9quw3p50mUzIEcJGy7N6rEVVWK+2rZcUrfgp1tSOvHF6MTMaa
 m0swOx9b743cVCXpRPFbwgrcdQLH9XLKwwd2JaVckoKM1bxYPJ5Szn8Hqltu51qGmUNr
 2q5wtJo/mnxNvJ4ICBIQLRBcNYEbGb5xR4khJcq/WJXTqZ9J2q7CgtHE8gi9Agtt0jje
 TXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724752150; x=1725356950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dvCJaXQ9bwpeXIjHD3IyOmSWxfRDpEZEg9BfTaOZjso=;
 b=FUrQFL6pU+aV0xKLvszwDltGbxtlXcHd51LCxEG+11hT5lZGSYB7mY6o/+zfZcNG79
 DBg5bPSQIYGKL4H6BLJZC9aZTHoVXq8kcub0Xv/cWwdNWTD2AR8CmBkICao9wLFD/7N7
 58LbZ/23ehBJOrJeI3kgUZx9xnW+dQusUdsrb82LaGEaBi0q6O3PNmvpzJXaY9X0qDTa
 RdYarHft1/Z0OH0gJO0l6r+1tHzvQ/AHDjoP5zpTBFCStzpjDuWSMAyZmbr60dDXAg/f
 F2zdS8UzxEHKVNT3RYj7L2uazulIhqP0AlUKecFaMrCvojgxqHFDyvb+83dIjMeZQwUG
 6pCA==
X-Gm-Message-State: AOJu0YyEuXxRsckXX7xVEeJ/PwJeWfuIiDMjEEdA4sWD4UfYnG/v4BTu
 9QY1rbqI800uSD+Os37SnNTcuUt7wxSa+laC7A10HQ6FMr2JesPi43fOVYBwaWQcjG1HpeoqJLD
 i
X-Google-Smtp-Source: AGHT+IEgaq3TR4RJEc4EaAVd6+r58wici1GYcmn/IOisF1X2r3dT2DImnJ1oONt1TSqm7p+gISKQoQ==
X-Received: by 2002:a05:6402:50d2:b0:5bf:b29:6eb9 with SMTP id
 4fb4d7f45d1cf-5c0891a823dmr12360081a12.23.1724752149471; 
 Tue, 27 Aug 2024 02:49:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb20fc99sm805206a12.47.2024.08.27.02.49.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Aug 2024 02:49:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 0/7] tests/functional: Convert few MIPS avocado tests
Date: Tue, 27 Aug 2024 11:48:58 +0200
Message-ID: <20240827094905.80648-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Since v3:
- Use linux_kernel_wait_for_pattern (Thomas)

$ RESCUE_YL_PATH=/path/to/fuloong2e/rescue-yl \
  QEMU_TEST_ALLOW_UNTRUSTED_CODE=1 \
  QEMU_TEST_FLAKY_TESTS=1 \
  QEMU_TEST_TIMEOUT_EXPECTED=1 \
    make check-functional V=1
▶  2/17 test_empty_cpu_model.EmptyCPUModel.test                                                      OK
 2/17 qemu:func-quick+func-mips64el / func-mips64el-empty_cpu_model                                  OK  0.14s   1 subtests passed
▶  8/17 test_empty_cpu_model.EmptyCPUModel.test                                                      OK
 8/17 qemu:func-quick+func-mips / func-mips-empty_cpu_model                                          OK  0.13s   1 subtests passed
▶  4/17 test_version.Version.test_qmp_human_info_version                                             OK
▶  5/17 test_empty_cpu_model.EmptyCPUModel.test                                                      OK
▶  7/17 test_version.Version.test_qmp_human_info_version                                             OK
 4/17 qemu:func-quick+func-mips64el / func-mips64el-version                                          OK  0.17s   1 subtests passed
 5/17 qemu:func-quick+func-mipsel / func-mipsel-empty_cpu_model                                      OK  0.17s   1 subtests passed
 7/17 qemu:func-quick+func-mipsel / func-mipsel-version                                              OK  0.18s   1 subtests passed
▶ 10/17 test_version.Version.test_qmp_human_info_version                                             OK
10/17 qemu:func-quick+func-mips / func-mips-version                                                  OK  0.21s   1 subtests passed
▶  1/17 test_mips64el_fuloong2e.MipsFuloong2e.test_linux_kernel_2_6_27_isa_serial                    OK
▶  3/17 test_info_usernet.InfoUsernet.test_hostfwd                                                   OK
▶ 11/17 test_empty_cpu_model.EmptyCPUModel.test                                                      OK
 3/17 qemu:func-quick+func-mips64el / func-mips64el-info_usernet                                     OK  0.29s   1 subtests passed
▶  6/17 test_info_usernet.InfoUsernet.test_hostfwd                                                   OK
11/17 qemu:func-quick+func-mips64 / func-mips64-empty_cpu_model                                      OK  0.16s   1 subtests passed
 6/17 qemu:func-quick+func-mipsel / func-mipsel-info_usernet                                         OK  0.30s   1 subtests passed
▶  9/17 test_info_usernet.InfoUsernet.test_hostfwd                                                   OK
 9/17 qemu:func-quick+func-mips / func-mips-info_usernet                                             OK  0.30s   1 subtests passed
▶ 13/17 test_version.Version.test_qmp_human_info_version                                             OK
13/17 qemu:func-quick+func-mips64 / func-mips64-version                                              OK  0.19s   1 subtests passed
▶ 12/17 test_info_usernet.InfoUsernet.test_hostfwd                                                   OK
12/17 qemu:func-quick+func-mips64 / func-mips64-info_usernet                                         OK  0.24s   1 subtests passed
▶ 17/17 test_mips_malta.MaltaMachineConsole.test_mips_malta                                          OK
▶ 16/17 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_16k_up                    OK
▶  1/17 test_mips64el_fuloong2e.MipsFuloong2e.test_linux_kernel_3_16                                 OK
 1/17 qemu:func-quick+func-mips64el / func-mips64el-mips64el_fuloong2e                               OK  3.10s   2 subtests passed
▶ 16/17 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_4k                        OK
▶ 14/17 test_mips64el_loongson3v.MipsLoongson3v.test_pmon_serial_console                             OK
14/17 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_loongson3v         OK  4.71s   1 subtests passed
▶ 16/17 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_64k_dbg                   OK
▶ 16/17 test_mipsel_malta.MaltaMachineYAMON.test_mipsel_malta_yamon                                  OK
16/17 qemu:func-thorough+func-mipsel-thorough+thorough / func-mipsel-mipsel_malta                    OK  8.64s   4 subtests passed
▶ 15/17 test_mips64el_malta.MaltaMachineConsole.test_mips64el_malta                                  OK
▶ 17/17 test_mips_malta.MaltaMachineConsole.test_mips_malta_cpio                                     OK
17/17 qemu:func-thorough+func-mips-thorough+thorough / func-mips-mips_malta                          OK  14.06s   2 subtests passed
▶ 15/17 test_mips64el_malta.MaltaMachineConsole.test_mips64el_malta_5KEc_cpio                        OK
▶ 15/17 test_mips64el_malta.MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core     OK
▶ 15/17 test_mips64el_malta.MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores    OK
▶ 15/17 test_mips64el_malta.MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores    OK
▶ 15/17 test_mipsel_malta.MaltaMachineYAMON.test_mipsel_malta_yamon                                  OK
15/17 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_malta              OK  56.88s   6 subtests passed

Ok:                 17
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            0
Timeout:            0

Based-on: <20240826221058.75126-2-philmd@linaro.org>

Philippe Mathieu-Daudé (7):
  tests/functional: Convert mips64el Fuloong2e avocado test (1/2)
  tests/functional: Convert mips64el Fuloong2e avocado test (2/2)
  tests/functional: Convert mips64el I6400 Malta avocado tests
  tests/functional: Convert mips64el 5KEc Malta avocado tests
  tests/functional: Convert mips32el Malta YAMON avocado test
  tests/functional: Convert nanomips Malta avocado tests
  tests/functional: Convert mips32eb 4Kc Malta avocado tests

 MAINTAINERS                                 |   6 +-
 tests/avocado/boot_linux_console.py         | 217 --------------------
 tests/avocado/machine_mips_fuloong2e.py     |  42 ----
 tests/avocado/machine_mips_malta.py         | 162 ---------------
 tests/functional/meson.build                |  13 ++
 tests/functional/qemu_test/utils.py         |  20 ++
 tests/functional/test_mips64el_fuloong2e.py |  67 ++++++
 tests/functional/test_mips64el_malta.py     | 190 +++++++++++++++++
 tests/functional/test_mips_malta.py         |  84 ++++++++
 tests/functional/test_mipsel_malta.py       |  98 +++++++++
 10 files changed, 476 insertions(+), 423 deletions(-)
 delete mode 100644 tests/avocado/machine_mips_fuloong2e.py
 delete mode 100644 tests/avocado/machine_mips_malta.py
 create mode 100755 tests/functional/test_mips64el_fuloong2e.py
 create mode 100755 tests/functional/test_mips64el_malta.py
 create mode 100755 tests/functional/test_mips_malta.py
 create mode 100755 tests/functional/test_mipsel_malta.py

-- 
2.45.2


