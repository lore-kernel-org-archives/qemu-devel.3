Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1775C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfxq-00014T-IM; Tue, 19 Mar 2024 16:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxo-00013y-Uy
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxn-0007X3-Fx
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710879694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfjufpNx+Y+8+5GtcHEkQkTzbcmUP74wXFDJyQBNVkk=;
 b=jWeNvSW0QBrd9vDgezbPPFIYmxyTlF431Ht9qUzAcsyXhCZAX0Leqi+kp516iurIDFKer8
 g41si3ZV99TAKRnckRkzVA2upSIzkYf6TR8FscCoy0PJLffluyFUe1xivZGuogucWghhJ6
 2//WluwaK7HTrRJ/2SWmB0VLr0FR8Mc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-A4cRPEddPCedCuvRqOQNQQ-1; Tue,
 19 Mar 2024 16:21:33 -0400
X-MC-Unique: A4cRPEddPCedCuvRqOQNQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6A801C05EB6
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 20:21:32 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F9DA10F53;
 Tue, 19 Mar 2024 20:21:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/8] Revert "chardev/char-socket: Fix TLS io channels sending
 too much data to the backend"
Date: Tue, 19 Mar 2024 20:21:16 +0000
Message-ID: <20240319202121.233130-4-berrange@redhat.com>
In-Reply-To: <20240319202121.233130-1-berrange@redhat.com>
References: <20240319202121.233130-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit results in unexpected termination of the TLS connection.
When 'fd_can_read' returns 0, the code goes on to pass a zero length
buffer to qio_channel_read. The TLS impl calls into gnutls_recv()
with this zero length buffer, at which point GNUTLS returns an error
GNUTLS_E_INVALID_REQUEST. This is treated as fatal by QEMU's TLS code
resulting in the connection being torn down by the chardev.

Simply skipping the qio_channel_read when the buffer length is zero
is also not satisfactory, as it results in a high CPU burn busy loop
massively slowing QEMU's functionality.

The proper solution is to avoid tcp_chr_read being called at all
unless the frontend is able to accept more data. This will be done
in a followup commit.

This reverts commit 462945cd22d2bcd233401ed3aa167d83a8e35b05

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 2c4dffc0e6..812d7aa38a 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -496,9 +496,9 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
         s->max_size <= 0) {
         return TRUE;
     }
-    len = tcp_chr_read_poll(opaque);
-    if (len > sizeof(buf)) {
-        len = sizeof(buf);
+    len = sizeof(buf);
+    if (len > s->max_size) {
+        len = s->max_size;
     }
     size = tcp_chr_recv(chr, (void *)buf, len);
     if (size == 0 || (size == -1 && errno != EAGAIN)) {
-- 
2.43.0


