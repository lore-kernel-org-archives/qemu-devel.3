Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF00D65530
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyxT-0007Tw-DY; Tue, 26 Nov 2024 12:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxP-0007Il-GR
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:35 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxN-00020u-T0
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:35 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-382433611d0so4860742f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732640552; x=1733245352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0oz9i3H0TButpl28/4xQ6x9LFZbz5aAAKUdubGU30ls=;
 b=u2BI6OOoMm2l58cv0MxHklZgnUP7a7H8t4KYdTtrYydL0mcCbsOZCkLhVx3zwkb5hI
 tlECMwNYrXh5dyGSj0hsT5szTrLkVLnMyDMxaWG6Fw7md2NVWErYyZ79ZN1oSWJKL3+a
 KbMjWcJLioJvmBpX/aM95jZjjT9vRff/FdeDfC49oxEXSf2nzZxbWnPioIsHgbrjR8no
 630L2sPMOrASUjxXhBt91ztWhYjRpCck9JXUFTdgyGvrDfyo8Gzonq0Eya5K+Myn67Tl
 V7xEMqA9izbmtXc0qwwCmH0j0zLS9aClNkXEjbmXxVPnl5CfE6F9Hgvvft7DqCv4CZrP
 ecFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732640552; x=1733245352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oz9i3H0TButpl28/4xQ6x9LFZbz5aAAKUdubGU30ls=;
 b=FjZtsSAKkfT6kPsR5yVonzwXztRviIijFQKZjKTXmrpZFPy5NINe6s1P8qsIDniP/D
 HFt/OWS2EUBG0NKtrzGKGHmF0KK88W23VEyNvYxxCwNA/t6xrVMfQuYnRIN4XmQugDXS
 Yli00C27JY1z4Bw8s8M8Ie1K06gVjXgqAwxvwECABoXGB7oe2BphkQNDDAhClWazV4ZX
 JDcyk/dYlMbV5Sr1UNZao66tyrgx4+wF/hu8R350Yxui3sqK0nVgbrfHdyoITtcNrXJd
 05CYljadDVeXc4pQbDZuwwQ8ftd3kS5DwviSY9yHNh8so5bnY2HDU8zzjiwbUKSoyUcR
 GIWA==
X-Gm-Message-State: AOJu0YzGg87Te9k6q64/WuyczQAjLPWWkGOqYp1+FKm8ZGcYoH7BdcFu
 6RLuAd8pp15KmuXmsZ1aBnF4Mm970H+VleU+esIeKxrjbTPw7pTjY0jnZ+Se6HH7SpAvVxPV1e9
 I
X-Gm-Gg: ASbGncsTYt4nod7twstHsfRTWpleR1+pw20W2IGbjrlkUzou1Xb63r/8eVjztWtHoRc
 mFAiao0d1AxCBOUBX6XZ8XNVjMFXzPSyE1U2rY1iEn9NeHJDzJUnk7dNOYGBOzBR2+YkY2tjHfs
 UFLGYhmOoajs/HdNZMMCkO8uAsput5DRckt7uBuqjSooZeyq8IxHQ1bSZI5ji1SJWb6V+QRBQSr
 q/Ge6ATYLKBHomaNbv8hNT1+I6ErxNjEQnmYJp6NkuIR5Q9Tfut2n9N
X-Google-Smtp-Source: AGHT+IGJyBT3AKr7hwnpyTjFKCOHeM5gwFU7zFggMoWJ3IxUcOWMcFfHXnvjuzJQ5XOlNtRPvTvLrw==
X-Received: by 2002:a05:6000:1882:b0:382:49fe:6f8a with SMTP id
 ffacd0b85a97d-38260bea7c4mr14999436f8f.55.1732640551577; 
 Tue, 26 Nov 2024 09:02:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a36c7a9fsm43017865e9.44.2024.11.26.09.02.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:02:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] target/arm/tcg/: fix typo in FEAT name
Date: Tue, 26 Nov 2024 17:02:20 +0000
Message-Id: <20241126170224.2926917-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126170224.2926917-1-peter.maydell@linaro.org>
References: <20241126170224.2926917-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241122225049.1617774-5-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 2a77701f8dc..2ad21825255 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -71,7 +71,7 @@ void aa32_max_features(ARMCPU *cpu)
     cpu->isar.id_mmfr5 = t;
 
     t = cpu->isar.id_pfr0;
-    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CVS2 */
+    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
     t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
     t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
     cpu->isar.id_pfr0 = t;
-- 
2.34.1


