Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B433D68BD5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 00:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXTl6-0002fN-6v; Sun, 21 Dec 2025 19:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1vXTl4-0002f0-GZ
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 19:26:42 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1vXTl2-0006DY-2W
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 19:26:42 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a1388cdac3so32528855ad.0
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 16:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wshooper-org.20230601.gappssmtp.com; s=20230601; t=1766363197; x=1766967997;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wPFozKCncDNUt5yqQ9xVflSZmQj97msFWltVE6dMWps=;
 b=sT0M37VX3e0Zu+TtRGtRQZDDdeSij5bpL+X1S2hRzs3653kRQwzfUv+/Vi/A36WIEF
 4QylUidLhF3VP0zZ6gkb3DkP3dLjgIQhdMwKbF4jNqjUVXwwJ/A92pwEKJS48n3SDiRS
 5lb9/1KY3gLRs1ZQlVzrb1kgxC52qnRMtXAoHYZqQ3vRQRCU3fCOVWcYXz6GkaXKq8Hc
 RrnldI4ADO23fGKbK2SPE3d98ExE0C6JNXovae3tVsWlyD6qP6Hq6aZunvvLVTIqejRM
 /gwppjxKY9ZC80LdMv9cXd4Qd4ZwCS9GK6m4gdPhlzPsCEC61JW5hmpfYgIg+OselkxI
 Bb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766363197; x=1766967997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPFozKCncDNUt5yqQ9xVflSZmQj97msFWltVE6dMWps=;
 b=e59fEBaVh3yMB2Az/FnAQh0RTqcrtHLEGnDQc/7zlEf7aJINsm0sB1M3/DKzaSRuGq
 vWtJnfETygbVkn+dFXJ0PvCJnq1S7pVGoHMvKaxPiLm778CvCPfH1tCCFx3ZDq3BB3m2
 wxspJTHJOhVM885zG6eTHzuGsCK5vA6kFlt40Zxrw37XazaIhDiUBy2pRYoreerd1jo8
 utFLBYgeDNa5UKrgDnA017uJpEB3Q6nU5hZdNNP1uV3id+CiBOHIXPVUDxX8qpIsSxZs
 wa1u7RpOUJVFjwYJrTjB9QOfkGIpG7QP5hgXv5e3DBaWFuMGz0RgzJTdPknF9eHB+kPm
 FJYA==
X-Gm-Message-State: AOJu0YzfHqvgqJnSCyooWxE9AaRzg/YxKOrHtI/n4Ocbz3PbdEPGaAwj
 ZtQTz+M8Ocp7Ow4RGZn9/eMa2FjE/9EUngPx+WQ6XbvrOyoeP7VaOnmP+lgS36g2cQUa1oHsvkM
 jyuMEffs=
X-Gm-Gg: AY/fxX4GIXcLEecV3MuJyMbf6ADgKVWKZbfVM3TxMvPPkFXBHMoI5URLgGVwSKyRA+x
 +1jmukMe8L23X7hi6x3wfYNSpJ7gqolro7Fqqaltjoc0qegb525jZQFZvfcUsFIgRYARCYomOko
 rkrEkpkQJZVpbJHR3tvmmA4BmUYwCgVXtulTv8ioF6edd2lEkTgCFrqpDJesibwvPDKsi6qCnUx
 MG9M4fAQgc0lupkNlaZHZB8516vfQkz7o3DcVqkw3UBZEUzmI7ZhwPRIBdEA2ks25f6enZH65OS
 AjcyZlzfllE5sHgvZCRCl8iSHyc7xP2X/pb6iYlSmTJXm5tLuJrjPi0ps6sEAcRoRBT3N1lbVvj
 dBNGduGQ8kg/HOWxbsgf9yQElD8hd7cINXBun4NcXYNQXz3LB7fJuIrQSuM6dni4ZSMFmkhRd2+
 ksbaNMbYftvYwR8KYxZyl//inTCkYDQLCQUIF6lKGS3J/iBvbGTxnIdJBu12iPrFVF9M9H4p+pr
 mcjMQ==
X-Google-Smtp-Source: AGHT+IFnGvj7YaB1EEYvVPWt5IBazRvgHa8yTjMP5llY/5IEQmzLrOzOHB1bznttyVLsV8SzBn+iNA==
X-Received: by 2002:a05:7022:688c:b0:11e:395:7dfc with SMTP id
 a92af1059eb24-121722e7dffmr8634606c88.28.1766363196947; 
 Sun, 21 Dec 2025 16:26:36 -0800 (PST)
Received: from localhost.localdomain (syn-076-081-243-074.biz.spectrum.com.
 [76.81.243.74]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217254cd77sm38332110c88.14.2025.12.21.16.26.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 21 Dec 2025 16:26:36 -0800 (PST)
From: William Hooper <wsh@wshooper.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v1] target/m68k: Improve CHK and CHK2; implement CMP2
Date: Sun, 21 Dec 2025 16:26:34 -0800
Message-ID: <20251222002634.61480-1-wsh@wshooper.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=wsh@wshooper.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
---
 target/m68k/helper.h    |   5 +-
 target/m68k/op_helper.c |  16 ++++--
 target/m68k/translate.c |  31 ++++++++----
 tests/tcg/m68k/trap.c   | 105 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 137 insertions(+), 20 deletions(-)

diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 95aa5e53bb..0bda8f8152 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -123,8 +123,9 @@ DEF_HELPER_FLAGS_4(bfclr_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
 DEF_HELPER_FLAGS_4(bfset_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
 DEF_HELPER_FLAGS_4(bfffo_mem, TCG_CALL_NO_WG, i64, env, i32, s32, i32)
 
-DEF_HELPER_3(chk, void, env, s32, s32)
-DEF_HELPER_4(chk2, void, env, s32, s32, s32)
+DEF_HELPER_4(chk, void, env, s32, s32, int)
+DEF_HELPER_5(chk2, void, env, s32, s32, s32, int)
+DEF_HELPER_4(cmp2, void, env, s32, s32, s32)
 
 #if !defined(CONFIG_USER_ONLY)
 DEF_HELPER_3(ptest, void, env, i32, i32)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index e9c20a8e03..1fa1b0b33b 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -1090,7 +1090,7 @@ uint64_t HELPER(bfffo_mem)(CPUM68KState *env, uint32_t addr,
     return n | ffo;
 }
 
-void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub)
+void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub, int ilen)
 {
     /*
      * From the specs:
@@ -1106,11 +1106,12 @@ void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub)
     env->cc_c = 0 <= ub ? val < 0 || val > ub : val > ub && val < 0;
 
     if (val < 0 || val > ub) {
-        raise_exception_format2(env, EXCP_CHK, 2, GETPC());
+        raise_exception_format2(env, EXCP_CHK, ilen, GETPC());
     }
 }
 
-void HELPER(chk2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub)
+void HELPER(chk2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub,
+                  int ilen)
 {
     /*
      * From the specs:
@@ -1127,6 +1128,13 @@ void HELPER(chk2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub)
     env->cc_c = lb <= ub ? val < lb || val > ub : val > ub && val < lb;
 
     if (env->cc_c) {
-        raise_exception_format2(env, EXCP_CHK, 4, GETPC());
+        raise_exception_format2(env, EXCP_CHK, ilen, GETPC());
     }
 }
+
+void HELPER(cmp2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub)
+{
+    /* Identical to CHK2 (above) but doesn't raise an exception */
+    env->cc_z = val != lb && val != ub;
+    env->cc_c = lb <= ub ? val < lb || val > ub : val > ub && val < lb;
+}
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index eb1ba15074..cc289b5105 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4237,7 +4237,7 @@ DISAS_INSN(ff1)
 
 DISAS_INSN(chk)
 {
-    TCGv src, reg;
+    TCGv src, reg, ilen;
     int opsize;
 
     switch ((insn >> 7) & 3) {
@@ -4258,13 +4258,14 @@ DISAS_INSN(chk)
     reg = gen_extend(s, DREG(insn, 9), opsize, 1);
 
     gen_flush_flags(s);
-    gen_helper_chk(tcg_env, reg, src);
+    ilen = tcg_constant_i32(s->pc - s->base.pc_next);
+    gen_helper_chk(tcg_env, reg, src, ilen);
 }
 
 DISAS_INSN(chk2)
 {
     uint16_t ext;
-    TCGv addr1, addr2, bound1, bound2, reg;
+    TCGv addr1, addr2, bound1, bound2, reg, ilen;
     int opsize;
 
     switch ((insn >> 9) & 3) {
@@ -4283,10 +4284,6 @@ DISAS_INSN(chk2)
     }
 
     ext = read_im16(env, s);
-    if ((ext & 0x0800) == 0) {
-        gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
-        return;
-    }
 
     addr1 = gen_lea(env, s, insn, OS_UNSIZED);
     addr2 = tcg_temp_new();
@@ -4303,7 +4300,12 @@ DISAS_INSN(chk2)
     }
 
     gen_flush_flags(s);
-    gen_helper_chk2(tcg_env, reg, bound1, bound2);
+    if ((ext & 0x0800) == 0) {
+        gen_helper_cmp2(tcg_env, reg, bound1, bound2);
+    } else {
+        ilen = tcg_constant_i32(s->pc - s->base.pc_next);
+        gen_helper_chk2(tcg_env, reg, bound1, bound2, ilen);
+    }
 }
 
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
index 96cac18d4d..a1378021b1 100644
--- a/tests/tcg/m68k/trap.c
+++ b/tests/tcg/m68k/trap.c
@@ -33,6 +33,7 @@ static void sig_handler(int sig, siginfo_t *si, void *puc)
     "move.l #0f, (%[ad])\n\tmove.l #1f, (%[pc])\n" S "\n1:\n"
 
 #define CHECK_SIG   do { assert(got_signal); got_signal = 0; } while (0)
+#define OUT_CZ      "\n\tscs %0\n\tseq %1" : [c] "=r"(c), [z] "=r"(z) :
 
 int main(int argc, char **argv)
 {
@@ -41,6 +42,73 @@ int main(int argc, char **argv)
         .sa_flags = SA_SIGINFO
     };
     int t0, t1;
+    char bbounds[2] = { 0, 2 };
+    short wbounds[2] = { 0, 2 };
+    int lbounds[2] = { 0, 2 };
+    static int sbounds[2] = { 0, 2 };
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
+    intermediate = (void *)lbounds - 0x0D0D0D0D;
+    asm volatile("chk2.l %2@(0xBDBDBDBD,%3:l:4)@(0x0D0D0D0D), %4" OUT_CZ
+                 "a"((void *)&intermediate - 0xBDBDBDBD - 0xEEEE * 4),
+                 "r"(0xEEEE), "d"(2));
+    assert(!c && z);
 
     sigaction(SIGILL, &act, NULL);
     sigaction(SIGTRAP, &act, NULL);
@@ -51,13 +119,40 @@ int main(int argc, char **argv)
     asm volatile(FMT2_STR("0:\tchk %0, %1") : : "d"(0), "d"(-1), FMT_INS);
     CHECK_SIG;
 
-#if 0
-    /* FIXME: chk2 not correctly translated. */
-    int bounds[2] = { 0, 1 };
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
+    asm volatile(FMT2_STR("0:\tchk2.l %0@(0xBDBDBDBD,%1:l:4)@(0x0D0D0D0D), %2")
+                 : : "a"((void *)&intermediate - 0xBDBDBDBD - 0xEEEE * 4),
+                 "r"(0xEEEE), "d"(3), FMT_INS);
     CHECK_SIG;
-#endif
 
     asm volatile(FMT2_STR("cmp.l %0, %1\n0:\ttrapv")
                  : : "d"(INT_MIN), "d"(1), FMT_INS);

