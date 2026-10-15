Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B457CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGHx-0000tM-BM; Thu, 15 Oct 2026 03:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGHs-0000r3-8C; Thu, 15 Oct 2026 03:54:05 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGHq-0004Q8-0W; Thu, 15 Oct 2026 03:54:04 -0400
Received: from [172.17.0.2] (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACHizmMhtBq093SCg--.11963S3;
 Thu, 15 Oct 2026 15:53:48 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH] target/riscv: gate envcfg CBO fields on extensions
Date: Thu, 15 Oct 2026 07:53:47 +0000
Message-Id: <179205082798.38010.17010797392458454916@otcaix.iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CM-TRANSID: rQCowACHizmMhtBq093SCg--.11963S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4UCw4xXr1rCw4rtr4fZrb_yoW5WFWUpF
 s8WFsxGrWkt34S9a93Gr1UWFs8JrZ5Ka929wnruasavFW2vrn3GFyDt343Ar18WFyxAr47
 K3ya9r1jyF4UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
 j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF
 1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY
 1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4I
 kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
 WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
 0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
 JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
 UvcSsGvfC2KfnxnUUI43ZEXa7IU5WCJJUUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The envcfg CBO fields are provided by Zicbom and Zicboz. Keep them
read-only zero when the corresponding extension is absent in all three
envcfg CSRs.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4225
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
 target/riscv/tcg/csr.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9d..96c513b 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3224,10 +3224,19 @@ static RISCVException write_menvcfg(CPURISCVState *en=
v, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
     const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
-    uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
-                    MENVCFG_CBZE;
+    uint64_t mask =3D MENVCFG_FIOM;
     bool stce_changed =3D false;
=20
+    /* CBIE/CBCFE are read-only zero when Zicbom is not implemented. */
+    if (cfg->ext_zicbom) {
+        mask |=3D MENVCFG_CBIE | MENVCFG_CBCFE;
+    }
+
+    /* CBZE is read-only zero when Zicboz is not implemented. */
+    if (cfg->ext_zicboz) {
+        mask |=3D MENVCFG_CBZE;
+    }
+
     /*
      * menvcfg.LPE (Zicfilp) and menvcfg.SSE (Zicfiss) reside in the low
      * 32 bits and are defined for both RV32 and RV64, so they must be
@@ -3328,8 +3337,18 @@ static RISCVException read_senvcfg(CPURISCVState *env,=
 int csrno,
 static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
-    uint64_t mask =3D SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_=
CBZE;
+    uint64_t mask =3D SENVCFG_FIOM;
     RISCVException ret;
+
+    /* CBIE/CBCFE are read-only zero when Zicbom is not implemented. */
+    if (env_archcpu(env)->cfg.ext_zicbom) {
+        mask |=3D SENVCFG_CBIE | SENVCFG_CBCFE;
+    }
+
+    /* CBZE is read-only zero when Zicboz is not implemented. */
+    if (env_archcpu(env)->cfg.ext_zicboz) {
+        mask |=3D SENVCFG_CBZE;
+    }
     /* Update PMM field only if the value is valid according to Zjpm v1.0 */
     if (env_archcpu(env)->cfg.ext_ssnpm &&
         riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
@@ -3386,10 +3405,20 @@ static RISCVException write_henvcfg(CPURISCVState *en=
v, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
     const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
-    uint64_t mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_=
CBZE;
+    uint64_t mask =3D HENVCFG_FIOM;
     RISCVException ret;
     bool stce_changed =3D false;
=20
+    /* CBIE/CBCFE are read-only zero when Zicbom is not implemented. */
+    if (cfg->ext_zicbom) {
+        mask |=3D HENVCFG_CBIE | HENVCFG_CBCFE;
+    }
+
+    /* CBZE is read-only zero when Zicboz is not implemented. */
+    if (cfg->ext_zicboz) {
+        mask |=3D HENVCFG_CBZE;
+    }
+
     ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
     if (ret !=3D RISCV_EXCP_NONE) {
         return ret;
--=20
2.43.0


