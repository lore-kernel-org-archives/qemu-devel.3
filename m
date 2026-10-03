Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E722DCA5FED
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 16:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD2MS-0006Jc-SS; Sat, 03 Oct 2026 12:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xD2MC-0006F4-G4; Sat, 03 Oct 2026 12:13:06 -0400
Received: from vps.sloservers.com ([204.109.61.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xD2M8-0005nM-Sj; Sat, 03 Oct 2026 12:13:03 -0400
Received: from thinking.duckdns.org (unknown [192.168.11.4])
 by vps.sloservers.com (Postfix) with ESMTPS id 3C8E9242D3;
 Sat, 03 Oct 2026 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sloservers.com;
 s=mail; t=1791043976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ZlUUH4WeAMcI9SQiMw9Q3Na0n6K13nr3POIbw8X16I=;
 b=VU3SeiYtJljvt5nzdaon7lxwBbkR97QEfvrW4qmVry8//9Uf6uXoT+PIDFdBR0XQHISX1G
 7DrHbSWHLzc1VtUiU3c4HuOHLwlu7Uv5N7jasGnJMn9kOmF3U4eUAJtfXSyhd+RH2Ls+7a
 BgZgm8ngdsn/a5OBksclaJ9mMPIoFfXuhPfV84sCf91j8idtnnWdVmMcXuvgTkC9hGTB0v
 XQ1MCFYKVPDRQZJujAA1wyVjf4GuRO6MM5uiItPZoxhlXBLNX+VzBcgcGfZhfndIPaRp6Y
 /nvqaNexDCaGK6BuVuZMoJxjaov+4Pex9OKNb4B9r7t3r9R8tGUA83vM4g8zYA==
Received: from ollopa-pc.thinking.duckdns.org (OPNsense.thinking.duckdns.org
 [192.168.1.5])
 by thinking.duckdns.org (Postfix) with ESMTPSA id A3878F38;
 Sat, 03 Oct 2026 09:12:55 -0700 (PDT)
From: Rick Richard <rick@sloservers.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Subject: [PATCH 2/3] hw/riscv/virt-acpi-build: Fix the UART register width in
 SPCR
Date: Sat,  3 Oct 2026 09:12:47 -0700
Message-ID: <20261003161248.38903-3-rick@sloservers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003161248.38903-1-rick@sloservers.com>
References: <20261003161248.38903-1-rick@sloservers.com>
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

The riscv virt board uses a 16550 UART with an 8-bit register stride,
but the SPCR table reports 32, which looks to have been copied from
arm virt, whose PL011 has a 32-bit stride.  Change it to the correct
stride for a 16550.

Fixes: 3e6f1e61b4 ("hw/riscv/virt-acpi-build.c: Generate SPCR table")
Signed-off-by: Rick Richard <rick@sloservers.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 8e516ec1..0475dcb5 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -246,7 +246,7 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
     AcpiSpcrData serial = {
         .interface_type = 0x12,       /* 16550 compatible */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
-        .base_addr.width = 32,
+        .base_addr.width = 8,
         .base_addr.offset = 0,
         .base_addr.size = 1,
         .base_addr.addr = s->memmap[VIRT_UART0].base,
-- 
2.43.0


