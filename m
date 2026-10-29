Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F873606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eucrxfDz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUBo-0008L3-FT; Thu, 29 Oct 2026 13:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qG-8e
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bp-Mi
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDPN6594499; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CXHgyny/ELk
 /Y6GulanFGtvOh+TwarN6zI5O2GcxFJo=; b=eucrxfDzyrJz/oowjdLmmOIJLoj
 isgCtfcTra8T0MdSyMDeg2sET0FfID0pXf0/mIHoftTeq0ctb+h9PEJ5i1cmYG+j
 3qr9DeGc7GcxvXNyr3yDSrCmG+15M2x3UfSyLPSUgKx1jWCEZ3nIHEyKhjPJzAwL
 gO4z0jNMzQVSHSZmtwd0yYNZQFcPpjEw7Cirld7x2+NoviT+UCZyRnYOJZbPY4ks
 caKzCTySsvio3NFmu7qH2Or7e1ZqUAyBOKvLcF+U8N0dwXCJyTEXY3BjNkk/v+rT
 nTgS2Jo5kHLjKCDZ/FA9e4a7MUa11bK1hbVd44cVz5ieRMeiD1TR1z4QKFQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3kt91-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiF3i2549285; Thu, 29 Oct 2026 17:44:15 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69THiEfl2549264
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id C1EF325851; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 18/20] target/hexagon: expose HLX registers through the gdbstub
Date: Thu, 29 Oct 2026 10:44:11 -0700
Message-ID: <20261029174413.643130-19-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX3bWrnAR3Xw89
 3SyknniITu6m7pfZCf4RfYxM49Z63XlPc1+UjHkEVvg+tvvq1WGt9/mbGQlMJkmWO9xJXUWLcvO
 1Dvqp20mVfyyLmTJrPN3EkOzJ+cHQgc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX8R9vJfQtlqMe
 u75QUd3+X7dpQmLF+8RkC/scSBihSqXM0dl59gBBvaPpwuwgUv9FkHQYPSgW657keI7q4DbOlU8
 JidZLMNw80JWtGPWkknfnABX+Ce5ErdsyItbBQ7Awak8aFHi+3+gg9C7gN3y19WgA/H+MF6VIkG
 MM9iXY2SUym1r4HfD8JZlLYFyEgJ+x609EUuZ7sByxwibagc8SAdzzabGkQfi9A3z2B1Xp7Eie+
 v0KsOHAVLdqykL5dUrMVx/VIW5itwGMCp8JuzSHQj6pxF0KzjMDbl63cqns8U0YO42LER52INn8
 gHtWCuLD2BlDWCxdAPxo2aMcJJnwbU+nmL+A8C1RRwKVLQ+oFR8+dV+6h5J9/9REoL0nPgGrAmC
 afLq2lZTCvxf0f9Pje2QI0V+n6KW+GS+p29nPzuLjHMdUM0MyfWRFCCrDAj0jpWzJVgqMX48BTl
 7ORpJt+E81QvBWz8J1A==
X-Proofpoint-ORIG-GUID: BST9VnUJfiOAKxSouvQYFwY9bQcFb41O
X-Proofpoint-GUID: BST9VnUJfiOAKxSouvQYFwY9bQcFb41O
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=eU0e3LhYAAAA:20 a=EUspDBNiAAAA:8
 a=QDXhLjxQveKjMNXUhXgA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add GDB register access for the active HLX context and register the
feature for V85 CPUs with HLX support.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 configs/targets/hexagon-linux-user.mak |  2 +-
 configs/targets/hexagon-softmmu.mak    |  2 +-
 gdbstub/gdb-xml/hexagon-hlx.xml        | 51 ++++++++++++++++++++++++++
 target/hexagon/cpu.c                   | 18 +++++++++
 target/hexagon/gdbstub.c               | 46 +++++++++++++++++++++++
 target/hexagon/internal.h              |  2 +
 6 files changed, 119 insertions(+), 2 deletions(-)
 create mode 100644 gdbstub/gdb-xml/hexagon-hlx.xml

diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hexagon-linux-user.mak
index 51fde5d60e..10ae1943a5 100644
--- a/configs/targets/hexagon-linux-user.mak
+++ b/configs/targets/hexagon-linux-user.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=hexagon
-TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml
+TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml hexagon-hlx.xml
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,32,hexagon,time32,stat64,rlimit,renameat
 TARGET_LONG_BITS=32
diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
index 1ba6420d20..8c3a9cd4b1 100644
--- a/configs/targets/hexagon-softmmu.mak
+++ b/configs/targets/hexagon-softmmu.mak
@@ -1,7 +1,7 @@
 # Default configuration for hexagon-softmmu
 
 TARGET_ARCH=hexagon
-TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml hexagon-sys.xml
+TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml hexagon-sys.xml hexagon-hlx.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/gdbstub/gdb-xml/hexagon-hlx.xml b/gdbstub/gdb-xml/hexagon-hlx.xml
new file mode 100644
index 0000000000..91040762ea
--- /dev/null
+++ b/gdbstub/gdb-xml/hexagon-hlx.xml
@@ -0,0 +1,51 @@
+<?xml version="1.0"?>
+<!--
+  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+  SPDX-License-Identifier: GPL-2.0-or-later
+
+  LLDB uses fields that GDB can ignore. See:
+  https://github.com/llvm/llvm-project/blob/287aa6c4536408413b860e61fca0318a27214cf3/lldb/docs/lldb-gdb-remote.txt#L738-L860
+-->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.hexagon.hlx">
+
+  <!-- Sixteen 2048-byte HLX L-registers. -->
+  <vector id="hlx_ud" type="uint64" count="256"/>
+  <vector id="hlx_d"  type="int64"  count="256"/>
+  <vector id="hlx_uw" type="uint32" count="512"/>
+  <vector id="hlx_w"  type="int32"  count="512"/>
+  <vector id="hlx_uh" type="uint16" count="1024"/>
+  <vector id="hlx_h"  type="int16"  count="1024"/>
+  <vector id="hlx_ub" type="uint8"  count="2048"/>
+  <vector id="hlx_b"  type="int8"   count="2048"/>
+  <union id="hlx_vec">
+    <field name="ud" type="hlx_ud"/>
+    <field name="d"  type="hlx_d"/>
+    <field name="uw" type="hlx_uw"/>
+    <field name="w"  type="hlx_w"/>
+    <field name="uh" type="hlx_uh"/>
+    <field name="h"  type="hlx_h"/>
+    <field name="ub" type="hlx_ub"/>
+    <field name="b"  type="hlx_b"/>
+  </union>
+
+  <!-- dwarf_regnums 124-139 follow HVX q0-q3. -->
+  <reg name="l0"  bitsize="16384" offset="0"     encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="124"/>
+  <reg name="l1"  bitsize="16384" offset="2048"  encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="125"/>
+  <reg name="l2"  bitsize="16384" offset="4096"  encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="126"/>
+  <reg name="l3"  bitsize="16384" offset="6144"  encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="127"/>
+  <reg name="l4"  bitsize="16384" offset="8192"  encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="128"/>
+  <reg name="l5"  bitsize="16384" offset="10240" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="129"/>
+  <reg name="l6"  bitsize="16384" offset="12288" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="130"/>
+  <reg name="l7"  bitsize="16384" offset="14336" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="131"/>
+  <reg name="l8"  bitsize="16384" offset="16384" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="132"/>
+  <reg name="l9"  bitsize="16384" offset="18432" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="133"/>
+  <reg name="l10" bitsize="16384" offset="20480" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="134"/>
+  <reg name="l11" bitsize="16384" offset="22528" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="135"/>
+  <reg name="l12" bitsize="16384" offset="24576" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="136"/>
+  <reg name="l13" bitsize="16384" offset="26624" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="137"/>
+  <reg name="l14" bitsize="16384" offset="28672" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="138"/>
+  <reg name="l15" bitsize="16384" offset="30720" encoding="vector" format="hex" group="HLX Vector Registers" dwarf_regnum="139"/>
+
+</feature>
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index c3930ab4e4..dfa9e1d3af 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -540,6 +540,18 @@ static void hexagon_cpu_disas_set_info(const CPUState *cs,
     info->target_info = &cpu->cfg;
 }
 
+static bool hexagon_cpu_has_hlx(HexagonCPU *cpu)
+{
+    if (cpu->cfg.hex_def->hex_version < HEX_VER_V85) {
+        return false;
+    }
+#ifdef CONFIG_USER_ONLY
+    return true;
+#else
+    return cpu->hlx && cpu->hlx->num_contexts > 0;
+#endif
+}
+
 static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -559,6 +571,12 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
                              hexagon_hvx_gdb_write_register,
                              gdb_find_static_feature("hexagon-hvx.xml"));
 
+    if (hexagon_cpu_has_hlx(cpu)) {
+        gdb_register_coprocessor(cs, hexagon_hlx_gdb_read_register,
+                                 hexagon_hlx_gdb_write_register,
+                                 gdb_find_static_feature("hexagon-hlx.xml"));
+    }
+
 #ifndef CONFIG_USER_ONLY
     gdb_register_coprocessor(cs, hexagon_sys_gdb_read_register,
                              hexagon_sys_gdb_write_register,
diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 5b79e42c4d..1065f3a826 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -217,3 +217,49 @@ int hexagon_hvx_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 
     g_assert_not_reached();
 }
+
+int hexagon_hlx_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    int total = 0;
+
+    BQL_LOCK_GUARD();
+
+    if (n < 0 || n >= NUM_LREGS) {
+        g_assert_not_reached();
+    }
+
+    /* Return zeroes when no HLX context is active. */
+    if (env->hlx_ctx == NULL) {
+        for (int i = 0; i < HLX_VEC_SIZE_BYTES; i++) {
+            g_byte_array_append(mem_buf, (const guint8 *)"\0", 1);
+        }
+        return HLX_VEC_SIZE_BYTES;
+    }
+
+    for (int i = 0; i < (int)ARRAY_SIZE(env->hlx_ctx->LRegs[n].uw); i++) {
+        total += gdb_get_reg32(mem_buf, env->hlx_ctx->LRegs[n].uw[i]);
+    }
+    return total;
+}
+
+int hexagon_hlx_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    BQL_LOCK_GUARD();
+
+    if (n < 0 || n >= NUM_LREGS) {
+        g_assert_not_reached();
+    }
+
+    /* Ignore writes without an active context. */
+    if (env->hlx_ctx == NULL) {
+        return HLX_VEC_SIZE_BYTES;
+    }
+
+    for (int i = 0; i < (int)ARRAY_SIZE(env->hlx_ctx->LRegs[n].uw); i++) {
+        env->hlx_ctx->LRegs[n].uw[i] = ldl_le_p(mem_buf);
+        mem_buf += 4;
+    }
+    return HLX_VEC_SIZE_BYTES;
+}
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 073de10284..6def331a83 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -24,6 +24,8 @@ int hexagon_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int hexagon_hvx_gdb_read_register(CPUState *env, GByteArray *mem_buf, int n);
 int hexagon_hvx_gdb_write_register(CPUState *env, uint8_t *mem_buf, int n);
+int hexagon_hlx_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n);
+int hexagon_hlx_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n);
 #ifndef CONFIG_USER_ONLY
 int hexagon_sys_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n);
 int hexagon_sys_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n);
-- 
2.43.0


