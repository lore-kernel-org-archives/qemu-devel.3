Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07D7CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzx5-0001AB-LX; Fri, 15 May 2026 17:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx4-00019H-41
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:10 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx2-0002qN-4X
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:09 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbec19732eso371475a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880007; x=1779484807;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oBAWkkIXQwxa/hU7AI/aeM5McIKkTJKsiwHaCGzLE90=;
 b=R/FEKKCZwtjgqMBoIHcqMriPvgNLswu4me62otPoVZpeZrNV6VKgidx2mY6FZ+mlD/
 LIQy1nyt+yi04lAZnJaGuB3MUXKxynEG2a7etEV/fWy2t1AaIxvRRhbep2tHl/6GFUey
 EnsyfDmYunlddiL/gtG02s9I3ewp2s1H/C3SojgPOf44zDryOwFVe/jHmosfUvN3TKb7
 2Qgq5gM7xmuLfy6LIlQjoGW3I64PxcrWh2GJb6ZWoHhNa0McJMK+3yUNw7kfqRRTbOwY
 gvAIOF2YkajrHTx1RQzpP9vDTrNRDIYxfhPdv7X3hGg8vRhiTU6XtcrKcIj5NKLfXL4V
 kirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880007; x=1779484807;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oBAWkkIXQwxa/hU7AI/aeM5McIKkTJKsiwHaCGzLE90=;
 b=ElvbHPkp0MK3mVH5a/k18A4EI9559NWK2w4ucns8F/YRLLhAo9s9OjJaohd6/eW0K+
 cDz4pNz4L0MPCCLsmnR3TVqZiOheniEfMVt1dbTGsEH18CXX7HqLLVXrfb45fyvkBvy4
 joiGUr8NatzDJ/jqIh8i3hxqhZCTal7bjWGTLihvYg7eppnE2UocXucmgxyaeKyIM54P
 bzKGnvIhE1ICWnJdYMdFQYZnrCervPqbRVaISU1A141CeMZKIxl5fz44x66bdY9vitFQ
 w5MvGar5om8QXqesIeRwMxpQ27Ebb9m7u1hmUmaP44T0Y5n6OENSJV9MlZTkW8m94RDM
 Sq3w==
X-Gm-Message-State: AOJu0Yz8adXcaFi4V0dUzwjp7Heuvjr/5JO6OoryZeWNXGhWCjwbkybC
 mp4cXW//ehQzDyjQFpM+p13GEYg+0YGwUwBhXXr7/d5mYFRYtbMlseGZbOoMnAXk2Kw=
X-Gm-Gg: Acq92OH+7e5ZYeka0B+D8enNoIVOMRMKOhg4X9MSMpSyFTzsqFjnYD3qzo7wZf2Sqfp
 A9qQnFBXjefIJ5ubOUtZkQJzcXzVac1Q8Ad+ar1sKLWLye76JXfC+CyW58OsLjwraBuiaLJRp8/
 H//ZhzFN8JeLRkbdRYiFFfxdZJRbQ+oH7FsBXk+arQ9Lvv0ejVUyV2GE544j71XgwLWlBiYqRng
 ao2lfBSL7HBdFs1z0d1hlW/vu9E6xhe/9qmd8FahboFg4BId1I6IhegIV/kUEnr5UBKh8PLpb51
 xGJDpdGwwT10wMK8yAYarEF4JUF2STEYDkNSYFftwk+ecLQKoWQ6MACiIjNtLSnZRMej+5aLqvs
 dBjsovEYz6ceVmx36xmRntCod6kLR9BzdaYp5NH5F8rdvd8/lDiXixAmLpBQpVIkV8fUeXdodhA
 sCfaEyl+ZPWQ==
X-Received: by 2002:a05:6830:6d47:b0:7d7:d510:4bf9 with SMTP id
 46e09a7af769-7e4f2b1c9d5mr4009114a34.12.1778880006778; 
 Fri, 15 May 2026 14:20:06 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:06 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:06 -0600
Subject: [PATCH 07/66] bsd-user: Add os-file.h with pipe2, chflagsat,
 close_range, and more
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-7-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5255; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=7vnu695aa0jALtwrU7g7GEc5cgKyz0AD/lhPRKnS0Bk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43hXseM3bISxRUhE09kvGu6xdFhBszLgWxBx
 s9oq8b+gBeJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4QAKCRBsHNEofbAR
 APMTD/418q6CpM+sdbiias+htV4X+buJqj3E/w43UXtri8ySLg2GEu43iH0iUIUqJ+QZWKmjcrL
 ivHP9udzH1ii6tJVyBmnoJL6zvbCb+k78IgiFfDSVtpfK29y3HXUvawW78Bv7DyCCSY2wnLu0jV
 ua+6L4+L5ZVFmWORKoctow2phPc/ufCmW1MAe1170h6s/5RJjUICC7K4eEBSvw4hRbUra8Gpu6v
 ZHcHR9FNMRV8gnv9o3DV3U1cWu4J1cYg8wODejntFE+AHxreVq9d/AADcVFi4dCDxp2bjJPQNP6
 qfgKkmOYl2hvO6UFywXxos45GWIPVldPDDbU72HZXGbJukmNMdn67FeBkcNn8LDzvjalyvjI8OR
 LuBSFIecQmKbLAtEG1C5DLfWHgKT38vx/y17vErGagBFCsuPLZxIs1/3wf86SmW/JYXWgRv6DAZ
 XjgDfz0Dgd13HNnF17nJHN5PfkC+aCoTgInqg7mA1ol7zmhKbw57ZVca4JmafDKwphvoMFwYTu8
 XZ0Y2yNqDsQton8qFi6+tkEnr+2iLTtCWGt3jDKp8mmyGpPyYT+AvZ+dopUmUM9h3aqoWq8ULT1
 6MivDZssoJRuWChVhIhu4UudSDnc7zlSpCsCksuVgnj3MKgjHsWAMJnfktJoedMaTPSuEafzyJJ
 Wde2nNLzGPTnFgQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add FreeBSD-specific file operation shims: pipe2, chflagsat,
close_range, copy_file_range, and __specialfd. Also add the
safe_copy_file_range and safe_ppoll syscall wrappers and the
target_specialfd_eventfd type definitions.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-file.h    | 126 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   7 +++
 2 files changed, 133 insertions(+)

diff --git a/bsd-user/freebsd/os-file.h b/bsd-user/freebsd/os-file.h
new file mode 100644
index 0000000000..bc31064a50
--- /dev/null
+++ b/bsd-user/freebsd/os-file.h
@@ -0,0 +1,126 @@
+/*
+ * FreeBSD file related system call shims and definitions
+ *
+ * Copyright (c) 2014 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FREEBSD_OS_FILE_H
+#define FREEBSD_OS_FILE_H
+
+#include <sys/specialfd.h>
+int __sys___specialfd(int, const void *, size_t);
+
+/*
+ * Asynchronous I/O.
+ */
+
+/* pipe2(2) */
+static abi_long do_bsd_pipe2(CPUArchState *env, abi_ulong pipedes, int flags)
+{
+    int host_pipe[2];
+    int host_ret = pipe2(host_pipe, flags);
+    /* XXXss - flags should be translated from target to host. */
+
+    if (is_error(host_ret)) {
+                return get_errno(host_ret);
+    }
+
+    /*
+     * pipe2() returns it's second FD by copying it back to userspace and not in
+     * a second register like pipe(2): set_second_rval(env, host_pipe[1]);
+     *
+     * Copy the FD's back to userspace:
+     */
+    if (put_user_s32(host_pipe[0], pipedes) ||
+        put_user_s32(host_pipe[1], pipedes + sizeof(host_pipe[0]))) {
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+
+/* chflagsat(2) */
+static inline abi_long do_bsd_chflagsat(int fd, abi_ulong path,
+        abi_ulong flags, int atflags)
+{
+    abi_long ret;
+    void *p;
+
+    LOCK_PATH(p, path);
+    ret = get_errno(chflagsat(fd, p, flags, atflags)); /* XXX path(p)? */
+    UNLOCK_PATH(p, path);
+
+    return ret;
+}
+
+/* close_range(2) */
+static inline abi_long do_freebsd_close_range(unsigned int lowfd,
+    unsigned int highfd, int flags)
+{
+
+    return get_errno(close_range(lowfd, highfd, flags));
+}
+
+ssize_t safe_copy_file_range(int, off_t *, int, off_t *, size_t, unsigned int);
+
+/* copy_file_range(2) */
+static inline abi_long do_freebsd_copy_file_range(int infd,
+    abi_ulong inofftp, int outfd, abi_ulong outofftp, size_t len,
+    unsigned int flags)
+{
+    off_t inoff, outoff, *inp, *outp;
+    abi_long ret;
+
+    inp = outp = NULL;
+    if (inofftp != 0 && !access_ok(VERIFY_WRITE, inofftp, sizeof(off_t))) {
+        return -TARGET_EFAULT;
+    } else if (inofftp != 0) {
+        inoff = tswap64(*(off_t *)g2h_untagged(inofftp));
+        inp = &inoff;
+    }
+    if (outofftp != 0 && !access_ok(VERIFY_WRITE, outofftp, sizeof(off_t))) {
+        return -TARGET_EFAULT;
+    } else if (outofftp != 0) {
+        outoff = tswap64(*(off_t *)g2h_untagged(outofftp));
+        outp = &outoff;
+    }
+
+    ret = get_errno(safe_copy_file_range(infd, inp, outfd, outp, len,
+        flags));
+
+    if (inofftp != 0) {
+        *(off_t *)g2h_untagged(inofftp) = tswap64(inoff);
+    }
+    if (outofftp != 0) {
+        *(off_t *)g2h_untagged(outofftp) = tswap64(outoff);
+    }
+    return ret;
+}
+
+static inline abi_long do_freebsd___specialfd(int type, abi_ulong req,
+    size_t len)
+{
+    abi_long ret;
+
+    ret = -TARGET_EINVAL;
+    switch (type) {
+    case TARGET_SPECIALFD_EVENT: {
+        struct specialfd_eventfd evfd;
+        struct target_specialfd_eventfd *target_eventfd;
+
+        if (!lock_user_struct(VERIFY_READ, target_eventfd, req, 0)) {
+            return -TARGET_EFAULT;
+        }
+
+        evfd.initval = tswap32(target_eventfd->initval);
+        evfd.flags = tswap32(target_eventfd->flags);
+        ret = get_errno(__sys___specialfd(type, &evfd, sizeof(evfd)));
+        unlock_user_struct(target_eventfd, req, 0);
+        break;
+    }
+    }
+
+    return ret;
+}
+
+#endif /* FREEBSD_OS_FILE_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index fc6273a780..8a25be4ac7 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -45,6 +45,7 @@
 #include "os-stat.h"
 #include "os-proc.h"
 #include "os-signal.h"
+#include "os-file.h"
 #include "os-misc.h"
 
 /* I/O */
@@ -66,6 +67,12 @@ safe_syscall3(ssize_t, writev, int, fd, const struct iovec *, iov, int, iovcnt);
 safe_syscall4(ssize_t, pwritev, int, fd, const struct iovec *, iov, int, iovcnt,
     off_t, offset);
 
+safe_syscall4(int, ppoll, struct pollfd *, fds, nfds_t, nfds,
+    const struct timespec *, restrict_timeout, const sigset_t *,
+    restrict_newsigmask);
+safe_syscall6(ssize_t, copy_file_range, int, infd, off_t *, inoffp, int, outfd,
+    off_t *, outoffp, size_t, len, unsigned int, flags);
+
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
     struct rusage *, rusage);

-- 
2.52.0


