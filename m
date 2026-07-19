Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A406C44512
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 11:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlPlB-0003DA-1Y; Sun, 19 Jul 2026 07:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlPl1-00039W-BM
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 07:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlPky-0000SR-VQ
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 07:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784460743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=foDmuaLNrGS5blCFGzx/2dpVZJJu2TMgBli21/4ii+A=;
 b=bRe/UrPdXTqWM4xa0y0PL5UwFcYV0fu3Joxo0IFzRae5uFSZbsCkQpTPExDPgXX+qZ/daV
 DQScun0TdsaoNVRwP9HmZiP1vTogVJ+hFiBDhb4o8DpBphoFXpRLt45okPk44hDO0lu9Iy
 LZNITqY5oj0E7l8AxAj6e1L5IC0GNQ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-N_YJxBV8PIiWZzPqT23EXg-1; Sun,
 19 Jul 2026 07:32:22 -0400
X-MC-Unique: N_YJxBV8PIiWZzPqT23EXg-1
X-Mimecast-MFC-AGG-ID: N_YJxBV8PIiWZzPqT23EXg_1784460741
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 392901955F7E; Sun, 19 Jul 2026 11:32:21 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2730F1955F6D; Sun, 19 Jul 2026 11:32:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] replay: fix use of uninitialized pointer on error
Date: Sun, 19 Jul 2026 15:32:16 +0400
Message-ID: <20260719113216.1177594-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
---
 replay/replay-debugging.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

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
2.55.0


