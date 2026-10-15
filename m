Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48850C2D0A6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtL-0003pP-VH; Thu, 15 Oct 2026 14:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtH-0003nU-KP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:19 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtF-00011d-U4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:19 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48c6955a7c3so1658233f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087756; x=1792692556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6RfD7QaogbN7wbHzQt8R/cTi4riXyz7aFoG02Ip6eyI=;
 b=GT0yQQ1VbL9UK/Z+viYytzlR6x8N4JSBlx0Yslj/JyYblsOYUVYKB3YT3NivV5Y52y
 YLeP8AOCWBXOCoXWNCa985VZeb7Fn+Pwy4RwD6yDxBKQ5TOJ6fyRqQTfaTfDrqXvbmq7
 dOCxr3uGVEX4I8rpAbwUMtxE50gSdv5OApYpy56sZCgF2a+Lc/VXtQTuAVskJKeAslZS
 +4/DLylCCTlRJfvSRIgxwxajdQ3s9xF8VpOooYiyPEpCLK3C8b8JrTfwiNve8pn3jfBC
 NnW1IirrC5kQuoe8hM0/fzMyGp5Xhr/3eu+IHJo6sAY8J/HQtCOlhvsiyuEfSxiR/sc5
 umrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087756; x=1792692556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6RfD7QaogbN7wbHzQt8R/cTi4riXyz7aFoG02Ip6eyI=;
 b=dlCwiLBekajOf9FcX5n5SmGNhwMzat9juUv+ewUHeQJXyeDk9+9YqP6fRxPd2Pt+YK
 Hm/D0KFD8zPQxaf9Djb6+/xgZAAArWOuRCYArP7EmpBFZC2GDZOpLQ6iWr9fDZsIAqeO
 tkmStG1PVjurar4RbDUjV34GxQdleHOkse9yhA+MwTN8u/Wh24fojPoI5hAR4u2FdVzT
 m1cXVDB+/1uluy9mMvyyjIdcNCCHZZihDFh9juKrBgOO3f+qMWtio5g5/SVrDIf2WPDK
 p0a8vvPh+evPj+0TPwyL9r4kTjVe0JdCBeouoYu6J/bBCtjHgMEfNEjWioEF7hh99Tyu
 DP5w==
X-Gm-Message-State: AFq9FYILUQWndCGF0+Kziio5tLOHUZK0Fde33AMz5M8A7ymvUC0ComiV
 E18mU0BrQOQv+4bLdEcmdGUdJVlZJnCyDh/76r5ZXrf9Np4GUre38DrCh/8PNgxxN9FxyXQ8hCX
 RJljNHLc=
X-Gm-Gg: AYBFou0sDQOvrkZVjcmusuBqfc4CURgYF7xQj8fc+rBfITwvhzKoCCzZG8JMbYQFZTB
 d3m2tlSHUOKdUMrpOkD0VREXv4/zLdiinDBQmNFeyiHsyE31J/7ZQO5WCWgS9uWRxaJs4kAFBXf
 7rd9aPsoZz05VOQF3AJUxdAaKr51rJ5mCHSd2g67hHW7LJSo1J6EiH4akZuscCbG6jDsWf9/UTO
 pBp+RyQwybTU3pjYOOva1rMTF9x9DPbjHweqgVz6hSUWVTnf9EecueIWpbEUfuWJJYfEipMvRLJ
 NsR2SoTsK0cTbiHC18KActYfrJU38CrZ26ZRkLZeEhJVpDWx2X/3JbS4TDcngMDuholqaKsZicg
 Db0lBYwbbu5Vz5XT5+tcEMRK99hc4x9KVR16lF7OGj7niUOO78bbmSTytz69w9GIBJziXyjRzFu
 F6CzYQT3M2/oprDq+XRMY1TVAL16IMPxHXFhuzXhGXMLQYFM+yDx9zIDD/U2M/nma0jj790i/el
 V5qZz+U5L0gjQgN7CbDD+mVqu04jYExL/q2JUDRAX3rdgyCUsVv3cXLW2e62OH2VxLtbMIlZQ/M
 XNfY
X-Received: by 2002:a05:6000:480a:b0:48d:eb44:650c with SMTP id
 ffacd0b85a97d-48deb44661cmr10876869f8f.40.1792087755999; 
 Thu, 15 Oct 2026 11:09:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/16] target/arm: Implement SCR_EL3.TID3
Date: Thu, 15 Oct 2026 19:08:54 +0100
Message-ID: <20261015180858.1863407-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261010070952.323466-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7974c46000b..78da51996e8 100644
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
2.43.0


