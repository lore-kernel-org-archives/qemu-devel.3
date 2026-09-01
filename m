Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D11EC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONO-00019c-Ui; Tue, 01 Sep 2026 09:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONM-00018O-Rz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:08 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONK-0007EF-PL
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:08 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so635838766b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268685; x=1788873485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NFFsSZY3pwWX8SiKmHRL6Osjy4jTCgN1nLcbeBKpLYk=;
 b=aSWo496hyB0bDZb22yI8VPpNh1jOEpNTIYQtLR+2rroik3d+HvXFKWWRM3iZoGQ8xf
 sCXU3TfDxQTfM76eeGSDTVJ13yKwvaC+Xi0dKoFUBGbzPEKBBZN/oJ3sdOOIHYbKweXL
 c2X6Kuj9qHxQ1Lc71deL7TsPbsHR4Au+mWzeIHeM853COVBZgKUh/frkhdYFu3rEtelA
 QMRLFQ4bjhDoCFo1XDjkonrH8dAX0JpQu9Brsq4NGmzxeB+WzLDPvxRyNEitGIZtuUA/
 /kPTOJkXL1HikEwJPqFQTPuAwnzxWBlqu4EPRYkXoD+sqV6oMSExPHm1D89j2CpuS+L6
 rPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268685; x=1788873485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NFFsSZY3pwWX8SiKmHRL6Osjy4jTCgN1nLcbeBKpLYk=;
 b=BduNBjihREywcOabg7Gf30YBR82SlAXgNdB14Fhk1pqG/XhrF/BvLQHRSH9RCnTWYG
 4cvEcqdb70cn8P7woIfM+u6+wDRcPpO/1D1AgR2cOir+BQoevhxXCzBzVpLVnnw/dXG+
 i+KE6BQpnU6TrUkBqWmQFJ3Cd2YIsfDUVTBM6sHWi+S8k9njuJ1ZtiI7Vfb34gVcUT4Q
 zILHAcRGDtaQf/iZaduDiwPaTukk0gmAk6JzF4pjlSsdWIg0bcjVnX0OqTRpfQVrPSl6
 cP5H4WIrHygIm4p1AUfBu9Zju29XIBg+vY8l9GgTLVq4PUKaNTAFbDvqDHk+Bt8xM12I
 20gA==
X-Gm-Message-State: AFuF++kVoF4Hix56XISeRFkFfO8fW32JknlXY50btoSZWxBK+6wdNnOX
 ybxNefy/vJsvR2smWAkks7CQac05EPiF1Ea593kQI8guL0Hfz47ZW2LI1V1rE+BtuDNY+5JJPxO
 YnzhBZQI=
X-Gm-Gg: AR+sD10AKLqEreUWlhfOQvC+mnGTfiRpxrkrWH1uRC4pjQj7kT/H/w3Cq0vSdIZi2rF
 L7uuqjCB51YPaRfH/F6DfKMRNVTNUjY/qWKPz7+QfN8zxF3TTPk1pXpk2LyZaBoSjqATQj6bbkV
 6O0usPmzkn7m7ehCHhPF+Vr301danA/d/x+xxZeP2yCz9FUtm9LC8ScQBc7gnNjZ1nzqIl9t20L
 c30Ksmm+KbEDM8f0PmXhn/g3XWybOcdszqRe1nYeNFalelKEl+pnH1C3in6kxfopJ5iPQxjQIOL
 6d6Ux1nkdgtUBh3xeU/OKFSY2d4p8hY/dHWXy/DyDVrYadTsjPSzCcQOiMOsFe9h5dXU3JzFW8d
 d6h6hYqKYigp5hz2rE2r9bCqfvZeVq9KZxjnRJwhc+c7B/S2pRb5a0djlq7TX72/rxyzv1PHAul
 KXL6fWGz+aa0VAS5w6n6lVaNqZ/cnNOA4LypFDKXoP0Uc0QmmooPHUxuCXD3S9/hkfd6EkHY3tw
 hBF9iu+cEsdMwUbMkeS0CsRPvAJR4I3Rz9QspP4iqzDZ1FiWts2tAChkI/Nerx4fMHJRw==
X-Received: by 2002:a17:906:f594:b0:c25:6210:84e5 with SMTP id
 a640c23a62f3a-c25b3ce0b0bmr572298966b.14.1788268685175; 
 Tue, 01 Sep 2026 06:18:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/58] target/arm: Implement FGWTE3 traps
Date: Tue,  1 Sep 2026 14:17:05 +0100
Message-ID: <20260901131732.2263947-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260806172709.333300-5-richard.henderson@linaro.org
[PMM: fixed comment indent]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/op_helper.c     | 40 +++++++++++++++++++++++-----------
 target/arm/tcg/translate-a64.c | 16 +++++++++++++-
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 857e897a48d..c2b09176cb1 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1061,13 +1061,15 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
      * Fine-grained traps also are lower priority than undef-to-EL1,
      * higher priority than trap-to-EL3, and we don't care about priority
      * order with other EL2 traps because the syndrome value is the same.
+     *
+     * FGWTE3 traps are exclusively traps to EL3 on registers that are
+     * only accessible to EL3, so there's no possibility of a trap to EL2.
+     * So we can handle these checks here too.
      */
-    if (arm_fgt_active(env, arm_current_el(env))) {
+    if (ri->fgt) {
         uint64_t trapword = 0;
         unsigned int idx = FIELD_EX32(ri->fgt, FGT, IDX);
         unsigned int bitpos = FIELD_EX32(ri->fgt, FGT, BITPOS);
-        bool rev = FIELD_EX32(ri->fgt, FGT, REV);
-        bool nxs = FIELD_EX32(ri->fgt, FGT, NXS);
         bool trapbit;
 
         if (ri->fgt & FGT_EXEC) {
@@ -1080,19 +1082,31 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
             assert(idx < ARRAY_SIZE(env->cp15.fgt_write));
             trapword = env->cp15.fgt_write[idx];
         }
+        trapbit = extract64(trapword, bitpos, 1);
 
-        if (nxs && (arm_hcrx_el2_eff(env) & HCRX_FGTNXS)) {
+        if ((ri->access & ~PL3_RW) == 0) {
             /*
-             * If HCRX_EL2.FGTnXS is 1 then the fine-grained trap for
-             * TLBI maintenance insns does *not* apply to the nXS variant.
+             * EL3 cpreg -- must be FGWTE3, and FGWTE3_EL3 can only be
+             * set from AArch64, and if the feature is enabled.
              */
-            trapbit = 0;
-        } else {
-            trapbit = extract64(trapword, bitpos, 1);
-        }
-        if (trapbit != rev) {
-            res = CP_ACCESS_TRAP_EL2;
-            goto fail;
+            if (trapbit) {
+                res = CP_ACCESS_TRAP_EL3;
+                goto fail;
+            }
+        } else if (arm_fgt_active(env, arm_current_el(env))) {
+            bool nxs = FIELD_EX32(ri->fgt, FGT, NXS);
+            bool rev = FIELD_EX32(ri->fgt, FGT, REV);
+            if (nxs && (arm_hcrx_el2_eff(env) & HCRX_FGTNXS)) {
+                /*
+                 * If HCRX_EL2.FGTnXS is 1 then the fine-grained trap for
+                 * TLBI maintenance insns does *not* apply to the nXS variant.
+                 */
+                trapbit = 0;
+            }
+            if (trapbit != rev) {
+                res = CP_ACCESS_TRAP_EL2;
+                goto fail;
+            }
         }
     }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4f9a93950b1..c60f4c4103d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2886,6 +2886,7 @@ static void handle_sys(DisasContext *s, bool isread,
 {
     uint32_t key = ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2);
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
+    bool need_helper = false;
     bool need_exit_tb = false;
     bool nv_trap_to_el2 = false;
     bool nv_redirect_reg = false;
@@ -2999,7 +3000,20 @@ static void handle_sys(DisasContext *s, bool isread,
         ri = redirect_cpreg(s, key, isread);
     }
 
-    if (ri->accessfn || (ri->fgt && s->fgt_active)) {
+    if (ri->accessfn) {
+        need_helper = true;
+    } else if (ri->fgt) {
+        /*
+         * EL3-only access means this must be an FGWTE3 trap (which are
+         * always active); otherwise it's an FGT trap to EL2.
+         */
+        if ((ri->access & ~PL3_RW) == 0) {
+            need_helper = dc_isar_feature(aa64_fgwte3, s);
+        } else {
+            need_helper = s->fgt_active;
+        }
+    }
+    if (need_helper) {
         /* Emit code to perform further access permissions checks at
          * runtime; this may result in an exception.
          */
-- 
2.43.0


