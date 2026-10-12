Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60460CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGMjw-0003Zt-38; Mon, 12 Oct 2026 16:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjs-0003V6-KS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjq-0003NG-7a
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791837313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8VVACXSd+yqSBYno2REMtAt1X6V5DiMdEu+Al/F2O4=;
 b=Fn/M0faAiOO495mDpn9bFJ4mnw0Qk2PKONu2F3Z4VIOOp+ir0n0Gqv84vYDb13DhP2ZRNY
 xgt7fhGiLzf4u0Zk+IgfX0Hyln6396J8CE4WmaSKrTvOjWgkdlC+NCfkdkOo3FxQazL7sM
 DAqEg32UTfo5s+gBmhZB+xEWb+rnQ1I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-lI-_daNIOzWPe1KdHeueWA-1; Mon,
 12 Oct 2026 20:35:09 +0000
X-MC-Unique: lI-_daNIOzWPe1KdHeueWA-1
X-Mimecast-MFC-AGG-ID: lI-_daNIOzWPe1KdHeueWA_1791837305
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A453D18021FF; Mon, 12 Oct 2026 20:35:05 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A24E61956086; Mon, 12 Oct 2026 20:35:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 00:34:10 +0400
Subject: [PATCH v2 07/10] target/sparc64: expose system registers via GDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-query-reg-v2-7-6f95a2e139a9@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4167;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZeupbSjlqQlOMmhMNoRj01W4+UfndDihzagGDkDwQkM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzURBWxbJff7o3WZRZvlqxUAa6qnvfabh6//8L
 I+R7NfwbCGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1EQQAKCRDa6OEJdZac
 5UTREACYakRiQVBKr/qeCc3g6muWu7Ojz1W+92YLlnxjalj6fmwA4t64sfxm3izHIvUCMthN2HG
 UgC/fl0j8BNTmDUyuGb+WHGI3nz2m4aA5RHAi4ArYTnYLKgip2Ifw04Xii3qbyJC+BT4puUim5r
 fq4IvNznZuPNINDS/z6Kdxek03KMybhZO7NTOgDaE2BeAtWSYwo6DqgHkMwJwqr+nfgaHOamkbj
 blNd812gODYdSwLWH8sE7A8lWizGNqy8Ona6dNoci1KL8tpWdHLrRNF7AivaFYx6XBA3P1VNlgM
 W8vy6gRUKToJiomQDZp2U+pK+jrgJ2nNs4BWWTDt3J0lG6ES1XMMrjpF09pB5zylLkTp4Cvma05
 qjG+s60ESlszaniqzPjStQ51C1BJuhOOw3n+knF8SBkWF5Vz/TlfhEgA55VSiZYTm+p+sT9ZABh
 cwbG6/KW7wEmrbJmXklCcgRdcjdntM1zBhHrZBNMcqEdB1PRI0FxjZDIuHwEG37VQacngUDNZT8
 F2sqpJ1rgYdrXunrrAOGTm86i0axp5hfpMqjOy1pGoZxVIAufySQY1WJblHJDn1PoZDCBiYKNrY
 puBBVIEOoRJvpKVdORTIUCpwBszqliPptSvdDUYDb42MjBVLJwSvDT0f8MKVndMzx6MwTK6e1Ix
 bx+NNEhqnwVSDxQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 2874ce1b3501..efbe16f38aa9 100644
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
+    gdb_register_internal_coprocessor(cs, sparc64_gdb_read_system_register,
+                                      sparc64_gdb_write_system_register,
+                                      gdb_find_static_feature("sparc64-system.xml"));
+#endif
 #endif
 }

-- 
2.56.0.116.g6de20f6092dc


