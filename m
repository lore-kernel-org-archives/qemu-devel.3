Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C387C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIK7-0002Cj-Jp; Fri, 10 Jul 2026 16:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIM-0000rW-8s
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:02 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIC-0001vR-2p
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:01 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3811f512167so1817161a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783717070; x=1784321870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wQlUvhVxYxUBBJ0TpgUPbHv3TSyy1Fi4wFktbhNSBoc=;
 b=sFiLLpEAbUq+7VZQrTOSdsRMd2vtmu5Y2sLEJYPiXxfXTpoEyyK1COEHZCb1FUnK9o
 swjl/bZ80RlFcCcin1Q2aTJTgftdUGOY5lg0KrYwv+ypInSF6xjVy7pGEnc/ULudU/4F
 dDrgbbsyZnY3mibrAXap8927f7IJ4Ui8eXxVY6VUJ5n2LzVDJqMwTY5rw37ugms+qRGI
 pB8I6XcwnzJWl/nkO+JYtlw3YNm482RXfg0l3rU3FsffsoDd5lq46ELBRq6QOAnH0oPP
 gkhEjyy8U3K2D4WDd2+TTBN1ZCNDA3l9o0VrOPXBpsfQ9k0sOAplRzL4i2CdaUAHLRN5
 fAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717070; x=1784321870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wQlUvhVxYxUBBJ0TpgUPbHv3TSyy1Fi4wFktbhNSBoc=;
 b=Kn0wHphUFElXvHYLnMM4wBhzMvrNngAYNeI59EWgEriBKi/UbmIr0903vXz0mPyUQt
 zlDNG3yKG6RSnyABoF/+gSp/PtjyeYV6GiR2OHBrlObuk4APWpoMfk+p8CQLqIudAYxV
 xtk4/O97LWHmeuBNjPboHpB/oJ5Yqr7kV4J330cjbTSDGjXeyisQfSxLgnqTa0cFDew5
 jWG3R90Gw1w7068Ja9kbtWBlYN2ZxIyB4lWVoJmL/v2500Ua+dI2Txg9D1cQtmv5fVf6
 tARMjZHfNc8OegesA9Ome0xKbqGQZjpayQ1Cu/7CYp1EiU63Jut7I0VO/N9ij7UHqAaE
 zS+g==
X-Gm-Message-State: AOJu0Yxoqh/KKZ8QsvneTYSGRZrf1vujo9PdLXKaPdb3yuWKvOlBuUK1
 rbFvxZNSsOD97bsZ47LRjqF41hqmQ31Bkdt71qDuvn2pSe0/4wrp08Ri5KqMgv8MSHLhwPVskMO
 QfLiC
X-Gm-Gg: AfdE7ckwulgUGVaYk31C1q52tRpGz5teB4IAJq59dIKogreUP5L6adXVTuUaPSlIeJ4
 Mobpygg9nEj7CVWjCRasGbG+IueOJPh7M3cwY2NRQlPpasy7APhjFZhhDWjHqvd9ip9IAXOBFVo
 2NuSWs5rHkYSZhn3KN/uIHwBNpTDhCFRV3y3pnxZJ4jt7p1Zx0FTPW/ahDsZHin+yR1P19I4/1+
 ihNf7KxyA+kQGfhSNlF32c7icDr9mEBccQhNaa/XfSW1qg9iDDDKc5jBdIWKOJwG/H1J/oH1unz
 6/5djWUCHf9Z35jCj6XhRNki2EEq/qG5Thl3+E3bG56dEgba0i1BSCXuLeQtXUtDYUsecm+11Wi
 iLr6N0qQaS58yKefKy5gPUUKTsV0XpTsDpPqds7VDOeiKzU0nGIEBGigCByLkVJvyPATTe4cQbP
 QDzFSfEslTce3fjyp17A==
X-Received: by 2002:a17:90b:58ce:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-38dc74cff62mr495341a91.11.1783717070129; 
 Fri, 10 Jul 2026 13:57:50 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a58792cdasm3256221a91.16.2026.07.10.13.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:57:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 46/51] accel/tcg: Drop stale assert for vaddr
Date: Fri, 10 Jul 2026 13:53:56 -0700
Message-ID: <20260710205401.836304-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

We no longer support 32-bit hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 695476eef1..c8ba727859 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -86,11 +86,6 @@
         }                                                         \
     } while (0)
 
-/* run_on_cpu_data.target_ptr should always be big enough for a
- * vaddr even on 32 bit builds
- */
-QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
-
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
 {
     return (fast->mask >> CPU_TLB_ENTRY_BITS) + 1;
-- 
2.43.0


