Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70903C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglTQ-00022l-SG; Wed, 21 Aug 2024 09:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sglTO-0001ta-E8
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:34:02 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sglTM-0005wj-74
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:34:02 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-371ba7e46easo1929976f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247238; x=1724852038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CcYalReRQD/9y4ZQ23cSwVFeg7oovaloH3i2aWIe2no=;
 b=Tn+GXTNhxW1bRrT0YWqSBE9e1m/9AxqJxt6Ve5rICYvd6RkJAPRKhjyIrPNzQfymMF
 3MgaUXyd+x7ikjv/hYW7HkylgnuKpehUl3uajIMLuwUZ68AZ1nO1cSePakWu3LJLSKyr
 9wn+R0ImzIx+ECRknBgbxnbluQlioWFVmxOqen+aS0zLzm15bNiSafkJZ5vHX/KrM8U1
 rCaFqTt889SKO+yb4qTvBBsjWcme9KUsYbp4KabeI8qPSBqkJl0IQQUqQgbPuz96LH1p
 RhSQI/uPDXSWbECi/vXuJYlg+iS0q2JIkAMWAAeb4YhTxBROW9i/x3XoYaWhrt0xRYqG
 9/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247238; x=1724852038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CcYalReRQD/9y4ZQ23cSwVFeg7oovaloH3i2aWIe2no=;
 b=CtLhMd76h9uieQFkxoRgaZHCPjL17WaOQ/Nr3RHi8ArlKPLFDJGR6Y+qcs5fOxz+DN
 oFT7D+d3y1NEPxE2GbLMWBiRrC6c0L036+gtAYHQyFv4h/Y45R9wx7d8vnYdYqR5FPJ8
 Wn+kd1DLZWVMa00eSt4excErKJmAbZ8AEGANmfNW3vJygv2xetZBsL7k31VbbPmlfcSh
 FVt0qN/M0+ZwVHgFYecuMy3hksUqYmlzvUBEq5K3ZXePqNgOC57Zgk0ZSIm7lNhQpxag
 YFZgrZJjBitPnAOOpkZVbOY/e9IQLonqYLhH9dvoahhKq29LpZDlGQg6i1a2BdZjbUgX
 WXXQ==
X-Gm-Message-State: AOJu0YzHP+C2iusfua951c+tBsTqmoC4Mls6xwynJGBb1hIW7EuXe8Lu
 7LLv7vRND1sFXZJ6HC0zW1gbmrYhWH3npVvAub3CrEQ/Js4hL7E9PCi64+c4eUqDUOTJ/6iZsRw
 2Rws=
X-Google-Smtp-Source: AGHT+IEN0ca2GoRzJTCdOpISBy0vZCNIen6OPIq131j8cs/YhZmlqWL12WLyq6bmJiH3Bv9vh8SMtw==
X-Received: by 2002:a05:6000:1e96:b0:371:86b2:a7e4 with SMTP id
 ffacd0b85a97d-372fd5ca8fdmr1469254f8f.37.1724247237450; 
 Wed, 21 Aug 2024 06:33:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189849b08sm15590548f8f.43.2024.08.21.06.33.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Aug 2024 06:33:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v2 0/3] tests/functional: Convert few MIPS avocado tests
Date: Wed, 21 Aug 2024 15:33:50 +0200
Message-ID: <20240821133353.65903-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

1/4 qemu:func-quick+func-mipsel / func-mipsel-empty_cpu_model                               OK   0.64s   1 subtests passed
2/4 qemu:func-quick+func-mipsel / func-mipsel-version                                       OK   0.65s   1 subtests passed
3/4 qemu:func-quick+func-mipsel / func-mipsel-info_usernet                                  OK   0.67s   1 subtests passed
4/4 qemu:func-thorough+func-mipsel-thorough+thorough / func-mipsel-mipsel_malta             OK   2.30s   1 subtests passed
1/6 qemu:func-quick+func-mips64el / func-mips64el-empty_cpu_model                           OK   0.12s   1 subtests passed
2/6 qemu:func-quick+func-mips64el / func-mips64el-version                                   OK   0.13s   1 subtests passed
3/6 qemu:func-quick+func-mips64el / func-mips64el-info_usernet                              OK   0.15s   1 subtests passed
4/6 qemu:func-quick+func-mips64el / func-mips64el-mips64el_fuloong2e                        OK   0.19s   1 subtests passed
5/6 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_loongson3v  OK   4.53s   1 subtests passed
6/6 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_malta       OK  23.52s   4 subtests passed

Based-on: <20240821082748.65853-1-thuth@redhat.com>
Supersedes: <20240821125701.63042-1-philmd@linaro.org>

Philippe Mathieu-Daudé (3):
  tests/functional: Convert mips fuloong2e avocado test
  tests/functional: Convert mips64el Malta I6400 avocado tests
  tests/functional: Convert mipsel Malta YAMON avocado test

 MAINTAINERS                                   |  5 +-
 tests/functional/meson.build                  |  9 ++
 .../test_mips64el_fuloong2e.py}               | 30 +++---
 .../test_mips64el_malta.py}                   | 98 +++++--------------
 tests/functional/test_mipsel_malta.py         | 46 +++++++++
 5 files changed, 99 insertions(+), 89 deletions(-)
 rename tests/{avocado/machine_mips_fuloong2e.py => functional/test_mips64el_fuloong2e.py} (61%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_mips_malta.py => functional/test_mips64el_malta.py} (53%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_mipsel_malta.py

-- 
2.45.2


