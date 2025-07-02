Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69F3C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwTr-0004pI-Sr; Wed, 02 Jul 2025 08:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTp-0004oD-FZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:25 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTj-0007C9-8o
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:25 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2efbbf5a754so2996028fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458937; x=1752063737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwerfD7lvNQJ4EdbSgApiW5S0oCtGzIs48Se4MUlJ1U=;
 b=KWPeJsbRT4SYqU+KelMFd5b42241vvQYmQEAVKucqKnoaZ83VO7ndN3zjOmeUMDUzg
 PSAopbnfIIVsNzQJoVbGPGmiatC9XaitR6ZXvDeJ0UMcR8B1dXBx5ilzuIGJVPQwMjSB
 Tq5BHzQGcvybgFxVKTD8L6nNW9aaAwLAYNkPvNmp5z3LgGmtiOV826aQfvIu6I/0JylC
 iMu1tJr8beftpufg2kyAqDwsbxJ4U1hMOBivkitd5dhXqn0UuunvAyqTyEczrjeDFWlK
 3Ez/zCNAvQL5fjipS/wMjpOvASqfVVuIusf6iTuhaI3/eOntk7L/Aq9F7Oeqgd467VWO
 u65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458937; x=1752063737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AwerfD7lvNQJ4EdbSgApiW5S0oCtGzIs48Se4MUlJ1U=;
 b=cz4R3s+NZ5r+dW2L3xMabi8EE3ORAXp52xl95tk5Z8lEAe9ltphWWh4SQAUmB7vgBS
 +9q3Rdjp+F1onN58tuAILhikpmKqTrSWdTQ4W97ZCsYQ7ziFMFmV/VJvZO2T/XcDXra+
 RhrLfB8JVIhNk/JG1Uje1POgD8+zjFAKNU5lFXl7bPxmGrU0pNSxP8FIxOSAUbVdguAd
 2gTxXn6jid+O+HH/ClyKIiZC/OvMrFFMAEIEbDbWwk29Fu1YjQXSJiJ3rPdqZiYcdjce
 fGfRAtWYUdlM05FB/hsoeZxdeBzCWXYNC9Tr0xyBNImS/SX3w3MuoVZr4ufZMQ5qndIv
 pL7g==
X-Gm-Message-State: AOJu0YyzpxdfrZhXybyFiWvf1eieuAddHYLKXC5rCqS6Zk3IUbCGv5K8
 JjtHfPM3avmw5uhoLScKcLsKmo5KXna/PonQ7Dcn3s5XdmkDCDQexs8IRLxAaR0+9Vg71sN18Bd
 vWxmNfC0=
X-Gm-Gg: ASbGncte4rSnz+7KdnBpojfEzz4bXBX+tE4JTHznMiGZJxZ+IPZhml9sJ8wr0RUwa1b
 T4phuyJYrZgCX5AK6SLZjpxt3J9E2Ma9Ao/B+YSYzg9FDJy99lxTOJpp1djxnFDxlMnYtx5cUBh
 vdpUg8HZNwdBQG+qEmWy3LRm2IXAzXMkTwWLwObVFRun7cZuZ/wrgN85qTHbA7RczEo8DC3wpxF
 /iAluMc9MTrpnqYa+yH4KLHNVMTdYyjFQF6nyFE9LVVtwFbrNe2dK+9/x1Rog5L6ASiiNlKRIE1
 /TCcm1qwTFSQ5yakHvk9L+WXZwaz2lWF2TatRUnvlFeSOmFEumg9Wamj9UwVD3twAR2++A==
X-Google-Smtp-Source: AGHT+IHBp4nid14igLYfJtGI2OjNOtO5XYtlxrrR6pPSyWNUBYcRj0jTmGNalyLQzF3KUPCtjS0Hfw==
X-Received: by 2002:a05:6870:f68f:b0:2ea:fb40:231c with SMTP id
 586e51a60fabf-2f5c7cc0bd1mr1974079fac.27.1751458936914; 
 Wed, 02 Jul 2025 05:22:16 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1bd3sm3785013fac.28.2025.07.02.05.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:22:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v3 01/10] target/arm: Fix SME vs AdvSIMD exception priority
Date: Wed,  2 Jul 2025 06:22:04 -0600
Message-ID: <20250702122213.758588-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702122213.758588-1-richard.henderson@linaro.org>
References: <20250702122213.758588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We failed to raise an exception when
sme_excp_el == 0 and fp_excp_el == 1.

Cc: qemu-stable@nongnu.org
Fixes: 3d74825f4d6 ("target/arm: Add SME enablement checks")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ac80f572a2..bb49a2ce90 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1494,7 +1494,8 @@ bool sme_enabled_check(DisasContext *s)
      * to be zero when fp_excp_el has priority.  This is because we need
      * sme_excp_el by itself for cpregs access checks.
      */
-    if (!s->fp_excp_el || s->sme_excp_el < s->fp_excp_el) {
+    if (s->sme_excp_el
+        && (!s->fp_excp_el || s->sme_excp_el <= s->fp_excp_el)) {
         bool ret = sme_access_check(s);
         s->fp_access_checked = (ret ? 1 : -1);
         return ret;
-- 
2.43.0


