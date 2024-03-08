Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F59C3DA49
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 00:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sT9w6-0007hW-9n; Sun, 14 Jul 2024 20:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1sT9sH-0006NL-Jq; Sun, 14 Jul 2024 20:47:29 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1sT9sF-00030W-5L; Sun, 14 Jul 2024 20:47:29 -0400
DKIM-Signature: a=rsa-sha256; bh=PlqWwhpsM/uu8ZDtP+MX+m4lIivWqynLFqCN9O/s/s4=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1721004442; v=1;
 b=npL0DSHNCInbzO+V6O3w+FG9LYuwwYaYfmx+mHyUPfWCw3mz05qWciEr2N7ZO7dPlrlp0V7m
 Kd9qxLySFQTLEPqUQTuaMSqIzVVwwWy4u1DqXrZGbei5IGobyInUufMUW4I57uFNpoo2NrQkSJ4
 CkY0Iq1v+WC5PfVOD3sV/ezwTOHFly0cBHXaYvKXW5Qi7WyS+kl9v5pRAJjL+kQXf1kVaRyFvic
 uIUilGbLh87N0WkYxaD87BsicMFHVMr/KkzHMoSBixKZyREwQdDc2gE2h6ncAA5PNJ/u91rnK0H
 u2YhL9VALyFuLNz3DvdtegqHgiTFqfw/ZNuB3rGjt19Dw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id CAAE7201F5;
 Mon, 15 Jul 2024 00:47:22 +0000 (UTC)
From: ~yuming <yuming@git.sr.ht>
Date: Fri, 08 Mar 2024 15:48:03 +0800
Subject: [PATCH qemu v4] target/riscv: raise an exception when CSRRS/CSRRC
 writes a read-only CSR
MIME-Version: 1.0
Message-ID: <172100444279.18077.6893072378718059541-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, yumin686@andestech.com, alvinga@andestech.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 14 Jul 2024 20:51:18 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: ~yuming <yumin686@andestech.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yu-Ming Chang <yumin686@andestech.com>

Both CSRRS and CSRRC always read the addressed CSR and cause any read side
effects regardless of rs1 and rd fields. Note that if rs1 specifies a register
holding a zero value other than x0, the instruction will still attempt to wri=
te
the unmodified value back to the CSR and will cause any attendant side effect=
s.

So if CSRRS or CSRRC tries to write a read-only CSR with rs1 which specifies
a register holding a zero value, an illegal instruction exception should be
raised.

Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
Signed-off-by: Alvin Chang <alvinga@andestech.com>
---
Hi Alistair,
    This fixed the issue of riscv_csrrw_debug().
    And tried solve the issue of `From` email address.
Best regards,
Yuming

 target/riscv/cpu.h       |  4 +++
 target/riscv/csr.c       | 57 ++++++++++++++++++++++++++++++++++++----
 target/riscv/op_helper.c |  6 ++---
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 87742047ce..6db92e0c58 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -735,6 +735,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 void riscv_cpu_update_mask(CPURISCVState *env);
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
=20
+RISCVException riscv_csrr(CPURISCVState *env, int csrno,
+                          target_ulong *ret_value);
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
@@ -767,6 +769,8 @@ typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *=
env, int csrno,
                                           target_ulong new_value,
                                           target_ulong write_mask);
=20
+RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
+                               Int128 *ret_value);
 RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
                                 Int128 *ret_value,
                                 Int128 new_value, Int128 write_mask);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 432c59dc66..e6939f62bb 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -4368,7 +4368,7 @@ static RISCVException rmw_seed(CPURISCVState *env, int =
csrno,
=20
 static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
                                                int csrno,
-                                               bool write_mask)
+                                               bool write)
 {
     /* check privileges and return RISCV_EXCP_ILLEGAL_INST if check fails */
     bool read_only =3D get_field(csrno, 0xC00) =3D=3D 3;
@@ -4390,7 +4390,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCV=
State *env,
     }
=20
     /* read / write check */
-    if (write_mask && read_only) {
+    if (write && read_only) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
=20
@@ -4477,11 +4477,22 @@ static RISCVException riscv_csrrw_do64(CPURISCVState =
*env, int csrno,
     return RISCV_EXCP_NONE;
 }
=20
+RISCVException riscv_csrr(CPURISCVState *env, int csrno,
+                           target_ulong *ret_value)
+{
+    RISCVException ret =3D riscv_csrrw_check(env, csrno, false);
+    if (ret !=3D RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0);
+}
+
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask)
 {
-    RISCVException ret =3D riscv_csrrw_check(env, csrno, write_mask);
+    RISCVException ret =3D riscv_csrrw_check(env, csrno, true);
     if (ret !=3D RISCV_EXCP_NONE) {
         return ret;
     }
@@ -4529,13 +4540,45 @@ static RISCVException riscv_csrrw_do128(CPURISCVState=
 *env, int csrno,
     return RISCV_EXCP_NONE;
 }
=20
+RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
+                               Int128 *ret_value)
+{
+    RISCVException ret;
+
+    ret =3D riscv_csrrw_check(env, csrno, false);
+    if (ret !=3D RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    if (csr_ops[csrno].read128) {
+        return riscv_csrrw_do128(env, csrno, ret_value,
+                                 int128_zero(), int128_zero());
+    }
+
+    /*
+     * Fall back to 64-bit version for now, if the 128-bit alternative isn't
+     * at all defined.
+     * Note, some CSRs don't need to extend to MXLEN (64 upper bits non
+     * significant), for those, this fallback is correctly handling the
+     * accesses
+     */
+    target_ulong old_value;
+    ret =3D riscv_csrrw_do64(env, csrno, &old_value,
+                           (target_ulong)0,
+                           (target_ulong)0);
+    if (ret =3D=3D RISCV_EXCP_NONE && ret_value) {
+        *ret_value =3D int128_make64(old_value);
+    }
+    return ret;
+}
+
 RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
                                 Int128 *ret_value,
                                 Int128 new_value, Int128 write_mask)
 {
     RISCVException ret;
=20
-    ret =3D riscv_csrrw_check(env, csrno, int128_nz(write_mask));
+    ret =3D riscv_csrrw_check(env, csrno, true);
     if (ret !=3D RISCV_EXCP_NONE) {
         return ret;
     }
@@ -4574,7 +4617,11 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, i=
nt csrno,
 #if !defined(CONFIG_USER_ONLY)
     env->debugger =3D true;
 #endif
-    ret =3D riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
+    if (!write_mask) {
+        ret =3D riscv_csrr(env, csrno, ret_value);
+    } else {
+        ret =3D riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
+    }
 #if !defined(CONFIG_USER_ONLY)
     env->debugger =3D false;
 #endif
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 2baf5bc3ca..84fb2a35e5 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -51,7 +51,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
     }
=20
     target_ulong val =3D 0;
-    RISCVException ret =3D riscv_csrrw(env, csr, &val, 0, 0);
+    RISCVException ret =3D riscv_csrr(env, csr, &val);
=20
     if (ret !=3D RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
@@ -84,9 +84,7 @@ target_ulong helper_csrrw(CPURISCVState *env, int csr,
 target_ulong helper_csrr_i128(CPURISCVState *env, int csr)
 {
     Int128 rv =3D int128_zero();
-    RISCVException ret =3D riscv_csrrw_i128(env, csr, &rv,
-                                          int128_zero(),
-                                          int128_zero());
+    RISCVException ret =3D riscv_csrr_i128(env, csr, &rv);
=20
     if (ret !=3D RISCV_EXCP_NONE) {
         riscv_raise_exception(env, ret, GETPC());
--=20
2.43.4

