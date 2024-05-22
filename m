Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9EBC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 03:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9cuK-0003S8-Ad; Tue, 21 May 2024 23:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuJ-0003RQ-1P
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:51 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuF-0004A4-PR
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:50 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-244bdd730dcso2063728fac.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 20:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716349485; x=1716954285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJ/MHrlbj4C0ri8M58dDIQBRERSolyRdsK7MrfghSiM=;
 b=EnSpFhiycxi0N+874U70eKBtYzm40R7Q0zr7Rcre1+PSkFNpAYpJXpjBJKffWNrqp+
 PeSEFmGfAw4i+0ww0vDy/B4VDuOoVdc3Ntwfvxq7fqNhnZdoOAEkUS7wxSgNUaimwemh
 8S/zl9YQKJiptT3In5Rub/DWme3p9NZzabj4SD/q2J4rwh0wRdkXf9YdxVMFse/PiIyt
 13zp3N9VKx723UUP/ooqasg3Y02nVFNDmYb6/QThuqkKhc2cGu9vnXNRptPdbUud7usu
 iyEWQv/CQqaBqn1mT1584Pnn3zpKFulZ/Z5vPzDYftDn5BqjgJ8aEF7e0LbZs/p8oqPH
 KrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716349485; x=1716954285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJ/MHrlbj4C0ri8M58dDIQBRERSolyRdsK7MrfghSiM=;
 b=D73uISaU1/rvsMqXEU5pcf7oBx7RsIXgrdP+Ism4Ia30JSreGMUVCKk9Uro8mbr6cg
 bLORyYij1nslc8D3gk1tFsva9ZG3BOzu2iA/cILB07d6TcBEHmt1aFg9u4VWizsQ40Q7
 5pSicFpBY8Rhq05UoN/S6hlVm2+2W+08P0lbMaP0poV6tUVBlUfhoV1IPfpQO4wZvoCa
 CPv5s7RodMD5mLPqEjthUiZR0l2CaESL2r/aa3yuCsoXDVd8TdBToIccsjYIxWX97xiA
 dQTI0nSj/9DY1ZEMiF/psvIz9qrOZhRG9L3PgMvxpYDa+zG5WlbbuMAxn4mixbfTZTQt
 AUag==
X-Gm-Message-State: AOJu0YzL5oPg/TCXuOrmFqxOyUnMp6Mcg0X+BPgbvuq6FAr9fI86KPIC
 WUY5FKYBHgwolQRPtv1jgYEFqP3doUG3moW7yUZNtC2IwrKAQNtYSYZKLHG5CSDhoQhn8MSxhvw
 B
X-Google-Smtp-Source: AGHT+IEP84YjNuFzJ2jlnUC619ISe+1FyRbbsGV/U6TTDaD1raTrmKSZ2c5LOI+CfKCw+kQkqQHkDA==
X-Received: by 2002:a05:6870:9627:b0:23c:1f34:730 with SMTP id
 586e51a60fabf-24c690dcbeamr1066614fac.49.1716349485353; 
 Tue, 21 May 2024 20:44:45 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm21416617b3a.162.2024.05.21.20.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 20:44:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RISU v2 2/8] Build elf test cases instead of raw binaries
Date: Tue, 21 May 2024 20:44:36 -0700
Message-Id: <20240522034442.140293-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522034442.140293-1-richard.henderson@linaro.org>
References: <20240522034442.140293-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

For test_arch64.s and test_arm.s, use '.inst' so that the risu
control insns are marked as instructions for disassembly.

For test_i386.S, split the data to be loaded into the data section;
fix an error aligning the data: 16 not 2**16.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile       | 19 ++++++++++---------
 test.ld        | 12 ++++++++++++
 test_aarch64.s |  4 ++--
 test_arm.s     | 16 +++++++++++-----
 test_i386.S    |  4 +++-
 5 files changed, 38 insertions(+), 17 deletions(-)
 create mode 100644 test.ld

diff --git a/Makefile b/Makefile
index ad7f879..2bd08aa 100644
--- a/Makefile
+++ b/Makefile
@@ -22,7 +22,8 @@ ALL_CFLAGS = -Wall -D_GNU_SOURCE -DARCH=$(ARCH) -U$(ARCH) $(BUILD_INC) $(CFLAGS)
 PROG=risu
 SRCS=risu.c comms.c risu_$(ARCH).c risu_reginfo_$(ARCH).c
 HDRS=risu.h risu_reginfo_$(ARCH).h
-BINS=test_$(ARCH).bin
+BINO=test_$(ARCH).o
+BINE=test_$(ARCH).elf
 
 # For dumping test patterns
 RISU_BINS=$(wildcard *.risu.bin)
@@ -30,7 +31,7 @@ RISU_ASMS=$(patsubst %.bin,%.asm,$(RISU_BINS))
 
 OBJS=$(SRCS:.c=.o)
 
-all: $(PROG) $(BINS)
+all: $(PROG) $(BINE)
 
 dump: $(RISU_ASMS)
 
@@ -43,17 +44,17 @@ $(PROG): $(OBJS)
 %.o: %.c $(HDRS)
 	$(CC) $(CPPFLAGS) $(ALL_CFLAGS) -o $@ -c $<
 
-%_$(ARCH).bin: %_$(ARCH).elf
-	$(OBJCOPY) -O binary $< $@
+%_$(ARCH).o: %_$(ARCH).s
+	$(CC) -o $@ -c $<
 
-%_$(ARCH).elf: %_$(ARCH).s
-	$(AS) -o $@ $<
-
-%_$(ARCH).elf: %_$(ARCH).S
+%_$(ARCH).o: %_$(ARCH).S
 	$(CC) $(CPPFLAGS) -o $@ -c $<
 
+%_$(ARCH).elf: test.ld %_$(ARCH).o
+	$(LD) -o $@ -T $^
+
 clean:
-	rm -f $(PROG) $(OBJS) $(BINS)
+	rm -f $(PROG) $(OBJS) $(BINO) $(BINE)
 
 distclean: clean
 	rm -f config.h Makefile.in
diff --git a/test.ld b/test.ld
new file mode 100644
index 0000000..eb0a76a
--- /dev/null
+++ b/test.ld
@@ -0,0 +1,12 @@
+ENTRY(start)
+
+PHDRS {
+    text PT_LOAD FILEHDR PHDRS;
+}
+
+SECTIONS {
+    . = SIZEOF_HEADERS;
+    PROVIDE(start = .);
+    .text : { *(.text) } :text
+    .data : { *(.data) } :text
+}
diff --git a/test_aarch64.s b/test_aarch64.s
index f75d588..88902c6 100644
--- a/test_aarch64.s
+++ b/test_aarch64.s
@@ -80,6 +80,6 @@ fmov d31, #31.0
 /* do compare.
  * The manual says instr with bits (28,27) == 0 0 are UNALLOCATED
  */
-.int 0x00005af0
+.inst 0x00005af0
 /* exit test */
-.int 0x00005af1
+.inst 0x00005af1
diff --git a/test_arm.s b/test_arm.s
index 49552f2..62582e7 100644
--- a/test_arm.s
+++ b/test_arm.s
@@ -9,20 +9,26 @@
  *     Peter Maydell (Linaro) - initial implementation
  *******************************************************************************/
 
+.text
+
 /* magic instruction to force ARM mode whether we were in ARM or Thumb before */
-.int 0xe0004778
+.inst 0xe0004778
+
 /* Initialise the gp regs */
 add r0, pc, #4
 ldmia r0, {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r14}
-b next
+b 1f
+
 .int 0,1,2,3,4,5,6,7,8,9,10,11,12,14
-next:
+
+1:
 msr CPSR_fs, #0
+
 /* do compare.
  * The space 0xE7F___F_ is guaranteed to always UNDEF
  * and not to be allocated for insns in future architecture
  * revisions.
  */
-.int 0xe7fe5af0
+.inst 0xe7fe5af0
 /* exit test */
-.int 0xe7fe5af1
+.inst 0xe7fe5af1
diff --git a/test_i386.S b/test_i386.S
index 05344d7..2e2b090 100644
--- a/test_i386.S
+++ b/test_i386.S
@@ -13,6 +13,7 @@
 
 /* Initialise the registers to avoid spurious mismatches */
 
+.text
 #ifdef __x86_64__
 #define BASE	%rax
 	lea	2f(%rip), BASE
@@ -71,7 +72,8 @@
 /* exit test */
 	ud1	%ecx, %eax
 
-	.p2align 16
+.data
+	.balign 16
 2:
 	.set	i, 0
 	.rept	256
-- 
2.34.1


