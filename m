Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EE1CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ZlF-0007yA-TR; Tue, 30 Sep 2025 08:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3Zl9-0007wI-Ja
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3Zl5-0002LP-KQ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759236424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdGKf1/Ah98uUN/hsJ5HarEBd3b8BDDjHM37Dm5B+dM=;
 b=R2u3LOz1KPynlgCVdJ9IQVWh3FBhCV7dF7urVqGzsHbmdj3oiA79oP1r3wOGdIwApaM4Xe
 cRx/lMdKuxK+bLWfAJVYpLv2oNpn1HqhrOCFZ5NH/sq/1SaDPHGXh+mHY6xVSKHAsudQAb
 op02U2srSjkfUlEoCTnkze+YYUPTGX0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-KehyE5brOY-UjIJ6-JI1fg-1; Tue,
 30 Sep 2025 08:47:02 -0400
X-MC-Unique: KehyE5brOY-UjIJ6-JI1fg-1
X-Mimecast-MFC-AGG-ID: KehyE5brOY-UjIJ6-JI1fg_1759236421
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FAC41955D77; Tue, 30 Sep 2025 12:47:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 151431800577; Tue, 30 Sep 2025 12:47:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 75BEA21E6779; Tue, 30 Sep 2025 14:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 06/13] net/slirp: Clean up error reporting
Date: Tue, 30 Sep 2025 14:46:46 +0200
Message-ID: <20250930124653.321609-7-armbru@redhat.com>
In-Reply-To: <20250930124653.321609-1-armbru@redhat.com>
References: <20250930124653.321609-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

net_slirp_register_poll_sock() and net_slirp_unregister_poll_sock()
report WSAEventSelect() failure with error_setg(&error_warn, ...).
error_setg_win32(&error_warn, ...) is undesirable just like
error_setg(&error_fatal, ...) and error_setg(&error_abort, ...)  are.
Replace by warn_report().

The failures should probably be errors, but these functions implement
callbacks that cannot fail, exit(1) would be too harsh, and silent
failure we don't want.  Thus, warnings.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250923091000.3180122-7-armbru@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 net/slirp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 9657e86a84..0a1c2a5eac 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -258,11 +258,13 @@ static void net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
 {
 #ifdef WIN32
     AioContext *ctxt = qemu_get_aio_context();
+    g_autofree char *msg = NULL;
 
     if (WSAEventSelect(fd, event_notifier_get_handle(&ctxt->notifier),
                        FD_READ | FD_ACCEPT | FD_CLOSE |
                        FD_CONNECT | FD_WRITE | FD_OOB) != 0) {
-        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSAEventSelect()");
+        msg = g_win32_error_message(WSAGetLastError());
+        warn_report("failed to WSAEventSelect(): %s", msg);
     }
 #endif
 }
@@ -270,8 +272,11 @@ static void net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
 static void net_slirp_unregister_poll_sock(slirp_os_socket fd, void *opaque)
 {
 #ifdef WIN32
+    g_autofree char *msg = NULL;
+
     if (WSAEventSelect(fd, NULL, 0) != 0) {
-        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSAEventSelect()");
+        msg = g_win32_error_message(WSAGetLastError());
+        warn_report("failed to WSAEventSelect(): %s", msg);
     }
 #endif
 }
-- 
2.49.0


