Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04640C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYSH-0006pN-Rh; Fri, 23 Feb 2024 11:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYAc-00053w-9Z
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:13:07 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYAZ-0003Ob-V7
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:13:05 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33d754746c3so669106f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708704782; x=1709309582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P4/qqHdd11nezC5l/Dlb0EfBKSAYDCgSWSGGYpw9f+U=;
 b=Wn2Y8NqVgMMqU1hdJlozIzrRlbEQ1GkUtTxYmMdi1jD7qQTiT321xb2tXqxTcRiR9y
 nsx+naiFkmwhKqaqoGWSIX9W9/7y44Fhq44hHgn0r885RExURnpAAzHu6JvZ8+FJ/0tU
 8plzWLV7Rr02aFEdNto09xztQer76pUD9pXUntsesFrLfH7uVbHPwkcpE8ZQ4yNRQZUk
 nG4qRa1LBNSWGOhKH/zw0S7In1+ArwRyHlrMBH4/Yt07KWC8j9Oi0xZa3FfA37tr4I24
 SLeEyGBBIrlcAU1USuQ/j9jokSunjxyUi6qp7NKmrCteVSEXWJ9RQWd/5s75YXnhimwQ
 ljig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708704782; x=1709309582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P4/qqHdd11nezC5l/Dlb0EfBKSAYDCgSWSGGYpw9f+U=;
 b=iDZXsrEC8Sv6ebyHKm1IZ1zBWNli1mV9L+IqnC6zQCKX64MXAUyBeNbQ70zbEi5Nfq
 6HWUFrohZeAjVVwed15cKM4i2T8nqOxGBQQ2TpnU9lT2xvWDHOdbcg+BgDiNLVmWZjvR
 GdDVBKRjNVEBu9bK4m584jmkYHD0aW8IgyjY36ir6ZRxWV1brt5sw7juvdg8kpjMou0o
 tDDSo2wGpWiNtGLvLp2uo8d6LPUx99O0/+KzO6NtGj4fv+Jwb0f0EK4wsLGQAaxQDUk1
 DdpPzSlSGGFKIetCIwj/wr6eJkAhj1+4aY1X/YR+dHqmGnMnKV+r1Ij3dKIW53TPkk3r
 ADpw==
X-Gm-Message-State: AOJu0YyeJvoef+wifP008GuqQ5E0CP3WEUYGXr5ZG4k9ZAaLo9J0nhrM
 c5UJ+esmxduPnz09z3jxTciEp4xScK8USlNqsByddnYDJWJqgzwEl9N+Tmola5+geNXHzO+/DfT
 T
X-Google-Smtp-Source: AGHT+IHOqZ7iX7+8bLZx+TCzsCD/+kvBieEvRstjlQtAuNeRZ7Ayo5dWGFa1pZZvNNGqA2cnR4SYBQ==
X-Received: by 2002:a5d:5392:0:b0:33b:237b:22c2 with SMTP id
 d18-20020a5d5392000000b0033b237b22c2mr165872wrv.21.1708704781979; 
 Fri, 23 Feb 2024 08:13:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 co18-20020a0560000a1200b0033b684d6d5csm3956031wrb.20.2024.02.23.08.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 08:13:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH] hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
Date: Fri, 23 Feb 2024 16:13:00 +0000
Message-Id: <20240223161300.938542-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The sun4v RTC device model added under commit a0e893039cf2ce0 in 2016
was unfortunately added with a license of GPL-v3-or-later, which is
not compatible with other QEMU code which has a GPL-v2-only license.

Relicense the code in the .c and the .h file to GPL-v2-or-later,
to make it compatible with the rest of QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Before we can commit this to either head-of-git or any stable branch,
we need a Signed-off-by: from everybody who's touched this file (or,
for corporate contributions, from somebody from the relevant company
who can confirm that the company is OK with the licensing, which is
RedHat and Linaro in this case).

The full list of people who've made changes to the file is:
 Artyom Tarasenko <atar4qemu@gmail.com>
 Philippe Mathieu-Daudé <philmd@linaro.org>
 Markus Armbruster <armbru@redhat.com>
 Eduardo Habkost <ehabkost@redhat.com>

(Artyom is the original author; everybody else's changes are largely
mechanical, refactoring, etc.  We've done some behind-the-scenes
coordination so I don't anticipate any problems getting the
signoffs.)
---
 include/hw/rtc/sun4v-rtc.h | 2 +-
 hw/rtc/sun4v-rtc.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/rtc/sun4v-rtc.h b/include/hw/rtc/sun4v-rtc.h
index fc54dfcba47..26a9eb61967 100644
--- a/include/hw/rtc/sun4v-rtc.h
+++ b/include/hw/rtc/sun4v-rtc.h
@@ -5,7 +5,7 @@
  *
  * Copyright (c) 2016 Artyom Tarasenko
  *
- * This code is licensed under the GNU GPL v3 or (at your option) any later
+ * This code is licensed under the GNU GPL v2 or (at your option) any later
  * version.
  */
 
diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
index e037acd1b56..ffcc0aa25d9 100644
--- a/hw/rtc/sun4v-rtc.c
+++ b/hw/rtc/sun4v-rtc.c
@@ -5,7 +5,7 @@
  *
  * Copyright (c) 2016 Artyom Tarasenko
  *
- * This code is licensed under the GNU GPL v3 or (at your option) any later
+ * This code is licensed under the GNU GPL v2 or (at your option) any later
  * version.
  */
 
-- 
2.34.1


