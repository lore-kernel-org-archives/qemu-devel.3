Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534CAF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHRL-0005Cx-O9; Fri, 10 Apr 2026 15:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRJ-0005CU-1C
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRH-00020W-Nw
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6txHtHza4oPO6jN+3NWocTvhcHQbFK0yWPa0mHLVQk=;
 b=MMGEdqjEP+MT/li2ajN+Cz/pJZi1xaATBy6lk8cCHdF1CVHXqb4u/WkN9vkxNd9ebj8Wae
 plZz64lTlj7bu0RKZFqmg5boX+3hHGAx5xJ1bunarR5jqomRygPmZS+Fv8aeuAlMkTTLvk
 vOU7LJ0I/As8tkvhZuXoWBrr2SCX1r8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-rd7g0PCLNM2XPBRpf2ACVg-1; Fri,
 10 Apr 2026 15:22:45 -0400
X-MC-Unique: rd7g0PCLNM2XPBRpf2ACVg-1
X-Mimecast-MFC-AGG-ID: rd7g0PCLNM2XPBRpf2ACVg_1775848964
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B82FD1956095; Fri, 10 Apr 2026 19:22:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 684E6180057F; Fri, 10 Apr 2026 19:22:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:00 +0400
Subject: [PATCH v2 38/67] ui: minor code simplification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-38-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=woJUhrs5y76Ek6vAQ8nlLqeubW55veqdmpH8rHOvF60=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0Vf0b6sNiBc2Vp3A5w+FOBQY8dKF3l1XwXr
 OuCCCMf3siJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5QhgD/9unmznd4NhfKdIDr2UrlyA3qhKfdkRU0fmU6ptVDUGGt5c865knSApLXR5mQgQVkqoTsf
 YHkScTCzc07M+GrGoGuu6H8gc2g7fbOYZDRQNYIm6m1MHhK70iDl+XU3PVBIQts/Oc4FueELTcH
 C3GN2WMHMI+I4Aw8niBLnCrwtIvbfUEpyfCxpOf97THuLb2c1Js+NSsRp19gNzZZCLxhY1icH6g
 C67deXjVjMtJGXZNfRGiJMoJKXdGuSpxnp3NyZlV83HB3DBlVeAjVdeSDGVQHsvmeApyGfgRlFf
 eWSyJbJbum/quXj86kab3gRWLTETV8Iboz1aoHLaqsXdqtf24z8N4XGSL1uJp8Ax8oiUtF0nki/
 HFEZFtK4LAO0rYLrqsRPLjRxkjfR08/5TGzlwPI59uxk32LXbsEv5F2JxItr+qsCaJINzYYjWEC
 QbKW636SaN6Kb0mGWY7fCtiSk6YzWWkpWiS/vCQ7UbYJXBWXpNPR5nePWM2SnC8qaWXtXjeWzj/
 jkrRkwUExb4xw/f8z0l8PF7iryk+BsBEcuLJEC6qd9Zsx7Rw3lgKLkGQHrs9LNl3JWkcddsNNTB
 3lh8NvOxekGqPR6rWtfcIntd8SlgEsKIWwN6259HJmk1FF8yABaEV19xMmNEchQwlyCzBRKw7tD
 +CuXp30IL95HVGg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Drop memset() usage.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/sdl2.c | 8 ++++----
 ui/vnc.c  | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index aaaede56e0e..30e0042fe29 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -600,10 +600,10 @@ static void handle_windowevent(SDL_Event *ev)
     switch (ev->window.event) {
     case SDL_WINDOWEVENT_RESIZED:
         {
-            QemuUIInfo info;
-            memset(&info, 0, sizeof(info));
-            info.width = ev->window.data1;
-            info.height = ev->window.data2;
+            QemuUIInfo info = {
+                .width = ev->window.data1,
+                .height = ev->window.data2,
+            };
             dpy_set_ui_info(scon->dcl.con, &info, true);
         }
         sdl2_redraw(scon);
diff --git a/ui/vnc.c b/ui/vnc.c
index 4aa446a48d7..9c8fe280bc9 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -43,6 +43,7 @@
 #include "qapi/qapi-events-ui.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
+#include "ui/console.h"
 #include "ui/input.h"
 #include "crypto/hash.h"
 #include "crypto/tlscreds.h"
@@ -2638,10 +2639,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
 
         trace_vnc_msg_client_set_desktop_size(vs, vs->ioc, w, h, screens);
         if (dpy_ui_info_supported(vs->vd->dcl.con)) {
-            QemuUIInfo info;
-            memset(&info, 0, sizeof(info));
-            info.width = w;
-            info.height = h;
+            QemuUIInfo info = { .width = w, .height = h };
             dpy_set_ui_info(vs->vd->dcl.con, &info, false);
             vnc_desktop_resize_ext(vs, 4 /* Request forwarded */);
         } else {

-- 
2.53.0


