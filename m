Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75397CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUEe-0007ax-4k; Mon, 08 Jun 2026 03:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEc-0007Zz-4B
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEa-0008LA-5j
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiPRbgAGG9+H5A2Rhy9bpK7HQJj7Pl9u84rDJDqgsuw=;
 b=MedilRb1ApkcDaXMJhZHTIfY+yl8fQSDDtxMiaghczZGgKR8YP+ZQ3ZB4WFlEuyqOsUpFE
 XKsC1kk4hHYOiILWhdZtWYWlfKsuVUp1J52LC4W/6UfumssYphNjTY5QpjTXeaZ/eBRos8
 0ti7smg+L9LQuRip+VUmtkG1fCKc9fQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-CoFDv1seP1mfFXbpPSzoVw-1; Mon,
 08 Jun 2026 03:17:13 -0400
X-MC-Unique: CoFDv1seP1mfFXbpPSzoVw-1
X-Mimecast-MFC-AGG-ID: CoFDv1seP1mfFXbpPSzoVw_1780903032
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10B2719560B1; Mon,  8 Jun 2026 07:17:12 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BD011800480; Mon,  8 Jun 2026 07:17:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:24 +0400
Subject: [PATCH v2 06/33] glib-compat: add fallback for g_clear_fd/g_autofd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-6-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yIivtAt+njPmx4qztb8O8h6ia85KP5LqwxILrMj9U00=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxIgWyIOIRXmjCwAXcRk11LXemF4Y0nTEQZm
 EskNzS/BduJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSAAKCRDa6OEJdZac
 5aiUEACTfCMbkEAocgRTpkAI/x9fRrFeywZ3zQ+3SRAqTkZ4ua5ifb4JYcLJzarY4i9HQPiIrDJ
 fzlxlazgik8VCfDWOzt+zuU8nvwdf8jOzTSELa7rNGYduKfoAVAwSPXJgok+5KXUwlSiH7YFWBU
 gzdQ2Xb2qStB5F1KXBrrg82Z8QXh3XoxuIyM6q0n5sDkvpXY2xdKFJgS3HoIqPYReznixUZnBHn
 0r70Q/G4aYwU0yQS0t8pghPX6aGCLFYfxY1txv8JYjYljtX1GP7SyMQvjxkzFT0YFAfilXJ6KMQ
 TZ0HgAjsWcj4n1nGsdnosX7WKlVib2SKAbOqMfA287HpJ3wH8l3B696uS/w4obu1NouJm9xvffB
 4E0iWBrZaf9NQTlzbtq4/t0BFtqAJmORAV1oJwwYJjQJiJj/O1lDlTTfDI1j1OBFyRLwMWzDIMz
 ezPgSygDQnDO0c36FA+TEUoiwcQd6ZHK+ucPBFnJ3M8ozNtc90QvkSgky+nJkn8vigaltut2uwC
 25YBx5PxVBTsAuYnIXwxLhfx7yO/lWREM+UPp/h9aecxedFv7F06w+aZ4PrLkJveUJ7KtfduaAj
 g4WNxBZLmHxXd61g2/9yQs5/gZB/dILAclbDVGoq1hf0Vc4gAfD0QIIpIeRUQxCkbJTGTHIctkJ
 2oqs/ZGy/vWLJvA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Those helpers were added in glib 2.76.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


