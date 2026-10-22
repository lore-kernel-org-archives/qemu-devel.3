Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC1606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ABBlaj4v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqUG-0003QI-L0; Thu, 22 Oct 2026 06:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUE-0003P7-R6
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUC-0001YI-EA
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCDdGapVlETR2OBYi9GYNj5+t+bbbuzJOSZ1lkf+XrE=;
 b=ABBlaj4v7VHhCQImCkUrmvKHmMwb6IV6DWASXiy6l8p64Qe63ZDAq4Igj9eAeM53PNdoZW
 GTgxeY8r+QyHkyvupq7KtbJEdiZep5fgjP15fZZxj5uo3ag1DFfpgjSbSV+NzmTemjfglZ
 47whJGAURV4Y5gUI8KsK1AeJCZRiQds=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-mCKMON0xPX2sfCVO0ma3Gg-1; Thu,
 22 Oct 2026 06:57:22 -0400
X-MC-Unique: mCKMON0xPX2sfCVO0ma3Gg-1
X-Mimecast-MFC-AGG-ID: mCKMON0xPX2sfCVO0ma3Gg_1792666639
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D8641955F73; Thu, 22 Oct 2026 10:57:19 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC2D4195608C; Thu, 22 Oct 2026 10:57:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:36 +0400
Subject: [PATCH v3 09/18] target/i386: expose system registers to monitors
 via gdbstub
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-9-7ad902b9a7cf@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12853;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=opSL/jxl640/Jj4R9cF7p5dXz4aeRzN7eFn39UEbQ8w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evmlmV6HratXT4gr6GDlf6vEpYwvs+ychS2d
 FrykLueGKOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5gAKCRDa6OEJdZac
 5Sw4EACq+h5GUlHqg+CJ8xUwmYRpKDf2K1amzD8pH90WeLMpsxZb+cJd+sZri5QVbCp4a01jYIN
 ZPm0EiEzf1SF6zFkyleX+qTkF6CE8y8XcivE8gv2s35nWndUC/0ltB7770Eg3mQ9Cb3fGmPFPyf
 jtciydLjfmQCE1Cvg4TLNxiWSuPoPMGZLwSMoz8cmHYjZggl0usOEPfdNf069XlAfQcfIb4H+ws
 PBRNMwsgTCoN6TCRxNOMqt1GRZb5L+0tsDeERKwOgVSq0Z9APZbOWLaWMTNecJNHiG0MOYz8Bfp
 wBis2doKtuklM/k5qnLmVOW0wJ5asCXkoK2HDsjT3RB8qDU+H7NjJYTpHG538ycdkLgZBb9qs1D
 lmI0a/Wq9SBJln8ldF6j6tT0hvCRHT1Ff2NPRlcfvgw7xR3u5xyLVSIBNOQrLdBg8FB9LC7tWn9
 S11Aj8okbxf7E4rpQqd/An97NIQ6FfaAObyHN9hOCGILMAS6a6TuWGPHN6N6BP9Zxs37qSQCEYw
 XXTDUu8E6Tho3q7gTKZ+Wmsl8sbrPgxP7pl5vawaqnR5zKBmSW4L58tEPGswAkj4cfTKNkRvhgp
 /brfYNnJNAtBAGM5nVU4Vz/xDv5FAvrbpPcexGvcq30Fp4M1svS3If3Q6yW2EcvspJ11YQ+dgdO
 21Q9LW9R5UBPHlQ==
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

Expand the org.qemu.gdb.i386.system feature to expose additional
read-only registers to HMP/monitor:

  - segment cache bases and flags (cs/ds/es/ss/fs/gs)
  - GDT/IDT base and limit
  - LDT/TR selector, base, limit, and flags
  - debug registers (dr0-dr3, dr6, dr7)
  - CPU status fields: CPL, interrupt-inhibit, A20, SMM, HLT
  - xcr0
  - abridged x87 tag word (ftw)

This will allow to implement an HMP "info registers" (cpu dump)
equivalent based on QMP register query some day.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 gdbstub/gdb-xml/i386-system.xml |  41 ++++++++++++-
 target/i386/cpu-dump.c          |   5 +-
 target/i386/cpu.h               |  16 +++++
 target/i386/gdbstub.c           | 132 +++++++++++++++++++++++++++++++++++++---
 4 files changed, 181 insertions(+), 13 deletions(-)

diff --git a/gdbstub/gdb-xml/i386-system.xml b/gdbstub/gdb-xml/i386-system.xml
index 9868b887eab8..7e7a5fb2e21f 100644
--- a/gdbstub/gdb-xml/i386-system.xml
+++ b/gdbstub/gdb-xml/i386-system.xml
@@ -3,7 +3,7 @@
   SPDX-License-Identifier: GPL-2.0-or-later
 -->
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<!-- Segment-cache values are read-only; writes are ignored. -->
+<!-- System-register values are read-only; writes are ignored. -->
 <feature name="org.qemu.gdb.i386.system">
   <reg name="cs.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
   <reg name="ds.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
@@ -11,4 +11,43 @@
   <reg name="ss.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
   <reg name="fs.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
   <reg name="gs.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <!-- fs/gs in core regs -->
+  <reg name="cs.base" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="ds.base" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="es.base" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="ss.base" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="cs.flags" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="ds.flags" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="es.flags" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="ss.flags" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="fs.flags" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="gs.flags" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="gdt.base" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="gdt.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="idt.base" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="idt.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="ldt.selector" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="ldt.base" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="ldt.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="ldt.flags" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="tr.selector" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="tr.base" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="tr.limit" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="tr.flags" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="dr0" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="dr1" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="dr2" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="dr3" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="dr6" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <reg name="dr7" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <!-- CPU status values, matching the fields printed by info registers. -->
+  <reg name="cpl" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <!-- ii: interrupt inhibit -->
+  <reg name="ii" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="a20" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="smm" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="hlt" bitsize="32" type="uint32" group="qemu-debug" save-restore="no"/>
+  <reg name="xcr0" bitsize="64" type="uint64" group="qemu-debug" save-restore="no"/>
+  <!-- Abridged x87 tag word: one bit per physical register, 1 = nonempty. -->
+  <reg name="ftw" bitsize="8" type="uint8" group="qemu-debug" save-restore="no"/>
 </feature>
diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index 9e290c0b9b42..d8d7ebaf0e03 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -511,10 +511,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                                      XSTATE_Hi16_ZMM_MASK | \
                                      XSTATE_YMM_MASK | XSTATE_SSE_MASK,
                        avx_mask = XSTATE_YMM_MASK | XSTATE_SSE_MASK;
-        fptag = 0;
-        for(i = 0; i < 8; i++) {
-            fptag |= ((!env->fptags[i]) << i);
-        }
+        fptag = x86_fptags_to_abridged(env);
         update_mxcsr_from_sse_status(env);
         qemu_fprintf(f, "FCW=%04x FSW=%04x [ST=%d] FTW=%02x MXCSR=%08x\n",
                      env->fpuc,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 116e28a59701..cc06f1fb7b68 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2998,6 +2998,22 @@ static inline void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
  */
 uint16_t cpu_compute_fptag(CPUX86State *env);
 
+/**
+ * x86_fptags_to_abridged - Pack fptags[] into the 8-bit abridged tag word.
+ *
+ * Returns the FXSAVE/XSAVE-style tag byte: bit i is 1 when ST(i) is
+ * nonempty (fptags[i] == 0) and 0 when empty (fptags[i] == 1).
+ */
+static inline uint8_t x86_fptags_to_abridged(const CPUX86State *env)
+{
+    uint8_t ftw = 0;
+
+    for (int i = 0; i < 8; i++) {
+        ftw |= (!env->fptags[i]) << i;
+    }
+    return ftw;
+}
+
 static inline void cpu_set_fpuc(CPUX86State *env, uint16_t fpuc)
 {
      env->fpuc = fpuc;
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 2b4c28aac162..9a46c46ecff9 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -510,21 +510,135 @@ static int i386_cpu_gdb_set_egprs(CPUState *cs, uint8_t *mem_buf, int n)
 #endif
 
 #ifndef CONFIG_USER_ONLY
+enum {
+    /* Segment limits: cs, ds, es, ss, fs, gs (6 × 32-bit) */
+    X86_GDB_SEG_LIMIT_FIRST,
+    X86_GDB_SEG_LIMIT_LAST = X86_GDB_SEG_LIMIT_FIRST + 5,
+    /* Segment bases: cs, ds, es, ss (4 × 64-bit; fs/gs in core regs) */
+    X86_GDB_SEG_BASE_FIRST,
+    X86_GDB_SEG_BASE_LAST = X86_GDB_SEG_BASE_FIRST + 3,
+    /* Segment flags: cs, ds, es, ss, fs, gs (6 × 32-bit) */
+    X86_GDB_SEG_FLAGS_FIRST,
+    X86_GDB_SEG_FLAGS_LAST = X86_GDB_SEG_FLAGS_FIRST + 5,
+    /* Descriptor tables */
+    X86_GDB_GDT_BASE,
+    X86_GDB_GDT_LIMIT,
+    X86_GDB_IDT_BASE,
+    X86_GDB_IDT_LIMIT,
+    X86_GDB_LDT_SELECTOR,
+    X86_GDB_LDT_BASE,
+    X86_GDB_LDT_LIMIT,
+    X86_GDB_LDT_FLAGS,
+    X86_GDB_TR_SELECTOR,
+    X86_GDB_TR_BASE,
+    X86_GDB_TR_LIMIT,
+    X86_GDB_TR_FLAGS,
+    /* Debug registers: dr0-dr3, dr6, dr7 (6 × 64-bit) */
+    X86_GDB_DR0,
+    X86_GDB_DR1,
+    X86_GDB_DR2,
+    X86_GDB_DR3,
+    X86_GDB_DR6,
+    X86_GDB_DR7,
+    /* CPU status */
+    X86_GDB_CPL,
+    X86_GDB_II,
+    X86_GDB_A20,
+    X86_GDB_SMM,
+    X86_GDB_HLT,
+    X86_GDB_XCR0,
+    X86_GDB_FTW,
+    X86_GDB_SYSTEM_COUNT,
+};
+
 static int x86_gdb_read_system(CPUState *cs, GByteArray *buf, int n)
 {
     CPUX86State *env = cpu_env(cs);
     static const int segments[] = { R_CS, R_DS, R_ES, R_SS, R_FS, R_GS };
 
-    if (n < 0 || n >= ARRAY_SIZE(segments)) {
+    switch (n) {
+    case X86_GDB_SEG_LIMIT_FIRST ... X86_GDB_SEG_LIMIT_LAST:
+        return gdb_get_reg32(buf,
+                             env->segs[segments[n - X86_GDB_SEG_LIMIT_FIRST]].limit);
+    case X86_GDB_SEG_BASE_FIRST ... X86_GDB_SEG_BASE_LAST:
+        return gdb_get_reg64(buf,
+                             env->segs[segments[n - X86_GDB_SEG_BASE_FIRST]].base);
+    case X86_GDB_SEG_FLAGS_FIRST ... X86_GDB_SEG_FLAGS_LAST:
+        return gdb_get_reg32(buf,
+                             env->segs[segments[n - X86_GDB_SEG_FLAGS_FIRST]].flags);
+    case X86_GDB_GDT_BASE:
+        return gdb_get_reg64(buf, env->gdt.base);
+    case X86_GDB_GDT_LIMIT:
+        return gdb_get_reg32(buf, env->gdt.limit);
+    case X86_GDB_IDT_BASE:
+        return gdb_get_reg64(buf, env->idt.base);
+    case X86_GDB_IDT_LIMIT:
+        return gdb_get_reg32(buf, env->idt.limit);
+    case X86_GDB_LDT_SELECTOR:
+        return gdb_get_reg32(buf, env->ldt.selector);
+    case X86_GDB_LDT_BASE:
+        return gdb_get_reg64(buf, env->ldt.base);
+    case X86_GDB_LDT_LIMIT:
+        return gdb_get_reg32(buf, env->ldt.limit);
+    case X86_GDB_LDT_FLAGS:
+        return gdb_get_reg32(buf, env->ldt.flags);
+    case X86_GDB_TR_SELECTOR:
+        return gdb_get_reg32(buf, env->tr.selector);
+    case X86_GDB_TR_BASE:
+        return gdb_get_reg64(buf, env->tr.base);
+    case X86_GDB_TR_LIMIT:
+        return gdb_get_reg32(buf, env->tr.limit);
+    case X86_GDB_TR_FLAGS:
+        return gdb_get_reg32(buf, env->tr.flags);
+    case X86_GDB_DR0 ... X86_GDB_DR3:
+        return gdb_get_reg64(buf, env->dr[n - X86_GDB_DR0]);
+    case X86_GDB_DR6:
+        return gdb_get_reg64(buf, env->dr[6]);
+    case X86_GDB_DR7:
+        return gdb_get_reg64(buf, env->dr[7]);
+    case X86_GDB_CPL:
+        return gdb_get_reg32(buf, env->hflags & HF_CPL_MASK);
+    case X86_GDB_II:
+        return gdb_get_reg32(buf, !!(env->hflags & HF_INHIBIT_IRQ_MASK));
+    case X86_GDB_A20:
+        return gdb_get_reg32(buf, (env->a20_mask >> 20) & 1);
+    case X86_GDB_SMM:
+        return gdb_get_reg32(buf, !!(env->hflags & HF_SMM_MASK));
+    case X86_GDB_HLT:
+        return gdb_get_reg32(buf, cs->halted);
+    case X86_GDB_XCR0:
+        return gdb_get_reg64(buf, env->xcr0);
+    case X86_GDB_FTW:
+        return gdb_get_reg8(buf, x86_fptags_to_abridged(env));
+    default:
         return 0;
     }
-    return gdb_get_reg32(buf, env->segs[segments[n]].limit);
 }
 
 static int x86_gdb_write_system(CPUState *cs, uint8_t *buf, int n)
 {
-    /* Segment caches are exposed for inspection only. Ignore writes. */
-    return 4;
+    /* System registers are exposed for inspection only. Ignore writes. */
+    static const uint8_t sizes[X86_GDB_SYSTEM_COUNT] = {
+        [X86_GDB_SEG_LIMIT_FIRST ... X86_GDB_SEG_LIMIT_LAST] = 4,
+        [X86_GDB_SEG_BASE_FIRST  ... X86_GDB_SEG_BASE_LAST]  = 8,
+        [X86_GDB_SEG_FLAGS_FIRST ... X86_GDB_SEG_FLAGS_LAST] = 4,
+        [X86_GDB_GDT_BASE] = 8, [X86_GDB_GDT_LIMIT] = 4,
+        [X86_GDB_IDT_BASE] = 8, [X86_GDB_IDT_LIMIT] = 4,
+        [X86_GDB_LDT_SELECTOR] = 4, [X86_GDB_LDT_BASE] = 8,
+        [X86_GDB_LDT_LIMIT] = 4, [X86_GDB_LDT_FLAGS] = 4,
+        [X86_GDB_TR_SELECTOR] = 4, [X86_GDB_TR_BASE] = 8,
+        [X86_GDB_TR_LIMIT] = 4, [X86_GDB_TR_FLAGS] = 4,
+        [X86_GDB_DR0 ... X86_GDB_DR7] = 8,
+        [X86_GDB_CPL] = 4, [X86_GDB_II] = 4,
+        [X86_GDB_A20] = 4, [X86_GDB_SMM] = 4,
+        [X86_GDB_HLT] = 4, [X86_GDB_XCR0] = 8,
+        [X86_GDB_FTW] = 1,
+    };
+
+    if (n < 0 || n >= X86_GDB_SYSTEM_COUNT) {
+        return 0;
+    }
+    return sizes[n];
 }
 #endif
 
@@ -559,9 +673,11 @@ void x86_cpu_gdb_init(CPUState *cs)
 #endif
 #endif
 #ifndef CONFIG_USER_ONLY
-    gdb_register_internal_coprocessor(
-        cs, x86_gdb_read_system,
-        x86_gdb_write_system,
-        gdb_find_static_feature("i386-system.xml"));
+    {
+        const GDBFeature *sysregs = gdb_find_static_feature("i386-system.xml");
+        g_assert(sysregs->num_regs == X86_GDB_SYSTEM_COUNT);
+        gdb_register_internal_coprocessor(cs, x86_gdb_read_system,
+                                          x86_gdb_write_system, sysregs);
+    }
 #endif
 }

-- 
2.56.0.116.g6de20f6092dc


