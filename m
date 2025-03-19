Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F7CC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy4e-0000uk-QU; Wed, 19 Mar 2025 14:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4P-0000Mv-Fx
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:14 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4G-0006Pe-2W
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:13 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so818341f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742408582; x=1743013382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8piUF4u9JTaJPSgck8BDagdzEdVPzEIS0aH/3c6C7T0=;
 b=ErSpOQrcmezizWvjeFUcZWCl5AWwjwwp7kQ/PDFqe0A6FxSNzQfDpqXClj4q+zgV2c
 +VUN2/fklcDq5RWYLSqDwkK/K1xAc6cpbNncgEGXNW09Wo45fYcUnOWwksGMmUEJEsgu
 Ikw6aEjlM7AGweyYs+cpwkAsUrqla7COvswLStWMDtT4DwKmk96CWWtasVCG9XT2+c/J
 Yn5k03osVPNdwm0wf1gWI1DT6X+gosTJZmrfhCq9nhetukda/KMEIxlotPJbx+v1H822
 WwUZAu5hS5m99WHEUcGZtPSYD8cQiTQQF4Ip9HKgnRww+TeQQtQ77XkR7VA4FfbOm77L
 g4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408582; x=1743013382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8piUF4u9JTaJPSgck8BDagdzEdVPzEIS0aH/3c6C7T0=;
 b=uWWSp3u9C7GYjolEO14hMxHqzsMzkX4k4My7kFY0wZA7IbNNek4Zip78DrJHJy8ymE
 ADQY8aA1Cnf24mJVEjb4o6p1URpxS94C5rLQVRvqhA2MlYSR+K13ECGY9iJQ4eznInHn
 IigKurBlTC/dLZ6Yj8E50lVZ6hQ6lL/bsxC2/QHy3dKd7AMEVlKc07OZxyhAHbRuNaAI
 YuJIOhQLdt/ykjiSwGW02BOJyCygR5BUQM3CEgVX0vJc10UV2GHlMIMuR4AJIcc8doLB
 jTR1vTWYDeb0La86kxqyDDtBZLKrXfnpqvfjfznAxmKTAKtJ466+zM0ndlo8c2/mqNv3
 PjIg==
X-Gm-Message-State: AOJu0YxqQ8v4FrdDWWuSd0SQj1EUOUtbxvixCKTUEibq4pCWz+5w9Cb7
 v0FTF3mkYlZ99TRd5NVM/ShXZ+g5qrs4LsgDk1tP7wu2B7T47RDyRUSGQpXcKug=
X-Gm-Gg: ASbGncsS51zvm0GNXByOVCFhnn+8dEADtQa5eixZC2H42un3K3oYg52H6ts5uRbyQLD
 ODX4HuukWlzr7SOXPlM2Ty7aUZLPDfAqKyeLogE55i3mOG9ITdoi7A0bfoVsqW0t82y2EXrFXCy
 NnUN15DosC0tW6Q0Jj6dhwTjkOu/30U7r5vlfJmO/DeYcIrlu9eaUr+wu7Mi79Q6pd6FSPO57bI
 TT/8xR45rxqEGXjf2tVkdZG2M9RlQMW4lLi02jcZ86PnrI6+QveDxEOfqi0fsiJLtZ/L9BQBTCj
 wOp2rUvlVZHFuDIkNr9Fe2Phb5OCqnQGBLRU1Y1SQv8TRVc=
X-Google-Smtp-Source: AGHT+IGF+nxh3CNGN04Hc1HlIN0cR9k37/dKbiPvCRwR44lUbGx9cLg5LkgpA9neGSvFaBCczlQTYQ==
X-Received: by 2002:a05:6000:2712:b0:391:4889:503e with SMTP id
 ffacd0b85a97d-399739de5f2mr3218843f8f.33.1742408582335; 
 Wed, 19 Mar 2025 11:23:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d3ae04a94sm28486135e9.0.2025.03.19.11.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 11:22:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 64E795FA87;
 Wed, 19 Mar 2025 18:22:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 02/10] gdbstub: introduce target independent gdb register
 helper
Date: Wed, 19 Mar 2025 18:22:47 +0000
Message-Id: <20250319182255.3096731-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319182255.3096731-1-alex.bennee@linaro.org>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

The current helper.h functions rely on hard coded assumptions about
target endianess to use the tswap macros. We also end up double
swapping a bunch of values if the target can run in multiple endianess
modes. Avoid this by getting the target to pass the endianess and size
via a MemOp and fixing up appropriately.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/registers.h | 30 ++++++++++++++++++++++++++++++
 gdbstub/gdbstub.c           | 22 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 include/gdbstub/registers.h

diff --git a/include/gdbstub/registers.h b/include/gdbstub/registers.h
new file mode 100644
index 0000000000..4abc7a6ae7
--- /dev/null
+++ b/include/gdbstub/registers.h
@@ -0,0 +1,30 @@
+/*
+ * GDB Common Register Helpers
+ *
+ * Copyright (c) 2025 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef GDB_REGISTERS_H
+#define GDB_REGISTERS_H
+
+#include "exec/memop.h"
+
+/**
+ * gdb_get_register_value() - get register value for gdb
+ * mo: size and endian MemOp
+ * buf: GByteArray to store in target order
+ * val: pointer to value in host order
+ *
+ * This replaces the previous legacy read functions with a single
+ * function to handle all sizes. Passing @mo allows the target mode to
+ * be taken into account and avoids using hard coded tswap() macros.
+ *
+ * Returns the number of bytes written to the array.
+ */
+int gdb_get_register_value(MemOp op, GByteArray *buf, uint8_t *val);
+
+#endif /* GDB_REGISTERS_H */
+
+
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 282e13e163..3d7b1028e4 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -32,6 +32,7 @@
 #include "exec/gdbstub.h"
 #include "gdbstub/commands.h"
 #include "gdbstub/syscalls.h"
+#include "gdbstub/registers.h"
 #ifdef CONFIG_USER_ONLY
 #include "accel/tcg/vcpu-state.h"
 #include "gdbstub/user.h"
@@ -45,6 +46,7 @@
 #include "system/runstate.h"
 #include "exec/replay-core.h"
 #include "exec/hwaddr.h"
+#include "exec/memop.h"
 
 #include "internals.h"
 
@@ -551,6 +553,26 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
     return 0;
 }
 
+/*
+ * Target helper function to read value into GByteArray, target
+ * supplies the size and target endianess via the MemOp.
+ */
+int gdb_get_register_value(MemOp op, GByteArray *buf, uint8_t *val)
+{
+    size_t bytes = memop_size(op);
+
+    if (op & MO_BSWAP) {
+        for ( int i = bytes ; i > 0; i--) {
+            g_byte_array_append(buf, &val[i - 1], 1);
+        };
+    } else {
+        g_byte_array_append(buf, val, bytes);
+    }
+
+    return bytes;
+}
+
+
 static void gdb_register_feature(CPUState *cpu, int base_reg,
                                  gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                                  const GDBFeature *feature)
-- 
2.39.5


