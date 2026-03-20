Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7340A1098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYc-00032M-NV; Fri, 20 Mar 2026 09:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYU-0002uI-RS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:22 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYS-000639-Lf
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:22 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-668abc98923so1095740a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011979; x=1774616779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YX0j0axZ/RBp77GoaFkpFK0DcOPDM4tK+si3g6SlcZI=;
 b=MaDbjkF1uCgp9jobx3VNjHvK5FI4eeJpGjE25c9noHdw833vZjN0uRfYT+FiMECn2I
 ewVcR/xtQFpvsgrFFQh5jboM6sAlq4RyaevJkgrAwmwbT56KuWoMUhsJo6Qtf1HyZo5C
 GzyfrD7zYUPYDC5PJsX2OQM4dSoF7OihOq7fhF2EOIv4YNIlKgb/YaTSsCxj7+0CAfRA
 zFCoix1abd7Mt8FxnM091DJKmJ+vRTf7DTuia7Rq27WPYVn5GB7Ca9Rv98FGeVMK2dH1
 bSuOxnlehqzwsb9GwlgQOBMQLobOLh2lbuy/Yf6YC3KzBK7iPJ/mHaapXvoix16OJjq/
 PIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011979; x=1774616779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YX0j0axZ/RBp77GoaFkpFK0DcOPDM4tK+si3g6SlcZI=;
 b=iLYmopg+gqQ4pTA5xlk667u6XB4JSI+uqU+nVvZZKr948ctxyO1IX52gis+aNNznz1
 LwPdZGhJXdn5O9dw/fQ6mOaVAqXHRKpesJzMnxbc2tO6motV7Thnrn+YyD0KDTBud9PZ
 BDFp3fA11QuwSfKVwIzNahEJZGuXAl5FNqtF6K1iOtiHPuEwFEFTSeRUrvdjd5j2PA/4
 iOv0Ka7Ftb7+37jKXNKbcHScs6PktLqT3XnyF9Ge2+k24sQ0fT9EqwPkXs6RIayU9y6a
 dXnTOSxXyrgC/w/hdvgp3tbr61oVmT7YKJ8prR+TsLJU1Kko96rcbGUtGNWQ/cwyeSug
 W9KA==
X-Gm-Message-State: AOJu0YwKSBkZbJcEQ5/0+sa9d58hMCcIEz+M1h/0EsFkrjx+eLidVRfm
 NJyvtLKParpWv6ZkI3tzzEnewgfscsa9BIj6e9MmfHNHjeVJU4H45AVGGgnAb5rn83g=
X-Gm-Gg: ATEYQzz/x10TuuIOqEivRlryU8yFno5QXhLpkhRBqdteMGy0oHV66wxAZ3JtBTtY/7S
 4sVtPVzO8ifXzd7CMq6vE8nygJJfcdbQVgAEa6e9qNQbbrcYhcBZ+g4KVl2iq7q1WJLyH257/JU
 haWd+k3Nl0oU04SfTuv57suMz8lz54F0v4cZ7kgHQ3TJLkEDwjJCemeYWrROTRxPQRWMDF4eZ1n
 NzgNOU5+Mf+5pxdKpOrDuYfR6RNzRCRzkvGGa2AnkB/TzZorGQmmfvIocRvzRAGhYwb4Zy71ibc
 vG91/eGLrY/d0Y6EDxy9U1y1BnZssjX5sqBQZSNxJ6hW1rDENF+vrTPvz9qigikKJ2jRthl2+3R
 x1MbrOxMsQ6av09Aku9xoYcFRPxmXrGTg+IwH81iRWJk/LpQ0cWzQYjk0+N5eDKjGknJkNzQwxW
 0oZ3peSi0soxdTRFh2u991ZlOlWAjVnFQuMw==
X-Received: by 2002:a05:6402:3593:b0:661:3f3c:400d with SMTP id
 4fb4d7f45d1cf-668c9c52289mr1939771a12.26.1774011978838; 
 Fri, 20 Mar 2026 06:06:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668cf7e4048sm1334074a12.9.2026.03.20.06.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C7AE85FA3D;
 Fri, 20 Mar 2026 13:06:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 25/35] target/arm: redefine event stream fields
Date: Fri, 20 Mar 2026 13:05:56 +0000
Message-ID: <20260320130607.2071996-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h | 11 +++++++----
 target/arm/helper.c    |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 8ec27508473..2296ac9cfb6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -263,14 +263,17 @@ FIELD(VSTCR, SA, 30, 1)
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
@@ -280,7 +283,7 @@ FIELD(CNTHCTL, EL1TVT, 13, 1)
 FIELD(CNTHCTL, EL1TVCT, 14, 1)
 FIELD(CNTHCTL, EL1NVPCT, 15, 1)
 FIELD(CNTHCTL, EL1NVVCT, 16, 1)
-FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTxCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5ee79f7564f..ba6db46d453 100644
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


