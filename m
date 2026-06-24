Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CC3CDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcLzo-0007nt-CB; Wed, 24 Jun 2026 07:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzj-0007kr-Tm
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzi-0007dA-Af
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+CyLVCmYr4kkIYUQEAm4+vhE3xyEAp/Xrk5Da/iYU8=;
 b=TUmDiptJtrwcXmZFQ8t7fNFvqncpWpLIXvpPD9do1UUnWqrhFJ3pNzuOuYvxCdL1IeextV
 HfTpLlMyer0U5NLUTCdS3UtZflEoEEeJyt/2HAaOQ0n6AHn72Y4NzAUgm+YYcH1EGc/lOB
 reA6OcChgKienh27tRbtbfe4AHxluG8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-TJHMypT6Ny6VKcQBQ8JH1A-1; Wed,
 24 Jun 2026 07:42:12 -0400
X-MC-Unique: TJHMypT6Ny6VKcQBQ8JH1A-1
X-Mimecast-MFC-AGG-ID: TJHMypT6Ny6VKcQBQ8JH1A_1782301331
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97D58180025E
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:42:11 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61F97180058F; Wed, 24 Jun 2026 11:42:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:29 +0400
Subject: [GIT PULL 07/35] glib-compat: add fallback for g_clear_fd/g_autofd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-7-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=irLOfrxiAbZTlFF1dzBMOLxOonS+emEKXBZLXRSOrIM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JmA74NihK1UafBmCqXbDSeM+n1wItAamhIl
 7JizEZpvteJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZgAKCRDa6OEJdZac
 5dBTEACJniTTzaUiWu5QBLNnCpxPt8OxlNJnR/uCqem/+fnX2H81zPBslcJ4jyNtpcz5y36WO+6
 ftQ6MeOGhGB5f3U5jTKM+dTSmQlR1JByn2HY7luqf46e1p0irWxKYJSvljcG5EOAp4Uw+/9y7Iz
 ox6Hflhh9MQrt5uX0ReCg+whJJYnp1Nqye/UVo9bNbZkTSfcIrSRVDxdwdz9G2Z58Unz9379+dx
 y+ioIYgk36s0MV/Jfm5c6vR9Y8CJovxL/knH8xDAIGlHVoUH42CW6DSqrwsZJFBN2NdbWdsbwt2
 ZgG/bU070VRn5aq0qgQNSumtI0PN8Cvf/KhRkiKYFqrOlPk/nUIIVMhg5evAF/XPN8923J5mnMu
 ige8GFWtxZQdYB5gRmIJlMtYh3lLcmoxQJFpvFK8Lx9gX+8n2ebDC/2+v/T0YTk0gsc1XqSi6Ak
 Iz5jmv/z5aKpqbfWL61EscmmR3u17TkLZwLa336vY3nZ7IsYzu6lMYirVmQZYGvo7pP07v8ocmW
 89yOuhoKTHpBKxJZmVryv5e9pu+IwWX7heP0+Vh5h9+TijkCSZlw3NZ6H94T658WR2WEWVhONBY
 EYqZN+IiVxHN+Np9ZmwjKXJHzA1dcan59ebabVioQBcwjUEArHH62IJtBgOW0MYmYmzDW8ju3FZ
 4+VCM3qBfR+ScLQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Those helpers were added in glib 2.76.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-7-4656aec3398d@redhat.com>
---
 include/glib-compat.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 2e32b90f051..32ee2afdcdf 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -30,6 +30,7 @@
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 
 #include <glib.h>
+#include <glib/gstdio.h>
 #if defined(G_OS_UNIX)
 #include <glib-unix.h>
 #include <sys/types.h>
@@ -129,6 +130,34 @@ qemu_g_test_slow(void)
 #define g_test_thorough() qemu_g_test_slow()
 #define g_test_quick() (!qemu_g_test_slow())
 
+static inline gboolean g_clear_fd_qemu(int *fd_ptr, GError **error)
+{
+#if GLIB_CHECK_VERSION(2, 76, 0)
+    return g_clear_fd(fd_ptr, error);
+#else
+    int fd = *fd_ptr;
+
+    *fd_ptr = -1;
+
+    if (fd < 0) {
+        return TRUE;
+    }
+
+    return g_close(fd, error);
+#endif
+}
+#define g_clear_fd(fd, err) g_clear_fd_qemu(fd, err)
+
+#if !GLIB_CHECK_VERSION(2, 76, 0)
+static inline void _g_clear_fd_ignore_error(int *fd_ptr)
+{
+    int errsv = errno;
+    g_clear_fd(fd_ptr, NULL);
+    errno = errsv;
+}
+#define g_autofd __attribute__((cleanup(_g_clear_fd_ignore_error)))
+#endif
+
 #pragma GCC diagnostic pop
 
 #ifndef G_NORETURN

-- 
2.54.0


