Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56395C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtnU-00009M-Ss; Tue, 13 May 2025 13:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtc3-0000IM-Kw
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:24 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtc1-0003Nc-Ao
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso36470115e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158015; x=1747762815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jo0KGiOqZWbyCmUkMPNRmBmFE7abFdGaEV66vf3nIzs=;
 b=cFmjVCC4ELJGlMwpsAXnXphjBVydSZ931nkScWgJXs98svOggg9pAJISH/7RYRvwYr
 8aBN+13f9oUM12sNd4CEQdJjUEaOCUrhxpAee9PYROhjgmxa8QqnAGKOMqKo4bQAQCXa
 4nWr/wC/3brKZ9a022oDff3om+C2oIM/424oK8n1do2uZ4bIIgHfXRB4TjBZ+emcJrB+
 xjXMDwsen4m5pkSifRJLxQIg2etJo7L5Gcr7p64RBdCS+5NqWZAXQdeVoS1rp4jhFRBF
 pXeBkcu430DaRvgJt30gqSvN+ZXvFcjvrAlYWN9mxKmhENWr2q2Qz9hzH16fKqs7qp1W
 2G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158015; x=1747762815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jo0KGiOqZWbyCmUkMPNRmBmFE7abFdGaEV66vf3nIzs=;
 b=WrZa5tiMRhdeCkXHO7R/U4O0NnvxbXi5lOI5iVUEmjVd5bAqVdd33/em+X9z5JWP9Q
 GJJbOwWjjT+88FrTEC9Ecyo/nT0r5SLBZE1IlUKCjFqNtzIBQa0YsQcc1cg2Kqy+Lx0Z
 bbgDt0INTFFBtJ9kg6TeEDeTZIDX1pXnQf0TjG7wGO9aOjE6LLag+C4ctdrgUlL0nO0y
 KfJbd0PYRmamL8uLW8tPuidvZeT5oySJEy6jno7Tow7zr/2GW6dipIksmPQRdwz5qx7+
 O9joJ+B+jWTbMsiALP0EZOLukCyU79UjOPrUrM4K4lk8gbnjkGeukEq+mE7E4bJJoNAv
 dD4w==
X-Gm-Message-State: AOJu0YysFwSwkgPNTQQgxTwpYscAqO0F6nn1KETZx92+L6yjQ8QQ/NJC
 N/sORCAlgKTyYkIb2klkDbd9iplJb8cdJM9MOUnjkjnDxHMZsQCQeoOn5CUjFUj7atA2b6gmfOW
 NofY=
X-Gm-Gg: ASbGncsQ0rCD67xIEpFE3eTipMj/cXpzJFwnNRjkOxZjM8umlHysFXTGJGOKTrdLvjp
 FqIF/7f0cKWNNfbIFzfoq+JpERhQ6twOaNZItkMiQ1hIuIhnpihLXyH2sbrb7vZD0mtddDANQkI
 nFnjlBC41RAXHOuozQiCvMjR2iMQL416ZMOPuNuLIC8vvBgdCoeZFiAqcJLSLiSibrcztuv7Z7n
 1Q8XuHisr+NyDsstCzcBsXRLZlXfqFSTwyyejQmdq1i4xedCHxFNm/OCjjr0itdsWoflFQoPvMI
 9rqLtwq4hTCQNwXOhhec4Pa2GWuZ2tlF6iUo6JBAIamgHJznLkGyjbV3vnjfzFTvrAsNC5/C3wd
 kGhr+/hYc/qgeyyMlP2R9WmgXs/qk
X-Google-Smtp-Source: AGHT+IG8VWHPcCcg9Vd1hoSTHNvG00rhixSMxwn3nanvnGhwlVfkSkpWyiu5tsqbpTvfrA1BB7dpZA==
X-Received: by 2002:a05:600c:1395:b0:43d:fa5d:9314 with SMTP id
 5b1f17b1804b1-442f216d802mr1693035e9.32.1747158014993; 
 Tue, 13 May 2025 10:40:14 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3285c7sm219433565e9.3.2025.05.13.10.40.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:40:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/19] target/arm/hvf: Include missing 'cpu-qom.h' header
Date: Tue, 13 May 2025 18:39:18 +0100
Message-ID: <20250513173928.77376-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

ARMCPU typedef is declared in "cpu-qom.h". Include it in
order to avoid when refactoring unrelated headers:

  target/arm/hvf_arm.h:23:41: error: unknown type name 'ARMCPU'
     23 | void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
        |                                         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/hvf_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 7a44e092620..ea82f2691df 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -11,7 +11,7 @@
 #ifndef QEMU_HVF_ARM_H
 #define QEMU_HVF_ARM_H
 
-#include "cpu.h"
+#include "target/arm/cpu-qom.h"
 
 /**
  * hvf_arm_init_debug() - initialize guest debug capabilities
-- 
2.47.1


