Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0067ECCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKAp-0001vm-B5; Mon, 27 Oct 2025 06:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vDKAm-0001uv-JJ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:09:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vDKAg-0003zz-2j
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:09:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-475dd54d7cdso5669645e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1761559781; x=1762164581;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dSIrBetGG+wfDz8yd4lntslaRbGzk4PwkgYTU3dLOJU=;
 b=Y+qDLrOk1Jxx8YOHzSRzrChaysB/WrrI84ZXCD7CgoMQfABEZtifY0wuH0gqXGwjhU
 RNpOMe9Yur8QEWkbN0tAzrkuFUADJD8AntU+LURSbsGkMESAM9ME2LnjkxFQbf3F4Jjs
 UP0mbCpjObKTnIU0djflufsCP5nxoTFdyeEFSDEsYMhWOtiXsv9nR7qcRyo/AjZ5hmRl
 HDvFclw055IoPLeQQ1S+/9uZmwWaYoj+gjc8lVlLQ2ao/Bmc+ne7Ud1zCm60qjj6VpfU
 s8uPIz8tFf0Ke7ilo4UALWMbEQi3cRuRuFiUGlJZ+i246rnZ9Bp5fcbwl+kjOTQfBibx
 QA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761559781; x=1762164581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dSIrBetGG+wfDz8yd4lntslaRbGzk4PwkgYTU3dLOJU=;
 b=sGqdoIKWqvhu9IkuNUwPDZL4mWNK+2dtGhuM7y+FJuK+SKqt8qJRBEWacZeRjva/hm
 uV7WhkVooVRcME/pGMWTaOJBPA5f6xWcWYX88xMdFin5V30JDq4+l2o8rJtJAE0VBSXZ
 AwyKmEsYYkWaegi+RiMBxlweGtc1BGD+vJJfxLqZ/dYmEeLO9H6FbirO4MNgvAkgFVh6
 6kwBN0aR/PMAXr1kyrCCW+XJVbyOTf3/VvbUG+nrexgqKgGwI8+MY6ve/9T/mJhd1YOA
 0maMruG60SXtF7obXUu+VSY+Uha1O63Nc5wmr1eK1YOqWIFTwc9QUnFr+nv0BNMMWf9m
 xoEg==
X-Gm-Message-State: AOJu0YzmcFqapPoF3Qh6l9iwO/q692zaVoQuhxfdu/ULxC0FFo2TXwzz
 6cucXWpM+3/utZd8kJS19iB9VRYsanAGU9EstHQKKNG9Pd7irQ6Le/r+/AxzA5zkHVqnP/ir2Pa
 akFmV9fQ=
X-Gm-Gg: ASbGncug2oU/F7OOlx7Ck8FC99Dadf81RfwfPolWm5A4/4s6oKf7k0T88SrB03jP1eK
 e15fAgxazHz6EEKa/0bX70GA111knKmcTRfTsLB2qytnzIX/OGkVGU0J0DXRWtk/w07yknd2iWR
 biUTaIOM4d87JqbTlTwRqPgLTqPlAb5zZ/PkKDnWgYxwb/8KdzYl3nQT4Z90g1j1qfyykRwjBLm
 9y+76jPs3VotIMys9EboPLIUU7Rl3Y4he9EdnsXM08y7gFLkv5EAdflWfo+2y4TBJQX8qITRaTg
 75uwqvp46jpbifuiJOlPWhpo2tajiu3IfosdN81p/pfrXjNkWFMZsllxyyOaHDavt7LQaVM39a9
 w2kCrOq2Daf4fgVoJxh3BoLESPo+439ylE9h6cEKyZ79OPvKTUtZtKgIMC9GUnN0t0K80UmEOUj
 A0hETd97SGIVmOJeA=
X-Google-Smtp-Source: AGHT+IFoTLc4HvdxaBdw971nYTQW98A71R4PKctc2laELDqjB5RvIm7nSkWsYkKSn+I8Si+qmzuTHQ==
X-Received: by 2002:a05:600c:528e:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-475dcbb7927mr53656205e9.9.1761559780655; 
 Mon, 27 Oct 2025 03:09:40 -0700 (PDT)
Received: from DDesktop.local ([2a10:8012:d:eea4:f4de:376b:66b1:d7b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd494d5csm128625465e9.9.2025.10.27.03.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 03:09:40 -0700 (PDT)
From: Michael Levit <michael@videogpu.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, smishash@gmail.com
Subject: [PATCH v2 0/5] RISC-V: NEORV32 CPU, devices, and machine
Date: Mon, 27 Oct 2025 12:09:33 +0200
Message-ID: <20251027100938.11822-1-michael@videogpu.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::332;
 envelope-from=michael@videogpu.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Hi all,

This v2 reworks my initial NEORV32 submission into a small, reviewable
series, following feedback to split the changes by subsystem.

The series introduces:
  * a minimal NEORV32 RV32 CPU type and vendor CSR hook,
  * the SYSINFO MMIO block,
  * a small UART device,
  * an SPI controller with command-mode chip-select,
  * and the 'neorv32' RISC-V board wiring the above, plus docs.

Tested by booting the NEORV32 bootloader as -bios and chaining into a
Hello World from an MTD-backed SPI flash image, with UART on stdio.

Changes since v1:
  * Split the monolithic patch into five functional patches, as suggested.
  * Dropped the accidental '.gitignore' hunk.
  * No intentional functional changes; only file organization and clarity.
  * Kept default.mak entry off by default (n).

Patch layout
============
  1/5  target/riscv: add NEORV32 RV32 CPU type and vendor CSR hooks
  2/5  hw/misc: add NEORV32 SYSINFO block (CLK/MISC/SOC/CACHE)
  3/5  hw/char: add NEORV32 UART (CTRL/DATA, fifo, chardev)
  4/5  hw/ssi: add NEORV32 SPI controller (SSI master, CS command)
  5/5  hw/riscv: introduce 'neorv32' board, docs, and riscv32 device config

Quick usage
===========
  $ ./configure --target-list=riscv32-softmmu --enable-debug --enable-fdt
  $ make -j$(nproc)

Prepare a flash image (64MiB) and place your app at 4MiB offset:
  $ dd if=/dev/zero of=$HOME/flash_contents.bin bs=1 count=$((0x04000000))
  $ dd if=/path/to/neorv32_exe.bin of=$HOME/flash_contents.bin \\
       bs=1 seek=$((0x00400000)) conv=notrunc

Run bootloader and chain-load your app:
  $ ./build/qemu-system-riscv32 -nographic -machine neorv32 \\
      -bios /path/to/neorv32/bootloader/neorv32_raw_exe.bin \\
      -drive file=$HOME/flash_contents.bin,if=mtd,format=raw

Debugging:
  $ ... -s -S   # gdbstub on :1234, start paused


Michael Levit (5):
  target/riscv: add NEORV32 RV32 CPU type and vendor CSR hooks
  hw/misc: add NEORV32 SYSINFO block (CLK/MISC/SOC/CACHE)
  hw/char: add NEORV32 UART (CTRL/DATA, fifo, chardev)
  hw/ssi: add NEORV32 SPI controller (SSI master, CS command)
  hw/riscv: introduce 'neorv32' board, docs, and riscv32 device config

Thanks for reviewing!
Michael

-- 
2.20.1

