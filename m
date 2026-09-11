Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E43FC88E5B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50MX-0007g6-8L; Fri, 11 Sep 2026 08:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50MU-0007dV-3O
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50MS-00076G-BJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789129687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOC7Y6WekuVCrNKqrt6rXK2o/HI47jMFwaaVFHSzoKw=;
 b=DwReLtWzmYEaMdfWWW3UVg14RZa6hPZS2X/8h9LBmLOX7gcz+br3sPgQAAMQNRy9PCqX2Y
 MFcf9ECZ2GbzVA2V8mJ71twTApcEddhxUGXKTwO7KSN7Rch7E40V4D+fZHYpykBF05j0w4
 VQR7967Jd8TKc5y/LGozLedgHdfKF6g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-zDViNNA3MnSZjCItWYvUGw-1; Fri,
 11 Sep 2026 08:28:04 -0400
X-MC-Unique: zDViNNA3MnSZjCItWYvUGw-1
X-Mimecast-MFC-AGG-ID: zDViNNA3MnSZjCItWYvUGw_1789129681
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEE6518011D5; Fri, 11 Sep 2026 12:28:00 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B7BD91800581; Fri, 11 Sep 2026 12:27:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 16:27:30 +0400
Subject: [PATCH 07/10] target/sparc64: expose system registers via GDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-query-reg-v1-7-0c04f0c02cf3@redhat.com>
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
In-Reply-To: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4140;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8Ys6+eVwTHB6L74vHtWq0qM5qyKtpTXiP0Nl0oR9qX0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqo/OvV1cFJ9QLWjhOt9OzTWPkGVDkye8ODKKIH
 CVgAciZvu2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqPzrwAKCRDa6OEJdZac
 5RJREACCFZSZlYJV9ngwTThkQliyjoF1j6SJxaxPG+HJfEW55rXUTZlq1HdlHuVgYUpiksqOczX
 fYn3/XZ9Oqos6786ggfL7mO/aGZ4dE/D7JHQlXBwZhe8VmaB2bVno2CnlTmJejGJK+1Xw+y1sHB
 kT6P1uUJacgUc+n+DUnNADZsIqK1e+YrogG7QxjKMUw/4F/8X7stWJ17SgUb/nJks3z1CMqBIrr
 c//MoIBnJMnfifB1RHsxElhrbWpffsqGqyaNNvWzqB4ctkOkcNsmd4/tS4A1MM165l6L7Cjd5lu
 ggOPSKBqvc0rM5iT/JCZpfrOjhtMA2jRllhrN2EQGr2z322Dy9cmHIaApL+fev0RDfhKr6t5ZD6
 c1ADNNpe70keUjQbLL/bhJ39P6kxr2zL5i2ZQNApXkNjKjNx+vyMBgxUsDpDR5gPxg/Ewnzfqjn
 a2IdckGgdkbRj2dvqT6datX2RkAajQRYT5KgKHlNmLQ/jxwWR8o7MMpjTRYztwq4yILhmX6mqTj
 3+G4w/KdBpc4RLvpNovACo59+Ejl0PJ7YS1sR/EXo9qjNPZTYxzbdPK7+PROtl17K19CP81zYO0
 GqL+TOCRpGQNMAj69K8R+7LbwMOvYPyE1RF9kMb4admEbsNPS5GIqgI2EFe6fUz85c3DTCTlmGK
 O3rhv7IdVWKbpWQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a sparc64-system.xml GDB feature that exposes asi, pstate,
cansave, canrestore, otherwin, wstate, and cleanwin as read-only
system registers through the GDB coprocessor interface.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configs/targets/sparc64-softmmu.mak |  2 +-
 gdbstub/gdb-xml/sparc64-system.xml  | 22 +++++++++++++++++++++
 target/sparc/gdbstub.c              | 38 +++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

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
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 2874ce1b3501..ca23a4a94532 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -266,6 +266,39 @@ static int sparc_cp0_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #endif
 }
 
+#if defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
+static int sparc64_gdb_read_system_register(CPUState *cs, GByteArray *buf,
+                                           int n)
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
+    gdb_register_coprocessor(cs, sparc64_gdb_read_system_register,
+                             sparc64_gdb_write_system_register,
+                             gdb_find_static_feature("sparc64-system.xml"));
+#endif
 #endif
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


