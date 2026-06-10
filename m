Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC41ACD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXPlq-0005mv-WF; Wed, 10 Jun 2026 16:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXPlp-0005kv-5j
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:43:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXPlm-0003kt-UZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:43:28 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso25792405e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 13:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781124205; x=1781729005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjVdjpfOdad/VHaFqOII69qjP1mCIpEc8kf1f/xpvbs=;
 b=fsqwzxMlTzoygIm/FxNDijG4xGiN1A+EYV4RaCWFBKolRhkjVdqU0qur5kie5fNZ8r
 35JgqMYCOciPyJ0J9v1wF3utedZWs86GuTWcrx+cr5rpTrPhfG//xgrOxVoc4MwsurcQ
 sgQ52EcZjNYJV2tiKL0EB511s2wvjoYKSiIt46iw4txzSsoz8VzivXnWSGb8LGVyEme1
 XlQeUO1tQkosewIBlXaUsjgk4YfirR4dAtHitu4wfXcUhRw3mo3WB6LUD1cKgRe1fOxD
 idKpCMViaQlVBoZB8OkwTmBfo5OTHMVSD6kEsJxdsprJne2gkIw0avGgnNMkhh/HrceK
 JeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124205; x=1781729005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BjVdjpfOdad/VHaFqOII69qjP1mCIpEc8kf1f/xpvbs=;
 b=W1E6bRDUs5vjuC4tpaYOmzo3fR1XAGEWcl9KluH43iKoXuhFkdPZd6wKtC8yLQ0XqU
 AiSFoGdLx6l23YHmEvSqPtxYk4M1UZSrNYhfE7dNRa6hMxMZ4Ijgb7VePw2r3K2qebCL
 vM6FFRs7vu30kCr0hRx2x2sm9RSfdXXJnadCqD7GONbp96sRKl//Hvri74JsHy1IWtKY
 RVMVJi7yaJOr82F+pblSWk4D0UoCFXn+ebUo3tF9eyYcP5ew6VWYQmY30fkDi7DPN66g
 2ANgopVUPWWx5oU2CnV/0sBsavEsug+phSPxceXKN2Yp5Jzutb9xsTdonvxJney/1xTH
 Kjng==
X-Gm-Message-State: AOJu0Yy5MHusChrpCm0b6cB9Qqq6+oHbsVBK/vqBBZSqXxHus9mIF5CW
 fscuUfGMg5P7TxDx1BTj476PWbw2bhAWhJlvJ17bCYCjsV6oWnbViML7WkOAqpWIpUs=
X-Gm-Gg: Acq92OFJZksqPV2Q+SKPbEOw9I3MGrzG+pPVYF8qXen6OJoy5plN7KKOKaaU49q+a8W
 cqaVDMRBHPbQ0nDu1StUZ5j16B3tnKK2P/s1oh+K67wY/uxwCHJqfszMDztXf4m5wZKf8tYNOyO
 JpVKZ4zSctLYu1wc02nCCxGbonFWzDLM7movOrugnl6a2dyetyu8CgcvVEhZg96xQW2/fX/cglA
 ypnFkhswNPqjaSEGlI1wq5unslUJ2Kijpkw07B6Nfhf0/ZMw1rynshx69lOTQsEK89RjUUrDAki
 /qzkoZTzVSsQ8sztk7nc5oPFnD11aDWGcl7UzHO0106Y879RKOn9TAD7btprIgjZItxIXNHKGET
 DPjxldT0LDFrDuYpGUUdysLimEYfQZER/9BVfTOPc4fys5iaW0iPSOUmPlYQVY35nO36nM3zJPF
 +BP+doR54XudTBpeqFiBDFU0ooxHrG9yKjduwaIPduu2EU
X-Received: by 2002:a05:600c:c0d3:b0:490:b0e0:3de2 with SMTP id
 5b1f17b1804b1-490c265c148mr302919585e9.33.1781124204639; 
 Wed, 10 Jun 2026 13:43:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ec711sm72388472f8f.12.2026.06.10.13.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 370555FA43;
 Wed, 10 Jun 2026 21:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/6] target/arm: trigger timer recalculation when toggling
 CNTHCTL:ECV
Date: Wed, 10 Jun 2026 21:43:18 +0100
Message-ID: <20260610204322.828645-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610204322.828645-1-alex.bennee@linaro.org>
References: <20260610204322.828645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

When toggling the state of ECV we affect the offset applied to timers.
As a result we should trigger a recalculation of the timer value to
take into account the new offset.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


