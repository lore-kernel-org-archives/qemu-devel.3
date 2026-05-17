Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF97ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPm-0008HT-Be; Sat, 16 May 2026 20:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOk-0007Dh-MT
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:31 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOf-00051q-Nh
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-83ef1d17904so1078134b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977820; x=1779582620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wl6+4I26v8HYA+JJlHEMinIiz3qcncuhnbxRtIcqZ1g=;
 b=vhy+qo4t8cACiidz1/LgBP3W0ZSUqXJJB06eclbYEG4/LrrKE2FCNtblUrH68pg3ao
 KK/EjaNbgOsEmZgSSZyu+kDCscg1xAHbi0DffGK9zgdkEOsDF5RfZYnzWUotHvdwxADo
 T1xJ8Ya6TeRnYbY9JnLUTLJJY0WsXfd1aL6WUQtY7lbMHXLV2DtZKK281Gxu8U2BXW1s
 CcDAE4YkPp/hVyyeZYibGO0iyRdA/pOypHjDIwK2TC7wHgXv4zGmJlDZAIUT7m3xHGiv
 wfcbK12vKcpMP5KPOyNLjz4l7DtZgWxeTuq7YKzCY+KGZl823CKQJLZKJjSTH3ehdbf+
 ZAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977820; x=1779582620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wl6+4I26v8HYA+JJlHEMinIiz3qcncuhnbxRtIcqZ1g=;
 b=HtFMhT1sT+6YzTZyh3l6+MVAMaHQfCFupFawsTFQCO4/IZxGETCQu8jYA0top4gOjq
 zNL4idcY/dlglrwniidnnrjILDuNbEVeJz8A5RBNvjkxoAlhVJULLeR7lJ0EX7bsc65g
 S0SjRRF9R7BTmx14Fw1tFhB9R0w5ccYLym/BbqCTvmTviuBwKXR2kYT57f3gJGlrjJnX
 4Tz8Y8DoPLBreEztcxV3gXFgBPBqBVWQ9OOGwkrjpgDnVjLrvwx5/gQgieMLn3tdWs7u
 U5cKA72l2jFeneoIbalSYUgVI/A0+IYhKYOHsKHhj5FWq+CmGb+vhWRurnn6PG2QcLZQ
 vggQ==
X-Gm-Message-State: AOJu0YwR2KFGxMsRGjTkHVK14V2wIAwPmZ7Mk9ShYAKkzFOmxvzdrFbC
 QBh8FP3HDWMSzj4Ffx75pddj8qbTd/3nGwDx65xkuhqzYZGAmW0P3TSqE1nKxtMTzQK2dmRSYma
 HwKq3
X-Gm-Gg: Acq92OHZiPOOOWi1mRGio1ydgDFF9dsXQ0J3MQuTy+qe4m+UdHA2U1o5p/PU/qAHY3j
 /6jct1x73t8ukJKdiSZLyh/dE+v/gnE6ttfJTPCAJXajZb3KjN37/GNOwJmKm8i3kGculuss1sQ
 ScMLuHxMwV0kJzmylB86Cibl6dd6YSqCd2TJJMpc5TJ6slwri5U7dqTfGrI8qQiJUSr1b9rI51e
 b/gpREndmZpXJXghR/Dpb8We9u6I0UDpd/L96UqmH8gZhRHxa15nyUWUhoHmEXPBMwu3MLeXYrL
 hSJijTfPMyUntTq+/RiO6piBLbMw9xaDQfPEkBQULCmmWS4pLDCVA+/s7OeVZ8SRBQ1JQ/S+kLO
 XaOcz+L3J/ygrkrsg9PwE1VMqDClZW4FvUt/L5uWgBPez7+YSXWJ1j6cRxnSfOu2WIMLZZbX2E4
 0LE0FhTncwkJvP/DbMGFX29+Vx1xef
X-Received: by 2002:a05:6a00:3014:b0:82c:dfea:9e2a with SMTP id
 d2e1a72fcca58-83f33c4d95fmr10807174b3a.2.1778977819880; 
 Sat, 16 May 2026 17:30:19 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 18/63] target/arm: Add isar_feature_aa64_f8cvt
Date: Sat, 16 May 2026 17:29:17 -0700
Message-ID: <20260517003002.321430-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1bb77d78da..1fde3e9231 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1569,6 +1569,11 @@ static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) >= 2;
 }
 
+static inline bool isar_feature_aa64_f8cvt(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8CVT);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
-- 
2.43.0


