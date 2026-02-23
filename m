Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBDAEC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKe-0002Kd-3r; Mon, 23 Feb 2026 12:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKd-0002JU-AW
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:51 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKb-0000Ee-7R
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso32334425e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866167; x=1772470967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OWTRxMPzfjQP35RbB57Fpzqp0nJNEuo2Ib1GI+1oX2E=;
 b=W9pq+A5OG608byHUyTRn25o5ANgAxZKoD4SjkyB9eeKIADm6u4f6LnusTmj/XC66ns
 cIl1srlD6WnFJB50eg4RUnlbfLll04QqEMqIracqTCsB/EEXmGPGLb5BIRkzZnratQsE
 R0UT95eS/iHrCu/jv1bZWiMGvJMGrmBlEsgUN6/+ZLzoSAnLJ9r/LaBc57zKNcdIZoId
 tMPxjA9jMvp02jQZA7ZiCAhfsrkE9DVYHhFP8MWkdrCWYOWmBdUJO8twUjcITktVppqb
 htPx5vqVtr65CR8i94YubFM00JRj5bKeiRA9XsBBf53pxZmWIkEarXruTz7D+XST+DNJ
 Bmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866167; x=1772470967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OWTRxMPzfjQP35RbB57Fpzqp0nJNEuo2Ib1GI+1oX2E=;
 b=cP0W2N+WYMGxjvZ8DXnN3M4jCUNLJr6ppu1bruFpE/AhmBIChSw2nyfNhbWeuiZMqw
 udaCm6Z6+JDJnpiDGXZyJUroFHDf2qVn7Pan4Qi1j41j7Yql7DeXQ+LshfDv6hiELX5j
 Q2zTS5rvwSiGyhWHzI+Rg/pBqK99QmghTi54/NJ0Ycssqcto4+QXo6jzGHWAVGU1lWW3
 su82yv6xHfB8jNvfeYO7EgUHV7qcyUikL+bDgs4m8omFI1IBRR4P6ChtwZ4KlXAfDRne
 Yp0w2+mYhTSJVhlAJ4aHInPTRbuA0sFVQQsJJ7UDGPV8/eo15WKr1Rg7pNK4jFxRsojm
 gyQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvtQI96+YymzMsNPhIjeHDFCKvygL1X2Uyqf3o/MFNYCYV39ZElTm0G91NnZZMUCfMYo0pZRaEezUK@nongnu.org
X-Gm-Message-State: AOJu0Yy1tq2MtzuzLVpxKtMl+i4icPU98krxqnz2nhmSnOYVQA13fW9g
 XlLldtlgE7JQrgrUbkorIyCpNVZj3lh2a2EuzYD02KvDveToxsQHlz90DLZ/rJuI9sk=
X-Gm-Gg: AZuq6aL5jshhl5jQzmygaZ4u/cQq1ZHG29qUqfQIIi4+3LrDiw9S9YPEGKyF0cDmC6I
 KNHEv4beRajlVLTxX+5N7py8Pp+4OYAWWl8Lb8O4UExeOi9d0nmJLBsXc13dL+s995Qgq94WuB6
 0Qn2/b+26dJwEYDKK2nhkfyKCo/bCRnf4i/wHRgZoZ78N8CAM+CFvbIKGLAsSJ7OC0vGF+HXoqx
 vWJG5S6TN7QfHVL3OPmL1G4BE33cE8DDEIOS3qqfx4qlxK3n7CNsrC5GsqrPEUpW8mmiQvBCHEJ
 VORLzNfb/pR0lv2rhiy6EMeR+PGf3apeyQCIXWLdfkgOrrzhxSTyzlhe9ELh2C0N5iyfzCZ9FUL
 BDp12vNbrFlqvhvAjSUtPewWLVbu3DSvrluqK/btyj940692xHTDKoWDiqyAkH/PzJJ+WLNrDNI
 UQ1WtECHGz41nCwoWIaYFWFQT1dfUO4Mebm3+5lDsN7qp+oRjJAj6Z8lWP4YR1orMeiyM5zO5mD
 9m/fLIyDu17jcL01Q271XOxxcN+k7Y=
X-Received: by 2002:a05:600c:c3cc:20b0:483:afbb:a064 with SMTP id
 5b1f17b1804b1-483afbba23cmr77215115e9.1.1771866166714; 
 Mon, 23 Feb 2026 09:02:46 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 28/65] hw/intc/arm_gicv5: Implement IRS_CR0 and IRS_CR1
Date: Mon, 23 Feb 2026 17:01:35 +0000
Message-ID: <20260223170212.441276-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
---
 hw/intc/arm_gicv5.c                | 14 ++++++++++++++
 hw/intc/arm_gicv5_common.c         |  2 ++
 include/hw/intc/arm_gicv5_common.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index d1baa015d1..5f4c4158c4 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1040,7 +1040,15 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
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
+
     return false;
 }
 
@@ -1118,6 +1126,12 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
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
 }
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index e0d954f3c6..b358691105 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -66,6 +66,8 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
 
     memset(cs->irs_ist_baser, 0, sizeof(cs->irs_ist_baser));
     memset(cs->irs_ist_cfgr, 0, sizeof(cs->irs_ist_cfgr));
+    memset(cs->irs_cr0, 0, sizeof(cs->irs_cr0));
+    memset(cs->irs_cr1, 0, sizeof(cs->irs_cr1));
 
     if (cs->spi) {
         GICv5Domain mp_domain;
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 5490fdaf8b..00b1dc2b45 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -85,6 +85,8 @@ struct GICv5Common {
     uint64_t irs_ist_baser[NUM_GICV5_DOMAINS];
     uint32_t irs_ist_cfgr[NUM_GICV5_DOMAINS];
     uint32_t irs_spi_selr[NUM_GICV5_DOMAINS];
+    uint32_t irs_cr0[NUM_GICV5_DOMAINS];
+    uint32_t irs_cr1[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.
-- 
2.43.0


