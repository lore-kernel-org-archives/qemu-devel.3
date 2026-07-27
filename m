Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCC1C531F9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 02:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woBNR-00013q-0Q; Sun, 26 Jul 2026 22:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tripprobins@gmail.com>)
 id 1woBNI-00012i-MV
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:47:28 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tripprobins@gmail.com>)
 id 1woBNG-00034f-Da
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:47:27 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-92e5cb052edso164352985a.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 19:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785120445; x=1785725245; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z3bq6eo0G2v8eCJGcTWAORRzCIT9S/JGm0tS1oh/lsQ=;
 b=m2x+wvUfB/KyLehgGGW+A0bs6NAxDYQ9iLndo2ncgAKF6A2/adOitoiTs5BXiHP0cC
 3UGH7yEGLY9adg8ookr6Sla5/g64RMAKHmbxTLnpQC6cM3V1TyEi11WjUxXWaOHKMst8
 noLxHHr5ynhxC4oFj6/uhmxi8/mNv8rQCQavlmDmIYmZfFC6TCMroxrp0dBqQl5OhI0j
 62BS+vcHERbNlhZLstkkoVsGW9KxGuK9pcP4zg5hxKVI/XxtG/Ut8i3W59FOpW6/FF8d
 +TrkO9tRLnR7FTjKqc9YxC0K4SF7y17Vy86zcU4qlGQ3F4oMkRn9pOZ04gk/aObC5Zcy
 Ifng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785120445; x=1785725245;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z3bq6eo0G2v8eCJGcTWAORRzCIT9S/JGm0tS1oh/lsQ=;
 b=oviyW7q9zg3Xpi066h5ChGRAIuGATHsoK/S7ehDQJjy6y1xg8WhAcsBFTELcA/E74Y
 CaKiQPNCgO4ziCaSjN3m2atj3NMsPrYOo3DHdFh5y4H+eNDT3+9eewn9fmsaUQJBZ2yZ
 3MGkca2Jy5hSzcGZktJ+DRL65PXumrMICI1S397l21LNjexS820Tkat8e0mFSHvUMHDO
 CKOCEMrQIHXiO0ypWmszcIaq+rELH14MJgRde3e2cpTS/d2KasdudKD7HjcSvtECPLT0
 xVMPZMKWtqfVYkvstmtLX7MvCaaQSpHEU+xqS8Y9Q0hLoJ8SJJt0fRAklHaPQq8Vx94q
 CVlQ==
X-Gm-Message-State: AOJu0YzmqrGY+amcR7x1/NyUeP4Nnrya+XdmXRY5xYRNL23pGU14u7H3
 qV4pEDGBVX1HHqsQps4MlOoWmad0TIwja9dYSIGrhqdpy4Ug7rw14TGBYtSPPpxk
X-Gm-Gg: AR+sD10rNIwNd/33rqXCx66YQUXeuUrlsxlqkoGnER8ohATykJDkqAjCZut5fa+aezp
 Lvt4Jzw77wUIYBOpZL/qDdfqRdwhDfTHiZT9TkVMhmp+mpgmvTh5zl+e7mSi32r8P29SqJQT5d5
 T8rzv9NZdryEizkngzA3lNkRSnGvRYIIXiHF3ibGMyEsZ3CSbp4YHva1+cQzwMyz3scGHY69m78
 NIp9s7Yzrd3dUNPJRusSFvxhqLp76IdaYsW9/6mNvCv4c1pj5/KDOYzrAz03GbHjCxSp1ouT7F+
 jxfP24/e396EvJ6XQ3Y+7Je+to94f0gFCD4vKryblhgZygFJCjb7FhqYy76mO97s61+XMa9xw9d
 bOSQGZ/q2279m3srgTa0mU14MyXo3bQHa4TD01YtWSXG96U/UZ4j9FCUUYe8tYPkBB6D7u3PoUf
 CwFl0LJA==
X-Received: by 2002:a05:620a:a0da:10b0:931:3d6:18fe with SMTP id
 af79cd13be357-932df751da3mr501002985a.64.1785120444923; 
 Sun, 26 Jul 2026 19:47:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:4040:5aa1:a000:4c84:45d:753f:5a58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de635f12sm510118485a.25.2026.07.26.19.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 19:47:24 -0700 (PDT)
From: Tripp R <tripprobins@gmail.com>
Date: Sun, 26 Jul 2026 22:47:06 -0400
Subject: [PATCH] added the inpsect block command ('xb') to print the
 contents within a block device to the monitor.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-xbcmd-v1-1-0ddbdcf82fcb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKnGZmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMz3Yqk5NwUXfO0RAsLSwMz8zRDUyWg2oKi1LTMCrA50bG1tQBrKHn
 aVwAAAA==
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Tripp R <tripprobins@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785120443; l=5896;
 i=tripprobins@gmail.com; h=from:subject:message-id;
 bh=ob3ODSYt/xVJwmYiVgV7i/pWEKmzO4+R5bIxGQXMiHY=;
 b=3oLrjHqaNk83J9nvFr8W4OCODmZ91/0jQEyKBSkWDkIPNtDsACg+xcAbNgbCS0dECEuMGogbc
 1+COYCDMrCmBP1Z53mWbdHASEJh5LqoGpgnP7iwy9IalPBWyeVoypnC
X-Developer-Key: i=tripprobins@gmail.com; a=ed25519;
 pk=qwr69xU8AQT+ZZ9TxMEd/Vlg8k8ovtJrkXWQKAiMMNw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=tripprobins@gmail.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

'xb' (examine block) is almost identical in usage to 'x' and 'xp', having the same targuments for those commands , albeit preceded by a drive name.

---
Implemented the xb (examine block) command to print the contents of a block     device to the console.

It is effectively a clone of the x/xp commands (examine memory / examine        physical memory), having the same arguments for those commands, albeit preceded by the name of a block driver.

e.g. usage
         xd floppy0 /510c 0

Signed-off-by: Tripp R <tripprobins@gmail.com>
---
 hmp-commands.hx       |  14 +++++++
 include/monitor/hmp.h |   1 +
 monitor/hmp-cmds.c    | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7ae2468a3d..db63b58a47 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -472,6 +472,20 @@ ERST
         .cmd        = hmp_memory_dump,
     },
 
+SRST
+``xb/``\ *fmt* *addr*
+  Block memory dump starting at *addr*.
+ERST
+
+    {
+        .name       = "xb",
+        .args_type  = "device:s, fmt:/,addr:l",
+        .params     = "device /fmt addr",
+        .help       = "block memory dump starting at 'addr'",
+        .cmd        = hmp_block_dump,
+    },
+
+
 SRST
 ``x/``\ *fmt* *addr*
   Virtual memory dump starting at *addr*.
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 9258a049bf..0c3e8a30c2 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -182,6 +182,7 @@ void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_sgx(Monitor *mon, const QDict *qdict);
 void hmp_info_via(Monitor *mon, const QDict *qdict);
+void hmp_block_dump(Monitor *mon, const QDict *qdict);
 void hmp_memory_dump(Monitor *mon, const QDict *qdict);
 void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
 void hmp_info_registers(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e9fb8d827a..5d4a6c6a78 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -39,8 +39,12 @@
 #include "system/hw_accel.h"
 #include "system/memory.h"
 #include "system/system.h"
+#include "system/block-backend-common.h"
+#include "system/block-backend-io.h"
+#include "system/block-backend-global-state.h"
 #include "disas/disas.h"
 
+
 /* Please update hmp-commands.hx when adding or changing commands */
 static HMPCommand hmp_info_cmds[] = {
 #include "hmp-commands-info.h"
@@ -584,6 +588,89 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
     }
 }
 
+
+static void block_dump(Monitor *mon, BlockBackend* blk, int count, int format, 
+    int wsize, int64_t offset)
+{
+    uint8_t buf[16];
+
+    uint16_t max_digits = 0;
+
+    switch (format) {
+    case 'o':
+        max_digits = DIV_ROUND_UP(wsize * 8, 3);
+        break;
+    default:
+    case 'x':
+        max_digits = (wsize * 8) / 4;
+        break;
+    case 'u':
+    case 'd':
+        max_digits = DIV_ROUND_UP(wsize * 8 * 10, 33);
+        break;
+    case 'c':
+        wsize = 1;
+        break;
+    }
+
+
+    while (count > 0) {
+        int bytes = MIN(16, count * wsize);
+
+        if (blk_pread(blk, offset, bytes, buf, 0) < 0) {
+            monitor_printf(mon,
+                           "Read failed at 0x%" PRIx64 "\n",
+                           offset);
+            return;
+        }
+
+        monitor_printf(mon, "%08" PRIx64 ": ", offset);
+
+        for (int i = 0; i < bytes; i += wsize) {
+            uint64_t v;
+
+            switch (wsize) {
+            case 1:
+                v = buf[i];
+                break;
+            case 2:
+                v = lduw_le_p(buf + i);
+                break;
+            case 4:
+                v = ldl_le_p(buf + i);
+                break;
+            case 8:
+                v = ldq_le_p(buf + i);
+                break;
+            default:
+                v=0;
+            }
+            switch (format) {
+            case 'o':
+                monitor_printf(mon, "0%*" PRIo64, max_digits, v);
+                break;
+            case 'x':
+                monitor_printf(mon, "0x%0*" PRIx64, max_digits, v);
+                break;
+            case 'u':
+                monitor_printf(mon, "%*" PRIu64, max_digits, v);
+                break;
+            case 'd':
+                monitor_printf(mon, "%*" PRId64, max_digits, v);
+                break;
+            case 'c':
+                monitor_printc(mon, v);
+                break;
+            }
+        }
+
+        monitor_printf(mon, "\n");
+
+        offset += bytes;
+        count -= bytes / wsize;
+    }
+}
+
 static void memory_dump(Monitor *mon, int count, int format, int wsize,
                         uint64_t addr, bool is_physical)
 {
@@ -692,6 +779,23 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     }
 }
 
+void hmp_block_dump(Monitor *mon, const QDict *qdict)
+{
+    int count = qdict_get_int(qdict, "count");
+    int format = qdict_get_int(qdict, "format");
+    int size = qdict_get_int(qdict, "size");
+    vaddr addr = qdict_get_int(qdict, "addr");
+    const char* dblock = qdict_get_str(qdict, "device");
+
+    BlockBackend *blk = blk_by_name(dblock);
+
+    if (!blk) {
+        monitor_printf(mon, "Invalid block device name '%s'.\n\r", dblock);
+        return;
+    }
+    block_dump(mon,blk, count, format, size, addr);
+}
+
 void hmp_memory_dump(Monitor *mon, const QDict *qdict)
 {
     int count = qdict_get_int(qdict, "count");

---
base-commit: 443e02410695b35a27fad18217424b6370358be7
change-id: 20260726-xbcmd-7fa889067f15

Best regards,
-- 
Tripp R <tripprobins@gmail.com>


