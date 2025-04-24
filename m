Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E38C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tAy-0007eB-Pb; Thu, 24 Apr 2025 05:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAx-0007dt-6m
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAv-0002a6-DM
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso5034025e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488039; x=1746092839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3spF3BHyP+3nJq+PBnSsTeYKhoBB0RsO1qRS6M0pmcw=;
 b=pjtTrJgSO307z6o36mjiv42XdYqPIuERXWyLcjJvjpb/0/zz6Lr0SLtk7pYFFuxJ5M
 e5EUplG1idDAg5XMxa1ls5ctn6rkqSoUK9e9yhKDazCMTlwZ3DbLTS88u1YUXXpclwUY
 e2kXVxliYMRty5iuBP8EJGLE9nCKMeDX8ISa/Dnr7s43BAuY2xPgFsnso7qFwClChcQ9
 N1aXzY8CSuD+txoVsWe7NlV+jylMPpMkFU0AvniU0zISN8rTBliJZMI7rHa+k9+62T9x
 73jOe1OlEpUmDjbYvLD+jUmrMD73DHW9tNXn6J+UaUQpmvX/qegOOyFJA8aqYRhy6cVw
 gAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488039; x=1746092839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3spF3BHyP+3nJq+PBnSsTeYKhoBB0RsO1qRS6M0pmcw=;
 b=SeIMSlPSjQerOEiTIXsZJrqAPyer5La3mJ5SJXKhy3s3+ZSvn305lIWPVyanyGMB5J
 ig7B8z7ZaqSCjbM4X5qVmY0O86RUeKGWWHyvypoCnOH3fpnlY+DEGMhs9dfuhghQo30E
 vteP8SuWo/twAlPoL0GUlB3CFow6wDCKCBFZu6veDfHYdUANcFDcUeuYDNI1gNX+vkPG
 I2cQaUpKJiqqL/HEuv1bUIXPA1L9Fnx4I/FFwuaAxQEc2Dy2M1bbPqeNrcQSvtOil0A0
 lRb2/TLbE1MjiWyMQ0gapqs1iBC0yr/rBoUj2pDoob9ludFvSeyg1ZON+tf2y/CMUAQz
 NeQg==
X-Gm-Message-State: AOJu0Yx10ZskIhbS12kC5cn5ZFVZIjrq/Cmlu8hoNDR38Kv5mGGW1got
 SpNsZ9dC2PSQJ5hhIybtgNdgj0FBZAZo0BdqtfGj8XM9mU6p+e+8grokBWeNd7nOHMNMtz/Lwy1
 8
X-Gm-Gg: ASbGnctStbTTqqPB0A4uZFtJ8RakmmNmJgYzgjGH8eFx/jyM6t+mSU+PaySTcdhWUFL
 v98d97ux5vLZmU/WY9/ulXU0oJVsqc7PtbUJLy6G6O+xvpcxI3jxANxgTR78jpTuGRmQ75jbQsF
 u+afxG9y+i4V35FjdLL2CKul+2pYPix5GG7nnSANSc2/HPqtQanPx/n9lyJ3mcWbBI9oXoZ5BPJ
 R6gLwyPWKl0nTSeCfYmJRgkaiKL5J/DL5n0JCtMWc6cVB/0YOU/TxErLlggblHDcEq8sktzhlH0
 UkWV3IghGUQ9cS25IxSQe5/5UnAZk7v/V8I0u/pu+Mz9LlOz9jxMQZAFThUlAkRVTxN0j5NgGZn
 qtzN6SkkfX0h9bt/nXQdS
X-Google-Smtp-Source: AGHT+IHFQls529ucT0sreRe7PpBuQc1Gruo6EsCEusAv5u2THfSozkM855d3balPccoGVbdBXwpr6Q==
X-Received: by 2002:a05:600c:8012:b0:43c:f629:66f4 with SMTP id
 5b1f17b1804b1-4409bc079b8mr20784615e9.0.1745488039037; 
 Thu, 24 Apr 2025 02:47:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4c4965sm1482024f8f.46.2025.04.24.02.47.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:47:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/13] include/exec: Move tb_invalidate_phys_range to
 translation-block.h
Date: Thu, 24 Apr 2025 11:46:45 +0200
Message-ID: <20250424094653.35932-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250424011918.599958-15-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/exec-all.h          | 5 -----
 include/exec/translation-block.h | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index c46255e66ef..4c5ad98c6a9 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -23,7 +23,6 @@
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
 #include "exec/mmu-access-type.h"
-#include "exec/translation-block.h"
 #include "exec/vaddr.h"
 
 #if defined(CONFIG_TCG)
@@ -123,10 +122,6 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 #endif /* !CONFIG_USER_ONLY */
 #endif /* CONFIG_TCG */
 
-/* TranslationBlock invalidate API */
-void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
-                              tb_page_addr_t last);
-
 #if !defined(CONFIG_USER_ONLY)
 
 /**
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 8b8e730561d..cdce399ebab 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -207,4 +207,8 @@ static inline void tb_set_page_addr1(TranslationBlock *tb,
 #endif
 }
 
+/* TranslationBlock invalidate API */
+void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
+                              tb_page_addr_t last);
+
 #endif /* EXEC_TRANSLATION_BLOCK_H */
-- 
2.47.1


