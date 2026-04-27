Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AA8FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH1x-0001Y8-Jn; Mon, 27 Apr 2026 04:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1R-00014i-BC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1P-0001ic-MJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso103266475e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277330; x=1777882130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+vMpMZoQNH3QhHcy99pn2A7JWOU5LwkPJbVb9DyM3Wk=;
 b=H+xm4MGq3+ZAnjXtr4MP7YSJKCpO/YVvvB6GC/hj3wcMYJz5fqjRRPaDTLPBd1Y7oK
 DwlMSz/Vzh8JhKnoIzVcGMU9aerAVyEy98mFZjZGsXaHgkzJgLwu78DwBuwW7at48KQH
 3TKa/bB0tMq6trbVrWEfy2YGnFtZ5ACZn+lWp4fwVG6r1wsZbdTLYzi2xqAikpr3Ga7G
 VeSbwsLyr1k52OoELtRTRyMhMx+SYOVMIxAoc2sHZrAnSoQOGqLF5gxBVmXgkJ9GOa8r
 1M0ZdJ1uJsksRiu3CnHnCDi0BrbWkr3Zz44pqIaFkO6b0nkgGT6ohqLgynzP0ZstfhYa
 lHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277330; x=1777882130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+vMpMZoQNH3QhHcy99pn2A7JWOU5LwkPJbVb9DyM3Wk=;
 b=oW350WGRq3FiGQha0i4UAStessG94e5cydp006ibGR6NPtpnS9keTR6iFzDKbn5jEn
 J3vuZRt1Qb6JVsSJd2oQxOnxwQ76uO1l/CIg/H61cuYxPwRuVU6lC3dQQlyFHsEKjO0w
 hqX99ihjhXuNSRf4cmh+Tq0iXL+LV15LOeHzdrX9PWCnCaleC5SX8CdxAmW1MwYsVKzH
 doNXUnQK5ASk6A9OruWkvNaLAwNUGHZkbzCw4JO2n6dnqfX8dMhqMjjHNtfIDGFPWCTm
 9huNQjMQlhl6cFMnyrS89gGwtrsBwO2Cufgw8v+6x/M1Bjh/9HE5UtafCp5HvMxWesAo
 EFxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cTMLZQ5ZNjnevsJ2Wi76cKKZl/IEvMQA8V7fNLCRaulTALOhHItEcPHkyBF/Qctow4j4dXSUtIaNp@nongnu.org
X-Gm-Message-State: AOJu0YzZubYnBZRlH05QHHtNlm2AyvorvKhATWxhuQ0VkWZnZvjNhbiy
 Tt7P0sugnpBmEhv/GCjLJtOLaMNAqgR1gIr0mrw11nYgGWeeXxT5jFIiky3eKwo2L7EKroAlobn
 ZUOOKV00=
X-Gm-Gg: AeBDieumFQ2oUWY4kTYCc08cFpTkP+fpv993bxBnl1TRo0K659OTXaRC6Cs3SlrBqie
 HnuAhDTGpDZGaLHkhhSWsrTvbxPqxD7qcUGGEA++4K53CF2ciB4Pmiuo36fILtOLRS51NLySPn+
 LMFEM3ROnvqe84iz3PZZfA0N7XAX3y2NivsLJqlaRPvp0k9+NS33MjPe3FA+L6+BuitUbKeztrs
 59dflpju3aAKVJ39tR9sBg9Ag1YWMS2bwcqyeFMHQo2lobdFMl27vlkmS5qWFv9s9H+/jAgYD5n
 RGzVit85woAJQ5a1pNjsErRlzLJKQK5wEzZzgZoIQWn6wVOtMkNOSqLFox3KvUDP0h2qGmIZpxc
 X48JfWh5MFPc1O0U4Xzrmm0t+6YZx3pnBAIOOmYyXk7koM8qBRUg0EstAZLGTshRXo+OXo3SnL+
 dibBtYRIvnux8hf2pLNkCjTx8Qp4IOLrp8+ZCWdTqAijXnMuDt/VC08P1hYvqKsNTNaJY0FcOb0
 JgMjlKMl2gX3tQzy/Zo/Q==
X-Received: by 2002:a05:600c:1e09:b0:489:1f6b:6276 with SMTP id
 5b1f17b1804b1-4891f6b6464mr432715975e9.15.1777277330033; 
 Mon, 27 Apr 2026 01:08:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7aa593sm245860535e9.24.2026.04.27.01.08.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:08:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 10/32] system: Expose 'arch_init.h' as
 'qemu/base-arch-defs.h'
Date: Mon, 27 Apr 2026 10:07:16 +0200
Message-ID: <20260427080738.77138-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index a0dbb81fd90..4298adf5a0a 100644
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
index 0e1fc217b4f..c89fe8378c5 100644
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


