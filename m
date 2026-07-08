Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17731C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTjj-0003QC-1v; Wed, 08 Jul 2026 10:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjf-0003EY-Ob
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjb-0002yq-Jq
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso459752f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783522725; x=1784127525; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p9tPxgPp+ertBUQDD22Wpkn9TkGPGklSEFP80sHRtw0=;
 b=qBKXzVyFRSvLM3oX5zu1E5Jbnv+3c3gMOLluh+uQFNllNi0Pnc7iwyyrmAg3M6s6i1
 OzGxAMkMAOYDH/JCiBeNtwENAWa2PCkZ2Gi68T/NO89vmDSw6pd7t6oLXG6qAX7GTwad
 4SJf6EpDGc5qmz7qUo7NnMNMtJfalwtXzyCfaOugFJtkSvtCRxEDMGiTsJa2oO5oZO8v
 rZiYnakCtqdh6745B+1uYLmxZpxU5OE1IkKiwIHotBlwtjIrRuRK3MgCs/brBhYu2KUL
 gqIPgUP5VJUlqDFcTAlDm6HLJOAozjvE7vMCtD0NRf13NU7Xsl7o2oRtOd47GNMy7CRA
 2Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522725; x=1784127525;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p9tPxgPp+ertBUQDD22Wpkn9TkGPGklSEFP80sHRtw0=;
 b=jRSqo/5t6D2tqVM3zh3hrXcJcdXiwiKqsVOfSz1avY3HJIQZRzNAIYHko8aUAlaZAB
 pR82BUevXsfreazJbBTqK3XLzX1d8m6q9s/IBRporystsn+ZK7Wb/xVzT7RridHpKv5i
 /MW3qUVzI9q0RPQaG7Vvlq9NGSpVoAvav8ZrqUduyY8JCrP/wDOsvEHz2umZOu5Qy9jq
 JYnO9nhUbwVLc9o0OGQ9JRiFYlbaQ3ED7is8kkALKG4tAgIXSiN7qA+5cDehskLRTWBp
 Xp/8Ha+VwGsfohAmRdzg2DL99FFMJisLhBy08210umTcR/vf8PTpLIrgVoijfDLUd6pq
 puXQ==
X-Gm-Message-State: AOJu0YzcrZ7Q7GF1nESIqtbRpaMI3Wghtf6Hh2Y0ymCku1qptt7oB9lj
 RVPYoLbDvfoviyc8aM47ONJk1p6Prm0DGlXBr8f03jwJA9hEPSZn8uObsCdhmTFWP5M=
X-Gm-Gg: AfdE7ckS1sdhiOpgJc4zJRAgk/co9TYnvqwAPloKnZYtky8DFWWQdY7diNR3sxpE/Kv
 86i2NgH8XSH/wcA2Ha7vLnOcwFpY5NHrGqzbM3wMAm54vOcVSsdrLihfJliRER7HwYl5H3xXSz/
 kiozcWXo7qgUK6w8g87r/QF5slhVoXR0j6cQFBgT/e997ZDXlraLGHz0r+3zbqKuXCdTwNi2WzG
 51AMI+jUtOBs5p7TyVBhnbg1dAEYzIQ0Iwld3kStJa8QoluA2b4RBDMnBXoQSH5iVkpiGPmllRe
 NUkkqz6hLTk2cNhz8SAa90gAj1Ly11yKwU9ReVJ3iHqKUCpzrIyoJtLkOZ9O/naqKxON9pbY78s
 uYWLd+NZ3GMSgpHe21O7aiaQnQYvNxBbdQG3b//DwvWpiwLm7/njpsSHZVhBFTYkDhawEcMQotY
 RJcdmn7IyV0DCQ
X-Received: by 2002:a05:6000:2909:b0:476:504f:7a8 with SMTP id
 ffacd0b85a97d-47df081e2c4mr3323321f8f.55.1783522725589; 
 Wed, 08 Jul 2026 07:58:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae44sm41646923f8f.23.2026.07.08.07.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:58:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E5DFC5F943;
 Wed, 08 Jul 2026 15:58:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/8] docs/system: declare support for FEAT_EVT2
Date: Wed,  8 Jul 2026 15:58:34 +0100
Message-ID: <20260708145841.3032079-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708145841.3032079-1-alex.bennee@linaro.org>
References: <20260708145841.3032079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

The actual implementation supports the additional trapping registers
of HCR_TTLBIS | HCR_TTLBOS. We already set the value to 2 for -cpu max
and don't currently model any CPUs that only have FEAT_EVT.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/cpu-max.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4f413d69efc..fb8d263db49 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -68,6 +68,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_EVT2 (Enhanced Virtualization Traps 2)
 - FEAT_F8F16MM (8-bit floating-point matrix multiply-accumulate to half-precision)
 - FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index d38bdfcf811..88b7c046333 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -130,7 +130,7 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
     t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
     t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
-    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
+    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT2 */
     SET_IDREG(isar, ID_MMFR4, t);
 
     FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
-- 
2.47.3


