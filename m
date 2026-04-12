Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE52E937EA
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxID-0006VU-Bx; Sun, 12 Apr 2026 12:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHx-0006Rc-QM
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:02 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHq-0004WY-Jh
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:54 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4152698e745so1337179fac.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009827; x=1776614627;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OG67MzhAjbi8mtn9vqr3Qx3q3JjHQoONM9JlGgCF1mM=;
 b=dhynwrnGypFQorpn8JLg7JGtk9gQJp+3DQn6d8ynQcdhwd0b4fcXWT/1detyUK1mOi
 AabZ3SEjua4DZ4gg2lmTPQYxDSM28mQjy3/Vp7pCa+6JK9JFu7tQkvZQe85JJtlmvflK
 z1v6GMBP6b/OdF3NfnCjoV/zcJ5ZC4f1t92FP3IpHMoeAt+apjfKUQcdvbLJLvy/8uus
 G2AphCU32oNATRCLK2xDRnME5YTm8qIuma4CqgmnJXqj2xcSxHtmzPjByHpRDiat1PN/
 7XFjbs6E4XWqBbg5WaDHbntG8pFbNY3r7zIvNN2PSZ8dAHmTnIcWpugrIMy2phaJ5Zf1
 5tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009827; x=1776614627;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OG67MzhAjbi8mtn9vqr3Qx3q3JjHQoONM9JlGgCF1mM=;
 b=TLfTWJZTxN2XiZXdcEDZY4vYUC6zXTedn9UAS9ly+8irYHUY7KUpiq2JzPWb4e008G
 cuo043NG7oovBXLMthvYKV2Dw0VRGfJEhKmcJSs5+b3hJEddP2v9gXjHSEERsHLWiy/i
 kMTDg0S+rYVztsI1/+Q4zavJamgFFN0FLq2OWhZfg3SRyvTY0NzYgjfRvHbRuvubAQb1
 IFwUCFdVqFp13a9xYelpMQFOFTRTdLO+flOxXELAPMDN1kDXD9VibtCrIfJseEA/+ZJe
 LwVwCrqipW2eEfKb13qMl4FCMkWjwrDYaKBBuslyOXMfcWHug4MVdSty0bcLehwp7eYl
 oqHg==
X-Gm-Message-State: AOJu0YzAMUG2NbdAcPtjSW3LUje10hdrNkQo5TNsaTiqyT2LMRxRGtlR
 hxAV/vK2o9Q7wyOQbN0jSxfaJ/AU/AMfTKJUcmnSK8tgAmMgAljVIMdkXZWTN8gyGkx/iD39obH
 urH+Wp3E=
X-Gm-Gg: AeBDiesU5r8Uv3FE4mSgWH/yDyVQHpcihTjeODgfxtrziDI/LDJ+15JXbCzX1iNAwJj
 BB+CWxXd98dMfcVKLuE6WBGP3tWmQMPF1jaIsPCAP/5hSNOSi0wAxKsyNKOpEY1qmhTXiANeT1T
 ZgEEU4qos4848JIsJtjma1pl+0GJynXGYtd1B1qyYuA9k5VXxoYAivxfbc+svmhyOH3zND9EwZB
 ielzT8pKht/9AQqcAfjrYadfDqQOJ/YTMYNYuU5rX9Xhotyr6wExUyrKRJKw0YFfobvW/peO748
 M+fK0U2KZ/bZsXJfi+RGUCxAorb4hAHXaycaukP2G60apIlgjBrgu7SjYdkS6OTQIov5vO77wJ6
 hr/+ZlZ9ip4jCMeB05YbT3nXXXOo/0WfjyCeR43I4ROX3r8i7cFLufIjhAEJbS2+4CsVCz3BwX6
 +PKO+mb0quQw==
X-Received: by 2002:a05:6820:1b18:b0:68b:cadc:4340 with SMTP id
 006d021491bc7-68be604a404mr4863543eaf.18.1776009827198; 
 Sun, 12 Apr 2026 09:03:47 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:46 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:34 -0600
Subject: [PATCH 11/17] bsd-user: Add bsd-ioctl.c infrastructure and termios
 conversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260412-ioctl-v1-11-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>, Sean Bruno <sbruno@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8449; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=bk41F2WqzI69O5FRTdWBtdF3GnnfoknoNTPXwZvfnHA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IgfarNv73DL2k9PA4oni8enRnPDBde/ocOO
 pT7rY7TnqaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIAAKCRBsHNEofbAR
 AAZsD/0QZM7SZw5CgkQjthEuauGAQBp0w7Y3fvJKI4hDejHee15hIq1k8If2Nda1YS1D/j/HfmC
 yns0z79ERPkQBL8MCpnic/rIpdCHgAYACWIGjhYrZy+yCWT5BSOu0btmxtUpR1HYNTaj8SJAPND
 g5P7nlySaXwwJDjxpv6QrgeTFD0THybnPtid5g4cH+Jc+CnT9QMfxWWNgd+Zh/RQo8V7q8Alejd
 97qtM2g+/lOFe02rApnEgGgGEqzrpFleqGyBlCwJlu+s2BBWFPELWe/DvHXyBLuroKpppH2+K1+
 /lJBJmHKopu/E4ZrnZ9ckRfOwDSeJTQaNxn0ea15RUcPvHmatSKJkaeoEzRCeCJKS3+ZSfZJhsk
 Hm4tbu53DHwHjCIOW9eweofjkdEiXl+HnT3gKCVnJ7mWPhF5i7SBySsiVijA4WUBPLcvf3ce8mK
 2M7HORS6YqPmSwlOdA8ZoyB/alU1job4vdwle375DmscvWt3VXtjc6o9zHBWerOEHgI6k2+avci
 NqtxNpCBCEz8gDiS9k06lkhLXdSVzm3fjDfVK8aIdcrnVQ2LKWqA1fGeDLv8u32JEVcYPYhOOfp
 WxctC9mXqM8LJ40UajB1r0yOfZPetTrWkzhy5H0THI5ikbUuGBJMeWnaoGCG3m19UXCg1XT5QHh
 BxRpS34u8Z5qmHg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x31.google.com
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

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
---
 bsd-user/bsd-ioctl.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
new file mode 100644
index 0000000000..32fa9c3d33
--- /dev/null
+++ b/bsd-user/bsd-ioctl.c
@@ -0,0 +1,221 @@
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
+#include <net/ethernet.h>
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
+#include "os-ioctl-disk.h"
+#include "os-ioctl-filio.h"
+#include "os-ioctl-in6_var.h"
+#include "os-ioctl-sockio.h"
+#include "os-ioctl-ttycom.h"
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


