Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5162D42B82
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 13:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArQR-0006Kd-6f; Tue, 12 Nov 2024 08:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tArQP-0006KG-QG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:59:21 -0500
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tArQO-00041W-3g
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:59:21 -0500
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8323b555a6aso310371339f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 05:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419958; x=1732024758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DtbbIOccD3ypn8aFqTUyq79fII/Aidcsb4TcLjK5hMY=;
 b=GccXvGNhpqq/VHYOQUBtyp0TC2r4rKVdJ1mhQGm+IzFM0jBo/6XZpS6eG6q41cXByp
 SOfvoFbaBK2k3IiLI+X/AP3f8Eo57EBke82gpOfByM9PMze5KlyDwi4AGTpqL8z93Q4X
 fRX/VrcpeqVRuba8pn8NTzWaiL5Itma6LGTMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419958; x=1732024758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DtbbIOccD3ypn8aFqTUyq79fII/Aidcsb4TcLjK5hMY=;
 b=MERBE6ydVUwMy9kH8GMtj5KoM6+iAw2Wq3SilNFkQ2z50eqwfr5HvxmPHjiKfONkZa
 7eXRVi6Zvg7qx5/JuvLwAWj9EH/gGgFUKqokxU7e5n+ezp9WTQ51n+k2F5yI4KXM6FwR
 XJFkX0ru7eOKj28njqccRO1fPOCT8V2vRIBDMfX9VmeqwRShmASAgi6VXhEI3CMhZABn
 4qpQ7sJWUj/jXLuAN3vp8An3SOIVpNyY5txzx4hz/fnO+W6ebJS7+h00AkP2b7ATxdDV
 zBY2xDJSq8ol1CVnIdDpsBdKzyiypFOPV0AtN392KoiIWMz1u8bhbCRcWDXhJid5aEcm
 UBtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6ezRV32EFYsGZuQaOa4K7JxDKmlcq+yM2t4ZWHmadViIU6LUlyarqrJGP92LMAaN0Lv8/nVIWpSN4@nongnu.org
X-Gm-Message-State: AOJu0YwDHHwsi+vWgPzSIk0h/z7aOn0j37nwKyNT+5h0tpih7kq3/TMb
 vN8YDkSWifDeG4+ADrPJush176cA5ef4FSdy7mX/ewTpKhFS3+d9La0+FeosnQ==
X-Google-Smtp-Source: AGHT+IHgOnnp4pNiA/5SFn1eOzk3Qyljr5fR2216TrKppaea3I8TFWkRKb0DCjzu1qnp+gSKHjt49Q==
X-Received: by 2002:a05:6602:2d84:b0:83a:95fc:b242 with SMTP id
 ca18e2360f4ac-83e032fa8c5mr1546439339f.7.1731419958358; 
 Tue, 12 Nov 2024 05:59:18 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 00/18] x86: Improve operation under QEMU
Date: Tue, 12 Nov 2024 06:58:53 -0700
Message-Id: <20241112135911.630586-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd35.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
is not perfect.

With both builds, executing the VESA ROM causes an intermittent hang, at
least on some AMD CPUs.

With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
is done in a way that works on real hardware but not with QEMU. This
means that performance is 4-5x slower than it could be, at least on my
CPU.

We can work around the first problem by using Bochs, which is anyway a
better choice than VESA for QEMU. But this results in the Ubuntu
installer failing to boot via EFI. It isn't clear whether this due to
a problem with the UEFI GOP, or something else. It hangs before the
Ubuntu logo appears.

So this series is unfinished. I thought it best to post what is here in
the hope that others can help work out the kinks.


Simon Glass (18):
  scripts: Add a script for building and booting QEMU
  x86: Expand x86_64 early memory
  RFC: x86: qemu: Switch to bochs display
  x86: qemu: Enable dhrystone
  x86: qemu: Avoid accessing BSS too early
  x86: Drop mpspec from the SPL build
  x86: Add some log categories
  x86: Drop use of CONFIG_REALMODE_DEBUG
  x86: Avoid clearing the VESA display
  x86: Add 64-bit entries to the GDT
  x86: Use defines for the cache flags
  x86: spl: Drop duplicate CPU init
  x86: Drop the message about features missing in 64-bit
  x86: Include stdbool.h in interrupt header
  x86: Tidy up the GDT size in start/16.S
  x86: Disable paging before changing to long mode
  x86: Use the same GDT when jumping to long mode
  x86: Use a simple jump into long mode

 MAINTAINERS                      |   8 ++
 arch/x86/cpu/i386/call64.S       |  35 +++----
 arch/x86/cpu/i386/cpu.c          |  18 +++-
 arch/x86/cpu/qemu/qemu.c         |  20 ++--
 arch/x86/cpu/start.S             |   4 +-
 arch/x86/cpu/start16.S           |   3 +-
 arch/x86/include/asm/interrupt.h |   1 +
 arch/x86/include/asm/processor.h |   5 +-
 arch/x86/lib/Makefile            |   2 +
 arch/x86/lib/bios.c              |  27 +++--
 arch/x86/lib/bios_interrupts.c   |   8 +-
 arch/x86/lib/i8259.c             |   2 +
 arch/x86/lib/spl.c               |   4 +-
 configs/qemu-x86_64_defconfig    |  10 +-
 configs/qemu-x86_defconfig       |   6 +-
 doc/board/emulation/index.rst    |   1 +
 doc/board/emulation/script.rst   |  61 +++++++++++
 scripts/build-qemu.sh            | 175 +++++++++++++++++++++++++++++++
 18 files changed, 331 insertions(+), 59 deletions(-)
 create mode 100644 doc/board/emulation/script.rst
 create mode 100755 scripts/build-qemu.sh

-- 
2.34.1


