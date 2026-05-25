Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946DECD5BCF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 06:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wROss-0002Mf-4K; Mon, 25 May 2026 02:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wROsW-00021l-1W
 for qemu-devel@nongnu.org; Mon, 25 May 2026 02:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wROsT-00013N-DL
 for qemu-devel@nongnu.org; Mon, 25 May 2026 02:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779690808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIwiZmnjUXUCbjuzvEwbbIdtcVmXNfGuVljF3AGGI/k=;
 b=OxOSa0p3NcANYYL/bg1A2IpvEF4klfaWBoqpZqXf8RhiMkMtFqdCetXaRspc5AI+ItHpP2
 BqvWDbycg8JyQgrDQPkPKp2G5YiLM4ZyXSbjl/MbjyzCrl2dmNfXV1StVeejw5jYV0YBD4
 /r9xrk+5RZPaehO2uBmNoSXZcGZH47Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-uvvYlzvoOJaFD_hD552gkA-1; Mon,
 25 May 2026 02:33:26 -0400
X-MC-Unique: uvvYlzvoOJaFD_hD552gkA-1
X-Mimecast-MFC-AGG-ID: uvvYlzvoOJaFD_hD552gkA_1779690805
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE7D21956089; Mon, 25 May 2026 06:33:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A1DF1800352; Mon, 25 May 2026 06:33:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Heechan Kang <gganji11@naver.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v3 08/38] ui: fix validation of VNC extended clipboard data
 length
Date: Mon, 25 May 2026 10:31:51 +0400
Message-ID: <20260525063223.1409791-9-marcandre.lureau@redhat.com>
In-Reply-To: <20260525063223.1409791-1-marcandre.lureau@redhat.com>
References: <20260525063223.1409791-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260512095543.459949-1-berrange@redhat.com>
---
 ui/vnc-clipboard.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index 124b6fbd9c2..fa05d86f424 100644
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


