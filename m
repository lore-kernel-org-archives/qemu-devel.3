Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F7DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEi5-0008UM-49; Mon, 13 Jul 2026 07:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEi0-0008LU-DK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:25 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEhw-00080G-Bt
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=EMqHzDt
 6SN2mBDMCJBiCZoDfm7uM6Bfg7T7QrYRF/VwcuTIJjB4GSSym2AMYnPObJoiPch0gT2Wa6
 aQhBRfHl+7Uc1NzXNP5aiqnTIVbjT2Hp9t9CLf7v5pYCUZyQ68DP++AAG+gWJGg0n/KB2P
 19Cv+dfYKYlFh6ZTBvld7WzbFyTA2qjVa8VTQIXoKITUlozyII9oaKEIxmAtbD1uLQAjzM
 eI/D13Z9q+fTzvvjj9RKFuqMXlt1t4txLyT7nJMLAvIh5vptxY9xN4lsHwdwLepSlM5+F+
 RvnMJoy/JzWwj0frI2bwBe8Bz/fUuQXGggH5CQU5eThdJd9Run3WTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=q
 KY12AVVACR8FROy6z+IWjSpbK411CZ9AEBo7Y5Yfr0=;
 h=date:subject:to:from:
 dkim-signature:dkim-signature; d=mx.catap.net; b=NmK6UBOAPhbDw7Tm2E+Uy
 yB9mznZDBRsFLFlJ8+UzItbHf8Jed3j1QzCzbva9LwIjjvyyvDDFoYc81P5D/5RnnbjJW5
 Q+sMtnywwMi0rrl4OdjKg5D//lcrBs/CFKpJ0jdmcQzl/4GpXz6cDWmuLBxe2GgDR8xVag
 ITu91dgoVD4/3cnh2XP11VfV1bYYlX5oBpI+lgkUCzJCizACPlN5DeNtQ0boha4fDEoOPx
 8kZGAOyjDayggDwz7YcUhdUXT4HRdpeOhTx2vVtTxavQHxLbzWwtHqHpapMrRuDxBcVydO
 g9HEqsXlXeU/jSZgsuKSKxaNNO32SN39Wxr8oaKdA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=kLlQWiMT; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=LUyDFJqW;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=qKY12AVV
 ACR8FROy6z+IWjSpbK411CZ9AEBo7Y5Yfr0=; h=date:subject:to:from; 
 d=korins.ky;
 b=kLlQWiMTRnC7h7kd67di4AvcdYevMaTNVenJAorrLp8nFDjaZ9sZ1Ki
 Y/qR8xuRiyyJS6KFJ04YoXd3jh21CF+U6F7JH1V6iA9aTwJPO5e8iUEV2W+/e+SFUORKcz
 3l0NBTikYsXb1XXl6TrH/ik5ks+HIkfTKIAfIHQiUJSFOjkqF9f2IjOelEypUFwRXrVL6E
 JiwKQO/vx3yskRtCPqriiJuuSkEO0s31jF7daNpfMp2u84/oFQggfAsNCCaKysOtqRkoFy
 UcC0k2SF1K+0n5K7nUMdmnZooKW9kw9yWeZqRiqy/q26tmdaklkcwhVXJwls38r4kkhiMM
 TCRRPhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=qKY12AVVACR8FROy6z+IWjSpbK411CZ9AEBo7Y5Yfr0=; h=date:subject:to:
 from; d=korins.ky; b=LUyDFJqWNxMi5yuaEs9iknnWnGqx+y2ZdGmCsf0FPx03RgZvL
 yAgxf71x/18xBESkbfM3rh7QYyWKb9STCv9CA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id b0b7428d
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) for <qemu-devel@nongnu.org>;
 Mon, 13 Jul 2026 13:20:15 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id bf2e7184
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:20:13 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/9] hw/mips: add Octeon III EBB7304 support
Date: Mon, 13 Jul 2026 13:16:28 +0200
Message-ID: <20260713112004.4956-1-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds enough Cavium Octeon III CN73xx and EBB7304 board
support to boot a modern U-Boot EBB7304 image and OpenBSD/octeon; the
same machine also boots the U-Boot image from the Ubiquiti EdgeRouter
Infinity ER-8-XG recovery set. The model intentionally covers the
hardware exercised by these firmware and operating system paths.

The vendor recovery image reaches:

    Octeon ubnt_e1000(Failsafe)#

This is the expected command prompt of the recovery U-Boot environment;
"Failsafe" describes the recovery image and does not indicate an
emulation or boot failure.

The board model is based on Amir Mehmood's original Octeon host.patch;
the basic machine approach and several peripheral modelling ideas come
from that work. The implementation targets CN73xx hardware and the boot
paths above.

The prerequisite patches correct xHCI interrupt reassertion, use atomic
access for MIPS CP0 interrupt and timer state under MTTCG, fix MIPS64
segment access checks and tlbwr replacement semantics, then add Octeon
CP0 state, the CN73xx CPU model, PageMask handling, and unaligned
accesses. The final patch adds the EBB7304 board and its functional
test.

The machine currently models:

* the EBB7304 RAM layout, boot flash aliases, and boot-local RAM;
* CN73xx CPUs, Octeon CP0 state, CVMSEG, and configurable clocks;
* legacy CIU and CIU3 interrupt routing, mailboxes, and secondary CPU
  release;
* UART, TWSI and SPD, LMC state, fuses, RNG, POW, and the firmware
  probes required during initialization;
* two DWC3 controllers and a minimal PCIe host suitable for PCI e1000
  and USB storage.

With system U-Boot, the functional test enumerates PCI, obtains a DHCP
lease, downloads bsd.rd through user mode TFTP, and boots the
OpenBSD/octeon 7.9 installer with four CPUs.

The series was tested with:

    ninja -C build qemu-system-mips64
    gmake -C build check-qtest-mips64
    gmake -C build check-functional-mips64

The qtest suite reported 14 passes, 2 empty suite skips, and no
failures. The functional suite reported 7 passes, 2 expected skips,
and no failures; its Octeon case reached the OpenBSD installer prompt.

Before the final rebase, the machine also completed a GCC build inside
OpenBSD/octeon using:

    -m 16G -smp 4 -accel tcg,thread=multi

That workload ran for several days to build gcc-16.1.0 inside.

Known limitations are:

* native Octeon Ethernet and the complete MMC path are not modelled;
  the OpenBSD test uses PCI e1000;
* direct kernel boot through -kernel is not implemented;
* board CSR and interrupt state has no VMState description, therefore
  migration and savevm correctness is not established.

The first patch is a generic xHCI fix required for reliable USB
interrupt delivery on this machine. Patches 2 through 4 contain generic
MIPS fixes; patches 5 through 8 add Octeon target support; patch 9 adds
the EBB7304 machine and functional test.

The series is based ona759542a2c62f0fd3b65f5a66ad9868201014669.

Patch layout:

  1. hw/usb/xhci: reassert pending busy interrupts
  2. target/mips: make CP0 interrupt state atomic
  3. target/mips: fix MIPS64 segment access checks
  4. target/mips: drop hidden TLB shadowing for tlbwr
  5. target/mips: add Octeon CP0 register state
  6. target/mips: add Octeon CN73xx CPU model
  7. target/mips: accept Octeon PageMask encodings
  8. target/mips: allow Octeon unaligned accesses
  9. hw/mips: add Octeon III EBB7304 machine



