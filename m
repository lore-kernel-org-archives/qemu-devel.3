Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224D6CCF2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB4r-0004D6-4D; Sat, 17 Oct 2026 16:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB37-0002yV-CJ; Sat, 17 Oct 2026 16:30:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB35-0004No-Gl; Sat, 17 Oct 2026 16:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268865; bh=1H9UvdKFQ1LlgD4r2/lAWiiBPAGHHtfueMIQAT2Nk2E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ScO1i+Zj65pTovx7RqFctienyZJia74jm3IeQu38Y7y25NWLiSi00LcVLlCiWaTxU
 jGfcM8n/KBE/AVUG6FDX1a+oItasMUnDWb8euHifS5XibkVCNFFXZa5i9F6x+jd3Rr
 RPaQms7WcQwWnu4Tq0HOiYGY+9suCHtXyXTCTZ7K1VwrB1EdCjDM6Thi2btqQKDUlN
 HoprVeUDVUFBSCARgSlLePpvFRceVkarHoAK6Ns8rN1FSKsEfrQ8cOxhvWgC3d0NmE
 tghLpYjulNQB/oBoX3MKgNjWMh+vqQX/620rP9GyidPnFDW4T/P+69DMRIqXy1WlwH
 +nd1KTkjh5a3g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4914A1DE765;
 Sat, 17 Oct 2026 23:27:45 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8C286443439;
 Sat, 17 Oct 2026 23:27:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tommaso Califano <tcalifan@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 39/73] hw/usb: Fix USB MTP Use-After-Free in
 usb_mtp_deletefn List Iteration
Date: Sat, 17 Oct 2026 23:25:57 +0300
Message-ID: <20261017202638.728621-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

From: Tommaso Califano <tcalifan@redhat.com>

In QEMU's USB MTP (Media Transfer Protocol) device emulation, the usb_mtp_deletefn()
function in hw/usb/dev-mtp.c iterates over a child object list using QLIST_FOREACH
while the recursive call may free the current element. After the free, the macro reads
the le_next field from freed memory to advance the iterator.

Replace QLIST_FOREACH with QLIST_FOREACH_SAFE, which saves the next pointer before the
iteration body executes.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3991
Signed-off-by: Tommaso Califano <tcalifan@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit d198957674b3c2cf8b9437ba91304cc421b219bb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1d8cfd32dc..c2d36a73cf 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1152,7 +1152,7 @@ enum {
 
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
-    MTPObject *iter, *iter2;
+    MTPObject *iter, *iter2, *iter2_next;
     int ret = 0;
 
     /*
@@ -1161,7 +1161,7 @@ static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 
     QLIST_FOREACH(iter, &o->children, list) {
         if (iter->format == FMT_ASSOCIATION) {
-            QLIST_FOREACH(iter2, &iter->children, list) {
+            QLIST_FOREACH_SAFE(iter2, &iter->children, list, iter2_next) {
                 ret |= usb_mtp_deletefn(s, iter2, trans);
             }
         }
-- 
2.47.3


