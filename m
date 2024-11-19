Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EAAD44161
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8f-0005vP-Uc; Tue, 19 Nov 2024 09:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8c-0005ss-Dr
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:30 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8a-0006DC-Gc
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:30 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so28516945e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026207; x=1732631007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BhPiVkPcywCEaevmfBnlQ6/FILPwbJv9lkpBnJtBRkM=;
 b=ZkM6ivYJnDepwEJLak7hjRlLGM7ObDNwhFSnU4iTHpmyF+KYtpFMcAI582JqGqXlnj
 4CXbPaLKdpOoY5FbAHMLlb1NIZgfbXDMrH6xmkqVRNj19UvpAfU2itHYGFgz8pv/dNF1
 WLVv0RJbLu0G/SAVbkO2G2GKKyt+cGkmk/2lJA65abKNKV6hHdB2Cnc91nBV7p5oCW2c
 sNjPwlA/1PXYc/DWNT9kjwuhY9x8mmmG2JJhqHQpCtORgDsJlaFcEilprsFkYV+9A6Us
 gRe0WrsfrF2FgnlSJgLu4cL54QywFvCIshGdplW44Eg8r+BUQjzYXfC1GA5uyTfPhcfQ
 MkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026207; x=1732631007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhPiVkPcywCEaevmfBnlQ6/FILPwbJv9lkpBnJtBRkM=;
 b=KCzCKx4sAFBumxrcjLzVrGuS1nUfQ2remxAGvNiXVbKq+Unilx/CEZpic/wLKTS2A2
 bI1A4O1Eyfk3BVKRqwMcIe2POrejqzL+PcP8Z5zdCoxMv58MnWkLkK39FExS1cNquU0h
 5FmGIpCBxijImZLPJjO5o2/Sl52WBp8p2NNfUW8JXqgFg7wpqetACCJah5iADgehkrK8
 j7vrkzgWz0RuLf60GUVHaEn6nOoSfV/8Hx7oYAs/lf+FRLTS5V01C9d4ObkZvIjY6vwn
 upc7bGNgKAH4xbkGnpsmr4ss1ZO5bFypkkXnjJxXEfLjvf12yBUqEOLoa/Z18UfFPbnf
 /qbQ==
X-Gm-Message-State: AOJu0YxJrdgaua0WTvHQf6AXZDOyOIl+NSRSxjB1XpAeB2TEtaLSaSo6
 Dx8dR2vWMmLRVRXIWx50KP0B8bak4mXa0AOnyCTxwJX31hUUUwvR4n7MpvWKzvbXHWrfWYYw4vJ
 Q
X-Google-Smtp-Source: AGHT+IHMCqTS8xOnUnC8urUDCN0dQVgtvcTj+i0FaFOPpLyDrJFmq68hpgS/YVyNSngsJ5I4Qa2TSg==
X-Received: by 2002:a05:600c:a06:b0:431:44fe:fd9a with SMTP id
 5b1f17b1804b1-432df74ebdcmr139355295e9.19.1732026206986; 
 Tue, 19 Nov 2024 06:23:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/15] arm/ptw: Make get_S1prot accept decoded AP
Date: Tue, 19 Nov 2024 14:23:14 +0000
Message-Id: <20241119142321.1853732-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Pavel Skripkin <paskripkin@gmail.com>

AP in armv7 short descriptor mode has 3 bits and also domain, which
makes it incompatible with other arm schemas.

To make it possible to share get_S1prot between armv8, armv7 long
format, armv7 short format and armv6 it's easier to make caller
decode AP.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Message-id: 20241118152526.45185-1-paskripkin@gmail.com
[PMM: fixed checkpatch nit]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 98499495085..b132910c401 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1357,25 +1357,24 @@ static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
  * @env:     CPUARMState
  * @mmu_idx: MMU index indicating required translation regime
  * @is_aa64: TRUE if AArch64
- * @ap:      The 2-bit simple AP (AP[2:1])
+ * @user_rw: Translated AP for user access
+ * @prot_rw: Translated AP for privileged access
  * @xn:      XN (execute-never) bit
  * @pxn:     PXN (privileged execute-never) bit
  * @in_pa:   The original input pa space
  * @out_pa:  The output pa space, modified by NSTable, NS, and NSE
  */
 static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
-                      int ap, int xn, int pxn,
+                      int user_rw, int prot_rw, int xn, int pxn,
                       ARMSecuritySpace in_pa, ARMSecuritySpace out_pa)
 {
     ARMCPU *cpu = env_archcpu(env);
     bool is_user = regime_is_user(env, mmu_idx);
-    int prot_rw, user_rw;
     bool have_wxn;
     int wxn = 0;
 
     assert(!regime_is_stage2(mmu_idx));
 
-    user_rw = simple_ap_to_rw_prot_is_user(ap, true);
     if (is_user) {
         prot_rw = user_rw;
     } else {
@@ -1393,8 +1392,6 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
                    regime_is_pan(env, mmu_idx) &&
                    (regime_sctlr(env, mmu_idx) & SCTLR_EPAN) && !xn) {
             prot_rw = 0;
-        } else {
-            prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
         }
     }
 
@@ -2044,6 +2041,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         int nse, ns = extract32(attrs, 5, 1);
         uint8_t attrindx;
         uint64_t mair;
+        int user_rw, prot_rw;
 
         switch (out_space) {
         case ARMSS_Root:
@@ -2110,12 +2108,15 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
             xn = 0;
             ap &= ~1;
         }
+
+        user_rw = simple_ap_to_rw_prot_is_user(ap, true);
+        prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
         /*
          * Note that we modified ptw->in_space earlier for NSTable, but
          * result->f.attrs retains a copy of the original security space.
          */
-        result->f.prot = get_S1prot(env, mmu_idx, aarch64, ap, xn, pxn,
-                                    result->f.attrs.space, out_space);
+        result->f.prot = get_S1prot(env, mmu_idx, aarch64, user_rw, prot_rw,
+                                    xn, pxn, result->f.attrs.space, out_space);
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
-- 
2.34.1


