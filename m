Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421A2CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9qjJ-000618-Jp; Fri, 17 Oct 2025 16:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjI-000607-5a
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:12 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjG-0005Ne-Fw
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DBFE261F90;
 Fri, 17 Oct 2025 20:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2DFC4CEE7;
 Fri, 17 Oct 2025 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760731622;
 bh=h2lkyTTcCndFJXuY+nRrzKCqWexGL8T19+0e9wkIPqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ROGiQVriKzBZSv2q7srvb+JK2sJVNuPnEKRLz9bY0Kzp3QvlQAPU/8Sdr0ydwhigw
 UyuNJ9V3OE0XUPQkWux0UqasljmrF519EEJJYBIslPSnV3YJ9ga1qDvAk6fQSLKu6V
 mwWdK6eQLerENbKCA+0uXQJSpTLZtiADygGl/sVE6IP3cshrhpoQI4j4UNL4YqpOdO
 ZgCBZnaxRcZRG8eKLoe7YPjAdNQwgr8l8vDa8J5aJVrnoXcNGMsL65uJ6+mzIzDpoX
 e+6eyj+6dy0phNP98zzIB3NzdnaI+pLqFIRgwt+jpECv/Pb29NavyADiEV+8V4CwJS
 0WJRhn+MFI/og==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 03/10] lasi: Forward LASI SCSI ports to NCR 53c710 driver
Date: Fri, 17 Oct 2025 22:06:46 +0200
Message-ID: <20251017200653.23337-4-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017200653.23337-1-deller@kernel.org>
References: <20251017200653.23337-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/misc/lasi.c         | 6 +++++-
 include/hw/misc/lasi.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index 9f758c6a86..6684f16fd7 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -43,7 +43,7 @@ static bool lasi_chip_mem_valid(void *opaque, hwaddr addr,
     case LASI_LAN + 12: /* LASI LAN MAC */
     case LASI_RTC:
     case LASI_FDC:
-
+    case LASI_SCSI ... LASI_SCSI + 0xFF:
     case LASI_PCR ... LASI_AMR:
         ret = true;
     }
@@ -84,6 +84,7 @@ static MemTxResult lasi_chip_read_with_attrs(void *opaque, hwaddr addr,
     case LASI_LAN:
     case LASI_LAN + 12:
     case LASI_FDC:
+    case LASI_SCSI ... LASI_SCSI + 0xFF:
         val = 0;
         break;
     case LASI_RTC:
@@ -156,6 +157,9 @@ static MemTxResult lasi_chip_write_with_attrs(void *opaque, hwaddr addr,
     case LASI_UART:
         /* XXX: reset serial port */
         break;
+    case LASI_SCSI ... LASI_SCSI + 0xFF:
+        /* XXX: reset SCSI Controller */
+        break;
     case LASI_LAN:
         /* XXX: reset LAN card */
         break;
diff --git a/include/hw/misc/lasi.h b/include/hw/misc/lasi.h
index 0bdfb11b50..04312d0b58 100644
--- a/include/hw/misc/lasi.h
+++ b/include/hw/misc/lasi.h
@@ -28,7 +28,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
 #define LASI_LPT        0x02000
 #define LASI_AUDIO      0x04000
 #define LASI_UART       0x05000
+#define LASI_SCSI       0x06000
 #define LASI_LAN        0x07000
+#define LASI_PS2        0x08000
 #define LASI_RTC        0x09000
 #define LASI_FDC        0x0A000
 
-- 
2.51.0


