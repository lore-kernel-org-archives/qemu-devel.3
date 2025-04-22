Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDBCC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIh-0002dN-N6; Tue, 22 Apr 2025 15:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIa-0002YG-3a
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:52 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIW-0006FH-3V
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:51 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b03bc416962so4061796a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350126; x=1745954926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSTxcdVupVH5RULwmr3LUReRVWUe6351QoWFFPPNbok=;
 b=ldLjh9a++GRUYT+CAJFW0bOPn6rIKB+56VjD8k4+1lrwcZwGjTJlD37FeOyyY+2U1P
 3zaL+z2H2CtiZVJWUWPYrHErt7avHJozAgcf+pzd17kfChLCU+AgG0MsX419Gk2SC1w2
 tbd1BQA0a8y/7wfby2Djz0QRfoF4Ey7OrOZ/HG4P7XKX1GB917geMahsXwBaxd+QRlpZ
 MG7hVzNHPIhedbh20dnV0fb7a522BCo8a/5rr+fAWK75RTG2yVJXSiN2HnTz+HlSJxG3
 yhhYE21QOdCmyA1b+cRX5QQ4ncvE+PCD1VZ55tL3hfh5n05TiAM+vXAFF8Ai/hRphj8K
 7H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350126; x=1745954926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSTxcdVupVH5RULwmr3LUReRVWUe6351QoWFFPPNbok=;
 b=okZjv0ZkNGL8uDMOePUHTtySmDZRe9nEBjA3cCc05axQDndt5YbVw+BV5ZT5iSbPOv
 /4cjaEXO/jI0YSa5mvQxkBquiyHxdObweP0pVXfE1+4SDZ8uHQ+Yx+5Gi2jXyeAPJBNc
 m06aEv2An5RZU7m7ubIPR8RJbdQHPtbeDxJ6/RsJQLdjeMcXXma7HHagR6vK+rvXyFkU
 fw6plp3glro26OYrEh3xmpQRqg8yhE8Xn7Wn3b2k6xYySg+C5Xldy+0anvWrTCCioyfq
 icH7ojNBO4778uvX3sAm9mi/3RFoZ6W3KrSg71gId1/F2aiGKxFWzWKjSLXOTUgs5saY
 08/g==
X-Gm-Message-State: AOJu0Yzm5s+QGOLavKRcD5xZxZaY5ihUXcFk7TbfrN706J2RmEpChD2V
 1a05KCCS2rjeCdEet1++PeUzFVFTrh0FJvl+MjzKdFzLWcaJX04YTZscJh1DWnqQ0FyMwtVrydF
 1
X-Gm-Gg: ASbGncsI3CZcBHl/+fQyNAgNNbRORFHQVB2rC4zsaYvIL3HaAML8PG6v54s2ZzJOVct
 cRwZ94TaYD2JYjhSFpNcAfwKwSuzvhzGSs3phlAUZExVdid6XmCBIAzgcV8D8H5zP2Mrr0tHcuE
 8k/TGk2m0nFfgNifEQp9rBoIwj1LcVTEBKgsTQ635bgJw0pwLzAPtD1P2AitRZzIbNJ0zEHVXAq
 PRXFQHTZr/CS+BM6JVbZbVv/xIdNOPTDdiPJtFezNhcPcYnZ7v4H4hRI3bVJk427OzJ9ilNpGyD
 rG5JLPg4zp1yKKO6/DzI5GtG9HOzyFnUe712rnI06qdzXeQPdO9juzqNaXysQ7+MAfb2AOhkRMc
 BlKa6a+VA1Q==
X-Google-Smtp-Source: AGHT+IE2L8jQekGi3bZ+iuQu940NpUCQSoIQIyIOzEkCM6Yd/Q43rZqH+3oiZEc0tRg2lyWSQMhQIQ==
X-Received: by 2002:a17:90b:2752:b0:301:a0e9:66f with SMTP id
 98e67ed59e1d1-3087bb579cdmr25356534a91.14.1745350126491; 
 Tue, 22 Apr 2025 12:28:46 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 039/147] accel/tcg: Remove unnecesary inclusion of
 memory-internal.h in cputlb.c
Date: Tue, 22 Apr 2025 12:26:28 -0700
Message-ID: <20250422192819.302784-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

At some point cputlb.c stopped depending on the
"exec/memory-internal.h" header. Clean that now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317161329.40300-2-philmd@linaro.org>
---
 accel/tcg/cputlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 134e523cab..613f919fff 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -26,7 +26,6 @@
 #include "exec/cpu_ldst.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
-#include "exec/memory-internal.h"
 #include "system/ram_addr.h"
 #include "exec/mmu-access-type.h"
 #include "exec/tlb-common.h"
-- 
2.43.0


