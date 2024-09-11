Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A0BEE4998
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMG9-0007PT-6l; Wed, 11 Sep 2024 08:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMFz-0006mV-VN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:41 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMFt-0007P3-0x
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:34 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53658f30749so6197936e87.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056927; x=1726661727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gypE18RCTnMpzEOhJVWlEbJee3c2WTq09e/PtDSyIt4=;
 b=QmuUfYuyI0HGkyZTZw6jzzslHNe/1lGQvB8cSUo2LjTpuujRRT3ipSMg0hKqF5ejFl
 +kqIrpuSeXrNpNMkVnGGDeTNdxUnr24H33rqjoikFSjNWFxzHkZcNzPlidW1OcGOefG2
 vIUrygw09iicxearELFWNX0y6lc+uvaZtV1PJeR0D9iqvx/ehyFtc03owdJznS3JUvuM
 XD39VLiQpcHsnZIemcvkzNo6VhF9HUJGHlMdSiC9sjvzAtfROe11A+JV/oNlZRELfJQY
 KleEzX87L6rYuwJNmvfaG9koKzJ2UHFd59q7TGkC7ql4atmUzS2WYaYjDH3xskEWzsDb
 3FmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056927; x=1726661727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gypE18RCTnMpzEOhJVWlEbJee3c2WTq09e/PtDSyIt4=;
 b=lsSYvFTETo1kxEevU/9cU8S4GY5vqZ+ZMmNIW5aM+rPPXXhDdrPN23GFwV/wRpZmv4
 PVJNwUBowY4s7jc15sxuXEJM8A30Bgmop36DeBwRAlGvItUD4/QGTjbf2H8WPlkeN5Sv
 4P1mY1v+MyKOIGoMQWfbYaVEl97A6RUfT2XYeHdRYLfNTtlmKRPjF2LK9LPS/+8LooOW
 inw7bXOoRK4h39Vt5T0+mZPl4Twh/VA280nWjh2lz6hUnebtFYrh9wfBfZOUXYHb0X8L
 JIib64NROe6hDZYQ7d25caES46jqjRg3ua/uzmohL24NhGWGjFPWhnt+DYLTsHU3e3im
 7irw==
X-Gm-Message-State: AOJu0YxHVKfkrjFjBDPg0NbiDgxkXfOu+NfGhQRf5vBuMBSRWoJc4NYh
 pRYEV+GcCNEA38sqSaweCWdOiMILgscbACGKju9dkd+FI8MPapk49I3FYy2lXs+UBPOC36VUVBN
 L
X-Google-Smtp-Source: AGHT+IEbfPTSyj16aS5SxwC2XtQt4I7kce8HmGuyJMfd7TtYo75Uu1kqa4UHfgAbi3Co7Nkpxj+B6w==
X-Received: by 2002:a05:6512:b03:b0:536:55cc:9642 with SMTP id
 2adb3069b0e04-536587b44d3mr12384392e87.26.1726056924207; 
 Wed, 11 Sep 2024 05:15:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c61210sm605613466b.113.2024.09.11.05.15.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:15:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 08/56] tests/tcg: Remove CRIS bare test files
Date: Wed, 11 Sep 2024 14:13:33 +0200
Message-ID: <20240911121422.52585-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

We are going to remove the CRIS target.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20240904143603.52934-3-philmd@linaro.org>
---
 MAINTAINERS                           |   1 -
 tests/tcg/cris/bare/sys.c             |  63 -------
 scripts/probe-gdb-support.py          |   1 -
 tests/tcg/cris/.gdbinit               |  11 --
 tests/tcg/cris/Makefile.target        |  62 -------
 tests/tcg/cris/README                 |   1 -
 tests/tcg/cris/bare/check_addcv17.s   |  65 -------
 tests/tcg/cris/bare/check_addi.s      |  57 ------
 tests/tcg/cris/bare/check_addiv32.s   |  62 -------
 tests/tcg/cris/bare/check_addm.s      |  96 ----------
 tests/tcg/cris/bare/check_addq.s      |  47 -----
 tests/tcg/cris/bare/check_addr.s      |  96 ----------
 tests/tcg/cris/bare/check_addxc.s     |  91 ---------
 tests/tcg/cris/bare/check_addxm.s     | 106 -----------
 tests/tcg/cris/bare/check_addxr.s     |  96 ----------
 tests/tcg/cris/bare/check_andc.s      |  80 --------
 tests/tcg/cris/bare/check_andm.s      |  90 ---------
 tests/tcg/cris/bare/check_andq.s      |  46 -----
 tests/tcg/cris/bare/check_andr.s      |  95 ----------
 tests/tcg/cris/bare/check_asr.s       | 230 -----------------------
 tests/tcg/cris/bare/check_ba.s        |  93 ----------
 tests/tcg/cris/bare/check_bas.s       | 102 ----------
 tests/tcg/cris/bare/check_bcc.s       | 197 --------------------
 tests/tcg/cris/bare/check_boundc.s    | 101 ----------
 tests/tcg/cris/bare/check_boundr.s    | 125 -------------
 tests/tcg/cris/bare/check_btst.s      |  96 ----------
 tests/tcg/cris/bare/check_clearfv32.s |  19 --
 tests/tcg/cris/bare/check_clrjmp1.s   |  36 ----
 tests/tcg/cris/bare/check_cmp-2.s     |  15 --
 tests/tcg/cris/bare/check_cmpc.s      |  86 ---------
 tests/tcg/cris/bare/check_cmpm.s      |  96 ----------
 tests/tcg/cris/bare/check_cmpq.s      |  75 --------
 tests/tcg/cris/bare/check_cmpr.s      | 102 ----------
 tests/tcg/cris/bare/check_cmpxc.s     |  92 ---------
 tests/tcg/cris/bare/check_cmpxm.s     | 106 -----------
 tests/tcg/cris/bare/check_dstep.s     |  42 -----
 tests/tcg/cris/bare/check_jsr.s       |  85 ---------
 tests/tcg/cris/bare/check_lapc.s      |  78 --------
 tests/tcg/cris/bare/check_lsl.s       | 217 ----------------------
 tests/tcg/cris/bare/check_lsr.s       | 218 ----------------------
 tests/tcg/cris/bare/check_mcp.s       |  49 -----
 tests/tcg/cris/bare/check_movdelsr1.s |  33 ----
 tests/tcg/cris/bare/check_movecr.s    |  37 ----
 tests/tcg/cris/bare/check_movei.s     |  50 -----
 tests/tcg/cris/bare/check_movemr.s    |  78 --------
 tests/tcg/cris/bare/check_movemrv32.s |  96 ----------
 tests/tcg/cris/bare/check_mover.s     |  28 ---
 tests/tcg/cris/bare/check_moverm.s    |  45 -----
 tests/tcg/cris/bare/check_movmp.s     | 131 -------------
 tests/tcg/cris/bare/check_movpmv32.s  |  35 ----
 tests/tcg/cris/bare/check_movpr.s     |  28 ---
 tests/tcg/cris/bare/check_movprv32.s  |  21 ---
 tests/tcg/cris/bare/check_movscr.s    |  29 ---
 tests/tcg/cris/bare/check_movsm.s     |  44 -----
 tests/tcg/cris/bare/check_movsr.s     |  46 -----
 tests/tcg/cris/bare/check_movucr.s    |  33 ----
 tests/tcg/cris/bare/check_movum.s     |  40 ----
 tests/tcg/cris/bare/check_movur.s     |  45 -----
 tests/tcg/cris/bare/check_mulv32.s    |  51 -----
 tests/tcg/cris/bare/check_mulx.s      | 257 --------------------------
 tests/tcg/cris/bare/check_neg.s       | 104 -----------
 tests/tcg/cris/bare/check_not.s       |  31 ----
 tests/tcg/cris/bare/check_orc.s       |  71 -------
 tests/tcg/cris/bare/check_orm.s       |  75 --------
 tests/tcg/cris/bare/check_orq.s       |  41 ----
 tests/tcg/cris/bare/check_orr.s       |  84 ---------
 tests/tcg/cris/bare/check_ret.s       |  25 ---
 tests/tcg/cris/bare/check_scc.s       |  95 ----------
 tests/tcg/cris/bare/check_subc.s      |  87 ---------
 tests/tcg/cris/bare/check_subm.s      |  96 ----------
 tests/tcg/cris/bare/check_subq.s      |  52 ------
 tests/tcg/cris/bare/check_subr.s      | 102 ----------
 tests/tcg/cris/bare/check_xarith.s    |  72 --------
 tests/tcg/cris/bare/crt.s             |  13 --
 tests/tcg/cris/bare/testutils.inc     | 117 ------------
 75 files changed, 5618 deletions(-)
 delete mode 100644 tests/tcg/cris/bare/sys.c
 delete mode 100644 tests/tcg/cris/.gdbinit
 delete mode 100644 tests/tcg/cris/Makefile.target
 delete mode 100644 tests/tcg/cris/README
 delete mode 100644 tests/tcg/cris/bare/check_addcv17.s
 delete mode 100644 tests/tcg/cris/bare/check_addi.s
 delete mode 100644 tests/tcg/cris/bare/check_addiv32.s
 delete mode 100644 tests/tcg/cris/bare/check_addm.s
 delete mode 100644 tests/tcg/cris/bare/check_addq.s
 delete mode 100644 tests/tcg/cris/bare/check_addr.s
 delete mode 100644 tests/tcg/cris/bare/check_addxc.s
 delete mode 100644 tests/tcg/cris/bare/check_addxm.s
 delete mode 100644 tests/tcg/cris/bare/check_addxr.s
 delete mode 100644 tests/tcg/cris/bare/check_andc.s
 delete mode 100644 tests/tcg/cris/bare/check_andm.s
 delete mode 100644 tests/tcg/cris/bare/check_andq.s
 delete mode 100644 tests/tcg/cris/bare/check_andr.s
 delete mode 100644 tests/tcg/cris/bare/check_asr.s
 delete mode 100644 tests/tcg/cris/bare/check_ba.s
 delete mode 100644 tests/tcg/cris/bare/check_bas.s
 delete mode 100644 tests/tcg/cris/bare/check_bcc.s
 delete mode 100644 tests/tcg/cris/bare/check_boundc.s
 delete mode 100644 tests/tcg/cris/bare/check_boundr.s
 delete mode 100644 tests/tcg/cris/bare/check_btst.s
 delete mode 100644 tests/tcg/cris/bare/check_clearfv32.s
 delete mode 100644 tests/tcg/cris/bare/check_clrjmp1.s
 delete mode 100644 tests/tcg/cris/bare/check_cmp-2.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpc.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpm.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpq.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpr.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpxc.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpxm.s
 delete mode 100644 tests/tcg/cris/bare/check_dstep.s
 delete mode 100644 tests/tcg/cris/bare/check_jsr.s
 delete mode 100644 tests/tcg/cris/bare/check_lapc.s
 delete mode 100644 tests/tcg/cris/bare/check_lsl.s
 delete mode 100644 tests/tcg/cris/bare/check_lsr.s
 delete mode 100644 tests/tcg/cris/bare/check_mcp.s
 delete mode 100644 tests/tcg/cris/bare/check_movdelsr1.s
 delete mode 100644 tests/tcg/cris/bare/check_movecr.s
 delete mode 100644 tests/tcg/cris/bare/check_movei.s
 delete mode 100644 tests/tcg/cris/bare/check_movemr.s
 delete mode 100644 tests/tcg/cris/bare/check_movemrv32.s
 delete mode 100644 tests/tcg/cris/bare/check_mover.s
 delete mode 100644 tests/tcg/cris/bare/check_moverm.s
 delete mode 100644 tests/tcg/cris/bare/check_movmp.s
 delete mode 100644 tests/tcg/cris/bare/check_movpmv32.s
 delete mode 100644 tests/tcg/cris/bare/check_movpr.s
 delete mode 100644 tests/tcg/cris/bare/check_movprv32.s
 delete mode 100644 tests/tcg/cris/bare/check_movscr.s
 delete mode 100644 tests/tcg/cris/bare/check_movsm.s
 delete mode 100644 tests/tcg/cris/bare/check_movsr.s
 delete mode 100644 tests/tcg/cris/bare/check_movucr.s
 delete mode 100644 tests/tcg/cris/bare/check_movum.s
 delete mode 100644 tests/tcg/cris/bare/check_movur.s
 delete mode 100644 tests/tcg/cris/bare/check_mulv32.s
 delete mode 100644 tests/tcg/cris/bare/check_mulx.s
 delete mode 100644 tests/tcg/cris/bare/check_neg.s
 delete mode 100644 tests/tcg/cris/bare/check_not.s
 delete mode 100644 tests/tcg/cris/bare/check_orc.s
 delete mode 100644 tests/tcg/cris/bare/check_orm.s
 delete mode 100644 tests/tcg/cris/bare/check_orq.s
 delete mode 100644 tests/tcg/cris/bare/check_orr.s
 delete mode 100644 tests/tcg/cris/bare/check_ret.s
 delete mode 100644 tests/tcg/cris/bare/check_scc.s
 delete mode 100644 tests/tcg/cris/bare/check_subc.s
 delete mode 100644 tests/tcg/cris/bare/check_subm.s
 delete mode 100644 tests/tcg/cris/bare/check_subq.s
 delete mode 100644 tests/tcg/cris/bare/check_subr.s
 delete mode 100644 tests/tcg/cris/bare/check_xarith.s
 delete mode 100644 tests/tcg/cris/bare/crt.s
 delete mode 100644 tests/tcg/cris/bare/testutils.inc

diff --git a/MAINTAINERS b/MAINTAINERS
index 26f9310a4f..d0ddbb6bfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -230,7 +230,6 @@ S: Maintained
 F: target/cris/
 F: hw/cris/
 F: include/hw/cris/
-F: tests/tcg/cris/
 F: disas/cris.c
 
 Hexagon TCG CPUs
diff --git a/tests/tcg/cris/bare/sys.c b/tests/tcg/cris/bare/sys.c
deleted file mode 100644
index 1644eecc33..0000000000
--- a/tests/tcg/cris/bare/sys.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Helper functions for CRIS system tests
- *
- * There is no libc and only a limited set of headers.
- */
-
-#include <stddef.h>
-
-void exit(int status)
-{
-    register unsigned int callno asm ("r9") = 1; /* NR_exit */
-
-    asm volatile ("break 13\n"
-                  : /* no outputs */
-                  : "r" (callno)
-                  : "memory");
-    while (1) {
-        /* do nothing */
-    };
-}
-
-size_t write(int fd, const void *buf, size_t count)
-{
-    register unsigned int callno asm ("r9") = 4; /* NR_write */
-    register unsigned int r10 asm ("r10") = fd;
-    register const void *r11 asm ("r11") = buf;
-    register size_t r12 asm ("r12") = count;
-    register unsigned int r asm ("r10");
-
-    asm volatile ("break 13\n"
-                  : "=r" (r)
-                  : "r" (callno), "0" (r10), "r" (r11), "r" (r12)
-                  : "memory");
-
-    return r;
-}
-
-static inline int mystrlen(char *s)
-{
-    int i = 0;
-    while (s[i]) {
-        i++;
-    }
-    return i;
-}
-
-
-void pass(void)
-{
-    char s[] = "passed.\n";
-    write(1, s, sizeof(s) - 1);
-    exit(0);
-}
-
-void _fail(char *reason)
-{
-    char s[] = "\nfailed: ";
-    int len = mystrlen(reason);
-    write(1, s, sizeof(s) - 1);
-    write(1, reason, len);
-    write(1, "\n", 1);
-    exit(1);
-}
diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
index 46d6c00140..6dc58d06c7 100644
--- a/scripts/probe-gdb-support.py
+++ b/scripts/probe-gdb-support.py
@@ -28,7 +28,6 @@
     "armv7": "arm",
     "armv8-a" : ["aarch64", "aarch64_be"],
     "avr" : "avr",
-    "cris" : "cris",
     # no hexagon in upstream gdb
     "hppa1.0" : "hppa",
     "i386" : "i386",
diff --git a/tests/tcg/cris/.gdbinit b/tests/tcg/cris/.gdbinit
deleted file mode 100644
index 5e8c1d32f3..0000000000
--- a/tests/tcg/cris/.gdbinit
+++ /dev/null
@@ -1,11 +0,0 @@
-b main
-b _fail
-b exit
-display /i $pc
-display /x $srp
-display /x $r0
-display /x $r1
-display /x $r2
-display /x $r3
-display /x $r4
-display /t $ccs
diff --git a/tests/tcg/cris/Makefile.target b/tests/tcg/cris/Makefile.target
deleted file mode 100644
index 713e2a5b6c..0000000000
--- a/tests/tcg/cris/Makefile.target
+++ /dev/null
@@ -1,62 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# Cris tests
-#
-# Currently we can only build the "bare" tests with the docker
-# supplied cross-compiler.
-#
-
-CRIS_SRC = $(SRC_PATH)/tests/tcg/cris/bare
-CRIS_ALL = $(wildcard $(CRIS_SRC)/*.s)
-CRIS_TESTS = $(patsubst $(CRIS_SRC)/%.s, %, $(CRIS_ALL))
-# Filter out common blobs and broken tests
-CRIS_BROKEN_TESTS  = crt check_jsr
-# upstream GCC doesn't support v32
-CRIS_BROKEN_TESTS += check_mcp check_mulv32 check_addiv32 check_movpmv32
-CRIS_BROKEN_TESTS += check_movprv32 check_clearfv32 check_movemrv32 check_bas
-CRIS_BROKEN_TESTS += check_lapc check_movei
-# no sure why
-CRIS_BROKEN_TESTS += check_scc check_xarith
-
-CRIS_USABLE_TESTS = $(filter-out $(CRIS_BROKEN_TESTS), $(CRIS_TESTS))
-CRIS_RUNS = $(patsubst %, run-%, $(CRIS_USABLE_TESTS))
-
-# override the list of tests, as we can't build the multiarch tests
-TESTS = $(CRIS_USABLE_TESTS)
-EXTRA_RUNS =
-VPATH = $(CRIS_SRC)
-
-AS	= $(CC) -x assembler-with-cpp
-LD      = $(CC)
-
-# we rely on GCC inline:ing the stuff we tell it to in many places here.
-CFLAGS  = -Winline -Wall -g -O2 -static -fno-stack-protector
-NOSTDFLAGS = -nostartfiles -nostdlib
-ASFLAGS += -mcpu=v10 -g -Wa,-I,$(SRC_PATH)/tests/tcg/cris/bare
-CRT_FILES = crt.o sys.o
-
-# stop make deleting crt files if build fails
-.PRECIOUS: $(CRT_FILES)
-
-%.o: %.c
-	$(CC) -c $< -o $@
-
-%.o: %.s
-	$(AS) $(ASFLAGS) -c $< -o $@
-
-%: %.s $(CRT_FILES)
-	$(CC) $(ASFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT_FILES)
-
-# The default CPU breaks (possibly as it's max?) so force crisv17
-QEMU_OPTS=-cpu crisv17
-
-# Additional runners to run under GNU SIM
-CRIS_RUNS_ON_SIM=$(patsubst %, %-on-sim, $(CRIS_RUNS))
-SIMG:=cris-axis-linux-gnu-run
-
-# e.g.: make -f ../../tests/tcg/Makefile run-check_orm-on-sim
-run-%-on-sim:
-	$(call run-test, $<, $(SIMG) $<)
-
-# We don't currently support the multiarch tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/cris/README b/tests/tcg/cris/README
deleted file mode 100644
index 2e65a76f10..0000000000
--- a/tests/tcg/cris/README
+++ /dev/null
@@ -1 +0,0 @@
-Test-suite for the cris port. Heavily based on the test-suite for the CRIS port of sim by Hans-Peter Nilsson.
diff --git a/tests/tcg/cris/bare/check_addcv17.s b/tests/tcg/cris/bare/check_addcv17.s
deleted file mode 100644
index 52ef7a9716..0000000000
--- a/tests/tcg/cris/bare/check_addcv17.s
+++ /dev/null
@@ -1,65 +0,0 @@
-# mach:  crisv17
-
- .include "testutils.inc"
-
- .macro addc Rs Rd inc=0
-# Create the instruction manually since there is no assembler support yet
- .word (\Rd << 12) | \Rs | (\inc << 10) | 0x09a0
- .endm
-
- start
-
- .data
-mem1:
- .dword 0x0
-mem2:
- .dword 0x12345678
-
- .text
- move.d mem1,r4
- clearf nzvc
- addc 4 3
- test_cc 0 1 0 0
- checkr3 0
-
- move.d mem1,r4
- clearf nzvc
- ax
- addc 4 3
- test_cc 0 0 0 0
- checkr3 0
-
- move.d mem1,r4
- clearf nzvc
- setf c
- addc 4 3
- test_cc 0 0 0 0
- checkr3 1
-
- move.d mem2,r4
- moveq 2, r3
- clearf nzvc
- setf c
- addc 4 3
- test_cc 0 0 0 0
- checkr3 1234567b
-
- move.d mem2,r5
- clearf nzvc
- cmp.d r4,r5
- test_cc 0 1 0 0
-
- move.d mem2,r4
- moveq 2, r3
- clearf nzvc
- addc 4 3 inc=1
- test_cc 0 0 0 0
- checkr3 1234567a
-
- move.d mem2,r5
- clearf nzvc
- addq 4,r5
- cmp.d r4,r5
- test_cc 0 1 0 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_addi.s b/tests/tcg/cris/bare/check_addi.s
deleted file mode 100644
index a00dec02af..0000000000
--- a/tests/tcg/cris/bare/check_addi.s
+++ /dev/null
@@ -1,57 +0,0 @@
-# mach:  crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 0\n1\n2\n4\nbe02460f\n69d035a6\nc16c14d4\n
-
- .include "testutils.inc"
- start
- moveq 0,r3
- moveq 0,r4
- clearf zcvn
- addi r4.b,r3
- test_cc 0 0 0 0
- checkr3 0
-
- moveq 0,r3
- moveq 1,r4
- setf zcvn
- addi r4.b,r3
- test_cc 1 1 1 1
- checkr3 1
-
- moveq 0,r3
- moveq 1,r4
- setf cv
- clearf zn
- addi r4.w,r3
- test_cc 0 0 1 1
- checkr3 2
-
- moveq 0,r3
- moveq 1,r4
- clearf cv
- setf zn
- addi r4.d,r3
- test_cc 1 1 0 0
- checkr3 4
-
- move.d 0x12345678,r3
- move.d 0xabcdef97,r4
- clearf cn
- setf zv
- addi r4.b,r3
- test_cc 0 1 1 0
- checkr3 be02460f
-
- move.d 0x12345678,r3
- move.d 0xabcdef97,r4
- setf cn
- clearf zv
- addi r4.w,r3
- test_cc 1 0 0 1
- checkr3 69d035a6
-
- move.d 0x12345678,r3
- move.d 0xabcdef97,r4
- addi r4.d,r3
- checkr3 c16c14d4
-
- quit
diff --git a/tests/tcg/cris/bare/check_addiv32.s b/tests/tcg/cris/bare/check_addiv32.s
deleted file mode 100644
index 20ba25d219..0000000000
--- a/tests/tcg/cris/bare/check_addiv32.s
+++ /dev/null
@@ -1,62 +0,0 @@
-# mach: crisv32
-# output: 4455aa77\n4455aa77\nee19ccff\nff22\n4455aa77\nff224455\n55aa77ff\n
-
- .include "testutils.inc"
- .data
-x:
- .dword 0x55aa77ff
- .dword 0xccff2244
- .dword 0x88ccee19
-
- start
- setf cv
- moveq -1,r0
- move.d x-32768,r5
- move.d 32769,r6
- addi r6.b,r5,acr
- test_cc 0 0 1 1
- move.d [acr],r3
- checkr3 4455aa77
-
- addu.w 32771,r5
- setf znvc
- moveq -1,r8
- addi r8.w,r5,acr
- test_cc 1 1 1 1
- move.d [acr],r3
- checkr3 4455aa77
-
- moveq 5,r10
- clearf znvc
- addi r10.b,acr,acr
- test_cc 0 0 0 0
- move.d [acr],r3
- checkr3 ee19ccff
-
- subq 1,r5
- move.d r5,r8
- subq 1,r8
- moveq 1,r9
- addi r9.d,r8,acr
- test_cc 0 0 0 0
- movu.w [acr],r3
- checkr3 ff22
-
- moveq -2,r11
- addi r11.w,acr,acr
- move.d [acr],r3
- checkr3 4455aa77
-
- moveq 5,r9
- addi r9.d,acr,acr
- subq 18,acr
- move.d [acr],r3
- checkr3 ff224455
-
- move.d -76789888/4,r12
- addi r12.d,r5,acr
- add.d 76789886,acr
- move.d [acr],r3
- checkr3 55aa77ff
-
- quit
diff --git a/tests/tcg/cris/bare/check_addm.s b/tests/tcg/cris/bare/check_addm.s
deleted file mode 100644
index efece9f538..0000000000
--- a/tests/tcg/cris/bare/check_addm.s
+++ /dev/null
@@ -1,96 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 1\n1\n1fffe\nfffffffe\ncc463bdb\nffff0001\n1\nfffe\nfedafffe\n78133bdb\nffffff01\n1\nfe\nfeda49fe\n781344db\n781344d0\n
-
- .include "testutils.inc"
- .data
-x:
- .dword 2,-1,0xffff,-1,0x5432f789
- .word 2,-1,0xffff,0xf789
- .byte 2,0xff,0x89
- .byte 0x7e
-
- start
- moveq -1,r3
- move.d x,r5
- add.d [r5+],r3
- test_cc 0 0 0 1
- checkr3 1
-
- moveq 2,r3
- add.d [r5],r3
- test_cc 0 0 0 1
- addq 4,r5
- checkr3 1
-
- move.d 0xffff,r3
- add.d [r5+],r3
- test_cc 0 0 0 0
- checkr3 1fffe
-
- moveq -1,r3
- add.d [r5+],r3
- test_cc 1 0 0 1
- checkr3 fffffffe
-
- move.d 0x78134452,r3
- add.d [r5+],r3
- test_cc 1 0 1 0
- checkr3 cc463bdb
-
- moveq -1,r3
- add.w [r5+],r3
- test_cc 0 0 0 1
- checkr3 ffff0001
-
- moveq 2,r3
- add.w [r5+],r3
- test_cc 0 0 0 1
- checkr3 1
-
- move.d 0xffff,r3
- add.w [r5],r3
- test_cc 1 0 0 1
- checkr3 fffe
-
- move.d 0xfedaffff,r3
- add.w [r5+],r3
- test_cc 1 0 0 1
- checkr3 fedafffe
-
- move.d 0x78134452,r3
- add.w [r5+],r3
- test_cc 0 0 0 1
- checkr3 78133bdb
-
- moveq -1,r3
- add.b [r5],r3
- test_cc 0 0 0 1
- addq 1,r5
- checkr3 ffffff01
-
- moveq 2,r3
- add.b [r5],r3
- test_cc 0 0 0 1
- checkr3 1
-
- move.d 0xff,r3
- add.b [r5],r3
- test_cc 1 0 0 1
- checkr3 fe
-
- move.d 0xfeda49ff,r3
- add.b [r5+],r3
- test_cc 1 0 0 1
- checkr3 feda49fe
-
- move.d 0x78134452,r3
- add.b [r5+],r3
- test_cc 1 0 0 0
- checkr3 781344db
-
- move.d 0x78134452,r3
- add.b [r5],r3
- test_cc 1 0 1 0
- checkr3 781344d0
-
- quit
diff --git a/tests/tcg/cris/bare/check_addq.s b/tests/tcg/cris/bare/check_addq.s
deleted file mode 100644
index e6f874f9b2..0000000000
--- a/tests/tcg/cris/bare/check_addq.s
+++ /dev/null
@@ -1,47 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: ffffffff\n0\n1\n100\n10000\n47\n67\na6\n80000001\n
-
- .include "testutils.inc"
- start
- moveq -2,r3
- addq 1,r3
- test_cc 1 0 0 0
- checkr3 ffffffff
-
- addq 1,r3
- test_cc 0 1 0 1
- checkr3 0
-
- addq 1,r3
- test_cc 0 0 0 0
- checkr3 1
-
- move.d 0xff,r3
- addq 1,r3
- test_cc 0 0 0 0
- checkr3 100
-
- move.d 0xffff,r3
- addq 1,r3
- test_cc 0 0 0 0
- checkr3 10000
-
- move.d 0x42,r3
- addq 5,r3
- test_cc 0 0 0 0
- checkr3 47
-
- addq 32,r3
- test_cc 0 0 0 0
- checkr3 67
-
- addq 63,r3
- test_cc 0 0 0 0
- checkr3 a6
-
- move.d 0x7ffffffe,r3
- addq 3,r3
- test_cc 1 0 1 0
- checkr3 80000001
-
- quit
diff --git a/tests/tcg/cris/bare/check_addr.s b/tests/tcg/cris/bare/check_addr.s
deleted file mode 100644
index 7f55cdc1b5..0000000000
--- a/tests/tcg/cris/bare/check_addr.s
+++ /dev/null
@@ -1,96 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 1\n1\n1fffe\nfffffffe\ncc463bdb\nffff0001\n1\nfffe\nfedafffe\n78133bdb\nffffff01\n1\nfe\nfeda49fe\n781344db\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- moveq 2,r4
- add.d r4,r3
- test_cc 0 0 0 1
- checkr3 1
-
- moveq 2,r3
- moveq -1,r4
- add.d r4,r3
- test_cc 0 0 0 1
- checkr3 1
-
- move.d 0xffff,r4
- move.d r4,r3
- add.d r4,r3
- test_cc 0 0 0 0
- checkr3 1fffe
-
- moveq -1,r4
- move.d r4,r3
- add.d r4,r3
- test_cc 1 0 0 1
- checkr3 fffffffe
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- add.d r4,r3
- test_cc 1 0 1 0
- checkr3 cc463bdb
-
- moveq -1,r3
- moveq 2,r4
- add.w r4,r3
- test_cc 0 0 0 1
- checkr3 ffff0001
-
- moveq 2,r3
- moveq -1,r4
- add.w r4,r3
- test_cc 0 0 0 1
- checkr3 1
-
- move.d 0xffff,r4
- move.d r4,r3
- add.w r4,r3
- test_cc 1 0 0 1
- checkr3 fffe
-
- move.d 0xfedaffff,r4
- move.d r4,r3
- add.w r4,r3
- test_cc 1 0 0 1
- checkr3 fedafffe
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- add.w r4,r3
- test_cc 0 0 0 1
- checkr3 78133bdb
-
- moveq -1,r3
- moveq 2,r4
- add.b r4,r3
- test_cc 0 0 0 1
- checkr3 ffffff01
-
- moveq 2,r3
- moveq -1,r4
- add.b r4,r3
- test_cc 0 0 0 1
- checkr3 1
-
- move.d 0xff,r4
- move.d r4,r3
- add.b r4,r3
- test_cc 1 0 0 1
- checkr3 fe
-
- move.d 0xfeda49ff,r4
- move.d r4,r3
- add.b r4,r3
- test_cc 1 0 0 1
- checkr3 feda49fe
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- add.b r4,r3
- test_cc 1 0 0 0
- checkr3 781344db
-
- quit
diff --git a/tests/tcg/cris/bare/check_addxc.s b/tests/tcg/cris/bare/check_addxc.s
deleted file mode 100644
index 09c8355bf8..0000000000
--- a/tests/tcg/cris/bare/check_addxc.s
+++ /dev/null
@@ -1,91 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 1\n1\n101\n10001\n100fe\n1fffe\nfffe\nfffe\nfffffffe\nfe\nfffffffe\n781344db\n781343db\n78143bdb\n78133bdb\n800000ed\n0\n
-
- .include "testutils.inc"
- start
- moveq 2,r3
- adds.b 0xff,r3
- test_cc 0 0 0 1
- checkr3 1
-
- moveq 2,r3
- adds.w 0xffff,r3
- test_cc 0 0 0 1
- checkr3 1
-
- moveq 2,r3
- addu.b 0xff,r3
- checkr3 101
-
- moveq 2,r3
- move.d 0xffffffff,r4
- addu.w -1,r3
- test_cc 0 0 0 0
- checkr3 10001
-
- move.d 0xffff,r3
- addu.b -1,r3
- test_cc 0 0 0 0
- checkr3 100fe
-
- move.d 0xffff,r3
- addu.w -1,r3
- test_cc 0 0 0 0
- checkr3 1fffe
-
- move.d 0xffff,r3
- adds.b 0xff,r3
- test_cc 0 0 0 1
- checkr3 fffe
-
- move.d 0xffff,r3
- adds.w 0xffff,r3
- test_cc 0 0 0 1
- checkr3 fffe
-
- moveq -1,r3
- adds.b 0xff,r3
- test_cc 1 0 0 1
- checkr3 fffffffe
-
- moveq -1,r3
- adds.w 0xff,r3
- test_cc 0 0 0 1
- checkr3 fe
-
- moveq -1,r3
- adds.w 0xffff,r3
- test_cc 1 0 0 1
- checkr3 fffffffe
-
- move.d 0x78134452,r3
- addu.b 0x89,r3
- test_cc 0 0 0 0
- checkr3 781344db
-
- move.d 0x78134452,r3
- adds.b 0x89,r3
- test_cc 0 0 0 1
- checkr3 781343db
-
- move.d 0x78134452,r3
- addu.w 0xf789,r3
- test_cc 0 0 0 0
- checkr3 78143bdb
-
- move.d 0x78134452,r3
- adds.w 0xf789,r3
- test_cc 0 0 0 1
- checkr3 78133bdb
-
- move.d 0x7fffffee,r3
- addu.b 0xff,r3
- test_cc 1 0 1 0
- checkr3 800000ed
-
- move.d 0x1,r3
- adds.w 0xffff,r3
- test_cc 0 1 0 1
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_addxm.s b/tests/tcg/cris/bare/check_addxm.s
deleted file mode 100644
index 7563494b99..0000000000
--- a/tests/tcg/cris/bare/check_addxm.s
+++ /dev/null
@@ -1,106 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 1\n1\n101\n10001\n100fe\n1fffe\nfffe\nfffe\nfffffffe\nfe\nfffffffe\n781344db\n781343db\n78143bdb\n78133bdb\n800000ed\n0\n
-
- .include "testutils.inc"
- .data
-x:
- .byte 0xff
- .word 0xffff
- .word 0xff
- .word 0xffff
- .byte 0x89
- .word 0xf789
- .byte 0xff
- .word 0xffff
-
- start
- moveq 2,r3
- move.d x,r5
- adds.b [r5+],r3
- test_cc 0 0 0 1
- checkr3 1
-
- moveq 2,r3
- adds.w [r5+],r3
- test_cc 0 0 0 1
- checkr3 1
-
- moveq 2,r3
- subq 3,r5
- addu.b [r5+],r3
- test_cc 0 0 0 0
- checkr3 101
-
- moveq 2,r3
- addu.w [r5+],r3
- subq 3,r5
- test_cc 0 0 0 0
- checkr3 10001
-
- move.d 0xffff,r3
- addu.b [r5],r3
- test_cc 0 0 0 0
- checkr3 100fe
-
- move.d 0xffff,r3
- addu.w [r5],r3
- test_cc 0 0 0 0
- checkr3 1fffe
-
- move.d 0xffff,r3
- adds.b [r5],r3
- test_cc 0 0 0 1
- checkr3 fffe
-
- move.d 0xffff,r3
- adds.w [r5],r3
- test_cc 0 0 0 1
- checkr3 fffe
-
- moveq -1,r3
- adds.b [r5],r3
- test_cc 1 0 0 1
- addq 3,r5
- checkr3 fffffffe
-
- moveq -1,r3
- adds.w [r5+],r3
- test_cc 0 0 0 1
- checkr3 fe
-
- moveq -1,r3
- adds.w [r5+],r3
- test_cc 1 0 0 1
- checkr3 fffffffe
-
- move.d 0x78134452,r3
- addu.b [r5],r3
- test_cc 0 0 0 0
- checkr3 781344db
-
- move.d 0x78134452,r3
- adds.b [r5+],r3
- test_cc 0 0 0 1
- checkr3 781343db
-
- move.d 0x78134452,r3
- addu.w [r5],r3
- test_cc 0 0 0 0
- checkr3 78143bdb
-
- move.d 0x78134452,r3
- adds.w [r5+],r3
- test_cc 0 0 0 1
- checkr3 78133bdb
-
- move.d 0x7fffffee,r3
- addu.b [r5+],r3
- test_cc 1 0 1 0
- checkr3 800000ed
-
- move.d 0x1,r3
- adds.w [r5+],r3
- test_cc 0 1 0 1
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_addxr.s b/tests/tcg/cris/bare/check_addxr.s
deleted file mode 100644
index 7f55cdc1b5..0000000000
--- a/tests/tcg/cris/bare/check_addxr.s
+++ /dev/null
@@ -1,96 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 1\n1\n1fffe\nfffffffe\ncc463bdb\nffff0001\n1\nfffe\nfedafffe\n78133bdb\nffffff01\n1\nfe\nfeda49fe\n781344db\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- moveq 2,r4
- add.d r4,r3
- test_cc 0 0 0 1
- checkr3 1
-
- moveq 2,r3
- moveq -1,r4
- add.d r4,r3
- test_cc 0 0 0 1
- checkr3 1
-
- move.d 0xffff,r4
- move.d r4,r3
- add.d r4,r3
- test_cc 0 0 0 0
- checkr3 1fffe
-
- moveq -1,r4
- move.d r4,r3
- add.d r4,r3
- test_cc 1 0 0 1
- checkr3 fffffffe
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- add.d r4,r3
- test_cc 1 0 1 0
- checkr3 cc463bdb
-
- moveq -1,r3
- moveq 2,r4
- add.w r4,r3
- test_cc 0 0 0 1
- checkr3 ffff0001
-
- moveq 2,r3
- moveq -1,r4
- add.w r4,r3
- test_cc 0 0 0 1
- checkr3 1
-
- move.d 0xffff,r4
- move.d r4,r3
- add.w r4,r3
- test_cc 1 0 0 1
- checkr3 fffe
-
- move.d 0xfedaffff,r4
- move.d r4,r3
- add.w r4,r3
- test_cc 1 0 0 1
- checkr3 fedafffe
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- add.w r4,r3
- test_cc 0 0 0 1
- checkr3 78133bdb
-
- moveq -1,r3
- moveq 2,r4
- add.b r4,r3
- test_cc 0 0 0 1
- checkr3 ffffff01
-
- moveq 2,r3
- moveq -1,r4
- add.b r4,r3
- test_cc 0 0 0 1
- checkr3 1
-
- move.d 0xff,r4
- move.d r4,r3
- add.b r4,r3
- test_cc 1 0 0 1
- checkr3 fe
-
- move.d 0xfeda49ff,r4
- move.d r4,r3
- add.b r4,r3
- test_cc 1 0 0 1
- checkr3 feda49fe
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- add.b r4,r3
- test_cc 1 0 0 0
- checkr3 781344db
-
- quit
diff --git a/tests/tcg/cris/bare/check_andc.s b/tests/tcg/cris/bare/check_andc.s
deleted file mode 100644
index a947b773c9..0000000000
--- a/tests/tcg/cris/bare/check_andc.s
+++ /dev/null
@@ -1,80 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 2\n2\nffff\nffffffff\n50124400\nffff0002\n2\nfffff\nfedaff0f\n78134400\nffffff02\n2\nf02\n78134401\n78134400\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- and.d 2,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq 2,r3
- and.d -1,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xffff,r3
- and.d 0xffff,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- moveq -1,r3
- and.d -1,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x78134452,r3
- and.d 0x5432f789,r3
- test_move_cc 0 0 0 0
- checkr3 50124400
-
- moveq -1,r3
- and.w 2,r3
- test_move_cc 0 0 0 0
- checkr3 ffff0002
-
- moveq 2,r3
- and.w -1,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xfffff,r3
- and.w 0xffff,r3
- test_move_cc 1 0 0 0
- checkr3 fffff
-
- move.d 0xfedaffaf,r3
- and.w 0xff5f,r3
- test_move_cc 1 0 0 0
- checkr3 fedaff0f
-
- move.d 0x78134452,r3
- and.w 0xf789,r3
- test_move_cc 0 0 0 0
- checkr3 78134400
-
- moveq -1,r3
- and.b 2,r3
- test_move_cc 0 0 0 0
- checkr3 ffffff02
-
- moveq 2,r3
- and.b -1,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xfa7,r3
- and.b 0x5a,r3
- test_move_cc 0 0 0 0
- checkr3 f02
-
- move.d 0x78134453,r3
- and.b 0x89,r3
- test_move_cc 0 0 0 0
- checkr3 78134401
-
- and.b 0,r3
- test_move_cc 0 1 0 0
- checkr3 78134400
-
- quit
diff --git a/tests/tcg/cris/bare/check_andm.s b/tests/tcg/cris/bare/check_andm.s
deleted file mode 100644
index 93858863fe..0000000000
--- a/tests/tcg/cris/bare/check_andm.s
+++ /dev/null
@@ -1,90 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 2\n2\nffff\nffffffff\n50124400\nffff0002\n2\nfffff\nfedaff0f\n78134400\nffffff02\n2\nf02\n78134401\n78134400\n
-
- .include "testutils.inc"
- .data
-x:
- .dword 2,-1,0xffff,-1,0x5432f789
- .word 2,-1,0xffff,0xff5f,0xf789
- .byte 2,-1,0x5a,0x89,0
-
- start
- moveq -1,r3
- move.d x,r5
- and.d [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq 2,r3
- and.d [r5],r3
- test_move_cc 0 0 0 0
- addq 4,r5
- checkr3 2
-
- move.d 0xffff,r3
- and.d [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- moveq -1,r3
- and.d [r5+],r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x78134452,r3
- and.d [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 50124400
-
- moveq -1,r3
- and.w [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 ffff0002
-
- moveq 2,r3
- and.w [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xfffff,r3
- and.w [r5],r3
- test_move_cc 1 0 0 0
- addq 2,r5
- checkr3 fffff
-
- move.d 0xfedaffaf,r3
- and.w [r5+],r3
- test_move_cc 1 0 0 0
- checkr3 fedaff0f
-
- move.d 0x78134452,r3
- and.w [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 78134400
-
- moveq -1,r3
- and.b [r5],r3
- test_move_cc 0 0 0 0
- addq 1,r5
- checkr3 ffffff02
-
- moveq 2,r3
- and.b [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xfa7,r3
- and.b [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 f02
-
- move.d 0x78134453,r3
- and.b [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 78134401
-
- and.b [r5],r3
- test_move_cc 0 1 0 0
- checkr3 78134400
-
- quit
diff --git a/tests/tcg/cris/bare/check_andq.s b/tests/tcg/cris/bare/check_andq.s
deleted file mode 100644
index 55aa7b0607..0000000000
--- a/tests/tcg/cris/bare/check_andq.s
+++ /dev/null
@@ -1,46 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 2\n2\nffff\nffffffff\n1f\nffffffe0\n78134452\n0\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- andq 2,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq 2,r3
- andq -1,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xffff,r3
- andq -1,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- moveq -1,r3
- andq -1,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- andq 31,r3
- test_move_cc 0 0 0 0
- checkr3 1f
-
- moveq -1,r3
- andq -32,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffe0
-
- move.d 0x78134457,r3
- andq -14,r3
- test_move_cc 0 0 0 0
- checkr3 78134452
-
- moveq 0,r3
- andq -14,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_andr.s b/tests/tcg/cris/bare/check_andr.s
deleted file mode 100644
index 61aa1dc32f..0000000000
--- a/tests/tcg/cris/bare/check_andr.s
+++ /dev/null
@@ -1,95 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 2\n2\nffff\nffffffff\n50124400\nffff0002\n2\nfffff\nfedaff0f\n78134400\nffffff02\n2\nf02\n78134401\n78134400\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- moveq 2,r4
- and.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq 2,r3
- moveq -1,r4
- and.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xffff,r4
- move.d r4,r3
- and.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- moveq -1,r4
- move.d r4,r3
- and.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- and.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 50124400
-
- moveq -1,r3
- moveq 2,r4
- and.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffff0002
-
- moveq 2,r3
- moveq -1,r4
- and.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xfffff,r3
- move.d 0xffff,r4
- and.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 fffff
-
- move.d 0xfedaffaf,r3
- move.d 0xff5f,r4
- and.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 fedaff0f
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- and.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 78134400
-
- moveq -1,r3
- moveq 2,r4
- and.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffffff02
-
- moveq 2,r3
- moveq -1,r4
- and.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0x5a,r4
- move.d 0xfa7,r3
- and.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 f02
-
- move.d 0x5432f789,r4
- move.d 0x78134453,r3
- and.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 78134401
-
- moveq 0,r7
- and.b r7,r3
- test_move_cc 0 1 0 0
- checkr3 78134400
-
- quit
diff --git a/tests/tcg/cris/bare/check_asr.s b/tests/tcg/cris/bare/check_asr.s
deleted file mode 100644
index 0a02ae6f7e..0000000000
--- a/tests/tcg/cris/bare/check_asr.s
+++ /dev/null
@@ -1,230 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: ffffffff\n1\nffffffff\nffffffff\n5a67f\nffffffff\nffffffff\nffffffff\nf699fc67\nffffffff\n1\nffffffff\nffffffff\n5a67f\nda67ffff\nda67ffff\nda67ffff\nda67fc67\nffffffff\nffffffff\n1\nffffffff\nffffffff\n5a670007\nda67f1ff\nda67f1ff\nda67f1ff\nda67f1e7\nffffffff\nffffffff\n1\nffffffff\nffffffff\nffffffff\n5a67f1ff\n5a67f1f9\n0\n5a670000\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- asrq 0,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- asrq 1,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
- moveq -1,r3
- asrq 31,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- asrq 15,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x5a67f19f,r3
- asrq 12,r3
- test_move_cc 0 0 0 0
- checkr3 5a67f
-
- move.d 0xda67f19f,r3
- move.d 31,r4
- asr.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0xda67f19f,r3
- move.d 32,r4
- asr.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0xda67f19f,r3
- move.d 33,r4
- asr.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0xda67f19f,r3
- move.d 66,r4
- asr.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 f699fc67
-
- moveq -1,r3
- moveq 0,r4
- asr.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- moveq 1,r4
- asr.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
- moveq -1,r3
- moveq 31,r4
- asr.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 15,r4
- asr.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x5a67f19f,r3
- moveq 12,r4
- asr.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 5a67f
-
- move.d 0xda67f19f,r3
- move.d 31,r4
- asr.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 da67ffff
-
- move.d 0xda67f19f,r3
- move.d 32,r4
- asr.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 da67ffff
-
- move.d 0xda67f19f,r3
- move.d 33,r4
- asr.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 da67ffff
-
- move.d 0xda67f19f,r3
- move.d 66,r4
- asr.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 da67fc67
-
- moveq -1,r3
- moveq 0,r4
- asr.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 1,r4
- asr.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- moveq 1,r4
- asr.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
- moveq -1,r3
- moveq 31,r4
- asr.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 15,r4
- asr.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x5a67719f,r3
- moveq 12,r4
- asr.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 5a670007
-
- move.d 0xda67f19f,r3
- move.d 31,r4
- asr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 da67f1ff
-
- move.d 0xda67f19f,r3
- move.d 32,r4
- asr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 da67f1ff
-
- move.d 0xda67f19f,r3
- move.d 33,r4
- asr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 da67f1ff
-
- move.d 0xda67f19f,r3
- move.d 66,r4
- asr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 da67f1e7
-
- moveq -1,r3
- moveq 0,r4
- asr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 1,r4
- asr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- moveq 1,r4
- asr.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
- moveq -1,r3
- moveq 31,r4
- asr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 15,r4
- asr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 7,r4
- asr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
-; FIXME: was wrong.
- move.d 0x5a67f19f,r3
- moveq 12,r4
- asr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 5a67f1ff
-
-; FIXME: was wrong.
- move.d 0x5a67f19f,r3
- moveq 4,r4
- asr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 5a67f1f9
-
- move.d 0x5a67f19f,r3
- asrq 31,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- move.d 0x5a67419f,r3
- moveq 16,r4
- asr.w r4,r3
- test_move_cc 0 1 0 0
- checkr3 5a670000
-
- quit
diff --git a/tests/tcg/cris/bare/check_ba.s b/tests/tcg/cris/bare/check_ba.s
deleted file mode 100644
index 873a4086c5..0000000000
--- a/tests/tcg/cris/bare/check_ba.s
+++ /dev/null
@@ -1,93 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: a\n
-
-
- .set smalloffset,0
- .set largeoffset,0
-
-
-	.macro fail
-	jump _fail
-	.endm
-
-	.global	main
-main:
- moveq 0,$r3
-
-; Short forward branch.
- ba 0f
- addq 1,$r3
- fail
-
-; Max short forward branch.
-1:
- ba 2f
- addq 1,$r3
- fail
-
-; Short backward branch.
-0:
- ba 1b
- addq 1,$r3
- fail
-
- .space 254-2+smalloffset+1b-.,0
- moveq 0,$r3
-
-2:
-; Transit branch (long).
- ba 3f
- addq 1,$r3
- fail
-
- moveq 0,$r3
-4:
-; Long forward branch.
- ba 5f
- addq 1,$r3
- fail
-
- .space 256-2-smalloffset+4b-.,0
-
- moveq 0,$r3
-
-; Max short backward branch.
-3:
- ba 4b
- addq 1,$r3
- fail
-
-5:
-; Max long forward branch.
- ba 6f
- addq 1,$r3
- fail
-
- .space 32766+largeoffset-2+5b-.,0
-
- moveq 0,$r3
-6:
-; Transit branch.
- ba 7f
- addq 1,$r3
- fail
-
- moveq 0,$r3
-9:
- jsr pass
- nop
-
-; Transit branch.
- moveq 0,$r3
-7:
- ba 8f
- addq 1,$r3
- fail
-
- .space 32768-largeoffset+9b-.,0
-
-8:
-; Max long backward branch.
- ba 9b
- addq 1,$r3
- fail
diff --git a/tests/tcg/cris/bare/check_bas.s b/tests/tcg/cris/bare/check_bas.s
deleted file mode 100644
index 11929d4202..0000000000
--- a/tests/tcg/cris/bare/check_bas.s
+++ /dev/null
@@ -1,102 +0,0 @@
-# mach: crisv32
-# output: 0\n0\n0\nfb349abc\n0\n12124243\n0\n0\neab5baad\n0\nefb37832\n
-
- .include "testutils.inc"
- start
-x:
- setf zncv
- bsr 0f
- nop
-0:
- test_cc 1 1 1 1
- move srp,r3
- sub.d 0b,r3
- checkr3 0
-
- bas 1f,mof
- moveq 0,r0
-6:
- nop
- quit
-
-2:
- move srp,r3
- sub.d 3f,r3
- checkr3 0
- move srp,r4
- subq 4,r4
- move.d [r4],r3
- checkr3 fb349abc
-
- basc 4f,mof
- nop
- .dword 0x12124243
-7:
- nop
- quit
-
-8:
- move mof,r3
- sub.d 7f,r3
- checkr3 0
-
- move mof,r4
- subq 4,r4
- move.d [r4],r3
- checkr3 eab5baad
-
- jasc 9f,mof
- nop
- .dword 0xefb37832
-0:
- quit
-
- quit
-9:
- move mof,r3
- sub.d 0b,r3
- checkr3 0
-
- move mof,r4
- subq 4,r4
- move.d [r4],r3
- checkr3 efb37832
-
- quit
-
-4:
- move mof,r3
- sub.d 7b,r3
- checkr3 0
- move mof,r4
- subq 4,r4
- move.d [r4],r3
- checkr3 12124243
- basc 5f,bz
- moveq 0,r3
- .dword 0x7634aeba
- quit
-
- .space 32770,0
-1:
- move mof,r3
- sub.d 6b,r3
- checkr3 0
-
- bsrc 2b
- nop
- .dword 0xfb349abc
-3:
-
- quit
-
-5:
- move mof,r3
- sub.d 7b,r3
- checkr3 0
- move.d 8b,r6
- jasc r6,mof
- nop
- .dword 0xeab5baad
-7:
- quit
diff --git a/tests/tcg/cris/bare/check_bcc.s b/tests/tcg/cris/bare/check_bcc.s
deleted file mode 100644
index c57ffa6fa3..0000000000
--- a/tests/tcg/cris/bare/check_bcc.s
+++ /dev/null
@@ -1,197 +0,0 @@
-	.global	main
-	.type	main, @function
-main:
-	clearf nzvc
-	setf   nzv
-	bcc    0f
-	addq   1, $r3
-	jump   dofail
-
-0:
-	clearf nzvc
-	setf   nzv
-	bcs    dofail
-	addq   1,$r3
-
-	clearf nzvc
-	setf   ncv
-	bne    1f
-	addq   1, $r3
-
-fail:
-dofail:
-	jump	_fail
-
-1:
-	clearf nzvc
-	setf ncv
-	beq dofail
-	addq 1,$r3
-
-	clearf nzvc
-	setf ncz
-	bvc 2f
-	addq 1,$r3
-	jump dofail
-
-2:
-	clearf nzvc
-	setf ncz
-	bvs dofail
-	addq 1,$r3
-
-	clearf	nzvc
-	setf	vcz
-	bpl	3f
-	addq	1,$r3
-	jump	fail
-3:
-	clearf	nzvc
-	setf	vcz
-	bmi	dofail
-	addq	1,$r3
-
-	clearf	nzvc
-	setf	nv
-	bls	dofail
-	addq	1,$r3
-
-	clearf	nzvc
-	setf	nv
-	bhi	4f
-	addq	1,$r3
-	jump	dofail
-
-4:
-	clearf	nzvc
-	setf	zc
-	bge	5f
-	addq	1,$r3
-	jump	dofail
-
-5:
-	clearf	nzvc
-	setf zc
-	blt dofail
-	addq 1,$r3
-
-	clearf nzvc
-	setf c
-	bgt 6f
-	addq 1,$r3
-	jump  fail
-
-6:
- clearf nzvc
- setf c
- ble dofail
- addq 1,$r3
-
-;;;;;;;;;;
-
- setf nzvc
- clearf nzv
- bcc dofail
- addq 1,$r3
-
- setf nzvc
- clearf nzv
- bcs 0f
- addq 1,$r3
- jump fail
-
-0:
- setf nzvc
- clearf ncv
- bne dofail
- addq 1,$r3
-
- setf nzvc
- clearf ncv
- beq 1f
- addq 1,$r3
- jump fail
-
-1:
- setf nzvc
- clearf ncz
- bvc dofail
- addq 1,$r3
-
- setf nzvc
- clearf ncz
- bvs 2f
- addq 1,$r3
- jump fail
-
-2:
- setf nzvc
- clearf vcz
- bpl dofail
- addq 1,$r3
-
- setf nzvc
- clearf vcz
- bmi 3f
- addq 1,$r3
- jump fail
-
-3:
- setf nzvc
- clearf nv
- bls 4f
- addq 1,$r3
- jump fail
-
-4:
- setf nzvc
- clearf nv
- bhi dofail
- addq 1,$r3
-
- setf zvc
- clearf nzc
- bge dofail
- addq 1,$r3
-
- setf nzc
- clearf vzc
- blt 5f
- addq 1,$r3
- jump fail
-
-5:
- setf nzvc
- clearf c
- bgt dofail
- addq 1,$r3
-
- setf nzvc
- clearf c
- ble 6f
- addq 1,$r3
- jump fail
-
-6:
-	; do a forward branch.
-	ba   2f
-	nop
-	.fill	100
-1:
-	ba	3f
-	nop
-	.fill	800
-2:
-	ba	1b
-	nop
-	.fill	1024
-3:
-
-	moveq	31, $r0
-1:	bne	1b
-	subq	1, $r0
-
-	jsr	pass
-	moveq	0, $r10
-	ret
-	nop
diff --git a/tests/tcg/cris/bare/check_boundc.s b/tests/tcg/cris/bare/check_boundc.s
deleted file mode 100644
index fb9e5bc905..0000000000
--- a/tests/tcg/cris/bare/check_boundc.s
+++ /dev/null
@@ -1,101 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 2\n2\nffff\nffffffff\n5432f789\n2\nffff\n2\nffff\nffff\nf789\n2\n2\nff\nff\nff\n89\n0\nff\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- moveq 2,r4
- bound.d 2,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq 2,r3
- bound.d 0xffffffff,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xffff,r3
- bound.d 0xffff,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- moveq -1,r3
- bound.d 0xffffffff,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x78134452,r3
- bound.d 0x5432f789,r3
- test_move_cc 0 0 0 0
- checkr3 5432f789
-
- moveq -1,r3
- bound.w 2,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq -1,r3
- bound.w 0xffff,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- moveq 2,r3
- bound.w 0xffff,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xffff,r3
- bound.w 0xffff,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- move.d 0xfedaffff,r3
- bound.w 0xffff,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- move.d 0x78134452,r3
- bound.w 0xf789,r3
- test_move_cc 0 0 0 0
- checkr3 f789
-
- moveq -1,r3
- bound.b 2,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq 2,r3
- bound.b 0xff,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq -1,r3
- bound.b 0xff,r3
- test_move_cc 0 0 0 0
- checkr3 ff
-
- move.d 0xff,r3
- bound.b 0xff,r3
- test_move_cc 0 0 0 0
- checkr3 ff
-
- move.d 0xfeda49ff,r3
- bound.b 0xff,r3
- test_move_cc 0 0 0 0
- checkr3 ff
-
- move.d 0x78134452,r3
- bound.b 0x89,r3
- test_move_cc 0 0 0 0
- checkr3 89
-
- bound.w 0,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- move.d 0xffff,r3
- bound.b -1,r3
- test_move_cc 0 0 0 0
- checkr3 ff
-
- quit
diff --git a/tests/tcg/cris/bare/check_boundr.s b/tests/tcg/cris/bare/check_boundr.s
deleted file mode 100644
index 5c50cc5f6a..0000000000
--- a/tests/tcg/cris/bare/check_boundr.s
+++ /dev/null
@@ -1,125 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 2\n2\nffff\nffffffff\n5432f789\n2\n2\nffff\nffff\nffff\nf789\n2\n2\nff\nff\n89\nfeda4953\nfeda4962\n0\n0\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- moveq 2,r4
- bound.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq 2,r3
- moveq -1,r4
- bound.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xffff,r4
- move.d r4,r3
- bound.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- moveq -1,r4
- move.d r4,r3
- bound.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- bound.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 5432f789
-
- moveq -1,r3
- moveq 2,r4
- bound.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq 2,r3
- moveq -1,r4
- bound.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq -1,r3
- bound.w r3,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- move.d 0xffff,r4
- move.d r4,r3
- bound.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- move.d 0xfedaffff,r4
- move.d r4,r3
- bound.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- bound.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 f789
-
- moveq -1,r3
- moveq 2,r4
- bound.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- moveq 2,r3
- moveq -1,r4
- bound.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 2
-
- move.d 0xff,r4
- move.d r4,r3
- bound.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 ff
-
- move.d 0xfeda49ff,r4
- move.d r4,r3
- bound.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 ff
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- bound.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 89
-
- move.d 0xfeda4956,r3
- move.d 0xfeda4953,r4
- bound.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 feda4953
-
- move.d 0xfeda4962,r3
- move.d 0xfeda4963,r4
- bound.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 feda4962
-
- move.d 0xfeda4956,r3
- move.d 0,r4
- bound.d r4,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- move.d 0xfeda4956,r4
- move.d 0,r3
- bound.d r4,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_btst.s b/tests/tcg/cris/bare/check_btst.s
deleted file mode 100644
index 485deb2006..0000000000
--- a/tests/tcg/cris/bare/check_btst.s
+++ /dev/null
@@ -1,96 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 1111\n
-
- .include "testutils.inc"
- start
- clearf nzvc
- moveq -1,r3
- .if 1 ;..asm.arch.cris.v32
- .else
- setf vc
- .endif
- btstq 0,r3
- test_cc 1 0 0 0
-
- moveq 2,r3
- btstq 1,r3
- test_cc 1 0 0 0
-
- moveq 4,r3
- btstq 1,r3
- test_cc 0 1 0 0
-
- moveq -1,r3
- btstq 31,r3
- test_cc 1 0 0 0
-
- move.d 0x5a67f19f,r3
- btstq 12,r3
- test_cc 1 0 0 0
-
- move.d 0xda67f19f,r3
- move.d 29,r4
- btst r4,r3
- test_cc 0 0 0 0
-
- move.d 0xda67f19f,r3
- move.d 32,r4
- btst r4,r3
- test_cc 1 0 0 0
-
- move.d 0xda67f191,r3
- move.d 33,r4
- btst r4,r3
- test_cc 0 0 0 0
-
- moveq -1,r3
- moveq 0,r4
- btst r4,r3
- test_cc 1 0 0 0
-
- moveq 2,r3
- moveq 1,r4
- btst r4,r3
- test_cc 1 0 0 0
-
- moveq -1,r3
- moveq 31,r4
- btst r4,r3
- test_cc 1 0 0 0
-
- moveq 4,r3
- btstq 1,r3
- test_cc 0 1 0 0
-
- moveq -1,r3
- moveq 15,r4
- btst r4,r3
- test_cc 1 0 0 0
-
- move.d 0x5a67f19f,r3
- moveq 12,r4
- btst r4,r3
- test_cc 1 0 0 0
-
- move.d 0x5a678000,r3
- moveq 11,r4
- btst r4,r3
- test_cc 0 1 0 0
-
- move.d 0x5a67f19f,r3
- btst r3,r3
- test_cc 0 0 0 0
-
- move.d 0x1111,r3
- checkr3 1111
-
- ; check that X gets cleared and that only the NZ flags are touched.
- ;; move.d	0xff, $r0
- ;; move $r0, $ccs
- ;; btst r3,r3
- ;; move $ccs, $r0
- ;; and.d 0xff, $r0
- ;; cmp.d	0xe3, $r0
- ;; test_cc 0 1 0 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_clearfv32.s b/tests/tcg/cris/bare/check_clearfv32.s
deleted file mode 100644
index 4e91360273..0000000000
--- a/tests/tcg/cris/bare/check_clearfv32.s
+++ /dev/null
@@ -1,19 +0,0 @@
-# mach: crisv32
-# output: ef\nef\n
-
-; Check that "clearf x" doesn't trivially fail.
-
- .include "testutils.inc"
- start
- setf puixnzvc
- clearf x	; Actually, x would be cleared by almost-all other insns.
- move ccs,r3
- and.d 0xff, $r3
- checkr3 ef
-
- setf puixnzvc
- moveq 0, $r3	; moveq should only clear the xflag.
- move ccs,r3
- and.d 0xff, $r3
- checkr3 ef
- quit
diff --git a/tests/tcg/cris/bare/check_clrjmp1.s b/tests/tcg/cris/bare/check_clrjmp1.s
deleted file mode 100644
index 45a7005e24..0000000000
--- a/tests/tcg/cris/bare/check_clrjmp1.s
+++ /dev/null
@@ -1,36 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: ffffff00\n
-
-; A bug resulting in a non-effectual clear.b discovered running the GCC
-; testsuite; jump actually wrote to p0.
-
- .include "testutils.inc"
-
- start
- jump 1f
- nop
- .p2align 8
-1:
- move.d y,r4
-
- .if 0 ;0 == ..asm.arch.cris.v32
-; There was a bug causing this insn to set special register p0
-; (byte-clear) to 8 (low 8 bits of location after insn).
- jump [r4+]
- .endif
-
-1:
- move.d 0f,r4
-
-; The corresponding bug would cause this insn too, to set p0.
- jump r4
- nop
- quit
-0:
- moveq -1,r3
- clear.b r3
- checkr3 ffffff00
- quit
-
-y:
- .dword 1b
diff --git a/tests/tcg/cris/bare/check_cmp-2.s b/tests/tcg/cris/bare/check_cmp-2.s
deleted file mode 100644
index 414d370517..0000000000
--- a/tests/tcg/cris/bare/check_cmp-2.s
+++ /dev/null
@@ -1,15 +0,0 @@
-
-
-.include "testutils.inc"
-
-	start
-
-	move.d	4294967283, $r0
-	move.d	$r0, $r10
-	cmp.d	$r0, $r10
-	beq	1f
-	move.d $r10, $r3
-	fail
-1:
-	pass
-	quit
diff --git a/tests/tcg/cris/bare/check_cmpc.s b/tests/tcg/cris/bare/check_cmpc.s
deleted file mode 100644
index 267c9ba8c0..0000000000
--- a/tests/tcg/cris/bare/check_cmpc.s
+++ /dev/null
@@ -1,86 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: ffffffff\n2\nffff\nffffffff\n78134452\nffffffff\n2\nffff\nfedaffff\n78134452\nffffffff\n2\nff\nfeda49ff\n78134452\n85649282\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- cmp.d -2,r3
- test_cc 0 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- cmp.d 1,r3
- test_cc 0 0 0 0
- checkr3 2
-
- move.d 0xffff,r3
- cmp.d -0xffff,r3
- test_cc 0 0 0 1
- checkr3 ffff
-
- moveq -1,r3
- cmp.d 1,r3
- test_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x78134452,r3
- cmp.d -0x5432f789,r3
- test_cc 1 0 1 1
- checkr3 78134452
-
- moveq -1,r3
- cmp.w -2,r3
- test_cc 0 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- cmp.w 1,r3
- test_cc 0 0 0 0
- checkr3 2
-
- move.d 0xffff,r3
- cmp.w 1,r3
- test_cc 1 0 0 0
- checkr3 ffff
-
- move.d 0xfedaffff,r3
- cmp.w 1,r3
- test_cc 1 0 0 0
- checkr3 fedaffff
-
- move.d 0x78134452,r3
- cmp.w 0x877,r3
- test_cc 0 0 0 0
- checkr3 78134452
-
- moveq -1,r3
- cmp.b -2,r3
- test_cc 0 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- cmp.b 1,r3
- test_cc 0 0 0 0
- checkr3 2
-
- move.d 0xff,r3
- cmp.b 1,r3
- test_cc 1 0 0 0
- checkr3 ff
-
- move.d 0xfeda49ff,r3
- cmp.b 1,r3
- test_cc 1 0 0 0
- checkr3 feda49ff
-
- move.d 0x78134452,r3
- cmp.b 0x77,r3
- test_cc 1 0 0 1
- checkr3 78134452
-
- move.d 0x85649282,r3
- cmp.b 0x82,r3
- test_cc 0 1 0 0
- checkr3 85649282
-
- quit
diff --git a/tests/tcg/cris/bare/check_cmpm.s b/tests/tcg/cris/bare/check_cmpm.s
deleted file mode 100644
index e4dde15b32..0000000000
--- a/tests/tcg/cris/bare/check_cmpm.s
+++ /dev/null
@@ -1,96 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: ffffffff\n2\nffff\nffffffff\n78134452\nffffffff\n2\nffff\nfedaffff\n78134452\nffffffff\n2\nff\nfeda49ff\n78134452\n85649222\n
-
- .include "testutils.inc"
- .data
-x:
- .dword -2,1,-0xffff,1,-0x5432f789
- .word -2,1,1,0x877
- .byte -2,1,0x77
- .byte 0x22
-
- start
- moveq -1,r3
- move.d x,r5
- cmp.d [r5+],r3
- test_cc 0 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- cmp.d [r5],r3
- test_cc 0 0 0 0
- addq 4,r5
- checkr3 2
-
- move.d 0xffff,r3
- cmp.d [r5+],r3
- test_cc 0 0 0 1
- checkr3 ffff
-
- moveq -1,r3
- cmp.d [r5+],r3
- test_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x78134452,r3
- cmp.d [r5+],r3
- test_cc 1 0 1 1
- checkr3 78134452
-
- moveq -1,r3
- cmp.w [r5+],r3
- test_cc 0 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- cmp.w [r5+],r3
- test_cc 0 0 0 0
- checkr3 2
-
- move.d 0xffff,r3
- cmp.w [r5],r3
- test_cc 1 0 0 0
- checkr3 ffff
-
- move.d 0xfedaffff,r3
- cmp.w [r5+],r3
- test_cc 1 0 0 0
- checkr3 fedaffff
-
- move.d 0x78134452,r3
- cmp.w [r5+],r3
- test_cc 0 0 0 0
- checkr3 78134452
-
- moveq -1,r3
- cmp.b [r5],r3
- test_cc 0 0 0 0
- addq 1,r5
- checkr3 ffffffff
-
- moveq 2,r3
- cmp.b [r5],r3
- test_cc 0 0 0 0
- checkr3 2
-
- move.d 0xff,r3
- cmp.b [r5],r3
- test_cc 1 0 0 0
- checkr3 ff
-
- move.d 0xfeda49ff,r3
- cmp.b [r5+],r3
- test_cc 1 0 0 0
- checkr3 feda49ff
-
- move.d 0x78134452,r3
- cmp.b [r5+],r3
- test_cc 1 0 0 1
- checkr3 78134452
-
- move.d 0x85649222,r3
- cmp.b [r5],r3
- test_cc 0 1 0 0
- checkr3 85649222
-
- quit
diff --git a/tests/tcg/cris/bare/check_cmpq.s b/tests/tcg/cris/bare/check_cmpq.s
deleted file mode 100644
index 5469141c91..0000000000
--- a/tests/tcg/cris/bare/check_cmpq.s
+++ /dev/null
@@ -1,75 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: 1\n1\n1\n1f\n1f\nffffffe1\nffffffe1\nffffffe0\n0\n0\nffffffff\nffffffff\n10000\n100\n5678900\n
-
- .include "testutils.inc"
- start
- moveq 1,r3
- cmpq 1,r3
- test_cc 0 1 0 0
- checkr3 1
-
- cmpq -1,r3
- test_cc 0 0 0 1
- checkr3 1
-
- cmpq 31,r3
- test_cc 1 0 0 1
- checkr3 1
-
- moveq 31,r3
- cmpq 31,r3
- test_cc 0 1 0 0
- checkr3 1f
-
- cmpq -31,r3
- test_cc 0 0 0 1
- checkr3 1f
-
- movs.b -31,r3
- cmpq -31,r3
- test_cc 0 1 0 0
- checkr3 ffffffe1
-
- cmpq -32,r3
- test_cc 0 0 0 0
- checkr3 ffffffe1
-
- movs.b -32,r3
- cmpq -32,r3
- test_cc 0 1 0 0
- checkr3 ffffffe0
-
- moveq 0,r3
- cmpq 1,r3
- test_cc 1 0 0 1
- checkr3 0
-
- cmpq -32,r3
- test_cc 0 0 0 1
- checkr3 0
-
- moveq -1,r3
- cmpq 1,r3
- test_cc 1 0 0 0
- checkr3 ffffffff
-
- cmpq -1,r3
- test_cc 0 1 0 0
- checkr3 ffffffff
-
- move.d 0x10000,r3
- cmpq 1,r3
- test_cc 0 0 0 0
- checkr3 10000
-
- move.d 0x100,r3
- cmpq 1,r3
- test_cc 0 0 0 0
- checkr3 100
-
- move.d 0x5678900,r3
- cmpq 7,r3
- test_cc 0 0 0 0
- checkr3 5678900
-
- quit
diff --git a/tests/tcg/cris/bare/check_cmpr.s b/tests/tcg/cris/bare/check_cmpr.s
deleted file mode 100644
index b30af7a538..0000000000
--- a/tests/tcg/cris/bare/check_cmpr.s
+++ /dev/null
@@ -1,102 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: ffffffff\n2\nffff\nffffffff\n78134452\nffffffff\n2\nffff\nfedaffff\n78134452\nffffffff\n2\nff\nfeda49ff\n78134452\n85649222\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- moveq -2,r4
- cmp.d r4,r3
- test_cc 0 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- moveq 1,r4
- cmp.d r4,r3
- test_cc 0 0 0 0
- checkr3 2
-
- move.d 0xffff,r3
- move.d -0xffff,r4
- cmp.d r4,r3
- test_cc 0 0 0 1
- checkr3 ffff
-
- moveq 1,r4
- moveq -1,r3
- cmp.d r4,r3
- test_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d -0x5432f789,r4
- move.d 0x78134452,r3
- cmp.d r4,r3
- test_cc 1 0 1 1
- checkr3 78134452
-
- moveq -1,r3
- moveq -2,r4
- cmp.w r4,r3
- test_cc 0 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- moveq 1,r4
- cmp.w r4,r3
- test_cc 0 0 0 0
- checkr3 2
-
- move.d 0xffff,r3
- move.d -0xffff,r4
- cmp.w r4,r3
- test_cc 1 0 0 0
- checkr3 ffff
-
- move.d 0xfedaffff,r3
- move.d -0xfedaffff,r4
- cmp.w r4,r3
- test_cc 1 0 0 0
- checkr3 fedaffff
-
- move.d -0x5432f789,r4
- move.d 0x78134452,r3
- cmp.w r4,r3
- test_cc 0 0 0 0
- checkr3 78134452
-
- moveq -1,r3
- moveq -2,r4
- cmp.b r4,r3
- test_cc 0 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- moveq 1,r4
- cmp.b r4,r3
- test_cc 0 0 0 0
- checkr3 2
-
- move.d -0xff,r4
- move.d 0xff,r3
- cmp.b r4,r3
- test_cc 1 0 0 0
- checkr3 ff
-
- move.d -0xfeda49ff,r4
- move.d 0xfeda49ff,r3
- cmp.b r4,r3
- test_cc 1 0 0 0
- checkr3 feda49ff
-
- move.d -0x5432f789,r4
- move.d 0x78134452,r3
- cmp.b r4,r3
- test_cc 1 0 0 1
- checkr3 78134452
-
- move.d 0x85649222,r3
- move.d 0x77445622,r4
- cmp.b r4,r3
- test_cc 0 1 0 0
- checkr3 85649222
-
- quit
diff --git a/tests/tcg/cris/bare/check_cmpxc.s b/tests/tcg/cris/bare/check_cmpxc.s
deleted file mode 100644
index b237a93175..0000000000
--- a/tests/tcg/cris/bare/check_cmpxc.s
+++ /dev/null
@@ -1,92 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 2\n2\n2\n2\nffff\nffff\nffff\nffff\nffffffff\nffffffff\nffffffff\n78134452\n78134452\n78134452\n78134452\n4452\n80000032\n
-
- .include "testutils.inc"
- start
- moveq 2,r3
- cmps.b 0xff,r3
- test_cc 0 0 0 1
- checkr3 2
-
- moveq 2,r3
- cmps.w 0xffff,r3
- test_cc 0 0 0 1
- checkr3 2
-
- moveq 2,r3
- cmpu.b 0xff,r3
- test_cc 1 0 0 1
- checkr3 2
-
- moveq 2,r3
- move.d 0xffffffff,r4
- cmpu.w -1,r3
- test_cc 1 0 0 1
- checkr3 2
-
- move.d 0xffff,r3
- cmpu.b -1,r3
- test_cc 0 0 0 0
- checkr3 ffff
-
- move.d 0xffff,r3
- cmpu.w -1,r3
- test_cc 0 1 0 0
- checkr3 ffff
-
- move.d 0xffff,r3
- cmps.b 0xff,r3
- test_cc 0 0 0 1
- checkr3 ffff
-
- move.d 0xffff,r3
- cmps.w 0xffff,r3
- test_cc 0 0 0 1
- checkr3 ffff
-
- moveq -1,r3
- cmps.b 0xff,r3
- test_cc 0 1 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- cmps.w 0xff,r3
- test_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- cmps.w 0xffff,r3
- test_cc 0 1 0 0
- checkr3 ffffffff
-
- move.d 0x78134452,r3
- cmpu.b 0x89,r3
- test_cc 0 0 0 0
- checkr3 78134452
-
- move.d 0x78134452,r3
- cmps.b 0x89,r3
- test_cc 0 0 0 1
- checkr3 78134452
-
- move.d 0x78134452,r3
- cmpu.w 0xf789,r3
- test_cc 0 0 0 0
- checkr3 78134452
-
- move.d 0x78134452,r3
- cmps.w 0xf789,r3
- test_cc 0 0 0 1
- checkr3 78134452
-
- move.d 0x4452,r3
- cmps.w 0x8002,r3
- test_cc 0 0 0 1
- checkr3 4452
-
- move.d 0x80000032,r3
- cmpu.w 0x764,r3
- test_cc 0 0 1 0
- checkr3 80000032
-
- quit
diff --git a/tests/tcg/cris/bare/check_cmpxm.s b/tests/tcg/cris/bare/check_cmpxm.s
deleted file mode 100644
index 87ea5bf8e3..0000000000
--- a/tests/tcg/cris/bare/check_cmpxm.s
+++ /dev/null
@@ -1,106 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 2\n2\n2\n2\nffff\nffff\nffff\nffff\nffffffff\nffffffff\nffffffff\n78134452\n78134452\n78134452\n78134452\n4452\n80000032\n
-
- .include "testutils.inc"
- .data
-x:
- .byte 0xff
- .word 0xffff
- .word 0xff
- .word 0xffff
- .byte 0x89
- .word 0xf789
- .word 0x8002
- .word 0x764
-
- start
- moveq 2,r3
- move.d x,r5
- cmps.b [r5+],r3
- test_cc 0 0 0 1
- checkr3 2
-
- moveq 2,r3
- cmps.w [r5+],r3
- test_cc 0 0 0 1
- checkr3 2
-
- moveq 2,r3
- subq 3,r5
- cmpu.b [r5+],r3
- test_cc 1 0 0 1
- checkr3 2
-
- moveq 2,r3
- cmpu.w [r5+],r3
- test_cc 1 0 0 1
- subq 3,r5
- checkr3 2
-
- move.d 0xffff,r3
- cmpu.b [r5],r3
- test_cc 0 0 0 0
- checkr3 ffff
-
- move.d 0xffff,r3
- cmpu.w [r5],r3
- test_cc 0 1 0 0
- checkr3 ffff
-
- move.d 0xffff,r3
- cmps.b [r5],r3
- test_cc 0 0 0 1
- checkr3 ffff
-
- move.d 0xffff,r3
- cmps.w [r5],r3
- test_cc 0 0 0 1
- checkr3 ffff
-
- moveq -1,r3
- cmps.b [r5],r3
- test_cc 0 1 0 0
- addq 3,r5
- checkr3 ffffffff
-
- moveq -1,r3
- cmps.w [r5+],r3
- test_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- cmps.w [r5+],r3
- test_cc 0 1 0 0
- checkr3 ffffffff
-
- move.d 0x78134452,r3
- cmpu.b [r5],r3
- test_cc 0 0 0 0
- checkr3 78134452
-
- move.d 0x78134452,r3
- cmps.b [r5+],r3
- test_cc 0 0 0 1
- checkr3 78134452
-
- move.d 0x78134452,r3
- cmpu.w [r5],r3
- test_cc 0 0 0 0
- checkr3 78134452
-
- move.d 0x78134452,r3
- cmps.w [r5+],r3
- test_cc 0 0 0 1
- checkr3 78134452
-
- move.d 0x4452,r3
- cmps.w [r5+],r3
- test_cc 0 0 0 1
- checkr3 4452
-
- move.d 0x80000032,r3
- cmpu.w [r5+],r3
- test_cc 0 0 1 0
- checkr3 80000032
-
- quit
diff --git a/tests/tcg/cris/bare/check_dstep.s b/tests/tcg/cris/bare/check_dstep.s
deleted file mode 100644
index bd43b838ea..0000000000
--- a/tests/tcg/cris/bare/check_dstep.s
+++ /dev/null
@@ -1,42 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: fffffffc\n4\nffff\nfffffffe\n9bf3911b\n0\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- moveq 2,r4
- dstep r4,r3
- test_move_cc 1 0 0 0
- checkr3 fffffffc
-
- moveq 2,r3
- moveq -1,r4
- dstep r4,r3
- test_move_cc 0 0 0 0
- checkr3 4
-
- move.d 0xffff,r4
- move.d r4,r3
- dstep r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- moveq -1,r4
- move.d r4,r3
- dstep r4,r3
- test_move_cc 1 0 0 0
- checkr3 fffffffe
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- dstep r4,r3
- test_move_cc 1 0 0 0
- checkr3 9bf3911b
-
- move.d 0xffff,r3
- move.d 0x1fffe,r4
- dstep r4,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_jsr.s b/tests/tcg/cris/bare/check_jsr.s
deleted file mode 100644
index 1060237873..0000000000
--- a/tests/tcg/cris/bare/check_jsr.s
+++ /dev/null
@@ -1,85 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: 0\n0\n0\n0\n0\n0\n
-
-# Test that jsr Rn and jsr [PC+] work.
-
- .include "testutils.inc"
- start
-x:
- move.d 0f,r6
- setf nzvc
- jsr r6
- .if 1; ..asm.arch.cris.v32
- nop
- .endif
-0:
- test_move_cc 1 1 1 1
- move srp,r3
- sub.d 0b,r3
- checkr3 0
-
- move.d 1f,r0
- setf nzvc
- jsr r0
- .if 1 ; ..asm.arch.cris.v32
- moveq 0,r0
- .endif
-6:
- nop
- quit
-
-2:
- test_move_cc 0 0 0 0
- move srp,r3
- sub.d 3f,r3
- checkr3 0
- jsr 4f
- .if 1 ; ..asm.arch.cris.v32
- nop
- .endif
-7:
- nop
- quit
-
-8:
- move srp,r3
- sub.d 7b,r3
- checkr3 0
- quit
-
-4:
- move srp,r3
- sub.d 7b,r3
- checkr3 0
- move.d 5f,r3
- jump r3
- .if 1; ..asm.arch.cris.v32
- moveq 0,r3
- .endif
- quit
-
- .space 32770,0
-1:
- test_move_cc 1 1 1 1
- move srp,r3
- sub.d 6b,r3
- checkr3 0
-
- clearf cznv
- jsr 2b
- .if 1; ..asm.arch.cris.v32
- nop
- .endif
-3:
-
- quit
-
-5:
- move srp,r3
- sub.d 7b,r3
- checkr3 0
- jump 8b
- .if 1 ; ..asm.arch.cris.v32
- nop
- .endif
- quit
diff --git a/tests/tcg/cris/bare/check_lapc.s b/tests/tcg/cris/bare/check_lapc.s
deleted file mode 100644
index 9a6150b749..0000000000
--- a/tests/tcg/cris/bare/check_lapc.s
+++ /dev/null
@@ -1,78 +0,0 @@
-# mach: crisv32
-# output: 0\n0\nfffffffa\nfffffffe\nffffffda\n1e\n1e\n0\n
-
-.include "testutils.inc"
-
-; To accommodate dumpr3 with more than one instruction, keep it
-; out of lapc operand ranges and difference calculations.
-
- start
- lapc.d 0f,r3
-0:
- sub.d .,r3
- checkr3 0
-
- lapcq 0f,r3
-0:
- sub.d .,r3
- checkr3 0
-
- lapc.d .,r3
- sub.d .,r3
- checkr3 fffffffa
-
- lapcq .,r3
- sub.d .,r3
- checkr3 fffffffe
-
-0:
- .rept 16
- nop
- .endr
- lapc.d 0b,r3
- sub.d .,r3
- checkr3 ffffffda
-
- setf zcvn
- lapc.d 0f,r3
- test_cc 1 1 1 1
- sub.d .,r3
- nop
- nop
- nop
- nop
- nop
- nop
- nop
- nop
- nop
- nop
- nop
- nop
-0:
- checkr3 1e
-0:
- lapcq 0f,r3
- sub.d 0b,r3
- nop
- nop
- nop
- nop
- nop
- nop
- nop
- nop
- nop
- nop
- nop
-0:
- checkr3 1e
- clearf cn
- setf zv
-1:
- lapcq .,r3
- test_cc 0 1 1 0
- sub.d 1b,r3
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_lsl.s b/tests/tcg/cris/bare/check_lsl.s
deleted file mode 100644
index 9e2ddd7cd0..0000000000
--- a/tests/tcg/cris/bare/check_lsl.s
+++ /dev/null
@@ -1,217 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: ffffffff\n4\n80000000\nffff8000\n7f19f000\n80000000\n0\n0\n699fc67c\nffffffff\n4\n80000000\nffff8000\n7f19f000\nda670000\nda670000\nda670000\nda67c67c\nffffffff\nfffafffe\n4\nffff0000\nffff8000\n5a67f000\nda67f100\nda67f100\nda67f100\nda67f17c\nfff3faff\nfff3fafe\n4\nffffff00\nffffff00\nffffff80\n5a67f100\n5a67f1f0\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- lslq 0,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- lslq 1,r3
- test_move_cc 0 0 0 0
- checkr3 4
-
- moveq -1,r3
- lslq 31,r3
- test_move_cc 1 0 0 0
- checkr3 80000000
-
- moveq -1,r3
- lslq 15,r3
- test_move_cc 1 0 0 0
- checkr3 ffff8000
-
- move.d 0x5a67f19f,r3
- lslq 12,r3
- test_move_cc 0 0 0 0
- checkr3 7f19f000
-
- move.d 0xda67f19f,r3
- move.d 31,r4
- lsl.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 80000000
-
- move.d 0xda67f19f,r3
- move.d 32,r4
- lsl.d r4,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- move.d 0xda67f19f,r3
- move.d 33,r4
- lsl.d r4,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- move.d 0xda67f19f,r3
- move.d 66,r4
- lsl.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 699fc67c
-
- moveq -1,r3
- moveq 0,r4
- lsl.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- moveq 1,r4
- lsl.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 4
-
- moveq -1,r3
- moveq 31,r4
- lsl.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 80000000
-
- moveq -1,r3
- moveq 15,r4
- lsl.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffff8000
-
- move.d 0x5a67f19f,r3
- moveq 12,r4
- lsl.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 7f19f000
-
- move.d 0xda67f19f,r3
- move.d 31,r4
- lsl.w r4,r3
- test_move_cc 0 1 0 0
- checkr3 da670000
-
- move.d 0xda67f19f,r3
- move.d 32,r4
- lsl.w r4,r3
- test_move_cc 0 1 0 0
- checkr3 da670000
-
- move.d 0xda67f19f,r3
- move.d 33,r4
- lsl.w r4,r3
- test_move_cc 0 1 0 0
- checkr3 da670000
-
- move.d 0xda67f19f,r3
- move.d 66,r4
- lsl.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 da67c67c
-
- moveq -1,r3
- moveq 0,r4
- lsl.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0xfffaffff,r3
- moveq 1,r4
- lsl.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 fffafffe
-
- moveq 2,r3
- moveq 1,r4
- lsl.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 4
-
- moveq -1,r3
- moveq 31,r4
- lsl.w r4,r3
- test_move_cc 0 1 0 0
- checkr3 ffff0000
-
- moveq -1,r3
- moveq 15,r4
- lsl.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffff8000
-
- move.d 0x5a67f19f,r3
- moveq 12,r4
- lsl.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 5a67f000
-
- move.d 0xda67f19f,r3
- move.d 31,r4
- lsl.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 da67f100
-
- move.d 0xda67f19f,r3
- move.d 32,r4
- lsl.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 da67f100
-
- move.d 0xda67f19f,r3
- move.d 33,r4
- lsl.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 da67f100
-
- move.d 0xda67f19f,r3
- move.d 66,r4
- lsl.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 da67f17c
-
- move.d 0xfff3faff,r3
- moveq 0,r4
- lsl.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 fff3faff
-
- move.d 0xfff3faff,r3
- moveq 1,r4
- lsl.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 fff3fafe
-
- moveq 2,r3
- moveq 1,r4
- lsl.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 4
-
- moveq -1,r3
- moveq 31,r4
- lsl.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 ffffff00
-
- moveq -1,r3
- moveq 15,r4
- lsl.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 ffffff00
-
- moveq -1,r3
- moveq 7,r4
- lsl.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffff80
-
- move.d 0x5a67f19f,r3
- moveq 12,r4
- lsl.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 5a67f100
-
- move.d 0x5a67f19f,r3
- moveq 4,r4
- lsl.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 5a67f1f0
-
- quit
diff --git a/tests/tcg/cris/bare/check_lsr.s b/tests/tcg/cris/bare/check_lsr.s
deleted file mode 100644
index 18fdbef9b2..0000000000
--- a/tests/tcg/cris/bare/check_lsr.s
+++ /dev/null
@@ -1,218 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: ffffffff\n1\n1\n1ffff\n5a67f\n1\n0\n0\n3699fc67\nffffffff\n1\n1\n1ffff\n5a67f\nda670000\nda670000\nda670000\nda673c67\nffffffff\nffff7fff\n1\nffff0000\nffff0001\n5a67000f\nda67f100\nda67f100\nda67f100\nda67f127\nffffffff\nffffff7f\n1\nffffff00\nffffff00\nffffff01\n5a67f100\n5a67f109\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- lsrq 0,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- lsrq 1,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
- moveq -1,r3
- lsrq 31,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
- moveq -1,r3
- lsrq 15,r3
- test_move_cc 0 0 0 0
- checkr3 1ffff
-
- move.d 0x5a67f19f,r3
- lsrq 12,r3
- test_move_cc 0 0 0 0
- checkr3 5a67f
-
- move.d 0xda67f19f,r3
- move.d 31,r4
- lsr.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
- move.d 0xda67f19f,r3
- move.d 32,r4
- lsr.d r4,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- move.d 0xda67f19f,r3
- move.d 33,r4
- lsr.d r4,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- move.d 0xda67f19f,r3
- move.d 66,r4
- lsr.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 3699fc67
-
- moveq -1,r3
- moveq 0,r4
- lsr.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq 2,r3
- moveq 1,r4
- lsr.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
- moveq -1,r3
- moveq 31,r4
- lsr.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
- moveq -1,r3
- moveq 15,r4
- lsr.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 1ffff
-
- move.d 0x5a67f19f,r3
- moveq 12,r4
- lsr.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 5a67f
-
- move.d 0xda67f19f,r3
- move.d 31,r4
- lsr.w r4,r3
- test_move_cc 0 1 0 0
- checkr3 da670000
-
- move.d 0xda67f19f,r3
- move.d 32,r4
- lsr.w r4,r3
- test_move_cc 0 1 0 0
- checkr3 da670000
-
- move.d 0xda67f19f,r3
- move.d 33,r4
- lsr.w r4,r3
- test_move_cc 0 1 0 0
- checkr3 da670000
-
- move.d 0xda67f19f,r3
- move.d 66,r4
- lsr.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 da673c67
-
- moveq -1,r3
- moveq 0,r4
- lsr.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 1,r4
- lsr.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffff7fff
-
- moveq 2,r3
- moveq 1,r4
- lsr.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
-;; FIXME: this was wrong. Z should be set.
- moveq -1,r3
- moveq 31,r4
- lsr.w r4,r3
- test_move_cc 0 1 0 0
- checkr3 ffff0000
-
- moveq -1,r3
- moveq 15,r4
- lsr.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffff0001
-
- move.d 0x5a67f19f,r3
- moveq 12,r4
- lsr.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 5a67000f
-
- move.d 0xda67f19f,r3
- move.d 31,r4
- lsr.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 da67f100
-
- move.d 0xda67f19f,r3
- move.d 32,r4
- lsr.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 da67f100
-
- move.d 0xda67f19f,r3
- move.d 33,r4
- lsr.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 da67f100
-
- move.d 0xda67f19f,r3
- move.d 66,r4
- lsr.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 da67f127
-
- moveq -1,r3
- moveq 0,r4
- lsr.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 1,r4
- lsr.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffffff7f
-
- moveq 2,r3
- moveq 1,r4
- lsr.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
- moveq -1,r3
- moveq 31,r4
- lsr.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 ffffff00
-
- moveq -1,r3
- moveq 15,r4
- lsr.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 ffffff00
-
- moveq -1,r3
- moveq 7,r4
- lsr.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffffff01
-
- move.d 0x5a67f19f,r3
- moveq 12,r4
- lsr.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 5a67f100
-
- move.d 0x5a67f19f,r3
- moveq 4,r4
- lsr.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 5a67f109
-
- quit
diff --git a/tests/tcg/cris/bare/check_mcp.s b/tests/tcg/cris/bare/check_mcp.s
deleted file mode 100644
index e65ccddfd4..0000000000
--- a/tests/tcg/cris/bare/check_mcp.s
+++ /dev/null
@@ -1,49 +0,0 @@
-# mach: crisv32
-# output: fffffffe\n1\n1ffff\nfffffffe\ncc463bdc\n4c463bdc\n0\n
-
- .include "testutils.inc"
- start
-
-; Set R, clear C.
- move 0x100,ccs
- moveq -5,r3
- move 2,mof
- mcp mof,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
-
- moveq 2,r3
- move -1,srp
- mcp srp,r3
- test_cc 0 0 0 0
- checkr3 1
-
- move 0xffff,srp
- move srp,r3
- mcp srp,r3
- test_cc 0 0 0 0
- checkr3 1ffff
-
- move -1,mof
- move mof,r3
- mcp mof,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
-
- move 0x5432f789,mof
- move.d 0x78134452,r3
- mcp mof,r3
- test_cc 1 0 1 0
- checkr3 cc463bdc
-
- move 0x80000000,srp
- mcp srp,r3
- test_cc 0 0 1 0
- checkr3 4c463bdc
-
- move 0xb3b9c423,srp
- mcp srp,r3
- test_cc 0 1 0 0
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_movdelsr1.s b/tests/tcg/cris/bare/check_movdelsr1.s
deleted file mode 100644
index 300cc87742..0000000000
--- a/tests/tcg/cris/bare/check_movdelsr1.s
+++ /dev/null
@@ -1,33 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: aa117acd\n
-# output: eeaabb42\n
-
-; Bug with move to special register in delay slot, due to
-; special flush-insn-cache simulator use.  Ordinary move worked;
-; special register caused branch to fail.
-
- .include "testutils.inc"
- start
- move -1,srp
-
- move.d 0xaa117acd,r1
- moveq 3,r9
- cmpq 1,r9
- bhi 0f
- move.d r1,r3
-
- fail
-0:
- checkr3 aa117acd
-
- move.d 0xeeaabb42,r1
- moveq 3,r9
- cmpq 1,r9
- bhi 0f
- move r1,srp
-
- fail
-0:
- move srp,r3
- checkr3 eeaabb42
- quit
diff --git a/tests/tcg/cris/bare/check_movecr.s b/tests/tcg/cris/bare/check_movecr.s
deleted file mode 100644
index da8ec26284..0000000000
--- a/tests/tcg/cris/bare/check_movecr.s
+++ /dev/null
@@ -1,37 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: ffffff42\n94\nffff4321\n9234\n76543210\n76540000\n
-
-; Move constant byte, word, dword to register.  Check that no extension is
-; performed, that only part of the register is set.
-
- .include "testutils.inc"
- startnostack
- moveq -1,r3
- move.b 0x42,r3
- test_move_cc 0 0 0 0
- checkr3 ffffff42
-
- moveq 0,r3
- move.b 0x94,r3
- test_move_cc 1 0 0 0
- checkr3 94
-
- moveq -1,r3
- move.w 0x4321,r3
- test_move_cc 0 0 0 0
- checkr3 ffff4321
-
- moveq 0,r3
- move.w 0x9234,r3
- test_move_cc 1 0 0 0
- checkr3 9234
-
- move.d 0x76543210,r3
- test_move_cc 0 0 0 0
- checkr3 76543210
-
- move.w 0,r3
- test_move_cc 0 1 0 0
- checkr3 76540000
-
- quit
diff --git a/tests/tcg/cris/bare/check_movei.s b/tests/tcg/cris/bare/check_movei.s
deleted file mode 100644
index bbfa633373..0000000000
--- a/tests/tcg/cris/bare/check_movei.s
+++ /dev/null
@@ -1,50 +0,0 @@
-# mach: crisv32
-# output: fffffffe\n
-# output: fffffffe\n
-
-; Check basic integral-write semantics regarding flags.
-
- .include "testutils.inc"
- start
-
- move.d 0, $r3	
-; A write that works.  Check that flags are set correspondingly.
- move.d d,r4
- ;; store to bring it into the tlb with the right prot bits
- move.d r3,[r4]
- moveq -2,r5
- setf c
- clearf p
- move.d [r4],r3
- ax
- move.d r5,[r4]
- move.d [r4],r3
-
- bcc 0f
- nop
- fail
-
-0:
- checkr3 fffffffe
-
-; A write that fails; check flags too.
- move.d d,r4
- moveq 23,r5
- setf p
- clearf c
- move.d [r4],r3
- ax
- move.d r5,[r4]
- move.d [r4],r3
-
- bcs 0f
- nop
- fail
-
-0:
- checkr3 fffffffe
- quit
-
- .data
-d:
- .dword 42424242
diff --git a/tests/tcg/cris/bare/check_movemr.s b/tests/tcg/cris/bare/check_movemr.s
deleted file mode 100644
index 88489dee31..0000000000
--- a/tests/tcg/cris/bare/check_movemr.s
+++ /dev/null
@@ -1,78 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: 12345678\n10234567\n12345678\n12344567\n12344523\n76543210\nffffffaa\naa\n9911\nffff9911\n78\n56\n3456\n6712\n
-
- .include "testutils.inc"
- start
-
- .data
-mem1:
- .dword 0x12345678
-mem2:
- .word 0x4567
-mem3:
- .byte 0x23
- .dword 0x76543210
- .byte 0xaa,0x11,0x99
-
- .text
- move.d mem1,r2
- move.d [r2],r3
- test_move_cc 0 0 0 0
- checkr3 12345678
-
- move.d mem2,r3
- move.d [r3],r3
- test_move_cc 0 0 0 0
- checkr3 10234567
-
- move.d mem1,r2
- move.d [r2+],r3
- test_move_cc 0 0 0 0
- checkr3 12345678
-
- move.w [r2+],r3
- test_move_cc 0 0 0 0
- checkr3 12344567
-
- move.b [r2+],r3
- test_move_cc 0 0 0 0
- checkr3 12344523
-
- move.d [r2+],r3
- test_move_cc 0 0 0 0
- checkr3 76543210
-
- movs.b [r2],r3
- test_move_cc 1 0 0 0
- checkr3 ffffffaa
-
- movu.b [r2+],r3
- test_move_cc 0 0 0 0
- checkr3 aa
-
- movu.w [r2],r3
- test_move_cc 0 0 0 0
- checkr3 9911
-
- movs.w [r2+],r3
- test_move_cc 1 0 0 0
- checkr3 ffff9911
-
- move.d mem1,r13
- movs.b [r13+],r3
- test_move_cc 0 0 0 0
- checkr3 78
-
- movu.b [r13],r3
- test_move_cc 0 0 0 0
- checkr3 56
-
- movs.w [r13+],r3
- test_move_cc 0 0 0 0
- checkr3 3456
-
- movu.w [r13+],r3
- test_move_cc 0 0 0 0
- checkr3 6712
-
- quit
diff --git a/tests/tcg/cris/bare/check_movemrv32.s b/tests/tcg/cris/bare/check_movemrv32.s
deleted file mode 100644
index 53950abd5b..0000000000
--- a/tests/tcg/cris/bare/check_movemrv32.s
+++ /dev/null
@@ -1,96 +0,0 @@
-# mach: crisv32
-# output: 15\n7\n2\nffff1234\nb\n16\nf\n2\nffffffef\nf\nffff1234\nf\nfffffff4\nd\nfffffff2\n10\nfffffff2\nd\n
-
- .include "testutils.inc"
- .data
-x:
- .dword 8,9,10,11
-y:
- .dword -12,13,-14,15,16
-
- start
- moveq 7,r0
- moveq 2,r1
- move.d 0xffff1234,r2
- moveq 21,r3
- move.d x,r4
- setf zcvn
- movem r2,[r4+]
- test_cc 1 1 1 1
- subq 12,r4
-
- checkr3 15
-
- move.d [r4+],r3
- checkr3 7
-
- move.d [r4+],r3
- checkr3 2
-
- move.d [r4+],r3
- checkr3 ffff1234
-
- move.d [r4+],r3
- checkr3 b
-
- subq 16,r4
- moveq 22,r0
- moveq 15,r1
- clearf zcvn
- movem r0,[r4]
- test_cc 0 0 0 0
- move.d [r4+],r3
- checkr3 16
-
- move.d r1,r3
- checkr3 f
-
- move.d [r4+],r3
- checkr3 2
-
- subq 8,r4
- moveq 10,r2
- moveq -17,r0
- clearf zc
- setf vn
- movem r1,[r4]
- test_cc 1 0 1 0
- move.d [r4+],r3
- checkr3 ffffffef
-
- move.d [r4+],r3
- checkr3 f
-
- move.d [r4+],r3
- checkr3 ffff1234
-
- move.d y,r4
- setf zc
- clearf vn
- movem [r4+],r3
- test_cc 0 1 0 1
- checkr3 f
-
- move.d r0,r3
- checkr3 fffffff4
-
- move.d r1,r3
- checkr3 d
-
- move.d r2,r3
- checkr3 fffffff2
-
- move.d [r4],r3
- checkr3 10
-
- subq 8,r4
- setf zcvn
- movem [r4+],r0
- test_cc 1 1 1 1
- move.d r0,r3
- checkr3 fffffff2
-
- move.d r1,r3
- checkr3 d
-
- quit
diff --git a/tests/tcg/cris/bare/check_mover.s b/tests/tcg/cris/bare/check_mover.s
deleted file mode 100644
index b4db595d64..0000000000
--- a/tests/tcg/cris/bare/check_mover.s
+++ /dev/null
@@ -1,28 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: ffffff05\nffff0005\n5\nffffff00\n
-
-; Move between registers.  Check that just the subreg is copied.
-
- .include "testutils.inc"
- startnostack
- moveq -30,r3
- moveq 5,r4
- move.b r4,r3
- test_move_cc 0 0 0 0  		; FIXME
- checkr3 ffffff05
-
- move.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffff0005
-
- move.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 5
-
- moveq -1,r3
- moveq 0,r4
- move.b r4,r3
- test_move_cc 0 1 0 0
- checkr3 ffffff00
-
- quit
diff --git a/tests/tcg/cris/bare/check_moverm.s b/tests/tcg/cris/bare/check_moverm.s
deleted file mode 100644
index eabc9588d4..0000000000
--- a/tests/tcg/cris/bare/check_moverm.s
+++ /dev/null
@@ -1,45 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: 7823fec2\n10231879\n102318fe\n
-
- .include "testutils.inc"
- start
-
- .data
-mem1:
- .dword 0x12345678
-mem2:
- .word 0x4567
-mem3:
- .byte 0x23
- .dword 0x76543210
- .byte 0xaa,0x11,0x99
-
- .text
- move.d mem1,r2
- move.d 0x7823fec2,r4
- setf nzvc
- move.d r4,[r2+]
- test_cc 1 1 1 1
- subq 4,r2
- move.d [r2],r3
- checkr3 7823fec2
-
- move.d mem2,r3
- move.d 0x45231879,r4
- clearf nzvc
- move.w r4,[r3]
- test_cc 0 0 0 0
- move.d [r3],r3
- checkr3 10231879
-
- move.d mem2,r2
- moveq -2,r4
- clearf nc
- setf zv
- move.b r4,[r2+]
- test_cc 0 1 1 0
- subq 1,r2
- move.d [r2],r3
- checkr3 102318fe
-
- quit
diff --git a/tests/tcg/cris/bare/check_movmp.s b/tests/tcg/cris/bare/check_movmp.s
deleted file mode 100644
index 7fc11f064d..0000000000
--- a/tests/tcg/cris/bare/check_movmp.s
+++ /dev/null
@@ -1,131 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: ffffff00\nffff0000\n0\nffffff00\nffff0000\n0\nffffff00\nffff0000\n0\nbb113344\n664433aa\ncc557788\nabcde012\nabcde000\n77880000\n0\n
-
-# Test generic "move Ps,[]" and "move [],Pd" insns; the ones with
-# functionality common to all models.
-
- .include "testutils.inc"
- start
-
- .data
-filler:
- .byte 0xaa
- .word 0x4433
- .dword 0x55778866
- .byte 0xcc
-
- .text
-; Test that writing to zero-registers is a nop
- .if 0
- ; We used to just ignore the writes, but now an error is emitted.  We
- ; keep the test-code but disabled, in case we need to change this again.
- move 0xaa,p0
- move 0x4433,p4
- move 0x55774433,p8
- .endif
-
- moveq -1,r3
- setf zcvn
- clear.b r3
- test_cc 1 1 1 1
- checkr3 ffffff00
-
- moveq -1,r3
- clearf zcvn
- clear.w r3
- test_cc 0 0 0 0
- checkr3 ffff0000
-
- moveq -1,r3
- clear.d r3
- checkr3 0
-
-; "Write" using ordinary memory references too.
- .if 0 ; See ".if 0" above.
- move.d filler,r6
- move [r6],p0
- move [r6],p4
- move [r6],p8
- .endif
-
-# ffffff00\nffff0000\n0\nffffff00\nffff0000\n0\nbb113344\n664433aa\ncc557788\nabcde012\nabcde000\n77880000\n0\n
-
- moveq -1,r3
- clear.b r3
- checkr3 ffffff00
-
- moveq -1,r3
- clear.w r3
- checkr3 ffff0000
-
- moveq -1,r3
- clear.d r3
- checkr3 0
-
-; And postincremented.
- .if 0 ; See ".if 0" above.
- move [r6+],p0
- move [r6+],p4
- move [r6+],p8
- .endif
-
-# ffffff00\nffff0000\n0\nbb113344\n664433aa\ncc557788\nabcde012\nabcde000\n77880000\n0\n
-
- moveq -1,r3
- clear.b r3
- checkr3 ffffff00
-
- moveq -1,r3
- clear.w r3
- checkr3 ffff0000
-
- moveq -1,r3
- clear.d r3
- checkr3 0
-
-; Now see that we can write to the registers too.
-# bb113344\n664433aa\ncc557788\nabcde012\nabcde000\n77880000\n0\n
-; [PC+]
- move.d filler,r9
- move 0xbb113344,srp
- move srp,r3
- checkr3 bb113344
-
-; [R+]
- move [r9+],srp
- move srp,r3
- checkr3 664433aa
-
-; [R]
- move [r9],srp
- move srp,r3
- checkr3 cc557788
-
-; And check writing to memory, clear and srp.
-
- move.d filler,r9
- move 0xabcde012,srp
- setf zcvn
- move srp,[r9+]
- test_cc 1 1 1 1
- subq 4,r9
- move.d [r9],r3
- checkr3 abcde012
-
- clearf zcvn
- clear.b [r9]
- test_cc 0 0 0 0
- move.d [r9],r3
- checkr3 abcde000
-
- addq 2,r9
- clear.w [r9+]
- subq 2,r9
- move.d [r9],r3
- checkr3 77880000
-
- clear.d [r9]
- move.d [r9],r3
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_movpmv32.s b/tests/tcg/cris/bare/check_movpmv32.s
deleted file mode 100644
index daf0970e4a..0000000000
--- a/tests/tcg/cris/bare/check_movpmv32.s
+++ /dev/null
@@ -1,35 +0,0 @@
-# mach: crisv32
-# output: 11223320\nbb113344\naa557711\n
-
-# Test v32-specific special registers.  FIXME: more registers.
-
- .include "testutils.inc"
- start
- .data
-store:
- .dword 0x11223344
- .dword 0x77665544
-
- .text
- moveq -1,r3
- move.d store,r4
- move vr,[r4]
- move [r4+],mof
- move mof,r3
- checkr3 11223320
-
- moveq -1,r3
- clearf zcvn
- move 0xbb113344,mof
- test_cc 0 0 0 0
- move mof,r3
- checkr3 bb113344
-
- setf zcvn
- move 0xaa557711,mof
- test_cc 1 1 1 1
- move mof,[r4]
- move.d [r4],r3
- checkr3 aa557711
-
- quit
diff --git a/tests/tcg/cris/bare/check_movpr.s b/tests/tcg/cris/bare/check_movpr.s
deleted file mode 100644
index eef9bdb4fb..0000000000
--- a/tests/tcg/cris/bare/check_movpr.s
+++ /dev/null
@@ -1,28 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: ffffff00\nffff0000\n0\nbb113344\n
-
-# Test generic "move Ps,Rd" and "move Rs,Pd" insns; the ones with
-# functionality common to all models.
-
- .include "testutils.inc"
- start
- moveq -1,r3
- clear.b r3
- checkr3 ffffff00
-
- moveq -1,r3
- clear.w r3
- checkr3 ffff0000
-
- moveq -1,r3
- clear.d r3
- checkr3 0
-
- moveq -1,r3
- move.d 0xbb113344,r4
- setf zcvn
- move r4,srp
- move srp,r3
- test_cc 1 1 1 1
- checkr3 bb113344
- quit
diff --git a/tests/tcg/cris/bare/check_movprv32.s b/tests/tcg/cris/bare/check_movprv32.s
deleted file mode 100644
index d0d90e1246..0000000000
--- a/tests/tcg/cris/bare/check_movprv32.s
+++ /dev/null
@@ -1,21 +0,0 @@
-# mach: crisv32
-# output: ffffff20\nbb113344\n
-
-# Test v32-specific special registers.  FIXME: more registers.
-
- .include "testutils.inc"
- start
- moveq -1,r3
- setf zcvn
- move vr,r3
- test_cc 1 1 1 1
- checkr3 ffffff20
-
- moveq -1,r3
- move.d 0xbb113344,r4
- clearf cvnz
- move r4,mof
- test_cc 0 0 0 0
- move mof,r3
- checkr3 bb113344
- quit
diff --git a/tests/tcg/cris/bare/check_movscr.s b/tests/tcg/cris/bare/check_movscr.s
deleted file mode 100644
index 53c8ce6b50..0000000000
--- a/tests/tcg/cris/bare/check_movscr.s
+++ /dev/null
@@ -1,29 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: 42\nffffff85\n7685\nffff8765\n0\n
-
-; Move constant byte, word, dword to register.  Check that sign-extension
-; is performed.
-
- .include "testutils.inc"
- start
- moveq -1,r3
- movs.b 0x42,r3
- checkr3 42
-
- movs.b 0x85,r3
- test_move_cc 1 0 0 0
- checkr3 ffffff85
-
- movs.w 0x7685,r3
- test_move_cc 0 0 0 0
- checkr3 7685
-
- movs.w 0x8765,r3
- test_move_cc 1 0 0 0
- checkr3 ffff8765
-
- movs.w 0,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_movsm.s b/tests/tcg/cris/bare/check_movsm.s
deleted file mode 100644
index 7074336e78..0000000000
--- a/tests/tcg/cris/bare/check_movsm.s
+++ /dev/null
@@ -1,44 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: 5\nfffffff5\n5\nfffffff5\n0\n
-
-; Movs between registers.  Check that sign-extension is performed and the
-; full register is set.
-
- .include "testutils.inc"
-
- .data
-x:
- .byte 5,-11
- .word 5,-11
- .word 0
-
- start
- move.d x,r5
-
- moveq -1,r3
- movs.b [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 5
-
- moveq 0,r3
- movs.b [r5],r3
- test_move_cc 1 0 0 0
- addq 1,r5
- checkr3 fffffff5
-
- moveq -1,r3
- movs.w [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 5
-
- moveq 0,r3
- movs.w [r5],r3
- test_move_cc 1 0 0 0
- addq 2,r5
- checkr3 fffffff5
-
- movs.w [r5],r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_movsr.s b/tests/tcg/cris/bare/check_movsr.s
deleted file mode 100644
index d1889a7a1b..0000000000
--- a/tests/tcg/cris/bare/check_movsr.s
+++ /dev/null
@@ -1,46 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: 5\nfffffff5\n5\nfffffff5\n0\n
-
-; Movs between registers.  Check that sign-extension is performed and the
-; full register is set.
-
- .include "testutils.inc"
- start
- moveq -1,r5
- moveq 5,r4
- move.b r4,r5
- moveq -1,r3
- movs.b r5,r3
- test_move_cc 0 0 0 0
- checkr3 5
-
- moveq 0,r5
- moveq -11,r4
- move.b r4,r5
- moveq 0,r3
- movs.b r5,r3
- test_move_cc 1 0 0 0
- checkr3 fffffff5
-
- moveq -1,r5
- moveq 5,r4
- move.w r4,r5
- moveq -1,r3
- movs.w r5,r3
- test_move_cc 0 0 0 0
- checkr3 5
-
- moveq 0,r5
- moveq -11,r4
- move.w r4,r5
- moveq 0,r3
- movs.w r5,r3
- test_move_cc 1 0 0 0
- checkr3 fffffff5
-
- moveq 0,r5
- movs.b r5,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_movucr.s b/tests/tcg/cris/bare/check_movucr.s
deleted file mode 100644
index 7c8487d1a2..0000000000
--- a/tests/tcg/cris/bare/check_movucr.s
+++ /dev/null
@@ -1,33 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: 42\n85\n7685\n8765\n0\n
-
-; Move constant byte, word, dword to register.  Check that zero-extension
-; is performed.
-
- .include "testutils.inc"
- start
- moveq -1,r3
- movu.b 0x42,r3
- test_move_cc 0 0 0 0
- checkr3 42
-
- moveq -1,r3
- movu.b 0x85,r3
- test_move_cc 0 0 0 0
- checkr3 85
-
- moveq -1,r3
- movu.w 0x7685,r3
- test_move_cc 0 0 0 0
- checkr3 7685
-
- moveq -1,r3
- movu.w 0x8765,r3
- test_move_cc 0 0 0 0
- checkr3 8765
-
- movu.b 0,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_movum.s b/tests/tcg/cris/bare/check_movum.s
deleted file mode 100644
index 038e539463..0000000000
--- a/tests/tcg/cris/bare/check_movum.s
+++ /dev/null
@@ -1,40 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: 5\nf5\n5\nfff5\n0\n
-
-; Movu between registers.  Check that zero-extension is performed and the
-; full register is set.
-
- .include "testutils.inc"
-
- .data
-x:
- .byte 5,-11
- .word 5,-11
- .word 0
-
- start
- move.d x,r5
-
- movu.b [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 5
-
- movu.b [r5],r3
- test_move_cc 0 0 0 0
- addq 1,r5
- checkr3 f5
-
- movu.w [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 5
-
- movu.w [r5],r3
- test_move_cc 0 0 0 0
- addq 2,r5
- checkr3 fff5
-
- movu.w [r5],r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_movur.s b/tests/tcg/cris/bare/check_movur.s
deleted file mode 100644
index 3ecf475f75..0000000000
--- a/tests/tcg/cris/bare/check_movur.s
+++ /dev/null
@@ -1,45 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: 5\nf5\n5\nfff5\n0\n
-
-; Movu between registers.  Check that zero-extension is performed and the
-; full register is set.
-
- .include "testutils.inc"
- start
- moveq -1,r5
- moveq 5,r4
- move.b r4,r5
- moveq -1,r3
- movu.b r5,r3
- test_move_cc 0 0 0 0
- checkr3 5
-
- moveq 0,r5
- moveq -11,r4
- move.b r4,r5
- moveq -1,r3
- movu.b r5,r3
- test_move_cc 0 0 0 0
- checkr3 f5
-
- moveq -1,r5
- moveq 5,r4
- move.w r4,r5
- moveq -1,r3
- movu.w r5,r3
- test_move_cc 0 0 0 0
- checkr3 5
-
- moveq 0,r5
- moveq -11,r4
- move.w r4,r5
- moveq -1,r3
- movu.w r5,r3
- test_move_cc 0 0 0 0
- checkr3 fff5
-
- movu.w 0,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_mulv32.s b/tests/tcg/cris/bare/check_mulv32.s
deleted file mode 100644
index f379358765..0000000000
--- a/tests/tcg/cris/bare/check_mulv32.s
+++ /dev/null
@@ -1,51 +0,0 @@
-# mach: crisv32
-# output: fffffffe\n
-# output: ffffffff\n
-# output: fffffffe\n
-# output: 1\n
-# output: fffffffe\n
-# output: ffffffff\n
-# output: fffffffe\n
-# output: 1\n
-
-; Check that carry is not modified on v32.
-
- .include "testutils.inc"
- start
- moveq -1,r3
- moveq 2,r4
- setf c
- muls.d r4,r3
- test_cc 1 0 0 1
- checkr3 fffffffe
- move mof,r3
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 2,r4
- setf c
- mulu.d r4,r3
- test_cc 0 0 1 1
- checkr3 fffffffe
- move mof,r3
- checkr3 1
-
- moveq -1,r3
- moveq 2,r4
- clearf c
- muls.d r4,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
- move mof,r3
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 2,r4
- clearf c
- mulu.d r4,r3
- test_cc 0 0 1 0
- checkr3 fffffffe
- move mof,r3
- checkr3 1
-
- quit
diff --git a/tests/tcg/cris/bare/check_mulx.s b/tests/tcg/cris/bare/check_mulx.s
deleted file mode 100644
index a7a1f82a82..0000000000
--- a/tests/tcg/cris/bare/check_mulx.s
+++ /dev/null
@@ -1,257 +0,0 @@
-# mach: crisv10 crisv32
-# output: fffffffe\nffffffff\nfffffffe\n1\nfffffffe\nffffffff\nfffffffe\n1\nfffe0001\n0\nfffe0001\n0\n1\n0\n1\nfffffffe\n193eade2\n277e3a49\n193eade2\n277e3a49\nfffffffe\nffffffff\n1fffe\n0\nfffffffe\nffffffff\n1fffe\n0\n1\n0\nfffe0001\n0\nfdbdade2\nffffffff\n420fade2\n0\nfffffffe\nffffffff\n1fe\n0\nfffffffe\nffffffff\n1fe\n0\n1\n0\nfe01\n0\n1\n0\nfe01\n0\nffffd9e2\nffffffff\n2be2\n0\n0\n0\n0\n0\n
-
- .include "testutils.inc"
- start
-
- .align 4
- moveq -1,r3
- moveq 2,r4
- muls.d r4,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
- move mof,r3
- checkr3 ffffffff
-
- .align 4
- moveq -1,r3
- moveq 2,r4
- mulu.d r4,r3
- test_cc 0 0 1 0
- checkr3 fffffffe
- move mof,r3
- checkr3 1
-
- .align 4
- moveq 2,r3
- moveq -1,r4
- muls.d r4,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
- move mof,r3
- checkr3 ffffffff
-
- .align 4
- moveq 2,r3
- moveq -1,r4
- mulu.d r4,r3
- test_cc 0 0 1 0
- checkr3 fffffffe
- move mof,r3
- checkr3 1
-
- move.d 0xffff,r4
- move.d r4,r3
- muls.d r4,r3
- test_cc 0 0 1 0
- checkr3 fffe0001
- move mof,r3
- checkr3 0
-
- move.d 0xffff,r4
- move.d r4,r3
- mulu.d r4,r3
- test_cc 0 0 0 0
- checkr3 fffe0001
- move mof,r3
- checkr3 0
-
- moveq -1,r4
- move.d r4,r3
- muls.d r4,r3
- test_cc 0 0 0 0
- checkr3 1
- move mof,r3
- checkr3 0
-
- moveq -1,r4
- move.d r4,r3
- mulu.d r4,r3
- test_cc 1 0 1 0
- checkr3 1
- move mof,r3
- checkr3 fffffffe
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- muls.d r4,r3
- test_cc 0 0 1 0
- checkr3 193eade2
- move mof,r3
- checkr3 277e3a49
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- mulu.d r4,r3
- test_cc 0 0 1 0
- checkr3 193eade2
- move mof,r3
- checkr3 277e3a49
-
- move.d 0xffff,r3
- moveq 2,r4
- muls.w r4,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
- move mof,r3
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 2,r4
- mulu.w r4,r3
- test_cc 0 0 0 0
- checkr3 1fffe
- move mof,r3
- checkr3 0
- nop
-
- moveq 2,r3
- move.d 0xffff,r4
- muls.w r4,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
- move mof,r3
- checkr3 ffffffff
-
- moveq 2,r3
- moveq -1,r4
- mulu.w r4,r3
- test_cc 0 0 0 0
- checkr3 1fffe
- move mof,r3
- checkr3 0
-
- move.d 0xffff,r4
- move.d r4,r3
- muls.w r4,r3
- test_cc 0 0 0 0
- checkr3 1
- move mof,r3
- checkr3 0
-
- moveq -1,r4
- move.d r4,r3
- mulu.w r4,r3
- test_cc 0 0 0 0
- checkr3 fffe0001
- move mof,r3
- checkr3 0
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- muls.w r4,r3
- test_cc 1 0 0 0
- checkr3 fdbdade2
- move mof,r3
- checkr3 ffffffff
- nop
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- mulu.w r4,r3
- test_cc 0 0 0 0
- checkr3 420fade2
- move mof,r3
- checkr3 0
- nop
-
- move.d 0xff,r3
- moveq 2,r4
- muls.b r4,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
- move mof,r3
- checkr3 ffffffff
-
- moveq -1,r3
- moveq 2,r4
- mulu.b r4,r3
- test_cc 0 0 0 0
- checkr3 1fe
- move mof,r3
- checkr3 0
-
- moveq 2,r3
- moveq -1,r4
- muls.b r4,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
- move mof,r3
- checkr3 ffffffff
-
- moveq 2,r3
- moveq -1,r4
- mulu.b r4,r3
- test_cc 0 0 0 0
- checkr3 1fe
- move mof,r3
- checkr3 0
-
- move.d 0xff,r4
- move.d r4,r3
- muls.b r4,r3
- test_cc 0 0 0 0
- checkr3 1
- move mof,r3
- checkr3 0
- nop
-
- moveq -1,r4
- move.d r4,r3
- mulu.b r4,r3
- test_cc 0 0 0 0
- checkr3 fe01
- move mof,r3
- checkr3 0
- nop
-
- move.d 0xfeda49ff,r4
- move.d r4,r3
- muls.b r4,r3
- test_cc 0 0 0 0
- checkr3 1
- move mof,r3
- checkr3 0
- nop
-
- move.d 0xfeda49ff,r4
- move.d r4,r3
- mulu.b r4,r3
- test_cc 0 0 0 0
- checkr3 fe01
- move mof,r3
- checkr3 0
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- muls.b r4,r3
- test_cc 1 0 0 0
- checkr3 ffffd9e2
- move mof,r3
- checkr3 ffffffff
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- mulu.b r4,r3
- test_cc 0 0 0 0
- checkr3 2be2
- move mof,r3
- checkr3 0
-
- moveq 0,r3
- move.d 0xf87f4aeb,r4
- muls.d r4,r3
- test_cc 0 1 0 0
- checkr3 0
- move mof,r3
- checkr3 0
-
- move.d 0xf87f4aeb,r3
- moveq 0,r4
- mulu.d r4,r3
- test_cc 0 1 0 0
- checkr3 0
- move mof,r3
- checkr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_neg.s b/tests/tcg/cris/bare/check_neg.s
deleted file mode 100644
index 963c4b6f5e..0000000000
--- a/tests/tcg/cris/bare/check_neg.s
+++ /dev/null
@@ -1,104 +0,0 @@
-# mach:  crisv0 crisv3 crisv8 crisv10 crisv32
-# output: ffffffff\nffffffff\n0\n80000000\n1\nba987655\nffff\nffff\n0\n89ab8000\nffff0001\n45677655\nff\nff\n0\n89abae80\nffffff01\n45678955\n
-
- .include "testutils.inc"
- start
- moveq 0,r3
- moveq 1,r4
- neg.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq 1,r3
- moveq 0,r4
- neg.d r3,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
-;; FIXME: this was wrong.
- moveq 0,r3
- neg.d r3,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- move.d 0x80000000,r3
- neg.d r3,r3
- test_move_cc 1 0 0 0
- checkr3 80000000
-
- moveq -1,r3
- neg.d r3,r3
- test_move_cc 0 0 0 0
- checkr3 1
-
- move.d 0x456789ab,r3
- neg.d r3,r3
- test_move_cc 1 0 0 0
- checkr3 ba987655
-
- moveq 0,r3
- moveq 1,r4
- neg.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffff
-
- moveq 1,r3
- moveq 0,r4
- neg.w r3,r3
- test_move_cc 1 0 0 0
- checkr3 ffff
-
- moveq 0,r3
- neg.w r3,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- move.d 0x89ab8000,r3
- neg.w r3,r3
- test_move_cc 1 0 0 0
- checkr3 89ab8000
-
- moveq -1,r3
- neg.w r3,r3
- test_move_cc 0 0 0 0
- checkr3 ffff0001
-
- move.d 0x456789ab,r3
- neg.w r3,r3
- test_move_cc 0 0 0 0
- checkr3 45677655
-
- moveq 0,r3
- moveq 1,r4
- neg.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 ff
-
- moveq 1,r3
- moveq 0,r4
- neg.b r3,r3
- test_move_cc 1 0 0 0
- checkr3 ff
-
- moveq 0,r3
- neg.b r3,r3
- test_move_cc 0 1 0 0
- checkr3 0
-
-;; FIXME: was wrong.
- move.d 0x89abae80,r3
- neg.b r3,r3
- test_move_cc 1 0 0 1
- checkr3 89abae80
-
- moveq -1,r3
- neg.b r3,r3
- test_move_cc 0 0 0 0
- checkr3 ffffff01
-
- move.d 0x456789ab,r3
- neg.b r3,r3
- test_move_cc 0 0 0 0
- checkr3 45678955
-
- quit
diff --git a/tests/tcg/cris/bare/check_not.s b/tests/tcg/cris/bare/check_not.s
deleted file mode 100644
index 33bcf155e5..0000000000
--- a/tests/tcg/cris/bare/check_not.s
+++ /dev/null
@@ -1,31 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: fffffffe\nfffffffd\nffff0f00\n0\n87ecbbad\n
-
- .include "testutils.inc"
- start
- moveq 1,r3
- not r3
- test_move_cc 1 0 0 0
- checkr3 fffffffe
-
- moveq 2,r3
- not r3
- test_move_cc 1 0 0 0
- checkr3 fffffffd
-
- move.d 0xf0ff,r3
- not r3
- test_move_cc 1 0 0 0
- checkr3 ffff0f00
-
- moveq -1,r3
- not r3
- test_move_cc 0 1 0 0
- checkr3 0
-
- move.d 0x78134452,r3
- not r3
- test_move_cc 1 0 0 0
- checkr3 87ecbbad
-
- quit
diff --git a/tests/tcg/cris/bare/check_orc.s b/tests/tcg/cris/bare/check_orc.s
deleted file mode 100644
index c733f036a2..0000000000
--- a/tests/tcg/cris/bare/check_orc.s
+++ /dev/null
@@ -1,71 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 3\n3\nffff\nffffffff\n7c33f7db\nffff0003\n3\nfedaffff\n7813f7db\n3\n3\nfeb\n781344db\n
-
- .include "testutils.inc"
- start
- moveq 1,r3
- or.d 2,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- moveq 2,r3
- or.d 1,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- move.d 0xf0ff,r3
- or.d 0xff0f,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- moveq -1,r3
- or.d -1,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x78134452,r3
- or.d 0x5432f789,r3
- test_move_cc 0 0 0 0
- checkr3 7c33f7db
-
- move.d 0xffff0001,r3
- or.w 2,r3
- test_move_cc 0 0 0 0
- checkr3 ffff0003
-
- moveq 2,r3
- or.w 1,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- move.d 0xfedaffaf,r3
- or.w 0xff5f,r3
- test_move_cc 1 0 0 0
- checkr3 fedaffff
-
- move.d 0x78134452,r3
- or.w 0xf789,r3
- test_move_cc 1 0 0 0
- checkr3 7813f7db
-
- moveq 1,r3
- or.b 2,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- moveq 2,r3
- or.b 1,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- move.d 0xfa3,r3
- or.b 0x4a,r3
- test_move_cc 1 0 0 0
- checkr3 feb
-
- move.d 0x78134453,r3
- or.b 0x89,r3
- test_move_cc 1 0 0 0
- checkr3 781344db
-
- quit
diff --git a/tests/tcg/cris/bare/check_orm.s b/tests/tcg/cris/bare/check_orm.s
deleted file mode 100644
index ee723a6aa0..0000000000
--- a/tests/tcg/cris/bare/check_orm.s
+++ /dev/null
@@ -1,75 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 3\n3\nffff\nffffffff\n7c33f7db\nffff0003\n3\nfedaffff\n7813f7db\n3\n3\nfeb\n781344db\n
-
- .include "testutils.inc"
- .data
-x:
- .dword 2,1,0xff0f,-1,0x5432f789
- .word 2,1,0xff5f,0xf789
- .byte 2,1,0x4a,0x89
-
- start
- moveq 1,r3
- move.d x,r5
- or.d [r5+],r3
- checkr3 3
-
- moveq 2,r3
- or.d [r5],r3
- addq 4,r5
- checkr3 3
-
- move.d 0xf0ff,r3
- or.d [r5+],r3
- checkr3 ffff
-
- moveq -1,r3
- or.d [r5+],r3
- checkr3 ffffffff
-
- move.d 0x78134452,r3
- or.d [r5+],r3
- checkr3 7c33f7db
-
- move.d 0xffff0001,r3
- or.w [r5+],r3
- checkr3 ffff0003
-
- moveq 2,r3
- or.w [r5],r3
- addq 2,r5
- test_move_cc 0 0 0 0
- checkr3 3
-
- move.d 0xfedaffaf,r3
- or.w [r5+],r3
- test_move_cc 1 0 0 0
- checkr3 fedaffff
-
- move.d 0x78134452,r3
- or.w [r5+],r3
- test_move_cc 1 0 0 0
- checkr3 7813f7db
-
- moveq 1,r3
- or.b [r5+],r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- moveq 2,r3
- or.b [r5],r3
- addq 1,r5
- test_move_cc 0 0 0 0
- checkr3 3
-
- move.d 0xfa3,r3
- or.b [r5+],r3
- test_move_cc 1 0 0 0
- checkr3 feb
-
- move.d 0x78134453,r3
- or.b [r5],r3
- test_move_cc 1 0 0 0
- checkr3 781344db
-
- quit
diff --git a/tests/tcg/cris/bare/check_orq.s b/tests/tcg/cris/bare/check_orq.s
deleted file mode 100644
index 5060edc72d..0000000000
--- a/tests/tcg/cris/bare/check_orq.s
+++ /dev/null
@@ -1,41 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 3\n3\nffffffff\nffffffff\n1f\nffffffe0\n7813445e\n
-
- .include "testutils.inc"
- start
- moveq 1,r3
- orq 2,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- moveq 2,r3
- orq 1,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- move.d 0xf0ff,r3
- orq -1,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq 0,r3
- orq -1,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- moveq 0,r3
- orq 31,r3
- test_move_cc 0 0 0 0
- checkr3 1f
-
- moveq 0,r3
- orq -32,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffe0
-
- move.d 0x78134452,r3
- orq 12,r3
- test_move_cc 0 0 0 0
- checkr3 7813445e
-
- quit
diff --git a/tests/tcg/cris/bare/check_orr.s b/tests/tcg/cris/bare/check_orr.s
deleted file mode 100644
index a514c11bc9..0000000000
--- a/tests/tcg/cris/bare/check_orr.s
+++ /dev/null
@@ -1,84 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 3\n3\nffff\nffffffff\n7c33f7db\nffff0003\n3\nfedaffff\n7813f7db\n3\n3\nfeb\n781344db\n
-
- .include "testutils.inc"
- start
- moveq 1,r3
- moveq 2,r4
- or.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- moveq 2,r3
- moveq 1,r4
- or.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- move.d 0xff0f,r4
- move.d 0xf0ff,r3
- or.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffff
-
- moveq -1,r4
- move.d r4,r3
- or.d r4,r3
- test_move_cc 1 0 0 0
- checkr3 ffffffff
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- or.d r4,r3
- test_move_cc 0 0 0 0
- checkr3 7c33f7db
-
- move.d 0xffff0001,r3
- moveq 2,r4
- or.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 ffff0003
-
- moveq 2,r3
- move.d 0xffff0001,r4
- or.w r4,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- move.d 0xfedaffaf,r3
- move.d 0xffffff5f,r4
- or.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 fedaffff
-
- move.d 0x5432f789,r4
- move.d 0x78134452,r3
- or.w r4,r3
- test_move_cc 1 0 0 0
- checkr3 7813f7db
-
- moveq 1,r3
- move.d 0xffffff02,r4
- or.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- moveq 2,r3
- moveq 1,r4
- or.b r4,r3
- test_move_cc 0 0 0 0
- checkr3 3
-
- move.d 0x4a,r4
- move.d 0xfa3,r3
- or.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 feb
-
- move.d 0x5432f789,r4
- move.d 0x78134453,r3
- or.b r4,r3
- test_move_cc 1 0 0 0
- checkr3 781344db
-
- quit
diff --git a/tests/tcg/cris/bare/check_ret.s b/tests/tcg/cris/bare/check_ret.s
deleted file mode 100644
index b44fb25933..0000000000
--- a/tests/tcg/cris/bare/check_ret.s
+++ /dev/null
@@ -1,25 +0,0 @@
-# mach: crisv3 crisv8 crisv10
-# output: 3\n
-
-# Test that ret works.
-
- .include "testutils.inc"
- start
-x:
- moveq 0,r3
- jsr z
-w:
- quit
-y:
- addq 1,r3
- checkr3 3
- quit
-
-z:
- addq 1,r3
- move srp,r2
- add.d y-w,r2
- move r2,srp
- ret
- addq 1,r3
- quit
diff --git a/tests/tcg/cris/bare/check_scc.s b/tests/tcg/cris/bare/check_scc.s
deleted file mode 100644
index 4a8674cc1a..0000000000
--- a/tests/tcg/cris/bare/check_scc.s
+++ /dev/null
@@ -1,95 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 1\n0\n1\n0\n1\n0\n1\n0\n0\n1\n1\n0\n1\n0\n1\n0\n1\n0\n0\n1\n0\n1\n1\n0\n1\n0\n0\n1\n1\n0\n1\n1\n0\n
-
- .include "testutils.inc"
-
- .macro lcheckr3 v
-	move	 $ccs, $r9
-	checkr3 \v
-	move	$r9, $ccs
- .endm
-
- start
- clearf nzvc
- scc r3
- lcheckr3 1
- scs r3
- lcheckr3 0
- sne r3
- lcheckr3 1
- seq r3
- lcheckr3 0
- svc r3
- lcheckr3 1
- svs r3
- lcheckr3 0
- spl r3
- lcheckr3 1
- smi r3
- lcheckr3 0
- sls r3
- lcheckr3 0
- shi r3
- lcheckr3 1
- sge r3
- lcheckr3 1
- slt r3
- lcheckr3 0
- sgt r3
- lcheckr3 1
- sle r3
- lcheckr3 0
- sa r3
- lcheckr3 1
- setf nzvc
- scc r3
- lcheckr3 0
- scs r3
- lcheckr3 1
- sne r3
- lcheckr3 0
- svc r3
- lcheckr3 0
- svs r3
- lcheckr3 1
- spl r3
- lcheckr3 0
- smi r3
- lcheckr3 1
- sls r3
- lcheckr3 1
- shi r3
- lcheckr3 0
- sge r3
- lcheckr3 1
- slt r3
- lcheckr3 0
- sgt r3
- lcheckr3 0
- sle r3
- lcheckr3 1
- sa r3
- lcheckr3 1
- clearf n
- sge r3
- lcheckr3 0
- slt r3
- lcheckr3 1
-
- .if 1 ;..asm.arch.cris.v32
- setf p
- ssb r3
- .else
- moveq 1,r3
- .endif
- lcheckr3 1
-
- .if 1 ;..asm.arch.cris.v32
- clearf p
- ssb r3
- .else
- moveq 0,r3
- .endif
- lcheckr3 0
-
- quit
diff --git a/tests/tcg/cris/bare/check_subc.s b/tests/tcg/cris/bare/check_subc.s
deleted file mode 100644
index e34b5448e2..0000000000
--- a/tests/tcg/cris/bare/check_subc.s
+++ /dev/null
@@ -1,87 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 1\n1\n1fffe\nfffffffe\ncc463bdb\nffff0001\n1\nfffe\nfedafffe\n78133bdb\nffffff01\n1\nfe\nfeda49fe\n781344db\n85649200\n
-
- .include "testutils.inc"
- start
-
- moveq -1,r3
- sub.d -2,r3
- test_cc 0 0 0 0
- checkr3 1
-
- moveq 2,r3
- sub.d 1,r3
- test_cc 0 0 0 0
- checkr3 1
-
- move.d 0xffff,r3
- sub.d -0xffff,r3
- test_cc 0 0 0 1
- checkr3 1fffe
-
- moveq -1,r3
- sub.d 1,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
-
- move.d 0x78134452,r3
- sub.d -0x5432f789,r3
- test_cc 1 0 1 1
- checkr3 cc463bdb
-
- moveq -1,r3
- sub.w -2,r3
- test_cc 0 0 0 0
- checkr3 ffff0001
-
- moveq 2,r3
- sub.w 1,r3
- test_cc 0 0 0 0
- checkr3 1
-
- move.d 0xffff,r3
- sub.w 1,r3
- test_cc 1 0 0 0
- checkr3 fffe
-
- move.d 0xfedaffff,r3
- sub.w 1,r3
- test_cc 1 0 0 0
- checkr3 fedafffe
-
- move.d 0x78134452,r3
- sub.w 0x877,r3
- test_cc 0 0 0 0
- checkr3 78133bdb
-
- moveq -1,r3
- sub.b -2,r3
- test_cc 0 0 0 0
- checkr3 ffffff01
-
- moveq 2,r3
- sub.b 1,r3
- test_cc 0 0 0 0
- checkr3 1
-
- move.d 0xff,r3
- sub.b 1,r3
- test_cc 1 0 0 0
- checkr3 fe
-
- move.d 0xfeda49ff,r3
- sub.b 1,r3
- test_cc 1 0 0 0
- checkr3 feda49fe
-
- move.d 0x78134452,r3
- sub.b 0x77,r3
- test_cc 1 0 0 1
- checkr3 781344db
-
- move.d 0x85649282,r3
- sub.b 0x82,r3
- test_cc 0 1 0 0
- checkr3 85649200
-
- quit
diff --git a/tests/tcg/cris/bare/check_subm.s b/tests/tcg/cris/bare/check_subm.s
deleted file mode 100644
index e07ea02dd4..0000000000
--- a/tests/tcg/cris/bare/check_subm.s
+++ /dev/null
@@ -1,96 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 1\n1\n1fffe\nfffffffe\ncc463bdb\nffff0001\n1\nfffe\nfedafffe\n78133bdb\nffffff01\n1\nfe\nfeda49fe\n781344db\n85649200\n
-
- .include "testutils.inc"
- .data
-x:
- .dword -2,1,-0xffff,1,-0x5432f789
- .word -2,1,1,0x877
- .byte -2,1,0x77
- .byte 0x22
-
- start
- moveq -1,r3
- move.d x,r5
- sub.d [r5+],r3
- test_cc 0 0 0 0
- checkr3 1
-
- moveq 2,r3
- sub.d [r5],r3
- test_cc 0 0 0 0
- addq 4,r5
- checkr3 1
-
- move.d 0xffff,r3
- sub.d [r5+],r3
- test_cc 0 0 0 1
- checkr3 1fffe
-
- moveq -1,r3
- sub.d [r5+],r3
- test_cc 1 0 0 0
- checkr3 fffffffe
-
- move.d 0x78134452,r3
- sub.d [r5+],r3
- test_cc 1 0 1 1
- checkr3 cc463bdb
-
- moveq -1,r3
- sub.w [r5+],r3
- test_cc 0 0 0 0
- checkr3 ffff0001
-
- moveq 2,r3
- sub.w [r5+],r3
- test_cc 0 0 0 0
- checkr3 1
-
- move.d 0xffff,r3
- sub.w [r5],r3
- test_cc 1 0 0 0
- checkr3 fffe
-
- move.d 0xfedaffff,r3
- sub.w [r5+],r3
- test_cc 1 0 0 0
- checkr3 fedafffe
-
- move.d 0x78134452,r3
- sub.w [r5+],r3
- test_cc 0 0 0 0
- checkr3 78133bdb
-
- moveq -1,r3
- sub.b [r5],r3
- test_cc 0 0 0 0
- addq 1,r5
- checkr3 ffffff01
-
- moveq 2,r3
- sub.b [r5],r3
- test_cc 0 0 0 0
- checkr3 1
-
- move.d 0xff,r3
- sub.b [r5],r3
- test_cc 1 0 0 0
- checkr3 fe
-
- move.d 0xfeda49ff,r3
- sub.b [r5+],r3
- test_cc 1 0 0 0
- checkr3 feda49fe
-
- move.d 0x78134452,r3
- sub.b [r5+],r3
- test_cc 1 0 0 1
- checkr3 781344db
-
- move.d 0x85649222,r3
- sub.b [r5],r3
- test_cc 0 1 0 0
- checkr3 85649200
-
- quit
diff --git a/tests/tcg/cris/bare/check_subq.s b/tests/tcg/cris/bare/check_subq.s
deleted file mode 100644
index 9e34fa31ab..0000000000
--- a/tests/tcg/cris/bare/check_subq.s
+++ /dev/null
@@ -1,52 +0,0 @@
-# mach: crisv3 crisv8 crisv10 crisv32
-# output: 0\nffffffff\nfffffffe\nffff\nff\n56788f9\n56788d9\n567889a\n0\n7ffffffc\n
-
- .include "testutils.inc"
- start
- moveq 1,r3
- subq 1,r3
- test_cc 0 1 0 0
- checkr3 0
-
- subq 1,r3
- test_cc 1 0 0 1
- checkr3 ffffffff
-
- subq 1,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
-
- move.d 0x10000,r3
- subq 1,r3
- test_cc 0 0 0 0
- checkr3 ffff
-
- move.d 0x100,r3
- subq 1,r3
- test_cc 0 0 0 0
- checkr3 ff
-
- move.d 0x5678900,r3
- subq 7,r3
- test_cc 0 0 0 0
- checkr3 56788f9
-
- subq 32,r3
- test_cc 0 0 0 0
- checkr3 56788d9
-
- subq 63,r3
- test_cc 0 0 0 0
- checkr3 567889a
-
- move.d 34,r3
- subq 34,r3
- test_cc 0 1 0 0
- checkr3 0
-
- move.d 0x80000024,r3
- subq 40,r3
- test_cc 0 0 1 0
- checkr3 7ffffffc
-
- quit
diff --git a/tests/tcg/cris/bare/check_subr.s b/tests/tcg/cris/bare/check_subr.s
deleted file mode 100644
index 742fbc8915..0000000000
--- a/tests/tcg/cris/bare/check_subr.s
+++ /dev/null
@@ -1,102 +0,0 @@
-# mach: crisv0 crisv3 crisv8 crisv10 crisv32
-# output: 1\n1\n1fffe\nfffffffe\ncc463bdb\nffff0001\n1\nfffe\nfedafffe\n78133bdb\nffffff01\n1\nfe\nfeda49fe\n781344db\n85649200\n
-
- .include "testutils.inc"
- start
- moveq -1,r3
- moveq -2,r4
- sub.d r4,r3
- test_cc 0 0 0 0
- checkr3 1
-
- moveq 2,r3
- moveq 1,r4
- sub.d r4,r3
- test_cc 0 0 0 0
- checkr3 1
-
- move.d 0xffff,r3
- move.d -0xffff,r4
- sub.d r4,r3
- test_cc 0 0 0 1
- checkr3 1fffe
-
- moveq 1,r4
- moveq -1,r3
- sub.d r4,r3
- test_cc 1 0 0 0
- checkr3 fffffffe
-
- move.d -0x5432f789,r4
- move.d 0x78134452,r3
- sub.d r4,r3
- test_cc 1 0 1 1
- checkr3 cc463bdb
-
- moveq -1,r3
- moveq -2,r4
- sub.w r4,r3
- test_cc 0 0 0 0
- checkr3 ffff0001
-
- moveq 2,r3
- moveq 1,r4
- sub.w r4,r3
- test_cc 0 0 0 0
- checkr3 1
-
- move.d 0xffff,r3
- move.d -0xffff,r4
- sub.w r4,r3
- test_cc 1 0 0 0
- checkr3 fffe
-
- move.d 0xfedaffff,r3
- move.d -0xfedaffff,r4
- sub.w r4,r3
- test_cc 1 0 0 0
- checkr3 fedafffe
-
- move.d -0x5432f789,r4
- move.d 0x78134452,r3
- sub.w r4,r3
- test_cc 0 0 0 0
- checkr3 78133bdb
-
- moveq -1,r3
- moveq -2,r4
- sub.b r4,r3
- test_cc 0 0 0 0
- checkr3 ffffff01
-
- moveq 2,r3
- moveq 1,r4
- sub.b r4,r3
- test_cc 0 0 0 0
- checkr3 1
-
- move.d -0xff,r4
- move.d 0xff,r3
- sub.b r4,r3
- test_cc 1 0 0 0
- checkr3 fe
-
- move.d -0xfeda49ff,r4
- move.d 0xfeda49ff,r3
- sub.b r4,r3
- test_cc 1 0 0 0
- checkr3 feda49fe
-
- move.d -0x5432f789,r4
- move.d 0x78134452,r3
- sub.b r4,r3
- test_cc 1 0 0 1
- checkr3 781344db
-
- move.d 0x85649222,r3
- move.d 0x77445622,r4
- sub.b r4,r3
- test_cc 0 1 0 0
- checkr3 85649200
-
- quit
diff --git a/tests/tcg/cris/bare/check_xarith.s b/tests/tcg/cris/bare/check_xarith.s
deleted file mode 100644
index 80038b2ab9..0000000000
--- a/tests/tcg/cris/bare/check_xarith.s
+++ /dev/null
@@ -1,72 +0,0 @@
-
-.include "testutils.inc"
-
-	start
-
-	moveq	-1, $r0
-	moveq	0, $r1
-	addq	1, $r0
-	ax
-	addq	0, $r1
-
-	move.d	$r0, $r3
-	checkr3 0
-	move.d	$r1, $r3
-	checkr3 1
-
-	move.d  0, $r0
-	moveq	-1, $r1
-	subq	1, $r0
-	ax
-	subq	0, $r1
-
-	move.d	$r0, $r3
-	checkr3 ffffffff
-	move.d	$r1, $r3
-	checkr3 fffffffe
-
-
-	moveq	-1, $r0
-	moveq	-1, $r1
-	cmpq	-1, $r0
-	ax
-	cmpq	-1, $r1
-	beq	1f
-	nop
-	fail
-1:
-	cmpq	0, $r0
-	ax
-	cmpq	-1, $r1
-	bne	1f
-	nop
-	fail
-1:
-
-	;; test for broken X sequence, run it several times.
-	moveq	8, $r0
-1:
-	moveq	0, $r3
-	move.d	$r0, $r1
-	andq	1, $r1
-	lslq	4, $r1
-	moveq	1, $r2
-	or.d	$r1, $r2
-	ba	2f
-	move	$r2, $ccs
-2:
-	addq	0, $r3
-	move.d	$r0, $r4
-	move.d	$r1, $r5
-	move.d	$r2, $r6
-	move.d	$r3, $r7
-	lsrq	4, $r1
-	move.d	$r1, $r8
-	xor	$r1, $r3
-	checkr3	0
-	subq	1, $r0
-	bne	1b
-	nop
-
-	pass
-	quit
diff --git a/tests/tcg/cris/bare/crt.s b/tests/tcg/cris/bare/crt.s
deleted file mode 100644
index af027d7475..0000000000
--- a/tests/tcg/cris/bare/crt.s
+++ /dev/null
@@ -1,13 +0,0 @@
-	.data
-_stack_start:
-	.space	8192, 0
-_stack_end:
-	.text
-	.global	_start
-_start:
-	move.d	_stack_end, $sp
-	jsr	main
-	nop
-	moveq	0, $r10
-	jump	exit
-	nop
diff --git a/tests/tcg/cris/bare/testutils.inc b/tests/tcg/cris/bare/testutils.inc
deleted file mode 100644
index aa1641b2e6..0000000000
--- a/tests/tcg/cris/bare/testutils.inc
+++ /dev/null
@@ -1,117 +0,0 @@
-	.syntax	no_register_prefix
-
-	.macro	start
-	.text
-	.global	main
-main:
-	.endm
-
-	.macro	quit
-	jump	pass
-	nop
-	.endm
-
-	.macro	pass
-	jump	pass
-	nop
-	.endm
-
-	.macro	startnostack
-	start
-	.endm
-
-	.macro	fail
-	.data
-99:
-	.asciz " checkr3 failed\n"
-	.text
-	move.d	99b, $r10
-	jsr	_fail
-	nop
-	.endm
-
-	.macro	checkr3 val
-	cmp.d	0x\val, $r3
-	beq	100f
-	nop
-	.data
-99:
-	.asciz "checkr3 failed\n"
-	.text
-	move.d	99b, $r10
-	jsr	_fail
-	nop
-100:
-	.endm
-
-; Test the condition codes
-        .macro test_cc N Z V C
-        .if \N
-        bpl 9f
-        nop
-        .else
-        bmi 9f
-        nop
-        .endif
-        .if \Z
-        bne 9f
-        nop
-        .else
-        beq 9f
-        nop
-        .endif
-        .if \V
-        bvc 9f
-        nop
-        .else
-        bvs 9f
-        nop
-        .endif
-        .if \C
-        bcc 9f
-        nop
-        .else
-        bcs 9f
-        nop
-        .endif
-        ba 8f
-        nop
-9:
-	.data
-99:
-	.asciz "test_move_cc failed\n"
-	.text
-	move.d	99b, $r10
-	jsr	_fail
-	nop
-8:
-        .endm
-
-
-        .macro test_move_cc N Z V C
-        .if \N
-        bpl 9f
-        nop
-        .else
-        bmi 9f
-        nop
-        .endif
-        .if \Z
-        bne 9f
-        nop
-        .else
-        beq 9f
-        nop
-        .endif
-        ba 8f
-        nop
-9:
-	.data
-99:
-	.asciz "test_move_cc failed\n"
-	.text
-	move.d	99b, $r10
-	jsr	_fail
-	nop
-8:
-        .endm
-- 
2.45.2


