Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495CBCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cof-00062j-TO; Fri, 10 Oct 2025 09:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Coc-00061Q-NI
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CoU-0003kk-1g
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso21969765e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101532; x=1760706332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rND9KTNhjLVjhnxkHUd+e7pq0Tu9WRg2XRHElf/VrAk=;
 b=rhNz10PHQiscvj0N7s9WtHiDQHil6X752lX7ON/fWw8XHkGkOhL/DqYOirmGSzmojy
 k2NrjHuYxslrjaOzxBFD1fwNCqZJBUL/3ssIx4UViMpRJ21m/oiqb8IqQZLTfXm5dFod
 Gx4wkTqYBK128Uz90m8Vm9yO76a5fqZnatYwPpcQMQ59dGHHz2iOKW/BKM0SLti23WFy
 eQ0PmvfYGZbVkOT7/hUq35otrouKToImctzpmCR6tY0S7XCBq5UyXD6bJZEmS5FhjFlJ
 0FeAr9SWHAnRfqP//eZLosfkcINNK/E9M88iYGQ9R8Oatl9FYiGUGBaQ94d4uHp4gyj0
 hesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101532; x=1760706332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rND9KTNhjLVjhnxkHUd+e7pq0Tu9WRg2XRHElf/VrAk=;
 b=Ip7S7cCDvtzzbDfIDEfmJMI0SzNvPrBZCRSxizBB0aDVYEoBgCEx5kIlcs0BOafBv4
 E8klAdCUMr8tVqkUSvkO48ObUyfVAp1rRIUiMzoumfgPLOk0c0/LHYKI7OyZnfinBFDF
 AIWuG2SjHrdajczGidlT5k1ojMY9pIGZqfSW6Kew+VsDfZ+py5zSwQ2SUHs7+2UZvFSp
 6OcT2kXOA+QkjsJVJTRc/ug7mREBboOzVn+Sw2u0aDBpogaMm+yAvokMAYT/809RnwOY
 +1R9J/w3lh7SgHZ3jN7W5mVPofoqxeSoYROr9jbinpSi1OmPThP9vTwsiqs9E7v0VW/f
 1bgw==
X-Gm-Message-State: AOJu0YyRqVJRZtbtSgVwnDnZZmrKsKk545lnJA777qcYLFZ8Ybc7M2Rm
 l2PloUngAfA/B6Jf1eS5X/qu37zL47f08miAkbhu1Z1cWn0ScUQyoWXsgCeT0eNSqSoEnT6kFcw
 Z17Ej
X-Gm-Gg: ASbGncsh5OkSVOXFZkD5NrPVWl5CqrIbneqHKLonPRHU3yJYrbGAXaTSM6utbdOlizB
 6Zrog4Sim8/2EnwxlJbH64Wg7KWY5jrGgK7NB5ICZRr8RvbdlGRZAwTuQWBP9QwOh2gqAb2L8cT
 nPe0wr4cBsV9MJ+T3jXTbtR3QdJs2e6Kmc/PzpGxHJcZDzhHHA0AAa8pD0KXvmou1vNXgPVrgo4
 skaZwHp8n2mxeGHkGh0hhumRyWZ9ESepDOneNRSmcJnHLHo0X9clKrVCD6SgZjSb9Wvyh88K6xA
 /EEIQhl0EVJnG+XepDiJR7RJwaeOhG8U+vMUQSq3tB4GaS2trv1F3wbNJ/Y8Zn3dtHee6pNrm/z
 oh8uxyBKf+OrsETVfx2jxfowVKBdxIbg/SVST6JFDcEFSQTVhtmYUdJ3lhYGYrQ==
X-Google-Smtp-Source: AGHT+IH5/vLrzME8imxLKRRaK2xjFHelRYPdfFcN4ctdd0F6zEq8yZZXhqdRQPwqr3wTbNiRblH4VQ==
X-Received: by 2002:a05:600c:4750:b0:46e:3b81:c3f9 with SMTP id
 5b1f17b1804b1-46fa9af30cdmr87227595e9.17.1760101532072; 
 Fri, 10 Oct 2025 06:05:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/76] target/arm: Add isar feature test for FEAT_S1PIE,
 FEAT_S2PIE
Date: Fri, 10 Oct 2025 14:04:13 +0100
Message-ID: <20251010130527.3921602-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: <qemu-devel.nongnu.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f59c18b6ef6..f3e90408f7b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1349,6 +1349,16 @@ static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
 }
 
+static inline bool isar_feature_aa64_s1pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S1PIE) != 0;
+}
+
+static inline bool isar_feature_aa64_s2pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S2PIE) != 0;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
-- 
2.43.0


