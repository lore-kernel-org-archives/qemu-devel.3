Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001ACC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQHO-0002fF-6n; Tue, 20 May 2025 12:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHQHF-0002UM-8A
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:57:18 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHQHB-0007q8-8L
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:57:16 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad55d6aeb07so129437766b.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747760231; x=1748365031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8GWiFjDTI1W+SwO61thYcMt6WHg8NWgc4ieUAXnmfvA=;
 b=hACHpxpii5C4kXQ2JQDlmiyb3R6THY6JtbLm9ZFHfIjKDp4bZqlGX/yb+Dja3Cq3Uf
 W3tc94HvqsPRThEae+buPNVjyhOuhdo90mLt7h8kFlzVIDH07n3tSQqt6S6SPgEXhhwq
 bx/6uXeVqm6ODK5ZJv1SW8GllHAttO9/anLEEBoxeZVpui9HLbKll/C/MsbawVptlegW
 YTHO2rPVZyMF0jrov/SUe+h+LJ6xE+lz0idVCXgds8QNK4jVSPzF8OpPFt4No4Nh8wwQ
 Eig+dAA+YHbx2R4KTCOulaGKUmPm4WYf0MDVAbehjQEya8gKxmTP1olSrvT1Z4kBxd5D
 XDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760231; x=1748365031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8GWiFjDTI1W+SwO61thYcMt6WHg8NWgc4ieUAXnmfvA=;
 b=eOxwUqClennEV+A7FQlt4muxBX4oesj5EcnKo0SnVX8AoGzamzzhahAQKbMgcnAlVL
 cUHdUkDTXSBu95iyDNRb2H2iwqrHeOpclUQcjcca+Tt8YybrYwg1Nc2CAlnr/B5XpKes
 oezORYVpw0l9B5poPbCspFGvwW5NUpidjyFJFNE9OMeDI3Kd/Ws7dMsSK5CbcJmRFgMS
 W/19LtxyuGVTN6qR9OohGpiiuED6dp3lEUSsFXcHI360RWAHJl+wQ63Qbqdgs39QJ4bx
 d0TmQizl00DOKX68+2mSxA1Feei00JDXiRm0a6dYMkggAzSOPsWxYmj3DrTf9VBMif8J
 6qoA==
X-Gm-Message-State: AOJu0YxKIyxWIe4i53rWx5XXd8CBWSKAdLT9ClSzDzWPvpcZ81QgiZPr
 oMI0Fih+cGfBsVbxD890rMfqBrPfmT42jm3+F/Nlg5xcaTFwihv7CK+/dP8q5JwHT5HX5AJSE+2
 9umyNz1I=
X-Gm-Gg: ASbGncvZyU+DlCwqDfiVS9W04wwBOsX68go57w7hkosBD0BmpICsGtjTQB//9mbhsii
 zundtzKewkz1/IH2+ZWoTUK/SNZTPH0uFQ5dsfdkAp/xTvS46E5OSyL4K+HcxzDA/c3dJRwEBV2
 TUAdi/lmXgETug1cCcreHkW5mKQ4Xj5+DvMw3jFOwzt7rqfjvvUZBqjqmWlK6LSfu1BpxFNBEXL
 DjTEEIE0SmhRIro7xS334YbfZcvdQa7h7gh09RGzfQIO5Q4PCAVWzqub907+WiTyZs2lu8SdZub
 gF0Csh8U83Z9wHMVZBWtkFiqme8hpmSYicKxl7XpNvIMbQUaSKkl
X-Google-Smtp-Source: AGHT+IHZqun16VdJQ0G1C7CMcrdF9wqtV6z+4AkH4MKsOnbUUmBPF24WGcoPOXYeeEdH2YnOc/UU7Q==
X-Received: by 2002:a17:907:3ea4:b0:ad2:49b5:8e0d with SMTP id
 a640c23a62f3a-ad536b7f1c3mr1528875566b.15.1747760230711; 
 Tue, 20 May 2025 09:57:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d047738sm762285166b.19.2025.05.20.09.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 09:57:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 354E25F7A5;
 Tue, 20 May 2025 17:57:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH] util: split unix socket functions out of qemu-sockets
Date: Tue, 20 May 2025 17:57:06 +0100
Message-Id: <20250520165706.3976971-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Since fccb744f41 (gdbstub: Try unlinking the unix socket before
binding) we use the unix_listen() function from linux-user which
causes complications when trying to build statically.

Fix this by splitting the unix functions into its own file and doing
the appropriate tweaks to the headers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/qemu/sockets.h |   1 +
 util/socket-helpers.h  |  17 ++++
 util/qemu-sockets.c    | 199 +--------------------------------------
 util/unix-sockets.c    | 207 +++++++++++++++++++++++++++++++++++++++++
 util/meson.build       |   5 +-
 5 files changed, 231 insertions(+), 198 deletions(-)
 create mode 100644 util/socket-helpers.h
 create mode 100644 util/unix-sockets.c

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index c562690d89..578aef13cf 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -65,6 +65,7 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp);
 
 NetworkAddressFamily inet_netfamily(int family);
 
+/* part of unix-sockets.c */
 int unix_listen(const char *path, Error **errp);
 int unix_connect(const char *path, Error **errp);
 
diff --git a/util/socket-helpers.h b/util/socket-helpers.h
new file mode 100644
index 0000000000..f72925148a
--- /dev/null
+++ b/util/socket-helpers.h
@@ -0,0 +1,17 @@
+/*
+ * Common helper functions for unix and qemu sockets
+ *
+ * (c) 2008 Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _SOCKET_HELPERS_H_
+#define _SOCKET_HELPERS_H_
+
+#include "qapi/qapi-visit-sockets.h"
+
+int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp);
+int unix_listen_saddr(UnixSocketAddress *saddr, int num, Error **errp);
+
+#endif /* _SOCKET_HELPERS_H_ */
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 77477c1cd5..a5c3515082 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1,5 +1,5 @@
 /*
- *  inet and unix socket functions for qemu
+ *  inet socket functions for qemu
  *
  *  (c) 2008 Gerd Hoffmann <kraxel@redhat.com>
  *
@@ -30,6 +30,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qemu/cutils.h"
+#include "socket-helpers.h"
 #include "trace.h"
 
 #ifndef AI_ADDRCONFIG
@@ -853,202 +854,6 @@ static int vsock_parse(VsockSocketAddress *addr, const char *str,
 }
 #endif /* CONFIG_AF_VSOCK */
 
-static bool saddr_is_abstract(UnixSocketAddress *saddr)
-{
-#ifdef CONFIG_LINUX
-    return saddr->abstract;
-#else
-    return false;
-#endif
-}
-
-static bool saddr_is_tight(UnixSocketAddress *saddr)
-{
-#ifdef CONFIG_LINUX
-    return !saddr->has_tight || saddr->tight;
-#else
-    return false;
-#endif
-}
-
-static int unix_listen_saddr(UnixSocketAddress *saddr,
-                             int num,
-                             Error **errp)
-{
-    bool abstract = saddr_is_abstract(saddr);
-    struct sockaddr_un un;
-    int sock, fd;
-    char *pathbuf = NULL;
-    const char *path;
-    size_t pathlen;
-    size_t addrlen;
-
-    sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
-    if (sock < 0) {
-        error_setg_errno(errp, errno, "Failed to create Unix socket");
-        return -1;
-    }
-
-    if (saddr->path[0] || abstract) {
-        path = saddr->path;
-    } else {
-        path = pathbuf = g_strdup_printf("%s/qemu-socket-XXXXXX",
-                                         g_get_tmp_dir());
-    }
-
-    pathlen = strlen(path);
-    if (pathlen > sizeof(un.sun_path) ||
-        (abstract && pathlen > (sizeof(un.sun_path) - 1))) {
-        error_setg(errp, "UNIX socket path '%s' is too long", path);
-        error_append_hint(errp, "Path must be less than %zu bytes\n",
-                          abstract ? sizeof(un.sun_path) - 1 :
-                          sizeof(un.sun_path));
-        goto err;
-    }
-
-    if (pathbuf != NULL) {
-        /*
-         * This dummy fd usage silences the mktemp() insecure warning.
-         * Using mkstemp() doesn't make things more secure here
-         * though.  bind() complains about existing files, so we have
-         * to unlink first and thus re-open the race window.  The
-         * worst case possible is bind() failing, i.e. a DoS attack.
-         */
-        fd = mkstemp(pathbuf);
-        if (fd < 0) {
-            error_setg_errno(errp, errno,
-                             "Failed to make a temporary socket %s", pathbuf);
-            goto err;
-        }
-        close(fd);
-    }
-
-    if (!abstract && unlink(path) < 0 && errno != ENOENT) {
-        error_setg_errno(errp, errno,
-                         "Failed to unlink socket %s", path);
-        goto err;
-    }
-
-    memset(&un, 0, sizeof(un));
-    un.sun_family = AF_UNIX;
-    addrlen = sizeof(un);
-
-    if (abstract) {
-        un.sun_path[0] = '\0';
-        memcpy(&un.sun_path[1], path, pathlen);
-        if (saddr_is_tight(saddr)) {
-            addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
-        }
-    } else {
-        memcpy(un.sun_path, path, pathlen);
-    }
-
-    if (bind(sock, (struct sockaddr *) &un, addrlen) < 0) {
-        error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
-        goto err;
-    }
-    if (listen(sock, num) < 0) {
-        error_setg_errno(errp, errno, "Failed to listen on socket");
-        goto err;
-    }
-
-    g_free(pathbuf);
-    return sock;
-
-err:
-    g_free(pathbuf);
-    close(sock);
-    return -1;
-}
-
-static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
-{
-    bool abstract = saddr_is_abstract(saddr);
-    struct sockaddr_un un;
-    int sock, rc;
-    size_t pathlen;
-    size_t addrlen;
-
-    if (saddr->path == NULL) {
-        error_setg(errp, "unix connect: no path specified");
-        return -1;
-    }
-
-    sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
-    if (sock < 0) {
-        error_setg_errno(errp, errno, "Failed to create socket");
-        return -1;
-    }
-
-    pathlen = strlen(saddr->path);
-    if (pathlen > sizeof(un.sun_path) ||
-        (abstract && pathlen > (sizeof(un.sun_path) - 1))) {
-        error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
-        error_append_hint(errp, "Path must be less than %zu bytes\n",
-                          abstract ? sizeof(un.sun_path) - 1 :
-                          sizeof(un.sun_path));
-        goto err;
-    }
-
-    memset(&un, 0, sizeof(un));
-    un.sun_family = AF_UNIX;
-    addrlen = sizeof(un);
-
-    if (abstract) {
-        un.sun_path[0] = '\0';
-        memcpy(&un.sun_path[1], saddr->path, pathlen);
-        if (saddr_is_tight(saddr)) {
-            addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
-        }
-    } else {
-        memcpy(un.sun_path, saddr->path, pathlen);
-    }
-    /* connect to peer */
-    do {
-        rc = 0;
-        if (connect(sock, (struct sockaddr *) &un, addrlen) < 0) {
-            rc = -errno;
-        }
-    } while (rc == -EINTR);
-
-    if (rc < 0) {
-        error_setg_errno(errp, -rc, "Failed to connect to '%s'",
-                         saddr->path);
-        goto err;
-    }
-
-    return sock;
-
- err:
-    close(sock);
-    return -1;
-}
-
-/* compatibility wrapper */
-int unix_listen(const char *str, Error **errp)
-{
-    UnixSocketAddress *saddr;
-    int sock;
-
-    saddr = g_new0(UnixSocketAddress, 1);
-    saddr->path = g_strdup(str);
-    sock = unix_listen_saddr(saddr, 1, errp);
-    qapi_free_UnixSocketAddress(saddr);
-    return sock;
-}
-
-int unix_connect(const char *path, Error **errp)
-{
-    UnixSocketAddress *saddr;
-    int sock;
-
-    saddr = g_new0(UnixSocketAddress, 1);
-    saddr->path = g_strdup(path);
-    sock = unix_connect_saddr(saddr, errp);
-    qapi_free_UnixSocketAddress(saddr);
-    return sock;
-}
-
 char *socket_uri(SocketAddress *addr)
 {
     switch (addr->type) {
diff --git a/util/unix-sockets.c b/util/unix-sockets.c
new file mode 100644
index 0000000000..e271dd3e09
--- /dev/null
+++ b/util/unix-sockets.c
@@ -0,0 +1,207 @@
+/*
+ * unix socket functions for qemu
+ *
+ * (c) 2008 Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+
+#include "socket-helpers.h"
+
+static bool saddr_is_abstract(UnixSocketAddress *saddr)
+{
+#ifdef CONFIG_LINUX
+    return saddr->abstract;
+#else
+    return false;
+#endif
+}
+
+static bool saddr_is_tight(UnixSocketAddress *saddr)
+{
+#ifdef CONFIG_LINUX
+    return !saddr->has_tight || saddr->tight;
+#else
+    return false;
+#endif
+}
+
+int unix_listen_saddr(UnixSocketAddress *saddr, int num, Error **errp)
+{
+    bool abstract = saddr_is_abstract(saddr);
+    struct sockaddr_un un;
+    int sock, fd;
+    char *pathbuf = NULL;
+    const char *path;
+    size_t pathlen;
+    size_t addrlen;
+
+    sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
+    if (sock < 0) {
+        error_setg_errno(errp, errno, "Failed to create Unix socket");
+        return -1;
+    }
+
+    if (saddr->path[0] || abstract) {
+        path = saddr->path;
+    } else {
+        path = pathbuf = g_strdup_printf("%s/qemu-socket-XXXXXX",
+                                         g_get_tmp_dir());
+    }
+
+    pathlen = strlen(path);
+    if (pathlen > sizeof(un.sun_path) ||
+        (abstract && pathlen > (sizeof(un.sun_path) - 1))) {
+        error_setg(errp, "UNIX socket path '%s' is too long", path);
+        error_append_hint(errp, "Path must be less than %zu bytes\n",
+                          abstract ? sizeof(un.sun_path) - 1 :
+                          sizeof(un.sun_path));
+        goto err;
+    }
+
+    if (pathbuf != NULL) {
+        /*
+         * This dummy fd usage silences the mktemp() insecure warning.
+         * Using mkstemp() doesn't make things more secure here
+         * though.  bind() complains about existing files, so we have
+         * to unlink first and thus re-open the race window.  The
+         * worst case possible is bind() failing, i.e. a DoS attack.
+         */
+        fd = mkstemp(pathbuf);
+        if (fd < 0) {
+            error_setg_errno(errp, errno,
+                             "Failed to make a temporary socket %s", pathbuf);
+            goto err;
+        }
+        close(fd);
+    }
+
+    if (!abstract && unlink(path) < 0 && errno != ENOENT) {
+        error_setg_errno(errp, errno,
+                         "Failed to unlink socket %s", path);
+        goto err;
+    }
+
+    memset(&un, 0, sizeof(un));
+    un.sun_family = AF_UNIX;
+    addrlen = sizeof(un);
+
+    if (abstract) {
+        un.sun_path[0] = '\0';
+        memcpy(&un.sun_path[1], path, pathlen);
+        if (saddr_is_tight(saddr)) {
+            addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
+        }
+    } else {
+        memcpy(un.sun_path, path, pathlen);
+    }
+
+    if (bind(sock, (struct sockaddr *) &un, addrlen) < 0) {
+        error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
+        goto err;
+    }
+    if (listen(sock, num) < 0) {
+        error_setg_errno(errp, errno, "Failed to listen on socket");
+        goto err;
+    }
+
+    g_free(pathbuf);
+    return sock;
+
+err:
+    g_free(pathbuf);
+    close(sock);
+    return -1;
+}
+
+int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
+{
+    bool abstract = saddr_is_abstract(saddr);
+    struct sockaddr_un un;
+    int sock, rc;
+    size_t pathlen;
+    size_t addrlen;
+
+    if (saddr->path == NULL) {
+        error_setg(errp, "unix connect: no path specified");
+        return -1;
+    }
+
+    sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
+    if (sock < 0) {
+        error_setg_errno(errp, errno, "Failed to create socket");
+        return -1;
+    }
+
+    pathlen = strlen(saddr->path);
+    if (pathlen > sizeof(un.sun_path) ||
+        (abstract && pathlen > (sizeof(un.sun_path) - 1))) {
+        error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
+        error_append_hint(errp, "Path must be less than %zu bytes\n",
+                          abstract ? sizeof(un.sun_path) - 1 :
+                          sizeof(un.sun_path));
+        goto err;
+    }
+
+    memset(&un, 0, sizeof(un));
+    un.sun_family = AF_UNIX;
+    addrlen = sizeof(un);
+
+    if (abstract) {
+        un.sun_path[0] = '\0';
+        memcpy(&un.sun_path[1], saddr->path, pathlen);
+        if (saddr_is_tight(saddr)) {
+            addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
+        }
+    } else {
+        memcpy(un.sun_path, saddr->path, pathlen);
+    }
+    /* connect to peer */
+    do {
+        rc = 0;
+        if (connect(sock, (struct sockaddr *) &un, addrlen) < 0) {
+            rc = -errno;
+        }
+    } while (rc == -EINTR);
+
+    if (rc < 0) {
+        error_setg_errno(errp, -rc, "Failed to connect to '%s'",
+                         saddr->path);
+        goto err;
+    }
+
+    return sock;
+
+ err:
+    close(sock);
+    return -1;
+}
+
+/* compatibility wrapper */
+int unix_listen(const char *str, Error **errp)
+{
+    UnixSocketAddress *saddr;
+    int sock;
+
+    saddr = g_new0(UnixSocketAddress, 1);
+    saddr->path = g_strdup(str);
+    sock = unix_listen_saddr(saddr, 1, errp);
+    qapi_free_UnixSocketAddress(saddr);
+    return sock;
+}
+
+int unix_connect(const char *path, Error **errp)
+{
+    UnixSocketAddress *saddr;
+    int sock;
+
+    saddr = g_new0(UnixSocketAddress, 1);
+    saddr->path = g_strdup(path);
+    sock = unix_connect_saddr(saddr, errp);
+    qapi_free_UnixSocketAddress(saddr);
+    return sock;
+}
diff --git a/util/meson.build b/util/meson.build
index 1adff96ebd..dbcfbc6542 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -87,7 +87,10 @@ if have_block or have_ga
   util_ss.add(files(f'coroutine-@coroutine_backend@.c'))
   util_ss.add(files('thread-pool.c', 'qemu-timer.c'))
 endif
-if have_block or have_ga or have_user
+if have_user
+  util_ss.add(files('unix-sockets.c'))
+endif
+if have_block or have_ga
   util_ss.add(files('qemu-sockets.c'))
 endif
 if have_block
-- 
2.39.5


