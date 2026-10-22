Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B9606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bHZQ87Pf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqUi-0003zh-4q; Thu, 22 Oct 2026 06:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUg-0003wp-BS
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUb-0001ds-Ge
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PS/DesDuFe83rdOhq2fGJrRWQSHKw5jiPfPuERYstNE=;
 b=bHZQ87PfqBUrRHv/2H8K/wV7UAa6hLsbbz3vi5zNMT42eHKnQUGfmhHwHw+MXYcQ/yePhH
 m1PzIFXIEGoa4nM0+tC4k+JIPsRmen26mocPXGrZpNtbBbXxp2JDgAvQvF5IA6iXFcPV5/
 WU+uGfP0ZKFCfgzzARAafXIHoMP1aNc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-fEnJs78yM4m3yONBxygXaA-1; Thu,
 22 Oct 2026 10:57:51 +0000
X-MC-Unique: fEnJs78yM4m3yONBxygXaA-1
X-Mimecast-MFC-AGG-ID: fEnJs78yM4m3yONBxygXaA_1792666667
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEE9B18002D7; Thu, 22 Oct 2026 10:57:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0F6F195608C; Thu, 22 Oct 2026 10:57:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:44 +0400
Subject: [PATCH v3 17/18] target/riscv: expose register aliases to monitors
 via gdbstub
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-17-7ad902b9a7cf@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=32105;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WzILhN/hYW6mi5xYG8UQCpf/aUKcvzOlA7lYipmAjPM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evnQOcZ7vQaz8DODi9X7BosSqqk8gUkxh/ZT
 R22MQnZTQmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5wAKCRDa6OEJdZac
 5SazD/4sVMJyES6o6HdVZmzNMHcDMkR+WJx6veTulLwbjg684s1bLwlegnvzwTcuhGKxZZKTrbG
 io7HwzdJ9U1Cs0Z08c6MdOuPtKir8Fl21PPu0RiE/ih6Nl4mielVn8fCOVfJ0OuLph/03io5MqY
 jxe5EjmrSrVRNtfUirmF3+z2gjEvDk+2WVecZPg3L27Opkf1gUJlx0Rk+O/nD1yzsEg7iWLOzlh
 kgJIN+Fa867kUjhX+aDSQ6+O+OVQy31IXOjn+z842Xa7riJKGJxnT1lGn6EqNxq8kh1a3n0rAKJ
 4JKL/Cb7AJ+GZT1STahfClNw6ujVybJd65eK2OSXIe+Hm9KfI7CnQvUhT5IXnJYtvJN9Fux/BEK
 8JtVBOsWts6HncY7zpkdafJX9qeFHwPmTXT0C4kBVxZPszbWTQ5b7v32syBzC+qJiMkFDTRtwAa
 lcxMPLauLeJvLRGd42Z1Sntm3C2SibL7SigFhFIMFGzdHrZ44nOGAviiO2XP0f2cL+xDYNHZ8dK
 Z771s3tddYxJSAoV5uLe8xb+0DJiJRQ52c2bl8YlkaFtycoml4EHvC+2PrpQdR7hBmRW9m1S9/P
 cezdbRmo6G6od2p95JZyAglkAar9j+j+EfYzDywfHM46on0ZSsb3pBUUb9D/1ClKZHJPJFK7/Ip
 XjhgcktmiE59kRQ==
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The core GDB XML uses ABI names (zero, ra, sp, fp, ft0, fs0, etc.)
but users also refer to registers by their numeric names (x0-x31,
f0-f31) and the s0 alias for fp. The legacy MonitorDef mechanism
supported both via split "x0/zero" name matching.

Register a feature that maps:
 - x0-x31 and s0 to the corresponding core integer registers
 - x0h-x31h and their ABI aliases (zeroh, rah, ...) to env->gprh[]
 - f0-f31 to the corresponding FPU registers (when FPU is present)

CSR-by-name lookups ($mstatus, $sstatus, ...) keep working, through
the existing GDB CSR feature rather than the removed csr_ops loop.

Lookup is now case-sensitive (consistent with all other targets),
including for the CSR names. Vector registers report "unknown
register" instead of the target-specific "Unable to print the value
of vector vreg" message.

RV32 numeric and high-half aliases now zero-extend into HMP’s 64-bit
expression value (for example, $x1 containing 0xffffffff evaluates to
4294967295, whereas the legacy fallback returned -1). This makes aliases
consistent with the existing GDB-backed names.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configs/targets/riscv32-linux-user.mak    |   2 +-
 configs/targets/riscv32-softmmu.mak       |   2 +-
 configs/targets/riscv64-bsd-user.mak      |   2 +-
 configs/targets/riscv64-linux-user.mak    |   2 +-
 configs/targets/riscv64-softmmu.mak       |   2 +-
 gdbstub/gdb-xml/riscv-32bit-alias.xml     | 105 ++++++++++++++++++++++
 gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml |  40 +++++++++
 gdbstub/gdb-xml/riscv-64bit-alias.xml     | 105 ++++++++++++++++++++++
 gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml |  46 ++++++++++
 target/riscv/cpu.c                        |   1 -
 target/riscv/gdbstub.c                    |  48 ++++++++++
 target/riscv/internals.h                  |   3 -
 target/riscv/monitor.c                    | 140 ------------------------------
 13 files changed, 349 insertions(+), 149 deletions(-)

diff --git a/configs/targets/riscv32-linux-user.mak b/configs/targets/riscv32-linux-user.mak
index d88fdf5e1b2f..8ee14fa14383 100644
--- a/configs/targets/riscv32-linux-user.mak
+++ b/configs/targets/riscv32-linux-user.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=riscv32
 TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
-TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-virtual.xml
+TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-virtual.xml riscv-32bit-alias.xml riscv-32bit-fpu-alias.xml riscv-64bit-fpu-alias.xml
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_SYSTBL_ABI=32
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index 5d5016d00832..c717940344f0 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=riscv32
 TARGET_BASE_ARCH=riscv
-TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-virtual.xml
+TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-virtual.xml riscv-32bit-alias.xml riscv-32bit-fpu-alias.xml riscv-64bit-fpu-alias.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv64-bsd-user.mak
index 5b4e138099fc..1d37e018c871 100644
--- a/configs/targets/riscv64-bsd-user.mak
+++ b/configs/targets/riscv64-bsd-user.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
-TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml
+TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-64bit-alias.xml riscv-32bit-fpu-alias.xml riscv-64bit-fpu-alias.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv64-linux-user.mak b/configs/targets/riscv64-linux-user.mak
index 35621520c560..564d15aaca8c 100644
--- a/configs/targets/riscv64-linux-user.mak
+++ b/configs/targets/riscv64-linux-user.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
-TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml
+TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-64bit-alias.xml riscv-32bit-fpu-alias.xml riscv-64bit-fpu-alias.xml
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_SYSTBL_ABI=64
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index a10dc03c04c8..28bfcdc575fb 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_KVM_HAVE_GUEST_DEBUG=y
-TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-32bit-cpu.xml riscv-32bit-virtual.xml
+TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-32bit-cpu.xml riscv-32bit-virtual.xml riscv-32bit-alias.xml riscv-64bit-alias.xml riscv-32bit-fpu-alias.xml riscv-64bit-fpu-alias.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
diff --git a/gdbstub/gdb-xml/riscv-32bit-alias.xml b/gdbstub/gdb-xml/riscv-32bit-alias.xml
new file mode 100644
index 000000000000..a00a86ebdf95
--- /dev/null
+++ b/gdbstub/gdb-xml/riscv-32bit-alias.xml
@@ -0,0 +1,105 @@
+<?xml version="1.0"?>
+<!--
+  SPDX-License-Identifier: GPL-2.0-or-later
+-->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.qemu.gdb.riscv.alias">
+  <reg name="x0" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x1" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x2" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x3" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x4" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x5" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x6" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x7" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x8" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x9" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x10" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x11" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x12" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x13" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x14" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x15" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x16" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x17" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x18" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x19" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x20" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x21" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x22" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x23" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x24" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x25" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x26" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x27" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x28" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x29" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x30" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x31" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s0" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x0h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="zeroh" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x1h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="rah" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x2h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="sph" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x3h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="gph" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x4h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="tph" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x5h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="t0h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x6h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="t1h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x7h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="t2h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x8h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s0h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x9h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s1h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x10h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="a0h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x11h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="a1h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x12h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="a2h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x13h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="a3h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x14h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="a4h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x15h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="a5h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x16h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="a6h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x17h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="a7h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x18h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s2h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x19h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s3h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x20h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s4h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x21h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s5h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x22h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s6h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x23h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s7h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x24h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s8h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x25h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s9h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x26h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s10h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x27h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="s11h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x28h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="t3h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x29h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="t4h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x30h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="t5h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="x31h" bitsize="32" type="int" group="qemu-debug"/>
+  <reg name="t6h" bitsize="32" type="int" group="qemu-debug"/>
+</feature>
diff --git a/gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml b/gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml
new file mode 100644
index 000000000000..3935f72ea289
--- /dev/null
+++ b/gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml
@@ -0,0 +1,40 @@
+<?xml version="1.0"?>
+<!--
+  SPDX-License-Identifier: GPL-2.0-or-later
+-->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.qemu.gdb.riscv.fpu-alias">
+  <reg name="f0" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f1" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f2" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f3" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f4" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f5" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f6" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f7" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f8" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f9" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f10" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f11" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f12" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f13" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f14" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f15" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f16" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f17" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f18" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f19" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f20" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f21" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f22" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f23" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f24" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f25" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f26" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f27" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f28" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f29" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f30" bitsize="32" type="ieee_single" group="qemu-debug"/>
+  <reg name="f31" bitsize="32" type="ieee_single" group="qemu-debug"/>
+</feature>
diff --git a/gdbstub/gdb-xml/riscv-64bit-alias.xml b/gdbstub/gdb-xml/riscv-64bit-alias.xml
new file mode 100644
index 000000000000..28781b230226
--- /dev/null
+++ b/gdbstub/gdb-xml/riscv-64bit-alias.xml
@@ -0,0 +1,105 @@
+<?xml version="1.0"?>
+<!--
+  SPDX-License-Identifier: GPL-2.0-or-later
+-->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.qemu.gdb.riscv.alias">
+  <reg name="x0" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x1" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x2" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x3" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x4" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x5" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x6" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x7" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x8" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x9" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x10" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x11" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x12" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x13" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x14" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x15" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x16" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x17" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x18" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x19" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x20" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x21" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x22" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x23" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x24" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x25" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x26" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x27" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x28" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x29" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x30" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x31" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s0" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x0h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="zeroh" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x1h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="rah" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x2h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="sph" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x3h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="gph" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x4h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="tph" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x5h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="t0h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x6h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="t1h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x7h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="t2h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x8h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s0h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x9h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s1h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x10h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="a0h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x11h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="a1h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x12h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="a2h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x13h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="a3h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x14h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="a4h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x15h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="a5h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x16h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="a6h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x17h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="a7h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x18h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s2h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x19h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s3h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x20h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s4h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x21h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s5h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x22h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s6h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x23h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s7h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x24h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s8h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x25h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s9h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x26h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s10h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x27h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="s11h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x28h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="t3h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x29h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="t4h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x30h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="t5h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="x31h" bitsize="64" type="int" group="qemu-debug"/>
+  <reg name="t6h" bitsize="64" type="int" group="qemu-debug"/>
+</feature>
diff --git a/gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml b/gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml
new file mode 100644
index 000000000000..13e6b341a0f8
--- /dev/null
+++ b/gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml
@@ -0,0 +1,46 @@
+<?xml version="1.0"?>
+<!--
+  SPDX-License-Identifier: GPL-2.0-or-later
+-->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.qemu.gdb.riscv.fpu-alias">
+
+  <union id="riscv_double">
+    <field name="float" type="ieee_single"/>
+    <field name="double" type="ieee_double"/>
+  </union>
+
+  <reg name="f0" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f1" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f2" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f3" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f4" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f5" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f6" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f7" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f8" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f9" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f10" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f11" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f12" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f13" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f14" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f15" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f16" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f17" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f18" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f19" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f20" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f21" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f22" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f23" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f24" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f25" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f26" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f27" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f28" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f29" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f30" bitsize="64" type="riscv_double" group="qemu-debug"/>
+  <reg name="f31" bitsize="64" type="riscv_double" group="qemu-debug"/>
+</feature>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08a4d14ea1f6..7b052da6d8b4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3107,7 +3107,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .legacy_vmsd = &vmstate_riscv_cpu,
 #ifdef CONFIG_TCG
     .translate_for_debug = riscv_cpu_translate_for_debug,
-    .monitor_get_register = riscv_monitor_get_register_legacy,
 #endif
 };
 #endif
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index f279f4ab2461..0d89caf8ba36 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -336,10 +336,42 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
     return &cpu->dyn_vreg_feature;
 }
 
+/* x0-x31, s0, then pairs of numeric and ABI high-half aliases. */
+static int riscv_gdb_get_alias(CPUState *cs, GByteArray *buf, int n)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint64_t val;
+
+    if (n < 33) {
+        return riscv_cpu_gdb_read_register(cs, buf, n == 32 ? 8 : n);
+    }
+
+    val = cpu->env.gprh[(n - 33) / 2];
+    if (riscv_cpu_is_32bit(cpu)) {
+        return gdb_get_reg32(buf, val);
+    }
+    return gdb_get_reg64(buf, val);
+}
+
+static int riscv_gdb_set_alias(CPUState *cs, uint8_t *buf, int n)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
+
+    if (n < 33) {
+        return riscv_cpu_gdb_write_register(cs, buf, n == 32 ? 8 : n);
+    }
+
+    env->gprh[(n - 33) / 2] = ldn(env, buf, regsz);
+    return regsz;
+}
+
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+
     if (env->misa_ext & RVD) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
                                  gdb_find_static_feature("riscv-64bit-fpu.xml"));
@@ -380,4 +412,20 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  feature);
     }
 #endif
+
+    gdb_register_internal_coprocessor(
+        cs, riscv_gdb_get_alias, riscv_gdb_set_alias,
+        gdb_find_static_feature(riscv_cpu_is_32bit(cpu) ?
+                                "riscv-32bit-alias.xml" :
+                                "riscv-64bit-alias.xml"));
+
+    if (env->misa_ext & RVD) {
+        gdb_register_internal_coprocessor(
+            cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
+            gdb_find_static_feature("riscv-64bit-fpu-alias.xml"));
+    } else if (env->misa_ext & RVF) {
+        gdb_register_internal_coprocessor(
+            cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
+            gdb_find_static_feature("riscv-32bit-fpu-alias.xml"));
+    }
 }
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f17d011d22fb..f4af4636c6ca 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -265,7 +265,4 @@ static inline int insn_len(uint16_t first_word)
     return (first_word & 3) == 3 ? 4 : 2;
 }
 
-int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
-                                      int64_t *pval);
-
 #endif
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 7e61ae2a4717..20f3ba57ae57 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -19,10 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/ctype.h"
-#include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "target/riscv/tcg/csr.h"
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
@@ -247,140 +244,3 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
     mem_info_svxx(hmp, env);
 }
 #endif /* CONFIG_HMP */
-
-#ifdef CONFIG_TCG
-static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
-                                 target_ulong *val, bool is_gprh)
-{
-    const char * const *reg_names;
-    uint64_t *vals;
-
-    if (is_gprh) {
-        reg_names = riscv_int_regnamesh;
-        vals = env->gprh;
-    } else {
-        reg_names = riscv_int_regnames;
-        vals = env->gpr;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        g_auto(GStrv) reg_name = g_strsplit(reg_names[i], "/", 2);
-
-        g_assert(reg_name[0]);
-        g_assert(reg_name[1]);
-
-        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
-            g_ascii_strcasecmp(reg_name[1], name) == 0) {
-            *val = vals[i];
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_t *val)
-{
-    if (qemu_tolower(name[0]) != 'f') {
-        return false;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        g_auto(GStrv) reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
-
-        g_assert(reg_name[0]);
-        g_assert(reg_name[1]);
-
-        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
-            g_ascii_strcasecmp(reg_name[1], name) == 0) {
-            *val = env->fpr[i];
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static bool reg_is_vreg(const char *name)
-{
-    if (qemu_tolower(name[0]) != 'v' || strlen(name) > 3) {
-        return false;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        if (g_ascii_strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
-int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
-                                      int64_t *pval)
-{
-    RISCVCPU *hart = RISCV_CPU(cs);
-    CPURISCVState *env = cpu_env(cs);
-    target_ulong val = 0;
-    uint64_t val64 = 0;
-    int i;
-
-    if (reg_is_ulong_integer(env, name, &val, false) ||
-        reg_is_ulong_integer(env, name, &val, true)) {
-        *pval = riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
-        return 0;
-    }
-
-    if (reg_is_u64_fpu(env, name, &val64)) {
-        *pval = val64;
-        return 0;
-    }
-
-    if (reg_is_vreg(name)) {
-        if (!riscv_cpu_cfg(env)->ext_zve32x) {
-            return -EINVAL;
-        }
-
-        qemu_printf("Unable to print the value of vector "
-                    "vreg '%s' from this API\n", name);
-
-        /*
-         * We're returning 0 because returning -EINVAL triggers
-         * an 'unknown register' message in exp_unary() later,
-         * which feels ankward after our own error message.
-         */
-        *pval = 0;
-        return 0;
-    }
-
-    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
-        RISCVException res;
-        int csrno = i;
-
-        /*
-         * Early skip when possible since we're going
-         * through a lot of NULL entries.
-         */
-        if (csr_ops[csrno].predicate == NULL) {
-            continue;
-        }
-
-        if (g_ascii_strcasecmp(csr_ops[csrno].name, name) != 0) {
-            continue;
-        }
-
-        res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
-
-        /*
-         * Rely on the smode, hmode, etc, predicates within csr.c
-         * to do the filtering of the registers that are present.
-         */
-        if (res == RISCV_EXCP_NONE) {
-            *pval = riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
-            return 0;
-        }
-    }
-
-    return -EINVAL;
-}
-#endif

-- 
2.56.0.116.g6de20f6092dc


