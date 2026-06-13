Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3450DCD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV7M-0004SO-PK; Sat, 13 Jun 2026 16:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV6y-0004FE-Ty; Sat, 13 Jun 2026 16:37:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV6x-0003TD-Dj; Sat, 13 Jun 2026 16:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382963; bh=ZO2V1hRxjxtkQY97w81DzNP/KhHOgRzafHWy3erJ3rg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dJ/OOzRmDx6HSiScSikd38QCe8xJ6CPv8TpYkVkMYXrfjiQTuDTJR4CzwnzPt1Sab
 7KYWltOS8KTH8t3W9sDmwwIr3qSm2r0mBR3zYC2cSTRks/jOCEfXlNVHyanFJXnJKn
 S+LMQFeCpbLiVuAunAajBEjUFBBRYG21sp64s9ROLIys4GY3bWNpvWyAvjJIBRuuT2
 MFAywvrnGGBaD0vAEZyst+vGihpvA2HJGAECXCslUdDHZITtnMpNEiTMPogi+mOmBR
 iRnpX+2R9PXWyFQwZdI5xqToEDvDd+hn3EiMbdJ8BlLbtBMYgUsBemHVnrtFyclzxS
 59mgruLEaofHw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 789591B6EEC;
 Sat, 13 Jun 2026 23:36:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E05923CE93E;
 Sat, 13 Jun 2026 23:36:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 boy juju <agx1657748706@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 18/72] ui/vnc: fix OOB write in VNC stats array
Date: Sat, 13 Jun 2026 23:34:44 +0300
Message-ID: <20260613203542.1809153-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The VncSurface struct maintains update statistics in an array:

    VncRectStat stats[VNC_STAT_ROWS][VNC_STAT_COLS];

where the dimensions are defined as:

  #define VNC_STAT_RECT  64
  #define VNC_STAT_COLS (VNC_MAX_WIDTH / VNC_STAT_RECT)
  #define VNC_STAT_ROWS (VNC_MAX_HEIGHT / VNC_STAT_RECT)

If VNC_MAX_WIDTH / VNC_MAX_HEIGHT are not an exact multiple of
VNC_STAT_REC, the COLS/ROWS will be undersized by 1.

Unfortunately:

  #define VNC_MAX_HEIGHT 2160

is not a multiple of 64, so there is potential for OOB reads and
writes in the 'stats' array, if the guest surface is over 2112
pixels in height. An array overflow occurs when vnc_update_stats()
records new statistics, either scribbling over data later in the
VncDisplay struct that 'stats' is embedded in, or performing an
OOB write on the allocated struct memory.

Fixes: CVE-2026-48002
Reported-by: boy juju <agx1657748706@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260521103353.1645561-3-berrange@redhat.com>
(cherry picked from commit c3c6226fa48180edf9d4646d4112fb1becbc149b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.h b/ui/vnc.h
index ec8d0c91b5..ad41b418b9 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -92,8 +92,8 @@ typedef void VncSendHextileTile(VncState *vs,
 #define VNC_DIRTY_BPL(x) (sizeof((x)->dirty) / VNC_MAX_HEIGHT * BITS_PER_BYTE)
 
 #define VNC_STAT_RECT  64
-#define VNC_STAT_COLS (VNC_MAX_WIDTH / VNC_STAT_RECT)
-#define VNC_STAT_ROWS (VNC_MAX_HEIGHT / VNC_STAT_RECT)
+#define VNC_STAT_COLS DIV_ROUND_UP(VNC_MAX_WIDTH, VNC_STAT_RECT)
+#define VNC_STAT_ROWS DIV_ROUND_UP(VNC_MAX_HEIGHT, VNC_STAT_RECT)
 
 #define VNC_AUTH_CHALLENGE_SIZE 16
 
-- 
2.47.3


