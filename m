Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC77FC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIO5-0000Dv-22; Tue, 04 Feb 2025 07:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINe-0008JR-Qr
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:19 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINc-00029m-VE
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:18 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862a921123so3767602f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673415; x=1739278215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R869ff5rZccFCzTyQxhPv2mn876SBy48z5OTtaNMV/s=;
 b=q34Kmo+4kCzQngdTmrf6jomCNA4mYp+pCHJLIKT327pPPTznWDEHNRjByw3wRHiA9E
 +jEkB/q1gUm7JooctWVDlPiXktO8gnQ5gyVjQ2bdNVwj/9k1ahxtFXfk96SM1vi+IlHS
 K4idlm7zA55Ds8D2IAP5wa4q7/EvicmcCE/CHLvtK4yo3QJpltbFQ3zhM0E3bmahpHfq
 WSb5YoQUKYywICTwe6ejr0jt4WeHuzNjVSrjnAvwWeiyJkeFWtWPCJgLkWvMgWw/HOuG
 ATtSw6fI52Eqos5LX/rlbPfjiFVekaL8zo5y31VfIySYnsgq4CM4MSSUz6dvKaieEtiW
 p2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673415; x=1739278215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R869ff5rZccFCzTyQxhPv2mn876SBy48z5OTtaNMV/s=;
 b=VVposMmmwSUmaCFouarMtHF5HQqE+ug8G300/g0tm0/uOc78RqyKLLWD5azYFY/OjJ
 eKnNSdhiVSLT2BmsrvXtcsFE6SqtBcY0k+81OaxN/HlbagzMYX4LRUxNSBxcmCZ+U5Sa
 6Lm3/5ZTeCjItx5oDDWxIDHccboTWwMNeJAED9HQGAgyeZ7biiwFh+RfhLZHapT2Yl0E
 t7Rxq79jQ0tV/dPJuHk6o/KPvzjGd16CuXeWS1vGR4WO5CxkQQoMMamwevRo30iQWHyw
 G+EB01dkla4rFfnAMvw0VU1gZuC5qhSW6bj9a1C75ZsPkYFKv9NOBMvxHrJE90Rb4dnU
 KWMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOpRsx4xg4d2+k+cVjIOzopJ+L4zRo11jyKai9oCkybps6Fvxrn7Nv/v8AIiYoESG3Affvrl2j1yl7@nongnu.org
X-Gm-Message-State: AOJu0YzenUg5vYSiT526CwwmmzhS9uz7J/rCedE4Oc2N5DBo/0Y+ZENf
 8Z0ch47b7CoE7btLmNolY9/imShe8Oh+7pmzjPk+7/kwTbnZ0cUF+6JH4l0hJvc=
X-Gm-Gg: ASbGncu0rxtcledjumEMAXAezDwvccobkHDXWpQ5d7aG3zJ1yUcD8RMrvTnGN1Jin+Q
 wUrNU9NgXOfu9adnf3CxWL3PeDYc8rDoWaKi8VsX9K7Wn0LJi+8XjTYi9XxKqQQVzHvr4YpiTad
 ziTY8x9xxJwXmON+ywFiMY5mWVc9SqZ7vK/CnctrXvXlN1UmR1y5QPAbP8c0BoLFhkCsUipQ11/
 r4Hnp+B0Zipq4z8HTeqKHPjAEWclOH2frt+/szCD5RBlmb1e63MYu+yh4vIAGhmv+ze3QotzVZr
 btNIEeIFYwp4UsqjcZ88JA==
X-Google-Smtp-Source: AGHT+IFy5V1sEUSCOvK8E5G5DGfVIJFSa43LRtsvOI53ZRMtIr6WvrFHSE5BDrg72O3QKV298X1ncA==
X-Received: by 2002:a5d:47c8:0:b0:385:e1a8:e28e with SMTP id
 ffacd0b85a97d-38c51931ef0mr19713816f8f.10.1738673414994; 
 Tue, 04 Feb 2025 04:50:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122465sm15757919f8f.47.2025.02.04.04.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 04:50:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 3/9] target/arm: Make CNTPS_* UNDEF from Secure EL1 when
 Secure EL2 is enabled
Date: Tue,  4 Feb 2025 12:50:03 +0000
Message-Id: <20250204125009.2281315-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204125009.2281315-1-peter.maydell@linaro.org>
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

When we added Secure EL2 support, we missed that this needs an update
to the access code for the EL3 physical timer registers.  These are
supposed to UNDEF from Secure EL1 when Secure EL2 is enabled.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ac8cb428925..7ec1e6cfaab 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2387,6 +2387,9 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
         if (!arm_is_secure(env)) {
             return CP_ACCESS_UNDEFINED;
         }
+        if (arm_is_el2_enabled(env)) {
+            return CP_ACCESS_UNDEFINED;
+        }
         if (!(env->cp15.scr_el3 & SCR_ST)) {
             return CP_ACCESS_TRAP_EL3;
         }
-- 
2.34.1


