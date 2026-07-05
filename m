Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE513C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEct-0005qm-Jb; Sun, 05 Jul 2026 00:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEby-0004oP-Do
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbo-000448-BB
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2c821a50615so14986425ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226255; x=1783831055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGDPhHwhZn4CtpoFYLi1kN7SQDwt8mZK08F0u+/IPxo=;
 b=P4iDrzxuiqP9WkWRlO+s7/yDn94SvkU5cqghNu5oDBLM8XYLH2lazv2ogb2Z5l/wey
 Qdq5BRnLB+W5kiWoRj9Up4whQ6Wnj/gWAmg/AS+NTZTHFLoC0q8ujgmDtLhTv+PLIP/t
 1g+goHRNciltObCkgS2j4XkbaYaoJIHsHKDtE178Sx+ArEBYnmPwgR7d1xUaLz5PG6sP
 18L9gYksouRpi7Upzkw4Le4OWj6PMmLZRMcFlRBMOvBQ/60cKXSx9kg/M0bFs9mt6o1o
 Sxipl4861HHiNx+qW71CSz/nlKUsJPiJX/ffjvBYFfSZVbArYG/2Af5jcHMdCVmG2Tc2
 rEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226255; x=1783831055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IGDPhHwhZn4CtpoFYLi1kN7SQDwt8mZK08F0u+/IPxo=;
 b=iYsN94ePnwn0mY1lZzSrFiDtl4We+WWy/by5wznvese96FD2VV/cJIouqlTAwJ5T+R
 3akDfUZ26DluP68joyiiySAN/wAIdCguMlXIgvUkd/zkJAv/5mJfSPYSmZ4lsaeuC2La
 zQX1ma+JQrQtf6oDOFj4yN4njezsM8ej/SkVRMEsEVN0xCx/rtD0awOWBPzhILz2yPTU
 jkgtCq+PyKW+ClJ11Byj0PToRsZAqjjIE1PRQy1P+oSayX2x+Jo0F/ryR/AeaHgyb/F9
 l2LONuEgJ1HbUtnAZD9pnzXJNNSUF0CtDfHWIJ6tFZ4Ui7dp6PzlE/J7LIOJd15jiZ2u
 /5eg==
X-Gm-Message-State: AOJu0Yzy26wxMtyIBo+yvaxYv0bXjhNa8q4+2SavHgt1LCyUq85beoFX
 l7XbSl2bmxM73vpS+c+HkIkw2ovPVTIDP38tTsoCEMX67dEMeMRnpQtoHUpLxnaV7KsOm+2LEQA
 GHNt/
X-Gm-Gg: AfdE7clQZhpbgGxSPS6Y7TVucf7Afhb1LNfqWOSGoAwCEejkUTvTjrRXbIDcU9cChPJ
 avUL/aGS/6QCDeJ/vWzJeaW9WqtIPhrFUCb8EEJFJwECPLTpUjDNefpF+206yveBPu5wZw12SHk
 Nk+HuWyn674JVZrq3SqRcX9+2nbSeC07w6LZhnU5vTq5BbiFzTXBkR3Obyw9yb06gxcfaAr7UuW
 FOM7lHANeJvvs2AdFyY85wNrrkA/f/Cc3Ajbb/HBQjfdn4gRagi0L/EM3BD+yT0Us6+TokNl5mi
 eQqeRQ0gDhdmVGU1QWOLrp/RVKIKHitawpE/DvVf3jJZ9Mh4EO7mRYsMEi2qUWze49+M0dZgEia
 Kz3xyPx1jXl8pRxycmP1r7X+1KaRaiN1W2/XpGNXZ1SYs5WctG7SL9G8J+dYtNKuQaCsxtnwVky
 G7JBU0u+BVd+lbEtx0ke1Drjko1rw0tM4NxXFV9CumXuw9bcbD3S3j9Qwqng==
X-Received: by 2002:a17:902:f60a:b0:2c7:f12d:5d37 with SMTP id
 d9443c01a7336-2cbb9e264d9mr49486075ad.17.1783226254795; 
 Sat, 04 Jul 2026 21:37:34 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 09/46] hw/core/cpu: Remove exec/breakpoint.h include
Date: Sat,  4 Jul 2026 21:36:48 -0700
Message-ID: <20260705043725.1373137-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

This is no longer required in the generic header.  Add includes
where required elsewhere in the code base.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h     | 1 -
 accel/tcg/tcg-accel-ops.c | 1 +
 cpu-common.c              | 1 +
 gdbstub/system.c          | 1 +
 gdbstub/user.c            | 1 +
 target/i386/kvm/kvm.c     | 1 +
 target/ppc/kvm.c          | 1 +
 target/s390x/kvm/kvm.c    | 1 +
 target/xtensa/helper.c    | 1 +
 9 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 160db776d8..ca0b0c7978 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -22,7 +22,6 @@
 
 #include "hw/core/qdev.h"
 #include "disas/dis-asm.h"
-#include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 38e0a038c4..5c30a7be88 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -31,6 +31,7 @@
 #include "accel/tcg/cpu-loop.h"
 #include "system/tcg.h"
 #include "system/replay.h"
+#include "exec/breakpoint.h"
 #include "exec/icount.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
diff --git a/cpu-common.c b/cpu-common.c
index ba2676cbad..af64bb1126 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "exec/cpu-common.h"
+#include "exec/breakpoint.h"
 #include "hw/core/cpu.h"
 #include "qemu/lockable.h"
 #include "trace/trace-root.h"
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 2063b63b2f..0b810477ee 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -15,6 +15,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "exec/gdbstub.h"
+#include "exec/breakpoint.h"
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 97eb13e796..05fe18f906 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -14,6 +14,7 @@
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
+#include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/commands.h"
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 64cc421abe..54bee753fa 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -68,6 +68,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "migration/blocker.h"
+#include "exec/breakpoint.h"
 #include "exec/memattrs.h"
 #include "exec/target_page.h"
 #include "trace.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2a3711fb1d..c44edac41f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -40,6 +40,7 @@
 #include "system/watchdog.h"
 #include "trace.h"
 #include "gdbstub/enums.h"
+#include "exec/breakpoint.h"
 #include "exec/memattrs.h"
 #include "system/ramblock.h"
 #include "system/hostmem.h"
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index fdef8f9e8a..9658534fa6 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -48,6 +48,7 @@
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/ebcdic.h"
+#include "exec/breakpoint.h"
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-hypercall.h"
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 5a0e865514..0db5502287 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -30,6 +30,7 @@
 #include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
+#include "exec/breakpoint.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-loop.h"
-- 
2.43.0


