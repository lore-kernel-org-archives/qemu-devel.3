Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122C3C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJfx-00082V-10; Sun, 26 May 2024 15:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfr-000802-Eo
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfl-0006UF-Mq
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:55 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2bf5e177ebdso2095946a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752204; x=1717357004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCy66KKepWlHqXyVaIB/ACSSH0v8RsXCcqK/IUUC3fY=;
 b=D6Kxh3PNvStWvdIF1Uwmdal0jzLgBgNr7BzfvZv/FBTVqDsk0dAVI7NE7NbpiQgnmL
 Ki0/s8cUITn9ltHkBPFA3eb+uoDSwtQOwdTYyfDJMLAvuYGw7FBpkFlB8ocEFaoIFEI2
 BPasuMkY5hT354aBPdM781iWSB3X7guk7G1l8t3Uo3oKMabl68xBLic+Yz3OdLrjdI6/
 BBEh8R5MLaTfQDCgZ4vtqDlXJ73d+N3Iu4iJvk6jpI6PdiTWiOZrzivcIw4x0ktfwbrJ
 XIBvCNOigTi7NW0jgulRlccUUj0ZX3lziEjCCfw1HVSVf5oTuoGuq8gbwmvSYv1Avhay
 Eyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752204; x=1717357004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCy66KKepWlHqXyVaIB/ACSSH0v8RsXCcqK/IUUC3fY=;
 b=d2opU/KtLMD8Wl6/4K9nh/8jL5c6gnnSIWKbuaQdcFLTJhzQErP/833LKKDREt9owm
 HtkP7eOU8SUPwGue2J6MEKZnBysXtwagph52P9/pWmSndqmeuj/vgEI/CJyE2Dr7BOYz
 dSuVjFN0Q6uE/vvmAY9MYbT82X4dVtQhPxTZQaEVZka1gXAt3q+4SO4u22/VWztHz9bT
 /ndHdsw5p1D2ILm2PNjdv/HHPBnsCXu8SbpItRaH6vTOUT0abGpFHJGU1QBUkk3SgR5D
 IXF+8Yvo+GeoeBIiCIgPLoZb7tHiMRFpgUWTlFr9J6GJcGTr30zLpK+ef0U5wj3bKnbC
 RaTA==
X-Gm-Message-State: AOJu0YxXLZvLTOQ1vM5bCkk06hAWi2KEJ+j66Z/VIJtV+aVbfvsKfvqU
 Z4i4CzPvZSqmQyoiqhMBtr9axQC76zgfn2ViuXfxkQQnbbeZDBqZYzpmVAsVRZcMgq8OxqKDHHn
 B
X-Google-Smtp-Source: AGHT+IHu0Hm01icjL+LtRk7j5ELkhLGgxJqq4i5B/ZVSxYbB9W7qmuzwzdF2znM/YY72RUoQVCbZ4g==
X-Received: by 2002:a17:90b:d98:b0:2bd:8cf6:107d with SMTP id
 98e67ed59e1d1-2bf5e84ace6mr7449859a91.7.1716752204058; 
 Sun, 26 May 2024 12:36:44 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f6155b6sm4943761a91.29.2024.05.26.12.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:36:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 06/13] risugen: Add sparc64 support
Date: Sun, 26 May 2024 12:36:30 -0700
Message-Id: <20240526193637.459064-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526193637.459064-1-richard.henderson@linaro.org>
References: <20240526193637.459064-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risugen            |  10 +-
 risugen_common.pm  |  50 +++++-
 risugen_sparc64.pm | 385 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 443 insertions(+), 2 deletions(-)
 create mode 100644 risugen_sparc64.pm

diff --git a/risugen b/risugen
index 2800b8b..830dfd3 100755
--- a/risugen
+++ b/risugen
@@ -310,6 +310,8 @@ Valid options:
                    Useful to test before support for FP is available.
     --sve        : enable sve floating point
     --be         : generate instructions in Big-Endian byte order (ppc64 only).
+    --cross prefix : prefix for the assembler and linker
+    --keep       : do not remove intermediate files
     --help       : print this message
 EOT
 }
@@ -322,6 +324,8 @@ sub main()
     my $fp_enabled = 1;
     my $sve_enabled = 0;
     my $big_endian = 0;
+    my $cross_prefix = "";
+    my $keep = 0;
     my ($infile, $outfile);
 
     GetOptions( "help" => sub { usage(); exit(0); },
@@ -339,6 +343,8 @@ sub main()
                 "be" => sub { $big_endian = 1; },
                 "no-fp" => sub { $fp_enabled = 0; },
                 "sve" => sub { $sve_enabled = 1; },
+                "cross-prefix=s" => \$cross_prefix,
+                "keep" => sub { $keep = 1; },
         ) or return 1;
     # allow "--pattern re,re" and "--pattern re --pattern re"
     @pattern_re = split(/,/,join(',',@pattern_re));
@@ -372,7 +378,9 @@ sub main()
         'keys' => \@insn_keys,
         'arch' => $full_arch[0],
         'subarch' => $full_arch[1] || '',
-        'bigendian' => $big_endian
+        'bigendian' => $big_endian,
+        'cross_prefix' => $cross_prefix,
+        'keep' => $keep,
     );
 
     write_test_code(\%params);
diff --git a/risugen_common.pm b/risugen_common.pm
index 5207c0e..228082f 100644
--- a/risugen_common.pm
+++ b/risugen_common.pm
@@ -26,7 +26,8 @@ BEGIN {
     our @EXPORT = qw(open_bin close_bin set_endian insn32 insn16 $bytecount
                    progress_start progress_update progress_end
                    eval_with_fields is_pow_of_2 sextract ctz
-                   dump_insn_details);
+                   dump_insn_details
+                   open_asm close_asm assemble_and_link);
 }
 
 our $bytecount;
@@ -66,6 +67,53 @@ sub insn16($)
     $bytecount += 2;
 }
 
+sub open_asm($)
+{
+    my ($basename) = @_;
+    my $fname = $basename . ".s";
+    open(ASM, ">", $fname) or die "can't open $fname: $!";
+    select ASM;
+}
+
+sub close_asm
+{
+    close(ASM) or die "can't close asm file: $!";
+    select STDOUT;
+}
+
+sub assemble_and_link($$$@)
+{
+    my ($basename, $cross_prefix, $keep, @asflags) = @_;
+    my $asmfile = $basename . ".s";
+    my $ldfile = $basename . ".ld";
+    my $objfile = $basename . ".o";
+
+    open(LD, ">", $ldfile) or die "can't open $ldfile: $!";
+    print LD '
+        ENTRY(start)
+        PHDRS { text PT_LOAD FILEHDR PHDRS; }
+        SECTIONS {
+            . = SIZEOF_HEADERS;
+            PROVIDE(start = .);
+            .text : { *(.text) } :text
+            .data : { *(.data) } :text
+        }
+    ';
+    close(LD);
+
+    my @as = ($cross_prefix . "as", @asflags, "-o", $objfile, $asmfile);
+    system(@as) == 0 or die "system @as failed: $?";
+
+    my @ld = ($cross_prefix . "ld", "-o", $basename, "-T", $ldfile, $objfile);
+    system(@ld) == 0 or die "system @ld failed: $?";
+
+    if (!$keep) {
+        unlink $asmfile;
+        unlink $ldfile;
+        unlink $objfile;
+    }
+}
+
 # Progress bar implementation
 my $lastprog;
 my $proglen;
diff --git a/risugen_sparc64.pm b/risugen_sparc64.pm
new file mode 100644
index 0000000..c9f2ede
--- /dev/null
+++ b/risugen_sparc64.pm
@@ -0,0 +1,385 @@
+#!/usr/bin/perl -w
+###############################################################################
+# Copyright (c) 2024 Linaro Limited
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+###############################################################################
+
+# risugen -- generate a test binary file for use with risu
+# See 'risugen --help' for usage information.
+package risugen_sparc64;
+
+use strict;
+use warnings;
+
+use risugen_common;
+
+require Exporter;
+
+our @ISA    = qw(Exporter);
+our @EXPORT = qw(write_test_code);
+
+my $periodic_reg_random = 1;
+
+# Maximum alignment restriction permitted for a memory op.
+my $MAXALIGN = 64;
+my $MAXBLOCK = 2048;
+my $PARAMREG = 15;         # %o7
+
+my $OP_COMPARE = 0;        # compare registers
+my $OP_TESTEND = 1;        # end of test, stop
+my $OP_SETMEMBLOCK = 2;    # g1 is address of memory block (8192 bytes)
+my $OP_GETMEMBLOCK = 3;    # add the address of memory block to g1
+my $OP_COMPAREMEM = 4;     # compare memory block
+
+my @GREGS = ( "%g0", "%g1", "%g2", "%g3", "%g4", "%g5", "%g6", "%g7",
+              "%o0", "%o1", "%o2", "%o3", "%o4", "%o5", "%o6", "%o7",
+              "%l0", "%l1", "%l2", "%l3", "%l4", "%l5", "%l6", "%l7",
+              "%i0", "%i1", "%i2", "%i3", "%i4", "%i5", "%i6", "%i7" );
+
+sub write_data32($)
+{
+    my ($val) = @_;
+    printf "\t.word\t%#x\n", $val;
+}
+
+sub write_data64($)
+{
+    my ($val) = @_;
+    printf "\t.quad\t%#x\n", $val;
+}
+
+sub write_risuop($)
+{
+    my ($op) = @_;
+    printf "\tilltrap\t%#x\n", 0xdead0 + $op;
+}
+
+sub write_mov_rr($$)
+{
+    my ($rd, $rs) = @_;
+    printf "\tmov\t%s,%s\n", $GREGS[$rs], $GREGS[$rd];
+}
+
+sub write_mov_ri($$)
+{
+    my ($rd, $imm) = @_;
+
+    if (-0x1000 <= $imm < 0x1000) {
+        printf "\tmov\t%d,%s\n", $imm, $GREGS[$rd];
+    } else {
+        my $immhi = $imm & 0xfffff000;
+        my $immlo = $imm & 0x00000fff;
+
+        if ($imm < 0) {
+            $immhi ^= 0xfffff000;
+            $immlo |= -0x1000;
+        }
+        printf "\tsethi\t%%hi(%d),%s\n", $immhi, $GREGS[$rd];
+        if ($immlo != 0) {
+            printf "\txor\t%s,%d,%s\n", $GREGS[$rd], $immlo, $GREGS[$rd];
+        }
+    }
+}
+
+sub write_add_rri($$$)
+{
+    my ($rd, $rs, $imm) = @_;
+    die "bad imm!" if ($imm < -0x1000 || $imm >= 0x1000);
+
+    printf "\txor\t%s,%d,%s\n", $GREGS[$rs], $imm, $GREGS[$rd];
+}
+
+sub write_sub_rrr($$$)
+{
+    my ($rd, $rs1, $rs2) = @_;
+
+    printf "\tsub\t%s,%s,%s\n", $GREGS[$rs1], $GREGS[$rs2], $GREGS[$rd];
+}
+
+sub begin_datablock($$)
+{
+    my ($align, $label) = @_;
+    die "bad align!" if ($align < 4 || $align > 255 || !is_pow_of_2($align));
+
+    printf ".data\n";
+    printf "\t.balign %d\n", $align;
+    printf "%s:\n", $label;
+}
+
+sub end_datablock()
+{
+    printf ".text\n"
+}
+
+sub write_ref_datablock($$$$)
+{
+    my ($rd, $offset, $scratch, $label) = @_;
+
+    printf "\trd\t%%pc,%s\n", $GREGS[$rd];
+    printf "\tsethi\t%%pc22(%s+%d),%s\n",
+           $label, $offset + 4, $GREGS[$scratch];
+    printf "\tor\t%s,%%pc10(%s+%d),%s\n",
+           $GREGS[$scratch], $label, $offset + 8, $GREGS[$scratch];
+    printf "\tadd\t%s,%s,%s\n", $GREGS[$scratch], $GREGS[$rd], $GREGS[$rd];
+}
+
+sub write_random_register_data($$)
+{
+    my ($fp_enabled, $fsr) = @_;
+    my $size = 32 * 8;
+
+    if ($fp_enabled) {
+        # random data for 32 double-precision regs plus %gsr
+        $size += $fp_enabled ? 33 * 8 : 0;
+    }
+
+    begin_datablock(8, "1");
+    for (my $i = 0; $i < $size; $i += 4) {
+        write_data32(rand(0xffffffff));
+    }
+    if ($fp_enabled) {
+        # %fsr gets constant data
+        write_data64($fsr);
+    }
+    end_datablock();
+
+    write_ref_datablock(1, 0, 2, "1b");
+
+    # Load floating point / SIMD registers
+    if ($fp_enabled) {
+        for (my $rt = 0; $rt < 64; $rt += 2) {
+            printf "\tldd\t[%s+%d],%%f%d\n", $GREGS[1], 32 * 8 + $rt * 4, $rt;
+        }
+        printf "\tldx\t[%s+%d],%s\n", $GREGS[1], 64 * 8, $GREGS[2];
+        printf "\twr\t%s,0,%%gsr\n", $GREGS[2];
+        printf "\tldx\t[%s+%d],%%fsr\n", $GREGS[1], 65 * 8;
+    }
+
+    # Load Y
+    printf "\tldx\t[%s],%s\n", $GREGS[1], $GREGS[2];
+    printf "\twr\t%s,0,%%y\n", $GREGS[2];
+
+    # Clear flags
+    printf "\twr\t%%g0,0,%%ccr\n";
+
+    # Load general purpose registers
+    for (my $i = 31; $i >= 1; --$i) {
+        if (reg_ok($i)) {
+            printf "\tldx\t[%s+%d],%s\n", $GREGS[1], $i * 8, $GREGS[$i];
+        }
+    }
+
+    write_risuop($OP_COMPARE);
+}
+
+sub write_memblock_setup()
+{
+    begin_datablock($MAXALIGN, "2");
+
+    for (my $i = 0; $i < $MAXBLOCK; $i += 4) {
+        write_data32(rand(0xffffffff));
+    }
+
+    end_datablock();
+    write_ref_datablock($PARAMREG, 0, 1, "2b");
+    write_risuop($OP_SETMEMBLOCK);
+}
+
+# Functions used in memory blocks to handle addressing modes.
+# These all have the same basic API: they get called with parameters
+# corresponding to the interesting fields of the instruction,
+# and should generate code to set up the base register to be
+# valid. They must return the register number of the base register.
+# The last (array) parameter lists the registers which are trashed
+# by the instruction (ie which are the targets of the load).
+# This is used to avoid problems when the base reg is a load target.
+
+# Global used to communicate between align(x) and reg() etc.
+my $alignment_restriction;
+
+sub align($)
+{
+    my ($a) = @_;
+    if (!is_pow_of_2($a) || !(0 < $a <= $MAXALIGN)) {
+        die "bad align() value $a\n";
+    }
+    $alignment_restriction = $a;
+}
+
+sub gen_memblock_offset()
+{
+    # Generate a random offset within the memory block, of the correct
+    # alignment. We require the offset to not be within 16 bytes of either
+    # end, to (more than) allow for the worst case data transfer.
+    return (rand($MAXBLOCK - 32) + 16) & ~($alignment_restriction - 1);
+}
+
+sub reg_ok($)
+{
+    my ($r) = @_;
+
+    # Avoid special registers %g7 (tp), %o6 (sp), %i6 (fp).
+    return $r != 7 && $r != 14 && $r != 30;
+}
+
+sub reg_plus_imm($$@)
+{
+    # Handle reg + immediate addressing mode
+    my ($base, $imm, @trashed) = @_;
+    my $offset = gen_memblock_offset();
+    my $scratch = $base != 1 ? 1 : 2;
+
+    write_ref_datablock($base, $offset - $imm, $scratch, "2b");
+    write_mov_ri($scratch, 0);
+
+    if (grep $_ == $base, @trashed) {
+        return -1;
+    }
+    return $base;
+}
+
+sub reg($@)
+{
+    my ($base, @trashed) = @_;
+    return reg_plus_imm($base, 0, @trashed);
+}
+
+sub reg_plus_reg($$@)
+{
+    # Handle reg + reg addressing mode
+    my ($base, $idx, @trashed) = @_;
+    my $offset = gen_memblock_offset();
+    my $scratch = 1;
+
+    if ($base == $idx) {
+        return -1;
+    }
+
+    while ($base == $scratch || $idx == $scratch) {
+        ++$scratch;
+    }
+
+    write_ref_datablock($base, $offset, $scratch, "2b");
+    write_mov_ri($scratch, 0);
+    write_sub_rrr($base, $base, $idx);
+
+    if (grep $_ == $base, @trashed) {
+        return -1;
+    }
+    return $base;
+}
+
+sub gen_one_insn($)
+{
+    my ($rec) = @_;
+    my $insnname = $rec->{name};
+    my $insnwidth = $rec->{width};
+    my $fixedbits = $rec->{fixedbits};
+    my $fixedbitmask = $rec->{fixedbitmask};
+    my $constraint = $rec->{blocks}{"constraints"};
+    my $memblock = $rec->{blocks}{"memory"};
+
+    # Given an instruction-details array, generate an instruction
+    my $constraintfailures = 0;
+
+    INSN: while(1) {
+        my $insn = int(rand(0xffffffff));
+
+        $insn &= ~$fixedbitmask;
+        $insn |= $fixedbits;
+
+        if (defined $constraint) {
+            # User-specified constraint: evaluate in an environment
+            # with variables set corresponding to the variable fields.
+            my $v = eval_with_fields($insnname, $insn, $rec, "constraints", $constraint);
+            if (!$v) {
+                $constraintfailures++;
+                if ($constraintfailures > 10000) {
+                    print "10000 consecutive constraint failures for $insnname constraints string:\n$constraint\n";
+                    exit (1);
+                }
+                next INSN;
+            }
+        }
+
+        # OK, we got a good one
+        $constraintfailures = 0;
+
+        my $basereg;
+
+        if (defined $memblock) {
+            # This is a load or store. We simply evaluate the block,
+            # which is expected to be a call to a function which emits
+            # the code to set up the base register and returns the
+            # number of the base register.
+            align(16);
+            $basereg = eval_with_fields($insnname, $insn, $rec, "memory", $memblock);
+        }
+
+	write_data32($insn);
+
+        if (defined $memblock) {
+            # Clean up following a memory access instruction:
+            # we need to turn the (possibly written-back) basereg
+            # into an offset from the base of the memory block,
+            # to avoid making register values depend on memory layout.
+            # $basereg -1 means the basereg was a target of a load
+            # (and so it doesn't contain a memory address after the op)
+            if ($basereg != -1) {
+                write_mov_ri($basereg, 0);
+            }
+            write_risuop($OP_COMPAREMEM);
+        }
+        return;
+    }
+}
+
+sub write_test_code($)
+{
+    my ($params) = @_;
+
+    my $fp_enabled = $params->{ 'fp_enabled' };
+    my $fsr = $params->{ 'fpscr' };
+    my $numinsns = $params->{ 'numinsns' };
+    my $outfile = $params->{ 'outfile' };
+
+    my %insn_details = %{ $params->{ 'details' } };
+    my @keys = @{ $params->{ 'keys' } };
+
+    open_asm($outfile);
+
+    # TODO better random number generator?
+    srand(0);
+
+    print STDOUT "Generating code using patterns: @keys...\n";
+    progress_start(78, $numinsns);
+
+    if (grep { defined($insn_details{$_}->{blocks}->{"memory"}) } @keys) {
+        write_memblock_setup();
+    }
+
+    # memblock setup doesn't clean its registers, so this must come afterwards.
+    write_random_register_data($fp_enabled, $fsr);
+
+    for my $i (1..$numinsns) {
+        my $insn_enc = $keys[int rand (@keys)];
+        gen_one_insn($insn_details{$insn_enc});
+        write_risuop($OP_COMPARE);
+        # Rewrite the registers periodically.
+        if ($periodic_reg_random && ($i % 100) == 0) {
+            write_random_register_data($fp_enabled, $fsr);
+        }
+        progress_update($i);
+    }
+    write_risuop($OP_TESTEND);
+    progress_end();
+
+    close_asm();
+    assemble_and_link($outfile, $params->{ 'cross_prefix' },
+                      $params->{ 'keep' }, "-Av9a");
+}
+
+1;
-- 
2.34.1


