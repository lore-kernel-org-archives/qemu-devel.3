Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4EAE9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9c2-0003bs-88; Thu, 19 Feb 2026 14:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9b6-0002hK-H5
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9b3-00087i-Es
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48371119eacso12115555e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528913; x=1772133713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIBF2HW/bZyg5pcbM7t2mPIZcp+EQrzY/Ap5rHYsQ+w=;
 b=K3TJ2qUHPZudLtvUpjs6uPBNPyYDoaCvzTLbIymSUHCRT5GV4PbjzQlzP12ToLGCTW
 1vICEMunH2t0JjhEbOfu0bk4cTymrlEkOo1gMdlfuKAdtSFMsEYApPTutz964t1FySsF
 sR6ZE7YGwx3WWu+ELUUkM088jZ/xbcViYLbbRLQz5QxU/JhpKea6la9IlfbVtEdYmMb8
 GofaBU9yq0eOsGMk114ailZHRCTVxm9uj+TTw3MMPJQzxy1TQV++TJ05DyWzaZeDV3kp
 7bV3GdmMnBT7h/RUzBSw/Xc5caMAQcE/4C3Tm5l3rvzdwa1LNozy8X/UWtqy+DJv+Lib
 LJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528913; x=1772133713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GIBF2HW/bZyg5pcbM7t2mPIZcp+EQrzY/Ap5rHYsQ+w=;
 b=L3Hp3tpAYypN72jEgVusNVwLumP0zU//jXzFL2+K3g5pvFIqxlFt9+AQC63MVPWW5h
 OP+pRoclX30Jz/mWszFjzWL3NTMaj2rDnd2sYXc5Sz+RXzOdhYLUvrnILD1OGHpDh43a
 vslHKx3G7RaJS7lAhMJ33BYgz3kqLKnjHh5ttthJ3k5f3ugKk09OgrDRhvqIc0Imh7Pz
 lnIKO1ADjm2QKSSYXOW5/GJKMqqMNFsdG94elVo8vkidnJ0pmGCyCFMqGgRK4lmnHEeo
 94pyNl65DQevK5wwwvnMXXT+tg6wsJIKFWYIkRmGHuq0uflhP4uRUPwHKgE16sAJrWq6
 W+ew==
X-Gm-Message-State: AOJu0YxXV1nVB/4eMiIt9za7JFghDU0b/SQLmMme0iZ2Iw6Iz+Vf1SRK
 JYf7tBQMOKE8YkyIf28yemWV6GjQOlnlw9iaox1IvpAV7hT1SEVtmpbQbCORibajZ9wda6p5KhV
 bfsCLBmeqpQ==
X-Gm-Gg: AZuq6aJMZJi0nZj2r/bKbgv0hn4Ms04+qB/dMSZFly7CJHKhNdxTu1VNjKiZ8ayRdt4
 kmTVh1wcCfecdW+jUFVwiu10cWP7vOfRJQsvgOWuA4MZjQUtXN6SDXIVlazq5P+NGs0QNKme4dO
 CHrPuhunPM4hEkNHgI9neXivsoU2T1ddXvMjESOkYoMwVqfrJE2fP2zjh3Cz/w1RLcS9yy9MH7l
 ELcyne+E6XRFZfoUtW7IETA204jYfE0RyyAyEgzUL9cKJZjcoY5pRrlLlxTVnc3vOXWxCjPIMZM
 9o8K7oECU/OCqLPkxHP9msvQYc0fmdS4J3JCC3+/euKdQzlVnAShpJjNtyGIK7ZM5cqClLlUh+8
 TnU0vs8yNX0NrnF7JqB/LqfkDAhFhU3VrADnkh/6jbsfKPWE/npRzxDy+7nLPJ1gl35lLiyNV5z
 3UAYmqi6IGgCreF8uitkt+B3NUop2FD4GL+pGMgVvYPAG2/goV0KlrDd+gnHmGMc86K9wTZ8xTI
 WsIT5VHPAQ=
X-Received: by 2002:a05:600c:4e54:b0:480:4a90:1af2 with SMTP id
 5b1f17b1804b1-4839c002d65mr100597615e9.35.1771528913236; 
 Thu, 19 Feb 2026 11:21:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31f9475sm18396265e9.14.2026.02.19.11.21.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:21:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 16/50] monitor/hmp: Handle gdb-xml exposed registers via
 gdb_get_register()
Date: Thu, 19 Feb 2026 20:19:18 +0100
Message-ID: <20260219191955.83815-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Implement the gdb_get_register() helper and call it before the
regular get_monitor_def() one. Registers is exposed via the
GDB XML files will be directly handled, possibily allowing new
registers added to XML files to be automatically accessible in
QEMU monitor. All targets having GDB XML files can now be used
within the monitor.

For example with Loongarch, before:

  $ qemu-system-loongarch64 -M virt -S -monitor stdio
  QEMU 10.2.0 monitor - type 'help' for more information

  (qemu) info registers

  CPU#0
   PC=000000001c000000  FCSR0 0x00000000
   ...

  (qemu) p/x $pc
  unknown register
  Try "help p" for more information
  (qemu)

and after:

  $ ./qemu-system-loongarch64 -M virt -S -monitor stdio
  QEMU 10.2.50 monitor - type 'help' for more information
  (qemu) p/x $pc
  0x1c000000
  (qemu)

Similarly RISC-V:

  QEMU 10.2.0 monitor - type 'help' for more information
  (qemu) p/x $pc
  unknown register
  Try "help p" for more information

VS

  QEMU 10.2.50 monitor - type 'help' for more information
  (qemu) p/x $pc
  0x1000
  (qemu)

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
TODO (Dave on v1):
add more checks on the return size of
gdb_read_register(..) just in case any arch is a bit screwy
(e.g. if they're 0 for example?)
---
 monitor/hmp.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 0a5bbf82197..0e5913fabb1 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -27,14 +27,18 @@
 #include "hw/core/qdev.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-target.h"
 #include "qobject/qdict.h"
 #include "qobject/qnum.h"
+#include "qemu/bswap.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
+#include "exec/gdbstub.h"
 #include "system/block-backend.h"
 #include "trace.h"
 
@@ -306,6 +310,46 @@ void hmp_help_cmd(Monitor *mon, const char *name)
     free_cmdline_args(args, nb_args);
 }
 
+/*
+ * Set @pval to the value in the register identified by @name.
+ * return %true if the register is found, %false otherwise.
+ */
+static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
+{
+    g_autoptr(GArray) regs = NULL;
+    CPUState *cs = mon_get_cpu(mon);
+
+    if (cs == NULL) {
+        return false;
+    }
+
+    regs = gdb_get_register_list(cs);
+
+    for (int i = 0; i < regs->len; i++) {
+        GDBRegDesc *reg = &g_array_index(regs, GDBRegDesc, i);
+        g_autoptr(GByteArray) buf = NULL;
+        int reg_size;
+
+        if (!reg->name || g_strcmp0(name, reg->name)) {
+            continue;
+        }
+
+        buf = g_byte_array_new();
+        reg_size = gdb_read_register(cs, buf, reg->gdb_reg);
+        if (reg_size > sizeof(*pval)) {
+            return false;
+        }
+
+        if (target_big_endian()) {
+            *pval = ldn_be_p(buf->data, reg_size);
+        } else {
+            *pval = ldn_le_p(buf->data, reg_size);
+        }
+        return true;
+    }
+    return false;
+}
+
 /*******************************************************************/
 
 static const char *pch;
@@ -338,7 +382,6 @@ static int64_t expr_unary(Monitor *mon)
 {
     int64_t n;
     char *p;
-    int ret;
 
     switch (*pch) {
     case '+':
@@ -393,8 +436,8 @@ static int64_t expr_unary(Monitor *mon)
                 pch++;
             }
             *q = 0;
-            ret = get_monitor_def(mon, &reg, buf);
-            if (ret < 0) {
+            if (!gdb_get_register(mon, &reg, buf)
+                && get_monitor_def(mon, &reg, buf) < 0) {
                 expr_error(mon, "unknown register");
             }
             n = reg;
-- 
2.52.0


