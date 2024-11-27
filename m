Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2FED6D22E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 19:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGNZQ-0002Li-Sl; Wed, 27 Nov 2024 14:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGNZK-0002LP-M9
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 14:19:23 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGNZI-0006DV-W4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 14:19:22 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434a9f2da82so23675e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 11:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732735159; x=1733339959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4ilIr5IjJMRG1FV3f50ShmHtgY8dkOoKs/arzlwSbMY=;
 b=owq5EW/zx+GIAR/+P2JbmO5VyfOQqtVDqEj/YFe+4djChhuz4ktN9LcVwF7NMlDOFx
 3Z+j56+KFdvMH2+LL7DOl3t7+UAlWOhaLpXYs7JsVAMjQzWSYJ+J+4rraZO3xbF4NPI9
 aoSlK3JuA6SdSdC3hb6XQPUwqPIeUJjKIyW8sUxCkJjUGW7Hl5cQDsQudClftiTQ0uuv
 Q9+3NdoiLxwefbjBHgaAtbntTGVzJ0WRTmpdSy6L50uKlSYMYeO4xmdLho+Cr1hQSV0F
 MNDgB6KsyNMkJBp6u79JjfiaDBGWK3+U5Hw0o79MgbaFUAX7zpmJAzSpsX2YvCxcDifR
 Qb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732735159; x=1733339959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ilIr5IjJMRG1FV3f50ShmHtgY8dkOoKs/arzlwSbMY=;
 b=ZxWDBclP+oMNo+wnY5C4FxlTmS3ADTrSxAXc4qvwUmtskJgv+Gkp9bBj0kX1mcXT17
 67O8uR7SIegdESTkpUlg0Q4oSUbiiIrMhdJQ1OJLGLyVbUR3/Yjj6BNc8Dl2tJr5uEhk
 Z91grlFn2ZM2U3YOM4Iov04bHRmeoFj7ueb5WIhplZIR8ANq6fDWekLlD/W6d4kwNWTj
 9bymo58Ka0nJQL6xUs4uofGM9o9BLivns4mIKt7Gf+A72z0KYv0dSynT1yKWCsZcfvKa
 60SvPgBkYbcBczoknyECFvCTrf3ii73+a0k3Becdqz3WRiXbb6jo4M4RzzXgsLg2ma06
 s9IQ==
X-Gm-Message-State: AOJu0YyTNeGOGD72O2nrbHSereo+X0H6jIASb8F6JqWwi4AxaRJ5kd5S
 IrN6Kw45GYtQKQgmdpEXgQ4R7V0OkCFmxhBBqhl6/OBQqF+vKRCwbFRajMMB+rrES0Pfko0uDtz
 W
X-Gm-Gg: ASbGncuitAsJYipuWobQ5KivZGpT8ra+qosBAYN2b4XYnm/v3hcx8HEPUhDpUf754HP
 6DqaWZrGTrcBa8+tXlJ9Jz4HnX4gFt7YDd71IqKfR1TQPlQDcC9egHVTWLf2VNjJjRWnTy+ltdF
 FIBWR5GBK0mTBQCltor4RHkJDn0DzbzlEk9AEMcQMSJ7AUFACqyITxY0l4hMONi3CXZrCgDfeOc
 yv633+s6b/9WWaDJSM7QMS1v/0E2uczF+5fUN8OzwrRS/lePPIW0sSHXhsr/nAI6NrDwn/FWXGc
 SypWGxR1257akh/2RceaHa4F8bNzWKPjfO4xq/NUagA=
X-Google-Smtp-Source: AGHT+IGhhVMotrcIP+cBJHJQs3OeVfK5zBIwKSuRNxtO2N/FWn7JXxETH4F4cGBXfzevPLNEhjg0nQ==
X-Received: by 2002:a05:600c:444e:b0:431:44fe:fd9a with SMTP id
 5b1f17b1804b1-434a9dc8297mr35380195e9.19.1732735158806; 
 Wed, 27 Nov 2024 11:19:18 -0800 (PST)
Received: from localhost.localdomain
 (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr. [176.184.14.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7e256esm29599145e9.32.2024.11.27.11.19.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Nov 2024 11:19:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0] system/qtest: Access memory using
 cpu_physical_memory_rw() API
Date: Wed, 27 Nov 2024 20:19:14 +0100
Message-ID: <20241127191914.34146-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
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

There is no vCPU within the QTest accelerator (well, they
are stubs doing nothing, see dummy_cpu_thread_fn).
Directly use the cpu_physical_memory_rw() API -- which
amusingly prefixed 'cpu_' does not use vCPU -- to access
memory. This reduces accesses to the global 'first_cpu'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qtest.c | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index 12703a20455..a2de9a7d5a4 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -18,6 +18,7 @@
 #include "chardev/char-fe.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
+#include "exec/cpu-common.h"
 #include "exec/tswap.h"
 #include "hw/qdev-core.h"
 #include "hw/irq.h"
@@ -514,23 +515,19 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][5] == 'b') {
             uint8_t data = value;
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 1);
+            cpu_physical_memory_write(addr, &data, 1);
         } else if (words[0][5] == 'w') {
             uint16_t data = value;
             tswap16s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 2);
+            cpu_physical_memory_write(addr, &data, 2);
         } else if (words[0][5] == 'l') {
             uint32_t data = value;
             tswap32s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 4);
+            cpu_physical_memory_write(addr, &data, 4);
         } else if (words[0][5] == 'q') {
             uint64_t data = value;
             tswap64s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 8);
+            cpu_physical_memory_write(addr, &data, 8);
         }
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
@@ -548,22 +545,18 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][4] == 'b') {
             uint8_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 1);
+            cpu_physical_memory_read(addr, &data, 1);
             value = data;
         } else if (words[0][4] == 'w') {
             uint16_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 2);
+            cpu_physical_memory_read(addr, &data, 2);
             value = tswap16(data);
         } else if (words[0][4] == 'l') {
             uint32_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 4);
+            cpu_physical_memory_read(addr, &data, 4);
             value = tswap32(data);
         } else if (words[0][4] == 'q') {
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &value, 8);
+            cpu_physical_memory_read(addr, &value, 8);
             tswap64s(&value);
         }
         qtest_send_prefix(chr);
@@ -583,9 +576,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(len);
 
         data = g_malloc(len);
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                           len);
-
+        cpu_physical_memory_read(addr, data, len);
         enc = qemu_hexdump_line(NULL, data, len, 0, 0);
 
         qtest_send_prefix(chr);
@@ -605,8 +596,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(ret == 0);
 
         data = g_malloc(len);
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                           len);
+        cpu_physical_memory_read(addr, data, len);
         b64_data = g_base64_encode(data, len);
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %s\n", b64_data);
@@ -640,8 +630,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                 data[i] = 0;
             }
         }
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                            len);
+        cpu_physical_memory_write(addr, data, len);
         g_free(data);
 
         qtest_send_prefix(chr);
@@ -663,8 +652,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         if (len) {
             data = g_malloc(len);
             memset(data, pattern, len);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                data, len);
+            cpu_physical_memory_write(addr, data, len);
             g_free(data);
         }
 
@@ -696,9 +684,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                            len, out_len);
             out_len = MIN(out_len, len);
         }
-
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                            len);
+        cpu_physical_memory_write(addr, data, len);
 
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
-- 
2.45.2


