Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A27C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8l9-0002YA-79; Fri, 25 Sep 2026 12:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8kx-0002TA-TQ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:26:39 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8kw-0001DW-B6
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:26:39 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747eefae4so2858155ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790353597; x=1790958397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r4XNC98Xo1b/yOhFGm0q8l++OLD16zW3At5CR/WR9jQ=;
 b=ZW7OxGa9HKQObF9nF1t/QICDJ112vD0KwOVcQeboj3Wq4Qe7M/d56xlSW9jHEvMhQ/
 5MaNP2CQT8kdVEUJTUeHRADkI8/b4uWWvPNdeB55hWjp7P9AHs80WE/NeQWY2UzPLgxb
 ezaJqKkG9EzVbHxJ+a7s2HrzVmz0ldaM9R1LRUmMbVcgl1TuNVdH3Ay2yN3QEmwhWu1M
 3CB9vWBRYaXozXa8uGgWRG4nYhe7dOzeDxQKEN/TlVZSBeAcrcw0JhuNOgLqXZ1fWXrb
 rrO+YfJHolVUnPvtZ0WZBTy2UEP2kV2N6TXAtPTpo08SCG9o/hcuWfFPC7izmTXHD7hX
 dPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790353597; x=1790958397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r4XNC98Xo1b/yOhFGm0q8l++OLD16zW3At5CR/WR9jQ=;
 b=j//9ASgTEukr1LB8ImUR2UMBt0mWL1mhZPMZ99e3ABokZ8Vof5S/3qJsYBxdrj+kbv
 SlxObLffaNPzPeO4/Y9f9s5P6kOkfcXvPYaFhpLkNcmo2ccrJvI502b7jafll8vaqHEh
 hD8Ncuff33+grq/TXnNedFCm+lCRCctGFyIvI0QDWy009ayoEiK8UZnHjUdIPNwTIpM5
 Ry2GOTdypP9Gfh7gDX0Ea3fIz0+FedLvq92FOV3xqNQ9i+mwX959XHMiZwpSS6WrLcCg
 aI4N85PTa5b0Yf2Ajm4AHPcqEditqH6EHIAJld3w+jWMUwt2AY+2tlpeLPwQUDgN8x13
 +IEw==
X-Gm-Message-State: AFuF++kP4Wt2o5We0U87AC2l+AAFdCr5LEVK//7JeO8ZFQhuX7Puf7P1
 EGOljtTTIYEYHkPgofxvpQYfhi0EfESd9WZ9r02ZDE6oMbvFsNmW9rFPT5H7Y32ijGg/OVicK9p
 75+ge
X-Gm-Gg: AYBFou32JRKDe2aW3uJwXXj/mXSqIMvEMUq6slz2yiaCMrlcR8g4gQgLWyM7wdyd+v+
 F1sY86ltgpnkNw2F+sTBW9i29mGfCoqtMx93aEua6FlJHKZ+oHcgdwbWGYU3lsL4GlqNMpOSdEJ
 GRCBDc7q9xXsEcbqrGK0fijhEHJNgcSgdZ3UFjhrrnKOhyC1NqC4YqXSihmOJdjwTzxZmFVWXur
 +v4u1810GCR2m2H8oKjm58bcyoft0PLr3g/5O5PmNe2GHIjsMEkeXDUQtre9S4KmMGBDe3Gt/c+
 BVfn7dwzyhPBe74FhCP94+zllUVpwdW46JI0K2rT+HJGASwbcCywDUgpt0ZJEnMt5DBlgQ+L0UX
 uJjKQFsz9wYqofxtI7Ze9CgMJXkx8+I9wp3AQ+3BiJFItL7k1V1phTL6TN0xLVDZ80vSvqfcEuu
 c1hxlJx3iMtwDIpqo4I0e8k/1/x24UjFsdL9FfToGbLi7u5Sz0ruHxh3KzLu+naPTaN0jbmSrg8
 ub9lWjMHuWs3vbtZ2sz9/Tyo6gFsg==
X-Received: by 2002:a17:90b:2809:b0:39e:4c7e:bc3 with SMTP id
 98e67ed59e1d1-3a0986a46b9mr4042084a91.17.1790353596802; 
 Fri, 25 Sep 2026 09:26:36 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976cacbesm11464809a91.13.2026.09.25.09.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:26:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 4/5] target/arm: Implement SCR_EL3.TID5
Date: Fri, 25 Sep 2026 09:26:31 -0700
Message-ID: <20260925162632.404001-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925162632.404001-1-richard.henderson@linaro.org>
References: <20260925162632.404001-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6416c402ac0..a149f492f8c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5548,8 +5548,21 @@ static const ARMCPRegInfo dcpodp_reg[] = {
 static CPAccessResult access_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
                                   bool isread)
 {
-    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID5)) {
-        return CP_ACCESS_TRAP_EL2;
+    switch (arm_current_el(env)) {
+    case 1:
+        if (arm_hcr_el2_eff(env) & HCR_TID5) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        /* fall through */
+    case 2:
+        if (env->cp15.scr_el3 & SCR_TID5) {
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


