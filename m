Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A72ECD98A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38C-0004Sp-3j; Thu, 05 Feb 2026 12:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo386-0004QU-W2
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:00 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37v-0001OU-Me
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:49 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-40427db1300so735182fac.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312406; x=1770917206;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1wC74hpf4AdImk+LbNBMtT1m5MiOKNrfw34XJ835Kqo=;
 b=y9MwSAKijDYE0O6ymxLaYBsTf+Un1Y2gvfCcTIPSN2GE6Ln0juY+BlEPgipDcr2OrD
 Bl51HbB3ZvougatDfCxatvvGeyoHZKA0tYbiSRXhUy0o7zkfFUq+s41sWuo7K2uW7+n3
 CqtQti7YW5XXggxpWcWmzIwF4G+6nlicyVGVFdessqUcR3UCBRQxOdMjlnfmGjUKBgYe
 m6fTuRRR0EmREL8QS2hNB5uAkFG3JscEacFrOFE3gdfp5Hice1nM6bUUq7iPltbkJD4p
 vuLUtRXwKIcYeaF0IcCodRQZdCYPSIXNhVdHA0unrpe0gcE+zUr0s7d4AxELiBUasVxt
 JYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312406; x=1770917206;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1wC74hpf4AdImk+LbNBMtT1m5MiOKNrfw34XJ835Kqo=;
 b=pPVTJicsoiUIeuXWolgilsVKDt6FxGtrsqBw0REUaVcwnmRujdk5YRAmi5goxEXNXG
 tKnM+G1YzC9GZj13lkqArwdF0sD3bISxZRXO9r5f4Z2mpGub/DCp7t9Ir3i9ZgxPWIjC
 L/m3CuBH2GpDALCeMypIUA/JQehXDIeXFW+vdmrBlMx7B5tejHdmi9ZKe3PyDV25SVzg
 HMNQ8WRKw/TxtWElR6Dmv7cG8suvsQuvAT7fstmHOjMaqhB8hj1OGaz3a8yVQKgKfQO7
 ENyrVcO2BLAJ+JWCx13wqKuwmoHQS6Wn2TTcg3DARQIUEcOlf8TFOeAaXVBLLj8AgMXA
 VN0Q==
X-Gm-Message-State: AOJu0Ywr64OpUT1MlWzX2cWLSsB22ScEJUH8RIr1vKt6swsSZy2P0D7C
 WC18lwQujbnyOK4dIH+Mx8cEt+IYQeEQA6SXXaDFfCPXdzBKRUmuyq8xfr9g7qVmG70=
X-Gm-Gg: AZuq6aJ6TnSEQLOO5sJn1IMyQ3zACS0VDv4RrQvFlqrKFYAcnj6tsYFKvkpuqNLbwQg
 FwB7IHMpNFX7pJpAierXQs3QxS7phylmeoqYDt5TSInj3VQigdcsMduLl4m8f+XmeNXvlU5BBRL
 /xHz34Y3MuC5spMTH0SRFdySNz1tBlHvwrz4NAUkZnbBUke9IdAoMxYruE9roDbeuB5YLEtEAVY
 UpXRe+RYHSuNUeMtPBXEVzfXJajg94UDzrU62MPtzQUrCRGk/jedB5R/jGba7CTYivUSUsqNa53
 vJ9PaG/tQLEVIlFe0ihIryuxshtH7W9i4Ot2Vq9h6xcm81e/jfwdu360ghTPa2rOgBc8B6R04sl
 Vdwf9ETW46OALANO9Hsnb1p8sV6N+vqtVV7bQsTGPqIJ0ZUNcOdzuTDyEY3vBpi31qat/AawYpA
 ==
X-Received: by 2002:a05:6820:468e:b0:65e:f5db:f478 with SMTP id
 006d021491bc7-66d0a667b31mr57814eaf.22.1770312406474; 
 Thu, 05 Feb 2026 09:26:46 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:46 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:39 -0700
Subject: [PATCH 06/24] bsd-user: Add host_to_target_uuid for uuidgen(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-6-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2197; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=98kWg2356QW8wyWPrlsuqf7iVrghL8bWmO1wpYrNWdM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLaMQd1g4SHJp474WWkYLHQZrkb6G6zLmixZ
 Z9vXJfP/QCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2gAKCRBsHNEofbAR
 ACz6D/0RtzwqS8b8YhKNbc35Xbfb9A279oanow2DMHtMSwizYhNXK28CQho6Zhwye68T2bWfdXN
 LCWuNsu4IAOAwJXGXCJal9j5ggl84YDcFOU1nRCnnUJ9VKR3mPVy6wHTcVdVQI+sdNfA7t4HNqa
 dsoScG2CT9+vVhdiZYAmLE9OtNAKJFW1d0WWMdVzvc3rLSJMOJ6vchpBi24IIbB+Hm81mcHMZIC
 twYH7nLGyzJiGSsJe1CfxdoMEupNrim3CjAzP57ocBWN7cDv/tU6tlu9qmXacxHQbbephAJy0I8
 IHawhIa9gdeX7ZcGlUEPHYii364UGW62fd9H0rOb4VZxgClolV1zKOuiyjtOtptk0YO9J7M0SPP
 QX4y86jxFMyg5ElRqJrqYvcOYYrHzJKV7MzkyxWLUNkHRB0fWJnpYNzcjvqtqhuFpXrV0Ah1M7I
 i38tImbL2+UtzK/wuC71Xm2gbc33Js6rKFvwD20SbDlh3YMobYobsUO3PqPPmQiwLAMOQSe0yLi
 RjC5wHgR35LjDnsUuYSB+AtJg1b26mNAqo0m5jxDbsZwNyhDS2xVKwwal+akSpy98779u0Fc+xA
 OssWAZ4zJLOPeZxA9xSV9rwNu+iMvD50Fh/Pon+yNfVHj1GibrqXQjvkRU2y1Jw8AeCtEyVQaTj
 CAhEf6Bi5VxkUwg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2e;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2e.google.com
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

Add host_to_target_uuid() to convert host struct uuid to target ABI
for the uuidgen(2) syscall.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
new file mode 100644
index 0000000000..d2107b2f85
--- /dev/null
+++ b/bsd-user/bsd-misc.c
@@ -0,0 +1,46 @@
+/*
+ *  BSD misc system call conversions routines
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
+#include "qemu/osdep.h"
+
+#include <sys/uuid.h>
+
+#include "qemu.h"
+#include "qemu-bsd.h"
+
+/*
+ * BSD uuidgen(2) struct uuid conversion
+ */
+abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid)
+{
+    struct target_uuid *target_uuid;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_uuid, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_uuid->time_low, &target_uuid->time_low);
+    __put_user(host_uuid->time_mid, &target_uuid->time_mid);
+    __put_user(host_uuid->time_hi_and_version,
+        &target_uuid->time_hi_and_version);
+    host_uuid->clock_seq_hi_and_reserved =
+        target_uuid->clock_seq_hi_and_reserved;
+    host_uuid->clock_seq_low = target_uuid->clock_seq_low;
+    memcpy(host_uuid->node, target_uuid->node, TARGET_UUID_NODE_LEN);
+    unlock_user_struct(target_uuid, target_addr, 1);
+    return 0;
+}

-- 
2.52.0


