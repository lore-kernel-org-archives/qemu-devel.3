Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64296C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQ5-0000dE-9C; Wed, 07 May 2025 19:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoQ0-0000PF-8K
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPy-0002c1-Hl
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22e661313a3so4888375ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661393; x=1747266193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oONThx//EO5WSiuREF023HuwIIuJ5yNwT7cwhGAiXZE=;
 b=h2J6qvqd6NYDOaIR5Uj4xhKJmPSjojXfA2h/WkZFW7sel0ul09PvlDz5BG+0v+SlVL
 Qc8yFKr1pnxBEvDrdcNCpIQ7ZwG/VnptrDR3ME46wr8gmOy9Y/TuZc3RFREBIddfmnPY
 GYQxXLV2ooDfbBPh1GbyteUHHcv3J/FhDDOTT8sogCbdgD4OcPQ1Hwf+XsPNInaUegxI
 3m4GMMn67SCTAfgpp3tdQnra0FONjB5sCyFtEME2giF528TTNSLbwLIxNZFoyJcoFvVM
 0eOR1KFhvmc/ePQiItCGsSiRlOTrfJMpbT4my5AWTll2mvR/y575ULX3XhfCa0cdo1qT
 w1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661393; x=1747266193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oONThx//EO5WSiuREF023HuwIIuJ5yNwT7cwhGAiXZE=;
 b=dDzr4AY13NrYJksy0RDz+qrmOmEg59tsmUNMUiu9aCFGRH9TWCQpJK9rsFsrgtlxUg
 eXfxAxi53KtFNB8KiXAD2jVVlcbhgaOKGLHrT2IpWXkeQqRt9mD81qhRGZfmhhwPebPi
 pb93u6DBtXRmva/ej0hQRslR4Z95t+G7PnKlurE0K+TmyYI778L6EHJ5fuycGRfMv+Wk
 hiumKgJWiWlzOYXCEjQezlX6pNpl6lOfvjP1VaGneEHn0s9xKhYA/+dzbMkX3igONM/H
 Czm1hCJWnVYyuIufRIYp3v6MO0Pb9jYOcZ0VLphVY2gc6OZls+lHgAdJkGNSGKfXMdL7
 GRuw==
X-Gm-Message-State: AOJu0YxK8dCZaEv5m+j+F7wG13tbJwRWBIsqwvfpJ7GKTV+NJQAF2OUO
 phcUJKl0qv1E5Q0gUFNmLixljUxJVV4aCewSdbDa91YAEzpNFXjlg4iOVia/38K4GeFLkqSYjrs
 bCc2vtg==
X-Gm-Gg: ASbGnctzClM/cHkL8W6tzcDDIoBYiWEwnxT6pLD1Vx92A3qsAzPyIL3EcOfApmsWZdT
 u2GZzNtZvdP4PCEM+FJwbYGkqWT49/ebvqWHEAIxiOOSJ0hciDglY92DJZvW7tq6vhy4H3WuHUK
 efaiPGP62cdlYWeML32fwCPxdSWzxj6YPSuJz+CKDStjqJMA8TtK2FDXvXQhh+8Gxk1T6A6roEQ
 aGEiiYNILrWIB2lp4z99f6dd+h9SMYwiLFFpn12Y6JLPlac6/iSBYbwEwgybVzfFI7EbUto4LHn
 jyzfDeFmB0himxm+BDjyQ2UUKxJFrXJom4W2LmFc
X-Google-Smtp-Source: AGHT+IEITMKovnAbZDNWcvLBKoaDhbNrpqSwM3KB7CHEJv8zt/wd/TnrW9sZ9exZAx7o97xXo3VB+Q==
X-Received: by 2002:a17:903:40cf:b0:22e:4cae:5965 with SMTP id
 d9443c01a7336-22e5ea8cd1fmr77512185ad.29.1746661393321; 
 Wed, 07 May 2025 16:43:13 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 35/49] target/arm/machine: reduce migration include to
 avoid target specific definitions
Date: Wed,  7 May 2025 16:42:26 -0700
Message-ID: <20250507234241.957746-36-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 978249fb71b..f7956898fa1 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -6,7 +6,8 @@
 #include "kvm_arm.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
 
 static bool vfp_needed(void *opaque)
-- 
2.47.2


