Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DD8D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwun0-0000zx-3s; Sun, 01 Mar 2026 23:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumx-0000z0-Fh
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:47 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumv-0006ot-Vc
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:47 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-463901a0accso1284540b6e.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425304; x=1773030104;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M046+PxjVBxfRiCPCz3BvHMOg7gZrTVkYVWADjCpLdw=;
 b=AgprB5wD8UfXl2eIdhRod0TPAIxBPdRNLDGB5STxPjpblLWGQXDo3bx/qUSFTSEuWc
 5TyIT/Qcr38tq91I/TARz86X6JcK5dw/EChBN5jEetNXLFX4M7UZ2eHkkNCdkKXJFmBp
 hbDNQwR1HBb0Bs6klI1d+WijDwsPpJ2IslHcTuRu5O4btiU3LoOtI5ym9GL1KIP95K8B
 /oEw+biOBG/6fvcTuuKNUevYVNvD+dP9Xw3l+CW0DOt0WI9bpHSZCK0S1IjZmCktshnt
 p7JHemSUU0r1iiak4iIlneWBTp2/+9chpDzx5O6XwPfYT6Dq6kgy4uQuO8FA+SmQKhJD
 TFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425304; x=1773030104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M046+PxjVBxfRiCPCz3BvHMOg7gZrTVkYVWADjCpLdw=;
 b=IO14oIzEC2/110IgBIt4gQRTRguV1ob+fzkb2EYvk7sYhdbNtcAtBeDrbwCwtW9bgU
 Jr3jBcmuiEBJ7ATxIYPnLfyjNXLtNi4cRssw2ezPxSDSqA2lyFk8bxCS/se1Gix0/ilS
 EvPkiPHcqIz0nQ5NGm6czJ9YAOb2rx8bGyBLij3/W1SD3UZAjXAntLG/Zgm1WUubuTAZ
 PPyAzN++NCZmTutCy+4nbB7NFaMcfU9YvNNuT/uWxpNJeHaeACnOYopV1ObU4ONYERnD
 yxj0W/Ze/mRt/kZIX5r8L1S4nWjIY6D3goNrPTP+yZcfwpxPxsgMEOXoUiyQ95VJt2rJ
 VDPQ==
X-Gm-Message-State: AOJu0YxwS0xKRV9vLwGpV3aY8Q84LsRUVvXc7gBLJ93dFvPQLgl+JVMK
 xowa02GKXVEuZYr6Sfysy4dbgZPYr1ThXBaua9J/y92JzHgKEpgGtkqkkPIzpLS6nITuMHnhwa3
 vTCs7t8A=
X-Gm-Gg: ATEYQzwjpEQipUHy53mi0pzvW6OILiAV0rkjR2RU9FJMBOv2bYomokutwENbg04W9ru
 1JsCjBJhUEM0vn/P0DX9gzcMYvweq/pTL89dr2OCcvcMIW5XcLJgsyIMbBCsREGD3g7Jv1Jt8T6
 k0IZwqyeOzZiqjiMHMrEDvry713FYHl4uC2DoQr897lbu+5NCcguqrK6vS/sARgOQ3zPWTC+DoK
 cLffGhdQJMmcgbpH6sJp58PMw2tYxxyeI5XEn890iXTmbsYz1v3sVLnSY/FMZMpTmexqfhClqt1
 8U4rOxmxNo/4JPaNdiIIveO0IsJvjBOw23k/nS+T+SLl+lVnM0pGgSWTD+TqEEhd6fDprGaq6aC
 1CgorbJK7GolzKbvU75DTioh9j2Sjlflx3xFEvx1VGuuFnvpqMzXSJdjozmkH29AOaUQCeE5XKF
 nFh7bOc+VFxpmCVSAso8QT
X-Received: by 2002:a05:6808:d54:b0:460:f435:2a75 with SMTP id
 5614622812f47-464be972d37mr5113503b6e.6.1772425304445; 
 Sun, 01 Mar 2026 20:21:44 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:44 -0800 (PST)
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
Subject: [PULL 08/27] bsd-user: Add host_to_target_uuid for uuidgen(2)
Date: Sun,  1 Mar 2026 21:20:56 -0700
Message-ID: <20260302042115.83410-9-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x229.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 bsd-user/bsd-misc.c

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
new file mode 100644
index 0000000000..68b67f37ba
--- /dev/null
+++ b/bsd-user/bsd-misc.c
@@ -0,0 +1,35 @@
+/*
+ * BSD misc system call conversions routines
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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


