Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8157CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3tE-0007il-Kf; Thu, 21 May 2026 09:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3tA-0007BO-7x
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3t8-0000lv-Og
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozfM5pL0zGVFmVkgCjhOy/HxIy8dJ9DpdHwS2nKdBUE=;
 b=bPi4pRIRhPD3qmYuPydE7qezt5dXDsiCtYJ8cRDQ7YcswIyQUQCiMXmmSCknVJMJA1Ap4R
 p4Nyxvo3Rb9i8sR7pQwikBdf4CobvgSv4CEalQQ/PFRkYj7eOf+vVALVIyNJuW4HqsFk3t
 bT8Qa5jUFq0IRqEnp0kwrCI48oQNRU0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-PZicMMnwMdWrvDQBrLlQIw-1; Thu,
 21 May 2026 09:56:34 -0400
X-MC-Unique: PZicMMnwMdWrvDQBrLlQIw-1
X-Mimecast-MFC-AGG-ID: PZicMMnwMdWrvDQBrLlQIw_1779371793
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D99751800622; Thu, 21 May 2026 13:56:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEFEB300019F; Thu, 21 May 2026 13:56:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 06/38] ui/vnc: fix OOB write in lossy rect worker code
Date: Thu, 21 May 2026 17:55:17 +0400
Message-ID: <20260521135551.1752945-7-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
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

From: Daniel P. Berrangé <berrange@redhat.com>

Incorrect calculation of the boundary condition when tracking lossy
rectangles in the worker thread will result in an OOB write which
can corrupt further worker state, and/or trigger any guard pages
that may lie beyond the VncWorker struct. This can be triggered
through careful choice of the display resolution in the guest
OS by an unprivileged user.

Fixes: CVE-2026-48002
Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260521103353.1645561-4-berrange@redhat.com>
[Marc-André - added assert() suggest by philmd@linaro.org]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 56dd43d53ff..375ab207950 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2982,13 +2982,15 @@ void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h)
 {
     int i, j;
 
-    w = (x + w) / VNC_STAT_RECT;
-    h = (y + h) / VNC_STAT_RECT;
+    w = DIV_ROUND_UP((x + w), VNC_STAT_RECT);
+    h = DIV_ROUND_UP((y + h), VNC_STAT_RECT);
+    assert(h <= VNC_STAT_ROWS);
+    assert(w <= VNC_STAT_COLS);
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


