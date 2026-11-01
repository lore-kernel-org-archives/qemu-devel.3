Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4F606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MB74YPYI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNULn-00083G-2j; Sun, 01 Nov 2026 07:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNULH-0007zJ-Tb
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNULD-0003Zf-W1
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793534834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TYKYNppDjZ2+QFHOmhj7/cGhBC3OPvjqnczzFl+yEuU=;
 b=MB74YPYIjN6WhePNHjr8sOi2fnwRpowPDZu0A8Q/04aculj8VaspsG+T8hCDUiuO21Fo0a
 ZLe1P5Y9KK6Bozn/Y0s2USNBpZlEYoxz9HjfzpUcHFybum7nTXxrKQLMPIAeAbf9poU/IU
 MLY1en3EShyyKaPe5p22He5rrhMPsTw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-iqwwWoAkORqyrH6lPbk7Ew-1; Sun,
 01 Nov 2026 07:07:11 -0500
X-MC-Unique: iqwwWoAkORqyrH6lPbk7Ew-1
X-Mimecast-MFC-AGG-ID: iqwwWoAkORqyrH6lPbk7Ew_1793534830
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B0AD1955EB6; Sun,  1 Nov 2026 12:07:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9080D1956087; Sun,  1 Nov 2026 12:07:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 01 Nov 2026 16:06:41 +0400
Subject: [GIT PULL 8/9] char-stdio: avoid closing stdio fds
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261101-ui-v1-8-8af305cef69a@redhat.com>
References: <20261101-ui-v1-0-8af305cef69a@redhat.com>
In-Reply-To: <20261101-ui-v1-0-8af305cef69a@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=okG3HUjiRm3CoUHuHRbRSC964CXB2rNsWNtet4+T37A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ytOqzY8P7ZZ3m4d223GhP7p8xBDz2XTsXBk0
 hteuCgfQISJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaucrTgAKCRDa6OEJdZac
 5TeKEACUy/MPW/UhRExfLnrar3VzuX7hmYlTOxsTkHoH6MF7VzhrJDRFCqnlS1JpRrfFYN9ZLp3
 7xhp7/btOwDQ4DpokkmzPszfOxW+PzI/ojDDZ1omgxXMMpa7UiJYIOdQFz9aMl3wPR19ZuThoI2
 t8yVyOUABBGAvd1ugXTsIPOhS7I+Xp9nfqSr+V6FE5s7oClJMdSCwmT7H/PXjhxF9c/2rYai8j/
 geaiPzH8wwlqBa/PLMdBgJ2U5HnrmUXywXCeRSYQaqyxhs9kH4lIzZJIODyVBhT2tG+JXZyuwGm
 EASdUnD+/gnT2vgugF7qG2icGzaSt3siD0apiJxWt6vKGWfNyyhKnSTMXpNWDl8lpmkQSAxhcO9
 i8f6sKoz3t/AZVHZqTP7V+gkzJpybNVguafHm+zXF0czkPXhMVH+pDyhaf10m3LWTK5WhQNQOwo
 WTuVKrNGWubw5ohETPUa/R3eNsI3VmMj/hRPcNY4vSGzm0vkZeoNZIO6snJPnL8pl7XDS9TfF6s
 YSdmT3py/nrQhbohF9WyMbpyJ+W6B4pBqzEkItoFvWvz753u7snGpvEqY2Wpx2nCfh2pk7MkP6S
 zKoSTDZKg2inKr45bT5cw3gwDzz0qucl2jvfFKZAqi6G2iT+2bSpmnhE80/DyeUcFwva/B1stFR
 K95oLCk8DBPH6+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Filip Hejsek <filip.hejsek@gmail.com>

Use a duplicate of stdin and stdout fds to avoid closing the standard
descriptors when the stdio chardev is destroyed.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261017-fix-stdio-close-v3-1-cfff0122a2a4@gmail.com>
---
 chardev/char-stdio.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index f63bf413c741..16b49fd924d1 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -114,6 +114,7 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     StdioChardev *s = STDIO_CHARDEV(chr);
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
+    int fd_in, fd_out;
 
     if (is_daemonized()) {
         error_setg(errp, "cannot use stdio with -daemonize");
@@ -133,7 +134,20 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         return false;
     }
 
-    if (!qemu_chr_open_fd(chr, 0, 1, errp)) {
+    fd_in = qemu_dup(0);
+    if (fd_in < 0) {
+        error_setg_errno(errp, errno, "Failed to dup stdin fd");
+        return false;
+    }
+    fd_out = qemu_dup(1);
+    if (fd_out < 0) {
+        error_setg_errno(errp, errno, "Failed to dup stdout fd");
+        qemu_close(fd_in);
+        return false;
+    }
+    if (!qemu_chr_open_fd(chr, fd_in, fd_out, errp)) {
+        qemu_close(fd_in);
+        qemu_close(fd_out);
         return false;
     }
 

-- 
2.56.0.116.g6de20f6092dc


