Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2BBCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjqN-0007ip-5u; Tue, 12 May 2026 05:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMjqK-0007iY-VX
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMjqH-0005kK-EW
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778579753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dmh5471avZxbjWCnR/HxlXbeySRQyYNzD86VPgV3zJk=;
 b=QIFgJ8oLUOQ07lAUiZ+wY8o87P4e7HLEuYA1mKVDMSInc3eYrtwU6tlqeeX825xLLXZp18
 pRHqLzM9DD9bACI53x5VAiQdLgOhuLXnk1tY7YOEiM5XrkmVdQEyBFVtqrTDgCny8RcRZ6
 BdeiGeB4X15iWykniniHRkJEBhWCFms=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-wrd10OheMhCBXzV-GNHxaQ-1; Tue,
 12 May 2026 05:55:49 -0400
X-MC-Unique: wrd10OheMhCBXzV-GNHxaQ-1
X-Mimecast-MFC-AGG-ID: wrd10OheMhCBXzV-GNHxaQ_1778579748
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91CF31800359; Tue, 12 May 2026 09:55:48 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.244])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0159F18004A3; Tue, 12 May 2026 09:55:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Heechan Kang <gganji11@naver.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] ui: fix validation of VNC extended clipboard data length
Date: Tue, 12 May 2026 10:55:43 +0100
Message-ID: <20260512095543.459949-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Heechan Kang <gganji11@naver.com>

QEMU's VNC extended clipboard handler inflates a client-controlled
compressed clipboard payload. The code checks the declared text size
against the total inflated buffer size:

    if (tsize < size)

but then copies from:

    tbuf = buf + 4;
    qemu_clipboard_set_data(..., tsize, tbuf, true);

The correct bound is the remaining data length after the 4-byte length
field, not the total inflated buffer length.

As a result, a VNC client can make QEMU copy up to 3 bytes past the end
of the inflated heap buffer. With a second VNC client, those copied
bytes are observable through the normal VNC extended clipboard PROVIDE
path.

Fixes: CVE-2026-8343
Reported-by: Heechan Kang <gganji11@naver.com>
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Heechan Kang <gganji11@naver.com>
[DB: added #include and 'return' statements]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-clipboard.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index 124b6fbd9c..fa05d86f42 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "vnc.h"
 #include "vnc-jobs.h"
 
@@ -282,10 +283,16 @@ void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t
             buf && size >= 4) {
             uint32_t tsize = read_u32(buf, 0);
             uint8_t *tbuf = buf + 4;
-            if (tsize < size) {
+            if (tsize <= size - 4) {
                 qemu_clipboard_set_data(&vs->cbpeer, vs->cbinfo,
                                         QEMU_CLIPBOARD_TYPE_TEXT,
                                         tsize, tbuf, true);
+            } else {
+                error_report("vnc: malformed extended clipboard payload "
+                             "with text length %u exceeding available %u",
+                             tsize, size - 4);
+                vnc_client_error(vs);
+                return;
             }
         }
     }
-- 
2.54.0


