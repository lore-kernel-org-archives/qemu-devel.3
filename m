Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC76CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZ3-0007G6-Ex; Wed, 20 May 2026 14:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYo-00070f-LR
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:26 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYm-0000Vz-9Z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:26 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3697c35eab7so2990954a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301343; x=1779906143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CH8sn0raFot2c6HYSuCv/vuUo7CdYLWHtN+GrqCIxQ=;
 b=qTr1zS50cJucynuQJdXscl8LAvd4zibYpUDlkbuOW7abhP45Od2lN3uPOFLB2copI9
 lDCtjE8maXPI/GhIkKJU9GhoCsybEvuzD30MJjKp358O2bEpa09SHJ2q5/ANxIJVzyr4
 lS6zcjGXHhgl+3fmXJAc10r1rmzV2gCBZmwVypVkviTkfN1xilOWw2MssTa+4kAHKs8m
 yr2dlImXYhUvUiO3gjlqqoYfKJZhCCk7BwRVBNa0jh22wAVlWIiua9CfdHnxOXe1oi29
 pvcbVTVpydYtQbPCrjlYOcgP/qOQEJ9eA85U14HDj4/WDYpIyDoIMKNMOMkaZ8iRUiXN
 Gbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301343; x=1779906143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6CH8sn0raFot2c6HYSuCv/vuUo7CdYLWHtN+GrqCIxQ=;
 b=ShxKFU1EPWpveNN1IdZ7KJHK0xaVjYDgWJjZZaSEj0B4ALNbEOP4cCoWM1JMnz3qGI
 D41kno98XVAQY4A90Q0oHgHaClCpZpTx60jnUl6SJ/w7hU4aTrWeEkBGYCvS6XYm+UAC
 2a8PcGQmsf9xnEw22OSHrPiVOSems7E2lnLfSSOQpb1Zyp7IxbGm0JUz3CmC7KoPjC/q
 VyjEDfTFqNovE+J3Jc3gYTbVrUwzXTOHsz7KvVGAHygxCxTuLqRxEGCN+JiwiMCan4TQ
 MCJx7zDFfcSDd8xaDhi2H3LGITwav9UxJEUUdN2UGHilbuExV4PsUq6VVRoAxUjBTJQa
 qJNg==
X-Gm-Message-State: AOJu0YxrHOIqnQhnRqiwm9cHTSgwv48Dl4dIFi6jpOhI9jXWBfZbv4yV
 bmXo5jen1qLRsLPuF4fRE5eJfBYHKd3VQA2kKHNrOG1Z9iDsZEOtB7R8QmwOgwbqx5pZoRd4SlI
 3XGr6w5I=
X-Gm-Gg: Acq92OGPfJUlpIt4E2l/I4QsG+UwQxvC1YTnAa0vqVEjxsH/MJb10VI56k9yi1/LAzR
 YTEHyNODp1HEu/f6Ej4OQbhs2m1ur7/8OE+5gr5cdV5g3QK1j5CVlFgDR9VSgX9c90lmhSHgQW6
 8E1JZS94Qc6zdE6rpwZRFOdnYsLJ1MJU/ucsUnaQl2NhdkK8Y72jhxGnLIbfCK3aNmSXxIT7ka2
 +3Xe8iOkzrJ0gQV40b/KtHNlgMLbKPLQnqK7ZqhW86g4YQj7/hPpJgQ571gg4O+0mRDONMfnxOi
 MUnP49BGnd1s0MZ+8c2pva4AglteXxgK7XovuITu06RUeYcstZ9uu9YxR523d1NpSpCbK3Su6Vz
 J+s1n5qyHAXUEhaPyMcwMHL3fKVdQCWOfnbl+ehSN2BFSOK7pn1DMWmQGyRwRv/X7AgEdbMnZr5
 zbSuSOqWpOagHAWnBDQ3oRjX+/xbgK
X-Received: by 2002:a17:90b:33c4:b0:35d:9c32:6219 with SMTP id
 98e67ed59e1d1-369519e8faamr24467915a91.9.1779301342447; 
 Wed, 20 May 2026 11:22:22 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 11/64] target/arm: Clear FPMR on ResetSVEState
Date: Wed, 20 May 2026 11:21:20 -0700
Message-ID: <20260520182213.872945-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

FPMR is cleared when entering or exiting Streaming Mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7eb7031294..3d6e7f1ccc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4856,6 +4856,7 @@ static void arm_reset_sve_state(CPUARMState *env)
     /* Recall that FFR is stored as pregs[16]. */
     memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
     vfp_set_fpsr(env, 0x0800009f);
+    env->vfp.fpmr = 0;
 }
 
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
-- 
2.43.0


