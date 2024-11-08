Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7748ED64060
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 16:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9RrW-0008Uv-45; Fri, 08 Nov 2024 11:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9RrJ-0008Tz-5Y
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:29:18 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9RrG-0003r1-Vm
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:29:16 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so19685685e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 08:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731083352; x=1731688152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLs4TQ7UF2UTNWreJQ08zWy7UHceQfrRSeNXZ5kQan4=;
 b=uUpAxab6yxD8hZ0SFK6IY9H/FCcGSSHDgynBJM5YUH9j+SfJVL+6+3rQADqRlDCruN
 eIIX+cWzjqYlyeaP8E8noqrXxLWa8nsBkQI3UN4Y4gp7Gw1IRQfLSLvFy1CHJvtCoOL0
 D+lTt8bV/PysicNJyyh3Nm+hduJCRxd+sduUGnZgtlX1yaCBdwpdotyZxBDubHs3KLka
 Asol0BRCkXaHKtcINhdHZbGnwxO7wLeLJ6Y1WbeHvR/FswFu2Rsav9FAirMqz26/HWTB
 ki2TjS9BV3/o97ppQLUktlpP0q9MERtLzgwwLbfwzzvsfvpYQ4cciI+4VEZTUhbUxG/I
 rofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731083352; x=1731688152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLs4TQ7UF2UTNWreJQ08zWy7UHceQfrRSeNXZ5kQan4=;
 b=GhSEQqnHWLlC8lIaYh95Cio41NStUSwMj6MfX/2Mfd4bc4yASDke8yfG+6DJMflgPF
 Q4hWPHuqXz10QPyfJWirwuJaCSB8HE9vzB1k4Q65+EEaaymuP6rUzAFEj6Dair3p+DGQ
 ny+MSqj2LRGHiOa5volDTWLaXyJzWdIozoOq9/ffEqgU0LjuuKt9orNgg9qcflm3k4pP
 X016dex25fimU6SHwD+J9CC+RIfTtAPpNigmQmGgHFUgWwf+RmLUVRtU8JzxwlH2C0ki
 JYgQ/FjvNCPpOB+wlQXmR3iYaD8ScVZwj6yKHOSS0ORWiAE8gLS0kzn1K1d+vux0SlxF
 CgRg==
X-Gm-Message-State: AOJu0Yyl+jOWo5DQjid/g7mlovib4R4XkzaMLVSjqatYY19AX8DAua7V
 QGvcLGM7KvNwgWg6UxBXyigkiDg/oFQppPyvEUzb27cSKwNdF2y3MmuEOBM75g1DKkPAYPpVwf1
 I
X-Google-Smtp-Source: AGHT+IH1ohYSxdLlBUtpaCwOIbXtBKeUy+/kmOJDPW1mBjFcRMbwaKRHLhLwQFpY28HT0x1V9k1KUA==
X-Received: by 2002:a05:600c:1d20:b0:431:6060:8b16 with SMTP id
 5b1f17b1804b1-432b751ceb4mr27698425e9.30.1731083352217; 
 Fri, 08 Nov 2024 08:29:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b0530599sm78109135e9.1.2024.11.08.08.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 08:29:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 2/3] target/arm/hvf: Add trace.h header
Date: Fri,  8 Nov 2024 16:29:08 +0000
Message-Id: <20241108162909.4080314-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108162909.4080314-1-peter.maydell@linaro.org>
References: <20241108162909.4080314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The documentation for trace events says that every subdirectory which
has trace events should have a trace.h header, whose only content is
an include of the trace/trace-<subdir>.h file.

When we added the trace events in target/arm/hvf/ we forgot to create
this file and instead hvf.c directly includes
trace/trace-target_arm_hvf.h.

Create the standard trace.h file to bring this into line with the
convention.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/trace.h | 1 +
 target/arm/hvf/hvf.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/hvf/trace.h

diff --git a/target/arm/hvf/trace.h b/target/arm/hvf/trace.h
new file mode 100644
index 00000000000..04a19c1d752
--- /dev/null
+++ b/target/arm/hvf/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_arm_hvf.h"
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6cea483d422..ca7ea92774a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -31,7 +31,7 @@
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
-#include "trace/trace-target_arm_hvf.h"
+#include "trace.h"
 #include "migration/vmstate.h"
 
 #include "gdbstub/enums.h"
-- 
2.34.1


