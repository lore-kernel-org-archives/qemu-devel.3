Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C62CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jHW-0001s1-Lf; Fri, 03 Oct 2025 13:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHT-0001qe-GO
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:19 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGX-0006GG-EK
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:19 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b555ab7fabaso2414450a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511293; x=1760116093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjDdAknr01k7YxkbZX1BtFHr9eMT0hUzaWlnonFMe1U=;
 b=Gu4ff+GdR57q0bvm+ZrSbKFZLDkn8W14XHb6mkvNMyLAKBgnnDtmtmooHQroaR4WG9
 cUsphHz0cbOq12jCNU3438XO2IBU+nauQ5CD+vVQN7E5xNqMYyLoaYhiNzD1EqZ5Dhlv
 SUoitsmG1VXWnANkcyER300EfQG6gbaM0pyO6Mgt6PMsriEiKhuBQkNjx0xSEBF8g31S
 eIYwhdbDyPr3WrD7A79b+Qff+GHl753+vG+G2+hdK6JBRTqVS9DCBjXwy4ASxNy5EMVw
 sr9kCv7Lqujpry0xVFEK+P1/6LKKU/b8L9j3j666vITcBQpNvXJdpfzu1k3ijNJyVDcY
 1veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511293; x=1760116093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjDdAknr01k7YxkbZX1BtFHr9eMT0hUzaWlnonFMe1U=;
 b=eyQJRPl1L5fYpyw5PDYOeWEi2sWKHX+UdRWG2rhXpYfcoJyjNiBaFSBg/SZxOdZaVq
 d1u9F//dBd/v1CQDsjXIrVOQrfAieSQrrcVvoIQVVlrCidbqenygcc7Ct30yWBxmw+KP
 B9GBESaFv9/11XPVTFjW7i+oXix6OpV0FFbGg3mkgWa2tFtqIWB9d+nkuQA8i+AaMVyv
 XdEf+MFNVLXCOYRRWCHsA2db89ymJPkb76oljBOq8jjeg12NSoNlJQZ6OUh/z9WcwV20
 2NRtEh5uVFZQcB6Q245+FUoTsjGdztXkw8rYKcpL5uQjRkyIjiwqzqDgiABqXz15/lDg
 ps8w==
X-Gm-Message-State: AOJu0YzaosOxvN/RmZZdwqnrgzqz7fEkRtlC4i3q3bHJvrjQCxLKBjeP
 QFPWQYi1dm7F072UKzkBX0kzlhdgZTG4HhLT6ixbsQZn+RebD3CuWgVMK6tlfIZYi9swZVDX2YT
 +Qvee+8k=
X-Gm-Gg: ASbGncsjHJCQb5G/QurDIiHirP+phBf/RA6slpEMjeTUzpU8b5NCGt3RY/5/BYQTbEM
 ZMrlKW0xbt3id0ctQ257VRuOQ8m9z/ad2kb65qUmplZyW73p7XH7lQMUU7ORh/YB5lmeZSn4GEO
 Q2A7m9xDJI793ee5zseWC4pptOdBNM6ezNkiuGEWxjMwP57AFdoWMD8d2y5Y0MZowDzloAiz7Hf
 W0XqGpBlyKuLdX+1ivIlA+kTL3XAtLhIkZs3o5OqpghxCOExkjA1VHm+qb6lyuvmT/q8K5T2cTW
 MXOxpXcxN41wZo+iPLAU4Lgu2Le15i3U8Z2pHjQDIIBwKWtU3JPjqDDxQM/JPirQO3qJsIUK/Cs
 jEMRnSBRrAg00jxZ3gF8yIZD8R/QH6pG6Jfi+adFjYgXbR/eEUhbYYYJO
X-Google-Smtp-Source: AGHT+IGKXwgtMDLS5kT7nVwrbhWP9lenr3DICGBR/qIAz/T1BY5P8QQaP+TT0r6zZfyTLb+vMcGWmw==
X-Received: by 2002:a17:903:3c24:b0:263:b8f:77dd with SMTP id
 d9443c01a7336-28e9a6b1caemr44484245ad.57.1759511293426; 
 Fri, 03 Oct 2025 10:08:13 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 13/73] target/arm: Enable FEAT_S1PIE and FEAT_S2PIE on -cpu
 max
Date: Fri,  3 Oct 2025 10:07:00 -0700
Message-ID: <20251003170800.997167-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index abef6a246e..76193826ce 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1253,6 +1253,8 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 6b04c96c8c..94a6192fa9 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -122,6 +122,8 @@ the following architecture extensions:
 - FEAT_RME (Realm Management Extension) (NB: support status in QEMU is experimental)
 - FEAT_RNG (Random number generator)
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
+- FEAT_S1PIE (Stage 1 permission indirections)
+- FEAT_S2PIE (Stage 2 permission indirections)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SCTLR2 (Extension to SCTLR_ELx)
-- 
2.43.0


