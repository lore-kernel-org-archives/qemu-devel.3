Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AA9CCF9F0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 21:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDUaB-0002Wo-5R; Mon, 27 Oct 2025 17:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZo-0002UT-TG
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:32 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZh-0004zV-87
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:28 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4ED8448C40;
 Mon, 27 Oct 2025 21:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ECDC4CEF1;
 Mon, 27 Oct 2025 21:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761599777;
 bh=+n3EC2b+2pzw2xJr++fp9IMDP9fAGUWHMzqA1sJSZYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Op2o7ir1/PauauM570ITNATGF4dzn1GUSdim/TnhDLQ7dazPVqeBTix4ECbP1oaoD
 OsgUznUVXm3Vc/4eRDmdnHp/lX/Vi5fJPqH8Ya9M3Ds3akoFJplKIcGn+LXAdkPeLb
 pL1PBtIo4mOErv4NeUk1S1nHmIYv3sHXD7sXXykkIMvFp4Ti7d72ZxCjGgUuDs6fBb
 /mAXEKRlYtWX2x5qY4b1PS2NQqElCVz2AE55TkFOAIkyOHuaselmhsSmDGskEafgE0
 VoYXREEzfplAjXkPyqkmk4x6YRuNa5sbgOvfTAvcUVZm0eI1X925F0tpy8UXOFyuDQ
 kNk/84IKu0qqg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de
Subject: [PULL 04/11] lasi: Forward LASI SCSI ports to NCR 53c710 driver
Date: Mon, 27 Oct 2025 22:15:56 +0100
Message-ID: <20251027211603.7141-5-deller@kernel.org>
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
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


