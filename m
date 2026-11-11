Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F6D606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=jxjZfpwt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7CY-0005r3-Eg; Wed, 11 Nov 2026 07:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xR7CW-0005qo-Lh
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:13:17 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xR7CS-0004sk-2w
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794399187; bh=jF6zjXau9iMhwYsVDPljMqmwImffhPlRfK/JOFANCGQ=;
 h=From:To:Cc:Subject:Date;
 b=jxjZfpwtt7LXxlCxEoKk2yI1WwsbzJyirU+S+klrXb4u5lbPpOGoKCWt59W2XW1y9
 xvh4Qr8Fh4qutXJdEsayhDqXRPZhU9cqsS+HssP6Jr8TzIGU6zf3yGdJAPKzecFNZ0
 cHzqgAD2fGeRGxIlhGA81J8frAjcnIavpepCOj2gDoMgoiDVo+ZePbieyatgjjEpYW
 YhXeHiuzWxZQovdTRzjhgF6iFdUQXrwY6XQhacU1tqJOvcWC6Ad+T3xTBEM60j+7hq
 XlcdEEQSSkvAu3Dh4+wrRuwdNYLMrTqe6ljTztYVgzn+m3YpTX913xEbnP3RTgvSiz
 vLJvvpgUPQ/vQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 68B8E1E5675;
 Wed, 11 Nov 2026 15:13:07 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3E6D2458EC8;
 Wed, 11 Nov 2026 15:13:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] linux-user/vdso: make the binaries reproducible
Date: Wed, 11 Nov 2026 15:12:59 +0300
Message-ID: <20261111121259.14941-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently the linux-user vdso*.so files are not reproducible,
because for one, the binaries embed a random temporary file
name used by the compiler during compilation, such as ccuckKYd.o.

At the very least, use -pipe to avoid the need to have a temp
file in the first place - this makes the build repeatable.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/aarch64/Makefile.vdso     | 6 ++++--
 linux-user/arm/Makefile.vdso         | 8 +++++---
 linux-user/hppa/Makefile.vdso        | 4 +++-
 linux-user/i386/Makefile.vdso        | 4 +++-
 linux-user/loongarch64/Makefile.vdso | 4 +++-
 linux-user/ppc/Makefile.vdso         | 8 +++++---
 linux-user/riscv/Makefile.vdso       | 6 ++++--
 linux-user/s390x/Makefile.vdso       | 4 +++-
 linux-user/sh4/Makefile.vdso         | 6 ++++--
 linux-user/x86_64/Makefile.vdso      | 4 +++-
 10 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/linux-user/aarch64/Makefile.vdso b/linux-user/aarch64/Makefile.vdso
index 82ed201108..1789b67268 100644
--- a/linux-user/aarch64/Makefile.vdso
+++ b/linux-user/aarch64/Makefile.vdso
@@ -3,6 +3,8 @@ include $(BUILD_DIR)/linux-user/aarch64/config-target.mak
 SUBDIR = $(SRC_PATH)/linux-user/aarch64
 VPATH += $(SUBDIR)
 
+REPRODUCIBLE = -pipe
+
 all: $(SUBDIR)/vdso-be.so $(SUBDIR)/vdso-le.so
 
 LDFLAGS = -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
@@ -10,7 +12,7 @@ LDFLAGS = -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
 	  -Wl,-z,max-page-size=4096 -Wl,-T,$(SUBDIR)/vdso.ld
 
 $(SUBDIR)/vdso-be.so: vdso.S vdso.ld
-	$(CC) -o $@ $(LDFLAGS) -mbig-endian $<
+	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mbig-endian $<
 
 $(SUBDIR)/vdso-le.so: vdso.S vdso.ld
-	$(CC) -o $@ $(LDFLAGS) -mlittle-endian $<
+	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mlittle-endian $<
diff --git a/linux-user/arm/Makefile.vdso b/linux-user/arm/Makefile.vdso
index 16ae8d7aaa..360b77185f 100644
--- a/linux-user/arm/Makefile.vdso
+++ b/linux-user/arm/Makefile.vdso
@@ -3,6 +3,8 @@ include $(BUILD_DIR)/linux-user/arm/config-target.mak
 SUBDIR = $(SRC_PATH)/linux-user/arm
 VPATH += $(SUBDIR)
 
+REPRODUCIBLE = -pipe
+
 all: $(SUBDIR)/vdso-be8.so $(SUBDIR)/vdso-be32.so $(SUBDIR)/vdso-le.so
 
 # Adding -use-blx disables unneeded interworking without actually using blx.
@@ -11,10 +13,10 @@ LDFLAGS = -nostdlib -shared -Wl,-use-blx -Wl,-z,max-page-size=4096 \
 	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
 
 $(SUBDIR)/vdso-be8.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC) -o $@ $(LDFLAGS) -mbig-endian -mbe8 $<
+	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mbig-endian -mbe8 $<
 
 $(SUBDIR)/vdso-be32.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC) -o $@ $(LDFLAGS) -mbig-endian -mbe32 $<
+	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mbig-endian -mbe32 $<
 
 $(SUBDIR)/vdso-le.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC) -o $@ $(LDFLAGS) -mlittle-endian $<
+	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mlittle-endian $<
diff --git a/linux-user/hppa/Makefile.vdso b/linux-user/hppa/Makefile.vdso
index 78642c4266..5f3f2ddde9 100644
--- a/linux-user/hppa/Makefile.vdso
+++ b/linux-user/hppa/Makefile.vdso
@@ -3,9 +3,11 @@ include $(BUILD_DIR)/linux-user/hppa/config-target.mak
 SUBDIR = $(SRC_PATH)/linux-user/hppa
 VPATH += $(SUBDIR)
 
+REPRODUCIBLE = -pipe
+
 all: $(SUBDIR)/vdso.so
 
 $(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso32.so.1 \
+	$(CC) $(REPRODUCIBLE) -o $@ -nostdlib -shared -Wl,-h,linux-vdso32.so.1 \
 	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
 	  -Wl,-T,$(SUBDIR)/vdso.ld $<
diff --git a/linux-user/i386/Makefile.vdso b/linux-user/i386/Makefile.vdso
index ca2e37fa6b..e797c5c7fe 100644
--- a/linux-user/i386/Makefile.vdso
+++ b/linux-user/i386/Makefile.vdso
@@ -3,9 +3,11 @@ include $(BUILD_DIR)/linux-user/i386/config-target.mak
 SUBDIR = $(SRC_PATH)/linux-user/i386
 VPATH += $(SUBDIR)
 
+REPRODUCIBLE = -pipe
+
 all: $(SUBDIR)/vdso.so
 
 $(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC) -o $@ -m32 -nostdlib -shared -Wl,-h,linux-gate.so.1 \
+	$(CC) $(REPRODUCIBLE) -o $@ -m32 -nostdlib -shared -Wl,-h,linux-gate.so.1 \
 	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
 	  -Wl,-T,$(SUBDIR)/vdso.ld $<
diff --git a/linux-user/loongarch64/Makefile.vdso b/linux-user/loongarch64/Makefile.vdso
index ceb6110120..64a422e66d 100644
--- a/linux-user/loongarch64/Makefile.vdso
+++ b/linux-user/loongarch64/Makefile.vdso
@@ -3,10 +3,12 @@ include $(BUILD_DIR)/linux-user/loongarch64/config-target.mak
 SUBDIR = $(SRC_PATH)/linux-user/loongarch64
 VPATH += $(SUBDIR)
 
+REPRODUCIBLE = -pipe
+
 all: $(SUBDIR)/vdso.so
 
 $(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC) -o $@ -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 \
+	$(CC) $(REPRODUCIBLE) -o $@ -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 \
 	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
 	  -Wl,--no-warn-rwx-segments -Wl,-z,max-page-size=4096 \
 	  -Wl,-T,$(SUBDIR)/vdso.ld $<
diff --git a/linux-user/ppc/Makefile.vdso b/linux-user/ppc/Makefile.vdso
index 6b9be84381..87a2bc1c57 100644
--- a/linux-user/ppc/Makefile.vdso
+++ b/linux-user/ppc/Makefile.vdso
@@ -3,6 +3,8 @@ include $(BUILD_DIR)/linux-user/ppc64/config-target.mak
 SUBDIR = $(SRC_PATH)/linux-user/ppc
 VPATH += $(SUBDIR)
 
+REPRODUCIBLE = -pipe
+
 all: $(SUBDIR)/vdso-32.so $(SUBDIR)/vdso-64.so $(SUBDIR)/vdso-64le.so
 
 LDFLAGS32 = -nostdlib -shared -Wl,-T,$(SUBDIR)/vdso-32.ld \
@@ -13,10 +15,10 @@ LDFLAGS64 = -nostdlib -shared -Wl,-T,$(SUBDIR)/vdso-64.ld \
 	    -Wl,--build-id=sha1 -Wl,-z,max-page-size=4096
 
 $(SUBDIR)/vdso-32.so: vdso.S vdso-32.ld vdso-asmoffset.h
-	$(CC) -o $@ $(LDFLAGS32) -m32 $<
+	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS32) -m32 $<
 
 $(SUBDIR)/vdso-64.so: vdso.S vdso-64.ld vdso-asmoffset.h
-	$(CC) -o $@ $(LDFLAGS64) -mbig-endian $<
+	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS64) -mbig-endian $<
 
 $(SUBDIR)/vdso-64le.so: vdso.S vdso-64.ld vdso-asmoffset.h
-	$(CC) -o $@ $(LDFLAGS64) -mlittle-endian $<
+	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS64) -mlittle-endian $<
diff --git a/linux-user/riscv/Makefile.vdso b/linux-user/riscv/Makefile.vdso
index 2eefdb70cf..2a47a3113d 100644
--- a/linux-user/riscv/Makefile.vdso
+++ b/linux-user/riscv/Makefile.vdso
@@ -3,13 +3,15 @@ include $(BUILD_DIR)/linux-user/riscv64/config-target.mak
 SUBDIR = $(SRC_PATH)/linux-user/riscv
 VPATH += $(SUBDIR)
 
+REPRODUCIBLE = -pipe
+
 all: $(SUBDIR)/vdso-32.so $(SUBDIR)/vdso-64.so
 
 LDFLAGS = -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
 	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
 
 $(SUBDIR)/vdso-32.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC) -o $@ $(LDFLAGS) -mabi=ilp32d -march=rv32g $<
+	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mabi=ilp32d -march=rv32g $<
 
 $(SUBDIR)/vdso-64.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC) -o $@ $(LDFLAGS) -mabi=lp64d -march=rv64g $<
+	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mabi=lp64d -march=rv64g $<
diff --git a/linux-user/s390x/Makefile.vdso b/linux-user/s390x/Makefile.vdso
index 51f7c50a2d..65ac267239 100644
--- a/linux-user/s390x/Makefile.vdso
+++ b/linux-user/s390x/Makefile.vdso
@@ -3,9 +3,11 @@ include $(BUILD_DIR)/linux-user/s390x/config-target.mak
 SUBDIR = $(SRC_PATH)/linux-user/s390x
 VPATH += $(SUBDIR)
 
+REPRODUCIBLE = -pipe
+
 all: $(SUBDIR)/vdso.so
 
 $(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso64.so.1 \
+	$(CC) $(REPRODUCIBLE) -o $@ -nostdlib -shared -Wl,-h,linux-vdso64.so.1 \
 	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
 	  -Wl,-T,$(SUBDIR)/vdso.ld $<
diff --git a/linux-user/sh4/Makefile.vdso b/linux-user/sh4/Makefile.vdso
index ed2cc11b82..97375a4783 100644
--- a/linux-user/sh4/Makefile.vdso
+++ b/linux-user/sh4/Makefile.vdso
@@ -3,6 +3,8 @@ include $(BUILD_DIR)/linux-user/sh4/config-target.mak
 SUBDIR = $(SRC_PATH)/linux-user/sh4
 VPATH += $(SUBDIR)
 
+REPRODUCIBLE = -pipe
+
 all: $(SUBDIR)/vdso-le.so $(SUBDIR)/vdso-be.so
 
 LDFLAGS = -nostdlib -shared -Wl,-h,linux-gate.so.1 \
@@ -10,9 +12,9 @@ LDFLAGS = -nostdlib -shared -Wl,-h,linux-gate.so.1 \
 	  -Wl,-T,$(SUBDIR)/vdso.ld
 
 $(SUBDIR)/vdso-le.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC) -o $@ $(LDFLAGS) -ml $<
+	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -ml $<
 
 CC_BE = sh4eb-unknown-linux-gnu-gcc
 
 $(SUBDIR)/vdso-be.so: vdso.S vdso.ld vdso-asmoffset.h
-	$(CC_BE) -o $@ $(LDFLAGS) $<
+	$(CC_BE) $(REPRODUCIBLE) -o $@ $(LDFLAGS) $<
diff --git a/linux-user/x86_64/Makefile.vdso b/linux-user/x86_64/Makefile.vdso
index 56fe87af72..41281ffe0a 100644
--- a/linux-user/x86_64/Makefile.vdso
+++ b/linux-user/x86_64/Makefile.vdso
@@ -3,9 +3,11 @@ include $(BUILD_DIR)/linux-user/x86_64/config-target.mak
 SUBDIR = $(SRC_PATH)/linux-user/x86_64
 VPATH += $(SUBDIR)
 
+REPRODUCIBLE = -pipe
+
 all: $(SUBDIR)/vdso.so
 
 $(SUBDIR)/vdso.so: vdso.S vdso.ld
-	$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
+	$(CC) $(REPRODUCIBLE) -o $@ -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
 	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
 	  -Wl,-T,$(SUBDIR)/vdso.ld $<
-- 
2.47.3


