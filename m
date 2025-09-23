Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32E6CAC5B1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z2f-0007DR-Id; Tue, 23 Sep 2025 05:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0z2c-0007CU-Np
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0z2P-0000Qj-L5
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758618613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fo7epLNUELelCjfM1nMiWhHNN9XRaAYZ5otAJ+zDWmM=;
 b=fYcOf1SoV2GunISCJJvW5N7Saumh06V0MvEfql+f0xqjkNgfnssSXIsYibtpMgAV/dm+nJ
 ieFY62a88vvcgmSOsr3JmL3/C0P+2QQfAwzsXExHhL4sXDe+5rdTOOzX3p4tmn+6B3NL5I
 JTp1USJHZ7SpIKFECXxOK73eqZIZXPw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-wml9ajfRPMCo3CePBR8I1A-1; Tue,
 23 Sep 2025 05:10:07 -0400
X-MC-Unique: wml9ajfRPMCo3CePBR8I1A-1
X-Mimecast-MFC-AGG-ID: wml9ajfRPMCo3CePBR8I1A_1758618606
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84A2519560BE; Tue, 23 Sep 2025 09:10:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FDBD3000198; Tue, 23 Sep 2025 09:10:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6354321E6775; Tue, 23 Sep 2025 11:10:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org,
 vsementsov@yandex-team.ru
Subject: [PATCH v3 06/13] net/slirp: Clean up error reporting
Date: Tue, 23 Sep 2025 11:09:53 +0200
Message-ID: <20250923091000.3180122-7-armbru@redhat.com>
In-Reply-To: <20250923091000.3180122-1-armbru@redhat.com>
References: <20250923091000.3180122-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


