Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264FCC7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 21:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTSLR-0007SV-O6; Sun, 22 Jun 2025 17:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTSLM-0007RS-N2
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 17:35:17 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTSLL-00058x-6S
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 17:35:16 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so2598667b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750628111; x=1751232911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86Re1mOlDXK3rV70IB71Kb0iZF4aZZETKbM675Pw+4M=;
 b=XitLb92pwHXvG+bscnt5Wrvn60ZHrYhNGplQx20GfZaQJ995BmyZHUmhd3wp1LPAsN
 ZDq+CVRkoMimPNDoMUGN295hSS6X/hYlKFckO/hliov43OvT+OoqzReEEc9iT02ZKxxJ
 V8WbzX8IR3xuWNo+0ee/1IK3nBmpuR/UwsqQFqITy2ZsjbQYNwevr8vQklOrY9buV5Ea
 vJTV7f1aM+D71Y/qRO8xE/vWa5atdgrAmaDnymlzMNXBmgGjEdkFCtHvRNmzgGp/gG65
 WsttyRCDRT0orBSeRolnZR2p2C7HMEQWVVojLhIbyoLFIW91vCfluGSPHbmQoDSiXy35
 Lphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750628111; x=1751232911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86Re1mOlDXK3rV70IB71Kb0iZF4aZZETKbM675Pw+4M=;
 b=i80QCJCFhY88hW/czB0x5NNlMM6xK0cqsf4WW4P46iDY7KflPZZClBeDqkvoi3wLfw
 wsQ37+3WAw0NjOoLYP0dlcwvR1X7rPAD70CwGqGFjU2tpjNNiQFhTzbS73cL1rEfTVbe
 ufe8rHUyRJ+fnRZRUIdOPr+m677oAqtPOgbgBp5wLaFZHm9klSc+C065Y/0E4CaashiU
 KHGq34L4Nm1Fu4Ro9Fzozd639IEj79nISXOP6hxBC/BCf8w4ve2aCjg2sapC5Zu21EKI
 k4iJQnw/g071ObJc4kB5qGDH1n5eR5IHS84B4oAjT9C9f2tJSs7fB63ujlszLPbQUk39
 rAxA==
X-Gm-Message-State: AOJu0YzqUgLtFdJucS5d5ZUIhjOOwdjLBOntDgMI2bNwkTA7/YB5THBd
 r4XTXA6iHtguXZVosM2PW4YurjOp/82eTOJF3PPu/95Y3aJ8a7sn/SkZq6WcvsKXNckwjL+Cp89
 GbySRpFw=
X-Gm-Gg: ASbGncv92Wgaq5cbORs6H7BMfrlSlyJvD/cxQjRAGYa4OrqiW3mhhrvEFGYM2bHiofi
 wXcHPHq5oa6BqlJ1+MjjfuJnGgKsZdmsZgXXRf4LRs3suKVeFhJXnpEKrmlW+Wlc10hsvmT3PGM
 DZ73Qnoj1vueIsSMr0Exs/LjAk8PdTytlWeDZL6wQ7/wWL/Q2wUM44/njzINIgx+CDT6WbfIAHv
 ixH3yw3CEDdCG30iIDPVoeYFw5cSkfXltvxTS2jaSZnr9g8leGB25aVAIlXzlqHnJeI32E3Njua
 beLfJRwVx+gEIpQtw3lhip35srU4+GDk+KdFj1knCm4VRFfDZKUp2ZfLNOFPkF4/mDhfFBzO8UR
 YErwO90dlGfS54aIlMa/Y
X-Google-Smtp-Source: AGHT+IGWXn0tGx9ZkmlFvyWLXoZCfFvDJnw8XWdMy/mjGHhIuCfgqEaBqBu/W6eQM25EonSY7kXxyg==
X-Received: by 2002:a05:6a00:1393:b0:736:9f2e:1357 with SMTP id
 d2e1a72fcca58-7490f592146mr13183724b3a.12.1750628111021; 
 Sun, 22 Jun 2025 14:35:11 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a69f3e2sm6479842b3a.159.2025.06.22.14.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Jun 2025 14:35:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH v2 1/3] target/arm: Fix SME vs AdvSIMD exception priority
Date: Sun, 22 Jun 2025 14:35:07 -0700
Message-ID: <20250622213509.277798-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250622213509.277798-1-richard.henderson@linaro.org>
References: <20250622213509.277798-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

We failed to raise an exception when
sme_excp_el == 0 and fp_excp_el == 1.

Cc: qemu-stable@nongnu.org
Fixes: 3d74825f4d6 ("target/arm: Add SME enablement checks")
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


