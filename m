Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9CFCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOt8-0008N4-9K; Thu, 30 Apr 2026 06:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOsy-0008Gh-90
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOsu-0005KK-70
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488d2079582so7547175e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777545878; x=1778150678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RsPS9jH4wqzZMo8K63vD2xS0qPk68eIqWMM62PQ4Kyc=;
 b=GkYLoU7RzlX2y+q+NIgdbpvcvv1mse7E7j+W+kTbYrygyVEsy52tupqqaQORYxTsK7
 tBL9SvROXHArEZW5wz7ipCfQCCbWQTLHW+Ir14kcyoDVIxSm9ph75bb6MWZFlINCMupo
 jETcsXOpEWQ2MSvYVwZdZmXYqOxh4/Yo0+v/9ve0s13WgmzOALup2vPHQ6D+JPFXCA51
 oWFroQZtSCwtYJqC7ZQ0udybSftv0aHmrnLNxrVM4xg50NETlb6DJxJGSzzciPpOGPNw
 HVJ27uK+ncv7DxHbgZidU4uRGlqwzzOSB49kWJ6+jJBm/C6tvh3fv4RlDQzrqcmzeR1R
 9QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545878; x=1778150678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RsPS9jH4wqzZMo8K63vD2xS0qPk68eIqWMM62PQ4Kyc=;
 b=GKAsTwovmPhEmGKuvWXk2pD8iCr7BZRRNVzj864Vy3rlyJNd0i+64Qlrsru7yZ0bMe
 Dm6Tqlo57suMTHu5x8Zq/q8P9O6hTdTesHmBdgd1boxjomW59MXZyEjTJDSlq4+UZwZF
 vW6b56vHN3Wz9SwXbr8vEsz5nH0us2Ae9FgH1+vR0t4baCD4TpMJ1qymzJZlV+4cHdPI
 9BgHO0omdZ1z/oQYSVM/6nWHrmnzdsrSLY34yW+RzJKxUxkjJe0wR6vN966UPc6WJj4l
 DXSH/kKNiHI/5fD8KZf6TZMd8P2plnpBGA0eG1UyNL7k1euavxtkFN0tclqBpQt5KfqN
 9T7g==
X-Gm-Message-State: AOJu0YwZYiuq9189bycak4IY94Q55aVzTyS+3oolK6EjFp55Twyo6iml
 7qa3Ls/ToNhR/E1s7LxlF/094qwu70q8w45kN3GEOCwK+f9pzxg9wroeKSnc89esUxs=
X-Gm-Gg: AeBDiet0R1Bq+lp7epZqgHcPBrI30heIZ8DWdb/BmiZbCEAyQz9lGOzSDCxkAm3/SeL
 XYVP8ikxqL+8pAyImuvAHKHk6bvk3YeiyeBxr2xpbTYRZ+MPDF+R9xDV+ofdHLNreVJ0vHR1X52
 ocfZkVWBLxinasleB/cm2lA3NnsCF1bnQnXBFJA+qEIAlD1Gm1GIpWRIu5dGS57iJXhYJLGDhKn
 ubHf7JcrI17sPzleo19Ts4Mb9xvLfacVt/7nN8NcbjfryCKA28BVTpCh7+Mb0d1dkLfB5AUByUw
 0WYhfbe4YQqx0hM92gX1jZsOOfiujnotNlegKG8AdubrNVI6vyVarvloW7TpLBvvqln6Ue8JeQK
 QDQe4eY6QrSf7dARC1eqhs9zpzRMhlLbX5WW+kwCEQZhNkvZYg42QESmEHOvjhxrDD0uMuAE9xZ
 NSIo3Jp6poBg7fKTI+CbDnI1DLi7FzVzAJ3A==
X-Received: by 2002:a05:600c:45d4:b0:488:90ac:8f71 with SMTP id
 5b1f17b1804b1-48a83d66cd4mr33804835e9.5.1777545878132; 
 Thu, 30 Apr 2026 03:44:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b912869sm40905485e9.6.2026.04.30.03.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:44:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F21705F932;
 Thu, 30 Apr 2026 11:44:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 2/7] target/arm: redefine event stream fields
Date: Thu, 30 Apr 2026 11:44:29 +0100
Message-ID: <20260430104434.1482407-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430104434.1482407-1-alex.bennee@linaro.org>
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

The event stream control bits are the same for both CNTHCTL and
CNTKCTL so rather than duplicating the definitions rename them to be
useful in both cases.

We will need these in a later commit when we start implementing event
streams.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h | 11 +++++++----
 target/arm/helper.c    |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4a1ea5465d7..24423a200ff 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -269,14 +269,17 @@ FIELD(VSTCR, SA, 30, 1)
  * have different bit definitions, and EL1PCTEN might be
  * bit 0 or bit 10. We use _E2H1 and _E2H0 suffixes to
  * disambiguate if necessary.
+ *
+ * The event stream bits (EVN*) are in the same position for
+ * CNTKCTL_EL1/CTNKCTL.
  */
 FIELD(CNTHCTL, EL0PCTEN_E2H1, 0, 1)
 FIELD(CNTHCTL, EL0VCTEN_E2H1, 1, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H0, 0, 1)
 FIELD(CNTHCTL, EL1PCEN_E2H0, 1, 1)
-FIELD(CNTHCTL, EVNTEN, 2, 1)
-FIELD(CNTHCTL, EVNTDIR, 3, 1)
-FIELD(CNTHCTL, EVNTI, 4, 4)
+FIELD(CNTxCTL, EVNTEN, 2, 1)
+FIELD(CNTxCTL, EVNTDIR, 3, 1)
+FIELD(CNTxCTL, EVNTI, 4, 4)
 FIELD(CNTHCTL, EL0VTEN, 8, 1)
 FIELD(CNTHCTL, EL0PTEN, 9, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H1, 10, 1)
@@ -286,7 +289,7 @@ FIELD(CNTHCTL, EL1TVT, 13, 1)
 FIELD(CNTHCTL, EL1TVCT, 14, 1)
 FIELD(CNTHCTL, EL1NVPCT, 15, 1)
 FIELD(CNTHCTL, EL1NVVCT, 16, 1)
-FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTxCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e7677a584d..dfdb77a9fe2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1746,9 +1746,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint32_t valid_mask =
         R_CNTHCTL_EL0PCTEN_E2H1_MASK |
         R_CNTHCTL_EL0VCTEN_E2H1_MASK |
-        R_CNTHCTL_EVNTEN_MASK |
-        R_CNTHCTL_EVNTDIR_MASK |
-        R_CNTHCTL_EVNTI_MASK |
+        R_CNTxCTL_EVNTEN_MASK |
+        R_CNTxCTL_EVNTDIR_MASK |
+        R_CNTxCTL_EVNTI_MASK |
         R_CNTHCTL_EL0VTEN_MASK |
         R_CNTHCTL_EL0PTEN_MASK |
         R_CNTHCTL_EL1PCTEN_E2H1_MASK |
@@ -1763,7 +1763,7 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
             R_CNTHCTL_EL1TVCT_MASK |
             R_CNTHCTL_EL1NVPCT_MASK |
             R_CNTHCTL_EL1NVVCT_MASK |
-            R_CNTHCTL_EVNTIS_MASK;
+            R_CNTxCTL_EVNTIS_MASK;
     }
     if (cpu_isar_feature(aa64_ecv, cpu)) {
         valid_mask |= R_CNTHCTL_ECV_MASK;
-- 
2.47.3


