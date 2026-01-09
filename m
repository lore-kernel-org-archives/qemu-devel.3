Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCD8D26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFeu-00088x-QA; Fri, 09 Jan 2026 11:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFec-000831-K1
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:48:06 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFeZ-0006hy-03
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:48:01 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso21436865e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977277; x=1768582077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTAOH/xq/3mecKgOFQc299O+6eUqLk/ATHdhAOXEHr4=;
 b=CkQAQIu0gJMwxpr+RivN9KvUt3PtinGIu+7qbDdxB55O7/NUuS6q46UGZ0Xd/Q34gL
 PZnob4J3m70yreQ+PrMZt8pmqMG3rDM2SMGoP913Q9Lu/XOUmtq9dr3/RoyfL5JMCE8O
 kHMrtonBTeWF1ZiEQMYVvr2TmFGPEsJkwx2zz2HBsXjTC79BqMQuzxmsPZ8GrQ095DY5
 r4prrqWNNGLn670vCvi/mkq2jeae3F4/v5y8Mu8acCg7fQdq66qO6sRyr4T0tMvSR+YV
 sPUBEv6je206f3Iz9/+RSUcqCVniYK1x5deAY3mVpBh8Hh776k4oP/854voc/XkiYatU
 okkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977277; x=1768582077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RTAOH/xq/3mecKgOFQc299O+6eUqLk/ATHdhAOXEHr4=;
 b=Snnkx1rN0bjYlL/sBqrZK1Ohavjv3swfZHGcLO/fa/iMxYjNC9VmySAZhkuuZrlIX1
 zylaiJZMjlMJsWYdaA87j+2ds862OrS9P29lf6wBNZK35IcufXluj+SELGdY2mt3w/4O
 SLRSu6+PA1fLVJ4X7t/YSgYVqRqyFjmfbej4bmHiwzeIxoK0MZitGanb51LecSi6YN6F
 rVKgBhG1eL+IdnnIcHVccPTzt8TxllhBRSyQ/mgGQTQvRP+KmPbXsy5GUN5p6dGmB2ea
 5sI+YK7kdDpsBBjChbvRGGWjxJsQyPkX1T/ty5BbG34mHXioxZo7NxTG4SDE9EuIyYHl
 bK3Q==
X-Gm-Message-State: AOJu0YwieLh+fVyJoN89M2Fds5D1OvtTH92M4j/PE0eRo20HPtI0+B9u
 hQ+3Op8N6vFDvAnkhI0hmG2CwH6hGZ31t5gJSGGia0j7GDuK9L9L5UaE8Uhof9n5PmYNioozt/B
 uFwUDCqA=
X-Gm-Gg: AY/fxX6AZAt9IpzpQz+U6u7Bm7lxIVAdXZYIVaccXKbNMZrGsb0/QcpDqj95C46xfXC
 yCTYG0pLt8ZQ+0TXTPFuLShiGYnlw41kEYG0Pxhk5gNmoqVVGNPV2LeSCF428j7zuohyjaoHmt7
 P4yUHeB6ddZjGSOF0+8V5EwBigoOsAEYTAsNSd0m49SDZnhYK/xSrSugJTxFtCGAnFqNN4OfBNi
 YEMcX+KtZV1DMjVy7qz1m6ytWhzdA+u2QXkCYPnya502fKBHcnXAeQ6Zyzl++d60leBZpfRDtNf
 DetrwLg8HakXKB882BIaOuG7D9cH97JSAMrazM/7TmbcM97Gee92u+tDqwhzDTEeLWIYjdorEHe
 KYw5OeNx3RXHcfYLypM9YCpdBIab9mHl7gnoZFAIroteXd0MMOyYF4fsWDUkm4PrsfA4X5EFc/0
 lM9mWg75tfJB0u8pbbGPt6OAnkmugV4Rwx2bLf1Xqlirhi1UrEfPxg/iJ7gwiN
X-Google-Smtp-Source: AGHT+IHIpCZzd0tKnWh0EcDxsMW9Q08s6epKdJyRuraP5/6yc16tLpIWI+2dUba2R38HCbUmXF28bQ==
X-Received: by 2002:a05:6000:1448:b0:431:a0:7dea with SMTP id
 ffacd0b85a97d-432c374ff61mr13406525f8f.40.1767977277121; 
 Fri, 09 Jan 2026 08:47:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff0b2sm23298148f8f.42.2026.01.09.08.47.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:47:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/4] bswap: Use 'qemu/bswap.h' instead of
 'qemu/host-utils.h'
Date: Fri,  9 Jan 2026 17:47:40 +0100
Message-ID: <20260109164742.58041-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109164742.58041-1-philmd@linaro.org>
References: <20260109164742.58041-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

These files only require "qemu/bswap.h", not "qemu/host-utils.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/ahci-test.c              | 2 +-
 tests/qtest/libqos/ahci.c            | 2 +-
 tests/qtest/libqos/generic-pcihost.c | 2 +-
 tests/qtest/libqos/pci-spapr.c       | 2 +-
 util/hbitmap.c                       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index e8aabfc13f5..5c32ff20029 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -31,7 +31,7 @@
 #include "libqos/pci-pc.h"
 
 #include "qobject/qdict.h"
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 34a75b7f43b..0621a6c4775 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -28,7 +28,7 @@
 #include "ahci.h"
 #include "pci-pc.h"
 
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
index 4bbeb5ff508..b77617524ca 100644
--- a/tests/qtest/libqos/generic-pcihost.c
+++ b/tests/qtest/libqos/generic-pcihost.c
@@ -15,7 +15,7 @@
 #include "generic-pcihost.h"
 #include "qobject/qdict.h"
 #include "hw/pci/pci_regs.h"
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 
 #include "qemu/module.h"
 
diff --git a/tests/qtest/libqos/pci-spapr.c b/tests/qtest/libqos/pci-spapr.c
index 0f1023e4a73..3723cbb38db 100644
--- a/tests/qtest/libqos/pci-spapr.c
+++ b/tests/qtest/libqos/pci-spapr.c
@@ -13,7 +13,7 @@
 
 #include "hw/pci/pci_regs.h"
 
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 #include "qemu/module.h"
 
 /*
diff --git a/util/hbitmap.c b/util/hbitmap.c
index d9a1dabc630..3525bf7751a 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -10,8 +10,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/hbitmap.h"
-#include "qemu/host-utils.h"
 #include "trace.h"
 #include "crypto/hash.h"
 
-- 
2.52.0


