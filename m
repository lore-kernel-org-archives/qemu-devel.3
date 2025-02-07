Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EAFC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQ1a-0001i8-5M; Fri, 07 Feb 2025 10:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgQ1Y-0001hc-55
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:12:08 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgQ1U-0002lC-NF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:12:07 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so23866835e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738941120; x=1739545920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1obwOCQYgIJoyANHuisDQcFcRKOfDSN12M2elLIY2RY=;
 b=jEdAEZJXGnEdjtxP8WI73ISp6hA2CLurZiR1Kd4rWggBrMrfg9JG1aH/MsDHRgGvdj
 wL63Jc+Y22xxM1caPtDEkdeByM6ERxqIl/reSJs+uetdptMD4DpqHNFjZ1SyblfwO1IM
 c6nJxN4jYVbcbzt1xBVtx6sHAgOnQKJo6zz3A65inO5RXsyU1baJy77jravrOAI52URm
 IRuOEwiZFre0Ks52YfB+VXrlgIGuYl4+6OObx98C255j7+VGvnRwspKFDDjawsInd9wC
 sgJ26mDaXY57afGR1l/tXryjujgUCcqtMxed5y3HzQwUcp5rVfhCJQ+630OPjKqlkdCi
 2exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738941120; x=1739545920;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1obwOCQYgIJoyANHuisDQcFcRKOfDSN12M2elLIY2RY=;
 b=uwHBDt2bKQXyHlCwP5eQg368si01ttFgkOnUsMTSNIT8hEQZcJ9sSse16694atxKZK
 ABQvssBrOX0w1fnYy7U+WLdsYVzUiE/LsdRiKUAgR+il4NCRROLovNNvZWPu+MqC4Ul0
 xP0BPLXshH+GT23q6z6VJdjXGB6MG8oKONOOXfnyullYoULmfPn7zRiANm7rcb+NYzYH
 IRN1MluNrv19M6tcpm20j0KAHFc5ufNuE9paOcfAZSBqInJXB7UwkaPr38YuKi85XnxO
 ROawZoangBJpPTuA4dBhIWuOHys7de+j2dpu3zDxZalVt5wCEoox1gd4mhcdH/V6PSSV
 SoBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe50kiXef1eJfVPAtriBmBFxeGOk5lUmzMeRibZ+n7R8rtGRm44f2/APIq2dPmzhhbtTdVgW/fm9zn@nongnu.org
X-Gm-Message-State: AOJu0YxhGH2VIoMBoFw3QLl43ngdMhFIOiepqnOXHbluD2hnBeH/YytE
 r2nisq2/Oa9wVaO+RsnhfFB6hQdAikGz4Jy0nuzMnBtma2JvhXrNiMOf4AMt5UI=
X-Gm-Gg: ASbGnctwtqwWa9WPfhXirTSEZZCJJDD7+qjq94/n2akdKIVAKF6CLnQ2ychQSXr1CPe
 eqmAhFRQFnx5qyV4XKxA/sXTmBkrNoEnF4sDbNIdUVxFBFW7TDkULmoecOtRF8dcJdrfJOE/o+A
 9UyePrzZ08smnbPKr7zC0Y4/tmryjFCtUfOiY4d1Hv/YKwwVsjVIaTQCFpRGGXRwvJekLsHRGON
 SvV8+BJd+cEO1nhqlXzzJ+uWiqbLM8FUOcDKyD9QMjGfUHvtWLs0f4uvg9VDMBbMmTXhJcwtKrn
 TF/j4ItZYt1sPZeY6mcTUw==
X-Google-Smtp-Source: AGHT+IGT9zSzzfcrPw87u3rCsEMinYPSJ7M7P0QjCoyziFIqPgZmH63widVYKf441Yjym+pbvYqDQQ==
X-Received: by 2002:a05:600c:4e56:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-43924989231mr35158855e9.10.1738941120346; 
 Fri, 07 Feb 2025 07:12:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391da96640sm60568925e9.8.2025.02.07.07.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:11:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] hw/net/smc91c111: Ignore attempt to pop from empty RX fifo
Date: Fri,  7 Feb 2025 15:11:57 +0000
Message-Id: <20250207151157.3151776-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The SMC91C111 includes an MMU Command register which permits
the guest to remove entries from the RX FIFO. The datasheet
does not specify what happens if the guest tries to do this
when the FIFO is already empty; there are no status registers
containing error bits which might be applicable.

Currently we don't guard at all against pop of an empty
RX FIFO, with the result that we allow the guest to drive
the rx_fifo_len index to negative values, which will cause
smc91c111_receive() to write to the rx_fifo[] array out of
bounds when we receive the next packet.

Instead ignore attempts to pop an empty RX FIFO.

Cc: qemu-stable@nongnu.org
Fixes: 80337b66a8e7 ("NIC emulation for qemu arm-softmmu")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2780
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/smc91c111.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index b18d5c23c39..0e13dfa18b2 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -182,6 +182,15 @@ static void smc91c111_pop_rx_fifo(smc91c111_state *s)
 {
     int i;
 
+    if (s->rx_fifo_len == 0) {
+        /*
+         * The datasheet doesn't document what the behaviour is if the
+         * guest tries to pop an empty RX FIFO, and there's no obvious
+         * error status register to report it. Just ignore the attempt.
+         */
+        return;
+    }
+
     s->rx_fifo_len--;
     if (s->rx_fifo_len) {
         for (i = 0; i < s->rx_fifo_len; i++)
-- 
2.34.1


