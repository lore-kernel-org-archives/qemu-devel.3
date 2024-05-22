Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED799C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 21:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9tV3-0004hi-EJ; Wed, 22 May 2024 17:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9tV2-0004gq-11
 for qemu-devel@nongnu.org; Wed, 22 May 2024 17:27:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9tUy-0002e5-1i
 for qemu-devel@nongnu.org; Wed, 22 May 2024 17:27:51 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ed41eb3382so13238165ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716413266; x=1717018066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ydyk0mcmL3rzafaipDSsdJMeA909aHuKPER+gpdcFBk=;
 b=hZXvGnPc+OWOY5shglTZ2XdjlOqWDg95WuETZFKoVTqpehvwwPm6fkLLQzaTDKTv0w
 1a88icXm8bmHz+8Y/BS5g77T48SgHFT/kR8KKHguKVG0naRULvIyqV7dBHb1tfmvQTDb
 gvqlyViq49I0oWkGcFMRSQm6eTv5CdxoHsm1cYAdehtII0zvCPF6tVLHoI59D0OLYHJ/
 hy2vh4oucJfFn14iZfPPPjdCC7CFHrBMUT/bJSrtR6Aso/bzbnHJYLalJk/Gni79kJg3
 LJ3nF+B4Ynkzc/ZQWwRreb2fRTkMYKoUdAB4KXGwwk6wniMDKoEHXP159hU2dnLoRbXR
 0CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716413266; x=1717018066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ydyk0mcmL3rzafaipDSsdJMeA909aHuKPER+gpdcFBk=;
 b=kDy3A8EWyafMUK/CQcqdc4enzE/l5aKIk+gJIbHXEzCrW84UIF++QjBbzNNfyZmzQG
 cwpCMS0P4q1XjtwLalJaJihQR4gB5YT3eh08ZxumKZh/UAPiVVzchdRjm62VmeaRxSNa
 3Se2392MhbH/Uyh3l0undvXJz9PQOde36M5RqwSSK0UdQONdfzcG2AFeRQ83pLVBb7eQ
 KW76/YjNYrCrfKT5Omu1XKHO/rhy+OZRtRVwqCCKcC8cCF0H7Ah6mtinCEwjRKxTk4/N
 J5MT/KyP4Pc6wh/9f4qAW6v6GxXSHolpy19PTATTyY2wOr9HcZ74JWObwRENSoel4gtL
 Febg==
X-Gm-Message-State: AOJu0YxPUcBiOqdvj9AFelYotK8xDOzLG9gWVJZqs6xdiwepRnjU+nBb
 lyAxZC5NPXBVNs1LRLyc5agMHLiA8mHG8dnRJeZgIRMLf3mfi7RLb5HoLPhXMhVYSj71lFtjQ0R
 6
X-Google-Smtp-Source: AGHT+IFIKJ5qdBHnfV1Ss7ckz/MtLeNTsFDo6PDnjyfHN8YPOdBcV0TTMu829jImAraImxlb5L+njA==
X-Received: by 2002:a17:902:d54b:b0:1f3:2d65:5698 with SMTP id
 d9443c01a7336-1f32d655911mr21352585ad.22.1716413265652; 
 Wed, 22 May 2024 14:27:45 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fc06586asm64621705ad.201.2024.05.22.14.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 14:27:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH RISU 3/4] risugen/arm: Switch to thumb mode only once
Date: Wed, 22 May 2024 14:27:40 -0700
Message-Id: <20240522212741.297734-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522212741.297734-1-richard.henderson@linaro.org>
References: <20240522212741.297734-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

With thumb2 we can avoid jumping back and forth
between arm and thumb modes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risugen_arm.pm | 85 +++++++++++++-------------------------------------
 1 file changed, 21 insertions(+), 64 deletions(-)

diff --git a/risugen_arm.pm b/risugen_arm.pm
index c7ca62b..582bade 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -26,19 +26,8 @@ require Exporter;
 our @ISA    = qw(Exporter);
 our @EXPORT = qw(write_test_code);
 
-# Note that we always start in ARM mode even if the C code was compiled for
-# thumb because we are called by branch to a lsbit-clear pointer.
-# is_thumb tracks the mode we're actually currently in (ie should we emit
-# an arm or thumb insn?); test_thumb tells us which mode we need to switch
-# to to emit the insns under test.
-# Use .mode aarch64 to start in Aarch64 mode.
-
 my $is_aarch64 = 0; # are we in aarch64 mode?
-# For aarch64 it only makes sense to put the mode directive at the
-# beginning, and there is no switching away from aarch64 to arm/thumb.
-
-my $is_thumb = 0;   # are we currently in Thumb mode?
-my $test_thumb = 0; # should test code be Thumb mode?
+my $is_thumb = 0;   # are we in Thumb mode?
 
 # Maximum alignment restriction permitted for a memory op.
 my $MAXALIGN = 64;
@@ -134,46 +123,6 @@ sub write_data32($)
     printf "\t.word\t%#08x\n", $data;
 }
 
-sub write_switch_to_thumb()
-{
-    # Switch to thumb if we're not already there
-    if (!$is_thumb) {
-        # Note that we have to clean up R0 afterwards so it isn't
-        # tainted with a value which depends on PC.
-        printf "\tadd\tr0, pc, #1\n";
-        printf "\tbx\tr0\n";
-        printf ".thumb\n";
-        printf "\teors\tr0, r0\n";
-        $is_thumb = 1;
-    }
-}
-
-sub write_switch_to_arm()
-{
-    # Switch to ARM mode if we are in thumb mode
-    if ($is_thumb) {
-        printf "\t.balign\t4\n";
-        printf "\tbx\tpc\n";
-        printf "\tnop\n";
-        printf ".arm\n";
-        $is_thumb = 0;
-    }
-}
-
-sub write_switch_to_test_mode()
-{
-    # Switch to whichever mode we need for test code
-    if ($is_aarch64) {
-        return; # nothing to do
-    }
-
-    if ($test_thumb) {
-        write_switch_to_thumb();
-    } else {
-        write_switch_to_arm();
-    }
-}
-
 sub write_add_rri($$$)
 {
     my ($rd, $rn, $i) = @_;
@@ -345,7 +294,14 @@ sub write_random_arm_regdata($)
 {
     my ($fp_enabled) = @_;
     my $vfp = $fp_enabled ? 2 : 0; # 0 : no vfp, 1 : vfpd16, 2 : vfpd32
-    write_switch_to_arm();
+
+    # clear the flags (NZCVQ and GE)
+    if ($is_thumb) {
+        printf "\tmovw\tr0, #0\n";
+        printf "\tmsr\tAPSR_nzcvqg, r0\n";
+    } else {
+        printf "\tmsr\tAPSR_nzcvqg, #0\n";
+    }
 
     # initialise all registers
     printf "\tadr\tr0, 0f\n";
@@ -370,9 +326,6 @@ sub write_random_arm_regdata($)
         printf "\tvldmia\tr0!, {d16-d31}\n";
     }
     printf "\tldmia\tr0, {r0-r12,r14}\n";
-
-    # clear the flags (NZCVQ and GE)
-    printf "\tmsr\tAPSR_nzcvqg, #0\n";
 }
 
 sub write_random_aarch64_regdata($$)
@@ -447,7 +400,6 @@ sub write_memblock_setup()
     # Write code which sets up the memory block for loads and stores.
     # We set r0 to point to a block of 8K length
     # of random data, aligned to the maximum desired alignment.
-    write_switch_to_arm();
 
     printf "\tadr\t%s, 2f\n", xr(0);
     if ($is_aarch64) {
@@ -475,7 +427,6 @@ sub write_memblock_setup()
 sub write_set_fpscr_arm($)
 {
     my ($fpscr) = @_;
-    write_switch_to_arm();
     write_mov_ri(0, $fpscr);
     printf "\tvmsr\tfpscr, r0\n";
 }
@@ -824,13 +775,13 @@ sub write_test_code($$$$$$$$)
     my $subarch = $params->{ 'subarch' };
 
     if ($subarch && $subarch eq 'aarch64') {
-        $test_thumb = 0;
+        $is_thumb = 0;
         $is_aarch64 = 1;
     } elsif ($subarch && $subarch eq 'thumb') {
-        $test_thumb = 1;
+        $is_thumb = 1;
         $is_aarch64 = 0;
     } else {
-        $test_thumb = 0;
+        $is_thumb = 0;
         $is_aarch64 = 0;
     }
 
@@ -849,9 +800,17 @@ sub write_test_code($$$$$$$$)
     printf "\t.text\n";
     if (!$is_aarch64) {
 	printf "\t.syntax unified\n";
-        printf "\t.arm\n";
         printf "\t.arch armv7-a\n";
         printf "\t.fpu neon\n" if ($fp_enabled);
+
+        # We always start in ARM mode even if the C code was compiled for
+        # thumb because we are called by branch to a lsbit-clear pointer.
+        printf ".arm\n";
+        if ($is_thumb) {
+            printf "\tadd\tr0, pc, #1\n";
+            printf "\tbx\tr0\n";
+            printf ".thumb\n";
+        }
     }
 
     # convert from probability that insn will be conditional to
@@ -873,7 +832,6 @@ sub write_test_code($$$$$$$$)
     }
     # memblock setup doesn't clean its registers, so this must come afterwards.
     write_random_register_data($fp_enabled, $sve_enabled);
-    write_switch_to_test_mode();
 
     for my $i (1..$numinsns) {
         my $insn_enc = $keys[int rand (@keys)];
@@ -885,7 +843,6 @@ sub write_test_code($$$$$$$$)
         # for the VFP registers to decay to NaNs and zeroes.
         if (($i % 100) == 0) {
             write_random_register_data($fp_enabled, $sve_enabled);
-            write_switch_to_test_mode();
         }
         progress_update($i);
     }
-- 
2.34.1


