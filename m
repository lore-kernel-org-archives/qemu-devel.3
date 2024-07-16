Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A38C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 07:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTcbZ-0004Uw-MB; Tue, 16 Jul 2024 03:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbX-0004MV-JL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:07 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbV-0006Rh-TD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fbfb8e5e0cso32951875ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 00:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721114883; x=1721719683;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gtC7q0ahDp8oBSQjb8wrhk1mVdCAYcUwBwrlKBZsqds=;
 b=L/usko57OVuJgVMzyLZoqj76y2alzfsIIi532QD7Jl0yh+tLyT0pYZSZzQft5K2ZzS
 3K7q4NpDEpB7mLBcev9E/WwBzfi1ti8bbUpaI4h5k8S0HWNSKVxNpMetFFUxg+yC3eq8
 RamuEt6ggNxQ7KWS0CM/ooWQH6E015iryAhTzTVHU00aALPXNcjx/MGG8zwgbo3bP7kF
 xoueyFQJn4Z1SmhbSCUeDbuDa5tasvZYTYg5IFM2y2qSsmdgy81iBHRBCz4DgQ4l5s8C
 mvVYFfutCDbpyFw1WO6vehM7kQ3dj4q1K1QRvzX+sFPtydbb1SQQNag0TdKhCW6R7Q2V
 iQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114883; x=1721719683;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtC7q0ahDp8oBSQjb8wrhk1mVdCAYcUwBwrlKBZsqds=;
 b=nr+mDNYqJ8B+JbSAgKzDm7HkNBNLV6vaQKfemNlDpI06JmK9aD6bUWYhSuL7Z60iuP
 +QJhGsM13qI98MWHCReW4A28qVdnVfe2AIH7bBdqjhJGjN1ojCHrSXESWcL5gjXD5sEI
 Dq5pgXZ0clsXNxRzb+UajD0v+ELbGjzrJpK2OV1ZTsQjezMuwDhkVmZqH2bt5Gvch5tu
 0YO1hjH4wBGYfIXJ50xS2SJR6b5soslfnQ6jLCy9nGAk7CiulHHSxhXhyFxocMvao05u
 ZdOv7z53F63+mVu/1tR2sFKLFXBe/0mtlTcdSg98N3MZqahYQsO35ZO7hbGHc+3MUzzr
 qbkQ==
X-Gm-Message-State: AOJu0Ywuyvo7bJRkef6V8JCUvcUKFeNfgx6TsZ5QJXii05nJWEluHhb4
 9I3C2DZehmSugj49gtJrys6A+lDep3OF2/8b4cD3cWTOBhlBFRa/kixdj2AH2yI=
X-Google-Smtp-Source: AGHT+IH83rGAZMP/1OOd2fQZmoyvUCzUIZFQ4e6Req4vKwqodSM5Yc94pNqraANcHPuVIufvouliyw==
X-Received: by 2002:a17:902:c40a:b0:1fb:72ea:376 with SMTP id
 d9443c01a7336-1fc3da1369fmr9808265ad.65.1721114883573; 
 Tue, 16 Jul 2024 00:28:03 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bc382e6sm51626725ad.194.2024.07.16.00.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 00:28:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 16:27:31 +0900
Subject: [PATCH v4 1/7] util: Introduce qemu_get_runtime_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-run-v4-1-5f7a29631168@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
In-Reply-To: <20240716-run-v4-0-5f7a29631168@daynix.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

qemu_get_runtime_dir() returns a dynamically allocated directory path
that is appropriate for storing runtime files. It corresponds to "run"
directory in Unix.

With a tree-wide search, it was found that there are several cases
where such a functionality is implemented so let's have one as a common
utlity function.

A notable feature of qemu_get_runtime_dir() is that it uses
$XDG_RUNTIME_DIR if available. While the function is often called by
executables which requires root privileges, it is still possible that
they are called from a user without privilege to write the system
runtime directory. In fact, I decided to write this patch when I ran
virtiofsd in a Linux namespace created by a normal user and realized
it tries to write the system runtime directory, not writable in this
case. $XDG_RUNTIME_DIR should provide a writable directory in such
cases.

This function does not use qemu_get_local_state_dir() or its logic
for Windows. Actually the implementation of qemu_get_local_state_dir()
for Windows seems not right as it calls g_get_system_data_dirs(),
which refers to $XDG_DATA_DIRS. In Unix terminology, it is basically
"/usr/share", not "/var", which qemu_get_local_state_dir() is intended
to provide. Instead, this function try to use the following in order:
- $XDG_RUNTIME_DIR
- LocalAppData folder
- get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")

This function does not use g_get_user_runtime_dir() either as it
falls back to g_get_user_cache_dir() when $XDG_DATA_DIRS is not
available. In the case, we rather use:
get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230921075425.16738-2-akihiko.odaki@daynix.com>
---
 include/qemu/osdep.h | 12 ++++++++++++
 util/oslib-posix.c   | 11 +++++++++++
 util/oslib-win32.c   | 26 ++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 191916f38e6d..fe8609fc1375 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -670,6 +670,18 @@ void qemu_set_cloexec(int fd);
  */
 char *qemu_get_local_state_dir(void);
 
+/**
+ * qemu_get_runtime_dir:
+ *
+ * Return a dynamically allocated directory path that is appropriate for storing
+ * runtime files. It corresponds to "run" directory in Unix, and uses
+ * $XDG_RUNTIME_DIR if available.
+ *
+ * The caller is responsible for releasing the value returned with g_free()
+ * after use.
+ */
+char *qemu_get_runtime_dir(void);
+
 /**
  * qemu_getauxval:
  * @type: the auxiliary vector key to lookup
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index e76441695bdc..9599509a9aa7 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -278,6 +278,17 @@ qemu_get_local_state_dir(void)
     return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR);
 }
 
+char *
+qemu_get_runtime_dir(void)
+{
+    char *env = getenv("XDG_RUNTIME_DIR");
+    if (env) {
+        return g_strdup(env);
+    }
+
+    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run");
+}
+
 void qemu_set_tty_echo(int fd, bool echo)
 {
     struct termios tty;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b623830d624f..8c5a02ee881d 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -27,6 +27,8 @@
  */
 
 #include "qemu/osdep.h"
+#include <shlobj.h>
+#include <wchar.h>
 #include <windows.h>
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
@@ -237,6 +239,30 @@ qemu_get_local_state_dir(void)
     return g_strdup(data_dirs[0]);
 }
 
+char *
+qemu_get_runtime_dir(void)
+{
+    size_t size = GetEnvironmentVariableA("XDG_RUNTIME_DIR", NULL, 0);
+    if (size) {
+        char *env = g_malloc(size);
+        GetEnvironmentVariableA("XDG_RUNTIME_DIR", env, size);
+        return env;
+    }
+
+    PWSTR wpath;
+    const wchar_t *cwpath;
+    if (!SHGetKnownFolderPath(&FOLDERID_LocalAppData, KF_FLAG_DEFAULT, NULL, &wpath)) {
+        cwpath = wpath;
+        size = wcsrtombs(NULL, &cwpath, 0, &(mbstate_t){0}) + 1;
+        char *path = g_malloc(size);
+        wcsrtombs(path, &cwpath, size, &(mbstate_t){0});
+        CoTaskMemFree(wpath);
+        return path;
+    }
+
+    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run");
+}
+
 void qemu_set_tty_echo(int fd, bool echo)
 {
     HANDLE handle = (HANDLE)_get_osfhandle(fd);

-- 
2.45.2


