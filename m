Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C317D44161
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8i-0005wH-LT; Tue, 19 Nov 2024 09:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8f-0005vG-HT
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:33 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8e-0006Em-05
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:33 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so31836215e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026210; x=1732631010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sgmkEh/mAYEEOBGITS2M+Q2muX4d/fOxHqnXuvoWYiU=;
 b=JHIaIC79/9Id0urll+seoq/Ihz7NwgJDA7sY26LyCIMq+3iRSAAkHXM/XrncUo0wvt
 hv0OpN66eVW5Qa1efJTj/tYEcfYveIs+W9yz2OIUASAqOro9o6r6tW/HgwoB84znOCZ8
 QWWGHwvaL32FI3/ld3Y3h/XNmyBVea+PdyH34TPjvGsZKzzqJ2NJfDOLqd7xnhamqRZG
 8EF/MRiUsDrbn0pR+5yv3K4FnByiKP8rWbohR3IHWxj2HVhS1NR9qLfHi+TQNAvAkgHt
 npA9TFujGkpXA4pvDJqIoNjhRazZHqU1KgR+W1VDVWDh9xrhAuWCiGUqEtA56Pve+4Rc
 F4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026210; x=1732631010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgmkEh/mAYEEOBGITS2M+Q2muX4d/fOxHqnXuvoWYiU=;
 b=gi+jKTgiPTxEUboin+r23O9C6fDeUd23VRLpuvm4SjXiBKrXHYuuSFqFrffUHuk9tO
 Bh7aHSKWGS9a4UoN51eCE7gImJ6+JmGGRSwBEVWOO6nFJdFuHYQXzTo+ddwTpR4gny/b
 hMw0dIwF70xp6J4fmAIaLP3lF+kndCSH5fs4Ybu0z3VqiMMEer3cFHzG7Z99jZVPI1f6
 UEwprbB5DmGAs1PA23RI1l//A1vcozIemJCpfaDhH3Um+jWWR/aiDutPivW3fJsb1EXL
 p95H1VFyOh0tK5rEnde4GIiiEqNrGEmEyCeN9co23MH6b+72w0R6zjF/SFQUla+xBZhr
 a2TA==
X-Gm-Message-State: AOJu0YyVOSIi9iNTKp2jIHqBs+qD1JfSX0IqM/3W9/N25qfL+z2Dh8FY
 o34CchKpn4qY8q0hV6G3cvRDnhwFNAfiVgIFAQlaeL5E8EM9+5GA2/uDmWJ0kLEau2UaMS23atf
 Y
X-Google-Smtp-Source: AGHT+IEztSF0TjdpCC5Qc86mcR3iY3hDNya1kKspPC7PAC5Z239FScG6nOgDAyDPMmg2eGhYNygqQw==
X-Received: by 2002:a05:600c:3d8d:b0:431:4fbd:f571 with SMTP id
 5b1f17b1804b1-432f57dfa69mr29987525e9.13.1732026210649; 
 Tue, 19 Nov 2024 06:23:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/15] target/arm/hvf: Add trace.h header
Date: Tue, 19 Nov 2024 14:23:20 +0000
Message-Id: <20241119142321.1853732-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241108162909.4080314-3-peter.maydell@linaro.org
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


