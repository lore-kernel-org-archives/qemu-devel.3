Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9268C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiSN-0001g8-V2; Wed, 05 Mar 2025 01:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiSH-0001cf-MW
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiSF-0001iD-RU
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741156926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKSkcRwm4AyX10dRmWZH8jGmnsqonQR9vc3Xrup2WzA=;
 b=HLMz3Med1a+Vg7ZORR3iQKiqkPwpWrFOEBuYbBP60cwo+2x8M5+F1TVkRnl9ACkSUrtiSz
 mDTb4V9dGpx47/ZqPP+HeZZY9fYSfTXOgWeBEKOa45J2w6sIFJVT3nzXNk1GMJqpjGan4s
 oH1d9V6x8204Ongc3v0qBTijSSyhS4M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-blGu2EOEOr29YxL9U1jU8g-1; Wed,
 05 Mar 2025 01:41:59 -0500
X-MC-Unique: blGu2EOEOr29YxL9U1jU8g-1
X-Mimecast-MFC-AGG-ID: blGu2EOEOr29YxL9U1jU8g_1741156918
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0214180AF57; Wed,  5 Mar 2025 06:41:57 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9170180035F; Wed,  5 Mar 2025 06:41:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 2/6] ui/console-vc: report to the application instead of screen
 rendering
Date: Wed,  5 Mar 2025 10:41:28 +0400
Message-ID: <20250305064132.87441-3-marcandre.lureau@redhat.com>
In-Reply-To: <20250305064132.87441-1-marcandre.lureau@redhat.com>
References: <20250305064132.87441-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 127.0.0.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Roman Penyaev <r.peniaev@gmail.com>

Terminal Device Status Report (DSR) [1] should be sent to an
application, not rendered to the screen. This patch fixes rendering of
terminal report, which appear only on the graphical screen of the
terminal (console "vc") and can be reproduced by the following
command:

     echo -en '\e[6n'; IFS='[;' read -sdR _ row col; echo $row:$col

Command requests cursor position and waits for terminal response, but
instead, the response is rendered to the graphical screen and never
sent to an application.

Why bother? Busybox shell (ash) in Alpine distribution requests cursor
position on each shell prompt (once <ENTER> is pressed), which makes a
prompt on a graphical screen corrupted with repeating Cursor Position
Report (CPR) [2]:

   [root@alpine ~]# \033[57;1R]

Which is very annoying and incorrect.

[1] https://vt100.net/docs/vt100-ug/chapter3.html#DSR
[2] https://vt100.net/docs/vt100-ug/chapter3.html#CPR

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250226075913.353676-3-r.peniaev@gmail.com>
---
 ui/console-vc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 90ff0ffda8..d512f57e10 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -617,10 +617,9 @@ static void vc_put_one(VCChardev *vc, int ch)
 
 static void vc_respond_str(VCChardev *vc, const char *buf)
 {
-    while (*buf) {
-        vc_put_one(vc, *buf);
-        buf++;
-    }
+    QemuTextConsole *s = vc->console;
+
+    qemu_chr_be_write(s->chr, (const uint8_t *)buf, strlen(buf));
 }
 
 /* set cursor, checking bounds */
-- 
2.47.0


