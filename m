Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B2CF9B610
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV1L-00040U-Ec; Wed, 22 Apr 2026 06:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV1A-0003ut-Vl
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV16-0002CC-6o
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fYaGsZ6mPfpuUJHsETFdqLxFxcDnCiwytGXSq+fP8E=;
 b=IMG7f7GVoxegGcJE1v5RxF11XHMBDUi8a/erV4uFwlecnt+6CKsfAKbo/sj8yUKhU3MFKV
 HfVzBnMUpMGpoZ0ZVzH7WHv2nW6vqKxHO5pSUrrpXDHAlcmyyqneTR1hA42VIcQHdooI2i
 z5l98sIJQrcZupK2iYeQu9tarsbgg3k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-YFXQgU9MP5SBbtEOuSKBOw-1; Wed,
 22 Apr 2026 06:41:08 -0400
X-MC-Unique: YFXQgU9MP5SBbtEOuSKBOw-1
X-Mimecast-MFC-AGG-ID: YFXQgU9MP5SBbtEOuSKBOw_1776854467
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22E0B19560B4; Wed, 22 Apr 2026 10:41:07 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A68CF1956095; Wed, 22 Apr 2026 10:41:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Werner de Carne <werner@carne.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 03/40] serial COM: windows serial COM PollingFunc don't sleep
Date: Wed, 22 Apr 2026 14:40:04 +0400
Message-ID: <20260422104042.3936506-4-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

From: Werner de Carne <werner@carne.de>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1802
Signed-off-by: Werner de Carne <werner@carne.de>
[ Marc-André - indentation fixes ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230807201443.2668-1-werner@carne.de>
---
 chardev/char-win.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/chardev/char-win.c b/chardev/char-win.c
index fef45e83aad..e194242c9f9 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "chardev/char-win.h"
 
-static void win_chr_read(Chardev *chr, DWORD len)
+static int win_chr_read(Chardev *chr, DWORD len)
 {
     WinChardev *s = WIN_CHARDEV(chr);
     int max_size = qemu_chr_be_can_write(chr);
@@ -40,7 +40,7 @@ static void win_chr_read(Chardev *chr, DWORD len)
         len = max_size;
     }
     if (len == 0) {
-        return;
+        return 0;
     }
 
     ZeroMemory(&s->orecv, sizeof(s->orecv));
@@ -56,6 +56,8 @@ static void win_chr_read(Chardev *chr, DWORD len)
     if (size > 0) {
         qemu_chr_be_write(chr, buf, size);
     }
+
+    return size > 0 ? 1 : 0;
 }
 
 static int win_chr_serial_poll(void *opaque)
@@ -67,8 +69,9 @@ static int win_chr_serial_poll(void *opaque)
 
     ClearCommError(s->file, &comerr, &status);
     if (status.cbInQue > 0) {
-        win_chr_read(chr, status.cbInQue);
-        return 1;
+        if (win_chr_read(chr, status.cbInQue)) {
+            return 1;
+        }
     }
     return 0;
 }
@@ -147,8 +150,9 @@ int win_chr_pipe_poll(void *opaque)
 
     PeekNamedPipe(s->file, NULL, 0, NULL, &size, NULL);
     if (size > 0) {
-        win_chr_read(chr, size);
-        return 1;
+        if (win_chr_read(chr, size)) {
+            return 1;
+        }
     }
     return 0;
 }
-- 
2.53.0


