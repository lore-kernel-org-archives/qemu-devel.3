Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD87C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 00:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBkwZ-0005i6-9Z; Mon, 27 May 2024 20:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkwW-0005gD-K2; Mon, 27 May 2024 20:43:56 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkwV-0001mI-0Y; Mon, 27 May 2024 20:43:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f44b42d1caso2422115ad.0; 
 Mon, 27 May 2024 17:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716857033; x=1717461833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18rm/lPX5mSSlNdlY87VqUvEx91nenlZ+MsIhknHyAI=;
 b=kuupIvGsBBIv4nGNQpurk8xZ3U/Sc6NdGJCaQvo9Xem+JU5f7MxDbDA/wNhOlAwX41
 5CcsZiGRKQJd4u8aToVhCQoXm6rqbXyLcw7OxfZI/5av2fX0bGr2EoOV2IOo5D5mhssZ
 6FYU9Y794BuM5bp7f4yup0kg04b3CpjKdCD26XmOVOSlNo5L9MlEcI4Tt4WjQSJ+3mcD
 qtcDTXE9yAbkx3ne7foguHfYjWsjyvlevMnRquWwmh3p2N8wWCUQTM5MmvC3eB6JMDKR
 4kKdIUQXFlL3mp+N6OVmwrcmuSipTnjXoA4sxjIdH82CAIBEo0LgZvbB+VV/ZpWdq1SZ
 UDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716857033; x=1717461833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18rm/lPX5mSSlNdlY87VqUvEx91nenlZ+MsIhknHyAI=;
 b=OTaKrpEr2YogK2hUZmTs/2VgbbfFIJQ6Cbnp/JzkexmdpHII00+BLVF5b8+0ynl08Y
 cZJGt5j2e31NcB23f5OqWil6NXXMux86O9mEsOcmirnZ7VvKVTynF5jtfN+BuyKm9Uap
 VM1kaFZeupO3IVKTNX0ZLAgxroOaJQakafp3iuPgAh27/K0Aj7o/mKemhOzFXj4AZzGd
 bukf9yZNpg4ErPw0riyS2iGOVES0b0pqJWxmYGR7blzips3/6Vmch3rGHys4Vtr95V0m
 WN6xi7L5cs7Hy5QNA1t7i/gqbmyLfO6SdA0WpnS8JVF/HBw/mybUoNFiARes19wh21R/
 zUgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkbJ1AcMtVFqhJHsowgtBrDF53SBGPAKUIo4WsyPCqYawhfrihD2kUuaHDm/UAl8J7bOECLXePq/S7fV2EmNU7iLkZ
X-Gm-Message-State: AOJu0YxzlkG2kXMStPjhRCpLBzEbGBqSbQ2nxibjDDRAZGlUe3yDPXxR
 VYdNIyEzdComknBw6D3yV9Es0oR3BjQKQcrWJHVX8VuubSVjT/5yQ0ln/g==
X-Google-Smtp-Source: AGHT+IGpMyTGV6gT9SNkH0qm6Y7k5jspalpctPrfpUc0hSVarnVrMq9dXmjpAxKRqnwLRzHE0MeJ5g==
X-Received: by 2002:a17:902:fa83:b0:1f2:ff7d:ecf1 with SMTP id
 d9443c01a7336-1f44872db15mr91230825ad.16.1716857032830; 
 Mon, 27 May 2024 17:43:52 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c75783asm67613595ad.23.2024.05.27.17.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 17:43:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 3/6] tests/qtest: Move common define from libqos-spapr.h to
 new ppc-util.h
Date: Tue, 28 May 2024 10:42:07 +1000
Message-ID: <20240528004211.564010-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528004211.564010-1-npiggin@gmail.com>
References: <20240528004211.564010-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The spapr QEMU machine defaults is useful outside libqos, so create a
new header for ppc specific qtests and move it there.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/libqos-spapr.h |  7 -------
 tests/qtest/ppc-util.h            | 19 +++++++++++++++++++
 tests/qtest/boot-serial-test.c    |  2 +-
 tests/qtest/prom-env-test.c       |  2 +-
 tests/qtest/pxe-test.c            |  2 +-
 5 files changed, 22 insertions(+), 10 deletions(-)
 create mode 100644 tests/qtest/ppc-util.h

diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/libqos-spapr.h
index e4483c14f8..a446276416 100644
--- a/tests/qtest/libqos/libqos-spapr.h
+++ b/tests/qtest/libqos/libqos-spapr.h
@@ -9,11 +9,4 @@ QOSState *qtest_spapr_boot(const char *cmdline_fmt, ...)
     G_GNUC_PRINTF(1, 2);
 void qtest_spapr_shutdown(QOSState *qs);
 
-/* List of capabilities needed to silence warnings with TCG */
-#define PSERIES_DEFAULT_CAPABILITIES             \
-    "cap-cfpc=broken,"                           \
-    "cap-sbbc=broken,"                           \
-    "cap-ibs=broken,"                            \
-    "cap-ccf-assist=off,"
-
 #endif
diff --git a/tests/qtest/ppc-util.h b/tests/qtest/ppc-util.h
new file mode 100644
index 0000000000..f68ee93520
--- /dev/null
+++ b/tests/qtest/ppc-util.h
@@ -0,0 +1,19 @@
+/*
+ * PowerPC misc useful things
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_UTIL_H
+#define PPC_UTIL_H
+
+/* List of capabilities needed to silence warnings with TCG */
+#define PSERIES_DEFAULT_CAPABILITIES             \
+    "cap-cfpc=broken,"                           \
+    "cap-sbbc=broken,"                           \
+    "cap-ibs=broken,"                            \
+    "cap-ccf-assist=off,"
+
+#endif /* PPC_UTIL_H */
diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index df389adeeb..3b92fa5d50 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -15,7 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/libqos-spapr.h"
+#include "ppc-util.h"
 
 static const uint8_t bios_avr[] = {
     0x88, 0xe0,             /* ldi r24, 0x08   */
diff --git a/tests/qtest/prom-env-test.c b/tests/qtest/prom-env-test.c
index 39ccb59797..14705105ad 100644
--- a/tests/qtest/prom-env-test.c
+++ b/tests/qtest/prom-env-test.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/libqos-spapr.h"
+#include "ppc-util.h"
 
 #define MAGIC   0xcafec0de
 #define ADDRESS 0x4000
diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index e4b48225a5..a3f900fbea 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -16,7 +16,7 @@
 #include <glib/gstdio.h>
 #include "libqtest.h"
 #include "boot-sector.h"
-#include "libqos/libqos-spapr.h"
+#include "ppc-util.h"
 
 #define NETNAME "net0"
 
-- 
2.43.0


