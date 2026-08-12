Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97BEC5DF65
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHXm-0001Ap-KM; Wed, 12 Aug 2026 18:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXl-00017r-0L
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:29 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXi-0001pw-0a
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:28 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso2184922a91.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786574124; x=1787178924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2cLYJd5I//EuV/MMscwo9rRBVUPYPrnSqKe7KOu+uHc=;
 b=a9SYedWjKVd0HIK7a9WNtLKGzxKHbDXM8kMQ+euMEVKXxt9uUgRGehWV56W2evD5h+
 NShGPXaWWo436SgC6tAgJObGIDjudGqNCw9XeD0vyG5yWP0oeJQ49HTq6T9f93BnvLsA
 bFKyU/epnte/HZYsZIFEE6XYdF9QjL0sXFIwdljaPUA0PyK/dWg3/99uAghwWCKfcXBj
 zelK/EX/oK8p9vssPfMhRqP/mZSp8T2JtCZ78D/se04fLXt4fep40uhjbDAK+0vvWGlv
 f64k6vlVOaBAQzyPWtfC9M7NP2h5bg7BYP/9Wao6esdFY/HkjmhI6cXff94rMJjF4YEX
 tc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786574124; x=1787178924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2cLYJd5I//EuV/MMscwo9rRBVUPYPrnSqKe7KOu+uHc=;
 b=rzu7kkHCPITW/RYhIZyxDkymg90adO/JJzTn+cEdajoXXcP81tPl2EoANm2lrAnjCb
 68GmBaerpV/xkt7dWSQwVcs+LUCUBkPKMkbzo9NT2O0QgwdMbiUk0BI0bCguIemYUZS+
 RDT7lkcyLJsZtTil4Z/ifXJydJ+GFr2QkN0+C+QX49Fe3FHIFnThJJ4epbX5f7jvxcmZ
 Ssj5CYleD4HP6m9K6g4DylzqB+CUQoakkbufYSm72RP/Clu2c/KY0efrmVtsmB9rqMas
 +t4Ejmvtf8HgSLzKSd3i0h9JMDsC6ijAMHjqAVhY9gRBYUmvTj7GYttfx6171evrKDso
 i0zw==
X-Gm-Message-State: AOJu0Yy2NdsowW8PLOnviD2FVfyGo3UCix/5AgH3UU779qoQBnLgYLLP
 E4AKVig5pYsa18XDxDMVc45mx5EsqG+My/LTQjiiJrarYVINOyryB1Q3toB3be/q0oQnHTYR0jF
 uU1II
X-Gm-Gg: AR+sD103deWeJoWOaNkmxWBdqFgyqcDWkpUMhOMAXu79oeEIr8j6cO+gDD77ECG1khO
 gMNgnTrLS/a/HsUJT0vSiWt0ZtGa3KnOYC1oqNBUO1mhN3n4nGIiEAfnywIycWaIk4H/WProSh5
 5FZqV4OHsKMFfRDJ6khKDikDpJjwD2ooVaRkcx9BVEIN0pE4U0GxKuhx0+eZoP0dUwruLJBUzD7
 3iQggeyxoSAG+vGSVZ5z54mBpHF2XvQKp3iWdOsV1rMku04/fVLqkvWR9qL+vJymxAV8TwSC45M
 kuZWc4+6PCDRzYgOUx4FB+6OG5GYqCGrSxtitn0mPAZfm2c5nG+0uU7/ONDyf9o7h87m/O1GNjE
 Kb+O4nXjM3rUdd+fbnm9I5nqpfO6s4oz9zGk3ZXKNvRew5WXdDWe3id2RXIOJRMNGPm3ErJBCkP
 Lvw7X2taPDOYIUV8hpQuGY15WrKnJ2BiaTzaH+QCg/kelHwFvQQ6xSckBmRin1Guk+BrLKFssbf
 mBDkM9NkzvZiwpJptHZ
X-Received: by 2002:a17:90b:4a10:b0:38e:488f:7068 with SMTP id
 98e67ed59e1d1-3931dfdd3e6mr1543449a91.2.1786574124452; 
 Wed, 12 Aug 2026 15:35:24 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f41cd2fsm464854a91.12.2026.08.12.15.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:35:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 44/52] disas/riscv: Move rv_op_illegal to riscv.c
Date: Wed, 12 Aug 2026 15:31:34 -0700
Message-ID: <20260812223142.349142-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

illegal is no longer used in other files.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h | 4 ----
 disas/riscv.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 241dd47d7f..5ac8c41616 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -200,10 +200,6 @@ typedef struct {
     uint8_t   rlist;
 } rv_decode;
 
-enum {
-    rv_op_illegal = 0
-};
-
 /* instruction formats */
 
 #define rv_fmt_none                   "O\t"
diff --git a/disas/riscv.c b/disas/riscv.c
index 787340e811..c3a8cde37d 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -29,7 +29,7 @@
 #include "disas/riscv-xlrbr.h"
 
 typedef enum {
-    /* 0 is reserved for rv_op_illegal. */
+    rv_op_illegal = 0,
     rv_op_lui = 1,
     rv_op_auipc = 2,
     rv_op_jal = 3,
-- 
2.43.0


