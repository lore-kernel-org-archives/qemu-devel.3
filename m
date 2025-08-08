Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA96C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukI9Z-00079v-0K; Fri, 08 Aug 2025 04:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9U-000748-WA
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9T-0006UA-1R
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754640514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKNHjrkE+SV7LG40jEVf1ht2LSznPIly+hKCp2dcHGI=;
 b=V3nYX2W+rcJn1gkwP/I0ZFz358zfalYUpFd8hPTN0rC4nyTgE/8W+/KVr315yWK1R7WDOI
 KPoUEAiSqx6UqTaL7T2wbi3JZSRbagn37LjVwvOGeQILXlWo+J2T941os7bhpVx0rzVp9x
 /Kkxdk8+Ga/RKyzx86TOm9Ckx7AC5gY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-PRP5d_yOMk-NkE5wPjTg8g-1; Fri,
 08 Aug 2025 04:08:30 -0400
X-MC-Unique: PRP5d_yOMk-NkE5wPjTg8g-1
X-Mimecast-MFC-AGG-ID: PRP5d_yOMk-NkE5wPjTg8g_1754640509
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB4D11800359; Fri,  8 Aug 2025 08:08:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82E24180028A; Fri,  8 Aug 2025 08:08:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C03C21E6779; Fri, 08 Aug 2025 10:08:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp,
	marcandre.lureau@redhat.com
Subject: [PATCH 06/12] net/slirp: Clean up error reporting
Date: Fri,  8 Aug 2025 10:08:17 +0200
Message-ID: <20250808080823.2638861-7-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-1-armbru@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I'm not familiar with liblirp, so I can't say whether the network
backend will work after such a failure.  If it doesn't, then this
should be an error.  If it does, then why bother the user with a
warning that isn't actionable, and likely confusing?

Regardless of that, error_setg_win32(&error_warn, ...) is undesirable
just like error_setg(&error_fatal, ...) and error_setg(&error_abort,
...)  are.  Replace by warn_report().

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 net/slirp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 9657e86a84..d75b09f16b 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -262,7 +262,8 @@ static void net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
     if (WSAEventSelect(fd, event_notifier_get_handle(&ctxt->notifier),
                        FD_READ | FD_ACCEPT | FD_CLOSE |
                        FD_CONNECT | FD_WRITE | FD_OOB) != 0) {
-        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSAEventSelect()");
+        warn_report("failed to WSAEventSelect(): %s",
+                    g_win32_error_message(WSAGetLastError()));
     }
 #endif
 }
@@ -271,7 +272,8 @@ static void net_slirp_unregister_poll_sock(slirp_os_socket fd, void *opaque)
 {
 #ifdef WIN32
     if (WSAEventSelect(fd, NULL, 0) != 0) {
-        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSAEventSelect()");
+        warn_report("failed to WSAEventSelect()",
+                    g_win32_error_message(WSAGetLastError()));
     }
 #endif
 }
-- 
2.49.0


