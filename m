Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B290DE9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswVD-0002ny-Ju; Thu, 19 Feb 2026 00:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswV9-0002mf-43
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:59 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswV6-0001qs-Te
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:58 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4be94eeacso540196a34.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478576; x=1772083376;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hELIrXauNqE+ZhrXSH5RTZ/jc/Tfd3LoGELsRFvc7Lo=;
 b=Md5INYpDZCGruij4LZNcAj8sWhB2bZjb0Alrn+fthM/JE0xOegWVuG3KfsY+W6T/mM
 CqwpOyUVwGd1ciPBTSfTbQR9Lob13Qa23FEt+LwU37UKctVDGNBDgVEqENMR1he6YIVg
 HoZ77k+dDKqqrjUkwb7OQ+weQJejbIKd+0HBwfRXdYZ5ENu+zUTpgY+K1ELSBMEwFP+J
 MTneRwG71NSbzSdfGIADtHWTS5bXuuiYi+jWmlWWzjYKYXH07kPNF7NvKyR0kYDHORHI
 nTHsFywdIE1Ho+sdbejJx/WF30lFouHFigceShXmhKaiKF9NQrbFUH8Vm5KV8js1/g66
 YpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478576; x=1772083376;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hELIrXauNqE+ZhrXSH5RTZ/jc/Tfd3LoGELsRFvc7Lo=;
 b=VOFf5vGaJCo7TbXeDZgacvdxaWEgb9HxvGsCG6hSXyDqp3iK+3JpaGCph32uQ18aDo
 CML9tqKVy8ZeGPjduM+vHGK31huLCOPCk9f0F9p7lCFV37RQnggEKvs2ImMJvXIQSzlD
 CKhNyRAN6RDRF/1tU3eQ5kUIsrwSFA9IaYgsYAnllGM12kStVnV9t5EJKMtQjMpH/ICx
 OCSxYuxYguJd7QozuK/8WmQ9PSSi3O8I8HFSApMZTIms+u+8ES6T/kGMH1JBupopbzcv
 +jhV8diIArA4H+K8MzBTxpyq964eh2C2Z9E5P0ignbKHRRZZDw/dGqeGfMMI0eKdijut
 JBSQ==
X-Gm-Message-State: AOJu0YwS2FvXUZlGID6IYDXF1DUB6q6OgvbwIEQWafMy9MsEtYTA9Y8y
 15qg0YFDYSXjs6iW4i8PmGjQX++Zf4WUQJeI+Xe3b8U/nTiSgf/jB+cCCQDN3r3KLOs=
X-Gm-Gg: AZuq6aKnD88KPSiIYHBCUO4FpguxfOy6xj7f3nZyCffxMNLaJx69sEYXNz+KI/OmuvA
 W6JW2Clptn3ty2r91WcxiELEaU3RzDOgzs3k8qVJJsXt9jmn9Ztutqq0ETy/cuR/zhN8CjEMCZF
 i57PvZe/EsuQouNwAK3Jd4w9bnAjo9kqsRDtLBFNqdMtwFWcAVkoROseytr2E/XakRGOGoThuE5
 YUC0bQarSjYY2l+R91i3rmAANWZkEpKR1N9TpYm40f0LqEnk5kRhkpC4UW6R1BrOj0FMZ5N6j9M
 604RtheRA33vA7DdQeB8QKtgDquT/zqtSIvV28NgexpOyFhPRvHgGNYCHIhUL1Q9ln5uGZ30qf/
 3K/Uw2FXyvE8e/zd5xwzzOlUGjmFLLpss1/91R0vgIWcJrXYmsO94Ls7ZDs8kMzYtGRftbAXG2q
 9643ia1KBhoEQNyqTzEEkZ
X-Received: by 2002:a05:6820:61f:b0:678:4076:8954 with SMTP id
 006d021491bc7-679a74814c0mr2409284eaf.79.1771478575733; 
 Wed, 18 Feb 2026 21:22:55 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:55 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:37 -0700
Subject: [PATCH v3 14/24] bsd-user: Add do_bsd_quotactl, do_bsd_reboot and
 do_bsd_getdtablesize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-14-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
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
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4sOHj99LpWB59u5VBb95x5FMGfxkRUztfM4
 xtuSRRPiUGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLAAKCRBsHNEofbAR
 AGaZEACUnUKdFBYqmta71WuArxtFE0SGeAFgQmq6JosL/kfp/fGn3W8L9V6WnxDojNTCJUROnXv
 yO8L9b7hvMRMGmJbrctZu8GR7WH2hxo8OugsgQYUmqMOiFX+pi7b/IBM4BuSV4Xv9e2lgQ0C7yQ
 ssaU5PczhgD4znHHZvC631vZoXK6qL8rWZjtNywbCm5+txrlv1E6eIwShKqv61613mqUO5Dm8qS
 vpZ2nLnsNks3dsSOg/4tJBf0wfLtfx7mXyhFk8XWqEDzy1tSXTM+41+ehF9y3V6jjCDc1vwv6nh
 5357rIQL0I4mzwhrSPUVWzNyqn2YSsBHJC7ahemDmIzQd5GemoI49Hv7MmfFsjFdRsOuU9jnevW
 7NqxS0XEdV+u+U1Vfim0ghoinyaaz/3cFch6D88s8TkYJTDQJgoSdfs+6s2Tu8L8YRC8b2xaSpg
 lom1gh4IahfU2+67xhlaAunSqL28mznrW8UvI3nfgi+rUlV9LsQGy5gf89I0vVFC88o/FWCkUNn
 eRVbDgt0qsBMxXOxDsHil+phj/Dcq9J8HvYrUZYW9h6yoLq8Rns2NtgV3xziEu6IlK1IfwBfMzA
 i1ksGiUkM8wZmEAoqPnYwlD/Vwj1WSe+1IrtTkfeeVxXxUh4g2+TWsf9k6KNItodundFO5lLyq9
 rIfvOt9CUFQbESw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32c.google.com
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


