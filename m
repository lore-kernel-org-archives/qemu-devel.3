Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650FBCD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXPls-0005ok-RJ; Wed, 10 Jun 2026 16:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXPlq-0005mt-V2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:43:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXPlp-0003oy-Aj
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:43:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490b9318997so53323065e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781124207; x=1781729007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O52Kn5p/ZNY8UYAGDKH5FlpPSoLk/aGgjayJR1kkiII=;
 b=YEzLG4Wh2zW0JqXkuegyAMXvMD7qt8OzW+MReUF2WKMEg+HkCpSfAs1trwZKe4/2fe
 6Y/Vb8MT4eBa7iCDhCA4DWEVShHnnVhOxHngrsGuNgSPgIX2GqZagcaW9PGhH8dmo2Mh
 TLZVQC0fNRoL6iVqtOEdKJUcVpBkb+zZ4tBETTzaCibU8Fe4McRC1kUIuVpHrdHaod76
 vDPw37ShFfIyBUrd0pVpVxrEbniWQaOPyKKJWaIR4czI4NWNXrALjmsGgSwbTZIiMrp7
 hM9YFqQM2sfiQTnMhQlDryDVzXa7UU6xM4yS+YCsi5phzBSK86EGk+cs8Wal8EEsXR0I
 sJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124207; x=1781729007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O52Kn5p/ZNY8UYAGDKH5FlpPSoLk/aGgjayJR1kkiII=;
 b=N7SpDYnBMc4JPqxLwFkLppb8umiZcBT7iQnsORcgz1JJko0qFDCPGNVJurzBAJueDk
 s1vX84sBagwqzEI+LwbzsPHOpsBWKumIvLFgM06wduRKMjgHL3fn7OtV6qgrX/vU1hqd
 +bUAYTEt0UxZN1m56h6EaOnpG/VBjsEWAs2F8ASmsJP/zogeBZ0VuUKwaGhgOMTrdLqX
 TPZ4mHoObwKo/ncFs8OwHUkD7JY1aYTrzWLhH1Ej0UaNxPJKkgVA45Ldw2ydOTZqjGIS
 P8vBwGeuc8bUzz2Wgm/IgYE2Ncj2G9P8UX6D6FMlMAnYTyraNM2DyWAdutjgPDKxcY0r
 3zbg==
X-Gm-Message-State: AOJu0YwjnQOUFSf9WN3dr298bDtbZ5P4AwoHbB3wuo7usZWA5qPP9Pnp
 Kt3+R0Y3ALwdK7IgXpo5FcTCmSlN0zhpyCOZ85S75NdatPxqSgLu/rMcETJQ3amxyLQ=
X-Gm-Gg: Acq92OGM4c4a0qVM81wSq5jQWe3u+IYpz/Gy+tWQosT0etLp+eZoQy+QzcGWp3R916u
 vOjmO78VPUu7kogmPAPjNLdMan8vnsRvTz5J5mN2cR0wADgP25bjTN8hXz8OK9DJMzod9TH7M7S
 QsFrlfqcWW4pjkG2Wd+k7P7WCs9CJLpTJeQbEZ/OLrSJkhj1f7gESwiwOz1eDt54ish3M78AhOZ
 K/Q4ghMLfC51pL0uPVE7cQABFZbmkhniHU0LKwJrjg+ydIWInYlkB1Np8AxpecQFseAXXXEme6+
 TFZ17vntSwrW/0cro3daOthZSB/TLbumGNcy4bgAD6O9EJEo7rrnoPQ/pGMEh2VA7BnbXmLDmm0
 g3hdRkIvlmR6auca0JDU20r9fGogyvFowtfkJvAIg0SfZwTcbtcWrD/agn5BDw3d+d2iKg1hH18
 IN7ISq5jqI62BKpVpKvKGFl8hY4O9vD7s+5Q==
X-Received: by 2002:a05:600c:8a0d:20b0:490:e1a6:45b6 with SMTP id
 5b1f17b1804b1-490e1a64634mr23037255e9.20.1781124207489; 
 Wed, 10 Jun 2026 13:43:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2cb2f4fsm11056285e9.15.2026.06.10.13.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5DD7B5FBBF;
 Wed, 10 Jun 2026 21:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 4/6] target/arm: gate check on scr_el3 behind
 ARM_FEATURE_EL3 check
Date: Wed, 10 Jun 2026 21:43:20 +0100
Message-ID: <20260610204322.828645-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610204322.828645-1-alex.bennee@linaro.org>
References: <20260610204322.828645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

We shouldn't be reading SCR_EL3 unless ARM_FEATURE_EL3 is enabled for
this system. If it is not there cannot be any offset so just return 0.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 22f5117ee54..8946d2aad28 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1413,6 +1413,10 @@ void gt_rme_post_el_change(ARMCPU *cpu, void *ignored)
 
 static uint64_t gt_phys_raw_cnt_offset(CPUARMState *env)
 {
+    if (!arm_feature(env, ARM_FEATURE_EL3)) {
+        return 0;
+    }
+
     if ((env->cp15.scr_el3 & SCR_ECVEN) &&
         FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, ECV) &&
         arm_is_el2_enabled(env) &&
-- 
2.47.3


