Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB2FC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewj-0002tj-9R; Mon, 24 Mar 2025 06:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewL-0002jm-MP
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:54 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewG-0006zm-N6
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:52 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5b6f3025dso6360617a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811707; x=1743416507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQxQFIFLKkSMaiU0IyJnJ1HI7neBwpu7NlcNgtElhLA=;
 b=plkzUrM+kJNKT0rJpwOLt6M3PjnXKCmW0qdRWznDoper23o8gIpYXYRjBh1yCSDucP
 FsJSjDpgtxQdOFg4QIfTtwVol60n+dx+VLVUNAeCXG8LjPqify75FWVDOG4hIhR4X5SO
 EogW7+5JqhyKfSxbJT3BQOtqaBPjAJ1ZvyygMAC4zdFqJsqclW04v9YIdmRr2e5VG1T/
 stfmoe9rdMqyc90pSe7DxQjOfRiJcmXzwoGy/DAPQmifrC1kG09ntySU45TX0zQ5aMAl
 Ck5VM6X17uiA3qLPRXHNghQSUmv98gZWvRhlqFP78ST+0sA9hSoHzyROzkerlMcHaY2j
 TXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811707; x=1743416507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQxQFIFLKkSMaiU0IyJnJ1HI7neBwpu7NlcNgtElhLA=;
 b=ER5Ldg3hmWBnEGa/8AOVSLBUX/Fjm9BjvondhgohCQGZ/IcW1kG/iqU4soyAgeseMS
 oVlH/RV4kG1ippV4glvWu9/MARDMKlT3MA/IICmni07GbcDpVIO5o+h0IAuD/oAIYikQ
 W+0BbxhXSDVyv4FPo+Q6sKehz3I01ukztRj0UMekFimLiNVDPxgDg6Ll1UAZBOg/q3iE
 MFrObkV9iuqyr7Jca3N4JIWM6wPPgFRMo2SFiTybjDiTNmEU3HFzDkRAtBap5fkFQqdK
 N7+syLHZJL05UWwqYCrgb5eKI4u8XQZ37C2kC9Rzepb2lkqkbmQJzPCmgo4KkxhoXAJL
 pz0A==
X-Gm-Message-State: AOJu0YznrWtA4CFArKO10NtH76wWOfCMiWoGXmTjT1/jBnla8Myi4euv
 c91DD7Qkl58n7nEIplfLTtudC/JuSM0qUZr9qnBajsrbdJ/FTrV+KBr+O2FsL9A=
X-Gm-Gg: ASbGncsNwL8m8089TKhxXTT9bBEFOHokPjooWl3zFkhd+ez4JqePh7cVAGRksfTVp8v
 jC/52+I399kSNmFXtBmCxE2SQ63y0L+vMAvrtEzKOt81gu9YLnlBuWgSGISh0hZdwXBW6ckVOQ8
 ZdaRdbJ2VbkZZSWhAcLYVlLEpxA//YHuhF1YcKhf54swUjNrj2cbaQIKx/BKHDCoN9eEDB/N2T2
 9CqBeD6mqrKHwwPC/xK40XHXYZ/ucCM4P7g8QKZ+ukiZNd0yDazd4eSdpwmN0az0LcknvxM6429
 Fkv8FRcHh9AaJJqRAwBMt+HXIcXnv7RGYEgOUXlFFfh98Kc=
X-Google-Smtp-Source: AGHT+IG1NvIDnqPcUhX0DNHpjpgTWH/FxoPfqWOijYLg+UStAPD6cFivzQ1JCOsYqdQvZD5KZ+XV0g==
X-Received: by 2002:a05:6402:42c6:b0:5e5:9a2b:167a with SMTP id
 4fb4d7f45d1cf-5ebcd468ed3mr11530410a12.17.1742811706141; 
 Mon, 24 Mar 2025 03:21:46 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebccf8ccb0sm5820322a12.30.2025.03.24.03.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1B335FB96;
 Mon, 24 Mar 2025 10:21:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 04/11] gdbstub: introduce target independent gdb register
 helper
Date: Mon, 24 Mar 2025 10:21:35 +0000
Message-Id: <20250324102142.67022-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

The current helper.h functions rely on hard coded assumptions about
target endianess to use the tswap macros. We also end up double
swapping a bunch of values if the target can run in multiple endianess
modes. Avoid this by getting the target to pass the endianess and size
via a MemOp and fixing up appropriately.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use unsigned consistently
  - fix some rouge whitespace
  - add typed reg32/64 wrappers
  - pass void * to underlying helper to avoid casting
---
 include/gdbstub/registers.h | 55 +++++++++++++++++++++++++++++++++++++
 gdbstub/gdbstub.c           | 23 ++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 include/gdbstub/registers.h

diff --git a/include/gdbstub/registers.h b/include/gdbstub/registers.h
new file mode 100644
index 0000000000..2220f58efe
--- /dev/null
+++ b/include/gdbstub/registers.h
@@ -0,0 +1,55 @@
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
+ * There are wrapper functions for the common sizes you can use to
+ * keep type checking.
+ *
+ * Returns the number of bytes written to the array.
+ */
+int gdb_get_register_value(MemOp op, GByteArray *buf, void *val);
+
+/**
+ * gdb_get_reg32_value() - type checked wrapper for gdb_get_register_value()
+ * mo: size and endian MemOp
+ * buf: GByteArray to store in target order
+ * val: pointer to uint32_t value in host order
+ */
+static inline int gdb_get_reg32_value(MemOp op, GByteArray *buf, uint32_t *val) {
+    g_assert((op & MO_SIZE) == MO_32);
+    return gdb_get_register_value(op, buf, val);
+}
+
+/**
+ * gdb_get_reg64_value() - type checked wrapper for gdb_get_register_value()
+ * mo: size and endian MemOp
+ * buf: GByteArray to store in target order
+ * val: pointer to uint32_t value in host order
+ */
+static inline int gdb_get_reg64_value(MemOp op, GByteArray *buf, uint64_t *val) {
+    g_assert((op & MO_SIZE) == MO_64);
+    return gdb_get_register_value(op, buf, val);
+}
+
+#endif /* GDB_REGISTERS_H */
+
+
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b6d5e11e03..e799fdc019 100644
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
 
@@ -551,6 +553,27 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
     return 0;
 }
 
+/*
+ * Target helper function to read value into GByteArray, target
+ * supplies the size and target endianess via the MemOp.
+ */
+int gdb_get_register_value(MemOp op, GByteArray *buf, void *val)
+{
+    unsigned bytes = memop_size(op);
+
+    if (op & MO_BSWAP) {
+        uint8_t *ptr = &((uint8_t *) val)[bytes - 1];
+        for (unsigned i = bytes; i > 0; i--) {
+            g_byte_array_append(buf, ptr--, 1);
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


