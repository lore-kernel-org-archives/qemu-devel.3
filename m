Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3440F606D81C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=aetCH0eF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOjVo-00040d-G6; Wed, 04 Nov 2026 17:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xOjVl-0003zr-QK
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 17:31:17 -0500
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xOjVj-0001kP-L3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 17:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1793831462; x=1794090662;
 bh=JZumWzVN7C5a/pdIzd+1FoSsPdaRXtn2jzxCPr4jBws=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=aetCH0eFKBiCElv/wOS/QzvuV+g4zTX8vf7XZNB41RBpVCHyxJmYxtyt7rCHkQPMY
 Dw9CqDEcMLqprumAr6IuWdsdLsyy/z9ci2t3PZj7Yf7C62MrVQb+qQGXRyVj63xoSV
 P746bm/jUhq8Bi3AvWeIrv1NLaDTPNx4au6qOsDBoPh2EtyNzoA7Ia3mIU8DZfrdy3
 oET4GO3fVT5+e9uMpc4cU12u040WzEnL4aZir3Ru81S8GWUELMiFOZoVhCmJawCdgi
 gbv4oe82jvuUDqROh2IAmrq0vGacKekEC1ZPBdDj7XRTHmJJOb7x6qa+U/e9cJfAnv
 N0i8GwXFnUQxA==
Date: Wed, 04 Nov 2026 22:30:56 +0000
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH] target/riscv: change mstatus bits for read-only if S ou U
 unsupported
Message-ID: <20261104223049.86286-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: d2265e9a164f176fda70b95137c2910dbf2efb4e
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The risc v privileged architecture says that mstatus.SXL, UXL, TSR,
TVM and MPVR should be read-only when S-mode or U-mode are not present.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4456

Signed-off-by: Christian S. Lima <christianslima@proton.me>
---
 target/riscv/cpu_bits.h |  4 ++--
 target/riscv/tcg/csr.c  | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 3579789a1f..ee7981c91e 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -668,8 +668,8 @@
 #define MSTATUS_MPV         0x8000000000ULL
 #define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
=20
-#define MSTATUS64_UXL       0x0000000300000000ULL
-#define MSTATUS64_SXL       0x0000000C00000000ULL
+#define MSTATUS64_UXL       0x0000000200000000ULL
+#define MSTATUS64_SXL       0x0000000A00000000ULL
=20
 #define MSTATUS32_SD        0x80000000
 #define MSTATUS64_SD        0x8000000000000000ULL
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



