Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8492EC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLk-0000yk-M0; Thu, 01 May 2025 17:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLV-0000mN-QA
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:31 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLU-0001Ta-6r
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-306bf444ba2so1319899a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134487; x=1746739287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMzLjz3HCOicg6vm+TDd7iPOiB48OiFdPHl2bMcuo4E=;
 b=Epaz5KTKTLOiy1sigIjYkd5ZG3EFM5zPbBAAKYtn7gwzgNa5m67ZY+ad61/yQ7uopG
 TMvyALVS5sEEaGQK4DYWGDxlgF9Y2e0k4P4b6B0A7cEB3rUZhebz3qFRmQJvFgcXtJ+1
 UHrMR4+v8G7vXAKwYveax0exYzX3PnCimre+C9yiINtrVPfakOjvzWotNMwCh8S1wqK3
 YnxBqfwo1+NtVFRZDbz/eRN/mu0NP3riN99C7pA7Uoj5j7nt+2kbburn0F512Bg7N2uQ
 Hm2X+VHNWkACLFl39WK1qdv+m/aKKhFXEDuS07KS1ChItLHKnAWT3Wz8jvSyyEZ8Jmj2
 Elyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134487; x=1746739287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JMzLjz3HCOicg6vm+TDd7iPOiB48OiFdPHl2bMcuo4E=;
 b=dgveQBKZVsl/2esV2FcwPPSor49fvYobRcfW/arkpYNr/xQ80Whr8VIUd31ATTlZF9
 swiXgzAEFjF74kKm8S51alf8JyigMhONexAGGl1u88D+GjnpLeCX16lvoa39vqlFmMF+
 76qn5Xgm/FnBqSxlvj8kVpcalpkwUXbYurpEw1J6cBYx6OQaAoYbI2F6PNP7S4/w6qyD
 wh2Ozl6lBGt3GeuPSKntQ4DEJx6mww3oIpIxLqKG3gv6oC9R5ELLynGWWb+U++NXZ0w7
 aHkBAstf6BW4JPzQcNqpVsS9XmPXU1kqPmpvKu7gEXMbepDfG1gxgj+QUeVC/ykpO+AA
 DHTA==
X-Gm-Message-State: AOJu0YwX+5sOYg0ygGtR93HE0wcWLkO3oH3djTrTdtMmyjecIHMMdIUd
 cYW3JO7fof6ecG1vx+miA9c0P4vd3XwuYKmfAkSpiMLgJvdPnUnWSyeQHfp1xhth0rDPw9AnKlF
 u
X-Gm-Gg: ASbGncspB4r5Kj7SOtXquHQPx8jzD+L4oNHI0Et8Mk3oJFr5uP7sQk/jZTUp306xTCV
 SwywEMFv8Pvgrod/+k6cl9V1hkQHlR+86Xu09gbxMPQIXkWqEqy6WURlNb4w2SszzM9rg8nr7SN
 qYEZ5MtmLKNJuHC66dGvAjEvqEV0dp7tRgCpIJQmVOqupkbD8KuSiUKdZeI02fDEOAHzigfHau3
 U4G7Yy7rlv4PVe9SimVyo6qnMv4Anaihgfg1RnGyl7TKWaQPCQW/jsqSVKNmdr15tyE4DXFUILa
 /1E7lO0QQuKae3hDb6fH65ShaOwHQAtn01vbUaG6nsDtPlF3on/SDj+p4sd6ioReaOBiGVinNmg
 =
X-Google-Smtp-Source: AGHT+IG83ucJKLFtncsdI4MjOwdMKFTKD6kMrWzzfji7p3YBzzUzImEdvcFd4fH3OHNZrw8hiY5OKg==
X-Received: by 2002:a17:90b:2745:b0:306:b78a:e22d with SMTP id
 98e67ed59e1d1-30a4e5d15c0mr928743a91.20.1746134486863; 
 Thu, 01 May 2025 14:21:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 15/59] include/exec: Move tb_invalidate_phys_range to
 translation-block.h
Date: Thu,  1 May 2025 14:20:29 -0700
Message-ID: <20250501212113.2961531-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h          | 5 -----
 include/exec/translation-block.h | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index c46255e66e..4c5ad98c6a 100644
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
index 8b8e730561..cdce399eba 100644
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
2.43.0


