Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D69F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHx8-0004Qu-UF; Fri, 10 Apr 2026 15:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHx7-0004Id-Kn
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHx3-0002hv-IE
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so30027345e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850935; x=1776455735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=px/O9JgpOPO/Ufbv2ZpzWXAnxI26EBsW5Ud+Y2G0TJ8=;
 b=Ks83eXtnQys7Wkjjvyiz47E7DXhgvXg76+EYFntvHUnQcW7DinCM2UnntIU37AKQAj
 MLt0AvBk3IV8ZaQfzRZ250sr7MkQ5AGW6HV/yVF8kCeRLukARWM3GBAnYpixgKJW4zbb
 xRnXpJqv/7t+Xqr1CO6dyf6ot9aJh0D3XGu3r7Mlxv3OrTl7L1PzNkB7iCgAkkQJatAH
 27KluE3X9KBkJDCAYITjfCtuHtnQEuYJIKwtxrIsUCcibiqrQ2SSxlhC+7qpUVfhB+iH
 PJCzPRTkAloNATphqHxt0BtrLXasJvLhwjJIVHwHSmMtEtpp4tPFDUxNcWBeuetTQumP
 Ipfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850935; x=1776455735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=px/O9JgpOPO/Ufbv2ZpzWXAnxI26EBsW5Ud+Y2G0TJ8=;
 b=IF1TnSjGLoKTELxrL7ih1Tv8EDZWBujTDaeBKfvPCHXKbAUr/PbYpDZw+8BcfAk3og
 TIdRXjLA30CM3tP5wxvvgHzoaJd116f30FdXPEZ5mRwIqjMhwiaU56lg/Vlgc5cHl1S6
 zszPnYUUg9+IjgGExP8wmNgshFlqvfxNkUGHg9q0AGF2apqC7iSErvTsN/TRrkj+LCYk
 FgadTb3msAT5/OadMXFdYcHr0wM23bgFtwNiFAsbnCWQNHI2Hi/hqYGywRhKiIzOI1a1
 XLd7dlOyrCbHOCxc9HAAj3KIBrHvgVhGkJKUcjhQRJc97PjyXgnYapY8sXhBm6S+YMOf
 +ncQ==
X-Gm-Message-State: AOJu0Yxr3/7pV93fC3+GdRLHf0VYn6vxSNWTFy1FBFRIml91FB2hDgXj
 GR+NnBPeXTGAylTiKR4RgDU7o/hefGvB/xTPnwORZ5/r+dbCI+NMpwvYAugbJ/KCplgZt5NuuDw
 dJKa4zK8=
X-Gm-Gg: AeBDies4jXEYbo53VSzubzvtHb7hqW3gjL40sbJElzLrUcPp+3Sqn5qmgZlERghrf9b
 9tVZJIs65BaoOZSdiiJJmZG/5zMXTI9LVo38TzZw8Pd2TAig6g7D63lVuB7iWZNFLOWW1yWXwK8
 PwqbqO6vPxKwlmG9EVTZyjYPQhqgcL228/ggZi3T2Iw7JqFFiMWTf6+8JYxh3Wx0KYiv4NVocYy
 z7A4CVzPJs6dAoe4XOt4v0W2YdCaDdeAR4gcdsI/g8YnKHoCmU/E9YYV9SGBpELu6VwOLbxOdCx
 qeXVfxFzi0bqWfKpsmXde85pTBqJHJWa6MpEu0W8/yYYlbBofwbeSCnmsmyeMW3AP+u1PjAHAS+
 7DhmA4bGJ4yNsNmdWrk5JO5wNBtjc5u2E4Wu+gBZpVlryoQu7S1E5pFhjpKP+k0DvGgzkgUzz7g
 d9K6fQ638niytejtaltCiI2FaQpk27PNuXAGDsoDT30yHVDIUnC/MOZmdCInIq1dUF6T+C9sp2
X-Received: by 2002:a05:600c:5298:b0:488:c014:34da with SMTP id
 5b1f17b1804b1-488d688687cmr63654455e9.26.1775850935538; 
 Fri, 10 Apr 2026 12:55:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d681ea59sm28066985e9.14.2026.04.10.12.55.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:55:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 18/27] system: Expose 'arch_init.h' as
 'qemu/target-arch-defs.h'
Date: Fri, 10 Apr 2026 21:53:12 +0200
Message-ID: <20260410195323.17937-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We already have a file unit outside of the local system'
folder which include "system/arch_init.h". We want more files
to use it, so make it official it is a generic header by moving
it under include. Rename as "qemu/base-arch-defs.h" which is
more descriptive.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/arch_init.h => include/qemu/base-arch-defs.h | 10 ++++++++--
 hw/pci/pci.c                                        |  2 +-
 system/arch_init.c                                  |  2 +-
 system/qdev-monitor.c                               |  2 +-
 system/vl.c                                         |  2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)
 rename system/arch_init.h => include/qemu/base-arch-defs.h (92%)

diff --git a/system/arch_init.h b/include/qemu/base-arch-defs.h
similarity index 92%
rename from system/arch_init.h
rename to include/qemu/base-arch-defs.h
index 0c2b1f3a5d0..f33465738c9 100644
--- a/system/arch_init.h
+++ b/include/qemu/base-arch-defs.h
@@ -1,5 +1,11 @@
-#ifndef QEMU_ARCH_INIT_H
-#define QEMU_ARCH_INIT_H
+/*
+ * QEMU base architecture bit definitions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_BASE_ARCH_DEFS_H
+#define QEMU_BASE_ARCH_DEFS_H
 
 #include "qapi/qapi-types-machine.h"
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2c3657d00de..a38dffd4899 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -36,7 +36,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/numa.h"
 #include "system/runstate.h"
 #include "system/system.h"
diff --git a/system/arch_init.c b/system/arch_init.c
index 604d5909ed0..1ad2f3d6f78 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "qemu/bitops.h"
 #include "qemu/target-info-qapi.h"
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 2ed95e83602..2e9dbb9b5c2 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -23,7 +23,7 @@
 #include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
diff --git a/system/vl.c b/system/vl.c
index 246623b3196..23f1da66369 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -112,7 +112,7 @@
 #include "trace/control.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/confidential-guest-support.h"
 
 #include "ui/qemu-spice.h"
-- 
2.53.0


