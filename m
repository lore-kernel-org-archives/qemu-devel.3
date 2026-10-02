Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE840CA5FE6
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 21:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCl9B-0001Ks-0b; Fri, 02 Oct 2026 17:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xCl9A-0001Ki-3K
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 17:50:28 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xCl98-0006Se-KF
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 17:50:27 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F412D60D82;
 Fri,  2 Oct 2026 21:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E8C1F000FF;
 Fri,  2 Oct 2026 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790977825;
 bh=7ty486zj2cWF0dMkg/hdGOsjUhARo1TtCR6KVaW+2ck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WvoEG/WiZTT8n4sDm46JloDGPpI9PQlL3EXOFEGSpJhfng0TE4xFul7KGfug2cASk
 /x4l0Wq/bP3LIEkmqwi7chwWVBvQkx1OcShi5JwjhqCMCANAb+qKYbDHT+YFz9lxXG
 l3Q/MTwx6fgvm32hdtUvNXxIbl1ofiwLau5vLKYqwZLgE2I2vMk4seLCkyAtocNiaa
 /x8N2ehen81msXqsJK4srjeEnuPIMMOGMIkyEsLH+EJfztPgUdoYiKDc8NGcmL068N
 qsnKqgVJvfwzwaHfjSLCp9ZRdTO9UZzBrSE77aHuIsCwb5S+5Mouvov115A0g+maVb
 6tozNYVnZR4Cw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Craig Lalley <mr_lalley@yahoo.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 4/4] hw/hppa: Place the CPU at HPA 0xfffa0000 and fw_cfg at
 0xfffb0000
Date: Fri,  2 Oct 2026 23:50:14 +0200
Message-ID: <20261002215014.45371-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002215014.45371-1-deller@kernel.org>
References: <20261002215014.45371-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Craig Lalley <mr_lalley@yahoo.com>

On real Astro based machines (C3700, A400, A500) the first CPU is at
HPA 0xfffa0000.  QEMU puts it one page higher at 0xfffb0000 and uses
0xfffa0000 for the fw_cfg interface, which does not exist on real
hardware.  Swap both, so that the OS sees the CPU at its real address.

Please note:

- CPU_HPA is shared with the 32-bit machines, so the CPU of the B160L
  and the 715 moves as well.  On the B160L this also changes the CPU
  module number, which the firmware derives from the HPA, from 48 to
  32.  The real B160L has its CPU at 0xfff10000, so neither value is
  the real one there.

- MIN_SEABIOS_HPPA_VERSION is raised to 26. Starting with this version
  the firmware is able to cope with any CPU_HPA address which is
  provided by QEMU.

Signed-off-by: Craig Lalley <mr_lalley@yahoo.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/hppa_hardware.h | 4 ++--
 hw/hppa/machine.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index 615b422865..c7ac6bdb85 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -24,7 +24,7 @@
 #define LASI_HPA        0xffd00000
 #define LASI_GFX_HPA    0xf8000000
 #define ARTIST_FB_ADDR  0xf9000000
-#define CPU_HPA         0xfffb0000
+#define CPU_HPA         0xfffa0000      /* as on real Astro based machines */
 #define MEMORY_HPA      0xfffff000
 
 #define IDE_HPA         0xf9000000      /* Boot disc controller */
@@ -48,7 +48,7 @@
 #define PORT_PCI_CMD    hppa_port_pci_cmd
 #define PORT_PCI_DATA   hppa_port_pci_data
 
-#define FW_CFG_IO_BASE  0xfffa0000
+#define FW_CFG_IO_BASE  0xfffb0000
 
 #define PORT_SERIAL1    (LASI_UART_HPA + 0x800)
 #define PORT_SERIAL2    (DINO_UART_HPA + 0x800)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index fb3ef25f04..0b0a8047ed 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -48,7 +48,7 @@ struct HppaMachineState {
     uint64_t memsplit_addr;
 };
 
-#define MIN_SEABIOS_HPPA_VERSION 22 /* require at least this fw version */
+#define MIN_SEABIOS_HPPA_VERSION 26 /* require at least this fw version */
 
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
 static hwaddr soft_power_reg;
-- 
2.54.0


