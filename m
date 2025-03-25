Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EF2C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwOL-0004L5-4m; Tue, 25 Mar 2025 00:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNv-0003nL-OW
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:36 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNs-0005oh-3b
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:31 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2255003f4c6so98340255ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878766; x=1743483566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQiP5GUFkFFVY7PDaY5zaedRYxLQ4TsTpg+RlxTtlvE=;
 b=jaSTuK5XaWJono/YsSt7+RNR3PZmol2aFKRYCtBPt1/0aSJ4tYSD0Gbp1LMExKUxyE
 TQJF4XPpMl/KD3vV2ASwf9VyqWi70P3+JXO0/MISwo+TxZqbJ/XHBqWSPuIRLUzlVACu
 7LB1DXAzmzpQ+oifntFjQNlIQezTOcl56BhIjjcPmvjqVqSKgKdkF5xHbR2PCjU9GI7s
 0zZl/XPNkdaZ2lzkRaz8STjxvfavgnyQKRHCLwl0UmRa0rQ4lRDPO2YckQqIrsaqTa9R
 j/1ZKwYBpfl0Gc7AIzN6jzdcvJZZlb0WFR2NCtDr/o/TPNV3LTNz63STpG3fK82wj8U0
 HwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878766; x=1743483566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQiP5GUFkFFVY7PDaY5zaedRYxLQ4TsTpg+RlxTtlvE=;
 b=jI9uGguXJCWQc1OnkwqCiZ/0n78flkip29UJhyYQoCDUr0q5PlLVOcQDypgEYQrRyj
 hOLkM7L91ZJV10sqK6/twU03mO///AH2P5SJixlWuHANZu8oBUEAxrIWwtAi8zv0pMGO
 rDj2DfjzBCDj5EzmcPxh+FRAvphUfTm69rRehDGJrtvlSJHqHARsOfTazhGV3w10Jpq6
 AZX1CXbSGhwo2p9puqw9grQk/OehtqoQ1LnIIh8+Sncuecdx1qgNPMmnJiUxOGT4ngta
 kJRlftlleQoyes6RNRzHuj6HkqaT4Ka/nbZ4ekqBWYJyezlxhBF585qOvo43+Olu8tZa
 AYFA==
X-Gm-Message-State: AOJu0YyZJ/CGZc2d1wEbSpuyR3pf9s8RmhLiXZhnU+lj2GahzpmEUeBa
 IEgsAQbEjkR9sUoZEZeiJTsfLj814rQ3NW9q4GqjvftXMooloeYX7zVaCIYCndLlipc8E9HzV4z
 u
X-Gm-Gg: ASbGncu6wNp/vSzwF2+tpqGwR9vieaItbIp3NhNqnTf1SR/F3dOQchdIStgd6gykl3x
 SNm569c1GCGiRNTMRE5oe4+2DoqsKAoQvWf1JAPBuIB1RIPNDes0EGEPpSQN7+5o/QemdGmxanT
 5O7yXvp4VpFwoTbMjut9yuL2cWhvvG/KtLdxAunwAitRlfKl8VFJSjA298Y/qYxFS/Z1hn+L/ME
 pGCDoB+veP02oVY7paIQQvUOMzlsxeE0xclPIWGuLcmduyxQYzLPv+7YZSsIB8gqmZckcYH+5Gr
 2PjY0D//SWshUqcL6mSw8izb/lK882P7ASkEE+G8wmQy
X-Google-Smtp-Source: AGHT+IGQVuU0IksPtjKkLrUXDMm+LhK2vYe+xFJfkgcp4bXwqJ47SOrxeScwDJQAOrOoSkVIRFVAow==
X-Received: by 2002:a17:902:e74d:b0:223:5e6a:57ab with SMTP id
 d9443c01a7336-22780e10df0mr235483485ad.39.1742878766217; 
 Mon, 24 Mar 2025 21:59:26 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 05/29] exec/cpu-all: remove exec/page-protection include
Date: Mon, 24 Mar 2025 21:58:50 -0700
Message-Id: <20250325045915.994760-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index eb029b65552..4a2cac1252d 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -19,7 +19,6 @@
 #ifndef CPU_ALL_H
 #define CPU_ALL_H
 
-#include "exec/page-protection.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/tswap.h"
-- 
2.39.5


