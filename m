Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16B5CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPY-00064n-JP; Wed, 06 May 2026 22:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPW-00063x-Pi
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:22 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPV-0007c9-EG
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:22 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-699a23b2b08so141674eaf.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120660; x=1778725460;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/18BWWz2Wbj63GAgi/PilHsC5xbsmE42NiHRmg2gYNo=;
 b=zva1G04HSZBopuAwIwqYQKyZvW/2X5fQ5rpvs+yZ3dIYcQw5rrpeUCUT608kI1ykRd
 QcvEhOBwlWnAqFz+Y04O8Exq/dloHqfKjKwQaLfknahNh4pwEj71IGT7wFaa5sQG1bDD
 OrZRrWvUza5XW3CzT5tGX8S+KOnEWQvgnqBXAghE2tPFdgwdZiK8Sjl8iO1Z7stJ6VfJ
 i11BfcXIXw/gXN2AbmzrrGi/G5E3ldv2adQYRGqR7tfnBHlV/AbXb7hrOL+Qxp3YP9Gr
 rEh0BNvJkvE2jxdCO5S1lH671PomYdDKyatrhkpfZVzyFAxPrhTO/829Aa8Qr9lJ+zJ/
 PI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120660; x=1778725460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/18BWWz2Wbj63GAgi/PilHsC5xbsmE42NiHRmg2gYNo=;
 b=ZBiLTVZErWOQu/Ka7EHreVntumPcN6QtcbyPwLu7KOJWMrr8KqXPO8h8URb5aZd5lz
 wgLaXiAvhdBWl802awakD4Ke7LQjNg+/KxV80x9EOvzfmLhkfUOSrozVlumjchthCnG8
 D+LJO1xwco+7vxurUk2rTaqz/2EtANyPhAxfV6JAAyQQa7JcQZIvAsR3rT71ZqbFd7zH
 RNRONE53mxXC79MPt+IL43YVbemRuNgGsVuGBLELMp76oO3wZrgg+kqQWtd/w24rIadV
 kTjDWpZcOGvD+o1vwcncVxjd5fpwqcJ4HZBCh/m9iGdp9El3wpSdNYDBRuOrPYvy2qXs
 hYUQ==
X-Gm-Message-State: AOJu0Yy6Kl4zweDYpuP3WMfq6sIjLnChCMQxysxP55gYDNur0FsF909V
 /70WMfYcF43gCKBUrlmK0c7+dDuQXPs4kX7z6njqkL9j8Md9tzda4stGra6W+b2W4DRodQ8kgM2
 YxQe/yxY=
X-Gm-Gg: AeBDieuZOpETM5RIRRvUdvi9kNho+s7NKvf8DxfthxpC5aEuEoEB5isjAs4rnvgfUHf
 epQ5M26VTNLh8+t63oPiu4iYbZYZhou/TljUP0R7qJhbpclw/y1aKw+LgkJqmLto4pNzucjE7wK
 zESq8HQSKmZ1cD0XBdmOVrBCPlm3ZQOeNWTLamanSgYCBTLnyoaDM1ZmmfzNDf6WetBjfAg9Vyd
 pLpuiEanpAtpNwSF1lSFT3ArqjeDL1zIpb+V4SX+8sBKGvsrGYzUQTMwJyEdlXBOPa4OBX3m/K7
 QhOWc6tB0SCMNanerbwunH3KiVFxaVzvNrLTK6q7Lj3gAqvholt5Y52v5EGoTGkTPvHdFRJ7KRo
 +VcIIszNushI51IDmdFSpDZmfIHe3Yq39iZNbi0hA1oNQ0tjx0jqD7btovvSxvNOqVRKATMcWo8
 td8HvjU0YHYXGhjg7d+bsJ5rbLGiGm4+2YC8pPg8dI3g==
X-Received: by 2002:a05:6820:2902:b0:692:a19b:af68 with SMTP id
 006d021491bc7-69998c95db5mr3300512eaf.5.1778120660080; 
 Wed, 06 May 2026 19:24:20 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:19 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 04/25] bsd-user: Create os-syscall.h
Date: Wed,  6 May 2026 20:21:58 -0600
Message-ID: <20260507022219.44171-5-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2d.google.com
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

Create os-syscall.h. The purpose of this file is to define anything
that's different among the BSDs, like system call numbers and
time_t. While there's a lot more different between the BSDs, this is at
least a start at capturing it.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 bsd-user/freebsd/os-syscall.h

diff --git a/bsd-user/freebsd/os-syscall.h b/bsd-user/freebsd/os-syscall.h
new file mode 100644
index 0000000000..962adfa91a
--- /dev/null
+++ b/bsd-user/freebsd/os-syscall.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2023 Warner Losh <imp@bsdimp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * OS-Specific portion of syscall_defs.h
+ */
+
+#include "syscall_nr.h"
+
+/*
+ * FreeBSD uses a 64bits time_t except on i386 so we have to add a special case
+ * here.
+ */
+#if defined(TARGET_I386) && !defined(TARGET_X86_64)
+typedef int32_t target_time_t;
+#else
+typedef int64_t target_time_t;
+#endif
+
+typedef abi_long target_suseconds_t;
-- 
2.52.0


