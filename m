Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316FBD58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunC-00014C-6T; Sun, 01 Mar 2026 23:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunA-00013i-Lp
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:00 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun9-0006ru-88
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:00 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4ba9abbecso5150771a34.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425318; x=1773030118;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1yAsyWprmLxqoqjwH7tCP0vAzHeK8o5qjeLFqyLWNs=;
 b=d4839Sf7vx1Vga4w7G9alt/zNIoEYEbhZBzFsXPOKYih/+KbDvcVknugWgjQhJISJ/
 PJ45AyAmAmKCzThVioAExyMqjpxihM5RIEBAjzwDPcZzbYZttL/5LVywA6NfKp9jAlcx
 CNIHs0m01S/ONdUAtIzWfevekLdE0OzheTQ4KiQ4Xzf6GTfKK+SBB4mUyMkaFfC409xD
 tFUVuQmQSiEI6ytnLOqCnMqmbsf8f8c60iAqxc2LvUHDd3K45UTYIYkJngYeiOoHM0jy
 /utaDZAIwh/+I52jBcDxhbhB0ukNd2SyGwO6a8al6zWgcqk7LEoGNVZJMh12oUyRdz5A
 b7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425318; x=1773030118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I1yAsyWprmLxqoqjwH7tCP0vAzHeK8o5qjeLFqyLWNs=;
 b=A7BQzUQUuyNHGaVa0bmdyzi2wXvqbAARIh5mgdibDdMhX4Mz9hoM/zspdsZVK+vpyZ
 GTm47uyAsyKACcjPJ4Ct3tgfqe6DirGxs9y1Cj1EwdqH32TepxyTncg2j+b/jdX0cno/
 K/ihFmiiuA5XMiI8G7n10ilZ3BXqUB2KUMFIh2Ck7W9fQR/Z7Cz6kUd8iAmjtJOGoA7u
 OuysNoSp/3vyZTspx0y02r4nDttZKZjhaqJnnC3F6axUyz0fIdEYSGNADGF7EdN7Xb2e
 u7nlQHMTQpE+cFw9XWMHUUcPQO07m6UNzZhOrt8qRpsB5yTP6Eh87ra0XYR0m4hQd7+6
 bkUA==
X-Gm-Message-State: AOJu0YzziPxH6iDVWqUdWElAr39364C66NFy0z3H5lT8iPR7rmSdXH9M
 GDENMMM3IUjR5xcQp4KGbZmBA2U2wYIc7TtKgxjlAkOkYV82puasNidIeva0TrYn1ReQuT7nFPi
 DLvq8
X-Gm-Gg: ATEYQzwarawOk8IErZk2MGbL+/06atHx8CFZNA+BjdjMNT3dKMIO/RiEd50N097dm6O
 8jY/dSccNFtZIe4Y37h6qq1Cvrzz9NHiQBMo3cO+9dpCTGlCliAjpNsu1Pq15MOZdYezPsQf0ZP
 qM+qxauMpkL3dUiIp1RbHGED2/5MLHOndmR9psVleIwVLPebXOIS2p6miAf56w/SVrZw4Vk5s7s
 2zk/NiIJ1GptxzGXsoA2b05QN2PiuYBqXlCdDx7962RHDyc71RB0huR+p0vUE58SaurIv6GUW1U
 F9PjrJLepcg3pWe3x4XJPzNMl6wj3Z7gUVPnPQolj8+V0cIppWGRQgqvwo51AREr6PZBkr7bvc5
 zapQ7RvOJvmMJtcSCEq6mwRqMVLc0GvNQX1506+kiikP+EXKvZ0hUgVOTvvVPUNY9cQ0A4udf3L
 x5x3ubX7fPyA==
X-Received: by 2002:a05:6870:910c:b0:40b:66d:1118 with SMTP id
 586e51a60fabf-416270badacmr5886402fac.55.1772425317802; 
 Sun, 01 Mar 2026 20:21:57 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:57 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/27] bsd-user: Add do_bsd_quotactl,
 do_bsd_reboot and do_bsd_getdtablesize
Date: Sun,  1 Mar 2026 21:21:04 -0700
Message-ID: <20260302042115.83410-17-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add some trivial misc system calls: stub implementations for quotactl(2)
and reboot(2) syscall; a trivial do_bsd_getdtablesize that calls
getdtablesize(2).

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 bsd-user/bsd-misc.h

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
new file mode 100644
index 0000000000..7587ffd605
--- /dev/null
+++ b/bsd-user/bsd-misc.h
@@ -0,0 +1,41 @@
+/*
+ * miscellaneous BSD system call shims
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BSD_MISC_H
+#define BSD_MISC_H
+
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/sem.h>
+#include <sys/uuid.h>
+
+#include "qemu-bsd.h"
+
+/* quotactl(2) */
+static inline abi_long do_bsd_quotactl(abi_ulong path, abi_long cmd,
+        __unused abi_ulong target_addr)
+{
+    qemu_log("qemu: Unsupported syscall quotactl()\n");
+    return -TARGET_ENOSYS;
+}
+
+/* reboot(2) */
+static inline abi_long do_bsd_reboot(abi_long how)
+{
+    qemu_log("qemu: Unsupported syscall reboot()\n");
+    return -TARGET_ENOSYS;
+}
+
+/* getdtablesize(2) */
+static inline abi_long do_bsd_getdtablesize(void)
+{
+    return get_errno(getdtablesize());
+}
+
+#endif /* BSD_MISC_H */
-- 
2.52.0


