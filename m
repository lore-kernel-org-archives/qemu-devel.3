Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123E4CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfP-0007gk-5l; Tue, 29 Sep 2026 06:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfD-0007X5-RL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:19 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfB-0008EU-VZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:19 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4887f690df6so2834885f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676136; x=1791280936; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CVMbfBRTgqTQ33sLJtqxsxmOZUqoGFBDApKeck7SUbg=;
 b=vnTIKsTueF+aWPkTd72agy9F5B72OZvNWcc+RnQ+U9cKmktnu/m15SHlbIDS6488B7
 UseUkhBn1G3w3ZkB3JuIMq7gnDW2EZtNEEKCI7lLWmSGbwk56gbZx4YTJYhwOuSXFABd
 8j+8BC5RzsafCbeYjb5TQnhTvNfGMr0vOBaniLLn2vPcJcLfkUgreCKgF5X9zu28K0hV
 hYqvsEW6MnRWEXGuL0Tr880W/CY3WjI2D2QlSJJN3ftISAHXSVNXieb9yBf7aaCoe2Gy
 +ge1QkVBIOH30hwftHBX63o2gazISMdE2i2WXxSLme8Cbjd7A4qhAuzx/i3cZjQejN2y
 4syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676136; x=1791280936;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CVMbfBRTgqTQ33sLJtqxsxmOZUqoGFBDApKeck7SUbg=;
 b=rAA/ZnDhH+1q15XSrEh9TNd7qU82gI5BRKbV4iDe/iLRKxfPVh3IG+8eekm2BDMU1W
 5U84DsvWmX30hjD0Y7e/lhYR+tQG1HFIsK3bD3mqGpz0fK2smuesnyuyFWRjaHwTb/5u
 4Zmqa4hdvSkiovxmrFVDdBwkRbTercM0ouHJYn+Y6PJVcAMT2ScG6dU+ToOOv6VsKp4a
 zPjuAHkTwlZX6pj+TqZkSD33iK7eDLqCqh+fQGqx9m66mdCgAgHIlh62oxXlQUoKSl6S
 H6fOrHRSV19rGIwVMXhesVgy8IzvSD6+hWINp/tDhcX9K/U6IFTiAeIDo1VhlfFg0JJ5
 0mVA==
X-Gm-Message-State: AFq9FYKn+kftEcrzDXXxD3lhr7vwQOTKUQ2xWCQpxOkr8bFf+sIUK8+b
 NRW/UVschoNUUUxD6pkKg+n7pr4aje7lPsaMYuZwFvgMvEw0ljlwXJ5bbmxYBMORQq7FSJIdQn0
 ATA4D
X-Gm-Gg: AYBFou2h3XGkxS5rGDqtORnE0P6c0BSTqZ+UQmuhPiCx3ARitvAP77aZBBRclfct8Xt
 JlUlPn3cldBhDVJW9UGdV/nXDKigvLzvJM+iRxD5ypq0gqKy/QKTXKCZ4jyp6kMPuEfmWDR3yFW
 ZAgeXScLlsqfu46lITclegZZzvockzK1YdvlyJ7/45IdlVgg6mJN+om7X3tk76jbw5J5JKoLJT+
 fHCvTs2LpXKlZJeAgOhw1wsX1GLob3xYSxpoOLdQbXCNi5Ee9ZcxQfSQcidkWzQgolesaLFdU2y
 +eh0g8mVhiiFxmpZFH9vQxhXu+Atdw7HU3UwVUSREWdVuvCuPHOcYK0NPBrOb3K6EVI8M2c6tEH
 tkuomnhjY9JCZJkdGMpREoKyKfAdGiFlt3fsQKEBbAxSsox51lhy7eeQxvz8//65lQqg6+OFQ14
 Z7iQXpGzhfRlDiGxHCZEr9ZGyrn+/Ahu1hoarIwvRsG/kyGiE0MTtDtCdpWvYver+8lruEJJqCg
 fHvdTkrrNMkGe6ouGLiA/p4hLGcRSTre1RaIVpkPknI1woKij0A8fjwK4IWzuxxeE/6N1ErzfDD
 90A=
X-Received: by 2002:a5d:5d10:0:b0:486:f301:11df with SMTP id
 ffacd0b85a97d-4887166d9cfmr34568997f8f.6.1790676136359; 
 Tue, 29 Sep 2026 03:02:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/37] target/arm: Move ID_AA64PFR2 feature tests together
Date: Tue, 29 Sep 2026 11:01:21 +0100
Message-ID: <20260929100133.2598676-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Currently the MTE feature tests are clustered together,
but those are spread across two ID registers.  Sort the
functions by ID reg and bitfield order, like most others.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260925215004.456336-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index eecbc3b889e..06318d12f9f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1207,16 +1207,6 @@ static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) >= 3;
 }
 
-static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
-{
-    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
-}
-
-static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
-{
-    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
-}
-
 static inline bool isar_feature_aa64_mte_mtx(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTEX) != 0;
@@ -1237,6 +1227,16 @@ static inline bool isar_feature_aa64_gcs(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, GCS) != 0;
 }
 
+static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
+}
+
+static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
+}
+
 static inline bool isar_feature_aa64_gcie(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, GCIE) != 0;
-- 
2.43.0


