Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D25CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPs-0006aS-PP; Wed, 06 May 2026 22:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPr-0006Zb-En
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:43 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPp-0007gl-C2
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:43 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-679b072ed3aso174026eaf.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120680; x=1778725480;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDLgHPbMW3HTfiXvqW+3o1mH9wo3oWIvOAWn56wDd8c=;
 b=q5A/eWNyFIqRW7lGWGnkIdsqmoe+bPInzVLKOpWtXt14C/m4xDOYqG8cmmwae5fTZr
 2h/NHqwlWHUDkFNZcYJDvzolkVO0KZcK5NAL2LQQRsUPpWKh33u6gut+LLV7SwTrYWlr
 wYldTlkg+eq1sDKmPvtAiML/sTz/CWD+yRmWApmnVvTv21NeYuCrJXXQ2igF81Rmnwlk
 oBFmB5s4AMDWiR44ix7d6+NrZIwd6wfrrJoNwzSly0EVgeKetnJ6zMKhisU1dcckWwyA
 t6ukb/BpLtfv1gKFfaQqC1Q143aUAlKHa7s8TeLo4oxEG1XLq5c+K62loBPq3TwlvXge
 LKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120680; x=1778725480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aDLgHPbMW3HTfiXvqW+3o1mH9wo3oWIvOAWn56wDd8c=;
 b=cd3zNFeP/XO6ceN4YWupArNF1rV25ZlacHBnd/107gA+ikcVI3t5gimBUbl4uRg+P7
 4G1WN4n6JLcx/0oTmDmRuqMtYDmtNd7UygBw3jNdZCHzT773qtX28W0hfNi6Pab8Bmzd
 vFDL9P31K7qC/lQY6Fn9iO12IVGMcC2IrlT3YDBQVHoznXUmU0iOvI84R0lzfxygKSaG
 BvPai4z49OHRAzJBVH+PH/iKwhkXKhH2YTM7L9NHVvx9632E0Fru4hhvo2UD4GDvuy6a
 71AcpzwL1w2ryVK29bnS1ku6tXrnkJfxpl03rUJmNsGqANNm7fC/SsHS7m7trkrMZJrR
 K3bA==
X-Gm-Message-State: AOJu0YxppZVU/pTBN3ndOtKOTRC6klGMBZXJUDqRbbJ+9mckHulqVu9s
 dRxRcc8ajn/td8zQOEWsDK8lAkIJqFlKe4PJFt4/mZSqOc6ZqBCgjAWeKEK8SabAwbQDjmOllpG
 pByf7UPA=
X-Gm-Gg: AeBDiesJ7e5+13+TXCcW0HtPYbIvwj2TEqSIym9wRXZUOrxCLhD5UzphNO5ecVWOYG5
 COJXTNQJzXaCWnOm80NY3Z+jhBH7Dnz8eyVwHA5DcZs8gK/UUx7upiyxanfCvQbdbhju89kQObf
 aFdbrT/NlaeCE63JuD6HIRpealbsIdVSUU1ZJHmYw3fIu7N4zlNlBbkJFHi/8h2AJ/vjEoq6olQ
 7tT6mpZOa9/iD3tkxemJJhRYrnmeKsD8AvrIgFvw7/auhlzRjBYysKvYWTgaNKKk3w/auzTTJBq
 RjV63kHvhF6X7XOaBdwdRxjFsGY0pERNGvZLH9VvBUiCPcg+7WMEb8DdQtxNKavNzJ86uP4nxee
 uLV6w7QdgFWmq+lswI4UMrYrQHFiBm5qPVNw9Qc+HCzcX7yzf5e+cZn5E8ZTvI0NfW6piyFw/s0
 EQiP5VEnqLBgg+sRLeTAG1
X-Received: by 2002:a05:6820:1513:b0:696:70f0:7ade with SMTP id
 006d021491bc7-69998c9fbfcmr3340956eaf.8.1778120679896; 
 Wed, 06 May 2026 19:24:39 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Sean Bruno <sbruno@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 18/25] bsd-user: Add bsd-ioctl.c infrastructure and termios
 conversion
Date: Wed,  6 May 2026 20:22:12 -0600
Message-ID: <20260507022219.44171-19-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c35;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add initial bsd-ioctl.c file with termios conversion functions,
structure type definitions, and ioctl table infrastructure.
Includes target_to_host_termios and host_to_target_termios for
terminal I/O control conversion, along with the ioctl dispatch
table framework.

Style complains about STRUCT and STRUCT_SPECIAL defines:
  ● checkpatch.pl: 197: ERROR: Macros with complex values should be enclosed in parenthesis
  ● checkpatch.pl: 198: ERROR: Macros with complex values should be enclosed in parenthesis
but that's fine. We are doing weird things with macros, and it's fine.
We can't put parens or do while (0) around these since they are table
building macros for files that are included multiple times.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 219 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 bsd-user/bsd-ioctl.c

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
new file mode 100644
index 0000000000..94110d4ad5
--- /dev/null
+++ b/bsd-user/bsd-ioctl.c
@@ -0,0 +1,219 @@
+/*
+ * BSD ioctl(2) emulation
+ *
+ * Copyright (c) 2013-2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#include <sys/types.h>
+#include <sys/param.h>
+#include <sys/disk.h>
+#include <sys/ioccom.h>
+#include <sys/ioctl.h>
+#include <sys/sockio.h>
+#include <sys/_termios.h>
+#include <sys/ttycom.h>
+#include <sys/filio.h>
+
+#include <crypto/cryptodev.h>
+
+#include <net/ethernet.h>
+#include <net/if.h>
+#include <net/if_var.h>
+#include <net/if_types.h>
+#include <net/route.h>
+#include <net/if_dl.h>
+#include <net/if_gif.h>
+#include <net/if_gre.h>
+#include <net/if_lagg.h>
+#include <net/if_media.h>
+#include <net/pfvar.h>
+#include <net/if_pfsync.h>
+#include <netinet/icmp6.h>
+#include <netinet/in.h>
+#include <netinet/ip_carp.h>
+#include <netinet6/in6_var.h>
+#include <netinet6/nd6.h>
+#include <net80211/ieee80211_ioctl.h>
+
+#include <stdio.h>
+
+#include "qemu.h"
+
+#include "syscall_defs.h"
+#include "bsd-ioctl.h"
+#include "os-ioctl-cryptodev.h"
+#include "os-ioctl-filio.h"
+#include "os-ioctl-in6_var.h"
+#include "os-ioctl-sockio.h"
+#include "os-ioctl-ttycom.h"
+#include "os-ioctl-disk.h"
+
+static void target_to_host_termios(void *dst, const void *src)
+{
+    struct termios *host = dst;
+    const struct target_termios *target = src;
+
+    host->c_iflag = target_to_host_bitmask(tswap32(target->c_iflag), iflag_tbl);
+    host->c_oflag = target_to_host_bitmask(tswap32(target->c_oflag), oflag_tbl);
+    host->c_cflag = target_to_host_bitmask(tswap32(target->c_cflag), cflag_tbl);
+    host->c_lflag = target_to_host_bitmask(tswap32(target->c_lflag), lflag_tbl);
+
+    memset(host->c_cc, 0, sizeof(host->c_cc));
+    host->c_cc[VEOF] = target->c_cc[TARGET_VEOF];
+    host->c_cc[VEOL] = target->c_cc[TARGET_VEOL];
+#ifdef VEOL2
+    host->c_cc[VEOL2] = target->c_cc[TARGET_VEOL2];
+#endif
+    host->c_cc[VERASE] = target->c_cc[TARGET_VERASE];
+#ifdef VWERASE
+    host->c_cc[VWERASE] = target->c_cc[TARGET_VWERASE];
+#endif
+    host->c_cc[VKILL] = target->c_cc[TARGET_VKILL];
+#ifdef VREPRINT
+    host->c_cc[VREPRINT] = target->c_cc[TARGET_VREPRINT];
+#endif
+#ifdef VERASE2
+    host->c_cc[VERASE2] = target->c_cc[TARGET_VERASE2];
+#endif
+    host->c_cc[VINTR] = target->c_cc[TARGET_VINTR];
+    host->c_cc[VQUIT] = target->c_cc[TARGET_VQUIT];
+    host->c_cc[VSUSP] = target->c_cc[TARGET_VSUSP];
+#ifdef VDSUSP
+    host->c_cc[VDSUSP] = target->c_cc[TARGET_VDSUSP];
+#endif
+    host->c_cc[VSTART] = target->c_cc[TARGET_VSTART];
+    host->c_cc[VSTOP] = target->c_cc[TARGET_VSTOP];
+#ifdef VLNEXT
+    host->c_cc[VLNEXT] = target->c_cc[TARGET_VLNEXT];
+#endif
+#ifdef VDISCARD
+    host->c_cc[VDISCARD] = target->c_cc[TARGET_VDISCARD];
+#endif
+    host->c_cc[VMIN] = target->c_cc[TARGET_VMIN];
+    host->c_cc[VTIME] = target->c_cc[TARGET_VTIME];
+#ifdef VSTATUS
+    host->c_cc[VSTATUS] = target->c_cc[TARGET_VSTATUS];
+#endif
+
+    host->c_ispeed = tswap32(target->c_ispeed);
+    host->c_ospeed = tswap32(target->c_ospeed);
+}
+
+static void host_to_target_termios(void *dst, const void *src)
+{
+    struct target_termios *target = dst;
+    const struct termios *host = src;
+
+    target->c_iflag = tswap32(host_to_target_bitmask(host->c_iflag, iflag_tbl));
+    target->c_oflag = tswap32(host_to_target_bitmask(host->c_oflag, oflag_tbl));
+    target->c_cflag = tswap32(host_to_target_bitmask(host->c_cflag, cflag_tbl));
+    target->c_lflag = tswap32(host_to_target_bitmask(host->c_lflag, lflag_tbl));
+
+    memset(target->c_cc, 0, sizeof(target->c_cc));
+    target->c_cc[TARGET_VEOF] = host->c_cc[VEOF];
+    target->c_cc[TARGET_VEOL] = host->c_cc[VEOL];
+#ifdef VEOL2
+    target->c_cc[TARGET_VEOL2] = host->c_cc[VEOL2];
+#endif
+    target->c_cc[TARGET_VERASE] = host->c_cc[VERASE];
+#ifdef VWERASE
+    target->c_cc[TARGET_VWERASE] = host->c_cc[VWERASE];
+#endif
+    target->c_cc[TARGET_VKILL] = host->c_cc[VKILL];
+#ifdef VREPRINT
+    target->c_cc[TARGET_VREPRINT] = host->c_cc[VREPRINT];
+#endif
+#ifdef VERASE2
+    target->c_cc[TARGET_VERASE2] = host->c_cc[VERASE2];
+#endif
+    target->c_cc[TARGET_VINTR] = host->c_cc[VINTR];
+    target->c_cc[TARGET_VQUIT] = host->c_cc[VQUIT];
+    target->c_cc[TARGET_VSUSP] = host->c_cc[VSUSP];
+#ifdef VDSUSP
+    target->c_cc[TARGET_VDSUSP] = host->c_cc[VDSUSP];
+#endif
+    target->c_cc[TARGET_VSTART] = host->c_cc[VSTART];
+    target->c_cc[TARGET_VSTOP] = host->c_cc[VSTOP];
+#ifdef VLNEXT
+    target->c_cc[TARGET_VLNEXT] = host->c_cc[VLNEXT];
+#endif
+#ifdef VDISCARD
+    target->c_cc[TARGET_VDISCARD] = host->c_cc[VDISCARD];
+#endif
+    target->c_cc[TARGET_VMIN] = host->c_cc[VMIN];
+    target->c_cc[TARGET_VTIME] = host->c_cc[VTIME];
+#ifdef VSTATUS
+    target->c_cc[TARGET_VSTATUS] = host->c_cc[VSTATUS];
+#endif
+
+    target->c_ispeed = tswap32(host->c_ispeed);
+    target->c_ospeed = tswap32(host->c_ospeed);
+}
+
+static const StructEntry struct_termios_def = {
+    .convert = { host_to_target_termios, target_to_host_termios },
+    .size = { sizeof(struct target_termios), sizeof(struct termios) },
+    .align = { __alignof__(struct target_termios),
+        __alignof__(struct termios) },
+};
+
+/* ioctl structure type definitions */
+#define STRUCT(name, ...) STRUCT_ ## name,
+#define STRUCT_SPECIAL(name) STRUCT_ ## name,
+enum {
+#include "os-ioctl-types.h"
+STRUCT_MAX
+};
+#undef STRUCT
+#undef STRUCT_SPECIAL
+
+#define STRUCT(name, ...) \
+    static const argtype struct_ ## name ## _def[] = { __VA_ARGS__, TYPE_NULL };
+#define STRUCT_SPECIAL(name)
+#include "os-ioctl-types.h"
+#undef STRUCT
+#undef STRUCT_SPECIAL
+
+
+struct IOCTLEntry;
+
+typedef abi_long do_ioctl_fn(const struct IOCTLEntry *ie, uint8_t *buf_temp,
+                int fd, abi_long cmd, abi_long arg);
+
+struct IOCTLEntry {
+    unsigned int target_cmd;
+    unsigned int host_cmd;
+    const char *name;
+    int access;
+    do_ioctl_fn *do_ioctl;
+    const argtype arg_type[5];
+};
+typedef struct IOCTLEntry IOCTLEntry;
+
+#define MAX_STRUCT_SIZE 4096
+
+static abi_long do_ioctl_unsupported(__unused const IOCTLEntry *ie,
+                                     __unused uint8_t *buf_temp,
+                                     __unused int fd, __unused abi_long cmd,
+                                     __unused abi_long arg);
+
+static abi_long do_ioctl_in6_ifreq_sockaddr_int(const IOCTLEntry *ie,
+        uint8_t *buf_temp, int fd, abi_long cmd, abi_long arg);
+
+static IOCTLEntry ioctl_entries[] = {
+#define IOC_    0x0000
+#define IOC_R   0x0001
+#define IOC_W   0x0002
+#define IOC_RW  (IOC_R | IOC_W)
+#define IOCTL(cmd, access, ...) \
+    { TARGET_ ## cmd, cmd, #cmd, access, 0, { __VA_ARGS__ } },
+#define IOCTL_SPECIAL(cmd, access, dofn, ...) \
+    { TARGET_ ## cmd, cmd, #cmd, access, dofn, { __VA_ARGS__ } },
+#define IOCTL_SPECIAL_UNIMPL(cmd, access, dofn, ...) \
+    { TARGET_ ## cmd, 0, #cmd, access, dofn, { __VA_ARGS__ } },
+#include "os-ioctl-cmds.h"
+    { 0, 0 },
+};
-- 
2.52.0


