Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44822C61DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x052E-0002oA-Tc; Fri, 28 Aug 2026 18:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0529-0002lp-3v
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0527-0002In-51
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:48 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2d72ae08fa1so13559735ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787956006; x=1788560806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JPL48k+kgX/er3dbBwM3QqTUUWWWeQuTkLu4LhOh8Fc=;
 b=n+I3Maf4pC/FHSPJiMMZtXb4HJvLQgSsOc89dUvrWdOMnmzFraB6tM6YBL0ZW0ciyO
 KBBSupK3ZovKlnPLpC6OawmoCv1dOIkujIFcUPwQvvUVuv9z9qfs0VhKjdWZOXwZyk/v
 BPYpgneNKZCbyt/+34WKYntvQz2xJq47biduTpS5MgEiF/UFO52qO9RwNkYMW5uH+OdR
 8Mr1WN8xYkrjfTPA7s/nz4mqA+Ha93t6nzvKMOr8v8dQ5BgtO5YTBO+OcJODjm3bpWZN
 KkQ0bnMc6nGDhzFHcB06y/f7zcw/Tcyjub8cSwJkEPs2Zv9LPAk1bojKpgxroER+Ztsi
 tFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787956006; x=1788560806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JPL48k+kgX/er3dbBwM3QqTUUWWWeQuTkLu4LhOh8Fc=;
 b=lTlisYpZ/RYKsSL0pHvRstv7EXdtfbXvNpdfPXllwcwfNI+YTj/rGUoDvqHKxxM6yf
 Ujjo34200BCvAz/dOolJrJZevpPgjzdBxVVdE2xVQHWUhPHpfEvQXVoEKze+zGsVB6si
 OEiaa2QqKUQ/AV2txvOz9sHiEgnmRsG9BEahdZKO0LXUKLb3U8kOrOgrLddegjsl8is0
 7JdOmSybHUX7bIXDHLHQabhpl/au9e3iauBPKduR3VxFdEjK/ZJPFxk69xVFGr7EIvAT
 A1tTbekhfCn2gvYZX2E3itXuOKKhibTsRwNeNPjHsp0eBZJUaVL84GcyA65QkToXpmMD
 aJ6w==
X-Gm-Message-State: AFuF++nbv0d1RRxzlPDTPjT+F0uBShm563jWh7GSSEki5G1ksuZ6UZF7
 Go0jgbjfHuCuoV8T9jeVoh4YJl2HnLJ776hDRnqDQkmS/aXO6s6EXfNmqelLrTFPg3Zxo1cHoJR
 buYmhWoo=
X-Gm-Gg: AYBFou23YtMgzWvKjrGqiwSXpVUYtMv63/f6IfEJHV0dbUJ38Qya2CLkaMbsRZ0IDDg
 KDy3SvAHJEidy4pjz4WVHA2pmIkoWANGJ3YEvL/E9W+TtI2JmK/emJMMP4a1/Op7aMdR2Buwr1+
 IUmkFCi+uemZdGy8W2unEz8QnwhIXMsOeapwAzD6autdBnqBXuzheGBKfwn5Yq27hYq2wkavxVa
 +BS2dMK49r9ll6NmKlKRHQSh+FUrUTkmhUll5FfrJV/3JEMXV/SepbHXfRD8kjOAK3EA8xhlEa7
 1uBT5CqF5qrKyqpmuFrcVYW0eK1CB6J4pUZFWSISuPMhXKwohp7PterL9vAnHNHdBBVh4tfeRq/
 5T25cvqXfWln7T5NC+bWhgjlMLBm2YkE0APMnBxB+Z4w2Q5d2MveIpo1atA7wDgSBJEtUaQUlFl
 Q+mUpmtxer/d6Vkd0fT0uDAbbhcmpOIaMsAQJhSfKJilnX1m+Q+5b1qWhO2jGVNJgdWWYM1AtW0
 eQRBQHaA94vZzb00Hk2
X-Received: by 2002:a17:903:144f:b0:2d8:d4d3:da4d with SMTP id
 d9443c01a7336-2d8d4d3db0emr42727475ad.17.1787956005562; 
 Fri, 28 Aug 2026 15:26:45 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759640270sm9178355ad.34.2026.08.28.15.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:26:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 06/13] target/arm: Add isar_feature_aa64_uinj
Date: Fri, 28 Aug 2026 15:26:32 -0700
Message-ID: <20260828222639.1432046-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828222639.1432046-1-richard.henderson@linaro.org>
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 8ec9832424e..1c57bacf5ab 100644
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
2.53.0


