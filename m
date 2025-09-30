Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B5BCCA471
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3YEN-0005y7-Nr; Tue, 30 Sep 2025 07:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3YEK-0005xr-S1
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3YE0-0007ge-3A
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759230524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1mCGF6Bwwkfd0T50pC6dG4iBUjt9f5lKksnanTgIdQ=;
 b=AUG38IRQk3CAnyf/pdiINPYQ5KW5PJ0fOJm5xXjqys+IZga3Q6kpl5TFH9hYs2vJMlK6F0
 ZPAfY6sOB4yw6XUdoezBSRWLiqJdA1GylI4Uv0fT656Mc7621dZshSUtOw4vzbSF0L8qid
 rY/hKIKoBW8PprExDjAfJsc8EYisknU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-77byysIONG-1zpWHvPZL0w-1; Tue,
 30 Sep 2025 07:08:40 -0400
X-MC-Unique: 77byysIONG-1zpWHvPZL0w-1
X-Mimecast-MFC-AGG-ID: 77byysIONG-1zpWHvPZL0w_1759230520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3164180048E; Tue, 30 Sep 2025 11:08:39 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69BF819560B4; Tue, 30 Sep 2025 11:08:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Grant Millar | Cylo <rid@cylo.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH 1/2] io: move websock resource release to close method
Date: Tue, 30 Sep 2025 12:08:33 +0100
Message-ID: <20250930110834.2551757-2-berrange@redhat.com>
In-Reply-To: <20250930110834.2551757-1-berrange@redhat.com>
References: <20250930110834.2551757-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QIOChannelWebsock object releases all its resources in the
finalize callback. This is too late, as callers expect to be
able to call qio_channel_close() to fully close a channel and
release resources related to I/O. Only releasing the underlying
QIOChannel transport can be delayed until finalize.

Furthermore the close callback must be robust against being
called multiple times. Thus when moving the code we now clear
the GSource ID using  g_clear_handle_id.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-websock.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 0a8c5c4712..56d53355d5 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -919,16 +919,7 @@ static void qio_channel_websock_finalize(Object *obj)
 {
     QIOChannelWebsock *ioc = QIO_CHANNEL_WEBSOCK(obj);
 
-    buffer_free(&ioc->encinput);
-    buffer_free(&ioc->encoutput);
-    buffer_free(&ioc->rawinput);
     object_unref(OBJECT(ioc->master));
-    if (ioc->io_tag) {
-        g_source_remove(ioc->io_tag);
-    }
-    if (ioc->io_err) {
-        error_free(ioc->io_err);
-    }
 }
 
 
@@ -1218,6 +1209,15 @@ static int qio_channel_websock_close(QIOChannel *ioc,
     QIOChannelWebsock *wioc = QIO_CHANNEL_WEBSOCK(ioc);
 
     trace_qio_channel_websock_close(ioc);
+    buffer_free(&wioc->encinput);
+    buffer_free(&wioc->encoutput);
+    buffer_free(&wioc->rawinput);
+    if (wioc->io_tag) {
+        g_clear_handle_id(&wioc->io_tag, g_source_remove);
+    }
+    if (wioc->io_err) {
+        g_clear_pointer(&wioc->io_err, error_free);
+    }
     return qio_channel_close(wioc->master, errp);
 }
 
-- 
2.50.1


