Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22ABC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWLk-0002Ps-BO; Wed, 22 Jul 2026 08:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLi-0002Ou-Hg; Wed, 22 Jul 2026 08:46:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLg-0001bi-Rm; Wed, 22 Jul 2026 08:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=9JkD38b5vgLEyzfVkI1oRnJJG5068eofwNgJBh2OZsc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BaayMr1/02xDJzkdWoRw23LE754LEYiCXyR1nOiM/22Y5hs70zio3je+Uo4QYH13P
 idJbif8AEG3N7+XZjiwJYtGdtOvvyuNGgkRiVnjzEE3y68eQ+EaUtk7aNFDzd/HHkG
 AyYldaY/yBcaUrQScoh0YyCOOdKV5Qdzov9Txxt3Ty1QRq7n27lzA57fMkgmCw/7Y6
 nroglMDtpi69IdqHquh352f8HOe51/Tueg8QDaYKYStTS2WZVIe6+HW5rfHQNE8oqt
 KBNYtxzUDR91CbOfOH/42znEi/FPLu5DJbr0noXdlsYOAUuGY/t6W8xUHdnmdn3Psv
 XMrLXF/qhrYJA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4D50C1C3AFA;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 92AFD3F3754;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 433A917EDD; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 081/122] hw/display/sm501: Catch bad coordinates
 for RTL operations
Date: Wed, 22 Jul 2026 15:45:30 +0300
Message-ID: <20260722124622.31034-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Peter Maydell <peter.maydell@linaro.org>

The sm501 code doesn't check whether a right-to-left operation has
specified a width greater than the x-coordinate (which would make it
extend off the left edge of the screen), or similarly a height
greater than the y-coordinate.  This means the guest can misprogram
the device so that we underflow when calculating the address of the
top left pixel, which might result in accessing out of bounds
memory.  Catch this as a guest error and ignore the operation.

Reported-by: Yannick Wang
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260707150933.1410507-2-peter.maydell@linaro.org
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3920
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit b378a1bd86b4f25255eada916e34ebd66a3e7437)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 09edcf86f8e..13ccc4941df 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -722,6 +722,10 @@ static void sm501_2d_operation(SM501State *s)
     }
 
     if (rtl) {
+        if (dst_x < (width - 1) || dst_y < (height - 1)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "sm501: RTL op out of bounds\n");
+            return;
+        }
         dst_x -= width - 1;
         dst_y -= height - 1;
     }
@@ -747,6 +751,10 @@ static void sm501_2d_operation(SM501State *s)
         }
 
         if (rtl) {
+            if (src_x < (width - 1) || src_y < (height - 1)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "sm501: RTL op out of bounds\n");
+                return;
+            }
             src_x -= width - 1;
             src_y -= height - 1;
         }
-- 
2.47.3


