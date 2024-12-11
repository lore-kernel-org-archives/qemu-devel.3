Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A388E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLWGy-0000lY-Da; Wed, 11 Dec 2024 18:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLWGw-0000lM-Fj
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:37:38 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLWGu-0007Pm-Mi
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:37:38 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso35605e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733960255; x=1734565055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dOD/dJ5Q8iBnkA8YIiW83dNp0NpX2SUkRELRiJ4WJo=;
 b=uuPFS2sgRrTnOmPDMpdGgrG1qZIGuyvvr3+IsBlVCJlTeW/unwiInC3QHh7GkVNM4V
 29RUuLNDwhEl7naghjTzqLSnHz49XN5QPJXfE3t1ucCxegXQAVW8xJklfpO/+KNs9dnF
 MH9Kqoy1u9oNkHjVHOrCp+lLoAdQMcaM7tfhskP0gqjAdRXRgdJEmJNuEu6n4UNOlFIL
 v5NEOeBj14jwE8B4TvLjciEKqFXE/a7s8o/R7tNEmtVIDJbdEDm7+AFtY8Gb6EwWycFl
 j0NlT3sb5v8ErwrPzOUJK27ssS2i24k/KsKFXmrbsjQ2vNtUDreTLnVh8VH1kS19covy
 La3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733960255; x=1734565055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dOD/dJ5Q8iBnkA8YIiW83dNp0NpX2SUkRELRiJ4WJo=;
 b=HX9OMpuqACT7irECLcthPLJIOuBo1okc8IRQiktpf4niuFLpF1mrVk0ly3RnWZtB41
 DGrqQrmPLicXPjOwRTC6KFMwK9P1FQMyzhSmxts3nqrhZ2AmWbwvRw4CIK4DFowRV1Pz
 k942AypW9ODk1vvNBLeUF9CKKLzOwC/X6KPH9QNMFza/d9a1+Xyke4jPIigwWP7YqpQ3
 kjK1A+rdjhuVR/7veyxhjWtLkXG+a1K5Ah7+5hyfMH991qSJtjJgvIl1qNe0cEnTVajO
 5jQjP5ELEKbVnf7CuuwsBqdVVlB3GY4oqyUEKrPBbHev/dDpqaRxpQaNb/OfLoArAhZu
 HI6Q==
X-Gm-Message-State: AOJu0Yza4/sHTZuJgnX3uoLttLuEX6qrO+uSoSTRn8/Ky/L/13qWiXrv
 HgXihEgcVoRRJ+XayKycdDugGxLVG5GtMhCqRR+vDWXUpcclO42kpXOEjIKUo8glkeZALpueaYc
 P
X-Gm-Gg: ASbGncuJhq11s/hCSpBbo7Q5HfoU29gtcsGsIRr912onm6Um+s9AZU5qMAxn/oyVHlz
 KkQObAC/XaanITQBeUcvBtIIlZ/OUK6kYe7Vylkqk8ECfbdC/usqh7ouHyIf7Y/ZkIhsHB+N373
 2AsjF2dmWK7Lc1FZ94MutLEJdHjlXW1vp4T9FgFcZD+s7shtAcsDKWvDMuKEq/5CUuEqtHad68q
 X2MkCOkGVhGSYabu2V48ikO2UWAR+Jp3WyaU6v37ZFotMJXNUxyfBBrPCnmkFkNBwVkHjQvZYA6
 JuFzGHywpMk0yX0fR8rWxpX0rFHdr8GbGA==
X-Google-Smtp-Source: AGHT+IGxFPnS+NYN2vFkcf2kaMduoLI5S071VgFuE2MRUP79cV5KpaPnMD9ijblnYAn326e1xf+4Xw==
X-Received: by 2002:a05:6000:481e:b0:385:e0d6:fb73 with SMTP id
 ffacd0b85a97d-3864ce54f0amr3844818f8f.15.1733960254687; 
 Wed, 11 Dec 2024 15:37:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251c4e1sm2413321f8f.89.2024.12.11.15.37.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:37:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bandan Das <bsd@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] system/qtest: Remove uses of 'first_cpu'
Date: Thu, 12 Dec 2024 00:37:26 +0100
Message-ID: <20241211233727.98923-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211233727.98923-1-philmd@linaro.org>
References: <20241211233727.98923-1-philmd@linaro.org>
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

Directly access the global &address_space_memory to reduce
access to the 'first_cpu' global (which is meaningless in
a heterogeneous emulation setup).

Cast the returned value to (void) to explicit we don't
care about invalid accesses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
We will likely remove &address_space_memory too, but one
global at a time. first_cpu is more annoying so I'm starting
with it.
---
 system/qtest.c | 53 +++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index 12703a20455..cc26dd75bef 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -16,6 +16,7 @@
 #include "sysemu/qtest.h"
 #include "sysemu/runstate.h"
 #include "chardev/char-fe.h"
+#include "exec/address-spaces.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
 #include "exec/tswap.h"
@@ -514,23 +515,23 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][5] == 'b') {
             uint8_t data = value;
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 1);
+            (void)address_space_write(&address_space_memory, addr,
+                                      MEMTXATTRS_UNSPECIFIED, &data, 1);
         } else if (words[0][5] == 'w') {
             uint16_t data = value;
             tswap16s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 2);
+            (void)address_space_write(&address_space_memory, addr,
+                                      MEMTXATTRS_UNSPECIFIED, &data, 2);
         } else if (words[0][5] == 'l') {
             uint32_t data = value;
             tswap32s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 4);
+            (void)address_space_write(&address_space_memory, addr,
+                                      MEMTXATTRS_UNSPECIFIED, &data, 4);
         } else if (words[0][5] == 'q') {
             uint64_t data = value;
             tswap64s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 8);
+            (void)address_space_write(&address_space_memory, addr,
+                                      MEMTXATTRS_UNSPECIFIED, &data, 8);
         }
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
@@ -548,22 +549,22 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][4] == 'b') {
             uint8_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 1);
+            (void)address_space_read(&address_space_memory, addr,
+                                     MEMTXATTRS_UNSPECIFIED, &data, 1);
             value = data;
         } else if (words[0][4] == 'w') {
             uint16_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 2);
+            (void)address_space_read(&address_space_memory, addr,
+                                     MEMTXATTRS_UNSPECIFIED, &data, 2);
             value = tswap16(data);
         } else if (words[0][4] == 'l') {
             uint32_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 4);
+            (void)address_space_read(&address_space_memory, addr,
+                                     MEMTXATTRS_UNSPECIFIED, &data, 4);
             value = tswap32(data);
         } else if (words[0][4] == 'q') {
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &value, 8);
+            (void)address_space_read(&address_space_memory, addr,
+                                     MEMTXATTRS_UNSPECIFIED, &value, 8);
             tswap64s(&value);
         }
         qtest_send_prefix(chr);
@@ -583,8 +584,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(len);
 
         data = g_malloc(len);
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                           len);
+        (void)address_space_read(&address_space_memory, addr,
+                                 MEMTXATTRS_UNSPECIFIED, data, len);
 
         enc = qemu_hexdump_line(NULL, data, len, 0, 0);
 
@@ -605,8 +606,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(ret == 0);
 
         data = g_malloc(len);
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                           len);
+        (void)address_space_read(&address_space_memory, addr,
+                                 MEMTXATTRS_UNSPECIFIED, data, len);
         b64_data = g_base64_encode(data, len);
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %s\n", b64_data);
@@ -640,8 +641,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                 data[i] = 0;
             }
         }
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                            len);
+        (void)address_space_write(&address_space_memory, addr,
+                                  MEMTXATTRS_UNSPECIFIED, data, len);
         g_free(data);
 
         qtest_send_prefix(chr);
@@ -663,8 +664,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         if (len) {
             data = g_malloc(len);
             memset(data, pattern, len);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                data, len);
+            (void)address_space_write(&address_space_memory, addr,
+                                      MEMTXATTRS_UNSPECIFIED, data, len);
             g_free(data);
         }
 
@@ -697,8 +698,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             out_len = MIN(out_len, len);
         }
 
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                            len);
+        (void)address_space_write(&address_space_memory, addr,
+                                  MEMTXATTRS_UNSPECIFIED, data, len);
 
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
-- 
2.45.2


