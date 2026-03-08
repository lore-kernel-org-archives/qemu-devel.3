Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBA4F55126
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8SY-0003Xc-Jv; Sun, 08 Mar 2026 03:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8RJ-00026G-7M
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:38 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8R7-0002ge-AI
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:28 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2be1ab1fa7dso2553056eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954424; x=1773559224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHYY5BBIiUbYxlFw3Mg7gm0rTWiqz92vPX2RYiWNXFU=;
 b=F08gcrIZr5KqWeWdEQQaDERaIYi3kN8Hm6eBfO5kLB/LcdTFIu+vLBHkGGRuCqH3Zf
 5bQRrNkOQilgneAMLcSDQ7JL4E5OHqsLhVqq4fQFi0FTNgwbd12jDxrk2yu/Ch8PVFp2
 atHoKlISk5TrCgSz1MJ4wdRYaa97e5243/1BMKU3vqNJLXvfLaQ1AzgGeq4eN71MPSXS
 lOFJCkYoiOWDfR4FkjtjtTJSQfWaEQyiYEZm0h22eJL09Fr9mO2H5w+f7f6dBvpZsph6
 ZHR0GPJwxGbVABXhDOJ3sSd+6mtv3jRA0fEXwA76FbHIRZ6rlhr2D+DpgIsRPkDer3hd
 bL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954424; x=1773559224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GHYY5BBIiUbYxlFw3Mg7gm0rTWiqz92vPX2RYiWNXFU=;
 b=l80p/2V4aQ9dz5gEGk5CSjA4rweRPUC6al9uAxpFu7S6BOXpGagx9hMtiBoc7iIV8b
 Jdi6yyzZnc6H/e30GEbyRNwJOx7c3n5F9D2uzswRXAQtN20+hDwMDSx+1lg3eg9c8+Iv
 cKjGUpRlFx1XIgq+xSjW0EU177MNpgdFNo9OF/I3np25/7kz8n1/CQfffKx1PM8US5SQ
 PRstQsuoF7hdhxCCZN+ebu90bo94m/3nZVYguWGd2gbksZLHGS74BSEmssT61AbM8ynt
 FnsQ3vR2JsSYrI0+hDj1psqMiMWm03kaLsAUPE4gX0bNQv+qpABJmCEh916eOPYLtpyl
 X93Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3FAJgI9OkLdUresyP+V58u69FLHscSC9O6ZsBhcgb/jHv5MfOt8Dd9Cnbjj1nV0/O1FNVBaQQ/Gn9@nongnu.org
X-Gm-Message-State: AOJu0YxK8yzJXHFonq+LsvjlxM8AZPIW4fxZ3vKFf5BIINwFWh2EqAIN
 B22++8P1I68d0ZJ93m13/Q2dYPKNWmykXGj7gtC3Lhlt+QkX4pzN+84b
X-Gm-Gg: ATEYQzxmltrhoVxLB5RSmVfLY/tuVDJoFPhMLERENBznnTNFoohbV9LoWiqTmqttX5U
 dfN1LPuoE6BHmivHW9QBkGIFMSfM8qd+EzQZ8WTg4UMwx9g9Tjy30bDTTc1Lh9ME+utLqe9Q0BC
 K/HckHAueubIdD5oNVyyaBL4LGFI04HfKQuCjRvn8yo4QgYYE0RzMN/td1oZWhwCqcjo8iIkYrx
 8ed8o2kdhQ2CiEZRNYXxs+400GbQvXQ1N9Yo7HOJ6Z5IKQJzgZrxO73V9kI+hmrmBxqoQPukZYR
 C7AycKzxEqLuUtjBclJY3XjRO/xcM5S6/PQVKXEc+n2Nh1Reb/k3ySFlLxLhigMcsTtwDpLqZ3o
 faNdrHoOeziX0xyig0o1SUTxILDL1ZzxWPqTJfVlwxcvHN1Z9eK6PVxzqsH9Cs9V445lcFbHcfd
 sYIa8SaDd1Xu9Q3Ko5imG3LKjCCFLKJ+rBiG7YjZSErEfFtxFf+ETAgixU2BqzAOlMJ/N628UUy
 /OJM8Rtx9GVMRGVnk/5UL0AHM6sqCxT+Hcc3Q==
X-Received: by 2002:a05:7301:fa0a:b0:2b8:30b8:58cf with SMTP id
 5a478bee46e88-2be4de76edcmr3216133eec.8.1772954423774; 
 Sat, 07 Mar 2026 23:20:23 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:20:22 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 19/28] hw/riscv/dm: add DMI register declarations and ROM
 entry program
Date: Sun,  8 Mar 2026 15:17:22 +0800
Message-ID: <bf02e096105896ca32e11de77ecf99705ff37ab7.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add the complete set of DMI register field declarations per the
Debug Specification v1.0 (DATA0-11, COMMAND, ABSTRACTAUTO,
PROGBUF0-15, SBCS, SBADDRESS/DATA, etc.) and the instruction
builder macros used to generate abstract command sequences.

Lay down the ROM entry program (park loop, resume, exception
vectors) and the ROM state management helpers (flush, sync,
reset).  Update dm_debug_reset() to use the new infrastructure.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/dm.c | 423 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 373 insertions(+), 50 deletions(-)

diff --git a/hw/riscv/dm.c b/hw/riscv/dm.c
index 760cae27e2..427507e77e 100644
--- a/hw/riscv/dm.c
+++ b/hw/riscv/dm.c
@@ -4,61 +4,85 @@
  * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
  *
  * Based on the RISC-V Debug Specification v1.0 (ratified 2025-02-21)
+ * Uses the QEMU register.h framework for declarative register definitions.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
-#include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/core/irq.h"
 #include "hw/riscv/dm.h"
 #include "exec/cpu-common.h"
 #include "migration/vmstate.h"
+#include "exec/translation-block.h"
 #include "system/tcg.h"
 #include "target/riscv/cpu.h"
 #include "trace.h"
 
+/* Addresses = DMI word address × 4 (byte offsets). */
+
+REG32(DATA0,  0x10)
+REG32(DATA1,  0x14)
+REG32(DATA2,  0x18)
+REG32(DATA3,  0x1C)
+REG32(DATA4,  0x20)
+REG32(DATA5,  0x24)
+REG32(DATA6,  0x28)
+REG32(DATA7,  0x2C)
+REG32(DATA8,  0x30)
+REG32(DATA9,  0x34)
+REG32(DATA10, 0x38)
+REG32(DATA11, 0x3C)
+
 REG32(DMCONTROL, 0x40)
-    FIELD(DMCONTROL, DMACTIVE, 0, 1)
-    FIELD(DMCONTROL, NDMRESET, 1, 1)
-    FIELD(DMCONTROL, CLRRESETHALTREQ, 2, 1)
-    FIELD(DMCONTROL, SETRESETHALTREQ, 3, 1)
-    FIELD(DMCONTROL, HARTSELLO, 6, 10)
-    FIELD(DMCONTROL, HARTSELHI, 16, 10)
-    FIELD(DMCONTROL, HASEL, 26, 1)
-    FIELD(DMCONTROL, ACKHAVERESET, 28, 1)
-    FIELD(DMCONTROL, HARTRESET, 29, 1)
-    FIELD(DMCONTROL, RESUMEREQ, 30, 1)
-    FIELD(DMCONTROL, HALTREQ, 31, 1)
+    FIELD(DMCONTROL, DMACTIVE,        0,  1)
+    FIELD(DMCONTROL, NDMRESET,        1,  1)
+    FIELD(DMCONTROL, CLRRESETHALTREQ, 2,  1)
+    FIELD(DMCONTROL, SETRESETHALTREQ, 3,  1)
+    FIELD(DMCONTROL, CLRKEEPALIVE,    4,  1)
+    FIELD(DMCONTROL, SETKEEPALIVE,    5,  1)
+    FIELD(DMCONTROL, HARTSELLO,       6, 10)
+    FIELD(DMCONTROL, HARTSELHI,      16, 10)
+    FIELD(DMCONTROL, HASEL,          26,  1)
+    FIELD(DMCONTROL, ACKUNAVAIL,     27,  1)
+    FIELD(DMCONTROL, ACKHAVERESET,   28,  1)
+    FIELD(DMCONTROL, HARTRESET,      29,  1)
+    FIELD(DMCONTROL, RESUMEREQ,      30,  1)
+    FIELD(DMCONTROL, HALTREQ,        31,  1)
 
 REG32(DMSTATUS, 0x44)
-    FIELD(DMSTATUS, VERSION, 0, 4)
-    FIELD(DMSTATUS, HASRESETHALTREQ, 5, 1)
-    FIELD(DMSTATUS, AUTHENTICATED, 7, 1)
-    FIELD(DMSTATUS, ANYHALTED, 8, 1)
-    FIELD(DMSTATUS, ALLHALTED, 9, 1)
-    FIELD(DMSTATUS, ANYRUNNING, 10, 1)
-    FIELD(DMSTATUS, ALLRUNNING, 11, 1)
-    FIELD(DMSTATUS, ANYUNAVAIL, 12, 1)
-    FIELD(DMSTATUS, ALLUNAVAIL, 13, 1)
-    FIELD(DMSTATUS, ANYNONEXISTENT, 14, 1)
-    FIELD(DMSTATUS, ALLNONEXISTENT, 15, 1)
-    FIELD(DMSTATUS, ANYRESUMEACK, 16, 1)
-    FIELD(DMSTATUS, ALLRESUMEACK, 17, 1)
-    FIELD(DMSTATUS, ANYHAVERESET, 18, 1)
-    FIELD(DMSTATUS, ALLHAVERESET, 19, 1)
-    FIELD(DMSTATUS, IMPEBREAK, 22, 1)
+    FIELD(DMSTATUS, VERSION,          0, 4)
+    FIELD(DMSTATUS, CONFSTRPTRVALID,  4, 1)
+    FIELD(DMSTATUS, HASRESETHALTREQ,  5, 1)
+    FIELD(DMSTATUS, AUTHBUSY,         6, 1)
+    FIELD(DMSTATUS, AUTHENTICATED,    7, 1)
+    FIELD(DMSTATUS, ANYHALTED,        8, 1)
+    FIELD(DMSTATUS, ALLHALTED,        9, 1)
+    FIELD(DMSTATUS, ANYRUNNING,      10, 1)
+    FIELD(DMSTATUS, ALLRUNNING,      11, 1)
+    FIELD(DMSTATUS, ANYUNAVAIL,      12, 1)
+    FIELD(DMSTATUS, ALLUNAVAIL,      13, 1)
+    FIELD(DMSTATUS, ANYNONEXISTENT,  14, 1)
+    FIELD(DMSTATUS, ALLNONEXISTENT,  15, 1)
+    FIELD(DMSTATUS, ANYRESUMEACK,    16, 1)
+    FIELD(DMSTATUS, ALLRESUMEACK,    17, 1)
+    FIELD(DMSTATUS, ANYHAVERESET,    18, 1)
+    FIELD(DMSTATUS, ALLHAVERESET,    19, 1)
+    FIELD(DMSTATUS, IMPEBREAK,       22, 1)
+    FIELD(DMSTATUS, STICKYUNAVAIL,   23, 1)
     FIELD(DMSTATUS, NDMRESETPENDING, 24, 1)
 
 REG32(HARTINFO, 0x48)
-    FIELD(HARTINFO, DATAADDR, 0, 12)
-    FIELD(HARTINFO, DATASIZE, 12, 4)
-    FIELD(HARTINFO, DATAACCESS, 16, 1)
-    FIELD(HARTINFO, NSCRATCH, 20, 4)
+    FIELD(HARTINFO, DATAADDR,    0, 12)
+    FIELD(HARTINFO, DATASIZE,   12,  4)
+    FIELD(HARTINFO, DATAACCESS, 16,  1)
+    FIELD(HARTINFO, NSCRATCH,   20,  4)
 
-REG32(HALTSUM1, 0x4c)
+REG32(HALTSUM1, 0x4C)
 
 REG32(HAWINDOWSEL, 0x50)
     FIELD(HAWINDOWSEL, HAWINDOWSEL, 0, 15)
@@ -66,13 +90,144 @@ REG32(HAWINDOWSEL, 0x50)
 REG32(HAWINDOW, 0x54)
 
 REG32(ABSTRACTCS, 0x58)
-    FIELD(ABSTRACTCS, DATACOUNT, 0, 4)
-    FIELD(ABSTRACTCS, CMDERR, 8, 3)
-    FIELD(ABSTRACTCS, BUSY, 12, 1)
+    FIELD(ABSTRACTCS, DATACOUNT,   0,  4)
+    FIELD(ABSTRACTCS, CMDERR,      8,  3)
+    FIELD(ABSTRACTCS, BUSY,       12,  1)
     FIELD(ABSTRACTCS, PROGBUFSIZE, 24, 5)
 
+REG32(COMMAND, 0x5C)
+    FIELD(COMMAND, REGNO,            0, 16)
+    FIELD(COMMAND, WRITE,           16,  1)
+    FIELD(COMMAND, TRANSFER,        17,  1)
+    FIELD(COMMAND, POSTEXEC,        18,  1)
+    FIELD(COMMAND, AARPOSTINCREMENT, 19, 1)
+    FIELD(COMMAND, AARSIZE,         20,  3)
+    FIELD(COMMAND, CMDTYPE,         24,  8)
+
+REG32(ABSTRACTAUTO, 0x60)
+    FIELD(ABSTRACTAUTO, AUTOEXECDATA,    0, 12)
+    FIELD(ABSTRACTAUTO, AUTOEXECPROGBUF, 16, 16)
+
+REG32(CONFSTRPTR0, 0x64)
+REG32(CONFSTRPTR1, 0x68)
+REG32(CONFSTRPTR2, 0x6C)
+REG32(CONFSTRPTR3, 0x70)
+
+REG32(NEXTDM, 0x74)
+
+REG32(PROGBUF0,  0x80)
+REG32(PROGBUF1,  0x84)
+REG32(PROGBUF2,  0x88)
+REG32(PROGBUF3,  0x8C)
+REG32(PROGBUF4,  0x90)
+REG32(PROGBUF5,  0x94)
+REG32(PROGBUF6,  0x98)
+REG32(PROGBUF7,  0x9C)
+REG32(PROGBUF8,  0xA0)
+REG32(PROGBUF9,  0xA4)
+REG32(PROGBUF10, 0xA8)
+REG32(PROGBUF11, 0xAC)
+REG32(PROGBUF12, 0xB0)
+REG32(PROGBUF13, 0xB4)
+REG32(PROGBUF14, 0xB8)
+REG32(PROGBUF15, 0xBC)
+
+REG32(AUTHDATA, 0xC0)
+
+REG32(DMCS2, 0xC8)
+    FIELD(DMCS2, HGSELECT,    0, 1)
+    FIELD(DMCS2, HGWRITE,     1, 1)
+    FIELD(DMCS2, GROUP,        2, 5)
+    FIELD(DMCS2, DMEXTTRIGGER, 7, 4)
+    FIELD(DMCS2, GROUPTYPE,   11, 1)
+
+REG32(HALTSUM2, 0xD0)
+REG32(HALTSUM3, 0xD4)
+
+REG32(SBADDRESS3, 0xDC)
+
+REG32(SBCS, 0xE0)
+    FIELD(SBCS, SBACCESS8,     0, 1)
+    FIELD(SBCS, SBACCESS16,    1, 1)
+    FIELD(SBCS, SBACCESS32,    2, 1)
+    FIELD(SBCS, SBACCESS64,    3, 1)
+    FIELD(SBCS, SBACCESS128,   4, 1)
+    FIELD(SBCS, SBASIZE,       5, 7)
+    FIELD(SBCS, SBERROR,      12, 3)
+    FIELD(SBCS, SBREADONDATA, 15, 1)
+    FIELD(SBCS, SBAUTOINCREMENT, 16, 1)
+    FIELD(SBCS, SBACCESS,     17, 3)
+    FIELD(SBCS, SBREADONADDR, 20, 1)
+    FIELD(SBCS, SBBUSY,       21, 1)
+    FIELD(SBCS, SBBUSYERROR,  22, 1)
+    FIELD(SBCS, SBVERSION,    29, 3)
+
+REG32(SBADDRESS0, 0xE4)
+REG32(SBADDRESS1, 0xE8)
+REG32(SBADDRESS2, 0xEC)
+
+REG32(SBDATA0, 0xF0)
+REG32(SBDATA1, 0xF4)
+REG32(SBDATA2, 0xF8)
+REG32(SBDATA3, 0xFC)
+
 REG32(HALTSUM0, 0x100)
 
+
+/* Minimal instruction builders used by abstract commands and ROM mailboxes. */
+#define DM_I(opcode, funct3, rd, rs1, imm) \
+    (((((uint32_t)(imm)) & 0xfffu) << 20) | \
+     (((uint32_t)(rs1)) << 15) | (((uint32_t)(funct3)) << 12) | \
+     (((uint32_t)(rd)) << 7) | ((uint32_t)(opcode)))
+
+#define DM_S(opcode, funct3, rs1, rs2, imm) \
+    (((((((uint32_t)(imm)) >> 5) & 0x7fu) << 25) | \
+      (((uint32_t)(rs2)) << 20) | (((uint32_t)(rs1)) << 15) | \
+      (((uint32_t)(funct3)) << 12) | ((((uint32_t)(imm)) & 0x1fu) << 7) | \
+      ((uint32_t)(opcode))))
+
+#define DM_LOAD(rd, rs1, offset, size) \
+    DM_I(0x03u, size, rd, rs1, offset)
+
+#define DM_STORE(rs2, rs1, offset, size) \
+    DM_S(0x23u, size, rs1, rs2, offset)
+
+#define DM_FP_LOAD(rd, rs1, offset, size) \
+    DM_I(0x07u, size, rd, rs1, offset)
+
+#define DM_FP_STORE(rs2, rs1, offset, size) \
+    DM_S(0x27u, size, rs1, rs2, offset)
+
+#define DM_LBU(rd, rs1, offset) \
+    DM_LOAD(rd, rs1, offset, 4u)
+
+#define DM_DATA_LOAD(rd, size) \
+    DM_LOAD(rd, 0u, RISCV_DM_ROM_DATA, size)
+
+#define DM_DATA_STORE(rs2, size) \
+    DM_STORE(rs2, 0u, RISCV_DM_ROM_DATA, size)
+
+#define DM_DATA_FP_LOAD(rd, size) \
+    DM_FP_LOAD(rd, 0u, RISCV_DM_ROM_DATA, size)
+
+#define DM_DATA_FP_STORE(rs2, size) \
+    DM_FP_STORE(rs2, 0u, RISCV_DM_ROM_DATA, size)
+
+/* csrr rd=s0, csr=regno */
+#define DM_CSRR(regno) \
+    (0x2473u | ((uint32_t)(regno) << 20))
+
+/* csrw csr=regno, rs1=s0 */
+#define DM_CSRW(regno) \
+    (0x41073u | ((uint32_t)(regno) << 20))
+
+/* jal x0, imm (imm is in units of 2 bytes, encoded in J-format) */
+#define DM_JAL(imm) \
+    (0x6fu | ((uint32_t)(imm) << 21))
+
+#define DM_NOP    0x13u
+#define DM_EBREAK 0x100073u
+
 typedef struct DMHartSelection {
     int all[RISCV_DM_HAWINDOW_SIZE + 1];
     int all_count;
@@ -109,6 +264,103 @@ static inline void dm_rom_write8(RISCVDMState *s, uint32_t offset, uint8_t val)
     s->rom_ptr[offset] = val;
 }
 
+static inline uint8_t dm_rom_read8(RISCVDMState *s, uint32_t offset)
+{
+    return s->rom_ptr[offset];
+}
+
+static void dm_sync_data_to_rom(RISCVDMState *s, int data_index)
+{
+    uint32_t val = s->regs[R_DATA0 + data_index];
+    dm_rom_write32(s, RISCV_DM_ROM_DATA + data_index * 4, val);
+}
+
+static void dm_sync_progbuf_to_rom(RISCVDMState *s, int progbuf_index)
+{
+    uint32_t val = s->regs[R_PROGBUF0 + progbuf_index];
+    dm_rom_write32(s, RISCV_DM_ROM_PROGBUF + progbuf_index * 4, val);
+}
+
+static void dm_flush_cmd_space(RISCVDMState *s)
+{
+    for (int i = 0; i < 8; i++) {
+        dm_rom_write32(s, RISCV_DM_ROM_CMD + i * 4, DM_NOP);
+    }
+    /* Restore s0 from dscratch0 */
+    dm_rom_write32(s, RISCV_DM_ROM_CMD + 8 * 4, DM_CSRR(0x7b2));
+    /* ebreak */
+    dm_rom_write32(s, RISCV_DM_ROM_CMD + 9 * 4, DM_EBREAK);
+    /* Default whereto: jump to CMD space from the ROM dispatcher. */
+    dm_rom_write32(s, RISCV_DM_ROM_WHERETO, DM_JAL(0x1C));
+}
+
+static void dm_invalidate_dynamic_code(RISCVDMState *s)
+{
+    if (tcg_enabled()) {
+        ram_addr_t base = memory_region_get_ram_addr(&s->rom_mr);
+
+        tb_invalidate_phys_range(NULL, base + RISCV_DM_ROM_WHERETO,
+                                 base + RISCV_DM_ROM_DATA - 1);
+    }
+}
+
+static void dm_update_impebreak(RISCVDMState *s)
+{
+    hwaddr ebreak_addr = RISCV_DM_ROM_PROGBUF + s->progbuf_size * 4;
+
+    if (ebreak_addr + 4 > RISCV_DM_ROM_DATA) {
+        return;
+    }
+
+    dm_rom_write32(s, ebreak_addr, s->impebreak ? DM_EBREAK : DM_NOP);
+}
+
+static void dm_reset_rom_state(RISCVDMState *s)
+{
+    if (!s->rom_ptr) {
+        return;
+    }
+
+    memset(s->rom_ptr + RISCV_DM_ROM_WORK_BASE, 0, RISCV_DM_ROM_WORK_SIZE);
+
+    dm_flush_cmd_space(s);
+
+    for (uint32_t i = 0; i < s->num_abstract_data; i++) {
+        dm_sync_data_to_rom(s, i);
+    }
+    for (uint32_t i = 0; i < s->progbuf_size; i++) {
+        dm_sync_progbuf_to_rom(s, i);
+    }
+
+    dm_update_impebreak(s);
+    dm_invalidate_dynamic_code(s);
+}
+
+static inline void dm_set_cmderr(RISCVDMState *s, uint32_t err)
+{
+    uint32_t cur = ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR);
+    if (cur == RISCV_DM_CMDERR_NONE) {
+        ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, CMDERR, err);
+    }
+}
+
+static bool dm_abstract_cmd_completed(RISCVDMState *s, uint32_t hartsel)
+{
+    uint32_t selected = dm_get_hartsel(s);
+    uint8_t flags;
+
+    if (!ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, BUSY) || selected != hartsel) {
+        return false;
+    }
+
+    /*
+     * The hart only completes an execution-based abstract command after it has
+     * consumed GO and returned to the park loop.
+     */
+    flags = dm_rom_read8(s, RISCV_DM_ROM_FLAGS + hartsel);
+    return !(flags & RISCV_DM_FLAG_GOING);
+}
+
 static void dm_selection_add(RISCVDMState *s, DMHartSelection *sel, int hartsel)
 {
     for (int i = 0; i < sel->all_count; i++) {
@@ -637,6 +889,65 @@ static const MemoryRegionOps dm_rom_ops = {
 
 static bool dm_rom_realize(RISCVDMState *s, Error **errp)
 {
+    /*
+     * ROM program at 0x800:
+     * - entry: jump to _entry
+     * - resume: jump to _resume
+     * - exception: jump to _exception
+     * - _entry: fence, save s0, poll FLAGS loop
+     * - _exception: write EXCP, restore s0, ebreak
+     * - going: write GOING, restore s0, jump to whereto
+     * - _resume: write RESUME hartid, restore s0, dret
+     */
+    static const uint32_t rom_code_entry[] = {
+        /* 0x800 <entry>: */
+        0x0180006f,                               /* j   818 <_entry>      */
+        0x00000013,                               /* nop                   */
+
+        /* 0x808 <resume>: */
+        0x0600006f,                               /* j   868 <_resume>     */
+        0x00000013,                               /* nop                   */
+
+        /* 0x810 <exception>: */
+        0x0400006f,                               /* j   850 <_exception>  */
+        0x00000013,                               /* nop                   */
+
+        /* 0x818 <_entry>: */
+        0x0ff0000f,                               /* fence                 */
+        0x7b241073,                               /* csrw dscratch0, s0    */
+
+        /* 0x820 <entry_loop>: */
+        0xf1402473,                               /* csrr s0, mhartid      */
+        0x07f47413,                               /* andi s0, s0, 127      */
+        DM_STORE(8, 0u, RISCV_DM_ROM_HARTID, 2u), /* sw s0, HARTID(zero)   */
+        DM_LBU(8, 8, RISCV_DM_ROM_FLAGS),         /* lbu s0, FLAGS(s0)     */
+        0x00147413,                               /* andi s0, s0, 1        */
+        0x02041463,                               /* bnez s0, 85c <going>  */
+        0xf1402473,                               /* csrr s0, mhartid      */
+        0x07f47413,                               /* andi s0, s0, 127      */
+        DM_LBU(8, 8, RISCV_DM_ROM_FLAGS),         /* lbu s0, FLAGS(s0)     */
+        0x00247413,                               /* andi s0, s0, 2        */
+        0xfc0410e3,                               /* bnez s0, 808 <resume> */
+        0xfd5ff06f,                               /* j    820 <entry_loop> */
+
+        /* 0x850 <_exception>: */
+        DM_STORE(0, 0u, RISCV_DM_ROM_EXCP, 2u),   /* sw zero, EXCP(zero)   */
+        0x7b202473,                               /* csrr s0, dscratch0    */
+        0x00100073,                               /* ebreak                */
+
+        /* 0x85c <going>: */
+        DM_STORE(0, 0u, RISCV_DM_ROM_GOING, 2u),  /* sw zero, GOING(zero)  */
+        0x7b202473,                               /* csrr s0, dscratch0    */
+        0xa9dff06f,                               /* j    300 <whereto>    */
+
+        /* 0x868 <_resume>: */
+        0xf1402473,                               /* csrr s0, mhartid      */
+        0x07f47413,                               /* andi s0, s0, 127      */
+        DM_STORE(8, 0u, RISCV_DM_ROM_RESUME, 2u), /* sw s0, RESUME(zero)   */
+        0x7b202473,                               /* csrr s0, dscratch0    */
+        0x7b200073,                               /* dret                  */
+    };
+
     SysBusDevice *sbd = SYS_BUS_DEVICE(s);
 
     if (!memory_region_init_rom_device(&s->rom_mr, OBJECT(s), &dm_rom_ops, s,
@@ -644,9 +955,11 @@ static bool dm_rom_realize(RISCVDMState *s, Error **errp)
                                        errp)) {
         return false;
     }
-
     s->rom_ptr = memory_region_get_ram_ptr(&s->rom_mr);
 
+    memcpy(s->rom_ptr + RISCV_DM_ROM_ENTRY, rom_code_entry,
+           sizeof(rom_code_entry));
+
     memory_region_init_alias(&s->rom_work_alias_mr, OBJECT(s),
                              "riscv-dm.rom-work", &s->rom_mr,
                              RISCV_DM_ROM_WORK_BASE, RISCV_DM_ROM_WORK_SIZE);
@@ -656,6 +969,7 @@ static bool dm_rom_realize(RISCVDMState *s, Error **errp)
 
     sysbus_init_mmio(sbd, &s->rom_work_alias_mr);
     sysbus_init_mmio(sbd, &s->rom_entry_alias_mr);
+
     return true;
 }
 
@@ -666,7 +980,11 @@ void riscv_dm_hart_halted(RISCVDMState *s, uint32_t hartsel)
     }
 
     s->hart_halted[hartsel] = true;
-    riscv_dm_abstracts_done(s, hartsel);
+
+    if (dm_abstract_cmd_completed(s, hartsel)) {
+        riscv_dm_abstracts_done(s, hartsel);
+    }
+
     dm_status_refresh(s);
     trace_riscv_dm_hart_halted(hartsel);
 }
@@ -692,22 +1010,29 @@ void riscv_dm_abstracts_done(RISCVDMState *s, uint32_t hartsel)
 
 void riscv_dm_abstracts_exception(RISCVDMState *s, uint32_t hartsel)
 {
-    ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, BUSY, 0);
-    ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, CMDERR,
-                     RISCV_DM_CMDERR_EXCEPTION);
+    dm_set_cmderr(s, RISCV_DM_CMDERR_EXCEPTION);
     trace_riscv_dm_abstract_cmd_exception(hartsel);
 }
 
 static void dm_debug_reset(RISCVDMState *s)
 {
-    memset(s->regs, 0, sizeof(s->regs));
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, VERSION, 3);
+    s->dm_active = false;
+
+    /* Reset all registers via framework */
+    for (unsigned int i = 0; i < ARRAY_SIZE(s->regs_info); i++) {
+        register_reset(&s->regs_info[i]);
+    }
+
+    /* Set config-dependent reset values */
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, VERSION, 3);       /* v1.0 */
     ARRAY_FIELD_DP32(s->regs, DMSTATUS, AUTHENTICATED, 1);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, IMPEBREAK, s->impebreak);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, IMPEBREAK, s->impebreak ? 1 : 0);
+
     ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, DATACOUNT, s->num_abstract_data);
     ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, PROGBUFSIZE, s->progbuf_size);
 
-    if (s->hart_halted) {
+    /* Reset per-hart state */
+    if (s->hart_resumeack && s->num_harts > 0) {
         for (uint32_t i = 0; i < s->num_harts; i++) {
             s->hart_halted[i] = false;
             s->hart_resumeack[i] = false;
@@ -717,12 +1042,9 @@ static void dm_debug_reset(RISCVDMState *s)
     }
 
     memset(s->hawindow, 0, sizeof(s->hawindow));
-    s->dm_active = false;
-
-    if (s->rom_ptr) {
-        memset(s->rom_ptr, 0, RISCV_DM_SIZE);
-    }
+    s->last_cmd = 0;
 
+    dm_reset_rom_state(s);
     dm_status_refresh(s);
 }
 
@@ -803,6 +1125,7 @@ static const VMStateDescription vmstate_riscv_dm = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, RISCVDMState, RISCV_DM_R_MAX),
         VMSTATE_BOOL(dm_active, RISCVDMState),
+        VMSTATE_UINT32(last_cmd, RISCVDMState),
         VMSTATE_VARRAY_UINT32(hart_halted, RISCVDMState, num_harts,
                               0, vmstate_info_bool, bool),
         VMSTATE_VARRAY_UINT32(hart_resumeack, RISCVDMState, num_harts,
-- 
2.53.0


