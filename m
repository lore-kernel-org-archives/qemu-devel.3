Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74735C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Zxi-0002QC-Ll; Thu, 17 Apr 2025 20:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5ZxS-0002Ee-Dp
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5ZxQ-000678-QJ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso8923985e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937509; x=1745542309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GcHJH1PYkGcsws2/whqy32PYr492ZOWj9l1ZtfQiy1U=;
 b=ixuIK8p4XdoCGOgokt+50gdTpx1T//rGOlg9+tcb+Hc68eBKnWikKENzl3Tp7wZQu1
 gWDdDfWABbgiGA4aTa1/0FnP6V+g2W8Jwn/ET6Zcr6afz3gLrfDnokDDi18spYGEh11W
 ls0kg03g0flq+vrtS2oEovwuoUjv7/hhYpFoZ1fokuvKrgrDRC0B4+MV47ruEXY1VH+9
 PZJvFwqRVqcr02dsrdHSZWBLMyRuEbH/Mh5afTB6W9F+sTgLemMpiXpVF6GLgC9nzjZG
 TbSY8A+UVYg9qK+mLT+xVa6zRVtazNGMMraMABJqWMlrtbde5yubomwA7LrckleceDUk
 To7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937509; x=1745542309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GcHJH1PYkGcsws2/whqy32PYr492ZOWj9l1ZtfQiy1U=;
 b=RRJ+L98yQQ4w5r+XiD/xpHgVTzM54Yz2gUISOLUguaokt3/tEkmhv1ASxKWQoZZVHX
 RCzxgTFMRq5NxqSXew6EcSFDg01R+KJdAcekOzygaSkQhySZOruXIpeAsBm6TWtUqNgc
 Se4K/AkGb6I89SQh45IhT1W4VfeAeBARQ1s0VBUSGKB0DD/3UwevXYAZT4JBi044VlGL
 Ha/+an7Tg7MnKq1vUXWHcgoZVzbxUfDnqnOSeY4fpB7IBOsCH+COQtg7LUoj2VW3xnRf
 aaJITYBwlhvEiv2FnjM6G332gVyCRTb5wHc44H0NaUz/vpYBLbu1kc22UaGQAgpoS5o7
 1Wlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7jT4OYt7Te/+SknAGS+YxLs3fFE4xoJCD1hjUm9eq7/z32taylO9OkjETdKOMvArbPIrX4SY0Lzd+@nongnu.org
X-Gm-Message-State: AOJu0YyhB23kdq0zAyqiAGavZ8mFly0tWesaVg0XjeR0TS1DmkvuqLwJ
 uRnFPo2yqhe4WRaezsxKlOAiW7yLSIYHXqxLdc1IX0GTbCq0WYbed0D+X8193B8=
X-Gm-Gg: ASbGncv1TsTv78IgMUfY5v8kQLQIfpTYdqMNxefi1rAsKPHvZilY9iirRfl1RS65nR+
 rrtKSMw2ikqD5GwgN31FEvBrOSzUZxm75gcnPUQN2f7hfP+wPS35PiNqc5AUBwreoULA34W5OEA
 uO9MwiIgKs/L5cNKBTCqg9a92iROjPUky95Fa5mLif+w3MQP3wl8wUViNrsQvAEJvv1RjklYzz9
 eY+LUubr979lER/q0PiHEWeoGi4w6QC2q5Xn7jkIGwqzqBUPplTrggqG+yF2GGX5Qpk65YpNKrP
 01u/ttnknbovQqkshrsTq8rgeZEpiWikhL2b/P+CCFh7ykITY+IAie7NStZm3ImPu+vY6VHEyEc
 XUrPPbRvyWbfwni2d3mji
X-Google-Smtp-Source: AGHT+IHV253r0y0hZBaHR1WeiYagIWkcVZJtuYzebKjigYTKRH+UT7fCOAWvAnQiY3uSgl0tAhxvRw==
X-Received: by 2002:a05:6000:4a1b:b0:39a:cb5b:78fe with SMTP id
 ffacd0b85a97d-39efba8a4f4mr534128f8f.34.1744937508874; 
 Thu, 17 Apr 2025 17:51:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43ce2esm1188192f8f.57.2025.04.17.17.51.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 09/11] config/target: Implement per-binary TargetInfo
 structure (Aarch64)
Date: Fri, 18 Apr 2025 02:50:57 +0200
Message-ID: <20250418005059.4436-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418005059.4436-1-philmd@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Implement the TargetInfo structure for qemu-system-aarch64 binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/aarch64-softmmu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 configs/targets/aarch64-softmmu.c

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
new file mode 100644
index 00000000000..e48ac264d7d
--- /dev/null
+++ b/configs/targets/aarch64-softmmu.c
@@ -0,0 +1,22 @@
+/*
+ * QEMU binary/target API (qemu-system-aarch64)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-impl.h"
+#include "qemu/target_info-qom.h"
+#include "cpu-qom.h"
+
+static const TargetInfo target_info_aarch64_system = {
+    .name = "aarch64",
+    .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_aarch64_system;
+}
-- 
2.47.1


