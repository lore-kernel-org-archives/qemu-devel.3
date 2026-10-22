Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8B606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aFG6JxR+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqUU-0003eh-Ng; Thu, 22 Oct 2026 06:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUS-0003dO-Mq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUQ-0001bp-EN
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWNRZB5WNkEXU6IF7jyqgb8IH8X8gm8RNRZC4r7nEY8=;
 b=aFG6JxR+tbRst+QrfkuKrLORXxTJYsHjj7OUsXG+W3dQHnKMeQMLC+K6JD5vc0HMUnxqLR
 MmQMKkFcPX7isXNpLDJ5YY85j1ExzJk1ouxSsuvQTseteOKd6hWU67tkJWwlKAGieCRabr
 j2SFc6zAD6gIYHz6SPIDJBOb4yY2tHk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-wRjTJ1LLMaGMbmg72C334Q-1; Thu,
 22 Oct 2026 10:57:36 +0000
X-MC-Unique: wRjTJ1LLMaGMbmg72C334Q-1
X-Mimecast-MFC-AGG-ID: wRjTJ1LLMaGMbmg72C334Q_1792666653
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ED30180059B; Thu, 22 Oct 2026 10:57:33 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BCA418001CA; Thu, 22 Oct 2026 10:57:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:40 +0400
Subject: [PATCH v3 13/18] target/m68k: expose system registers to monitors
 via gdbstub
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-13-7ad902b9a7cf@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6440;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YEGQk+Kr4OYoLSh1J3PGoDFmqRNt4E0Gb60b7pwVF4k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evm7o6GGVCKli6tvdo9IBh2TQ/36K3STJMVO
 p+4ijEttBSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5gAKCRDa6OEJdZac
 5YPOD/9jc7e4cD7YUnbrJqbrkjxrAHkl/pax8X95fd05SM2PcQqhoPtahRvMiwmFXejQsdqFclc
 yYpDaepEXXFStKk0C1+uS3TRrya8zPwdR3GRgIzA4HM7d3kb9EECfuow2YhXBulayeNkAu/aziW
 v3sNcOSU+OoM4UgCuV4Ssvru6/GaEI3zRml5+UsJunStmodf57ebT1hT/eTTe2F9vuK8RWryHix
 pALDL98m2h+A+bxAl4BpQ1ByDYzk/bUMcg7BLbX8mTHLosPGEccHhEfUGVMQuUE7+IAgkqMjpbj
 IFveUuGkHQdVdAJxKTIxL85XB0QdanT6U/xyTAGsCcmDkYAnRnOtP06GaSodcu72bDUQ2PNLBnE
 Ol0smFB2Ln//AgERzam9BnC8wiJMUPRD2qyebXj/HDQBH3XLMh+LcaseN5qtp+Lz7jbkUhNXdyN
 QDBaaCpXHIdmxQR67yMHFQM3jzzCHBZQgSJbqXg41Lss9JL5THZ50dB5eookxDXpWpM7vezSehg
 l/YQV8top54r5I8/ueNz0wSnRNNsO5XGYVGG6dAq8BoxlwIaTqlxerZLVDT6HHxYVBhgKxOPwTF
 iBoc7hzyF/4U48WWDLIO13YOiATNITE4RjXYQggHu1VRHkAUxjwpgCUzmS2FUFKt31nwxoIPEsb
 Bdg+wghur8gEMpQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the HMP-specific MonitorDef with a GDB feature that exposes
supervisor stack pointers (ssp, usp, isp), function code registers (sfc,
dfc), MMU registers (urp, srp, dttr0/1, ittr0/1, mmusr) as read-only
system registers through the internal GDB coprocessor interface.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configs/targets/m68k-softmmu.mak |  2 +-
 gdbstub/gdb-xml/m68k-system.xml  | 32 ++++++++++++++++++++++++++
 target/m68k/cpu.c                | 22 ------------------
 target/m68k/helper.c             | 49 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/configs/targets/m68k-softmmu.mak b/configs/targets/m68k-softmmu.mak
index 0bc889f326e3..f3ac9b74c862 100644
--- a/configs/targets/m68k-softmmu.mak
+++ b/configs/targets/m68k-softmmu.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=m68k
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml
+TARGET_XML_FILES= cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml m68k-system.xml
 TARGET_LONG_BITS=32
diff --git a/gdbstub/gdb-xml/m68k-system.xml b/gdbstub/gdb-xml/m68k-system.xml
new file mode 100644
index 000000000000..0a91be0edc00
--- /dev/null
+++ b/gdbstub/gdb-xml/m68k-system.xml
@@ -0,0 +1,32 @@
+<?xml version="1.0"?>
+<!--
+  SPDX-License-Identifier: GPL-2.0-or-later
+-->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<!-- System-register values are read-only; writes are ignored. -->
+<feature name="org.qemu.gdb.m68k.system">
+  <reg name="ssp" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="usp" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="isp" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="sfc" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="dfc" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="urp" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="srp" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="dttr0" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="dttr1" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="ittr0" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="ittr1" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="mmusr" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+</feature>
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9b52ad5fc234..ad7303305848 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -25,7 +25,6 @@
 #include "disas/capstone.h"
 #ifndef CONFIG_USER_ONLY
 #include "migration/vmstate.h"
-#include "monitor/hmp.h"
 #endif
 
 #include "cpu.h"
@@ -666,32 +665,11 @@ static const VMStateDescription vmstate_m68k_cpu = {
     },
 };
 
-#ifdef CONFIG_HMP
-static const MonitorDef m68k_monitor_defs[] = {
-    { "ssp", offsetof(CPUM68KState, sp[0]) },
-    { "usp", offsetof(CPUM68KState, sp[1]) },
-    { "isp", offsetof(CPUM68KState, sp[2]) },
-    { "sfc", offsetof(CPUM68KState, sfc) },
-    { "dfc", offsetof(CPUM68KState, dfc) },
-    { "urp", offsetof(CPUM68KState, mmu.urp) },
-    { "srp", offsetof(CPUM68KState, mmu.srp) },
-    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
-    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
-    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
-    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
-    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
-    { NULL },
-};
-#endif
-
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
     .has_work = m68k_cpu_has_work,
     .get_phys_addr_debug = m68k_cpu_get_phys_addr_debug,
-#ifdef CONFIG_HMP
-    .monitor_defs = m68k_monitor_defs,
-#endif
 };
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5f91d206f596..1a29eaaf37f6 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -123,6 +123,48 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
+#ifndef CONFIG_USER_ONLY
+static int m68k_gdb_read_system_register(CPUState *cs, GByteArray *buf, int n)
+{
+    CPUM68KState *env = cpu_env(cs);
+    static const int stacks[] = { M68K_SSP, M68K_USP, M68K_ISP };
+
+    if (n >= 0 && n < ARRAY_SIZE(stacks)) {
+        int sp = stacks[n];
+
+        return gdb_get_reg32(buf, env->sp[sp]);
+    }
+    switch (n) {
+    case 3:
+        return gdb_get_reg32(buf, env->sfc);
+    case 4:
+        return gdb_get_reg32(buf, env->dfc);
+    case 5:
+        return gdb_get_reg32(buf, env->mmu.urp);
+    case 6:
+        return gdb_get_reg32(buf, env->mmu.srp);
+    case 7:
+        return gdb_get_reg32(buf, env->mmu.ttr[M68K_DTTR0]);
+    case 8:
+        return gdb_get_reg32(buf, env->mmu.ttr[M68K_DTTR1]);
+    case 9:
+        return gdb_get_reg32(buf, env->mmu.ttr[M68K_ITTR0]);
+    case 10:
+        return gdb_get_reg32(buf, env->mmu.ttr[M68K_ITTR1]);
+    case 11:
+        return gdb_get_reg32(buf, env->mmu.mmusr);
+    default:
+        return 0;
+    }
+}
+
+static int m68k_gdb_write_system_register(CPUState *cs, uint8_t *buf, int n)
+{
+    /* These registers are exposed for inspection only. Ignore writes. */
+    return 4;
+}
+#endif
+
 void m68k_cpu_init_gdb(M68kCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -135,7 +177,12 @@ void m68k_cpu_init_gdb(M68kCPU *cpu)
         gdb_register_coprocessor(cs, m68k_fpu_gdb_get_reg, m68k_fpu_gdb_set_reg,
                                  gdb_find_static_feature("m68k-fp.xml"));
     }
-    /* TODO: Add [E]MAC registers.  */
+    /* TODO: Add [E]MAC registers. */
+#ifndef CONFIG_USER_ONLY
+    gdb_register_internal_coprocessor(cs, m68k_gdb_read_system_register,
+                                      m68k_gdb_write_system_register,
+                                      gdb_find_static_feature("m68k-system.xml"));
+#endif
 }
 
 void HELPER(cf_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)

-- 
2.56.0.116.g6de20f6092dc


