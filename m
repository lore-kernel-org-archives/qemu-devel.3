Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADB6C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ldX-0004YP-2m; Wed, 16 Sep 2026 05:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6ldP-00043T-7L; Wed, 16 Sep 2026 05:08:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6ldN-0007Rf-E1; Wed, 16 Sep 2026 05:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549560; bh=3X5KhR9unJ3pxNlBAJ3w+vwmMTfnndNh7QH1A19Hzkc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jSkcL/g56L0poXiZ5rA2SrO+9vtcAbuRpBfP93uQ3LdSDEqgbI/bt+iyMyWMlWE+A
 9LReGUUXhq0eTLKmQWNTVSqencYXt18atZ+d3U5DiZObT0JRiCwt2lRo3/m2QTbZqV
 5WPbRVh2tk22F1jyqZOU3CUtliFGqaxvacUePbizklK1j4F2C1ggMwDU0pAu0XCb1t
 c6OBmseGkGFj5u4lz8F5yptCLPBgtiov6XAiX4tXAnX8LtaLCmblOfDB0uw7lsFjZi
 rRZiJ7YJuISUZmlHFusIpvqvYq0Rj7lfF41pfGfQp1PmaCAsMIbjK34ROVaHzuYb0k
 siaeX1ak1rd4Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ECB4A1D56D3;
 Wed, 16 Sep 2026 12:06:00 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 98918429E1D;
 Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 822C85A795; Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 30/57] target/arm: Make Thumb T1 hint space UNDEF
 before v6T2
Date: Wed, 16 Sep 2026 12:03:54 +0300
Message-ID: <20260916090516.677749-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

The "hint space" is a region of the encoding space which is defined
to NOP if not specified as an architected instruction, so that future
instructions can be added there which fall back to NOPs on older
CPUs.  In the A32 encoding, this hint space was carved out of the MSR
(imm) insn by using the fact that a field_mask (bits [19:15]) of
0b0000 meant that an MSR (imm) would set no parts of the CPSR from
the immediate, so it was always NOP on existing CPUs.

For the T1 encoding, the hint space is in a range that used to UNDEF
in Armv5, and so the hint insns and the NOP region must all UNDEF
before v6T2.  Rather than putting this check in the trans functions
for each hint insn and for the NOP space (which is a lot of places,
and awkward since those trans functions are often shared with the A64
and A32 encodings), put in a decode line that covers the whole space
which we check before any of the hints and which will explicitly
UNDEF if necessary.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4208
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260821132550.168896-4-peter.maydell@linaro.org
(cherry picked from commit 2931a675e9d3fcddedf673509fe9759955fc616d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
index 778fbf16275..70b7608d2ce 100644
--- a/target/arm/tcg/t16.decode
+++ b/target/arm/tcg/t16.decode
@@ -224,6 +224,9 @@ REVSH           1011 1010 11 ... ...            @rdm
 
 {
   {
+    # Before v6T2 this was not NOP space and must UNDEF
+    MAYBE_UNDEF_T1_HINT 1011 1111 ---- 0000
+
     YIELD       1011 1111 0001 0000
     WFE         1011 1111 0010 0000
     WFI         1011 1111 0011 0000
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index b480f6f65ea..2df91c4818b 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3310,6 +3310,24 @@ static bool trans_NOP(DisasContext *s, arg_NOP *a)
     return true;
 }
 
+static bool trans_MAYBE_UNDEF_T1_HINT(DisasContext *s,
+                                      arg_MAYBE_UNDEF_T1_HINT *a)
+{
+    /*
+     * The Thumb T1 encoding hint space was only defined starting
+     * in v6T2 for A-profile. For M-profile it always exists, even
+     * in v6M.
+     */
+    if (arm_dc_feature(s, ARM_FEATURE_M) ||
+        arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
+        /* Allow decode to fall through to the hint insns and NOP space */
+        return false;
+    }
+    /* On the earlier cores, we must UNDEF */
+    unallocated_encoding(s);
+    return true;
+}
+
 static bool trans_MSR_imm(DisasContext *s, arg_MSR_imm *a)
 {
     uint32_t val = ror32(a->imm, a->rot * 2);
-- 
2.47.3


