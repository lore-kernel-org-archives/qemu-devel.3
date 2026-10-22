Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E1606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hySfvPdz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqUN-0003X2-No; Thu, 22 Oct 2026 06:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUJ-0003Rt-KE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUF-0001Z7-1o
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2rDz3rQ/JLRiyCGgkymIxrCWPr9EYDtBAF4DWLCXOP8=;
 b=hySfvPdzGe9xT6fNn38TPa8E7xaQoPXjqu/h1xcJyWkuvHoLoxF8TSRR1Hhz5QZq08HgRx
 B4+EaGzOYKnT21wzCFzYI1XgE5JUbTV0N7ZCLMFDBaZpA/0jUJ6XMOF77llNSqUfLofUdI
 YVcpPUsXASMAhi/x38IzPhFjuu3aJms=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-7CSWQ2w8OCGUUiTcLDHzEA-1; Thu,
 22 Oct 2026 10:57:25 +0000
X-MC-Unique: 7CSWQ2w8OCGUUiTcLDHzEA-1
X-Mimecast-MFC-AGG-ID: 7CSWQ2w8OCGUUiTcLDHzEA_1792666642
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 585F31800615; Thu, 22 Oct 2026 10:57:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CBCB195608C; Thu, 22 Oct 2026 10:57:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:37 +0400
Subject: [PATCH v3 10/18] target/i386: expose AVX/AVX-512 registers to GDB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-10-7ad902b9a7cf@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20223;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MKLeVlzXZuS0u3c1Qx474RnGODtqnwwqJepPI02mvTc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evmOa7xBNz2vu1nvQUShQ6TvopjRjBCE0NCu
 AlYeK6U/jSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5gAKCRDa6OEJdZac
 5b1QD/9L15OsaOihSK0LzAtpPxwtEPt1MrXk9L2XDkh9IQEijXvaNKMYGTxeavUS2e6wtswZ7vd
 yiEm5WfrUE4prHXe2hmXyEC60uRBS+KuAwH1Y55ZG6oQFB8WYT8JK78/F8sO3AHYHtIMrJAiE8v
 /2z8zOt1Im/vGlC5kgfYyMYkS84UvF8ilgSnUidHfHp0t5axQbZnxiBcuw5pkVvEoosGtk6Q17c
 Vdu/H4ScbbHg0hNBMm92mdCnuo2kXT+8iFd5yz7YfWpE2Ng5dBxjv89NYJbPsDz8O7ZbclYQ6PR
 BX67E5FktP8JzCMflfivPZNSP2j04wqGqZPr8xDtzxwL42jBehaJr9QU5Xs5vvpSFhGH5PbHkRW
 gKEhPMhkE6LqzljcBQcEhHnFBzLGvC785nt3b86csILuBJZL4uKyplN+eyVVhbOpMrRk9u+qaFX
 zaNouOv8cT67F10dnqc16HhdhSkVsO1+swIKipyZMtABt2lnCDFWqTxFmpCYT8hy4Wnt0uqcVM7
 PdMQLFGwTrQy4eJpjBxeMTD7alt/6ZI10kOahtzaAHoVKG+rlzckVyN54mrkZP8JrcGVk44a6DC
 cuM5gleqIVX/p8CYTryO6kjTwll3XfwpSm+q40R1WZUA0yzLJefzbDCpP5S78fGAcUf3cqWJN7t
 3ZH5IU/F6aRp/8w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Register the standard GDB target description features for AVX and
AVX-512, so that GDB clients can inspect and modify vector state:

  - org.gnu.gdb.i386.avx (requires CPUID_EXT_AVX):
    YMM upper halves (ymm0h..ymm7h for 32-bit, ymm0h..ymm15h for
    64-bit). GDB synthesizes full ymm0..ymm15 pseudo-registers by
    concatenating xmm + ymmh.

  - org.gnu.gdb.i386.avx512 (requires CPUID_7_0_EBX_AVX512F):
    32-bit: k0..k7 opmask + zmm0h..zmm7h upper halves.
    64-bit: xmm16..xmm31, ymm16h..ymm31h, k0..k7 opmask,
            zmm0h..zmm31h upper halves.
    GDB synthesizes full zmm0..zmm31 pseudo-registers from the
    xmm + ymmh + zmmh components.

The XML descriptions and register layouts match the GDB feature
definitions from binutils-gdb (gdb/features/i386/).

Features are conditionally registered based on the CPU model's CPUID.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configs/targets/i386-bsd-user.mak     |   2 +-
 configs/targets/i386-linux-user.mak   |   2 +-
 configs/targets/i386-softmmu.mak      |   2 +-
 configs/targets/x86_64-bsd-user.mak   |   2 +-
 configs/targets/x86_64-linux-user.mak |   2 +-
 configs/targets/x86_64-softmmu.mak    |   2 +-
 gdbstub/gdb-xml/i386-32bit-avx.xml    |  20 +++++
 gdbstub/gdb-xml/i386-32bit-avx512.xml |  31 +++++++
 gdbstub/gdb-xml/i386-64bit-avx.xml    |  28 +++++++
 gdbstub/gdb-xml/i386-64bit-avx512.xml | 108 ++++++++++++++++++++++++
 target/i386/gdbstub.c                 | 154 +++++++++++++++++++++++++++++++++-
 11 files changed, 346 insertions(+), 7 deletions(-)

diff --git a/configs/targets/i386-bsd-user.mak b/configs/targets/i386-bsd-user.mak
index b2a8b0a42ad9..18e618258cc6 100644
--- a/configs/targets/i386-bsd-user.mak
+++ b/configs/targets/i386-bsd-user.mak
@@ -1,3 +1,3 @@
 TARGET_ARCH=i386
-TARGET_XML_FILES= i386-32bit.xml i386-32bit-sse.xml
+TARGET_XML_FILES= i386-32bit.xml i386-32bit-sse.xml i386-32bit-avx.xml i386-32bit-avx512.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-linux-user.mak
index 234e600860a3..6b9869a6d253 100644
--- a/configs/targets/i386-linux-user.mak
+++ b/configs/targets/i386-linux-user.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=i386
 TARGET_SYSTBL_ABI=i386
 TARGET_SYSTBL=syscall_32.tbl
-TARGET_XML_FILES= i386-32bit.xml i386-32bit-sse.xml i386-32bit-linux.xml
+TARGET_XML_FILES= i386-32bit.xml i386-32bit-sse.xml i386-32bit-avx.xml i386-32bit-avx512.xml i386-32bit-linux.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index a53ee07255b4..05cc0bf29716 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
-TARGET_XML_FILES= i386-32bit.xml i386-32bit-sse.xml i386-system.xml
+TARGET_XML_FILES= i386-32bit.xml i386-32bit-sse.xml i386-32bit-avx.xml i386-32bit-avx512.xml i386-system.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/x86_64-bsd-user.mak b/configs/targets/x86_64-bsd-user.mak
index f36a9ccbd60a..e157dd9935bd 100644
--- a/configs/targets/x86_64-bsd-user.mak
+++ b/configs/targets/x86_64-bsd-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_XML_FILES= i386-64bit.xml i386-64bit-sse.xml i386-64bit-apx.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-sse.xml i386-64bit-avx.xml i386-64bit-avx512.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index 77a035b7eb4c..cc65f1333c3e 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -2,5 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
-TARGET_XML_FILES= i386-64bit.xml i386-64bit-sse.xml i386-64bit-linux.xml i386-64bit-apx.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-sse.xml i386-64bit-avx.xml i386-64bit-avx512.xml i386-64bit-linux.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index c04fdf2d3fe8..725db9e4cdb4 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
-TARGET_XML_FILES= i386-64bit.xml i386-64bit-sse.xml i386-64bit-apx.xml i386-system.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-sse.xml i386-64bit-avx.xml i386-64bit-avx512.xml i386-64bit-apx.xml i386-system.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/gdbstub/gdb-xml/i386-32bit-avx.xml b/gdbstub/gdb-xml/i386-32bit-avx.xml
new file mode 100644
index 000000000000..bc6bc28ff19c
--- /dev/null
+++ b/gdbstub/gdb-xml/i386-32bit-avx.xml
@@ -0,0 +1,20 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2010-2026 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.
+
+     SPDX-License-Identifier: GPL-2.0-or-later
+-->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.i386.avx">
+  <reg name="ymm0h" bitsize="128" type="uint128"/>
+  <reg name="ymm1h" bitsize="128" type="uint128"/>
+  <reg name="ymm2h" bitsize="128" type="uint128"/>
+  <reg name="ymm3h" bitsize="128" type="uint128"/>
+  <reg name="ymm4h" bitsize="128" type="uint128"/>
+  <reg name="ymm5h" bitsize="128" type="uint128"/>
+  <reg name="ymm6h" bitsize="128" type="uint128"/>
+  <reg name="ymm7h" bitsize="128" type="uint128"/>
+</feature>
diff --git a/gdbstub/gdb-xml/i386-32bit-avx512.xml b/gdbstub/gdb-xml/i386-32bit-avx512.xml
new file mode 100644
index 000000000000..764f74f86d6c
--- /dev/null
+++ b/gdbstub/gdb-xml/i386-32bit-avx512.xml
@@ -0,0 +1,31 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2014-2026 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.
+
+     SPDX-License-Identifier: GPL-2.0-or-later
+-->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.i386.avx512">
+  <vector id="v2ui128" type="uint128" count="2"/>
+
+  <reg name="k0" bitsize="64" type="uint64"/>
+  <reg name="k1" bitsize="64" type="uint64"/>
+  <reg name="k2" bitsize="64" type="uint64"/>
+  <reg name="k3" bitsize="64" type="uint64"/>
+  <reg name="k4" bitsize="64" type="uint64"/>
+  <reg name="k5" bitsize="64" type="uint64"/>
+  <reg name="k6" bitsize="64" type="uint64"/>
+  <reg name="k7" bitsize="64" type="uint64"/>
+
+  <reg name="zmm0h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm1h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm2h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm3h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm4h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm5h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm6h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm7h" bitsize="256" type="v2ui128"/>
+</feature>
diff --git a/gdbstub/gdb-xml/i386-64bit-avx.xml b/gdbstub/gdb-xml/i386-64bit-avx.xml
new file mode 100644
index 000000000000..d470ee08af30
--- /dev/null
+++ b/gdbstub/gdb-xml/i386-64bit-avx.xml
@@ -0,0 +1,28 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2010-2026 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.
+
+     SPDX-License-Identifier: GPL-2.0-or-later
+-->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.i386.avx">
+  <reg name="ymm0h" bitsize="128" type="uint128"/>
+  <reg name="ymm1h" bitsize="128" type="uint128"/>
+  <reg name="ymm2h" bitsize="128" type="uint128"/>
+  <reg name="ymm3h" bitsize="128" type="uint128"/>
+  <reg name="ymm4h" bitsize="128" type="uint128"/>
+  <reg name="ymm5h" bitsize="128" type="uint128"/>
+  <reg name="ymm6h" bitsize="128" type="uint128"/>
+  <reg name="ymm7h" bitsize="128" type="uint128"/>
+  <reg name="ymm8h" bitsize="128" type="uint128"/>
+  <reg name="ymm9h" bitsize="128" type="uint128"/>
+  <reg name="ymm10h" bitsize="128" type="uint128"/>
+  <reg name="ymm11h" bitsize="128" type="uint128"/>
+  <reg name="ymm12h" bitsize="128" type="uint128"/>
+  <reg name="ymm13h" bitsize="128" type="uint128"/>
+  <reg name="ymm14h" bitsize="128" type="uint128"/>
+  <reg name="ymm15h" bitsize="128" type="uint128"/>
+</feature>
diff --git a/gdbstub/gdb-xml/i386-64bit-avx512.xml b/gdbstub/gdb-xml/i386-64bit-avx512.xml
new file mode 100644
index 000000000000..79156c561db8
--- /dev/null
+++ b/gdbstub/gdb-xml/i386-64bit-avx512.xml
@@ -0,0 +1,108 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2014-2026 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.
+
+     SPDX-License-Identifier: GPL-2.0-or-later
+-->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.i386.avx512">
+  <vector id="v8bf16" type="bfloat16" count="8"/>
+  <vector id="v8h" type="ieee_half" count="8"/>
+  <vector id="v4f" type="ieee_single" count="4"/>
+  <vector id="v2d" type="ieee_double" count="2"/>
+  <vector id="v16i8" type="int8" count="16"/>
+  <vector id="v8i16" type="int16" count="8"/>
+  <vector id="v4i32" type="int32" count="4"/>
+  <vector id="v2i64" type="int64" count="2"/>
+  <union id="vec128">
+    <field name="v8_bfloat16" type="v8bf16"/>
+    <field name="v8_half" type="v8h"/>
+    <field name="v4_float" type="v4f"/>
+    <field name="v2_double" type="v2d"/>
+    <field name="v16_int8" type="v16i8"/>
+    <field name="v8_int16" type="v8i16"/>
+    <field name="v4_int32" type="v4i32"/>
+    <field name="v2_int64" type="v2i64"/>
+    <field name="uint128" type="uint128"/>
+  </union>
+  <vector id="v2ui128" type="uint128" count="2"/>
+
+  <reg name="xmm16" bitsize="128" type="vec128"/>
+  <reg name="xmm17" bitsize="128" type="vec128"/>
+  <reg name="xmm18" bitsize="128" type="vec128"/>
+  <reg name="xmm19" bitsize="128" type="vec128"/>
+  <reg name="xmm20" bitsize="128" type="vec128"/>
+  <reg name="xmm21" bitsize="128" type="vec128"/>
+  <reg name="xmm22" bitsize="128" type="vec128"/>
+  <reg name="xmm23" bitsize="128" type="vec128"/>
+  <reg name="xmm24" bitsize="128" type="vec128"/>
+  <reg name="xmm25" bitsize="128" type="vec128"/>
+  <reg name="xmm26" bitsize="128" type="vec128"/>
+  <reg name="xmm27" bitsize="128" type="vec128"/>
+  <reg name="xmm28" bitsize="128" type="vec128"/>
+  <reg name="xmm29" bitsize="128" type="vec128"/>
+  <reg name="xmm30" bitsize="128" type="vec128"/>
+  <reg name="xmm31" bitsize="128" type="vec128"/>
+
+  <reg name="ymm16h" bitsize="128" type="uint128"/>
+  <reg name="ymm17h" bitsize="128" type="uint128"/>
+  <reg name="ymm18h" bitsize="128" type="uint128"/>
+  <reg name="ymm19h" bitsize="128" type="uint128"/>
+  <reg name="ymm20h" bitsize="128" type="uint128"/>
+  <reg name="ymm21h" bitsize="128" type="uint128"/>
+  <reg name="ymm22h" bitsize="128" type="uint128"/>
+  <reg name="ymm23h" bitsize="128" type="uint128"/>
+  <reg name="ymm24h" bitsize="128" type="uint128"/>
+  <reg name="ymm25h" bitsize="128" type="uint128"/>
+  <reg name="ymm26h" bitsize="128" type="uint128"/>
+  <reg name="ymm27h" bitsize="128" type="uint128"/>
+  <reg name="ymm28h" bitsize="128" type="uint128"/>
+  <reg name="ymm29h" bitsize="128" type="uint128"/>
+  <reg name="ymm30h" bitsize="128" type="uint128"/>
+  <reg name="ymm31h" bitsize="128" type="uint128"/>
+
+  <reg name="k0" bitsize="64" type="uint64"/>
+  <reg name="k1" bitsize="64" type="uint64"/>
+  <reg name="k2" bitsize="64" type="uint64"/>
+  <reg name="k3" bitsize="64" type="uint64"/>
+  <reg name="k4" bitsize="64" type="uint64"/>
+  <reg name="k5" bitsize="64" type="uint64"/>
+  <reg name="k6" bitsize="64" type="uint64"/>
+  <reg name="k7" bitsize="64" type="uint64"/>
+
+  <reg name="zmm0h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm1h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm2h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm3h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm4h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm5h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm6h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm7h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm8h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm9h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm10h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm11h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm12h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm13h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm14h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm15h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm16h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm17h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm18h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm19h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm20h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm21h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm22h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm23h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm24h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm25h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm26h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm27h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm28h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm29h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm30h" bitsize="256" type="v2ui128"/>
+  <reg name="zmm31h" bitsize="256" type="v2ui128"/>
+</feature>
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 9a46c46ecff9..8b89f2260a4c 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -422,6 +422,141 @@ static int x86_gdb_write_sse(CPUState *cs, uint8_t *buf, int n)
     return 0;
 }
 
+/*
+ * AVX feature (org.gnu.gdb.i386.avx) — YMM upper halves.
+ *
+ * Register layout: ymm0h..ymm(N-1)h, each 128-bit.
+ * N = CPU_NB_REGS (8 for 32-bit, 16 for 64-bit).
+ */
+static int x86_gdb_read_avx(CPUState *cs, GByteArray *buf, int n)
+{
+    CPUX86State *env = cpu_env(cs);
+
+    if (n < 0 || n >= CPU_NB_REGS) {
+        return 0;
+    }
+    return gdb_get_reg128(buf,
+                          env->xmm_regs[n].ZMM_Q(3),
+                          env->xmm_regs[n].ZMM_Q(2));
+}
+
+static int x86_gdb_write_avx(CPUState *cs, uint8_t *buf, int n)
+{
+    CPUX86State *env = cpu_env(cs);
+
+    if (n < 0 || n >= CPU_NB_REGS) {
+        return 0;
+    }
+    env->xmm_regs[n].ZMM_Q(2) = ldq_p(buf);
+    env->xmm_regs[n].ZMM_Q(3) = ldq_p(buf + 8);
+    return 16;
+}
+
+/*
+ * AVX-512 feature (org.gnu.gdb.i386.avx512).
+ *
+ * 32-bit layout (CPU_NB_REGS == 8):
+ *   n = 0..7   k0..k7          (64-bit opmask)
+ *   n = 8..15  zmm0h..zmm7h    (256-bit ZMM upper halves)
+ *
+ * 64-bit layout (CPU_NB_REGS == 16):
+ *   n = 0..15  xmm16..xmm31    (128-bit)
+ *   n = 16..31 ymm16h..ymm31h  (128-bit)
+ *   n = 32..39 k0..k7          (64-bit opmask)
+ *   n = 40..71 zmm0h..zmm31h   (256-bit ZMM upper halves)
+ */
+#ifdef TARGET_X86_64
+enum {
+    X86_GDB_AVX512_XMM16_FIRST  = 0,
+    X86_GDB_AVX512_YMM16H_FIRST = 16,
+    X86_GDB_AVX512_OPMASK_FIRST = 32,
+    X86_GDB_AVX512_ZMM_FIRST    = 40,
+    X86_GDB_AVX512_COUNT        = 72,
+};
+#else
+enum {
+    X86_GDB_AVX512_OPMASK_FIRST = 0,
+    X86_GDB_AVX512_ZMM_FIRST    = NB_OPMASK_REGS,
+    X86_GDB_AVX512_COUNT        = NB_OPMASK_REGS + CPU_NB_REGS,
+};
+#endif
+
+static int x86_gdb_read_avx512(CPUState *cs, GByteArray *buf, int n)
+{
+    CPUX86State *env = cpu_env(cs);
+    int reg;
+
+    if (n < 0 || n >= X86_GDB_AVX512_COUNT) {
+        return 0;
+    }
+
+#ifdef TARGET_X86_64
+    if (n < X86_GDB_AVX512_YMM16H_FIRST) {
+        /* xmm16..xmm31: lower 128 bits */
+        reg = 16 + n;
+        return gdb_get_reg128(buf,
+                              env->xmm_regs[reg].ZMM_Q(1),
+                              env->xmm_regs[reg].ZMM_Q(0));
+    }
+    if (n < X86_GDB_AVX512_OPMASK_FIRST) {
+        /* ymm16h..ymm31h: upper 128 bits of YMM */
+        reg = 16 + (n - X86_GDB_AVX512_YMM16H_FIRST);
+        return gdb_get_reg128(buf,
+                              env->xmm_regs[reg].ZMM_Q(3),
+                              env->xmm_regs[reg].ZMM_Q(2));
+    }
+#endif
+    if (n < X86_GDB_AVX512_ZMM_FIRST) {
+        /* k0..k7: opmask registers */
+        return gdb_get_reg64(buf,
+                             env->opmask_regs[n - X86_GDB_AVX512_OPMASK_FIRST]);
+    }
+    /* zmm0h..zmm(N-1)h: upper 256 bits of ZMM */
+    reg = n - X86_GDB_AVX512_ZMM_FIRST;
+    for (int i = 4; i < 8; i++) {
+        gdb_get_reg64(buf, env->xmm_regs[reg].ZMM_Q(i));
+    }
+    return 32;
+}
+
+static int x86_gdb_write_avx512(CPUState *cs, uint8_t *buf, int n)
+{
+    CPUX86State *env = cpu_env(cs);
+    int reg;
+
+    if (n < 0 || n >= X86_GDB_AVX512_COUNT) {
+        return 0;
+    }
+
+#ifdef TARGET_X86_64
+    if (n < X86_GDB_AVX512_YMM16H_FIRST) {
+        /* xmm16..xmm31 */
+        reg = 16 + n;
+        env->xmm_regs[reg].ZMM_Q(0) = ldq_p(buf);
+        env->xmm_regs[reg].ZMM_Q(1) = ldq_p(buf + 8);
+        return 16;
+    }
+    if (n < X86_GDB_AVX512_OPMASK_FIRST) {
+        /* ymm16h..ymm31h */
+        reg = 16 + (n - X86_GDB_AVX512_YMM16H_FIRST);
+        env->xmm_regs[reg].ZMM_Q(2) = ldq_p(buf);
+        env->xmm_regs[reg].ZMM_Q(3) = ldq_p(buf + 8);
+        return 16;
+    }
+#endif
+    if (n < X86_GDB_AVX512_ZMM_FIRST) {
+        /* k0..k7 */
+        env->opmask_regs[n - X86_GDB_AVX512_OPMASK_FIRST] = ldq_p(buf);
+        return 8;
+    }
+    /* zmm0h..zmm(N-1)h */
+    reg = n - X86_GDB_AVX512_ZMM_FIRST;
+    for (int i = 0; i < 4; i++) {
+        env->xmm_regs[reg].ZMM_Q(4 + i) = ldq_p(buf + i * 8);
+    }
+    return 32;
+}
+
 #ifdef CONFIG_LINUX_USER
 
 #define IDX_ORIG_AX 0
@@ -644,16 +779,33 @@ static int x86_gdb_write_system(CPUState *cs, uint8_t *buf, int n)
 
 void x86_cpu_gdb_init(CPUState *cs)
 {
+    CPUX86State *env = cpu_env(cs);
 #ifdef TARGET_X86_64
-    CPUX86State *env = &X86_CPU(cs)->env;
     const char *sse_xml = "i386-64bit-sse.xml";
+    const char *avx_xml = "i386-64bit-avx.xml";
+    const char *avx512_xml = "i386-64bit-avx512.xml";
 #else
     const char *sse_xml = "i386-32bit-sse.xml";
+    const char *avx_xml = "i386-32bit-avx.xml";
+    const char *avx512_xml = "i386-32bit-avx512.xml";
 #endif
 
     gdb_register_coprocessor(cs, x86_gdb_read_sse, x86_gdb_write_sse,
                              gdb_find_static_feature(sse_xml));
 
+    if (env->features[FEAT_1_ECX] & CPUID_EXT_AVX) {
+        const GDBFeature *avx = gdb_find_static_feature(avx_xml);
+        g_assert(avx->num_regs == CPU_NB_REGS);
+        gdb_register_coprocessor(cs, x86_gdb_read_avx,
+                                 x86_gdb_write_avx, avx);
+    }
+    if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_AVX512F) {
+        const GDBFeature *avx512 = gdb_find_static_feature(avx512_xml);
+        g_assert(avx512->num_regs == X86_GDB_AVX512_COUNT);
+        gdb_register_coprocessor(cs, x86_gdb_read_avx512,
+                                 x86_gdb_write_avx512, avx512);
+    }
+
 #ifdef TARGET_X86_64
     if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF) {
         gdb_register_coprocessor(cs, i386_cpu_gdb_get_egprs,

-- 
2.56.0.116.g6de20f6092dc


