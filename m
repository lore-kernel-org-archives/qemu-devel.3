Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F05CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWx0Y-0001WS-K2; Tue, 09 Jun 2026 10:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWx04-0001M7-Hv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:00:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWx02-0004Jd-LG
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:00:16 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4905529b933so60380895e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781013613; x=1781618413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hgC4BPNJwqz49DQoEMfvPbzbVF2te92kpDfaNPld+I=;
 b=jxJHHMJDrsDjOXmvhDsUSoBLIb9dCQxlALJ2e+eoYBJYjPGLisM9nQ9brZxqXYX/LT
 ryLzbi3O+Km78blTSzcPOhxO6PuLV/S2+Sv0QOItuvuBnhka6doIQBgB+r0XYfYS1iYO
 fcBzHc+xoyFCshzxUEQSSaC4sfozVTA+DZx03rylCw16Fq9rg49VqCoY30v1Gj1OQpg6
 IgFV6FrYjgbBlAbAsAobZGPWyME6mwWrHdQ1osCcCmHR8Rs1Ur86/bWja8wufkRJhNwq
 HU6xee/nbGVYZP6Y51KBqXSNZq6zlFcrBrIrkXIldQyIV2KFblYfgkcxNtqJB6Vtpjk2
 sykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781013613; x=1781618413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1hgC4BPNJwqz49DQoEMfvPbzbVF2te92kpDfaNPld+I=;
 b=iKGMMx1JUvLKvEQrktxF4fNhbS1B6bjwZ6zBO1RpeDNXVRZ47N4CkyjhkvWZE+LNCY
 ZEAKv/MFAKjxXvCTZdIYG1k+zR5tLs6xPQ6pEit3hm2h+DMpijY+iHz0ZP+ZwtwH4Ryj
 AJJnG7tEjJjwkgCcy/7gtteexAjvlYaoOMjAOLtIrUendyo7/5pleIFjTWLp47BVXB7p
 QtuFMl5wBW3IBzt5EkDlayE4taFLQsDZ5iPr7ZKSEbQrLAy+86mJ337T37vANNPLgJUz
 maS1CsoMIGTdOq86pExBKzlglzLc+qZBkvB37IboahMgzi/Yo+gSLRERvhu5BCXV/jQ+
 orjA==
X-Gm-Message-State: AOJu0YyYvRGz8e1ZgPkTOs11k0UqfFN/YwBJQoSASa+uWdFHH/q/nIEI
 nyopSg9xKCzO86QsEMewJY2z9XFf1FfRk7K07ZKvmHoUZ1LXKUXI71oZEL0h4MHcAbw=
X-Gm-Gg: Acq92OH7eMfgTy41mJX/3G8woCIe851+vgmlY96odNrWc7xnojo/Mgyaj/ESeOzklnr
 m5TMKlXuc5pEbNG5HlF4nayHAh0GAa8EtF7t6PLFIpIQbR/4ZgtN/GePAQG7Tf/zLtqC0vTP0ze
 D2B8zQsAD21SYEKUIV+HjKU1+jlinMJwl5Wgq6Dv4IL9Blr2wPeAMudQvQQAG0hnHRFR7sebFSa
 aY3O2uN0QrEFjaxZEnJJ81sMfqkEY+S/j4bk2eFt5Qtxco6PWtnyVyes+CWd80W88LC2Wyw6GZ0
 J3S1KRZHYOo9Q91SIsk59cNmNGivjkMuDQPMeXJtruadsqiF9rZEh4lVWC2Gs0RvxQDteJ0Ab9Q
 HfeXto3BMssbdobNrjKWb+/Q4Gr7WWAXYluCV2jUWhNUva9NQmFE56TIvObfOkLGcBzqOOdk3gc
 J6JbIdDyxNwsdfcWakNOcki2TvkfMZtT/Cz4ZWdYPQFCX+
X-Received: by 2002:a05:600c:a302:b0:490:c2a3:1781 with SMTP id
 5b1f17b1804b1-490c2a317c3mr268615525e9.34.1781013612670; 
 Tue, 09 Jun 2026 07:00:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3c15cesm473268275e9.5.2026.06.09.07.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:00:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A5DA35FAE2;
 Tue, 09 Jun 2026 15:00:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/5] target/arm: trigger timer recalculation when toggling
 CNTHCTL:ECV
Date: Tue,  9 Jun 2026 15:00:05 +0100
Message-ID: <20260609140008.3206970-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609140008.3206970-1-alex.bennee@linaro.org>
References: <20260609140008.3206970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When toggling the state of ECV we affect the offset applied to timers.
As a result we should trigger a recalculation of the timer value to
take into account the new offset.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f4aae0a4072..5c640853060 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1806,6 +1806,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
         gt_update_irq(cpu, GTIMER_PHYS);
     }
+    if ((oldval ^ value) & R_CNTHCTL_ECV_MASK) {
+        gt_recalc_timer(cpu, GTIMER_PHYS);
+    }
 }
 
 static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.47.3


