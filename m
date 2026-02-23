Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB32EC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKN-0001Va-LU; Mon, 23 Feb 2026 12:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKK-0001RB-AH
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:32 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKI-00007c-Kj
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so27425535e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866149; x=1772470949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sngzmWpFYqov4tsRiPEbrCo+XLB7I8a4AeFdOGirVho=;
 b=b46WDa7qPdAvTMHuoQPVU2eKaCo1w9pMyO79mXtdbEN+PggUqVE36pmuTC0AuWiFEQ
 0FaO6hLG5c5THhJNOes89tmbTEb3Y9+29dXe2BZrWPng+BE6oTptcWKuXnsTAxTeYD2f
 vHu0/gSDE2npYNInWkYcx/tkYCaTkkYF2X93OsgXcekqjaqRlKZwCefnFU9Vr6Olaesj
 eYl8tD9bF28RsgMUFrICKTYq/COBPKvHkzvWK2D1kUtQD8UkzdQuCmupVjis6Wi6f4R/
 Ur3UMhNN0wQnbYz+1iI0S0nPTM6gLqux1TEDLRs/IhMzqg9MnrEbrC0cfl3rA0uJLJ2l
 UGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866149; x=1772470949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sngzmWpFYqov4tsRiPEbrCo+XLB7I8a4AeFdOGirVho=;
 b=hj0DH5ikQJs/V/Pi57XM+HDPuOi5kn1BbH78xD6wuLj2Kc3u5MPz2Rw5sNDvwPVRWB
 cOASWx+bP6dpMUh98c6KcGnI62WR3ErKez0Q88D+DV0H6QPqNWUz8HhOnYAFxAfI2dpS
 i6zssFv9UL7MeCNwJU+/SWmZwriWQBeHDTJ5fhgtPYuVimb7mQM4YnBpJg32/QQf3tGX
 S5CiPsi4dMlhaWK+Tr75kTkxRAMynPtdpus813dwSZ7k5yeR9OW5tm+z2av38YE0ndoG
 Avo5wpQ0X6Sge2wSsW/gyCsxDaOTqxSKVLXi9Ppff16tJtm8wf3hW8Dh4jlT+t4dUpvy
 zMrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULGl6eBxd0uBc9QRLr6H+/MY23H+4xnUCY0UVu9Pb/F3jm8NBsrblZ/LAwxt/TuCYP1NT36CJ6PkRb@nongnu.org
X-Gm-Message-State: AOJu0YyV8QdBzW0k8WN0YUEaZyZle114IRO/5WdWpi+VX1ZjMpX1VyNc
 uUOsSgTEhswVkBP9UcSso3AfgLFzFcoK7ecy8G0ir1TGkpf+oenoijx9liVwMr+XSdOVC0caVJo
 ZgVPY
X-Gm-Gg: AZuq6aKoM+DsQ78n/AAlvrL1cnIPI1CEos1K1YU9wvl96qOGL/AtfmpAqMPPfRzJfOA
 pmQTrXsuy+jScJzVaaz1pZkLrboXUrVGfKMYsQvv5JOKZ79tvd/DT+grrvsVEXQawO8aKX7u7cv
 9vEJoxN6FI+vEtrlyjB7EUaZYdr4OwqqmChF3AHqB5zHJi5eWg5Kr5sGDbMPPUPV4MjhFhdrlup
 1A0DQ4Ld/20ZMcKbXhlvSphnfY0WZtAX04yKuv2tpgzY79vijVmk2HKs7/rBiDu2UShNCxnItlf
 w6fTpxibmiso2hT5d+Vu7CPSVTAwuAwLLK4ha1FY/ydsHTUJdNn2iAc0Otc5bzfMSMyEQb/Up/H
 cpGJeCp1UfWMPB1PgNkLeOeHlHKmviY1y9YW4Y4rvBon4JOZHZpvUL4s69kWcQ3Zmd/wzhyE36h
 Ud9NnjEymB4OKKvlHRlAvOY7H98B7cnei2Wzl/arw3acgbqtqaVtfdSLCgOxyHmhq1HKWiZpzSJ
 FAYvA/qGn91y7Z7bdH6ePWEjPe9YY4=
X-Received: by 2002:a05:600c:6211:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-483a9566b78mr139437995e9.0.1771866149008; 
 Mon, 23 Feb 2026 09:02:29 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/65] hw/intc/arm_gicv5: Add defines for GICv5 architected
 PPIs
Date: Mon, 23 Feb 2026 17:01:19 +0000
Message-ID: <20260223170212.441276-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The GICv5 defines architected numbers for the PPI sources like the
generic timer and the PMU; these are different from the ones
traditionally used by GICv2 and GICv3.  Add defines for them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv5_types.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index 143dcdec28..9c7788b1e6 100644
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


