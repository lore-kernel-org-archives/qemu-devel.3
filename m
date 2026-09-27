Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBB6C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmTi-0004xh-Qm; Sun, 27 Sep 2026 06:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTO-0004Dq-V5; Sun, 27 Sep 2026 06:51:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmTM-0001Pb-C3; Sun, 27 Sep 2026 06:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506136; bh=UD2DCKk5RC2siDEc5hx6BoL7q3x6dJh+kzjciSjalyk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AZuEetGhepatxfYWWvfNDysnSOhzwMh7pFn0bjcqgwlcxA8gWrrwjVBXjEYz5TjD1
 gYIzkd+zrjvDLJveoTaxG4AwMNsmCwAJn3suQfetNtQlctx0tbyIwRUaXYSZZqIL4U
 nEOXCzATPC1RieXgB2XdpHCdoWofcRm51Z+2tzIvSzOd7HJHCAdWBsXtiKeS8jHEg+
 XiU0ojWoFGrtYCAcsXD6UwXSfnRQUeqKR+9RdsBtHVyxSVOX+xBBBYtRBrsBwEKSDn
 l/RzIrxTTSNc+XV2eN4MpggNHStapzdUfPPQUyYMlQSbVRDnazt8KCW20YtDeMf22M
 qYdd6pKTwIcLw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4FAFC1D8B73;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 42AD243217A;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0438D5E79E; Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Simon Scherer <scherer.simon89@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 84/92] target/i386: Update FPU tag word for
 FXTRACT's old ST(0)
Date: Sun, 27 Sep 2026 13:48:00 +0300
Message-ID: <20260927104821.196183-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Simon Scherer <scherer.simon89@gmail.com>

FXTRACT writes two registers: the old ST(0) gets the exponent (it
becomes ST(1) after the push), and the new ST(0) gets the
significand. Both should end up marked valid in the FPU tag word.

helper_fxtract() only marks the new one valid, via fpush(). The old
ST(0) just keeps whatever tag it had before the instruction, even
though it was just written with the exponent. So if it happened to
be tagged empty beforehand, it is still (wrongly) tagged empty
afterwards.

Add a fpush_fxtract() helper that does the usual fpush() and also
marks the old ST(0) (now ST(1)) valid, and use it in place of plain
fpush() at all previous call sites in helper_fxtract().

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4395
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260901085839.138094-1-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 994fb6c218f8c8f2be3fc9fab75a41d15b859fdc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 32af8b79f4f..829b2c80dbc 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1808,6 +1808,13 @@ void helper_fpatan(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
+/* fpush() only validates the new top. FXTRACT also needs ST(1) validated. */
+static inline void fpush_fxtract(CPUX86State *env)
+{
+    fpush(env);
+    env->fptags[(env->fpstt + 1) & 7] = 0;
+}
+
 void helper_fxtract(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
@@ -1819,22 +1826,22 @@ void helper_fxtract(CPUX86State *env)
         /* Easy way to generate -inf and raising division by 0 exception */
         ST0 = floatx80_div(floatx80_chs(floatx80_one), floatx80_zero,
                            &env->fp_status);
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = temp.d;
     } else if (floatx80_invalid_encoding(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST0 = floatx80_default_nan(&env->fp_status);
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = ST1;
     } else if (floatx80_is_any_nan(ST0)) {
         if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
             float_raise(float_flag_invalid, &env->fp_status);
             ST0 = floatx80_silence_nan(ST0, &env->fp_status);
         }
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = ST1;
     } else if (floatx80_is_infinity(ST0, &env->fp_status)) {
-        fpush(env);
+        fpush_fxtract(env);
         ST0 = ST1;
         ST1 = floatx80_default_inf(0, &env->fp_status);
     } else {
@@ -1850,7 +1857,7 @@ void helper_fxtract(CPUX86State *env)
         }
         /* DP exponent bias */
         ST0 = int32_to_floatx80(expdif, &env->fp_status);
-        fpush(env);
+        fpush_fxtract(env);
         BIASEXPONENT(temp);
         ST0 = temp.d;
     }
-- 
2.47.3


