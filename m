Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EB2F9B614
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV2Q-0006H0-Nr; Wed, 22 Apr 2026 06:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV25-0005j4-Sj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV24-0002Ut-9r
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twgYeKSfk/9iFKYxAn07J2tfYB24YSO2tHaeQMNeFm8=;
 b=S7Gygel2nRYJQB7/qgh/Y7jwPm+/V9IXk8UBVz7rWdfMiEMlrTz542T2LfEOXIFRElE8ov
 kVGZ0XXWXTPsSUoR+pAqb/DKmSgYM3VD8y22/bP4DW3TqrXzXBSuD+QycGYrLvzqhq0+XM
 IjTQ+1WqGJbwgUcOMEFJRjkHa1H5eM8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-b6YB3bYhNHWHIEd2YJwDhA-1; Wed,
 22 Apr 2026 06:42:10 -0400
X-MC-Unique: b6YB3bYhNHWHIEd2YJwDhA-1
X-Mimecast-MFC-AGG-ID: b6YB3bYhNHWHIEd2YJwDhA_1776854529
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4402518001FB; Wed, 22 Apr 2026 10:42:09 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5B983000C15; Wed, 22 Apr 2026 10:42:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 13/40] ui/console-vc: ignore string-type escape sequences
Date: Wed, 22 Apr 2026 14:40:14 +0400
Message-ID: <20260422104042.3936506-14-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Modern terminals and applications emit OSC (Operating System Command),
DCS, SOS, PM, and APC escape sequences (e.g. for setting window
titles).  The text console currently does not recognise these
string-type introducers, so each byte of the payload is interpreted as
a normal character or a new escape, producing garbage on screen.

Add a TTY_STATE_OSC state that silently consumes all bytes until the
sequence is terminated by BEL or ST (ESC \).

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 8dee1f9bd01..62114d89ddd 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -44,6 +44,7 @@ enum TTYState {
     TTY_STATE_CSI,
     TTY_STATE_G0,
     TTY_STATE_G1,
+    TTY_STATE_OSC,
 };
 
 typedef struct QemuTextConsole {
@@ -807,6 +808,10 @@ static void vc_putchar(VCChardev *vc, int ch)
             vc->state = TTY_STATE_G0;
         } else if (ch == ')') {
             vc->state = TTY_STATE_G1;
+        } else if (ch == ']' || ch == 'P' || ch == 'X'
+                   || ch == '^' || ch == '_') {
+            /* String sequences: OSC, DCS, SOS, PM, APC */
+            vc->state = TTY_STATE_OSC;
         } else if (ch == '7') {
             vc_save_cursor(vc);
             vc->state = TTY_STATE_NORM;
@@ -965,6 +970,16 @@ static void vc_putchar(VCChardev *vc, int ch)
             break;
         }
         break;
+    case TTY_STATE_OSC: /* Operating System Command: ESC ] ... BEL/ST */
+        if (ch == '\a') {
+            /* BEL terminates OSC */
+            vc->state = TTY_STATE_NORM;
+        } else if (ch == 27) {
+            /* ESC might start ST (ESC \) */
+            vc->state = TTY_STATE_ESC;
+        }
+        /* All other bytes are silently consumed */
+        break;
     case TTY_STATE_G0: /* set character sets */
     case TTY_STATE_G1: /* set character sets */
         switch (ch) {
-- 
2.53.0


