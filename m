Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26ADC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl19-0004Ks-Gc; Sun, 04 May 2025 21:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0o-0003ws-7O
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:58 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0f-0002XE-Nl
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:52 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af91fc1fa90so3546618a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409964; x=1747014764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92Ra51BscJ7plqFLljDp4Imt4ck5QTPqHgH4Y/GteZ4=;
 b=xqLjAN9f1Hfmn0PHgRLRaO35sW9s0hAeMBEGoyJLsabvg8gHOcrGHD4CZQ2F622o5L
 nDhBl8wMkRcXe7QMr2KQULCARH5tKvG3iYmY/hEK4gtN3va5h7+wuDSJeQJrah6/6ZDN
 tX9tH1hHg+TydBbvmIPtzvB6GdtqHyAYtlA3SMLljWFqWVWyfa9Mi8eFlhhJ6c6KuhrO
 fvPLqpVdZAOi9YcjjUvKodJDNDfy6tbaISVtoErY0qSBCf+K0QhiCGYuAIm0wJmQZzbP
 vOHdxTlJnWFHkVPu5hnH+1GuDwGBNHSOA9h/4e13MyxwOL0Zye/bsXQJdxMkzino1nXQ
 UZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409964; x=1747014764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=92Ra51BscJ7plqFLljDp4Imt4ck5QTPqHgH4Y/GteZ4=;
 b=S3q8xeieiXlvBio5vjjOgOSExy+XllRCCj5RvP2D6vClQhYzqL5F0ofWLqEkjCUz4O
 n7cUG59adoidDfRVlv4kiiNvK13yqoOvgXevbBrrImkms13NTcnrt84T1stqhMABX8wV
 TqFpdv0pfg9LtG5PEpPq56FCu2D1cUINULsHTxxxrUdzwqREwkKkzKHCHNtxzRA/N5IX
 STN+gAQOmkoXFXeiP8iKfPuhDK/NF1tQVkG2MQW7ztQnNFjQ/ECXeoEa1dCzD1Ocup4Q
 iFr1z6M3PxZtlMoBA5H3vHQIjLKooKFA2cAgZBtjax7DBp0aQBZzOtTnuzfoShvgQ0X7
 mc2g==
X-Gm-Message-State: AOJu0YycjJ35K1kwI3P7EwrW7guUQ9v4Lkxy4kkVf/aC7OU6NntGSR+w
 5a3JmLzOv92XPy9hmz7TAaEPzbg6FhAZHqyJ+HPP5x7keXyw0kl9DSKWRl0s++HZ2BWpTKqr9Cf
 tnC4=
X-Gm-Gg: ASbGncvbAmc16lBBksjMPBJkL+DQpyOiwQFMXoO7njB/eBB+j/lnRna5e/EqEVJfk0x
 iXo37mmbjQpXCRLtHV7OTGUtCzJGayFDznyrWBRe1o0ZXP3E4+Bjtdu/Qdl0Grl9TsqO3IUozIE
 Lj2IkBCggQrzzhmDxiESyLYpyq5dl98T8hO4g02/QbpcfJJYJpNvYVfLkHP4MzOkXPY8fUjZ49a
 /i0C7jThwAgc0fZAT9KzJh/YRALmPvEZF9B7TVBqxItTzLr6IkQXKNS1Pmzr8L41K+LMGN/tHCB
 MFGOz/M+UWt9y5KTyntNKjzt4/5Gwkl+jezeH5b8
X-Google-Smtp-Source: AGHT+IE9j2o3T7kEuRYqkKUfbrNoqBKSp9dkYQiKXtC9/BPBj/wfPB0ZC7uXMkUBNXaP91CXX8quKA==
X-Received: by 2002:a05:6a21:8dca:b0:1f5:87dc:a315 with SMTP id
 adf61e73a8af0-20e06436846mr10046422637.12.1746409964452; 
 Sun, 04 May 2025 18:52:44 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 18/48] target/arm/debug_helper: only include common helpers
Date: Sun,  4 May 2025 18:51:53 -0700
Message-ID: <20250505015223.3895275-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

Avoid pulling helper.h which contains TARGET_AARCH64.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 473ee2af38e..357bc2141ae 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -12,10 +12,12 @@
 #include "cpu-features.h"
 #include "cpregs.h"
 #include "exec/exec-all.h"
-#include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
 #include "system/tcg.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #ifdef CONFIG_TCG
 /* Return the Exception Level targeted by debug exceptions. */
 static int arm_debug_target_el(CPUARMState *env)
-- 
2.47.2


