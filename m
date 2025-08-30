Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC096CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOJv-00039F-Gp; Sat, 30 Aug 2025 12:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1usLQK-0001cc-51
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 09:15:17 -0400
Received: from bonnix2.bonnix.it ([37.247.49.194])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1usLQE-0002iJ-Pk
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 09:15:15 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it 42187243410
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1756559698;
 bh=UpJ3eLXvOnRdBEmtsdcpLwOzW3r5fZ7Upt3+dj4PLBI=;
 h=Date:To:Cc:From:Subject;
 b=AdBp2ca+6YfntMEU8YwSXxaDqZlfcnjX/aB/Bmfi7PCuzZu3jMu6qnqZ3Xnt/qlUn
 eqdKYm3Ul3DFDtRNWeVKTqsdqs9lYHECq3geFpkWgdxI2rsgAOo8NxNPBd50H7oTgR
 2kE7IFZWTsxFmAEztiP6nXIItXrWK2NXuKkqBxZQ=
Received: from [10.0.0.70] (ip190-129-198-217.pool-bba.aruba.it
 [217.198.129.190])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id 42187243410;
 Sat, 30 Aug 2025 15:14:58 +0200 (CEST)
Message-ID: <4bfb150f-7f5a-459b-808f-b0d1abc3b830@bonslack.org>
Date: Sat, 30 Aug 2025 15:14:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: it
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
From: Luca Bonissi <qemu@bonslack.org>
Subject: [PATCH 1/7] Add termios2 support to linux-user
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.247.49.194; envelope-from=qemu@bonslack.org;
 helo=bonnix2.bonnix.it
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From f784259c584fa5f69172f5223b82e21e6054569f Mon Sep 17 00:00:00 2001
From: Luca Bonissi <qemu@bonslack.org>
Date: Sat, 30 Aug 2025 14:51:09 +0200
Subject: [PATCH 1/7] Add termios2 support to linux-user

Signed-off-by: Luca Bonissi <qemu@bonslack.org>
---
 linux-user/ioctls.h         |  6 +++
 linux-user/strace.c         | 63 +++++++++++++++++++++++++++++
 linux-user/syscall.c        | 80 +++++++++++++++++++++++++++++++++++++
 linux-user/syscall_types.h  |  3 ++
 linux-user/user-internals.h |  3 ++
 5 files changed, 155 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 3b41128fd7..0b2deb2824 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -1,5 +1,11 @@
      /* emulated ioctl list */
 
+#ifdef TARGET_TCGETS2
+     IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
+     IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
+     IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
+     IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
+#endif
      IOCTL(TCGETS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios)))
      IOCTL(TCSETS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
      IOCTL(TCSETSF, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 786354627a..ce35769f92 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1933,6 +1933,69 @@ print_termios(void *arg)
     qemu_log("}");
 }
 
+#ifdef TARGET_TCGETS2
+void
+print_termios2(void *arg)
+{
+    const struct target_termios2 *target = arg;
+
+    target_tcflag_t iflags = tswap32(target->c_iflag);
+    target_tcflag_t oflags = tswap32(target->c_oflag);
+    target_tcflag_t cflags = tswap32(target->c_cflag);
+    target_tcflag_t lflags = tswap32(target->c_lflag);
+
+    qemu_log("{");
+
+    qemu_log("c_iflag = ");
+    print_flags(termios_iflags, iflags, 0);
+
+    qemu_log("c_oflag = ");
+    target_tcflag_t oflags_clean =  oflags & ~(TARGET_NLDLY | TARGET_CRDLY |
+                                               TARGET_TABDLY | TARGET_BSDLY |
+                                               TARGET_VTDLY | TARGET_FFDLY);
+    print_flags(termios_oflags, oflags_clean, 0);
+    if (oflags & TARGET_NLDLY) {
+        print_enums(termios_oflags_NLDLY, oflags & TARGET_NLDLY, 0);
+    }
+    if (oflags & TARGET_CRDLY) {
+        print_enums(termios_oflags_CRDLY, oflags & TARGET_CRDLY, 0);
+    }
+    if (oflags & TARGET_TABDLY) {
+        print_enums(termios_oflags_TABDLY, oflags & TARGET_TABDLY, 0);
+    }
+    if (oflags & TARGET_BSDLY) {
+        print_enums(termios_oflags_BSDLY, oflags & TARGET_BSDLY, 0);
+    }
+    if (oflags & TARGET_VTDLY) {
+        print_enums(termios_oflags_VTDLY, oflags & TARGET_VTDLY, 0);
+    }
+    if (oflags & TARGET_FFDLY) {
+        print_enums(termios_oflags_FFDLY, oflags & TARGET_FFDLY, 0);
+    }
+
+    qemu_log("c_cflag = ");
+    if (cflags & TARGET_CBAUD) {
+        print_enums(termios_cflags_CBAUD, cflags & TARGET_CBAUD, 0);
+    }
+    if (cflags & TARGET_CSIZE) {
+        print_enums(termios_cflags_CSIZE, cflags & TARGET_CSIZE, 0);
+    }
+    target_tcflag_t cflags_clean = cflags & ~(TARGET_CBAUD | TARGET_CSIZE);
+    print_flags(termios_cflags, cflags_clean, 0);
+
+    qemu_log("c_lflag = ");
+    print_flags(termios_lflags, lflags, 0);
+
+    qemu_log("c_cc = ");
+    qemu_log("\"%s\",", target->c_cc);
+
+    qemu_log("c_line = ");
+    print_raw_param("\'%c\'", target->c_line, 1);
+
+    qemu_log("}");
+}
+#endif
+
 #undef UNUSED
 
 #ifdef TARGET_NR_accept
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c..41ef690e52 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -88,6 +88,7 @@
 #endif
 
 #define termios host_termios
+#define termios2 host_termios2
 #define winsize host_winsize
 #define termio host_termio
 #define sgttyb host_sgttyb /* same as target */
@@ -5887,6 +5888,85 @@ static const StructEntry struct_termios_def = {
     .print = print_termios,
 };
 
+#ifdef TARGET_TCGETS2
+static void target_to_host_termios2 (void *dst, const void *src)
+{
+    struct host_termios2 *host = dst;
+    const struct target_termios2 *target = src;
+
+    host->c_iflag =
+        target_to_host_bitmask(tswap32(target->c_iflag), iflag_tbl);
+    host->c_oflag =
+        target_to_host_bitmask(tswap32(target->c_oflag), oflag_tbl);
+    host->c_cflag =
+        target_to_host_bitmask(tswap32(target->c_cflag), cflag_tbl);
+    host->c_lflag =
+        target_to_host_bitmask(tswap32(target->c_lflag), lflag_tbl);
+    host->c_line = target->c_line;
+
+    memset(host->c_cc, 0, sizeof(host->c_cc));
+    host->c_cc[VINTR] = target->c_cc[TARGET_VINTR];
+    host->c_cc[VQUIT] = target->c_cc[TARGET_VQUIT];
+    host->c_cc[VERASE] = target->c_cc[TARGET_VERASE];
+    host->c_cc[VKILL] = target->c_cc[TARGET_VKILL];
+    host->c_cc[VEOF] = target->c_cc[TARGET_VEOF];
+    host->c_cc[VTIME] = target->c_cc[TARGET_VTIME];
+    host->c_cc[VMIN] = target->c_cc[TARGET_VMIN];
+    host->c_cc[VSWTC] = target->c_cc[TARGET_VSWTC];
+    host->c_cc[VSTART] = target->c_cc[TARGET_VSTART];
+    host->c_cc[VSTOP] = target->c_cc[TARGET_VSTOP];
+    host->c_cc[VSUSP] = target->c_cc[TARGET_VSUSP];
+    host->c_cc[VEOL] = target->c_cc[TARGET_VEOL];
+    host->c_cc[VREPRINT] = target->c_cc[TARGET_VREPRINT];
+    host->c_cc[VDISCARD] = target->c_cc[TARGET_VDISCARD];
+    host->c_cc[VWERASE] = target->c_cc[TARGET_VWERASE];
+    host->c_cc[VLNEXT] = target->c_cc[TARGET_VLNEXT];
+    host->c_cc[VEOL2] = target->c_cc[TARGET_VEOL2];
+}
+
+static void host_to_target_termios2 (void *dst, const void *src)
+{
+    struct target_termios2 *target = dst;
+    const struct host_termios2 *host = src;
+
+    target->c_iflag =
+        tswap32(host_to_target_bitmask(host->c_iflag, iflag_tbl));
+    target->c_oflag =
+        tswap32(host_to_target_bitmask(host->c_oflag, oflag_tbl));
+    target->c_cflag =
+        tswap32(host_to_target_bitmask(host->c_cflag, cflag_tbl));
+    target->c_lflag =
+        tswap32(host_to_target_bitmask(host->c_lflag, lflag_tbl));
+    target->c_line = host->c_line;
+
+    memset(target->c_cc, 0, sizeof(target->c_cc));
+    target->c_cc[TARGET_VINTR] = host->c_cc[VINTR];
+    target->c_cc[TARGET_VQUIT] = host->c_cc[VQUIT];
+    target->c_cc[TARGET_VERASE] = host->c_cc[VERASE];
+    target->c_cc[TARGET_VKILL] = host->c_cc[VKILL];
+    target->c_cc[TARGET_VEOF] = host->c_cc[VEOF];
+    target->c_cc[TARGET_VTIME] = host->c_cc[VTIME];
+    target->c_cc[TARGET_VMIN] = host->c_cc[VMIN];
+    target->c_cc[TARGET_VSWTC] = host->c_cc[VSWTC];
+    target->c_cc[TARGET_VSTART] = host->c_cc[VSTART];
+    target->c_cc[TARGET_VSTOP] = host->c_cc[VSTOP];
+    target->c_cc[TARGET_VSUSP] = host->c_cc[VSUSP];
+    target->c_cc[TARGET_VEOL] = host->c_cc[VEOL];
+    target->c_cc[TARGET_VREPRINT] = host->c_cc[VREPRINT];
+    target->c_cc[TARGET_VDISCARD] = host->c_cc[VDISCARD];
+    target->c_cc[TARGET_VWERASE] = host->c_cc[VWERASE];
+    target->c_cc[TARGET_VLNEXT] = host->c_cc[VLNEXT];
+    target->c_cc[TARGET_VEOL2] = host->c_cc[VEOL2];
+}
+
+static const StructEntry struct_termios2_def = {
+    .convert = { host_to_target_termios2, target_to_host_termios2 },
+    .size = { sizeof(struct target_termios2), sizeof(struct host_termios2) },
+    .align = { __alignof__(struct target_termios2), __alignof__(struct host_termios2) },
+    .print = print_termios2,
+};
+#endif
+
 /* If the host does not provide these bits, they may be safely discarded. */
 #ifndef MAP_SYNC
 #define MAP_SYNC 0
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 6dd7a80ce5..ac45705acf 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -1,4 +1,7 @@
 STRUCT_SPECIAL(termios)
+#ifdef TARGET_TCGETS2
+STRUCT_SPECIAL(termios2)
+#endif
 
 STRUCT(winsize,
        TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_SHORT)
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 691b9a1775..191e01c3a8 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -127,6 +127,9 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 #endif /* TARGET_ABI_BITS != 32 */
 
 void print_termios(void *arg);
+#ifdef TARGET_TCGETS2
+void print_termios2(void *arg);
+#endif
 
 /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
 #ifdef TARGET_ARM
-- 
2.50.1



