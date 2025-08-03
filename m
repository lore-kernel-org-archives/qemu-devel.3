Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F49C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNij-0007IN-1c; Sat, 02 Aug 2025 21:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNid-0007EN-Ts
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:59 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNic-0004ep-Ib
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:59 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7170344c100so19038817b3.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754185257; x=1754790057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2hpklU5tW/phoAllBqiTzLMcPLur7eE9PCzi++QuJw=;
 b=gzak6Knywdbg4T1yL8tGvC2GW5LKbZRahOJlu+UW91pFjd5PJuYnDfM/s6CTUihuYU
 sbDZAuXSNhYXwTIdB4ATfbM5RjFMLLLck/ozlDn8eghbNSvMwX8w2pPaXI0DG9hG4LXh
 O87/xVAdVEJYECKj8EF7poqeuq2CrHEF9c/hPSY6/WfHlRtJRSQOk9bWpxe71PQwg7/z
 NPUl8zf48bWNhzAzp9dplef7oXwlNgEkUh80uyhRNG1/V9ztsFZ8yGFxjI1qzmyT3HaM
 aV/5wgXA3XX0LFMem45jfDJanscEfXVOMasNk87+zVtMlJDNjER3SmGYrPx8R75RRMvG
 Wvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754185257; x=1754790057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2hpklU5tW/phoAllBqiTzLMcPLur7eE9PCzi++QuJw=;
 b=KrqyPxtnmKJfTfvEd/DWgz9utGvco6pOztqFkMJ9IhV+aO2IWrlnARzi9CkY/BXarr
 9KCai4rbDwug9GEdeDFEHgsqD5t2yD/Dq7rPf2uRevfTmMYWpSuuds24K6AYadNBZ3Bi
 pvKo2G+YW0RqXezQiSB8wBcW1xlfPkoho4UxUU1vn+mlNqPTO2Y3Wi9lskE7l7qHQj2g
 vs1eYwBUJAHOhcwcpVr0DW5hkLA5OgGiUTa+T+0YxE4EjzIE7HyQ9MNbGlCjVNCOtdit
 1bZW5IFzr+orhhMYKiI44QEVbnqwIJszyQu4W7AWS6GF1wVieDuzD5xI7+TxPq3Rc/u+
 UZAQ==
X-Gm-Message-State: AOJu0YztLNXOaqo07j6x8eVg+T3FLTj14t9kfAEjWk39Bb5BIlFnneSd
 8tCzXrGSe1N/Dj2hsxihtemj/U3RK921sXB1f68Uo+YAds3OHnBALzHuvW9yAu61GNCMf2CaJZG
 PG8x1gg4=
X-Gm-Gg: ASbGnctN8YrDz0tG0NFyl4NUaz3lThzm8b3yJXSsZrwUl+7pTiPBhtNEogjvWo1AKUo
 qNQxoZ1PJXb6TPNieIyIt/yyUbAchVp3f1nH9f7nljC0V6t5zHKohWQzG13omu8tRzW+IlqrCLd
 DXBgZjaSQVsjhgnwblmV0w52hP3wMDvHJwe8El9fLebtOqEL40k00AJxyBCW6aasAPTczBX8oI5
 etl9r6Pqg6F2Htxi2Vh4hVCRUtKIgNXFXDg4pchzlhpp7/mCCvAxG3aeRLYQWauzt/wiEH5966n
 1WJQ0xejssB8Y9dOWKT83BZzdgMAgSRUgdrUq9WG0lFvV/VQo9zBIQsrx5qxFzqjPJU6jVP9wx7
 N77xReB6d8mjLxH7Xs2mIKsvpvPtscjzK/o61tr1+RjMAXvpzsnRU
X-Google-Smtp-Source: AGHT+IEJbzn7EGFWYapr3XdJmlLJQUUzbaqk31iERqxt71/eY3qCnRBmk6YK7fYnflCRq8m4MJzbLg==
X-Received: by 2002:a05:690c:f8b:b0:710:f1da:1b5f with SMTP id
 00721157ae682-71b7f0a34a3mr66702407b3.34.1754185257501; 
 Sat, 02 Aug 2025 18:40:57 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a6031a1sm18753227b3.86.2025.08.02.18.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 18:40:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/11] target/arm: Add feature predicate for FEAT_CMPBR
Date: Sun,  3 Aug 2025 11:40:15 +1000
Message-ID: <20250803014019.416797-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250803014019.416797-1-richard.henderson@linaro.org>
References: <20250803014019.416797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f12c5c8be7..744199b776 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -609,6 +609,11 @@ static inline bool isar_feature_aa64_cssc(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, CSSC) != 0;
 }
 
+static inline bool isar_feature_aa64_cmpbr(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, CSSC) >= 2;
+}
+
 static inline bool isar_feature_aa64_lut(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, LUT);
-- 
2.43.0


