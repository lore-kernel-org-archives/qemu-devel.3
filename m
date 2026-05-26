Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5600CD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmo-00013v-5O; Tue, 26 May 2026 10:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmm-00010B-3C
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:36 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmk-0001QL-L3
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-459bf19e87bso6314277f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805773; x=1780410573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dekYF9pPrnIVrcP0IqaeXaJtDkemEhBeBmy30K13ZaQ=;
 b=KStNzm6+qQSw/J866c8f0rLm7bhxY8dfEJGchVxJLU/OxLR+8WLbZ+1u6aFnz50/9e
 72r6Sy2ZFiIIJckq03tfTefd6jYiNbYyTwWyEdlyJ4BTKgrOWtwcfqlQiRyZq1pvN51o
 RzW5Aref8LV0/P6YSVpxecOEq2BBpqLcbhm4YQMzKFr/Hq1sbvmjsd6hDYqc6TTxCrn3
 fp8pbNeQUn6pCoRM+SIOE6QdEfKS8S/BDwgjydXKiClou7U+tEbyJ0gBFKMZtwh3bsr/
 1J12zzEZwxFJYXpZJnTK0YqD1S7+Kst+KK5uAHHukp4Hoj4/DUmQ2c1R7R6GXp48AeDN
 yfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805773; x=1780410573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dekYF9pPrnIVrcP0IqaeXaJtDkemEhBeBmy30K13ZaQ=;
 b=gX6P91i9L2XJSlYFYp8tcBnb760z30g7C3TcXTzb2ktltVJTUvyidO3ZNCGaqjvRiy
 /Ws0a4CXFQ4OLCF5by/+Xvnpzwp9QBVdVr89QhPFZLV4/YaApzFYODjqcoKgYPdsByGo
 ZOOupg3Bu6G7qs2G60CmELIvdSVMvmjsC5RKiFsXeMoJHxtonDAFVZrKpU5WJ7KlBtnb
 uulhjObkzMFieqhYWZUucxq6AQ6cyQLR1RSXGtAF9dq4Zw9/zIBqGQ4DykkpIniW4zIN
 XkW0p9AGvbYN10Dg6vms2dVwgI/LDWLH2tEHL0gPTkiShP26rQJqxa4poT0mgLXcgSKi
 1vbg==
X-Gm-Message-State: AOJu0YwpJca6rtFzXfSe+Sley1I+9cWIR8lr9D9UfLPhX7D1ngUOOCBp
 bFo7dDe5r42vl9LezB/3ChRBo9CDD7ghXSeIG17qmD3BW5KnprokT5dFn0uP5QOWVcz8vFY5lva
 7Q6gJ
X-Gm-Gg: Acq92OHFP3qdsywI8MU6Xa+dXuMz82DQRfTp8iTJHfUnuHWOTBGUhDcQPJafT9ydm1x
 EmRjvvAwmv1jNRgjjb25H1Q0EkiLAlg63ehATQ9skZwC+/w2vumUBW5NwRo69OZ8SSJQR85r1bk
 hnSyJ6xQgVwLhzbqTnmOQt/qaFbSMAOFPJUtls1j18glDw9NrKlemAkbRcrd/MwlWzIoJeeEaVS
 xkKJmBBHIynxKTAs6Kta7Y2PQiLHHDGwrcr4yEgIA/B2e36ABTam3v/j4y1lK4L/0M0cOqwnq4Y
 dzBqmGENWg4Uehz3bIW9r7TtbxsABnIYqdTNZAaYDIUIOv/2KpOvkCOcoy/4IJUkaSta0BrUd4p
 xSx6i4qJuKM9whzEvuzks4gnDD0SdAuEdymrNvNckO+ojZgQBpDWkVGclhBDUn9cNjwv3G7BowD
 ccIr/qWRGgom1wk3WwKsHI2I39UA4kapFiSKtjcQ9Fu/u+PtAuDD4caoZxlpPfFyTI88bJOiB/c
 a7UjoYCmT5OHOxvNCLl8SHpNu4JyZM=
X-Received: by 2002:a05:6000:381:b0:455:4695:92d9 with SMTP id
 ffacd0b85a97d-45eb38a1c99mr33312482f8f.12.1779805773283; 
 Tue, 26 May 2026 07:29:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/54] target/arm: Clear FPMR on ResetSVEState
Date: Tue, 26 May 2026 15:28:38 +0100
Message-ID: <20260526142850.2326589-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

FPMR is cleared when entering or exiting Streaming Mode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7eb7031294..3d6e7f1ccc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4856,6 +4856,7 @@ static void arm_reset_sve_state(CPUARMState *env)
     /* Recall that FFR is stored as pregs[16]. */
     memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
     vfp_set_fpsr(env, 0x0800009f);
+    env->vfp.fpmr = 0;
 }
 
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
-- 
2.43.0


