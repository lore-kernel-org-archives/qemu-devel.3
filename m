Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B683CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGMjm-0003MD-1x; Mon, 12 Oct 2026 16:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjk-0003L9-Ew
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMji-0003Ky-Ib
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791837305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KI6zkCDK6jxzISZwzK7y8pcfmvIDYrkBArJhoZ8yTW4=;
 b=UfaBbaKXB6/ddbbhdJwTZIYPjLn8zzZfCzFkUtiBCDGquMR/ix0XIu2KvRPksrFJhwMaWF
 kJ13ZqXrqgylK2G4EDXoTCbz1yZ1geqtOtcn8AAEwfONsZ4yyM5Bzr2/Uil9umpSvhQFhG
 K6iTrrJ/eg7Lphsh1EHrZat/rJtdBHs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-YiNYDXNiOSq7HKAFbbaIZw-1; Mon,
 12 Oct 2026 20:35:02 +0000
X-MC-Unique: YiNYDXNiOSq7HKAFbbaIZw-1
X-Mimecast-MFC-AGG-ID: YiNYDXNiOSq7HKAFbbaIZw_1791837298
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E9EF18021FF; Mon, 12 Oct 2026 20:34:58 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 451FF1956040; Mon, 12 Oct 2026 20:34:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 00:34:08 +0400
Subject: [PATCH v2 05/10] target/i386: expose segment limits via GDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-query-reg-v2-5-6f95a2e139a9@redhat.com>
References: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
In-Reply-To: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3992;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MLngmh22pK16NDCikInqFllLZ2YeVt3kfZpRRoITKSs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzURBQJJv2pxuj+RJgNi2+CS/Nm3jF/H5DykKZ
 PNi4fJqz8WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1EQQAKCRDa6OEJdZac
 5Qo5D/9kXG6wmcAQdxQcjfpO/FJQAEaFsH6sSIw3q84oWXhUnsjr0Q0cXpk1Yns1i1/tc/b6zQW
 sP6lwG1V6N1f4LxK2JEUBBb0/GfSR1RPViXKX3SYGqD+Y+IFAvxXRTxTIt9Jg99xbYxZcKwlqk4
 DStQiQPgYuVzwfK3Vkjn7IsvJoBPa8Qkaa2BtIpUTcZ2ubP7JKSCbA9YVlFOOPFVgR2YKjnlSNn
 6JBWj1sXiPHW2E7h3PTsoEl9y3wZbkjVXfuXYi0WhDFR61Wz9a+F2jLPcSxtdYFZFjFYv5/9/aR
 XWoivkpGE6Ky7ooDgRcf2Qzt7af5JNhZDB2+iY4OdIvNlm15OryjYweZ65be/Wnh6ww+xs1Os8D
 N7r2R6MWaxSd6Kd1CNa2lwqR5/+s7wJG6NoNWHkf48W6B6A4CYWbrSzYQLtlQaC9lIAh6tHswUX
 o0hGuFhQSYpArxjQHT5gqcYXyGeS3IbHCUzk24i0/fIicxy0Xvj91231GfhO9aQdN8JXMgwuzOF
 oUBcqANQC2onlR4hzmC3N37ucLJIrgHrxYmrXN6OEbRTg+km1JWUq2AB2inL4c+MbTAUnc93b6G
 IzJu7bOa7Wc3bvi44s6vJXV62dBZ2DfHQ9VrnQfgYqrOy92dy5//PqFlxCzKtzRj0m9GdUZizv9
 nY7cgG4NeiqCbog==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add an i386-segments.xml GDB feature that exposes the six segment
limit registers (cs, ds, es, ss, fs, gs) as read-only system
registers through the GDB coprocessor interface. This makes them
accessible to both GDB and HMP without relying on the legacy
MonitorDef table, which will be removed in a subsequent commit.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configs/targets/i386-softmmu.mak   |  2 +-
 configs/targets/x86_64-softmmu.mak |  2 +-
 gdbstub/gdb-xml/i386-segments.xml  | 14 ++++++++++++++
 target/i386/gdbstub.c              | 24 ++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 38a8f85201f9..89cdaa072ef7 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
-TARGET_XML_FILES= i386-32bit.xml
+TARGET_XML_FILES= i386-32bit.xml i386-segments.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index c7f8746b4f58..0af699971de0 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
-TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml i386-segments.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/gdbstub/gdb-xml/i386-segments.xml b/gdbstub/gdb-xml/i386-segments.xml
new file mode 100644
index 000000000000..6fbf3f91957e
--- /dev/null
+++ b/gdbstub/gdb-xml/i386-segments.xml
@@ -0,0 +1,14 @@
+<?xml version="1.0"?>
+<!--
+  SPDX-License-Identifier: GPL-2.0-or-later
+-->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<!-- Segment-cache values are read-only; writes are ignored. -->
+<feature name="org.qemu.gdb.i386.segments">
+  <reg name="cs.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="ds.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="es.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="ss.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="fs.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="gs.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+</feature>
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index e636ca0f4ae7..088bc930548a 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -496,6 +496,25 @@ static int i386_cpu_gdb_set_egprs(CPUState *cs, uint8_t *mem_buf, int n)
 }
 #endif
 
+#ifndef CONFIG_USER_ONLY
+static int x86_gdb_read_segment_limit(CPUState *cs, GByteArray *buf, int n)
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
+static int x86_gdb_write_segment_limit(CPUState *cs, uint8_t *buf, int n)
+{
+    /* Segment caches are exposed for inspection only. Ignore writes. */
+    return 4;
+}
+#endif
+
 void x86_cpu_gdb_init(CPUState *cs)
 {
 #ifdef TARGET_X86_64
@@ -517,4 +536,9 @@ void x86_cpu_gdb_init(CPUState *cs)
                              gdb_find_static_feature("i386-32bit-linux.xml"));
 #endif
 #endif
+#ifndef CONFIG_USER_ONLY
+    gdb_register_coprocessor(cs, x86_gdb_read_segment_limit,
+                             x86_gdb_write_segment_limit,
+                             gdb_find_static_feature("i386-segments.xml"));
+#endif
 }

-- 
2.56.0.116.g6de20f6092dc


