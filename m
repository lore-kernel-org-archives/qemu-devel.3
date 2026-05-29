Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB94CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvDU-0001I6-SZ; Fri, 29 May 2026 07:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDS-0001HV-LB
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDR-0008Gi-8o
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiPRbgAGG9+H5A2Rhy9bpK7HQJj7Pl9u84rDJDqgsuw=;
 b=LsO13kWoytQUAAf94CE82JTszqUIk4xNdG0eE0jwfxaU3cDQl9OkP7ue9ol98yTtDk4S1r
 ybwwxMablDfBZ3wMuKo/IsDF/uMicIYrw8hgsc+NfKXeZuYW6SldeptTmtK+05DkmfHwFQ
 VN7T3mw5juU59QazOYKu9kZDYGihf3Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-ZaDMdiGoOg6FZD66XPSgdA-1; Fri,
 29 May 2026 07:17:21 -0400
X-MC-Unique: ZaDMdiGoOg6FZD66XPSgdA-1
X-Mimecast-MFC-AGG-ID: ZaDMdiGoOg6FZD66XPSgdA_1780053439
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E678195609D; Fri, 29 May 2026 11:17:19 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 903B019560A3; Fri, 29 May 2026 11:17:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:27 +0400
Subject: [PATCH 06/32] glib-compat: add fallback for g_clear_fd/g_autofd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-6-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWPc0bZf1mgaQzXersmWjueBos/qYBP4Igar
 Kk2OIkoe5OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jwAKCRDa6OEJdZac
 5ew2EACKAy0oxj/D2Sd0sficzqdvFMRXmBTGNG5Y50blEq6Mx8Nt9Of/tNFZVTTVoMCaSJf9+X/
 c3RGwNiqN+hYUrDPdpXV3jom3xfSJI58W1hvPhxHTMhPoz3jm0N+Q89TSNpvOBtAO0nQ2687m5S
 aEgVTVHPe1vMczG8wcXo9qSKiweWBKyeRz5bqaz5RhNPRfRdnIm0Qc2gbsya0x7iUtvSQa56alX
 5fkEu0ShLnC955aCWVbRdPokNWS4oninU7CW0RHtBXgxaqvpSWMF1iaZBTJ5tI7fc6eVDMzT+bn
 gMWqv2ef68Rr1P1TjkgGfjqEYW3WrESOOJwsYjE6q8kn+F4wwo5fSg6L5wpxfsCcQrbCHlDTRgM
 +1yX0IgzCDHFT9P6rqlctdXpvxtgGZNEj51OQbTRt33ejOUrOd5s/ITfGtfKSFsJalhjgmMUi9C
 WWTGdYkexvxoWKPObiOmQMGlHohynLJYR0cujsLg3MRoDW61ZUtws84tc5imT/kANJStLzEJUx+
 taadarXlZEb7Ved/kN6ydT+2oXH9sIj+MhJkpDDDp9acggDWftl/YDx8rDWi9APgf/227whGoIX
 XS73rd8FEUtwoL8yJ/0P2cCBf0VUpZibvIrUT3nUuZAhKtHODgSh1g1sDTO4AKHt0PxnkM9fbyT
 y18zN54N1gsPUIQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


