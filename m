Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BB4CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfX-0007kO-CV; Tue, 29 Sep 2026 06:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfF-0007ZI-1G
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:21 -0400
Received: from mail-wr2-x17.google.com ([2a00:1450:4864:30::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfD-0008El-Bd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:20 -0400
Received: by mail-wr2-x17.google.com with SMTP id
 ffacd0b85a97d-4888598e4f9so2572019f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676137; x=1791280937; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=INN0hh4o6+2YKso9yD9XUIa0Z6UZ9zt13jPQTQszeEM=;
 b=QkaNbNvJjtHQYPD82DPOcdlno5vccJyPkUXt4PyGtQLYyEDmQmOWUtBEg4C5GM9IHg
 /MegtNzMT9GnjUUEgnzAkTiGcftnqRbjtdcl11xREr6S/O19IbIwzMsNAVGJpZuVMAlH
 zMcf8WaPoEVy4udRZgU88RkzRjdBttbhhGWYemwGQ6eJ5Hx4ifEnNR2knGPie7Fo6kfu
 ptc0OqMxu8uGUEhebUjBy1+xbm4gd5z5/LG7NOShFavSl756RrbPjZlJLW17UqWP5B9b
 Cmjlc6uf2b5kWvtd0PLFcax0h2rr2NsPiEECGxcEUYih2eKa7DJRsMLvWL13EhpgLVyl
 MdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676137; x=1791280937;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=INN0hh4o6+2YKso9yD9XUIa0Z6UZ9zt13jPQTQszeEM=;
 b=G8FteB0DwaeCMzkKbhiqPtOmpei6RnbhX1ml2RjTuf30y2RoaBrapKeIbeEtv67fcQ
 MjWgoMti/Fr3X8gVrznvsgDfeteBk9cxx3aoRJE1A5u6DiTfaKPLhivw+fRDJQbwHKB5
 MwsRWh4IPUkhK8XufXvO9xovC6NKjBfW3BJFu6aY37/fSJIue2kGcwIUrUS6Cx8ekJ+n
 d4qVmI2eE8PsnKnKrq1POS8OdLMW1w6jqN6oih+D03rD5IpU9a9MHRxWMt0Q3CSqO6gM
 BGkeyAQPit95aMztfRvYeMm0Yte0XgehDB9C31zAGiShJxIbprBwLRtB4Lweyw2zHFK9
 mShg==
X-Gm-Message-State: AFq9FYK8HTE5Oli7VOLaREwfJObuxSJxV2JG8rjzbl7/dBxRF3+sHeyj
 Uj16LMOIM/2Ys+McAn8/+/T0vLg8HZMxni+75ulX6AsRYYIa9SBk4TUsrUOm8aGv38w1sqjRsdu
 MVyCX
X-Gm-Gg: AYBFou0bad2r+VNc5zYtq2DEMj+GD6kKkhEVqXYXW2yIRracVIFrrEQZfCwAPOF9FCK
 TCCNBSesRNbZbzchDLhrKMOKNnhwQ3uyOLqlb5Ir3drC1w4SUf96v/WY3UVDT/eqSnHvFyZd/sF
 mLXCwM4zpsUJjYeaoAArfN2kXutDXjwFVbgycE5iEnp3RASsPEpDwrDv5zBAy6uB1gdxoFCPRuu
 jVH8O/jLWQETuuABOFUbGILlBo1egwjXnosvfi/w/qGrcUXbwtP6LS/8RxBsuxz6VJxxPk5M6TB
 5U/Ol3ncGhjtGjs69Ts69rAj4Dqq6rhHJnjwoqkNsE81KSxRQIYxvqfcBnVHIDio4vu8UiFXDnJ
 vl6cKqkBoPzpvNe7/zdNP7Ryswuk3kukIowqVqOLGfFBeHAVVzGOq4Ogt4Tpf1c9riubs77Lo6Q
 zg+IbNUXtX1oYPNdnP1/oir38sITvSrIPSN3yqrSRT8hpqDr5JSDKgGOxYbHKvfg2lvSYvgoyJ4
 3/0MFB7t0aWJmcYn1uEpjhhMh9LX3k2xcklC2vhta8WKss+iE0CrjDC1NlAq55v41y2SVaa/zC7
 b+M=
X-Received: by 2002:a05:6000:388:b0:487:27f9:833 with SMTP id
 ffacd0b85a97d-48af56cf229mr1703089f8f.40.1790676137537; 
 Tue, 29 Sep 2026 03:02:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/37] target/arm: Add isar_feature_aa64_uinj
Date: Tue, 29 Sep 2026 11:01:22 +0100
Message-ID: <20260929100133.2598676-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::17;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x17.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260925215004.456336-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 06318d12f9f..a9eebb45564 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -290,6 +290,7 @@ FIELD(ID_AA64PFR2, MTEPERM, 0, 4)
 FIELD(ID_AA64PFR2, MTESTOREONLY, 4, 4)
 FIELD(ID_AA64PFR2, MTEFAR, 8, 4)
 FIELD(ID_AA64PFR2, GCIE, 12, 4)
+FIELD(ID_AA64PFR2, UINJ, 16, 4)
 FIELD(ID_AA64PFR2, FPMR, 32, 4)
 
 FIELD(ID_AA64MMFR0, PARANGE, 0, 4)
@@ -1242,6 +1243,11 @@ static inline bool isar_feature_aa64_gcie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, GCIE) != 0;
 }
 
+static inline bool isar_feature_aa64_uinj(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, UINJ) != 0;
+}
+
 static inline bool isar_feature_aa64_fpmr(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, FPMR) != 0;
-- 
2.43.0


