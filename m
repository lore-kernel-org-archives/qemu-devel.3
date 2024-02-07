Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B02C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmXJ-0004ji-OP; Wed, 07 Feb 2024 13:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXI-0004ie-2i
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:40 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXG-0008AI-IJ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A793761999;
 Wed,  7 Feb 2024 18:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87727C433C7;
 Wed,  7 Feb 2024 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707330037;
 bh=vqjS4Tn8JsTETJjKAhscWBmZAWUWeDAIiHK9Uvc1mpY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IL+jR9Qq+myOvvZsQ/8Ie4IfEkzVD8SUY90tNqIFBRM2CKeVD1L7hxDl7soKlQBzd
 LDMY1Mgd79jrWIkmzMgOsHEn45E0lrQGEdZX3kCBrMbcnsJTFT5SRNMoGqn3Tb0zpi
 bbex5SiAnuJk0qfHu2iT8y5IywAo1Hzzuk26+yK8r3z7SgQ+5zh3xNTHkznnzETPyR
 4/7Npbb+dvBARGEQR07CTulXysSvT/0jQ53wlldMgsNBOPB6OqwUGJqOs5acy2uxwp
 9IqomqZHxKkcUVY4Lcv2IQjfcQu1FvBshN7YHIsrgt62xtTXfS+x6kA+g22V1VLkz6
 hK7ABblut0ydg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 08/13] lasi: Add reset I/O ports for LASI audio and FDC
Date: Wed,  7 Feb 2024 19:20:18 +0100
Message-ID: <20240207182023.36316-9-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207182023.36316-1-deller@kernel.org>
References: <20240207182023.36316-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

Linux writes zeroes at bootup into the default ports for LASI audio and
LASI floppy controller to reset those devices.  Allow writing to those
registers to avoid HPMCs.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/misc/lasi.c         | 11 +++++++++++
 include/hw/misc/lasi.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index 9cfa5bb316..970fc98b5c 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -36,10 +36,13 @@ static bool lasi_chip_mem_valid(void *opaque, hwaddr addr,
     case LASI_IAR:
 
     case LASI_LPT:
+    case LASI_AUDIO:
+    case LASI_AUDIO + 4:
     case LASI_UART:
     case LASI_LAN:
     case LASI_LAN + 12: /* LASI LAN MAC */
     case LASI_RTC:
+    case LASI_FDC:
 
     case LASI_PCR ... LASI_AMR:
         ret = true;
@@ -80,6 +83,7 @@ static MemTxResult lasi_chip_read_with_attrs(void *opaque, hwaddr addr,
     case LASI_UART:
     case LASI_LAN:
     case LASI_LAN + 12:
+    case LASI_FDC:
         val = 0;
         break;
     case LASI_RTC:
@@ -145,12 +149,19 @@ static MemTxResult lasi_chip_write_with_attrs(void *opaque, hwaddr addr,
     case LASI_LPT:
         /* XXX: reset parallel port */
         break;
+    case LASI_AUDIO:
+    case LASI_AUDIO + 4:
+        /* XXX: reset audio port */
+        break;
     case LASI_UART:
         /* XXX: reset serial port */
         break;
     case LASI_LAN:
         /* XXX: reset LAN card */
         break;
+    case LASI_FDC:
+        /* XXX: reset Floppy controller */
+        break;
     case LASI_RTC:
         s->rtc_ref = val - time(NULL);
         break;
diff --git a/include/hw/misc/lasi.h b/include/hw/misc/lasi.h
index 0a8c7352be..f01c0f680a 100644
--- a/include/hw/misc/lasi.h
+++ b/include/hw/misc/lasi.h
@@ -26,9 +26,11 @@ OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
 #define LASI_IAR        0x10
 
 #define LASI_LPT        0x02000
+#define LASI_AUDIO      0x04000
 #define LASI_UART       0x05000
 #define LASI_LAN        0x07000
 #define LASI_RTC        0x09000
+#define LASI_FDC        0x0A000
 
 #define LASI_PCR        0x0C000 /* LASI Power Control register */
 #define LASI_ERRLOG     0x0C004 /* LASI Error Logging register */
-- 
2.43.0


