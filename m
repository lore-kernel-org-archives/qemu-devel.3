Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC44EC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIJ-0002TK-6T; Tue, 22 Apr 2025 15:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIH-0002Oq-1Z
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:33 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIB-0006AB-T0
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:30 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb3so5444062a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350106; x=1745954906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+iLT1/Bfyh6dr5m+/UJ8NdE52qvtvxZT56N4nM2rJs=;
 b=G7XOLLWqO30WEQZ4xqlZULxayOxwqvuBIWRy+KxSWAmxZZY1gL/tIbLj1dfOG4/GsM
 AmJvFcrKL5Ra5o+PzuyG+/Ef5f/nTLSdsuJgx/YwHEjfM/xQyIeRQD6f/kyCrpEJn8f3
 cTEUzDBjxJEuFatsuaS3G+BuE7cKPGHPn+W6QiW3m9IbtLgo3rFmGyldpcDK+h7LZ79U
 OKb3rnIgDRjpOpUolOH1+oGopl/3kjmZ/pzmDjHBM/l6kMO3NEJsiVpGH1n87hH2QdAS
 hp3QoVx/dNlM9ZDPcvqirBnT6rTDw5DSWRDo9ZeR3CCYmfTv5xcsdUHsJ/MdAgH/hoGC
 GRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350106; x=1745954906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1+iLT1/Bfyh6dr5m+/UJ8NdE52qvtvxZT56N4nM2rJs=;
 b=u7twx9sbSOwEkCcHMzH/WMPTovg3Rapz1aXyJpGXYBj1n4Q6jqPsaZu78cY3YYe/co
 DwOWZKaAn1RR/v6EdPMc/6Mp95ye3Mj2PRQwzjoNkw2PaVxr+le+Lk9WL59Noslru7Bw
 lSw2mOpZ7blO3kGw/pCKr9yMbQL2snnpu0lTz75scund/+ul0fjYIlDAo6EFaOPZAQcl
 qIcoGTXE10E5bsgftHo/dL9dF2fC9P8yW5eY7zR0zuRRs5b/XeaoAz89pDSBs6cXSugh
 g8+y/DpPc3tCGLqQl5uRIMgT9Pi7Z5RZnn5MNbVY4zdit9eHbPP/Y19TwU7TLp7tgb4j
 xxVw==
X-Gm-Message-State: AOJu0YyFs/bh78EpukVuOmvYtFWb0F+nWuu95b1hJzxGeLLAdY+TFapO
 5XhXlnR3pSmAV83NqjROmy2uxTVyTezuQzEAFo2aEUG+dUrL+nQ41oj8HF/iUUDc34BycIaWpR2
 q
X-Gm-Gg: ASbGncvl+t0RunXl/WIfevEJ1WIlKqooOcO/C4XJo/sLqPhc46MUUX3m13+6YNqSQnc
 ntjD5O4Dkjhh+2+UQbjsKUUnPrW6rJLQfgeoqjBCww1ilpNsw4pdD41iTBgdjl4vzy30Oc1E4rd
 8G3+4WhNAtWbbtc6jE5tHdnOUH1U+/uCxiKDPXVbo2MUjw++JaBjTy9QEIjGhLVRk3zzmBB4h6z
 zgeP03wJ2kvgLeKhaWFvporfdHe3PAIUi+/9YzdAq8yIveZ1vp+CNhK8MFq95PcsjnUHagL1an5
 08r7ZBHitGNrpiQaiOh4bZa2/7LUl6NNb/hRGhgIRF913c3VB62HbZcSb8lyorg5ARibeALfsC0
 nTJiGgpA9dg==
X-Google-Smtp-Source: AGHT+IFolnarNUJnhByCYoB8VbPcwTaRocfidq8IqjyapB5NaeyuXCRyXzdeHwb0B5aRr25ww7Dj1A==
X-Received: by 2002:a17:90b:540e:b0:2f8:49ad:4079 with SMTP id
 98e67ed59e1d1-3087bb41876mr20463153a91.6.1745350106554; 
 Tue, 22 Apr 2025 12:28:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 009/147] exec/ram_addr: remove dependency on cpu.h
Date: Tue, 22 Apr 2025 12:25:58 -0700
Message-ID: <20250422192819.302784-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Needed so compilation units including it can be common.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-10-pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index e4c28fbec9..f5d574261a 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -20,13 +20,14 @@
 #define RAM_ADDR_H
 
 #ifndef CONFIG_USER_ONLY
-#include "cpu.h"
 #include "system/xen.h"
 #include "system/tcg.h"
 #include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
+#include "exec/memory.h"
+#include "exec/target_page.h"
 #include "qemu/rcu.h"
 
 #include "exec/hwaddr.h"
-- 
2.43.0


