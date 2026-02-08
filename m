Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCBBEF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpASu-0001vS-4J; Sun, 08 Feb 2026 14:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARK-0000f4-EE
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:28 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARA-00005o-4z
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:26 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45f10d7eb81so752155b6e.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578803; x=1771183603;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fHX/C77dVsk06cG8hV5catnZ7KSymcawlwSMRwrkU3k=;
 b=GxysoJ+fP7M+1jP8oi/lv2eI0r1SV+/tdizJqZx6T2KE8NI7o9Xx10Sr6mloPzmQr3
 bIIVk/J/i4mAiZnSEH3YwO74KZWgaedi4/N+rAbFQh8cZQB49QjzX29WYVzWGfjK+RI2
 bHuKScYRm8sL2q1GiC/mpDI07h/liCrALZ1/lVnRJ4cpYaYCFb79Y0UgtpkMa5L5YRqP
 /q/WBCPCy49I4z1Xow3GiBI0kraRBlsDz4YAu3x2dOyyoh+QD+/cgEfuCJXRjLplKhig
 OInzTl1aPsDA2aTs/xdvNlBU1mBOyTTRWnBVRzDwQ0EqvQVbKlQqf3Jj2sS7abkdsnzN
 Qadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578803; x=1771183603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fHX/C77dVsk06cG8hV5catnZ7KSymcawlwSMRwrkU3k=;
 b=QMm9Q73W9guDWTtoUBwMHA6B21asp58PaLCWrnPUYling4y8K42KhH8XUmKWcZHUtQ
 u9jwnf5ZPyUl2u9DDVYY1KCfeiT1jLNppag4F4g6HSsm70RM2a0pe82r0kP7cBAVZF3d
 bErY5MAt7DDMTksGcSK78asojIuqfaxxhvMiK+p/o2OUR97OEFPj1Hl+5YyT1XCklKnr
 PfGY05+SgBMTH3leJP0bOx9cSqWqGgbAWl5QgNdy04IalGcbFH5xENpJBJ8M9jV3xHLF
 PWoPjLFV3cBlIvfxgmEEYb4lRz495f9IPGHB5y97j7ncu6o1UDwh44J8QitKzyq0WkVz
 QGEA==
X-Gm-Message-State: AOJu0Yz9q3Psu6VYW6w33OJnYlL2s+fbfzg9y8ShuH5opyeItUVQ9Uus
 gLZAU9mDeTp/zt7dpNuSzQIiq0NdfdOjOW8JF/z0WkGw9t8n/oRfmlincQMIPTU6cic=
X-Gm-Gg: AZuq6aJi3C16IV839drKoT6+UDIyAZtXWVVkMjrtESRpftxT2U+gHWFNy/RTCAkZPUu
 mU+xYUIflsiH1wsctZlP3s4dSWmsLQZFywP7S61BJatrL7Qk6XFsjyUQjNg2A81UxEuxX8YOCFS
 CLSJb5c5rNu+EW6nAexFPjFh728h4jmrypY2BpHSKCNPfff6IB379jBven0ghuWSONe9DKGu+g/
 YF4NucQCd0+KLNdqEZds57nIF/sAYc0kFE/RInFnBkP0rMLeNhwuWqTwJj1FU8XC/4HBZKEfrFO
 R/FkrvN9oPgwGTWXBLVqL/J06ceO7dSf4MBwpL8snOzYTy1kcndiqItzX7UD4/I7qNOhm0PNN6b
 AoROSur5RgvLOUjzr4YSc38Vxe4q/5ourr3xIFxP02CZy8wCil1aE4giu20+GdEsWZOAsn/kvvA
 ==
X-Received: by 2002:a05:6820:1f02:b0:65f:7470:38bd with SMTP id
 006d021491bc7-66d0c854e6fmr3810715eaf.58.1770578803563; 
 Sun, 08 Feb 2026 11:26:43 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:42 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:23 -0700
Subject: [PATCH v2 14/24] bsd-user: Add do_bsd_quotactl, do_bsd_reboot and
 do_bsd_getdtablesize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-14-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Imt7rQSgusaioMj0Y0+cyIkXWLoDGAvpFv+XWUgK7O4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONhqCEKoDeVrCb4CpUgzoWn3D1ugMmZ+VQXH
 ujbGDtFFdaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYQAKCRBsHNEofbAR
 ANQqD/9AIMYT7uRmQKyc4imW6ZJdYza1PGO2sSutksn8MEJLYoBw0wR+oCwz6mi/9oh+07mzn5K
 zc8yfbr8+Le/6fPz0hCay0Mgkk2RPHe4p42SDO6LiGSxTvKQmTBFtneY8Tw73xccxKtdqfmPvwI
 CPhu/qJqp0O24lkFUtMuH150kqM2QKHBrLq73CaI4Go60un/YNm46Zp93DwwyjlDDj7ClLl+581
 nnJG62RJycKm1n5X66Yg0mOYHfWc69rQdqRqseWV+sLhsDi5E68YWVbb8dlh/2qbiI8Z/iGJqxk
 ghnPn4P7LW1yRG0STBlUhR7igh1JEkSXlnnZ0B8qsl+702IaI6adiBZzTB/KvH40KLyfsFu/PC3
 yijzWxB+YKWK4JT03Zru6HaOtGui5RvP93OrnCXG05Z+xPbKfpGJ2Y+S8EKPqkfmZ5cDsEm/98e
 cg/fwPgmab0ve67tXyyUbmXtD0uSv1fWojHuNjqv3Bc9H+uB5erisJqDVnY2RTKKE3KYRs26hIo
 Lno3h2xQMbVegcdR7wY8V2W9phm/MiDxu0yOEbr0/ZYqP4PBMNUfkWvkG5/ccUg9K2C45J7kPd7
 CNb/r3//YObSpd+917MUkcABx0nnibfvQhMn3ZpKj3mQfEaG5NIizY3X4XV82AA/kQRYv9Ya3ZJ
 otv9dyGz8GOrg/Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22d.google.com
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
 bsd-user/bsd-misc.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
new file mode 100644
index 0000000000..d81b4fbaef
--- /dev/null
+++ b/bsd-user/bsd-misc.h
@@ -0,0 +1,52 @@
+/*
+ *  miscellaneous BSD system call shims
+ *
+ *  Copyright (c) 2013 Stacey D. Son
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
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


