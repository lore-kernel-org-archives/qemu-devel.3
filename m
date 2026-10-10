Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75620CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 07:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFRDc-0001lH-EF; Sat, 10 Oct 2026 03:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRDW-0001ch-Bd
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:10:03 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRDU-0001C9-HF
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:10:02 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48870973bddso221140f8f.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 00:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791616199; x=1792220999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ppmMYGWpy+qdHr4jHS5Z1zjFLfpOfn68XGnzECW55C8=;
 b=Ad/HBDynUgEVKOltzSh8B9LArRK4GJdkevntrf6rN0U+c25NPx/nxjVdeqGBGxbcYA
 tqTNuUXjd4mCG3UAKbEpOefSkcrsCo+RhqAlbxcrQLnI+cy+QyMWS/w1sAxTlt+/3ww8
 0w67LWFGcmKchcJbn8Phj3LzvTRarx3leW++/R+4fXiMxWNrCm06sWplFVD40548awKi
 c/JNTKNLrmfIrnLBjl43lbvbb9yD0ArGS68d+0/qb5NUYn/pHrkxUEiZ8hI9Y3anO6jA
 4DeL27pLHecOEDegbzbZKpN7RguGV7+uSInldZngaln3m/6ElRrSNg5LPVCMP6ph4k02
 1oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791616199; x=1792220999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ppmMYGWpy+qdHr4jHS5Z1zjFLfpOfn68XGnzECW55C8=;
 b=Ld4rs5R0x1ncqMMIbAvhFJ6gEtENDsn9qQDFKoIv3r/sAziJobJxRCR/UCCd21T5+i
 7Ylv59NRkjJF7XznKYed6B5qQXJRbIejkEF57Rt7NNr75SeXYvgXd0VeTxw+p3isW6Co
 9CdXL7OmwUYpN7GYYgzWSsy9Kktxv1ukAq9y8UEPnzL21a92Yyv2erSUGuov/XFtCgIc
 GeOr+hUVAWJkDXtOFZfilW/5y+XqW3xzIDiFRa9y+FIYelqBEB8Zh8MFgcCUkmSp2n1b
 v9hos2Gpov8u6EE98NAL9nnBoRFwrYEzDNGsj0mldmL+Yf0C0Dwme6Cmg4QhPNvxBqkI
 i2yw==
X-Gm-Message-State: AFq9FYI72xeYGqGzejju8hjLcRCbXkBWynuxrLG19UgkCU+/CiP/IxDW
 HoE+M+cOJfF++nI5H22EmIrzK0z7ld/Dr9jY01FBUh9NAeGI0aeWyEuR4Np5DXSTMNmneT3amg3
 4tyCujDQ=
X-Gm-Gg: AYBFou0qErf43KJqsB586HZLvGDkRPQSxrsj15HpuQ3CwVyZz1rKkxHZZI6QxOfm3HP
 geKBFuMu+MXiC2/u2TJsXGy+TWRHxBH0mlVnCv815G4/Rk4byEEBEHWG4Zc0nWTLBLKKfYJqccR
 X3it/2dnHbm5kAtdcezS4SFkfgnddXq3VcU/e3oYz0JYZ957zYxmETbgF7hefdX98x1YnDu89JB
 3K/2oBoEleLHWma0HqQYpIwVQtPSepSfdMQGsZd1ul+kvNQP9nK2a6A1yODlLSRRTitsHGIoZVa
 gb89rPoVK0HDpXK9ycN336DpvNP2v4IdTmqQglKtZBEG75TilwhEsUhGp09YQRrKfY2k6atemal
 qUoGEnnLBHZbiFhMenYtrlNHEnVuhBGNusk5Aytn2VVewJfYboI4yY9S4o4nWrm7dEIzCaWGKjN
 /qzpLHCmpy0bfGQepSXWqnXV65zuAB+f76HCEC7QLJHSjYqs/f+wKBr/XGOq6GlNPnn22d
X-Received: by 2002:a05:6000:46d3:b0:48c:4f4d:4d6a with SMTP id
 ffacd0b85a97d-48db94ab1d6mr5742527f8f.28.1791616198897; 
 Sat, 10 Oct 2026 00:09:58 -0700 (PDT)
Received: from stoup.local ([2a00:1e:e082:2901:a2d3:66fa:95e6:7d81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abda3csm7662252f8f.36.2026.10.10.00.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 00:09:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 4/6] target/arm: Implement SCR_EL3.TID3
Date: Sat, 10 Oct 2026 09:09:50 +0200
Message-ID: <20261010070952.323466-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010070952.323466-1-richard.henderson@linaro.org>
References: <20261010070952.323466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a49dbc5acf2..ae1b8a57617 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6078,8 +6078,21 @@ static CPAccessResult access_v7a_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
      * Any other registers in the TID3 trap space should use access_tid3(),
      * so that they trap on v8 and above, but not on v7.
      */
-    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3)) {
-        return CP_ACCESS_TRAP_EL2;
+    switch (arm_current_el(env)) {
+    case 1:
+        if (arm_hcr_el2_eff(env) & HCR_TID3) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        /* fall through */
+    case 2:
+        if (env->cp15.scr_el3 & SCR_TID3) {
+            return CP_ACCESS_TRAP_EL3;
+        }
+        break;
+    case 3:
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     return CP_ACCESS_OK;
-- 
2.53.0


