Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE65CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGTr-0004td-2n; Thu, 15 Oct 2026 04:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGTR-0004mF-Vs; Thu, 15 Oct 2026 04:06:08 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xHGTN-0005Xg-IJ; Thu, 15 Oct 2026 04:05:59 -0400
Received: from [172.17.0.2] (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowAAXFzVgidBqVxvTCg--.56203S3;
 Thu, 15 Oct 2026 16:05:52 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH] target/riscv: gate envcfg CBO fields on extensions
Date: Thu, 15 Oct 2026 08:05:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CM-TRANSID: rQCowAAXFzVgidBqVxvTCg--.56203S3
Message-Id: <6AD08960.0F1C24.05843@cstnet.cn>
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4UCw4xXr1rCw4rtr4fZrb_yoW5WFWrpF
 s8WFsxGrWkt34fua93Gr1UXFs8JrZ5K3929w17CasavFW2vrn3GFyDtw13Ar1UWFyxAr47
 K3ya9r1jyF4UAFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
 j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw
 1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l
 w4CEF2IF47xS0VAv8wCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFyl42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUYewZDUUUUU==
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
---
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


