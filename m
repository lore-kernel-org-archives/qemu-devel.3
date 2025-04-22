Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A14EC369D8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JT2-00065w-Ly; Tue, 22 Apr 2025 15:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSN-0004KY-H6
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:02 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSK-0007NS-No
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:58 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b041afe0ee1so5107538a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350734; x=1745955534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q6jXpda4WDLp9/Pv3j909jBuMMAiayizqN/RLechrcE=;
 b=JoH4W2zkHwKuAB9+2dJRzuBkxhT7eFdDpWVQ51p5B/JcPkik2Ezkf72q8T01K7GjTY
 FwBIQCd7AWD+K94JwSkWNWp91h088GXvllk9g1ZItOPpS/KwTPvO7iCOfa5cS2yrvcBl
 h8DpqTGJoB+XLKBArRdoZOkdthoAqgDkgvQ2oUuJSQC4Q6bm9gOuqAzd6w+qx/nb5QEW
 fV4UWLo1bx7l22lN5dBns7UDIrCxYecZgU5Adugh3OpnMlCAdhNczuosSlch9PuMC86t
 jrhOJSC9ni9taNGg3d8nwcG0EX6+2tAYtMlL3bUyXagsD5CURPRoeDXj5mQfxLYXRjdq
 UNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350734; x=1745955534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6jXpda4WDLp9/Pv3j909jBuMMAiayizqN/RLechrcE=;
 b=gsuPJHCEUwXn7RfAy9uMhBwL54DfVcpyK1C9gis3TSCtvAYGY/p/yXAjGa8vmwF5YN
 De6rWQ4cRqdU1nWXGQz5hLXg3rv41AEEZOWYfvSwkj50htMW1eMnx5ssbu/fAll9h01P
 qZ6p3FkpXzZS5GRKqPgL6SsWRUUahpRT5ux6k7dnVgCJYEIOSUO5bD1YnA4rYko/erUS
 TET3M8K3iHnD0k7SPdFJTvz8aHCOqcgR5QRkRLAiB0NQ6SHNSnLLmYH2tBOVcfN22xXj
 l+xGPInBhpJHLJt4CbFQ51j81YgJszc6ZZSWu+xyQNmb5GKkd5N+9jIUOd+ic87QqfdW
 qLSQ==
X-Gm-Message-State: AOJu0Yx1dgQFxd27ZKi5jJd1byaO+HXkkZ09//ViTFD4pUem5iwGz4uW
 E5lBsvP8cltu6k+cfvC0bVQWw7OpcL/PjazPe2S3i8QT24cNQyuFuwqEORAdwrY0XlflsEBhWWF
 p
X-Gm-Gg: ASbGncuP9JpZUP1MnM83MTSx5v2YRyiEthelgZMVT5GKowLQCeWDdLd5lo03ptta6L9
 xvkimeYOqG3G2T9n+cT8pvRyCbr6rrxGxu5roSawizBPNz34AlaJTYdkNs9y15xYInizXDgNusr
 y55rnWNPu7qIIwh9wMgBICtUjrQr3B2Yh2drL5yg1NfrEKExNepD4/oPPmGM06EtFWtnSdk5CrC
 kUX4LHruwB42rP9LqghZdbXGnowkdJ6iejWfm+52HrcqvUArrYaN7KdR1822UD9r8kd9XJzVWQF
 GHVHke0B0RbfVkCLRcw+G1XbhMJc+oZc4YnhlaaD/rSOP4A/eDXOQFOWvaH2XJvwTai+heQ0ShM
 =
X-Google-Smtp-Source: AGHT+IFGkMQFRrmhCW6aPvFYG2MIaT8vo5xkK/oq7gizweh1nOHgsEEaE1iN7Tyas0nrUI22lGIDQQ==
X-Received: by 2002:a17:902:e84f:b0:220:cd9a:a167 with SMTP id
 d9443c01a7336-22c5357a689mr272151435ad.4.1745350734699; 
 Tue, 22 Apr 2025 12:38:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 142/147] accel/tcg: Remove mttcg_enabled
Date: Tue, 22 Apr 2025 12:28:11 -0700
Message-ID: <20250422192819.302784-143-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

In qemu_tcg_mttcg_enabled, read the value from TCGState
and eliminate the separate global variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index bb759cec07..b754f92905 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -60,14 +60,11 @@ DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
                          TYPE_TCG_ACCEL)
 
 #ifndef CONFIG_USER_ONLY
-
-static bool mttcg_enabled;
-
 bool qemu_tcg_mttcg_enabled(void)
 {
-    return mttcg_enabled;
+    TCGState *s = TCG_STATE(current_accel());
+    return s->mttcg_enabled;
 }
-
 #endif /* !CONFIG_USER_ONLY */
 
 /*
@@ -124,7 +121,6 @@ static int tcg_init_machine(MachineState *ms)
 #ifndef CONFIG_USER_ONLY
     if (s->mttcg_enabled) {
         max_threads = ms->smp.max_cpus;
-        mttcg_enabled = true;
     }
 #endif
     tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_threads);
-- 
2.43.0


