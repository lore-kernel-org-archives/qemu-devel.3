Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F70606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=cGd/D66r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQvEl-0006nH-I9; Tue, 10 Nov 2026 18:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xQvEi-0006n0-FK
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 18:26:44 -0500
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xQvEd-0002Ks-T5
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 18:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1794353188; x=1794612388;
 bh=Yz3noM1RPDUZOGb7ABFp/wgt5+rbrpxqiejpDijhdCc=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=cGd/D66rbaOt5AcV936o9XpfI8OZVuOikYn4kK7JRzypTqKg97Hf0ZueOO1+tAXha
 uDAb5IvwImRxQaB298PrC7EymTjODOd8x6CFa6QEJseMN/pCXWjU3F2nupdFmKdreX
 gTPZNPJzg4abWdHEeyHUgHijg2IqVppVBwU2ID4LUbq47rUndD1v/Rv0xP1AS3sesB
 94zlOIvqiWOxmCYkrI3neh1mA47H1VquCX/Dz7DgctmQGlE3xIjBLRkKyHsZJehkB8
 h2+v2jJvjpCUQnkVk0bCjgNnG1kned7nRBvM6SQo3jhBdQd/Y5nVQ7XCBzEVj7FGJN
 nJ5/jN3U1sAgQ==
Date: Tue, 10 Nov 2026 23:26:20 +0000
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH v2] target/riscv: change mstatus bits for read-only if S ou U
 unsupported
Message-ID: <20261110232614.83050-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: 343423d13731d85eaf7aa54b3a3640096b8c6bf3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.210.45;
 envelope-from=christianslima@proton.me; helo=mail-06.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The risc v privileged architecture says that mstatus.SXL, UXL, TSR,
TVM and MPVR should be read-only when S-mode or U-mode are not
present.

changes in v2:
- Don't change bits in target/riscv/cpu_bits.h
- Add checks to S-Mode in the mstatus.SXL and U-mode mstatus.UXL in
the target/riscv/cpu.c file that were suggested by Daniel in the
review [1]

Link to v1: https://lore.kernel.org/qemu-riscv/20261104223049.86286-1-chris=
tianslima@proton.me/

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4456

[1] https://lore.kernel.org/qemu-riscv/20261104223049.86286-1-christianslim=
a@proton.me/T/#mddbb34a3ea837e3c707131a2e354c63c989ab029

Suugested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Christian S. Lima <christianslima@proton.me>
---
 target/riscv/cpu.c     | 12 ++++++++++--
 target/riscv/tcg/csr.c | 17 ++++++++++++-----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 15c27f4ce4..50bdfbe025 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -997,8 +997,16 @@ static void riscv_cpu_reset_hold(Object *obj, ResetTyp=
e type)
          * The reset status of SXL/UXL is undefined, but mstatus is WARL
          * and we must ensure that the value after init is valid for read.
          */
-        env->mstatus =3D set_field(env->mstatus, MSTATUS64_SXL, env->misa_=
mxl);
-        env->mstatus =3D set_field(env->mstatus, MSTATUS64_UXL, env->misa_=
mxl);
+        if (riscv_has_ext(env, RVS)) {
+            env->mstatus =3D set_field(env->mstatus,
+                                     MSTATUS64_SXL, env->misa_mxl);
+        }
+
+        if (riscv_has_ext(env, RVU)) {
+            env->mstatus =3D set_field(env->mstatus,
+                                     MSTATUS64_UXL, env->misa_mxl);
+        }
+
         if (riscv_has_ext(env, RVH)) {
             env->vsstatus =3D set_field(env->vsstatus,
                                       MSTATUS64_SXL, env->misa_mxl);
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..24eda54bac 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2081,18 +2081,25 @@ static RISCVException write_mstatus(CPURISCVState *=
env, int csrno,
         tlb_flush(env_cpu(env));
     }
     mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
-        MSTATUS_SPP | MSTATUS_MPRV | MSTATUS_SUM |
-        MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
-        MSTATUS_TW;
+        MSTATUS_SPP | MSTATUS_SUM | MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TW=
;
=20
     if (riscv_has_ext(env, RVF)) {
         mask |=3D MSTATUS_FS;
     }
=20
+    if (riscv_has_ext(env, RVS) || riscv_has_ext(env, RVU)) {
+        mask |=3D MSTATUS_MPRV;
+    }
+
     if (riscv_cpu_cfg(env)->ext_zve32x) {
         mask |=3D MSTATUS_VS;
     }
=20
+    if (riscv_has_ext(env, RVS)) {
+        mask |=3D MSTATUS_TSR;
+        mask |=3D MSTATUS_TVM;
+    }
+
     if (riscv_env_smode_dbltrp_enabled(env, env->virt_enabled)) {
         mask |=3D MSTATUS_SDT;
         if ((val & MSTATUS_SDT) !=3D 0) {
@@ -2111,12 +2118,12 @@ static RISCVException write_mstatus(CPURISCVState *=
env, int csrno,
         if (riscv_has_ext(env, RVH)) {
             mask |=3D MSTATUS_MPV | MSTATUS_GVA;
         }
-        if ((val & MSTATUS64_SXL) !=3D 0) {
+        if (riscv_has_ext(env, RVS) && (val & MSTATUS64_SXL) !=3D 0) {
             mask |=3D MSTATUS64_SXL;
             val =3D riscv_write_uxl(env, val, MSTATUS64_SXL);
         }
=20
-        if ((val & MSTATUS64_UXL) !=3D 0) {
+        if (riscv_has_ext(env, RVU) && (val & MSTATUS64_UXL) !=3D 0) {
             mask |=3D MSTATUS64_UXL;
             val =3D riscv_write_uxl(env, val, MSTATUS64_UXL);
         }
--=20
2.56.0



