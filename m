Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EDAC56201
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7u-0005su-Lm; Fri, 20 Feb 2026 10:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2D-0008Dc-FQ; Fri, 20 Feb 2026 10:03:17 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2B-0002LT-PF; Fri, 20 Feb 2026 10:03:13 -0500
DKIM-Signature: a=rsa-sha256; bh=WKnV4L7hUXk8QTYKS6WtDPUEwgGmDE9P4skYagYcYNs=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1771599790; v=1;
 b=i+L5vdOuOPsfiqcDqkyD2xWQT2jrfYmRyQWPKoFuafSG+V0HJp8g0XNjoVpBHS+D7Tu9zQUO
 MiwSD3V807NbJfqPeZv+F/2uFu64/8b/5ElcmJZi3+Twio8huxohIc63Zbz4wf9x466g5n/ZD+A
 3meW5mJLZR/X89fFM6OXaLeKmhK3n7bfnMnDQ5ivOJXmXhl2A6toNbwxuC3hYxQH1WeKkrYUJ+w
 x+rKtGLYew05Kmp9THOxOGeuClvoZlm1wwDnIrVk4/MRTOIgNwA1PMXmUVVupBGr+uWKJHiXMHL
 Pqt7Wvf5X521KlvyRPT6fnrjLd+BBJrEbhO7Pf49OldLQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 3A0B02501F;
 Fri, 20 Feb 2026 15:03:10 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Wed, 15 Feb 2023 18:17:31 +0100
Subject: [PATCH qemu 07/11] [ot] target/riscv: add support for impl-defined
 initial PMP config
Message-ID: <177159976712.8279.7732381632410882915-7@git.sr.ht>
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
---
 target/riscv/cpu.c                | 24 ++++++++++++++++++++++++
 target/riscv/cpu_cfg_fields.h.inc |  7 +++++++
 2 files changed, 31 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 507061e8e9..73aae7fd14 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -792,6 +792,25 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType =
type)
     if (kvm_enabled()) {
         kvm_riscv_reset_vcpu(cpu);
     }
+
+    /* default physical memory protection configuration */
+    const RISCVCPUConfig *cfg =3D &cpu->cfg;
+    g_assert(cfg->pmp_cfg_count <=3D MAX_RISCV_PMPS);
+    g_assert(cfg->pmp_addr_count <=3D MAX_RISCV_PMPS);
+    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
+        env->pmp_state.pmp[i].cfg_reg =3D
+            i < cfg->pmp_cfg_count ? cfg->pmp_cfg[i] : 0;
+    }
+    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
+        env->pmp_state.pmp[i].addr_reg =3D
+            i < cfg->pmp_addr_count ? (target_ulong)cfg->pmp_addr[i] : 0;
+    }
+    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
+        pmp_update_rule_addr(env, i);
+    }
+    pmp_update_rule_nums(env);
+
+    env->mseccfg =3D (target_ulong)cfg->mseccfg;
 #endif
 }
=20
@@ -2670,6 +2689,11 @@ static const Property riscv_cpu_properties[] =3D {
                        DEFAULT_RNMI_IRQVEC),
     DEFINE_PROP_UINT64("rnmi-exception-vector", RISCVCPU, env.rnmi_excpvec,
                        DEFAULT_RNMI_EXCPVEC),
+    DEFINE_PROP_UINT64("mseccfg", RISCVCPU, cfg.mseccfg, 0u),
+    DEFINE_PROP_ARRAY("pmp_cfg", RISCVCPU, cfg.pmp_cfg_count, cfg.pmp_cfg,
+                      qdev_prop_uint8, uint8_t),
+    DEFINE_PROP_ARRAY("pmp_addr", RISCVCPU, cfg.pmp_addr_count, cfg.pmp_addr,
+                      qdev_prop_uint64, uint64_t),
 #endif
=20
     DEFINE_PROP_BOOL("short-isa-string", RISCVCPU, cfg.short_isa_string, fal=
se),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.=
h.inc
index 70ec650abf..39ca957aa6 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -176,5 +176,12 @@ TYPED_FIELD(uint32_t, pmp_granularity, 0)
=20
 TYPED_FIELD(int8_t, max_satp_mode, -1)
=20
+/* physical memory protection HW configuration */
+TYPED_FIELD(uint8_t *, pmp_cfg, 0)
+TYPED_FIELD(uint32_t, pmp_cfg_count, 0)
+TYPED_FIELD(uint64_t *, pmp_addr, 0)
+TYPED_FIELD(uint32_t, pmp_addr_count, 0)
+TYPED_FIELD(uint64_t, mseccfg, 0)
+
 #undef BOOL_FIELD
 #undef TYPED_FIELD
--=20
2.49.1


