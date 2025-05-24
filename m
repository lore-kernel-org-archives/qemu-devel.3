Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DFBC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsmR-00081R-2l; Sat, 24 May 2025 13:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmO-0007yd-Kv
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmL-0000gm-If
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1BUcCpSr5ctVf8kpo2QU7QmLHfVmuGp/pyUk+dZcBo=;
 b=B9m4uNNA0YyT7O1Pz6uysgYY1FVT7HG6TZO40FBzLHxQk2IAhP/c/Xk97DnoHInuo1CDEE
 yMtZUvyYyXDKZphsD5auqTRqGoCFWDrSVem8CNLvWG+IgJQuhjt7A++ylewdjhQF+0sRK/
 /atFn1dxgTM3YxpBr4aFCjQR42RWVgg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-fkMCyTXLOAap_vAo2cBjXA-1; Sat,
 24 May 2025 13:35:22 -0400
X-MC-Unique: fkMCyTXLOAap_vAo2cBjXA-1
X-Mimecast-MFC-AGG-ID: fkMCyTXLOAap_vAo2cBjXA_1748108121
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA310195608E
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 17:35:21 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6EB531944DFF; Sat, 24 May 2025 17:35:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com
Subject: [PULL 01/19] ui/gtk: warn if setting the clipboard failed
Date: Sat, 24 May 2025 19:34:54 +0200
Message-ID: <20250524173514.317886-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

Just in case.
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk-clipboard.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 8d8a636fd1..65d89ec601 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 
 #include "ui/gtk.h"
@@ -95,11 +96,13 @@ static void gd_clipboard_update_info(GtkDisplayState *gd,
             gtk_clipboard_clear(gd->gtkcb[s]);
             if (targets) {
                 gd->cbowner[s] = true;
-                gtk_clipboard_set_with_data(gd->gtkcb[s],
-                                            targets, n_targets,
-                                            gd_clipboard_get_data,
-                                            gd_clipboard_clear,
-                                            gd);
+                if (!gtk_clipboard_set_with_data(gd->gtkcb[s],
+                                                 targets, n_targets,
+                                                 gd_clipboard_get_data,
+                                                 gd_clipboard_clear,
+                                                 gd)) {
+                    warn_report("Failed to set GTK clipboard");
+                }
 
                 gtk_target_table_free(targets, n_targets);
             }
-- 
2.49.0


