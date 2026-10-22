Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7A606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JKCy+Zf8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqUY-0003hr-J5; Thu, 22 Oct 2026 06:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUW-0003fo-2q
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUT-0001cT-Qq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Gu8UrZonIkC3QcH/XvFPyD/Vf39gwyrS2GjjVD5/60=;
 b=JKCy+Zf8Rajc8jS27FYwv3eVZDu15jQZ2DX5JOGbKrGGRV4GWrr/wFYi4k7K/4SnMO4XPH
 P+FXdZKo1CdkY7fUNTz+xrrAy6fK2crVLJExSH1MCdBJwMZFiqPr0CudJ+crOMSVlY+BEW
 wv7sw4pYMMSOAxCjIDC4ljLJqlOolm0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-7X9o_BvQNqG1U8BTVgatPg-1; Thu,
 22 Oct 2026 06:57:39 -0400
X-MC-Unique: 7X9o_BvQNqG1U8BTVgatPg-1
X-Mimecast-MFC-AGG-ID: 7X9o_BvQNqG1U8BTVgatPg_1792666656
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47EED1800615; Thu, 22 Oct 2026 10:57:36 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 711A25AA; Thu, 22 Oct 2026 10:57:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:41 +0400
Subject: [PATCH v3 14/18] target/sparc64: expose system registers to
 monitors via gdbstub
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-14-7ad902b9a7cf@redhat.com>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
In-Reply-To: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5421;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OD/4k2nUxQUESsQp2QzTVblTXy1ojM4LkemcaUMfJYc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evmuNM0lVLp3ir2BqQnzwpOjUe6L+dtZNn5q
 BprVn2rINmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5gAKCRDa6OEJdZac
 5X4FEACOT6xYHdlgQsgptc7IpHNZfjqcuS+4s9DjOPDj03OzetY2VeyLX9EVv28Ao51lXYlOnKp
 2xJrnlWNRFtOOqvNRM0F22yf8w6JXfAOfKGexTpONPN0iV0lYsk6Dj94odBewHOKh8SFI5dh9pS
 KEKTsu+23vUt/KfGeS4UgnwizIiB95c7RVZwWPIsXcmxRytDi2amrcqmRUMLbeiNjvYU6RhN1i8
 nV53huzvtQoal+O747uoC1Ev90/0y+pnx1b2he8G5aTxAtgfN59m/zZ5+e9VyWJaM9kEyfogXPi
 7sRdQ7GmyFtY4cm9sNAfvZcsY+L2z90hURJaDFWwUatYKJpBzGQKSNF0bI/ZfEEWnDRRxfl7zxL
 RjSnw7Z1pgvLLpRRfq0s+MdzvGmOgupY+7ltRuQUyxMrGQQEQxxsLuPcPV5Wm07D8ubz1x4Bfea
 4zMikPEUMxpva2srrFiOTzY+68tY8gbQpIVFcNn0xkNBLzY3O4YYhcDVqkXcth6EOuVCHTkTSB9
 vioAGdLZJG2zGGQs20e4ybW96ylOQ2BeZQxLwYH5sG1WtJCZxN+SwxD0HfcAYQ64qtR4F7avN8T
 5vR8Rn6gk6Y8PfBeckECN1DIWtQm+r6Ab9sDCYp/55l+siwlaGSCKMJQW8edhM13SxMRU4nL2z/
 9Z6cLPRzbTRXLAQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the HMP-specific MonitorDef with a GDB feature that exposes
asi, pstate, cansave, canrestore, otherwin, wstate, and cleanwin as
read-only system registers through the internal GDB coprocessor
interface.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configs/targets/sparc64-softmmu.mak |  2 +-
 gdbstub/gdb-xml/sparc64-system.xml  | 22 +++++++++++++++++++++
 target/sparc/cpu.c                  | 19 -------------------
 target/sparc/gdbstub.c              | 38 +++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index 4e621fb8e39e..7f2789136653 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=sparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml
+TARGET_XML_FILES=sparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml sparc64-system.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/gdbstub/gdb-xml/sparc64-system.xml b/gdbstub/gdb-xml/sparc64-system.xml
new file mode 100644
index 000000000000..e00baedb467e
--- /dev/null
+++ b/gdbstub/gdb-xml/sparc64-system.xml
@@ -0,0 +1,22 @@
+<?xml version="1.0"?>
+<!--
+  SPDX-License-Identifier: GPL-2.0-or-later
+-->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<!-- System-register values are read-only; writes are ignored. -->
+<feature name="org.qemu.gdb.sparc.system">
+  <reg name="asi" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="pstate" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="cansave" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="canrestore" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="otherwin" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="wstate" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="cleanwin" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+</feature>
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae9bdca9df82..89dfb091ca87 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -995,31 +995,12 @@ static const Property sparc_cpu_properties[] = {
 
 #ifndef CONFIG_USER_ONLY
 
-#ifdef TARGET_SPARC64
-#include "monitor/hmp.h"
-#ifdef CONFIG_HMP
-static const MonitorDef sparc64_monitor_defs[] = {
-    { "asi", offsetof(CPUSPARCState, asi) },
-    { "pstate", offsetof(CPUSPARCState, pstate) },
-    { "cansave", offsetof(CPUSPARCState, cansave) },
-    { "canrestore", offsetof(CPUSPARCState, canrestore) },
-    { "otherwin", offsetof(CPUSPARCState, otherwin) },
-    { "wstate", offsetof(CPUSPARCState, wstate) },
-    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-    { NULL },
-};
-#endif
-#endif
-
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
     .has_work = sparc_cpu_has_work,
     .get_phys_addr_debug = sparc_cpu_get_phys_addr_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
-#if defined(TARGET_SPARC64) && defined(CONFIG_HMP)
-    .monitor_defs = sparc64_monitor_defs,
-#endif
 };
 #endif
 
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 2874ce1b3501..c8aa74a4a8b7 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -266,6 +266,39 @@ static int sparc_cp0_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #endif
 }
 
+#if defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
+static int sparc64_gdb_read_system_register(CPUState *cs, GByteArray *buf,
+                                            int n)
+{
+    CPUSPARCState *env = cpu_env(cs);
+
+    switch (n) {
+    case 0:
+        return gdb_get_reg32(buf, env->asi);
+    case 1:
+        return gdb_get_reg32(buf, env->pstate);
+    case 2:
+        return gdb_get_reg32(buf, env->cansave);
+    case 3:
+        return gdb_get_reg32(buf, env->canrestore);
+    case 4:
+        return gdb_get_reg32(buf, env->otherwin);
+    case 5:
+        return gdb_get_reg32(buf, env->wstate);
+    case 6:
+        return gdb_get_reg32(buf, env->cleanwin);
+    default:
+        return 0;
+    }
+}
+
+static int sparc64_gdb_write_system_register(CPUState *cs, uint8_t *buf, int n)
+{
+    /* These registers are exposed for inspection only. Ignore writes. */
+    return 4;
+}
+#endif
+
 void sparc_cpu_register_gdb_regs(CPUState *cs)
 {
 #if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
@@ -282,5 +315,10 @@ void sparc_cpu_register_gdb_regs(CPUState *cs)
     gdb_register_coprocessor(cs, sparc_cp0_gdb_read_register,
                              sparc_cp0_gdb_write_register,
                              gdb_find_static_feature("sparc64-cp0.xml"));
+#ifndef CONFIG_USER_ONLY
+    gdb_register_internal_coprocessor(cs, sparc64_gdb_read_system_register,
+                                      sparc64_gdb_write_system_register,
+                                      gdb_find_static_feature("sparc64-system.xml"));
+#endif
 #endif
 }

-- 
2.56.0.116.g6de20f6092dc


