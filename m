Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499DDC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 01:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsJN-0004ne-64; Sun, 18 Feb 2024 20:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIh-0003Zk-1J; Sun, 18 Feb 2024 20:18:33 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIe-0004K0-NX; Sun, 18 Feb 2024 20:18:30 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-607f8482b88so22613817b3.0; 
 Sun, 18 Feb 2024 17:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305500; x=1708910300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5v3rqQLdf3b5YXiRwBfIAauAiypwurxDmQ+q45Unrk=;
 b=Da0qadC1+XK2LK2Ek0Hvbn5xMY7NWaGHDqmIDwVgLucW8reDhplGxbEbpICtGCs1Z8
 IVo5q2Jkr93Mv+L7SYfaNlazsWdVD1bdbCSYRHcTnYJdHkPZCWCXO3hoLbabWvdNRHWm
 +f5DEkqQc9Brb10KwmsXTMh9fRo/sBUJ8BOk+xly19WL6qx/sOgxEVatMjMFDuSubReG
 yzZY9+1dlwEeDFK/CkIZasn8chUAGlHssmruaeHvNr/0FZs/mxzhY/1XMbQ6w31wi5DU
 wXkRX5ufykzUDvcpzwIC5La8wDov+LLy0xMGA7GM5ZRQZQmy93WgglblpEnDd09Kqa8m
 CzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305500; x=1708910300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5v3rqQLdf3b5YXiRwBfIAauAiypwurxDmQ+q45Unrk=;
 b=OPjk04YVnZi+6NlImO6DIrYIhdx1u/0vBtflc3RW8eBzc4qDqntCbR+7VfoEhm4qr1
 WPzmQ7VQugx+QJJMFRznSTqbTwkFAWDGJYz6sT6KDMf7xqaqPRgnWqkoEJeq66Y0YX8N
 oAJioJZZFTmVbGNFTcYtdBYnMZvTQaRsSQ485UyIBziRxAQJfx/XPfwtKGvO7Bk/sokG
 jKaoGDQnCV8ICKdQU4ES4QEKq7Dfg6QG84Mi5Ka/GoufHSLcgSxPB+WXFi9KKamko+VY
 vBSUAuDgwzT+vSLMQvO2WJBOPEUQy0LBoW3ZH/1r8opX7K3HugZF8I7ElibCuQl68Wbo
 Yngg==
X-Gm-Message-State: AOJu0YwOqrnyMBcgzb0XB6LVr+vRAy1qnCKv5uATPRmLNBkxokQiB6yZ
 v5gOBekIuLg6r0PvVX7bNG5TglIcqZnhJQJ0eQF7tysmMFQZqvJ3wztZfiH5S4w=
X-Google-Smtp-Source: AGHT+IERAAycGtxT0XzUfeYTnv1aCRvsFzBdRBRGUcXH+7mcRFRL/hRET40GqP9lno7vmr3MACIjHQ==
X-Received: by 2002:a0d:e816:0:b0:608:21a0:229c with SMTP id
 r22-20020a0de816000000b0060821a0229cmr2754743ywe.35.1708305500342; 
 Sun, 18 Feb 2024 17:18:20 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:18:20 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 31/41] Add mailbox test stub
Date: Sun, 18 Feb 2024 19:17:29 -0600
Message-Id: <20240219011739.2316619-32-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112b.google.com
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mailbox.c | 60 +++++++++++++++++++++++++++++++++++
 tests/qtest/bcm2838-mailbox.h | 37 +++++++++++++++++++++
 tests/qtest/meson.build       |  1 +
 3 files changed, 98 insertions(+)
 create mode 100644 tests/qtest/bcm2838-mailbox.c
 create mode 100644 tests/qtest/bcm2838-mailbox.h

diff --git a/tests/qtest/bcm2838-mailbox.c b/tests/qtest/bcm2838-mailbox.c
new file mode 100644
index 0000000000..0928a3dff8
--- /dev/null
+++ b/tests/qtest/bcm2838-mailbox.c
@@ -0,0 +1,60 @@
+/*
+ * Helper functions to work with BCM2838 mailbox via qtest interface.
+ *
+ * Copyright (c) 2023 Auriga LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/registerfields.h"
+#include "libqtest-single.h"
+#include "bcm2838-mailbox.h"
+
+REG32(MBOX_EXCHNG_REG,          0)
+FIELD(MBOX_EXCHNG_REG, CHANNEL, 0, 4)
+FIELD(MBOX_EXCHNG_REG, DATA,    4, 28)
+
+static uint32_t qtest_mbox0_read_reg32(QTestState *s, uint32_t offset)
+{
+    return qtest_readl(s, MBOX0_BASE + offset);
+}
+
+static void qtest_mbox1_write_reg32(QTestState *s, uint32_t offset, uint32_t value)
+{
+    return qtest_writel(s, MBOX1_BASE + offset, value);
+}
+
+static void qtest_mbox1_write(QTestState *s, uint8_t channel, uint32_t data)
+{
+    uint32_t mbox_reg = 0;
+
+    mbox_reg = FIELD_DP32(mbox_reg, MBOX_EXCHNG_REG, CHANNEL, channel);
+    mbox_reg = FIELD_DP32(mbox_reg, MBOX_EXCHNG_REG, DATA, data);
+    qtest_mbox1_write_reg32(s, MBOX_REG_WRITE, mbox_reg);
+}
+
+int qtest_mbox0_has_data(QTestState *s) {
+    return !(qtest_mbox0_read_reg32(s, MBOX_REG_STATUS) & MBOX_READ_EMPTY);
+}
+
+void qtest_mbox0_read_message(QTestState *s,
+                              uint8_t channel,
+                              void *msgbuf,
+                              size_t msgbuf_size)
+{
+    uint32_t mbox_reg;
+    uint32_t msgaddr;
+
+    g_assert(qtest_mbox0_has_data(s));
+    mbox_reg = qtest_mbox0_read_reg32(s, MBOX_REG_READ);
+    g_assert_cmphex(FIELD_EX32(mbox_reg, MBOX_EXCHNG_REG, CHANNEL), ==, channel);
+    msgaddr = FIELD_EX32(mbox_reg, MBOX_EXCHNG_REG, DATA) << 4;
+    qtest_memread(s, msgaddr, msgbuf, msgbuf_size);
+}
+
+void qtest_mbox1_write_message(QTestState *s, uint8_t channel, uint32_t msg_addr)
+{
+    qtest_mbox1_write(s, channel, msg_addr >> 4);
+}
diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
new file mode 100644
index 0000000000..e9e1f53bc9
--- /dev/null
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -0,0 +1,37 @@
+/*
+ * Declarations for BCM2838 mailbox test.
+ *
+ * Copyright (c) 2023 Auriga LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+typedef struct {
+    uint32_t size;
+    uint32_t req_resp_code;
+} MboxBufHeader;
+
+#define DECLARE_TAG_TYPE(TypeName, RequestValueType, ResponseValueType) \
+typedef struct {                                                        \
+    uint32_t id;                                                        \
+    uint32_t value_buffer_size;                                         \
+    union {                                                             \
+        struct {                                                        \
+            uint32_t zero;                                              \
+            RequestValueType value;                                     \
+        } request;                                                      \
+        struct {                                                        \
+            uint32_t size_stat;                                         \
+            ResponseValueType value;                                    \
+        } response;                                                     \
+    };                                                                  \
+} TypeName
+
+
+int mbox0_has_data(void);
+void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
+void mbox1_write_message(uint8_t channel, uint32_t msg_addr);
+int qtest_mbox0_has_data(QTestState *s);
+void qtest_mbox0_read_message(QTestState *s, uint8_t channel, void *msgbuf, size_t msgbuf_size);
+void qtest_mbox1_write_message(QTestState *s, uint8_t channel, uint32_t msg_addr);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2b89e8634b..e312634963 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -333,6 +333,7 @@ qtests = {
   'virtio-net-failover': files('migration-helpers.c'),
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
+  'bcm2838-mbox-property-test' : files('bcm2838-mailbox.c'),
 }
 
 if vnc.found()
-- 
2.34.1


