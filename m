Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D77CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 21:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDUab-0002Zf-Ax; Mon, 27 Oct 2025 17:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZx-0002Up-Ul
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:48 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZr-00050Y-FQ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:37 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A264D48C42;
 Mon, 27 Oct 2025 21:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BF2C4CEF1;
 Mon, 27 Oct 2025 21:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761599781;
 bh=xFlzV8vrus0MSYUZSP7M+xz2pgWJO+cv9CnznTXzwKI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hc3lyDXU0IIrCXgErqQv79ze7SRRmmwlX+71EX23gc913Mp39OsamYatZNhzi80cG
 OZ/wUc//XDsITtsW+tAiHl9ijTujnO3wLX8Q2E7wxg/TslL5UfgfzViTWJtDBEQYdw
 ua9LOwR2SH4pFy2cTlF84/LcyvUBwk4WtgQp6P/ukWlYP5sRps4WOHF+xtCIAhJ7mW
 ezd8Vil2w8aJesxAbPjWEmuPEl/x1kuGhNivDme8wvfnYOpqP/FBLB/S96t24+fRbc
 5qv5Iz0j7HtrX+WpWBNITnJNXs40avYiAbpb6GOGSeo03xb/JTacq7DMRDtpwE/H1Y
 54gPK2cChWfBw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de
Subject: [PULL 06/11] hw/hppa: Fix firmware end address for LASI chip
Date: Mon, 27 Oct 2025 22:15:58 +0100
Message-ID: <20251027211603.7141-7-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027211603.7141-1-deller@kernel.org>
References: <20251027211603.7141-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The base address of a LASI chip on a 715 machine starts at HPA
0xf0100000.  Make sure that the firmware does not extend beyond that
address, otherwise it's not possible to access the LASI ports.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/hppa_hardware.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index 21c777cba6..d422af0429 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -5,7 +5,7 @@
 #define HW_HPPA_HPPA_HARDWARE_H
 
 #define FIRMWARE_START  0xf0000000
-#define FIRMWARE_END    0xf0800000
+#define FIRMWARE_END    0xf0100000
 #define FIRMWARE_HIGH   0xfffffff0  /* upper 32-bits of 64-bit firmware address */
 
 #define RAM_MAP_HIGH  0x0100000000  /* memory above 3.75 GB is mapped here */
@@ -19,6 +19,7 @@
 #define DINO_UART_HPA   0xfff83000
 #define  DINO_UART_BASE 0xfff83800
 #define DINO_SCSI_HPA   0xfff8c000
+#define LASI_HPA_715    0xf0100000
 #define LASI_HPA        0xffd00000
 #define LASI_UART_HPA   0xffd05000
 #define LASI_SCSI_HPA   0xffd06000
-- 
2.51.0


