Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C2AC56201
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7s-0005rf-O1; Fri, 20 Feb 2026 10:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2B-0008CR-1t; Fri, 20 Feb 2026 10:03:12 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS29-0002Kp-C0; Fri, 20 Feb 2026 10:03:10 -0500
DKIM-Signature: a=rsa-sha256; bh=y3mnVFRBz48Yw2IzjiSIHXssFaZ5U7MLuEMtGzsSPsc=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1771599788; v=1;
 b=oWxUtkgku9BWFCUpjeFwgablpsBkq6mt2Sx0G5UnGB2BJ/xwWv9J3+f2Ua4lkfOH06rwl0Af
 lL3kV8nD9fTVjxOjvvnMvKJDsq5exY+bWaIImzmKS/kOY//u3x+yR/NI/nDt26muVvaRGmV46hy
 Zmjnncqr/ridAYFG8ndMyQhGllMsZiDJhLFP0h/+LTdluh4z2CZkNr+yYM80GGV86Dc4KHJwjjP
 vlwfWuhRj5Dlw0dGOcyTr/u84PgjptogtrPtrqnFWczAyHbtipDc9tWMyuFM9XF9ZI7iW6tlwXR
 KwkLXqFaMDsG4THRE3U0UepObfbBn519ephrf7YX2SsDg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id EA4552501C;
 Fri, 20 Feb 2026 15:03:07 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 07 Feb 2023 16:59:35 +0100
Subject: [PATCH qemu 04/11] [ot] target/riscv: implement custom LowRisc Ibex
 CSRs
Message-ID: <177159976712.8279.7732381632410882915-4@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177159976712.8279.7732381632410882915-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Daniel =?utf-8?q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 lowRISC <qemu-maintainers@lowrisc.org>, nabihestefan@google.com,
 Amit Kumar-Hermosillo <amitkh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Feb 2026 10:09:01 -0500
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Emmanuel Blot <eblot@rivosinc.com>

Signed-off-by: Emmanuel Blot <eblot@rivosinc.com>

Includes existing MIT licenced code (already published elsewhere)
---
 target/riscv/cpu.c       |  2 +-
 target/riscv/cpu.h       |  7 ++++
 target/riscv/ibex_csr.c  | 85 ++++++++++++++++++++++++++++++++++++++++
 target/riscv/meson.build |  1 +
 4 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/ibex_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 24a4c2fd3f..dd30b21dd2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3056,7 +3056,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
         .cfg.ext_zbc =3D true,
-        .cfg.ext_zbs =3D true
+        .cfg.ext_zbs =3D true,
     ),
=20
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 35d1f6362c..faf55e8b5e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -481,6 +481,10 @@ struct CPUArchState {
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
     uint64_t sstateen[SMSTATEEN_MAX_COUNT];
     uint64_t henvcfg;
+
+    /* Ibex custom CSRs */
+    target_ulong cpuctrlsts;
+    target_ulong secureseed;
 #endif
=20
     /* Fields from here on are preserved across CPU reset. */
@@ -988,5 +992,8 @@ extern const RISCVCSR th_csr_list[];
 /* Implemented in mips_csr.c */
 extern const RISCVCSR mips_csr_list[];
=20
+/* Implemented in ibex_csr.c */
+extern const RISCVCSR ibex_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/ibex_csr.c b/target/riscv/ibex_csr.c
new file mode 100644
index 0000000000..d62638bbfb
--- /dev/null
+++ b/target/riscv/ibex_csr.c
@@ -0,0 +1,85 @@
+/*
+ * QEMU LowRisc Ibex core features
+ *
+ * Copyright (c) 2023 Rivos, Inc.
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+
+/* Custom CSRs */
+#define CSR_CPUCTRLSTS 0x7c0
+#define CSR_SECURESEED 0x7c1
+
+#define CPUCTRLSTS_ICACHE_ENABLE     0x000
+#define CPUCTRLSTS_DATA_IND_TIMING   0x001
+#define CPUCTRLSTS_DUMMY_INSTR_EN    0x002
+#define CPUCTRLSTS_DUMMY_INSTR_MASK  0x038
+#define CPUCTRLSTS_SYNC_EXC_SEEN     0x040
+#define CPUCTRLSTS_DOUBLE_FAULT_SEEN 0x080
+#define CPUCTRLSTS_IC_SCR_KEY_VALID  0x100
+
+#if !defined(CONFIG_USER_ONLY)
+
+static RISCVException read_cpuctrlsts(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D CPUCTRLSTS_IC_SCR_KEY_VALID | env->cpuctrlsts;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_cpuctrlsts(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t a)
+{
+    /* b7 can only be cleared */
+    env->cpuctrlsts &=3D ~0xbf;
+    /* b6 should be cleared on mret */
+    env->cpuctrlsts |=3D val & 0x3f;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_secureseed(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    /*
+     * "Seed values are not actually stored in a register and so reads to th=
is
+     * register will always return zero."
+     */
+    *val =3D 0;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_secureseed(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t a)
+{
+    (void)val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    /*
+     *  unfortunately, this predicate is not public, so duplicate the standa=
rd
+     *  implementation
+     */
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR ibex_csr_list[] =3D {
+    {
+        .csrno =3D CSR_CPUCTRLSTS,
+        .csr_ops =3D { "cpuctrlsts", any, &read_cpuctrlsts, &write_cpuctrlst=
s },
+    },
+    {
+        .csrno =3D CSR_SECURESEED,
+        .csr_ops =3D { "secureseed", any, &read_secureseed, &write_securesee=
d },
+    },
+    {}
+};
+
+#endif /* !defined(CONFIG_USER_ONLY) */
+
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 3842c7c1a8..5a174a6feb 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -17,6 +17,7 @@ riscv_ss.add(files(
   'cpu.c',
   'cpu_helper.c',
   'csr.c',
+  'ibex_csr.c',
   'fpu_helper.c',
   'gdbstub.c',
   'op_helper.c',
--=20
2.49.1


