Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32F606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YtmBnrdM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqU2-0003Ej-M4; Thu, 22 Oct 2026 06:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqU1-0003EK-OS
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqTz-0001VI-Jc
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESCmvJu2gqS6Z8pPMNRJcIJDVBJOTZgbBtoQ3FBj7Io=;
 b=YtmBnrdMPu4FVEN8VmM962M5GCuSEjjzBIL5BSNOUcXVkzTOXERDYxL+kBZHhGEgpV9LRK
 sAqFvRJNTUgFmqs1dk8NYuni/aViCuDcF1gk4CEjdkJMJCzNkru9cnG/GMx3BiaQSVYVi2
 LjBo+D/AblN+wugjUdncgrQ3xO3LbSw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-v6rkgJm_M-ScbiLFvrc6Uw-1; Thu,
 22 Oct 2026 10:57:11 +0000
X-MC-Unique: v6rkgJm_M-ScbiLFvrc6Uw-1
X-Mimecast-MFC-AGG-ID: v6rkgJm_M-ScbiLFvrc6Uw_1792666628
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 230771956050; Thu, 22 Oct 2026 10:57:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EEA1195608C; Thu, 22 Oct 2026 10:57:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:33 +0400
Subject: [PATCH v3 06/18] target/i386: expose segment limits register to
 monitors via gdbstub
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-6-7ad902b9a7cf@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4586;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PGZ6+YaAF1dYuldZi9TpIczkb/orrxgKoj0GM9a1uVM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evmQ3tW0J02KK1HFNkKLRr+h1Rpiobtl9orP
 WNfwpeOPp+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5gAKCRDa6OEJdZac
 5Wo4D/0ROhQ/rBsZZS25NKz8CproUQYoTLh+UzyyaWKxw0BsBjGXXifJ7nklP3NWRTvLoeY9Bmv
 /IlTyvoc45zLk+uV7k+b2Nf7lGap37gRX6lDuWtFb4HrFWb4LAYn+VfV2c+XLCMq9F164WCvMt8
 vGh9ET93w4U3o9xthtRRWy+Z6mwWhTHkeP+EKm8O1lN0omZYSoAvt+E+cnnnEFVYGMwgARlPRxH
 WRuR8FQnDSdZno05FIETpZb0Eg3t9lSm/H/ldTyh/gcQRLyB7TSPQYaxTSHARMQ5zasHl/gJAWf
 Ldw0FkU6SPRITxu6xHVwvdxysYcpcdF6H4QsjR4mIh/RFdZD6mtjRRq4hMxF4aj1TyYePErblTl
 2BdgI2eP/XeLAITmpqhQnCYtfeqKLmKjSJrhtVC2qAL1A6yYhXJFibN80uRd2RBBs+A2WVWRoni
 +mMu5EhbOttAhf39jfzyTWodTozT10YiVih/ypdn0q+NEQ3yTlEADXBwIGoaEBsrZVkAD9AM0hz
 7HFPOvj+x4tIyVZXf9LHupqbW83y7jSDnyPPkIU9fX5wcYrFekZwpezycyDBV4bPy7XtdBPife9
 aWpRHWIVOAkHZ2dxWWkSJCE2HZvesCybyvCS7ZbZXbxprjgPqxKDT+hrQ2zf3cNi2UL8AbH4F79
 16jzB4ht42m6ogg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add an i386-system.xml GDB "internal" feature that exposes the six
segment limit registers (cs, ds, es, ss, fs, gs) as read-only system
registers through the GDB coprocessor interface. This makes them
accessible to HMP without relying on the legacy MonitorDef table, which
will be removed in a subsequent commit.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configs/targets/i386-softmmu.mak   |  2 +-
 configs/targets/x86_64-softmmu.mak |  2 +-
 gdbstub/gdb-xml/i386-system.xml    | 14 ++++++++++++++
 target/i386/cpu.c                  |  9 ---------
 target/i386/gdbstub.c              | 25 +++++++++++++++++++++++++
 5 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 38a8f85201f9..1424ab6f6834 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
-TARGET_XML_FILES= i386-32bit.xml
+TARGET_XML_FILES= i386-32bit.xml i386-system.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index c7f8746b4f58..51e882b1c747 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
-TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml i386-system.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/gdbstub/gdb-xml/i386-system.xml b/gdbstub/gdb-xml/i386-system.xml
new file mode 100644
index 000000000000..9868b887eab8
--- /dev/null
+++ b/gdbstub/gdb-xml/i386-system.xml
@@ -0,0 +1,14 @@
+<?xml version="1.0"?>
+<!--
+  SPDX-License-Identifier: GPL-2.0-or-later
+-->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<!-- Segment-cache values are read-only; writes are ignored. -->
+<feature name="org.qemu.gdb.i386.system">
+  <reg name="cs.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="ds.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="es.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="ss.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="fs.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="gs.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+</feature>
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5da80ade70eb..37732b65e408 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10893,17 +10893,8 @@ static int64_t monitor_get_pc(MonitorHMP *hmp, const struct MonitorDef *md,
 }
 
 static const MonitorDef x86_monitor_defs[] = {
-#define SEG(name, seg) \
-    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
-    SEG("cs", R_CS)
-    SEG("ds", R_DS)
-    SEG("es", R_ES)
-    SEG("ss", R_SS)
-    SEG("fs", R_FS)
-    SEG("gs", R_GS)
     { "pc", 0, monitor_get_pc, },
     { NULL },
-#undef SEG
 };
 #endif
 
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index e636ca0f4ae7..c0cde26d978c 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -496,6 +496,25 @@ static int i386_cpu_gdb_set_egprs(CPUState *cs, uint8_t *mem_buf, int n)
 }
 #endif
 
+#ifndef CONFIG_USER_ONLY
+static int x86_gdb_read_system(CPUState *cs, GByteArray *buf, int n)
+{
+    CPUX86State *env = cpu_env(cs);
+    static const int segments[] = { R_CS, R_DS, R_ES, R_SS, R_FS, R_GS };
+
+    if (n < 0 || n >= ARRAY_SIZE(segments)) {
+        return 0;
+    }
+    return gdb_get_reg32(buf, env->segs[segments[n]].limit);
+}
+
+static int x86_gdb_write_system(CPUState *cs, uint8_t *buf, int n)
+{
+    /* Segment caches are exposed for inspection only. Ignore writes. */
+    return 4;
+}
+#endif
+
 void x86_cpu_gdb_init(CPUState *cs)
 {
 #ifdef TARGET_X86_64
@@ -517,4 +536,10 @@ void x86_cpu_gdb_init(CPUState *cs)
                              gdb_find_static_feature("i386-32bit-linux.xml"));
 #endif
 #endif
+#ifndef CONFIG_USER_ONLY
+    gdb_register_internal_coprocessor(
+        cs, x86_gdb_read_system,
+        x86_gdb_write_system,
+        gdb_find_static_feature("i386-system.xml"));
+#endif
 }

-- 
2.56.0.116.g6de20f6092dc


