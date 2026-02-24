Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF3AF3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutb8-0000c5-Da; Tue, 24 Feb 2026 09:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutay-0000Qx-Pk
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:05 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutau-0001J3-P4
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:03 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d19bfe1190so4783724a34.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944058; x=1772548858;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hELIrXauNqE+ZhrXSH5RTZ/jc/Tfd3LoGELsRFvc7Lo=;
 b=wrr6htsKp+jmr8mkOd1OxpVDLAodt6i+ntn60vLsaJOD5/04Ozsk5IYnoXsVDrGn5T
 1iC88enw6iz3vj3skwV3TiJqh+Y0c29V6RlqLshlgQ2KyIXMBWZqFi5sI5SnEMHoLrNg
 RsFCKkOnS9c+20m1SwIL1XQdH4VSAJxszjWmLoJML8DrpyjSHE7f9n1AwhMWaWtZfPh5
 f2ppsYxzwwim+TR50y/lmYVNIwDtTpLto5vALCB5Dfzk3a8B0Vr+IPrOu6RrV1GAfD78
 frbT1m0DKKMaLL2QqeFBjgJSUyBHH6yh1tSepfSP9EJqpzpDDYJK3dvJsBDmBPDmoSGb
 EF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944058; x=1772548858;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hELIrXauNqE+ZhrXSH5RTZ/jc/Tfd3LoGELsRFvc7Lo=;
 b=BgPFENrkWVJ3k5KuxbKSgMJVqpBkeUGsBzMiQ4gI+MZZuSTFr7hXGhLz8gaMRgWxjM
 0wO2IgKmqDQHtAUQsM3+meepUkB9E6qwWPR4Mbe6OIBgjIU/B1trdHNdtrBP0OfO8CF1
 Ui0VZY+6E96AxsA4y6WdoZ0RhwqCrBdgybS+oA9bUEjJeCJHODypoq39KLG/sExNFPUD
 jY5Xk+EdKn9WgHD6QwGEIMxgIzlGP+3otIrmrG5uRbCYMas/+VSD+DGKshMCj7HMzjI+
 AVkCuCc78Mr9T9Hx3jc2PsHPQ/XVBPHTtbhYaQNo33/P793FfCrT8WRdGtsoIxKbkgAz
 m0+Q==
X-Gm-Message-State: AOJu0YzmkxaiYXEyNp6REEAbvngKcIhd95U0YCeAPSbF/3QRYCngVzF2
 i5/gxObFPu2FeuhW1vJJr4WLU2t1OV7RfWCCsqfByxtu0AqRkP97U1FwI/1lyP7pzsZuYK2NBQb
 AjlhyJg8=
X-Gm-Gg: AZuq6aI9spiHmQOIQA7YJCVvp8rJ/WC6/Z5SlFMpi/iHywoQdxOvI981SZd8A1UNyNI
 U22Pj/gsN+Mf/C14khTJZ/znMVlEu3UMIdfQDZWrDWGf6bkzSKgaytdtq+GssLKJ1KptmyMMrcT
 qhlfxg6HMP+86c0xV+vtDGpgCrPZKe2WWr66h4mzE9ebv3nnC85Si4HomyYEwmuuPnJZJUBeQZb
 OUZkRJIeu1xShnAqslTK4lDsjo2yY61q7bZVSEnx1tnSBsxLapYKkKwByvwn+mm280wAQWG2gRw
 0hcH+nEHdILOq7P8S0KY1ogCK/BYCnYgEcCY3upvkDYvSTrGbua0ukRFQbhoFMBeZlDGTnbPnkj
 jcYuCS7ikV4QVIgTOpvnIpqXRtc0sHg+tdZc0C1mux82DiXAW1h2zq0f9fQDgaLcht6umeBRIGI
 L9/x4oVdcWDw==
X-Received: by 2002:a05:6830:2646:b0:7d4:90db:f69a with SMTP id
 46e09a7af769-7d52bf5d332mr6142147a34.35.1771944058587; 
 Tue, 24 Feb 2026 06:40:58 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:57 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:38 -0700
Subject: [PATCH v4 14/24] bsd-user: Add do_bsd_quotactl, do_bsd_reboot and
 do_bsd_getdtablesize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-14-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=yNFZihQIZ8VD3/rJuHGqo1dD0knWbQFa488nV9Osru4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhnwAA/rCjueBAXwMHD5ctQPWlNCD3eJskKx
 CXGJgKGboSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZwAKCRBsHNEofbAR
 ABlmEACoIoXcSpQ0plXtEsD9JRbftV8o0MarhYglaWT5uxAFuWnDG1zy7yPBXkdwq0+4/ssinCp
 wcDmjMVfgNfFo9kbKZgUyqSg0GiN5sMiZqOrhySUZQKDnTjzY/MfO0+EBzuLIbrp2Gmsa+x/NC5
 BdVRtYjp4CAidA3SwYAiB+BqZMJ4XDXONPJg9C7683kCuQl1XpDUV2e/3EdgG2m3Ij7uevXZeZV
 hA3EQLwpcYfWv6hLLqwd8B7J9n99akQl7qmfgSTexHsTM+ELvBevyRKl4L7VT1PefjQRYjR9yYS
 W0o86ZrhjiWJNO5/snP6g0vht5HZGy9RZrnYFhD49aOajW1ctblgi5+pDI+jRAd/9dHVbesExpL
 6zU3fU/ZFNFtkYiBpEOkwvgmQST139+fS2hgOJ2YgOnRad9ohm7NANkykI+oq3FdNkZvce0dke5
 GF0U5K4SHRH5Z+bGY6kL1nz32BadhTxRInXPFOfAM4MVIc9g/Ch5qIFiALeqkeRvBDUabWneTXa
 6QZ2hsPi5b8iSyqWsuFBgVB38hjrq+ShSgPbYvJ+SH3gNeC63e7FSmTevWaaWIvnwcNj53VU4z7
 +p5w/VQJVg8bGx/qTesk87wTD62Gx4hIzUZ1FgLf9s2y1fBJcygqbXCXgDdmFYJ7qwCtvgpPryV
 Ft3K1ZL8lERGLmw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x336.google.com
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


