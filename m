Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE039C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8K-0006Uo-GT; Wed, 15 May 2024 05:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B84-0005p5-9c
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B81-0001dK-7Q
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:55 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34db9a38755so6306798f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766052; x=1716370852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8D/PMBczQIsrFLsR1lIqXJyOFdBm71SwgovD3vevRX4=;
 b=O6yVTTZhIKHeJClrYDBDe1MU29NX+rNdgBI9iq1mCNhFzLpOfWh/Rk0n/ehDZWA3R3
 7slAXb2GAz96GbGI5efxl24gyPJDJDLFxEHeoW4CciGra9DOr13HTXDKfFYeRZO5i72q
 KYOwVTxz/soAQ4ttakpqwaBzhaAwmy4/Hi2WVg514uDqVJClVRGZidRlxR95ht/MZHgy
 YhIkHg81Y87WihM+OKXYX0g4LHOa2/lL9tbCSqnL0HPR+w60BB7J5cl/ZrrvfnGIHKjm
 Omv91owO5qfE5cIjfFhfV2Cb+nrJfsodKMqBHeJgR258iutg+zGXR8owKCPzBgAMb5PG
 /N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766052; x=1716370852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8D/PMBczQIsrFLsR1lIqXJyOFdBm71SwgovD3vevRX4=;
 b=hNrQ1gdoeX+yObfPtaDRhT407yUDDDysuoL4BilCgo6LDDKGVx8z5h8ve56WCpq7qj
 4H1ftVW+NJ4yNu1111Ij+PYajJv9dSvfuXXjcdbRuTOQh+NHzF2310AQiZVOAKm2u/Eg
 IciDcrHmxex8Y1MibGIIxjOR2q5Jvg8q8X1mRpJC/99uCUKB6z4FvR+tYggxLsmeC0zi
 V5UQwzqEcegRSn4NIpGCPEn6FqHeNNWksq/xm+I+7TdrVdotmHiHgq1CW/MzSLTZLYs4
 md+AbrffoXr3K8/X7E6c+GoSOzVb5e/ksh+5Zfvb5XJAwlv09e/U+OMhC7XD8cNtfreW
 aQPQ==
X-Gm-Message-State: AOJu0YwgDp5LX2xtQtq3vu9MtlwBcqwUFRVPNYlE3H55vfJlNGRF8ifi
 05IqRasCCFDqSORqC9Y1HFBWuuEEvbzHw6evDvx7DjCu4Tjjx20oDBvc+aWCWeJ/ho0pjAOKnx5
 PxNI=
X-Google-Smtp-Source: AGHT+IEapX76CzQe0ceiirm58cDc7KgF2KF7+gFhHXaguNB3pcppwaUVPT4sjgFxJV/XPD2tH/ZQug==
X-Received: by 2002:a5d:6190:0:b0:34a:35c7:22a3 with SMTP id
 ffacd0b85a97d-3504a737286mr14514773f8f.20.1715766051964; 
 Wed, 15 May 2024 02:40:51 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 10/43] target/hppa: Skip nullified insns in unconditional
 dbranch path
Date: Wed, 15 May 2024 11:40:10 +0200
Message-Id: <20240515094043.82850-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9189e0350b..6c5efb0023 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1806,11 +1806,17 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
 
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, false);
-        ctx->iaoq_n = dest;
-        ctx->iaoq_n_var = NULL;
         if (is_n) {
+            if (use_nullify_skip(ctx)) {
+                nullify_set(ctx, 0);
+                gen_goto_tb(ctx, 0, dest, dest + 4);
+                ctx->base.is_jmp = DISAS_NORETURN;
+                return true;
+            }
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
+        ctx->iaoq_n = dest;
+        ctx->iaoq_n_var = NULL;
     } else {
         nullify_over(ctx);
 
-- 
2.34.1


