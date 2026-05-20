Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEEBCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZ9-0007Jj-9P; Wed, 20 May 2026 14:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYq-000747-F9
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:28 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYn-0000Wk-BE
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:27 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3680540a6efso2828374a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301344; x=1779906144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuUYRHuovVEbvZDKoFulOJ76CJMsJZBODEhgWcUkabI=;
 b=O9JL60rzyMjVOfD5f24uMFLmi+e0w4bez/r4ppHyIvVdGPt9GsOCYx8Z0L7MyMsas9
 h5iK5a7ET4UokYtIwrTgAxyYI32sy0HqQu0TesUKl/TUiEbIGAR8yGKn9ZKSQOVKkNkH
 WmUiV/NZqJtx1qztXnXfkYV6gTg83bZWoM02utmZY/xEm4zej8YWGHOBoay6Mvleq9zP
 vVRQ/fKbaOc/lu9rDeNte9ER8Ztyh9qSM3otcxOgKGQGtHgbxS0Qnn1eBnuMV8uNeKkL
 LW3iTuwoudLJv40fqulDCZMqX3NKMwelnGVcToPiHsNksU8v5Y9vhE1QYV98/QL5n+qK
 T+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301344; x=1779906144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RuUYRHuovVEbvZDKoFulOJ76CJMsJZBODEhgWcUkabI=;
 b=tDG3FKE8mCCIc82atE2iAy3HNw8FOQc2VO9omKPnYTvXEuA/PH7hq1cydkfA8yYoYp
 +Pg9NnpQpFYpHX6Snz/cxgojiJVHl8TzR9FE5ZTOcTEiKx6Dxb+eivgUhIK0osnyVssi
 F8LNeLCtWM9EQINxEmiKB8hE9VHed7ga2keHMVW6y0rN0UjURhQx5VWdeXLvePwwErcR
 AhPnQreZ0xl5p8+tlm4t03puzwhAb9vF3Kh6x0WgKLxGY5JRx1aP15OSKcqlgycDPjaA
 tovv9q5USMqskDoN8osLchR/uaTfj1U/tJzULIq7oDgWRFonwmJrYAm/G9BerRFRhhZf
 QtDg==
X-Gm-Message-State: AOJu0YwR1CKR1YAY2bg93mYyQlDHXoUAW13Wi/F/2XGNbv6PxRhM37aY
 /nVX10smGZeKXdMcDPvUmt1HBZ8EalV4dBYV53uC3LmPM7IygFIII0geO3y4mQQlDVV2Uavo9ee
 0Sh9CGh0=
X-Gm-Gg: Acq92OGxaBxExIzEB1cd2KXuOJNtmbW1fqmQ45ryT98N8ZGp1g6a5W00dzpeJ+lfNHf
 MbzBnrGpIWQski29ApUAb8XmKadVbNVkGN/ITZulKz887ZpdRGT3lquDStmMAPh8XsbN20BLGhF
 8ui0xUimMKVMjXr9lYnEVUZYq4vSmGNoKOu4r1i7O2UhktihwfT/mN/4XtIByV5PXBxXkKjsJF1
 tVWg4RwIAg8NqtGzQrcVz0038S2tt0WFAT3f1HFkpsUVT1oxIfxvCEI3mj3EoomLFu/5hUJBFQk
 r5kLKGfdR5IARP4Tsj8KNrUrSP3dLRwCk8MQuqdsn/SpWnqM9qBggImkQjQp9o0jjoCdCeMDYTd
 iwsnUB7TNwNCj2cGVipXv0pkPeSmiKogpF/LlHF9Sl5AdXX65Z21jVnVqH5mJw6O89YNDFLgZ1N
 H2J2rp7fMXMJBb+SGFCACc/jNHWzEGTgYZ0YY5fug=
X-Received: by 2002:a17:90b:2549:b0:368:ac5f:d31b with SMTP id
 98e67ed59e1d1-36951b8708amr23103839a91.24.1779301343626; 
 Wed, 20 May 2026 11:22:23 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 13/64] target/arm: Trap direct acceses to FPMR
Date: Wed, 20 May 2026 11:21:22 -0700
Message-ID: <20260520182213.872945-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b013dd51cb..d2a4b0fadc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2899,6 +2899,10 @@ static void handle_sys(DisasContext *s, bool isread,
     }
 
     if (!skip_fp_access_checks) {
+        if ((ri->type & ARM_CP_FPMR) && s->fpmr_el != 0) {
+            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, s->fpmr_el);
+            return;
+        }
         if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
             return;
         } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
-- 
2.43.0


