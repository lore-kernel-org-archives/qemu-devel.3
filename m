Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D5BC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQ0N-0000kE-Hk; Wed, 12 Jun 2024 11:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ0J-0000Px-T3
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:35:15 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ0G-0004JT-1g
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:35:15 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57c83100bd6so4658978a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718206509; x=1718811309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KVKwzv6PSKKY2fr+KeYYMd1xy6tDc4gIj3OlrlQ7yw=;
 b=TUCEPz+tdZ2I6nObV8OnsrYPwdq9khWIHo6z4DhU345LdyDdIlDeLaGZZrm6c2gMoU
 dOvRnbkdjz7Msb0kC+6F0WodxtO59DNXEi7Bx+GL1sCtZGhZlr6VNWNRx3Z3UG8ddNj2
 VbLQYCDXyRfqLh6C39OXsdfgnJ3vGlQtuXu6bzvkVvbmEvmBi4IwvgPLq1LMQbtSnQuv
 Rhw12Vfaet/U8LToO+uBFFbL3xDOah9DqVMC6D2hKTChrbd4uj21cQj9MNBb/hDOnRT2
 zBopOTGSFiwbnpPAVnYnRUm4ubVPeQRiEiXMp9JvB7vLKmw/L7qTPPFRWWlZK023cxFp
 kIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718206509; x=1718811309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1KVKwzv6PSKKY2fr+KeYYMd1xy6tDc4gIj3OlrlQ7yw=;
 b=FF9VVUCQYEMpkH/rFTrNx5oxyc7efyxy8Hx8IpebYdRqtKM5V3N3+CC+v2kpeVhDdu
 jZGsNOD89uQyilOWwHWc7p7CMP3/VW/tosjBV5nlP6FxDaq6z6ca25AYS0S8wA5R8pMu
 7MnLbK4tj9comWB28/ElBwFvgaBQi8EFsgWlJDSbeMtdUOc7k5HIa9UN/cnRq1BC0O4/
 XwNDgdpibM6+HxPSMu9QaxjO17r5fnBZQRUqRr+SJnEWlV/2MKiKv7t1SZwtLEyhVG6E
 b6vf20Fq0ktzfgF8qFx3NUpsgE9k8IxVfWSfsOJrg6ZabuBTbsJuIuF5cejNCBX2FMoU
 zt4g==
X-Gm-Message-State: AOJu0Yw1dGsgFp8UGkQzNuQyCdgrsPDA3YOa22Np4hBLEiXQAfFhZOvV
 P+EUMDLbGPEzeIPGYRzIOLK/4gfBjeqxUL6xNi0v+8IpNj6jaO0UnFRwpv5mwOM=
X-Google-Smtp-Source: AGHT+IHdD1zUvLC5libXDtJeYvV0M22MB4IFlxxI8NI0tRbpAFP6x9W6SyugUDKf6QoX0qd+4pE2SA==
X-Received: by 2002:a50:d6dc:0:b0:57c:5b7a:87e7 with SMTP id
 4fb4d7f45d1cf-57ca976c727mr1437158a12.14.1718206509408; 
 Wed, 12 Jun 2024 08:35:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c8f3a0c33sm3824158a12.82.2024.06.12.08.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 08:35:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5FD225F93C;
 Wed, 12 Jun 2024 16:35:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/9] gdbstub: move enums into separate header
Date: Wed, 12 Jun 2024 16:35:01 +0100
Message-Id: <20240612153508.1532940-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240612153508.1532940-1-alex.bennee@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is an experiment to further reduce the amount we throw into the
exec headers. It might not be as useful as I initially thought because
just under half of the users also need gdbserver_start().

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h    |  9 ---------
 include/gdbstub/enums.h   | 21 +++++++++++++++++++++
 accel/hvf/hvf-accel-ops.c |  2 +-
 accel/kvm/kvm-all.c       |  2 +-
 accel/tcg/tcg-accel-ops.c |  2 +-
 gdbstub/user.c            |  1 +
 monitor/hmp-cmds.c        |  3 ++-
 system/vl.c               |  1 +
 target/arm/hvf/hvf.c      |  2 +-
 target/arm/hyp_gdbstub.c  |  2 +-
 target/arm/kvm.c          |  2 +-
 target/i386/kvm/kvm.c     |  2 +-
 target/ppc/kvm.c          |  2 +-
 target/s390x/kvm/kvm.c    |  2 +-
 14 files changed, 34 insertions(+), 19 deletions(-)
 create mode 100644 include/gdbstub/enums.h

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 008a92198a..1bd2c4ec2a 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -1,15 +1,6 @@
 #ifndef GDBSTUB_H
 #define GDBSTUB_H
 
-#define DEFAULT_GDBSTUB_PORT "1234"
-
-/* GDB breakpoint/watchpoint types */
-#define GDB_BREAKPOINT_SW        0
-#define GDB_BREAKPOINT_HW        1
-#define GDB_WATCHPOINT_WRITE     2
-#define GDB_WATCHPOINT_READ      3
-#define GDB_WATCHPOINT_ACCESS    4
-
 typedef struct GDBFeature {
     const char *xmlname;
     const char *xml;
diff --git a/include/gdbstub/enums.h b/include/gdbstub/enums.h
new file mode 100644
index 0000000000..c4d54a1d08
--- /dev/null
+++ b/include/gdbstub/enums.h
@@ -0,0 +1,21 @@
+/*
+ * gdbstub enums
+ *
+ * Copyright (c) 2024 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef GDBSTUB_ENUMS_H
+#define GDBSTUB_ENUMS_H
+
+#define DEFAULT_GDBSTUB_PORT "1234"
+
+/* GDB breakpoint/watchpoint types */
+#define GDB_BREAKPOINT_SW        0
+#define GDB_BREAKPOINT_HW        1
+#define GDB_WATCHPOINT_WRITE     2
+#define GDB_WATCHPOINT_READ      3
+#define GDB_WATCHPOINT_ACCESS    4
+
+#endif /* GDBSTUB_ENUMS_H */
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b2a37a2229..ac08cfb9f3 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -52,7 +52,7 @@
 #include "qemu/main-loop.h"
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
-#include "exec/gdbstub.h"
+#include "gdbstub/enums.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hvf.h"
 #include "sysemu/hvf_int.h"
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 009b49de44..5680cd157e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -27,7 +27,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/s390x/adapter.h"
-#include "exec/gdbstub.h"
+#include "gdbstub/enums.h"
 #include "sysemu/kvm_int.h"
 #include "sysemu/runstate.h"
 #include "sysemu/cpus.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 1433e38f40..3c19e68a79 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -35,7 +35,7 @@
 #include "exec/exec-all.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
-#include "exec/gdbstub.h"
+#include "gdbstub/enums.h"
 
 #include "hw/core/cpu.h"
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index edeb72efeb..e34b58b407 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -18,6 +18,7 @@
 #include "exec/gdbstub.h"
 #include "gdbstub/syscalls.h"
 #include "gdbstub/user.h"
+#include "gdbstub/enums.h"
 #include "hw/core/cpu.h"
 #include "trace.h"
 #include "internals.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index ea79148ee8..067152589b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -15,8 +15,9 @@
 
 #include "qemu/osdep.h"
 #include "exec/address-spaces.h"
-#include "exec/gdbstub.h"
 #include "exec/ioport.h"
+#include "exec/gdbstub.h"
+#include "gdbstub/enums.h"
 #include "monitor/hmp.h"
 #include "qemu/help_option.h"
 #include "monitor/monitor-internal.h"
diff --git a/system/vl.c b/system/vl.c
index a3eede5fa5..cfcb674425 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -68,6 +68,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/hostmem.h"
 #include "exec/gdbstub.h"
+#include "gdbstub/enums.h"
 #include "qemu/timer.h"
 #include "chardev/char.h"
 #include "qemu/bitmap.h"
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 45e2218be5..ef9bc42738 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -33,7 +33,7 @@
 #include "trace/trace-target_arm_hvf.h"
 #include "migration/vmstate.h"
 
-#include "exec/gdbstub.h"
+#include "gdbstub/enums.h"
 
 #define MDSCR_EL1_SS_SHIFT  0
 #define MDSCR_EL1_MDE_SHIFT 15
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index ebde2899cd..f120d55caa 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internals.h"
-#include "exec/gdbstub.h"
+#include "gdbstub/enums.h"
 
 /* Maximum and current break/watch point counts */
 int max_hw_bps, max_hw_wps;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7cf5cf31de..70f79eda33 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -31,7 +31,7 @@
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
-#include "exec/gdbstub.h"
+#include "gdbstub/enums.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
 #include "qapi/visitor.h"
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 912f5d5a6b..a666129f41 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -38,7 +38,7 @@
 #include "hyperv.h"
 #include "hyperv-proto.h"
 
-#include "exec/gdbstub.h"
+#include "gdbstub/enums.h"
 #include "qemu/host-utils.h"
 #include "qemu/main-loop.h"
 #include "qemu/ratelimit.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 005f2239f3..2c3932200b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -39,7 +39,7 @@
 #include "migration/qemu-file-types.h"
 #include "sysemu/watchdog.h"
 #include "trace.h"
-#include "exec/gdbstub.h"
+#include "gdbstub/enums.h"
 #include "exec/memattrs.h"
 #include "exec/ram_addr.h"
 #include "sysemu/hostmem.h"
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 1b494ecc20..94181d9281 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -40,7 +40,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
 #include "sysemu/device_tree.h"
-#include "exec/gdbstub.h"
+#include "gdbstub/enums.h"
 #include "exec/ram_addr.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-inst.h"
-- 
2.39.2


