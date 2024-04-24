Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A27C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm66-0006He-Hn; Wed, 24 Apr 2024 19:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5r-00061O-Tp
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:04 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5q-0003zL-AQ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:03 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ab1ddfded1so439436a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001521; x=1714606321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cGd76eq3aObei5VuQZhwLC7u3w/qktBLjof4YnAY7+U=;
 b=HbyG0QN6WaJLgW4m7I398TQIHNKsFFsOzpyQhQAsEIY7ovn3AOiz2xay29SlKFWpFM
 8KWS7nyHEN36Iac7MrotYlsMZougPtYBj4T85JU2Pr5dyfKqn3vrg6OJKl0nSlaIpRCr
 wr1YnIFeapD/dRG0hkARYYPsJZWQjD7bGAh5aGUPNzXROqux0Y7bMq9+RBUFCS9uGJyo
 A/bTK96owvpBoCn8+t1U9zFcs2zPx79v0J+T2QN40c0tnVMRXQ6cAloUehtcGDK3+7Bl
 ShqQD+bWdlBPFXhjmGzRq0bJPVMT8AEFpQY9wHovDK3UxKNfaTiER07+X5YvhgT/GXOA
 lECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001521; x=1714606321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGd76eq3aObei5VuQZhwLC7u3w/qktBLjof4YnAY7+U=;
 b=kIayh7BRt0ab02czwSuOKAx3O4mUdiOtIslifCM0934iv3lVd04CfUjPAsI5Dnexv4
 h7/J+AOUJwMOcUA0lvBNgPPb1iZrWP/OYwtdihlD7fIEOyhzp2piUNQTq93yfIERnbnH
 ItBZw35F9iCc8J8N8dCJFjP6uFBn54Ofqh/Rnd6R0RU82JG554JU4a8TzDc0UdTv2jr8
 eSH9t0hW6NUn+94UidmNd9vyXVG9xWotaSxKiHu+Uh1pxBWWSrh25QPuNgGQXWHQgx8p
 e3fqcKzpNEO0JwXeX0SvpXiYo2djVA7LvHGzzV++cep1ogAQRpC5l14mZkkl+OTd1hM8
 bUgA==
X-Gm-Message-State: AOJu0YzPyfhCYPoufu6lcxOEmmXa1hAQSy0bzMI+mnvwTrU+N621/0CB
 udLBDvbosmsrBv48yOVxr9DqM994hqqmAH/77Qpog3nIB8x1hMs+y/TtHEwfSjMXVjkBGJ9tAWt
 4
X-Google-Smtp-Source: AGHT+IEYKS2OvByHqDLQLa28WVPjt6/5L+bueQdtMZUNwbZjigtvaNg3JOT7JRvBbl1K0uZIpCCgTw==
X-Received: by 2002:a17:90a:4746:b0:2a4:892f:39b2 with SMTP id
 y6-20020a17090a474600b002a4892f39b2mr4285123pjg.11.1714001521044; 
 Wed, 24 Apr 2024 16:32:01 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.32.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:32:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 32/33] target/s390x: Use translator_lduw in get_next_pc
Date: Wed, 24 Apr 2024 16:31:30 -0700
Message-Id: <20240424233131.988727-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
 target/s390x/tcg/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index bac033c63c..ebd96abe6c 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -36,7 +36,6 @@
 #include "tcg/tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "qemu/host-utils.h"
-#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 
@@ -6471,7 +6470,7 @@ static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
                                 uint64_t pc)
 {
-    uint64_t insn = cpu_lduw_code(env, pc);
+    uint64_t insn = translator_lduw(env, &s->base, pc);
 
     return pc + get_ilen((insn >> 8) & 0xff);
 }
-- 
2.34.1


