Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CB5CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 10:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ0jE-00015k-5l; Thu, 21 May 2026 06:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ0jB-000158-Kc
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ0j9-0006Fo-SA
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779359647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4pLLYtFwu2vJHug+1PMti/u2IAeHTuHm98LVYR6w/U=;
 b=MvRBHjRqEByJv1NuA3B5FcylcpO7H1WiQOcADnDZycHRg52gv7dJbtajNAQVOPuOlQTKj2
 Ne8qyqngYRXkDKuY1SQxl0Nhve9fmBkLCrdUySvLbuUyk4MItRQi10p/j0BFKa5IvJmGaJ
 /L/nNVN1sy2q8uTmElURXvQ+XS407AA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-Za04i7ktNLam9Sih2vC9OQ-1; Thu,
 21 May 2026 06:34:05 -0400
X-MC-Unique: Za04i7ktNLam9Sih2vC9OQ-1
X-Mimecast-MFC-AGG-ID: Za04i7ktNLam9Sih2vC9OQ_1779359644
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1232618005B6
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 10:34:04 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.98])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1B1E19560A3; Thu, 21 May 2026 10:34:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/4] ui/vnc: fix OOB write in lossy rect worker code
Date: Thu, 21 May 2026 11:33:52 +0100
Message-ID: <20260521103353.1645561-4-berrange@redhat.com>
In-Reply-To: <20260521103353.1645561-1-berrange@redhat.com>
References: <20260521103353.1645561-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Incorrect calculation of the boundary condition when tracking lossy
rectangles in the worker thread will result in an OOB write which
can corrupt further worker state, and/or trigger any guard pages
that may lie beyond the VncWorker struct. This can be triggered
through careful choice of the display resolution in the guest
OS by an unprivileged user.

Fixes: CVE-2026-48002
Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 56dd43d53f..ee567700a5 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2982,13 +2982,13 @@ void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h)
 {
     int i, j;
 
-    w = (x + w) / VNC_STAT_RECT;
-    h = (y + h) / VNC_STAT_RECT;
+    w = DIV_ROUND_UP((x + w), VNC_STAT_RECT);
+    h = DIV_ROUND_UP((y + h), VNC_STAT_RECT);
     x /= VNC_STAT_RECT;
     y /= VNC_STAT_RECT;
 
-    for (j = y; j <= h; j++) {
-        for (i = x; i <= w; i++) {
+    for (j = y; j < h; j++) {
+        for (i = x; i < w; i++) {
             worker->lossy_rect[j][i] = 1;
         }
     }
-- 
2.54.0


