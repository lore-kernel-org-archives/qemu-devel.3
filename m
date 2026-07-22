Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EB5C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWP8-0004yU-QX; Wed, 22 Jul 2026 08:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNy-00041h-R7; Wed, 22 Jul 2026 08:49:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNv-0001um-Ci; Wed, 22 Jul 2026 08:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=+vm56tPTTeZVe1mo75AWDitko8RK/ZCBqWZJOR8e0Nc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BR8UWXKVxy4b2q7caOZUatTg2lZNgazHsrMlYrJM7myYiMvjDCsK2LRoW1JI15cnM
 rkLaJSrWz64LfPAilNpj/nW14XrtFRCkxYbnitPX6nc/kEeYLq3cOW31jZ4i9bXklj
 0TmiSfiP9xVnAdV7V+MLgjK/mA1KxogTTDrNf7vk5DmlQObR0scVsuvsMewGhwxzAc
 +Hna39TeRjjWJUklY+MbfmxSd8B2LIs6xsP4Lv7GpdTQ5dvtD9QrgOXIi0hFA555DK
 YpuCzEo6ALdeC4STRp0VHeHFZlZ61du2LFXOFRV4Wc0HwIcFT44NC/7IA67qDf1DvH
 UDf0qiohkjyMg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C939C1C3B11;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1D4423F376B;
 Wed, 22 Jul 2026 15:46:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7AD3717F0B; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 104/122] ui/vnc: validate SetPixelFormat field
 ranges
Date: Wed, 22 Jul 2026 15:45:53 +0300
Message-ID: <20260722124622.31034-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The VNC SetPixelFormat message carries red/green/blue_max as 16-bit
values, but PixelFormat stores them as uint8_t. A client sending a
max value above 255 (e.g. 0x0100) passes the existing non-zero check
but silently truncates to 0 on assignment, leading to a division by
zero in the Tight PNG palette path.

Add explicit range checks if any channel max exceeds UINT8_MAX.

Fixes: CVE-2026-15578
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3976
Reported-by: dong ling
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 6075444c5a72ab531295d92050d95cebea8a8119)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index b42e0973101..8be69754e0e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2308,6 +2308,11 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
         return;
     }
 
+    if (red_max > UINT8_MAX || green_max > UINT8_MAX || blue_max > UINT8_MAX) {
+        vnc_client_error(vs);
+        return;
+    }
+
     if (red_shift >= bits_per_pixel || red_shift >= 32 ||
         green_shift >= bits_per_pixel || green_shift >= 32 ||
         blue_shift >= bits_per_pixel || blue_shift >= 32) {
-- 
2.47.3


