Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F077C88E56
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50MT-0007bF-11; Fri, 11 Sep 2026 08:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50MR-0007a9-0j
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50MP-00074t-0i
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789129684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1WUW4ELU4Cz0ipri/RHlLjzyu/yidvhECkZjI5ve4Xw=;
 b=GDfFKUE29UGchpeIi+jEE1bnSzjCVG4JB7LZibMtgoZhwyDpDhzhoo2WHmkkV/EzpBroHl
 r0sGgRnfka88k3ZbOp09zXsz5emQBisP21RvNHGRDzZKp3lYKS2XOoh6QtSduGgNSapIOE
 bSyoB2anTy4RaWMN36gxEe55HT62S6M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-eQUljFxnNrSisc8P4tkB1w-1; Fri,
 11 Sep 2026 08:28:00 -0400
X-MC-Unique: eQUljFxnNrSisc8P4tkB1w-1
X-Mimecast-MFC-AGG-ID: eQUljFxnNrSisc8P4tkB1w_1789129677
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F20E61800758; Fri, 11 Sep 2026 12:27:56 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 892901955D89; Fri, 11 Sep 2026 12:27:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 16:27:29 +0400
Subject: [PATCH 06/10] target/m68k: expose system registers via GDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-query-reg-v1-6-0c04f0c02cf3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4755;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IesXY+sDlfCytswu+bEzF53XDpZvcNCkxXDQFYISFMY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqo/OvCueRLcYC4C3/RXua2TzP2GSN4UUbuA/it
 b9X9zRkh3KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqPzrwAKCRDa6OEJdZac
 5R5AD/wN2EbwgmmoxNas9VMAerI+1XMh6VnDOz9Vke+0c2wqm3tEXUxPm/pVz1aQ541rNUZDZX9
 QEw6jHwJ0B3WOyHbZO2+7ZieeIQ5DQpxUmOGDccHBDeW/CTdwyGsdKrb6HpJyJWJJmyGnQEXtbr
 8yrOt8aX9gPE7XUe+8a3szCslCCIFlX3fSsNHtaX0ynYeiDUahJIMW3Y7UA832btaenLYiD4X3K
 K5kMmJHexz/zolp7o9L535BMCAUtrJHYMu6PRKduIyhJj/M8uv2hBDT1Gnpi+1FFB0Zl8PN2y1u
 h+77HlAyyrQL85yeqdkuWmSxUwYPnHsC1BkUZbdR5c/6xjSIKjonknaKHnpteXr/KEuxk+DMlTh
 5NI9A2cfh8yjmApAAKBnH5Zh98Iu0HwLcLh+H7h+TzB4WCoz4kOc2zWh9BkdwFpuy63rf5XlL/H
 ZUwXOUm6hpsG2/x81Fssr6pjv+vTyVoQeAMIHGkAOXac/LWAZHmgK+HzvmxiuxZ3X9xeS1exAbR
 vjDRVnEQrOy/WIflV+4HCpRd2itKYy6dRCYU3APpwpL6XNgrKCgviybSJ81pFkY8ehi6JS1QW8b
 d42z1x4hiNwpIsb49GXnpY6cPx/pGRzVdp6kYrdtyFJ2w0Y9W+VaJE7mMxI5gA6heU301ipn4e1
 KkE+0SG4rizXL6Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add an m68k-system.xml GDB feature that exposes supervisor stack
pointers (ssp, usp, isp), function code registers (sfc, dfc), MMU
registers (urp, srp, dttr0/1, ittr0/1, mmusr) as read-only system
registers through the GDB coprocessor interface.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configs/targets/m68k-softmmu.mak |  2 +-
 gdbstub/gdb-xml/m68k-system.xml  | 32 +++++++++++++++++++++++++++
 target/m68k/helper.c             | 47 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/configs/targets/m68k-softmmu.mak b/configs/targets/m68k-softmmu.mak
index 0bc889f326e3..f3ac9b74c862 100644
--- a/configs/targets/m68k-softmmu.mak
+++ b/configs/targets/m68k-softmmu.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=m68k
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml
+TARGET_XML_FILES= cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml m68k-system.xml
 TARGET_LONG_BITS=32
diff --git a/gdbstub/gdb-xml/m68k-system.xml b/gdbstub/gdb-xml/m68k-system.xml
new file mode 100644
index 000000000000..0a91be0edc00
--- /dev/null
+++ b/gdbstub/gdb-xml/m68k-system.xml
@@ -0,0 +1,32 @@
+<?xml version="1.0"?>
+<!--
+  SPDX-License-Identifier: GPL-2.0-or-later
+-->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<!-- System-register values are read-only; writes are ignored. -->
+<feature name="org.qemu.gdb.m68k.system">
+  <reg name="ssp" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="usp" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="isp" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="sfc" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="dfc" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="urp" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="srp" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="dttr0" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="dttr1" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="ittr0" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="ittr1" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+  <reg name="mmusr" bitsize="32" type="uint32"
+       group="qemu-debug" save-restore="no"/>
+</feature>
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5f91d206f596..f2615d5bcfb8 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -123,6 +123,48 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
+#ifndef CONFIG_USER_ONLY
+static int m68k_gdb_read_system_register(CPUState *cs, GByteArray *buf, int n)
+{
+    CPUM68KState *env = cpu_env(cs);
+    static const int stacks[] = { M68K_SSP, M68K_USP, M68K_ISP };
+
+    if (n >= 0 && n < ARRAY_SIZE(stacks)) {
+        int sp = stacks[n];
+
+        return gdb_get_reg32(buf, env->sp[sp]);
+    }
+    switch (n) {
+    case 3:
+        return gdb_get_reg32(buf, env->sfc);
+    case 4:
+        return gdb_get_reg32(buf, env->dfc);
+    case 5:
+        return gdb_get_reg32(buf, env->mmu.urp);
+    case 6:
+        return gdb_get_reg32(buf, env->mmu.srp);
+    case 7:
+        return gdb_get_reg32(buf, env->mmu.ttr[M68K_DTTR0]);
+    case 8:
+        return gdb_get_reg32(buf, env->mmu.ttr[M68K_DTTR1]);
+    case 9:
+        return gdb_get_reg32(buf, env->mmu.ttr[M68K_ITTR0]);
+    case 10:
+        return gdb_get_reg32(buf, env->mmu.ttr[M68K_ITTR1]);
+    case 11:
+        return gdb_get_reg32(buf, env->mmu.mmusr);
+    default:
+        return 0;
+    }
+}
+
+static int m68k_gdb_write_system_register(CPUState *cs, uint8_t *buf, int n)
+{
+    /* These registers are exposed for inspection only. Ignore writes. */
+    return 4;
+}
+#endif
+
 void m68k_cpu_init_gdb(M68kCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -135,6 +177,11 @@ void m68k_cpu_init_gdb(M68kCPU *cpu)
         gdb_register_coprocessor(cs, m68k_fpu_gdb_get_reg, m68k_fpu_gdb_set_reg,
                                  gdb_find_static_feature("m68k-fp.xml"));
     }
+#ifndef CONFIG_USER_ONLY
+    gdb_register_coprocessor(cs, m68k_gdb_read_system_register,
+                             m68k_gdb_write_system_register,
+                             gdb_find_static_feature("m68k-system.xml"));
+#endif
     /* TODO: Add [E]MAC registers.  */
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


