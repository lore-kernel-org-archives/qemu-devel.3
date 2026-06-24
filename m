Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6E6CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMzQ-0003Ov-Pw; Wed, 24 Jun 2026 08:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcMz1-000387-VV
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:45:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcMyy-0006Mx-UU
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:45:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso10149225e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 05:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782305130; x=1782909930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pq3pVOWs5xUz0luOR7Gba+BoRAVEKlJAiyWE6ZD8t04=;
 b=dqX6vjSWf8zgMx4A/ItossrMA1ASCoiPnMxLqfnI1t8+vGJkRh/4U2qKw9SnprxAdH
 2fgLYMjhgujmeRltX1AsrxOjUej6yWwSfiCBkaB8KcmlvDgfPqincsbhleNp+noeMW3p
 kig++Ab8PRHTgY3tcZZqJzevbGJ8dKDFJIIW51KcgE+nTGtNwVwowm6KpeDz7ACSQ4IN
 9TLLBVCNE2LgJAdmTFH39/WWalsh6mjQrfWO5Lkhb9Qa7lLsRFZGmUzmBFHXz/DpfR1q
 BAjNSlGzt1ki+YNhZW9mkCMb/v8VJeqzOOH97JV5qjkrYGSYw7t9OKeiMi9EJxPZ08Hg
 mjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782305130; x=1782909930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pq3pVOWs5xUz0luOR7Gba+BoRAVEKlJAiyWE6ZD8t04=;
 b=X14cxxti5cQz3PQuXDpBU+h/na1Fx9A3br8BglrL25Ydj8Olu1nbgZHCryLJpSq75b
 ruxxg+5h2tJxnU7sEGwJuNEdZCvODVKjBvPJYaFcqTmBtZyC4odjXr9w1lmbOA2fgK23
 pxWG7RUMJgPODu3xJZPoohBURHwp5YKCc9Gn+kR2q4NAT8pAOdbMK3H123F9Zdu5dSvR
 ZfvdlaskhIMGHR5YuXwQa/Lq7OBBQAZqo7o7fSYUxcbN97OZpvObXPhLNw38ds/4ITWo
 CmenUdj55E0DmwhZ1Dx6Irefg2ogwaIgc7Je2rxu084/ju7FgbVLSE+ZroOmzirRs/0q
 LTKw==
X-Gm-Message-State: AOJu0Yzt6U77IwwTbqufM8pn+Ms2pqNnZPlOtwyYmXNj7OngpqjPGGYt
 W5w2oxlD3qGCfmOxatHa95iCvFnFWD/RNnGcjqrHdpfuoDoLCEVuGY2lxJ8wjZsmPZA=
X-Gm-Gg: AfdE7clh1vhdRvA4PT3DUfhQmsl+VZgN2uT77ovXU4i63chnkqKOCi3VJA6vCAiZNA6
 G6o71v7TzakOlz4Jp2GnZJksTP7lvMyz/SflQO8T3cepd6dZcUsF7/mMwGnvs2pMGOnxDR/tENU
 TAnHvrG8xyAs8CD8Tmgey0wf5G8I6C/8nvZSt5rp+fp5iHg/Vtisdc4Y5TeHzJIWnR4UL6VI8ex
 0aAyRaTmoOaePJPUauzYtlYzDGq5tRhl+f8s0Fdp8qcP4xmPS2YE/xKbTBzBfsbsQ2Hest6xJpG
 3uCg0xv/dzpiTimR3vy4uxT9HKW1/G5G4yVybTyD4a1hqjyCPxCNlZgYQDYyYgxmyXhkaSnU58i
 zvI7t5paea4KYwThAWJCthdrbhs0dcCra1YCJdYY5Q6y1/2fsc+HhQ+otrZJIIdD9DwVmOG+F7M
 gw1f5juF4IRY/N
X-Received: by 2002:a05:600c:1d1e:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-49260873781mr43398815e9.20.1782305130246; 
 Wed, 24 Jun 2026 05:45:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923c862sm349689185e9.7.2026.06.24.05.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:45:29 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3845F5F8E5;
 Wed, 24 Jun 2026 13:45:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 2/6] target/arm: trigger timer recalculation when toggling
 CNTHCTL:ECV
Date: Wed, 24 Jun 2026 13:45:23 +0100
Message-ID: <20260624124527.1018912-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624124527.1018912-1-alex.bennee@linaro.org>
References: <20260624124527.1018912-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3d52cdc4a5e..3f0707126b5 100644
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


