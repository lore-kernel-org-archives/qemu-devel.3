Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F71C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2Bx-0006lX-5D; Tue, 11 Mar 2025 12:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts22p-0004X3-9C
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts22i-0005nw-7X
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZFCUSt+CA7uOUzEuduQjHaj5iVHAwCq5l0Wu92LpCg=;
 b=Aywhc4jTO9g/CIEX1wbIh/deF8+60Njp+eJKhqDfD9saIDATsXut/OavSsUMXStG6h6UCi
 +1x13ecv5BJmROJ8pBYR5CkgHrMkAF1dptc3++59ovUi/93LPdi1/kEUtL8JwNPPRaShV4
 EGVI01JkiWgv23WxzLVkMOzlAURLXkE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-AbIkjy3BNt2c-w_L1L0gGw-1; Tue,
 11 Mar 2025 12:01:05 -0400
X-MC-Unique: AbIkjy3BNt2c-w_L1L0gGw-1
X-Mimecast-MFC-AGG-ID: AbIkjy3BNt2c-w_L1L0gGw_1741708864
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D654180087D
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:01:04 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40FF418009AE; Tue, 11 Mar 2025 16:01:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-10.1 10/10] ui/vdagent: remove migration blocker
Date: Tue, 11 Mar 2025 19:59:32 +0400
Message-ID: <20250311155932.1472092-11-marcandre.lureau@redhat.com>
In-Reply-To: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Fixes: https://issues.redhat.com/browse/RHEL-81894
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vdagent.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index cc5738a6ea..3b27ba25fb 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -6,7 +6,6 @@
 #include "qemu/option.h"
 #include "qemu/units.h"
 #include "hw/qdev-core.h"
-#include "migration/blocker.h"
 #include "ui/clipboard.h"
 #include "ui/console.h"
 #include "ui/input.h"
@@ -33,9 +32,6 @@
 struct VDAgentChardev {
     Chardev parent;
 
-    /* TODO: migration isn't yet supported */
-    Error *migration_blocker;
-
     /* config */
     bool mouse;
     bool clipboard;
@@ -673,10 +669,6 @@ static void vdagent_chr_open(Chardev *chr,
     return;
 #endif
 
-    if (migrate_add_blocker(&vd->migration_blocker, errp) != 0) {
-        return;
-    }
-
     vd->mouse = VDAGENT_MOUSE_DEFAULT;
     if (cfg->has_mouse) {
         vd->mouse = cfg->mouse;
@@ -1073,8 +1065,6 @@ static void vdagent_chr_init(Object *obj)
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
 
     vd->outbuf = g_byte_array_new();
-    error_setg(&vd->migration_blocker,
-               "The vdagent chardev doesn't yet support migration");
     vmstate_register_any(NULL, &vmstate_vdagent, vd);
 }
 
@@ -1082,7 +1072,6 @@ static void vdagent_chr_fini(Object *obj)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
 
-    migrate_del_blocker(&vd->migration_blocker);
     vdagent_disconnect(vd);
     if (vd->mouse_hs) {
         qemu_input_handler_unregister(vd->mouse_hs);
-- 
2.47.0


