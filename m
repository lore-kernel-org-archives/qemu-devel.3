Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91574606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=a/BQ4E+f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRbd5-0003Q0-EJ; Thu, 12 Nov 2026 15:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRbd2-0003Lt-Hv
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 15:42:40 -0500
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRbcz-0002c9-95
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 15:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1794515050; x=1794774250;
 bh=eO8d3oqGFeTzdAkI8ONF0oXDolX1Prx56dghSxHTvhs=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=a/BQ4E+f2zglIKjAwXOHuGqDOyC0AIWXrAynMEvqr6VlHoUwVaaz4kk27RvNQyT3/
 b6XBXyxTs73Ti6S6Vb6IBGJ7P1BWzo4aePApymI6YGxL1Qkrqgu+o+kSdicsMc7IgR
 c4QrqE3saJPriT2Z1Zl+R4CPCsC5xWvtrB13wCcl4kM56lhXUGRspQKK0DEYzRmjs4
 eOvTRPizFhhm3ERPmOCQV2VwSwcgOWTTrQ1NY5dAjfGsLthCJViNl+IZ1I6ufBTiaS
 843qDKJVibgy57n9dx1VT3W1IuP3eFcsgV0Km2Z0Gb4Zx0Ks4APf9LThR+UQghMBMs
 Y9TRT1sdGW85Q==
Date: Thu, 12 Nov 2026 20:24:01 +0000
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH v3] target/riscv: change mstatus bits for read-only if S or U
 unsupported
Message-ID: <20261112202356.23980-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: ffc7f9a036ba6ac3b388a1e60543903a272e2aff
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249;
 envelope-from=christianslima@proton.me; helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The risc v privileged architecture says that mstatus.SXL, UXL, TSR,
TVM and MPRV should be read-only when S-mode or U-mode are not
present.

changes in v3:
- Fixed grammar mistakes and now Daniel can be credited correctly by the to=
oling

Link to v2: https://lore.kernel.org/qemu-riscv/20261110232614.83050-1-chris=
tianslima@proton.me/

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

Signed-off-by: Christian S. Lima <christianslima@proton.me>
Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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



