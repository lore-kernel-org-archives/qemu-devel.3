Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345EFCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDg7h-0003Bq-Re; Mon, 05 Oct 2026 06:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xDg7G-0002x5-Cc; Mon, 05 Oct 2026 06:40:19 -0400
Received: from vps.sloservers.com ([204.109.61.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xDg7E-0003M9-7c; Mon, 05 Oct 2026 06:40:18 -0400
Received: from thinking.duckdns.org (unknown [192.168.11.4])
 by vps.sloservers.com (Postfix) with ESMTPS id 5831624F55;
 Mon, 05 Oct 2026 10:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sloservers.com;
 s=mail; t=1791196812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TXwLLrvHCZTGu7oXHOiKwRSRlMAaU5YkF7jmhARqmC0=;
 b=SKdnpVGWREpoKr2pL34aiOMP8uomwV1Ve974a2s4byJZORXHSWXuRmA/NrODyXBgyuop2F
 PTeoGK1xKV7ULZ3cst1PzQvbZncoy7jTRk5p/CDJgimQ5M4BjfAP7hGwuMfpHrPnEda+em
 6c9cW2DnvWK/DVZlaP8QQ7vGgQd6FXnNiS4BC9QPSvZxKsl2Tcg9wtMedigFZSRCGSIYUz
 0giEKySzFW7bRjF6P0U+zTA/pP4dVj8wZxbbD8fSyafGxyRC6PPclD0USJIkUbt102J6Dp
 siDhdefMvrIlksYzYpXFLmnjapAdZXVZ8sUWrRqxX2tv6cDTjxDIXL8nOC/03Q==
Received: from ollopa-pc.thinking.duckdns.org (OPNsense.thinking.duckdns.org
 [192.168.1.5])
 by thinking.duckdns.org (Postfix) with ESMTPSA id A4BB1D5B;
 Mon, 05 Oct 2026 03:40:11 -0700 (PDT)
From: Rick Richard <rick@sloservers.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 0/3] hw/riscv/virt: Fix the UART register width in SPCR
Date: Mon,  5 Oct 2026 03:40:05 -0700
Message-ID: <20261005104008.214588-1-rick@sloservers.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.109.61.218; envelope-from=rick@sloservers.com;
 helo=vps.sloservers.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The riscv virt board's SPCR table says its 16550 UART has a 32-bit
register stride, but the registers are actually byte spaced.  Linux
doesn't use this field to work out the register spacing, but FreeBSD's
EFI loader does, and the FreeBSD kernel then crashes on the console
UART when booted through EDK2 with ACPI enabled.

This series fixes the width, plus the usual bios-tables-test patches to
update the golden reference so 'make check' keeps passing.

v2:
- Keep the relative file path in the patch 3 iasl diff (Daniel)
- Add Reviewed-by tags

Thanks,
Rick

Rick Richard (3):
  tests/qtest/bios-tables-test: Allow changes to riscv64 virt SPCR
  hw/riscv/virt-acpi-build: Fix the UART register width in SPCR
  tests/qtest/bios-tables-test: Update riscv64 virt SPCR golden
    reference

 hw/riscv/virt-acpi-build.c        |   2 +-
 tests/data/acpi/riscv64/virt/SPCR | Bin 90 -> 90 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


