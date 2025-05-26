Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC4AC54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQRm-0003Rb-So; Mon, 26 May 2025 01:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRa-0002ry-Tb
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:16 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRL-0002Ir-C0
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:02 -0400
Received: by mail-ua1-x942.google.com with SMTP id
 a1e0cc1a2514c-87ded588c8eso282540241.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748237516; x=1748842316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FE5dwy+2bD4ehEe2dm4zv+l8JLivF5Ay29z8XQyry8Q=;
 b=d6d03jFj+3r9Z04B/k+TfFpjiA9U/SiXnAiuI0FzSQM0a7a1dt8z6bPuoo5aL4O06n
 CHwDZH331zTKOPVIav5Mq8uLnClNRHiWUkAxWuLSiPsL3iPG/zEhwWpXliaoXaEeMj1n
 s+zRFlLfNr0XIpMt895sekSpY2mEm/ynbt+uW042xX9Zkc1KiOK2LMopSvepQWUq77vJ
 O4IxTCEavRISitHKXPo2pFTX4XF9OEJJwUj243oEplsBdICHCC3r7y/qISM3NG1vQYJi
 7cedBC5CSv0E7mgwcRHZmOBiP4fiNSwr5WHxAfzAV6RpSwaVLOTY7r+W7JIQMCZA9222
 6UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237516; x=1748842316;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FE5dwy+2bD4ehEe2dm4zv+l8JLivF5Ay29z8XQyry8Q=;
 b=BuM/sBbkdPkB+pArM9DJe5zkHWfpeFUnVk7uI8ucyWmp6eFwsZLRrLIDUiiH3EyZ7X
 iJo8S1L1YKf0b9gevyiDSLR8w6AahPCHn5sjhMP71H4KeiAtOCnG0Iw752Jz/ayJyrwn
 idBni316o1CK9ylYt9iu2Sp54ourl52oPsHOWkKNs/KQggjilOipnAp02EpTlgQXuq/S
 +cIoIHQv8aKE18N7e+3YV+vL7ovDvXExbsNKuQeM5IdqPGevSKVROgR5MjFSchzRNlu+
 U0nXE0u7EZkwTwxp6cKsnsRiFToJGh+nsJlv1J0nNaqW15kaj0NdkXK7Gtzk8wVVHUBl
 34qQ==
X-Gm-Message-State: AOJu0YwXu0RhYlQVSYwhCD4rFNeGes4NubWOIvzkWGxlqdlLfc/OfOcM
 IEPCYeSeZsC7Gkc/vpe4V6PYwWJQ7PFnuACrRfIaZ3NIb+XcLKxoiJoJThDeD46zL5fzHF3A+72
 xMTo8JQv+gA==
X-Gm-Gg: ASbGnct1GVc4EuiAK6+BcOCzSuYz8Bq49ZHEZzkBH+/ULFOkMOL1v7dmCqx+u3GVmTc
 nRsgbCdfgGzBfhhhiL1kALs8q59823Sb/qFwsco0Ktd+AyWR/omJ+iQeLfbctKPj22Z22/eXQOd
 3FwQHhOiGvg3zIjVOGPWvP78/yrFvvWBK5PHue+wawBh8jd+7p+lqNX2GdQ0cFgMr+F1qzkK55S
 J9xfoDhQp8h+RU5VQ/BcwTUFLInHN7tX5kgiHGtQsSfg/rI5mUuG+RO/dxmnm7Csh1m1W7MmmK3
 BQ7A6dn9Yojhyx2RjHImp0suux8NWosJFPUJ0pApYiMRVcavAGqJEgPfv6jXx7I+mD+XPivRBJ3
 grRYLBOc/MM9mWUNdL7LwHg==
X-Google-Smtp-Source: AGHT+IEuzcldqamOeAR6LQXYBr14vf8YjBhYIx3aqSXtNgpAd6Y6dkvNOFB6PufFOJQVFM9bvb0C0Q==
X-Received: by 2002:a05:6102:3e95:b0:4e2:82b9:b377 with SMTP id
 ada2fe7eead31-4e4241609ecmr5559911137.18.1748237516382; 
 Sun, 25 May 2025 22:31:56 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e454da4378sm784310137.17.2025.05.25.22.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 22:31:55 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, thuth@redhat.com, gustavo.romero@linaro.org,
 alex.bennee@linaro.org, mst@redhat.com, imammedo@redhat.com
Subject: [PATCH 0/5] ACPI tests for PCI Hotplug on ARM
Date: Mon, 26 May 2025 05:31:18 +0000
Message-Id: <20250526053123.1434204-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::942;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ua1-x942.google.com
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

This series updates the existing ACPI tests to work with the new support
for ACPI PCI hotplug on aarch64, which is now enabled by default in the
'virt' machine. Because ACPI PCI hotplug is now enabled by default it's
necessary to disable it (acpi-pcihp=off) for the existing tests, because
they use the native PCI hotplug mechanism.

It also introduces a new test variant, .acpipcihp, to test the ACPI
tables and the AML code necessary to make the ACP PCI hotplug/unplug
work, so in essence it tests the ACPI when 'acpi-pcihp=on'.

This series should not be merged before the "ACPI PCI Hotplug support on
ARM" [0] series (under review) is in the master branch.


Cheers,
Gustavo

[0] https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg03487.html

Gustavo Romero (5):
  tests/qtest/bios-tables-test: Prepare for changes in the ACPI tables
  tests/qtest/bios-tables-test: Keep ACPI PCI hotplug off
  tests/qtest/bios-tables-test: Update changed ACPI blobs
  tests/qtest/bios-tables-test: Add aarch64 ACPI PCI hotplug test
  qtest/bios-tables-test: Update aarch64/virt 'acpipcihp' variant blob

 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5178 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5264 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 0 -> 5993 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6539 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7635 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5380 bytes
 tests/qtest/bios-tables-test.c                |  42 ++++++++++++++++--
 7 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp

-- 
2.34.1


