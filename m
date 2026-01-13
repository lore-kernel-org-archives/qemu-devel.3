Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41965D29DFE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfbFi-0000va-Hi; Tue, 13 Jan 2026 05:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vfbFJ-0000ow-P2
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:03:32 -0500
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vfbFG-0006qZ-2n
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1768298601; x=1768903401; i=laurent@vivier.eu;
 bh=cEbdU75b2qPxsZwlpwA870EouvhvM5JPR+gtoOutog8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vLBXJGDF5W1C4ZZStBagNca+aiCTXLjA7asT5eMW1hVZwhFBabks1oK0fsu41oDX
 3Nuo2GJqQ2PedAI8O2+k+son3T8WdmrY0A21pJ7O5RsAgD+6d+vCX50BcHAP1PfGb
 G1e/GncFTJ7ywidgp8jgrI+Y3p/P63cWZg77zH5c4eyopPtV/JD/eTLL48DUujjNS
 YwrPaO2/PNk4LniflcqP2bnLfAiaontM5GkAgSElPSmjcDEFzKmjdDzhBTmIH1zE1
 TS3qzeeu7y38jTKH+heaqBUyNbCkd55qhk4Ak1xSm7qsG2ztFPBqmeHm9iYt3cuCy
 mFmQ3aSZv4RNGc4a5Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M8hph-1vkG5224Kv-003PZC; Tue, 13
 Jan 2026 11:03:21 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	William Hooper <wsh@wshooper.org>
Subject: [PULL 3/3] target/m68k: Improve CHK and CHK2; implement CMP2
Date: Tue, 13 Jan 2026 11:03:20 +0100
Message-ID: <20260113100320.1009608-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113100320.1009608-1-laurent@vivier.eu>
References: <20260113100320.1009608-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dyx9J/HBHkeQtlfFrLGSdsYmTMClxwhZj/vJePC5B+pyi16mWW2
 5hK3HHZ2uTOYBVmShUcNX/GAE61iZZO3t3bHU8tejo/YLSApClbv3G/78OzOiOMF5NAx9pM
 gphyPrbBsXZG2zwMwClajk/oFKpqpawA30SEzLAhMMlTcBGil4vWtwZHthj0TTdhl9DCEOG
 8gZsOZDSE34cswdQJWwbA==
UI-OutboundReport: notjunk:1;M01:P0:nojMkRXFcwE=;7evH3NfM6A4TMnn4q0T/i6Ob+1J
 h9BLr8FqPgBEsGxZGxtawhQkn8Ow7pXxB3NT5THF7J5miJpwfURAJwslkWpTD1BzwlVMJZ1GB
 4NGsxV5rweQdpyVGyu17Gc56qcIuOfow8TjPi66HZOqxojts7vCAsBj/Q3QSL7zVLVHsTxVrQ
 o/oI0IxN90WAk73FfxHPMP4AUXShrXkMH1gG+UjncPjY/BtmRRKqM4h3jdvD6hojtwH3cQ7F3
 FfIe4DusbA1h0QiHEm8VvRYFZHPQfWse/hQKkSANGX3rqLHJpnIE5KwJ9t2wuyisPtAazEofx
 JHzXHAw/2kXyfyWii+RIHGOrkwE0SiEgE+3r/tT8EKxDpYAwojEQSF40Mf3PP0G6+0rNrOddq
 J+BRU4jDzkZWsCFd5Gu8KMBwbEwdU2dRcgccXyQjLjqseraMZvciiKNOMHeMQsaBaQiQqS/+8
 7NyIHsvgZ+oO1rGZr+uM63HyKTOv0ByGjkq68RUfMrsUw6mcm0yFXD2fNHdXG/PnM6Kl9jRuv
 LX1KZ/hJDNMnRKRXslIw83HPjjNuK4WNjzolksIlM+gzl8tCbAFd4KahgnAjuXVBBbfhCQ/Lt
 cSMRDh0BOdzsRusXP8MwemZQUEqqsbwKXY7LA0hCQGqAr1GYY/AB3LHUb/kFoUPiz+y8X84/p
 A3y6wiju0z/vWcMNWa8gC7qHGKtwx4vKoopkdS51Ysa/joXac2aW5YnD+Is744w+Fe1Q7FDnk
 UxbSqA0AVxYB9DLNI9cXP/6c45nu4ILW+2ucN4jFMzgSAHvqfetx9D3AEdoZ7GdpVEDxezyW6
 z+iqDnK3y/nva+QN4tFeykNdIKSMPJUj2lHAYOhYWEVfRwgBVCg4k1EC9I5+vHnB+xyVTE4Om
 e9h5AF0gpDx1LSF9+pocJyB0sYVLbdcWyDvpo735uKrKQKNBLkglPTPM+Y3sb6PYDiAMcryGM
 lJ67o4Npu5enjpARCd7vVsMHiPmtU1bncUA0QVDI3Vk2EhKGP83QXb654qTGOfLDq6X2V9gtf
 mTYu+/XInWXjYjr366vfE1fK59mlLGo1af2a8/PJh9nb7Wbgm6JJzayZM7+tJ5Jk2iqnM3fCW
 HA+eZLe7ieIBHVapv+Kwc8q4EjMjmzGfKA9F5B/E0lEdilam8PRnA15JOQeX8tfQe8r1/v7qT
 VZHHvdVJzdr6RrIYowVLUll84scvZkLvbWItvhXWF60VfeDjaZ+Exr5s+a+xrR6h/9OJtBU3t
 un5xgNgMnBTwehcyCMTWNGLxtOt8vXLKNG0M3hN1TAAJWzLZ1zW+NhrAPzxOHNy2fTv5wYdfC
 AkJyk5lLahj2xB6V3PM2RMaWQ98J6yUoXklhppao2Bn/rZqsc0NgxG0xQtpRWcko6/ywy2I0L
 6JtKL4vSeZPmWq+u5z4jJQHIcfXSaC265BxN3sAGpcXbJjcOlP1VZISGJ+TCOVzerT3u5chJ3
 zPTcZ0UGQE18MZFegq55ux2wd2kGu8sYP5QVclq9rDITcLMGgJJTHXT5+lJOD0+DJ4Cxvs2vR
 zxfWlTnw28kgj5C3EwcNgbQsMCQGFLac5scp4wFFNCt5sl+ldnmy4lNl0l3zGwVwEDGhX0aeN
 gYtGxFR6axfa5ms5LgNu6yw8QSYOstBxMn9Xg95q55L4NNcNHY9kpFvTbqSgE9AVEMaLyzMR6
 vuMPe5GAJowr/RtZ7T84xVMxopI3qtZxzSpS9Fg3a/G9xWe/kZB/SAl/Xaax+AeQQIuBznUt9
 tXrwJcw/CrAqVlsfZ98+M08MFs2dQtiuaFSvSqxKp3i1/AxwLiOrD1RA=
Received-SPF: pass client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: William Hooper <wsh@wshooper.org>

Some CHK2 (Check Register Against Bounds) instructions, such as opcode
02FA, cause spurious illegal instruction exceptions, despite being valid
on Motorola MC68020 and later processors and used in existing software.

With this patch, QEMU:

- Translates CHK2 and CMP2 (Compare Register Against Bounds)
  instructions [1] having any valid size or effective address. CHK2 and
  CMP2 use the same opcodes but differ in bit 11 of the extension word.
  (BITREV or BYTEREV instructions for ColdFire family processors [2],
  which use similar opcodes, are not captured, however.)

- Implements CMP2, which "is identical to CHK2 except that it sets
  condition codes rather than taking an exception" [1].

- Populates the correct "logical address of the instruction following
  the instruction that caused the trap" [3] in the exception stack frame
  for CHK and CHK2 exceptions, according to the number of words in the
  instruction, including extension words, rather than default lengths.

An existing test for CHK2 is enabled, and tests are added for CHK, CHK2,
and CMP2.

References:
[1] Motorola M68000 Family Programmer's Reference Manual (M68000PM/AD),
    Rev. 1, 1992, pages 4-72 to 4-73 and 4-82 to 4-83.
[2] Freescale Semiconductor, ColdFire Family Programmer's Reference Manual
    (CFPRM), Rev. 3, 2005, pages 4-19 and 4-26.
[3] Motorola M68040 User's Manual (M68040UM/AD), 1993, page 8-8.

Signed-off-by: William Hooper <wsh@wshooper.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20251222002634.61480-1-wsh@wshooper.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
=2D--
 target/m68k/helper.h    |   5 +-
 target/m68k/op_helper.c |  16 ++++--
 target/m68k/translate.c |  31 ++++++++----
 tests/tcg/m68k/trap.c   | 105 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 137 insertions(+), 20 deletions(-)

diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 95aa5e53bb97..0bda8f8152de 100644
=2D-- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -123,8 +123,9 @@ DEF_HELPER_FLAGS_4(bfclr_mem, TCG_CALL_NO_WG, i32, env=
, i32, s32, i32)
 DEF_HELPER_FLAGS_4(bfset_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
 DEF_HELPER_FLAGS_4(bfffo_mem, TCG_CALL_NO_WG, i64, env, i32, s32, i32)
=20
-DEF_HELPER_3(chk, void, env, s32, s32)
-DEF_HELPER_4(chk2, void, env, s32, s32, s32)
+DEF_HELPER_4(chk, void, env, s32, s32, int)
+DEF_HELPER_5(chk2, void, env, s32, s32, s32, int)
+DEF_HELPER_4(cmp2, void, env, s32, s32, s32)
=20
 #if !defined(CONFIG_USER_ONLY)
 DEF_HELPER_3(ptest, void, env, i32, i32)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 10266b1e0e8b..a27e2bcfbc46 100644
=2D-- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -1090,7 +1090,7 @@ uint64_t HELPER(bfffo_mem)(CPUM68KState *env, uint32=
_t addr,
     return n | ffo;
 }
=20
-void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub)
+void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub, int ilen)
 {
     /*
      * From the specs:
@@ -1106,11 +1106,12 @@ void HELPER(chk)(CPUM68KState *env, int32_t val, i=
nt32_t ub)
     env->cc_c =3D 0 <=3D ub ? val < 0 || val > ub : val > ub && val < 0;
=20
     if (val < 0 || val > ub) {
-        raise_exception_format2(env, EXCP_CHK, 2, GETPC());
+        raise_exception_format2(env, EXCP_CHK, ilen, GETPC());
     }
 }
=20
-void HELPER(chk2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub)
+void HELPER(chk2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub,
+                  int ilen)
 {
     /*
      * From the specs:
@@ -1127,6 +1128,13 @@ void HELPER(chk2)(CPUM68KState *env, int32_t val, i=
nt32_t lb, int32_t ub)
     env->cc_c =3D lb <=3D ub ? val < lb || val > ub : val > ub && val < l=
b;
=20
     if (env->cc_c) {
-        raise_exception_format2(env, EXCP_CHK, 4, GETPC());
+        raise_exception_format2(env, EXCP_CHK, ilen, GETPC());
     }
 }
+
+void HELPER(cmp2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub)
+{
+    /* Identical to CHK2 (above) but doesn't raise an exception */
+    env->cc_z =3D val !=3D lb && val !=3D ub;
+    env->cc_c =3D lb <=3D ub ? val < lb || val > ub : val > ub && val < l=
b;
+}
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 78efa3e597c4..721668634d97 100644
=2D-- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4237,7 +4237,7 @@ DISAS_INSN(ff1)
=20
 DISAS_INSN(chk)
 {
-    TCGv src, reg;
+    TCGv src, reg, ilen;
     int opsize;
=20
     switch ((insn >> 7) & 3) {
@@ -4258,13 +4258,14 @@ DISAS_INSN(chk)
     reg =3D gen_extend(s, DREG(insn, 9), opsize, 1);
=20
     gen_flush_flags(s);
-    gen_helper_chk(tcg_env, reg, src);
+    ilen =3D tcg_constant_i32(s->pc - s->base.pc_next);
+    gen_helper_chk(tcg_env, reg, src, ilen);
 }
=20
 DISAS_INSN(chk2)
 {
     uint16_t ext;
-    TCGv addr1, addr2, bound1, bound2, reg;
+    TCGv addr1, addr2, bound1, bound2, reg, ilen;
     int opsize;
=20
     switch ((insn >> 9) & 3) {
@@ -4283,10 +4284,6 @@ DISAS_INSN(chk2)
     }
=20
     ext =3D read_im16(env, s);
-    if ((ext & 0x0800) =3D=3D 0) {
-        gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
-        return;
-    }
=20
     addr1 =3D gen_lea(env, s, insn, OS_UNSIZED);
     addr2 =3D tcg_temp_new();
@@ -4303,7 +4300,12 @@ DISAS_INSN(chk2)
     }
=20
     gen_flush_flags(s);
-    gen_helper_chk2(tcg_env, reg, bound1, bound2);
+    if ((ext & 0x0800) =3D=3D 0) {
+        gen_helper_cmp2(tcg_env, reg, bound1, bound2);
+    } else {
+        ilen =3D tcg_constant_i32(s->pc - s->base.pc_next);
+        gen_helper_chk2(tcg_env, reg, bound1, bound2, ilen);
+    }
 }
=20
 static void m68k_copy_line(TCGv dst, TCGv src, int index)
@@ -5770,8 +5772,11 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(undef,     0000, 0000);
     INSN(arith_im,  0080, fff8, CF_ISA_A);
     INSN(arith_im,  0000, ff00, M68K);
-    INSN(chk2,      00c0, f9c0, CHK2);
     INSN(bitrev,    00c0, fff8, CF_ISA_APLUSC);
+    INSN(chk2,      00d0, fff8, CHK2);
+    INSN(chk2,      00e8, fff8, CHK2);
+    INSN(chk2,      00f0, fff8, CHK2);
+    INSN(chk2,      00f8, fffc, CHK2);
     BASE(bitop_reg, 0100, f1c0);
     BASE(bitop_reg, 0140, f1c0);
     BASE(bitop_reg, 0180, f1c0);
@@ -5781,12 +5786,20 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(arith_im,  0200, ff00, M68K);
     INSN(undef,     02c0, ffc0, M68K);
     INSN(byterev,   02c0, fff8, CF_ISA_APLUSC);
+    INSN(chk2,      02d0, fff8, CHK2);
+    INSN(chk2,      02e8, fff8, CHK2);
+    INSN(chk2,      02f0, fff8, CHK2);
+    INSN(chk2,      02f8, fffc, CHK2);
     INSN(arith_im,  0480, fff8, CF_ISA_A);
     INSN(arith_im,  0400, ff00, M68K);
     INSN(undef,     04c0, ffc0, M68K);
     INSN(arith_im,  0600, ff00, M68K);
     INSN(undef,     06c0, ffc0, M68K);
     INSN(ff1,       04c0, fff8, CF_ISA_APLUSC);
+    INSN(chk2,      04d0, fff8, CHK2);
+    INSN(chk2,      04e8, fff8, CHK2);
+    INSN(chk2,      04f0, fff8, CHK2);
+    INSN(chk2,      04f8, fffc, CHK2);
     INSN(arith_im,  0680, fff8, CF_ISA_A);
     INSN(arith_im,  0c00, ff38, CF_ISA_A);
     INSN(arith_im,  0c00, ff00, M68K);
diff --git a/tests/tcg/m68k/trap.c b/tests/tcg/m68k/trap.c
index 96cac18d4d5a..a1378021b1eb 100644
=2D-- a/tests/tcg/m68k/trap.c
+++ b/tests/tcg/m68k/trap.c
@@ -33,6 +33,7 @@ static void sig_handler(int sig, siginfo_t *si, void *pu=
c)
     "move.l #0f, (%[ad])\n\tmove.l #1f, (%[pc])\n" S "\n1:\n"
=20
 #define CHECK_SIG   do { assert(got_signal); got_signal =3D 0; } while (0=
)
+#define OUT_CZ      "\n\tscs %0\n\tseq %1" : [c] "=3Dr"(c), [z] "=3Dr"(z)=
 :
=20
 int main(int argc, char **argv)
 {
@@ -41,6 +42,73 @@ int main(int argc, char **argv)
         .sa_flags =3D SA_SIGINFO
     };
     int t0, t1;
+    char bbounds[2] =3D { 0, 2 };
+    short wbounds[2] =3D { 0, 2 };
+    int lbounds[2] =3D { 0, 2 };
+    static int sbounds[2] =3D { 0, 2 };
+    void *intermediate;
+    char c, z;
+
+    /*
+     * Tests for CMP2, which sets the condition code register just as
+     * CHK2 does but doesn't raise out-of-bounds exceptions:
+     */
+    asm volatile("cmp2.b %2, %3" OUT_CZ "m"(bbounds), "d"(-1));
+    assert(c && !z);
+    asm volatile("cmp2.b %2, %3" OUT_CZ "m"(bbounds), "d"(0));
+    assert(!c && z);
+    asm volatile("cmp2.b %2, %3" OUT_CZ "m"(bbounds), "d"(1));
+    assert(!c && !z);
+    asm volatile("cmp2.b %2, %3" OUT_CZ "m"(bbounds), "d"(2));
+    assert(!c && z);
+    asm volatile("cmp2.b %2, %3" OUT_CZ "m"(bbounds), "d"(3));
+    assert(c && !z);
+    asm volatile("cmp2.w %2, %3" OUT_CZ "m"(wbounds), "d"(-1));
+    assert(c && !z);
+    asm volatile("cmp2.w %2, %3" OUT_CZ "m"(wbounds), "d"(0));
+    assert(!c && z);
+    asm volatile("cmp2.w %2, %3" OUT_CZ "m"(wbounds), "d"(1));
+    assert(!c && !z);
+    asm volatile("cmp2.w %2, %3" OUT_CZ "m"(wbounds), "d"(2));
+    assert(!c && z);
+    asm volatile("cmp2.w %2, %3" OUT_CZ "m"(wbounds), "d"(3));
+    assert(c && !z);
+    asm volatile("cmp2.l %2, %3" OUT_CZ "m"(lbounds), "d"(-1));
+    assert(c && !z);
+    asm volatile("cmp2.l %2, %3" OUT_CZ "m"(lbounds), "d"(0));
+    assert(!c && z);
+    asm volatile("cmp2.l %2, %3" OUT_CZ "m"(lbounds), "d"(1));
+    assert(!c && !z);
+    asm volatile("cmp2.l %2, %3" OUT_CZ "m"(lbounds), "d"(2));
+    assert(!c && z);
+    asm volatile("cmp2.l %2, %3" OUT_CZ "m"(lbounds), "d"(3));
+    assert(c && !z);
+
+    /*
+     * CHK2 shouldn't raise out-of-bounds exceptions, either, when the
+     * register value is within bounds:
+     */
+    asm volatile("chk2.b %2, %3" OUT_CZ "m"(bbounds), "d"(0));
+    assert(!c && z);
+    asm volatile("chk2.w %2, %3" OUT_CZ "m"(wbounds), "d"(0));
+    assert(!c && z);
+    asm volatile("chk2.l %2, %3" OUT_CZ "m"(lbounds), "d"(0));
+    assert(!c && z);
+
+    /* Address register indirect addressing (without displacement) */
+    asm volatile("chk2.l %2, %3" OUT_CZ "Q"(lbounds), "d"(2));
+    assert(!c && z);
+
+    /* Absolute long addressing */
+    asm volatile("chk2.l %2, %3" OUT_CZ "m"(sbounds), "d"(2));
+    assert(!c && z);
+
+    /* Memory indirect preindexed addressing */
+    intermediate =3D (void *)lbounds - 0x0D0D0D0D;
+    asm volatile("chk2.l %2@(0xBDBDBDBD,%3:l:4)@(0x0D0D0D0D), %4" OUT_CZ
+                 "a"((void *)&intermediate - 0xBDBDBDBD - 0xEEEE * 4),
+                 "r"(0xEEEE), "d"(2));
+    assert(!c && z);
=20
     sigaction(SIGILL, &act, NULL);
     sigaction(SIGTRAP, &act, NULL);
@@ -51,13 +119,40 @@ int main(int argc, char **argv)
     asm volatile(FMT2_STR("0:\tchk %0, %1") : : "d"(0), "d"(-1), FMT_INS)=
;
     CHECK_SIG;
=20
-#if 0
-    /* FIXME: chk2 not correctly translated. */
-    int bounds[2] =3D { 0, 1 };
+    /*
+     * The extension word here should be counted when computing the
+     * address of the next instruction in the exception stack frame
+     */
+    asm volatile(FMT2_STR("0:\tchk %0, %1")
+                 : : "m"(lbounds), "d"(-1), FMT_INS);
+    CHECK_SIG;
+
+    asm volatile(FMT2_STR("0:\tchk2.b %0, %1")
+                 : : "m"(bbounds), "d"(3), FMT_INS);
+    CHECK_SIG;
+
+    asm volatile(FMT2_STR("0:\tchk2.w %0, %1")
+                 : : "m"(wbounds), "d"(3), FMT_INS);
+    CHECK_SIG;
+
     asm volatile(FMT2_STR("0:\tchk2.l %0, %1")
-                 : : "m"(bounds), "d"(2), FMT_INS);
+                 : : "m"(lbounds), "d"(3), FMT_INS);
+    CHECK_SIG;
+
+    /* Absolute long addressing */
+    asm volatile(FMT2_STR("0:\tchk2.l %0, %1")
+                 : : "m"(sbounds), "d"(3), FMT_INS);
+    CHECK_SIG;
+
+    /*
+     * Memory indirect preindexed addressing; also, the six extension
+     * words here should be counted when computing the address of the
+     * next instruction in the exception stack frame
+     */
+    asm volatile(FMT2_STR("0:\tchk2.l %0@(0xBDBDBDBD,%1:l:4)@(0x0D0D0D0D)=
, %2")
+                 : : "a"((void *)&intermediate - 0xBDBDBDBD - 0xEEEE * 4)=
,
+                 "r"(0xEEEE), "d"(3), FMT_INS);
     CHECK_SIG;
-#endif
=20
     asm volatile(FMT2_STR("cmp.l %0, %1\n0:\ttrapv")
                  : : "d"(INT_MIN), "d"(1), FMT_INS);
=2D-=20
2.52.0


