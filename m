Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AECC44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visvL-0004ex-9e; Thu, 22 Jan 2026 06:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1visvA-0004cK-W3
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1visv5-0007Yz-Pf
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769081531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djthdnav+88HYBrzPOQFPUMPX/KCmxP41g/8I8VobCs=;
 b=NOQX+8fWYA5TGC+B2icDDBSaV3CsKGOSTCGkW8ZLGySQXRutyJ9S2YuV5+MIsBMp6NQiVC
 yTZmemT2vuUUW8xjsSvpfuvRicwOBEiYBb1nHuekwcfzkWTZ4N+mfnFVQYrBvRrD7BLalI
 JBWUiDq7hGxpwUNsYeWcith6DOwC7qw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-2fWNiqSPMw-EDoErB8-MBw-1; Thu,
 22 Jan 2026 06:32:07 -0500
X-MC-Unique: 2fWNiqSPMw-EDoErB8-MBw-1
X-Mimecast-MFC-AGG-ID: 2fWNiqSPMw-EDoErB8-MBw_1769081527
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC8B31955D84; Thu, 22 Jan 2026 11:32:06 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF06B1956095; Thu, 22 Jan 2026 11:32:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org
Subject: [PATCH 3/4] ui/dbus: fix Unix.Map proxy leak
Date: Thu, 22 Jan 2026 15:31:42 +0400
Message-ID: <20260122113144.2046899-4-marcandre.lureau@redhat.com>
In-Reply-To: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
References: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fixes: commit 48b7ef0f0 ("ui/dbus: implement Unix.Map")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 407719fc1e0..46264839d86 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -960,8 +960,8 @@ dbus_display_listener_dispose(GObject *object)
     g_clear_object(&ddl->conn);
     g_clear_pointer(&ddl->bus_name, g_free);
     g_clear_object(&ddl->proxy);
-#ifdef WIN32
     g_clear_object(&ddl->map_proxy);
+#ifdef WIN32
     g_clear_object(&ddl->d3d11_proxy);
     g_clear_pointer(&ddl->peer_process, CloseHandle);
 #ifdef CONFIG_PIXMAN
-- 
2.52.0


