Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3F2F3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QB4-0007hh-Sw; Tue, 17 Mar 2026 04:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAC-0006eG-5R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QA7-00037m-UW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhtt844qJCBla7vAdeQO83fRNPACQxKpvzJlDF+Oc8A=;
 b=GbNq2bX6DauzVDhVzOFYsYow1efPXRfzOElmZeskrSgHKj5YBSRWQjujneWsHlHzYxFKF1
 CPraTfiyy5PYZv2hf0crqvxYEgxrqCH5nl4bsUUCrhbjEeHjrkoy+OxRiND3S0h+ZgBXhp
 ZEkZzq8RdNLIYWczWvBXdmGUVvERmTc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-qO4_Rx8GNCWpAgYFBNKIrg-1; Tue,
 17 Mar 2026 04:52:25 -0400
X-MC-Unique: qO4_Rx8GNCWpAgYFBNKIrg-1
X-Mimecast-MFC-AGG-ID: qO4_Rx8GNCWpAgYFBNKIrg_1773737545
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD8D019560A6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:24 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C44DC1800107
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:32 +0400
Subject: [PATCH 18/60] ui/console-vc: make invalidate_xy() take vt100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-18-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/BrEMOT5CCiPx1ZrI4u2e6B2BAwyWH8wfQvslbfXeGA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXa/JaCs2JASR2Izxodw6Hq/A8YrN1HrQqiJ
 uluf5+qzliJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5T/tD/9FGzTOGcsHAnTEjM4eg0t+CKCiMDCCoKtXHdaiB1MYPMRfdsGNezjAQQxRo3KxarPGxko
 c6lkYvVtlrfFSN0WrqFNYcFIgf6+78ZTl+7VDAoMiqU4EJ2R4uN7pPwqX+qahGxAo6xZOqZ/Rww
 kWsPDyDNTq9gUpREwQG9SAxyk04k2RSbqfaxG1iB+0Nj/8lkyg/ziuBxQ3CVGUqm8bmD0XftdIz
 CQfnYbf4FTFaQofkPIp9cj6ItV1yWDfFm5DNNmmGhD5EpYKg/Ri045iSd9378q9lLnZn/ts7cjp
 4fVsjC7bPsQ1KXLTR6jeMkgomDgb4fj3glPIseSwt48snEh785ORsfa2ArRuwNA+QOyXhj6TW0t
 bFF54TiYJnJ00D3RVp0fD02+pEb3fb480xTCTc3n3rpq9XxT6VJc3s7xyC8LHtOLjg++pSpK89E
 foiWjqV06yBHT4VpD4PJNVlpKPvFQwG/FCDiph3ECjfxxFGJrDvTlELMutB+Hd1VguqOY9bgdDs
 kTSzSaH2r2A8NEDvGa86qrlvWFM/0lM98TszIVrE1Krrg0vAteiUpSz9HHpA4jl6qPhIuqjE55F
 NSxUNNDfxPeh7BAhELaWp0P87Ew+lzFiKIiBKqHz50jIdxNc9ArH8C1FDz8Xh/Q2KyA7N2VYXTx
 6QyXI/sx9JY4oPw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

This decouples glyph rendering from the console object, continuing the
QemuVT100 abstraction introduced in the previous commits.

Style fixes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index c730a8a52b8..4117429a508 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -179,19 +179,20 @@ static void vt100_putcharxy(QemuVT100 *vt, int x, int y, int ch,
                              &fgcol, &bgcol, x, y, FONT_WIDTH, FONT_HEIGHT);
 }
 
-static void invalidate_xy(QemuTextConsole *s, int x, int y)
+static void vt100_invalidate_xy(QemuVT100 *vt, int x, int y)
 {
-    if (!qemu_console_is_visible(QEMU_CONSOLE(s))) {
-        return;
+    if (vt->update_x0 > x * FONT_WIDTH) {
+        vt->update_x0 = x * FONT_WIDTH;
+    }
+    if (vt->update_y0 > y * FONT_HEIGHT) {
+        vt->update_y0 = y * FONT_HEIGHT;
+    }
+    if (vt->update_x1 < (x + 1) * FONT_WIDTH) {
+        vt->update_x1 = (x + 1) * FONT_WIDTH;
+    }
+    if (vt->update_y1 < (y + 1) * FONT_HEIGHT) {
+        vt->update_y1 = (y + 1) * FONT_HEIGHT;
     }
-    if (s->vt.update_x0 > x * FONT_WIDTH)
-        s->vt.update_x0 = x * FONT_WIDTH;
-    if (s->vt.update_y0 > y * FONT_HEIGHT)
-        s->vt.update_y0 = y * FONT_HEIGHT;
-    if (s->vt.update_x1 < (x + 1) * FONT_WIDTH)
-        s->vt.update_x1 = (x + 1) * FONT_WIDTH;
-    if (s->vt.update_y1 < (y + 1) * FONT_HEIGHT)
-        s->vt.update_y1 = (y + 1) * FONT_HEIGHT;
 }
 
 static void console_show_cursor(QemuTextConsole *s, int show)
@@ -219,7 +220,7 @@ static void console_show_cursor(QemuTextConsole *s, int show)
         } else {
             vt100_putcharxy(&s->vt, x, y, c->ch, &(c->t_attrib));
         }
-        invalidate_xy(s, x, y);
+        vt100_invalidate_xy(&s->vt, x, y);
     }
 }
 
@@ -585,7 +586,7 @@ static void vc_update_xy(VCChardev *vc, int x, int y)
         c = &s->vt.cells[y1 * s->vt.width + x];
         vt100_putcharxy(&s->vt, x, y2, c->ch,
                       &(c->t_attrib));
-        invalidate_xy(s, x, y2);
+        vt100_invalidate_xy(&s->vt, x, y2);
     }
 }
 

-- 
2.53.0


