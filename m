Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88978C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBbj-0007pa-CW; Fri, 10 Jul 2026 09:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wiBbg-0007pP-RL
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wiBbe-00015P-GJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783691368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EhTR2MjQSarOvx0KROWJm40uQobi38h8qa+ZZ9zIx+U=;
 b=cYlYF6k4JhboBwZytVE3uPHGuBXwcsJrzSyw7Z9qgwo4GJ6VgWJNxx/257KPi5RP8Ya7Yi
 2THquamTI7aMg3rFPz1NMMisFKLh3WHbeeOnZfaT54NJkqZMODbwqzgyjW0ElQ3B1Hv+s1
 GxVw/5rN4QxMOEf4lY58ITCx7otfZ6w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-6-oXu1LlM3aprnXWt-4gjw-1; Fri,
 10 Jul 2026 09:49:27 -0400
X-MC-Unique: 6-oXu1LlM3aprnXWt-4gjw-1
X-Mimecast-MFC-AGG-ID: 6-oXu1LlM3aprnXWt-4gjw_1783691366
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D0531800597
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:49:26 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08C06180029C; Fri, 10 Jul 2026 13:49:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/vnc: fix out-of-bounds write in lossy refresh dirty marking
Date: Fri, 10 Jul 2026 17:49:21 +0400
Message-ID: <20260710134921.2321027-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vnc_refresh_lossy_rect() marks a full VNC_STAT_RECT (64) rows of the
dirty bitmap when refreshing a lossy tile. When the display height is
not a multiple of VNC_STAT_RECT, the last tile row is a partial tile and
the loop writes past the end of vs->dirty[VNC_MAX_HEIGHT].

For example, with a 2160-pixel-high display (VNC_MAX_HEIGHT), the last
stat tile starts at y=2112. The unconditional 64-row loop writes rows
2112..2175, overflowing 16 rows (640 bytes) past the dirty bitmap into
subsequent VncState fields.

Fix by passing the effective display height into
vnc_refresh_lossy_rect() and clamping the inner loop.

Fixes: CVE-2026-61475
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3935
Reported-by: "Vulnerability Report" <vr@darknavy.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index b2b69923b75..dfc8262d42a 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2998,15 +2998,18 @@ void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h)
     }
 }
 
-static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
+static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y,
+                                  int height)
 {
     VncState *vs;
     int sty = y / VNC_STAT_RECT;
     int stx = x / VNC_STAT_RECT;
     int has_dirty = 0;
+    int rows;
 
     y = QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
     x = QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
+    rows = MIN(VNC_STAT_RECT, height - y);
 
     QTAILQ_FOREACH(vs, &vd->clients, next) {
         VncConnection *vc = container_of(vs, VncConnection, vs);
@@ -3022,7 +3025,7 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
         }
 
         vc->worker.lossy_rect[sty][stx] = 0;
-        for (j = 0; j < VNC_STAT_RECT; ++j) {
+        for (j = 0; j < rows; ++j) {
             bitmap_set(vs->dirty[y + j],
                        x / VNC_DIRTY_PIXELS_PER_BIT,
                        VNC_STAT_RECT / VNC_DIRTY_PIXELS_PER_BIT);
@@ -3073,7 +3076,7 @@ static int vnc_update_stats(VncDisplay *vd,  struct timeval * tv)
 
             if (timercmp(&res, &VNC_REFRESH_LOSSY, >)) {
                 rect->freq = 0;
-                has_dirty += vnc_refresh_lossy_rect(vd, x, y);
+                has_dirty += vnc_refresh_lossy_rect(vd, x, y, height);
                 memset(rect->times, 0, sizeof (rect->times));
                 continue ;
             }
-- 
2.55.0


