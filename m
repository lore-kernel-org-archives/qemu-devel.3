Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C041CCA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGMkL-0004KY-RM; Mon, 12 Oct 2026 16:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMk3-0003gQ-OD
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjy-0003PY-El
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791837321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylzV0Bc3H/C0kOdwreoojkYALggNTzrD9Dl8vcWbD2E=;
 b=IQQAomuVbfrxcM57Ow/73Ud38Ihg/sz8DRfPe1r5LRkiqOVZQFvobwMehkbqMtoouYRL2T
 oqism9BI3str1XBGWgh/65rykov3yn+nuePy9/FK6NaZ9uLBfg1z30AeeYzahhdikpsOUb
 KW/zITTOJ6ifiM+RB++Sp6CCbkXFnR4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-2ew-TTRPM_2I85krkwmafw-1; Mon,
 12 Oct 2026 20:35:15 +0000
X-MC-Unique: 2ew-TTRPM_2I85krkwmafw-1
X-Mimecast-MFC-AGG-ID: 2ew-TTRPM_2I85krkwmafw_1791837312
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB61A180059E; Mon, 12 Oct 2026 20:35:12 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3000195608F; Mon, 12 Oct 2026 20:35:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 00:34:12 +0400
Subject: [PATCH v2 09/10] target/riscv: expose register aliases via GDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-query-reg-v2-9-6f95a2e139a9@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=26233;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5RuOjUNyaDEDL5nBL66I/LpUP+P269OjTlXEVv1zuew=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGrNREGganj2NF03DTbLm9oZjvtUOaPdc+cN3Q38t0rV1+/EJ
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqzURBAAoJENro4Ql1lpzlBN0P/3Z9
 YtabG0oLC52uljA6LBFjqOEGRcWT2y4UlbnS/dr5H3LXubGKYkqVAocMD6Mu/YRwhkl6+YU79Nd
 QAq+8/EvmXBMtj2kmvykhuHSnlgiFZzw+O9dk0DJFzshgR5KXbRf8dmX8XT/b/8EeN7E0lC++F6
 wGAZqlibE9eYao5WDSL6k54NmqnwTjt0GTZ9EhQlOBiOasJ7VFNMqSE+BsbnTAphamWxJq3Jqz2
 KfZHn/XLfvgV6pYIhqJfejBapavKIVg1T+2uED+M53qXnKjMlaL6fFdHq54+XCh7ZO3wQ7+qSRa
 JsWUaSeY9yLPb9e6mnnjhbgJgUZblB7UNvvM26Vu8tI1CTQmGXo8lXY0+w2wOr+Dc1Ei3dOr2dQ
 DFYpJy835eFp+1fCJuXnHuIooaffbNkPV/15IzbT946RL3JSyOJys9HsiYfUKLCmNFdMFkrRiiF
 n5hPYm51QqGNc8zjQx7BIrn2bt3jhfI7ousr0pQ4zMUtx3Cvjqlw1ATyBLpp+7j5UNDhx1zLrmn
 7Vr635AgebrEUySaz7D/7AtLqPOYKdLOotfMKZXY6g6DRUcpzWDsUr0+F0np9/SGdEjqS0UKqxg
 EYWF5CuievVb4KmFGAzFRHzyDxruZdZF1MpMufwW2Del32y/UUEuI4cOcaXd+ENbmEZXxjRQzeN
 1IJSr
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The core GDB XML uses ABI names (zero, ra, sp, fp, ft0, fs0, etc.)
but users also refer to registers by their numeric names (x0-x31,
f0-f31) and the s0 alias for fp. The legacy MonitorDef mechanism
supported both via split "x0/zero" name matching.

Register a feature that maps:
 - x0-x31 and s0 to the corresponding core integer registers
 - x0h-x31h and their ABI aliases (zeroh, rah, ...) to env->gprh[]
 - f0-f31 to the corresponding FPU registers (when FPU is present)

This preserves full HMP $register compatibility after the MonitorDef
removal.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configs/targets/riscv32-linux-user.mak    |   2 +-
 configs/targets/riscv32-softmmu.mak       |   2 +-
 configs/targets/riscv64-bsd-user.mak      |   2 +-
 configs/targets/riscv64-linux-user.mak    |   2 +-
 configs/targets/riscv64-softmmu.mak       |   2 +-
 gdbstub/gdb-xml/riscv-32bit-alias.xml     | 105 ++++++++++++++++++++++++++++++
 gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml |  40 ++++++++++++
 gdbstub/gdb-xml/riscv-64bit-alias.xml     | 105 ++++++++++++++++++++++++++++++
 gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml |  46 +++++++++++++
 target/riscv/gdbstub.c                    |  47 +++++++++++++
 10 files changed, 348 insertions(+), 5 deletions(-)

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
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index f279f4ab2461..cc7f17491efb 100644
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
@@ -380,4 +412,19 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  feature);
     }
 #endif
+
+    gdb_register_internal_coprocessor(cs, riscv_gdb_get_alias, riscv_gdb_set_alias,
+        gdb_find_static_feature(riscv_cpu_is_32bit(cpu) ?
+            "riscv-32bit-alias.xml" :
+            "riscv-64bit-alias.xml"));
+
+    if (env->misa_ext & RVD) {
+        gdb_register_internal_coprocessor(cs, riscv_gdb_get_fpu,
+            riscv_gdb_set_fpu,
+            gdb_find_static_feature("riscv-64bit-fpu-alias.xml"));
+    } else if (env->misa_ext & RVF) {
+        gdb_register_internal_coprocessor(cs, riscv_gdb_get_fpu,
+            riscv_gdb_set_fpu,
+            gdb_find_static_feature("riscv-32bit-fpu-alias.xml"));
+    }
 }

-- 
2.56.0.116.g6de20f6092dc


