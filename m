Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47F7C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzUCW-0002Q9-20; Thu, 27 Aug 2026 03:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzUCU-0002Pj-3F
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 03:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzUCR-0003s5-R6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 03:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787814416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EgZS9nN00w86ZINuBBy32OYeQIC2ItAWGNeRdbC/AVg=;
 b=a3kdIJirrCpLcLJ7EImjJSAml+sjnNI8wxcPT15opBgbChOQdc9iSnWkwOVrKtDq+nWuLT
 yVEqPuNfGqW9O1b6e0kOZ7uHW1LnNCiyHZXRRGiDxNsOdbpkL6XHQBU4PAzwxjJs0/Wxl4
 2MdbSD/eymMjWVVaFDexypKbhTg9PYQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-tFD2QC74Nam3v7l_qKfcpA-1; Thu,
 27 Aug 2026 03:06:52 -0400
X-MC-Unique: tFD2QC74Nam3v7l_qKfcpA-1
X-Mimecast-MFC-AGG-ID: tFD2QC74Nam3v7l_qKfcpA_1787814411
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0D0719540DB; Thu, 27 Aug 2026 07:06:51 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 980CB7D7; Thu, 27 Aug 2026 07:06:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/console: fix use-after-free in qemu_console_set_cursor
Date: Thu, 27 Aug 2026 11:06:47 +0400
Message-ID: <20260827070647.2872650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When the new cursor is the same object as the one already held by
the console and the refcount is 1, cursor_unref frees it before
cursor_ref can increment the count.

Ref the incoming cursor before unreffing the old one so the
refcount goes 1-2-1 instead of 1-0 (freed) then use-after-free.

This is related to 385ac97f8fad ("ui: keep current cursor with
QemuConsole"), but could have happened earlier with VNC too.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index a8a2a247d8f4..4db8f1cb431f 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -904,8 +904,9 @@ void qemu_console_set_cursor(QemuConsole *c, QEMUCursor *cursor)
     DisplayState *s = c->ds;
     DisplayChangeListener *dcl;
 
+    cursor_ref(cursor);
     cursor_unref(con->cursor);
-    con->cursor = cursor_ref(cursor);
+    con->cursor = cursor;
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (c != dcl->con) {
             continue;
-- 
2.55.0.543.g5ebe2ebe4ea8


