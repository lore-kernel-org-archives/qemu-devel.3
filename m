Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A611AC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA2q-0004Xe-Tg; Wed, 17 Apr 2024 14:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2i-00044J-Vb
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:30:02 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2g-0003mq-Pn
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:30:00 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e346224bdso1939a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378597; x=1713983397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8eo2jSvcn1ZSvG3FSu+38gN1aTmZ4jM+1lXBXdjpkc=;
 b=Dl4YDuDnTMAXAE4tt+gI8zRxQMID6+23TH9SFhhRow4XahmGRyJz2ceycoUJuFKLIM
 DQKVDyDI9WzfS85IdatAD3njfA5WJ6BZHDtK/sUWzbZzXA3MSTZBOWNfD6rTrTeQuiPK
 KKvrjVOWb17EnY18j/+EJwlsOMNEKiVj0NvXtp8afU7yzPf8TRXimg9ro5eHsuhOiRJH
 gnPtz2MpvOXRIZvp3Wtn44oohi+WyREWK9kYeAE4wnxPJcpKNkr8uwh/usiL8feN+1qq
 /R2EtqEIsQSfTNfvrRcX1SMrHtD/a7gIJCJsd8CRkPwaOGBzx/WzVyeOjc8a1LfHvHdZ
 BA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378597; x=1713983397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8eo2jSvcn1ZSvG3FSu+38gN1aTmZ4jM+1lXBXdjpkc=;
 b=IAobYp8HFFzvFKS5Dkvo6eFz1Z+VFzBMkjdlpYG53j5VTrLawbkPQPbu3Ao4dY7ePt
 2/5iuelj00o6+j/MVORrnj4Po/yKYdW13g7Lbz7V4IGIDN3tppgdodcSOMDO2lRXgcky
 NHn9pO7W4M9m40+2u3DhcnYan3tP6x4fmbrGIR65O3INGou5FVGkD2GM+4qKESQdjtWU
 jx+oeo+OdmukSH/J/k9q4IzQIB8VlOvjQugMdUtwE6p9qu6CfKBBxSAtVMQ5Y1doJ5kZ
 cM5kf6JCTu1VQdcY48AJa1aLjG501UpSZvG07tOGTkUQgsDXflQ+N9RMC7vAM62uH2fH
 D4eQ==
X-Gm-Message-State: AOJu0YxJAFjTCQSaUcM42ZUfx09BMrj4CS4SUD5HMPYTfS9MFrUImmuF
 YXMJMZ8jIKiB+XWMVkLD/QeDFvauQuOQeXKhE3cMZ2uCwJpIGiiKzfIbUKoSK2BrQg/MKZcW8HB
 c
X-Google-Smtp-Source: AGHT+IHHIB7qHxMG68OhofnspXIyIB8oUaFO0rsERtfE8Mn4CGR36tq3nfKuj+x2bOaAJVxyamQFrQ==
X-Received: by 2002:a50:ab57:0:b0:568:a30c:2db5 with SMTP id
 t23-20020a50ab57000000b00568a30c2db5mr220732edc.40.1713378597013; 
 Wed, 17 Apr 2024 11:29:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 n22-20020aa7c796000000b0056feeb85ed0sm6935158eds.19.2024.04.17.11.29.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:29:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 19/21] exec: Move [b]tswapl() declarations to
 'exec/user/tswap-target.h'
Date: Wed, 17 Apr 2024 20:28:04 +0200
Message-ID: <20240417182806.69446-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

tswapl() and bswaptls() are target-dependent and only used
by user emulation. Move their definitions to a new header:
"exec/user/tswap-target.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20231212123401.37493-17-philmd@linaro.org>
---
 MAINTAINERS                        |  1 +
 bsd-user/freebsd/target_os_elf.h   |  1 +
 bsd-user/freebsd/target_os_stack.h |  1 +
 bsd-user/netbsd/target_os_elf.h    |  1 +
 bsd-user/openbsd/target_os_elf.h   |  1 +
 include/exec/cpu-all.h             |  8 --------
 include/exec/user/abitypes.h       |  1 +
 include/user/tswap-target.h        | 22 ++++++++++++++++++++++
 bsd-user/signal.c                  |  1 +
 bsd-user/strace.c                  |  1 +
 linux-user/elfload.c               |  1 +
 linux-user/i386/signal.c           |  1 +
 linux-user/ppc/signal.c            |  1 +
 13 files changed, 33 insertions(+), 8 deletions(-)
 create mode 100644 include/user/tswap-target.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f1f6922025..e85b358683 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3704,6 +3704,7 @@ Overall usermode emulation
 M: Riku Voipio <riku.voipio@iki.fi>
 S: Maintained
 F: accel/tcg/user-exec*.c
+F: include/exec/user/
 F: include/user/
 F: common-user/
 
diff --git a/bsd-user/freebsd/target_os_elf.h b/bsd-user/freebsd/target_os_elf.h
index 9df17d56d8..01124979f7 100644
--- a/bsd-user/freebsd/target_os_elf.h
+++ b/bsd-user/freebsd/target_os_elf.h
@@ -22,6 +22,7 @@
 
 #include "target_arch_elf.h"
 #include "elf.h"
+#include "user/tswap-target.h"
 
 #define bsd_get_ncpu() 1 /* until we pull in bsd-proc.[hc] */
 
diff --git a/bsd-user/freebsd/target_os_stack.h b/bsd-user/freebsd/target_os_stack.h
index d15fc3263f..ac0ef22cd7 100644
--- a/bsd-user/freebsd/target_os_stack.h
+++ b/bsd-user/freebsd/target_os_stack.h
@@ -23,6 +23,7 @@
 #include <sys/param.h>
 #include "target_arch_sigtramp.h"
 #include "qemu/guest-random.h"
+#include "user/tswap-target.h"
 
 /*
  * The initial FreeBSD stack is as follows:
diff --git a/bsd-user/netbsd/target_os_elf.h b/bsd-user/netbsd/target_os_elf.h
index 2f3cb20871..9de0f290c0 100644
--- a/bsd-user/netbsd/target_os_elf.h
+++ b/bsd-user/netbsd/target_os_elf.h
@@ -22,6 +22,7 @@
 
 #include "target_arch_elf.h"
 #include "elf.h"
+#include "user/tswap-target.h"
 
 /* this flag is uneffective under linux too, should be deleted */
 #ifndef MAP_DENYWRITE
diff --git a/bsd-user/openbsd/target_os_elf.h b/bsd-user/openbsd/target_os_elf.h
index 6dca9c5a85..4cf5747dcd 100644
--- a/bsd-user/openbsd/target_os_elf.h
+++ b/bsd-user/openbsd/target_os_elf.h
@@ -22,6 +22,7 @@
 
 #include "target_arch_elf.h"
 #include "elf.h"
+#include "user/tswap-target.h"
 
 /* this flag is uneffective under linux too, should be deleted */
 #ifndef MAP_DENYWRITE
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 7c44ffb3af..78848f018c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -36,14 +36,6 @@
 #define BSWAP_NEEDED
 #endif
 
-#if TARGET_LONG_SIZE == 4
-#define tswapl(s) tswap32(s)
-#define bswaptls(s) bswap32s(s)
-#else
-#define tswapl(s) tswap64(s)
-#define bswaptls(s) bswap64s(s)
-#endif
-
 /* Target-endianness CPU memory access functions. These fit into the
  * {ld,st}{type}{sign}{size}{endian}_p naming scheme described in bswap.h.
  */
diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index 6178453d94..56e96fcb99 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -2,6 +2,7 @@
 #define EXEC_USER_ABITYPES_H
 
 #include "cpu.h"
+#include "user/tswap-target.h"
 
 #ifdef TARGET_ABI32
 #define TARGET_ABI_BITS 32
diff --git a/include/user/tswap-target.h b/include/user/tswap-target.h
new file mode 100644
index 0000000000..4719330dbb
--- /dev/null
+++ b/include/user/tswap-target.h
@@ -0,0 +1,22 @@
+/*
+ * target-specific swap() definitions
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef USER_TSWAP_H
+#define USER_TSWAP_H
+
+#include "exec/cpu-defs.h"
+#include "exec/tswap.h"
+
+#if TARGET_LONG_SIZE == 4
+#define tswapl(s) tswap32(s)
+#define bswaptls(s) bswap32s(s)
+#else
+#define tswapl(s) tswap64(s)
+#define bswaptls(s) bswap64s(s)
+#endif
+
+#endif
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index e5a773ddde..b2faf1d0dd 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu.h"
+#include "user/tswap-target.h"
 #include "gdbstub/user.h"
 #include "signal-common.h"
 #include "trace.h"
diff --git a/bsd-user/strace.c b/bsd-user/strace.c
index 96499751eb..6dc01d3be7 100644
--- a/bsd-user/strace.c
+++ b/bsd-user/strace.c
@@ -22,6 +22,7 @@
 #include <sys/ioccom.h>
 
 #include "qemu.h"
+#include "user/tswap-target.h"
 
 #include "os-strace.h"  /* OS dependent strace print functions */
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 60cf55b36c..28d9e8a9a5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -7,6 +7,7 @@
 #include <sys/shm.h>
 
 #include "qemu.h"
+#include "user/tswap-target.h"
 #include "user-internals.h"
 #include "signal-common.h"
 #include "loader.h"
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index cfe70fc5cf..990048f42a 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "user/tswap-target.h"
 
 /* from the Linux kernel - /arch/x86/include/uapi/asm/sigcontext.h */
 
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 652038a53c..a1d8c0bccc 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "user/tswap-target.h"
 #include "vdso-asmoffset.h"
 
 /* See arch/powerpc/include/asm/ucontext.h.  Only used for 32-bit PPC;
-- 
2.41.0


