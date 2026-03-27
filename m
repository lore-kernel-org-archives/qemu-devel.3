Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7864C10ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Bw-0006eN-QM; Fri, 27 Mar 2026 07:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bn-0006Rb-5J
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bk-0007rw-6E
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so19560845e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610234; x=1775215034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hk6a1v8L3spC6OyBMcpBGHvcslrItUrS5/6IvS68Vw=;
 b=QUlhctwmiwAj5MlUVWsA0VMz1ytCYF7MRg8L25ZFaufhHdTfjBzpz0COl4wrMWzVhv
 77bjrALIomQ7KLwkO2snBK6/Fy0pZMcZaR7kFECZpIFH/KBckUkr52DcS0ov/nnge8Kr
 QVX6NmgKnl69EDMLwqaN0p2MZV+M1AWYRYZi+aPyAO7GxnAHDBhTlXbMuc+PLHUaZHl6
 vuXKdi62kBk+m/pGpKo5b3HmzEngcaJ+9jYAUXcVFLIieEDwQB81rBWfQgzkTNz611Im
 qnwhRN5SZcvnQjjD5HNDw4FOTXkZxMgNy31FWRX9HNreuRwfy6tVoEK7HYHOpkzlKs+I
 vUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610234; x=1775215034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0hk6a1v8L3spC6OyBMcpBGHvcslrItUrS5/6IvS68Vw=;
 b=eATDuOJOMbh89RFyofKfGiPzDscLR88dBO2jtuXvyJGSMW3NvyyeOTii93ncBXVCkn
 jAga5wUbcVS8BPZMkxxXeZM579KE6wM8ljcgTjOEq8vfLZEEmUBNkNy6DzQkwsG3rOra
 x+/3FRCQKXKQym1V6BCiQ3xg4pxNcoK2aOwIOmT3uNhEUxvj9RhC7RdB47x66hMAwZ/F
 pUo6QJaRN8jOw/I7qckerdmHNDNviL3vHPfL0JFbWQr9nhYAwRxcRghgIR7J2ppUN0U+
 oacd6bnDu0/jbVM7AsdF65aLMQIxplFH0j60LW4NeCaq66yEs0KnkOpMd5+qJU3OyzQm
 8dug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVWslB4xp3WmKFFe/ZWf3SdrZGWDt7V5mCz3ouFUFqiNOpb5IqckEVGBPovtN+6264J/aLmokn3k8H@nongnu.org
X-Gm-Message-State: AOJu0YzUFzPycG1iZf0ou3ZHeUboU5/S74qKyajk0nxWotytpYC7V3e6
 Tdy4KWd7BvLYlEhbwhJN1ft9FEyyoJlXWWnGxAVaylh0toC9r0rJKf76MEAftUFem9mUu/oyORQ
 EGA6HqD0=
X-Gm-Gg: ATEYQzy/YvbICqYHmjHi5ORBeUiGHRTh7sBjwe2nc/WclXgEZy8e6V3zNPyyvQPmPPl
 IWTG1vjHOK3JQWUxTpyWZiwiityDUr9ZEaR5CIZ5vgTxjdVmOGwqHBwbGG1RTPtMDt+k19nHezk
 IOs6CU7iAOsV7bisllF4cXxBucheCz6CrVUGOyMMP68G778tNafXmBe1Khy4cXyj5oW3+rVeSp5
 DoMrKlJ1n6egKrcGLWwbl1TB5Zaecv8ZK4eyoJykYFV/3D9kktJ8yEJ7Itue4ctua3Slixa3rAI
 3Fy2GHJs4z5cqAu2ZhfJ9JwS98xi1Mrauo+d2GyisEBVAacH9jU8G/MWlALDe0NJqL6YRrL0vii
 silzl5etCXCyAvrxGod/Ibt+wOghFj8P9UUx9lbw6p5EUYoAjiAl1YT+7IoNy2W2ne+Oh8+kSEz
 Q+2xdZlobJk/s/U2Zy6zmJvtuKE5zxFEStYmK7YycXHZW3D6nUkuM9vyk7c7wm0kssevOMbiNwk
 yrmsfmjwKyw4ZVBb9U+uZ48mKrXXCinnmsLPlsG4g==
X-Received: by 2002:a05:600c:8207:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-48727ee4444mr34500275e9.29.1774610234518; 
 Fri, 27 Mar 2026 04:17:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 13/65] hw/intc/arm_gicv5: Add defines for GICv5 architected
 PPIs
Date: Fri, 27 Mar 2026 11:16:08 +0000
Message-ID: <20260327111700.795099-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The GICv5 defines architected numbers for the PPI sources like the
generic timer and the PMU; these are different from the ones
traditionally used by GICv2 and GICv3.  Add defines for them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 include/hw/intc/arm_gicv5_types.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index 49dc1d6e95..7d23752ece 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -25,4 +25,24 @@ typedef enum GICv5Domain {
 
 #define NUM_GICV5_DOMAINS 4
 
+/* Architected GICv5 PPIs (as listed in R_XDVCM) */
+#define GICV5_PPI_S_DB_PPI 0
+#define GICV5_PPI_RL_DB_PPI 1
+#define GICV5_PPI_NS_DB_PPI 2
+#define GICV5_PPI_SW_PPI 3
+#define GICV5_PPI_HACDBSIRQ 15
+#define GICV5_PPI_CNTHVS 19
+#define GICV5_PPI_CNTHPS 20
+#define GICV5_PPI_PMBIRQ 21
+#define GICV5_PPI_COMMIRQ 22
+#define GICV5_PPI_PMUIRQ 23
+#define GICV5_PPI_CTIIRQ 24
+#define GICV5_PPI_GICMNT 25
+#define GICV5_PPI_CNTHP 26
+#define GICV5_PPI_CNTV 27
+#define GICV5_PPI_CNTHV 28
+#define GICV5_PPI_CNTPS 29
+#define GICV5_PPI_CNTP 30
+#define GICV5_PPI_TRBIRQ 31
+
 #endif
-- 
2.43.0


