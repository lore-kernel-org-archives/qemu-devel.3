Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CAACD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11Z-0003ut-Um; Thu, 07 May 2026 11:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11Y-0003qw-Eu
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11W-0003uJ-Mn
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so9827265e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169145; x=1778773945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9oGVwfR54uhD8ZqlC1hsQ13c9LMwPv+Y80P0CRoZjqE=;
 b=bFmEJWOANEAXF+hsGP/Qr+fpAxLsF3Z33EOyQeTJKsr/32N086UlfyWFEbJqHIZniD
 sqdprcdM86c0Stg8n6U9rKyVgUDfAn2sjpbb5MoTxiXS1RFps28mrf8HV+YALY0bMDya
 0hO2z3TaxrG6DSnihPOwVOHk17lnAhfldNfyrZwT0I8v9yfvWtNgUlD1UfDHsysQdoW+
 I9ihpaQYQn3TXq6S81gpvHLTJDnGyxL1VALvzLfPHlULuYKYBqLH8CgV7vwCUaMdytHH
 hOTzmgR1LBj0l2cwVPjMWDyEQ4XF1U5zJga/0qQ0/3OdJZbhc3/D+u3SqfvSuWrfNYmS
 edyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169145; x=1778773945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9oGVwfR54uhD8ZqlC1hsQ13c9LMwPv+Y80P0CRoZjqE=;
 b=RS7SWUNOUx/UI/4kSE9txheIBADc+l8EbLXsoBnaQYSAyA5mVzRCAdY6PPUKIn3XQN
 URJ6aiwK5+XJrwTOGLB/InmIj84cN69RUXrppTS+Hu3+4ORP9TIoCIlC4y1pNCplJL4p
 eat61c5BYuZMVq60/v+646V+OR+e1mDVhicHY12D4eNxFXzDpnBH1rUwHAfFx/WFQ/4U
 jK6I53Nn+RxUBPv0UG9KUIWbFNQ2qerIdlP8teI+54VGeWFCfXokAS41N/e9JhcDi5ff
 gXoJdDxx4sqtLwP7eb5C+JYbr/T2DcnAtSONAEI+/nY07b049TLrTY0Esj99rNSH/IAi
 IjkA==
X-Gm-Message-State: AOJu0YxLo6HB1/iZkd1jo5ZHAS80OdHVX03rN0eHUInFI+APaoBT74Xt
 YK3l0VZ5cFPROwYgJXF86wuLlOTWpU4+zjAJqgA15Y+7QY/DPK+DE3xmL1tWtfOkBUZhIZqs+ag
 wYLKQ
X-Gm-Gg: AeBDietL1XiHFk71sBXCfCnWQxDaadamZN28gJUlMt4UpgXW5tPZ9dajJWhhHFzxq2Q
 04FHpfKLSMHcCC6u/sKzQV5tjwiOuKNcvNcgEpae6+z0mTgJTRKQfuwLndQrek2TIEh8C4LmZtQ
 126oh3fImPdppJ2JSNOcINAjZk/6DmHkPk1XF75IWQQynPVTDlq1bBKprRhEumfNr0NKLzHRLQS
 /g0Evkd3x5EUQFbPo4un6OvuDL/Mvhb00vvOXm7qyGya0ybKkAKGJLtHieiVMgdVf3RgZYQQsib
 UYqQNTJJCarZP1QsELpa8FVjbCc5sZ2+UX93WXrTk4LciSDb/znfNnLrlA7Up+o/Exm+EysIt8X
 YZ7XmwnWMMjdGt+hP1U/bY/l+X6uQ9vfxkdrwbJJ0MqRibmwHSURaxF7EzQEOdve5lH8Ae4Oqpn
 BhaQrstGv46PGl+4CJZnQFi2bRUU4I4rYu3sOy3cDCmfIwjlK36d/YyD4/7H0b1Hoc6aMTettVO
 vnFVsc+jUZtSmix
X-Received: by 2002:a05:600d:8408:b0:48a:58e1:6d17 with SMTP id
 5b1f17b1804b1-48e52bd4f17mr102477975e9.20.1778169145211; 
 Thu, 07 May 2026 08:52:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/67] hw/intc/arm_gicv5: Implement IRS_CR0 and IRS_CR1
Date: Thu,  7 May 2026 16:51:16 +0100
Message-ID: <20260507155154.1886557-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The IRS_CR0 register has the main enable bit for the IRS, and an IDLE
bit to tell the guest when an enable/disable transition has
completed.

The IRS_CR1 register has cacheability, shareability and cache hint
information to use for IRS memory accesses; since QEMU doesn't care
about this we can make it simply reads-as-written.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-30-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c                | 13 +++++++++++++
 hw/intc/arm_gicv5_common.c         |  2 ++
 include/hw/intc/arm_gicv5_common.h |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index bc887233f5..3f397d9115 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1080,6 +1080,13 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         }
         *data = v;
         return true;
+    case A_IRS_CR0:
+        /* Enabling is instantaneous for us so IDLE is always 1 */
+        *data = cs->irs_cr0[domain] | R_IRS_CR0_IDLE_MASK;
+        return true;
+    case A_IRS_CR1:
+        *data = cs->irs_cr1[domain];
+        return true;
     }
 
     return false;
@@ -1159,6 +1166,12 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
         trace_gicv5_spi_state(id, spi->level, spi->pending, spi->active);
         return true;
     }
+    case A_IRS_CR0:
+        cs->irs_cr0[domain] = data & R_IRS_CR0_IRSEN_MASK;
+        return true;
+    case A_IRS_CR1:
+        cs->irs_cr1[domain] = data;
+        return true;
     }
 
     return false;
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 607b99c2ac..69622e41c0 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -64,6 +64,8 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
 
     memset(cs->irs_ist_baser, 0, sizeof(cs->irs_ist_baser));
     memset(cs->irs_ist_cfgr, 0, sizeof(cs->irs_ist_cfgr));
+    memset(cs->irs_cr0, 0, sizeof(cs->irs_cr0));
+    memset(cs->irs_cr1, 0, sizeof(cs->irs_cr1));
 
     if (cs->spi) {
         GICv5Domain mp_domain;
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index c5a64bf86d..f259d2d642 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -86,6 +86,8 @@ struct GICv5Common {
     uint64_t irs_ist_baser[NUM_GICV5_DOMAINS];
     uint32_t irs_ist_cfgr[NUM_GICV5_DOMAINS];
     uint32_t irs_spi_selr[NUM_GICV5_DOMAINS];
+    uint32_t irs_cr0[NUM_GICV5_DOMAINS];
+    uint32_t irs_cr1[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.  Array
-- 
2.43.0


