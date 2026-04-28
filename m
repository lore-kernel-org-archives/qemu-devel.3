Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DECFF8874
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHk2P-00020B-Uo; Tue, 28 Apr 2026 11:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHk2M-0001za-0n
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHk2J-0000ZA-0J
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777388862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wP/Ru80yHhGUP0sq9wta8Fv1o5i9JRd5+TNCkCPLPnY=;
 b=bHH15V7M5Es6WpUzrF6VN50eK6M8rlAMynt+OetaAuP240+qjmqPSxYLBSpS4oM3oU7/sJ
 G36SdIvyZRtT90XkYiAYptoUqmvQWlPh1sAMiQLn/4g0PQclLbxSJiN8s1IxNk0XXaqPyx
 3MPEHsAd5pOFJkf/lg0ZX5cwxSnQCTM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-v27IlPbkNMqafHGdFvRAVg-1; Tue,
 28 Apr 2026 11:07:38 -0400
X-MC-Unique: v27IlPbkNMqafHGdFvRAVg-1
X-Mimecast-MFC-AGG-ID: v27IlPbkNMqafHGdFvRAVg_1777388857
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 825D11956048; Tue, 28 Apr 2026 15:07:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84FDF1800446; Tue, 28 Apr 2026 15:07:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 01/15] ui: move FONT_WIDTH/HEIGHT to vgafont.h
Date: Tue, 28 Apr 2026 19:07:11 +0400
Message-ID: <20260428150726.1659814-2-marcandre.lureau@redhat.com>
In-Reply-To: <20260428150726.1659814-1-marcandre.lureau@redhat.com>
References: <20260428150726.1659814-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Since those values are related to the VGA font, it make sense to move
them here.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-priv.h | 5 -----
 ui/vgafont.h      | 6 +++++-
 ui/console-vc.c   | 1 +
 ui/console.c      | 1 +
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/ui/console-priv.h b/ui/console-priv.h
index 8bcdb79d914..39798c3e9d7 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -9,11 +9,6 @@
 #include "qemu/coroutine.h"
 #include "qemu/timer.h"
 
-#include "vgafont.h"
-
-#define FONT_HEIGHT 16
-#define FONT_WIDTH 8
-
 struct QemuConsole {
     Object parent;
 
diff --git a/ui/vgafont.h b/ui/vgafont.h
index 54aeeb7d192..d24b5d47a95 100644
--- a/ui/vgafont.h
+++ b/ui/vgafont.h
@@ -6,6 +6,10 @@
 
 #include <stdint.h>
 
-extern const uint8_t vgafont16[256 * 16];
+/* supports only vga 8x16 */
+#define FONT_WIDTH 8
+#define FONT_HEIGHT 16
+
+extern const uint8_t vgafont16[256 * FONT_HEIGHT];
 
 #endif
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 107294af1cc..6163e21d2c6 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -10,6 +10,7 @@
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "ui/console.h"
+#include "ui/vgafont.h"
 
 #include "pixman.h"
 #include "trace.h"
diff --git a/ui/console.c b/ui/console.c
index a7bd22515b9..9606da7b1a6 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "ui/console.h"
+#include "ui/vgafont.h"
 #include "hw/core/qdev.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
-- 
2.54.0


