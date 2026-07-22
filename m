Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F43C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWVe-0005Kc-FS; Wed, 22 Jul 2026 08:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWU4-0001aP-94; Wed, 22 Jul 2026 08:55:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWU2-0003PP-H1; Wed, 22 Jul 2026 08:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=muNAh4RU3UYOtUuju152tRHPb6SeX/QYPbJCxpOiBfA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ReAMMU49Ufxrmp9Zu2bC45jBdn1BFTNuMEraSXdBXA0GOT+4JKgaRU2d9c2EgrOfN
 sd/hPpDcrzGgjX9s2UKh6N79UgPTVSkiGbfb7HzGJcB1sPWM6fCjOjK0ZLvz55xz5n
 PeDi2zY5Qaj8N36qgqtIU27g97ztW991zfLk8T4n90yrK+OvDdft74w2sLlbDlUtT0
 wFY/IxkaEzPzVaFhIMSZo2mJiZnGzbefm1JDeBfyJ6/8tfxkds8yOsPr6iQ65s7uCc
 StmavTvvQrMG4enoQgl1z1eOiFcSYyTkjEW8CWvEk+KXavRL7lkfWzhTJshb0Rn6n0
 oP0XEVzMnNDcQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A7631C3B59;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B36803F37A9;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 03DD517F87; Wed, 22 Jul 2026 15:49:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 124/127] replay: fix use of uninitialized pointer
 on error
Date: Wed, 22 Jul 2026 15:48:49 +0300
Message-ID: <20260722124859.32371-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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

When bdrv_snapshot_list() returns a negative error code, sn_tab is
uninitialized. The loop does not execute (since i=0 < negative is
false), but the code falls through to g_free(sn_tab) which frees
an uninitialized pointer.

Fixes: f6baed3d1485 ("replay: implement replay-seek command")
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260719113216.1177594-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit fe68e4b47bf5a3ff016a8c2b580e05c93df05752)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 11053640021..7b904a14165 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -139,9 +139,8 @@ static char *replay_find_nearest_snapshot(int64_t icount,
                                           int64_t *snapshot_icount)
 {
     BlockDriverState *bs;
-    QEMUSnapshotInfo *sn_tab;
+    g_autofree QEMUSnapshotInfo *sn_tab = NULL;
     QEMUSnapshotInfo *nearest = NULL;
-    char *ret = NULL;
     int rv;
     int nb_sns, i;
 
@@ -149,15 +148,19 @@ static char *replay_find_nearest_snapshot(int64_t icount,
 
     bs = bdrv_all_find_vmstate_bs(NULL, false, NULL, NULL);
     if (!bs) {
-        goto fail;
+        return NULL;
     }
 
     nb_sns = bdrv_snapshot_list(bs, &sn_tab);
+    if (nb_sns < 0) {
+        return NULL;
+    }
 
     for (i = 0; i < nb_sns; i++) {
         rv = bdrv_all_has_snapshot(sn_tab[i].name, false, NULL, NULL);
-        if (rv < 0)
-            goto fail;
+        if (rv < 0) {
+            return NULL;
+        }
         if (rv == 1) {
             if (sn_tab[i].icount != -1ULL
                 && sn_tab[i].icount <= icount
@@ -166,14 +169,12 @@ static char *replay_find_nearest_snapshot(int64_t icount,
             }
         }
     }
-    if (nearest) {
-        ret = g_strdup(nearest->name);
-        *snapshot_icount = nearest->icount;
+    if (!nearest) {
+        return NULL;
     }
-    g_free(sn_tab);
 
-fail:
-    return ret;
+    *snapshot_icount = nearest->icount;
+    return g_strdup(nearest->name);
 }
 
 static void replay_seek(int64_t icount, QEMUTimerCB callback, Error **errp)
-- 
2.47.3


