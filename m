Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A135606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UNCVsVdR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqUI-0003R8-GC; Thu, 22 Oct 2026 06:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUG-0003QB-7y
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUC-0001Wi-GS
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0EY7oY5DkTCrUlYc/29dZU0yvm7SGp0gDpE+x8TrbY=;
 b=UNCVsVdRpVWO03JV6gmss8Ot85iulm1L9XG1kKG6fmdMfWAeBNWacjOoXI0m+YACdg9KCa
 ipqFljoUc+jT+CVrEbKwdREEhbTe6Y/8bshua/HgVMWmahmBIpY1dvUxXp0MpYRtDqeu/G
 AG+W22sVOKVjgpWKfG9I8V4G9XaBsA0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-mOJ-9lifPMig8a_rYvAeOg-1; Thu,
 22 Oct 2026 06:57:18 -0400
X-MC-Unique: mOJ-9lifPMig8a_rYvAeOg-1
X-Mimecast-MFC-AGG-ID: mOJ-9lifPMig8a_rYvAeOg_1792666635
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 285F11955F05; Thu, 22 Oct 2026 10:57:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E82C18005B7; Thu, 22 Oct 2026 10:57:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:35 +0400
Subject: [PATCH v3 08/18] target/i386: split SSE registers into separate
 GDB feature
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-8-7ad902b9a7cf@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19511;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tHvQdITEwH7tiAQ001Ix/Vk9Cane0HB1zqCD9JJ3tQo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evmmQaFKAz9O1JS1WpjLSlcsw8zfdlYLwpAP
 XrbtL1MmoiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5gAKCRDa6OEJdZac
 5YlrD/9A7Oovj8wE9uYFOuSz/3Q10FzG6NSyWUADr/bYPghIfnl5pHCJQyDBjDNqsFPBa7hsBvq
 90GJSlBPhee07LKyeJ7BJiJ5HZSyXDxln0ydFEZ7hbThAGxNS/mrK5XRpDdBdqYBvwBrTSikstb
 nCy8WlAgooOxg247MYwFZRH31wVmz11D37SAYVNElJ6cCEeToLXVb+6paRXPueC3uKS4XsVw1jx
 bGmEONTggs2AIwHjNjEgLJI8lRT2+lxKw51nCc9fWr8i+wjVIiUXMk/FW8oksk4K2zhgfwtd5Ir
 tSluwDmQ9Bi/j9QaEf4s7qggXErtC4+J3ek86Upzixe5gUV2Rmh6tfJEqBciecMxeBQrWBvRtQV
 HrwwTlPfZnjBF8rhdZAOvBuAOiXPSYubIUtEcQ1fUlUK5qff4rFG2eFz2PlYPGM7hnYimErUYHd
 P55W0J/nHmcyAmfHuS4eVN21b4nUp6WfLjve1XRScj4CiIy00D807/N2VEv/xWEsOjE2AN+FnLO
 jwqKFBGhsYp7Lm9gTxiyoTenlUNWM6ROpcqT7U3xX0u8T3MIDpkgeNr245p9bF1YQHwdKzD/qJU
 LZgybotcfMGnUqbOjMusNBwEM00cQs4NNesjrsrRY2IrwIIxgEGBzE3QgAm+MI244SZbgsLPKDo
 d3R1cHPq0a/Te9w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move XMM registers and mxcsr out of org.gnu.gdb.i386.core into a
separate org.gnu.gdb.i386.sse feature, matching GDB's expected target
description layout (gdb/features/i386/{32,64}bit-sse.xml). Previously,
SSE registers were embedded in the core feature with a commented-out
feature boundary.

GDB requires org.gnu.gdb.i386.sse as a prerequisite for the AVX
feature (org.gnu.gdb.i386.avx). Without this split, adding AVX support
causes GDB to reject the target description entirely.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configs/targets/i386-bsd-user.mak     |  2 +-
 configs/targets/i386-linux-user.mak   |  2 +-
 configs/targets/i386-softmmu.mak      |  2 +-
 configs/targets/x86_64-bsd-user.mak   |  2 +-
 configs/targets/x86_64-linux-user.mak |  2 +-
 configs/targets/x86_64-softmmu.mak    |  2 +-
 gdbstub/gdb-xml/i386-32bit-sse.xml    | 54 +++++++++++++++++++++++++
 gdbstub/gdb-xml/i386-32bit.xml        | 46 +--------------------
 gdbstub/gdb-xml/i386-64bit-sse.xml    | 62 ++++++++++++++++++++++++++++
 gdbstub/gdb-xml/i386-64bit.xml        | 50 -----------------------
 target/i386/gdbstub.c                 | 76 ++++++++++++++++++++++-------------
 11 files changed, 172 insertions(+), 128 deletions(-)

diff --git a/configs/targets/i386-bsd-user.mak b/configs/targets/i386-bsd-user.mak
index 485f571cb6cd..b2a8b0a42ad9 100644
--- a/configs/targets/i386-bsd-user.mak
+++ b/configs/targets/i386-bsd-user.mak
@@ -1,3 +1,3 @@
 TARGET_ARCH=i386
-TARGET_XML_FILES= i386-32bit.xml
+TARGET_XML_FILES= i386-32bit.xml i386-32bit-sse.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-linux-user.mak
index a3ea4c39c520..234e600860a3 100644
--- a/configs/targets/i386-linux-user.mak
+++ b/configs/targets/i386-linux-user.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=i386
 TARGET_SYSTBL_ABI=i386
 TARGET_SYSTBL=syscall_32.tbl
-TARGET_XML_FILES= i386-32bit.xml i386-32bit-linux.xml
+TARGET_XML_FILES= i386-32bit.xml i386-32bit-sse.xml i386-32bit-linux.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 1424ab6f6834..a53ee07255b4 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
-TARGET_XML_FILES= i386-32bit.xml i386-system.xml
+TARGET_XML_FILES= i386-32bit.xml i386-32bit-sse.xml i386-system.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/x86_64-bsd-user.mak b/configs/targets/x86_64-bsd-user.mak
index 26b7cfad4e23..f36a9ccbd60a 100644
--- a/configs/targets/x86_64-bsd-user.mak
+++ b/configs/targets/x86_64-bsd-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-sse.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index cad68746bdb2..77a035b7eb4c 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -2,5 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
-TARGET_XML_FILES= i386-64bit.xml i386-64bit-linux.xml i386-64bit-apx.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-sse.xml i386-64bit-linux.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 51e882b1c747..c04fdf2d3fe8 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
-TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml i386-system.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-sse.xml i386-64bit-apx.xml i386-system.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/gdbstub/gdb-xml/i386-32bit-sse.xml b/gdbstub/gdb-xml/i386-32bit-sse.xml
new file mode 100644
index 000000000000..3f8a8d2bc8c1
--- /dev/null
+++ b/gdbstub/gdb-xml/i386-32bit-sse.xml
@@ -0,0 +1,54 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2010-2017 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.
+
+     SPDX-License-Identifier: GPL-2.0-or-later
+-->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.i386.sse">
+  <vector id="v4f" type="ieee_single" count="4"/>
+  <vector id="v2d" type="ieee_double" count="2"/>
+  <vector id="v16i8" type="int8" count="16"/>
+  <vector id="v8i16" type="int16" count="8"/>
+  <vector id="v4i32" type="int32" count="4"/>
+  <vector id="v2i64" type="int64" count="2"/>
+  <union id="vec128">
+    <field name="v4_float" type="v4f"/>
+    <field name="v2_double" type="v2d"/>
+    <field name="v16_int8" type="v16i8"/>
+    <field name="v8_int16" type="v8i16"/>
+    <field name="v4_int32" type="v4i32"/>
+    <field name="v2_int64" type="v2i64"/>
+    <field name="uint128" type="uint128"/>
+  </union>
+  <flags id="i386_mxcsr" size="4">
+    <field name="IE" start="0" end="0"/>
+    <field name="DE" start="1" end="1"/>
+    <field name="ZE" start="2" end="2"/>
+    <field name="OE" start="3" end="3"/>
+    <field name="UE" start="4" end="4"/>
+    <field name="PE" start="5" end="5"/>
+    <field name="DAZ" start="6" end="6"/>
+    <field name="IM" start="7" end="7"/>
+    <field name="DM" start="8" end="8"/>
+    <field name="ZM" start="9" end="9"/>
+    <field name="OM" start="10" end="10"/>
+    <field name="UM" start="11" end="11"/>
+    <field name="PM" start="12" end="12"/>
+    <field name="FZ" start="15" end="15"/>
+  </flags>
+
+  <reg name="xmm0" bitsize="128" type="vec128"/>
+  <reg name="xmm1" bitsize="128" type="vec128"/>
+  <reg name="xmm2" bitsize="128" type="vec128"/>
+  <reg name="xmm3" bitsize="128" type="vec128"/>
+  <reg name="xmm4" bitsize="128" type="vec128"/>
+  <reg name="xmm5" bitsize="128" type="vec128"/>
+  <reg name="xmm6" bitsize="128" type="vec128"/>
+  <reg name="xmm7" bitsize="128" type="vec128"/>
+
+  <reg name="mxcsr" bitsize="32" type="i386_mxcsr" group="vector"/>
+</feature>
diff --git a/gdbstub/gdb-xml/i386-32bit.xml b/gdbstub/gdb-xml/i386-32bit.xml
index 1dec40e1d2c1..dd6b6e7b8481 100644
--- a/gdbstub/gdb-xml/i386-32bit.xml
+++ b/gdbstub/gdb-xml/i386-32bit.xml
@@ -5,7 +5,7 @@
      are permitted in any medium without royalty provided the copyright
      notice and this notice are preserved.  -->
 
-<!-- I386 with SSE -->
+<!-- I386 core -->
 
 <!DOCTYPE target SYSTEM "gdb-target.dtd">
 <feature name="org.gnu.gdb.i386.core">
@@ -152,48 +152,4 @@
   <reg name="foseg" bitsize="32" type="int" group="float"/>
   <reg name="fooff" bitsize="32" type="int" group="float"/>
   <reg name="fop" bitsize="32" type="int" group="float"/>
-<!--/feature>
-<feature name="org.gnu.gdb.i386.32bit.sse"-->
-  <vector id="v4f" type="ieee_single" count="4"/>
-  <vector id="v2d" type="ieee_double" count="2"/>
-  <vector id="v16i8" type="int8" count="16"/>
-  <vector id="v8i16" type="int16" count="8"/>
-  <vector id="v4i32" type="int32" count="4"/>
-  <vector id="v2i64" type="int64" count="2"/>
-  <union id="vec128">
-	<field name="v4_float" type="v4f"/>
-	<field name="v2_double" type="v2d"/>
-	<field name="v16_int8" type="v16i8"/>
-	<field name="v8_int16" type="v8i16"/>
-	<field name="v4_int32" type="v4i32"/>
-	<field name="v2_int64" type="v2i64"/>
-	<field name="uint128" type="uint128"/>
-  </union>
-  <flags id="i386_mxcsr" size="4">
-	<field name="IE" start="0" end="0"/>
-	<field name="DE" start="1" end="1"/>
-	<field name="ZE" start="2" end="2"/>
-	<field name="OE" start="3" end="3"/>
-	<field name="UE" start="4" end="4"/>
-	<field name="PE" start="5" end="5"/>
-	<field name="DAZ" start="6" end="6"/>
-	<field name="IM" start="7" end="7"/>
-	<field name="DM" start="8" end="8"/>
-	<field name="ZM" start="9" end="9"/>
-	<field name="OM" start="10" end="10"/>
-	<field name="UM" start="11" end="11"/>
-	<field name="PM" start="12" end="12"/>
-	<field name="FZ" start="15" end="15"/>
-  </flags>
-
-  <reg name="xmm0" bitsize="128" type="vec128"/>
-  <reg name="xmm1" bitsize="128" type="vec128"/>
-  <reg name="xmm2" bitsize="128" type="vec128"/>
-  <reg name="xmm3" bitsize="128" type="vec128"/>
-  <reg name="xmm4" bitsize="128" type="vec128"/>
-  <reg name="xmm5" bitsize="128" type="vec128"/>
-  <reg name="xmm6" bitsize="128" type="vec128"/>
-  <reg name="xmm7" bitsize="128" type="vec128"/>
-
-  <reg name="mxcsr" bitsize="32" type="i386_mxcsr" group="vector"/>
 </feature>
diff --git a/gdbstub/gdb-xml/i386-64bit-sse.xml b/gdbstub/gdb-xml/i386-64bit-sse.xml
new file mode 100644
index 000000000000..06a5f857d92c
--- /dev/null
+++ b/gdbstub/gdb-xml/i386-64bit-sse.xml
@@ -0,0 +1,62 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2010-2017 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.
+
+     SPDX-License-Identifier: GPL-2.0-or-later
+-->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.i386.sse">
+  <vector id="v4f" type="ieee_single" count="4"/>
+  <vector id="v2d" type="ieee_double" count="2"/>
+  <vector id="v16i8" type="int8" count="16"/>
+  <vector id="v8i16" type="int16" count="8"/>
+  <vector id="v4i32" type="int32" count="4"/>
+  <vector id="v2i64" type="int64" count="2"/>
+  <union id="vec128">
+    <field name="v4_float" type="v4f"/>
+    <field name="v2_double" type="v2d"/>
+    <field name="v16_int8" type="v16i8"/>
+    <field name="v8_int16" type="v8i16"/>
+    <field name="v4_int32" type="v4i32"/>
+    <field name="v2_int64" type="v2i64"/>
+    <field name="uint128" type="uint128"/>
+  </union>
+  <flags id="x64_mxcsr" size="4">
+    <field name="IE" start="0" end="0"/>
+    <field name="DE" start="1" end="1"/>
+    <field name="ZE" start="2" end="2"/>
+    <field name="OE" start="3" end="3"/>
+    <field name="UE" start="4" end="4"/>
+    <field name="PE" start="5" end="5"/>
+    <field name="DAZ" start="6" end="6"/>
+    <field name="IM" start="7" end="7"/>
+    <field name="DM" start="8" end="8"/>
+    <field name="ZM" start="9" end="9"/>
+    <field name="OM" start="10" end="10"/>
+    <field name="UM" start="11" end="11"/>
+    <field name="PM" start="12" end="12"/>
+    <field name="FZ" start="15" end="15"/>
+  </flags>
+
+  <reg name="xmm0" bitsize="128" type="vec128"/>
+  <reg name="xmm1" bitsize="128" type="vec128"/>
+  <reg name="xmm2" bitsize="128" type="vec128"/>
+  <reg name="xmm3" bitsize="128" type="vec128"/>
+  <reg name="xmm4" bitsize="128" type="vec128"/>
+  <reg name="xmm5" bitsize="128" type="vec128"/>
+  <reg name="xmm6" bitsize="128" type="vec128"/>
+  <reg name="xmm7" bitsize="128" type="vec128"/>
+  <reg name="xmm8" bitsize="128" type="vec128"/>
+  <reg name="xmm9" bitsize="128" type="vec128"/>
+  <reg name="xmm10" bitsize="128" type="vec128"/>
+  <reg name="xmm11" bitsize="128" type="vec128"/>
+  <reg name="xmm12" bitsize="128" type="vec128"/>
+  <reg name="xmm13" bitsize="128" type="vec128"/>
+  <reg name="xmm14" bitsize="128" type="vec128"/>
+  <reg name="xmm15" bitsize="128" type="vec128"/>
+
+  <reg name="mxcsr" bitsize="32" type="x64_mxcsr" group="vector"/>
+</feature>
diff --git a/gdbstub/gdb-xml/i386-64bit.xml b/gdbstub/gdb-xml/i386-64bit.xml
index 9ac9164e6a99..a31c38aa8bd7 100644
--- a/gdbstub/gdb-xml/i386-64bit.xml
+++ b/gdbstub/gdb-xml/i386-64bit.xml
@@ -170,54 +170,4 @@
   <reg name="fooff" bitsize="32" type="int" group="float"/>
   <reg name="fop" bitsize="32" type="int" group="float"/>
 
-  <vector id="v4f" type="ieee_single" count="4"/>
-  <vector id="v2d" type="ieee_double" count="2"/>
-  <vector id="v16i8" type="int8" count="16"/>
-  <vector id="v8i16" type="int16" count="8"/>
-  <vector id="v4i32" type="int32" count="4"/>
-  <vector id="v2i64" type="int64" count="2"/>
-  <union id="vec128">
-	<field name="v4_float" type="v4f"/>
-	<field name="v2_double" type="v2d"/>
-	<field name="v16_int8" type="v16i8"/>
-	<field name="v8_int16" type="v8i16"/>
-	<field name="v4_int32" type="v4i32"/>
-	<field name="v2_int64" type="v2i64"/>
-	<field name="uint128" type="uint128"/>
-  </union>
-  <flags id="x64_mxcsr" size="4">
-	<field name="IE" start="0" end="0"/>
-	<field name="DE" start="1" end="1"/>
-	<field name="ZE" start="2" end="2"/>
-	<field name="OE" start="3" end="3"/>
-	<field name="UE" start="4" end="4"/>
-	<field name="PE" start="5" end="5"/>
-	<field name="DAZ" start="6" end="6"/>
-	<field name="IM" start="7" end="7"/>
-	<field name="DM" start="8" end="8"/>
-	<field name="ZM" start="9" end="9"/>
-	<field name="OM" start="10" end="10"/>
-	<field name="UM" start="11" end="11"/>
-	<field name="PM" start="12" end="12"/>
-	<field name="FZ" start="15" end="15"/>
-  </flags>
-
-  <reg name="xmm0" bitsize="128" type="vec128"/>
-  <reg name="xmm1" bitsize="128" type="vec128"/>
-  <reg name="xmm2" bitsize="128" type="vec128"/>
-  <reg name="xmm3" bitsize="128" type="vec128"/>
-  <reg name="xmm4" bitsize="128" type="vec128"/>
-  <reg name="xmm5" bitsize="128" type="vec128"/>
-  <reg name="xmm6" bitsize="128" type="vec128"/>
-  <reg name="xmm7" bitsize="128" type="vec128"/>
-  <reg name="xmm8" bitsize="128" type="vec128"/>
-  <reg name="xmm9" bitsize="128" type="vec128"/>
-  <reg name="xmm10" bitsize="128" type="vec128"/>
-  <reg name="xmm11" bitsize="128" type="vec128"/>
-  <reg name="xmm12" bitsize="128" type="vec128"/>
-  <reg name="xmm13" bitsize="128" type="vec128"/>
-  <reg name="xmm14" bitsize="128" type="vec128"/>
-  <reg name="xmm15" bitsize="128" type="vec128"/>
-
-  <reg name="mxcsr" bitsize="32" type="x64_mxcsr" group="vector"/>
 </feature>
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 420ce845eeae..2b4c28aac162 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -57,9 +57,8 @@ static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 /*
  * fpu regs ----------> 8 or 16
  */
-#define IDX_NB_MXCSR    1
 /*
- *          total ----> 8+1+1+9+6+16+8+1=50 or 16+1+1+9+6+16+16+1=66
+ *          total ----> 8+1+1+9+6+16=41 or 16+1+1+9+6+16=49
  */
 
 #define IDX_IP_REG      CPU_NB_REGS
@@ -67,8 +66,6 @@ static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 #define IDX_SEG_REGS    (IDX_FLAGS_REG + IDX_NB_FLAGS)
 #define IDX_CTL_REGS    (IDX_SEG_REGS + IDX_NB_SEG)
 #define IDX_FP_REGS     (IDX_CTL_REGS + IDX_NB_CTL)
-#define IDX_XMM_REGS    (IDX_FP_REGS + IDX_NB_FP)
-#define IDX_MXCSR_REG   (IDX_XMM_REGS + CPU_NB_REGS)
 
 #define IDX_CTL_CR0_REG     (IDX_CTL_REGS + 0)
 #define IDX_CTL_CR2_REG     (IDX_CTL_REGS + 1)
@@ -139,13 +136,6 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         int len = gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
         len += gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
         return len;
-    } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
-        n -= IDX_XMM_REGS;
-        if (n < CPU_NB_REGS32 || TARGET_LONG_BITS == 64) {
-            return gdb_get_reg128(mem_buf,
-                                  env->xmm_regs[n].ZMM_Q(1),
-                                  env->xmm_regs[n].ZMM_Q(0));
-        }
     } else {
         switch (n) {
         case IDX_IP_REG:
@@ -198,10 +188,6 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         case IDX_FP_REGS + 15:
             return gdb_get_reg32(mem_buf, 0); /* fop */
 
-        case IDX_MXCSR_REG:
-            update_mxcsr_from_sse_status(env);
-            return gdb_get_reg32(mem_buf, env->mxcsr);
-
         case IDX_CTL_CR0_REG:
             return gdb_read_reg_cs64(env->hflags, mem_buf, env->cr[0]);
         case IDX_CTL_CR2_REG:
@@ -300,13 +286,6 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         fp->low = le64_to_cpu(* (uint64_t *) mem_buf);
         fp->high = le16_to_cpu(* (uint16_t *) (mem_buf + 8));
         return 10;
-    } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
-        n -= IDX_XMM_REGS;
-        if (n < CPU_NB_REGS32 || TARGET_LONG_BITS == 64) {
-            env->xmm_regs[n].ZMM_Q(0) = ldq_p(mem_buf);
-            env->xmm_regs[n].ZMM_Q(1) = ldq_p(mem_buf + 8);
-            return 16;
-        }
     } else {
         switch (n) {
         case IDX_IP_REG:
@@ -358,10 +337,6 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         case IDX_FP_REGS + 15: /* fop */
             return 4;
 
-        case IDX_MXCSR_REG:
-            cpu_set_mxcsr(env, ldl_p(mem_buf));
-            return 4;
-
         case IDX_CTL_CR0_REG:
             len = gdb_write_reg_cs64(env->hflags, mem_buf, &tmp);
 #ifndef CONFIG_USER_ONLY
@@ -409,6 +384,44 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
+/*
+ * SSE feature (org.gnu.gdb.i386.sse) — XMM registers + mxcsr.
+ *
+ * Register layout: xmm0..xmm(N-1), mxcsr.
+ * N = CPU_NB_REGS (8 for 32-bit, 16 for 64-bit).
+ */
+static int x86_gdb_read_sse(CPUState *cs, GByteArray *buf, int n)
+{
+    CPUX86State *env = cpu_env(cs);
+
+    if (n < CPU_NB_REGS) {
+        return gdb_get_reg128(buf,
+                              env->xmm_regs[n].ZMM_Q(1),
+                              env->xmm_regs[n].ZMM_Q(0));
+    }
+    if (n == CPU_NB_REGS) {
+        update_mxcsr_from_sse_status(env);
+        return gdb_get_reg32(buf, env->mxcsr);
+    }
+    return 0;
+}
+
+static int x86_gdb_write_sse(CPUState *cs, uint8_t *buf, int n)
+{
+    CPUX86State *env = cpu_env(cs);
+
+    if (n < CPU_NB_REGS) {
+        env->xmm_regs[n].ZMM_Q(0) = ldq_p(buf);
+        env->xmm_regs[n].ZMM_Q(1) = ldq_p(buf + 8);
+        return 16;
+    }
+    if (n == CPU_NB_REGS) {
+        cpu_set_mxcsr(env, ldl_p(buf));
+        return 4;
+    }
+    return 0;
+}
+
 #ifdef CONFIG_LINUX_USER
 
 #define IDX_ORIG_AX 0
@@ -519,11 +532,20 @@ void x86_cpu_gdb_init(CPUState *cs)
 {
 #ifdef TARGET_X86_64
     CPUX86State *env = &X86_CPU(cs)->env;
+    const char *sse_xml = "i386-64bit-sse.xml";
+#else
+    const char *sse_xml = "i386-32bit-sse.xml";
+#endif
 
+    gdb_register_coprocessor(cs, x86_gdb_read_sse, x86_gdb_write_sse,
+                             gdb_find_static_feature(sse_xml));
+
+#ifdef TARGET_X86_64
     if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF) {
         gdb_register_coprocessor(cs, i386_cpu_gdb_get_egprs,
                                  i386_cpu_gdb_set_egprs,
-                                 gdb_find_static_feature("i386-64bit-apx.xml"));
+                                 gdb_find_static_feature(
+                                     "i386-64bit-apx.xml"));
     }
 #endif
 

-- 
2.56.0.116.g6de20f6092dc


