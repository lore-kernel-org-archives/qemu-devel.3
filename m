Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCAED111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 17:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOfsg-0004TQ-IY; Thu, 27 Nov 2025 12:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsb-0004Rm-Us
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:05 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsX-0001Fs-Dx
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:04 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B182B80C4E;
 Thu, 27 Nov 2025 20:33:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:834::1:7])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rXiJgL0F7Os0-9L2QmjXC; Thu, 27 Nov 2025 20:33:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764264835;
 bh=Qrz6uqZ8id/hIeHHI1j4NbP6cH4LsPuTNTQJjCY5ro0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nxKYTMMec3gOgNU+9vpi5tzNSHhW3OF67BYo9APzFcWP2pbbaZ/ZITca0NLRUKceB
 SrzN19oQug15ay44xx2kyyoT5+/JhW44fC3rUxowr78QEcmrAu3dcBCtmfyQeUD4ir
 01WGHT6AX3RNASGEcgvI5MENrtkMxGRVXfySDLTk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: dave@treblig.org,
	armbru@redhat.com
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Subject: [PATCH 1/5] ui/vnc: don't use of error_printf_unless_qmp()
Date: Thu, 27 Nov 2025 20:33:48 +0300
Message-ID: <20251127173352.283731-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251127173352.283731-1-vsementsov@yandex-team.ru>
References: <20251127173352.283731-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

That's not a big deal to print these messages to log, if QMP
monitor is active. And these two are the only users of this
API. To simplify things, let's use more usual error_report() and
info_report(), and drop error_printf_unless_qmp() in the following
commit.

Drop \n from messages, as vreport() adds one.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 ui/vnc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index e6bcf0e1cf..ffeed5788e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3534,8 +3534,8 @@ int vnc_display_password(const char *id, const char *password)
         return -EINVAL;
     }
     if (vd->auth == VNC_AUTH_NONE) {
-        error_printf_unless_qmp("If you want use passwords please enable "
-                                "password auth using '-vnc ${dpy},password'.\n");
+        error_report("If you want use passwords please enable "
+                     "password auth using '-vnc ${dpy},password'.");
         return -EINVAL;
     }
 
@@ -3574,9 +3574,8 @@ static void vnc_display_print_local_addr(VncDisplay *vd)
         qapi_free_SocketAddress(addr);
         return;
     }
-    error_printf_unless_qmp("VNC server running on %s:%s\n",
-                            addr->u.inet.host,
-                            addr->u.inet.port);
+    info_report("VNC server running on %s:%s", addr->u.inet.host,
+                addr->u.inet.port);
     qapi_free_SocketAddress(addr);
 }
 
-- 
2.48.1


