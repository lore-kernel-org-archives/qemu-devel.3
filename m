Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C9FCD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmq-0001GD-QM; Tue, 26 May 2026 10:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmo-00013r-2y
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmm-0001T6-IK
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45ea19f412aso3138014f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805775; x=1780410575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mt2hX80wseQewY57S1j4Yf/t3dERnLFFl4xcPkBbimI=;
 b=Vx/LEy1bFAuX4Z9zBbb0gzSgHQzZN32LQeO2O2XEUHREjXm1863AjfwTZXvDttlOzy
 /1PPo2AfWAGVMgbAGbUtc1eddDHk/ss/eRBiwsjWunDq6cQVFqAWJe+lxAKOufkp/2cp
 tZIuTbOsRycKU55HVFoYk5g+kf5F2pYrjT7aElyHcwdFZf0QG7863UoGORds5Ga4aB5O
 y1WbrwkuU+L0RnCYV2scPqNOhR+gFcWrj7WvqQeDL586K32gvq/seWv8iC+qlzMpzGd/
 41dwCxYralWiKKfVu5fOjL8DG0TyG0ZTZsA2qsRqjvHJ25xtjWYn1ZUX9pHJ5QAfP0iQ
 7eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805775; x=1780410575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mt2hX80wseQewY57S1j4Yf/t3dERnLFFl4xcPkBbimI=;
 b=VHfJbUCrNqPSJABmObx/Rar5PUP/Fgc/qFmfVuH7O5E+Qe+tjf+ADejatFns6FYiS1
 38mcx4ZfX8tNdfMk7HTWg9FnaGRybRsmZYWEj2DyBgPYrOR3dGg5t/deZhubgDe3L7HE
 wG7lFy4tb5s9gvIA5cl1vfF8W2u4mmtdP6CcIErlDapOH5CjtnqNEk62jOWlrboNrNZ3
 B9mAIMDz71sSHJhsG5wQQJm0/vGf9jTwj/wVldNbXEKzDZ88tC9q2Nd5cqr0qR43iC/I
 RbKrcDw/y9lc0/2wKmpn6sZUu2nqIdpFt5l81w/8yeHGkfv8e1DSeU2goUl/SDzCC7hd
 Pxfw==
X-Gm-Message-State: AOJu0Ywyl9+RmqnIN37P1Kavkw1QH0GDA0s/qQF5nZL9AKcVrtuLBB/D
 Ss4DPwJjnQpsyXryZZSum4C4XiG7MM4xwyqASfDOTYEtA9aU7viMgOXh93n7BLsmZ3NKKUqZ1/v
 fcPyE
X-Gm-Gg: Acq92OHuPBYyHn7n2Dw+AUBz+AAEFvYLVFwuN7UHoyCJc+CzAYEl2si0XSu1LKjRMe5
 NZzgz9f+dLVqEuhV32rH6d1xCc/8/aGaZmq2qR43qbKRuqF617OaKDF5CLvX6Dju3VbTMOacKl8
 ceitsbhLIw9LXONfrMlj1lWJY1hTDxxbC4WoH0fKAXzL/2tGERdQo4i+mXlYvdbO6CMrIyGg4Ot
 lugSC23pC4iIJuFrKHelNNI7mVq+L3wYYKcMNQe+CnTluI0T4jg9fNLG3+UPdXWyR3oBXihgSwh
 Jp1E0rBQJ7KXWMPHySaVCjYF0j/kW1oFJJjEWVnXWR4klVmd2NQmyvIIEZCahbFONRlery+jRvE
 qn3j+R+ChbhphA8zQlBlEM3yW9EqSxM1+NBBs7ngwLnBj8VWMAnHH6i9C2O3u6/ZW/YrsKzNERy
 g5j13IBZhp18QSymGapzn8kJrG/Mz+D90Xz3Yz4Yvb+Yl4mZ6LvWYb12g731mCfDBTjRaEJiMlp
 x1YTRDaJFhFwMSSADeCBo8BETwE0DREvpSNHNaNPg==
X-Received: by 2002:a05:6000:4a05:b0:451:bee9:17c8 with SMTP id
 ffacd0b85a97d-45eb36b0275mr29355745f8f.6.1779805775192; 
 Tue, 26 May 2026 07:29:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/54] target/arm: Trap direct acceses to FPMR
Date: Tue, 26 May 2026 15:28:40 +0100
Message-ID: <20260526142850.2326589-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
Message-id: 20260522220306.235200-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d1a581acfd..41dd013784 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2899,6 +2899,10 @@ static void handle_sys(DisasContext *s, bool isread,
     }
 
     if (!skip_fp_access_checks) {
+        if ((ri->type & ARM_CP_FPMR) && s->fpmr_el != 0) {
+            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, s->fpmr_el);
+            return;
+        }
         if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
             return;
         } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
-- 
2.43.0


