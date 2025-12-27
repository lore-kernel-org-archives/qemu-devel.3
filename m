Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE96E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQv0-0003hP-HL; Sat, 27 Dec 2025 04:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuy-0003g1-Ld
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuw-0006y3-QM
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCrPm+mupOMDZG9CEqWstk/Ar+Uz/0tVlPBTLpw4mAQ=;
 b=RcWKminAJI4yRwMi+u/W7GAAro2Od1jzMS0sv/X9JUNM+0Ub4wa5wesq08uRKNWmtPHjsW
 zlSa6x7GC9LjdGh3UU6dvBvOP03gQtCvVdzC3dzP/0gLYiLDmVde8CkXtCHe1kHJd35Vn9
 c3LX8Ch1CXze9ywyf8wihH4V0np+5Rs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-VGcFBOp1OC25AJ2MA61S4g-1; Sat, 27 Dec 2025 04:48:56 -0500
X-MC-Unique: VGcFBOp1OC25AJ2MA61S4g-1
X-Mimecast-MFC-AGG-ID: VGcFBOp1OC25AJ2MA61S4g_1766828936
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a49cso30836595e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828935; x=1767433735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LCrPm+mupOMDZG9CEqWstk/Ar+Uz/0tVlPBTLpw4mAQ=;
 b=g4HaaZ4+GaN2j6BbfmWxY3nmMi5EveAW8KtD5jgOeayahmp/2vK/4b4eg9d7ongDT9
 slUXvc4HQyLfviG/EBDSBlDsplZwq1Tj7I6MgO2wHPzeXvGmTofOGGMfXhoaNji8o+Ie
 I+B1BOZd1mGz3ZCdCHFsTzfNmooWoTVog92Y/bxka99b0GTqb1aybnKPsdyvbfXy6cQB
 xGxWChDDig15XAjSZXr6W8Dr2gq6wzZ/ISgNSHeTu/wPHXslbT+g0UADphWIuW4o9dWx
 qqTnjwePYlfKG81a4lSVx7xOvV/gFQ2g9FfbZu0KBKH3wbL3tH7ZUiAX3Ldohek2FE0t
 Nb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828935; x=1767433735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LCrPm+mupOMDZG9CEqWstk/Ar+Uz/0tVlPBTLpw4mAQ=;
 b=mzJ+wsIvfQl9HhddkxVNvBFCz+Z2sGDxrGivCCicB9xFN8kIfWf5kB+Cy/jXjU4a4S
 vLFX09PMvLAkxG9Tq45xv2lowjWvtixGMmyON1Hicv+NSJ83K8O1FTnFpuWcL75/XQAB
 zhpy3vjb4x9Qmde1KQE5w1kMZGkLIWCg6ZDCwimqPSn3FRUSiEBp1Ah8aczeYCaevael
 uGLGS9ZrrIkyOLEXhnatfaWiRFJwuMztUuAjcYEs5smaBkZL+kj2XiVhiTp4ax8HyU6E
 roPOtjErdyidHI9Zkx+71qD+LvRXYgTgLvv4CBlrYOF6n1cHgi000/k70XTsNMkDMhrm
 z7Og==
X-Gm-Message-State: AOJu0YytRZC6X9FSPe9QFALT3ag6vfXvs6p+68V8gNa6PFK9jLMF4S4y
 SM55u5BbIPwyAs3I+sV+u6r+1W7rBC213CH3oOrLLGYr4fEeqhbLfXXF4NQtJQU111vWVEk8snG
 /FvOB+cH8/ChC+in5CrCHhwmgkjbFAP6w8lLCnQrPXvEKWTzSc2FY9nd+5YaAX8wpTC4eef7xqo
 u3gp5LHiuFJP/HL8/wvXdj8h0qzLam0oSzXS4BfbQ5
X-Gm-Gg: AY/fxX7PWYJPuqYdlv+UKM9IDR93hgnZrJDarQN3AWNx6UbpoEccAjm3MdoXpiZYXyr
 GvMPl4udQy1EHWlf9dXvRsVXaUCllCxSdm6S/MASmIfASJ5illjJx1X4oTu+I0oNOw6XA17SHPv
 u03paPjU9HvOrLap136WUXeUK00ySV3zpmbhw3u3tAytF5QLJbdDbzAePQdtFkvlPB/DPbeud2T
 SmIvx4/7ObUWrvFRLZKxuuLwyPt9Qv7ZfWaa675nzZkYyz8LjwCHm3TZVG3zMauSrVR4RcXSkzQ
 dm7kT3YWPIRe1Vt4nc8/iGmbXoiKiwQbio1NBFrIjgY39Hf4T61mxy8vEJRTHSmgf/UHf65b2g6
 149t7+ZcDeNiro/2+FuYbP4rb/7ZCa5HHS7v/k2UALz/3+Ijkq/WE3lRquNbotXORe8JCYkJn0q
 /wnKgEYTAvZfuYjgE=
X-Received: by 2002:a05:600c:4711:b0:47a:9560:5944 with SMTP id
 5b1f17b1804b1-47d195c1a71mr306892365e9.34.1766828934810; 
 Sat, 27 Dec 2025 01:48:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfcOYJlqUAF9e9uJYTi/XgJW0tStHVgkxGL+th2WeRl/AOYC6hzBFIqZHt01gRnqXNK7oDdw==
X-Received: by 2002:a05:600c:4711:b0:47a:9560:5944 with SMTP id
 5b1f17b1804b1-47d195c1a71mr306892035e9.34.1766828934325; 
 Sat, 27 Dec 2025 01:48:54 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be395d9cfsm199728055e9.0.2025.12.27.01.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 098/153] i386/gdbstub: Add APX support for gdbstub
Date: Sat, 27 Dec 2025 10:47:03 +0100
Message-ID: <20251227094759.35658-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Add i386-64bit-apx.xml from gdb to allow QEMU gdbstub parse APX EGPRs,
and implement the callbacks to allow gdbstub access EGPRs of guest.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211070942.3612547-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/targets/x86_64-softmmu.mak |  2 +-
 target/i386/cpu.h                  | 16 +++++++
 target/i386/gdbstub.c              | 69 +++++++++++++++++++++++++++++-
 gdb-xml/i386-64bit-apx.xml         | 26 +++++++++++
 4 files changed, 110 insertions(+), 3 deletions(-)
 create mode 100644 gdb-xml/i386-64bit-apx.xml

diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 5619b2bc686..5180560d4d6 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -2,5 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
-TARGET_XML_FILES= gdb-xml/i386-64bit.xml
+TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 471d3931056..691ed974684 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -61,6 +61,22 @@ enum {
     R_R13 = 13,
     R_R14 = 14,
     R_R15 = 15,
+    R_R16 = 16,
+    R_R17 = 17,
+    R_R18 = 18,
+    R_R19 = 19,
+    R_R20 = 20,
+    R_R21 = 21,
+    R_R22 = 22,
+    R_R23 = 23,
+    R_R24 = 24,
+    R_R25 = 25,
+    R_R26 = 26,
+    R_R27 = 27,
+    R_R28 = 28,
+    R_R29 = 29,
+    R_R30 = 30,
+    R_R31 = 31,
 
     R_AL = 0,
     R_CL = 1,
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 04c49e802d7..be41601cffc 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -27,9 +27,11 @@
 #endif
 
 #ifdef TARGET_X86_64
-static const int gpr_map[16] = {
+static const int gpr_map[CPU_NB_EREGS] = {
     R_EAX, R_EBX, R_ECX, R_EDX, R_ESI, R_EDI, R_EBP, R_ESP,
-    8, 9, 10, 11, 12, 13, 14, 15
+    R_R8, R_R9, R_R10, R_R11, R_R12, R_R13, R_R14, R_R15,
+    R_R16, R_R17, R_R18, R_R19, R_R20, R_R21, R_R22, R_R23,
+    R_R24, R_R25, R_R26, R_R27, R_R28, R_R29, R_R30, R_R31,
 };
 #else
 #define gpr_map gpr_map32
@@ -444,8 +446,71 @@ static int x86_cpu_gdb_write_linux_register(CPUState *cs, uint8_t *mem_buf,
 
 #endif
 
+#ifdef TARGET_X86_64
+static int i386_cpu_gdb_get_egprs(CPUState *cs, GByteArray *mem_buf, int n)
+{
+    CPUX86State *env = &X86_CPU(cs)->env;
+
+    if (n >= 0 && n < EGPR_NUM) {
+        /* EGPRs can be only directly accessible in 64-bit mode. */
+        if (env->hflags & HF_CS64_MASK) {
+            return gdb_get_reg64(mem_buf, env->regs[gpr_map[n + CPU_NB_REGS]]);
+        } else {
+            return gdb_get_regl(mem_buf, 0);
+        }
+    }
+
+    return 0;
+}
+
+static int i386_cpu_gdb_set_egprs(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    CPUX86State *env = &X86_CPU(cs)->env;
+
+    if (n >= 0 && n < EGPR_NUM) {
+        /*
+         * EGPRs can be only directly accessible in 64-bit mode, and require
+         * XCR0[APX_F] (at least for modification in gdbstub) to be enabled.
+         */
+        if (env->hflags & HF_CS64_MASK && env->xcr0 & XSTATE_APX_MASK) {
+            env->regs[gpr_map[n + CPU_NB_REGS]] = ldtul_p(mem_buf);
+
+            /*
+             * Per SDM Vol 1, "Processor Tracking of XSAVE-Managed State",
+             * XSTATE_BV[i] *may* be either 0 or 1 if the state component is
+             * in its initial configuration.
+             *
+             * However, it is observed on Diamond Rapids (DMR) that
+             * XSTATE_BV[APX_F] is set whenever EGPRs are modified, regardless
+             * of the value written (even if zero).
+             *
+             * Since GDB modifies the software register cache directly,
+             * manually force the bit set to emulate this behavior observed
+             * on hardware.
+             */
+            if (!(env->xstate_bv & XSTATE_APX_MASK)) {
+                env->xstate_bv |= XSTATE_APX_MASK;
+            }
+        }
+        return sizeof(target_ulong);
+    }
+    return 0;
+}
+#endif
+
 void x86_cpu_gdb_init(CPUState *cs)
 {
+#ifdef TARGET_X86_64
+    CPUX86State *env = &X86_CPU(cs)->env;
+
+    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF) {
+        gdb_register_coprocessor(cs, i386_cpu_gdb_get_egprs,
+                                 i386_cpu_gdb_set_egprs,
+                                 gdb_find_static_feature("i386-64bit-apx.xml"),
+                                 0);
+    }
+#endif
+
 #ifdef CONFIG_LINUX_USER
     gdb_register_coprocessor(cs, x86_cpu_gdb_read_linux_register,
                              x86_cpu_gdb_write_linux_register,
diff --git a/gdb-xml/i386-64bit-apx.xml b/gdb-xml/i386-64bit-apx.xml
new file mode 100644
index 00000000000..11a4ec67cae
--- /dev/null
+++ b/gdb-xml/i386-64bit-apx.xml
@@ -0,0 +1,26 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2024 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.i386.apx">
+  <reg name="r16" bitsize="64" type="int64"/>
+  <reg name="r17" bitsize="64" type="int64"/>
+  <reg name="r18" bitsize="64" type="int64"/>
+  <reg name="r19" bitsize="64" type="int64"/>
+  <reg name="r20" bitsize="64" type="int64"/>
+  <reg name="r21" bitsize="64" type="int64"/>
+  <reg name="r22" bitsize="64" type="int64"/>
+  <reg name="r23" bitsize="64" type="int64"/>
+  <reg name="r24" bitsize="64" type="int64"/>
+  <reg name="r25" bitsize="64" type="int64"/>
+  <reg name="r26" bitsize="64" type="int64"/>
+  <reg name="r27" bitsize="64" type="int64"/>
+  <reg name="r28" bitsize="64" type="int64"/>
+  <reg name="r29" bitsize="64" type="int64"/>
+  <reg name="r30" bitsize="64" type="int64"/>
+  <reg name="r31" bitsize="64" type="int64"/>
+</feature>
-- 
2.52.0


