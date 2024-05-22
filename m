Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81296C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 21:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9tV6-0004iO-1o; Wed, 22 May 2024 17:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9tV1-0004gV-Cu
 for qemu-devel@nongnu.org; Wed, 22 May 2024 17:27:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9tUw-0002dz-JR
 for qemu-devel@nongnu.org; Wed, 22 May 2024 17:27:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f4d6b7168eso2118145b3a.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716413264; x=1717018064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8e5m0plxdryjhxAJXURN0ZG6zEweLdqiMndk79L3hk=;
 b=LfGQP9tEebRwIefdoE4H4gxHkm2e/jy//qG3nlffvvYv+vTcpWdlTnVnO6croNKUYH
 w8ChY1HOgsZ6esCiwOcYeYQ5SWH521iqPxpU2Ras4A0d5E99mmMIuaq0EzXDNmf/GufQ
 IE2mImPRLKuUBbrMq5cQ3EkxxE4OX6Nb6ztfo+GkbFCoDdahlardNB1rGQ2AWcaD+BUo
 AjdCDSXapXhe2DYDNCMLLawiHuYFpv7j3mDnJ+uRh7vMlv30esPmAHfhFTW2NPvIvt97
 HVrSN+JRcehtpe24uiaw3MI7+Vo7DBoVdfex17cNdn+nxM1YtQCpL2bPaJhoK9Jv4JrK
 kbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716413264; x=1717018064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8e5m0plxdryjhxAJXURN0ZG6zEweLdqiMndk79L3hk=;
 b=ZUeTGQUJ7PgeYge4L1xEIiYF0PPpnW738Oc+1WddILAwtE/QO43bt249QJU05MyQPs
 Y93VUuTCe4L81cWEeuFlrLdCDLeWb4Z576FiVmAg3KWj4bRjPRVliI9aqa51My6Dhl5w
 +2hSb4RtypHA/6XCYrx3Z6QArN7UHvbg0eRxhcJ6HiF9+Pni+Ejp51Zv1zGVT2Jxqjhs
 7GCdpmNwYLWDOmrGa3/k7M1yVdEIlQ1ntFiHA5tuQzZqL/HNDTr6Crnf8owQdqOnpdvi
 h4HVOu61erPQ887kUJ/prFEVK0aPbgYFKdt9QYARk5foxqmX292HKz9JWLsjKoPDtFwG
 cGIw==
X-Gm-Message-State: AOJu0YwgLO45D685Y0HYUfgqdE9tcocHV7MtvdZjy+MWg/yKIdGpOYfs
 kHKdg/sIYyCI7HxX0HGsqrOEAbKGl9DK/Au4KEUdBDDEarHlWl06WLlsYFXKVpJ6cFrSgF25CVz
 G
X-Google-Smtp-Source: AGHT+IGHjviFitK4Xf88WKHFfvb3sGv3AZHqN5in7cCB2nj5kcIAI/W8GXxF9Ci1mYwMxIRLrYfJZQ==
X-Received: by 2002:a05:6a21:150b:b0:1af:86da:3f7 with SMTP id
 adf61e73a8af0-1b1f874fa98mr4064197637.4.1716413263999; 
 Wed, 22 May 2024 14:27:43 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fc06586asm64621705ad.201.2024.05.22.14.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 14:27:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH RISU 1/4] risugen/arm: Convert to use assembly
Date: Wed, 22 May 2024 14:27:38 -0700
Message-Id: <20240522212741.297734-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522212741.297734-1-richard.henderson@linaro.org>
References: <20240522212741.297734-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Split random data and memory blocks into .data.
Use ADR label+offset to address them.
Fix some bugs in the (apparently unused) SVE memory addressing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risugen_arm.pm | 719 +++++++++++++++++--------------------------------
 1 file changed, 247 insertions(+), 472 deletions(-)

diff --git a/risugen_arm.pm b/risugen_arm.pm
index 8d423b1..cf0c1af 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -26,9 +26,6 @@ require Exporter;
 our @ISA    = qw(Exporter);
 our @EXPORT = qw(write_test_code);
 
-my $periodic_reg_random = 1;
-my $enable_aarch64_ld1 = 0;
-
 # Note that we always start in ARM mode even if the C code was compiled for
 # thumb because we are called by branch to a lsbit-clear pointer.
 # is_thumb tracks the mode we're actually currently in (ie should we emit
@@ -45,6 +42,8 @@ my $test_thumb = 0; # should test code be Thumb mode?
 
 # Maximum alignment restriction permitted for a memory op.
 my $MAXALIGN = 64;
+# Maximum offset permitted for a memory op.
+my $MEMBLOCKLEN = 8192;
 
 # An instruction pattern as parsed from the config file turns into
 # a record like this:
@@ -60,19 +59,11 @@ my $MAXALIGN = 64;
 # Valid block names (keys in blocks hash)
 my %valid_blockname = ( constraints => 1, memory => 1 );
 
-# for thumb only
-sub thumb_align4()
-{
-    if ($bytecount & 3) {
-        insn16(0xbf00);  # NOP
-    }
-}
-
 # used for aarch64 only for now
 sub data_barrier()
 {
     if ($is_aarch64) {
-        insn32(0xd5033f9f); # DSB SYS
+        printf "\tdsb\tsy\n";
     }
 }
 
@@ -94,23 +85,35 @@ my $OP_SETMEMBLOCK = 2;    # r0 is address of memory block (8192 bytes)
 my $OP_GETMEMBLOCK = 3;    # add the address of memory block to r0
 my $OP_COMPAREMEM = 4;     # compare memory block
 
+sub xr($)
+{
+    my ($reg) = @_;
+    if (!$is_aarch64) {
+        return "r$reg";
+    } elsif ($reg == 31) {
+        return "xzr";
+    } else {
+        return "x$reg";
+    }
+}
+
 sub write_thumb_risuop($)
 {
     my ($op) = @_;
-    insn16(0xdee0 | $op);
+    printf "\t.inst.n\t%#x\n", 0xdee0 | $op;
 }
 
 sub write_arm_risuop($)
 {
     my ($op) = @_;
-    insn32(0xe7fe5af0 | $op);
+    printf "\t.inst\t%#x\n", 0xe7fe5af0 | $op;
 }
 
 sub write_aarch64_risuop($)
 {
     # instr with bits (28:27) == 0 0 are UNALLOCATED
     my ($op) = @_;
-    insn32(0x00005af0 | $op);
+    printf "\t.inst\t%#x\n", 0x00005af0 | $op;
 }
 
 sub write_risuop($)
@@ -125,17 +128,22 @@ sub write_risuop($)
     }
 }
 
+sub write_data32($)
+{
+    my ($data) = @_;
+    printf "\t.word\t%#08x\n", $data;
+}
+
 sub write_switch_to_thumb()
 {
     # Switch to thumb if we're not already there
     if (!$is_thumb) {
-        # Note that we have to clean up r0 afterwards
-        # so it isn't tainted with a value which depends
-        # on PC (and which might differ between hw and
-        # qemu/valgrind/etc)
-        insn32(0xe28f0001);     # add r0, pc, #1
-        insn32(0xe12fff10);     # bx r0
-        insn16(0x4040);         # eor r0,r0 (enc T1)
+        # Note that we have to clean up R0 afterwards so it isn't
+        # tainted with a value which depends on PC.
+        printf "\tadd\tr0, pc, #1\n";
+        printf "\tbx\tr0\n";
+        printf ".thumb\n";
+        printf "\teors\tr0, r0\n";
         $is_thumb = 1;
     }
 }
@@ -144,9 +152,10 @@ sub write_switch_to_arm()
 {
     # Switch to ARM mode if we are in thumb mode
     if ($is_thumb) {
-        thumb_align4();
-        insn16(0x4778);  # bx pc
-        insn16(0xbf00);  # nop
+        printf "\t.balign\t4\n";
+        printf "\tbx\tpc\n";
+        printf "\tnop\n";
+        printf ".arm\n";
         $is_thumb = 0;
     }
 }
@@ -165,122 +174,38 @@ sub write_switch_to_test_mode()
     }
 }
 
-# sign extend a 32bit reg into a 64bit reg
-sub write_sxt32($$)
-{
-    my ($rd, $rn) = @_;
-    die "write_sxt32: invalid operation for this arch.\n" if (!$is_aarch64);
-
-    insn32(0x93407c00 | $rn << 5 | $rd);
-}
-
 sub write_add_rri($$$)
 {
     my ($rd, $rn, $i) = @_;
-    my $sh;
-
-    die "write_add_rri: invalid operation for this arch.\n" if (!$is_aarch64);
-
-    if ($i >= 0 && $i < 0x1000) {
-        $sh = 0;
-    } elsif (($i & 0xfff) || $i >= 0x1000000) {
-        die "invalid immediate for this arch,\n";
-    } else {
-        $sh = 1;
-        $i >>= 12;
-    }
-    insn32(0x91000000 | ($rd << 0) | ($rn << 5) | ($i << 10) | ($sh << 22));
+    printf "\tadd\t%s, %s, #%d\n", xr($rd), xr($rn), $i;
 }
 
 sub write_sub_rrr($$$)
 {
     my ($rd, $rn, $rm) = @_;
-
-    if ($is_aarch64) {
-        insn32(0xcb000000 | ($rm << 16) | ($rn << 5) | $rd);
-
-    } elsif ($is_thumb) {
-        # enc T2
-        insn16(0xeba0 | $rn);
-        insn16(0x0000 | ($rd << 8) | $rm);
-    } else {
-        # enc A1
-        insn32(0xe0400000 | ($rn << 16) | ($rd << 12) | $rm);
-    }
+    printf "\tsub\t%s, %s, %s\n", xr($rd), xr($rn), xr($rm);
 }
 
 # valid shift types
-my $SHIFT_LSL = 0;
-my $SHIFT_LSR = 1;
-my $SHIFT_ASR = 2;
-my $SHIFT_ROR = 3;
+my $SHIFT_LSL = "lsl";
+my $SHIFT_LSR = "lsr";
+my $SHIFT_ASR = "asr";
+my $SHIFT_ROR = "ror";
 
 sub write_sub_rrrs($$$$$)
 {
     # sub rd, rn, rm, shifted
     my ($rd, $rn, $rm, $type, $imm) = @_;
     $type = $SHIFT_LSL if $imm == 0;
-    my $bits = $is_aarch64 ? 64 : 32;
 
-    if ($imm == $bits && ($type == $SHIFT_LSR || $type == $SHIFT_ASR)) {
-        $imm = 0;
-    }
-    die "write_sub_rrrs: bad shift immediate $imm\n" if $imm < 0 || $imm > ($bits - 1);
-
-    if ($is_aarch64) {
-        insn32(0xcb000000 | ($type << 22) | ($rm << 16) | ($imm << 10) | ($rn << 5) | $rd);
-
-    } elsif ($is_thumb) {
-        # enc T2
-        my ($imm3, $imm2) = ($imm >> 2, $imm & 3);
-        insn16(0xeba0 | $rn);
-        insn16(($imm3 << 12) | ($rd << 8) | ($imm2 << 6) | ($type << 4) | $rm);
-    } else {
-        # enc A1
-        insn32(0xe0400000 | ($rn << 16) | ($rd << 12) | ($imm << 7) | ($type << 5) | $rm);
-    }
+    printf "\tsub\t%s, %s, %s, %s #%d\n",
+           xr($rd), xr($rn), xr($rm), $type, $imm;
 }
 
 sub write_mov_rr($$)
 {
     my ($rd, $rm) = @_;
-
-    if ($is_aarch64) {
-        # using ADD 0x11000000 */
-        insn32(0x91000000 | ($rm << 5) | $rd);
-
-    } elsif ($is_thumb) {
-        # enc T3
-        insn16(0xea4f);
-        insn16(($rd << 8) | $rm);
-    } else {
-        # enc A1
-        insn32(0xe1a00000 | ($rd << 12) | $rm);
-    }
-}
-
-sub write_mov_ri16($$$)
-{
-    # Write 16 bits of immediate to register.
-    my ($rd, $imm, $is_movt) = @_;
-
-    die "write_mov_ri16: invalid operation for this arch.\n" if ($is_aarch64);
-    die "write_mov_ri16: immediate $imm out of range\n" if (($imm & 0xffff0000) != 0);
-
-    if ($is_thumb) {
-        # enc T3
-        my ($imm4, $i, $imm3, $imm8) = (($imm & 0xf000) >> 12,
-                                        ($imm & 0x0800) >> 11,
-                                        ($imm & 0x0700) >> 8,
-                                        ($imm & 0x00ff));
-        insn16(0xf240 | ($is_movt << 7) | ($i << 10) | $imm4);
-        insn16(($imm3 << 12) | ($rd << 8) | $imm8);
-    } else {
-        # enc A2
-        my ($imm4, $imm12) = (($imm & 0xf000) >> 12,
-                              ($imm & 0x0fff));
-        insn32(0xe3000000 | ($is_movt << 22) | ($imm4 << 16) | ($rd << 12) | $imm12);
-    }
+    printf "\tmov\t%s, %s\n", xr($rd), xr($rm);
 }
 
 sub write_mov_ri($$)
@@ -288,21 +213,21 @@ sub write_mov_ri($$)
     my ($rd, $imm) = @_;
     my $highhalf = ($imm >> 16) & 0xffff;
 
-    if ($is_aarch64) {
-        if ($imm < 0) {
-            # MOVN
-            insn32(0x92800000 | ((~$imm & 0xffff) << 5) | $rd);
-            # MOVK, LSL 16
-            insn32(0xf2a00000 | ($highhalf << 5) | $rd) if $highhalf != 0xffff;
-        } else {
-            # MOVZ
-            insn32(0x52800000 | (($imm & 0xffff) << 5) | $rd);
-            # MOVK, LSL 16
-            insn32(0xf2a00000 | ($highhalf << 5) | $rd) if $highhalf != 0;
+    if (!$is_aarch64) {
+        printf "\tmovw\t%s, #%#x\n", xr($rd), 0xffff & $imm;
+        if ($highhalf != 0) {
+            printf "\tmovt\t%s, #%#x\n", xr($rd), $highhalf;
+        }
+    } elsif ($imm < 0) {
+        printf "\tmovn\t%s, #%#x\n", xr($rd), 0xffff & ~$imm;
+        if ($highhalf != 0xffff) {
+            printf "\tmovk\t%s, #%#x, lsl #16\n", xr($rd), $highhalf;
         }
     } else {
-        write_mov_ri16($rd, ($imm & 0xffff), 0);
-        write_mov_ri16($rd, $highhalf, 1) if $highhalf;
+        printf "\tmovz\t%s, #%#x\n", xr($rd), 0xffff & $imm;
+        if ($highhalf != 0) {
+            printf "\tmovk\t%s, #%#x, lsl #16\n", xr($rd), $highhalf;
+        }
     }
 }
 
@@ -311,7 +236,7 @@ sub write_addpl_rri($$$)
     my ($rd, $rn, $imm) = @_;
     die "write_addpl: invalid operation for this arch.\n" if (!$is_aarch64);
 
-    insn32(0x04605000 | ($rn << 16) | (($imm & 0x3f) << 5) | $rd);
+    printf "\taddpl\t%s, %s, #%d\n", xr($rd), xr($rn), $imm;
 }
 
 sub write_addvl_rri($$$)
@@ -319,7 +244,7 @@ sub write_addvl_rri($$$)
     my ($rd, $rn, $imm) = @_;
     die "write_addvl: invalid operation for this arch.\n" if (!$is_aarch64);
 
-    insn32(0x04205000 | ($rn << 16) | (($imm & 0x3f) << 5) | $rd);
+    printf "\taddvl\t%s, %s, #%d\n", xr($rd), xr($rn), $imm;
 }
 
 sub write_rdvl_ri($$)
@@ -327,7 +252,7 @@ sub write_rdvl_ri($$)
     my ($rd, $imm) = @_;
     die "write_rdvl: invalid operation for this arch.\n" if (!$is_aarch64);
 
-    insn32(0x04bf5000 | (($imm & 0x3f) << 5) | $rd);
+    printf "\trdvl\t%s, #%d\n", xr($rd), $imm;
 }
 
 sub write_madd_rrrr($$$$)
@@ -335,7 +260,7 @@ sub write_madd_rrrr($$$$)
     my ($rd, $rn, $rm, $ra) = @_;
     die "write_madd: invalid operation for this arch.\n" if (!$is_aarch64);
 
-    insn32(0x9b000000 | ($rm << 16) | ($ra << 10) | ($rn << 5) | $rd);
+    printf "\tmadd\t%s, %s, %s, %s\n", xr($rd), xr($rn), xr($rm), xr($ra);
 }
 
 sub write_msub_rrrr($$$$)
@@ -343,13 +268,14 @@ sub write_msub_rrrr($$$$)
     my ($rd, $rn, $rm, $ra) = @_;
     die "write_msub: invalid operation for this arch.\n" if (!$is_aarch64);
 
-    insn32(0x9b008000 | ($rm << 16) | ($ra << 10) | ($rn << 5) | $rd);
+    printf "\tmsub\t%s, %s, %s, %s\n", xr($rd), xr($rn), xr($rm), xr($ra);
 }
 
 sub write_mul_rrr($$$)
 {
     my ($rd, $rn, $rm) = @_;
-    write_madd_rrrr($rd, $rn, $rm, 31);
+
+    printf "\tmul\t%s, %s, %s\n", xr($rd), xr($rn), xr($rm);
 }
 
 # write random fp value of passed precision (1=single, 2=double, 4=quad)
@@ -359,7 +285,7 @@ sub write_random_fpreg_var($)
     my $randomize_low = 0;
 
     if ($precision != 1 && $precision != 2 && $precision != 4) {
-	die "write_random_fpreg: invalid precision.\n";
+        die "write_random_fpreg: invalid precision.\n";
     }
 
     my ($low, $high);
@@ -371,7 +297,7 @@ sub write_random_fpreg_var($)
     } elsif ($r < 10) {
         # NaN (5%)
         # (plus a tiny chance of generating +-Inf)
-	$randomize_low = 1;
+        $randomize_low = 1;
         $high = rand(0xffffffff) | 0x7ff00000;
     } elsif ($r < 15) {
         # Infinity (5%)
@@ -381,83 +307,22 @@ sub write_random_fpreg_var($)
     } elsif ($r < 30) {
         # Denormalized number (15%)
         # (plus tiny chance of +-0)
-	$randomize_low = 1;
+        $randomize_low = 1;
         $high = rand(0xffffffff) & ~0x7ff00000;
     } else {
         # Normalized number (70%)
         # (plus a small chance of the other cases)
-	$randomize_low = 1;
+        $randomize_low = 1;
         $high = rand(0xffffffff);
     }
 
     for (my $i = 1; $i < $precision; $i++) {
-	if ($randomize_low) {
-	    $low = rand(0xffffffff);
-	}
-	insn32($low);
+        if ($randomize_low) {
+            $low = rand(0xffffffff);
+        }
+        printf "\t.word\t%#08x\n", $low;
     }
-    insn32($high);
-}
-
-sub write_random_double_fpreg()
-{
-    my ($low, $high);
-    my $r = rand(100);
-    if ($r < 5) {
-        # +-0 (5%)
-        $low = $high = 0;
-        $high |= 0x80000000 if (rand() < 0.5);
-    } elsif ($r < 10) {
-        # NaN (5%)
-        # (plus a tiny chance of generating +-Inf)
-        $low = rand(0xffffffff);
-        $high = rand(0xffffffff) | 0x7ff00000;
-    } elsif ($r < 15) {
-        # Infinity (5%)
-        $low = 0;
-        $high = 0x7ff00000;
-        $high |= 0x80000000 if (rand() < 0.5);
-    } elsif ($r < 30) {
-        # Denormalized number (15%)
-        # (plus tiny chance of +-0)
-        $low = rand(0xffffffff);
-        $high = rand(0xffffffff) & ~0x7ff00000;
-    } else {
-        # Normalized number (70%)
-        # (plus a small chance of the other cases)
-        $low = rand(0xffffffff);
-        $high = rand(0xffffffff);
-    }
-    insn32($low);
-    insn32($high);
-}
-
-sub write_random_single_fpreg()
-{
-    my ($value);
-    my $r = rand(100);
-    if ($r < 5) {
-        # +-0 (5%)
-        $value = 0;
-        $value |= 0x80000000 if (rand() < 0.5);
-    } elsif ($r < 10) {
-        # NaN (5%)
-        # (plus a tiny chance of generating +-Inf)
-        $value = rand(0xffffffff) | 0x7f800000;
-    } elsif ($r < 15) {
-        # Infinity (5%)
-        $value = 0x7f800000;
-        $value |= 0x80000000 if (rand() < 0.5);
-    } elsif ($r < 30) {
-        # Denormalized number (15%)
-        # (plus tiny chance of +-0)
-        $value = rand(0xffffffff) & ~0x7f800000;
-    } else {
-        # Normalized number (70%)
-        # (plus a small chance of the other cases)
-        $value = rand(0xffffffff);
-    }
-    insn32($value);
+    printf "\t.word\t%#08x\n", $high;
 }
 
 sub write_random_arm_fpreg()
@@ -479,110 +344,92 @@ sub write_random_arm_fpreg()
 sub write_random_arm_regdata($)
 {
     my ($fp_enabled) = @_;
-    # TODO hardcoded, also no d16-d31 initialisation
     my $vfp = $fp_enabled ? 2 : 0; # 0 : no vfp, 1 : vfpd16, 2 : vfpd32
     write_switch_to_arm();
-    
+
     # initialise all registers
-    if ($vfp == 1) {
-        insn32(0xe28f0008);    # add r0, pc, #8
-        insn32(0xecb00b20);    # vldmia r0!, {d0-d15}
-    } elsif ($vfp == 2) {
-        insn32(0xe28f000c);    # add r0, pc, #12
-        insn32(0xecb00b20);    # vldmia r0!, {d0-d15}
-        insn32(0xecf00b20);    # vldmia r0!, {d16-d31}
-    } else {
-        insn32(0xe28f0004);    # add r0, pc, #4
-    }
-    
-    insn32(0xe8905fff);        # ldmia r0, {r0-r12,r14}
-    my $datalen = 14;
-    $datalen += (32 * $vfp);
-    insn32(0xea000000 + ($datalen-1));    # b next
+    printf "\tadr\tr0, 0f\n";
+    printf "\tb\t1f\n";
+
+    printf "\t.balign %d\n", $fp_enabled ? 8 : 4;
+    printf "0:\n";
+
     for (0..(($vfp * 16) - 1)) { # NB: never done for $vfp == 0
         write_random_arm_fpreg();
     }
     #  .word [14 words of data for r0..r12,r14]
     for (0..13) {
-        insn32(rand(0xffffffff));
+        write_data32(rand(0xffffffff));
     }
-    # next:
-    # clear the flags (NZCVQ and GE): msr APSR_nzcvqg, #0
-    insn32(0xe32cf000);
+
+    printf "1:\n";
+    if ($vfp == 1) {
+        printf "\tvldmia\tr0!, {d0-d15}\n";
+    } elsif ($vfp == 2) {
+        printf "\tvldmia\tr0!, {d0-d15}\n";
+        printf "\tvldmia\tr0!, {d16-d31}\n";
+    }
+    printf "\tldmia\tr0, {r0-r12,r14}\n";
+
+    # clear the flags (NZCVQ and GE)
+    printf "\tmsr\tAPSR_nzcvqg, #0\n";
 }
 
 sub write_random_aarch64_fpdata()
 {
     # load floating point / SIMD registers
-    my $align = 16;
-    my $datalen = 32 * 16 + $align;
-    write_pc_adr(0, (3 * 4) + ($align - 1)); # insn 1
-    write_align_reg(0, $align);              # insn 2
-    write_jump_fwd($datalen);                # insn 3
+    printf "\t.data\n";
+    printf "\t.balign\t16\n";
+    printf "1:\n";
 
-    # align safety
-    for (my $i = 0; $i < ($align / 4); $i++) {
-        insn32(rand(0xffffffff));
-    };
-
-    for (my $rt = 0; $rt <= 31; $rt++) {
-	write_random_fpreg_var(4); # quad
+    for (0..31) {
+        write_random_fpreg_var(4); # quad
     }
 
-    if ($enable_aarch64_ld1) {
-	# enable only when we have ld1
-	for (my $rt = 0; $rt <= 31; $rt += 4) {
-	    insn32(0x4cdf2c00 | $rt); # ld1 {v0.2d-v3.2d}, [x0], #64
-	}
-    } else {
-	# temporarily use LDP instead
-	for (my $rt = 0; $rt <= 31; $rt += 2) {
-	    insn32(0xacc10000 | ($rt + 1) << 10 | ($rt)); # ldp q0,q1,[x0],#32
-	}
+    printf "\t.text\n";
+    printf "\tadr\tx0, 1b\n";
+
+    for (my $rt = 0; $rt < 32; $rt += 4) {
+        printf "\tld1\t{v%d.2d-v%d.2d}, [x0], #64\n", $rt, $rt + 3;
     }
 }
 
 sub write_random_aarch64_svedata()
 {
+    # Max SVE size
+    my $vq = 16;
+
     # Load SVE registers
-    my $align = 16;
-    my $vq = 16;                             # quadwords per vector
-    my $veclen = 32 * $vq * 16;
-    my $predlen = 16 * $vq * 2;
-    my $datalen = $veclen + $predlen;
+    printf "\t.data\n";
+    printf "\t.balign\t16\n";
+    printf "1:\n";
 
-    write_pc_adr(0, 2 * 4);     # insn 1
-    write_jump_fwd($datalen);   # insn 2
+    for (my $i = 0; $i < 32 * 16 * $vq; $i += 16) {
+        write_random_fpreg_var(4); # quad
+    }
+    for (my $i = 0; $i < 16 * 2 * $vq; $i += 4) {
+        write_data32(rand(0xffffffff));
+    }
+
+    printf "\t.text\n";
+    printf "\tadr\tx0, 1b\n";
 
     for (my $rt = 0; $rt <= 31; $rt++) {
-        for (my $q = 0; $q < $vq; $q++) {
-            write_random_fpreg_var(4); # quad
-        }
+        printf "\tldr\tz%d, [x0, #%d, mul vl]\n", $rt, $rt;
     }
-    for (my $rt = 0; $rt <= 15; $rt++) {
-        for (my $q = 0; $q < $vq; $q++) {
-            insn16(rand(0xffff));
-        }
-    }
-
-    for (my $rt = 0; $rt <= 31; $rt++) {
-        # ldr z$rt, [x0, #$rt, mul vl]
-        insn32(0x85804000 + $rt + (($rt & 7) << 10) + (($rt & 0x18) << 13));
-    }
-
-    write_add_rri(0, 0, $veclen);
+    write_add_rri(0, 0, 32 * 16 * $vq);
 
     for (my $rt = 0; $rt <= 15; $rt++) {
-        # ldr p$rt, [x0, #$pt, mul vl]
-        insn32(0x85800000 + $rt + (($rt & 7) << 10) + (($rt & 0x18) << 13));
+        printf "\tldr\tp%d, [x0, #%d, mul vl]\n", $rt, $rt;
     }
 }
 
 sub write_random_aarch64_regdata($$)
 {
     my ($fp_enabled, $sve_enabled) = @_;
+
     # clear flags
-    insn32(0xd51b421f);     # msr nzcv, xzr
+    printf "\tmsr\tnzcv, xzr\n";
 
     # Load floating point / SIMD registers
     # (one or the other as they overlap)
@@ -612,65 +459,6 @@ sub write_random_register_data($$)
     write_risuop($OP_COMPARE);
 }
 
-# put PC + offset into a register.
-# this must emit an instruction of 4 bytes.
-sub write_pc_adr($$)
-{
-    my ($rd, $imm) = @_;
-
-    if ($is_aarch64) {
-        # C2.3.5 PC-relative address calculation
-        # The ADR instruction adds a signed, 21-bit value of the pc that fetched this instruction,
-        my ($immhi, $immlo) = ($imm >> 2, $imm & 0x3);
-        insn32(0x10000000 | $immlo << 29 | $immhi << 5 | $rd);
-    } else {
-        # A.2.3 ARM Core Registers:
-        # When executing an ARM instruction, PC reads as the address of the current insn plus 8.
-        $imm -= 8;
-        insn32(0xe28f0000 | $rd << 12 | $imm);
-
-    }
-}
-
-# clear bits in register to satisfy alignment.
-# Must use exactly 4 instruction-bytes (one instruction on arm)
-sub write_align_reg($$)
-{
-    my ($rd, $align) = @_;
-    die "bad alignment!" if ($align < 2);
-
-    if ($is_aarch64) {
-        # and rd, rd, ~(align - 1)    ; A64 BIC imm is an alias for AND
-
-        # Unfortunately we need to calculate the immr/imms/N values to get
-        # our desired immediate value. In this case we want to use an element
-        # size of 64, which means that N is 1, immS is the length of run of
-        # set bits in the mask, and immR is the rotation.
-        # N = 1, immR = 64 - ctz, imms = 63 - ctz
-        # (Note that an all bits-set mask is not encodable here, but
-        # the requirement for $align to be at least 2 avoids that.)
-        my $cnt = ctz($align);
-        insn32(0x92000000 | 1 << 22 | (64 - $cnt) << 16 | (63 - $cnt) << 10 | $rd << 5 | $rd);
-    } else {
-        # bic rd, rd, (align - 1)
-        insn32(0xe3c00000 | $rd << 16 | $rd << 12 | ($align - 1));
-    }
-}
-
-# jump ahead of n bytes starting from next instruction
-sub write_jump_fwd($)
-{
-    my ($len) = @_;
-
-    if ($is_aarch64) {
-        # b pc + len
-        insn32(0x14000000 | (($len / 4) + 1));
-    } else {
-        # b pc + len
-        insn32(0xea000000 | (($len / 4) - 1));
-    }
-}
-
 sub write_memblock_setup()
 {
     # Write code which sets up the memory block for loads and stores.
@@ -678,36 +466,35 @@ sub write_memblock_setup()
     # of random data, aligned to the maximum desired alignment.
     write_switch_to_arm();
 
-    my $align = $MAXALIGN;
-    my $datalen = 8192 + $align;
-    if (($align > 255) || !is_pow_of_2($align) || $align < 4) {
-        die "bad alignment!";
+    printf "\tadr\t%s, 2f\n", xr(0);
+    if ($is_aarch64) {
+        printf "\t.data\n";
+    } else {
+        printf "\tb\t3f\n";
     }
 
-    # set r0 to (datablock + (align-1)) & ~(align-1)
-    # datablock is at PC + (4 * 4 instructions) = PC + 16
-    write_pc_adr(0, (4 * 4) + ($align - 1)); # insn 1
-    write_align_reg(0, $align);              # insn 2
-    write_risuop($OP_SETMEMBLOCK);           # insn 3
-    write_jump_fwd($datalen);                # insn 4
+    printf "\t.balign\t%d\n", $MAXALIGN;
+    printf "2:\n";
 
-    for (my $i = 0; $i < $datalen / 4; $i++) {
-        insn32(rand(0xffffffff));
+    for (my $i = 0; $i < $MEMBLOCKLEN; $i += 4) {
+        write_data32(rand(0xffffffff));
     }
-    # next:
 
+    if ($is_aarch64) {
+        printf "\t.text\n";
+    } else {
+        printf "3:\n";
+    }
+
+    write_risuop($OP_SETMEMBLOCK);
 }
 
 sub write_set_fpscr_arm($)
 {
     my ($fpscr) = @_;
     write_switch_to_arm();
-    # movw r0, imm16
-    insn32(0xe3000000 | ($fpscr & 0xfff) | (($fpscr & 0xf000) << 4));
-    # movt r0, imm16
-    insn32(0xe3400000 | (($fpscr & 0xf0000000) >> 12) | (($fpscr & 0x0fff0000) >> 16));
-    # vmsr fpscr, r0
-    insn32(0xeee10a10);
+    write_mov_ri(0, $fpscr);
+    printf "\tvmsr\tfpscr, r0\n";
 }
 
 sub write_set_fpscr_aarch64($)
@@ -715,10 +502,9 @@ sub write_set_fpscr_aarch64($)
     # on aarch64 we have split fpcr and fpsr registers.
     # Status will be initialized to 0, while user param controls fpcr.
     my ($fpcr) = @_;
-    write_mov_ri(0, 0);
-    insn32(0xd51b4420); #  msr fpsr, x0
+    printf "\tmsr\tfpsr, xzr\n";
     write_mov_ri(0, $fpcr);
-    insn32(0xd51b4400); #  msr fpcr, x0
+    printf "\tmsr\tfpcr, x0\n";
 }
 
 sub write_set_fpscr($)
@@ -752,17 +538,12 @@ sub align($)
     $alignment_restriction = $a;
 }
 
-# XXX claudio: this seems to get the full address, not the offset.
-sub write_get_offset()
+sub get_offset()
 {
-    # Emit code to get a random offset within the memory block, of the
-    # right alignment, into r0
     # We require the offset to not be within 256 bytes of either
     # end, to (more than) allow for the worst case data transfer, which is
     # 16 * 64 bit regs
-    my $offset = (rand(2048 - 512) + 256) & ~($alignment_restriction - 1);
-    write_mov_ri(0, $offset);
-    write_risuop($OP_GETMEMBLOCK);
+    return (rand($MEMBLOCKLEN - 512) + 256) & ~($alignment_restriction - 1);
 }
 
 # Return the log2 of the memory size of an operation described by dtype.
@@ -774,15 +555,21 @@ sub dtype_msz($)
     return $dtl >= $dth ? $dth : 3 - $dth;
 }
 
-sub reg($@)
+sub reg_plus_imm($$@)
 {
-    my ($base, @trashed) = @_;
-    write_get_offset();
-    # Now r0 is the address we want to do the access to,
-    # so just move it into the basereg
-    if ($base != 0) {
-        write_mov_rr($base, 0);
-        write_mov_ri(0, 0);
+    # Handle reg + immediate addressing mode
+    my ($base, $imm, @trashed) = @_;
+    my $offset = get_offset() - $imm;
+
+    if ($is_aarch64) {
+        printf "\tadr\tx%d, 2b%+d\n", $base, $offset;
+    } else {
+        write_mov_ri(0, $offset);
+        write_risuop($OP_GETMEMBLOCK);
+        if ($base != 0) {
+            write_mov_rr($base, 0);
+            write_mov_ri(0, 0);
+        }
     }
     if (grep $_ == $base, @trashed) {
         return -1;
@@ -790,64 +577,37 @@ sub reg($@)
     return $base;
 }
 
-sub reg_plus_imm($$@)
+sub reg($@)
 {
-    # Handle reg + immediate addressing mode
-    my ($base, $imm, @trashed) = @_;
-    if ($imm == 0) {
-        return reg($base, @trashed);
-    }
-
-    write_get_offset();
-    # Now r0 is the address we want to do the access to,
-    # so set the basereg by doing the inverse of the
-    # addressing mode calculation, ie base = r0 - imm
-    # We could do this more cleverly with a sub immediate.
-    if ($base != 0) {
-        write_mov_ri($base, $imm);
-        write_sub_rrr($base, 0, $base);
-        # Clear r0 to avoid register compare mismatches
-        # when the memory block location differs between machines.
-        write_mov_ri(0, 0);
-    } else {
-        # We borrow r1 as a temporary (not a problem
-        # as long as we don't leave anything in a register
-        # which depends on the location of the memory block)
-        write_mov_ri(1, $imm);
-        write_sub_rrr($base, 0, 1);
-    }
-    if (grep $_ == $base, @trashed) {
-        return -1;
-    }
-    return $base;
+    # Handle reg addressing mode
+    my ($base, @trashed) = @_;
+    return reg_plus_imm($base, 0, @trashed);
 }
 
 sub reg_plus_imm_pl($$@)
 {
     # Handle reg + immediate addressing mode
     my ($base, $imm, @trashed) = @_;
-    if ($imm == 0) {
-        return reg($base, @trashed);
-    }
-    write_get_offset();
+    my $offset = get_offset();
 
-    # Now r0 is the address we want to do the access to,
-    # so set the basereg by doing the inverse of the
+    printf "\tadr\tx%d, 2b+%+d\n", $base, $offset;
+
+    # Set the basereg by doing the inverse of the
     # addressing mode calculation, ie base = r0 - imm
     #
     # Note that addpl has a 6-bit immediate, but ldr has a 9-bit
     # immediate, so we need to be able to support larger immediates.
-
     if (-$imm >= -32 && -$imm <= 31) {
-        write_addpl_rri($base, 0, -$imm);
+        write_addpl_rri($base, $base, -$imm);
     } else {
-        # We borrow r1 and r2 as a temporaries (not a problem
-        # as long as we don't leave anything in a register
-        # which depends on the location of the memory block)
-        write_mov_ri(1, 0);
-        write_mov_ri(2, $imm);
-        write_addpl_rri(1, 1, 1);
-        write_msub_rrrr($base, 1, 2, 0);
+        # Select two temporaries (no need to zero afterward, since we don't
+        # leave anything which depends on the location of the memory block.
+        my $t1 = $base == 0 ? 1 : 0;
+        my $t2 = $base == 1 ? 2 : 1;
+        write_mov_ri($t1, 0);
+        write_addpl_rri($t1, $t1, 1);
+        write_mov_ri($t2, -$imm);
+        write_madd_rrrr($base, $t1, $t2, $base);
     }
     if (grep $_ == $base, @trashed) {
         return -1;
@@ -855,7 +615,7 @@ sub reg_plus_imm_pl($$@)
     return $base;
 }
 
-sub reg_plus_imm_vl($$@)
+sub reg_plus_imm_vl($$$@)
 {
     # The usual address formulation is
     #   elements = VL DIV esize
@@ -865,15 +625,13 @@ sub reg_plus_imm_vl($$@)
     #   scale = log2(esize / msize)
     #   base + (imm * VL) >> scale
     my ($base, $imm, $scale, @trashed) = @_;
-    if ($imm == 0) {
-        return reg($base, @trashed);
-    }
-    write_get_offset();
+    my $offset = get_offset();
+    my $t1 = $base == 0 ? 1 : 0;
+    my $t2 = $base == 1 ? 2 : 1;
 
-    # Now r0 is the address we want to do the access to,
-    # so set the basereg by doing the inverse of the
-    # addressing mode calculation, ie base = r0 - imm
-    #
+    printf "\tadr\tx%d, 2b+%+d\n", $base, $offset;
+
+    # Set the basereg by doing the inverse of the addressing calculation.
     # Note that rdvl/addvl have a 6-bit immediate, but ldr has a 9-bit
     # immediate, so we need to be able to support larger immediates.
 
@@ -882,18 +640,19 @@ sub reg_plus_imm_vl($$@)
     my $imm_div = $imm / $mul;
 
     if ($imm == $imm_div * $mul && -$imm_div >= -32 && -$imm_div <= 31) {
-        write_addvl_rri($base, 0, -$imm_div);
+        write_addvl_rri($base, $base, -$imm_div);
     } elsif ($imm >= -32 && $imm <= 31) {
-        write_rdvl_ri(1, $imm);
-        write_sub_rrrs($base, 0, 1, $SHIFT_ASR, $scale);
+        write_rdvl_ri($t1, $imm);
+        write_sub_rrrs($base, $base, $t1, $SHIFT_ASR, $scale);
     } else {
-        write_rdvl_ri(1, 1);
-        write_mov_ri(2, $imm);
+        write_rdvl_ri($t1, 1);
         if ($scale == 0) {
-            write_msub_rrrr($base, 1, 2, 0);
+            write_mov_ri($t2, -$imm);
+            write_madd_rrrr($base, $t1, $t2, $base);
         } else {
-            write_mul_rrr(1, 1, 2);
-            write_sub_rrrs($base, 0, 1, $SHIFT_ASR, $scale);
+            write_mov_ri($t2, $imm);
+            write_mul_rrr($t1, $t1, $t2);
+            write_sub_rrrs($base, $base, $t1, $SHIFT_ASR, $scale);
         }
     }
     if (grep $_ == $base, @trashed) {
@@ -912,35 +671,39 @@ sub reg_plus_reg_shifted($$$@)
 {
     # handle reg + reg LSL imm addressing mode
     my ($base, $idx, $shift, @trashed) = @_;
-    if ($shift < 0 || $shift > 4 || (!$is_aarch64 && $shift == 4)) {
+    my $offset = get_offset();
 
+    if ($shift < 0 || $shift > 4 || (!$is_aarch64 && $shift == 4)) {
         print ("\n(shift) $shift\n");
         print ("\n(arch) $is_aarch64\n");
         die "reg_plus_reg_shifted: bad shift size\n";
     }
-    my $savedidx = 0;
-    if ($idx == 0) {
-        # save the index into some other register for the
-        # moment, because the risuop will trash r0
-        $idx = 1;
-        $idx++ if $idx == $base;
-        $savedidx = 1;
-        write_mov_rr($idx, 0);
-    }
 
-    # Get a random offset within the memory block, of the
-    # right alignment.
-    write_get_offset();
-    # Now r0 is the address we want to do the access to,
-    # so set the basereg by doing the inverse of the
-    # addressing mode calculation, ie base = r0 - idx LSL imm
-    # LSL x is shift type 0, 
-    write_sub_rrrs($base, 0, $idx, $SHIFT_LSL, $shift);
-    if ($savedidx) {
-        # We can move this back to r0 now
-        write_mov_rr(0, $idx);
-    } elsif ($base != 0) {
-        write_mov_ri(0, 0);
+    if ($is_aarch64) {
+        printf "\tadr\tx%d, 2b%+d\n", $base, $offset;
+        write_sub_rrrs($base, $base, $idx, $SHIFT_LSL, $shift);
+    } else {
+        my $savedidx = 0;
+
+        if ($idx == 0) {
+            # save the index into some other register for the
+            # moment, because the risuop will trash r0
+            $idx = 1;
+            $idx++ if $idx == $base;
+            $savedidx = 1;
+            write_mov_rr($idx, 0);
+        }
+
+        write_mov_ri(0, $offset);
+        write_risuop($OP_GETMEMBLOCK);
+        write_sub_rrrs($base, 0, $idx, $SHIFT_LSL, $shift);
+
+        if ($savedidx) {
+            # We can move idx back to r0 now
+            write_mov_rr(0, $idx);
+        } elsif ($base != 0) {
+            write_mov_ri(0, 0);
+        }
     }
     if (grep $_ == $base, @trashed) {
         return -1;
@@ -1028,21 +791,18 @@ sub gen_one_insn($$)
         }
 
         if ($is_thumb) {
-            # Since the encoding diagrams in the ARM ARM give 32 bit
-            # Thumb instructions as low half | high half, we
-            # flip the halves here so that the input format in
-            # the config file can be in the same order as the ARM.
-            # For a 16 bit Thumb instruction the generated insn is in
-            # the high halfword (because we didn't bother to readjust
-            # all the bit positions in parse_config_file() when we
-            # got to the end and found we only had 16 bits).
-            insn16($insn >> 16);
             if ($insnwidth == 32) {
-                insn16($insn & 0xffff);
+                printf "\t.inst.w\t%#08x\n", $insn;
+            } else {
+                # For a 16 bit Thumb instruction the generated insn is in
+                # the high halfword (because we didn't bother to readjust
+                # all the bit positions in parse_config_file() when we
+                # got to the end and found we only had 16 bits).
+                printf "\t.inst.n\t%#04x\n", $insn >> 16;
             }
         } else {
             # ARM is simple, always a 32 bit word
-            insn32($insn);
+            printf "\t.inst\t%#08x\n", $insn;
         }
 
         if (defined $memblock) {
@@ -1058,8 +818,12 @@ sub gen_one_insn($$)
             }
 
             if ($basereg != -1) {
-                write_mov_ri(0, 0);
-                write_risuop($OP_GETMEMBLOCK);
+                if ($is_aarch64) {
+                    printf "\tadr\tx0, 2b\n";
+                } else {
+                    write_mov_ri(0, 0);
+                    write_risuop($OP_GETMEMBLOCK);
+                }
                 write_sub_rrr($basereg, $basereg, 0);
                 write_mov_ri(0, 0);
             }
@@ -1097,7 +861,15 @@ sub write_test_code($$$$$$$$)
     my %insn_details = %{ $params->{ 'details' } };
     my @keys = @{ $params->{ 'keys' } };
 
-    open_bin($outfile);
+    open_asm($outfile);
+
+    printf "\t.text\n";
+    if (!$is_aarch64) {
+	printf "\t.syntax unified\n";
+        printf "\t.arm\n";
+        printf "\t.arch armv7-a\n";
+        printf "\t.fpu neon\n" if ($fp_enabled);
+    }
 
     # convert from probability that insn will be conditional to
     # probability of forcing insn to unconditional
@@ -1106,7 +878,7 @@ sub write_test_code($$$$$$$$)
     # TODO better random number generator?
     srand(0);
 
-    print "Generating code using patterns: @keys...\n";
+    print STDOUT "Generating code using patterns: @keys...\n";
     progress_start(78, $numinsns);
 
     if ($fp_enabled) {
@@ -1128,7 +900,7 @@ sub write_test_code($$$$$$$$)
         write_risuop($OP_COMPARE);
         # Rewrite the registers periodically. This avoids the tendency
         # for the VFP registers to decay to NaNs and zeroes.
-        if ($periodic_reg_random && ($i % 100) == 0) {
+        if (($i % 100) == 0) {
             write_random_register_data($fp_enabled, $sve_enabled);
             write_switch_to_test_mode();
         }
@@ -1136,7 +908,10 @@ sub write_test_code($$$$$$$$)
     }
     write_risuop($OP_TESTEND);
     progress_end();
-    close_bin();
+
+    close_asm();
+    assemble_and_link($outfile, $params->{ 'cross_prefix' },
+                      $params->{ 'keep' });
 }
 
 1;
-- 
2.34.1


