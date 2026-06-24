Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22CCCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNkZ-0000O6-GM; Wed, 24 Jun 2026 09:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNkU-0000Ai-RI; Wed, 24 Jun 2026 09:34:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNkT-0000Xn-AE; Wed, 24 Jun 2026 09:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307996; bh=OwdSBD4V2b4+B8glKB7Gyvjax4SKaYALuDPpDERSKxU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=w+VQdKdCqlAb6XwFQqNuSrhNTHYoPbPitSCXVb5G4RHKAJSiEJL0d7PdY9jdTMkfe
 iENEYpbPVy1sof4g6KHUp0mU/t9JL/i6uxmXuFjjZlh16Dg7U3pHjgv4sWDYbbl/KV
 bQqVEDcSa8dJM4jCjpo+4tiC8mlMs+FFc52+Zryf2iG2SEpcVDWF5ufjeOhSOZIKgk
 WVQ+ooVXtC7Pm6RzJrWJPVCW2rfqueYN5rf4IqhXfe2wAseCTqRfx7BDIPo20PAsRO
 9dzVRY7ShFjTZ/IX90JnuvdxidkN9+8GFUAWMDb9lJD87/ypZVyLoXcVMgerKn16n5
 YsP8tPFGu9ReQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 841E41BA9C6;
 Wed, 24 Jun 2026 16:33:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1F6E33DEA15;
 Wed, 24 Jun 2026 16:33:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 boy juju <agx1657748706@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 020/107] ui/vnc: fix OOB read updating VNC update
 frequency stats
Date: Wed, 24 Jun 2026 16:30:25 +0300
Message-ID: <20260624133301.403266-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

Incorrect loop bounds in vnc_update_freq result in iterating past the
last row and past the last column in the VNC stats array. With suitably
chosen dimensions this could be a OOB read that accesses memory beyond
the VncDisplay struct that the stats array is embedded in.

Should this hit a guard page, it could trigger a guest crash. If it
does not, then the VNC frequency stats will be updated with garbage.

Fixes: CVE-2026-48003
Reported-by: boy juju <agx1657748706@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260521103353.1645561-5-berrange@redhat.com>
(cherry picked from commit d0c7b82d3a89dd9c863f8aa69b07360c648ca9fb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index 8ab44c830c..1b5fc8117a 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3105,12 +3105,14 @@ double vnc_update_freq(VncState *vs, int x, int y, int w, int h)
     int i, j;
     double total = 0;
     int num = 0;
+    int x_end = x + w;
+    int y_end = y + h;
 
     x =  QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
     y =  QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
 
-    for (j = y; j <= y + h; j += VNC_STAT_RECT) {
-        for (i = x; i <= x + w; i += VNC_STAT_RECT) {
+    for (j = y; j < y_end; j += VNC_STAT_RECT) {
+        for (i = x; i < x_end; i += VNC_STAT_RECT) {
             total += vnc_stat_rect(vs->vd, i, j)->freq;
             num++;
         }
-- 
2.47.3


