Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2B5C3DA40
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZ9-00011j-FD; Fri, 14 Jun 2024 13:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZ8-00011M-2Z
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:18 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZ5-00043G-T6
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 37C4920726;
 Fri, 14 Jun 2024 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Aws4khzscTtE/UXma9tVeQJFLcYjczXhseH9nYlb6E=;
 b=bnK+8vlXfeXwGzF+KnlNRcXb3JJWo6krtjjZvZS3V3qY9zBh0vrzSc/P8Beyj1Bm1H2gPP
 jTnKC6ZpnRKJ7qaKpTWra66ZkBPBUysFMz72C/m87CLpdiX9dfNgsW+HmzJNiLOOfqIgG7
 ixmSXi+Yw9ai5/6pHELB+6kqGMWG9AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Aws4khzscTtE/UXma9tVeQJFLcYjczXhseH9nYlb6E=;
 b=CPxd+6zYSDZaBxbi43hLk37XHXviI8+HeJxQR+N4uW1UtjHQELEeuN2GfxGIyZ+7Eu1ZVK
 gafQFmzBfzjG53Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bnK+8vlX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CPxd+6zY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Aws4khzscTtE/UXma9tVeQJFLcYjczXhseH9nYlb6E=;
 b=bnK+8vlXfeXwGzF+KnlNRcXb3JJWo6krtjjZvZS3V3qY9zBh0vrzSc/P8Beyj1Bm1H2gPP
 jTnKC6ZpnRKJ7qaKpTWra66ZkBPBUysFMz72C/m87CLpdiX9dfNgsW+HmzJNiLOOfqIgG7
 ixmSXi+Yw9ai5/6pHELB+6kqGMWG9AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Aws4khzscTtE/UXma9tVeQJFLcYjczXhseH9nYlb6E=;
 b=CPxd+6zYSDZaBxbi43hLk37XHXviI8+HeJxQR+N4uW1UtjHQELEeuN2GfxGIyZ+7Eu1ZVK
 gafQFmzBfzjG53Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C05F813AB1;
 Fri, 14 Jun 2024 17:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8PKCIVR7bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 04/18] tests/qtest/migration-test: Use custom asm bios for ppc64
Date: Fri, 14 Jun 2024 14:17:48 -0300
Message-Id: <20240614171802.28451-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 37C4920726
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,gmail.com];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[4];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Similar to other archs, build a custom bios memory updater. Running the
test with OF code is a cool trick, but SLOF takes a long time to boot.
This reduces test time by around 3x (150s to 50s).

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/migration/Makefile           |  2 +-
 tests/migration/migration-test.h   |  1 +
 tests/migration/ppc64/Makefile     | 15 +++++++
 tests/migration/ppc64/a-b-kernel.S | 66 ++++++++++++++++++++++++++++++
 tests/migration/ppc64/a-b-kernel.h | 42 +++++++++++++++++++
 tests/qtest/migration-test.c       | 37 +++--------------
 6 files changed, 131 insertions(+), 32 deletions(-)
 create mode 100644 tests/migration/ppc64/Makefile
 create mode 100644 tests/migration/ppc64/a-b-kernel.S
 create mode 100644 tests/migration/ppc64/a-b-kernel.h

diff --git a/tests/migration/Makefile b/tests/migration/Makefile
index 13e99b1692..2c5ee287ec 100644
--- a/tests/migration/Makefile
+++ b/tests/migration/Makefile
@@ -5,7 +5,7 @@
 # See the COPYING file in the top-level directory.
 #
 
-TARGET_LIST = i386 aarch64 s390x
+TARGET_LIST = i386 aarch64 s390x ppc64
 
 SRC_PATH = ../..
 
diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
index 68512c0b1b..194df7df6f 100644
--- a/tests/migration/migration-test.h
+++ b/tests/migration/migration-test.h
@@ -22,6 +22,7 @@
 /* PPC */
 #define PPC_TEST_MEM_START (1 * 1024 * 1024)
 #define PPC_TEST_MEM_END   (100 * 1024 * 1024)
+#define PPC_H_PUT_TERM_CHAR 0x58
 
 /* ARM */
 #define ARM_TEST_MEM_START (0x40000000 + 1 * 1024 * 1024)
diff --git a/tests/migration/ppc64/Makefile b/tests/migration/ppc64/Makefile
new file mode 100644
index 0000000000..a3a2d98ac8
--- /dev/null
+++ b/tests/migration/ppc64/Makefile
@@ -0,0 +1,15 @@
+.PHONY: all clean
+all: a-b-kernel.h
+
+a-b-kernel.h: ppc64.kernel
+	echo "$$__note" > $@
+	xxd -i $< | sed -e 's/.*int.*//' >> $@
+
+ppc64.kernel: ppc64.elf
+	$(CROSS_PREFIX)objcopy -O binary -S $< $@
+
+ppc64.elf: a-b-kernel.S
+	$(CROSS_PREFIX)gcc -static -o $@ -nostdlib -Wl,--build-id=none $<
+
+clean:
+	$(RM) *.kernel *.elf
diff --git a/tests/migration/ppc64/a-b-kernel.S b/tests/migration/ppc64/a-b-kernel.S
new file mode 100644
index 0000000000..0613a8d18e
--- /dev/null
+++ b/tests/migration/ppc64/a-b-kernel.S
@@ -0,0 +1,66 @@
+#
+# Copyright (c) 2024 IBM, Inc
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+#include "../migration-test.h"
+
+.section .text
+
+.macro print ch
+	li	%r3,PPC_H_PUT_TERM_CHAR
+	li	%r4,0
+	li	%r5,1
+	li	%r6,\ch
+	sldi	%r6,%r6,56
+	sc	1
+.endm
+
+        .globl  _start
+_start:
+. = 0x100
+	/*
+	 * Enter 64-bit mode. Not necessary because the test uses 32-bit
+	 * addresses, but those constants could easily be changed and break
+	 * in 32-bit mode.
+	 */
+	mfmsr	%r9
+	li	%r10,-1
+	rldimi	%r9,%r10,63,0
+	mtmsrd	%r9
+
+        /*
+	 * Set up test memory region. Non-volatiles are used because the
+	 * hcall can clobber regs.
+	 * r20 - start address
+	 * r21 - number of pages
+	 */
+	lis	%r20,PPC_TEST_MEM_START@h
+	ori	%r20,%r20,PPC_TEST_MEM_START@l
+	lis	%r9,PPC_TEST_MEM_END@h
+	ori	%r9,%r9,PPC_TEST_MEM_END@l
+	subf	%r21,%r20,%r9
+	li	%r10,TEST_MEM_PAGE_SIZE
+	divd	%r21,%r21,%r10
+
+	print	'A'
+
+	li	%r3,0
+	mr	%r9,%r20
+	mtctr	%r21
+1:	stb	%r3,0(%r9)
+	addi	%r9,%r9,TEST_MEM_PAGE_SIZE
+	bdnz	1b
+
+loop:
+	mr	%r9,%r20
+	mtctr	%r21
+1:	lbz	%r3,0(%r9)
+	addi	%r3,%r3,1
+	stb	%r3,0(%r9)
+	addi	%r9,%r9,TEST_MEM_PAGE_SIZE
+	bdnz	1b
+
+	print	'B'
+	b	loop
diff --git a/tests/migration/ppc64/a-b-kernel.h b/tests/migration/ppc64/a-b-kernel.h
new file mode 100644
index 0000000000..673317efdb
--- /dev/null
+++ b/tests/migration/ppc64/a-b-kernel.h
@@ -0,0 +1,42 @@
+/* This file is automatically generated from the assembly file in
+ * tests/migration/ppc64. Edit that file and then run "make all"
+ * inside tests/migration to update, and then remember to send both
+ * the header and the assembler differences in your patch submission.
+ */
+unsigned char ppc64_kernel[] = {
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x7d, 0x20, 0x00, 0xa6, 0x39, 0x40, 0xff, 0xff,
+  0x79, 0x49, 0xf8, 0x0e, 0x7d, 0x20, 0x01, 0x64, 0x3e, 0x80, 0x00, 0x10,
+  0x62, 0x94, 0x00, 0x00, 0x3d, 0x20, 0x06, 0x40, 0x61, 0x29, 0x00, 0x00,
+  0x7e, 0xb4, 0x48, 0x50, 0x39, 0x40, 0x10, 0x00, 0x7e, 0xb5, 0x53, 0xd2,
+  0x38, 0x60, 0x00, 0x58, 0x38, 0x80, 0x00, 0x00, 0x38, 0xa0, 0x00, 0x01,
+  0x38, 0xc0, 0x00, 0x41, 0x78, 0xc6, 0xc1, 0xc6, 0x44, 0x00, 0x00, 0x22,
+  0x38, 0x60, 0x00, 0x00, 0x7e, 0x89, 0xa3, 0x78, 0x7e, 0xa9, 0x03, 0xa6,
+  0x98, 0x69, 0x00, 0x00, 0x39, 0x29, 0x10, 0x00, 0x42, 0x00, 0xff, 0xf8,
+  0x7e, 0x89, 0xa3, 0x78, 0x7e, 0xa9, 0x03, 0xa6, 0x88, 0x69, 0x00, 0x00,
+  0x38, 0x63, 0x00, 0x01, 0x98, 0x69, 0x00, 0x00, 0x39, 0x29, 0x10, 0x00,
+  0x42, 0x00, 0xff, 0xf0, 0x38, 0x60, 0x00, 0x58, 0x38, 0x80, 0x00, 0x00,
+  0x38, 0xa0, 0x00, 0x01, 0x38, 0xc0, 0x00, 0x42, 0x78, 0xc6, 0xc1, 0xc6,
+  0x44, 0x00, 0x00, 0x22, 0x4b, 0xff, 0xff, 0xcc
+};
+
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index ef9ddef1c8..d6f5ceed80 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -128,6 +128,7 @@ static char *bootpath;
  */
 #include "tests/migration/i386/a-b-bootblock.h"
 #include "tests/migration/aarch64/a-b-kernel.h"
+#include "tests/migration/ppc64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
 
 static void bootfile_create(char *dir, bool suspend_me)
@@ -147,10 +148,8 @@ static void bootfile_create(char *dir, bool suspend_me)
         content = s390x_elf;
         len = sizeof(s390x_elf);
     } else if (strcmp(arch, "ppc64") == 0) {
-        /*
-         * sane architectures can be programmed at the boot prompt
-         */
-        return;
+        content = ppc64_kernel;
+        len = sizeof(ppc64_kernel);
     } else if (strcmp(arch, "aarch64") == 0) {
         content = aarch64_kernel;
         len = sizeof(aarch64_kernel);
@@ -181,29 +180,10 @@ static void wait_for_serial(const char *side)
 {
     g_autofree char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
     FILE *serialfile = fopen(serialpath, "r");
-    const char *arch = qtest_get_arch();
-    int started = (strcmp(side, "src_serial") == 0 &&
-                   strcmp(arch, "ppc64") == 0) ? 0 : 1;
 
     do {
         int readvalue = fgetc(serialfile);
 
-        if (!started) {
-            /* SLOF prints its banner before starting test,
-             * to ignore it, mark the start of the test with '_',
-             * ignore all characters until this marker
-             */
-            switch (readvalue) {
-            case '_':
-                started = 1;
-                break;
-            case EOF:
-                fseek(serialfile, 0, SEEK_SET);
-                usleep(1000);
-                break;
-            }
-            continue;
-        }
         switch (readvalue) {
         case 'A':
             /* Fine */
@@ -215,8 +195,6 @@ static void wait_for_serial(const char *side)
             return;
 
         case EOF:
-            started = (strcmp(side, "src_serial") == 0 &&
-                       strcmp(arch, "ppc64") == 0) ? 0 : 1;
             fseek(serialfile, 0, SEEK_SET);
             usleep(1000);
             break;
@@ -737,14 +715,11 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         memory_size = "256M";
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
-        arch_source = g_strdup_printf("-prom-env 'use-nvramrc?=true' -prom-env "
-                                      "'nvramrc=hex .\" _\" begin %x %x "
-                                      "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                      "until'", end_address, start_address);
         machine_alias = "pseries";
         machine_opts = "vsmt=8";
-        arch_opts = g_strdup("-nodefaults "
-                             "-machine " PSERIES_DEFAULT_CAPABILITIES);
+        arch_opts = g_strdup_printf(
+            "-nodefaults -machine " PSERIES_DEFAULT_CAPABILITIES " "
+            "-bios %s", bootpath);
     } else if (strcmp(arch, "aarch64") == 0) {
         memory_size = "150M";
         machine_alias = "virt";
-- 
2.35.3


